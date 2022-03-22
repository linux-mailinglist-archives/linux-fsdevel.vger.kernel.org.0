Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270E04E40F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiCVORd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbiCVOQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:16:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D16089CC3;
        Tue, 22 Mar 2022 07:14:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1E382CE1E18;
        Tue, 22 Mar 2022 14:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69BCC36AFA;
        Tue, 22 Mar 2022 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958446;
        bh=k6YGRIdB4dcCELFakmu2rMsXHeruz8T3YwyGiVlLrAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mjK8KTiV8IxKRktmdu1YZwYnCJdt7EL27HQsvO+etVbqJvDVtLFP4AlDjiYSR7Q8I
         LfeW0108gsMQT/2OD3Ivo+wnb/Sg1QIZN8AvN6tcBXSrwiLZq4oELoPf4BYkj0pvxX
         ZpkBSvt9e7KuFkWH3eg/do86FgaBLu36NO3CA3/HAOnW0bCuTEdKMQJR2ae6TLQzXh
         lBU6+2D15JnHjKNKR6GzQuTzXr7+tu1fQTPb297SzdiiIJwgac4sxGKpSK5AJcHIa4
         zfiInJkmv8VG91M+10pi7L2LFaTab/4QfJ/K9z2UONgN/8mvE3xskeaf7Q9OfAWb/w
         r0hBbrceQKKxg==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 50/51] ceph: add encryption support to writepage
Date:   Tue, 22 Mar 2022 10:13:15 -0400
Message-Id: <20220322141316.41325-51-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow writepage to issue encrypted writes. Extend out the requested size
and offset to cover complete blocks, and then encrypt and write them to
the OSDs.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 13a37a568a1d..403e7a960a4e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -594,10 +594,12 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	loff_t page_off = page_offset(page);
 	int err;
 	loff_t len = thp_size(page);
+	loff_t wlen;
 	struct ceph_writeback_ctl ceph_wbc;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_osd_request *req;
 	bool caching = ceph_is_cache_enabled(inode);
+	struct page *bounce_page = NULL;
 
 	dout("writepage %p idx %lu\n", page, page->index);
 
@@ -628,6 +630,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 
 	if (ceph_wbc.i_size < page_off + len)
 		len = ceph_wbc.i_size - page_off;
+	if (IS_ENCRYPTED(inode))
+		wlen = round_up(len, CEPH_FSCRYPT_BLOCK_SIZE);
 
 	dout("writepage %p page %p index %lu on %llu~%llu snapc %p seq %lld\n",
 	     inode, page, page->index, page_off, len, snapc, snapc->seq);
@@ -636,22 +640,37 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
 		set_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
 
-	req = ceph_osdc_new_request(osdc, &ci->i_layout, ceph_vino(inode), page_off, &len, 0, 1,
-				    CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE, snapc,
-				    ceph_wbc.truncate_seq, ceph_wbc.truncate_size,
-				    true);
+	req = ceph_osdc_new_request(osdc, &ci->i_layout, ceph_vino(inode),
+				    page_off, &wlen, 0, 1, CEPH_OSD_OP_WRITE,
+				    CEPH_OSD_FLAG_WRITE, snapc,
+				    ceph_wbc.truncate_seq,
+				    ceph_wbc.truncate_size, true);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
+	if (wlen < len)
+		len = wlen;
+
 	set_page_writeback(page);
 	if (caching)
 		ceph_set_page_fscache(page);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
+	if (IS_ENCRYPTED(inode)) {
+		bounce_page = fscrypt_encrypt_pagecache_blocks(page, CEPH_FSCRYPT_BLOCK_SIZE,
+								0, GFP_NOFS);
+		if (IS_ERR(bounce_page)) {
+			err = PTR_ERR(bounce_page);
+			goto out;
+		}
+	}
 	/* it may be a short write due to an object boundary */
 	WARN_ON_ONCE(len > thp_size(page));
-	osd_req_op_extent_osd_data_pages(req, 0, &page, len, 0, false, false);
-	dout("writepage %llu~%llu (%llu bytes)\n", page_off, len, len);
+	osd_req_op_extent_osd_data_pages(req, 0,
+			bounce_page ? &bounce_page : &page, wlen, 0,
+			false, false);
+	dout("writepage %llu~%llu (%llu bytes, %sencrypted)\n",
+	     page_off, len, wlen, IS_ENCRYPTED(inode) ? "" : "not ");
 
 	req->r_mtime = inode->i_mtime;
 	err = ceph_osdc_start_request(osdc, req, true);
@@ -660,7 +679,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 
 	ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
 				  req->r_end_latency, len, err);
-
+	fscrypt_free_bounce_page(bounce_page);
+out:
 	ceph_osdc_put_request(req);
 	if (err == 0)
 		err = len;
-- 
2.35.1

