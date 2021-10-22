Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA67437D99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhJVTH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234125AbhJVTHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjuM0Z1Ol4Mfqz9YrQA7/+R9GNqZnkOBaFnc7EjRc70=;
        b=U6JSs0BUWu4OaCAkhamxhZ4JicAdVFksPWmOoL+6Bp4DHv8Y1sGLmAQ7b4uAqLrnOfTzpm
        juJlzwL0NmUYkqZOO6cBAbnsAs6sArMQerQpiu4n88sHctXWkg8g0YUDE8MaL0a/rZZBpD
        mcfb0zweX4uvNd3x6zCItFeuNc4oEMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-PC8YlrGYOumCFMPqCm78zA-1; Fri, 22 Oct 2021 15:05:22 -0400
X-MC-Unique: PC8YlrGYOumCFMPqCm78zA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56CA2801FCE;
        Fri, 22 Oct 2021 19:05:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71C7E7092B;
        Fri, 22 Oct 2021 19:05:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 26/53] vfs,
 fscache: Implement pinning of cache usage for writeback
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Oct 2021 20:05:08 +0100
Message-ID: <163492950845.1038219.15215875412425428905.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cachefiles has a problem in that it needs to keep the backing file for a
cookie open whilst there are local modifications pending that need to be
written to it.  However, we don't want to keep the file open indefinitely,
as that causes EMFILE/ENFILE/ENOMEM problems.

Reopening the cache file, however, is a problem if this is being done due
to writeback triggered by exit().  Some filesystems will oops if we try to
open a file in that context because they want to access current->fs or
other resources that have already been dismantled.

To get around this, I added the following:

 (1) An inode flag, I_PINNING_FSCACHE_WB, to be set on a network filesystem
     inode to indicate that we have a usage count on the cookie caching
     that inode.

 (2) A flag in struct writeback_control, unpinned_fscache_wb, that is set
     when __writeback_single_inode() clears the last dirty page from
     i_pages - at which point it clears I_PINNING_FSCACHE_WB and sets this
     flag.

     This has to be done here so that clearing I_PINNING_FSCACHE_WB can be
     done atomically with the check of PAGECACHE_TAG_DIRTY that clears
     I_DIRTY_PAGES.

 (3) A function, fscache_set_page_dirty(), which if it is not set, sets
     I_PINNING_FSCACHE_WB and calls fscache_use_cookie() to pin the cache
     resources.

 (4) A function, fscache_unpin_writeback(), to be called by ->write_inode()
     to unuse the cookie.

 (5) A function, fscache_clear_inode_writeback(), to be called when the
     inode is evicted, before clear_inode() is called.  This cleans up any
     lingering I_PINNING_FSCACHE_WB.

The network filesystem can then use these tools to make sure that
fscache_write_to_cache() can write locally modified data to the cache as
well as to the server.

For the future, I'm working on write helpers for netfs lib that should
allow this facility to be removed by keeping track of the dirty regions
separately - but that's incomplete at the moment and is also going to be
affected by folios, one way or another, since it deals with pages

Signed-off-by: David Howells <dhowells@redhat.com>cc: linux-cachefs@redhat.com
---

 fs/fs-writeback.c           |    8 ++++++++
 fs/fscache/io.c             |   38 ++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h          |    3 +++
 include/linux/fscache.h     |   40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fscache_old.h |    1 +
 include/linux/writeback.h   |    1 +
 6 files changed, 91 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 81ec192ce067..f3122831c4fe 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1666,6 +1666,13 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 
 	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		inode->i_state |= I_DIRTY_PAGES;
+	else if (unlikely(inode->i_state & I_PINNING_FSCACHE_WB)) {
+		if (!(inode->i_state & I_DIRTY_PAGES)) {
+			inode->i_state &= ~I_PINNING_FSCACHE_WB;
+			wbc->unpinned_fscache_wb = true;
+			dirty |= I_PINNING_FSCACHE_WB; /* Cause write_inode */
+		}
+	}
 
 	spin_unlock(&inode->i_lock);
 
@@ -1675,6 +1682,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 		if (ret == 0)
 			ret = err;
 	}
+	wbc->unpinned_fscache_wb = false;
 	trace_writeback_single_inode(inode, wbc, nr_to_write);
 	return ret;
 }
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 0c128e61df81..5b7ecb8a205b 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -217,6 +217,44 @@ int __fscache_fallback_write_page(struct fscache_cookie *cookie, struct page *pa
 }
 EXPORT_SYMBOL(__fscache_fallback_write_page);
 
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
+
 struct fscache_write_request {
 	struct netfs_cache_resources cache_resources;
 	struct address_space	*mapping;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd2..908ea452a2cf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2419,6 +2419,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *			Used to detect that mark_inode_dirty() should not move
  * 			inode between dirty lists.
  *
+ * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2441,6 +2443,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_CREATING		(1 << 15)
 #define I_DONTCACHE		(1 << 16)
 #define I_SYNC_QUEUED		(1 << 17)
+#define I_PINNING_FSCACHE_WB	(1 << 18)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 2996b417c5d0..46a89b5d7cfb 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -559,6 +559,46 @@ static inline void fscache_write_to_cache(struct fscache_cookie *cookie,
 }
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
+}
+
 #ifdef FSCACHE_USE_FALLBACK_IO_API
 
 /**
diff --git a/include/linux/fscache_old.h b/include/linux/fscache_old.h
index 01558d155799..ba4878b56717 100644
--- a/include/linux/fscache_old.h
+++ b/include/linux/fscache_old.h
@@ -19,6 +19,7 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 #include <linux/list_bl.h>
+#include <linux/writeback.h>
 #include <linux/netfs.h>
 
 #if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index d1f65adf6a26..2fda288600d3 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -69,6 +69,7 @@ struct writeback_control {
 	unsigned for_reclaim:1;		/* Invoked from the page allocator */
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
+	unsigned unpinned_fscache_wb:1;	/* Cleared I_PINNING_FSCACHE_WB */
 
 	/*
 	 * When writeback IOs are bounced through async layers, only the


