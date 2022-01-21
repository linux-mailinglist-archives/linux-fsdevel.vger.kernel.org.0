Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC41F496099
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 15:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381028AbiAUOSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 09:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381020AbiAUOSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:18:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD2AC061574;
        Fri, 21 Jan 2022 06:18:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B7AC6168F;
        Fri, 21 Jan 2022 14:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4C1C340E1;
        Fri, 21 Jan 2022 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642774722;
        bh=OABX/K/IhQGzhhAW4+Hk0r1lwBybzcoVxIjt/TV2A1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NtK4jEZcjZXrxPKYPqM9FNdW9biHs7MQsuUkOoCGTig6qpIiulARRTsc0XH58j1WB
         J5S8K4oMd2VAF2UANwNdeUKwmm/Ada3j1iRBBAPhmCkjJ64L/RE/tu3PqaXb2rUE80
         vGG4vYfhtsKGlIN5abvQPLNblryY84lzo76CFwutIUeTUAHe9Pzztl4i1aIQtrGVYJ
         IoeBK0snT/QbpEOHmj5f+CwNqL4xB1jPn4OcoI+i0DW+UWln9Vq+b+aGl/2c59v/fd
         tBfLqf0uDvxsDtjD2XMGv4mr/YZJve7TAa6x610aWBjbrScDh+nV7dUb3vWjEtjBXf
         fVxmCQkH8YXbQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/3] ceph: Uninline the data on a file opened for writing
Date:   Fri, 21 Jan 2022 09:18:38 -0500
Message-Id: <20220121141838.110954-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121141838.110954-1-jlayton@kernel.org>
References: <20220121141838.110954-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

If a ceph file is made up of inline data, uninline that in the ceph_open()
rather than in ceph_page_mkwrite(), ceph_write_iter(), ceph_fallocate() or
ceph_write_begin().

This makes it easier to convert to using the netfs library for VM write
hooks.

Should this also take the inode lock for the duration on uninlining to
prevent a race with truncation?

[ jlayton: fix up folio locking, update i_inline_version after write ]

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c  | 154 +++++++++++++++---------------------------------
 fs/ceph/file.c  |  32 +++++-----
 fs/ceph/super.h |   2 +-
 3 files changed, 64 insertions(+), 124 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 01d97ab56f71..4b6b28c32483 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1266,45 +1266,11 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
 			    struct page **pagep, void **fsdata)
 {
 	struct inode *inode = file_inode(file);
-	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct folio *folio = NULL;
-	pgoff_t index = pos >> PAGE_SHIFT;
 	int r;
 
-	/*
-	 * Uninlining should have already been done and everything updated, EXCEPT
-	 * for inline_version sent to the MDS.
-	 */
-	if (ci->i_inline_version != CEPH_INLINE_NONE) {
-		unsigned int fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE;
-		if (aop_flags & AOP_FLAG_NOFS)
-			fgp_flags |= FGP_NOFS;
-		folio = __filemap_get_folio(mapping, index, fgp_flags,
-					    mapping_gfp_mask(mapping));
-		if (!folio)
-			return -ENOMEM;
-
-		/*
-		 * The inline_version on a new inode is set to 1. If that's the
-		 * case, then the folio is brand new and isn't yet Uptodate.
-		 */
-		r = 0;
-		if (index == 0 && ci->i_inline_version != 1) {
-			if (!folio_test_uptodate(folio)) {
-				WARN_ONCE(1, "ceph: write_begin called on still-inlined inode (inline_version %llu)!\n",
-					  ci->i_inline_version);
-				r = -EINVAL;
-			}
-			goto out;
-		}
-		zero_user_segment(&folio->page, 0, folio_size(folio));
-		folio_mark_uptodate(folio);
-		goto out;
-	}
-
 	r = netfs_write_begin(file, inode->i_mapping, pos, len, 0, &folio, NULL,
 			      &ceph_netfs_read_ops, NULL);
-out:
 	if (r == 0)
 		folio_wait_fscache(folio);
 	if (r < 0) {
@@ -1500,19 +1466,6 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	ceph_block_sigs(&oldset);
 
-	if (ci->i_inline_version != CEPH_INLINE_NONE) {
-		struct page *locked_page = NULL;
-		if (off == 0) {
-			lock_page(page);
-			locked_page = page;
-		}
-		err = ceph_uninline_data(vma->vm_file, locked_page);
-		if (locked_page)
-			unlock_page(locked_page);
-		if (err < 0)
-			goto out_free;
-	}
-
 	if (off + thp_size(page) <= size)
 		len = thp_size(page);
 	else
@@ -1569,11 +1522,9 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 		ceph_put_snap_context(snapc);
 	} while (err == 0);
 
-	if (ret == VM_FAULT_LOCKED ||
-	    ci->i_inline_version != CEPH_INLINE_NONE) {
+	if (ret == VM_FAULT_LOCKED) {
 		int dirty;
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
 					       &prealloc_cf);
 		spin_unlock(&ci->i_ceph_lock);
@@ -1637,16 +1588,29 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 	}
 }
 
