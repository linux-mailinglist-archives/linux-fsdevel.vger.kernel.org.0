Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C7E2BAE48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgKTPOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:14:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729104AbgKTPOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w4fg5oGh21XBgs3jGclZ3hwXa0kjESICZpD7AJSYvNk=;
        b=e5OiNWUUeQc+v5Nob8FMc4o0qlMEk1bTcfpR44uZEBpWcKgQ//H5oXxzGGvmuqfQVn2TLG
        KNQvgoqggumyayZoW7PGgOM65HgzlmyME91zd5A6Qndx6im50mPcCerHGKKbj0ZDEa5sOx
        /gPHff6XBh2MI5m3kdh92f2m+yogjGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-pXsfS9KTPC-PUFgAVtKuzw-1; Fri, 20 Nov 2020 10:14:40 -0500
X-MC-Unique: pXsfS9KTPC-PUFgAVtKuzw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88B081005D5A;
        Fri, 20 Nov 2020 15:14:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3E9560C05;
        Fri, 20 Nov 2020 15:14:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 56/76] afs: Pass page into dirty region helpers to provide
 THP size
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:14:31 +0000
Message-ID: <160588527183.3465195.16107942526481976308.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass a pointer to the page being accessed into the dirty region helpers so
that the size of the page can be determined in case it's a transparent huge
page.

