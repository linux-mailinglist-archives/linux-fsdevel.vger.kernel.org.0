Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0B54321B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhJRPGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233465AbhJRPFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ta+4wHdynNPy0bFW+9M1HIOAo1s/OgHB0kjMN761Lqw=;
        b=c6HOpioJRd13er5xluMYyJsmjLIC/NBT9XwNMoMq0vQVEXn9Jxgf+Z1o4H+uMUsCjIfZyo
        fC/nUbw4kf8OFe1vbLeaIJy2rt+2UNFZT8uPyIctGxgXbGSeXlqz9m3PtIqRWji6ArDYqJ
        WZ4Vnwip+mH+oRdo48nY0IcpQhCgnjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-hNT8YbiVPr2lt9d5R-wRbQ-1; Mon, 18 Oct 2021 11:03:21 -0400
X-MC-Unique: hNT8YbiVPr2lt9d5R-wRbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75F231018720;
        Mon, 18 Oct 2021 15:03:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0E675DF21;
        Mon, 18 Oct 2021 15:02:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 49/67] fscache: Add support for writing to the cache
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
Date:   Mon, 18 Oct 2021 16:02:27 +0100
Message-ID: <163456934704.2614702.13459517221637847782.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
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

 fs/fscache/io.c         |  100 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fscache.h |   58 +++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)

diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 8b1a865a0847..3910cba65545 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -11,6 +11,7 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
+#include <linux/uio.h>
 #include "internal.h"
 
 /**
@@ -278,3 +279,102 @@ void __fscache_resize_cookie(struct fscache_cookie *cookie, loff_t new_size)
 	}
 }
 EXPORT_SYMBOL(__fscache_resize_cookie);
+
+struct fscache_write_request {
+	struct netfs_cache_resources cache_resources;
+	struct address_space	*mapping;
+	loff_t			start;
+	size_t			len;
+	netfs_io_terminated_t	term_func;
+	void			*term_func_priv;
+};
+
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
+			end_page_fscache(page);
+		}
+		rcu_read_unlock();
+	}
+}
+EXPORT_SYMBOL(__fscache_clear_page_bits);
+
+/*
+ * Deal with the completion of writing the data to the cache.
+ */
+static void fscache_wreq_done(void *priv, ssize_t transferred_or_error,
+			      bool was_async)
+{
+	struct fscache_write_request *wreq = priv;
+
+	fscache_clear_page_bits(wreq->mapping, wreq->start, wreq->len);
+
+	if (wreq->term_func)
+		wreq->term_func(wreq->term_func_priv, transferred_or_error,
+				was_async);
+	fscache_end_operation(&wreq->cache_resources);
+	kfree(wreq);
+}
+
+void __fscache_write_to_cache(struct fscache_cookie *cookie,
+			      struct address_space *mapping,
+			      loff_t start, size_t len, loff_t i_size,
+			      netfs_io_terminated_t term_func,
+			      void *term_func_priv)
+{
+	struct fscache_write_request *wreq;
+	struct netfs_cache_resources *cres;
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
+	cres = &wreq->cache_resources;
+	if (fscache_begin_operation(cres, cookie, FSCACHE_WANT_WRITE,
+				    fscache_access_io_write) < 0)
+		goto abandon_free;
+
+	ret = cres->ops->prepare_write(cres, &start, &len, i_size, false);
+	if (ret < 0)
+		goto abandon_end;
+
+	/* TODO: Consider clearing page bits now for space the write isn't
+	 * covering.  This is more complicated than it appears when THPs are
+	 * taken into account.
+	 */
+
+	iov_iter_xarray(&iter, WRITE, &mapping->i_pages, start, len);
+	fscache_write(cres, start, &iter, fscache_wreq_done, wreq);
+	return;
+
+abandon_end:
+	return fscache_wreq_done(wreq, ret, false);
+abandon_free:
+	kfree(wreq);
+abandon:
+	fscache_clear_page_bits(mapping, start, len);
+	if (term_func)
+		term_func(term_func_priv, ret, false);
+}
+EXPORT_SYMBOL(__fscache_write_to_cache);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 8ab691e52cc5..fe4d588641da 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -176,6 +176,10 @@ extern int __fscache_fallback_read_page(struct fscache_cookie *, struct page *);
 extern int __fscache_fallback_write_page(struct fscache_cookie *, struct page *);
 #endif
 
+extern void __fscache_write_to_cache(struct fscache_cookie *, struct address_space *,
+				     loff_t, size_t, loff_t, netfs_io_terminated_t, void *);
+extern void __fscache_clear_page_bits(struct address_space *, loff_t, size_t);
+
 /**
  * fscache_acquire_volume - Register a volume as desiring caching services
  * @volume_key: An identification string for the volume
@@ -543,6 +547,60 @@ int fscache_write(struct netfs_cache_resources *cres,
 	return ops->write(cres, start_pos, iter, term_func, term_func_priv);
 }
 
+/**
+ * fscache_clear_page_bits - Clear the PG_fscache bits from a set of pages
+ * @mapping: The netfs inode to use as the source
+ * @start: The start position in @mapping
+ * @len: The amount of data to unlock
+ *
+ * Clear the PG_fscache flag from a sequence of pages and wake up anyone who's
+ * waiting.
+ */
+static inline void fscache_clear_page_bits(struct address_space *mapping,
+					   loff_t start, size_t len)
+{
+	if (fscache_available())
+		__fscache_clear_page_bits(mapping, start, len);
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
+static inline void fscache_write_to_cache(struct fscache_cookie *cookie,
+					  struct address_space *mapping,
+					  loff_t start, size_t len, loff_t i_size,
+					  netfs_io_terminated_t term_func,
+					  void *term_func_priv)
+{
+	if (fscache_available()) {
+		__fscache_write_to_cache(cookie, mapping, start, len, i_size,
+					 term_func, term_func_priv);
+	} else {
+		fscache_clear_page_bits(mapping, start, len);
+		if (term_func)
+			term_func(term_func_priv, -ENOBUFS, false);
+	}
+
+}
 #endif /* FSCACHE_USE_NEW_IO_API */
 
 #if __fscache_available


