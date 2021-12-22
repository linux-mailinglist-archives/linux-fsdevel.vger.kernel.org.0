Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE0347DA53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 00:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245012AbhLVXVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Dec 2021 18:21:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245043AbhLVXVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640215261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BxWL4NZFkXVhiD5tuKkZk/3sS19WSw1GTC7RwwFLIAo=;
        b=YkuFqU/KPjhrH909Fj3542bvtqkyMuS6ILW+U/rhrdpyXBnJ6Ffv0h1wBVjL+1pRuZHbqA
        3QFvKAD924ItZNHClluP3FWv6xi90i4EeSmN9yTG+egQbm4n8LfoWoxXoFuxbS3/zhsAUi
        Gfp/GZEEoL4/4HAa5zXyhkgwLzhTbZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-SJ_Fp9rWPmGDwuh3xaLyFA-1; Wed, 22 Dec 2021 18:20:56 -0500
X-MC-Unique: SJ_Fp9rWPmGDwuh3xaLyFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 644711006AA4;
        Wed, 22 Dec 2021 23:20:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5713838FE;
        Wed, 22 Dec 2021 23:20:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 27/68] vfs,
 fscache: Implement pinning of cache usage for writeback
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Dec 2021 23:20:47 +0000
Message-ID: <164021524705.640689.17824932021727663017.stgit@warthog.procyon.org.uk>
In-Reply-To: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819615157.215744.17623791756928043114.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906917856.143852.8224898306177154573.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163967124567.1823006.14188359004568060298.stgit@warthog.procyon.org.uk/ # v3
---

 fs/fs-writeback.c         |    8 ++++++++
 fs/fscache/io.c           |   38 ++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h        |    3 +++
 include/linux/fscache.h   |   41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/writeback.h |    1 +
 5 files changed, 91 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 67f0e88eed01..8294a60ce323 100644
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
index 74cde7acf434..e9e5d6758ea8 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -150,6 +150,44 @@ int __fscache_begin_read_operation(struct netfs_cache_resources *cres,
 }
 EXPORT_SYMBOL(__fscache_begin_read_operation);
 
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
index bbf812ce89a8..2c0b8e77d9ab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2418,6 +2418,8 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *			Used to detect that mark_inode_dirty() should not move
  * 			inode between dirty lists.
  *
+ * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2440,6 +2442,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_CREATING		(1 << 15)
 #define I_DONTCACHE		(1 << 16)
 #define I_SYNC_QUEUED		(1 << 17)
+#define I_PINNING_FSCACHE_WB	(1 << 18)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 9d469613e16c..18e725671594 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -16,6 +16,7 @@
 
 #include <linux/fs.h>
 #include <linux/netfs.h>
+#include <linux/writeback.h>
 
 #if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
 #define __fscache_available (1)
@@ -566,4 +567,44 @@ static inline void fscache_write_to_cache(struct fscache_cookie *cookie,
 
 }
 
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
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 3bfd487d1dd2..fec248ab1fec 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -68,6 +68,7 @@ struct writeback_control {
 	unsigned for_reclaim:1;		/* Invoked from the page allocator */
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
+	unsigned unpinned_fscache_wb:1;	/* Cleared I_PINNING_FSCACHE_WB */
 
 	/*
 	 * When writeback IOs are bounced through async layers, only the


