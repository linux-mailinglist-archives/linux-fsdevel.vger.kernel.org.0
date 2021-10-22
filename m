Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8D5437D91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbhJVTHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232461AbhJVTH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+EtOHSphb6Q0NtS/equNMZvHtnI/Q3HIjX9WVypO5RQ=;
        b=IJ36X5gXwUeBOypmJ2/t0T5V4NtnBe3XJj0nCj80FDIa8MnomYt5y+qvd/h49C57PFTjtH
        0pjKxY/RFzIHS/bxHdoBiRzSnWtJtoP+DsXV66pBTwnRwsKSIk5RNdqkDNTs3Q5zHZitgU
        kM97th2eeL0q28FsiXnyTjFZ3qY9Ztk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-m22tksXfOniOuIbfClVuHg-1; Fri, 22 Oct 2021 15:05:05 -0400
X-MC-Unique: m22tksXfOniOuIbfClVuHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B329802B4F;
        Fri, 22 Oct 2021 19:05:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4914460C04;
        Fri, 22 Oct 2021 19:04:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 25/53] fscache: Provide fallback I/O functions
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
Date:   Fri, 22 Oct 2021 20:04:54 +0100
Message-ID: <163492949429.1038219.2330338330511845559.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide functions to perform fallback I/O:

	int fscache_fallback_read_page(struct fscache_cookie *cookie,
				       struct page *page);
	int fscache_fallback_write_page(struct fscache_cookie *cookie,
					struct page *page);

These read and write a page to the cache described by the cookie.  The page
index and size indicate the size and location of the operation.  They operate
synchronously.

[!] NOTE: These should be considered dangerous and may malfunction if the
cache is backed by an extent-based filesystem such as ext4, xfs or btrfs due
to the disk filesystem inserting or removing bridging blocks of zeros to
optimise the extent layout.  This can cause data corruption.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/io.c         |   66 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fscache.h |   48 ++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 0c74dbb91fea..0c128e61df81 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -151,6 +151,72 @@ int __fscache_begin_read_operation(struct netfs_cache_resources *cres,
 }
 EXPORT_SYMBOL(__fscache_begin_read_operation);
 
+/*
+ * Fallback page reading interface.
+ */
+int __fscache_fallback_read_page(struct fscache_cookie *cookie, struct page *page)
+{
+	struct netfs_cache_resources cres;
+	struct iov_iter iter;
+	struct bio_vec bvec[1];
+	int ret;
+
+	_enter("%lx", page->index);
+
+	memset(&cres, 0, sizeof(cres));
+	bvec[0].bv_page		= page;
+	bvec[0].bv_offset	= 0;
+	bvec[0].bv_len		= PAGE_SIZE;
+	iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+
+	ret = fscache_begin_operation(&cres, cookie, FSCACHE_WANT_READ,
+				      fscache_access_io_write);
+	if (ret < 0)
+		return ret;
+
+	ret = fscache_read(&cres, page_offset(page), &iter, NETFS_READ_HOLE_FAIL,
+			   NULL, NULL);
+	fscache_end_operation(&cres);
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(__fscache_fallback_read_page);
+
+/*
+ * Fallback page writing interface.
+ */
+int __fscache_fallback_write_page(struct fscache_cookie *cookie, struct page *page)
+{
+	struct netfs_cache_resources cres;
+	struct iov_iter iter;
+	struct bio_vec bvec[1];
+	int ret;
+
+	_enter("%lx", page->index);
+
+	memset(&cres, 0, sizeof(cres));
+	bvec[0].bv_page		= page;
+	bvec[0].bv_offset	= 0;
+	bvec[0].bv_len		= PAGE_SIZE;
+	iov_iter_bvec(&iter, WRITE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+
+	ret = fscache_begin_operation(&cres, cookie, FSCACHE_WANT_WRITE,
+				      fscache_access_io_write);
+	if (ret < 0)
+		return ret;
+
+	ret = cres.ops->prepare_fallback_write(&cres, page_index(page));
+	if (ret < 0)
+		goto out;
+
+	ret = fscache_write(&cres, page_offset(page), &iter, NULL, NULL);
+out:
+	fscache_end_operation(&cres);
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(__fscache_fallback_write_page);
+
 struct fscache_write_request {
 	struct netfs_cache_resources cache_resources;
 	struct address_space	*mapping;
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index b3b625d0834c..2996b417c5d0 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -171,6 +171,10 @@ extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t,
 #ifdef FSCACHE_USE_NEW_IO_API
 extern int __fscache_begin_read_operation(struct netfs_cache_resources *, struct fscache_cookie *);
 #endif
+#ifdef FSCACHE_USE_FALLBACK_IO_API
+extern int __fscache_fallback_read_page(struct fscache_cookie *, struct page *);
+extern int __fscache_fallback_write_page(struct fscache_cookie *, struct page *);
+#endif
 
 extern void __fscache_write_to_cache(struct fscache_cookie *, struct address_space *,
 				     loff_t, size_t, loff_t, netfs_io_terminated_t, void *);
@@ -555,4 +559,48 @@ static inline void fscache_write_to_cache(struct fscache_cookie *cookie,
 }
 #endif /* FSCACHE_USE_NEW_IO_API */
 
+#ifdef FSCACHE_USE_FALLBACK_IO_API
+
+/**
+ * fscache_fallback_read_page - Read a page from a cache object (DANGEROUS)
+ * @cookie: The cookie representing the cache object
+ * @page: The page to be read to
+ *
+ * Synchronously read a page from the cache.  The page's offset is used to
+ * indicate where to read.
+ *
+ * This is dangerous and should be moved away from as it relies on the
+ * assumption that the backing filesystem will exactly record the blocks we
+ * have stored there.
+ */
+static inline
+int fscache_fallback_read_page(struct fscache_cookie *cookie, struct page *page)
+{
+	if (fscache_cookie_enabled(cookie))
+		return __fscache_fallback_read_page(cookie, page);
+	return -ENOBUFS;
+}
+
+/**
+ * fscache_fallback_write_page - Write a page to a cache object (DANGEROUS)
+ * @cookie: The cookie representing the cache object
+ * @page: The page to be written from
+ *
+ * Synchronously write a page to the cache.  The page's offset is used to
+ * indicate where to write.
+ *
+ * This is dangerous and should be moved away from as it relies on the
+ * assumption that the backing filesystem will exactly record the blocks we
+ * have stored there.
+ */
+static inline
+int fscache_fallback_write_page(struct fscache_cookie *cookie, struct page *page)
+{
+	if (fscache_cookie_enabled(cookie))
+		return __fscache_fallback_write_page(cookie, page);
+	return -ENOBUFS;
+}
+
+#endif /* FSCACHE_USE_FALLBACK_IO_API */
+
 #endif /* _LINUX_FSCACHE_H */


