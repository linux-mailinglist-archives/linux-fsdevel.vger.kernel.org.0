Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37892BAC9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgKTPEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:04:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728446AbgKTPEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pc91uKcoaNabkc5j9yzLyhrGzya1Wd5jdjqeBJLyAJs=;
        b=bs90FKWC+sLPst4LYkt14jp365StuPlkYIat9mVkhzsHJ4kCx9Cg6waTw8HBvjAHwtfACa
        8OzLImUd728tzaHGg3r60mU7FED4WHsC+2E7uca2BAmG7IuMGJgc8KXYYXlZ851NEgepWH
        iEmh6nVunvJG9sM0GvcSsUoy8iDDG4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-IQPxjQIrOwu6AKwM6JRdLg-1; Fri, 20 Nov 2020 10:04:04 -0500
X-MC-Unique: IQPxjQIrOwu6AKwM6JRdLg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B76D801B2C;
        Fri, 20 Nov 2020 15:04:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C93E95D6AD;
        Fri, 20 Nov 2020 15:03:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 06/76] fscache: Remove the netfs data from the cookie
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:03:54 +0000
Message-ID: <160588463494.3465195.6612093184241882813.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the netfs data pointer from the cookie so that we don't refer back
to the netfs state and don't need accessors to manage this.  Keep the
information we do need (of which there's not actually a lot) in the cookie
which we can keep hold of if the netfs state goes away.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cache.c                |   39 --------
 fs/afs/cell.c                 |    3 -
 fs/afs/inode.c                |    3 -
 fs/afs/volume.c               |    4 -
 fs/cachefiles/interface.c     |  104 +++------------------
 fs/cachefiles/internal.h      |   20 +---
 fs/cachefiles/namei.c         |   10 +-
 fs/cachefiles/xattr.c         |  204 +++++++----------------------------------
 fs/fscache/cache.c            |   20 +---
 fs/fscache/cookie.c           |   37 ++++---
 fs/fscache/fsdef.c            |   37 -------
 fs/fscache/internal.h         |   29 ++++--
 fs/fscache/netfs.c            |    3 -
 fs/fscache/object-list.c      |    9 +-
 fs/fscache/object.c           |   48 ----------
 fs/nfs/fscache-index.c        |    4 -
 include/linux/fscache-cache.h |   32 +++++-
 include/linux/fscache.h       |   39 +-------
 18 files changed, 144 insertions(+), 501 deletions(-)

diff --git a/fs/afs/cache.c b/fs/afs/cache.c
index 037af93e3aba..9b2de3014dbf 100644
--- a/fs/afs/cache.c
+++ b/fs/afs/cache.c
@@ -8,11 +8,6 @@
 #include <linux/sched.h>
 #include "internal.h"
 
-static enum fscache_checkaux afs_vnode_cache_check_aux(void *cookie_netfs_data,
-						       const void *buffer,
-						       uint16_t buflen,
-						       loff_t object_size);
-
 struct fscache_netfs afs_cache_netfs = {
 	.name			= "afs",
 	.version		= 2,
@@ -31,38 +26,4 @@ struct fscache_cookie_def afs_volume_cache_index_def = {
 struct fscache_cookie_def afs_vnode_cache_index_def = {
 	.name		= "AFS.vnode",
 	.type		= FSCACHE_COOKIE_TYPE_DATAFILE,
-	.check_aux	= afs_vnode_cache_check_aux,
 };
-
-/*
- * check that the auxiliary data indicates that the entry is still valid
- */
-static enum fscache_checkaux afs_vnode_cache_check_aux(void *cookie_netfs_data,
-						       const void *buffer,
-						       uint16_t buflen,
-						       loff_t object_size)
-{
-	struct afs_vnode *vnode = cookie_netfs_data;
-	struct afs_vnode_cache_aux aux;
-
-	_enter("{%llx,%x,%llx},%p,%u",
-	       vnode->fid.vnode, vnode->fid.unique, vnode->status.data_version,
-	       buffer, buflen);
-
-	memcpy(&aux, buffer, sizeof(aux));
-
-	/* check the size of the data is what we're expecting */
-	if (buflen != sizeof(aux)) {
-		_leave(" = OBSOLETE [len %hx != %zx]", buflen, sizeof(aux));
-		return FSCACHE_CHECKAUX_OBSOLETE;
-	}
-
-	if (vnode->status.data_version != aux.data_version) {
-		_leave(" = OBSOLETE [vers %llx != %llx]",
-		       aux.data_version, vnode->status.data_version);
-		return FSCACHE_CHECKAUX_OBSOLETE;
-	}
-
-	_leave(" = SUCCESS");
-	return FSCACHE_CHECKAUX_OKAY;
-}
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 887b673f6223..d4cc13ce847b 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -681,9 +681,10 @@ static int afs_activate_cell(struct afs_net *net, struct afs_cell *cell)
 #ifdef CONFIG_AFS_FSCACHE
 	cell->cache = fscache_acquire_cookie(afs_cache_netfs.primary_index,
 					     &afs_cell_cache_index_def,
+					     NULL,
 					     cell->name, strlen(cell->name),
 					     NULL, 0,
-					     cell, 0, true);
+					     0, true);
 #endif
 	ret = afs_proc_cell_setup(cell);
 	if (ret < 0)
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 79c8dc06c0b8..883fa9f67520 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -433,9 +433,10 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 
 	vnode->cache = fscache_acquire_cookie(vnode->volume->cache,
 					      &afs_vnode_cache_index_def,
+					      NULL,
 					      &key, sizeof(key),
 					      &aux, sizeof(aux),
-					      vnode, vnode->status.size, true);
+					      vnode->status.size, true);
 #endif
 }
 
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index f84194b791d3..9ca246ab1a86 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -273,9 +273,9 @@ void afs_activate_volume(struct afs_volume *volume)
 #ifdef CONFIG_AFS_FSCACHE
 	volume->cache = fscache_acquire_cookie(volume->cell->cache,
 					       &afs_volume_cache_index_def,
+					       NULL,
 					       &volume->vid, sizeof(volume->vid),
-					       NULL, 0,
-					       volume, 0, true);
+					       NULL, 0, 0, true);
 #endif
 }
 
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 04d92ad402a4..530ed11bb213 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -7,13 +7,9 @@
 
 #include <linux/slab.h>
 #include <linux/mount.h>
