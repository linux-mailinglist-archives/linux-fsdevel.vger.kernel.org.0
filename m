Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5EA437D38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbhJVTE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232747AbhJVTEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbeUDRvfOB2aZ1sHCO5D2RGmW9kgUvKEDFff366LXY4=;
        b=E1hLd5ydNfBElZk/GtkqOp5sQiB1OTaSdsNyhFslfm/vsQ3QHbe9Bi3g0M6QxvyCAeUaS7
        rQP3chipLt+TBgfL4QElR817BMOtHFM6VO+NauTcmadZMXFmzKUWxwxRUr9rBVuORyFfH7
        vq9KeAR6R/efiwP4y3xchI+wcDNSdkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-GJhCiyf0PZGta_LRvW2QGg-1; Fri, 22 Oct 2021 15:02:28 -0400
X-MC-Unique: GJhCiyf0PZGta_LRvW2QGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 230C1806688;
        Fri, 22 Oct 2021 19:02:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBBDE5C1A3;
        Fri, 22 Oct 2021 19:02:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 13/53] fscache: Implement volume-level access helpers
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
Date:   Fri, 22 Oct 2021 20:02:22 +0100
Message-ID: <163492934215.1038219.4516739049966201721.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a pair of helper functions to manage access to a volume, pinning the
volume in place for the duration to prevent cache withdrawal from removing
it:

	bool fscache_begin_volume_access(struct fscache_volume *volume,
					 enum fscache_access_trace why);
	void fscache_end_volume_access(struct fscache_volume *volume,
				       enum fscache_access_trace why);

The first is intended for internal use only, but the second will be used by
the cache backend also.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/internal.h          |    2 ++
 fs/fscache/main.c              |    1 +
 fs/fscache/volume.c            |   47 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fscache-cache.h  |    3 +++
 include/trace/events/fscache.h |   30 ++++++++++++++++++++++++++
 5 files changed, 83 insertions(+)

diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 5546c24d18d8..18f9a408a4f4 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -107,6 +107,8 @@ struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
 					  enum fscache_volume_trace where);
 void fscache_put_volume(struct fscache_volume *volume,
 			enum fscache_volume_trace where);
+bool fscache_begin_volume_access(struct fscache_volume *volume,
+				 enum fscache_access_trace why);
 void fscache_create_volume(struct fscache_volume *volume, bool wait);
 
 
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index e1f14b29cff4..6a024c45eb0b 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -22,6 +22,7 @@ MODULE_PARM_DESC(fscache_debug,
 		 "FS-Cache debugging mask");
 
 EXPORT_TRACEPOINT_SYMBOL(fscache_access_cache);
+EXPORT_TRACEPOINT_SYMBOL(fscache_access_volume);
 
 struct workqueue_struct *fscache_wq;
 EXPORT_SYMBOL(fscache_wq);
diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
index 924851888f18..d539d6ec2664 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -33,6 +33,53 @@ static void fscache_see_volume(struct fscache_volume *volume,
 	trace_fscache_volume(volume->debug_id, ref, where);
 }
 
+/*
+ * Pin the cache behind a volume so that we can access it.
+ */
+static void __fscache_begin_volume_access(struct fscache_volume *volume,
+					  enum fscache_access_trace why)
+{
+	int n_accesses;
+
+	n_accesses = atomic_inc_return(&volume->n_accesses);
+	smp_mb__after_atomic();
+	trace_fscache_access_volume(volume->debug_id, refcount_read(&volume->ref),
+				    n_accesses, why);
+}
+
+/*
+ * If the cache behind a volume is live, pin it so that we can access it.
+ */
+bool fscache_begin_volume_access(struct fscache_volume *volume,
+				 enum fscache_access_trace why)
+{
+	if (!fscache_cache_is_live(volume->cache))
+		return false;
+	__fscache_begin_volume_access(volume, why);
+	if (!fscache_cache_is_live(volume->cache)) {
+		fscache_end_volume_access(volume, fscache_access_unlive);
+		return false;
+	}
+	return true;
+}
+
+/*
+ * Mark the end of an access on a volume.
+ */
+void fscache_end_volume_access(struct fscache_volume *volume,
+			       enum fscache_access_trace why)
+{
+	int n_accesses;
+
+	smp_mb__before_atomic();
+	n_accesses = atomic_dec_return(&volume->n_accesses);
+	trace_fscache_access_volume(volume->debug_id, refcount_read(&volume->ref),
+				    n_accesses, why);
+	if (n_accesses == 0)
+		wake_up_var(&volume->n_accesses);
+}
+EXPORT_SYMBOL(fscache_end_volume_access);
+
 static long fscache_compare_volume(const struct fscache_volume *a,
 				   const struct fscache_volume *b)
 {
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index e075cca1a30d..7db4dda74951 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -77,6 +77,9 @@ extern struct fscache_cache *fscache_acquire_cache(const char *name);
 extern void fscache_put_cache(struct fscache_cache *cache,
 			      enum fscache_cache_trace where);
 
+extern void fscache_end_volume_access(struct fscache_volume *volume,
+				      enum fscache_access_trace why);
+
 extern struct fscache_cookie *fscache_get_cookie(struct fscache_cookie *cookie,
 						 enum fscache_cookie_trace where);
 extern void fscache_put_cookie(struct fscache_cookie *cookie,
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index d09d7e3ac86c..4b35fe9cd906 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -40,6 +40,7 @@ enum fscache_volume_trace {
 	fscache_volume_put_relinquish,
 	fscache_volume_see_create_work,
 	fscache_volume_see_hash_wake,
+	fscache_volume_wait_create_work,
 };
 
 enum fscache_cookie_trace {
@@ -239,6 +240,35 @@ TRACE_EVENT(fscache_access_cache,
 		      __entry->n_accesses)
 	    );
 
+TRACE_EVENT(fscache_access_volume,
+	    TP_PROTO(unsigned int volume_debug_id,
+		     int ref,
+		     int n_accesses,
+		     enum fscache_access_trace why),
+
+	    TP_ARGS(volume_debug_id, ref, n_accesses, why),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		volume		)
+		    __field(int,			ref		)
+		    __field(int,			n_accesses	)
+		    __field(enum fscache_access_trace,	why		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->volume	= volume_debug_id;
+		    __entry->ref	= ref;
+		    __entry->n_accesses	= n_accesses;
+		    __entry->why	= why;
+			   ),
+
+	    TP_printk("V=%08x %s r=%d a=%d",
+		      __entry->volume,
+		      __print_symbolic(__entry->why, fscache_access_traces),
+		      __entry->ref,
+		      __entry->n_accesses)
+	    );
+
 TRACE_EVENT(fscache_acquire,
 	    TP_PROTO(struct fscache_cookie *cookie),
 


