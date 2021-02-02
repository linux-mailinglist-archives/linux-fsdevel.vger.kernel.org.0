Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FA530BC8A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 12:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBBLGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 06:06:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229511AbhBBLGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612263874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SVGYKHIcPo6tueTdXNVLBjjSO7ZYj2ZvN2dKNlpOlHI=;
        b=AteY/IXd19PsmypHEFpyz+wAwFKrFKIwd6M6HnrjNPc+MnFXFnoB+tmMN7nAtYKArDjjG+
        PIb48UO43FeKcFaNxTd8XGKg7TSEt53AwsX9jyJsqmI63W1U1eIJvsjdalQA46iP3on6JG
        ZyUXmHyYRFxnp1QQoSclcsZRzaUjSvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-BBnzba1hP1GlMVjmTv-a2w-1; Tue, 02 Feb 2021 06:04:30 -0500
X-MC-Unique: BBnzba1hP1GlMVjmTv-a2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DB571DDE1;
        Tue,  2 Feb 2021 11:04:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B72C560C6B;
        Tue,  2 Feb 2021 11:04:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
cc:     dhowells@redhat.com, Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] 9p: Convert to cut-down fscache I/O API rewrite
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <241016.1612263863.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 02 Feb 2021 11:04:23 +0000
Message-ID: <241017.1612263863@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dominique,

Here's a draft of a patch to convert 9P to use the cut-down part of the
fscache I/O API rewrite (I've removed all the cookie and object state mach=
ine
changes for now).  It compiles, but I've no way to test it.  This is built=
 on
top of my fscache-netfs-lib branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dfscache-netfs-lib

I'm hoping to ask Linus to pull the netfs lib, afs and ceph changes in the
next merge window.

Would you be able to give it a whirl?

David
---
commit 725145bde271b382e7e4e4ee2a9342a36f91b8fc
Author: David Howells <dhowells@redhat.com>
Date:   Wed Nov 18 09:06:42 2020 +0000

    9p: Convert to using the netfs helper lib to do reads and caching
    =

    Convert the 9p filesystem to use the netfs helper lib to handle readpa=
ge,
    readahead and write_begin, converting those into a common issue_op for=
 the
    filesystem itself to handle.  The netfs helper lib also handles readin=
g
    from fscache if a cache is available, and interleaving reads from both
    sources.
    =

    This change also switches from the old fscache I/O API to the new one,
    meaning that fscache no longer keeps track of netfs pages and instead =
does
    async DIO between the backing files and the 9p file pagecache.  As a p=
art
    of this change, the handling of PG_fscache changes.  It now just means=
 that
    the cache has a write I/O operation in progress on a page (PG_locked
    is used for a read I/O op).
    =

    Note that this is a cut-down version of the fscache rewrite and does n=
ot
    change any of the cookie and cache coherency handling.
    =

    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/fs/9p/Kconfig b/fs/9p/Kconfig
index 09fd4a185fd2..d7bc93447c85 100644
--- a/fs/9p/Kconfig
+++ b/fs/9p/Kconfig
@@ -2,6 +2,7 @@
 config 9P_FS
 	tristate "Plan 9 Resource Sharing Support (9P2000)"
 	depends on INET && NET_9P
+	select NETFS_SUPPORT
 	help
 	  If you say Y here, you will get experimental support for
 	  Plan 9 resource sharing via the 9P2000 protocol.
diff --git a/fs/9p/cache.c b/fs/9p/cache.c
index eb2151fb6049..68e5d12e690d 100644
--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -199,140 +199,3 @@ void v9fs_cache_inode_reset_cookie(struct inode *ino=
de)
 =

 	mutex_unlock(&v9inode->fscache_lock);
 }
