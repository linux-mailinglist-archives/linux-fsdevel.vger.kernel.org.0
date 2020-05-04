Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C041C40EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgEDRIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:08:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22152 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730042AbgEDRIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jBA5nnIPJGSbqzD2tNYIz7aJqnkEgQUWxlb0RBvFN0=;
        b=UJLDfsWE0xyzv7qzlfHllPE8lzT0EedeHBGQ4JzVZZGr67VqC1OmjV0j+PGZ8BInqueTpJ
        sFedvqK8pL0zs0vjnYqv90fWAJAbzUL5pCXu6yMCJD6+FVpL97Rm+mma4dkknfW1+6Bi9d
        +pi3W92AIbHOmevuDI+d/NypN+KvzR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-20xCdRigP0e8wQgpbiYjEQ-1; Mon, 04 May 2020 13:08:26 -0400
X-MC-Unique: 20xCdRigP0e8wQgpbiYjEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3AF3107ACF2;
        Mon,  4 May 2020 17:08:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1398362492;
        Mon,  4 May 2020 17:08:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 06/61] afs: Disable use of the fscache I/O routines
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:08:18 +0100
Message-ID: <158861209824.340223.1864211542341758994.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Disable use of the fscache I/O routined by the AFS filesystem.  It's about to
transition to passing iov_iters down and fscache is about to have its I/O path
to use iov_iter, so all that needs to change.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c  |  196 ++++++++++----------------------------------------------
 fs/afs/write.c |   10 ---
 2 files changed, 35 insertions(+), 171 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 8415733f7bc1..f0cca37f2da8 100644
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
 /*
  * Fetch file data from the volume.
  */
@@ -285,89 +267,46 @@ int afs_page_filler(void *data, struct page *page)
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
-		/* fall through */
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
+
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
 
-		SetPageUptodate(page);
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
 
@@ -413,23 +352,10 @@ static int afs_readpage(struct file *file, struct page *page)
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
@@ -488,9 +414,6 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 		index = page->index;
 		if (add_to_page_cache_lru(page, mapping, index,
 					  readahead_gfp_mask(mapping))) {
-#ifdef CONFIG_AFS_FSCACHE
-			fscache_uncache_page(vnode->cache, page);
-#endif
 			put_page(page);
 			break;
 		}
@@ -523,9 +446,6 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 	for (i = 0; i < req->nr_pages; i++) {
 		page = req->pages[i];
 		if (page) {
-#ifdef CONFIG_AFS_FSCACHE
-			fscache_uncache_page(vnode->cache, page);
-#endif
 			SetPageError(page);
 			unlock_page(page);
 		}
@@ -557,37 +477,6 @@ static int afs_readpages(struct file *file, struct address_space *mapping,
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
@@ -615,14 +504,6 @@ static void afs_invalidatepage(struct page *page, unsigned int offset,
 
 	/* we clean up only if the entire page is being invalidated */
 	if (offset == 0 && length == PAGE_SIZE) {
-#ifdef CONFIG_AFS_FSCACHE
-		if (PageFsCache(page)) {
-			struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
-			fscache_wait_on_page_write(vnode->cache, page);
-			fscache_uncache_page(vnode->cache, page);
-		}
-#endif
-
 		if (PagePrivate(page)) {
 			priv = page_private(page);
 			trace_afs_page_dirty(vnode, tracepoint_string("inval"),
@@ -650,13 +531,6 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 
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
 		priv = page_private(page);
 		trace_afs_page_dirty(vnode, tracepoint_string("rel"),
diff --git a/fs/afs/write.c b/fs/afs/write.c
index cb76566763db..25786237485a 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -788,9 +788,6 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	/* Wait for the page to be written to the cache before we allow it to
 	 * be modified.  We then assume the entire page will need writing back.
 	 */
-#ifdef CONFIG_AFS_FSCACHE
-	fscache_wait_on_page_write(vnode->cache, vmf->page);
-#endif
 
 	if (PageWriteback(vmf->page) &&
 	    wait_on_page_bit_killable(vmf->page, PG_writeback) < 0)
@@ -875,12 +872,5 @@ int afs_launder_page(struct page *page)
 			     page->index, priv);
 	set_page_private(page, 0);
 	ClearPagePrivate(page);
-
-#ifdef CONFIG_AFS_FSCACHE
-	if (PageFsCache(page)) {
-		fscache_wait_on_page_write(vnode->cache, page);
-		fscache_uncache_page(vnode->cache, page);
-	}
-#endif
 	return ret;
 }


