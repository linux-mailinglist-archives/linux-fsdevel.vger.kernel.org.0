Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1952E46187C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378261AbhK2Oby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:31:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378388AbhK2O3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638195988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7osXFdmGFDkBwi2P6/RgAumxLsKwz2YGIAgldJ1gKN4=;
        b=KYFIwImLnTIYefJiu8t4+Tuxzxvo/mR/+FEY/8wF7O5L/1K7RzcGSf81YpDelY9anvva5T
        /a+BTMS9X0/gD5sPt08fpL1/YYDqbMgt28OpVVBFWuy1v7945OuyvrZsAxMdpZoyV8l3KF
        IioTku86VpL0N2vjI4a+w0FTcYAXu1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-5_o04qV5PQqZXVfdpA7oSA-1; Mon, 29 Nov 2021 09:26:24 -0500
X-MC-Unique: 5_o04qV5PQqZXVfdpA7oSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F2611018720;
        Mon, 29 Nov 2021 14:26:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 102E77E20A;
        Mon, 29 Nov 2021 14:26:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/64] fscache: Provide and use cache methods to
 lookup/create/free a volume
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
Date:   Mon, 29 Nov 2021 14:26:18 +0000
Message-ID: <163819597821.215744.5225318658134989949.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add cache methods to lookup, create and remove a volume.

Looking up or creating the volume requires the cache pinning for access;
freeing the volume requires the volume pinning for access.  The
->acquire_volume() method is used to ask the cache backend to lookup and,
if necessary, create a volume; the ->free_volume() method is used to free
the resources for a volume.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/fscache/volume.c            |   89 +++++++++++++++++++++++++++++++++++++++-
 include/linux/fscache-cache.h  |    7 +++
 include/trace/events/fscache.h |   11 ++++-
 3 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
index b1c1c2718104..4d0c2d43d54f 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -15,6 +15,8 @@ static struct hlist_bl_head fscache_volume_hash[1 << fscache_volume_hash_shift];
 static atomic_t fscache_volume_debug_id;
 static LIST_HEAD(fscache_volumes);
 
+static void fscache_create_volume_work(struct work_struct *work);
+
 struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
 					  enum fscache_volume_trace where)
 {
@@ -216,7 +218,7 @@ static struct fscache_volume *fscache_alloc_volume(const char *volume_key,
 	volume->cache = cache;
 	volume->coherency = coherency_data;
 	INIT_LIST_HEAD(&volume->proc_link);
-	INIT_WORK(&volume->work, NULL /* PLACEHOLDER */);
+	INIT_WORK(&volume->work, fscache_create_volume_work);
 	refcount_set(&volume->ref, 1);
 	spin_lock_init(&volume->lock);
 
@@ -253,6 +255,58 @@ static struct fscache_volume *fscache_alloc_volume(const char *volume_key,
 	return NULL;
 }
 
+/*
+ * Create a volume's representation on disk.  Have a volume ref and a cache
+ * access we have to release.
+ */
+static void fscache_create_volume_work(struct work_struct *work)
+{
+	const struct fscache_cache_ops *ops;
+	struct fscache_volume *volume =
+		container_of(work, struct fscache_volume, work);
+
+	fscache_see_volume(volume, fscache_volume_see_create_work);
+
+	ops = volume->cache->ops;
+	if (ops->acquire_volume)
+		ops->acquire_volume(volume);
+	fscache_end_cache_access(volume->cache,
+				 fscache_access_acquire_volume_end);
+
+	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
+	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
+	fscache_put_volume(volume, fscache_volume_put_create_work);
+}
+
+/*
+ * Dispatch a worker thread to create a volume's representation on disk.
+ */
+void fscache_create_volume(struct fscache_volume *volume, bool wait)
+{
+	if (test_and_set_bit(FSCACHE_VOLUME_CREATING, &volume->flags))
+		goto maybe_wait;
+	if (volume->cache_priv)
+		goto no_wait; /* We raced */
+	if (!fscache_begin_cache_access(volume->cache,
+					fscache_access_acquire_volume))
+		goto no_wait;
+
+	fscache_get_volume(volume, fscache_volume_get_create_work);
+	if (!schedule_work(&volume->work))
+		fscache_put_volume(volume, fscache_volume_put_create_work);
+
+maybe_wait:
+	if (wait) {
+		fscache_see_volume(volume, fscache_volume_wait_create_work);
+		wait_on_bit(&volume->flags, FSCACHE_VOLUME_CREATING,
+			    TASK_UNINTERRUPTIBLE);
+	}
+	return;
+no_wait:
+	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
+	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
+}
+
 /*
  * Acquire a volume representation cookie and link it to a (proposed) cache.
  */
@@ -271,7 +325,7 @@ struct fscache_volume *__fscache_acquire_volume(const char *volume_key,
 		return NULL;
 	}
 
-	// PLACEHOLDER: Create the volume if we have a cache available
+	fscache_create_volume(volume, false);
 	return volume;
 }
 EXPORT_SYMBOL(__fscache_acquire_volume);
@@ -318,7 +372,12 @@ static void fscache_free_volume(struct fscache_volume *volume)
 	struct fscache_cache *cache = volume->cache;
 
 	if (volume->cache_priv) {
-		// PLACEHOLDER: Detach any attached cache
+		__fscache_begin_volume_access(volume, NULL,
+					      fscache_access_relinquish_volume);
+		if (volume->cache_priv)
+			cache->ops->free_volume(volume);
+		fscache_end_volume_access(volume, NULL,
+					  fscache_access_relinquish_volume_end);
 	}
 
 	down_write(&fscache_addremove_sem);
@@ -371,6 +430,30 @@ void __fscache_relinquish_volume(struct fscache_volume *volume,
 }
 EXPORT_SYMBOL(__fscache_relinquish_volume);
 
+/**
+ * fscache_withdraw_volume - Withdraw a volume from being cached
+ * @volume: Volume cookie
+ *
+ * Withdraw a cache volume from service, waiting for all accesses to complete
+ * before returning.
+ */
+void fscache_withdraw_volume(struct fscache_volume *volume)
+{
+	int n_accesses;
+
+	_debug("withdraw V=%x", volume->debug_id);
+
+	/* Allow wakeups on dec-to-0 */
+	n_accesses = atomic_dec_return(&volume->n_accesses);
+	trace_fscache_access_volume(volume->debug_id, 0,
+				    refcount_read(&volume->ref),
+				    n_accesses, fscache_access_cache_unpin);
+
+	wait_var_event(&volume->n_accesses,
+		       atomic_read(&volume->n_accesses) == 0);
+}
+EXPORT_SYMBOL(fscache_withdraw_volume);
+
 #ifdef CONFIG_PROC_FS
 /*
  * Generate a list of volumes in /proc/fs/fscache/volumes
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index f78add6e7823..a10b66ca3544 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -51,6 +51,12 @@ struct fscache_cache {
 struct fscache_cache_ops {
 	/* name of cache provider */
 	const char *name;
+
+	/* Acquire a volume */
+	void (*acquire_volume)(struct fscache_volume *volume);
+
+	/* Free the cache's data attached to a volume */
+	void (*free_volume)(struct fscache_volume *volume);
 };
 
 extern struct workqueue_struct *fscache_wq;
