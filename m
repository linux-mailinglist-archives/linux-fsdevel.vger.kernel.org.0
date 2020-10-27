Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B0729ADEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 14:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbgJ0NvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 09:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752802AbgJ0NvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603806662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+jb4Uum0YDVbkpAFXhZteFm7QpAvfmGgqEE4z4q5ck=;
        b=Y1+tWpQuOG5aDjnZDm4d7ohmURRvq7U/NtQLozf1mtEaC6W9W5EAQm+xnc+16Bma7vmHDv
        ysQ+sSrpX8MSAsmvSkjuqicekXzcZ3iBhyvb3GEBy+kL8U8nh1Vj9SGEcNS4Nx9WX2ONV4
        zu4UbvCXt4a5+pcdEYW0pGbfRjUhOl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-m7wWUJasOqSgkfC57lUcSw-1; Tue, 27 Oct 2020 09:50:57 -0400
X-MC-Unique: m7wWUJasOqSgkfC57lUcSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A2DA106B80D;
        Tue, 27 Oct 2020 13:50:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5749B60C07;
        Tue, 27 Oct 2020 13:50:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/10] afs: Wrap page->private manipulations in inline
 functions
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 27 Oct 2020 13:50:54 +0000
Message-ID: <160380665455.3467511.8273234602878423351.stgit@warthog.procyon.org.uk>
In-Reply-To: <160380659566.3467511.15495463187114465303.stgit@warthog.procyon.org.uk>
References: <160380659566.3467511.15495463187114465303.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The afs filesystem uses page->private to store the dirty range within a
page such that in the event of a conflicting 3rd-party write to the server,
we write back just the bits that got changed locally.

However, there are a couple of problems with this:

 (1) I need a bit to note if the page might be mapped so that partial
     invalidation doesn't shrink the range.

 (2) There aren't necessarily sufficient bits to store the entire range of
     data altered (say it's a 32-bit system with 64KiB pages or transparent
     huge pages are in use).

So wrap the accesses in inline functions so that future commits can change
how this works.

Also move them out of the tracing header into the in-directory header.
There's not really any need for them to be in the tracing header.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h          |   28 ++++++++++++++++++++++++++++
 fs/afs/write.c             |   31 +++++++++++++------------------
 include/trace/events/afs.h |   19 +++----------------
 3 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 289f5dffa46f..acefa6bf0a4d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -858,6 +858,34 @@ struct afs_vnode_cache_aux {
 	u64			data_version;
 } __packed;
 
+/*
+ * We use page->private to hold the amount of the page that we've written to,
+ * splitting the field into two parts.  However, we need to represent a range
+ * 0...PAGE_SIZE inclusive, so we can't support 64K pages on a 32-bit system.
+ */
+#if PAGE_SIZE > 32768
+#define __AFS_PAGE_PRIV_MASK	0xffffffff
+#define __AFS_PAGE_PRIV_SHIFT	32
+#else
+#define __AFS_PAGE_PRIV_MASK	0xffff
+#define __AFS_PAGE_PRIV_SHIFT	16
+#endif
+
+static inline unsigned int afs_page_dirty_from(unsigned long priv)
+{
+	return priv & __AFS_PAGE_PRIV_MASK;
+}
+
+static inline unsigned int afs_page_dirty_to(unsigned long priv)
+{
+	return (priv >> __AFS_PAGE_PRIV_SHIFT) & __AFS_PAGE_PRIV_MASK;
+}
+
+static inline unsigned long afs_page_dirty(unsigned int from, unsigned int to)
+{
+	return ((unsigned long)to << __AFS_PAGE_PRIV_SHIFT) | from;
+}
+
 #include <trace/events/afs.h>
 
 /*****************************************************************************/
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 5ed5df906744..91bc2cb2cad1 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -117,8 +117,8 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	t = f = 0;
 	if (PagePrivate(page)) {
 		priv = page_private(page);
-		f = priv & AFS_PRIV_MAX;
-		t = priv >> AFS_PRIV_SHIFT;
+		f = afs_page_dirty_from(priv);
+		t = afs_page_dirty_to(priv);
 		ASSERTCMP(f, <=, t);
 	}
 
