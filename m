Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C8F48B6D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350576AbiAKTRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60938 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350635AbiAKTQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89B93B81D21;
        Tue, 11 Jan 2022 19:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A51C36AE9;
        Tue, 11 Jan 2022 19:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928604;
        bh=rcBiPIKaYqUSZ+A9+95aGX79vYaQ/FdlL2WoyKxfZtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QlpzSbCAZEyRr9pj4m2VeNXyaTIkbn2exmyjFOmT6nS3n9tGTBov8IFUG8dgICdhv
         mwsF6tjZ/9vgg4NAAIlmROIsjLhog1DG1725i4fzY/z70lFxyD1uIIk0/w7CvOuQ9R
         PELxkdtqjBCoUMTGl9xT7GpL9qxDrZlccKjcOxrVckvdSuOb+3myySo1sPyLq2RBUU
         WXiHV9gwMGMSMfw2S59quzcJ0l6fav+c5uzby0Fq9oklzmtA9+w9kVF7wRb823N0a6
         ERa9Dx8bvsF9nzklhNcaMWq4khmx8X/0qeMhqjHk23+5q6lKR1HnU/2aQEjsyo62D6
         KAlpO4pgVuJ+w==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 47/48] ceph: add encryption support to writepage
Date:   Tue, 11 Jan 2022 14:16:07 -0500
Message-Id: <20220111191608.88762-48-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index dbc587a41fea..46ff50a2474e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -545,10 +545,12 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
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
 
@@ -579,6 +581,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 
 	if (ceph_wbc.i_size < page_off + len)
 		len = ceph_wbc.i_size - page_off;
+	if (IS_ENCRYPTED(inode))
+		wlen = round_up(len, CEPH_FSCRYPT_BLOCK_SIZE);
 
 	dout("writepage %p page %p index %lu on %llu~%llu snapc %p seq %lld\n",
 	     inode, page, page->index, page_off, len, snapc, snapc->seq);
@@ -587,22 +591,37 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
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
@@ -611,7 +630,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 
 	ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
 				  req->r_end_latency, len, err);
-
+	fscrypt_free_bounce_page(bounce_page);
+out:
 	ceph_osdc_put_request(req);
 	if (err == 0)
 		err = len;
-- 
2.34.1