@@ -65,6 +71,7 @@ extern int fscache_add_cache(struct fscache_cache *cache,
 			     const struct fscache_cache_ops *ops,
 			     void *cache_priv);
 extern void fscache_withdraw_cache(struct fscache_cache *cache);
+extern void fscache_withdraw_volume(struct fscache_volume *volume);
 
 extern void fscache_end_volume_access(struct fscache_volume *volume,
 				      struct fscache_cookie *cookie,
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 33ef0b23cd6a..c16b2ca4bf3f 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -64,8 +64,12 @@ enum fscache_cookie_trace {
 };
 
 enum fscache_access_trace {
+	fscache_access_acquire_volume,
+	fscache_access_acquire_volume_end,
 	fscache_access_cache_pin,
 	fscache_access_cache_unpin,
+	fscache_access_relinquish_volume,
+	fscache_access_relinquish_volume_end,
 	fscache_access_unlive,
 };
 
@@ -96,7 +100,8 @@ enum fscache_access_trace {
 	EM(fscache_volume_put_hash_collision,	"PUT hcoll")		\
 	EM(fscache_volume_put_relinquish,	"PUT relnq")		\
 	EM(fscache_volume_see_create_work,	"SEE creat")		\
-	E_(fscache_volume_see_hash_wake,	"SEE hwake")
+	EM(fscache_volume_see_hash_wake,	"SEE hwake")		\
+	E_(fscache_volume_wait_create_work,	"WAIT crea")
 
 #define fscache_cookie_traces						\
 	EM(fscache_cookie_collision,		"*COLLIDE*")		\
@@ -115,8 +120,12 @@ enum fscache_access_trace {
 	E_(fscache_cookie_see_work,		"-   work ")
 
 #define fscache_access_traces		\
+	EM(fscache_access_acquire_volume,	"BEGIN acq_vol")	\
+	EM(fscache_access_acquire_volume_end,	"END   acq_vol")	\
 	EM(fscache_access_cache_pin,		"PIN   cache  ")	\
 	EM(fscache_access_cache_unpin,		"UNPIN cache  ")	\
+	EM(fscache_access_relinquish_volume,	"BEGIN rlq_vol")	\
+	EM(fscache_access_relinquish_volume_end,"END   rlq_vol")	\
 	E_(fscache_access_unlive,		"END   unlive ")
 
 /*


