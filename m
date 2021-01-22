Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B644300AAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 19:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbhAVR5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:57:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbhAVRwh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:52:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D44B23AAC;
        Fri, 22 Jan 2021 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611337885;
        bh=XteU6WoIODT4ILm25/2DVaakb5xIuud8bxJnL10oc0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+yNe8hS5hwlDZXFiZ0OVvf0hKTARCyXm9CuYiJxlmmk1qSK02LwCoBfekbWBmJ0H
         Bzi9mrCuqOU//q6XUMUXnjXZN6Z8ZMRDsNbIKoWQ8aJ/5AEHo9C16uH5Netm+CmLzA
         l7dVXSoxw0OOpzM/AG0rbWWL3vJ9oBM6yuFYQHl4VVrBu2kiTqflg0yPdEB1GF5Ub5
         hJVG1XtpvTUTjiVWaw1in/cQZ9lPvlmocxxHDUwoUlNgdqlZgoMYXCnPjlwRoRc8AO
         0zgW9gUgZXk091PltjNA8jqZ3onRZfcis8ANrJEKIZ0El+uAkyonsBL1wYikhM73pr
         hcnIKJj5IdPpA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        willy@infradead.org, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/6] ceph: plug write_begin into read helper
Date:   Fri, 22 Jan 2021 12:51:17 -0500
Message-Id: <20210122175119.364381-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122175119.364381-1-jlayton@kernel.org>
References: <20210122175119.364381-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert ceph_write_begin to use the netfs_write_begin helper. Most of
the ops we need for it are already in place from the readpage conversion
but we do add a new check_write_begin op since ceph needs to be able to
vet whether there is an incompatible writeback already in flight before
reading in the page.

With this, we can also remove the old ceph_do_readpage helper.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 187 ++++++++++++++++---------------------------------
 1 file changed, 61 insertions(+), 126 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 986c9c56653f..b3b58285a997 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -321,76 +321,6 @@ static int ceph_readpage(struct file *filp, struct page *page)
 	return netfs_readpage(filp, page, &ceph_readpage_netfs_ops, NULL);
 }
 
-/* read a single page, without unlocking it. */
-static int ceph_do_readpage(struct file *filp, struct page *page)
-{
-	struct inode *inode = file_inode(filp);
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
-	struct ceph_osd_client *osdc = &fsc->client->osdc;
-	struct ceph_osd_request *req;
-	struct ceph_vino vino = ceph_vino(inode);
-	int err = 0;
-	u64 off = page_offset(page);
-	u64 len = PAGE_SIZE;
-
-	if (off >= i_size_read(inode)) {
-		zero_user_segment(page, 0, PAGE_SIZE);
-		SetPageUptodate(page);
-		return 0;
-	}
-
-	if (ci->i_inline_version != CEPH_INLINE_NONE) {
-		/*
-		 * Uptodate inline data should have been added
-		 * into page cache while getting Fcr caps.
-		 */
-		if (off == 0)
-			return -EINVAL;
-		zero_user_segment(page, 0, PAGE_SIZE);
-		SetPageUptodate(page);
-		return 0;
-	}
-
-	dout("readpage ino %llx.%llx file %p off %llu len %llu page %p index %lu\n",
-	     vino.ino, vino.snap, filp, off, len, page, page->index);
-	req = ceph_osdc_new_request(osdc, &ci->i_layout, vino, off, &len, 0, 1,
-				    CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ, NULL,
-				    ci->i_truncate_seq, ci->i_truncate_size,
-				    false);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	osd_req_op_extent_osd_data_pages(req, 0, &page, len, 0, false, false);
-
-	err = ceph_osdc_start_request(osdc, req, false);
-	if (!err)
-		err = ceph_osdc_wait_request(osdc, req);
-
-	ceph_update_read_latency(&fsc->mdsc->metric, req->r_start_latency,
-				 req->r_end_latency, err);
-
-	ceph_osdc_put_request(req);
-	dout("readpage result %d\n", err);
-
-	if (err == -ENOENT)
-		err = 0;
-	if (err < 0) {
-		if (err == -EBLOCKLISTED)
-			fsc->blocklisted = true;
-		goto out;
-	}
-	if (err < PAGE_SIZE)
-		/* zero fill remainder of page */
-		zero_user_segment(page, err, PAGE_SIZE);
-	else
-		flush_dcache_page(page);
-
-	SetPageUptodate(page);
-out:
-	return err < 0 ? err : 0;
-}
-
 /*
  * Finish an async read(ahead) op.
  */
@@ -1410,6 +1340,40 @@ ceph_find_incompatible(struct page *page)
 	return NULL;
 }
 
