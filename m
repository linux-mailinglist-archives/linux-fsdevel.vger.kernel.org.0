Return-Path: <linux-fsdevel+bounces-3057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC047EF995
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710C91F271DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCA0482E1;
	Fri, 17 Nov 2023 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cr46nBxp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC7A171A
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700255772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9Y/8lMgWHg32NLiAkA5dht4A8Xbgy35GbV1GQhEufU=;
	b=cr46nBxpMKVGqiW4amjubhpmehiI0cV2qwsaSs9eJ++MD7dDjSdEdAiSiKB3+nzXqhnoRG
	yJccLZvcmgVMECsWbTWA+N2CbX/KJonhZqgiTLUuYG/HBLponoGkBHF2ZtUvmmiY68gqLk
	7qYPXJfV5QneVAiwVgZK9tIOW7PRUMA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-YgL-4DAPNO-E6OutxTZucw-1; Fri,
 17 Nov 2023 16:16:07 -0500
X-MC-Unique: YgL-4DAPNO-E6OutxTZucw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52A3F3C0C129;
	Fri, 17 Nov 2023 21:16:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 96150C15881;
	Fri, 17 Nov 2023 21:16:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/51] afs: Don't use folio->private to record partial modification
Date: Fri, 17 Nov 2023 21:14:57 +0000
Message-ID: <20231117211544.1740466-6-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

AFS currently uses folio->private to store the range of bytes within a
folio that have been modified - the idea being that if we have, say, a 2MiB
folio and someone writes a single byte, we only have to write back that
single page and not the whole 2MiB folio - thereby saving on network
bandwidth.

Remove this, at least for now, and accept the extra network load (which
doesn't matter in the common case of writing a whole file at a time from
beginning to end).

This makes folio->private available for netfslib to use.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/afs/file.c              |  67 -------------
 fs/afs/internal.h          |  56 -----------
 fs/afs/write.c             | 188 ++++++++-----------------------------
 include/trace/events/afs.h |  16 +---
 4 files changed, 42 insertions(+), 285 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index d37dd201752b..0c49b3b6f214 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -405,63 +405,6 @@ int afs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return 0;
 }
 
-/*
- * Adjust the dirty region of the page on truncation or full invalidation,
- * getting rid of the markers altogether if the region is entirely invalidated.
- */
-static void afs_invalidate_dirty(struct folio *folio, size_t offset,
-				 size_t length)
-{
-	struct afs_vnode *vnode = AFS_FS_I(folio_inode(folio));
-	unsigned long priv;
-	unsigned int f, t, end = offset + length;
-
-	priv = (unsigned long)folio_get_private(folio);
-
-	/* we clean up only if the entire page is being invalidated */
-	if (offset == 0 && length == folio_size(folio))
-		goto full_invalidate;
-
-	 /* If the page was dirtied by page_mkwrite(), the PTE stays writable
-	  * and we don't get another notification to tell us to expand it
-	  * again.
-	  */
-	if (afs_is_folio_dirty_mmapped(priv))
-		return;
-
-	/* We may need to shorten the dirty region */
-	f = afs_folio_dirty_from(folio, priv);
-	t = afs_folio_dirty_to(folio, priv);
-
-	if (t <= offset || f >= end)
-		return; /* Doesn't overlap */
-
-	if (f < offset && t > end)
-		return; /* Splits the dirty region - just absorb it */
-
-	if (f >= offset && t <= end)
-		goto undirty;
-
-	if (f < offset)
-		t = offset;
-	else
-		f = end;
-	if (f == t)
-		goto undirty;
-
-	priv = afs_folio_dirty(folio, f, t);
-	folio_change_private(folio, (void *)priv);
-	trace_afs_folio_dirty(vnode, tracepoint_string("trunc"), folio);
-	return;
-
-undirty:
-	trace_afs_folio_dirty(vnode, tracepoint_string("undirty"), folio);
-	folio_clear_dirty_for_io(folio);
-full_invalidate:
-	trace_afs_folio_dirty(vnode, tracepoint_string("inval"), folio);
-	folio_detach_private(folio);
-}
-
 /*
  * invalidate part or all of a page
  * - release a page and clean up its private data if offset is 0 (indicating
@@ -472,11 +415,6 @@ static void afs_invalidate_folio(struct folio *folio, size_t offset,
 {
 	_enter("{%lu},%zu,%zu", folio->index, offset, length);
 
-	BUG_ON(!folio_test_locked(folio));
-
-	if (folio_get_private(folio))
-		afs_invalidate_dirty(folio, offset, length);
-
 	folio_wait_fscache(folio);
 	_leave("");
 }
@@ -504,11 +442,6 @@ static bool afs_release_folio(struct folio *folio, gfp_t gfp)
 	fscache_note_page_release(afs_vnode_cache(vnode));
 #endif
 
-	if (folio_test_private(folio)) {
-		trace_afs_folio_dirty(vnode, tracepoint_string("rel"), folio);
-		folio_detach_private(folio);
-	}
-
 	/* Indicate that the folio can be released */
 	_leave(" = T");
 	return true;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index c9cef3782b4a..0de8d1895832 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -892,62 +892,6 @@ static inline void afs_invalidate_cache(struct afs_vnode *vnode, unsigned int fl
 			   i_size_read(&vnode->netfs.inode), flags);
 }
 
