Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B954946F13B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242584AbhLIROM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:14:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242588AbhLIROF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSJhgCoB+950zrWgcIUFIpKQvzVtAWH1v4id/d+sOf4=;
        b=W1lwripsAuHvFRiKu9pP0LSBaHFjIureaTIScDhIyD6kQGTtkFqTjor4a4y+/j5pFRuBbt
        6hhUWWpSXGDo1ZTnbZqCgFAn9w6yrzg5j4fSngvSl93taB8Fg8t7QUSKJEFRrU7VZqk4RQ
        JUUOiFLOf5lrdGcpCYvvrJg5bDvsYoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-gHxk5Bt2NYuOwT-7jQzpLw-1; Thu, 09 Dec 2021 12:10:28 -0500
X-MC-Unique: gHxk5Bt2NYuOwT-7jQzpLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CACF81CCB4;
        Thu,  9 Dec 2021 17:10:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 109D810023AE;
        Thu,  9 Dec 2021 17:10:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 63/67] nfs: Implement cache I/O by accessing the cache
 directly
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Dec 2021 17:10:13 +0000
Message-ID: <163906981318.143852.17220018647843475985.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move NFS to using fscache DIO API instead of the old upstream I/O API as
that has been removed.  This is a stopgap solution as the intention is that
at sometime in the future, the cache will move to using larger blocks and
won't be able to store individual pages in order to deal with the potential
for data corruption due to the backing filesystem being able insert/remove
bridging blocks of zeros into its extent list[1].

NFS then reads and writes cache pages synchronously and one page at a time.

The preferred change would be to use the netfs lib, but the new I/O API can
be used directly.  It's just that as the cache now needs to track data for
itself, caching blocks may exceed page size...

This code is somewhat borrowed from my "fallback I/O" patchset[2].

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dave Wysochanski <dwysocha@redhat.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Anna Schumaker <anna.schumaker@netapp.com>
cc: linux-nfs@vger.kernel.org
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/YO17ZNOcq+9PajfQ@mit.edu [1]
Link: https://lore.kernel.org/r/163189108292.2509237.12615909591150927232.stgit@warthog.procyon.org.uk/ [2]
---

 fs/fscache/io.c         |    8 +++
 fs/nfs/fscache.c        |  126 ++++++++++++++++++++++++++++++++++++++---------
 fs/nfs/fscache.h        |   56 ++++-----------------
 fs/nfs/read.c           |   25 +++------
 fs/nfs/write.c          |    7 ++-
 include/linux/fscache.h |   28 ++++++++++
 6 files changed, 163 insertions(+), 87 deletions(-)

diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index bed7628a5a9d..7a769ea57720 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -150,6 +150,14 @@ int __fscache_begin_read_operation(struct netfs_cache_resources *cres,
 }
 EXPORT_SYMBOL(__fscache_begin_read_operation);
 