This also required the page to be passed into the afs_page_dirty trace
point - so there's no need to specifically pass in the index or private
data as these can be retrieved directly from the page struct.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c              |   20 +++++++--------
 fs/afs/internal.h          |   16 ++++++------
 fs/afs/write.c             |   60 ++++++++++++++++++--------------------------
 include/trace/events/afs.h |   23 ++++++++++-------
 4 files changed, 55 insertions(+), 64 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index ba8874720626..c06197e4339b 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -528,8 +528,8 @@ static void afs_invalidate_dirty(struct page *page, unsigned int offset,
 		return;
 
 	/* We may need to shorten the dirty region */
-	f = afs_page_dirty_from(priv);
-	t = afs_page_dirty_to(priv);
+	f = afs_page_dirty_from(page, priv);
+	t = afs_page_dirty_to(page, priv);
 
 	if (t <= offset || f >= end)
 		return; /* Doesn't overlap */
@@ -547,17 +547,17 @@ static void afs_invalidate_dirty(struct page *page, unsigned int offset,
 	if (f == t)
 		goto undirty;
 
-	priv = afs_page_dirty(f, t);
+	priv = afs_page_dirty(page, f, t);
 	set_page_private(page, priv);
-	trace_afs_page_dirty(vnode, tracepoint_string("trunc"), page->index, priv);
+	trace_afs_page_dirty(vnode, tracepoint_string("trunc"), page);
 	return;
 
 undirty:
-	trace_afs_page_dirty(vnode, tracepoint_string("undirty"), page->index, priv);
+	trace_afs_page_dirty(vnode, tracepoint_string("undirty"), page);
 	clear_page_dirty_for_io(page);
 full_invalidate:
-	priv = (unsigned long)detach_page_private(page);
-	trace_afs_page_dirty(vnode, tracepoint_string("inval"), page->index, priv);
+	detach_page_private(page);
+	trace_afs_page_dirty(vnode, tracepoint_string("inval"), page);
 }
 
 /*
@@ -585,7 +585,6 @@ static void afs_invalidatepage(struct page *page, unsigned int offset,
 static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 {
 	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
-	unsigned long priv;
 
 	_enter("{{%llx:%llu}[%lu],%lx},%x",
 	       vnode->fid.vid, vnode->fid.vnode, page->index, page->flags,
@@ -594,9 +593,8 @@ static int afs_releasepage(struct page *page, gfp_t gfp_flags)
 	/* deny if page is being written to the cache and the caller hasn't
 	 * elected to wait */
 	if (PagePrivate(page)) {
-		priv = (unsigned long)detach_page_private(page);
-		trace_afs_page_dirty(vnode, tracepoint_string("rel"),
-				     page->index, priv);
+		detach_page_private(page);
+		trace_afs_page_dirty(vnode, tracepoint_string("rel"), page);
 	}
 
 	/* indicate that the page can be released */
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 12bb08eaeeff..9f75d99f5b2e 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -874,31 +874,31 @@ struct afs_vnode_cache_aux {
 #define __AFS_PAGE_PRIV_MMAPPED	0x8000UL
 #endif
 
-static inline unsigned int afs_page_dirty_resolution(void)
+static inline unsigned int afs_page_dirty_resolution(struct page *page)
 {
-	int shift = PAGE_SHIFT - (__AFS_PAGE_PRIV_SHIFT - 1);
+	int shift = thp_order(page) + PAGE_SHIFT - (__AFS_PAGE_PRIV_SHIFT - 1);
 	return (shift > 0) ? shift : 0;
 }
 
-static inline size_t afs_page_dirty_from(unsigned long priv)
+static inline size_t afs_page_dirty_from(struct page *page, unsigned long priv)
 {
 	unsigned long x = priv & __AFS_PAGE_PRIV_MASK;
 
 	/* The lower bound is inclusive */
-	return x << afs_page_dirty_resolution();
+	return x << afs_page_dirty_resolution(page);
 }
 
-static inline size_t afs_page_dirty_to(unsigned long priv)
+static inline size_t afs_page_dirty_to(struct page *page, unsigned long priv)
 {
 	unsigned long x = (priv >> __AFS_PAGE_PRIV_SHIFT) & __AFS_PAGE_PRIV_MASK;
 
 	/* The upper bound is immediately beyond the region */
-	return (x + 1) << afs_page_dirty_resolution();
+	return (x + 1) << afs_page_dirty_resolution(page);
 }
 
-static inline unsigned long afs_page_dirty(size_t from, size_t to)
+static inline unsigned long afs_page_dirty(struct page *page, size_t from, size_t to)
 {
-	unsigned int res = afs_page_dirty_resolution();
+	unsigned int res = afs_page_dirty_resolution(page);
 	from >>= res;
 	to = (to - 1) >> res;
 	return (to << __AFS_PAGE_PRIV_SHIFT) | from;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 92eaa88000d7..9d0cef35ecba 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -112,15 +112,14 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	t = f = 0;
 	if (PagePrivate(page)) {
 		priv = page_private(page);
-		f = afs_page_dirty_from(priv);
-		t = afs_page_dirty_to(priv);
+		f = afs_page_dirty_from(page, priv);
+		t = afs_page_dirty_to(page, priv);
 		ASSERTCMP(f, <=, t);
 	}
 
 	if (f != t) {
 		if (PageWriteback(page)) {
-			trace_afs_page_dirty(vnode, tracepoint_string("alrdy"),
-					     page->index, priv);
+			trace_afs_page_dirty(vnode, tracepoint_string("alrdy"), page);
 			goto flush_conflicting_write;
 		}
 		/* If the file is being filled locally, allow inter-write
@@ -204,21 +203,19 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 
 	if (PagePrivate(page)) {
 		priv = page_private(page);
-		f = afs_page_dirty_from(priv);
-		t = afs_page_dirty_to(priv);
+		f = afs_page_dirty_from(page, priv);
+		t = afs_page_dirty_to(page, priv);
 		if (from < f)
 			f = from;
 		if (to > t)
 			t = to;
-		priv = afs_page_dirty(f, t);
+		priv = afs_page_dirty(page, f, t);
 		set_page_private(page, priv);
-		trace_afs_page_dirty(vnode, tracepoint_string("dirty+"),
-				     page->index, priv);
+		trace_afs_page_dirty(vnode, tracepoint_string("dirty+"), page);
 	} else {
-		priv = afs_page_dirty(from, to);
+		priv = afs_page_dirty(page, from, to);
 		attach_page_private(page, (void *)priv);
-		trace_afs_page_dirty(vnode, tracepoint_string("dirty"),
-				     page->index, priv);
+		trace_afs_page_dirty(vnode, tracepoint_string("dirty"), page);
 	}
 
 	set_page_dirty(page);
@@ -321,7 +318,6 @@ static void afs_pages_written_back(struct afs_vnode *vnode,
 				   pgoff_t first, pgoff_t last)
 {
 	struct pagevec pv;
-	unsigned long priv;
 	unsigned count, loop;
 
 	_enter("{%llx:%llu},{%lx-%lx}",
@@ -340,9 +336,9 @@ static void afs_pages_written_back(struct afs_vnode *vnode,
 		ASSERTCMP(pv.nr, ==, count);
 
 		for (loop = 0; loop < count; loop++) {
-			priv = (unsigned long)detach_page_private(pv.pages[loop]);
+			detach_page_private(pv.pages[loop]);
 			trace_afs_page_dirty(vnode, tracepoint_string("clear"),
-					     pv.pages[loop]->index, priv);
+					     pv.pages[loop]);
 			end_page_writeback(pv.pages[loop]);
 		}
 		first += count;
@@ -516,15 +512,13 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 	 */
 	start = primary_page->index;
 	priv = page_private(primary_page);
-	offset = afs_page_dirty_from(priv);
-	to = afs_page_dirty_to(priv);
-	trace_afs_page_dirty(vnode, tracepoint_string("store"),
-			     primary_page->index, priv);
+	offset = afs_page_dirty_from(primary_page, priv);
+	to = afs_page_dirty_to(primary_page, priv);
+	trace_afs_page_dirty(vnode, tracepoint_string("store"), primary_page);
 
 	WARN_ON(offset == to);
 	if (offset == to)
-		trace_afs_page_dirty(vnode, tracepoint_string("WARN"),
-				     primary_page->index, priv);
+		trace_afs_page_dirty(vnode, tracepoint_string("WARN"), primary_page);
 
 	if (start >= final_page ||
 	    (to < PAGE_SIZE && !test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags)))
@@ -562,8 +556,8 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 			}
 
 			priv = page_private(page);
-			f = afs_page_dirty_from(priv);
-			t = afs_page_dirty_to(priv);
+			f = afs_page_dirty_from(page, priv);
+			t = afs_page_dirty_to(page, priv);
 			if (f != 0 &&
 			    !test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags)) {
 				unlock_page(page);
@@ -571,8 +565,7 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 			}
 			to = t;
 
-			trace_afs_page_dirty(vnode, tracepoint_string("store+"),
-					     page->index, priv);
+			trace_afs_page_dirty(vnode, tracepoint_string("store+"), page);
 
 			if (!clear_page_dirty_for_io(page))
 				BUG();
@@ -861,14 +854,13 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 */
 	wait_on_page_writeback(vmf->page);
 
-	priv = afs_page_dirty(0, PAGE_SIZE);
+	priv = afs_page_dirty(vmf->page, 0, PAGE_SIZE);
 	priv = afs_page_dirty_mmapped(priv);
-	trace_afs_page_dirty(vnode, tracepoint_string("mkwrite"),
-			     vmf->page->index, priv);
 	if (PagePrivate(vmf->page))
 		set_page_private(vmf->page, priv);
 	else
 		attach_page_private(vmf->page, (void *)priv);
+	trace_afs_page_dirty(vnode, tracepoint_string("mkwrite"), vmf->page);
 	file_update_time(file);
 
 	sb_end_pagefault(inode->i_sb);
@@ -921,17 +913,15 @@ int afs_launder_page(struct page *page)
 		f = 0;
 		t = PAGE_SIZE;
 		if (PagePrivate(page)) {
-			f = afs_page_dirty_from(priv);
-			t = afs_page_dirty_to(priv);
+			f = afs_page_dirty_from(page, priv);
+			t = afs_page_dirty_to(page, priv);
 		}
 
-		trace_afs_page_dirty(vnode, tracepoint_string("launder"),
-				     page->index, priv);
+		trace_afs_page_dirty(vnode, tracepoint_string("launder"), page);
 		ret = afs_store_data(mapping, page->index, page->index, t, f, true);
 	}
 
