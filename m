Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9054320EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhJRO7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232860AbhJRO7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ri23d0kOe2QwmIyAtW/ggOo3iGWrkP0pmwkM3ZjyG+k=;
        b=NxL50Srqp4sE0xU61hrLDtLbeRlJFQIS/v1cLjsucHb1AaY32bM7ouipN5yrODQO8uhYbO
        2yg3SBCHTjMs9dH9gev1W9cP7SR16Rq4Fk7dWKk7Q+8I3kVWHMO7jqsHjJfsd6UjxNqKax
        AfRY6iyP6KZ0JBRsDjBQQAqSetVaNaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-ZCGijVUMPCuOT2aGxddyQg-1; Mon, 18 Oct 2021 10:57:18 -0400
X-MC-Unique: ZCGijVUMPCuOT2aGxddyQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E788F1006AA6;
        Mon, 18 Oct 2021 14:57:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04A6860BF4;
        Mon, 18 Oct 2021 14:57:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 25/67] cachefiles: Fold fscache_object into cachefiles_object
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
Date:   Mon, 18 Oct 2021 15:57:04 +0100
Message-ID: <163456902408.2614702.7160119571677792662.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Merge struct fscache_object into cachefiles_object so that it can be got
rid of.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/bind.c              |    6 +-
 fs/cachefiles/interface.c         |  116 +++++++++++++++----------------------
 fs/cachefiles/internal.h          |   19 +-----
 fs/cachefiles/key.c               |    8 +--
 fs/cachefiles/namei.c             |   21 +++----
 fs/cachefiles/xattr.c             |   16 +++--
 fs/fscache/cache.c                |   10 ++-
 fs/fscache/cookie.c               |   20 +++---
 fs/fscache/internal.h             |    4 +
 fs/fscache/object.c               |  110 ++++++++++++++++++-----------------
 include/linux/fscache-cache.h     |   71 +++++++++++++----------
 include/trace/events/cachefiles.h |   14 ++--
 include/trace/events/fscache.h    |    2 -
 13 files changed, 194 insertions(+), 223 deletions(-)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index cb3296814056..8db1ef2d1196 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -193,7 +193,7 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	}
 
 	fsdef->dentry = cachedir;
-	fsdef->fscache.cookie = NULL;
+	fsdef->cookie = NULL;
 
 	/* get the graveyard directory */
 	graveyard = cachefiles_get_directory(cache, root, "graveyard", NULL);
@@ -210,10 +210,10 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 			   "%s",
 			   fsdef->dentry->d_sb->s_id);
 
