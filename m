Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D134619E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378774AbhK2Omd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:42:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379055AbhK2Okb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638196633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cSor2yiOje7FQnD5rZ1twNF/X0kMwOwMyNXIJ1sohrs=;
        b=AgtDhhyCmLU8YeZuTolCM7c7iNY+vHQPzGIiju6t9hRUp1SSlawrRO7wuFFItpXFiPDF6X
        mPbYWwc2ckiLOouZdgDbGRZz3uh2VDLL4LXay8rEOQgjQCIU68qdMzaomeZxSzF6djxYVz
        sUPLfVeCyfCph0lm3Ws3WMIl1GkYzO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-D4SD-mpsOtqPA2nNRv7l3A-1; Mon, 29 Nov 2021 09:37:09 -0500
X-MC-Unique: D4SD-mpsOtqPA2nNRv7l3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 823E8839A43;
        Mon, 29 Nov 2021 14:37:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28C4C60854;
        Mon, 29 Nov 2021 14:37:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 58/64] afs: Copy local writes to the cache when writing to the
 server
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 14:37:03 +0000
Message-ID: <163819662333.215744.7531373404219224438.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When writing to the server from afs_writepage() or afs_writepages(), copy
the data to the cache object too.

To make this possible, the cookie must have its active users count
incremented when the page is dirtied and kept incremented until we manage
to clean up all the pages.  This allows the writeback to take place after
the last file struct is released.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
---

 fs/afs/file.c     |    6 ++++
 fs/afs/inode.c    |    8 +++--
 fs/afs/internal.h |    5 +++
 fs/afs/super.c    |    1 +
 fs/afs/write.c    |   87 ++++++++++++++++++++++++++++++++++++++++++++++-------
 5 files changed, 92 insertions(+), 15 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 0a6cb1e3c28f..2272a6be9c9f 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -416,6 +416,12 @@ static void afs_readahead(struct readahead_control *ractl)
 	netfs_readahead(ractl, &afs_req_ops, NULL);
 }
 