+static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned int len,
+					struct page *page, void **_fsdata)
+{
+	struct inode *inode = file_inode(file);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_snap_context *snapc;
+
+	snapc = ceph_find_incompatible(page);
+	if (snapc) {
+		int r;
+
+		unlock_page(page);
+		put_page(page);
+		if (IS_ERR(snapc))
+			return PTR_ERR(snapc);
+
+		ceph_queue_writeback(inode);
+		r = wait_event_killable(ci->i_cap_wq,
+					context_is_writeable_or_written(inode, snapc));
+		ceph_put_snap_context(snapc);
+		return r == 0 ? -EAGAIN : r;
+	}
+	return 0;
+}
+
+const struct netfs_read_request_ops ceph_netfs_write_begin_ops = {
+	.init_rreq		= ceph_init_rreq,
+	.is_cache_enabled	= ceph_is_cache_enabled,
+	.begin_cache_operation	= ceph_begin_cache_operation,
+	.issue_op		= ceph_netfs_issue_op,
+	.clamp_length		= ceph_netfs_clamp_length,
+	.check_write_begin	= ceph_netfs_check_write_begin,
+};
+
 /*
  * We are only allowed to write into/dirty the page if the page is
  * clean, or already dirty within the same snap context.
@@ -1420,75 +1384,46 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
 {
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_snap_context *snapc;
 	struct page *page = NULL;
 	pgoff_t index = pos >> PAGE_SHIFT;
-	int pos_in_page = pos & ~PAGE_MASK;
-	int r = 0;
-
-	dout("write_begin file %p inode %p page %p %d~%d\n", file, inode, page, (int)pos, (int)len);
-
-	for (;;) {
-		page = grab_cache_page_write_begin(mapping, index, flags);
-		if (!page) {
-			r = -ENOMEM;
-			break;
-		}
-
-		snapc = ceph_find_incompatible(page);
-		if (snapc) {
-			if (IS_ERR(snapc)) {
-				r = PTR_ERR(snapc);
-				break;
-			}
-			unlock_page(page);
-			put_page(page);
-			page = NULL;
-			ceph_queue_writeback(inode);
-			r = wait_event_killable(ci->i_cap_wq,
-						context_is_writeable_or_written(inode, snapc));
-			ceph_put_snap_context(snapc);
-			if (r != 0)
-				break;
-			continue;
-		}
-
-		if (PageUptodate(page)) {
-			dout(" page %p already uptodate\n", page);
-			break;
-		}
+	int r;
 
+	if (ci->i_inline_version != CEPH_INLINE_NONE) {
 		/*
-		 * In some cases we don't need to read at all:
-		 * - full page write
-		 * - write that lies completely beyond EOF
-		 * - write that covers the the page from start to EOF or beyond it
+		 * In principle, we should never get here, as the inode should have been uninlined
+		 * before we're allowed to write to the page (in write_iter or page_mkwrite).
 		 */
-		if ((pos_in_page == 0 && len == PAGE_SIZE) ||
-		    (pos >= i_size_read(inode)) ||
-		    (pos_in_page == 0 && (pos + len) >= i_size_read(inode))) {
-			zero_user_segments(page, 0, pos_in_page,
-					   pos_in_page + len, PAGE_SIZE);
-			break;
-		}
+		WARN_ONCE(1, "ceph: write_begin called on still-inlined inode!\n");
 
 		/*
-		 * We need to read it. If we get back -EINPROGRESS, then the page was
-		 * handed off to fscache and it will be unlocked when the read completes.
-		 * Refind the page in that case so we can reacquire the page lock. Otherwise
-		 * we got a hard error or the read was completed synchronously.
+		 * Uptodate inline data should have been added
+		 * into page cache while getting Fcr caps.
 		 */
-		r = ceph_do_readpage(file, page);
-		if (r != -EINPROGRESS)
-			break;
+		if (index == 0) {
+			r = -EINVAL;
+			goto out;
+		}
+
+		page = grab_cache_page_write_begin(mapping, index, flags);
+		if (!page)
+			return -ENOMEM;
+
+		zero_user_segment(page, 0, PAGE_SIZE);
+		SetPageUptodate(page);
+		r = 0;
+		goto out;
 	}
 
+	r = netfs_write_begin(file, inode->i_mapping, pos, len, 0, &page, NULL,
+			      &ceph_netfs_write_begin_ops, NULL);
+out:
+	if (r == 0)
+		wait_on_page_fscache(page);
 	if (r < 0) {
-		if (page) {
-			unlock_page(page);
+		if (page)
 			put_page(page);
-		}
 	} else {
+		WARN_ON_ONCE(!PageLocked(page));
 		*pagep = page;
 	}
 	return r;
-- 
2.29.2

