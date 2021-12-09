Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51DB46F069
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhLIRIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:08:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242219AbhLIRG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96OhJmrKZdyLXOox+8A3TmywmmEPWaFn7IWn648Nl+8=;
        b=XLK22UBblnXXHmiOwdHOqvLnX5RrYw8tIKzF21Ql7J2/oJYvtWkAt2SN7dbxS7EZtJZoTm
        RJIsOwKmzquVTavsHxE1mn5k1OtpH3X1ti2+EhPhef7ej2F4cV/85N1GJZfk7Gja4kq5mu
        zf6CcGp0jYiF9mKMjmRnR376Y9T9y5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-IxHpwzd6ObiBrdiBmGuQGw-1; Thu, 09 Dec 2021 12:03:22 -0500
X-MC-Unique: IxHpwzd6ObiBrdiBmGuQGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 112B01006AA1;
        Thu,  9 Dec 2021 17:03:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 877F019C59;
        Thu,  9 Dec 2021 17:03:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 43/67] cachefiles: Implement object lifecycle funcs
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
Date:   Thu, 09 Dec 2021 17:03:15 +0000
Message-ID: <163906939569.143852.3594314410666551982.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement allocate, get, see and put functions for the cachefiles_object
struct.  The members of the struct we're going to need are also added.

Additionally, implement a lifecycle tracepoint.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819639457.215744.4600093239395728232.stgit@warthog.procyon.org.uk/ # v1
---

 fs/cachefiles/interface.c         |   86 +++++++++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h          |   35 ++++++++++++++-
 fs/cachefiles/main.c              |   16 +++++++
 include/trace/events/cachefiles.h |   58 +++++++++++++++++++++++++
 include/trace/events/fscache.h    |    4 ++
 5 files changed, 197 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 1793e46bd3e7..68bb7b6c4945 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -13,6 +13,92 @@
 #include <trace/events/fscache.h>
 #include "internal.h"
 
