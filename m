Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB2B369384
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbhDWNde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243137AbhDWNdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619184748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PM9ZncdqC47b4nvQeIHvIY2G/pNRrTmGXUik2M2kEJY=;
        b=QGk4KtbazyWkvNAQTPcaKxGmjrHB8c7U088ltHMxULMc8sia9HU5OS8lIi5FU0RnJBuZ6d
        l+IMjtc++8eIZ0v9uCZH45Tk3DcIc4O4r2V87Zn9SMlEsKUWBPLhO2JUl2flo9kCKDNlbm
        gwFlD6wjLyfPeDyQBnz7cCQ3UpM35Ig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-NS_Wb76ENXKj4RtUTONxdA-1; Fri, 23 Apr 2021 09:32:18 -0400
X-MC-Unique: NS_Wb76ENXKj4RtUTONxdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA08487A840;
        Fri, 23 Apr 2021 13:32:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 888FA3A47;
        Fri, 23 Apr 2021 13:32:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v7 18/31] afs: Disable use of the fscache I/O routines
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 23 Apr 2021 14:32:02 +0100
Message-ID: <161918472275.3145707.16721613179279697086.stgit@warthog.procyon.org.uk>
In-Reply-To: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
References: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Disable use of the fscache I/O routined by the AFS filesystem.  It's about
to transition to passing iov_iters down and fscache is about to have its
I/O path to use iov_iter, so all that needs to change.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-By: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/158861209824.340223.1864211542341758994.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/159465768717.1376105.2229314852486665807.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/160588457929.3465195.1730097418904945578.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161118143744.1232039.2727898205333669064.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161039077.2537118.7986870854927176905.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340403323.1303470.8159439948319423431.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539547167.286939.3536238932531122332.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/161653802797.2770958.547311814861545911.stgit@warthog.procyon.org.uk/ # v5
Link: https://lore.kernel.org/r/161789085806.6155.2596146255056027428.stgit@warthog.procyon.org.uk/ # v6
---

 fs/afs/file.c  |  199 ++++++++++----------------------------------------------
 fs/afs/inode.c |    2 -
 fs/afs/write.c |   10 ---
 3 files changed, 36 insertions(+), 175 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 960b64268623..314f6a9517c7 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -202,24 +202,6 @@ void afs_put_read(struct afs_read *req)
 	}
 }
 