-
-int __v9fs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	struct inode *inode =3D page->mapping->host;
-	struct v9fs_inode *v9inode =3D V9FS_I(inode);
-
-	BUG_ON(!v9inode->fscache);
-
-	return fscache_maybe_release_page(v9inode->fscache, page, gfp);
-}
-
-void __v9fs_fscache_invalidate_page(struct page *page)
-{
-	struct inode *inode =3D page->mapping->host;
-	struct v9fs_inode *v9inode =3D V9FS_I(inode);
-
-	BUG_ON(!v9inode->fscache);
-
-	if (PageFsCache(page)) {
-		fscache_wait_on_page_write(v9inode->fscache, page);
-		BUG_ON(!PageLocked(page));
-		fscache_uncache_page(v9inode->fscache, page);
-	}
-}
-
-static void v9fs_vfs_readpage_complete(struct page *page, void *data,
-				       int error)
-{
-	if (!error)
-		SetPageUptodate(page);
-
-	unlock_page(page);
-}
-
-/**
- * __v9fs_readpage_from_fscache - read a page from cache
- *
- * Returns 0 if the pages are in cache and a BIO is submitted,
- * 1 if the pages are not in cache and -error otherwise.
- */
-
-int __v9fs_readpage_from_fscache(struct inode *inode, struct page *page)
-{
-	int ret;
-	const struct v9fs_inode *v9inode =3D V9FS_I(inode);
-
-	p9_debug(P9_DEBUG_FSC, "inode %p page %p\n", inode, page);
-	if (!v9inode->fscache)
-		return -ENOBUFS;
-
-	ret =3D fscache_read_or_alloc_page(v9inode->fscache,
-					 page,
-					 v9fs_vfs_readpage_complete,
-					 NULL,
-					 GFP_KERNEL);
-	switch (ret) {
-	case -ENOBUFS:
-	case -ENODATA:
-		p9_debug(P9_DEBUG_FSC, "page/inode not in cache %d\n", ret);
-		return 1;
-	case 0:
-		p9_debug(P9_DEBUG_FSC, "BIO submitted\n");
-		return ret;
-	default:
-		p9_debug(P9_DEBUG_FSC, "ret %d\n", ret);
-		return ret;
-	}
-}
-
-/**
- * __v9fs_readpages_from_fscache - read multiple pages from cache
- *
- * Returns 0 if the pages are in cache and a BIO is submitted,
- * 1 if the pages are not in cache and -error otherwise.
- */
-
-int __v9fs_readpages_from_fscache(struct inode *inode,
-				  struct address_space *mapping,
-				  struct list_head *pages,
-				  unsigned *nr_pages)
-{
-	int ret;
-	const struct v9fs_inode *v9inode =3D V9FS_I(inode);
-
-	p9_debug(P9_DEBUG_FSC, "inode %p pages %u\n", inode, *nr_pages);
-	if (!v9inode->fscache)
-		return -ENOBUFS;
-
-	ret =3D fscache_read_or_alloc_pages(v9inode->fscache,
-					  mapping, pages, nr_pages,
-					  v9fs_vfs_readpage_complete,
-					  NULL,
-					  mapping_gfp_mask(mapping));
-	switch (ret) {
-	case -ENOBUFS:
-	case -ENODATA:
-		p9_debug(P9_DEBUG_FSC, "pages/inodes not in cache %d\n", ret);
-		return 1;
-	case 0:
-		BUG_ON(!list_empty(pages));
-		BUG_ON(*nr_pages !=3D 0);
-		p9_debug(P9_DEBUG_FSC, "BIO submitted\n");
-		return ret;
-	default:
-		p9_debug(P9_DEBUG_FSC, "ret %d\n", ret);
-		return ret;
-	}
-}
-
-/**
- * __v9fs_readpage_to_fscache - write a page to the cache
- *
- */
-
-void __v9fs_readpage_to_fscache(struct inode *inode, struct page *page)
-{
-	int ret;
-	const struct v9fs_inode *v9inode =3D V9FS_I(inode);
-
-	p9_debug(P9_DEBUG_FSC, "inode %p page %p\n", inode, page);
-	ret =3D fscache_write_page(v9inode->fscache, page,
-				 i_size_read(&v9inode->vfs_inode), GFP_KERNEL);
-	p9_debug(P9_DEBUG_FSC, "ret =3D  %d\n", ret);
-	if (ret !=3D 0)
-		v9fs_uncache_page(inode, page);
-}
-
-/*
- * wait for a page to complete writing to the cache
- */
-void __v9fs_fscache_wait_on_page_write(struct inode *inode, struct page *=
page)
-{
-	const struct v9fs_inode *v9inode =3D V9FS_I(inode);
-	p9_debug(P9_DEBUG_FSC, "inode %p page %p\n", inode, page);
-	if (PageFsCache(page))
-		fscache_wait_on_page_write(v9inode->fscache, page);
-}
diff --git a/fs/9p/cache.h b/fs/9p/cache.h
index 00f107af443e..cfafa89b972c 100644
--- a/fs/9p/cache.h
+++ b/fs/9p/cache.h
@@ -7,9 +7,11 @@
 =

 #ifndef _9P_CACHE_H
 #define _9P_CACHE_H