+static atomic_t cachefiles_object_debug_id;
+
+/*
+ * Allocate a cache object record.
+ */
+static
+struct cachefiles_object *cachefiles_alloc_object(struct fscache_cookie *cookie)
+{
+	struct fscache_volume *vcookie = cookie->volume;
+	struct cachefiles_volume *volume = vcookie->cache_priv;
+	struct cachefiles_object *object;
+
+	_enter("{%s},%x,", vcookie->key, cookie->debug_id);
+
+	object = kmem_cache_zalloc(cachefiles_object_jar, GFP_KERNEL);
+	if (!object)
+		return NULL;
+
+	refcount_set(&object->ref, 1);
+
+	spin_lock_init(&object->lock);
+	INIT_LIST_HEAD(&object->cache_link);
+	object->volume = volume;
+	object->debug_id = atomic_inc_return(&cachefiles_object_debug_id);
+	object->cookie = fscache_get_cookie(cookie, fscache_cookie_get_attach_object);
+
+	fscache_count_object(vcookie->cache);
+	trace_cachefiles_ref(object->debug_id, cookie->debug_id, 1,
+			     cachefiles_obj_new);
+	return object;
+}
+
+/*
+ * Note that an object has been seen.
+ */
+void cachefiles_see_object(struct cachefiles_object *object,
+			   enum cachefiles_obj_ref_trace why)
+{
+	trace_cachefiles_ref(object->debug_id, object->cookie->debug_id,
+			     refcount_read(&object->ref), why);
+}
+
+/*
+ * Increment the usage count on an object;
+ */
+struct cachefiles_object *cachefiles_grab_object(struct cachefiles_object *object,
+						 enum cachefiles_obj_ref_trace why)
+{
+	int r;
+
+	__refcount_inc(&object->ref, &r);
+	trace_cachefiles_ref(object->debug_id, object->cookie->debug_id, r, why);
+	return object;
+}
+
+/*
+ * dispose of a reference to an object
+ */
+void cachefiles_put_object(struct cachefiles_object *object,
+			   enum cachefiles_obj_ref_trace why)
+{
+	unsigned int object_debug_id = object->debug_id;
+	unsigned int cookie_debug_id = object->cookie->debug_id;
+	struct fscache_cache *cache;
+	bool done;
+	int r;
+
+	done = __refcount_dec_and_test(&object->ref, &r);
+	trace_cachefiles_ref(object_debug_id, cookie_debug_id, r, why);
+	if (done) {
+		_debug("- kill object OBJ%x", object_debug_id);
+
+		ASSERTCMP(object->file, ==, NULL);
+
+		kfree(object->d_name);
+
+		cache = object->volume->cache->cache;
+		fscache_put_cookie(object->cookie, fscache_cookie_put_object);
+		object->cookie = NULL;
+		kmem_cache_free(cachefiles_object_jar, object);
+		fscache_uncount_object(cache);
+	}
+
+	_leave("");
+}
+
 const struct fscache_cache_ops cachefiles_cache_ops = {
 	.name			= "cachefiles",
 	.acquire_volume		= cachefiles_acquire_volume,
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 3b1a6d67cf96..ff378171c71d 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -19,6 +19,16 @@
 struct cachefiles_cache;
 struct cachefiles_object;
 
+enum cachefiles_content {
+	/* These values are saved on disk */
+	CACHEFILES_CONTENT_NO_DATA	= 0, /* No content stored */
+	CACHEFILES_CONTENT_SINGLE	= 1, /* Content is monolithic, all is present */
+	CACHEFILES_CONTENT_ALL		= 2, /* Content is all present, no map */
+	CACHEFILES_CONTENT_BACKFS_MAP	= 3, /* Content is piecemeal, mapped through backing fs */
+	CACHEFILES_CONTENT_DIRTY	= 4, /* Content is dirty (only seen on disk) */
+	nr__cachefiles_content
+};
+
 /*
  * Cached volume representation.
  */
@@ -31,10 +41,20 @@ struct cachefiles_volume {
 };
 
 /*
- * Data file records.
+ * Backing file state.
  */
 struct cachefiles_object {
-	int				debug_id;	/* debugging ID */
+	struct fscache_cookie		*cookie;	/* Netfs data storage object cookie */
+	struct cachefiles_volume	*volume;	/* Cache volume that holds this object */
+	struct list_head		cache_link;	/* Link in cache->*_list */
+	struct file			*file;		/* The file representing this object */
+	char				*d_name;	/* Backing file name */
+	int				debug_id;
+	spinlock_t			lock;
+	refcount_t			ref;
+	u8				d_name_len;	/* Length of filename */
+	enum cachefiles_content		content_info:8;	/* Info about content presence */
+	unsigned long			flags;
 };
 
 /*
@@ -146,6 +166,17 @@ static inline int cachefiles_inject_remove_error(void)
  * interface.c
  */
 extern const struct fscache_cache_ops cachefiles_cache_ops;
+extern void cachefiles_see_object(struct cachefiles_object *object,
+				  enum cachefiles_obj_ref_trace why);
+extern struct cachefiles_object *cachefiles_grab_object(struct cachefiles_object *object,
+							enum cachefiles_obj_ref_trace why);
+extern void cachefiles_put_object(struct cachefiles_object *object,
+				  enum cachefiles_obj_ref_trace why);
+
+/*
+ * main.c
+ */
+extern struct kmem_cache *cachefiles_object_jar;
 
 /*
  * namei.c
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index 533e3067d80f..3f369c6f816d 100644
--- a/fs/cachefiles/main.c
+++ b/fs/cachefiles/main.c
@@ -31,6 +31,8 @@ MODULE_DESCRIPTION("Mounted-filesystem based cache");
 MODULE_AUTHOR("Red Hat, Inc.");
 MODULE_LICENSE("GPL");
 
+struct kmem_cache *cachefiles_object_jar;
+
 static struct miscdevice cachefiles_dev = {
 	.minor	= MISC_DYNAMIC_MINOR,
 	.name	= "cachefiles",
@@ -51,9 +53,22 @@ static int __init cachefiles_init(void)
 	if (ret < 0)
 		goto error_dev;
 
+	/* create an object jar */
+	ret = -ENOMEM;
+	cachefiles_object_jar =
+		kmem_cache_create("cachefiles_object_jar",
+				  sizeof(struct cachefiles_object),
+				  0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!cachefiles_object_jar) {
+		pr_notice("Failed to allocate an object jar\n");
+		goto error_object_jar;
+	}
+
 	pr_info("Loaded\n");
 	return 0;
 
+error_object_jar:
+	misc_deregister(&cachefiles_dev);
 error_dev:
 	cachefiles_unregister_error_injection();
 error_einj:
@@ -70,6 +85,7 @@ static void __exit cachefiles_exit(void)
 {
 	pr_info("Unloading\n");
 
+	kmem_cache_destroy(cachefiles_object_jar);
 	misc_deregister(&cachefiles_dev);
 	cachefiles_unregister_error_injection();
 }
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index b548dbaf85bb..493afa7fbfec 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -18,6 +18,21 @@
 #ifndef __CACHEFILES_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __CACHEFILES_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
+enum cachefiles_obj_ref_trace {
+	cachefiles_obj_get_ioreq,
+	cachefiles_obj_new,
+	cachefiles_obj_put_alloc_fail,
+	cachefiles_obj_put_detach,
+	cachefiles_obj_put_ioreq,
+	cachefiles_obj_see_clean_commit,
+	cachefiles_obj_see_clean_delete,
+	cachefiles_obj_see_clean_drop_tmp,
+	cachefiles_obj_see_lookup_cookie,
+	cachefiles_obj_see_lookup_failed,
+	cachefiles_obj_see_withdraw_cookie,
+	cachefiles_obj_see_withdrawal,
+};
+
 enum fscache_why_object_killed {
 	FSCACHE_OBJECT_IS_STALE,
 	FSCACHE_OBJECT_IS_WEIRD,
@@ -66,6 +81,20 @@ enum cachefiles_error_trace {
 	EM(FSCACHE_OBJECT_WAS_RETIRED,	"was_retired")		\
 	E_(FSCACHE_OBJECT_WAS_CULLED,	"was_culled")
 
+#define cachefiles_obj_ref_traces					\
+	EM(cachefiles_obj_get_ioreq,		"GET ioreq")		\
+	EM(cachefiles_obj_new,			"NEW obj")		\
+	EM(cachefiles_obj_put_alloc_fail,	"PUT alloc_fail")	\
+	EM(cachefiles_obj_put_detach,		"PUT detach")		\
+	EM(cachefiles_obj_put_ioreq,		"PUT ioreq")		\
+	EM(cachefiles_obj_see_clean_commit,	"SEE clean_commit")	\
+	EM(cachefiles_obj_see_clean_delete,	"SEE clean_delete")	\
+	EM(cachefiles_obj_see_clean_drop_tmp,	"SEE clean_drop_tmp")	\
+	EM(cachefiles_obj_see_lookup_cookie,	"SEE lookup_cookie")	\
+	EM(cachefiles_obj_see_lookup_failed,	"SEE lookup_failed")	\
+	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
+	E_(cachefiles_obj_see_withdrawal,	"SEE withdrawal")
+
 #define cachefiles_trunc_traces						\
 	EM(cachefiles_trunc_dio_adjust,		"DIOADJ")		\
 	EM(cachefiles_trunc_expand_tmpfile,	"EXPTMP")		\
@@ -100,6 +129,7 @@ enum cachefiles_error_trace {
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 
 cachefiles_obj_kill_traces;
+cachefiles_obj_ref_traces;
 cachefiles_trunc_traces;
 cachefiles_error_traces;
 
@@ -113,6 +143,34 @@ cachefiles_error_traces;
 #define E_(a, b)	{ a, b }
 
 
+TRACE_EVENT(cachefiles_ref,
+	    TP_PROTO(unsigned int object_debug_id,
+		     unsigned int cookie_debug_id,
+		     int usage,
+		     enum cachefiles_obj_ref_trace why),
+
+	    TP_ARGS(object_debug_id, cookie_debug_id, usage, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj		)
+		    __field(unsigned int,			cookie		)
+		    __field(enum cachefiles_obj_ref_trace,	why		)
+		    __field(int,				usage		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= object_debug_id;
+		    __entry->cookie	= cookie_debug_id;
+		    __entry->usage	= usage;
+		    __entry->why	= why;
+			   ),
+
+	    TP_printk("c=%08x o=%08x u=%d %s",
+		      __entry->cookie, __entry->obj, __entry->usage,
+		      __print_symbolic(__entry->why, cachefiles_obj_ref_traces))
+	    );
+
 TRACE_EVENT(cachefiles_lookup,
 	    TP_PROTO(struct cachefiles_object *obj,
 		     struct dentry *de),
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 5fa37a8b4ec7..d9d830296ec3 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -49,6 +49,7 @@ enum fscache_volume_trace {
 enum fscache_cookie_trace {
 	fscache_cookie_collision,
 	fscache_cookie_discard,
+	fscache_cookie_get_attach_object,
 	fscache_cookie_get_end_access,
 	fscache_cookie_get_hash_collision,
 	fscache_cookie_get_inval_work,
@@ -57,6 +58,7 @@ enum fscache_cookie_trace {
 	fscache_cookie_new_acquire,
 	fscache_cookie_put_hash_collision,
 	fscache_cookie_put_lru,
+	fscache_cookie_put_object,
 	fscache_cookie_put_over_queued,
 	fscache_cookie_put_relinquish,
 	fscache_cookie_put_withdrawn,
@@ -122,6 +124,7 @@ enum fscache_access_trace {
 #define fscache_cookie_traces						\
 	EM(fscache_cookie_collision,		"*COLLIDE*")		\
 	EM(fscache_cookie_discard,		"DISCARD  ")		\
+	EM(fscache_cookie_get_attach_object,	"GET attch")		\
 	EM(fscache_cookie_get_hash_collision,	"GET hcoll")		\
 	EM(fscache_cookie_get_end_access,	"GQ  endac")		\
 	EM(fscache_cookie_get_inval_work,	"GQ  inval")		\
@@ -130,6 +133,7 @@ enum fscache_access_trace {
 	EM(fscache_cookie_new_acquire,		"NEW acq  ")		\
 	EM(fscache_cookie_put_hash_collision,	"PUT hcoll")		\
 	EM(fscache_cookie_put_lru,		"PUT lru  ")		\
+	EM(fscache_cookie_put_object,		"PUT obj  ")		\
 	EM(fscache_cookie_put_over_queued,	"PQ  overq")		\
 	EM(fscache_cookie_put_relinquish,	"PUT relnq")		\
 	EM(fscache_cookie_put_withdrawn,	"PUT wthdn")		\


