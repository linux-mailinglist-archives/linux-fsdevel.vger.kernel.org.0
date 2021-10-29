Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E0943FE0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 16:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhJ2ONR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 10:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231894AbhJ2OM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635516629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXx3uIfKth8YmI86LHJ8fNbU60gPN+WghMFTv2Km9ww=;
        b=NoPIugM2X8d7EuhHEgcDHBC3s0gmo8mD/Tr1i4u7bj/mvuuc4K9xRqtduVxhaYxo1w502U
        kNmKYqQUTU59PzD5wUbSDz99AuqM/iMNtVZb/ZFrI+IosN1gtrx6kuy01nO03aSIJJKJZG
        7R8EGPS8fbmWm1+eHI/i7o7+lSmmjGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-yOIQWFPLOfeuRll1t2QShw-1; Fri, 29 Oct 2021 10:10:25 -0400
X-MC-Unique: yOIQWFPLOfeuRll1t2QShw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8590C802B61;
        Fri, 29 Oct 2021 14:10:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05288810A4;
        Fri, 29 Oct 2021 14:10:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 05/10] nfs: Move to using the alternate fallback fscache
 I/O API
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 29 Oct 2021 15:10:19 +0100
Message-ID: <163551661912.1877519.8649368675533788865.stgit@warthog.procyon.org.uk>
In-Reply-To: <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk>
References: <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move NFS to using the alternate fallback fscache I/O API instead of the old
upstream I/O API as that is about to be deleted.  The alternate API will
also be deleted at some point in the future as it's dangerous (as is the
old API) and can lead to data corruption if the backing filesystem can
insert/remove bridging blocks of zeros into its extent list[1].

The alternate API reads and writes pages synchronously, with the intention
of allowing removal of the operation management framework and thence the
object management framework from fscache.

The preferred change would be to use the netfs lib, but the new I/O API can
be used directly.  It's just that as the cache now needs to track data for
itself, caching blocks may exceed page size...

Changes
=======
ver #3:
  - Merged and adjusted a fix from Dave Wysochanski[3] so as not to return 1
    from the nfs cache readpage(s) functions.

ver #2:
  - Changed "deprecated" to "fallback" in the new function names[2].

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Dave Wysochanski <dwysocha@redhat.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Anna Schumaker <anna.schumaker@netapp.com>
cc: linux-nfs@vger.kernel.org
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/YO17ZNOcq+9PajfQ@mit.edu [1]
Link: https://lore.kernel.org/r/CAHk-=wiVK+1CyEjW8u71zVPK8msea=qPpznX35gnX+s8sXnJTg@mail.gmail.com/ [2]
Link: https://listman.redhat.com/archives/linux-cachefs/2021-October/msg00011.html [3]
Link: https://lore.kernel.org/r/163162771421.438332.11563297618174948818.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/163189108292.2509237.12615909591150927232.stgit@warthog.procyon.org.uk/ # rfc v2
---

 fs/nfs/file.c    |   14 +++-
 fs/nfs/fscache.c |  170 ++++++------------------------------------------------
 fs/nfs/fscache.h |   85 ++++-----------------------
 fs/nfs/read.c    |   25 +++-----
 fs/nfs/write.c   |    7 ++
 5 files changed, 52 insertions(+), 249 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index aa353fd58240..209dac208477 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -416,7 +416,7 @@ static void nfs_invalidate_page(struct page *page, unsigned int offset,
 	/* Cancel any unstarted writes on this page */
 	nfs_wb_page_cancel(page_file_mapping(page)->host, page);
 
-	nfs_fscache_invalidate_page(page, page->mapping->host);
+	wait_on_page_fscache(page);
 }
 
 /*
@@ -432,7 +432,12 @@ static int nfs_release_page(struct page *page, gfp_t gfp)
 	/* If PagePrivate() is set, then the page is not freeable */
 	if (PagePrivate(page))
 		return 0;
