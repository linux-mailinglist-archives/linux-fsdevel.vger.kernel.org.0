Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED9843218E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhJRPE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43925 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233375AbhJRPDI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xp2LKQx9if5tGosngwP99n5iEOkL5LnpG8JtI6hikwc=;
        b=diNjvMx5Kktgx3NSV7CCxDoGj+OxnRbZrmzMUf8UFHS/OjCSmKZf6B3H/wxc8xAdLtwthG
        QqPmf/qK3I/v3HEcFrqycWSpUTp3nGx2BI3EbN9/CZbf3zzstC3+ltmmWUppSGuOclqJMy
        fZgcvAgaf5nKnDgcqAceRr90tQWdCIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-74102ZF3MtCUjCBHtUJWNQ-1; Mon, 18 Oct 2021 11:00:53 -0400
X-MC-Unique: 74102ZF3MtCUjCBHtUJWNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C760100CCC0;
        Mon, 18 Oct 2021 15:00:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 420DC1980E;
        Mon, 18 Oct 2021 15:00:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 40/67] vfs,
 fscache: Force ->write_inode() to occur if cookie pinned for writeback
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 16:00:47 +0100
Message-ID: <163456924735.2614702.11449131617169771724.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use an inode flag, I_PINNING_FSCACHE_WB, to indicate that a cookie is
pinned in use by that inode for the purposes of writeback.

Pinning is necessary because the in-use pin from the open file is released
before the writeback takes place, but if the resources aren't pinned, the
dirty data can't be written to the cache.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/io.c         |   38 ++++++++++++++++++++++++++++++++++++++
 include/linux/fscache.h |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index ef4b0606019d..25976413fe34 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -214,3 +214,41 @@ int __fscache_fallback_write_page(struct fscache_cookie *cookie, struct page *pa
 	return ret;
 }
 EXPORT_SYMBOL(__fscache_fallback_write_page);
+
+/**
+ * fscache_set_page_dirty - Mark page dirty and pin a cache object for writeback
+ * @page: The page being dirtied
+ * @cookie: The cookie referring to the cache object
+ *
+ * Set the dirty flag on a page and pin an in-use cache object in memory when
+ * dirtying a page so that writeback can later write to it.  This is intended
+ * to be called from the filesystem's ->set_page_dirty() method.
+ *
+ *  Returns 1 if PG_dirty was set on the page, 0 otherwise.
+ */
+int fscache_set_page_dirty(struct page *page, struct fscache_cookie *cookie)
+{
+	struct inode *inode = page->mapping->host;
+	bool need_use = false;
+
+	_enter("");
+
+	if (!__set_page_dirty_nobuffers(page))
+		return 0;
+	if (!fscache_cookie_valid(cookie))
+		return 1;
+
+	if (!(inode->i_state & I_PINNING_FSCACHE_WB)) {
+		spin_lock(&inode->i_lock);
+		if (!(inode->i_state & I_PINNING_FSCACHE_WB)) {
+			inode->i_state |= I_PINNING_FSCACHE_WB;
+			need_use = true;
+		}
+		spin_unlock(&inode->i_lock);
+
+		if (need_use)
+			fscache_use_cookie(cookie, true);
+	}
+	return 1;
+}
+EXPORT_SYMBOL(fscache_set_page_dirty);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index fa7eef2674bf..abf5413c3151 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -512,6 +512,47 @@ int fscache_write(struct netfs_cache_resources *cres,
 
 #endif /* FSCACHE_USE_NEW_IO_API */
 
+#if __fscache_available
+extern int fscache_set_page_dirty(struct page *page, struct fscache_cookie *cookie);
+#else
+#define fscache_set_page_dirty(PAGE, COOKIE) (__set_page_dirty_nobuffers((PAGE)))
+#endif
+
+/**
+ * fscache_unpin_writeback - Unpin writeback resources
+ * @wbc: The writeback control
+ * @cookie: The cookie referring to the cache object
+ *
+ * Unpin the writeback resources pinned by fscache_set_page_dirty().  This is
+ * intended to be called by the netfs's ->write_inode() method.
+ */
+static inline void fscache_unpin_writeback(struct writeback_control *wbc,
+					   struct fscache_cookie *cookie)
+{
+	if (wbc->unpinned_fscache_wb)
+		fscache_unuse_cookie(cookie, NULL, NULL);
+}
+
+/**
+ * fscache_clear_inode_writeback - Clear writeback resources pinned by an inode
+ * @cookie: The cookie referring to the cache object
+ * @inode: The inode to clean up
+ * @aux: Auxiliary data to apply to the inode
+ *
+ * Clear any writeback resources held by an inode when the inode is evicted.
+ * This must be called before clear_inode() is called.
+ */
+static inline void fscache_clear_inode_writeback(struct fscache_cookie *cookie,
+						 struct inode *inode,
+						 const void *aux)
+{
+	if (inode->i_state & I_PINNING_FSCACHE_WB) {
+		loff_t i_size = i_size_read(inode);
+		fscache_unuse_cookie(cookie, aux, &i_size);
+	}
+
+}
+
 #ifdef FSCACHE_USE_FALLBACK_IO_API
 
 /**