-/*
- * We use folio->private to hold the amount of the folio that we've written to,
- * splitting the field into two parts.  However, we need to represent a range
- * 0...FOLIO_SIZE, so we reduce the resolution if the size of the folio
- * exceeds what we can encode.
- */
-#ifdef CONFIG_64BIT
-#define __AFS_FOLIO_PRIV_MASK		0x7fffffffUL
-#define __AFS_FOLIO_PRIV_SHIFT		32
-#define __AFS_FOLIO_PRIV_MMAPPED	0x80000000UL
-#else
-#define __AFS_FOLIO_PRIV_MASK		0x7fffUL
-#define __AFS_FOLIO_PRIV_SHIFT		16
-#define __AFS_FOLIO_PRIV_MMAPPED	0x8000UL
-#endif
-
-static inline unsigned int afs_folio_dirty_resolution(struct folio *folio)
-{
-	int shift = folio_shift(folio) - (__AFS_FOLIO_PRIV_SHIFT - 1);
-	return (shift > 0) ? shift : 0;
-}
-
-static inline size_t afs_folio_dirty_from(struct folio *folio, unsigned long priv)
-{
-	unsigned long x = priv & __AFS_FOLIO_PRIV_MASK;
-
-	/* The lower bound is inclusive */
-	return x << afs_folio_dirty_resolution(folio);
-}
-
-static inline size_t afs_folio_dirty_to(struct folio *folio, unsigned long priv)
-{
-	unsigned long x = (priv >> __AFS_FOLIO_PRIV_SHIFT) & __AFS_FOLIO_PRIV_MASK;
-
-	/* The upper bound is immediately beyond the region */
-	return (x + 1) << afs_folio_dirty_resolution(folio);
-}
-
-static inline unsigned long afs_folio_dirty(struct folio *folio, size_t from, size_t to)
-{
-	unsigned int res = afs_folio_dirty_resolution(folio);
-	from >>= res;
-	to = (to - 1) >> res;
-	return (to << __AFS_FOLIO_PRIV_SHIFT) | from;
-}
-
-static inline unsigned long afs_folio_dirty_mmapped(unsigned long priv)
-{
-	return priv | __AFS_FOLIO_PRIV_MMAPPED;
-}
-
-static inline bool afs_is_folio_dirty_mmapped(unsigned long priv)
-{
-	return priv & __AFS_FOLIO_PRIV_MMAPPED;
-}
-
 #include <trace/events/afs.h>
 
 /*****************************************************************************/
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 57d05d67f0c2..0fcf48ff009f 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -16,7 +16,8 @@
 
 static int afs_writepages_region(struct address_space *mapping,
 				 struct writeback_control *wbc,
-				 loff_t start, loff_t end, loff_t *_next,
+				 unsigned long long start,
+				 unsigned long long end, loff_t *_next,
 				 bool max_one_loop);
 
 static void afs_write_to_cache(struct afs_vnode *vnode, loff_t start, size_t len,
@@ -43,25 +44,6 @@ static void afs_folio_start_fscache(bool caching, struct folio *folio)
 }
 #endif
 