+int __fscache_begin_write_operation(struct netfs_cache_resources *cres,
+				    struct fscache_cookie *cookie)
+{
+	return fscache_begin_operation(cres, cookie, FSCACHE_WANT_PARAMS,
+				       fscache_access_io_write);
+}
+EXPORT_SYMBOL(__fscache_begin_write_operation);
+
 /**
  * fscache_set_page_dirty - Mark page dirty and pin a cache object for writeback
  * @page: The page being dirtied
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index d10e50ab0b3d..aef777d2f308 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -249,48 +249,128 @@ void nfs_fscache_release_file(struct inode *inode, struct file *filp)
 	}
 }
 
+static inline void fscache_end_operation(struct netfs_cache_resources *cres)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+
+	if (ops)
+		ops->end_operation(cres);
+}
+
+/*
+ * Fallback page reading interface.
+ */
+static int fscache_fallback_read_page(struct inode *inode, struct page *page)
+{
+	struct netfs_cache_resources cres;
+	struct fscache_cookie *cookie = nfs_i_fscache(inode);
+	struct iov_iter iter;
+	struct bio_vec bvec[1];
+	int ret;
+
+	memset(&cres, 0, sizeof(cres));
+	bvec[0].bv_page		= page;
+	bvec[0].bv_offset	= 0;
+	bvec[0].bv_len		= PAGE_SIZE;
+	iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+
+	ret = fscache_begin_read_operation(&cres, cookie);
+	if (ret < 0)
+		return ret;
+
+	ret = fscache_read(&cres, page_offset(page), &iter, NETFS_READ_HOLE_FAIL,
+			   NULL, NULL);
+	fscache_end_operation(&cres);
+	return ret;
+}
+
+/*
+ * Fallback page writing interface.
+ */
+static int fscache_fallback_write_page(struct inode *inode, struct page *page,
+				       bool no_space_allocated_yet)
+{
+	struct netfs_cache_resources cres;
+	struct fscache_cookie *cookie = nfs_i_fscache(inode);
+	struct iov_iter iter;
+	struct bio_vec bvec[1];
+	loff_t start = page_offset(page);
+	size_t len = PAGE_SIZE;
+	int ret;
+
+	memset(&cres, 0, sizeof(cres));
+	bvec[0].bv_page		= page;
+	bvec[0].bv_offset	= 0;
+	bvec[0].bv_len		= PAGE_SIZE;
+	iov_iter_bvec(&iter, WRITE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+
+	ret = fscache_begin_write_operation(&cres, cookie);
+	if (ret < 0)
+		return ret;
+
+	ret = cres.ops->prepare_write(&cres, &start, &len, i_size_read(inode),
+				      no_space_allocated_yet);
+	if (ret == 0)
+		ret = fscache_write(&cres, page_offset(page), &iter, NULL, NULL);
+	fscache_end_operation(&cres);
+	return ret;
+}
+
 /*
  * Retrieve a page from fscache
  */
-int __nfs_readpage_from_fscache(struct nfs_open_context *ctx,
-				struct inode *inode, struct page *page)
+int __nfs_readpage_from_fscache(struct inode *inode, struct page *page)
 {
+	int ret;
+
 	dfprintk(FSCACHE,
 		 "NFS: readpage_from_fscache(fsc:%p/p:%p(i:%lx f:%lx)/0x%p)\n",
 		 nfs_i_fscache(inode), page, page->index, page->flags, inode);
 
 	if (PageChecked(page)) {
+		dfprintk(FSCACHE, "NFS:    readpage_from_fscache: PageChecked\n");
 		ClearPageChecked(page);
 		return 1;
 	}
 
-	return -ENOBUFS; // TODO: Use netfslib
-}
-
-/*
- * Retrieve a set of pages from fscache
- */
-int __nfs_readpages_from_fscache(struct nfs_open_context *ctx,
-				 struct inode *inode,
-				 struct address_space *mapping,
-				 struct list_head *pages,
-				 unsigned *nr_pages)
-{
-	dfprintk(FSCACHE, "NFS: nfs_getpages_from_fscache (0x%p/%u/0x%p)\n",
-		 nfs_i_fscache(inode), *nr_pages, inode);
+	ret = fscache_fallback_read_page(inode, page);
+	if (ret < 0) {
+		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
+		dfprintk(FSCACHE,
+			 "NFS:    readpage_from_fscache failed %d\n", ret);
+		SetPageChecked(page);
+		return ret;
+	}
 
-	return -ENOBUFS; // TODO: Use netfslib
+	/* Read completed synchronously */
+	dfprintk(FSCACHE, "NFS:    readpage_from_fscache: read successful\n");
+	nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
+	SetPageUptodate(page);
+	return 0;
 }
 
 /*
- * Store a newly fetched page in fscache
- * - PG_fscache must be set on the page
+ * Store a newly fetched page in fscache.  We can be certain there's no page
+ * stored in the cache as yet otherwise we would've read it from there.
  */
-void __nfs_readpage_to_fscache(struct inode *inode, struct page *page, int sync)
+void __nfs_readpage_to_fscache(struct inode *inode, struct page *page)
 {
+	int ret;
+
 	dfprintk(FSCACHE,
-		 "NFS: readpage_to_fscache(fsc:%p/p:%p(i:%lx f:%lx)/%d)\n",
-		 nfs_i_fscache(inode), page, page->index, page->flags, sync);
+		 "NFS: readpage_to_fscache(fsc:%p/p:%p(i:%lx f:%lx))\n",
+		 nfs_i_fscache(inode), page, page->index, page->flags);
 
-	return; // TODO: Use netfslib
+	ret = fscache_fallback_write_page(inode, page, true);
+
+	dfprintk(FSCACHE,
+		 "NFS:     readpage_to_fscache: p:%p(i:%lu f:%lx) ret %d\n",
+		 page, page->index, page->flags, ret);
+
+	if (ret != 0) {
+		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_WRITTEN_FAIL);
+		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_UNCACHED);
+	} else {
+		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_WRITTEN_OK);
+	}
 }
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 26b6fb1cfd58..487e012363f5 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -44,14 +44,10 @@ extern void nfs_fscache_clear_inode(struct inode *);
 extern void nfs_fscache_open_file(struct inode *, struct file *);
 extern void nfs_fscache_release_file(struct inode *, struct file *);
 