-	return nfs_fscache_release_page(page, gfp);
+	if (PageFsCache(page)) {
+		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
+			return false;
+		wait_on_page_fscache(page);
+	}
+	return true;
 }
 
 static void nfs_check_dirty_writeback(struct page *page,
@@ -475,12 +480,11 @@ static void nfs_check_dirty_writeback(struct page *page,
 static int nfs_launder_page(struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
-	struct nfs_inode *nfsi = NFS_I(inode);
 
 	dfprintk(PAGECACHE, "NFS: launder_page(%ld, %llu)\n",
 		inode->i_ino, (long long)page_offset(page));
 
-	nfs_fscache_wait_on_page_write(nfsi, page);
+	wait_on_page_fscache(page);
 	return nfs_wb_page(inode, page);
 }
 
@@ -555,7 +559,7 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 
 	/* make sure the cache has finished storing the page */
-	nfs_fscache_wait_on_page_write(NFS_I(inode), page);
+	wait_on_page_fscache(page);
 
 	wait_on_bit_action(&NFS_I(inode)->flags, NFS_INO_INVALIDATING,
 			nfs_wait_bit_killable, TASK_KILLABLE);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index d743629e05e1..68e266a37675 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -317,7 +317,6 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
 		clear_bit(NFS_INO_FSCACHE, &nfsi->flags);
 		fscache_disable_cookie(cookie, &auxdata, true);
-		fscache_uncache_all_inode_pages(cookie, inode);
 	} else {
 		dfprintk(FSCACHE, "NFS: nfsi 0x%p enabling cache\n", nfsi);
 		fscache_enable_cookie(cookie, &auxdata, nfsi->vfs_inode.i_size,
@@ -328,79 +327,10 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 }
 EXPORT_SYMBOL_GPL(nfs_fscache_open_file);
 
-/*
- * Release the caching state associated with a page, if the page isn't busy
- * interacting with the cache.
- * - Returns true (can release page) or false (page busy).
- */
-int nfs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	if (PageFsCache(page)) {
-		struct fscache_cookie *cookie = nfs_i_fscache(page->mapping->host);
-
-		BUG_ON(!cookie);
-		dfprintk(FSCACHE, "NFS: fscache releasepage (0x%p/0x%p/0x%p)\n",
-			 cookie, page, NFS_I(page->mapping->host));
-
-		if (!fscache_maybe_release_page(cookie, page, gfp))
-			return 0;
-
-		nfs_inc_fscache_stats(page->mapping->host,
-				      NFSIOS_FSCACHE_PAGES_UNCACHED);
-	}
-
-	return 1;
-}
-
-/*
- * Release the caching state associated with a page if undergoing complete page
- * invalidation.
- */
-void __nfs_fscache_invalidate_page(struct page *page, struct inode *inode)
-{
-	struct fscache_cookie *cookie = nfs_i_fscache(inode);
-
-	BUG_ON(!cookie);
-
-	dfprintk(FSCACHE, "NFS: fscache invalidatepage (0x%p/0x%p/0x%p)\n",
-		 cookie, page, NFS_I(inode));
-
-	fscache_wait_on_page_write(cookie, page);
-
-	BUG_ON(!PageLocked(page));
-	fscache_uncache_page(cookie, page);
-	nfs_inc_fscache_stats(page->mapping->host,
-			      NFSIOS_FSCACHE_PAGES_UNCACHED);
-}
-
-/*
- * Handle completion of a page being read from the cache.
- * - Called in process (keventd) context.
- */
-static void nfs_readpage_from_fscache_complete(struct page *page,
-					       void *context,
-					       int error)
-{
-	dfprintk(FSCACHE,
-		 "NFS: readpage_from_fscache_complete (0x%p/0x%p/%d)\n",
-		 page, context, error);
-
-	/*
-	 * If the read completes with an error, mark the page with PG_checked,
-	 * unlock the page, and let the VM reissue the readpage.
-	 */
-	if (!error)
-		SetPageUptodate(page);
-	else
-		SetPageChecked(page);
-	unlock_page(page);
-}
-
 /*
  * Retrieve a page from fscache
  */
-int __nfs_readpage_from_fscache(struct nfs_open_context *ctx,
-				struct inode *inode, struct page *page)
+int __nfs_readpage_from_fscache(struct inode *inode, struct page *page)
 {
 	int ret;
 
@@ -409,112 +339,48 @@ int __nfs_readpage_from_fscache(struct nfs_open_context *ctx,
 		 nfs_i_fscache(inode), page, page->index, page->flags, inode);
 
 	if (PageChecked(page)) {
+		dfprintk(FSCACHE, "NFS:    readpage_from_fscache: PageChecked\n");
 		ClearPageChecked(page);
 		return 1;
 	}
 
-	ret = fscache_read_or_alloc_page(nfs_i_fscache(inode),
-					 page,
-					 nfs_readpage_from_fscache_complete,
-					 ctx,
-					 GFP_KERNEL);
-
-	switch (ret) {
-	case 0: /* read BIO submitted (page in fscache) */
-		dfprintk(FSCACHE,
-			 "NFS:    readpage_from_fscache: BIO submitted\n");
-		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
-		return ret;
-
-	case -ENOBUFS: /* inode not in cache */
-	case -ENODATA: /* page not in cache */
+	ret = fscache_fallback_read_page(nfs_i_fscache(inode), page);
+	if (ret < 0) {
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
 		dfprintk(FSCACHE,
-			 "NFS:    readpage_from_fscache %d\n", ret);
-		return 1;
-
-	default:
-		dfprintk(FSCACHE, "NFS:    readpage_from_fscache %d\n", ret);
-		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL);
-	}
-	return ret;
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
-	unsigned npages = *nr_pages;
-	int ret;
-
-	dfprintk(FSCACHE, "NFS: nfs_getpages_from_fscache (0x%p/%u/0x%p)\n",
-		 nfs_i_fscache(inode), npages, inode);
-
-	ret = fscache_read_or_alloc_pages(nfs_i_fscache(inode),
-					  mapping, pages, nr_pages,
-					  nfs_readpage_from_fscache_complete,
-					  ctx,
-					  mapping_gfp_mask(mapping));
-	if (*nr_pages < npages)
-		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK,
-				      npages);
-	if (*nr_pages > 0)
-		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL,
-				      *nr_pages);
-
-	switch (ret) {
-	case 0: /* read submitted to the cache for all pages */
-		BUG_ON(!list_empty(pages));
-		BUG_ON(*nr_pages != 0);
-		dfprintk(FSCACHE,
-			 "NFS: nfs_getpages_from_fscache: submitted\n");
-
+			 "NFS:    readpage_from_fscache failed %d\n", ret);
+		SetPageChecked(page);
 		return ret;