-#ifdef CONFIG_9P_FSCACHE
+
+#define FSCACHE_USE_NEW_IO_API
 #include <linux/fscache.h>
-#include <linux/spinlock.h>
+
+#ifdef CONFIG_9P_FSCACHE
 =

 extern struct fscache_netfs v9fs_cache_netfs;
 extern const struct fscache_cookie_def v9fs_cache_session_index_def;
@@ -27,64 +29,6 @@ extern void v9fs_cache_inode_reset_cookie(struct inode =
*inode);
 extern int __v9fs_cache_register(void);
 extern void __v9fs_cache_unregister(void);
 =

-extern int __v9fs_fscache_release_page(struct page *page, gfp_t gfp);
-extern void __v9fs_fscache_invalidate_page(struct page *page);
-extern int __v9fs_readpage_from_fscache(struct inode *inode,
-					struct page *page);
-extern int __v9fs_readpages_from_fscache(struct inode *inode,
-					 struct address_space *mapping,
-					 struct list_head *pages,
-					 unsigned *nr_pages);
-extern void __v9fs_readpage_to_fscache(struct inode *inode, struct page *=
page);
-extern void __v9fs_fscache_wait_on_page_write(struct inode *inode,
-					      struct page *page);
-
-static inline int v9fs_fscache_release_page(struct page *page,
-					    gfp_t gfp)
-{
-	return __v9fs_fscache_release_page(page, gfp);
-}
-
-static inline void v9fs_fscache_invalidate_page(struct page *page)
-{
-	__v9fs_fscache_invalidate_page(page);
-}
-
-static inline int v9fs_readpage_from_fscache(struct inode *inode,
-					     struct page *page)
-{
-	return __v9fs_readpage_from_fscache(inode, page);
-}
-
-static inline int v9fs_readpages_from_fscache(struct inode *inode,
-					      struct address_space *mapping,
-					      struct list_head *pages,
-					      unsigned *nr_pages)
-{
-	return __v9fs_readpages_from_fscache(inode, mapping, pages,
-					     nr_pages);
-}
-
-static inline void v9fs_readpage_to_fscache(struct inode *inode,
-					    struct page *page)
-{
-	if (PageFsCache(page))
-		__v9fs_readpage_to_fscache(inode, page);
-}
-
-static inline void v9fs_uncache_page(struct inode *inode, struct page *pa=
ge)
-{
-	struct v9fs_inode *v9inode =3D V9FS_I(inode);
-	fscache_uncache_page(v9inode->fscache, page);
-	BUG_ON(PageFsCache(page));
-}
-
-static inline void v9fs_fscache_wait_on_page_write(struct inode *inode,
-						   struct page *page)
-{
-	return __v9fs_fscache_wait_on_page_write(inode, page);
-}
-
 #else /* CONFIG_9P_FSCACHE */
 =

 static inline void v9fs_cache_inode_get_cookie(struct inode *inode)