-int ceph_uninline_data(struct file *filp, struct page *locked_page)
+int ceph_uninline_data(struct file *file)
 {
-	struct inode *inode = file_inode(filp);
+	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	struct ceph_osd_request *req;
-	struct page *page = NULL;
+	struct ceph_cap_flush *prealloc_cf;
+	struct folio *folio = NULL;
+	struct page *pages[1];
 	u64 len, inline_version;
 	int err = 0;
-	bool from_pagecache = false;
+
+	prealloc_cf = ceph_alloc_cap_flush();
+	if (!prealloc_cf)
+		return -ENOMEM;
+
+	folio = read_mapping_folio(inode->i_mapping, 0, file);
+	if (IS_ERR(folio)) {
+		err = PTR_ERR(folio);
+		goto out;
+	}
+
+	folio_lock(folio);
 
 	spin_lock(&ci->i_ceph_lock);
 	inline_version = ci->i_inline_version;
@@ -1657,45 +1621,11 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 
 	if (inline_version == 1 || /* initial version, no data */
 	    inline_version == CEPH_INLINE_NONE)
-		goto out;
-
-	if (locked_page) {
-		page = locked_page;
-		WARN_ON(!PageUptodate(page));
-	} else if (ceph_caps_issued(ci) &
-		   (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) {
-		page = find_get_page(inode->i_mapping, 0);
-		if (page) {
-			if (PageUptodate(page)) {
-				from_pagecache = true;
-				lock_page(page);
-			} else {
-				put_page(page);
-				page = NULL;
-			}
-		}
-	}
+		goto out_unlock;
 
-	if (page) {
-		len = i_size_read(inode);
-		if (len > PAGE_SIZE)
-			len = PAGE_SIZE;
-	} else {
-		page = __page_cache_alloc(GFP_NOFS);
-		if (!page) {
-			err = -ENOMEM;
-			goto out;
-		}
-		err = __ceph_do_getattr(inode, page,
-					CEPH_STAT_CAP_INLINE_DATA, true);
-		if (err < 0) {
-			/* no inline data */
-			if (err == -ENODATA)
-				err = 0;
-			goto out;
-		}
-		len = err;
-	}
+	len = i_size_read(inode);
+	if (len > folio_size(folio))
+		len = folio_size(folio);
 
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 				    ceph_vino(inode), 0, &len, 0, 1,
@@ -1703,7 +1633,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 				    NULL, 0, 0, false);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
-		goto out;
+		goto out_unlock;
 	}
 
 	req->r_mtime = inode->i_mtime;
@@ -1712,7 +1642,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 		err = ceph_osdc_wait_request(&fsc->client->osdc, req);
 	ceph_osdc_put_request(req);
 	if (err < 0)
-		goto out;
+		goto out_unlock;
 
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 				    ceph_vino(inode), 0, &len, 1, 3,
@@ -1721,10 +1651,11 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 				    ci->i_truncate_size, false);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
-		goto out;
+		goto out_unlock;
 	}
 
-	osd_req_op_extent_osd_data_pages(req, 1, &page, len, 0, false, false);
+	pages[0] = folio_page(folio, 0);
+	osd_req_op_extent_osd_data_pages(req, 1, pages, len, 0, false, false);
 
 	{
 		__le64 xattr_buf = cpu_to_le64(inline_version);
@@ -1734,7 +1665,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 					    CEPH_OSD_CMPXATTR_OP_GT,
 					    CEPH_OSD_CMPXATTR_MODE_U64);
 		if (err)
-			goto out_put;
+			goto out_put_req;
 	}
 
 	{
@@ -1745,7 +1676,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 					    "inline_version",
 					    xattr_buf, xattr_len, 0, 0);
 		if (err)
-			goto out_put;
+			goto out_put_req;
 	}
 
 	req->r_mtime = inode->i_mtime;
@@ -1756,19 +1687,28 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 	ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
 				  req->r_end_latency, len, err);
 
-out_put:
+	if (!err) {
+		int dirty;
+
+		/* Set to CAP_INLINE_NONE and dirty the caps */
+		down_read(&fsc->mdsc->snap_rwsem);
+		spin_lock(&ci->i_ceph_lock);
+		ci->i_inline_version = CEPH_INLINE_NONE;
+		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR, &prealloc_cf);
+		spin_unlock(&ci->i_ceph_lock);
+		up_read(&fsc->mdsc->snap_rwsem);
+		if (dirty)
+			__mark_inode_dirty(inode, dirty);
+	}
+out_put_req:
 	ceph_osdc_put_request(req);
 	if (err == -ECANCELED)
 		err = 0;