-extern void __nfs_fscache_invalidate_page(struct page *, struct inode *);
-
-extern int __nfs_readpage_from_fscache(struct nfs_open_context *,
-				       struct inode *, struct page *);
-extern int __nfs_readpages_from_fscache(struct nfs_open_context *,
-					struct inode *, struct address_space *,
-					struct list_head *, unsigned *);
-extern void __nfs_readpage_to_fscache(struct inode *, struct page *, int);
+extern int __nfs_readpage_from_fscache(struct inode *, struct page *);
+extern void __nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
+					     unsigned long bytes);
+extern void __nfs_readpage_to_fscache(struct inode *, struct page *);
 
 static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
 {
@@ -69,27 +65,11 @@ static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
 /*
  * Retrieve a page from an inode data storage object.
  */
-static inline int nfs_readpage_from_fscache(struct nfs_open_context *ctx,
-					    struct inode *inode,
+static inline int nfs_readpage_from_fscache(struct inode *inode,
 					    struct page *page)
 {
 	if (NFS_I(inode)->fscache)
-		return __nfs_readpage_from_fscache(ctx, inode, page);
-	return -ENOBUFS;
-}
-
-/*
- * Retrieve a set of pages from an inode data storage object.
- */
-static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
-					     struct inode *inode,
-					     struct address_space *mapping,
-					     struct list_head *pages,
-					     unsigned *nr_pages)
-{
-	if (NFS_I(inode)->fscache)
-		return __nfs_readpages_from_fscache(ctx, inode, mapping, pages,
-						    nr_pages);
+		return __nfs_readpage_from_fscache(inode, page);
 	return -ENOBUFS;
 }
 
@@ -98,11 +78,10 @@ static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
  * in the cache.
  */
 static inline void nfs_readpage_to_fscache(struct inode *inode,
-					   struct page *page,
-					   int sync)
+					   struct page *page)
 {
-	if (PageFsCache(page))
-		__nfs_readpage_to_fscache(inode, page, sync);
+	if (NFS_I(inode)->fscache)
+		__nfs_readpage_to_fscache(inode, page);
 }
 
 static inline void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *auxdata,
@@ -151,26 +130,13 @@ static inline void nfs_fscache_clear_inode(struct inode *inode) {}
 static inline void nfs_fscache_open_file(struct inode *inode,
 					 struct file *filp) {}
 
-static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	return 1; /* True: may release page */
-}
-static inline int nfs_readpage_from_fscache(struct nfs_open_context *ctx,
-					    struct inode *inode,
+static inline int nfs_readpage_from_fscache(struct inode *inode,
 					    struct page *page)
 {
 	return -ENOBUFS;
 }
-static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
-					     struct inode *inode,
-					     struct address_space *mapping,
-					     struct list_head *pages,
-					     unsigned *nr_pages)
-{
-	return -ENOBUFS;
-}
 static inline void nfs_readpage_to_fscache(struct inode *inode,
-					   struct page *page, int sync) {}
+					   struct page *page) {}
 
 
 static inline void nfs_fscache_invalidate(struct inode *inode, int flags) {}
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index d11af2a9299c..eb00229c1a50 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -123,7 +123,7 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 		struct address_space *mapping = page_file_mapping(page);
 
 		if (PageUptodate(page))
-			nfs_readpage_to_fscache(inode, page, 0);
+			nfs_readpage_to_fscache(inode, page);
 		else if (!PageError(page) && !PagePrivate(page))
 			generic_error_remove_page(mapping, page);
 		unlock_page(page);
@@ -305,6 +305,12 @@ readpage_async_filler(void *data, struct page *page)
 
 	aligned_len = min_t(unsigned int, ALIGN(len, rsize), PAGE_SIZE);
 