-/*
- * Flush out a conflicting write.  This may extend the write to the surrounding
- * pages if also dirty and contiguous to the conflicting region..
- */
-static int afs_flush_conflicting_write(struct address_space *mapping,
-				       struct folio *folio)
-{
-	struct writeback_control wbc = {
-		.sync_mode	= WB_SYNC_ALL,
-		.nr_to_write	= LONG_MAX,
-		.range_start	= folio_pos(folio),
-		.range_end	= LLONG_MAX,
-	};
-	loff_t next;
-
-	return afs_writepages_region(mapping, &wbc, folio_pos(folio), LLONG_MAX,
-				     &next, true);
-}
-
 /*
  * prepare to perform part of a write to a page
  */
@@ -71,10 +53,6 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	struct folio *folio;
-	unsigned long priv;
-	unsigned f, from;
-	unsigned t, to;
-	pgoff_t index;
 	int ret;
 
 	_enter("{%llx:%llu},%llx,%x",
@@ -88,49 +66,20 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	if (ret < 0)
 		return ret;
 
-	index = folio_index(folio);
-	from = pos - index * PAGE_SIZE;
-	to = from + len;
-
 try_again:
 	/* See if this page is already partially written in a way that we can
 	 * merge the new write with.
 	 */
-	if (folio_test_private(folio)) {
-		priv = (unsigned long)folio_get_private(folio);
-		f = afs_folio_dirty_from(folio, priv);
-		t = afs_folio_dirty_to(folio, priv);
-		ASSERTCMP(f, <=, t);
-
-		if (folio_test_writeback(folio)) {
-			trace_afs_folio_dirty(vnode, tracepoint_string("alrdy"), folio);
-			folio_unlock(folio);
-			goto wait_for_writeback;
-		}
-		/* If the file is being filled locally, allow inter-write
-		 * spaces to be merged into writes.  If it's not, only write
-		 * back what the user gives us.
-		 */
-		if (!test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags) &&
-		    (to < f || from > t))
-			goto flush_conflicting_write;
+	if (folio_test_writeback(folio)) {
+		trace_afs_folio_dirty(vnode, tracepoint_string("alrdy"), folio);
+		folio_unlock(folio);
+		goto wait_for_writeback;
 	}
 
 	*_page = folio_file_page(folio, pos / PAGE_SIZE);
 	_leave(" = 0");
 	return 0;
 
-	/* The previous write and this write aren't adjacent or overlapping, so
-	 * flush the page out.
-	 */
-flush_conflicting_write:
-	trace_afs_folio_dirty(vnode, tracepoint_string("confl"), folio);
-	folio_unlock(folio);
-
-	ret = afs_flush_conflicting_write(mapping, folio);
-	if (ret < 0)
-		goto error;
-
 wait_for_writeback:
 	ret = folio_wait_writeback_killable(folio);
 	if (ret < 0)
@@ -156,9 +105,6 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 {
 	struct folio *folio = page_folio(subpage);
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
-	unsigned long priv;
-	unsigned int f, from = offset_in_folio(folio, pos);
-	unsigned int t, to = from + copied;
 	loff_t i_size, write_end_pos;
 
 	_enter("{%llx:%llu},{%lx}",
@@ -188,23 +134,6 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 		fscache_update_cookie(afs_vnode_cache(vnode), NULL, &write_end_pos);
 	}
 
-	if (folio_test_private(folio)) {
-		priv = (unsigned long)folio_get_private(folio);
-		f = afs_folio_dirty_from(folio, priv);
-		t = afs_folio_dirty_to(folio, priv);
-		if (from < f)
-			f = from;
-		if (to > t)
-			t = to;
-		priv = afs_folio_dirty(folio, f, t);
-		folio_change_private(folio, (void *)priv);
-		trace_afs_folio_dirty(vnode, tracepoint_string("dirty+"), folio);
-	} else {
-		priv = afs_folio_dirty(folio, from, to);
-		folio_attach_private(folio, (void *)priv);
-		trace_afs_folio_dirty(vnode, tracepoint_string("dirty"), folio);
-	}
-
 	if (folio_mark_dirty(folio))
 		_debug("dirtied %lx", folio_index(folio));
 
@@ -309,7 +238,6 @@ static void afs_pages_written_back(struct afs_vnode *vnode, loff_t start, unsign
 		}
 
 		trace_afs_folio_dirty(vnode, tracepoint_string("clear"), folio);
-		folio_detach_private(folio);
 		folio_end_writeback(folio);
 	}
 
@@ -463,17 +391,12 @@ static void afs_extend_writeback(struct address_space *mapping,
 				 long *_count,
 				 loff_t start,
 				 loff_t max_len,
-				 bool new_content,
 				 bool caching,
-				 unsigned int *_len)
+				 size_t *_len)
 {
 	struct folio_batch fbatch;
 	struct folio *folio;
-	unsigned long priv;
-	unsigned int psize, filler = 0;
-	unsigned int f, t;
-	loff_t len = *_len;
-	pgoff_t index = (start + len) / PAGE_SIZE;
+	pgoff_t index = (start + *_len) / PAGE_SIZE;
 	bool stop = true;
 	unsigned int i;
 
@@ -501,7 +424,7 @@ static void afs_extend_writeback(struct address_space *mapping,
 				continue;
 			}
 
-			/* Has the page moved or been split? */
+			/* Has the folio moved or been split? */
 			if (unlikely(folio != xas_reload(&xas))) {
 				folio_put(folio);
 				break;
@@ -519,24 +442,13 @@ static void afs_extend_writeback(struct address_space *mapping,
 				break;
 			}
 
-			psize = folio_size(folio);
-			priv = (unsigned long)folio_get_private(folio);
-			f = afs_folio_dirty_from(folio, priv);
-			t = afs_folio_dirty_to(folio, priv);
-			if (f != 0 && !new_content) {
-				folio_unlock(folio);
-				folio_put(folio);
-				break;
-			}
-
-			len += filler + t;
-			filler = psize - t;
-			if (len >= max_len || *_count <= 0)
+			index += folio_nr_pages(folio);
+			*_count -= folio_nr_pages(folio);
+			*_len += folio_size(folio);
+			stop = false;
+			if (*_len >= max_len || *_count <= 0)
 				stop = true;
-			else if (t == psize || new_content)
-				stop = false;
 
-			index += folio_nr_pages(folio);
 			if (!folio_batch_add(&fbatch, folio))
 				break;
 			if (stop)
@@ -561,16 +473,12 @@ static void afs_extend_writeback(struct address_space *mapping,
 				BUG();
 			folio_start_writeback(folio);
 			afs_folio_start_fscache(caching, folio);
-
-			*_count -= folio_nr_pages(folio);
 			folio_unlock(folio);
 		}
 
 		folio_batch_release(&fbatch);
 		cond_resched();
 	} while (!stop);
-
-	*_len = len;
 }
 
 /*
@@ -580,14 +488,13 @@ static void afs_extend_writeback(struct address_space *mapping,
 static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
 						struct writeback_control *wbc,
 						struct folio *folio,
-						loff_t start, loff_t end)
+						unsigned long long start,
+						unsigned long long end)
 {
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
 	struct iov_iter iter;
-	unsigned long priv;
-	unsigned int offset, to, len, max_len;
-	loff_t i_size = i_size_read(&vnode->netfs.inode);
-	bool new_content = test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
+	unsigned long long i_size = i_size_read(&vnode->netfs.inode);
+	size_t len, max_len;
 	bool caching = fscache_cookie_enabled(afs_vnode_cache(vnode));
 	long count = wbc->nr_to_write;
 	int ret;
@@ -604,13 +511,9 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
 	 * immediately lockable, is not dirty or is missing, or we reach the
 	 * end of the range.
 	 */
