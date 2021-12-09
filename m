Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4A246EF67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbhLIRER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:04:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241990AbhLIREJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5oGKicqT5K5hg8GsON7+ysTZJszf7/nyM29VGtzQujs=;
        b=hnJjcT+Z0vZ1CShOQHWxFN/0PQyFX7tPotHyR2xEAZlXIy3xUV03mR1KBcIgjCXTSBbTTY
        rqhXJ6la/b+nTMxhgON3qzwbc81FROcUksV5CSWy788y89PSaxlhqTBbyk8P2nVgnNbiJL
        zqMwjmYcfr+/de5lEJdFPUP3d389t0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-3pDGLpE9P7G1OAv_91_kfQ-1; Thu, 09 Dec 2021 12:00:32 -0500
X-MC-Unique: 3pDGLpE9P7G1OAv_91_kfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E4B3802C8F;
        Thu,  9 Dec 2021 17:00:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B29DD4ABA1;
        Thu,  9 Dec 2021 17:00:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 29/67] fscache: Provide a function to resize a cookie
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
Date:   Thu, 09 Dec 2021 17:00:23 +0000
Message-ID: <163906922387.143852.16394459879816147793.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a function to change the size of the storage attached to a cookie,
to match the size of the file being cached when it's changed by truncate or
fallocate:

	void fscache_resize_cookie(struct fscache_cookie *cookie,
				   loff_t new_size);

This acts synchronously and is expected to run under the inode lock of the
caller.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819621839.215744.7895597119803515402.stgit@warthog.procyon.org.uk/ # v1
---

 fs/fscache/internal.h          |    3 +++
 fs/fscache/io.c                |   25 +++++++++++++++++++++++++
 fs/fscache/stats.c             |    9 +++++++--
 include/linux/fscache-cache.h  |    4 ++++
 include/linux/fscache.h        |   18 ++++++++++++++++++
 include/trace/events/fscache.h |   25 +++++++++++++++++++++++++
 6 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 1308bfff94fb..87884f4b34fb 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -122,6 +122,9 @@ extern atomic_t fscache_n_relinquishes;
 extern atomic_t fscache_n_relinquishes_retire;
 extern atomic_t fscache_n_relinquishes_dropped;
 
+extern atomic_t fscache_n_resizes;
+extern atomic_t fscache_n_resizes_null;
+
 static inline void fscache_stat(atomic_t *stat)
 {
 	atomic_inc(stat);
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index e9e5d6758ea8..bed7628a5a9d 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -291,3 +291,28 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 		term_func(term_func_priv, ret, false);
 }
 EXPORT_SYMBOL(__fscache_write_to_cache);
+
+/*
+ * Change the size of a backing object.
+ */
+void __fscache_resize_cookie(struct fscache_cookie *cookie, loff_t new_size)
+{
+	struct netfs_cache_resources cres;
+
+	trace_fscache_resize(cookie, new_size);
+	if (fscache_begin_operation(&cres, cookie, FSCACHE_WANT_WRITE,
+				    fscache_access_io_resize) == 0) {
+		fscache_stat(&fscache_n_resizes);
+		set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
+
+		/* We cannot defer a resize as we need to do it inside the
+		 * netfs's inode lock so that we're serialised with respect to
+		 * writes.
+		 */
+		cookie->volume->cache->ops->resize_cookie(&cres, new_size);
+		fscache_end_operation(&cres);
+	} else {
+		fscache_stat(&fscache_n_resizes_null);
+	}
+}
+EXPORT_SYMBOL(__fscache_resize_cookie);
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index db42beb1ba3f..798ee68b3e9d 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -35,6 +35,9 @@ atomic_t fscache_n_relinquishes;
 atomic_t fscache_n_relinquishes_retire;
 atomic_t fscache_n_relinquishes_dropped;
 
+atomic_t fscache_n_resizes;
+atomic_t fscache_n_resizes_null;
+
 atomic_t fscache_n_read;
 EXPORT_SYMBOL(fscache_n_read);
 atomic_t fscache_n_write;
@@ -69,8 +72,10 @@ int fscache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "Invals : n=%u\n",
 		   atomic_read(&fscache_n_invalidates));
 
