Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6243843977F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 15:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhJYN1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 09:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232229AbhJYN1S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:27:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67C0160FBF;
        Mon, 25 Oct 2021 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635168295;
        bh=reeYv9j8xgCwFBY/XgKvzySo5aLr3ci+jAQrDTHNNss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gysE1EqPYgTUub79Iq1JzfG3sLWsWmzN4OX4sWidgWKaHq8bRyg9RnqeimMh92+eG
         lnfrm2aZtxPLa/BQ9CZ6QHaUTOChATlq1NtVjTLrafk/tD8PU3mQvGDfuQZ3zeGVF9
         1e0g4bOmdOvkLclWpCHt8gbt4rDw6akc6GzerAGqwnx8rxWTy22CXvTk52kRfVxCFc
         CEaJk9mQXV+MY4sllnEyLzlscLuya6I06ViKe7zQI8m6CSlK8rSD1bhIiVPUhVczBu
         0Y5JkVZyfiqj+Ut6/EUD6p0sFzFp4oBIUl0w+Cnm9NBxzE8kLX7B12FRuL7+ZOdjvU
         I+Q65aqnhROvw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ceph: add fscache writeback support
Date:   Mon, 25 Oct 2021 09:24:52 -0400
Message-Id: <20211025132452.101591-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025132452.101591-1-jlayton@kernel.org>
References: <20211025132452.101591-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When updating the backing store from the pagecache (a'la writepage or
writepages), write to the cache first. This allows us to keep caching
files even when they are open for write.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 66 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 09ba8a53c035..c78749ff1587 100644
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
@@ -383,6 +382,43 @@ static void ceph_readahead(struct readahead_control *ractl)
 	netfs_readahead(ractl, &ceph_netfs_read_ops, (void *)(uintptr_t)got);
 }
 
+#ifdef CONFIG_CEPH_FSCACHE
+static void ceph_set_page_fscache(struct page *page)
+{
+	struct ceph_inode_info *ci = ceph_inode(page->mapping->host);
+	struct fscache_cookie *cookie = ceph_fscache_cookie(ci);
+
+	if  (fscache_cookie_enabled(cookie) &&
+	     test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags))
+		set_page_fscache(page);
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
+static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct fscache_cookie *cookie = ceph_fscache_cookie(ci);
+
+	fscache_write_to_cache(cookie, inode->i_mapping, off, len, i_size_read(inode),
+			       ceph_fscache_write_terminated, inode);
+}
+#else
+static void ceph_set_page_fscache(struct page *page)
+{
+}
+
+static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len)
+{
+}
+#endif /* CONFIG_CEPH_FSCACHE */
+
 struct ceph_writeback_ctl
 {
 	loff_t i_size;
@@ -491,6 +527,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	struct inode *inode = page->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct fscache_cookie *cookie = ceph_fscache_cookie(ci);
 	struct ceph_snap_context *snapc, *oldest;
 	loff_t page_off = page_offset(page);
 	int err;
@@ -536,16 +573,15 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
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
+	ceph_set_page_fscache(page);
 
 	/* it may be a short write due to an object boundary */
 	WARN_ON_ONCE(len > thp_size(page));
@@ -604,6 +640,9 @@ static int ceph_writepage(struct page *page, struct writeback_control *wbc)
 	struct inode *inode = page->mapping->host;
 	BUG_ON(!inode);
 	ihold(inode);
+
+	wait_on_page_fscache(page);
+
 	err = writepage_nounlock(page, wbc);
 	if (err == -ERESTARTSYS) {
 		/* direct memory reclaimer was killed by SIGKILL. return 0
@@ -848,7 +887,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				unlock_page(page);
 				break;
 			}
-			if (PageWriteback(page)) {
+			if (PageWriteback(page) || PageFsCache(page)) {
 				if (wbc->sync_mode == WB_SYNC_NONE) {
 					dout("%p under writeback\n", page);
 					unlock_page(page);
@@ -856,6 +895,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 				}
 				dout("waiting on writeback %p\n", page);
 				wait_on_page_writeback(page);
+				wait_on_page_fscache(page);
 			}
 
 			if (!clear_page_dirty_for_io(page)) {
@@ -988,9 +1028,19 @@ static int ceph_writepages_start(struct address_space *mapping,
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
+				ceph_fscache_write_to_cache(inode, offset, len);
+
+				/* Start a new extent */
 				osd_req_op_extent_dup_last(req, op_idx,
 							   cur_offset - offset);
 				dout("writepages got pages at %llu~%llu\n",
@@ -1007,8 +1057,10 @@ static int ceph_writepages_start(struct address_space *mapping,
 			}
 
 			set_page_writeback(pages[i]);
+			ceph_set_page_fscache(pages[i]);
 			len += thp_size(page);
 		}
+		ceph_fscache_write_to_cache(inode, offset, len);
 
 		if (ceph_wbc.size_stable) {
 			len = min(len, ceph_wbc.i_size - offset);
-- 
2.31.1