+out_unlock:
+	folio_unlock(folio);
+	folio_put(folio);
 out:
-	if (page && page != locked_page) {
-		if (from_pagecache) {
-			unlock_page(page);
-			put_page(page);
-		} else
-			__free_pages(page, 0);
-	}
-
+	ceph_free_cap_flush(prealloc_cf);
 	dout("uninline_data %p %llx.%llx inline_version %llu = %d\n",
 	     inode, ceph_vinop(inode), inline_version, err);
 	return err;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 7de5db51c3d0..c507c0349c32 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -207,6 +207,7 @@ static int ceph_init_file_info(struct inode *inode, struct file *file,
 	struct ceph_mount_options *opt =
 		ceph_inode_to_client(&ci->vfs_inode)->mount_options;
 	struct ceph_file_info *fi;
+	int ret;
 
 	dout("%s %p %p 0%o (%s)\n", __func__, inode, file,
 			inode->i_mode, isdir ? "dir" : "regular");
@@ -240,7 +241,22 @@ static int ceph_init_file_info(struct inode *inode, struct file *file,
 	INIT_LIST_HEAD(&fi->rw_contexts);
 	fi->filp_gen = READ_ONCE(ceph_inode_to_client(inode)->filp_gen);
 
+	if ((file->f_mode & FMODE_WRITE) &&
+	    ci->i_inline_version != CEPH_INLINE_NONE) {
+		ret = ceph_uninline_data(file);
+		if (ret < 0)
+			goto error;
+	}
+
 	return 0;
+
+error:
+	ceph_fscache_unuse_cookie(inode, file->f_mode & FMODE_WRITE);
+	ceph_put_fmode(ci, fi->fmode, 1);
+	kmem_cache_free(ceph_file_cachep, fi);
+	/* wake up anyone waiting for caps on this inode */
+	wake_up_all(&ci->i_cap_wq);
+	return ret;
 }
 
 /*
@@ -1032,7 +1048,6 @@ static void ceph_aio_complete(struct inode *inode,
 		}
 
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
 					       &aio_req->prealloc_cf);
 		spin_unlock(&ci->i_ceph_lock);
@@ -1764,12 +1779,6 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (err)
 		goto out;
 
-	if (ci->i_inline_version != CEPH_INLINE_NONE) {
-		err = ceph_uninline_data(file, NULL);
-		if (err < 0)
-			goto out;
-	}
-
 	dout("aio_write %p %llx.%llx %llu~%zd getting caps. i_size %llu\n",
 	     inode, ceph_vinop(inode), pos, count, i_size_read(inode));
 	if (!(fi->flags & CEPH_F_SYNC) && !direct_lock)
@@ -1841,7 +1850,6 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		int dirty;
 
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
 					       &prealloc_cf);
 		spin_unlock(&ci->i_ceph_lock);
@@ -2095,12 +2103,6 @@ static long ceph_fallocate(struct file *file, int mode,
 		goto unlock;
 	}
 
-	if (ci->i_inline_version != CEPH_INLINE_NONE) {
-		ret = ceph_uninline_data(file, NULL);
-		if (ret < 0)
-			goto unlock;
-	}
-
 	size = i_size_read(inode);
 
 	/* Are we punching a hole beyond EOF? */
@@ -2124,7 +2126,6 @@ static long ceph_fallocate(struct file *file, int mode,
 
 	if (!ret) {
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
 					       &prealloc_cf);
 		spin_unlock(&ci->i_ceph_lock);
@@ -2516,7 +2517,6 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	}
 	/* Mark Fw dirty */
 	spin_lock(&dst_ci->i_ceph_lock);
-	dst_ci->i_inline_version = CEPH_INLINE_NONE;
 	dirty = __ceph_mark_dirty_caps(dst_ci, CEPH_CAP_FILE_WR, &prealloc_cf);
 	spin_unlock(&dst_ci->i_ceph_lock);
 	if (dirty)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 126d560a5e20..481997b9b17b 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1216,7 +1216,7 @@ extern void __ceph_touch_fmode(struct ceph_inode_info *ci,
 /* addr.c */
 extern const struct address_space_operations ceph_aops;
 extern int ceph_mmap(struct file *file, struct vm_area_struct *vma);
-extern int ceph_uninline_data(struct file *filp, struct page *locked_page);
+extern int ceph_uninline_data(struct file *file);
 extern int ceph_pool_perm_check(struct inode *inode, int need);
 extern void ceph_pool_perm_destroy(struct ceph_mds_client* mdsc);
 int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invalidate);
-- 
2.34.1