@@ -206,23 +206,19 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 
 	if (PagePrivate(page)) {
 		priv = page_private(page);
-		f = priv & AFS_PRIV_MAX;
-		t = priv >> AFS_PRIV_SHIFT;
+		f = afs_page_dirty_from(priv);
+		t = afs_page_dirty_to(priv);
 		if (from < f)
 			f = from;
 		if (to > t)
 			t = to;
-		priv = (unsigned long)t << AFS_PRIV_SHIFT;
-		priv |= f;
+		priv = afs_page_dirty(f, t);
 		trace_afs_page_dirty(vnode, tracepoint_string("dirty+"),
 				     page->index, priv);
 	} else {
 		SetPagePrivate(page);
 		get_page(page);
-		f = from;
-		t = to;
-		priv = (unsigned long)t << AFS_PRIV_SHIFT;
-		priv |= f;
+		priv = afs_page_dirty(from, to);
 		trace_afs_page_dirty(vnode, tracepoint_string("dirty"),
 				     page->index, priv);
 	}
@@ -526,8 +522,8 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 	 */
 	start = primary_page->index;
 	priv = page_private(primary_page);
-	offset = priv & AFS_PRIV_MAX;
-	to = priv >> AFS_PRIV_SHIFT;
+	offset = afs_page_dirty_from(priv);
+	to = afs_page_dirty_to(priv);
 	trace_afs_page_dirty(vnode, tracepoint_string("store"),
 			     primary_page->index, priv);
 
@@ -572,8 +568,8 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 			}
 
 			priv = page_private(page);
-			f = priv & AFS_PRIV_MAX;
-			t = priv >> AFS_PRIV_SHIFT;
+			f = afs_page_dirty_from(priv);
+			t = afs_page_dirty_to(priv);
 			if (f != 0 &&
 			    !test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags)) {
 				unlock_page(page);
@@ -874,8 +870,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 */
 	wait_on_page_writeback(vmf->page);
 
-	priv = (unsigned long)PAGE_SIZE << AFS_PRIV_SHIFT; /* To */
-	priv |= 0; /* From */
+	priv = afs_page_dirty(0, PAGE_SIZE);
 	trace_afs_page_dirty(vnode, tracepoint_string("mkwrite"),
 			     vmf->page->index, priv);
 	if (!TestSetPagePrivate(vmf->page))
@@ -933,8 +928,8 @@ int afs_launder_page(struct page *page)
 		f = 0;
 		t = PAGE_SIZE;
 		if (PagePrivate(page)) {
-			f = priv & AFS_PRIV_MAX;
-			t = priv >> AFS_PRIV_SHIFT;
+			f = afs_page_dirty_from(priv);
+			t = afs_page_dirty_to(priv);
 		}
 
 		trace_afs_page_dirty(vnode, tracepoint_string("launder"),
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 8eb49231c6bb..e718ae17ad91 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -966,19 +966,6 @@ TRACE_EVENT(afs_dir_check_failed,
 		      __entry->vnode, __entry->off, __entry->i_size)
 	    );
 
-/*
- * We use page->private to hold the amount of the page that we've written to,
- * splitting the field into two parts.  However, we need to represent a range
- * 0...PAGE_SIZE inclusive, so we can't support 64K pages on a 32-bit system.
- */
-#if PAGE_SIZE > 32768
-#define AFS_PRIV_MAX	0xffffffff
-#define AFS_PRIV_SHIFT	32
-#else
-#define AFS_PRIV_MAX	0xffff
-#define AFS_PRIV_SHIFT	16
-#endif
-
 TRACE_EVENT(afs_page_dirty,
 	    TP_PROTO(struct afs_vnode *vnode, const char *where,
 		     pgoff_t page, unsigned long priv),
@@ -999,10 +986,10 @@ TRACE_EVENT(afs_page_dirty,
 		    __entry->priv = priv;
 			   ),
 
-	    TP_printk("vn=%p %lx %s %lu-%lu",
+	    TP_printk("vn=%p %lx %s %x-%x",
 		      __entry->vnode, __entry->page, __entry->where,
-		      __entry->priv & AFS_PRIV_MAX,
-		      __entry->priv >> AFS_PRIV_SHIFT)
+		      afs_page_dirty_from(__entry->priv),
+		      afs_page_dirty_to(__entry->priv))
 	    );
 
 TRACE_EVENT(afs_call_state,


