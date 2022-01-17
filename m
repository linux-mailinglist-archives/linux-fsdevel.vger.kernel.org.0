Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2946490C78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 17:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbiAQQ0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 11:26:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237567AbiAQQ0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642436805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=euRX7iWL4G1W/pkmPtvR/4IE/b91fipk9WTzv4FWT7Q=;
        b=itAyCIkCUdrWm9s9ib849/EJRUmZ3wJQIMz2ce8cp+ZUIA17GiHmcCxWzri5MfnTznNMFc
        mcFSSppgNPcfgTaJw3GxT1A9c46nW21QF1hGd2r+prTx3sRBUx3KJwhWjwQXZQZqrNi69m
        dgJ0eEJ81x+9HlBdUP3xJet8tIQII3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-LMg39DBEPnK7aJwRYZ8EsQ-1; Mon, 17 Jan 2022 11:26:42 -0500
X-MC-Unique: LMg39DBEPnK7aJwRYZ8EsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 381871083F64;
        Mon, 17 Jan 2022 16:26:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AE2A2C2C3;
        Mon, 17 Jan 2022 16:26:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/3] ceph: Uninline the data on a file opened for writing
From:   David Howells <dhowells@redhat.com>
To:     ceph-devel@vger.kernel.org
Cc:     dhowells@redhat.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 17 Jan 2022 16:26:36 +0000
Message-ID: <164243679615.2863669.15715941907688580296.stgit@warthog.procyon.org.uk>
In-Reply-To: <164243678893.2863669.12713835397467153827.stgit@warthog.procyon.org.uk>
References: <164243678893.2863669.12713835397467153827.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a ceph file is made up of inline data, uninline that in the ceph_open()
rather than in ceph_page_mkwrite(), ceph_write_iter(), ceph_fallocate() or
ceph_write_begin().

This makes it easier to convert to using the netfs library for VM write
hooks.

Changes
=======
ver #3:
 - Move the patch to make ceph_netfs_issue_op() before this one so that
   reading inline data is handled there.
 - Call read_mapping_folio() to allocate and cause the page to be read
   instead of reading inline data directly there.
 - Assume that we can just dump the uninlined data into the pagecache, no
   matter the caps.

ver #2:
 - Removed the uninline-handling code from ceph_write_begin() also.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: ceph-devel@vger.kernel.org
---

 fs/ceph/addr.c  |  135 +++++++++++++------------------------------------------
 fs/ceph/file.c  |   28 +++++++----
 fs/ceph/super.h |    2 -
 3 files changed, 50 insertions(+), 115 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 11273108e924..10837587f7db 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1319,45 +1319,11 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
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
@@ -1553,19 +1519,6 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
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
@@ -1690,16 +1643,16 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
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
+	struct folio *folio = NULL;
+	struct page *pages[1];
 	u64 len, inline_version;
 	int err = 0;
-	bool from_pagecache = false;
 
 	spin_lock(&ci->i_ceph_lock);
 	inline_version = ci->i_inline_version;
@@ -1712,43 +1665,24 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 	    inline_version == CEPH_INLINE_NONE)
 		goto out;
 
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
+	folio = read_mapping_folio(inode->i_mapping, 0, file);
+	if (IS_ERR(folio))
+		goto out;
 
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
+	if (folio_test_uptodate(folio))
+		goto out_put_folio;
+
+	err = folio_lock_killable(folio);
+	if (err < 0)
+		goto out_put_folio;
+
+	if (inline_version == 1 || /* initial version, no data */
+	    inline_version == CEPH_INLINE_NONE)
+		goto out_unlock;
+
+	len = i_size_read(inode);
+	if (len >  folio_size(folio))
+		len = folio_size(folio);
 
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 				    ceph_vino(inode), 0, &len, 0, 1,
@@ -1756,7 +1690,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 				    NULL, 0, 0, false);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
-		goto out;
+		goto out_unlock;
 	}
 
 	req->r_mtime = inode->i_mtime;
@@ -1765,7 +1699,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 		err = ceph_osdc_wait_request(&fsc->client->osdc, req);
 	ceph_osdc_put_request(req);
 	if (err < 0)
-		goto out;
+		goto out_unlock;
 
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 				    ceph_vino(inode), 0, &len, 1, 3,
@@ -1774,10 +1708,11 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
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
@@ -1787,7 +1722,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 					    CEPH_OSD_CMPXATTR_OP_GT,
 					    CEPH_OSD_CMPXATTR_MODE_U64);
 		if (err)
-			goto out_put;
+			goto out_put_req;
 	}
 
 	{
@@ -1798,7 +1733,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 					    "inline_version",
 					    xattr_buf, xattr_len, 0, 0);
 		if (err)
-			goto out_put;
+			goto out_put_req;
 	}
 
 	req->r_mtime = inode->i_mtime;
@@ -1809,19 +1744,15 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 	ceph_update_write_metrics(&fsc->mdsc->metric, req->r_start_latency,
 				  req->r_end_latency, len, err);
 
-out_put:
+out_put_req:
 	ceph_osdc_put_request(req);
 	if (err == -ECANCELED)
 		err = 0;
+out_unlock:
+	folio_unlock(folio);
+out_put_folio:
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
 	dout("uninline_data %p %llx.%llx inline_version %llu = %d\n",
 	     inode, ceph_vinop(inode), inline_version, err);
 	return err;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 9d9304e712d9..d1d28220f691 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -205,6 +205,7 @@ static int ceph_init_file_info(struct inode *inode, struct file *file,
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_file_info *fi;
+	int ret;
 
 	dout("%s %p %p 0%o (%s)\n", __func__, inode, file,
 			inode->i_mode, isdir ? "dir" : "regular");
@@ -235,7 +236,22 @@ static int ceph_init_file_info(struct inode *inode, struct file *file,
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
@@ -1763,12 +1779,6 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
@@ -2094,12 +2104,6 @@ static long ceph_fallocate(struct file *file, int mode,
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
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d0142cc5c41b..f1cec05e4eb8 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1207,7 +1207,7 @@ extern void __ceph_touch_fmode(struct ceph_inode_info *ci,
 /* addr.c */
 extern const struct address_space_operations ceph_aops;
 extern int ceph_mmap(struct file *file, struct vm_area_struct *vma);
-extern int ceph_uninline_data(struct file *filp, struct page *locked_page);
+extern int ceph_uninline_data(struct file *file);
 extern int ceph_pool_perm_check(struct inode *inode, int need);
 extern void ceph_pool_perm_destroy(struct ceph_mds_client* mdsc);
 int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invalidate);