+	if (!IS_SYNC(page->mapping->host)) {
+		error = nfs_readpage_from_fscache(page->mapping->host, page);
+		if (error == 0)
+			goto out_unlock;
+	}
+
 	new = nfs_create_request(desc->ctx, page, 0, aligned_len);
 	if (IS_ERR(new))
 		goto out_error;
@@ -320,6 +326,7 @@ readpage_async_filler(void *data, struct page *page)
 	return 0;
 out_error:
 	error = PTR_ERR(new);
+out_unlock:
 	unlock_page(page);
 out:
 	return error;
@@ -366,12 +373,6 @@ int nfs_readpage(struct file *file, struct page *page)
 		desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
 
 	xchg(&desc.ctx->error, 0);
-	if (!IS_SYNC(inode)) {
-		ret = nfs_readpage_from_fscache(desc.ctx, inode, page);
-		if (ret == 0)
-			goto out_wait;
-	}
-
 	nfs_pageio_init_read(&desc.pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
@@ -381,7 +382,6 @@ int nfs_readpage(struct file *file, struct page *page)
 
 	nfs_pageio_complete_read(&desc.pgio);
 	ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
-out_wait:
 	if (!ret) {
 		ret = wait_on_page_locked_killable(page);
 		if (!PageUptodate(page) && !ret)
@@ -419,14 +419,6 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
 	} else
 		desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
 
-	/* attempt to read as many of the pages as possible from the cache
-	 * - this returns -ENOBUFS immediately if the cookie is negative
-	 */
-	ret = nfs_readpages_from_fscache(desc.ctx, inode, mapping,
-					 pages, &nr_pages);
-	if (ret == 0)
-		goto read_complete; /* all pages were read */
-
 	nfs_pageio_init_read(&desc.pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
@@ -434,7 +426,6 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
 
 	nfs_pageio_complete_read(&desc.pgio);
 
-read_complete:
 	put_nfs_open_context(desc.ctx);
 out:
 	trace_nfs_aop_readahead_done(inode, nr_pages, ret);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2b322170372a..987a187bd39a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2126,8 +2126,11 @@ int nfs_migrate_page(struct address_space *mapping, struct page *newpage,
 	if (PagePrivate(page))
 		return -EBUSY;
 
-	if (!nfs_fscache_release_page(page, GFP_KERNEL))
-		return -EBUSY;
+	if (PageFsCache(page)) {
+		if (mode == MIGRATE_ASYNC)
+			return -EBUSY;
+		wait_on_page_fscache(page);
+	}
 
 	return migrate_page(mapping, newpage, page, mode);
 }
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index b38d233c9fad..b28bedee28d9 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -165,6 +165,7 @@ extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_resize_cookie(struct fscache_cookie *, loff_t);
 extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t, unsigned int);
 extern int __fscache_begin_read_operation(struct netfs_cache_resources *, struct fscache_cookie *);
+extern int __fscache_begin_write_operation(struct netfs_cache_resources *, struct fscache_cookie *);
 
 extern void __fscache_write_to_cache(struct fscache_cookie *, struct address_space *,
 				     loff_t, size_t, loff_t, netfs_io_terminated_t, void *,
@@ -493,6 +494,33 @@ int fscache_read(struct netfs_cache_resources *cres,
 			 term_func, term_func_priv);
 }
 
+/**
+ * fscache_begin_write_operation - Begin a write operation for the netfs lib
+ * @cres: The cache resources for the write being performed
+ * @cookie: The cookie representing the cache object
+ *
+ * Begin a write operation on behalf of the netfs helper library.  @cres
+ * indicates the cache resources to which the operation state should be
+ * attached; @cookie indicates the cache object that will be accessed.
+ *
+ * @cres->inval_counter is set from @cookie->inval_counter for comparison at
+ * the end of the operation.  This allows invalidation during the operation to
+ * be detected by the caller.
+ *
+ * Returns:
+ * * 0		- Success
+ * * -ENOBUFS	- No caching available
+ * * Other error code from the cache, such as -ENOMEM.
+ */
+static inline
+int fscache_begin_write_operation(struct netfs_cache_resources *cres,
+				  struct fscache_cookie *cookie)
+{
+	if (fscache_cookie_enabled(cookie))
+		return __fscache_begin_write_operation(cres, cookie);
+	return -ENOBUFS;
+}
+
 /**
  * fscache_write - Start a write to the cache.
  * @cres: The cache resources to use


