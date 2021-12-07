Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482AF46BCD2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 14:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbhLGNs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 08:48:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38682 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbhLGNs1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:48:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 008CCB817AC;
        Tue,  7 Dec 2021 13:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E89C341C1;
        Tue,  7 Dec 2021 13:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638884694;
        bh=VX1ojaJS4PPmnxeCb6+y/7/79PA+Ijg7cL814ZnlG54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqC2x/PHKhEyYPRc5FSMScrmaafQ4UByne/FQ0ggVDqhVnC2FTgQRvIJHl83886s0
         3lWAgaSfi5TuH7Ci7dJuOzMe1y9TyUEgqu/mivLIKq95fQO+16ecSzJPYJYWmxM2pm
         LqQNCsrJ7x83x9Ju7jkMox5Uee+9G/7nArOfkinL9ycUI1jnM1sfw9f62al7FdJ8ck
         PqlPOGN1aFhEdhMCyyjAfw4etskvCD3X84k5zrhc0beDGaR6nBq5WZo61S+pXOCMwn
         BhqTwxvu0a/cE2OUuB0IWswBEdiVXy1vOIEuX5eJwE2OT5WTNyuM5qYeUzXPxOwVzl
         Vc+me0L39vYVg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-cachefs@redhat.com
Cc:     idryomov@gmail.com, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ceph: add fscache writeback support
Date:   Tue,  7 Dec 2021 08:44:51 -0500
Message-Id: <20211207134451.66296-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211207134451.66296-1-jlayton@kernel.org>
References: <20211207134451.66296-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When updating the backing store from the pagecache (a'la writepage or
writepages), write to the cache first. This allows us to keep caching
files even when they are being written, as long as we have appropriate
caps.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 67 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 0ffc4c8d7c10..e836f8f1d4f8 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -5,7 +5,6 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
-#include <linux/writeback.h>	/* generic_writepages */
 #include <linux/slab.h>
 #include <linux/pagevec.h>
 #include <linux/task_io_accounting_ops.h>
@@ -384,6 +383,38 @@ static void ceph_readahead(struct readahead_control *ractl)
 	netfs_readahead(ractl, &ceph_netfs_read_ops, (void *)(uintptr_t)got);
 }
 
+#ifdef CONFIG_CEPH_FSCACHE
+static void ceph_set_page_fscache(struct page *page)
+{
+	set_page_fscache(page);
+}
+
+static void ceph_fscache_write_terminated(void *priv, ssize_t error, bool was_async)
+{
+	struct inode *inode = priv;
+
+	if (IS_ERR_VALUE(error) && error != -ENOBUFS)
+		ceph_fscache_invalidate(inode, false);
+}
+
+static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, bool caching)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct fscache_cookie *cookie = ceph_fscache_cookie(ci);
+
+	fscache_write_to_cache(cookie, inode->i_mapping, off, len, i_size_read(inode),
+			       ceph_fscache_write_terminated, inode, caching);
+}
+#else
+static inline void ceph_set_page_fscache(struct page *page)
+{
+}
+
+static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, bool caching)
+{
+}
+#endif /* CONFIG_CEPH_FSCACHE */
+
 struct ceph_writeback_ctl
 {
 	loff_t i_size;
@@ -499,6 +530,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	struct ceph_writeback_ctl ceph_wbc;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_osd_request *req;
+	bool caching = ceph_is_cache_enabled(inode);
 
 	dout("writepage %p idx %lu\n", page, page->index);
 
@@ -537,16 +569,17 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
 		set_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
 
-	set_page_writeback(page);
 	req = ceph_osdc_new_request(osdc, &ci->i_layout, ceph_vino(inode), page_off, &len, 0, 1,
 				    CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE, snapc,
 				    ceph_wbc.truncate_seq, ceph_wbc.truncate_size,
 				    true);
-	if (IS_ERR(req)) {
-		redirty_page_for_writepage(wbc, page);
-		end_page_writeback(page);
+	if (IS_ERR(req))
 		return PTR_ERR(req);
-	}
+
+	set_page_writeback(page);
+	if (caching)
+		ceph_set_page_fscache(page);
+	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	/* it may be a short write due to an object boundary */
 	WARN_ON_ONCE(len > thp_size(page));
@@ -605,6 +638,9 @@ static int ceph_writepage(struct page *page, struct writeback_control *wbc)
 	struct inode *inode = page->mapping->host;
 	BUG_ON(!inode);
 	ihold(inode);
+
+	wait_on_page_fscache(page);
+
 	err = writepage_nounlock(page, wbc);
 	if (err == -ERESTARTSYS) {
 		/* direct memory reclaimer was killed by SIGKILL. return 0
@@ -726,6 +762,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 	struct ceph_writeback_ctl ceph_wbc;
 	bool should_loop, range_whole = false;
 	bool done = false;
+	bool caching = ceph_is_cache_enabled(inode);
 
 	dout("writepages_start %p (mode=%s)\n", inode,
 	     wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
@@ -849,7 +886,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				unlock_page(page);
 				break;
 			}
-			if (PageWriteback(page)) {
+			if (PageWriteback(page) || PageFsCache(page)) {
 				if (wbc->sync_mode == WB_SYNC_NONE) {
 					dout("%p under writeback\n", page);
 					unlock_page(page);
@@ -857,6 +894,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				}
 				dout("waiting on writeback %p\n", page);
 				wait_on_page_writeback(page);
+				wait_on_page_fscache(page);
 			}
 
 			if (!clear_page_dirty_for_io(page)) {
@@ -989,9 +1027,19 @@ static int ceph_writepages_start(struct address_space *mapping,
 		op_idx = 0;
 		for (i = 0; i < locked_pages; i++) {
 			u64 cur_offset = page_offset(pages[i]);
+			/*
+			 * Discontinuity in page range? Ceph can handle that by just passing
+			 * multiple extents in the write op.
+			 */
 			if (offset + len != cur_offset) {
+				/* If it's full, stop here */
 				if (op_idx + 1 == req->r_num_ops)
 					break;
+
+				/* Kick off an fscache write with what we have so far. */
+				ceph_fscache_write_to_cache(inode, offset, len, caching);
+
+				/* Start a new extent */
 				osd_req_op_extent_dup_last(req, op_idx,
 							   cur_offset - offset);
 				dout("writepages got pages at %llu~%llu\n",
@@ -1002,14 +1050,17 @@ static int ceph_writepages_start(struct address_space *mapping,
 				osd_req_op_extent_update(req, op_idx, len);
 
 				len = 0;
-				offset = cur_offset; 
+				offset = cur_offset;
 				data_pages = pages + i;
 				op_idx++;
 			}
 
 			set_page_writeback(pages[i]);
+			if (caching)
+				ceph_set_page_fscache(pages[i]);
 			len += thp_size(page);
 		}
+		ceph_fscache_write_to_cache(inode, offset, len, caching);
 
 		if (ceph_wbc.size_stable) {
 			len = min(len, ceph_wbc.i_size - offset);
-- 
2.33.1