+int afs_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	fscache_unpin_writeback(wbc, afs_vnode_cache(AFS_FS_I(inode)));
+	return 0;
+}
+
 /*
  * Adjust the dirty region of the page on truncation or full invalidation,
  * getting rid of the markers altogether if the region is entirely invalidated.
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 509208825907..8db902405031 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -761,9 +761,8 @@ int afs_drop_inode(struct inode *inode)
  */
 void afs_evict_inode(struct inode *inode)
 {
-	struct afs_vnode *vnode;
-
-	vnode = AFS_FS_I(inode);
+	struct afs_vnode_cache_aux aux;
+	struct afs_vnode *vnode = AFS_FS_I(inode);
 
 	_enter("{%llx:%llu.%d}",
 	       vnode->fid.vid,
@@ -775,6 +774,9 @@ void afs_evict_inode(struct inode *inode)
 	ASSERTCMP(inode->i_ino, ==, vnode->fid.vnode);
 
 	truncate_inode_pages_final(&inode->i_data);
+
+	afs_set_cache_aux(vnode, &aux);
+	fscache_clear_inode_writeback(afs_vnode_cache(vnode), inode, &aux);
 	clear_inode(inode);
 
 	while (!list_empty(&vnode->wb_keys)) {
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index e46b31c1b6d4..0dd15de57be9 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1072,6 +1072,7 @@ extern int afs_release(struct inode *, struct file *);
 extern int afs_fetch_data(struct afs_vnode *, struct afs_read *);
 extern struct afs_read *afs_alloc_read(gfp_t);
 extern void afs_put_read(struct afs_read *);
+extern int afs_write_inode(struct inode *, struct writeback_control *);
 
 static inline struct afs_read *afs_get_read(struct afs_read *req)
 {
@@ -1519,7 +1520,11 @@ extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
 /*
  * write.c
  */
+#ifdef CONFIG_AFS_FSCACHE
 extern int afs_set_page_dirty(struct page *);
+#else
+#define afs_set_page_dirty __set_page_dirty_nobuffers
+#endif
 extern int afs_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,
 			struct page **pagep, void **fsdata);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index d110def8aa8e..af7cbd9949c5 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -55,6 +55,7 @@ int afs_net_id;
 static const struct super_operations afs_super_ops = {
 	.statfs		= afs_statfs,
 	.alloc_inode	= afs_alloc_inode,
+	.write_inode	= afs_write_inode,
 	.drop_inode	= afs_drop_inode,
 	.destroy_inode	= afs_destroy_inode,
 	.free_inode	= afs_free_inode,
diff --git a/fs/afs/write.c b/fs/afs/write.c
index ac1341af31e9..e186a3432999 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -14,14 +14,28 @@
 #include <linux/netfs.h>
 #include "internal.h"
 
+static void afs_write_to_cache(struct afs_vnode *vnode, loff_t start, size_t len,
+			       loff_t i_size, bool caching);
+
+#ifdef CONFIG_AFS_FSCACHE
 /*
- * mark a page as having been made dirty and thus needing writeback
+ * Mark a page as having been made dirty and thus needing writeback.  We also
+ * need to pin the cache object to write back to.
  */
 int afs_set_page_dirty(struct page *page)
 {
-	_enter("");
-	return __set_page_dirty_nobuffers(page);
+	return fscache_set_page_dirty(page, afs_vnode_cache(AFS_FS_I(page->mapping->host)));
+}
+static void afs_folio_start_fscache(bool caching, struct folio *folio)
+{
+	if (caching)
+		folio_start_fscache(folio);
+}
+#else
+static void afs_folio_start_fscache(bool caching, struct folio *folio)
+{
 }
+#endif
 
 /*
  * Prepare to perform part of a write to a page.  Note that len may extend
@@ -114,7 +128,7 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 	unsigned long priv;
 	unsigned int f, from = offset_in_folio(folio, pos);
 	unsigned int t, to = from + copied;
-	loff_t i_size, maybe_i_size;
+	loff_t i_size, write_end_pos;
 
 	_enter("{%llx:%llu},{%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, folio_index(folio));
@@ -132,15 +146,16 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 	if (copied == 0)
 		goto out;
 
-	maybe_i_size = pos + copied;
+	write_end_pos = pos + copied;
 
 	i_size = i_size_read(&vnode->vfs_inode);
-	if (maybe_i_size > i_size) {
+	if (write_end_pos > i_size) {
 		write_seqlock(&vnode->cb_lock);
 		i_size = i_size_read(&vnode->vfs_inode);
-		if (maybe_i_size > i_size)
-			afs_set_i_size(vnode, maybe_i_size);
+		if (write_end_pos > i_size)
+			afs_set_i_size(vnode, write_end_pos);
 		write_sequnlock(&vnode->cb_lock);
+		fscache_update_cookie(afs_vnode_cache(vnode), NULL, &write_end_pos);
 	}
 
 	if (folio_test_private(folio)) {
@@ -419,6 +434,7 @@ static void afs_extend_writeback(struct address_space *mapping,
 				 loff_t start,
 				 loff_t max_len,
 				 bool new_content,
+				 bool caching,
 				 unsigned int *_len)
 {
 	struct pagevec pvec;
@@ -465,7 +481,9 @@ static void afs_extend_writeback(struct address_space *mapping,
 				folio_put(folio);
 				break;
 			}
-			if (!folio_test_dirty(folio) || folio_test_writeback(folio)) {
+			if (!folio_test_dirty(folio) ||
+			    folio_test_writeback(folio) ||
+			    folio_test_fscache(folio)) {
 				folio_unlock(folio);
 				folio_put(folio);
 				break;
@@ -513,6 +531,7 @@ static void afs_extend_writeback(struct address_space *mapping,
 				BUG();
 			if (folio_start_writeback(folio))
 				BUG();
+			afs_folio_start_fscache(caching, folio);
 
 			*_count -= folio_nr_pages(folio);
 			folio_unlock(folio);
@@ -540,6 +559,7 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
 	unsigned int offset, to, len, max_len;
 	loff_t i_size = i_size_read(&vnode->vfs_inode);
 	bool new_content = test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
+	bool caching = fscache_cookie_enabled(afs_vnode_cache(vnode));
 	long count = wbc->nr_to_write;
 	int ret;
 
@@ -547,6 +567,7 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
 
 	if (folio_start_writeback(folio))
 		BUG();
+	afs_folio_start_fscache(caching, folio);
 
 	count -= folio_nr_pages(folio);
 
@@ -573,7 +594,8 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
 		if (len < max_len &&
 		    (to == folio_size(folio) || new_content))
 			afs_extend_writeback(mapping, vnode, &count,
-					     start, max_len, new_content, &len);
+					     start, max_len, new_content,
+					     caching, &len);
 		len = min_t(loff_t, len, max_len);
 	}
 
@@ -586,12 +608,19 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
 	if (start < i_size) {
 		_debug("write back %x @%llx [%llx]", len, start, i_size);
 
+		/* Speculatively write to the cache.  We have to fix this up
+		 * later if the store fails.
+		 */
+		afs_write_to_cache(vnode, start, len, i_size, caching);
+
 		iov_iter_xarray(&iter, WRITE, &mapping->i_pages, start, len);
 		ret = afs_store_data(vnode, &iter, start, false);
 	} else {
 		_debug("write discard %x @%llx [%llx]", len, start, i_size);
 
 		/* The dirty region was entirely beyond the EOF. */
+		fscache_clear_page_bits(afs_vnode_cache(vnode),
+					mapping, start, len, caching);
 		afs_pages_written_back(vnode, start, len);
 		ret = 0;
 	}
@@ -650,6 +679,10 @@ int afs_writepage(struct page *subpage, struct writeback_control *wbc)
 
 	_enter("{%lx},", folio_index(folio));
 
+#ifdef CONFIG_AFS_FSCACHE
+	folio_wait_fscache(folio);
+#endif
+
 	start = folio_index(folio) * PAGE_SIZE;
 	ret = afs_write_back_from_locked_folio(folio_mapping(folio), wbc,
 					       folio, start, LLONG_MAX - start);
@@ -715,10 +748,15 @@ static int afs_writepages_region(struct address_space *mapping,
 			continue;
 		}
 
-		if (folio_test_writeback(folio)) {
+		if (folio_test_writeback(folio) ||
+		    folio_test_fscache(folio)) {
 			folio_unlock(folio);
-			if (wbc->sync_mode != WB_SYNC_NONE)
+			if (wbc->sync_mode != WB_SYNC_NONE) {
 				folio_wait_writeback(folio);
+#ifdef CONFIG_AFS_FSCACHE
+				folio_wait_fscache(folio);
+#endif
+			}
 			folio_put(folio);
 			continue;
 		}
@@ -971,3 +1009,28 @@ int afs_launder_page(struct page *subpage)
 	folio_wait_fscache(folio);
 	return ret;
 }
+
+/*
+ * Deal with the completion of writing the data to the cache.
+ */
+static void afs_write_to_cache_done(void *priv, ssize_t transferred_or_error,
+				    bool was_async)
+{
+	struct afs_vnode *vnode = priv;
+
+	if (IS_ERR_VALUE(transferred_or_error) &&
+	    transferred_or_error != -ENOBUFS)
+		afs_invalidate_cache(vnode, 0);
+}
+
+/*
+ * Save the write to the cache also.
+ */
+static void afs_write_to_cache(struct afs_vnode *vnode,
+			       loff_t start, size_t len, loff_t i_size,
+			       bool caching)
+{
+	fscache_write_to_cache(afs_vnode_cache(vnode),
+			       vnode->vfs_inode.i_mapping, start, len, i_size,
+			       afs_write_to_cache_done, vnode, caching);
+}