-	fscache_object_init(&fsdef->fscache, &fscache_fsdef_index,
+	fscache_object_init(fsdef, &fscache_fsdef_index,
 			    &cache->cache);
 
-	ret = fscache_add_cache(&cache->cache, &fsdef->fscache, cache->tag);
+	ret = fscache_add_cache(&cache->cache, fsdef, cache->tag);
 	if (ret < 0)
 		goto error_add_cache;
 
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 92bb3ba78c41..7ec2302a3214 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -15,7 +15,7 @@ static int cachefiles_attr_changed(struct cachefiles_object *object);
 /*
  * allocate an object record for a cookie lookup and prepare the lookup data
  */
-static struct fscache_object *cachefiles_alloc_object(
+static struct cachefiles_object *cachefiles_alloc_object(
 	struct fscache_cache *_cache,
 	struct fscache_cookie *cookie)
 {
@@ -33,7 +33,7 @@ static struct fscache_object *cachefiles_alloc_object(
 
 	atomic_set(&object->usage, 1);
 
-	fscache_object_init(&object->fscache, cookie, &cache->cache);
+	fscache_object_init(object, cookie, &cache->cache);
 
 	object->type = cookie->type;
 
@@ -41,8 +41,8 @@ static struct fscache_object *cachefiles_alloc_object(
 	if (!cachefiles_cook_key(object))
 		goto nomem_key;
 
-	_leave(" = %x [%s]", object->fscache.debug_id, object->d_name);
-	return &object->fscache;
+	_leave(" = %x [%s]", object->debug_id, object->d_name);
+	return object;
 
 nomem_key:
 	kmem_cache_free(cachefiles_object_jar, object);
@@ -56,19 +56,17 @@ static struct fscache_object *cachefiles_alloc_object(
  * attempt to look up the nominated node in this cache
  * - return -ETIMEDOUT to be scheduled again
  */
-static int cachefiles_lookup_object(struct fscache_object *_object)
+static int cachefiles_lookup_object(struct cachefiles_object *object)
 {
-	struct cachefiles_object *parent, *object;
+	struct cachefiles_object *parent;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
 	int ret;
 
-	_enter("{OBJ%x}", _object->debug_id);
+	_enter("{OBJ%x}", object->debug_id);
 
-	cache = container_of(_object->cache, struct cachefiles_cache, cache);
-	parent = container_of(_object->parent,
-			      struct cachefiles_object, fscache);
-	object = container_of(_object, struct cachefiles_object, fscache);
+	cache = container_of(object->cache, struct cachefiles_cache, cache);
+	parent = object->parent;
 
 	ASSERT(object->d_name);
 
@@ -79,13 +77,13 @@ static int cachefiles_lookup_object(struct fscache_object *_object)
 
 	/* polish off by setting the attributes of non-index files */
 	if (ret == 0 &&
-	    object->fscache.cookie->type != FSCACHE_COOKIE_TYPE_INDEX)
+	    object->cookie->type != FSCACHE_COOKIE_TYPE_INDEX)
 		cachefiles_attr_changed(object);
 
 	if (ret < 0 && ret != -ETIMEDOUT) {
 		if (ret != -ENOBUFS)
 			pr_warn("Lookup failed error %d\n", ret);
-		fscache_object_lookup_error(&object->fscache);
+		fscache_object_lookup_error(object);
 	}
 
 	_leave(" [%d]", ret);
@@ -95,52 +93,43 @@ static int cachefiles_lookup_object(struct fscache_object *_object)
 /*
  * indication of lookup completion
  */
-static void cachefiles_lookup_complete(struct fscache_object *_object)
+static void cachefiles_lookup_complete(struct cachefiles_object *object)
 {
-	struct cachefiles_object *object;
-
-	object = container_of(_object, struct cachefiles_object, fscache);
-
-	_enter("{OBJ%x}", object->fscache.debug_id);
+	_enter("{OBJ%x}", object->debug_id);
 }
 
 /*
  * increment the usage count on an inode object (may fail if unmounting)
  */
 static
-struct fscache_object *cachefiles_grab_object(struct fscache_object *_object,
-					      enum fscache_obj_ref_trace why)
+struct cachefiles_object *cachefiles_grab_object(struct cachefiles_object *object,
+						 enum fscache_obj_ref_trace why)
 {
-	struct cachefiles_object *object =
-		container_of(_object, struct cachefiles_object, fscache);
 	int u;
 
-	_enter("{OBJ%x,%d}", _object->debug_id, atomic_read(&object->usage));
+	_enter("{OBJ%x,%d}", object->debug_id, atomic_read(&object->usage));
 
 #ifdef CACHEFILES_DEBUG_SLAB
 	ASSERT((atomic_read(&object->usage) & 0xffff0000) != 0x6b6b0000);
 #endif
 
 	u = atomic_inc_return(&object->usage);
-	trace_cachefiles_ref(object, _object->cookie,
+	trace_cachefiles_ref(object, object->cookie,
 			     (enum cachefiles_obj_ref_trace)why, u);
-	return &object->fscache;
+	return object;
 }
 
 /*
  * update the auxiliary data for an object object on disk
  */
-static void cachefiles_update_object(struct fscache_object *_object)
+static void cachefiles_update_object(struct cachefiles_object *object)
 {
-	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
 
-	_enter("{OBJ%x}", _object->debug_id);
+	_enter("{OBJ%x}", object->debug_id);
 
-	object = container_of(_object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache, struct cachefiles_cache,
-			     cache);
+	cache = container_of(object->cache, struct cachefiles_cache, cache);
 
 	cachefiles_begin_secure(cache, &saved_cred);
 	cachefiles_set_object_xattr(object, XATTR_REPLACE);
@@ -152,21 +141,16 @@ static void cachefiles_update_object(struct fscache_object *_object)
  * discard the resources pinned by an object and effect retirement if
  * requested
  */
-static void cachefiles_drop_object(struct fscache_object *_object)
+static void cachefiles_drop_object(struct cachefiles_object *object)
 {
-	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
 
-	ASSERT(_object);
-
-	object = container_of(_object, struct cachefiles_object, fscache);
+	ASSERT(object);
 
-	_enter("{OBJ%x,%d}",
-	       object->fscache.debug_id, atomic_read(&object->usage));
+	_enter("{OBJ%x,%d}", object->debug_id, atomic_read(&object->usage));
 
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
+	cache = container_of(object->cache, struct cachefiles_cache, cache);
 
 #ifdef CACHEFILES_DEBUG_SLAB
 	ASSERT((atomic_read(&object->usage) & 0xffff0000) != 0x6b6b0000);
@@ -179,10 +163,10 @@ static void cachefiles_drop_object(struct fscache_object *_object)
 	 */
 	if (object->dentry) {
 		/* delete retired objects */
-		if (test_bit(FSCACHE_OBJECT_RETIRED, &object->fscache.flags) &&
-		    _object != cache->cache.fsdef
+		if (test_bit(FSCACHE_OBJECT_RETIRED, &object->flags) &&
+		    object != cache->cache.fsdef
 		    ) {
-			_debug("- retire object OBJ%x", object->fscache.debug_id);
+			_debug("- retire object OBJ%x", object->debug_id);
 			cachefiles_begin_secure(cache, &saved_cred);
 			cachefiles_delete_object(cache, object);
 			cachefiles_end_secure(cache, saved_cred);
@@ -200,43 +184,40 @@ static void cachefiles_drop_object(struct fscache_object *_object)
 /*
  * dispose of a reference to an object
  */
-void cachefiles_put_object(struct fscache_object *_object,
+void cachefiles_put_object(struct cachefiles_object *object,
 			   enum fscache_obj_ref_trace why)
 {
-	struct cachefiles_object *object;
 	struct fscache_cache *cache;
 	int u;
 
-	ASSERT(_object);
-
-	object = container_of(_object, struct cachefiles_object, fscache);
+	ASSERT(object);
 
 	_enter("{OBJ%x,%d}",
-	       object->fscache.debug_id, atomic_read(&object->usage));
+	       object->debug_id, atomic_read(&object->usage));
 
 #ifdef CACHEFILES_DEBUG_SLAB
 	ASSERT((atomic_read(&object->usage) & 0xffff0000) != 0x6b6b0000);
 #endif
 
-	ASSERTIFCMP(object->fscache.parent,
-		    object->fscache.parent->n_children, >, 0);
+	ASSERTIFCMP(object->parent,
+		    object->parent->n_children, >, 0);
 
 	u = atomic_dec_return(&object->usage);
-	trace_cachefiles_ref(object, _object->cookie,
+	trace_cachefiles_ref(object, object->cookie,
 			     (enum cachefiles_obj_ref_trace)why, u);
 	ASSERTCMP(u, !=, -1);
 	if (u == 0) {
-		_debug("- kill object OBJ%x", object->fscache.debug_id);
+		_debug("- kill object OBJ%x", object->debug_id);
 
-		ASSERTCMP(object->fscache.parent, ==, NULL);
+		ASSERTCMP(object->parent, ==, NULL);
 		ASSERTCMP(object->dentry, ==, NULL);
-		ASSERTCMP(object->fscache.n_ops, ==, 0);
-		ASSERTCMP(object->fscache.n_children, ==, 0);
+		ASSERTCMP(object->n_ops, ==, 0);
+		ASSERTCMP(object->n_children, ==, 0);
 
 		kfree(object->d_name);
 
-		cache = object->fscache.cache;
-		fscache_object_destroy(&object->fscache);
+		cache = object->cache;
+		fscache_object_destroy(object);
 		kmem_cache_free(cachefiles_object_jar, object);
 		fscache_object_destroyed(cache);
 	}
@@ -285,12 +266,12 @@ static int cachefiles_attr_changed(struct cachefiles_object *object)
 	loff_t oi_size;
 	int ret;
 
-	ni_size = object->fscache.cookie->object_size;
+	ni_size = object->cookie->object_size;
 
 	_enter("{OBJ%x},[%llu]",
-	       object->fscache.debug_id, (unsigned long long) ni_size);
+	       object->debug_id, (unsigned long long) ni_size);
 
-	cache = container_of(object->fscache.cache,
+	cache = container_of(object->cache,
 			     struct cachefiles_cache, cache);
 
 	if (ni_size == object->i_size)
@@ -337,23 +318,20 @@ static int cachefiles_attr_changed(struct cachefiles_object *object)
 /*
  * Invalidate an object
  */
-static void cachefiles_invalidate_object(struct fscache_object *_object)
+static void cachefiles_invalidate_object(struct cachefiles_object *object)
 {
-	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
 	struct path path;
 	uint64_t ni_size;
 	int ret;
 
-	object = container_of(_object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
+	cache = container_of(object->cache, struct cachefiles_cache, cache);
 
-	ni_size = object->fscache.cookie->object_size;
+	ni_size = object->cookie->object_size;
 
 	_enter("{OBJ%x},[%llu]",
-	       object->fscache.debug_id, (unsigned long long)ni_size);
+	       object->debug_id, (unsigned long long)ni_size);
 
 	if (object->dentry) {
 		ASSERT(d_is_reg(object->dentry));
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 9f2f837027e0..f268495ecbc6 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -29,21 +29,6 @@ extern unsigned cachefiles_debug;
 
 #define cachefiles_gfp (__GFP_RECLAIM | __GFP_NORETRY | __GFP_NOMEMALLOC)
 
-/*
- * node records
- */
-struct cachefiles_object {
-	struct fscache_object		fscache;	/* fscache handle */
-	char				*d_name;	/* Filename */
-	struct dentry			*dentry;	/* the file/dir representing this object */
-	loff_t				i_size;		/* object size */
-	atomic_t			usage;		/* object usage count */
-	uint8_t				type;		/* object type */
-	bool				new;		/* T if object new */
-	u8				d_name_len;	/* Length of filename */
-	u8				key_hash;
-};
-
 extern struct kmem_cache *cachefiles_object_jar;
 
 /*
@@ -114,7 +99,7 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  */
 extern const struct fscache_cache_ops cachefiles_cache_ops;
 
-void cachefiles_put_object(struct fscache_object *_object,
+void cachefiles_put_object(struct cachefiles_object *_object,
 			   enum fscache_obj_ref_trace why);
 
 /*
@@ -191,7 +176,7 @@ do {							\
 do {									\
 	struct cachefiles_cache *___cache;				\
 									\
-	___cache = container_of((object)->fscache.cache,		\
+	___cache = container_of((object)->cache,			\
 				struct cachefiles_cache, cache);	\
 	cachefiles_io_error(___cache, FMT, ##__VA_ARGS__);		\
 } while (0)
diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
index 56a9b3201b41..ccadbc4776f1 100644
--- a/fs/cachefiles/key.c
+++ b/fs/cachefiles/key.c
@@ -31,8 +31,8 @@ static const char cachefiles_filecharmap[256] = {
  */
 bool cachefiles_cook_key(struct cachefiles_object *object)
 {
-	const u8 *key = fscache_get_key(object->fscache.cookie);
-	unsigned int acc, sum, keylen = object->fscache.cookie->key_len;
+	const u8 *key = fscache_get_key(object->cookie);
+	unsigned int acc, sum, keylen = object->cookie->key_len;
 	char *name;
 	u8 *buffer, *p;
 	int i, len, elem3, print;
@@ -57,7 +57,7 @@ bool cachefiles_cook_key(struct cachefiles_object *object)
 		if (!name)
 			return false;
 
-		switch (object->fscache.cookie->type) {
+		switch (object->cookie->type) {
 		case FSCACHE_COOKIE_TYPE_INDEX:		type = 'I';	break;
 		case FSCACHE_COOKIE_TYPE_DATAFILE:	type = 'D';	break;
 		default:				type = 'S';	break;
@@ -97,7 +97,7 @@ bool cachefiles_cook_key(struct cachefiles_object *object)
 		return false;
 	}
 
-	switch (object->fscache.cookie->type) {
+	switch (object->cookie->type) {
 	case FSCACHE_COOKIE_TYPE_INDEX:		type = 'J';	break;
 	case FSCACHE_COOKIE_TYPE_DATAFILE:	type = 'E';	break;
 	default:				type = 'T';	break;
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7f02fcb34b1e..d3903cbb7de3 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -29,7 +29,7 @@ static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object)
 	struct inode *inode = d_backing_inode(dentry);
 	bool can_use = false;
 
-	_enter(",%x", object->fscache.debug_id);
+	_enter(",%x", object->debug_id);
 
 	inode_lock(inode);
 
@@ -235,7 +235,7 @@ int cachefiles_delete_object(struct cachefiles_cache *cache,
 	struct dentry *dir;
 	int ret;
 
-	_enter(",OBJ%x{%pd}", object->fscache.debug_id, object->dentry);
+	_enter(",OBJ%x{%pd}", object->debug_id, object->dentry);
 
 	ASSERT(object->dentry);
 	ASSERT(d_backing_inode(object->dentry));
@@ -350,11 +350,11 @@ static int cachefiles_walk_to_file(struct cachefiles_cache *cache,
 		/* This element of the path doesn't exist, so we can release
 		 * any readers in the certain knowledge that there's nothing
 		 * for them to actually read */
-		fscache_object_lookup_negative(&object->fscache);
+		fscache_object_lookup_negative(object);
 
 		ret = cachefiles_has_space(cache, 1, 0);
 		if (ret < 0) {
-			fscache_object_mark_killed(&object->fscache, FSCACHE_OBJECT_NO_SPACE);
+			fscache_object_mark_killed(object, FSCACHE_OBJECT_NO_SPACE);
 			goto error_dput;
 		}
 
@@ -423,11 +423,10 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	int ret;
 
 	_enter("OBJ%x{%pd},OBJ%x,%s,",
-	       parent->fscache.debug_id, parent->dentry,
-	       object->fscache.debug_id, object->d_name);
+	       parent->debug_id, parent->dentry,
+	       object->debug_id, object->d_name);
 
-	cache = container_of(parent->fscache.cache,
-			     struct cachefiles_cache, cache);
+	cache = container_of(parent->cache, struct cachefiles_cache, cache);
 	ASSERT(parent->dentry);
 	ASSERT(d_backing_inode(parent->dentry));
 
@@ -460,7 +459,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 		goto check_error;
 
 	object->new = false;
-	fscache_obtained_object(&object->fscache);
+	fscache_obtained_object(object);
 	_leave(" = 0 [%lu]", d_backing_inode(object->dentry)->i_ino);
 	return 0;
 
@@ -468,7 +467,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	if (ret == -ESTALE) {
 		dput(object->dentry);
 		object->dentry = NULL;
-		fscache_object_retrying_stale(&object->fscache);
+		fscache_object_retrying_stale(object);
 		goto lookup_again;
 	}
 	if (ret == -EIO)
@@ -514,7 +513,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		 * any readers in the certain knowledge that there's nothing
 		 * for them to actually read */
 		if (object)
-			fscache_object_lookup_negative(&object->fscache);
+			fscache_object_lookup_negative(object);
 
 		ret = cachefiles_has_space(cache, 1, 0);
 		if (ret < 0)
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 8b9f30f9ce21..464dea0b467c 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -31,23 +31,23 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object,
 {
 	struct cachefiles_xattr *buf;
 	struct dentry *dentry = object->dentry;
-	unsigned int len = object->fscache.cookie->aux_len;
+	unsigned int len = object->cookie->aux_len;
 	int ret;
 
 	if (!dentry)
 		return -ESTALE;
 
-	_enter("%x,#%d", object->fscache.debug_id, len);
+	_enter("%x,#%d", object->debug_id, len);
 
 	buf = kmalloc(sizeof(struct cachefiles_xattr) + len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	buf->type = object->fscache.cookie->type;
+	buf->type = object->cookie->type;
 	if (len > 0)
-		memcpy(buf->data, fscache_get_aux(object->fscache.cookie), len);
+		memcpy(buf->data, fscache_get_aux(object->cookie), len);
 
-	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
+	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->cookie->flags);
 	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
 			   buf, sizeof(struct cachefiles_xattr) + len,
 			   xattr_flags);
@@ -68,8 +68,8 @@ int cachefiles_check_auxdata(struct cachefiles_object *object)
 {
 	struct cachefiles_xattr *buf;
 	struct dentry *dentry = object->dentry;
-	unsigned int len = object->fscache.cookie->aux_len, tlen;
-	const void *p = fscache_get_aux(object->fscache.cookie);
+	unsigned int len = object->cookie->aux_len, tlen;
+	const void *p = fscache_get_aux(object->cookie);
 	ssize_t ret;
 
 	ASSERT(dentry);
@@ -82,7 +82,7 @@ int cachefiles_check_auxdata(struct cachefiles_object *object)
 
 	ret = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, buf, tlen);
 	if (ret == tlen &&
-	    buf->type == object->fscache.cookie->type &&
+	    buf->type == object->cookie->type &&
 	    memcmp(buf->data, p, len) == 0)
 		ret = 0;
 	else
diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index efcd834d6279..8a3191a89c32 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -93,7 +93,7 @@ struct fscache_cache *fscache_select_cache_for_object(
 	struct fscache_cookie *cookie)
 {
 	struct fscache_cache_tag *tag;
-	struct fscache_object *object;
+	struct cachefiles_object *object;
 	struct fscache_cache *cache;
 
 	_enter("");
@@ -110,7 +110,7 @@ struct fscache_cache *fscache_select_cache_for_object(
 	 * cache */
 	if (!hlist_empty(&cookie->backing_objects)) {
 		object = hlist_entry(cookie->backing_objects.first,
-				     struct fscache_object, cookie_link);
+				     struct cachefiles_object, cookie_link);
 
 		cache = object->cache;
 		if (fscache_object_is_dying(object) ||
@@ -200,7 +200,7 @@ EXPORT_SYMBOL(fscache_init_cache);
  * description.
  */
 int fscache_add_cache(struct fscache_cache *cache,
-		      struct fscache_object *ifsdef,
+		      struct cachefiles_object *ifsdef,
 		      const char *tagname)
 {
 	struct fscache_cache_tag *tag;
@@ -313,14 +313,14 @@ EXPORT_SYMBOL(fscache_io_error);
 static void fscache_withdraw_all_objects(struct fscache_cache *cache,
 					 struct list_head *dying_objects)
 {
-	struct fscache_object *object;
+	struct cachefiles_object *object;
 
 	while (!list_empty(&cache->object_list)) {
 		spin_lock(&cache->object_list_lock);
 
 		if (!list_empty(&cache->object_list)) {
 			object = list_entry(cache->object_list.next,
-					    struct fscache_object, cache_link);
+					    struct cachefiles_object, cache_link);
 			list_move_tail(&object->cache_link, dying_objects);
 
 			_debug("withdraw %x", object->cookie->debug_id);
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 0dc27f82e910..3f7bb2eecdc3 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -26,11 +26,11 @@ static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie);
 static int fscache_alloc_object(struct fscache_cache *cache,
 				struct fscache_cookie *cookie);
 static int fscache_attach_object(struct fscache_cookie *cookie,
-				 struct fscache_object *object);
+				 struct cachefiles_object *object);
 
 static void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 {
-	struct fscache_object *object;
+	struct cachefiles_object *object;
 	struct hlist_node *o;
 	const u8 *k;
 	unsigned loop;
@@ -48,7 +48,7 @@ static void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 
 	o = READ_ONCE(cookie->backing_objects.first);
 	if (o) {
-		object = hlist_entry(o, struct fscache_object, cookie_link);
+		object = hlist_entry(o, struct cachefiles_object, cookie_link);
 		pr_err("%c-cookie o=%u\n", prefix, object->debug_id);
 	}
 
@@ -396,7 +396,7 @@ EXPORT_SYMBOL(__fscache_enable_cookie);
  */
 static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie)
 {
-	struct fscache_object *object;
+	struct cachefiles_object *object;
 	struct fscache_cache *cache;
 	int ret;
 
@@ -443,7 +443,7 @@ static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie)
 	}
 
 	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
+			     struct cachefiles_object, cookie_link);
 
 	/* initiate the process of looking up all the objects in the chain
 	 * (done by fscache_initialise_object()) */
@@ -476,7 +476,7 @@ static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie)
 static int fscache_alloc_object(struct fscache_cache *cache,
 				struct fscache_cookie *cookie)
 {
-	struct fscache_object *object;
+	struct cachefiles_object *object;
 	int ret;
 
 	_enter("%s,%x{%s}", cache->tag->name, cookie->debug_id, cookie->type_name);
@@ -548,9 +548,9 @@ static int fscache_alloc_object(struct fscache_cache *cache,
  * attach a cache object to a cookie
  */
 static int fscache_attach_object(struct fscache_cookie *cookie,
-				 struct fscache_object *object)
+				 struct cachefiles_object *object)
 {
-	struct fscache_object *p;
+	struct cachefiles_object *p;
 	struct fscache_cache *cache = object->cache;
 	int ret;
 
@@ -648,7 +648,7 @@ EXPORT_SYMBOL(__fscache_wait_on_invalidate);
  */
 void __fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data)
 {
-	struct fscache_object *object;
+	struct cachefiles_object *object;
 
 	fscache_stat(&fscache_n_updates);
 
@@ -686,7 +686,7 @@ void __fscache_disable_cookie(struct fscache_cookie *cookie,
 			      const void *aux_data,
 			      bool invalidate)
 {
-	struct fscache_object *object;
+	struct cachefiles_object *object;
 	bool awaken = false;
 
 	_enter("%x,%u", cookie->debug_id, invalidate);
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index e78ca3151e41..eefcb6dfee3e 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -106,7 +106,7 @@ static inline bool fscache_object_congested(void)
 /*
  * object.c
  */
-extern void fscache_enqueue_object(struct fscache_object *);
+extern void fscache_enqueue_object(struct cachefiles_object *);
 
 /*
  * proc.c
@@ -227,7 +227,7 @@ int fscache_stats_show(struct seq_file *m, void *v);
  * - if the event is not masked for that object, then the object is
  *   queued for attention by the thread pool.
  */
-static inline void fscache_raise_event(struct fscache_object *object,
+static inline void fscache_raise_event(struct cachefiles_object *object,
 				       unsigned event)
 {
 	BUG_ON(event >= NR_FSCACHE_OBJECT_EVENTS);
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 761d6dc4aa0f..e653d0194f71 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -14,19 +14,19 @@
 #include <linux/prefetch.h>
 #include "internal.h"
 
-static const struct fscache_state *fscache_abort_initialisation(struct fscache_object *, int);
-static const struct fscache_state *fscache_kill_dependents(struct fscache_object *, int);
-static const struct fscache_state *fscache_drop_object(struct fscache_object *, int);
-static const struct fscache_state *fscache_initialise_object(struct fscache_object *, int);
-static const struct fscache_state *fscache_invalidate_object(struct fscache_object *, int);
-static const struct fscache_state *fscache_jumpstart_dependents(struct fscache_object *, int);
-static const struct fscache_state *fscache_kill_object(struct fscache_object *, int);
-static const struct fscache_state *fscache_lookup_failure(struct fscache_object *, int);
-static const struct fscache_state *fscache_look_up_object(struct fscache_object *, int);
-static const struct fscache_state *fscache_object_available(struct fscache_object *, int);
-static const struct fscache_state *fscache_parent_ready(struct fscache_object *, int);
-static const struct fscache_state *fscache_update_object(struct fscache_object *, int);
-static const struct fscache_state *fscache_object_dead(struct fscache_object *, int);
+static const struct fscache_state *fscache_abort_initialisation(struct cachefiles_object *, int);
+static const struct fscache_state *fscache_kill_dependents(struct cachefiles_object *, int);
+static const struct fscache_state *fscache_drop_object(struct cachefiles_object *, int);
+static const struct fscache_state *fscache_initialise_object(struct cachefiles_object *, int);
+static const struct fscache_state *fscache_invalidate_object(struct cachefiles_object *, int);
+static const struct fscache_state *fscache_jumpstart_dependents(struct cachefiles_object *, int);
+static const struct fscache_state *fscache_kill_object(struct cachefiles_object *, int);
+static const struct fscache_state *fscache_lookup_failure(struct cachefiles_object *, int);
+static const struct fscache_state *fscache_look_up_object(struct cachefiles_object *, int);
+static const struct fscache_state *fscache_object_available(struct cachefiles_object *, int);
+static const struct fscache_state *fscache_parent_ready(struct cachefiles_object *, int);
+static const struct fscache_state *fscache_update_object(struct cachefiles_object *, int);
+static const struct fscache_state *fscache_object_dead(struct cachefiles_object *, int);
 
 #define __STATE_NAME(n) fscache_osm_##n
 #define STATE(n) (&__STATE_NAME(n))
@@ -133,21 +133,21 @@ static const struct fscache_transition fscache_osm_run_oob[] = {
 	   { 0, NULL }
 };
 
-static int  fscache_get_object(struct fscache_object *,
+static int  fscache_get_object(struct cachefiles_object *,
 			       enum fscache_obj_ref_trace);
-static void fscache_put_object(struct fscache_object *,
+static void fscache_put_object(struct cachefiles_object *,
 			       enum fscache_obj_ref_trace);
-static bool fscache_enqueue_dependents(struct fscache_object *, int);
-static void fscache_dequeue_object(struct fscache_object *);
-static void fscache_update_aux_data(struct fscache_object *);
+static bool fscache_enqueue_dependents(struct cachefiles_object *, int);
+static void fscache_dequeue_object(struct cachefiles_object *);
+static void fscache_update_aux_data(struct cachefiles_object *);
 
 /*
  * we need to notify the parent when an op completes that we had outstanding
  * upon it
  */
-static inline void fscache_done_parent_op(struct fscache_object *object)
+static inline void fscache_done_parent_op(struct cachefiles_object *object)
 {
-	struct fscache_object *parent = object->parent;
+	struct cachefiles_object *parent = object->parent;
 
 	_enter("OBJ%x {OBJ%x,%x}",
 	       object->debug_id, parent->debug_id, parent->n_ops);
@@ -163,7 +163,7 @@ static inline void fscache_done_parent_op(struct fscache_object *object)
 /*
  * Object state machine dispatcher.
  */
-static void fscache_object_sm_dispatcher(struct fscache_object *object)
+static void fscache_object_sm_dispatcher(struct cachefiles_object *object)
 {
 	const struct fscache_transition *t;
 	const struct fscache_state *state, *new_state;
@@ -274,8 +274,8 @@ static void fscache_object_sm_dispatcher(struct fscache_object *object)
  */
 static void fscache_object_work_func(struct work_struct *work)
 {
-	struct fscache_object *object =
-		container_of(work, struct fscache_object, work);
+	struct cachefiles_object *object =
+		container_of(work, struct cachefiles_object, work);
 
 	_enter("{OBJ%x}", object->debug_id);
 
@@ -294,7 +294,7 @@ static void fscache_object_work_func(struct work_struct *work)
  * See Documentation/filesystems/caching/backend-api.rst for a complete
  * description.
  */
-void fscache_object_init(struct fscache_object *object,
+void fscache_object_init(struct cachefiles_object *object,
 			 struct fscache_cookie *cookie,
 			 struct fscache_cache *cache)
 {
@@ -335,7 +335,7 @@ EXPORT_SYMBOL(fscache_object_init);
  * Mark the object as no longer being live, making sure that we synchronise
  * against op submission.
  */
-static inline void fscache_mark_object_dead(struct fscache_object *object)
+static inline void fscache_mark_object_dead(struct cachefiles_object *object)
 {
 	spin_lock(&object->lock);
 	clear_bit(FSCACHE_OBJECT_IS_LIVE, &object->flags);
@@ -345,7 +345,7 @@ static inline void fscache_mark_object_dead(struct fscache_object *object)
 /*
  * Abort object initialisation before we start it.
  */
-static const struct fscache_state *fscache_abort_initialisation(struct fscache_object *object,
+static const struct fscache_state *fscache_abort_initialisation(struct cachefiles_object *object,
 								int event)
 {
 	_enter("{OBJ%x},%d", object->debug_id, event);
@@ -362,10 +362,10 @@ static const struct fscache_state *fscache_abort_initialisation(struct fscache_o
  * - we may need to start the process of creating a parent and we need to wait
  *   for the parent's lookup and creation to complete if it's not there yet
  */
-static const struct fscache_state *fscache_initialise_object(struct fscache_object *object,
+static const struct fscache_state *fscache_initialise_object(struct cachefiles_object *object,
 							     int event)
 {
-	struct fscache_object *parent;
+	struct cachefiles_object *parent;
 	bool success;
 
 	_enter("{OBJ%x},%d", object->debug_id, event);
@@ -417,10 +417,10 @@ static const struct fscache_state *fscache_initialise_object(struct fscache_obje
 /*
  * Once the parent object is ready, we should kick off our lookup op.
  */
-static const struct fscache_state *fscache_parent_ready(struct fscache_object *object,
+static const struct fscache_state *fscache_parent_ready(struct cachefiles_object *object,
 							int event)
 {
-	struct fscache_object *parent = object->parent;
+	struct cachefiles_object *parent = object->parent;
 
 	_enter("{OBJ%x},%d", object->debug_id, event);
 
@@ -440,11 +440,11 @@ static const struct fscache_state *fscache_parent_ready(struct fscache_object *o
  * - we hold an "access lock" on the parent object, so the parent object cannot
  *   be withdrawn by either party till we've finished
  */
-static const struct fscache_state *fscache_look_up_object(struct fscache_object *object,
+static const struct fscache_state *fscache_look_up_object(struct cachefiles_object *object,
 							  int event)
 {
 	struct fscache_cookie *cookie = object->cookie;
-	struct fscache_object *parent = object->parent;
+	struct cachefiles_object *parent = object->parent;
 	int ret;
 
 	_enter("{OBJ%x},%d", object->debug_id, event);
@@ -499,7 +499,7 @@ static const struct fscache_state *fscache_look_up_object(struct fscache_object
  * Note negative lookup, permitting those waiting to read data from an already
  * existing backing object to continue as there's no data for them to read.
  */
-void fscache_object_lookup_negative(struct fscache_object *object)
+void fscache_object_lookup_negative(struct cachefiles_object *object)
 {
 	struct fscache_cookie *cookie = object->cookie;
 
@@ -531,7 +531,7 @@ EXPORT_SYMBOL(fscache_object_lookup_negative);
  * Note that after calling this, an object's cookie may be relinquished by the
  * netfs, and so must be accessed with object lock held.
  */
-void fscache_obtained_object(struct fscache_object *object)
+void fscache_obtained_object(struct cachefiles_object *object)
 {
 	struct fscache_cookie *cookie = object->cookie;
 
@@ -563,7 +563,7 @@ EXPORT_SYMBOL(fscache_obtained_object);
 /*
  * handle an object that has just become available
  */
-static const struct fscache_state *fscache_object_available(struct fscache_object *object,
+static const struct fscache_state *fscache_object_available(struct cachefiles_object *object,
 							    int event)
 {
 	_enter("{OBJ%x},%d", object->debug_id, event);
@@ -588,7 +588,7 @@ static const struct fscache_state *fscache_object_available(struct fscache_objec
 /*
  * Wake up this object's dependent objects now that we've become available.
  */
-static const struct fscache_state *fscache_jumpstart_dependents(struct fscache_object *object,
+static const struct fscache_state *fscache_jumpstart_dependents(struct cachefiles_object *object,
 								int event)
 {
 	_enter("{OBJ%x},%d", object->debug_id, event);
@@ -601,7 +601,7 @@ static const struct fscache_state *fscache_jumpstart_dependents(struct fscache_o
 /*
  * Handle lookup or creation failute.
  */
-static const struct fscache_state *fscache_lookup_failure(struct fscache_object *object,
+static const struct fscache_state *fscache_lookup_failure(struct cachefiles_object *object,
 							  int event)
 {
 	struct fscache_cookie *cookie;
@@ -629,7 +629,7 @@ static const struct fscache_state *fscache_lookup_failure(struct fscache_object
  * Wait for completion of all active operations on this object and the death of
  * all child objects of this object.
  */
-static const struct fscache_state *fscache_kill_object(struct fscache_object *object,
+static const struct fscache_state *fscache_kill_object(struct cachefiles_object *object,
 						       int event)
 {
 	_enter("{OBJ%x,%d,%d},%d",
@@ -652,7 +652,7 @@ static const struct fscache_state *fscache_kill_object(struct fscache_object *ob
 /*
  * Kill dependent objects.
  */
-static const struct fscache_state *fscache_kill_dependents(struct fscache_object *object,
+static const struct fscache_state *fscache_kill_dependents(struct cachefiles_object *object,
 							   int event)
 {
 	_enter("{OBJ%x},%d", object->debug_id, event);
@@ -665,10 +665,10 @@ static const struct fscache_state *fscache_kill_dependents(struct fscache_object
 /*
  * Drop an object's attachments
  */
-static const struct fscache_state *fscache_drop_object(struct fscache_object *object,
+static const struct fscache_state *fscache_drop_object(struct cachefiles_object *object,
 						       int event)
 {
-	struct fscache_object *parent = object->parent;
+	struct cachefiles_object *parent = object->parent;
 	struct fscache_cookie *cookie = object->cookie;
 	struct fscache_cache *cache = object->cache;
 	bool awaken = false;
@@ -738,7 +738,7 @@ static const struct fscache_state *fscache_drop_object(struct fscache_object *ob
 /*
  * get a ref on an object
  */
-static int fscache_get_object(struct fscache_object *object,
+static int fscache_get_object(struct cachefiles_object *object,
 			      enum fscache_obj_ref_trace why)
 {
 	int ret;
@@ -752,7 +752,7 @@ static int fscache_get_object(struct fscache_object *object,
 /*
  * Discard a ref on an object
  */
-static void fscache_put_object(struct fscache_object *object,
+static void fscache_put_object(struct cachefiles_object *object,
 			       enum fscache_obj_ref_trace why)
 {
 	fscache_stat(&fscache_n_cop_put_object);
@@ -766,7 +766,7 @@ static void fscache_put_object(struct fscache_object *object,
  *
  * Note the imminent destruction and deallocation of a cache object record.
  */
-void fscache_object_destroy(struct fscache_object *object)
+void fscache_object_destroy(struct cachefiles_object *object)
 {
 	/* We can get rid of the cookie now */
 	fscache_put_cookie(object->cookie, fscache_cookie_put_object);
@@ -777,7 +777,7 @@ EXPORT_SYMBOL(fscache_object_destroy);
 /*
  * enqueue an object for metadata-type processing
  */
-void fscache_enqueue_object(struct fscache_object *object)
+void fscache_enqueue_object(struct cachefiles_object *object)
 {
 	_enter("{OBJ%x}", object->debug_id);
 
@@ -831,9 +831,9 @@ EXPORT_SYMBOL_GPL(fscache_object_sleep_till_congested);
  * again then return false immediately.  We return true if the list was
  * cleared.
  */
-static bool fscache_enqueue_dependents(struct fscache_object *object, int event)
+static bool fscache_enqueue_dependents(struct cachefiles_object *object, int event)
 {
-	struct fscache_object *dep;
+	struct cachefiles_object *dep;
 	bool ret = true;
 
 	_enter("{OBJ%x}", object->debug_id);
@@ -845,7 +845,7 @@ static bool fscache_enqueue_dependents(struct fscache_object *object, int event)
 
 	while (!list_empty(&object->dependents)) {
 		dep = list_entry(object->dependents.next,
-				 struct fscache_object, dep_link);
+				 struct cachefiles_object, dep_link);
 		list_del_init(&dep->dep_link);
 
 		fscache_raise_event(dep, event);
@@ -864,7 +864,7 @@ static bool fscache_enqueue_dependents(struct fscache_object *object, int event)
 /*
  * remove an object from whatever queue it's waiting on
  */
-static void fscache_dequeue_object(struct fscache_object *object)
+static void fscache_dequeue_object(struct cachefiles_object *object)
 {
 	_enter("{OBJ%x}", object->debug_id);
 
@@ -877,7 +877,7 @@ static void fscache_dequeue_object(struct fscache_object *object)
 	_leave("");
 }
 
-static const struct fscache_state *fscache_invalidate_object(struct fscache_object *object,
+static const struct fscache_state *fscache_invalidate_object(struct cachefiles_object *object,
 							     int event)
 {
 	return transit_to(UPDATE_OBJECT);
@@ -886,7 +886,7 @@ static const struct fscache_state *fscache_invalidate_object(struct fscache_obje
 /*
  * Update auxiliary data.
  */
-static void fscache_update_aux_data(struct fscache_object *object)
+static void fscache_update_aux_data(struct cachefiles_object *object)
 {
 	fscache_stat(&fscache_n_updates_run);
 	fscache_stat(&fscache_n_cop_update_object);
@@ -897,7 +897,7 @@ static void fscache_update_aux_data(struct fscache_object *object)
 /*
  * Asynchronously update an object.
  */
-static const struct fscache_state *fscache_update_object(struct fscache_object *object,
+static const struct fscache_state *fscache_update_object(struct cachefiles_object *object,
 							 int event)
 {
 	_enter("{OBJ%x},%d", object->debug_id, event);
@@ -915,7 +915,7 @@ static const struct fscache_state *fscache_update_object(struct fscache_object *
  * Note that an object lookup found an on-disk object that was adjudged to be
  * stale and has been deleted.  The lookup will be retried.
  */
-void fscache_object_retrying_stale(struct fscache_object *object)
+void fscache_object_retrying_stale(struct cachefiles_object *object)
 {
 	fscache_stat(&fscache_n_cache_no_space_reject);
 }
@@ -929,7 +929,7 @@ EXPORT_SYMBOL(fscache_object_retrying_stale);
  * Note that an object was killed.  Returns true if the object was
  * already marked killed, false if it wasn't.
  */
-void fscache_object_mark_killed(struct fscache_object *object,
+void fscache_object_mark_killed(struct cachefiles_object *object,
 				enum fscache_why_object_killed why)
 {
 	if (test_and_set_bit(FSCACHE_OBJECT_KILLED_BY_CACHE, &object->flags)) {
@@ -961,7 +961,7 @@ EXPORT_SYMBOL(fscache_object_mark_killed);
  * already running (and so can be requeued) but hasn't yet cleared the event
  * mask.
  */
-static const struct fscache_state *fscache_object_dead(struct fscache_object *object,
+static const struct fscache_state *fscache_object_dead(struct cachefiles_object *object,
 						       int event)
 {
 	if (!test_and_set_bit(FSCACHE_OBJECT_RUN_AFTER_DEAD,
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 0439dc3021c7..7021c1ec2b64 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -22,7 +22,7 @@
 
 struct fscache_cache;
 struct fscache_cache_ops;
-struct fscache_object;
+struct cachefiles_object;
 enum fscache_cookie_trace;
 
 enum fscache_obj_ref_trace {
@@ -65,7 +65,7 @@ struct fscache_cache {
 	struct list_head	object_list;	/* list of data/index objects */
 	spinlock_t		object_list_lock;
 	atomic_t		object_count;	/* no. of live objects in this cache */
-	struct fscache_object	*fsdef;		/* object for the fsdef index */
+	struct cachefiles_object	*fsdef;		/* object for the fsdef index */
 	unsigned long		flags;
 #define FSCACHE_IOERROR		0	/* cache stopped on I/O error */
 #define FSCACHE_CACHE_WITHDRAWN	1	/* cache has been withdrawn */
@@ -81,46 +81,46 @@ struct fscache_cache_ops {
 	const char *name;
 
 	/* allocate an object record for a cookie */
-	struct fscache_object *(*alloc_object)(struct fscache_cache *cache,
+	struct cachefiles_object *(*alloc_object)(struct fscache_cache *cache,
 					       struct fscache_cookie *cookie);
 
 	/* look up the object for a cookie
 	 * - return -ETIMEDOUT to be requeued
 	 */
-	int (*lookup_object)(struct fscache_object *object);
+	int (*lookup_object)(struct cachefiles_object *object);
 
 	/* finished looking up */
-	void (*lookup_complete)(struct fscache_object *object);
+	void (*lookup_complete)(struct cachefiles_object *object);
 
 	/* increment the usage count on this object (may fail if unmounting) */
-	struct fscache_object *(*grab_object)(struct fscache_object *object,
+	struct cachefiles_object *(*grab_object)(struct cachefiles_object *object,
 					      enum fscache_obj_ref_trace why);
 
 	/* pin an object in the cache */
-	int (*pin_object)(struct fscache_object *object);
+	int (*pin_object)(struct cachefiles_object *object);
 
 	/* unpin an object in the cache */
-	void (*unpin_object)(struct fscache_object *object);
+	void (*unpin_object)(struct cachefiles_object *object);
 
 	/* store the updated auxiliary data on an object */
-	void (*update_object)(struct fscache_object *object);
+	void (*update_object)(struct cachefiles_object *object);
 
 	/* Invalidate an object */
-	void (*invalidate_object)(struct fscache_object *object);
+	void (*invalidate_object)(struct cachefiles_object *object);
 
 	/* discard the resources pinned by an object and effect retirement if
 	 * necessary */
-	void (*drop_object)(struct fscache_object *object);
+	void (*drop_object)(struct cachefiles_object *object);
 
 	/* dispose of a reference to an object */
-	void (*put_object)(struct fscache_object *object,
+	void (*put_object)(struct cachefiles_object *object,
 			   enum fscache_obj_ref_trace why);
 
 	/* sync a cache */
 	void (*sync_cache)(struct fscache_cache *cache);
 
 	/* reserve space for an object's data and associated metadata */
-	int (*reserve_space)(struct fscache_object *object, loff_t i_size);
+	int (*reserve_space)(struct cachefiles_object *object, loff_t i_size);
 
 	/* Begin an operation for the netfs lib */
 	int (*begin_operation)(struct netfs_cache_resources *cres);
@@ -155,7 +155,7 @@ struct fscache_transition {
 struct fscache_state {
 	char name[24];
 	char short_name[8];
-	const struct fscache_state *(*work)(struct fscache_object *object,
+	const struct fscache_state *(*work)(struct cachefiles_object *object,
 					    int event);
 	const struct fscache_transition transitions[];
 };
@@ -163,7 +163,7 @@ struct fscache_state {
 /*
  * on-disk cache file or index handle
  */
-struct fscache_object {
+struct cachefiles_object {
 	const struct fscache_state *state;	/* Object state machine state */
 	const struct fscache_transition *oob_table; /* OOB state transition table */
 	int			debug_id;	/* debugging ID */
@@ -192,40 +192,49 @@ struct fscache_object {
 	struct hlist_node	cookie_link;	/* link in cookie->backing_objects */
 	struct fscache_cache	*cache;		/* cache that supplied this object */
 	struct fscache_cookie	*cookie;	/* netfs's file/index object */
-	struct fscache_object	*parent;	/* parent object */
+	struct cachefiles_object	*parent;	/* parent object */
 	struct work_struct	work;		/* attention scheduling record */
 	struct list_head	dependents;	/* FIFO of dependent objects */
 	struct list_head	dep_link;	/* link in parent's dependents list */
+
+	char				*d_name;	/* Filename */
+	struct dentry			*dentry;	/* the file/dir representing this object */
+	loff_t				i_size;		/* object size */
+	atomic_t			usage;		/* object usage count */
+	uint8_t				type;		/* object type */
+	bool				new;		/* T if object new */
+	u8				d_name_len;	/* Length of filename */
+	u8				key_hash;
 };
 
-extern void fscache_object_init(struct fscache_object *, struct fscache_cookie *,
+extern void fscache_object_init(struct cachefiles_object *, struct fscache_cookie *,
 				struct fscache_cache *);
-extern void fscache_object_destroy(struct fscache_object *);
+extern void fscache_object_destroy(struct cachefiles_object *);
 
-extern void fscache_object_lookup_negative(struct fscache_object *object);
-extern void fscache_obtained_object(struct fscache_object *object);
+extern void fscache_object_lookup_negative(struct cachefiles_object *object);
+extern void fscache_obtained_object(struct cachefiles_object *object);
 
-static inline bool fscache_object_is_live(struct fscache_object *object)
+static inline bool fscache_object_is_live(struct cachefiles_object *object)
 {
 	return test_bit(FSCACHE_OBJECT_IS_LIVE, &object->flags);
 }
 
-static inline bool fscache_object_is_dying(struct fscache_object *object)
+static inline bool fscache_object_is_dying(struct cachefiles_object *object)
 {
 	return !fscache_object_is_live(object);
 }
 
-static inline bool fscache_object_is_available(struct fscache_object *object)
+static inline bool fscache_object_is_available(struct cachefiles_object *object)
 {
 	return test_bit(FSCACHE_OBJECT_IS_AVAILABLE, &object->flags);
 }
 
-static inline bool fscache_cache_is_broken(struct fscache_object *object)
+static inline bool fscache_cache_is_broken(struct cachefiles_object *object)
 {
 	return test_bit(FSCACHE_IOERROR, &object->cache->flags);
 }
 
-static inline bool fscache_object_is_active(struct fscache_object *object)
+static inline bool fscache_object_is_active(struct cachefiles_object *object)
 {
 	return fscache_object_is_available(object) &&
 		fscache_object_is_live(object) &&
@@ -251,7 +260,7 @@ static inline void fscache_object_destroyed(struct fscache_cache *cache)
  * Note that an object encountered a fatal error (usually an I/O error) and
  * that it should be withdrawn as soon as possible.
  */
-static inline void fscache_object_lookup_error(struct fscache_object *object)
+static inline void fscache_object_lookup_error(struct cachefiles_object *object)
 {
 	set_bit(FSCACHE_OBJECT_EV_ERROR, &object->events);
 }
@@ -268,7 +277,7 @@ static inline void __fscache_use_cookie(struct fscache_cookie *cookie)
  * Request usage of the cookie attached to an object.  NULL is returned if the
  * relinquishment had reduced the cookie usage count to 0.
  */
-static inline bool fscache_use_cookie(struct fscache_object *object)
+static inline bool fscache_use_cookie(struct cachefiles_object *object)
 {
 	struct fscache_cookie *cookie = object->cookie;
 	return atomic_inc_not_zero(&cookie->n_active) != 0;
@@ -291,7 +300,7 @@ static inline void __fscache_wake_unused_cookie(struct fscache_cookie *cookie)
  * Cease usage of the cookie attached to an object.  When the users count
  * reaches zero then the cookie relinquishment will be permitted to proceed.
  */
-static inline void fscache_unuse_cookie(struct fscache_object *object)
+static inline void fscache_unuse_cookie(struct cachefiles_object *object)
 {
 	struct fscache_cookie *cookie = object->cookie;
 	if (__fscache_unuse_cookie(cookie))
@@ -307,7 +316,7 @@ void fscache_init_cache(struct fscache_cache *cache,
 			const char *idfmt, ...);
 
 extern int fscache_add_cache(struct fscache_cache *cache,
-			     struct fscache_object *fsdef,
+			     struct cachefiles_object *fsdef,
 			     const char *tagname);
 extern void fscache_withdraw_cache(struct fscache_cache *cache);
 
@@ -315,7 +324,7 @@ extern void fscache_io_error(struct fscache_cache *cache);
 
 extern bool fscache_object_sleep_till_congested(signed long *timeoutp);
 
-extern void fscache_object_retrying_stale(struct fscache_object *object);
+extern void fscache_object_retrying_stale(struct cachefiles_object *object);
 
 enum fscache_why_object_killed {
 	FSCACHE_OBJECT_IS_STALE,
@@ -323,7 +332,7 @@ enum fscache_why_object_killed {
 	FSCACHE_OBJECT_WAS_RETIRED,
 	FSCACHE_OBJECT_WAS_CULLED,
 };
-extern void fscache_object_mark_killed(struct fscache_object *object,
+extern void fscache_object_mark_killed(struct cachefiles_object *object,
 				       enum fscache_why_object_killed why);
 
 extern struct fscache_cookie *fscache_get_cookie(struct fscache_cookie *cookie,
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 87681dd957ec..5aec097d51ae 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -85,7 +85,7 @@ TRACE_EVENT(cachefiles_ref,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->obj	= obj->debug_id;
 		    __entry->cookie	= cookie->debug_id;
 		    __entry->usage	= usage;
 		    __entry->why	= why;
@@ -109,7 +109,7 @@ TRACE_EVENT(cachefiles_lookup,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->obj	= obj->debug_id;
 		    __entry->ino	= (!IS_ERR(de) && d_backing_inode(de) ?
 					   d_backing_inode(de)->i_ino : 0);
 		    __entry->error	= IS_ERR(de) ? PTR_ERR(de) : 0;
@@ -132,7 +132,7 @@ TRACE_EVENT(cachefiles_create,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->obj	= obj->debug_id;
 		    __entry->de		= de;
 		    __entry->ret	= ret;
 			   ),
@@ -156,7 +156,7 @@ TRACE_EVENT(cachefiles_unlink,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj ? obj->fscache.debug_id : UINT_MAX;
+		    __entry->obj	= obj ? obj->debug_id : UINT_MAX;
 		    __entry->de		= de;
 		    __entry->why	= why;
 			   ),
@@ -183,7 +183,7 @@ TRACE_EVENT(cachefiles_rename,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj ? obj->fscache.debug_id : UINT_MAX;
+		    __entry->obj	= obj ? obj->debug_id : UINT_MAX;
 		    __entry->de		= de;
 		    __entry->to		= to;
 		    __entry->why	= why;
@@ -207,7 +207,7 @@ TRACE_EVENT(cachefiles_mark_active,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->obj	= obj->debug_id;
 		    __entry->de		= de;
 			   ),
 
@@ -230,7 +230,7 @@ TRACE_EVENT(cachefiles_mark_inactive,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->obj	= obj->debug_id;
 		    __entry->de		= de;
 		    __entry->inode	= inode;
 			   ),
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index eac561d3ac51..412f016f6975 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -228,7 +228,7 @@ TRACE_EVENT(fscache_disable,
 	    );
 
 TRACE_EVENT(fscache_osm,
-	    TP_PROTO(struct fscache_object *object,
+	    TP_PROTO(struct cachefiles_object *object,
 		     const struct fscache_state *state,
 		     bool wait, bool oob, s8 event_num),
 


