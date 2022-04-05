Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5568F4F4D7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581725AbiDEXkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573601AbiDETXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:23:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704B4515BC;
        Tue,  5 Apr 2022 12:21:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2046BB81FA5;
        Tue,  5 Apr 2022 19:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B237C385A1;
        Tue,  5 Apr 2022 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186480;
        bh=aBwSCl+nnd5kUW2zQQtaeshWmlSvmWxl99UF09aY6AQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQB7CfxjNrExI1aJTNY6nAaIMDhbZN1vzkObuQ+dIoqtT1qCNZEnZfSj5ZEdz9DC1
         zu2WuAhBT1TK+p+0MhGSIDnhIh/hiVRcbH/nuQZuMli8zJ1RZUoXBgK+G9v0uol0IR
         xeFjXw9fKar9XABvQvUJT+dXKYh+XVFFEN7NHgKr9lu7tDvwTibMvq3AM+M0bwkKiL
         k75o5H3n3SUxDz4yKncozFnh8S0O9L9gvm/NMSdaJ8A6NuAZQuvuYAPXP5z/xr07gm
         80bkN+tZUO74+oHRnUJ02bMDhXRX8tzyY2P3JTpBBdFMH3UpmW++cjDBPll8Rr+Pbd
         kmr7qW1P+vZ1A==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 53/59] ceph: align data in pages in ceph_sync_write
Date:   Tue,  5 Apr 2022 15:20:24 -0400
Message-Id: <20220405192030.178326-54-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Encrypted files will need to be dealt with in block-sized chunks and
once we do that, the way that ceph_sync_write aligns the data in the
bounce buffer won't be acceptable.

Change it to align the data the same way it would be aligned in the
pagecache.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 41b97d32dfcf..69ac67c93552 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1551,6 +1551,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	bool check_caps = false;
 	struct timespec64 mtime = current_time(inode);
 	size_t count = iov_iter_count(from);
+	size_t off;
 
 	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
 		return -EROFS;
@@ -1588,12 +1589,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			break;
 		}
 
-		/*
-		 * write from beginning of first page,
-		 * regardless of io alignment
-		 */
-		num_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
+		num_pages = calc_pages_for(pos, len);
 		pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
 		if (IS_ERR(pages)) {
 			ret = PTR_ERR(pages);
@@ -1601,9 +1597,12 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		}
 
 		left = len;
+		off = offset_in_page(pos);
 		for (n = 0; n < num_pages; n++) {
-			size_t plen = min_t(size_t, left, PAGE_SIZE);
-			ret = copy_page_from_iter(pages[n], 0, plen, from);
+			size_t plen = min_t(size_t, left, PAGE_SIZE - off);
+
+			ret = copy_page_from_iter(pages[n], off, plen, from);
+			off = 0;
 			if (ret != plen) {
 				ret = -EFAULT;
 				break;
@@ -1618,8 +1617,9 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 
 		req->r_inode = inode;
 
-		osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0,
-						false, true);
+		osd_req_op_extent_osd_data_pages(req, 0, pages, len,
+						 offset_in_page(pos),
+						 false, true);
 
 		req->r_mtime = mtime;
 		ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
-- 
2.35.1