-	priv = (unsigned long)detach_page_private(page);
-	trace_afs_page_dirty(vnode, tracepoint_string("laundered"),
-			     page->index, priv);
+	detach_page_private(page);
+	trace_afs_page_dirty(vnode, tracepoint_string("laundered"), page);
 	return ret;
 }
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 4eef374d4413..f0b2565db2d9 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -967,30 +967,33 @@ TRACE_EVENT(afs_dir_check_failed,
 	    );
 
 TRACE_EVENT(afs_page_dirty,
-	    TP_PROTO(struct afs_vnode *vnode, const char *where,
-		     pgoff_t page, unsigned long priv),
+	    TP_PROTO(struct afs_vnode *vnode, const char *where, struct page *page),
 
-	    TP_ARGS(vnode, where, page, priv),
+	    TP_ARGS(vnode, where, page),
 
 	    TP_STRUCT__entry(
 		    __field(struct afs_vnode *,		vnode		)
 		    __field(const char *,		where		)
 		    __field(pgoff_t,			page		)
-		    __field(unsigned long,		priv		)
+		    __field(unsigned long,		from		)
+		    __field(unsigned long,		to		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->vnode = vnode;
 		    __entry->where = where;
-		    __entry->page = page;
-		    __entry->priv = priv;
+		    __entry->page = page->index;
+		    __entry->from = afs_page_dirty_from(page, page->private);
+		    __entry->to = afs_page_dirty_to(page, page->private);
+		    __entry->to |= (afs_is_page_dirty_mmapped(page->private) ?
+				    (1UL << (BITS_PER_LONG - 1)) : 0);
 			   ),
 
-	    TP_printk("vn=%p %lx %s %zx-%zx%s",
+	    TP_printk("vn=%p %lx %s %lx-%lx%s",
 		      __entry->vnode, __entry->page, __entry->where,
-		      afs_page_dirty_from(__entry->priv),
-		      afs_page_dirty_to(__entry->priv),
-		      afs_is_page_dirty_mmapped(__entry->priv) ? " M" : "")
+		      __entry->from,
+		      __entry->to & ~(1UL << (BITS_PER_LONG - 1)),
+		      __entry->to & (1UL << (BITS_PER_LONG - 1)) ? " M" : "")
 	    );
 
 TRACE_EVENT(afs_call_state,


