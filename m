Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35852BAE98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgKTPRp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:17:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729569AbgKTPRo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=prtcvWIYR6gesJ4HmwUyCJ9G6MSDu9AVnPYB4lPA1DA=;
        b=JWtfdLzGYtvOjUxsOFOOQsSaxE0zl+niF4fGdZWVikHMzfr37lMuFVzp0LO3WtPHQlfJZi
        GOjqkgqc6QrsQ4TfnwKegBJK5NhZFPW0wg5wC+6PWbH/jnAphHnRFTUGD6/9PpUnSpxDZv
        9pJthQw8texechbt4qiK1EY/XDDt/i4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-gjj8eo7_OpyOVJOZLDS42g-1; Fri, 20 Nov 2020 10:17:40 -0500
X-MC-Unique: gjj8eo7_OpyOVJOZLDS42g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 026BC8144E3;
        Fri, 20 Nov 2020 15:17:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3EB35D9D5;
        Fri, 20 Nov 2020 15:17:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 69/76] fscache: Add support for writing to the cache
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
Date:   Fri, 20 Nov 2020 15:17:32 +0000
Message-ID: <160588545208.3465195.7723308498025669512.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a pair of helpers for use by a netfs to write data to the cache.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/content-map.c |   38 +++++++++++++
 fs/cachefiles/interface.c   |    1 
 fs/cachefiles/internal.h    |    2 +
 fs/fscache/io.c             |  128 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fscache.h     |   34 +++++++++++
 5 files changed, 203 insertions(+)

diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
index da0a81e3f751..d1e8a509a8cc 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -204,6 +204,44 @@ enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *sub
 	return NETFS_READ_FROM_CACHE;
 }
 
+/*
+ * Prepare for a write to occur.
+ */
+int cachefiles_prepare_write(struct fscache_op_resources *opr,
+			     loff_t *_start, size_t *_len, loff_t i_size)
+{
+	struct cachefiles_object *object =
+		container_of(opr->object, struct cachefiles_object, fscache);
+	loff_t start = *_start, map_limit;
+	size_t len = *_len, down;
+	long granule = start / CACHEFILES_GRAN_SIZE;
+
+	if (start >= CACHEFILES_SIZE_LIMIT)
+		return -ENOBUFS;
+
+	if (granule / 8 >= object->content_map_size) {
+		cachefiles_expand_content_map(object, i_size);
+		if (granule / 8 >= object->content_map_size)
+			return -ENOBUFS;
+	}
+
+	map_limit = object->content_map_size * 8 * CACHEFILES_GRAN_SIZE;
+	if (start >= map_limit)
+		return -ENOBUFS;
+	if (len > map_limit - start)
+		len = map_limit - start;
+
+	/* Assume that the preparation to write involved preloading any
+	 * bits of the cache that weren't to be written and filling any
+	 * gaps that didn't end up being written.
+	 */
+
+	down = start - round_down(start, CACHEFILES_DIO_BLOCK_SIZE);
+	*_start = start - down;
+	*_len = round_up(down + len, CACHEFILES_DIO_BLOCK_SIZE);
+	return 0;
+}
+
 /*
  * Allocate a new content map.
  */
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 3609ff2fb491..a9725ca72ad5 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -609,6 +609,7 @@ static const struct fscache_op_ops cachefiles_io_ops = {
 	.write			= cachefiles_write,
 	.expand_readahead	= cachefiles_expand_readahead,
 	.prepare_read		= cachefiles_prepare_read,
+	.prepare_write		= cachefiles_prepare_write,
 };
 
 static void cachefiles_begin_operation(struct fscache_op_resources *opr)
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index e2d06c0860a2..38149868c331 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -137,6 +137,8 @@ extern void cachefiles_mark_content_map(struct cachefiles_object *object,
 					loff_t start, loff_t len, unsigned int inval_counter);
 extern void cachefiles_expand_content_map(struct cachefiles_object *object, loff_t size);
 extern void cachefiles_shorten_content_map(struct cachefiles_object *object, loff_t new_size);
