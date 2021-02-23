Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD9E322B34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 14:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhBWNIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 08:08:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232538AbhBWNIN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:08:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2110564E61;
        Tue, 23 Feb 2021 13:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614085596;
        bh=ayD+gCxrJ+kRprtT90J7vGbBwzieK99AyONUaHaEtUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6HixtyuIK25+Q4G0DQUO0SJt5ZQVgRaqEDLzFELEsshTHZr9nCIl2+p5abSjh3qF
         EMHjjGoEiiUPT3+An5UYitLH0hOf9BBTRYy3EHgh725Ss2x3E1BhcNdCNF9Vw6c1HT
         /QpnxRiRo80WKWqx5nDNwf/3ZtynfyzRhTZpgUJt742B5Oj6JTlhXjamsdN9y0Zy6D
         rb0I1vAdh1VrynxEGuwF8zw4mSougWw4UmIkSEhHTC1Qs0aeJlQzRN5GJocy9iJNZ/
         pvLaRFPMC9J8i32nXo8RXUQQUzbjAyqpGvHI/2toHScwuA+50zd2cbsB0AMNiX0n37
         fFide14wR6j0A==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, xiubli@redhat.com, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH v3 5/6] ceph: plug write_begin into read helper
Date:   Tue, 23 Feb 2021 08:06:28 -0500
Message-Id: <20210223130629.249546-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210223130629.249546-1-jlayton@kernel.org>
References: <20210223130629.249546-1-jlayton@kernel.org>
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
Cc: ceph-devel@vger.kernel.org
Cc: linux-cachefs@redhat.com
Cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/addr.c | 186 +++++++++++++++----------------------------------
 1 file changed, 57 insertions(+), 129 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index fbfdf1296174..84b6b43c399d 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -62,6 +62,9 @@
 	(CONGESTION_ON_THRESH(congestion_kb) -				\
 	 (CONGESTION_ON_THRESH(congestion_kb) >> 2))
 
+static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned int len,
+					struct page *page, void **_fsdata);
+
 static inline struct ceph_snap_context *page_snap_context(struct page *page)
 {
 	if (PagePrivate(page))
@@ -308,6 +311,7 @@ const struct netfs_read_request_ops ceph_netfs_read_ops = {
 	.issue_op		= ceph_netfs_issue_op,
 	.expand_readahead	= ceph_netfs_expand_readahead,
 	.clamp_length		= ceph_netfs_clamp_length,
+	.check_write_begin	= ceph_netfs_check_write_begin,
 };
 
 /* read a single page, without unlocking it. */
@@ -340,76 +344,6 @@ static int ceph_readpage(struct file *file, struct page *page)
 	return netfs_readpage(file, page, &ceph_netfs_read_ops, NULL);
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
@@ -1429,6 +1363,31 @@ ceph_find_incompatible(struct page *page)
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
 /*
  * We are only allowed to write into/dirty the page if the page is
  * clean, or already dirty within the same snap context.
@@ -1439,75 +1398,47 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
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
+	int r;
 
-	for (;;) {
+	/*
+	 * Uninlining should have already been done and everything updated, EXCEPT
+	 * for inline_version sent to the MDS.
+	 */
+	if (ci->i_inline_version != CEPH_INLINE_NONE) {
 		page = grab_cache_page_write_begin(mapping, index, flags);
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
+		if (!page)
+			return -ENOMEM;
 
 		/*
-		 * In some cases we don't need to read at all:
-		 * - full page write
-		 * - write that lies completely beyond EOF
-		 * - write that covers the the page from start to EOF or beyond it
+		 * The inline_version on a new inode is set to 1. If that's the
+		 * case, then the page is brand new and isn't yet Uptodate.
 		 */
-		if ((pos_in_page == 0 && len == PAGE_SIZE) ||
-		    (pos >= i_size_read(inode)) ||
-		    (pos_in_page == 0 && (pos + len) >= i_size_read(inode))) {
-			zero_user_segments(page, 0, pos_in_page,
-					   pos_in_page + len, PAGE_SIZE);
-			break;
+		r = 0;
+		if (index == 0 && ci->i_inline_version != 1) {
+			if (!PageUptodate(page)) {
+				WARN_ONCE(1, "ceph: write_begin called on still-inlined inode (inline_version %llu)!\n",
+					  ci->i_inline_version);
+				r = -EINVAL;
+			}
+			goto out;
 		}
-
-		/*
-		 * We need to read it. If we get back -EINPROGRESS, then the page was
-		 * handed off to fscache and it will be unlocked when the read completes.
-		 * Refind the page in that case so we can reacquire the page lock. Otherwise
-		 * we got a hard error or the read was completed synchronously.
-		 */
-		r = ceph_do_readpage(file, page);
-		if (r != -EINPROGRESS)
-			break;
+		zero_user_segment(page, 0, PAGE_SIZE);
+		SetPageUptodate(page);
+		goto out;
 	}
 
+	r = netfs_write_begin(file, inode->i_mapping, pos, len, 0, &page, NULL,
+			      &ceph_netfs_read_ops, NULL);
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
@@ -1680,9 +1611,6 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-/*
- * Reuse write_begin here for simplicity.
- */
 static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-- 
2.29.2

