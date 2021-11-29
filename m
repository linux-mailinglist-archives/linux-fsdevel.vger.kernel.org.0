Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2727046186A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378663AbhK2ObV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:31:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378085AbhK2O3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638195954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+2kKc/Wpi1rvd1RDl7U7flLC54DNLJqacoF7ZJP3go=;
        b=ClodOzQcB40JdQ6ib6OTpfigmmJG5YrFyB/RAhTFwDTwEgYPehnRer7TbFQw8fXJAsrQii
        JpcmAV2a/MhaU1EnuKx5eIMbd15L0XqYyPKu2vMy/cYDY2oqpEXf79lOt7bijEuNlpeUt+
        FWnu9LLolGipLUUIxY9tqkg3yd5oZWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-2-GBo7epMMOnA0kvdB_Uog-1; Mon, 29 Nov 2021 09:25:48 -0500
X-MC-Unique: 2-GBo7epMMOnA0kvdB_Uog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C50C1018724;
        Mon, 29 Nov 2021 14:25:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7906F5D9C0;
        Mon, 29 Nov 2021 14:25:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/64] fscache: Implement volume-level access helpers
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 14:25:41 +0000
Message-ID: <163819594158.215744.8285859817391683254.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

The way the access gate on the volume works/will work is:

  (1) If the cache tests as not live (state is not FSCACHE_CACHE_IS_ACTIVE),
      then we return false to indicate access was not permitted.

  (2) If the cache tests as live, then we increment the volume's n_accesses
      count and then recheck the cache liveness, ending the access if it
      ceased to be live.

  (3) When we end the access, we decrement the volume's n_accesses and wake
      up the any waiters if it reaches 0.

  (4) Whilst the cache is caching, the volume's n_accesses is kept
      artificially incremented to prevent wakeups from happening.

  (5) When the cache is taken offline, the state is changed to prevent new
      accesses, the volume's n_accesses is decremented and we wait for it to
      become 0.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/internal.h          |    3 +
 fs/fscache/main.c              |    1 
 fs/fscache/volume.c            |   84 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fscache-cache.h  |    4 ++
 include/trace/events/fscache.h |   34 ++++++++++++++++
 5 files changed, 126 insertions(+)

diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index ca035d6be7f9..8727419870aa 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -130,6 +130,9 @@ struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
 					  enum fscache_volume_trace where);
 void fscache_put_volume(struct fscache_volume *volume,
 			enum fscache_volume_trace where);