-	priv = (unsigned long)folio_get_private(folio);
-	offset = afs_folio_dirty_from(folio, priv);
-	to = afs_folio_dirty_to(folio, priv);
 	trace_afs_folio_dirty(vnode, tracepoint_string("store"), folio);
 
-	len = to - offset;
-	start += offset;
+	len = folio_size(folio);
 	if (start < i_size) {
 		/* Trim the write to the EOF; the extra data is ignored.  Also
 		 * put an upper limit on the size of a single storedata op.
@@ -619,12 +522,10 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
 		max_len = min_t(unsigned long long, max_len, end - start + 1);
 		max_len = min_t(unsigned long long, max_len, i_size - start);
 
-		if (len < max_len &&
-		    (to == folio_size(folio) || new_content))
+		if (len < max_len)
 			afs_extend_writeback(mapping, vnode, &count,
-					     start, max_len, new_content,
-					     caching, &len);
-		len = min_t(loff_t, len, max_len);
+					     start, max_len, caching, &len);
+		len = min_t(unsigned long long, len, i_size - start);
 	}
 
 	/* We now have a contiguous set of dirty pages, each with writeback
@@ -634,7 +535,7 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
 	folio_unlock(folio);
 
 	if (start < i_size) {
-		_debug("write back %x @%llx [%llx]", len, start, i_size);
+		_debug("write back %zx @%llx [%llx]", len, start, i_size);
 
 		/* Speculatively write to the cache.  We have to fix this up
 		 * later if the store fails.
@@ -644,7 +545,7 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
 		iov_iter_xarray(&iter, ITER_SOURCE, &mapping->i_pages, start, len);
 		ret = afs_store_data(vnode, &iter, start, false);
 	} else {
-		_debug("write discard %x @%llx [%llx]", len, start, i_size);
+		_debug("write discard %zx @%llx [%llx]", len, start, i_size);
 
 		/* The dirty region was entirely beyond the EOF. */
 		fscache_clear_page_bits(mapping, start, len, caching);
@@ -700,7 +601,8 @@ static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
  */
 static int afs_writepages_region(struct address_space *mapping,
 				 struct writeback_control *wbc,
-				 loff_t start, loff_t end, loff_t *_next,
+				 unsigned long long start,
+				 unsigned long long end, loff_t *_next,
 				 bool max_one_loop)
 {
 	struct folio *folio;
@@ -912,7 +814,6 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	struct inode *inode = file_inode(file);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct afs_file *af = file->private_data;
-	unsigned long priv;
 	vm_fault_t ret = VM_FAULT_RETRY;
 
 	_enter("{{%llx:%llu}},{%lx}", vnode->fid.vid, vnode->fid.vnode, folio_index(folio));
@@ -936,24 +837,15 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	if (folio_lock_killable(folio) < 0)
 		goto out;
 
-	/* We mustn't change folio->private until writeback is complete as that
-	 * details the portion of the page we need to write back and we might
-	 * need to redirty the page if there's a problem.
-	 */
 	if (folio_wait_writeback_killable(folio) < 0) {
 		folio_unlock(folio);
 		goto out;
 	}
 
-	priv = afs_folio_dirty(folio, 0, folio_size(folio));
-	priv = afs_folio_dirty_mmapped(priv);
-	if (folio_test_private(folio)) {
-		folio_change_private(folio, (void *)priv);
+	if (folio_test_dirty(folio))
 		trace_afs_folio_dirty(vnode, tracepoint_string("mkwrite+"), folio);
-	} else {
-		folio_attach_private(folio, (void *)priv);
+	else
 		trace_afs_folio_dirty(vnode, tracepoint_string("mkwrite"), folio);
-	}
 	file_update_time(file);
 
 	ret = VM_FAULT_LOCKED;
@@ -998,30 +890,26 @@ int afs_launder_folio(struct folio *folio)
 	struct afs_vnode *vnode = AFS_FS_I(folio_inode(folio));
 	struct iov_iter iter;
 	struct bio_vec bv;
-	unsigned long priv;
-	unsigned int f, t;
+	unsigned long long fend, i_size = vnode->netfs.inode.i_size;
+	size_t len;
 	int ret = 0;
 
 	_enter("{%lx}", folio->index);
 
-	priv = (unsigned long)folio_get_private(folio);
-	if (folio_clear_dirty_for_io(folio)) {
-		f = 0;
-		t = folio_size(folio);
-		if (folio_test_private(folio)) {
-			f = afs_folio_dirty_from(folio, priv);
-			t = afs_folio_dirty_to(folio, priv);
-		}
+	if (folio_clear_dirty_for_io(folio) && folio_pos(folio) < i_size) {
+		len = folio_size(folio);
+		fend = folio_pos(folio) + len;
+		if (vnode->netfs.inode.i_size < fend)
+			len = fend - i_size;
 
-		bvec_set_folio(&bv, folio, t - f, f);
-		iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, bv.bv_len);
+		bvec_set_folio(&bv, folio, len, 0);
+		iov_iter_bvec(&iter, WRITE, &bv, 1, len);
 
 		trace_afs_folio_dirty(vnode, tracepoint_string("launder"), folio);
-		ret = afs_store_data(vnode, &iter, folio_pos(folio) + f, true);
+		ret = afs_store_data(vnode, &iter, folio_pos(folio), true);
 	}
 
 	trace_afs_folio_dirty(vnode, tracepoint_string("laundered"), folio);
-	folio_detach_private(folio);
 	folio_wait_fscache(folio);
 	return ret;
 }
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 597677acc6b1..08506680350c 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -846,26 +846,18 @@ TRACE_EVENT(afs_folio_dirty,
 		    __field(struct afs_vnode *,		vnode)
 		    __field(const char *,		where)
 		    __field(pgoff_t,			index)
-		    __field(unsigned long,		from)
-		    __field(unsigned long,		to)
+		    __field(size_t,			size)
 			     ),
 
 	    TP_fast_assign(
-		    unsigned long priv = (unsigned long)folio_get_private(folio);
 		    __entry->vnode = vnode;
 		    __entry->where = where;
 		    __entry->index = folio_index(folio);
-		    __entry->from  = afs_folio_dirty_from(folio, priv);
-		    __entry->to    = afs_folio_dirty_to(folio, priv);
-		    __entry->to   |= (afs_is_folio_dirty_mmapped(priv) ?
-				      (1UL << (BITS_PER_LONG - 1)) : 0);
+		    __entry->size = folio_size(folio);
 			   ),
 
-	    TP_printk("vn=%p %lx %s %lx-%lx%s",
-		      __entry->vnode, __entry->index, __entry->where,
-		      __entry->from,
-		      __entry->to & ~(1UL << (BITS_PER_LONG - 1)),
-		      __entry->to & (1UL << (BITS_PER_LONG - 1)) ? " M" : "")
+	    TP_printk("vn=%p ix=%05lx s=%05lx %s",
+		      __entry->vnode, __entry->index, __entry->size, __entry->where)
 	    );
 
 TRACE_EVENT(afs_call_state,