@@ -99,39 +43,5 @@ static inline void v9fs_cache_inode_set_cookie(struct i=
node *inode, struct file
 {
 }
 =

-static inline int v9fs_fscache_release_page(struct page *page,
-					    gfp_t gfp) {
-	return 1;
-}
-
-static inline void v9fs_fscache_invalidate_page(struct page *page) {}
-
-static inline int v9fs_readpage_from_fscache(struct inode *inode,
-					     struct page *page)
-{
-	return -ENOBUFS;
-}
-
-static inline int v9fs_readpages_from_fscache(struct inode *inode,
-					      struct address_space *mapping,
-					      struct list_head *pages,
-					      unsigned *nr_pages)
-{
-	return -ENOBUFS;
-}
-
-static inline void v9fs_readpage_to_fscache(struct inode *inode,
-					    struct page *page)
-{}
-
-static inline void v9fs_uncache_page(struct inode *inode, struct page *pa=
ge)
-{}
-
-static inline void v9fs_fscache_wait_on_page_write(struct inode *inode,
-						   struct page *page)
-{
-	return;
-}
-
 #endif /* CONFIG_9P_FSCACHE */
 #endif /* _9P_CACHE_H */
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 7b763776306e..780b9ef78622 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -123,6 +123,15 @@ static inline struct v9fs_inode *V9FS_I(const struct =
inode *inode)
 {
 	return container_of(inode, struct v9fs_inode, vfs_inode);
 }
+ =

+static inline struct fscache_cookie *v9fs_inode_cookie(struct v9fs_inode =
*v9inode)
+{
+#ifdef CONFIG_9P_FSCACHE
+	return v9inode->fscache;
+#else
+	return NULL;
+#endif	=

+}
 =

 extern int v9fs_show_options(struct seq_file *m, struct dentry *root);
 =

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index cce9ace651a2..4e273e006056 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -19,7 +19,7 @@
 #include <linux/idr.h>
 #include <linux/sched.h>
 #include <linux/uio.h>
-#include <linux/bvec.h>
+#include <linux/netfs.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 =

@@ -29,89 +29,85 @@
 #include "fid.h"
 =

 /**
- * v9fs_fid_readpage - read an entire page in from 9P
- *
- * @fid: fid being read
- * @page: structure to page
- *
+ * v9fs_req_issue_op - Issue a read from 9P
+ * @subreq: The read to make
  */
-static int v9fs_fid_readpage(void *data, struct page *page)
+static void v9fs_req_issue_op(struct netfs_read_subrequest *subreq)
 {
-	struct p9_fid *fid =3D data;
-	struct inode *inode =3D page->mapping->host;
-	struct bio_vec bvec =3D {.bv_page =3D page, .bv_len =3D PAGE_SIZE};
+	struct netfs_read_request *rreq =3D subreq->rreq;
+	struct p9_fid *fid =3D rreq->netfs_priv;
 	struct iov_iter to;
+	loff_t pos =3D subreq->start + subreq->transferred;
+	size_t len =3D subreq->len   - subreq->transferred;
 	int retval, err;
 =

-	p9_debug(P9_DEBUG_VFS, "\n");
-
-	BUG_ON(!PageLocked(page));
+	iov_iter_xarray(&to, READ, &rreq->mapping->i_pages, pos, len);
 =

-	retval =3D v9fs_readpage_from_fscache(inode, page);
-	if (retval =3D=3D 0)
-		return retval;
+	retval =3D p9_client_read(fid, pos, &to, &err);
+	if (retval)
+		subreq->error =3D retval;
+}
 =

-	iov_iter_bvec(&to, READ, &bvec, 1, PAGE_SIZE);
+/**
+ * v9fs_init_rreq - Initialise a read request
+ * @rreq: The read request
+ * @file: The file being read from
+ */
+static void v9fs_init_rreq(struct netfs_read_request *rreq, struct file *=
file)
+{
+	rreq->netfs_priv =3D file->private_data;
+}
 =

-	retval =3D p9_client_read(fid, page_offset(page), &to, &err);
-	if (err) {
-		v9fs_uncache_page(inode, page);
-		retval =3D err;
-		goto done;
-	}
+/**
+ * v9fs_is_cache_enabled - Determine if caching is enabled for an inode
+ * @inode: The inode to check
+ */
+static bool v9fs_is_cache_enabled(struct inode *inode)
+{
+	struct fscache_cookie *cookie =3D v9fs_inode_cookie(V9FS_I(inode));
 =

-	zero_user(page, retval, PAGE_SIZE - retval);
-	flush_dcache_page(page);
-	SetPageUptodate(page);
+	return fscache_cookie_enabled(cookie) && !hlist_empty(&cookie->backing_o=
bjects);
+}
 =

-	v9fs_readpage_to_fscache(inode, page);
-	retval =3D 0;
+/**
+ * v9fs_begin_cache_operation - Begin a cache operation for a read
+ * @rreq: The read request
+ */
+static int v9fs_begin_cache_operation(struct netfs_read_request *rreq)
+{
+	struct fscache_cookie *cookie =3D v9fs_inode_cookie(V9FS_I(rreq->inode))=
;
 =

-done:
-	unlock_page(page);
-	return retval;
+	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
+		return __fscache_begin_read_operation(rreq, cookie);
+	else
+		return -ENOBUFS;
 }
 =

+static const struct netfs_read_request_ops v9fs_req_ops =3D {
+	.init_rreq		=3D v9fs_init_rreq,
+	.is_cache_enabled	=3D v9fs_is_cache_enabled,
+	.begin_cache_operation	=3D v9fs_begin_cache_operation,
+	.issue_op		=3D v9fs_req_issue_op,
+};
+
 /**
  * v9fs_vfs_readpage - read an entire page in from 9P
- *
  * @filp: file being read
  * @page: structure to page
  *
  */
-
-static int v9fs_vfs_readpage(struct file *filp, struct page *page)
+static int v9fs_vfs_readpage(struct file *file, struct page *page)
 {
-	return v9fs_fid_readpage(filp->private_data, page);
+	return netfs_readpage(file, page, &v9fs_req_ops, NULL);
 }
 =

 /**
- * v9fs_vfs_readpages - read a set of pages from 9P
- *
- * @filp: file being read
- * @mapping: the address space
- * @pages: list of pages to read
- * @nr_pages: count of pages to read
- *
+ * v9fs_vfs_readahead - read a set of pages from 9P
+ * @ractl: The readahead parameters
  */
-
-static int v9fs_vfs_readpages(struct file *filp, struct address_space *ma=
pping,
-			     struct list_head *pages, unsigned nr_pages)
+static void v9fs_vfs_readahead(struct readahead_control *ractl)
 {
-	int ret =3D 0;
-	struct inode *inode;
-
-	inode =3D mapping->host;
-	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, filp);
-
-	ret =3D v9fs_readpages_from_fscache(inode, mapping, pages, &nr_pages);
-	if (ret =3D=3D 0)
-		return ret;
-
-	ret =3D read_cache_pages(mapping, pages, v9fs_fid_readpage,
-			filp->private_data);
-	p9_debug(P9_DEBUG_VFS, "  =3D %d\n", ret);
-	return ret;
+	netfs_readahead(ractl, &v9fs_req_ops, NULL);
 }
 =

 /**
@@ -124,7 +120,14 @@ static int v9fs_release_page(struct page *page, gfp_t=
 gfp)
 {
 	if (PagePrivate(page))
 		return 0;
-	return v9fs_fscache_release_page(page, gfp);
+#ifdef CONFIG_AFS_FSCACHE
+	if (PageFsCache(page)) {
+		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
+			return 0;
+		wait_on_page_fscache(page);
+	}
+#endif
+	return 1;
 }
 =

 /**
@@ -137,21 +140,16 @@ static int v9fs_release_page(struct page *page, gfp_=
t gfp)
 static void v9fs_invalidate_page(struct page *page, unsigned int offset,
 				 unsigned int length)
 {
-	/*
-	 * If called with zero offset, we should release
-	 * the private state assocated with the page
-	 */
-	if (offset =3D=3D 0 && length =3D=3D PAGE_SIZE)
-		v9fs_fscache_invalidate_page(page);
+	wait_on_page_fscache(page);
 }
 =

 static int v9fs_vfs_writepage_locked(struct page *page)
 {
 	struct inode *inode =3D page->mapping->host;
 	struct v9fs_inode *v9inode =3D V9FS_I(inode);
+	loff_t start =3D page_offset(page);
 	loff_t size =3D i_size_read(inode);
 	struct iov_iter from;
-	struct bio_vec bvec;
 	int err, len;
 =

 	if (page->index =3D=3D size >> PAGE_SHIFT)
@@ -159,17 +157,14 @@ static int v9fs_vfs_writepage_locked(struct page *pa=
ge)
 	else
 		len =3D PAGE_SIZE;
 =

-	bvec.bv_page =3D page;
-	bvec.bv_offset =3D 0;
-	bvec.bv_len =3D len;
-	iov_iter_bvec(&from, WRITE, &bvec, 1, len);
+	iov_iter_xarray(&from, WRITE, &page->mapping->i_pages, start, len);
 =

 	/* We should have writeback_fid always set */
 	BUG_ON(!v9inode->writeback_fid);
 =

 	set_page_writeback(page);
 =

-	p9_client_write(v9inode->writeback_fid, page_offset(page), &from, &err);
+	p9_client_write(v9inode->writeback_fid, start, &from, &err);
 =

 	end_page_writeback(page);
 	return err;
@@ -205,14 +200,13 @@ static int v9fs_vfs_writepage(struct page *page, str=
uct writeback_control *wbc)
 static int v9fs_launder_page(struct page *page)
 {
 	int retval;
-	struct inode *inode =3D page->mapping->host;
 =

-	v9fs_fscache_wait_on_page_write(inode, page);
 	if (clear_page_dirty_for_io(page)) {
 		retval =3D v9fs_vfs_writepage_locked(page);
 		if (retval)
 			return retval;
 	}
+	wait_on_page_fscache(page);
 	return 0;
 }
 =

@@ -256,35 +250,24 @@ static int v9fs_write_begin(struct file *filp, struc=
t address_space *mapping,
 			    loff_t pos, unsigned len, unsigned flags,
 			    struct page **pagep, void **fsdata)
 {
-	int retval =3D 0;
+	int retval;
 	struct page *page;
-	struct v9fs_inode *v9inode;
-	pgoff_t index =3D pos >> PAGE_SHIFT;
-	struct inode *inode =3D mapping->host;
-
+	struct v9fs_inode *v9inode =3D V9FS_I(mapping->host);
 =

 	p9_debug(P9_DEBUG_VFS, "filp %p, mapping %p\n", filp, mapping);
 =

-	v9inode =3D V9FS_I(inode);
-start:
-	page =3D grab_cache_page_write_begin(mapping, index, flags);
-	if (!page) {
-		retval =3D -ENOMEM;
-		goto out;
-	}
 	BUG_ON(!v9inode->writeback_fid);
-	if (PageUptodate(page))
-		goto out;
 =

-	if (len =3D=3D PAGE_SIZE)
-		goto out;
+	/* Prefetch area to be written into the cache if we're caching this
+	 * file.  We need to do this before we get a lock on the page in case
+	 * there's more than one writer competing for the same cache block.
+	 */
+	retval =3D netfs_write_begin(filp, mapping, pos, len, flags, &page, fsda=
ta,
+				   &v9fs_req_ops, NULL);
+	if (retval < 0)
+		return retval;
 =

-	retval =3D v9fs_fid_readpage(v9inode->writeback_fid, page);
-	put_page(page);
-	if (!retval)
-		goto start;
-out:
-	*pagep =3D page;
+	*pagep =3D find_subpage(page, pos / PAGE_SIZE);
 	return retval;
 }
 =

@@ -324,7 +307,7 @@ static int v9fs_write_end(struct file *filp, struct ad=
dress_space *mapping,
 =

 const struct address_space_operations v9fs_addr_operations =3D {
 	.readpage =3D v9fs_vfs_readpage,
-	.readpages =3D v9fs_vfs_readpages,
+	.readahead =3D v9fs_vfs_readahead,
 	.set_page_dirty =3D __set_page_dirty_nobuffers,
 	.writepage =3D v9fs_vfs_writepage,
 	.write_begin =3D v9fs_write_begin,
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 649f04f112dc..9a1f510633c7 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -555,14 +555,27 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 	p9_debug(P9_DEBUG_VFS, "page %p fid %lx\n",
 		 page, (unsigned long)filp->private_data);
 =

+	v9inode =3D V9FS_I(inode);
+
+	/* Wait for the page to be written to the cache before we allow it to
+	 * be modified.  We then assume the entire page will need writing back.
+	 */
+#ifdef CONFIG_V9FS_FSCACHE
+	if (PageFsCache(page) &&
+	    wait_on_page_bit_killable(page, PG_fscache) < 0)
+		return VM_FAULT_RETRY;
+#endif
+
+	if (PageWriteback(page) &&
+	    wait_on_page_bit_killable(page, PG_writeback) < 0)
+		return VM_FAULT_RETRY;
+
 	/* Update file times before taking page lock */
 	file_update_time(filp);
 =

-	v9inode =3D V9FS_I(inode);
-	/* make sure the cache has finished storing the page */
-	v9fs_fscache_wait_on_page_write(inode, page);
 	BUG_ON(!v9inode->writeback_fid);
-	lock_page(page);
+	if (lock_page_killable(page) < 0)
+		return VM_FAULT_RETRY;
 	if (page->mapping !=3D inode->i_mapping)
 		goto out_unlock;
 	wait_for_stable_page(page);