+extern int cachefiles_prepare_write(struct fscache_op_resources *opr,
+				    loff_t *_start, size_t *_len, loff_t i_size);
 extern bool cachefiles_load_content_map(struct cachefiles_object *object);
 extern void cachefiles_save_content_map(struct cachefiles_object *object);
 extern int cachefiles_display_object(struct seq_file *m, struct fscache_object *object);
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 5401c9ed347b..295a89af4269 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -10,6 +10,7 @@
 #include <linux/fscache-cache.h>
 #include <linux/slab.h>
 #include <linux/netfs.h>
+#include <linux/uio.h>
 #include "internal.h"
 
 /*
@@ -260,3 +261,130 @@ void __fscache_resize_cookie(struct fscache_cookie *cookie, loff_t new_size)
 	}
 }
 EXPORT_SYMBOL(__fscache_resize_cookie);
+
+struct fscache_write_request {
+	struct fscache_op_resources cache_resources;
+	struct address_space	*mapping;
+	loff_t			start;
+	size_t			len;
+	fscache_io_terminated_t	term_func;
+	void			*term_func_priv;
+};
+
+/**
+ * fscache_clear_page_bits - Clear the PG_fscache bits from a set of pages
+ * @mapping: The netfs inode to use as the source
+ * @start: The start position in @mapping
+ * @len: The amount of data to unlock
+ *
+ * Clear the PG_fscache flag from a sequence of pages and wake up anyone who's
+ * waiting.
+ */
+void __fscache_clear_page_bits(struct address_space *mapping,
+			       loff_t start, size_t len)
+{
+	pgoff_t first = start / PAGE_SIZE;
+	pgoff_t last = (start + len - 1) / PAGE_SIZE;
+	struct page *page;
+
+	if (len) {
+		XA_STATE(xas, &mapping->i_pages, first);
+
+		rcu_read_lock();
+		xas_for_each(&xas, page, last) {
+			unlock_page_fscache(page);
+		}
+		rcu_read_unlock();
+	}
+}
+EXPORT_SYMBOL(__fscache_clear_page_bits);
+
+/*
+ * Deal with the completion of writing the data to the cache.
+ */
+static void fscache_wreq_done(void *priv, ssize_t transferred_or_error)
+{
+	struct fscache_write_request *wreq = priv;
+
+	fscache_clear_page_bits(wreq->mapping, wreq->start, wreq->len);
+
+	if (wreq->term_func)
+		wreq->term_func(wreq->term_func_priv, transferred_or_error);
+	fscache_end_operation(&wreq->cache_resources);
+	kfree(wreq);
+}
+
+/**
+ * fscache_write_to_cache - Save a write to the cache and clear PG_fscache
+ * @cookie: The cookie representing the cache object
+ * @mapping: The netfs inode to use as the source
+ * @start: The start position in @mapping
+ * @len: The amount of data to write back
+ * @i_size: The new size of the inode
+ * @term_func: The function to call upon completion
+ * @term_func_priv: The private data for @term_func
+ *
+ * Helper function for a netfs to write dirty data from an inode into the cache
+ * object that's backing it.
+ *
+ * @start and @len describe the range of the data.  This does not need to be
+ * page-aligned, but to satisfy DIO requirements, the cache may expand it up to
+ * the page boundaries on either end.  All the pages covering the range must be
+ * marked with PG_fscache.
+ *
+ * If given, @term_func will be called upon completion and supplied with
+ * @term_func_priv.  Note that the PG_fscache flags will have been cleared by
+ * this point, so the netfs must retain its own pin on the mapping.
+ */
+void __fscache_write_to_cache(struct fscache_cookie *cookie,
+			      struct address_space *mapping,
+			      loff_t start, size_t len, loff_t i_size,
+			      fscache_io_terminated_t term_func,
+			      void *term_func_priv)
+{
+	struct fscache_write_request *wreq;
+	struct fscache_op_resources *opr;
+	struct iov_iter iter;
+	int ret = -ENOBUFS;
+
+	if (!fscache_cookie_valid(cookie) || len == 0)
+		goto abandon;
+
+	_enter("%llx,%zx", start, len);
+
+	wreq = kzalloc(sizeof(struct fscache_write_request), GFP_NOFS);
+	if (!wreq)
+		goto abandon;
+	wreq->mapping		= mapping;
+	wreq->start		= start;
+	wreq->len		= len;
+	wreq->term_func		= term_func;
+	wreq->term_func_priv	= term_func_priv;
+
+	opr = &wreq->cache_resources;
+	if (fscache_begin_operation(cookie, opr, FSCACHE_WANT_WRITE) < 0)
+		goto abandon_free;
+
+	ret = opr->ops->prepare_write(opr, &start, &len, i_size);
+	if (ret < 0)
+		goto abandon_end;
+
+	/* TODO: Consider clearing page bits now for space the write isn't
+	 * covering.  This is more complicated than it appears when THPs are
+	 * taken into account.
+	 */
+
+	iov_iter_xarray(&iter, WRITE, &mapping->i_pages, start, len);
+	fscache_write(opr, start, &iter, fscache_wreq_done, wreq);
+	return;
+
+abandon_end:
+	return fscache_wreq_done(wreq, ret);
+abandon_free:
+	kfree(wreq);
+abandon:
+	fscache_clear_page_bits(mapping, start, len);
+	if (term_func)
+		term_func(term_func_priv, ret);
+}
+EXPORT_SYMBOL(__fscache_write_to_cache);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 1c1ea3558421..0613ccea88c1 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -192,6 +192,12 @@ struct fscache_op_ops {
 	 */
 	enum netfs_read_source (*prepare_read)(struct netfs_read_subrequest *subreq,
 					       loff_t i_size);
+
+	/* Prepare a write operation, working out what part of the write we can
+	 * actually do.
+	 */
+	int (*prepare_write)(struct fscache_op_resources *opr,
+			     loff_t *_start, size_t *_len, loff_t i_size);
 };
 
 /*
@@ -226,6 +232,10 @@ extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t,
 extern void fscache_put_super(struct super_block *,
 			      struct fscache_cookie *(*get_cookie)(struct inode *));
 
+extern void __fscache_write_to_cache(struct fscache_cookie *, struct address_space *,
+				     loff_t, size_t, loff_t, fscache_io_terminated_t, void *);
+extern void __fscache_clear_page_bits(struct address_space *, loff_t, size_t);
+
 /**
  * fscache_register_netfs - Register a filesystem as desiring caching services
  * @netfs: The description of the filesystem
@@ -627,6 +637,30 @@ int fscache_write(struct fscache_op_resources *opr,
 	return ops->write(opr, start_pos, iter, term_func, term_func_priv);
 }
 
+static inline void fscache_clear_page_bits(struct address_space *mapping,
+					   loff_t start, size_t len)
+{
+	if (fscache_available())
+		__fscache_clear_page_bits(mapping, start, len);
+}
+
+static inline void fscache_write_to_cache(struct fscache_cookie *cookie,
+					  struct address_space *mapping,
+					  loff_t start, size_t len, loff_t i_size,
+					  fscache_io_terminated_t term_func,
+					  void *term_func_priv)
+{
+	if (fscache_available()) {
+		__fscache_write_to_cache(cookie, mapping, start, len, i_size,
+					 term_func, term_func_priv);
+	} else {
+		fscache_clear_page_bits(mapping, start, len);
+		if (term_func)
+			term_func(term_func_priv, -ENOBUFS);
+	}
+
+}
+
 #if __fscache_available
 extern int fscache_set_page_dirty(struct page *page, struct fscache_cookie *cookie);
 #else


