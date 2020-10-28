Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E01A29D7FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbgJ1WYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732546AbgJ1WXw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mW7yauOWG/Q0ZES4OIJ2b78YSpdUNzFwOZjFJEaTAdw=;
        b=HKRTBZBGYU7ZX4Cxi7K6NwlNt/tYaKUMBKJ5b4VIuHdUcyuaqVI+jk6ZCYcJx9lSvsLsfL
        +kpXAhmV8lGFnewLBM8eiKIXXNK1QwPRipFgNz4u41H7KKQ6Rn0TSvQB3BngSYbd0x5uLC
        tJFIcuG8Qu/rWl/orHJgkVPmqP7EZL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-w-YNSVyfPvu2NF2a5iw0EQ-1; Wed, 28 Oct 2020 18:23:48 -0400
X-MC-Unique: w-YNSVyfPvu2NF2a5iw0EQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD216804B77;
        Wed, 28 Oct 2020 22:23:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D06655D9EF;
        Wed, 28 Oct 2020 22:23:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/11] afs: Fix afs_invalidatepage to adjust the dirty region
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Oct 2020 22:23:46 +0000
Message-ID: <160392382605.592578.10068060460922268317.stgit@warthog.procyon.org.uk>
In-Reply-To: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
References: <160392375589.592578.13383738325695138512.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs_invalidatepage() to adjust the dirty region recorded in
page->private when truncating a page.  If the dirty region is entirely
removed, then the private data is cleared and the page dirty state is
cleared.

Without this, if the page is truncated and then expanded again by truncate,
zeros from the expanded, but no-longer dirty region may get written back to
the server if the page gets laundered due to a conflicting 3rd-party write.

It mustn't, however, shorten the dirty region of the page if that page is
still mmapped and has been marked dirty by afs_page_mkwrite(), so a flag is
stored in page->private to record this.

Fixes: 4343d00872e1 ("afs: Get rid of the afs_writeback record")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c              |   72 +++++++++++++++++++++++++++++++++++++-------
 fs/afs/internal.h          |   16 +++++++++-
 fs/afs/write.c             |    1 +
 include/trace/events/afs.h |    5 ++-
 4 files changed, 79 insertions(+), 15 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 4503c493dddb..a580c53763d0 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -601,6 +601,63 @@ static int afs_readpages(struct file *file, struct address_space *mapping,
 	return ret;
 }
 
+/*
+ * Adjust the dirty region of the page on truncation or full invalidation,
+ * getting rid of the markers altogether if the region is entirely invalidated.
+ */
+static void afs_invalidate_dirty(struct page *page, unsigned int offset,
+				 unsigned int length)
+{
+	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
+	unsigned long priv;
+	unsigned int f, t, end = offset + length;
+
+	priv = page_private(page);
+
+	/* we clean up only if the entire page is being invalidated */
+	if (offset == 0 && length == thp_size(page))
+		goto full_invalidate;
+
+	 /* If the page was dirtied by page_mkwrite(), the PTE stays writable
+	  * and we don't get another notification to tell us to expand it
+	  * again.
+	  */
+	if (afs_is_page_dirty_mmapped(priv))
+		return;
+
+	/* We may need to shorten the dirty region */
+	f = afs_page_dirty_from(priv);
+	t = afs_page_dirty_to(priv);
+
+	if (t <= offset || f >= end)
+		return; /* Doesn't overlap */
+
+	if (f < offset && t > end)
+		return; /* Splits the dirty region - just absorb it */
+
+	if (f >= offset && t <= end)
+		goto undirty;
+
+	if (f < offset)
+		t = offset;
+	else
+		f = end;
+	if (f == t)
+		goto undirty;
+
+	priv = afs_page_dirty(f, t);
+	set_page_private(page, priv);
+	trace_afs_page_dirty(vnode, tracepoint_string("trunc"), page->index, priv);
+	return;
+
+undirty:
+	trace_afs_page_dirty(vnode, tracepoint_string("undirty"), page->index, priv);
+	clear_page_dirty_for_io(page);
+full_invalidate:
+	trace_afs_page_dirty(vnode, tracepoint_string("inval"), page->index, priv);
+	detach_page_private(page);
+}
+
 /*
  * invalidate part or all of a page
  * - release a page and clean up its private data if offset is 0 (indicating
@@ -609,30 +666,23 @@ static int afs_readpages(struct file *file, struct address_space *mapping,
 static void afs_invalidatepage(struct page *page, unsigned int offset,
 			       unsigned int length)
 {
-	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
-	unsigned long priv;
-
 	_enter("{%lu},%u,%u", page->index, offset, length);
 
 	BUG_ON(!PageLocked(page));
 
+#ifdef CONFIG_AFS_FSCACHE
 	/* we clean up only if the entire page is being invalidated */
 	if (offset == 0 && length == PAGE_SIZE) {
-#ifdef CONFIG_AFS_FSCACHE
 		if (PageFsCache(page)) {
 			struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
 			fscache_wait_on_page_write(vnode->cache, page);
 			fscache_uncache_page(vnode->cache, page);
 		}
+	}
 #endif
 
