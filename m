Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C690546EF32
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbhLIRD2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:03:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241965AbhLIRDM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GP02KiJbnJYBAOGMQqE1u41IRwItBMwpwRb7K4M2Rzo=;
        b=IAKwsUUuhDXab8Si9BtrDaoP6m6GsPGoaws+7sBpTSVJJN68IuPs2yqCXkWIWO2vOctMbu
        OBEYLwanC5PrLj+SJVC/2I/tAhr1wfdce2pBp57YhDQZ3X6cWvKNngkWWoEe/EOEsWBSVm
        5YD3uqGw5LUsOgz8sa8LfpGRoQIsNJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-65HGJa4XMt2W4MbCOnFUgA-1; Thu, 09 Dec 2021 11:59:35 -0500
X-MC-Unique: 65HGJa4XMt2W4MbCOnFUgA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53CDC10144E1;
        Thu,  9 Dec 2021 16:59:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F44660657;
        Thu,  9 Dec 2021 16:59:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 26/67] fscache: Implement higher-level write I/O interface
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
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
Date:   Thu, 09 Dec 2021 16:59:23 +0000
Message-ID: <163906916346.143852.15632773570362489926.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a higher-level function than fscache_write() to perform a write
from an inode's pagecache to the cache, whilst fending off concurrent
writes by means of the PG_fscache mark on a page:

	void fscache_write_to_cache(struct fscache_cookie *cookie,
				    struct address_space *mapping,
				    loff_t start,
				    size_t len,
				    loff_t i_size,
				    netfs_io_terminated_t term_func,
				    void *term_func_priv,
				    bool caching);

If caching is false, this function does nothing except call (*term_func)()
if given.  It assumes that, in such a case, PG_fscache will not have been
set on the pages.

Otherwise, if caching is true, this function requires the source pages to
have had PG_fscache set on them before calling.  start and len define the
region of the file to be modified and i_size indicates the new file size.
The source pages are extracted from the mapping.

term_func and term_func_priv work as for fscache_write().  The PG_fscache
marks will be cleared at the end of the operation, before term_func is
called or the function otherwise returns.

There is an additonal helper function to clear the PG_fscache bits from a
range of pages:

	void fscache_clear_page_bits(struct fscache_cookie *cookie,
				     struct address_space *mapping,
				     loff_t start, size_t len,
				     bool caching);

If caching is true, the pages to be managed are expected to be located on
mapping in the range defined by start and len.  If caching is false, it
does nothing.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819614155.215744.5528123235123721230.stgit@warthog.procyon.org.uk/ # v1
---

 fs/fscache/io.c         |  104 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fscache.h |   63 ++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+)

diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 460a43473019..74cde7acf434 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -149,3 +149,107 @@ int __fscache_begin_read_operation(struct netfs_cache_resources *cres,
 				       fscache_access_io_read);
 }
 EXPORT_SYMBOL(__fscache_begin_read_operation);
+
+struct fscache_write_request {
+	struct netfs_cache_resources cache_resources;
+	struct address_space	*mapping;
+	loff_t			start;
+	size_t			len;
+	bool			set_bits;
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
+	fscache_clear_page_bits(fscache_cres_cookie(&wreq->cache_resources),
+				wreq->mapping, wreq->start, wreq->len,
+				wreq->set_bits);
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
+			      void *term_func_priv,
+			      bool cond)
+{
+	struct fscache_write_request *wreq;
+	struct netfs_cache_resources *cres;
+	struct iov_iter iter;
+	int ret = -ENOBUFS;
+
+	if (len == 0)
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
+	wreq->set_bits		= cond;
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
+	fscache_clear_page_bits(cookie, mapping, start, len, cond);
+	if (term_func)
+		term_func(term_func_priv, ret, false);
+}
+EXPORT_SYMBOL(__fscache_write_to_cache);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 55ea296fe4db..1a018964d418 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -164,6 +164,11 @@ extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t, unsigned int);
 extern int __fscache_begin_read_operation(struct netfs_cache_resources *, struct fscache_cookie *);
 
+extern void __fscache_write_to_cache(struct fscache_cookie *, struct address_space *,
+				     loff_t, size_t, loff_t, netfs_io_terminated_t, void *,
+				     bool);
+extern void __fscache_clear_page_bits(struct address_space *, loff_t, size_t);
+
 /**
  * fscache_acquire_volume - Register a volume as desiring caching services
  * @volume_key: An identification string for the volume
@@ -499,4 +504,62 @@ int fscache_write(struct netfs_cache_resources *cres,
 	return ops->write(cres, start_pos, iter, term_func, term_func_priv);
 }
 
+/**
+ * fscache_clear_page_bits - Clear the PG_fscache bits from a set of pages
+ * @cookie: The cookie representing the cache object
+ * @mapping: The netfs inode to use as the source
+ * @start: The start position in @mapping
+ * @len: The amount of data to unlock
+ * @caching: If PG_fscache has been set
+ *
+ * Clear the PG_fscache flag from a sequence of pages and wake up anyone who's
+ * waiting.
+ */
+static inline void fscache_clear_page_bits(struct fscache_cookie *cookie,
+					   struct address_space *mapping,
+					   loff_t start, size_t len,
+					   bool caching)
+{
+	if (caching)
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
+ * @caching: If PG_fscache has been set
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
+					  void *term_func_priv,
+					  bool caching)
+{
+	if (caching)
+		__fscache_write_to_cache(cookie, mapping, start, len, i_size,
+					 term_func, term_func_priv, caching);
+	else if (term_func)
+		term_func(term_func_priv, -ENOBUFS, false);
+
+}
+
 #endif /* _LINUX_FSCACHE_H */


