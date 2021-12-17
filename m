Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2946B478EF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 16:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbhLQPEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 10:04:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237809AbhLQPEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639753483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=k9xcqiNnhTjzn2fwr0M1ZTkGaqs6PIqW/lJHwIqnnWc=;
        b=TaCv2MUUQCx4uAz5hrtSj3+nn5JjI5ukwV1uJqHD3VRy/UwpIrrjz6PacGraPFePNavc8N
        IOscS/epD+ibatpbvapfuM3wfh4exAWJZZPMMX9dRXs8sJm8HMTcS32tY8PxW5ERJVo+qe
        rBCdz89159/tJ5WOECWbQFMrvAMxNxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-DvWHLaHuNkivacyvYWc37Q-1; Fri, 17 Dec 2021 10:04:40 -0500
X-MC-Unique: DvWHLaHuNkivacyvYWc37Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE04C94EF0;
        Fri, 17 Dec 2021 15:04:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBD3B78DFB;
        Fri, 17 Dec 2021 15:04:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] ceph: Uninline the data on a file opened for writing
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org
Cc:     ceph-devel@vger.kernel.org, idryomov@gmail.com,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org
Date:   Fri, 17 Dec 2021 15:04:29 +0000
Message-ID: <163975346937.2001835.1323687821705230415.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a ceph file is made up of inline data, uninline that in the ceph_open()
rather than in ceph_page_mkwrite(), ceph_write_iter() or ceph_fallocate().

This makes it easier to convert to using the netfs library for VM write
hooks.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: ceph-devel@vger.kernel.org
---

 fs/ceph/addr.c  |   63 ++++++++++++++++++++-----------------------------------
 fs/ceph/file.c  |   28 ++++++++++++++----------
 fs/ceph/super.h |    2 +-
 3 files changed, 40 insertions(+), 53 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e836f8f1d4f8..46f1cc6c91e4 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1512,19 +1512,6 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
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
@@ -1649,13 +1636,14 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
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
 	bool from_pagecache = false;
@@ -1671,34 +1659,30 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
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
+	if (ceph_caps_issued(ci) & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) {
+		folio = filemap_get_folio(inode->i_mapping, 0);
+		if (folio) {
+			if (folio_test_uptodate(folio)) {
 				from_pagecache = true;
-				lock_page(page);
+				folio_lock(folio);
 			} else {
-				put_page(page);
-				page = NULL;
+				folio_put(folio);
+				folio = NULL;
 			}
 		}
 	}
 
-	if (page) {
+	if (folio) {
 		len = i_size_read(inode);
-		if (len > PAGE_SIZE)
-			len = PAGE_SIZE;
+		if (len >  folio_size(folio))
+			len = folio_size(folio);
 	} else {
-		page = __page_cache_alloc(GFP_NOFS);
-		if (!page) {
+		folio = filemap_alloc_folio(GFP_NOFS, 0);
+		if (!folio) {
 			err = -ENOMEM;
 			goto out;
 		}
-		err = __ceph_do_getattr(inode, page,
+		err = __ceph_do_getattr(inode, folio_page(folio, 0),
 					CEPH_STAT_CAP_INLINE_DATA, true);
 		if (err < 0) {
 			/* no inline data */
@@ -1736,7 +1720,8 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 		goto out;
 	}
 
-	osd_req_op_extent_osd_data_pages(req, 1, &page, len, 0, false, false);
+	pages[0] = folio_page(folio, 0);
+	osd_req_op_extent_osd_data_pages(req, 1, pages, len, 0, false, false);
 
 	{
 		__le64 xattr_buf = cpu_to_le64(inline_version);
@@ -1773,12 +1758,10 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 	if (err == -ECANCELED)
 		err = 0;
 out:
-	if (page && page != locked_page) {
-		if (from_pagecache) {
-			unlock_page(page);
-			put_page(page);
-		} else
-			__free_pages(page, 0);
+	if (folio) {
+		if (from_pagecache)
+			folio_unlock(folio);
+		folio_put(folio);
 	}
 
 	dout("uninline_data %p %llx.%llx inline_version %llu = %d\n",
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index bf1017682d09..d16ba8720783 100644
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
@@ -1751,12 +1767,6 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
@@ -2082,12 +2092,6 @@ static long ceph_fallocate(struct file *file, int mode,
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