-
-	case -ENOBUFS: /* some pages aren't cached and can't be */
-	case -ENODATA: /* some pages aren't cached */
-		dfprintk(FSCACHE,
-			 "NFS: nfs_getpages_from_fscache: no page: %d\n", ret);
-		return 1;
-
-	default:
-		dfprintk(FSCACHE,
-			 "NFS: nfs_getpages_from_fscache: ret  %d\n", ret);
 	}
 
-	return ret;
+	/* Read completed synchronously */
+	dfprintk(FSCACHE, "NFS:    readpage_from_fscache: read successful\n");
+	nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK);
+	SetPageUptodate(page);
+	return 0;
 }
 
 /*
  * Store a newly fetched page in fscache
- * - PG_fscache must be set on the page
  */
-void __nfs_readpage_to_fscache(struct inode *inode, struct page *page, int sync)
+void __nfs_readpage_to_fscache(struct inode *inode, struct page *page)
 {
 	int ret;
 
 	dfprintk(FSCACHE,
-		 "NFS: readpage_to_fscache(fsc:%p/p:%p(i:%lx f:%lx)/%d)\n",
-		 nfs_i_fscache(inode), page, page->index, page->flags, sync);
+		 "NFS: readpage_to_fscache(fsc:%p/p:%p(i:%lx f:%lx))\n",
+		 nfs_i_fscache(inode), page, page->index, page->flags);
+
+	ret = fscache_fallback_write_page(nfs_i_fscache(inode), page);
 