+bool fscache_begin_volume_access(struct fscache_volume *volume,
+				 struct fscache_cookie *cookie,
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
index 924851888f18..b1c1c2718104 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -33,6 +33,90 @@ static void fscache_see_volume(struct fscache_volume *volume,
 	trace_fscache_volume(volume->debug_id, ref, where);
 }
 
+/*
+ * Pin the cache behind a volume so that we can access it.
+ */
+static void __fscache_begin_volume_access(struct fscache_volume *volume,
+					  struct fscache_cookie *cookie,
+					  enum fscache_access_trace why)
+{
+	int n_accesses;
+
+	n_accesses = atomic_inc_return(&volume->n_accesses);
+	smp_mb__after_atomic();
+	trace_fscache_access_volume(volume->debug_id, cookie ? cookie->debug_id : 0,
+				    refcount_read(&volume->ref),
+				    n_accesses, why);
+}
+
+/**
+ * fscache_begin_volume_access - Pin a cache so a volume can be accessed
+ * @volume: The volume cookie
+ * @cookie: A datafile cookie for a tracing reference (or NULL)
+ * @why: An indication of the circumstances of the access for tracing
+ *
+ * Attempt to pin the cache to prevent it from going away whilst we're
+ * accessing a volume and returns true if successful.  This works as follows:
+ *
+ *  (1) If the cache tests as not live (state is not FSCACHE_CACHE_IS_ACTIVE),
+ *      then we return false to indicate access was not permitted.
+ *
+ *  (2) If the cache tests as live, then we increment the volume's n_accesses
+ *      count and then recheck the cache liveness, ending the access if it
+ *      ceased to be live.
+ *
+ *  (3) When we end the access, we decrement the volume's n_accesses and wake
+ *      up the any waiters if it reaches 0.
+ *
+ *  (4) Whilst the cache is caching, the volume's n_accesses is kept
+ *      artificially incremented to prevent wakeups from happening.
+ *
+ *  (5) When the cache is taken offline, the state is changed to prevent new
+ *      accesses, the volume's n_accesses is decremented and we wait for it to
+ *      become 0.
+ *
+ * The datafile @cookie and the @why indicator are merely provided for tracing
+ * purposes.
+ */
+bool fscache_begin_volume_access(struct fscache_volume *volume,
+				 struct fscache_cookie *cookie,
+				 enum fscache_access_trace why)
+{
+	if (!fscache_cache_is_live(volume->cache))
+		return false;
+	__fscache_begin_volume_access(volume, cookie, why);
+	if (!fscache_cache_is_live(volume->cache)) {
+		fscache_end_volume_access(volume, cookie, fscache_access_unlive);
+		return false;
+	}
+	return true;
+}
+
+/**
+ * fscache_end_volume_access - Unpin a cache at the end of an access.
+ * @volume: The volume cookie
+ * @cookie: A datafile cookie for a tracing reference (or NULL)
+ * @why: An indication of the circumstances of the access for tracing
+ *
+ * Unpin a cache volume after we've accessed it.  The datafile @cookie and the
+ * @why indicator are merely provided for tracing purposes.
+ */
+void fscache_end_volume_access(struct fscache_volume *volume,
+			       struct fscache_cookie *cookie,
+			       enum fscache_access_trace why)
+{
+	int n_accesses;
+
+	smp_mb__before_atomic();
+	n_accesses = atomic_dec_return(&volume->n_accesses);
+	trace_fscache_access_volume(volume->debug_id, cookie ? cookie->debug_id : 0,
+				    refcount_read(&volume->ref),
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
index c4355b888c91..fbbd8a2afe12 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -53,6 +53,10 @@ extern struct rw_semaphore fscache_addremove_sem;
 extern struct fscache_cache *fscache_acquire_cache(const char *name);
 extern void fscache_relinquish_cache(struct fscache_cache *cache);
 
+extern void fscache_end_volume_access(struct fscache_volume *volume,
+				      struct fscache_cookie *cookie,
+				      enum fscache_access_trace why);
+
 extern struct fscache_cookie *fscache_get_cookie(struct fscache_cookie *cookie,
 						 enum fscache_cookie_trace where);
 extern void fscache_put_cookie(struct fscache_cookie *cookie,
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 0ce0bd88e2b4..104aad12021b 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -43,6 +43,7 @@ enum fscache_volume_trace {
 	fscache_volume_put_relinquish,
 	fscache_volume_see_create_work,
 	fscache_volume_see_hash_wake,
+	fscache_volume_wait_create_work,
 };
 
 enum fscache_cookie_trace {
@@ -245,6 +246,39 @@ TRACE_EVENT(fscache_access_cache,
 		      __entry->n_accesses)
 	    );
 
+TRACE_EVENT(fscache_access_volume,
+	    TP_PROTO(unsigned int volume_debug_id,
+		     unsigned int cookie_debug_id,
+		     int ref,
+		     int n_accesses,
+		     enum fscache_access_trace why),
+
+	    TP_ARGS(volume_debug_id, cookie_debug_id, ref, n_accesses, why),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		volume		)
+		    __field(unsigned int,		cookie		)
+		    __field(int,			ref		)
+		    __field(int,			n_accesses	)
+		    __field(enum fscache_access_trace,	why		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->volume	= volume_debug_id;
+		    __entry->cookie	= cookie_debug_id;
+		    __entry->ref	= ref;
+		    __entry->n_accesses	= n_accesses;
+		    __entry->why	= why;
+			   ),
+
+	    TP_printk("V=%08x c=%08x %s r=%d a=%d",
+		      __entry->volume,
+		      __entry->cookie,
+		      __print_symbolic(__entry->why, fscache_access_traces),
+		      __entry->ref,
+		      __entry->n_accesses)
+	    );
+
 TRACE_EVENT(fscache_acquire,
 	    TP_PROTO(struct fscache_cookie *cookie),
 


