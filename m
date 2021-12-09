Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E9A46EF1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 17:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241877AbhLIRDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:03:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241901AbhLIRC7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vd921sogBTg+kYlITr+cbEKdv56Dclb9wuDNgVUrOLM=;
        b=PZE7pQ4TJFLhPLSiW+np2gGrJqnB9NLfRhqDqWRVRAQlff5R3tty9KcwzQ8Kl6BGoyJ43A
        8h9af6bRH4M6PahwqvUpQSxjVeG008obT/r2v1VDxYupv2s79YEdXvkB85UateWW8zj0cE
        nMnCAWHFNV0d1R+s28NqK3A1oc7WpbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-moYGQ1mkP0KlwufHS2jztQ-1; Thu, 09 Dec 2021 11:59:20 -0500
X-MC-Unique: moYGQ1mkP0KlwufHS2jztQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D8B810144E2;
        Thu,  9 Dec 2021 16:59:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A10295D6D5;
        Thu,  9 Dec 2021 16:59:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 25/67] fscache: Implement raw I/O interface
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
Date:   Thu, 09 Dec 2021 16:59:13 +0000
Message-ID: <163906915386.143852.16936177636106480724.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a pair of functions to perform raw I/O on the cache.  The first
function allows an arbitrary asynchronous direct-IO read to be made against
a cache object, though the read should be aligned and sized appropriately
for the backing device:

        int fscache_read(struct netfs_cache_resources *cres,
                         loff_t start_pos,
                         struct iov_iter *iter,
                         enum netfs_read_from_hole read_hole,
                         netfs_io_terminated_t term_func,
                         void *term_func_priv);

The cache resources must have been previously initialised by
fscache_begin_read_operation().  A read operation is sent to the backing
filesystem, starting at start_pos within the file.  The size of the read is
specified by the iterator, as is the location of the output buffer.

If there is a hole in the data it can be ignored and left to the backing
filesystem to deal with (NETFS_READ_HOLE_IGNORE), a hole at the beginning
can be skipped over and the buffer padded with zeros
(NETFS_READ_HOLE_CLEAR) or -ENODATA can be given (NETFS_READ_HOLE_FAIL).

If term_func is not NULL, the operation may be performed asynchronously.
Upon completion, successful or otherwise, (*term_func)() will be called and
passed term_func_priv, along with an error or the amount of data
transferred.  If the op is run asynchronously, fscache_read() will return
-EIOCBQUEUED.

The second function allows an arbitrary asynchronous direct-IO write to be
made against a cache object, though the write should be aligned and sized
appropriately for the backing device:

        int fscache_write(struct netfs_cache_resources *cres,
                          loff_t start_pos,
                          struct iov_iter *iter,
                          netfs_io_terminated_t term_func,
                          void *term_func_priv);

This works in very similar way to fscache_read(), except that there's no
need to deal with holes (they're just overwritten).

The caller is responsible for preventing concurrent overlapping writes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819613224.215744.7877577215582621254.stgit@warthog.procyon.org.uk/ # v1
---

 include/linux/fscache.h        |   74 ++++++++++++++++++++++++++++++++++++++++
 include/trace/events/fscache.h |    2 +
 2 files changed, 76 insertions(+)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index ceb1966acc52..55ea296fe4db 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -425,4 +425,78 @@ int fscache_begin_read_operation(struct netfs_cache_resources *cres,
 	return -ENOBUFS;
 }
 
+/**
+ * fscache_read - Start a read from the cache.
+ * @cres: The cache resources to use
+ * @start_pos: The beginning file offset in the cache file
+ * @iter: The buffer to fill - and also the length
+ * @read_hole: How to handle a hole in the data.
+ * @term_func: The function to call upon completion
+ * @term_func_priv: The private data for @term_func
+ *
+ * Start a read from the cache.  @cres indicates the cache object to read from
+ * and must be obtained by a call to fscache_begin_operation() beforehand.
+ *
+ * The data is read into the iterator, @iter, and that also indicates the size
+ * of the operation.  @start_pos is the start position in the file, though if
+ * @seek_data is set appropriately, the cache can use SEEK_DATA to find the
+ * next piece of data, writing zeros for the hole into the iterator.
+ *
+ * Upon termination of the operation, @term_func will be called and supplied
+ * with @term_func_priv plus the amount of data written, if successful, or the
+ * error code otherwise.
+ *
+ * @read_hole indicates how a partially populated region in the cache should be
+ * handled.  It can be one of a number of settings:
+ *
+ *	NETFS_READ_HOLE_IGNORE - Just try to read (may return a short read).
+ *
+ *	NETFS_READ_HOLE_CLEAR - Seek for data, clearing the part of the buffer
+ *				skipped over, then do as for IGNORE.
+ *
+ *	NETFS_READ_HOLE_FAIL - Give ENODATA if we encounter a hole.
+ */
+static inline
+int fscache_read(struct netfs_cache_resources *cres,
+		 loff_t start_pos,
+		 struct iov_iter *iter,
+		 enum netfs_read_from_hole read_hole,
+		 netfs_io_terminated_t term_func,
+		 void *term_func_priv)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	return ops->read(cres, start_pos, iter, read_hole,
+			 term_func, term_func_priv);
+}
+
+/**
+ * fscache_write - Start a write to the cache.
+ * @cres: The cache resources to use
+ * @start_pos: The beginning file offset in the cache file
+ * @iter: The data to write - and also the length
+ * @term_func: The function to call upon completion
+ * @term_func_priv: The private data for @term_func
+ *
+ * Start a write to the cache.  @cres indicates the cache object to write to and
+ * must be obtained by a call to fscache_begin_operation() beforehand.
+ *
+ * The data to be written is obtained from the iterator, @iter, and that also
+ * indicates the size of the operation.  @start_pos is the start position in
+ * the file.
+ *
+ * Upon termination of the operation, @term_func will be called and supplied
+ * with @term_func_priv plus the amount of data written, if successful, or the
+ * error code otherwise.
+ */
+static inline
+int fscache_write(struct netfs_cache_resources *cres,
+		  loff_t start_pos,
+		  struct iov_iter *iter,
+		  netfs_io_terminated_t term_func,
+		  void *term_func_priv)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	return ops->write(cres, start_pos, iter, term_func, term_func_priv);
+}
+
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 9f78c903b00a..2459d75659cf 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -79,6 +79,7 @@ enum fscache_access_trace {
 	fscache_access_io_not_live,
 	fscache_access_io_read,
 	fscache_access_io_wait,
+	fscache_access_io_write,
 	fscache_access_lookup_cookie,
 	fscache_access_lookup_cookie_end,
 	fscache_access_lookup_cookie_end_failed,
@@ -149,6 +150,7 @@ enum fscache_access_trace {
 	EM(fscache_access_io_not_live,		"END   io_notl")	\
 	EM(fscache_access_io_read,		"BEGIN io_read")	\
 	EM(fscache_access_io_wait,		"WAIT  io     ")	\
+	EM(fscache_access_io_write,		"BEGIN io_writ")	\
 	EM(fscache_access_lookup_cookie,	"BEGIN lookup ")	\
 	EM(fscache_access_lookup_cookie_end,	"END   lookup ")	\
 	EM(fscache_access_lookup_cookie_end_failed,"END   lookupf")	\