-	seq_printf(m, "Updates: n=%u\n",
-		   atomic_read(&fscache_n_updates));
+	seq_printf(m, "Updates: n=%u rsz=%u rsn=%u\n",
+		   atomic_read(&fscache_n_updates),
+		   atomic_read(&fscache_n_resizes),
+		   atomic_read(&fscache_n_resizes_null));
 
 	seq_printf(m, "Relinqs: n=%u rtr=%u drop=%u\n",
 		   atomic_read(&fscache_n_relinquishes),
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 796c8b5c5305..3fa4902dc87c 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -64,6 +64,10 @@ struct fscache_cache_ops {
 	/* Withdraw an object without any cookie access counts held */
 	void (*withdraw_cookie)(struct fscache_cookie *cookie);
 
+	/* Change the size of a data object */
+	void (*resize_cookie)(struct netfs_cache_resources *cres,
+			      loff_t new_size);
+
 	/* Invalidate an object */
 	bool (*invalidate_cookie)(struct fscache_cookie *cookie);
 
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index fed7def0fbe0..b38d233c9fad 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -162,6 +162,7 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 extern void __fscache_use_cookie(struct fscache_cookie *, bool);
 extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
+extern void __fscache_resize_cookie(struct fscache_cookie *, loff_t);
 extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t, unsigned int);
 extern int __fscache_begin_read_operation(struct netfs_cache_resources *, struct fscache_cookie *);
 
@@ -362,6 +363,23 @@ void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
 		__fscache_update_cookie(cookie, aux_data, object_size);
 }
 
+/**
+ * fscache_resize_cookie - Request that a cache object be resized
+ * @cookie: The cookie representing the cache object
+ * @new_size: The new size of the object (may be NULL)
+ *
+ * Request that the size of an object be changed.
+ *
+ * See Documentation/filesystems/caching/netfs-api.txt for a complete
+ * description.
+ */
+static inline
+void fscache_resize_cookie(struct fscache_cookie *cookie, loff_t new_size)
+{
+	if (fscache_cookie_enabled(cookie))
+		__fscache_resize_cookie(cookie, new_size);
+}
+
 /**
  * fscache_invalidate - Notify cache that an object needs invalidation
  * @cookie: The cookie representing the cache object
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 2459d75659cf..5fa37a8b4ec7 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -78,6 +78,7 @@ enum fscache_access_trace {
 	fscache_access_invalidate_cookie_end,
 	fscache_access_io_not_live,
 	fscache_access_io_read,
+	fscache_access_io_resize,
 	fscache_access_io_wait,
 	fscache_access_io_write,
 	fscache_access_lookup_cookie,
@@ -149,6 +150,7 @@ enum fscache_access_trace {
 	EM(fscache_access_invalidate_cookie_end,"END   inval  ")	\
 	EM(fscache_access_io_not_live,		"END   io_notl")	\
 	EM(fscache_access_io_read,		"BEGIN io_read")	\
+	EM(fscache_access_io_resize,		"BEGIN io_resz")	\
 	EM(fscache_access_io_wait,		"WAIT  io     ")	\
 	EM(fscache_access_io_write,		"BEGIN io_writ")	\
 	EM(fscache_access_lookup_cookie,	"BEGIN lookup ")	\
@@ -418,6 +420,29 @@ TRACE_EVENT(fscache_invalidate,
 		      __entry->cookie, __entry->new_size)
 	    );
 
+TRACE_EVENT(fscache_resize,
+	    TP_PROTO(struct fscache_cookie *cookie, loff_t new_size),
+
+	    TP_ARGS(cookie, new_size),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(loff_t,			old_size	)
+		    __field(loff_t,			new_size	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie	= cookie->debug_id;
+		    __entry->old_size	= cookie->object_size;
+		    __entry->new_size	= new_size;
+			   ),
+
+	    TP_printk("c=%08x os=%08llx sz=%08llx",
+		      __entry->cookie,
+		      __entry->old_size,
+		      __entry->new_size)
+	    );
+
 #endif /* _TRACE_FSCACHE_H */
 
 /* This part must be outside protection */