-	ret = fscache_write_page(nfs_i_fscache(inode), page,
-				 inode->i_size, GFP_KERNEL);
 	dfprintk(FSCACHE,
 		 "NFS:     readpage_to_fscache: p:%p(i:%lu f:%lx) ret %d\n",
 		 page, page->index, page->flags, ret);
 
 	if (ret != 0) {
-		fscache_uncache_page(nfs_i_fscache(inode), page);
-		nfs_inc_fscache_stats(inode,
-				      NFSIOS_FSCACHE_PAGES_WRITTEN_FAIL);
+		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_WRITTEN_FAIL);
 		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_UNCACHED);
 	} else {
-		nfs_inc_fscache_stats(inode,
-				      NFSIOS_FSCACHE_PAGES_WRITTEN_OK);
+		nfs_inc_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_WRITTEN_OK);
 	}
 }
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 6118cdd2e1d7..679055720dae 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -11,7 +11,7 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
-#define FSCACHE_USE_OLD_IO_API
+#define FSCACHE_USE_FALLBACK_IO_API
 #include <linux/fscache.h>
 
 #ifdef CONFIG_NFS_FSCACHE
@@ -94,61 +94,19 @@ extern void nfs_fscache_init_inode(struct inode *);
 extern void nfs_fscache_clear_inode(struct inode *);
 extern void nfs_fscache_open_file(struct inode *, struct file *);
 
-extern void __nfs_fscache_invalidate_page(struct page *, struct inode *);
-extern int nfs_fscache_release_page(struct page *, gfp_t);
-
-extern int __nfs_readpage_from_fscache(struct nfs_open_context *,
-				       struct inode *, struct page *);
-extern int __nfs_readpages_from_fscache(struct nfs_open_context *,
-					struct inode *, struct address_space *,
-					struct list_head *, unsigned *);
-extern void __nfs_readpage_to_fscache(struct inode *, struct page *, int);
-
-/*
- * wait for a page to complete writing to the cache
- */
-static inline void nfs_fscache_wait_on_page_write(struct nfs_inode *nfsi,
-						  struct page *page)
-{
-	if (PageFsCache(page))
-		fscache_wait_on_page_write(nfsi->fscache, page);
-}
-
-/*
- * release the caching state associated with a page if undergoing complete page
- * invalidation
- */
-static inline void nfs_fscache_invalidate_page(struct page *page,
-					       struct inode *inode)
-{
-	if (PageFsCache(page))
-		__nfs_fscache_invalidate_page(page, inode);
-}
+extern int __nfs_readpage_from_fscache(struct inode *, struct page *);
+extern void __nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
+					     unsigned long bytes);
+extern void __nfs_readpage_to_fscache(struct inode *, struct page *);
 
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
 
@@ -157,11 +115,10 @@ static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
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
 
 /*
@@ -204,31 +161,13 @@ static inline void nfs_fscache_clear_inode(struct inode *inode) {}
 static inline void nfs_fscache_open_file(struct inode *inode,
 					 struct file *filp) {}
 
-static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	return 1; /* True: may release page */
-}
-static inline void nfs_fscache_invalidate_page(struct page *page,
-					       struct inode *inode) {}
-static inline void nfs_fscache_wait_on_page_write(struct nfs_inode *nfsi,
-						  struct page *page) {}
-
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
 
 
 static inline void nfs_fscache_invalidate(struct inode *inode) {}
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 08d6cc57cbc3..06ed827a67e8 100644
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
@@ -367,12 +374,6 @@ int nfs_readpage(struct file *file, struct page *page)
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
 
@@ -382,7 +383,6 @@ int nfs_readpage(struct file *file, struct page *page)
 
 	nfs_pageio_complete_read(&desc.pgio);
 	ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
-out_wait:
 	if (!ret) {
 		ret = wait_on_page_locked_killable(page);
 		if (!PageUptodate(page) && !ret)
@@ -421,14 +421,6 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
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
 
@@ -436,7 +428,6 @@ int nfs_readpages(struct file *file, struct address_space *mapping,
 
 	nfs_pageio_complete_read(&desc.pgio);
 
-read_complete:
 	put_nfs_open_context(desc.ctx);
 out:
 	return ret;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index eae9bf114041..466266a96b2a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2124,8 +2124,11 @@ int nfs_migrate_page(struct address_space *mapping, struct page *newpage,
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