-		if (PagePrivate(page)) {
-			priv = page_private(page);
-			trace_afs_page_dirty(vnode, tracepoint_string("inval"),
-					     page->index, priv);
-			detach_page_private(page);
-		}
-	}
+	if (PagePrivate(page))
+		afs_invalidate_dirty(page, offset, length);
 
 	_leave("");
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 344c545f934c..b0fce1f75397 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -864,11 +864,13 @@ struct afs_vnode_cache_aux {
  * 0...PAGE_SIZE inclusive, so we can't support 64K pages on a 32-bit system.
  */
 #ifdef CONFIG_64BIT
-#define __AFS_PAGE_PRIV_MASK	0xffffffffUL
+#define __AFS_PAGE_PRIV_MASK	0x7fffffffUL
 #define __AFS_PAGE_PRIV_SHIFT	32
+#define __AFS_PAGE_PRIV_MMAPPED	0x80000000UL
 #else
-#define __AFS_PAGE_PRIV_MASK	0xffffUL
+#define __AFS_PAGE_PRIV_MASK	0x7fffUL
 #define __AFS_PAGE_PRIV_SHIFT	16
+#define __AFS_PAGE_PRIV_MMAPPED	0x8000UL
 #endif
 
 static inline size_t afs_page_dirty_from(unsigned long priv)
@@ -886,6 +888,16 @@ static inline unsigned long afs_page_dirty(size_t from, size_t to)
 	return ((unsigned long)(to - 1) << __AFS_PAGE_PRIV_SHIFT) | from;
 }
 
+static inline unsigned long afs_page_dirty_mmapped(unsigned long priv)
+{
+	return priv | __AFS_PAGE_PRIV_MMAPPED;
+}
+
+static inline bool afs_is_page_dirty_mmapped(unsigned long priv)
+{
+	return priv & __AFS_PAGE_PRIV_MMAPPED;
+}
+
 #include <trace/events/afs.h>
 
 /*****************************************************************************/
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 7561b9973806..0bc895d4f491 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -870,6 +870,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	wait_on_page_writeback(vmf->page);
 
 	priv = afs_page_dirty(0, PAGE_SIZE);
+	priv = afs_page_dirty_mmapped(priv);
 	trace_afs_page_dirty(vnode, tracepoint_string("mkwrite"),
 			     vmf->page->index, priv);
 	if (PagePrivate(vmf->page))
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 866fc67d5aa5..4eef374d4413 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -986,10 +986,11 @@ TRACE_EVENT(afs_page_dirty,
 		    __entry->priv = priv;
 			   ),
 
-	    TP_printk("vn=%p %lx %s %zx-%zx",
+	    TP_printk("vn=%p %lx %s %zx-%zx%s",
 		      __entry->vnode, __entry->page, __entry->where,
 		      afs_page_dirty_from(__entry->priv),
-		      afs_page_dirty_to(__entry->priv))
+		      afs_page_dirty_to(__entry->priv),
+		      afs_is_page_dirty_mmapped(__entry->priv) ? " M" : "")
 	    );
 
 TRACE_EVENT(afs_call_state,