+#include <linux/xattr.h>
 #include "internal.h"
 
-struct cachefiles_lookup_data {
-	struct cachefiles_xattr	*auxdata;	/* auxiliary data */
-	char			*key;		/* key path */
-};
-
 static int cachefiles_attr_changed(struct fscache_object *_object);
 
 /*
@@ -23,11 +19,9 @@ static struct fscache_object *cachefiles_alloc_object(
 	struct fscache_cache *_cache,
 	struct fscache_cookie *cookie)
 {
-	struct cachefiles_lookup_data *lookup_data;
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
-	struct cachefiles_xattr *auxdata;
-	unsigned keylen, auxlen;
+	unsigned keylen;
 	void *buffer, *p;
 	char *key;
 
@@ -35,10 +29,6 @@ static struct fscache_object *cachefiles_alloc_object(
 
 	_enter("{%s},%p,", cache->cache.identifier, cookie);
 
-	lookup_data = kmalloc(sizeof(*lookup_data), cachefiles_gfp);
-	if (!lookup_data)
-		goto nomem_lookup_data;
-
 	/* create a new object record and a temporary leaf image */
 	object = kmem_cache_alloc(cachefiles_object_jar, cachefiles_gfp);
 	if (!object)
@@ -62,10 +52,7 @@ static struct fscache_object *cachefiles_alloc_object(
 		goto nomem_buffer;
 
 	keylen = cookie->key_len;
-	if (keylen <= sizeof(cookie->inline_key))
-		p = cookie->inline_key;
-	else
-		p = cookie->key;
+	p = fscache_get_key(cookie);
 	memcpy(buffer + 2, p, keylen);
 
 	*(uint16_t *)buffer = keylen;
@@ -75,28 +62,13 @@ static struct fscache_object *cachefiles_alloc_object(
 
 	/* turn the raw key into something that can work with as a filename */
 	key = cachefiles_cook_key(buffer, keylen + 2, object->type);
+	kfree(buffer);
 	if (!key)
 		goto nomem_key;
 
-	/* get hold of the auxiliary data and prepend the object type */
-	auxdata = buffer;
-	auxlen = cookie->aux_len;
-	if (auxlen) {
-		if (auxlen <= sizeof(cookie->inline_aux))
-			p = cookie->inline_aux;
-		else
-			p = cookie->aux;
-		memcpy(auxdata->data, p, auxlen);
-	}
-
-	auxdata->len = auxlen + 1;
-	auxdata->type = cookie->type;
-
-	lookup_data->auxdata = auxdata;
-	lookup_data->key = key;
-	object->lookup_data = lookup_data;
+	object->lookup_key = key;
 
-	_leave(" = %p [%p]", &object->fscache, lookup_data);
+	_leave(" = %p [%s]", &object->fscache, key);
 	return &object->fscache;
 
 nomem_key:
@@ -106,8 +78,6 @@ static struct fscache_object *cachefiles_alloc_object(
 	kmem_cache_free(cachefiles_object_jar, object);
 	fscache_object_destroyed(&cache->cache);
 nomem_object:
-	kfree(lookup_data);
-nomem_lookup_data:
 	_leave(" = -ENOMEM");
 	return ERR_PTR(-ENOMEM);
 }
@@ -118,7 +88,6 @@ static struct fscache_object *cachefiles_alloc_object(
  */
 static int cachefiles_lookup_object(struct fscache_object *_object)
 {
-	struct cachefiles_lookup_data *lookup_data;
 	struct cachefiles_object *parent, *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
@@ -130,15 +99,12 @@ static int cachefiles_lookup_object(struct fscache_object *_object)
 	parent = container_of(_object->parent,
 			      struct cachefiles_object, fscache);
 	object = container_of(_object, struct cachefiles_object, fscache);
-	lookup_data = object->lookup_data;
 
-	ASSERTCMP(lookup_data, !=, NULL);
+	ASSERTCMP(object->lookup_key, !=, NULL);
 
 	/* look up the key, creating any missing bits */
 	cachefiles_begin_secure(cache, &saved_cred);
-	ret = cachefiles_walk_to_object(parent, object,
-					lookup_data->key,
-					lookup_data->auxdata);
+	ret = cachefiles_walk_to_object(parent, object, object->lookup_key);
 	cachefiles_end_secure(cache, saved_cred);
 
 	/* polish off by setting the attributes of non-index files */
@@ -165,14 +131,10 @@ static void cachefiles_lookup_complete(struct fscache_object *_object)
 
 	object = container_of(_object, struct cachefiles_object, fscache);
 
-	_enter("{OBJ%x,%p}", object->fscache.debug_id, object->lookup_data);
+	_enter("{OBJ%x}", object->fscache.debug_id);
 
-	if (object->lookup_data) {
-		kfree(object->lookup_data->key);
-		kfree(object->lookup_data->auxdata);
-		kfree(object->lookup_data);
-		object->lookup_data = NULL;
-	}
+	kfree(object->lookup_key);
+	object->lookup_key = NULL;
 }
 
 /*
@@ -204,12 +166,8 @@ struct fscache_object *cachefiles_grab_object(struct fscache_object *_object,
 static void cachefiles_update_object(struct fscache_object *_object)
 {
 	struct cachefiles_object *object;
-	struct cachefiles_xattr *auxdata;
 	struct cachefiles_cache *cache;
-	struct fscache_cookie *cookie;
 	const struct cred *saved_cred;
-	const void *aux;
-	unsigned auxlen;
 
 	_enter("{OBJ%x}", _object->debug_id);
 
@@ -217,40 +175,9 @@ static void cachefiles_update_object(struct fscache_object *_object)
 	cache = container_of(object->fscache.cache, struct cachefiles_cache,
 			     cache);
 
-	if (!fscache_use_cookie(_object)) {
-		_leave(" [relinq]");
-		return;
-	}
-
-	cookie = object->fscache.cookie;
-	auxlen = cookie->aux_len;
-
-	if (!auxlen) {
-		fscache_unuse_cookie(_object);
-		_leave(" [no aux]");
-		return;
-	}
-
-	auxdata = kmalloc(2 + auxlen + 3, cachefiles_gfp);
-	if (!auxdata) {
-		fscache_unuse_cookie(_object);
-		_leave(" [nomem]");
-		return;
-	}
-
-	aux = (auxlen <= sizeof(cookie->inline_aux)) ?
-		cookie->inline_aux : cookie->aux;
-
-	memcpy(auxdata->data, aux, auxlen);
-	fscache_unuse_cookie(_object);
-
-	auxdata->len = auxlen + 1;
-	auxdata->type = cookie->type;
-
 	cachefiles_begin_secure(cache, &saved_cred);
-	cachefiles_update_object_xattr(object, auxdata);
+	cachefiles_set_object_xattr(object, XATTR_REPLACE);
 	cachefiles_end_secure(cache, saved_cred);
-	kfree(auxdata);
 	_leave("");
 }
 
@@ -354,12 +281,7 @@ static void cachefiles_put_object(struct fscache_object *_object,
 		ASSERTCMP(object->fscache.n_ops, ==, 0);
 		ASSERTCMP(object->fscache.n_children, ==, 0);
 
-		if (object->lookup_data) {
-			kfree(object->lookup_data->key);
-			kfree(object->lookup_data->auxdata);
-			kfree(object->lookup_data);
-			object->lookup_data = NULL;
-		}
+		kfree(object->lookup_key);
 
 		cache = object->fscache.cache;
 		fscache_object_destroy(&object->fscache);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index aca73c8403ab..a5d48f271ce1 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -34,7 +34,7 @@ extern unsigned cachefiles_debug;
  */
 struct cachefiles_object {
 	struct fscache_object		fscache;	/* fscache handle */
-	struct cachefiles_lookup_data	*lookup_data;	/* cached lookup data */
+	char				*lookup_key;	/* key to look up */
 	struct dentry			*dentry;	/* the file/dir representing this object */
 	struct dentry			*backer;	/* backing file */
 	loff_t				i_size;		/* object size */
@@ -88,15 +88,6 @@ struct cachefiles_cache {
 	char				*tag;		/* cache binding tag */
 };
 
-/*
- * auxiliary data xattr buffer
- */
-struct cachefiles_xattr {
-	uint16_t			len;
-	uint8_t				type;
-	uint8_t				data[];
-};
-
 #include <trace/events/cachefiles.h>
 
 /*
@@ -142,8 +133,7 @@ extern int cachefiles_delete_object(struct cachefiles_cache *cache,
 				    struct cachefiles_object *object);
 extern int cachefiles_walk_to_object(struct cachefiles_object *parent,
 				     struct cachefiles_object *object,
-				     const char *key,
-				     struct cachefiles_xattr *auxdata);
+				     const char *key);
 extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					       struct dentry *dir,
 					       const char *name);
@@ -204,12 +194,8 @@ static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
  */
 extern int cachefiles_check_object_type(struct cachefiles_object *object);
 extern int cachefiles_set_object_xattr(struct cachefiles_object *object,
-				       struct cachefiles_xattr *auxdata);
-extern int cachefiles_update_object_xattr(struct cachefiles_object *object,
-					  struct cachefiles_xattr *auxdata);
+				       unsigned int xattr_flags);
 extern int cachefiles_check_auxdata(struct cachefiles_object *object);
-extern int cachefiles_check_object_xattr(struct cachefiles_object *object,
-					 struct cachefiles_xattr *auxdata);
 extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 					  struct dentry *dentry);
 
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index ecc8ecbbfa5a..432002080b83 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -45,11 +45,10 @@ void __cachefiles_printk_object(struct cachefiles_object *object,
 	spin_lock(&object->fscache.lock);
 	cookie = object->fscache.cookie;
 	if (cookie) {
-		pr_err("%scookie=%p [pr=%p nd=%p fl=%lx]\n",
+		pr_err("%scookie=%p [pr=%p fl=%lx]\n",
 		       prefix,
 		       object->fscache.cookie,
 		       object->fscache.cookie->parent,
-		       object->fscache.cookie->netfs_data,
 		       object->fscache.cookie->flags);
 		pr_err("%skey=[%u] '", prefix, cookie->key_len);
 		k = (cookie->key_len <= sizeof(cookie->inline_key)) ?
@@ -481,8 +480,7 @@ int cachefiles_delete_object(struct cachefiles_cache *cache,
  */
 int cachefiles_walk_to_object(struct cachefiles_object *parent,
 			      struct cachefiles_object *object,
-			      const char *key,
-			      struct cachefiles_xattr *auxdata)
+			      const char *key)
 {
 	struct cachefiles_cache *cache;
 	struct dentry *dir, *next = NULL;
@@ -636,7 +634,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	if (!object->new) {
 		_debug("validate '%pd'", next);
 
-		ret = cachefiles_check_object_xattr(object, auxdata);
+		ret = cachefiles_check_auxdata(object);
 		if (ret == -ESTALE) {
 			/* delete the object (the deleter drops the directory
 			 * mutex) */
@@ -671,7 +669,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 
 	if (object->new) {
 		/* attach data to a newly constructed terminal object */
-		ret = cachefiles_set_object_xattr(object, auxdata);
+		ret = cachefiles_set_object_xattr(object, XATTR_CREATE);
 		if (ret < 0)
 			goto check_error;
 	} else {
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 72e42438f3d7..5ab8643ca97a 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -15,6 +15,11 @@
 #include <linux/slab.h>
 #include "internal.h"
 
+struct cachefiles_xattr {
+	uint8_t				type;
+	uint8_t				data[];
+} __packed;
+
 static const char cachefiles_xattr_cache[] =
 	XATTR_USER_PREFIX "CacheFiles.cache";
 
@@ -97,56 +102,35 @@ int cachefiles_check_object_type(struct cachefiles_object *object)
  * set the state xattr on a cache file
  */
 int cachefiles_set_object_xattr(struct cachefiles_object *object,
-				struct cachefiles_xattr *auxdata)
-{
-	struct dentry *dentry = object->dentry;
-	int ret;
-
-	ASSERT(dentry);
-
-	_enter("%p,#%d", object, auxdata->len);
-
-	/* attempt to install the cache metadata directly */
-	_debug("SET #%u", auxdata->len);
-
-	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
-	ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
-			   &auxdata->type, auxdata->len,
-			   XATTR_CREATE);
-	if (ret < 0 && ret != -ENOMEM)
-		cachefiles_io_error_obj(
-			object,
-			"Failed to set xattr with error %d", ret);
-
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * update the state xattr on a cache file
- */
-int cachefiles_update_object_xattr(struct cachefiles_object *object,
-				   struct cachefiles_xattr *auxdata)
+				unsigned int xattr_flags)
 {
+	struct cachefiles_xattr *buf;
 	struct dentry *dentry = object->dentry;
+	unsigned int len = object->fscache.cookie->aux_len;
 	int ret;
 
 	if (!dentry)
 		return -ESTALE;
 
-	_enter("%p,#%d", object, auxdata->len);
+	_enter("%p,#%d", object, len);
 
-	/* attempt to install the cache metadata directly */
-	_debug("SET #%u", auxdata->len);
+	buf = kmalloc(sizeof(struct cachefiles_xattr) + len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf->type = object->fscache.cookie->def->type;
+	if (len > 0)
+		memcpy(buf->data, fscache_get_aux(object->fscache.cookie), len);
 
 	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
 	ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
-			   &auxdata->type, auxdata->len,
-			   XATTR_REPLACE);
+			   buf, sizeof(struct cachefiles_xattr) + len,
+			   xattr_flags);
+	kfree(buf);
 	if (ret < 0 && ret != -ENOMEM)
 		cachefiles_io_error_obj(
 			object,
-			"Failed to update xattr with error %d", ret);
+			"Failed to set xattr with error %d", ret);
 
 	_leave(" = %d", ret);
 	return ret;
@@ -157,148 +141,30 @@ int cachefiles_update_object_xattr(struct cachefiles_object *object,
  */
 int cachefiles_check_auxdata(struct cachefiles_object *object)
 {
-	struct cachefiles_xattr *auxbuf;
-	enum fscache_checkaux validity;
+	struct cachefiles_xattr *buf;
 	struct dentry *dentry = object->dentry;
-	ssize_t xlen;
-	int ret;
+	unsigned int len = object->fscache.cookie->aux_len, tlen;
+	const void *p = fscache_get_aux(object->fscache.cookie);
+	ssize_t ret;
 
 	ASSERT(dentry);
 	ASSERT(d_backing_inode(dentry));
-	ASSERT(object->fscache.cookie->def->check_aux);
 
-	auxbuf = kmalloc(sizeof(struct cachefiles_xattr) + 512, GFP_KERNEL);
-	if (!auxbuf)
+	tlen = sizeof(struct cachefiles_xattr) + len;
+	buf = kmalloc(tlen, GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
-	xlen = vfs_getxattr(dentry, cachefiles_xattr_cache,
-			    &auxbuf->type, 512 + 1);
-	ret = -ESTALE;
-	if (xlen < 1 ||
-	    auxbuf->type != object->fscache.cookie->def->type)
-		goto error;
-
-	xlen--;
-	validity = fscache_check_aux(&object->fscache, &auxbuf->data, xlen,
-				     i_size_read(d_backing_inode(dentry)));
-	if (validity != FSCACHE_CHECKAUX_OKAY)
-		goto error;
-
-	ret = 0;
-error:
-	kfree(auxbuf);
-	return ret;
-}
-
-/*
- * check the state xattr on a cache file
- * - return -ESTALE if the object should be deleted
- */
-int cachefiles_check_object_xattr(struct cachefiles_object *object,
-				  struct cachefiles_xattr *auxdata)
-{
-	struct cachefiles_xattr *auxbuf;
-	struct dentry *dentry = object->dentry;
-	int ret;
-
-	_enter("%p,#%d", object, auxdata->len);
-
-	ASSERT(dentry);
-	ASSERT(d_backing_inode(dentry));
-
-	auxbuf = kmalloc(sizeof(struct cachefiles_xattr) + 512, cachefiles_gfp);
-	if (!auxbuf) {
-		_leave(" = -ENOMEM");
-		return -ENOMEM;
-	}
-
-	/* read the current type label */
-	ret = vfs_getxattr(dentry, cachefiles_xattr_cache,
-			   &auxbuf->type, 512 + 1);
-	if (ret < 0) {
-		if (ret == -ENODATA)
-			goto stale; /* no attribute - power went off
-				     * mid-cull? */
-
-		if (ret == -ERANGE)
-			goto bad_type_length;
-
-		cachefiles_io_error_obj(object,
-					"Can't read xattr on %lu (err %d)",
-					d_backing_inode(dentry)->i_ino, -ret);
-		goto error;
-	}
-
-	/* check the on-disk object */
-	if (ret < 1)
-		goto bad_type_length;
-
-	if (auxbuf->type != auxdata->type)
-		goto stale;
-
-	auxbuf->len = ret;
-
-	/* consult the netfs */
-	if (object->fscache.cookie->def->check_aux) {
-		enum fscache_checkaux result;
-		unsigned int dlen;
-
-		dlen = auxbuf->len - 1;
-
-		_debug("checkaux %s #%u",
-		       object->fscache.cookie->def->name, dlen);
-
-		result = fscache_check_aux(&object->fscache,
-					   &auxbuf->data, dlen,
-					   i_size_read(d_backing_inode(dentry)));
-
-		switch (result) {
-			/* entry okay as is */
-		case FSCACHE_CHECKAUX_OKAY:
-			goto okay;
-
-			/* entry requires update */
-		case FSCACHE_CHECKAUX_NEEDS_UPDATE:
-			break;
-
-			/* entry requires deletion */
-		case FSCACHE_CHECKAUX_OBSOLETE:
-			goto stale;
-
-		default:
-			BUG();
-		}
-
-		/* update the current label */
-		ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
-				   &auxdata->type, auxdata->len,
-				   XATTR_REPLACE);
-		if (ret < 0) {
-			cachefiles_io_error_obj(object,
-						"Can't update xattr on %lu"
-						" (error %d)",
-						d_backing_inode(dentry)->i_ino, -ret);
-			goto error;
-		}
-	}
-
-okay:
-	ret = 0;
+	ret = vfs_getxattr(dentry, cachefiles_xattr_cache, buf, tlen);
+	if (ret == tlen &&
+	    buf->type == object->fscache.cookie->def->type &&
+	    memcmp(buf->data, p, len) == 0)
+		ret = 0;
+	else
+		ret = -ESTALE;
 
-error:
-	kfree(auxbuf);
-	_leave(" = %d", ret);
+	kfree(buf);
 	return ret;
-
-bad_type_length:
-	pr_err("Cache object %lu xattr length incorrect\n",
-	       d_backing_inode(dentry)->i_ino);
-	ret = -EIO;
-	goto error;
-
-stale:
-	ret = -ESTALE;
-	goto error;
 }
 
 /*
diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index 7de6d4cd29ee..2231691845b8 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -30,6 +30,7 @@ struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
 	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
 		if (strcmp(tag->name, name) == 0) {
 			atomic_inc(&tag->usage);
+			refcount_inc(&tag->ref);
 			up_read(&fscache_addremove_sem);
 			return tag;
 		}
@@ -44,6 +45,7 @@ struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
 		return ERR_PTR(-ENOMEM);
 
 	atomic_set(&xtag->usage, 1);
+	refcount_set(&xtag->ref, 1);
 	strcpy(xtag->name, name);
 
 	/* write lock, search again and add if still not present */
@@ -52,6 +54,7 @@ struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
 	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
 		if (strcmp(tag->name, name) == 0) {
 			atomic_inc(&tag->usage);
+			refcount_inc(&tag->ref);
 			up_write(&fscache_addremove_sem);
 			kfree(xtag);
 			return tag;
@@ -64,7 +67,7 @@ struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
 }
 
 /*
- * release a reference to a cache tag
+ * Unuse a cache tag
  */
 void __fscache_release_cache_tag(struct fscache_cache_tag *tag)
 {
@@ -77,8 +80,7 @@ void __fscache_release_cache_tag(struct fscache_cache_tag *tag)
 			tag = NULL;
 
 		up_write(&fscache_addremove_sem);
-
-		kfree(tag);
+		fscache_put_cache_tag(tag);
 	}
 }
 
@@ -130,20 +132,10 @@ struct fscache_cache *fscache_select_cache_for_object(
 
 	spin_unlock(&cookie->lock);
 
-	if (!cookie->def->select_cache)
-		goto no_preference;
-
-	/* ask the netfs for its preference */
-	tag = cookie->def->select_cache(cookie->parent->netfs_data,
-					cookie->netfs_data);
+	tag = cookie->preferred_cache;
 	if (!tag)
 		goto no_preference;
 
-	if (tag == ERR_PTR(-ENOMEM)) {
-		_leave(" = NULL [nomem tag]");
-		return NULL;
-	}
-
 	if (!tag->cache) {
 		_leave(" = NULL [unbacked tag]");
 		return NULL;
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index b35f727cc0d4..e38f02589077 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -43,11 +43,10 @@ static void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 	       cookie->flags,
 	       atomic_read(&cookie->n_children),
 	       atomic_read(&cookie->n_active));
-	pr_err("%c-cookie d=%p{%s} n=%p\n",
+	pr_err("%c-cookie d=%p{%s}\n",
 	       prefix,
 	       cookie->def,
-	       cookie->def ? cookie->def->name : "?",
-	       cookie->netfs_data);
+	       cookie->def ? cookie->def->name : "?");
 
 	o = READ_ONCE(cookie->backing_objects.first);
 	if (o) {
@@ -74,6 +73,7 @@ void fscache_free_cookie(struct fscache_cookie *cookie)
 			kfree(cookie->aux);
 		if (cookie->key_len > sizeof(cookie->inline_key))
 			kfree(cookie->key);
+		fscache_put_cache_tag(cookie->preferred_cache);
 		kmem_cache_free(fscache_cookie_jar, cookie);
 	}
 }
@@ -150,9 +150,9 @@ static atomic_t fscache_cookie_debug_id = ATOMIC_INIT(1);
 struct fscache_cookie *fscache_alloc_cookie(
 	struct fscache_cookie *parent,
 	const struct fscache_cookie_def *def,
+	struct fscache_cache_tag *preferred_cache,
 	const void *index_key, size_t index_key_len,
 	const void *aux_data, size_t aux_data_len,
-	void *netfs_data,
 	loff_t object_size)
 {
 	struct fscache_cookie *cookie;
@@ -187,7 +187,9 @@ struct fscache_cookie *fscache_alloc_cookie(
 
 	cookie->def		= def;
 	cookie->parent		= parent;
-	cookie->netfs_data	= netfs_data;
+
+	cookie->preferred_cache	= fscache_get_cache_tag(preferred_cache);
+	
 	cookie->flags		= (1 << FSCACHE_COOKIE_NO_DATA_YET);
 	cookie->type		= def->type;
 	spin_lock_init(&cookie->lock);
@@ -252,7 +254,6 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
  *   - the top level index cookie for each netfs is stored in the fscache_netfs
  *     struct upon registration
  * - def points to the definition
- * - the netfs_data will be passed to the functions pointed to in *def
  * - all attached caches will be searched to see if they contain this object
  * - index objects aren't stored on disk until there's a dependent file that
  *   needs storing
@@ -264,9 +265,9 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
 struct fscache_cookie *__fscache_acquire_cookie(
 	struct fscache_cookie *parent,
 	const struct fscache_cookie_def *def,
+	struct fscache_cache_tag *preferred_cache,
 	const void *index_key, size_t index_key_len,
 	const void *aux_data, size_t aux_data_len,
-	void *netfs_data,
 	loff_t object_size,
 	bool enable)
 {
@@ -274,9 +275,9 @@ struct fscache_cookie *__fscache_acquire_cookie(
 
 	BUG_ON(!def);
 
-	_enter("{%s},{%s},%p,%u",
+	_enter("{%s},{%s},%u",
 	       parent ? (char *) parent->def->name : "<no-parent>",
-	       def->name, netfs_data, enable);
+	       def->name, enable);
 
 	if (!index_key || !index_key_len || index_key_len > 255 || aux_data_len > 255)
 		return NULL;
@@ -300,10 +301,10 @@ struct fscache_cookie *__fscache_acquire_cookie(
 	BUG_ON(def->type == FSCACHE_COOKIE_TYPE_INDEX &&
 	       parent->type != FSCACHE_COOKIE_TYPE_INDEX);
 
-	candidate = fscache_alloc_cookie(parent, def,
+	candidate = fscache_alloc_cookie(parent, def, preferred_cache,
 					 index_key, index_key_len,
 					 aux_data, aux_data_len,
-					 netfs_data, object_size);
+					 object_size);
 	if (!candidate) {
 		fscache_stat(&fscache_n_acquires_oom);
 		_leave(" [ENOMEM]");
@@ -814,8 +815,8 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
 		return;
 	}
 
-	_enter("%p{%s,%p,%d},%d",
-	       cookie, cookie->def->name, cookie->netfs_data,
+	_enter("%p{%s,%d},%d",
+	       cookie, cookie->def->name,
 	       atomic_read(&cookie->n_active), retire);
 
 	trace_fscache_relinquish(cookie, retire);
@@ -827,7 +828,6 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
 	__fscache_disable_cookie(cookie, aux_data, retire);
 
 	/* Clear pointers back to the netfs */
-	cookie->netfs_data	= NULL;
 	cookie->def		= NULL;
 
 	if (cookie->parent) {
@@ -981,8 +981,8 @@ static int fscache_cookies_seq_show(struct seq_file *m, void *v)
 
 	if (v == &fscache_cookies) {
 		seq_puts(m,
-			 "COOKIE   PARENT   USAGE CHILD ACT TY FL  DEF              NETFS_DATA\n"
-			 "======== ======== ===== ===== === == === ================ ==========\n"
+			 "COOKIE   PARENT   USAGE CHILD ACT TY FL  DEF             \n"
+			 "======== ======== ===== ===== === == === ================\n"
 			 );
 		return 0;
 	}
@@ -1004,7 +1004,7 @@ static int fscache_cookies_seq_show(struct seq_file *m, void *v)
 	}
 
 	seq_printf(m,
-		   "%08x %08x %5u %5u %3u %s %03lx %-16s %px",
+		   "%08x %08x %5u %5u %3u %s %03lx %-16s",
 		   cookie->debug_id,
 		   cookie->parent ? cookie->parent->debug_id : 0,
 		   atomic_read(&cookie->usage),
@@ -1012,8 +1012,7 @@ static int fscache_cookies_seq_show(struct seq_file *m, void *v)
 		   atomic_read(&cookie->n_active),
 		   type,
 		   cookie->flags,
-		   cookie->def->name,
-		   cookie->netfs_data);
+		   cookie->def->name);
 
 	keylen = cookie->key_len;
 	auxlen = cookie->aux_len;
diff --git a/fs/fscache/fsdef.c b/fs/fscache/fsdef.c
index 5f8f6fe243fe..0e2e242121fe 100644
--- a/fs/fscache/fsdef.c
+++ b/fs/fscache/fsdef.c
@@ -9,12 +9,6 @@
 #include <linux/module.h>
 #include "internal.h"
 
-static
-enum fscache_checkaux fscache_fsdef_netfs_check_aux(void *cookie_netfs_data,
-						    const void *data,
-						    uint16_t datalen,
-						    loff_t object_size);
-
 /*
  * The root index is owned by FS-Cache itself.
  *
@@ -64,35 +58,4 @@ EXPORT_SYMBOL(fscache_fsdef_index);
 struct fscache_cookie_def fscache_fsdef_netfs_def = {
 	.name		= "FSDEF.netfs",
 	.type		= FSCACHE_COOKIE_TYPE_INDEX,
-	.check_aux	= fscache_fsdef_netfs_check_aux,
 };
-
-/*
- * check that the index structure version number stored in the auxiliary data
- * matches the one the netfs gave us
- */
-static enum fscache_checkaux fscache_fsdef_netfs_check_aux(
-	void *cookie_netfs_data,
-	const void *data,
-	uint16_t datalen,
-	loff_t object_size)
-{
-	struct fscache_netfs *netfs = cookie_netfs_data;
-	uint32_t version;
-
-	_enter("{%s},,%hu", netfs->name, datalen);
-
-	if (datalen != sizeof(version)) {
-		_leave(" = OBSOLETE [dl=%d v=%zu]", datalen, sizeof(version));
-		return FSCACHE_CHECKAUX_OBSOLETE;
-	}
-
-	memcpy(&version, data, sizeof(version));
-	if (version != netfs->version) {
-		_leave(" = OBSOLETE [ver=%x net=%x]", version, netfs->version);
-		return FSCACHE_CHECKAUX_OBSOLETE;
-	}
-
-	_leave(" = OKAY");
-	return FSCACHE_CHECKAUX_OKAY;
-}
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 83dfbe0e3964..7dc447f7f3b0 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -24,6 +24,7 @@
 
 #define pr_fmt(fmt) "FS-Cache: " fmt
 
+#include <linux/slab.h>
 #include <linux/fscache-cache.h>
 #include <trace/events/fscache.h>
 #include <linux/sched.h>
@@ -41,6 +42,20 @@ extern struct rw_semaphore fscache_addremove_sem;
 extern struct fscache_cache *fscache_select_cache_for_object(
 	struct fscache_cookie *);
 
+static inline
+struct fscache_cache_tag *fscache_get_cache_tag(struct fscache_cache_tag *tag)
+{
+	if (tag)
+		refcount_inc(&tag->ref);
+	return tag;
+}
+
+static inline void fscache_put_cache_tag(struct fscache_cache_tag *tag)
+{
+	if (tag && refcount_dec_and_test(&tag->ref))
+		kfree(tag);
+}
+
 /*
  * cookie.c
  */
@@ -50,9 +65,10 @@ extern const struct seq_operations fscache_cookies_seq_ops;
 extern void fscache_free_cookie(struct fscache_cookie *);
 extern struct fscache_cookie *fscache_alloc_cookie(struct fscache_cookie *,
 						   const struct fscache_cookie_def *,
+						   struct fscache_cache_tag *,
 						   const void *, size_t,
 						   const void *, size_t,
-						   void *, loff_t);
+						   loff_t);
 extern struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *);
 extern void fscache_cookie_put(struct fscache_cookie *,
 			       enum fscache_cookie_trace);
@@ -329,16 +345,9 @@ static inline void fscache_cookie_get(struct fscache_cookie *cookie,
 static inline
 void fscache_update_aux(struct fscache_cookie *cookie, const void *aux_data)
 {
-	void *p;
-
-	if (!aux_data)
-		return;
-	if (cookie->aux_len <= sizeof(cookie->inline_aux))
-		p = cookie->inline_aux;
-	else
-		p = cookie->aux;
+	void *p = fscache_get_aux(cookie);
 
-	if (memcmp(p, aux_data, cookie->aux_len) != 0) {
+	if (p && memcmp(p, aux_data, cookie->aux_len) != 0) {
 		memcpy(p, aux_data, cookie->aux_len);
 		set_bit(FSCACHE_COOKIE_AUX_UPDATED, &cookie->flags);
 	}
diff --git a/fs/fscache/netfs.c b/fs/fscache/netfs.c
index cce92216fa28..8ce4c7fa11a0 100644
--- a/fs/fscache/netfs.c
+++ b/fs/fscache/netfs.c
@@ -22,9 +22,10 @@ int __fscache_register_netfs(struct fscache_netfs *netfs)
 	/* allocate a cookie for the primary index */
 	candidate = fscache_alloc_cookie(&fscache_fsdef_index,
 					 &fscache_fsdef_netfs_def,
+					 NULL,
 					 netfs->name, strlen(netfs->name),
 					 &netfs->version, sizeof(netfs->version),
-					 netfs, 0);
+					 0);
 	if (!candidate) {
 		_leave(" = -ENOMEM");
 		return -ENOMEM;
diff --git a/fs/fscache/object-list.c b/fs/fscache/object-list.c
index 1a0dc32c0a33..240e71d3faf2 100644
--- a/fs/fscache/object-list.c
+++ b/fs/fscache/object-list.c
@@ -170,7 +170,7 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 	if ((unsigned long) v == 1) {
 		seq_puts(m, "OBJECT   PARENT   STAT CHLDN OPS OOP IPR EX READS"
 			 " EM EV FL S"
-			 " | COOKIE   NETFS_COOKIE_DEF TY FL NETFS_DATA");
+			 " | COOKIE   NETFS_COOKIE_DEF TY FL");
 		if (config & (FSCACHE_OBJLIST_CONFIG_KEY |
 			      FSCACHE_OBJLIST_CONFIG_AUX))
 			seq_puts(m, "       ");
@@ -189,7 +189,7 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 	if ((unsigned long) v == 2) {
 		seq_puts(m, "======== ======== ==== ===== === === === == ====="
 			 " == == == ="
-			 " | ======== ================ == === ================");
+			 " | ======== ================ == ===");
 		if (config & (FSCACHE_OBJLIST_CONFIG_KEY |
 			      FSCACHE_OBJLIST_CONFIG_AUX))
 			seq_puts(m, " ================");
@@ -263,12 +263,11 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 			break;
 		}
 
-		seq_printf(m, "%08x %-16s %s %3lx %16p",
+		seq_printf(m, "%08x %-16s %s %3lx",
 			   cookie->debug_id,
 			   cookie->def->name,
 			   type,
-			   cookie->flags,
-			   cookie->netfs_data);
+			   cookie->flags);
 
 		if (config & FSCACHE_OBJLIST_CONFIG_KEY)
 			keylen = cookie->key_len;
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 3d7f956a01c6..4ee9b5473c43 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -910,54 +910,6 @@ static void fscache_dequeue_object(struct fscache_object *object)
 	_leave("");
 }
 
-/**
- * fscache_check_aux - Ask the netfs whether an object on disk is still valid
- * @object: The object to ask about
- * @data: The auxiliary data for the object
- * @datalen: The size of the auxiliary data
- *
- * This function consults the netfs about the coherency state of an object.
- * The caller must be holding a ref on cookie->n_active (held by
- * fscache_look_up_object() on behalf of the cache backend during object lookup
- * and creation).
- */
-enum fscache_checkaux fscache_check_aux(struct fscache_object *object,
-					const void *data, uint16_t datalen,
-					loff_t object_size)
-{
-	enum fscache_checkaux result;
-
-	if (!object->cookie->def->check_aux) {
-		fscache_stat(&fscache_n_checkaux_none);
-		return FSCACHE_CHECKAUX_OKAY;
-	}
-
-	result = object->cookie->def->check_aux(object->cookie->netfs_data,
-						data, datalen, object_size);
-	switch (result) {
-		/* entry okay as is */
-	case FSCACHE_CHECKAUX_OKAY:
-		fscache_stat(&fscache_n_checkaux_okay);
-		break;
-
-		/* entry requires update */
-	case FSCACHE_CHECKAUX_NEEDS_UPDATE:
-		fscache_stat(&fscache_n_checkaux_update);
-		break;
-
-		/* entry requires deletion */
-	case FSCACHE_CHECKAUX_OBSOLETE:
-		fscache_stat(&fscache_n_checkaux_obsolete);
-		break;
-
-	default:
-		BUG();
-	}
-
-	return result;
-}
-EXPORT_SYMBOL(fscache_check_aux);
-
 /*
  * Asynchronously invalidate an object.
  */
diff --git a/fs/nfs/fscache-index.c b/fs/nfs/fscache-index.c
index 573b1da9342c..b1049815729e 100644
--- a/fs/nfs/fscache-index.c
+++ b/fs/nfs/fscache-index.c
@@ -106,7 +106,7 @@ enum fscache_checkaux nfs_fscache_inode_check_aux(void *cookie_netfs_data,
  *   cache fails with EIO - in which case the server must be contacted to
  *   retrieve the data, which requires the read context for security.
  */
-static void nfs_fh_get_context(void *cookie_netfs_data, void *context)
+static void nfs_fh_get_context(void *context)
 {
 	get_nfs_open_context(context);
 }
@@ -116,7 +116,7 @@ static void nfs_fh_get_context(void *cookie_netfs_data, void *context)
  * - This function can be absent if the completion function doesn't require a
  *   context.
  */
-static void nfs_fh_put_context(void *cookie_netfs_data, void *context)
+static void nfs_fh_put_context(void *context)
 {
 	if (context)
 		put_nfs_open_context(context);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index f01fe979b323..0b395bcb4b16 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -45,8 +45,9 @@ struct fscache_cache_tag {
 	struct fscache_cache	*cache;		/* cache referred to by this tag */
 	unsigned long		flags;
 #define FSCACHE_TAG_RESERVED	0		/* T if tag is reserved for a cache */
-	atomic_t		usage;
-	char			name[];	/* tag name */
+	atomic_t		usage;		/* Number of using netfs's */
+	refcount_t		ref;		/* Reference count on structure */
+	char			name[];		/* tag name */
 };
 
 /*
@@ -414,11 +415,6 @@ extern void fscache_io_error(struct fscache_cache *cache);
 
 extern bool fscache_object_sleep_till_congested(signed long *timeoutp);
 
-extern enum fscache_checkaux fscache_check_aux(struct fscache_object *object,
-					       const void *data,
-					       uint16_t datalen,
-					       loff_t object_size);
-
 extern void fscache_object_retrying_stale(struct fscache_object *object);
 
 enum fscache_why_object_killed {
@@ -430,4 +426,26 @@ enum fscache_why_object_killed {
 extern void fscache_object_mark_killed(struct fscache_object *object,
 				       enum fscache_why_object_killed why);
 
+/*
+ * Find the key on a cookie.
+ */
+static inline void *fscache_get_key(struct fscache_cookie *cookie)
+{
+	if (cookie->key_len <= sizeof(cookie->inline_key))
+		return cookie->inline_key;
+	else
+		return cookie->key;
+}
+
+/*
+ * Find the auxiliary data on a cookie.
+ */
+static inline void *fscache_get_aux(struct fscache_cookie *cookie)
+{
+	if (cookie->aux_len <= sizeof(cookie->inline_aux))
+		return cookie->inline_aux;
+	else
+		return cookie->aux;
+}
+
 #endif /* _LINUX_FSCACHE_CACHE_H */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 143d48281117..a9a11dff6eae 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -47,13 +47,6 @@ struct fscache_cache_tag;
 struct fscache_cookie;
 struct fscache_netfs;
 
-/* result of index entry consultation */
-enum fscache_checkaux {
-	FSCACHE_CHECKAUX_OKAY,		/* entry okay as is */
-	FSCACHE_CHECKAUX_NEEDS_UPDATE,	/* entry requires update */
-	FSCACHE_CHECKAUX_OBSOLETE,	/* entry requires deletion */
-};
-
 /*
  * fscache cookie definition
  */
@@ -65,26 +58,6 @@ struct fscache_cookie_def {
 	uint8_t type;
 #define FSCACHE_COOKIE_TYPE_INDEX	0
 #define FSCACHE_COOKIE_TYPE_DATAFILE	1
-
-	/* select the cache into which to insert an entry in this index
-	 * - optional
-	 * - should return a cache identifier or NULL to cause the cache to be
-	 *   inherited from the parent if possible or the first cache picked
-	 *   for a non-index file if not
-	 */
-	struct fscache_cache_tag *(*select_cache)(
-		const void *parent_netfs_data,
-		const void *cookie_netfs_data);
-
-	/* consult the netfs about the state of an object
-	 * - this function can be absent if the index carries no state data
-	 * - the netfs data from the cookie being used as the target is
-	 *   presented, as is the auxiliary data and the object size
-	 */
-	enum fscache_checkaux (*check_aux)(void *cookie_netfs_data,
-					   const void *data,
-					   uint16_t datalen,
-					   loff_t object_size);
 };
 
 /*
@@ -114,9 +87,9 @@ struct fscache_cookie {
 	struct hlist_head		backing_objects; /* object(s) backing this file/index */
 	const struct fscache_cookie_def	*def;		/* definition */
 	struct fscache_cookie		*parent;	/* parent of this entry */
+	struct fscache_cache_tag	*preferred_cache; /* The preferred cache or NULL */
 	struct hlist_bl_node		hash_link;	/* Link in hash table */
 	struct list_head		proc_link;	/* Link in proc list */
-	void				*netfs_data;	/* back pointer to netfs */
 
 	unsigned long			flags;
 #define FSCACHE_COOKIE_LOOKING_UP	0	/* T if non-index cookie being looked up still */
@@ -164,9 +137,10 @@ extern void __fscache_release_cache_tag(struct fscache_cache_tag *);
 extern struct fscache_cookie *__fscache_acquire_cookie(
 	struct fscache_cookie *,
 	const struct fscache_cookie_def *,
+	struct fscache_cache_tag *,
 	const void *, size_t,
 	const void *, size_t,
-	void *, loff_t, bool);
+	loff_t, bool);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, const void *, bool);
 extern int __fscache_check_consistency(struct fscache_cookie *, const void *);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *);
@@ -252,6 +226,7 @@ void fscache_release_cache_tag(struct fscache_cache_tag *tag)
  * fscache_acquire_cookie - Acquire a cookie to represent a cache object
  * @parent: The cookie that's to be the parent of this one
  * @def: A description of the cache object, including callback operations
+ * @preferred_cache: The cache to use (or NULL)
  * @index_key: The index key for this cookie
  * @index_key_len: Size of the index key
  * @aux_data: The auxiliary data for the cookie (may be NULL)
@@ -272,19 +247,19 @@ static inline
 struct fscache_cookie *fscache_acquire_cookie(
 	struct fscache_cookie *parent,
 	const struct fscache_cookie_def *def,
+	struct fscache_cache_tag *preferred_cache,
 	const void *index_key,
 	size_t index_key_len,
 	const void *aux_data,
 	size_t aux_data_len,
-	void *netfs_data,
 	loff_t object_size,
 	bool enable)
 {
 	if (fscache_cookie_valid(parent) && fscache_cookie_enabled(parent))
-		return __fscache_acquire_cookie(parent, def,
+		return __fscache_acquire_cookie(parent, def, preferred_cache,
 						index_key, index_key_len,
 						aux_data, aux_data_len,
-						netfs_data, object_size, enable);
+						object_size, enable);
 	else
 		return NULL;
 }