-#ifdef CONFIG_AFS_FSCACHE
-/*
- * deal with notification that a page was read from the cache
- */
-static void afs_file_readpage_read_complete(struct page *page,
-					    void *data,
-					    int error)
-{
-	_enter("%p,%p,%d", page, data, error);
-
-	/* if the read completes with an error, we just unlock the page and let
-	 * the VM reissue the readpage */
-	if (!error)
-		SetPageUptodate(page);
-	unlock_page(page);
-}
-#endif
-
 static void afs_fetch_data_success(struct afs_operation *op)
 {
 	struct afs_vnode *vnode = op->file[0].vnode;
@@ -287,89 +269,46 @@ int afs_page_filler(void *data, struct page *page)
 	if (test_bit(AFS_VNODE_DELETED, &vnode->flags))
 		goto error;
 
-	/* is it cached? */
-#ifdef CONFIG_AFS_FSCACHE
-	ret = fscache_read_or_alloc_page(vnode->cache,
-					 page,
-					 afs_file_readpage_read_complete,
-					 NULL,
-					 GFP_KERNEL);
-#else
-	ret = -ENOBUFS;
-#endif
-	switch (ret) {
-		/* read BIO submitted (page in cache) */
-	case 0:
-		break;
-
-		/* page not yet cached */
-	case -ENODATA:
-		_debug("cache said ENODATA");
-		goto go_on;
-
-		/* page will not be cached */
-	case -ENOBUFS:
-		_debug("cache said ENOBUFS");
-
-		fallthrough;
-	default:
-	go_on:
-		req = kzalloc(struct_size(req, array, 1), GFP_KERNEL);
-		if (!req)
-			goto enomem;
-
-		/* We request a full page.  If the page is a partial one at the
-		 * end of the file, the server will return a short read and the
-		 * unmarshalling code will clear the unfilled space.
-		 */
-		refcount_set(&req->usage, 1);
-		req->pos = (loff_t)page->index << PAGE_SHIFT;
-		req->len = PAGE_SIZE;
-		req->nr_pages = 1;
-		req->pages = req->array;
-		req->pages[0] = page;
-		get_page(page);
-
-		/* read the contents of the file from the server into the
-		 * page */
-		ret = afs_fetch_data(vnode, key, req);
-		afs_put_read(req);
-
-		if (ret < 0) {
-			if (ret == -ENOENT) {
-				_debug("got NOENT from server"
-				       " - marking file deleted and stale");
-				set_bit(AFS_VNODE_DELETED, &vnode->flags);
-				ret = -ESTALE;
-			}
-
-#ifdef CONFIG_AFS_FSCACHE
-			fscache_uncache_page(vnode->cache, page);
-#endif
-			BUG_ON(PageFsCache(page));
-
-			if (ret == -EINTR ||
-			    ret == -ENOMEM ||
-			    ret == -ERESTARTSYS ||
-			    ret == -EAGAIN)
-				goto error;
-			goto io_error;
-		}
+	req = kzalloc(struct_size(req, array, 1), GFP_KERNEL);
+	if (!req)
+		goto enomem;
 
-		SetPageUptodate(page);
+	/* We request a full page.  If the page is a partial one at the
+	 * end of the file, the server will return a short read and the
+	 * unmarshalling code will clear the unfilled space.
+	 */
+	refcount_set(&req->usage, 1);
+	req->pos = (loff_t)page->index << PAGE_SHIFT;
+	req->len = PAGE_SIZE;
+	req->nr_pages = 1;
+	req->pages = req->array;
+	req->pages[0] = page;
+	get_page(page);
+
+	/* read the contents of the file from the server into the
+	 * page */
+	ret = afs_fetch_data(vnode, key, req);
+	afs_put_read(req);
 
-		/* send the page to the cache */
-#ifdef CONFIG_AFS_FSCACHE
-		if (PageFsCache(page) &&
-		    fscache_write_page(vnode->cache, page, vnode->status.size,
-				       GFP_KERNEL) != 0) {
-			fscache_uncache_page(vnode->cache, page);
-			BUG_ON(PageFsCache(page));
+	if (ret < 0) {
+		if (ret == -ENOENT) {
+			_debug("got NOENT from server"
+			       " - marking file deleted and stale");
+			set_bit(AFS_VNODE_DELETED, &vnode->flags);
+			ret = -ESTALE;
 		}
-#endif
-		unlock_page(page);
+
+		if (ret == -EINTR ||
+		    ret == -ENOMEM ||
+		    ret == -ERESTARTSYS ||
+		    ret == -EAGAIN)
+			goto error;
+		goto io_error;
 	}
 
+	SetPageUptodate(page);
+	unlock_page(page);
+
 	_leave(" = 0");
 	return 0;
 
@@ -415,23 +354,10 @@ static int afs_readpage(struct file *file, struct page *page)
  */
 static void afs_readpages_page_done(struct afs_read *req)
 {
-#ifdef CONFIG_AFS_FSCACHE
-	struct afs_vnode *vnode = req->vnode;
-#endif
 	struct page *page = req->pages[req->index];
 
 	req->pages[req->index] = NULL;
 	SetPageUptodate(page);
-
-	/* send the page to the cache */
-#ifdef CONFIG_AFS_FSCACHE
-	if (PageFsCache(page) &&
-	    fscache_write_page(vnode->cache, page, vnode->status.size,
-			       GFP_KERNEL) != 0) {
-		fscache_uncache_page(vnode->cache, page);
-		BUG_ON(PageFsCache(page));
-	}
-#endif
 	unlock_page(page);
 	put_page(page);
 }
@@ -490,9 +416,6 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 		index = page->index;
 		if (add_to_page_cache_lru(page, mapping, index,
 					  readahead_gfp_mask(mapping))) {
-#ifdef CONFIG_AFS_FSCACHE
-			fscache_uncache_page(vnode->cache, page);
-#endif
 			put_page(page);
 			break;
 		}
@@ -525,9 +448,6 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 	for (i = 0; i < req->nr_pages; i++) {
 		page = req->pages[i];
 		if (page) {
-#ifdef CONFIG_AFS_FSCACHE
-			fscache_uncache_page(vnode->cache, page);
-#endif
 			SetPageError(page);
 			unlock_page(page);
 		}
@@ -559,37 +479,6 @@ static int afs_readpages(struct file *file, struct address_space *mapping,
 	}
 
 	/* attempt to read as many of the pages as possible */
-#ifdef CONFIG_AFS_FSCACHE
-	ret = fscache_read_or_alloc_pages(vnode->cache,
-					  mapping,
-					  pages,
-					  &nr_pages,
-					  afs_file_readpage_read_complete,
-					  NULL,
-					  mapping_gfp_mask(mapping));
-#else
-	ret = -ENOBUFS;
-#endif
-
-	switch (ret) {
-		/* all pages are being read from the cache */
-	case 0:
-		BUG_ON(!list_empty(pages));
-		BUG_ON(nr_pages != 0);
-		_leave(" = 0 [reading all]");
-		return 0;
-
-		/* there were pages that couldn't be read from the cache */
-	case -ENODATA:
-	case -ENOBUFS:
-		break;
-
-		/* other error */
-	default:
-		_leave(" = %d", ret);
-		return ret;
-	}
-
 	while (!list_empty(pages)) {
 		ret = afs_readpages_one(file, mapping, pages);
 		if (ret < 0)
@@ -669,17 +558,6 @@ static void afs_invalidatepage(struct page *page, unsigned int offset,
 
 	BUG_ON(!PageLocked(page));
 
-#ifdef CONFIG_AFS_FSCACHE
-	/* we clean up only if the entire page is being invalidated */
-	if (offset == 0 && length == PAGE_SIZE) {
-		if (PageFsCache(page)) {
-			struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
-			fscache_wait_on_page_write(vnode->cache, page);
-			fscache_uncache_page(vnode->cache, page);
-		}
-	}
-#endif
-
 	if (PagePrivate(page))
 		afs_invalidate_dirty(page, offset, length);
 
@@ -701,13 +579,6 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 
 	/* deny if page is being written to the cache and the caller hasn't
 	 * elected to wait */
-#ifdef CONFIG_AFS_FSCACHE
-	if (!fscache_maybe_release_page(vnode->cache, page, gfp_flags)) {
-		_leave(" = F [cache busy]");
-		return 0;
-	}
-#endif
-
 	if (PagePrivate(page)) {
 		priv = (unsigned long)detach_page_private(page);
 		trace_afs_page_dirty(vnode, tracepoint_string("rel"),
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 12be88716e4c..8de6f05987b4 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -427,7 +427,7 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 	} __packed key;
 	struct afs_vnode_cache_aux aux;
 
-	if (vnode->status.type == AFS_FTYPE_DIR) {
+	if (vnode->status.type != AFS_FTYPE_FILE) {
 		vnode->cache = NULL;
 		return;
 	}
diff --git a/fs/afs/write.c b/fs/afs/write.c
index eb737ed63afb..901bd2ee2dd0 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -847,9 +847,6 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	/* Wait for the page to be written to the cache before we allow it to
 	 * be modified.  We then assume the entire page will need writing back.
 	 */
-#ifdef CONFIG_AFS_FSCACHE
-	fscache_wait_on_page_write(vnode->cache, vmf->page);
-#endif
 
 	if (wait_on_page_writeback_killable(vmf->page))
 		return VM_FAULT_RETRY;
@@ -935,12 +932,5 @@ int afs_launder_page(struct page *page)
 	priv = (unsigned long)detach_page_private(page);
 	trace_afs_page_dirty(vnode, tracepoint_string("laundered"),
 			     page->index, priv);
-
-#ifdef CONFIG_AFS_FSCACHE
-	if (PageFsCache(page)) {
-		fscache_wait_on_page_write(vnode->cache, page);
-		fscache_uncache_page(vnode->cache, page);
-	}
-#endif
 	return ret;
 }


