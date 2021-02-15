Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB9531BDC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 16:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhBOPyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 10:54:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232069AbhBOPvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613404178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBwzGZNZQ+UMM3OydMQqHdTFW8MF6HNUwB3N2ow9wp4=;
        b=CQLqQJ/ODQ6jotSMSPGVxnFrhvf3Ud99tIPLb3klWI8f3w+UYlu9Oh9dc0ju4cQYVzFatD
        hbfCZU4067RfZkfSGOg2oumME8vBGUf0B/nPfr5WTRTjj2BY7r5asYfbdqFqpv/Tkv7ban
        MGQUqwUU+WNhrwbF4Gny5LX+6gYLXfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-jjTxv7DAMUWhACU5ApinfA-1; Mon, 15 Feb 2021 10:49:28 -0500
X-MC-Unique: jjTxv7DAMUWhACU5ApinfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD2108030D0;
        Mon, 15 Feb 2021 15:49:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84CAD5C233;
        Mon, 15 Feb 2021 15:49:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 25/33] afs: Prepare for use of THPs
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 Feb 2021 15:49:18 +0000
Message-ID: <161340415869.1303470.6040191748634322355.stgit@warthog.procyon.org.uk>
In-Reply-To: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As a prelude to supporting transparent huge pages, use thp_size() and
similar rather than PAGE_SIZE/SHIFT.

Further, try and frame everything in terms of file positions and lengths
rather than page indices and numbers of pages.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
---

 fs/afs/dir.c      |    2 
 fs/afs/file.c     |    8 -
 fs/afs/internal.h |    2 
 fs/afs/write.c    |  436 +++++++++++++++++++++++++++++------------------------
 4 files changed, 245 insertions(+), 203 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 526a49889dff..d547891af63d 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -2082,6 +2082,6 @@ static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
 		afs_stat_v(dvnode, n_inval);
 
 	/* we clean up only if the entire page is being invalidated */
-	if (offset == 0 && length == PAGE_SIZE)
+	if (offset == 0 && length == thp_size(page))
 		detach_page_private(page);
 }
diff --git a/fs/afs/file.c b/fs/afs/file.c
index acbc21a8c80e..f6282ac0d222 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -330,8 +330,8 @@ static int afs_page_filler(struct key *key, struct page *page)
 	req->vnode		= vnode;
 	req->key		= key_get(key);
 	req->pos		= (loff_t)page->index << PAGE_SHIFT;
-	req->len		= PAGE_SIZE;
-	req->nr_pages		= 1;
+	req->len		= thp_size(page);
+	req->nr_pages		= thp_nr_pages(page);
 	req->done		= afs_file_read_done;
 	req->cleanup		= afs_file_read_cleanup;
 
@@ -575,8 +575,8 @@ static void afs_invalidate_dirty(struct page *page, unsigned int offset,
 	trace_afs_page_dirty(vnode, tracepoint_string("undirty"), page);
 	clear_page_dirty_for_io(page);
 full_invalidate:
-	detach_page_private(page);
 	trace_afs_page_dirty(vnode, tracepoint_string("inval"), page);
+	detach_page_private(page);
 }
 
 /*
@@ -621,8 +621,8 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 #endif
 
 	if (PagePrivate(page)) {
-		detach_page_private(page);
 		trace_afs_page_dirty(vnode, tracepoint_string("rel"), page);
+		detach_page_private(page);
 	}
 
 	/* indicate that the page can be released */
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index d4163f9babfd..daf5339ae316 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -815,8 +815,6 @@ struct afs_operation {
 			loff_t	pos;
 			loff_t	size;
 			loff_t	i_size;
-			pgoff_t	first;		/* first page in mapping to deal with */
-			pgoff_t	last;		/* last page in mapping to deal with */
 			bool	laundering;	/* Laundering page, PG_writeback not set */
 		} store;
 		struct {
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 89c804bfe253..e672833c99bc 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -94,15 +94,15 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	struct page *page;
 	unsigned long priv;
-	unsigned f, from = pos & (PAGE_SIZE - 1);
-	unsigned t, to = from + len;
-	pgoff_t index = pos >> PAGE_SHIFT;
+	unsigned f, from;
+	unsigned t, to;
+	pgoff_t index;
 	int ret;
 
-	_enter("{%llx:%llu},{%lx},%u,%u",
-	       vnode->fid.vid, vnode->fid.vnode, index, from, to);
+	_enter("{%llx:%llu},%llx,%x",
+	       vnode->fid.vid, vnode->fid.vnode, pos, len);
 
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	page = grab_cache_page_write_begin(mapping, pos / PAGE_SIZE, flags);
 	if (!page)
 		return -ENOMEM;
 
@@ -121,19 +121,20 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	wait_on_page_fscache(page);
 #endif
 
+	index = page->index;
+	from = pos - index * PAGE_SIZE;
+	to = from + len;
+
 try_again:
 	/* See if this page is already partially written in a way that we can
 	 * merge the new write with.
 	 */
-	t = f = 0;
 	if (PagePrivate(page)) {
 		priv = page_private(page);
 		f = afs_page_dirty_from(page, priv);
 		t = afs_page_dirty_to(page, priv);
 		ASSERTCMP(f, <=, t);
-	}
 
-	if (f != t) {
 		if (PageWriteback(page)) {
 			trace_afs_page_dirty(vnode, tracepoint_string("alrdy"), page);
 			goto flush_conflicting_write;
@@ -180,7 +181,7 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	unsigned long priv;
-	unsigned int f, from = pos & (PAGE_SIZE - 1);
+	unsigned int f, from = pos & (thp_size(page) - 1);
 	unsigned int t, to = from + copied;
 	loff_t i_size, maybe_i_size;
 	int ret = 0;
@@ -233,9 +234,8 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 		trace_afs_page_dirty(vnode, tracepoint_string("dirty"), page);
 	}
 
-	set_page_dirty(page);
-	if (PageDirty(page))
-		_debug("dirtied");
+	if (set_page_dirty(page))
+		_debug("dirtied %lx", page->index);
 	ret = copied;
 
 out:
@@ -248,40 +248,43 @@ int afs_write_end(struct file *file, struct address_space *mapping,
  * kill all the pages in the given range
  */
 static void afs_kill_pages(struct address_space *mapping,
-			   pgoff_t first, pgoff_t last)
+			   loff_t start, loff_t len)
 {
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
 	struct pagevec pv;
-	unsigned count, loop;
+	unsigned int loop, psize;
 
-	_enter("{%llx:%llu},%lx-%lx",
-	       vnode->fid.vid, vnode->fid.vnode, first, last);
+	_enter("{%llx:%llu},%llx @%llx",
+	       vnode->fid.vid, vnode->fid.vnode, len, start);
 
 	pagevec_init(&pv);
 
 	do {
-		_debug("kill %lx-%lx", first, last);
+		_debug("kill %llx @%llx", len, start);
 
-		count = last - first + 1;
-		if (count > PAGEVEC_SIZE)
-			count = PAGEVEC_SIZE;
-		pv.nr = find_get_pages_contig(mapping, first, count, pv.pages);
-		ASSERTCMP(pv.nr, ==, count);
+		pv.nr = find_get_pages_contig(mapping, start / PAGE_SIZE,
+					      PAGEVEC_SIZE, pv.pages);
+		if (pv.nr == 0)
+			break;
 
-		for (loop = 0; loop < count; loop++) {
+		for (loop = 0; loop < pv.nr; loop++) {
 			struct page *page = pv.pages[loop];
+
+			if (page->index * PAGE_SIZE >= start + len)
+				break;
+
+			psize = thp_size(page);
+			start += psize;
+			len -= psize;
 			ClearPageUptodate(page);
-			SetPageError(page);
 			end_page_writeback(page);
-			if (page->index >= first)
-				first = page->index + 1;
 			lock_page(page);
 			generic_error_remove_page(mapping, page);
 			unlock_page(page);
 		}
 
 		__pagevec_release(&pv);
-	} while (first <= last);
+	} while (len > 0);
 
 	_leave("");
 }
@@ -291,37 +294,40 @@ static void afs_kill_pages(struct address_space *mapping,
  */
 static void afs_redirty_pages(struct writeback_control *wbc,
 			      struct address_space *mapping,
-			      pgoff_t first, pgoff_t last)
+			      loff_t start, loff_t len)
 {
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
 	struct pagevec pv;
-	unsigned count, loop;
+	unsigned int loop, psize;
 
-	_enter("{%llx:%llu},%lx-%lx",
-	       vnode->fid.vid, vnode->fid.vnode, first, last);
+	_enter("{%llx:%llu},%llx @%llx",
+	       vnode->fid.vid, vnode->fid.vnode, len, start);
 
 	pagevec_init(&pv);
 
 	do {
-		_debug("redirty %lx-%lx", first, last);
+		_debug("redirty %llx @%llx", len, start);
 
-		count = last - first + 1;
-		if (count > PAGEVEC_SIZE)
-			count = PAGEVEC_SIZE;
-		pv.nr = find_get_pages_contig(mapping, first, count, pv.pages);
-		ASSERTCMP(pv.nr, ==, count);
+		pv.nr = find_get_pages_contig(mapping, start / PAGE_SIZE,
+					      PAGEVEC_SIZE, pv.pages);
+		if (pv.nr == 0)
+			break;
 
-		for (loop = 0; loop < count; loop++) {
+		for (loop = 0; loop < pv.nr; loop++) {
 			struct page *page = pv.pages[loop];
 
+			if (page->index * PAGE_SIZE >= start + len)
+				break;
+
+			psize = thp_size(page);
+			start += psize;
+			len -= psize;
 			redirty_page_for_writepage(wbc, page);
 			end_page_writeback(page);
-			if (page->index >= first)
-				first = page->index + 1;
 		}
 
 		__pagevec_release(&pv);
-	} while (first <= last);
+	} while (len > 0);
 
 	_leave("");
 }
@@ -329,23 +335,28 @@ static void afs_redirty_pages(struct writeback_control *wbc,
 /*
  * completion of write to server
  */
-static void afs_pages_written_back(struct afs_vnode *vnode, pgoff_t start, pgoff_t last)
+static void afs_pages_written_back(struct afs_vnode *vnode, loff_t start, unsigned int len)
 {
 	struct address_space *mapping = vnode->vfs_inode.i_mapping;
 	struct page *page;
+	pgoff_t end;
 
-	XA_STATE(xas, &mapping->i_pages, start);
+	XA_STATE(xas, &mapping->i_pages, start / PAGE_SIZE);
 
-	_enter("{%llx:%llu},{%lx-%lx}",
-	       vnode->fid.vid, vnode->fid.vnode, start, last);
+	_enter("{%llx:%llu},{%x @%llx}",
+	       vnode->fid.vid, vnode->fid.vnode, len, start);
 
 	rcu_read_lock();
 
-	xas_for_each(&xas, page, last) {
-		ASSERT(PageWriteback(page));
+	end = (start + len - 1) / PAGE_SIZE;
+	xas_for_each(&xas, page, end) {
+		if (!PageWriteback(page)) {
+			kdebug("bad %x @%llx page %lx %lx", len, start, page->index, end);
+			ASSERT(PageWriteback(page));
+		}
 
-		detach_page_private(page);
 		trace_afs_page_dirty(vnode, tracepoint_string("clear"), page);
+		detach_page_private(page);
 		page_endio(page, true, 0);
 	}
 
@@ -404,7 +415,7 @@ static void afs_store_data_success(struct afs_operation *op)
 	afs_vnode_commit_status(op, &op->file[0]);
 	if (op->error == 0) {
 		if (!op->store.laundering)
-			afs_pages_written_back(vnode, op->store.first, op->store.last);
+			afs_pages_written_back(vnode, op->store.pos, op->store.size);
 		afs_stat_v(vnode, n_stores);
 		atomic_long_add(op->store.size, &afs_v2net(vnode)->n_store_bytes);
 	}
@@ -419,8 +430,7 @@ static const struct afs_operation_ops afs_store_data_operation = {
 /*
  * write to a file
  */
-static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter,
-			  loff_t pos, pgoff_t first, pgoff_t last,
+static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t pos,
 			  bool laundering)
 {
 	struct afs_operation *op;
@@ -453,8 +463,6 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter,
 	op->file[0].dv_delta = 1;
 	op->store.write_iter = iter;
 	op->store.pos = pos;
-	op->store.first = first;
-	op->store.last = last;
 	op->store.size = size;
 	op->store.i_size = max(pos + size, i_size);
 	op->store.laundering = laundering;
@@ -499,40 +507,49 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter,
 static void afs_extend_writeback(struct address_space *mapping,
 				 struct afs_vnode *vnode,
 				 long *_count,
-				 pgoff_t start,
-				 pgoff_t final_page,
-				 unsigned *_offset,
-				 unsigned *_to,
-				 bool new_content)
+				 loff_t start,
+				 loff_t max_len,
+				 bool new_content,
+				 unsigned int *_len)
 {
-	struct page *pages[8], *page;
-	unsigned long count = *_count, priv;
-	unsigned offset = *_offset, to = *_to, n, f, t;
-	int loop;
+	struct pagevec pvec;
+	struct page *page;
+	unsigned long priv;
+	unsigned int psize, filler = 0;
+	unsigned int f, t;
+	loff_t len = *_len;
+	pgoff_t index = (start + len) / PAGE_SIZE;
+	bool stop = true;
+	unsigned int i;
+
+	XA_STATE(xas, &mapping->i_pages, index);
+	pagevec_init(&pvec);
 
-	start++;
 	do {
-		_debug("more %lx [%lx]", start, count);
-		n = final_page - start + 1;
-		if (n > ARRAY_SIZE(pages))
-			n = ARRAY_SIZE(pages);
-		n = find_get_pages_contig(mapping, start, ARRAY_SIZE(pages), pages);
-		_debug("fgpc %u", n);
-		if (n == 0)
-			goto no_more;
-		if (pages[0]->index != start) {
-			do {
-				put_page(pages[--n]);
-			} while (n > 0);
-			goto no_more;
-		}
+		/* Firstly, we gather up a batch of contiguous dirty pages
+		 * under the RCU read lock - but we can't clear the dirty flags
+		 * there if any of those pages are mapped.
+		 */
+		rcu_read_lock();
 
-		for (loop = 0; loop < n; loop++) {
-			page = pages[loop];
-			if (to != PAGE_SIZE && !new_content)
+		xas_for_each(&xas, page, ULONG_MAX) {
+			stop = true;
+			if (xas_retry(&xas, page))
+				continue;
+			if (xa_is_value(page))
+				break;
+			if (page->index != index)
 				break;
-			if (page->index > final_page)
+
+			if (!page_cache_get_speculative(page)) {
+				xas_reset(&xas);
+				continue;
+			}
+
+			/* Has the page moved or been split? */
+			if (unlikely(page != xas_reload(&xas)))
 				break;
+
 			if (!trylock_page(page))
 				break;
 			if (!PageDirty(page) || PageWriteback(page)) {
@@ -540,6 +557,7 @@ static void afs_extend_writeback(struct address_space *mapping,
 				break;
 			}
 
+			psize = thp_size(page);
 			priv = page_private(page);
 			f = afs_page_dirty_from(page, priv);
 			t = afs_page_dirty_to(page, priv);
@@ -547,110 +565,126 @@ static void afs_extend_writeback(struct address_space *mapping,
 				unlock_page(page);
 				break;
 			}
-			to = t;
 
+			len += filler + t;
+			filler = psize - t;
+			if (len >= max_len || *_count <= 0)
+				stop = true;
+			else if (t == psize || new_content)
+				stop = false;
+
+			index += thp_nr_pages(page);
+			if (!pagevec_add(&pvec, page))
+				break;
+			if (stop)
+				break;
+		}
+
+		if (!stop)
+			xas_pause(&xas);
+		rcu_read_unlock();
+
+		/* Now, if we obtained any pages, we can shift them to being
+		 * writable and mark them for caching.
+		 */
+		if (!pagevec_count(&pvec))
+			break;
+
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			page = pvec.pages[i];
 			trace_afs_page_dirty(vnode, tracepoint_string("store+"), page);
 
 			if (!clear_page_dirty_for_io(page))
 				BUG();
 			if (test_set_page_writeback(page))
 				BUG();
+
+			*_count -= thp_nr_pages(page);
 			unlock_page(page);
-			put_page(page);
-		}
-		count += loop;
-		if (loop < n) {
-			for (; loop < n; loop++)
-				put_page(pages[loop]);
-			goto no_more;
 		}
 
-		start += loop;
-	} while (start <= final_page && count < 65536);
+		pagevec_release(&pvec);
+		cond_resched();
+	} while (!stop);
 
-no_more:
-	*_count = count;
-	*_offset = offset;
-	*_to = to;
+	*_len = len;
 }
 
 /*
  * Synchronously write back the locked page and any subsequent non-locked dirty
  * pages.
  */
-static int afs_write_back_from_locked_page(struct address_space *mapping,
-					   struct writeback_control *wbc,
-					   struct page *primary_page,
-					   pgoff_t final_page)
+static ssize_t afs_write_back_from_locked_page(struct address_space *mapping,
+					       struct writeback_control *wbc,
+					       struct page *page,
+					       loff_t start, loff_t end)
 {
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
 	struct iov_iter iter;
-	unsigned long count, priv;
-	unsigned offset, to;
-	pgoff_t start, first, last;
-	loff_t i_size, pos, end;
+	unsigned long priv;
+	unsigned int offset, to, len, max_len;
+	loff_t i_size = i_size_read(&vnode->vfs_inode);
 	bool new_content = test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
+	long count = wbc->nr_to_write;
 	int ret;
 
-	_enter(",%lx", primary_page->index);
+	_enter(",%lx,%llx-%llx", page->index, start, end);
 
-	count = 1;
-	if (test_set_page_writeback(primary_page))
+	if (test_set_page_writeback(page))
 		BUG();
 
+	count -= thp_nr_pages(page);
+
 	/* Find all consecutive lockable dirty pages that have contiguous
 	 * written regions, stopping when we find a page that is not
 	 * immediately lockable, is not dirty or is missing, or we reach the
 	 * end of the range.
 	 */
-	start = primary_page->index;
-	priv = page_private(primary_page);
-	offset = afs_page_dirty_from(primary_page, priv);
-	to = afs_page_dirty_to(primary_page, priv);
-	trace_afs_page_dirty(vnode, tracepoint_string("store"), primary_page);
-
-	WARN_ON(offset == to);
-	if (offset == to)
-		trace_afs_page_dirty(vnode, tracepoint_string("WARN"), primary_page);
-
-	if (start < final_page &&
-	    (to == PAGE_SIZE || new_content))
-		afs_extend_writeback(mapping, vnode, &count, start, final_page,
-				     &offset, &to, new_content);
+	priv = page_private(page);
+	offset = afs_page_dirty_from(page, priv);
+	to = afs_page_dirty_to(page, priv);
+	trace_afs_page_dirty(vnode, tracepoint_string("store"), page);
+
+	len = to - offset;
+	start += offset;
+	if (start < i_size) {
+		/* Trim the write to the EOF; the extra data is ignored.  Also
+		 * put an upper limit on the size of a single storedata op.
+		 */
+		max_len = 65536 * 4096;
+		max_len = min_t(unsigned long long, max_len, end - start + 1);
+		max_len = min_t(unsigned long long, max_len, i_size - start);
+
+		if (len < max_len &&
+		    (to == thp_size(page) || new_content))
+			afs_extend_writeback(mapping, vnode, &count,
+					     start, max_len, new_content, &len);
+		len = min_t(loff_t, len, max_len);
+	}
 
 	/* We now have a contiguous set of dirty pages, each with writeback
 	 * set; the first page is still locked at this point, but all the rest
 	 * have been unlocked.
 	 */
-	unlock_page(primary_page);
-
-	first = primary_page->index;
-	last = first + count - 1;
-	_debug("write back %lx[%u..] to %lx[..%u]", first, offset, last, to);
-
-	pos = first;
-	pos <<= PAGE_SHIFT;
-	pos += offset;
-	end = last;
-	end <<= PAGE_SHIFT;
-	end += to;
+	unlock_page(page);
 
-	/* Trim the actual write down to the EOF */
-	i_size = i_size_read(&vnode->vfs_inode);
-	if (end > i_size)
-		end = i_size;
+	if (start < i_size) {
+		_debug("write back %x @%llx [%llx]", len, start, i_size);
 
-	if (pos < i_size) {
-		iov_iter_xarray(&iter, WRITE, &mapping->i_pages, pos, end - pos);
-		ret = afs_store_data(vnode, &iter, pos, first, last, false);
+		iov_iter_xarray(&iter, WRITE, &mapping->i_pages, start, len);
+		ret = afs_store_data(vnode, &iter, start, false);
 	} else {
+		_debug("write discard %x @%llx [%llx]", len, start, i_size);
+
 		/* The dirty region was entirely beyond the EOF. */
+		afs_pages_written_back(vnode, start, len);
 		ret = 0;
 	}
 
 	switch (ret) {
 	case 0:
-		ret = count;
+		wbc->nr_to_write = count;
+		ret = len;
 		break;
 
 	default:
@@ -662,13 +696,13 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 	case -EKEYEXPIRED:
 	case -EKEYREJECTED:
 	case -EKEYREVOKED:
-		afs_redirty_pages(wbc, mapping, first, last);
+		afs_redirty_pages(wbc, mapping, start, len);
 		mapping_set_error(mapping, ret);
 		break;
 
 	case -EDQUOT:
 	case -ENOSPC:
-		afs_redirty_pages(wbc, mapping, first, last);
+		afs_redirty_pages(wbc, mapping, start, len);
 		mapping_set_error(mapping, -ENOSPC);
 		break;
 
@@ -680,7 +714,7 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 	case -ENOMEDIUM:
 	case -ENXIO:
 		trace_afs_file_error(vnode, ret, afs_file_error_writeback_fail);
-		afs_kill_pages(mapping, first, last);
+		afs_kill_pages(mapping, start, len);
 		mapping_set_error(mapping, ret);
 		break;
 	}
@@ -695,19 +729,19 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
  */
 int afs_writepage(struct page *page, struct writeback_control *wbc)
 {
-	int ret;
+	ssize_t ret;
+	loff_t start;
 
 	_enter("{%lx},", page->index);
 
+	start = page->index * PAGE_SIZE;
 	ret = afs_write_back_from_locked_page(page->mapping, wbc, page,
-					      wbc->range_end >> PAGE_SHIFT);
+					      start, LLONG_MAX - start);
 	if (ret < 0) {
-		_leave(" = %d", ret);
-		return 0;
+		_leave(" = %zd", ret);
+		return ret;
 	}
 
-	wbc->nr_to_write -= ret;
-
 	_leave(" = 0");
 	return 0;
 }
@@ -717,35 +751,46 @@ int afs_writepage(struct page *page, struct writeback_control *wbc)
  */
 static int afs_writepages_region(struct address_space *mapping,
 				 struct writeback_control *wbc,
-				 pgoff_t index, pgoff_t end, pgoff_t *_next)
+				 loff_t start, loff_t end, loff_t *_next)
 {
 	struct page *page;
-	int ret, n;
+	ssize_t ret;
+	int n;
 
-	_enter(",,%lx,%lx,", index, end);
+	_enter("%llx,%llx,", start, end);
 
 	do {
-		n = find_get_pages_range_tag(mapping, &index, end,
-					PAGECACHE_TAG_DIRTY, 1, &page);
+		pgoff_t index = start / PAGE_SIZE;
+
+		n = find_get_pages_range_tag(mapping, &index, end / PAGE_SIZE,
+					     PAGECACHE_TAG_DIRTY, 1, &page);
 		if (!n)
 			break;
 
+		start = (loff_t)page->index * PAGE_SIZE; /* May regress with THPs */
+
 		_debug("wback %lx", page->index);
 
-		/*
-		 * at this point we hold neither the i_pages lock nor the
+		/* At this point we hold neither the i_pages lock nor the
 		 * page lock: the page may be truncated or invalidated
 		 * (changing page->mapping to NULL), or even swizzled
 		 * back from swapper_space to tmpfs file mapping
 		 */
-		ret = lock_page_killable(page);
-		if (ret < 0) {
-			put_page(page);
-			_leave(" = %d", ret);
-			return ret;
+		if (wbc->sync_mode != WB_SYNC_NONE) {
+			ret = lock_page_killable(page);
+			if (ret < 0) {
+				put_page(page);
+				return ret;
+			}
+		} else {
+			if (!trylock_page(page)) {
+				put_page(page);
+				return 0;
+			}
 		}
 
 		if (page->mapping != mapping || !PageDirty(page)) {
+			start += thp_size(page);
 			unlock_page(page);
 			put_page(page);
 			continue;
@@ -761,20 +806,20 @@ static int afs_writepages_region(struct address_space *mapping,
 
 		if (!clear_page_dirty_for_io(page))
 			BUG();
-		ret = afs_write_back_from_locked_page(mapping, wbc, page, end);
+		ret = afs_write_back_from_locked_page(mapping, wbc, page, start, end);
 		put_page(page);
 		if (ret < 0) {
-			_leave(" = %d", ret);
+			_leave(" = %zd", ret);
 			return ret;
 		}
 
-		wbc->nr_to_write -= ret;
+		start += ret * PAGE_SIZE;
 
 		cond_resched();
-	} while (index < end && wbc->nr_to_write > 0);
+	} while (wbc->nr_to_write > 0);
 
-	*_next = index;
-	_leave(" = 0 [%lx]", *_next);
+	*_next = start;
+	_leave(" = 0 [%llx]", *_next);
 	return 0;
 }
 
@@ -785,7 +830,7 @@ int afs_writepages(struct address_space *mapping,
 		   struct writeback_control *wbc)
 {
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
-	pgoff_t start, end, next;
+	loff_t start, next;
 	int ret;
 
 	_enter("");
@@ -800,22 +845,19 @@ int afs_writepages(struct address_space *mapping,
 		return 0;
 
 	if (wbc->range_cyclic) {
-		start = mapping->writeback_index;
-		end = -1;
-		ret = afs_writepages_region(mapping, wbc, start, end, &next);
+		start = mapping->writeback_index * PAGE_SIZE;
+		ret = afs_writepages_region(mapping, wbc, start, LLONG_MAX, &next);
 		if (start > 0 && wbc->nr_to_write > 0 && ret == 0)
 			ret = afs_writepages_region(mapping, wbc, 0, start,
 						    &next);
-		mapping->writeback_index = next;
+		mapping->writeback_index = next / PAGE_SIZE;
 	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
-		end = (pgoff_t)(LLONG_MAX >> PAGE_SHIFT);
-		ret = afs_writepages_region(mapping, wbc, 0, end, &next);
+		ret = afs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
 		if (wbc->nr_to_write > 0)
 			mapping->writeback_index = next;
 	} else {
-		start = wbc->range_start >> PAGE_SHIFT;
-		end = wbc->range_end >> PAGE_SHIFT;
-		ret = afs_writepages_region(mapping, wbc, start, end, &next);
+		ret = afs_writepages_region(mapping, wbc,
+					    wbc->range_start, wbc->range_end, &next);
 	}
 
 	up_read(&vnode->validate_lock);
@@ -873,13 +915,13 @@ int afs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  */
 vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 {
+	struct page *page = thp_head(vmf->page);
 	struct file *file = vmf->vma->vm_file;
 	struct inode *inode = file_inode(file);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	unsigned long priv;
 
-	_enter("{{%llx:%llu}},{%lx}",
-	       vnode->fid.vid, vnode->fid.vnode, vmf->page->index);
+	_enter("{{%llx:%llu}},{%lx}", vnode->fid.vid, vnode->fid.vnode, page->index);
 
 	sb_start_pagefault(inode->i_sb);
 
@@ -887,31 +929,33 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 * be modified.  We then assume the entire page will need writing back.
 	 */
 #ifdef CONFIG_AFS_FSCACHE
-	if (PageFsCache(vmf->page) &&
-	    wait_on_page_bit_killable(vmf->page, PG_fscache) < 0)
+	if (PageFsCache(page) &&
+	    wait_on_page_bit_killable(page, PG_fscache) < 0)
 		return VM_FAULT_RETRY;
 #endif
 
-	if (PageWriteback(vmf->page) &&
-	    wait_on_page_bit_killable(vmf->page, PG_writeback) < 0)
+	if (PageWriteback(page) &&
+	    wait_on_page_bit_killable(page, PG_writeback) < 0)
 		return VM_FAULT_RETRY;
 
-	if (lock_page_killable(vmf->page) < 0)
+	if (lock_page_killable(page) < 0)
 		return VM_FAULT_RETRY;
 
 	/* We mustn't change page->private until writeback is complete as that
 	 * details the portion of the page we need to write back and we might
 	 * need to redirty the page if there's a problem.
 	 */
-	wait_on_page_writeback(vmf->page);
+	wait_on_page_writeback(page);
 
-	priv = afs_page_dirty(vmf->page, 0, PAGE_SIZE);
+	priv = afs_page_dirty(page, 0, thp_size(page));
 	priv = afs_page_dirty_mmapped(priv);
-	if (PagePrivate(vmf->page))
-		set_page_private(vmf->page, priv);
-	else
-		attach_page_private(vmf->page, (void *)priv);
-	trace_afs_page_dirty(vnode, tracepoint_string("mkwrite"), vmf->page);
+	if (PagePrivate(page)) {
+		set_page_private(page, priv);
+		trace_afs_page_dirty(vnode, tracepoint_string("mkwrite+"), page);
+	} else {
+		attach_page_private(page, (void *)priv);
+		trace_afs_page_dirty(vnode, tracepoint_string("mkwrite"), page);
+	}
 	file_update_time(file);
 
 	sb_end_pagefault(inode->i_sb);
@@ -964,7 +1008,7 @@ int afs_launder_page(struct page *page)
 	priv = page_private(page);
 	if (clear_page_dirty_for_io(page)) {
 		f = 0;
-		t = PAGE_SIZE;
+		t = thp_size(page);
 		if (PagePrivate(page)) {
 			f = afs_page_dirty_from(page, priv);
 			t = afs_page_dirty_to(page, priv);
@@ -976,12 +1020,12 @@ int afs_launder_page(struct page *page)
 		iov_iter_bvec(&iter, WRITE, bv, 1, bv[0].bv_len);
 
 		trace_afs_page_dirty(vnode, tracepoint_string("launder"), page);
-		ret = afs_store_data(vnode, &iter, (loff_t)page->index << PAGE_SHIFT,
-				     page->index, page->index, true);
+		ret = afs_store_data(vnode, &iter, (loff_t)page->index * PAGE_SIZE,
+				     true);
 	}
 
-	detach_page_private(page);
 	trace_afs_page_dirty(vnode, tracepoint_string("laundered"), page);
+	detach_page_private(page);
 	wait_on_page_fscache(page);
 	return ret;
 }


