Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4AC2BAD95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgKTPIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:08:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728433AbgKTPI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s7fzbShTnt/EGdkmPVwiKODlhzJ33cWPfces6TfHv4s=;
        b=N7cImae/f+OipbSclbo79DptA1XBI4J89WWogNTPLn8UK0PBUvm9VYE1dizkbddSiibN22
        a9XaOFTfJpqlUVdtLY1xy+3jgyP0WVDZPNPLCwIGVUVOSEloYxmBf0O2QV6xAFNivPslTx
        sSbXhZ5uJ9Vg6askYwIU135IBR/F5+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-30vjRpfdOQyfxvazTT9htg-1; Fri, 20 Nov 2020 10:08:09 -0500
X-MC-Unique: 30vjRpfdOQyfxvazTT9htg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4676A100C634;
        Fri, 20 Nov 2020 15:08:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 442385C224;
        Fri, 20 Nov 2020 15:07:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 25/76] fscache: Replace the object management state
 machine
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
Date:   Fri, 20 Nov 2020 15:07:55 +0000
Message-ID: <160588487538.3465195.17400193823685775453.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace the object management state machine with something a lot simpler.
The entire process of setting up or tearing down a cookie is done in one
go, and the dispatcher either punts it to a worker thread, or if all the
worker threads are all busy, does it in the current thread.

fscache_enable_cookie() and fscache_disable_cookie() are replaced by 'use'
and 'unuse' routines to which the mode of access (readonly or writable) is
declared - these then impose the policy of what to do with the backing
object.

The policy for handling local writes is declared to
fscache_acquire_cookie() using FSACHE_ADV_WRITE_*CACHE flags.  This only
allows for the possibility of suspending caching whilst a file is open for
writing; policies such as write-through and write-back have to be handled
at the netfs level.

At some point in the future, object records that aren't in use will get put
on an LRU and discarded under memory pressure or if they haven't been used
for a while.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c                     |    4 
 fs/afs/file.c                     |   15 +
 fs/afs/inode.c                    |   13 
 fs/afs/volume.c                   |    4 
 fs/cachefiles/bind.c              |    4 
 fs/cachefiles/interface.c         |  165 +++---
 fs/cachefiles/internal.h          |   12 
 fs/cachefiles/main.c              |   11 
 fs/cachefiles/namei.c             |   60 +-
 fs/cachefiles/xattr.c             |    1 
 fs/fscache/Makefile               |    3 
 fs/fscache/cache.c                |  136 +++--
 fs/fscache/cookie.c               |  675 ++++++++++---------------
 fs/fscache/fsdef.c                |    1 
 fs/fscache/histogram.c            |    2 
 fs/fscache/internal.h             |   68 +--
 fs/fscache/main.c                 |   41 --
 fs/fscache/netfs.c                |    4 
 fs/fscache/obj.c                  |  371 ++++++++++++++
 fs/fscache/object-list.c          |   58 --
 fs/fscache/object.c               |  981 -------------------------------------
 fs/fscache/object_bits.c          |  120 +++++
 fs/fscache/proc.c                 |    6 
 fs/fscache/stats.c                |    2 
 include/linux/fscache-cache.h     |  210 ++------
 include/linux/fscache.h           |  192 +++----
 include/trace/events/cachefiles.h |   17 -
 include/trace/events/fscache.h    |  135 +----
 28 files changed, 1229 insertions(+), 2082 deletions(-)
 create mode 100644 fs/fscache/obj.c
 delete mode 100644 fs/fscache/object.c
 create mode 100644 fs/fscache/object_bits.c

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 585fd10da5be..3500f9b4317d 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -686,7 +686,7 @@ static int afs_activate_cell(struct afs_net *net, struct afs_cell *cell)
 					     NULL,
 					     cell->name, strlen(cell->name),
 					     NULL, 0,
-					     0, true);
+					     0);
 #endif
 	ret = afs_proc_cell_setup(cell);
 	if (ret < 0)
@@ -725,7 +725,7 @@ static void afs_deactivate_cell(struct afs_net *net, struct afs_cell *cell)
 	mutex_unlock(&net->proc_cells_lock);
 
 #ifdef CONFIG_AFS_FSCACHE
-	fscache_relinquish_cookie(cell->cache, NULL, false);
+	fscache_relinquish_cookie(cell->cache, false);
 	cell->cache = NULL;
 #endif
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 6d43713fde01..ba8874720626 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -146,7 +146,9 @@ int afs_open(struct inode *inode, struct file *file)
 
 	if (file->f_flags & O_TRUNC)
 		set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
-	
+
+	fscache_use_cookie(afs_vnode_cache(vnode), file->f_mode & FMODE_WRITE);
+
 	file->private_data = af;
 	_leave(" = 0");
 	return 0;
@@ -165,8 +167,10 @@ int afs_open(struct inode *inode, struct file *file)
  */
 int afs_release(struct inode *inode, struct file *file)
 {
+	struct afs_vnode_cache_aux aux;
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct afs_file *af = file->private_data;
+	loff_t i_size;
 	int ret = 0;
 
 	_enter("{%llx:%llu},", vnode->fid.vid, vnode->fid.vnode);
@@ -177,6 +181,15 @@ int afs_release(struct inode *inode, struct file *file)
 	file->private_data = NULL;
 	if (af->wb)
 		afs_put_wb_key(af->wb);
+
+	if ((file->f_mode & FMODE_WRITE)) {
+		i_size = i_size_read(&vnode->vfs_inode);
+		aux.data_version = vnode->status.data_version;
+		fscache_unuse_cookie(afs_vnode_cache(vnode), &aux, &i_size);
+	} else {
+		fscache_unuse_cookie(afs_vnode_cache(vnode), NULL, NULL);
+	}
+
 	key_put(af->key);
 	kfree(af);
 	afs_prune_wb_keys(vnode);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 9f9fd0f85940..df999d703e2b 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -439,7 +439,7 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 		NULL,
 		&key, sizeof(key),
 		&aux, sizeof(aux),
-		vnode->status.size, true);
+		vnode->status.size);
 #endif
 }
 
@@ -793,14 +793,9 @@ void afs_evict_inode(struct inode *inode)
 	}
 
 #ifdef CONFIG_AFS_FSCACHE
-	{
-		struct afs_vnode_cache_aux aux;
-
-		aux.data_version = vnode->status.data_version;
-		fscache_relinquish_cookie(vnode->cache, &aux,
-					  test_bit(AFS_VNODE_DELETED, &vnode->flags));
-		vnode->cache = NULL;
-	}
+	fscache_relinquish_cookie(vnode->cache,
+				  test_bit(AFS_VNODE_DELETED, &vnode->flags));
+	vnode->cache = NULL;
 #endif
 
 	afs_prune_wb_keys(vnode);
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 5eaaa762fbd9..22c54f296d30 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -276,7 +276,7 @@ void afs_activate_volume(struct afs_volume *volume)
 					       "AFS.vol",
 					       0, NULL,
 					       &volume->vid, sizeof(volume->vid),
-					       NULL, 0, 0, true);
+					       NULL, 0, 0);
 #endif
 }
 
@@ -288,7 +288,7 @@ void afs_deactivate_volume(struct afs_volume *volume)
 	_enter("%s", volume->name);
 
 #ifdef CONFIG_AFS_FSCACHE
-	fscache_relinquish_cookie(volume->cache, NULL,
+	fscache_relinquish_cookie(volume->cache,
 				  test_bit(AFS_VOLUME_DELETED, &volume->flags));
 	volume->cache = NULL;
 #endif
diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index 2e9d01a9d53f..a39e65d5103b 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -99,12 +99,10 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	/* allocate the root index object */
 	ret = -ENOMEM;
 
-	fsdef = kmem_cache_alloc(cachefiles_object_jar, GFP_KERNEL);
+	fsdef = kmem_cache_zalloc(cachefiles_object_jar, GFP_KERNEL);
 	if (!fsdef)
 		goto error_root_object;
 
-	ASSERTCMP(fsdef->backer, ==, NULL);
-
 	atomic_set(&fsdef->usage, 1);
 	fsdef->type = FSCACHE_COOKIE_TYPE_INDEX;
 
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index dc2cfbed4250..e40118e65e25 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -8,39 +8,56 @@
 #include <linux/slab.h>
 #include <linux/mount.h>
 #include <linux/xattr.h>
+#include <linux/file.h>
 #include "internal.h"
 
 static int cachefiles_attr_changed(struct cachefiles_object *object);
+static void cachefiles_put_object(struct fscache_object *_object,
+				  enum fscache_obj_ref_trace why);
 
 /*
- * allocate an object record for a cookie lookup and prepare the lookup data
+ * Allocate an object record for a cookie lookup and prepare the lookup data.
+ * Eats the caller's ref on parent.
  */
-static struct fscache_object *cachefiles_alloc_object(
-	struct fscache_cache *_cache,
-	struct fscache_cookie *cookie)
+static
+struct fscache_object *cachefiles_alloc_object(struct fscache_cookie *cookie,
+					       struct fscache_cache *_cache,
+					       struct fscache_object *parent)
 {
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
-	unsigned keylen;
-	void *buffer, *p;
-	char *key;
 
 	cache = container_of(_cache, struct cachefiles_cache, cache);
 
 	_enter("{%s},%x,", cache->cache.identifier, cookie->debug_id);
 
-	/* create a new object record and a temporary leaf image */
-	object = kmem_cache_alloc(cachefiles_object_jar, cachefiles_gfp);
-	if (!object)
-		goto nomem_object;
-
-	ASSERTCMP(object->backer, ==, NULL);
-
-	atomic_set(&object->usage, 1);
+	object = kmem_cache_zalloc(cachefiles_object_jar, cachefiles_gfp);
+	if (!object) {
+		cachefiles_put_object(parent, fscache_obj_put_alloc_fail);
+		return NULL;
+	}
 
 	fscache_object_init(&object->fscache, cookie, &cache->cache);
+	object->fscache.parent = parent;
+	object->fscache.stage = FSCACHE_OBJECT_STAGE_LOOKING_UP;
+	atomic_set(&object->usage, 1);
 
 	object->type = cookie->type;
+	trace_cachefiles_ref(object, cookie,
+			     (enum cachefiles_obj_ref_trace)fscache_obj_new, 1);
+	return &object->fscache;
+}
+
+/*
+ * Prepare data for use in lookup.  This involves cooking the binary key into
+ * something that can be used as a filename.
+ */
+static void *cachefiles_prepare_lookup_data(struct fscache_object *object)
+{
+	struct fscache_cookie *cookie = object->cookie;
+	unsigned keylen;
+	void *buffer, *p;
+	char *key;
 
 	/* get hold of the raw key
 	 * - stick the length on the front and leave space on the back for the
@@ -48,7 +65,7 @@ static struct fscache_object *cachefiles_alloc_object(
 	 */
 	buffer = kmalloc((2 + 512) + 3, cachefiles_gfp);
 	if (!buffer)
-		goto nomem_buffer;
+		goto nomem;
 
 	keylen = cookie->key_len;
 	p = fscache_get_key(cookie);
@@ -60,36 +77,29 @@ static struct fscache_object *cachefiles_alloc_object(
 	((char *)buffer)[keylen + 4] = 0;
 
 	/* turn the raw key into something that can work with as a filename */
-	key = cachefiles_cook_key(buffer, keylen + 2, object->type);
+	key = cachefiles_cook_key(buffer, keylen + 2, cookie->type);
 	kfree(buffer);
 	if (!key)
-		goto nomem_key;
+		goto nomem;
 
-	object->lookup_key = key;
+	_leave(" = %s", key);
+	return key;
 
-	_leave(" = %x [%s]", object->fscache.debug_id, key);
-	return &object->fscache;
-
-nomem_key:
-	kfree(buffer);
-nomem_buffer:
-	kmem_cache_free(cachefiles_object_jar, object);
-	fscache_object_destroyed(&cache->cache);
-nomem_object:
-	_leave(" = -ENOMEM");
+nomem:
 	return ERR_PTR(-ENOMEM);
 }
 
 /*
- * attempt to look up the nominated node in this cache
- * - return -ETIMEDOUT to be scheduled again
+ * Attempt to look up the nominated node in this cache
  */
-static int cachefiles_lookup_object(struct fscache_object *_object)
+static bool cachefiles_lookup_object(struct fscache_object *_object,
+				     void *lookup_data)
 {
 	struct cachefiles_object *parent, *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
-	int ret;
+	char *lookup_key = lookup_data;
+	bool success;
 
 	_enter("{OBJ%x}", _object->debug_id);
 
@@ -98,47 +108,30 @@ static int cachefiles_lookup_object(struct fscache_object *_object)
 			      struct cachefiles_object, fscache);
 	object = container_of(_object, struct cachefiles_object, fscache);
 
-	ASSERTCMP(object->lookup_key, !=, NULL);
+	ASSERTCMP(lookup_key, !=, NULL);
 
 	/* look up the key, creating any missing bits */
 	cachefiles_begin_secure(cache, &saved_cred);
-	ret = cachefiles_walk_to_object(parent, object, object->lookup_key);
+	success = cachefiles_walk_to_object(parent, object, lookup_key);
 	cachefiles_end_secure(cache, saved_cred);
 
 	/* polish off by setting the attributes of non-index files */
-	if (ret == 0 &&
+	if (success &&
 	    object->fscache.cookie->type != FSCACHE_COOKIE_TYPE_INDEX)
 		cachefiles_attr_changed(object);
 
-	if (ret < 0 && ret != -ETIMEDOUT) {
-		if (ret != -ENOBUFS)
-			pr_warn("Lookup failed error %d\n", ret);
-		fscache_object_lookup_error(&object->fscache);
-	}
-
-	_leave(" [%d]", ret);
-	return ret;
+	_leave(" [%d]", success);
+	return success;
 }
 
-/*
- * indication of lookup completion
- */
-static void cachefiles_lookup_complete(struct fscache_object *_object)
+static void cachefiles_free_lookup_data(struct fscache_object *object, void *lookup_data)
 {
-	struct cachefiles_object *object;
-
-	object = container_of(_object, struct cachefiles_object, fscache);
-
-	_enter("{OBJ%x}", object->fscache.debug_id);
-
-	kfree(object->lookup_key);
-	object->lookup_key = NULL;
+	kfree(lookup_data);
 }
 
 /*
  * increment the usage count on an inode object (may fail if unmounting)
  */
-static
 struct fscache_object *cachefiles_grab_object(struct fscache_object *_object,
 					      enum fscache_obj_ref_trace why)
 {
@@ -166,6 +159,8 @@ static void cachefiles_update_object(struct fscache_object *_object)
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
+	loff_t object_size;
+	int ret;
 
 	_enter("{OBJ%x}", _object->debug_id);
 
@@ -174,7 +169,25 @@ static void cachefiles_update_object(struct fscache_object *_object)
 			     cache);
 
 	cachefiles_begin_secure(cache, &saved_cred);
+
+	object_size = object->fscache.cookie->object_size;
+	if (i_size_read(d_inode(object->backer)) > object_size) {
+		struct path path = {
+			.mnt	= cache->mnt,
+			.dentry	= object->backer
+		};
+		_debug("trunc %llx -> %llx", i_size_read(d_inode(object->backer)), object_size);
+		ret = vfs_truncate(&path, object_size);
+		if (ret < 0) {
+			cachefiles_io_error_obj(object, "Trunc-to-size failed");
+			cachefiles_remove_object_xattr(cache, object->backer);
+			goto out;
+		}
+	}
+
 	cachefiles_set_object_xattr(object, XATTR_REPLACE);
+
+out:
 	cachefiles_end_secure(cache, saved_cred);
 	_leave("");
 }
@@ -183,7 +196,8 @@ static void cachefiles_update_object(struct fscache_object *_object)
  * discard the resources pinned by an object and effect retirement if
  * requested
  */
-static void cachefiles_drop_object(struct fscache_object *_object)
+static void cachefiles_drop_object(struct fscache_object *_object,
+				   bool invalidate)
 {
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
@@ -209,17 +223,18 @@ static void cachefiles_drop_object(struct fscache_object *_object)
 	 * before we set it up.
 	 */
 	if (object->dentry) {
-		/* delete retired objects */
-		if (test_bit(FSCACHE_OBJECT_RETIRED, &object->fscache.flags) &&
-		    _object != cache->cache.fsdef
-		    ) {
-			_debug("- retire object OBJ%x", object->fscache.debug_id);
+		if (invalidate && _object != cache->cache.fsdef) {
+			_debug("- inval object OBJ%x", object->fscache.debug_id);
 			cachefiles_begin_secure(cache, &saved_cred);
 			cachefiles_delete_object(cache, object);
 			cachefiles_end_secure(cache, saved_cred);
 		}
 
 		/* close the filesystem stuff attached to the object */
+		if (object->backing_file)
+			fput(object->backing_file);
+		object->backing_file = NULL;
+
 		if (object->backer != object->dentry)
 			dput(object->backer);
 		object->backer = NULL;
@@ -253,9 +268,6 @@ static void cachefiles_put_object(struct fscache_object *_object,
 	ASSERT((atomic_read(&object->usage) & 0xffff0000) != 0x6b6b0000);
 #endif
 
-	ASSERTIFCMP(object->fscache.parent,
-		    object->fscache.parent->n_children, >, 0);
-
 	u = atomic_dec_return(&object->usage);
 	trace_cachefiles_ref(object, _object->cookie,
 			     (enum cachefiles_obj_ref_trace)why, u);
@@ -263,14 +275,10 @@ static void cachefiles_put_object(struct fscache_object *_object,
 	if (u == 0) {
 		_debug("- kill object OBJ%x", object->fscache.debug_id);
 
-		ASSERTCMP(object->fscache.parent, ==, NULL);
 		ASSERTCMP(object->backer, ==, NULL);
 		ASSERTCMP(object->dentry, ==, NULL);
-		ASSERTCMP(object->fscache.n_ops, ==, 0);
 		ASSERTCMP(object->fscache.n_children, ==, 0);
 
-		kfree(object->lookup_key);
-
 		cache = object->fscache.cache;
 		fscache_object_destroy(&object->fscache);
 		kmem_cache_free(cachefiles_object_jar, object);
@@ -376,7 +384,7 @@ static int cachefiles_attr_changed(struct cachefiles_object *object)
 /*
  * Invalidate an object
  */
-static void cachefiles_invalidate_object(struct fscache_object *_object)
+static bool cachefiles_invalidate_object(struct fscache_object *_object)
 {
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
@@ -410,21 +418,32 @@ static void cachefiles_invalidate_object(struct fscache_object *_object)
 			if (ret == -EIO)
 				cachefiles_io_error_obj(object,
 							"Invalidate failed");
+			return false;
 		}
 	}
 
-	_leave("");
+	return true;
+}
+
+static unsigned int cachefiles_get_object_usage(const struct fscache_object *_object)
+{
+	struct cachefiles_object *object;
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+	return atomic_read(&object->usage);
 }
 
 const struct fscache_cache_ops cachefiles_cache_ops = {
 	.name			= "cachefiles",
 	.alloc_object		= cachefiles_alloc_object,
+	.prepare_lookup_data	= cachefiles_prepare_lookup_data,
 	.lookup_object		= cachefiles_lookup_object,
-	.lookup_complete	= cachefiles_lookup_complete,
+	.free_lookup_data	= cachefiles_free_lookup_data,
 	.grab_object		= cachefiles_grab_object,
 	.update_object		= cachefiles_update_object,
 	.invalidate_object	= cachefiles_invalidate_object,
 	.drop_object		= cachefiles_drop_object,
 	.put_object		= cachefiles_put_object,
+	.get_object_usage	= cachefiles_get_object_usage,
 	.sync_cache		= cachefiles_sync_cache,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index f8f308ce7385..b89f76a03546 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -34,13 +34,13 @@ extern unsigned cachefiles_debug;
  */
 struct cachefiles_object {
 	struct fscache_object		fscache;	/* fscache handle */
-	char				*lookup_key;	/* key to look up */
 	struct dentry			*dentry;	/* the file/dir representing this object */
 	struct dentry			*backer;	/* backing file */
+	struct file			*backing_file;	/* File open on backing storage */
 	loff_t				i_size;		/* object size */
 	atomic_t			usage;		/* object usage count */
 	uint8_t				type;		/* object type */
-	uint8_t				new;		/* T if object new */
+	bool				new;		/* T if object new */
 };
 
 extern struct kmem_cache *cachefiles_object_jar;
@@ -112,6 +112,8 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  * interface.c
  */
 extern const struct fscache_cache_ops cachefiles_cache_ops;
+extern struct fscache_object *cachefiles_grab_object(struct fscache_object *_object,
+						     enum fscache_obj_ref_trace why);
 
 /*
  * key.c
@@ -125,9 +127,9 @@ extern void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
 				    struct dentry *dentry);
 extern int cachefiles_delete_object(struct cachefiles_cache *cache,
 				    struct cachefiles_object *object);
-extern int cachefiles_walk_to_object(struct cachefiles_object *parent,
-				     struct cachefiles_object *object,
-				     const char *key);
+extern bool cachefiles_walk_to_object(struct cachefiles_object *parent,
+				      struct cachefiles_object *object,
+				      const char *key);
 extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					       struct dentry *dir,
 					       const char *name);
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index 3f0101a74809..3373f3eddbf8 100644
--- a/fs/cachefiles/main.c
+++ b/fs/cachefiles/main.c
@@ -37,13 +37,6 @@ static struct miscdevice cachefiles_dev = {
 	.fops	= &cachefiles_daemon_fops,
 };
 
-static void cachefiles_object_init_once(void *_object)
-{
-	struct cachefiles_object *object = _object;
-
-	memset(object, 0, sizeof(*object));
-}
-
 /*
  * initialise the fs caching module
  */
@@ -60,9 +53,7 @@ static int __init cachefiles_init(void)
 	cachefiles_object_jar =
 		kmem_cache_create("cachefiles_object_jar",
 				  sizeof(struct cachefiles_object),
-				  0,
-				  SLAB_HWCACHE_ALIGN,
-				  cachefiles_object_init_once);
+				  0, SLAB_HWCACHE_ALIGN, NULL);
 	if (!cachefiles_object_jar) {
 		pr_notice("Failed to allocate an object jar\n");
 		goto error_object_jar;
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 1fb011474765..0a7e2031efa2 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -18,8 +18,6 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-#define CACHEFILES_KEYBUF_SIZE 512
-
 /*
  * Mark the backing file as being a cache file if it's not already in use so.
  */
@@ -255,13 +253,24 @@ int cachefiles_delete_object(struct cachefiles_cache *cache,
 	return ret;
 }
 
+/*
+ * Handle negative lookup.  We create a temporary file for a datafile to use
+ * which we will link into place later.
+ */
+static void cachefiles_negative_lookup(struct cachefiles_object *parent,
+				       struct cachefiles_object *object)
+{
+	// TODO: Use vfs_tmpfile() for datafiles
+	//fscache_object_lookup_negative(&object->fscache);
+}
+
 /*
  * walk from the parent object to the child object through the backing
  * filesystem, creating directories as we go
  */
-int cachefiles_walk_to_object(struct cachefiles_object *parent,
-			      struct cachefiles_object *object,
-			      const char *key)
+bool cachefiles_walk_to_object(struct cachefiles_object *parent,
+			       struct cachefiles_object *object,
+			       const char *key)
 {
 	struct cachefiles_cache *cache;
 	struct dentry *dir, *next = NULL;
@@ -269,7 +278,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	struct path path;
 	unsigned long start;
 	const char *name;
-	bool marked = false;
+	bool marked = false, negated = false;
 	int ret, nlen;
 
 	_enter("OBJ%x{%pd},OBJ%x,%s,",
@@ -286,7 +295,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	if (!(d_is_dir(parent->dentry))) {
 		// TODO: convert file to dir
 		_leave("looking up in none directory");
-		return -ENOBUFS;
+		return false;
 	}
 
 	dir = dget(parent->dentry);
@@ -326,8 +335,10 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	/* if this element of the path doesn't exist, then the lookup phase
 	 * failed, and we can release any readers in the certain knowledge that
 	 * there's nothing for them to actually read */
-	if (d_is_negative(next))
-		fscache_object_lookup_negative(&object->fscache);
+	if (d_is_negative(next) && !negated) {
+		cachefiles_negative_lookup(object, parent);
+		negated = true;
+	}
 
 	/* we need to create the object if it's negative */
 	if (key || object->type == FSCACHE_COOKIE_TYPE_INDEX) {
@@ -442,6 +453,9 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 			fscache_object_retrying_stale(&object->fscache);
 			goto lookup_again;
 		}
+
+		if (ret < 0)
+			goto check_error_unlock;
 	}
 
 	inode_unlock(d_inode(dir));
@@ -467,14 +481,10 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	/* open a file interface onto a data file */
 	if (object->type != FSCACHE_COOKIE_TYPE_INDEX) {
 		if (d_is_reg(object->dentry)) {
-			const struct address_space_operations *aops;
-
-			ret = -EPERM;
-			aops = d_backing_inode(object->dentry)->i_mapping->a_ops;
-			if (!aops->bmap)
-				goto check_error;
-			if (object->dentry->d_sb->s_blocksize > PAGE_SIZE)
+			if (object->dentry->d_sb->s_blocksize > PAGE_SIZE) {
+				pr_warn("cachefiles: Block size too large\n");
 				goto check_error;
+			}
 
 			object->backer = object->dentry;
 		} else {
@@ -482,11 +492,15 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 		}
 	}
 
-	object->new = 0;
-	fscache_obtained_object(&object->fscache);
+	if (object->new)
+		object->fscache.stage = FSCACHE_OBJECT_STAGE_LIVE_EMPTY;
+	else
+		object->fscache.stage = FSCACHE_OBJECT_STAGE_LIVE;
+	wake_up_var(&object->fscache.stage);
 
-	_leave(" = 0 [%lu]", d_backing_inode(object->dentry)->i_ino);
-	return 0;
+	object->new = false;
+	_leave(" = t [%lu]", d_backing_inode(object->dentry)->i_ino);
+	return true;
 
 no_space_error:
 	fscache_object_mark_killed(&object->fscache, FSCACHE_OBJECT_NO_SPACE);
@@ -518,8 +532,10 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 error_out2:
 	dput(dir);
 error_out:
-	_leave(" = error %d", -ret);
-	return ret;
+	object->fscache.stage = FSCACHE_OBJECT_STAGE_DEAD;
+	wake_up_var(&object->fscache.stage);
+	_leave(" = f");
+	return false;
 }
 
 /*
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 46913d4157dd..75a2a6b70e4a 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -122,7 +122,6 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object,
 	if (len > 0)
 		memcpy(buf->data, fscache_get_aux(object->fscache.cookie), len);
 
-	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
 	ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
 			   buf, sizeof(struct cachefiles_xattr) + len,
 			   xattr_flags);
diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index 7b10c6aad157..396e1b5fdc28 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -10,7 +10,8 @@ fscache-y := \
 	fsdef.o \
 	main.o \
 	netfs.o \
-	object.o
+	obj.o \
+	object_bits.o
 
 fscache-$(CONFIG_PROC_FS) += proc.o
 fscache-$(CONFIG_FSCACHE_STATS) += stats.o
diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index 60fa68c7da3a..80120402d874 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /* FS-Cache cache handling
  *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2007, 2020 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  */
 
@@ -93,6 +93,7 @@ struct fscache_cache *fscache_select_cache_for_object(
 	struct fscache_cookie *cookie)
 {
 	struct fscache_cache_tag *tag;
+	struct fscache_cookie *parent = cookie->parent;
 	struct fscache_object *object;
 	struct fscache_cache *cache;
 
@@ -104,33 +105,32 @@ struct fscache_cache *fscache_select_cache_for_object(
 	}
 
 	/* we check the parent to determine the cache to use */
-	spin_lock(&cookie->lock);
+	spin_lock(&parent->lock);
 
 	/* the first in the parent's backing list should be the preferred
 	 * cache */
-	if (!hlist_empty(&cookie->backing_objects)) {
-		object = hlist_entry(cookie->backing_objects.first,
+	if (!hlist_empty(&parent->backing_objects)) {
+		object = hlist_entry(parent->backing_objects.first,
 				     struct fscache_object, cookie_link);
 
 		cache = object->cache;
-		if (fscache_object_is_dying(object) ||
-		    test_bit(FSCACHE_IOERROR, &cache->flags))
+		if (test_bit(FSCACHE_IOERROR, &cache->flags))
 			cache = NULL;
 
-		spin_unlock(&cookie->lock);
+		spin_unlock(&parent->lock);
 		_leave(" = %s [parent]", cache ? cache->tag->name : "NULL");
 		return cache;
 	}
 
 	/* the parent is unbacked */
-	if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX) {
+	if (parent->type != FSCACHE_COOKIE_TYPE_INDEX) {
 		/* cookie not an index and is unbacked */
-		spin_unlock(&cookie->lock);
-		_leave(" = NULL [cookie ub,ni]");
+		spin_unlock(&parent->lock);
+		_leave(" = NULL [parent ub,ni]");
 		return NULL;
 	}
 
-	spin_unlock(&cookie->lock);
+	spin_unlock(&parent->lock);
 
 	tag = cookie->preferred_cache;
 	if (!tag)
@@ -210,10 +210,7 @@ int fscache_add_cache(struct fscache_cache *cache,
 	BUG_ON(!ifsdef);
 
 	cache->flags = 0;
-	ifsdef->event_mask =
-		((1 << NR_FSCACHE_OBJECT_EVENTS) - 1) &
-		~(1 << FSCACHE_OBJECT_EV_CLEARED);
-	__set_bit(FSCACHE_OBJECT_IS_AVAILABLE, &ifsdef->flags);
+	ifsdef->stage = FSCACHE_OBJECT_STAGE_LIVE;
 
 	if (!tagname)
 		tagname = cache->identifier;
@@ -308,33 +305,86 @@ void fscache_io_error(struct fscache_cache *cache)
 EXPORT_SYMBOL(fscache_io_error);
 
 /*
- * request withdrawal of all the objects in a cache
- * - all the objects being withdrawn are moved onto the supplied list
+ * Withdraw an object.
  */
-static void fscache_withdraw_all_objects(struct fscache_cache *cache,
-					 struct list_head *dying_objects)
+static void fscache_withdraw_object(struct fscache_cookie *cookie,
+				    struct fscache_object *object,
+				    int param)
 {
-	struct fscache_object *object;
+	_enter("c=%08x o=%08x", cookie ? cookie->debug_id : 0, object->debug_id);
 
-	while (!list_empty(&cache->object_list)) {
-		spin_lock(&cache->object_list_lock);
+	_debug("WITHDRAW %x", object->debug_id);
+
+retry:
+	spin_lock(&cookie->lock);
+	if (cookie->stage == FSCACHE_COOKIE_STAGE_RELINQUISHING) {
+		spin_unlock(&cookie->lock);
+		wait_var_event(&cookie->stage,
+			       READ_ONCE(cookie->stage) != FSCACHE_COOKIE_STAGE_RELINQUISHING);
+		cond_resched();
+		goto retry;
+	}
 
-		if (!list_empty(&cache->object_list)) {
-			object = list_entry(cache->object_list.next,
-					    struct fscache_object, cache_link);
-			list_move_tail(&object->cache_link, dying_objects);
+	if (cookie->stage == FSCACHE_COOKIE_STAGE_DROPPED) {
+		spin_unlock(&cookie->lock);
+		kleave(" [dropped]");
+		return;
+	}
+
+	if (cookie->stage != FSCACHE_COOKIE_STAGE_INDEX)
+		cookie->stage = FSCACHE_COOKIE_STAGE_WITHDRAWING;
+	hlist_del_init(&object->cookie_link);
+	spin_unlock(&cookie->lock);
+	wake_up_cookie_stage(cookie);
 
-			_debug("withdraw %x", object->cookie->debug_id);
+	if (cookie->stage == FSCACHE_COOKIE_STAGE_WITHDRAWING) {
+		atomic_dec(&cookie->n_ops);
+		wait_var_event(&cookie->n_ops, atomic_read(&cookie->n_ops) == 0);
+		atomic_inc(&cookie->n_ops);
+	}
 
-			/* This must be done under object_list_lock to prevent
-			 * a race with fscache_drop_object().
-			 */
-			fscache_raise_event(object, FSCACHE_OBJECT_EV_KILL);
-		}
+	fscache_drop_object(cookie, object, param);
 
+	spin_lock(&cookie->lock);
+	if (cookie->stage == FSCACHE_COOKIE_STAGE_WITHDRAWING)
+		cookie->stage = FSCACHE_COOKIE_STAGE_QUIESCENT;
+	spin_unlock(&cookie->lock);
+	wake_up_cookie_stage(cookie);
+	object->cache->ops->put_object(object, fscache_obj_put_withdraw);
+}
+
+/*
+ * Request withdrawal of all the objects in a cache.
+ */
+static void fscache_withdraw_all_objects(struct fscache_cache *cache)
+{
+	struct fscache_object *object;
+
+	_enter("");
+
+	spin_lock(&cache->object_list_lock);
+	while (!list_empty(&cache->object_list)) {
+		/* Go through the list backwards so that we do children before
+		 * their parents.
+		 */
+		object = list_entry(cache->object_list.prev,
+				    struct fscache_object, cache_link);
+		list_del_init(&object->cache_link);
+		cache->ops->grab_object(object, fscache_obj_get_withdraw);
 		spin_unlock(&cache->object_list_lock);
+
+		_debug("o=%08x n=%u", object->debug_id, object->n_children);
+		wait_var_event(&object->n_children, READ_ONCE(object->n_children) == 0);
+
+		fscache_dispatch(object->cookie, object, 0,
+				 fscache_withdraw_object);
+
 		cond_resched();
+		spin_lock(&cache->object_list_lock);
 	}
+	spin_unlock(&cache->object_list_lock);
+
+	_leave("");
 }
 
 /**
@@ -349,12 +399,10 @@ static void fscache_withdraw_all_objects(struct fscache_cache *cache,
  */
 void fscache_withdraw_cache(struct fscache_cache *cache)
 {
-	LIST_HEAD(dying_objects);
-
 	_enter("");
 
-	pr_notice("Withdrawing cache \"%s\"\n",
-		  cache->tag->name);
+	pr_notice("Withdrawing cache \"%s\" (%u objs)\n",
+		  cache->tag->name, atomic_read(&cache->object_count));
 
 	/* make the cache unavailable for cookie acquisition */
 	if (test_and_set_bit(FSCACHE_CACHE_WITHDRAWN, &cache->flags))
@@ -365,29 +413,27 @@ void fscache_withdraw_cache(struct fscache_cache *cache)
 	cache->tag->cache = NULL;
 	up_write(&fscache_addremove_sem);
 
-	/* make sure all pages pinned by operations on behalf of the netfs are
-	 * written to disk */
-	fscache_stat(&fscache_n_cop_sync_cache);
-	cache->ops->sync_cache(cache);
-	fscache_stat_d(&fscache_n_cop_sync_cache);
-
 	/* we now have to destroy all the active objects pertaining to this
 	 * cache - which we do by passing them off to thread pool to be
 	 * disposed of */
 	_debug("destroy");
 
-	fscache_withdraw_all_objects(cache, &dying_objects);
+	fscache_withdraw_all_objects(cache);
+
+	/* make sure all outstanding data is written to disk */
+	fscache_stat(&fscache_n_cop_sync_cache);
+	cache->ops->sync_cache(cache);
+	fscache_stat_d(&fscache_n_cop_sync_cache);
 
 	/* wait for all extant objects to finish their outstanding operations
 	 * and go away */
-	_debug("wait for finish");
+	_debug("wait for finish %u", atomic_read(&cache->object_count));
 	wait_event(fscache_cache_cleared_wq,
 		   atomic_read(&cache->object_count) == 0);
 	_debug("wait for clearance");
 	wait_event(fscache_cache_cleared_wq,
 		   list_empty(&cache->object_list));
 	_debug("cleared");
-	ASSERT(list_empty(&dying_objects));
 
 	kobject_put(cache->kobj);
 
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 0346bc7f5818..3e79177a7b7b 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /* netfs cookie management
  *
- * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004-2007, 2020 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * See Documentation/filesystems/caching/netfs-api.rst for more information on
@@ -15,19 +15,11 @@
 
 struct kmem_cache *fscache_cookie_jar;
 
-static atomic_t fscache_object_debug_id = ATOMIC_INIT(0);
-
 #define fscache_cookie_hash_shift 15
 static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
 static LIST_HEAD(fscache_cookies);
 static DEFINE_RWLOCK(fscache_cookies_lock);
 
-static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie);
-static int fscache_alloc_object(struct fscache_cache *cache,
-				struct fscache_cookie *cookie);
-static int fscache_attach_object(struct fscache_cookie *cookie,
-				 struct fscache_object *object);
-
 static void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 {
 	struct fscache_object *object;
@@ -162,8 +154,8 @@ struct fscache_cookie *fscache_alloc_cookie(
 	if (!cookie)
 		return NULL;
 
-	cookie->type = type;
-	cookie->advice = advice;
+	cookie->type	= type;
+	cookie->advice	= advice;
 	cookie->key_len = index_key_len;
 	cookie->aux_len = aux_data_len;
 	cookie->object_size = object_size;
@@ -180,19 +172,24 @@ struct fscache_cookie *fscache_alloc_cookie(
 			goto nomem;
 	}
 
+	cookie->parent = parent;
 	atomic_set(&cookie->usage, 1);
 	atomic_set(&cookie->n_children, 0);
+	atomic_set(&cookie->n_ops, 1);
 	cookie->debug_id = atomic_inc_return(&fscache_cookie_debug_id);
 
+	if (type == FSCACHE_COOKIE_TYPE_INDEX)
+		cookie->stage = FSCACHE_COOKIE_STAGE_INDEX;
+	else
+		cookie->stage = FSCACHE_COOKIE_STAGE_QUIESCENT;
+
 	/* We keep the active count elevated until relinquishment to prevent an
 	 * attempt to wake up every time the object operations queue quiesces.
 	 */
 	atomic_set(&cookie->n_active, 1);
 
-	cookie->parent		= parent;
 	cookie->preferred_cache	= fscache_get_cache_tag(preferred_cache);
-	
-	cookie->flags		= (1 << FSCACHE_COOKIE_NO_DATA_YET);
+
 	spin_lock_init(&cookie->lock);
 	INIT_HLIST_HEAD(&cookie->backing_objects);
 
@@ -206,13 +203,28 @@ struct fscache_cookie *fscache_alloc_cookie(
 	return NULL;
 }
 
+static void fscache_wait_on_collision(struct fscache_cookie *candidate,
+				      struct fscache_cookie *wait_for)
+{
+	enum fscache_cookie_stage *stagep = &wait_for->stage;
+
+	wait_var_event_timeout(stagep, READ_ONCE(*stagep) == FSCACHE_COOKIE_STAGE_DROPPED,
+			       20 * HZ);
+	if (READ_ONCE(*stagep) != FSCACHE_COOKIE_STAGE_DROPPED) {
+		pr_notice("Potential collision c=%08x old: c=%08x",
+			  candidate->debug_id, wait_for->debug_id);
+		wait_var_event(stagep, READ_ONCE(*stagep) == FSCACHE_COOKIE_STAGE_DROPPED);
+	}
+}
+
 /*
  * Attempt to insert the new cookie into the hash.  If there's a collision, we
- * return the old cookie if it's not in use and an error otherwise.
+ * wait for the old cookie to complete if it's being relinquished and an error
+ * otherwise.
  */
 struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
 {
-	struct fscache_cookie *cursor;
+	struct fscache_cookie *cursor, *wait_for = NULL;
 	struct hlist_bl_head *h;
 	struct hlist_bl_node *p;
 	unsigned int bucket;
@@ -222,31 +234,34 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
 
 	hlist_bl_lock(h);
 	hlist_bl_for_each_entry(cursor, p, h, hash_link) {
-		if (fscache_compare_cookie(candidate, cursor) == 0)
-			goto collision;
+		if (fscache_compare_cookie(candidate, cursor) == 0) {
+			if (!test_bit(FSCACHE_COOKIE_RELINQUISHED, &cursor->flags))
+				goto collision;
+			wait_for = fscache_cookie_get(cursor,
+						      fscache_cookie_get_hash_collision);
+			break;
+		}
 	}
 
-	__set_bit(FSCACHE_COOKIE_ACQUIRED, &candidate->flags);
 	fscache_cookie_get(candidate->parent, fscache_cookie_get_acquire_parent);
 	atomic_inc(&candidate->parent->n_children);
 	hlist_bl_add_head(&candidate->hash_link, h);
 	hlist_bl_unlock(h);
-	return candidate;
 
-collision:
-	if (test_and_set_bit(FSCACHE_COOKIE_ACQUIRED, &cursor->flags)) {
-		trace_fscache_cookie(cursor, fscache_cookie_collision,
-				     atomic_read(&cursor->usage));
-		pr_err("Duplicate cookie detected\n");
-		fscache_print_cookie(cursor, 'O');
-		fscache_print_cookie(candidate, 'N');
-		hlist_bl_unlock(h);
-		return NULL;
+	if (wait_for) {
+		fscache_wait_on_collision(candidate, wait_for);
+		fscache_cookie_put(wait_for, fscache_cookie_put_hash_collision);
 	}
+	return candidate;
 
-	fscache_cookie_get(cursor, fscache_cookie_get_reacquire);
+collision:
+	trace_fscache_cookie(cursor, fscache_cookie_collision,
+			     atomic_read(&cursor->usage));
+	pr_err("Duplicate cookie detected\n");
+	fscache_print_cookie(cursor, 'O');
+	fscache_print_cookie(candidate, 'N');
 	hlist_bl_unlock(h);
-	return cursor;
+	return NULL;
 }
 
 /*
@@ -270,13 +285,12 @@ struct fscache_cookie *__fscache_acquire_cookie(
 	struct fscache_cache_tag *preferred_cache,
 	const void *index_key, size_t index_key_len,
 	const void *aux_data, size_t aux_data_len,
-	loff_t object_size,
-	bool enable)
+	loff_t object_size)
 {
 	struct fscache_cookie *candidate, *cookie;
 
-	_enter("{%s},{%s},%u",
-	       parent ? parent->type_name : "<no-parent>", type_name, enable);
+	_enter("{%s},{%s}",
+	       parent ? parent->type_name : "<no-parent>", type_name);
 
 	if (!index_key || !index_key_len || index_key_len > 255 || aux_data_len > 255)
 		return NULL;
@@ -308,6 +322,7 @@ struct fscache_cookie *__fscache_acquire_cookie(
 		_leave(" [ENOMEM]");
 		return NULL;
 	}
+	trace_fscache_cookie(candidate, fscache_cookie_new_acquire, 1);
 
 	cookie = fscache_hash_cookie(candidate);
 	if (!cookie) {
@@ -331,28 +346,8 @@ struct fscache_cookie *__fscache_acquire_cookie(
 	}
 
 	trace_fscache_acquire(cookie);
-
-	if (enable) {
-		/* if the object is an index then we need do nothing more here
-		 * - we create indices on disk when we need them as an index
-		 * may exist in multiple caches */
-		if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX) {
-			if (fscache_acquire_non_index_cookie(cookie) == 0) {
-				set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
-			} else {
-				atomic_dec(&parent->n_children);
-				fscache_cookie_put(cookie,
-						   fscache_cookie_put_acquire_nobufs);
-				fscache_stat(&fscache_n_acquires_nobufs);
-				_leave(" = NULL");
-				return NULL;
-			}
-		} else {
-			set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
-		}
-	}
-
 	fscache_stat(&fscache_n_acquires_ok);
+	_leave(" = c=%08x", cookie->debug_id);
 
 out:
 	fscache_free_cookie(candidate);
@@ -361,250 +356,128 @@ struct fscache_cookie *__fscache_acquire_cookie(
 EXPORT_SYMBOL(__fscache_acquire_cookie);
 
 /*
- * Enable a cookie to permit it to accept new operations.
+ * Start using the cookie for I/O.  This prevents the backing object from being
+ * reaped by VM pressure.
  */
-void __fscache_enable_cookie(struct fscache_cookie *cookie,
-			     const void *aux_data,
-			     loff_t object_size,
-			     bool (*can_enable)(void *data),
-			     void *data)
+void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
 {
-	_enter("%x", cookie->debug_id);
-
-	trace_fscache_enable(cookie);
-
-	wait_on_bit_lock(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK,
-			 TASK_UNINTERRUPTIBLE);
-
-	cookie->object_size = object_size;
-	fscache_update_aux(cookie, aux_data);
+	enum fscache_cookie_stage stage;
 
-	if (test_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags))
-		goto out_unlock;
+	_enter("c=%08x", cookie->debug_id);
 
-	if (can_enable && !can_enable(data)) {
-		/* The netfs decided it didn't want to enable after all */
-	} else if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX) {
-		/* Wait for outstanding disablement to complete */
-		__fscache_wait_on_invalidate(cookie);
-
-		if (fscache_acquire_non_index_cookie(cookie) == 0)
-			set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
-	} else {
-		set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
-	}
-
-out_unlock:
-	clear_bit_unlock(FSCACHE_COOKIE_ENABLEMENT_LOCK, &cookie->flags);
-	wake_up_bit(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK);
-}
-EXPORT_SYMBOL(__fscache_enable_cookie);
-
-/*
- * acquire a non-index cookie
- * - this must make sure the index chain is instantiated and instantiate the
- *   object representation too
- */
-static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie)
-{
-	struct fscache_object *object;
-	struct fscache_cache *cache;
-	int ret;
-
-	_enter("");
-
-	set_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
-
-	/* now we need to see whether the backing objects for this cookie yet
-	 * exist, if not there'll be nothing to search */
-	down_read(&fscache_addremove_sem);
+	if (WARN(test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags),
+		 "Trying to use relinquished cookie\n"))
+		return;
 
-	if (list_empty(&fscache_cache_list)) {
-		up_read(&fscache_addremove_sem);
-		_leave(" = 0 [no caches]");
-		return 0;
-	}
+	spin_lock(&cookie->lock);
 
-	/* select a cache in which to store the object */
-	cache = fscache_select_cache_for_object(cookie->parent);
-	if (!cache) {
-		up_read(&fscache_addremove_sem);
-		fscache_stat(&fscache_n_acquires_no_cache);
-		_leave(" = -ENOMEDIUM [no cache]");
-		return -ENOMEDIUM;
-	}
+	atomic_inc(&cookie->n_active);
 
-	_debug("cache %s", cache->tag->name);
+again:
+	stage = cookie->stage;
+	switch (stage) {
+	case FSCACHE_COOKIE_STAGE_QUIESCENT:
+		cookie->stage = FSCACHE_COOKIE_STAGE_INITIALISING;
 
-	set_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags);
+		/* The lookup job holds its own active increment */
+		atomic_inc(&cookie->n_active);
+		spin_unlock(&cookie->lock);
+		wake_up_cookie_stage(cookie);
 
-	/* ask the cache to allocate objects for this cookie and its parent
-	 * chain */
-	ret = fscache_alloc_object(cache, cookie);
-	if (ret < 0) {
-		up_read(&fscache_addremove_sem);
-		_leave(" = %d", ret);
-		return ret;
-	}
+		fscache_dispatch(cookie, NULL, will_modify, fscache_lookup_object);
+		break;
 
-	spin_lock(&cookie->lock);
-	if (hlist_empty(&cookie->backing_objects)) {
+	case FSCACHE_COOKIE_STAGE_INITIALISING:
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
 		spin_unlock(&cookie->lock);
-		goto unavailable;
-	}
-
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
+		wait_var_event(&cookie->stage, READ_ONCE(cookie->stage) != stage);
+		spin_lock(&cookie->lock);
+		goto again;
 
-	/* initiate the process of looking up all the objects in the chain
-	 * (done by fscache_initialise_object()) */
-	fscache_raise_event(object, FSCACHE_OBJECT_EV_NEW_CHILD);
+	case FSCACHE_COOKIE_STAGE_NO_DATA_YET:
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+	case FSCACHE_COOKIE_STAGE_INVALIDATING:
+		// TODO: Handle will_modify
+		spin_unlock(&cookie->lock);
+		break;
 
-	spin_unlock(&cookie->lock);
+	case FSCACHE_COOKIE_STAGE_FAILED:
+	case FSCACHE_COOKIE_STAGE_WITHDRAWING:
+		spin_unlock(&cookie->lock);
+		break;
 
-	/* we may be required to wait for lookup to complete at this point */
-	if (!fscache_defer_lookup) {
-		wait_on_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP,
-			    TASK_UNINTERRUPTIBLE);
-		if (test_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags))
-			goto unavailable;
+	case FSCACHE_COOKIE_STAGE_INDEX:
+	case FSCACHE_COOKIE_STAGE_DROPPED:
+	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
+		spin_unlock(&cookie->lock);
+		WARN(1, "Can't use cookie in stage %u\n", cookie->stage);
+		break;
 	}
 
-	up_read(&fscache_addremove_sem);
-	_leave(" = 0 [deferred]");
-	return 0;
-
-unavailable:
-	up_read(&fscache_addremove_sem);
-	_leave(" = -ENOBUFS");
-	return -ENOBUFS;
+	_leave("");
 }
+EXPORT_SYMBOL(__fscache_use_cookie);
 
 /*
- * recursively allocate cache object records for a cookie/cache combination
- * - caller must be holding the addremove sem
+ * Stop using the cookie for I/O.
  */
-static int fscache_alloc_object(struct fscache_cache *cache,
-				struct fscache_cookie *cookie)
+void __fscache_unuse_cookie(struct fscache_cookie *cookie,
+			    const void *aux_data, const loff_t *object_size)
 {
-	struct fscache_object *object;
-	int ret;
-
-	_enter("%s,%x{%s}", cache->tag->name, cookie->debug_id, cookie->type_name);
-
-	spin_lock(&cookie->lock);
-	hlist_for_each_entry(object, &cookie->backing_objects,
-			     cookie_link) {
-		if (object->cache == cache)
-			goto object_already_extant;
-	}
-	spin_unlock(&cookie->lock);
-
-	/* ask the cache to allocate an object (we may end up with duplicate
-	 * objects at this stage, but we sort that out later) */
-	fscache_stat(&fscache_n_cop_alloc_object);
-	object = cache->ops->alloc_object(cache, cookie);
-	fscache_stat_d(&fscache_n_cop_alloc_object);
-	if (IS_ERR(object)) {
-		fscache_stat(&fscache_n_object_no_alloc);
-		ret = PTR_ERR(object);
-		goto error;
-	}
-
-	ASSERTCMP(object->cookie, ==, cookie);
-	fscache_stat(&fscache_n_object_alloc);
-
-	object->debug_id = atomic_inc_return(&fscache_object_debug_id);
-
-	_debug("ALLOC OBJ%x: %s {%lx}",
-	       object->debug_id, cookie->type_name, object->events);
-
-	ret = fscache_alloc_object(cache, cookie->parent);
-	if (ret < 0)
-		goto error_put;
-
-	/* only attach if we managed to allocate all we needed, otherwise
-	 * discard the object we just allocated and instead use the one
-	 * attached to the cookie */
-	if (fscache_attach_object(cookie, object) < 0) {
-		fscache_stat(&fscache_n_cop_put_object);
-		cache->ops->put_object(object, fscache_obj_put_attach_fail);
-		fscache_stat_d(&fscache_n_cop_put_object);
-	}
-
-	_leave(" = 0");
-	return 0;
-
-object_already_extant:
-	ret = -ENOBUFS;
-	if (fscache_object_is_dying(object) ||
-	    fscache_cache_is_broken(object)) {
-		spin_unlock(&cookie->lock);
-		goto error;
-	}
-	spin_unlock(&cookie->lock);
-	_leave(" = 0 [found]");
-	return 0;
-
-error_put:
-	fscache_stat(&fscache_n_cop_put_object);
-	cache->ops->put_object(object, fscache_obj_put_alloc_fail);
-	fscache_stat_d(&fscache_n_cop_put_object);
-error:
-	_leave(" = %d", ret);
-	return ret;
+	if (aux_data || object_size)
+		__fscache_update_cookie(cookie, aux_data, object_size);
+	if (atomic_dec_and_test(&cookie->n_active))
+		wake_up_var(&cookie->n_active);
 }
+EXPORT_SYMBOL(__fscache_unuse_cookie);
 
 /*
- * attach a cache object to a cookie
+ * Attempt to attach the object to the list on the cookie or, if there's an
+ * object already attached, then that is used instead and a ref is taken on it
+ * for the caller.  Returns a pointer to whichever object is selected.
+ *
+ * Returns NULL if either the netfs relinquished the cookie or the cache got
+ * withdrawn.
  */
-static int fscache_attach_object(struct fscache_cookie *cookie,
-				 struct fscache_object *object)
+struct fscache_object *fscache_attach_object(struct fscache_cookie *cookie,
+					     struct fscache_object *object)
 {
-	struct fscache_object *p;
+	struct fscache_object *parent, *p, *ret = NULL;
 	struct fscache_cache *cache = object->cache;
-	int ret;
+	bool wake = false;
 
-	_enter("{%s},{OBJ%x}", cookie->type_name, object->debug_id);
+	_enter("c=%08x{%s},o=%08x", cookie->debug_id, cookie->type_name, object->debug_id);
 
 	ASSERTCMP(object->cookie, ==, cookie);
 
 	spin_lock(&cookie->lock);
 
+	if (cookie->stage != FSCACHE_COOKIE_STAGE_INDEX &&
+	    cookie->stage != FSCACHE_COOKIE_STAGE_INITIALISING)
+		goto out;
+
 	/* there may be multiple initial creations of this object, but we only
 	 * want one */
-	ret = -EEXIST;
 	hlist_for_each_entry(p, &cookie->backing_objects, cookie_link) {
-		if (p->cache == object->cache) {
-			if (fscache_object_is_dying(p))
-				ret = -ENOBUFS;
-			goto cant_attach_object;
-		}
+		if (p->cache == object->cache)
+			goto exists;
 	}
 
 	/* pin the parent object */
 	spin_lock_nested(&cookie->parent->lock, 1);
-	hlist_for_each_entry(p, &cookie->parent->backing_objects,
-			     cookie_link) {
-		if (p->cache == object->cache) {
-			if (fscache_object_is_dying(p)) {
-				ret = -ENOBUFS;
-				spin_unlock(&cookie->parent->lock);
-				goto cant_attach_object;
-			}
-			object->parent = p;
-			spin_lock(&p->lock);
-			p->n_children++;
-			spin_unlock(&p->lock);
-			break;
-		}
-	}
+
+	parent = object->parent;
+
+	spin_lock(&parent->lock);
+	parent->n_children++;
+	spin_unlock(&parent->lock);
+
 	spin_unlock(&cookie->parent->lock);
 
 	/* attach to the cache's object list */
 	if (list_empty(&object->cache_link)) {
 		spin_lock(&cache->object_list_lock);
-		list_add(&object->cache_link, &cache->object_list);
+		list_add_tail(&object->cache_link, &cache->object_list);
 		spin_unlock(&cache->object_list_lock);
 	}
 
@@ -612,12 +485,48 @@ static int fscache_attach_object(struct fscache_cookie *cookie,
 	hlist_add_head(&object->cookie_link, &cookie->backing_objects);
 
 	fscache_objlist_add(object);
-	ret = 0;
+	if (cookie->stage != FSCACHE_COOKIE_STAGE_INDEX) {
+		cookie->stage = FSCACHE_COOKIE_STAGE_LOOKING_UP;
+		wake = true;
+	}
 
-cant_attach_object:
+out_grab:
+	ret = cache->ops->grab_object(object, fscache_obj_get_attach);
+out:
 	spin_unlock(&cookie->lock);
-	_leave(" = %d", ret);
+	if (wake)
+		wake_up_cookie_stage(cookie);
+	_leave(" = c=%08x", ret ? ret->debug_id : 0);
 	return ret;
+
+exists:
+	object = p;
+	goto out_grab;
+}
+
+/*
+ * Change the stage a cookie is at and wake up anyone waiting for that - but
+ * only if the cookie isn't already marked as being in a cleanup state.
+ */
+void fscache_set_cookie_stage(struct fscache_cookie *cookie,
+			      enum fscache_cookie_stage stage)
+{
+	bool changed = false;
+
+	spin_lock(&cookie->lock);
+	switch (cookie->stage) {
+	case FSCACHE_COOKIE_STAGE_INDEX:
+	case FSCACHE_COOKIE_STAGE_WITHDRAWING:
+	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
+		break;
+	default:
+		cookie->stage = stage;
+		changed = true;
+		break;
+	}
+	spin_unlock(&cookie->lock);
+	if (changed)
+		wake_up_cookie_stage(cookie);
 }
 
 /*
@@ -625,7 +534,7 @@ static int fscache_attach_object(struct fscache_cookie *cookie,
  */
 void __fscache_invalidate(struct fscache_cookie *cookie)
 {
-	struct fscache_object *object;
+	struct fscache_object *object = NULL;
 
 	_enter("{%s}", cookie->type_name);
 
@@ -638,72 +547,57 @@ void __fscache_invalidate(struct fscache_cookie *cookie)
 	 */
 	ASSERTCMP(cookie->type, ==, FSCACHE_COOKIE_TYPE_DATAFILE);
 
-	/* If there's an object, we tell the object state machine to handle the
-	 * invalidation on our behalf, otherwise there's nothing to do.
-	 */
-	if (!hlist_empty(&cookie->backing_objects)) {
-		spin_lock(&cookie->lock);
+	spin_lock(&cookie->lock);
+	if (!hlist_empty(&cookie->backing_objects))
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
 
-		if (fscache_cookie_enabled(cookie) &&
-		    !hlist_empty(&cookie->backing_objects) &&
-		    !test_and_set_bit(FSCACHE_COOKIE_INVALIDATING,
-				      &cookie->flags)) {
-			object = hlist_entry(cookie->backing_objects.first,
-					     struct fscache_object,
-					     cookie_link);
-			/* TODO: Do invalidation */
-		}
+	switch (cookie->stage) {
+	case FSCACHE_COOKIE_STAGE_INITIALISING: /* Assume later checks will catch it */
+	case FSCACHE_COOKIE_STAGE_INVALIDATING: /* is_still_valid will catch it */
+	default:
+		spin_unlock(&cookie->lock);
+		_leave(" [no %u]", cookie->stage);
+		return;
 
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
 		spin_unlock(&cookie->lock);
-	}
+		_leave(" [look]");
+		return;
 
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_invalidate);
+	case FSCACHE_COOKIE_STAGE_NO_DATA_YET:
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		cookie->stage = FSCACHE_COOKIE_STAGE_INVALIDATING;
 
-/*
- * Wait for object invalidation to complete.
- */
-void __fscache_wait_on_invalidate(struct fscache_cookie *cookie)
-{
-	_enter("%x", cookie->debug_id);
-
-	wait_on_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING,
-		    TASK_UNINTERRUPTIBLE);
+		atomic_inc(&cookie->n_ops);
+		object->cache->ops->grab_object(object, fscache_obj_get_inval);
+		spin_unlock(&cookie->lock);
+		wake_up_cookie_stage(cookie);
 
-	_leave("");
+		fscache_dispatch(cookie, object, 0, fscache_invalidate_object);
+		_leave(" [inv]");
+		return;
+	}
 }
-EXPORT_SYMBOL(__fscache_wait_on_invalidate);
+EXPORT_SYMBOL(__fscache_invalidate);
 
 /*
- * update the index entries backing a cookie
+ * Update the index entries backing a cookie.  The writeback is done lazily.
  */
-void __fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data)
+void __fscache_update_cookie(struct fscache_cookie *cookie,
+			     const void *aux_data, const loff_t *object_size)
 {
 	struct fscache_object *object;
 
 	fscache_stat(&fscache_n_updates);
 
-	if (!cookie) {
-		fscache_stat(&fscache_n_updates_null);
-		_leave(" [no cookie]");
-		return;
-	}
-
 	_enter("{%s}", cookie->type_name);
 
 	spin_lock(&cookie->lock);
 
-	fscache_update_aux(cookie, aux_data);
-
-	if (fscache_cookie_enabled(cookie)) {
-		/* update the index entry on disk in each cache backing this
-		 * cookie.
-		 */
-		hlist_for_each_entry(object,
-				     &cookie->backing_objects, cookie_link) {
-			fscache_raise_event(object, FSCACHE_OBJECT_EV_UPDATE);
-		}
+	fscache_update_aux(cookie, aux_data, object_size);
+	hlist_for_each_entry(object, &cookie->backing_objects, cookie_link) {
+		set_bit(FSCACHE_OBJECT_NEEDS_UPDATE, &object->flags);
 	}
 
 	spin_unlock(&cookie->lock);
@@ -711,112 +605,30 @@ void __fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data
 }
 EXPORT_SYMBOL(__fscache_update_cookie);
 
-/*
- * Disable a cookie to stop it from accepting new requests from the netfs.
- */
-void __fscache_disable_cookie(struct fscache_cookie *cookie,
-			      const void *aux_data,
-			      bool invalidate)
-{
-	struct fscache_object *object;
-	bool awaken = false;
-
-	_enter("%x,%u", cookie->debug_id, invalidate);
-
-	trace_fscache_disable(cookie);
-
-	ASSERTCMP(atomic_read(&cookie->n_active), >, 0);
-
-	if (atomic_read(&cookie->n_children) != 0) {
-		pr_err("Cookie '%s' still has children\n",
-		       cookie->type_name);
-		BUG();
-	}
-
-	wait_on_bit_lock(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK,
-			 TASK_UNINTERRUPTIBLE);
-
-	fscache_update_aux(cookie, aux_data);
-
-	if (!test_and_clear_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags))
-		goto out_unlock_enable;
-
-	/* If the cookie is being invalidated, wait for that to complete first
-	 * so that we can reuse the flag.
-	 */
-	__fscache_wait_on_invalidate(cookie);
-
-	/* Dispose of the backing objects */
-	set_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags);
-
-	spin_lock(&cookie->lock);
-	if (!hlist_empty(&cookie->backing_objects)) {
-		hlist_for_each_entry(object, &cookie->backing_objects, cookie_link) {
-			if (invalidate)
-				set_bit(FSCACHE_OBJECT_RETIRED, &object->flags);
-			fscache_raise_event(object, FSCACHE_OBJECT_EV_KILL);
-		}
-	} else {
-		if (test_and_clear_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
-			awaken = true;
-	}
-	spin_unlock(&cookie->lock);
-	if (awaken)
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
-
-	/* Wait for cessation of activity requiring access to the netfs (when
-	 * n_active reaches 0).  This makes sure outstanding reads and writes
-	 * have completed.
-	 */
-	if (!atomic_dec_and_test(&cookie->n_active)) {
-		wait_var_event(&cookie->n_active,
-			       !atomic_read(&cookie->n_active));
-	}
-
-	/* Reset the cookie state if it wasn't relinquished */
-	if (!test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags)) {
-		atomic_inc(&cookie->n_active);
-		set_bit(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
-	}
-
-out_unlock_enable:
-	clear_bit_unlock(FSCACHE_COOKIE_ENABLEMENT_LOCK, &cookie->flags);
-	wake_up_bit(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK);
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_disable_cookie);
-
 /*
  * release a cookie back to the cache
  * - the object will be marked as recyclable on disk if retire is true
  * - all dependents of this cookie must have already been unregistered
  *   (indices/files/pages)
  */
-void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
-				 const void *aux_data,
-				 bool retire)
+void __fscache_relinquish_cookie(struct fscache_cookie *cookie, bool retire)
 {
+	enum fscache_cookie_stage stage;
+	bool just_drop = false;
+
 	fscache_stat(&fscache_n_relinquishes);
 	if (retire)
 		fscache_stat(&fscache_n_relinquishes_retire);
 
-	if (!cookie) {
-		fscache_stat(&fscache_n_relinquishes_null);
-		_leave(" [no cookie]");
-		return;
-	}
-
-	_enter("%x{%s,%d},%d",
+	_enter("c=%08x{%s,%d},%d",
 	       cookie->debug_id, cookie->type_name,
 	       atomic_read(&cookie->n_active), retire);
 
-	trace_fscache_relinquish(cookie, retire);
-
-	/* No further netfs-accessing operations on this cookie permitted */
-	if (test_and_set_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags))
-		BUG();
-
-	__fscache_disable_cookie(cookie, aux_data, retire);
+	if (WARN(test_and_set_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags),
+		 "Cookie '%s' already relinquished\n", cookie->type_name) ||
+	    WARN(atomic_read(&cookie->n_children) != 0,
+		 "Cookie '%s' still has children\n", cookie->type_name))
+		return;
 
 	if (cookie->parent) {
 		ASSERTCMP(atomic_read(&cookie->parent->usage), >, 0);
@@ -824,11 +636,42 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
 		atomic_dec(&cookie->parent->n_children);
 	}
 
-	/* Dispose of the netfs's link to the cookie */
-	ASSERTCMP(atomic_read(&cookie->usage), >, 0);
-	fscache_cookie_put(cookie, fscache_cookie_put_relinquish);
+	/* Make sure those who are checking the state under lock have looked at
+	 * the relinquished flag.
+	 */
+retry:
+	spin_lock(&cookie->lock);
+	trace_fscache_relinquish(cookie, retire);
+	stage = cookie->stage;
+	switch (stage) {
+	case FSCACHE_COOKIE_STAGE_QUIESCENT:
+		just_drop = true;
+		fallthrough;
+	default:
+		break;
+	case FSCACHE_COOKIE_STAGE_INITIALISING:
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+	case FSCACHE_COOKIE_STAGE_INVALIDATING:
+	case FSCACHE_COOKIE_STAGE_WITHDRAWING:
+		spin_unlock(&cookie->lock);
+		wait_var_event(&cookie->stage, READ_ONCE(cookie->stage) != stage);
+		cond_resched();
+		goto retry;
+	}
+	cookie->stage = FSCACHE_COOKIE_STAGE_RELINQUISHING;
+	spin_unlock(&cookie->lock);
+	wake_up_cookie_stage(cookie);
 
-	_leave("");
+	atomic_dec(&cookie->n_ops);
+	atomic_dec(&cookie->n_active);
+
+	wait_var_event(&cookie->n_ops, atomic_read(&cookie->n_ops) == 0);
+	wait_var_event(&cookie->n_active, atomic_read(&cookie->n_active) == 0);
+
+	if (just_drop)
+		fscache_drop_cookie(cookie);
+	else
+		fscache_dispatch(cookie, NULL, retire, fscache_relinquish_objects);
 }
 EXPORT_SYMBOL(__fscache_relinquish_cookie);
 
@@ -848,6 +691,20 @@ static void fscache_unhash_cookie(struct fscache_cookie *cookie)
 	hlist_bl_unlock(h);
 }
 
+/*
+ * Finalise a cookie after all its resources have been disposed of.
+ */
+void fscache_drop_cookie(struct fscache_cookie *cookie)
+{
+	spin_lock(&cookie->lock);
+	cookie->stage = FSCACHE_COOKIE_STAGE_DROPPED;
+	spin_unlock(&cookie->lock);
+	wake_up_cookie_stage(cookie);
+
+	fscache_unhash_cookie(cookie);
+	fscache_cookie_put(cookie, fscache_cookie_put_relinquish);
+}
+
 /*
  * Drop a reference to a cookie.
  */
@@ -857,9 +714,9 @@ void fscache_cookie_put(struct fscache_cookie *cookie,
 	struct fscache_cookie *parent;
 	int usage;
 
-	_enter("%x", cookie->debug_id);
-
 	do {
+		_enter("c=%08x", cookie->debug_id);
+
 		usage = atomic_dec_return(&cookie->usage);
 		trace_fscache_cookie(cookie, where, usage);
 
@@ -868,7 +725,6 @@ void fscache_cookie_put(struct fscache_cookie *cookie,
 		BUG_ON(usage < 0);
 
 		parent = cookie->parent;
-		fscache_unhash_cookie(cookie);
 		fscache_free_cookie(cookie);
 
 		cookie = parent;
@@ -877,6 +733,7 @@ void fscache_cookie_put(struct fscache_cookie *cookie,
 
 	_leave("");
 }
+EXPORT_SYMBOL(fscache_cookie_put);
 
 /*
  * Generate a list of extant cookies in /proc/fs/fscache/cookies
@@ -890,8 +747,8 @@ static int fscache_cookies_seq_show(struct seq_file *m, void *v)
 
 	if (v == &fscache_cookies) {
 		seq_puts(m,
-			 "COOKIE   PARENT   USAGE CHILD ACT TY FL  DEF             \n"
-			 "======== ======== ===== ===== === == === ================\n"
+			 "COOKIE   PARENT   USAGE CHILD ACT OPS TY S FL  DEF             \n"
+			 "======== ======== ===== ===== === === == = === ================\n"
 			 );
 		return 0;
 	}
@@ -913,13 +770,15 @@ static int fscache_cookies_seq_show(struct seq_file *m, void *v)
 	}
 
 	seq_printf(m,
-		   "%08x %08x %5u %5u %3u %s %03lx %-16s",
+		   "%08x %08x %5d %5d %3d %3d %s %u %03lx %-16s",
 		   cookie->debug_id,
 		   cookie->parent ? cookie->parent->debug_id : 0,
 		   atomic_read(&cookie->usage),
 		   atomic_read(&cookie->n_children),
 		   atomic_read(&cookie->n_active),
+		   atomic_read(&cookie->n_ops) - 1,
 		   type,
+		   cookie->stage,
 		   cookie->flags,
 		   cookie->type_name);
 
diff --git a/fs/fscache/fsdef.c b/fs/fscache/fsdef.c
index b802cbddb578..377151a6a54a 100644
--- a/fs/fscache/fsdef.c
+++ b/fs/fscache/fsdef.c
@@ -40,7 +40,6 @@ struct fscache_cookie fscache_fsdef_index = {
 	.lock		= __SPIN_LOCK_UNLOCKED(fscache_fsdef_index.lock),
 	.backing_objects = HLIST_HEAD_INIT,
 	.type_name	= ".fscach",
-	.flags		= 1 << FSCACHE_COOKIE_ENABLED,
 	.type		= FSCACHE_COOKIE_TYPE_INDEX,
 };
 EXPORT_SYMBOL(fscache_fsdef_index);
diff --git a/fs/fscache/histogram.c b/fs/fscache/histogram.c
index 4e5beeaaf454..4fd5dda1d0ad 100644
--- a/fs/fscache/histogram.c
+++ b/fs/fscache/histogram.c
@@ -5,7 +5,7 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
-#define FSCACHE_DEBUG_LEVEL THREAD
+#define FSCACHE_DEBUG_LEVEL CACHE
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 2100e2222884..67ca437c1f73 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -74,6 +74,23 @@ extern struct fscache_cookie *fscache_alloc_cookie(struct fscache_cookie *,
 extern struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *);
 extern void fscache_cookie_put(struct fscache_cookie *,
 			       enum fscache_cookie_trace);
+extern struct fscache_object *fscache_attach_object(struct fscache_cookie *,
+						    struct fscache_object *);
+extern void fscache_set_cookie_stage(struct fscache_cookie *,
+				     enum fscache_cookie_stage);
+extern void fscache_drop_cookie(struct fscache_cookie *);
+
+static inline void wake_up_cookie_stage(struct fscache_cookie *cookie)
+{
+	/* Use a barrier to ensure that waiters see the stage variable
+	 * change, as spin_unlock doesn't guarantee a barrier.
+	 *
+	 * See comments over wake_up_bit() and waitqueue_active().
+	 */
+	smp_mb();
+	wake_up_var(&cookie->stage);
+}
+
 
 /*
  * dispatcher.c
@@ -115,23 +132,17 @@ extern const struct seq_operations fscache_histogram_ops;
 /*
  * main.c
  */
-extern unsigned fscache_defer_lookup;
-extern unsigned fscache_defer_create;
 extern unsigned fscache_debug;
 extern struct kobject *fscache_root;
-extern struct workqueue_struct *fscache_object_wq;
 extern struct workqueue_struct *fscache_op_wq;
-DECLARE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
-
-static inline bool fscache_object_congested(void)
-{
-	return workqueue_congested(WORK_CPU_UNBOUND, fscache_object_wq);
-}
 
 /*
- * object.c
+ * obj.c
  */
-extern void fscache_enqueue_object(struct fscache_object *);
+extern void fscache_lookup_object(struct fscache_cookie *, struct fscache_object *, int);
+extern void fscache_invalidate_object(struct fscache_cookie *, struct fscache_object *, int);
+extern void fscache_drop_object(struct fscache_cookie *, struct fscache_object *, bool);
+extern void fscache_relinquish_objects(struct fscache_cookie *, struct fscache_object *, int);
 
 /*
  * object-list.c
@@ -239,44 +250,29 @@ int fscache_stats_show(struct seq_file *m, void *v);
 #define fscache_stat_d(stat) do {} while (0)
 #endif
 
-/*
- * raise an event on an object
- * - if the event is not masked for that object, then the object is
- *   queued for attention by the thread pool.
- */
-static inline void fscache_raise_event(struct fscache_object *object,
-				       unsigned event)
-{
-	BUG_ON(event >= NR_FSCACHE_OBJECT_EVENTS);
-#if 0
-	printk("*** fscache_raise_event(OBJ%d{%lx},%x)\n",
-	       object->debug_id, object->event_mask, (1 << event));
-#endif
-	if (!test_and_set_bit(event, &object->events) &&
-	    test_bit(event, &object->event_mask))
-		fscache_enqueue_object(object);
-}
-
-static inline void fscache_cookie_get(struct fscache_cookie *cookie,
-				      enum fscache_cookie_trace where)
+static inline
+struct fscache_cookie *fscache_cookie_get(struct fscache_cookie *cookie,
+					  enum fscache_cookie_trace where)
 {
 	int usage = atomic_inc_return(&cookie->usage);
 
 	trace_fscache_cookie(cookie, where, usage);
+	return cookie;
 }
 
 /*
  * Update the auxiliary data on a cookie.
  */
 static inline
-void fscache_update_aux(struct fscache_cookie *cookie, const void *aux_data)
+void fscache_update_aux(struct fscache_cookie *cookie,
+			const void *aux_data, const loff_t *object_size)
 {
 	void *p = fscache_get_aux(cookie);
 
-	if (p && memcmp(p, aux_data, cookie->aux_len) != 0) {
+	if (aux_data && p)
 		memcpy(p, aux_data, cookie->aux_len);
-		set_bit(FSCACHE_COOKIE_AUX_UPDATED, &cookie->flags);
-	}
+	if (object_size)
+		cookie->object_size = *object_size;
 }
 
 /*****************************************************************************/
@@ -337,7 +333,7 @@ do {						\
 
 #define FSCACHE_DEBUG_CACHE	0
 #define FSCACHE_DEBUG_COOKIE	1
-#define FSCACHE_DEBUG_PAGE	2
+#define FSCACHE_DEBUG_OBJECT	2
 #define FSCACHE_DEBUG_OPERATION	3
 
 #define FSCACHE_POINT_ENTER	1
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index c8f1beafa8e1..003e53d17245 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -19,18 +19,6 @@ MODULE_DESCRIPTION("FS Cache Manager");
 MODULE_AUTHOR("Red Hat, Inc.");
 MODULE_LICENSE("GPL");
 
-unsigned fscache_defer_lookup = 1;
-module_param_named(defer_lookup, fscache_defer_lookup, uint,
-		   S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(fscache_defer_lookup,
-		 "Defer cookie lookup to background thread");
-
-unsigned fscache_defer_create = 1;
-module_param_named(defer_create, fscache_defer_create, uint,
-		   S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(fscache_defer_create,
-		 "Defer cookie creation to background thread");
-
 unsigned fscache_debug;
 module_param_named(debug, fscache_debug, uint,
 		   S_IWUSR | S_IRUGO);
@@ -38,11 +26,8 @@ MODULE_PARM_DESC(fscache_debug,
 		 "FS-Cache debugging mask");
 
 struct kobject *fscache_root;
-struct workqueue_struct *fscache_object_wq;
 struct workqueue_struct *fscache_op_wq;
 
-DEFINE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
-
 /* these values serve as lower bounds, will be adjusted in fscache_init() */
 static unsigned fscache_object_max_active = 4;
 static unsigned fscache_op_max_active = 2;
@@ -64,14 +49,6 @@ static int fscache_max_active_sysctl(struct ctl_table *table, int write,
 }
 
 static struct ctl_table fscache_sysctls[] = {
-	{
-		.procname	= "object_max_active",
-		.data		= &fscache_object_max_active,
-		.maxlen		= sizeof(unsigned),
-		.mode		= 0644,
-		.proc_handler	= fscache_max_active_sysctl,
-		.extra1		= &fscache_object_wq,
-	},
 	{
 		.procname	= "operation_max_active",
 		.data		= &fscache_op_max_active,
@@ -98,20 +75,8 @@ static struct ctl_table fscache_sysctls_root[] = {
  */
 static int __init fscache_init(void)
 {
-	unsigned int nr_cpus = num_possible_cpus();
-	unsigned int cpu;
 	int ret;
 
-	fscache_object_max_active =
-		clamp_val(nr_cpus,
-			  fscache_object_max_active, WQ_UNBOUND_MAX_ACTIVE);
-
-	ret = -ENOMEM;
-	fscache_object_wq = alloc_workqueue("fscache_object", WQ_UNBOUND,
-					    fscache_object_max_active);
-	if (!fscache_object_wq)
-		goto error_object_wq;
-
 	fscache_op_max_active =
 		clamp_val(fscache_object_max_active / 2,
 			  fscache_op_max_active, WQ_UNBOUND_MAX_ACTIVE);
@@ -122,9 +87,6 @@ static int __init fscache_init(void)
 	if (!fscache_op_wq)
 		goto error_op_wq;
 
-	for_each_possible_cpu(cpu)
-		init_waitqueue_head(&per_cpu(fscache_object_cong_wait, cpu));
-
 	ret = fscache_init_dispatchers();
 	if (ret < 0)
 		goto error_dispatchers;
@@ -169,8 +131,6 @@ static int __init fscache_init(void)
 error_proc:
 	destroy_workqueue(fscache_op_wq);
 error_op_wq:
-	destroy_workqueue(fscache_object_wq);
-error_object_wq:
 	return ret;
 }
 
@@ -191,7 +151,6 @@ static void __exit fscache_exit(void)
 	fscache_proc_cleanup();
 	fscache_kill_dispatchers();
 	destroy_workqueue(fscache_op_wq);
-	destroy_workqueue(fscache_object_wq);
 	pr_notice("Unloaded\n");
 }
 
diff --git a/fs/fscache/netfs.c b/fs/fscache/netfs.c
index f8a816f844f6..7ebf733b068b 100644
--- a/fs/fscache/netfs.c
+++ b/fs/fscache/netfs.c
@@ -32,7 +32,7 @@ int __fscache_register_netfs(struct fscache_netfs *netfs)
 		return -ENOMEM;
 	}
 
-	candidate->flags = 1 << FSCACHE_COOKIE_ENABLED;
+	trace_fscache_cookie(candidate, fscache_cookie_new_netfs, 1);
 
 	/* check the netfs type is not already present */
 	cookie = fscache_hash_cookie(candidate);
@@ -68,7 +68,7 @@ void __fscache_unregister_netfs(struct fscache_netfs *netfs)
 {
 	_enter("{%s.%u}", netfs->name, netfs->version);
 
-	fscache_relinquish_cookie(netfs->primary_index, NULL, false);
+	fscache_relinquish_cookie(netfs->primary_index, false);
 	pr_notice("Netfs '%s' unregistered from caching\n", netfs->name);
 
 	_leave("");
diff --git a/fs/fscache/obj.c b/fs/fscache/obj.c
new file mode 100644
index 000000000000..d4a3b6fac791
--- /dev/null
+++ b/fs/fscache/obj.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Cache object management
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * See Documentation/filesystems/caching/netfs-api.txt for more information on
+ * the netfs API.
+ */
+
+#define FSCACHE_DEBUG_LEVEL OPERATION
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+static struct fscache_object *fscache_do_alloc_object(struct fscache_cookie *cookie,
+						      struct fscache_cache *cache,
+						      struct fscache_object *parent)
+{
+	struct fscache_object *object;
+
+	fscache_stat(&fscache_n_cop_alloc_object);
+	object = cache->ops->alloc_object(cookie, cache, parent);
+	fscache_stat_d(&fscache_n_cop_alloc_object);
+
+	if (object) {
+		ASSERTCMP(object->cookie, ==, cookie);
+		_debug("ALLOC o=%08x: %s", object->debug_id, cookie->type_name);
+		fscache_stat(&fscache_n_object_alloc);
+	} else {
+		fscache_stat(&fscache_n_object_no_alloc);
+	}
+
+	return object;
+}
+
+static int fscache_do_lookup_object(struct fscache_object *object, void *data)
+{
+	int ret;
+	fscache_stat(&fscache_n_object_lookups);
+	fscache_stat(&fscache_n_cop_lookup_object);
+	ret = object->cache->ops->lookup_object(object, data);
+	fscache_stat_d(&fscache_n_cop_lookup_object);
+	return ret;
+}
+
+static int fscache_do_create_object(struct fscache_object *object, void *data)
+{
+	int ret;
+	fscache_stat(&fscache_n_object_lookups);
+	fscache_stat(&fscache_n_cop_lookup_object);
+	ret = object->cache->ops->create_object(object, data);
+	fscache_stat_d(&fscache_n_cop_lookup_object);
+	return ret;
+}
+
+static void fscache_do_update_object(struct fscache_object *object)
+{
+	fscache_stat(&fscache_n_updates_run);
+	fscache_stat(&fscache_n_cop_update_object);
+	object->cache->ops->update_object(object);
+	fscache_stat_d(&fscache_n_cop_update_object);
+}
+
+static void fscache_do_drop_object(struct fscache_cache *cache,
+				   struct fscache_object *object,
+				   bool invalidate)
+{
+	fscache_stat(&fscache_n_cop_drop_object);
+	cache->ops->drop_object(object, invalidate);
+	fscache_stat_d(&fscache_n_cop_drop_object);
+}
+
+static void fscache_do_put_object(struct fscache_object *object,
+				  enum fscache_obj_ref_trace why)
+{
+	fscache_stat(&fscache_n_cop_put_object);
+	object->cache->ops->put_object(object, why);
+	fscache_stat_d(&fscache_n_cop_put_object);
+}
+
+/*
+ * Do the actual on-disk wrangling involved in object lookup/creation.
+ */
+static bool fscache_wrangle_object(struct fscache_cookie *cookie,
+				   struct fscache_cache *cache,
+				   struct fscache_object *object)
+{
+
+	void *lookup_data;
+	bool ret = false;
+
+	lookup_data = cache->ops->prepare_lookup_data(object);
+	if (IS_ERR(lookup_data))
+		goto out;
+
+	if (!fscache_do_lookup_object(object, lookup_data))
+		goto out_free;
+
+	if (object->stage < FSCACHE_OBJECT_STAGE_LIVE_EMPTY &&
+	    !fscache_do_create_object(object, lookup_data))
+		goto out_free;
+
+	fscache_set_cookie_stage(cookie,
+				 (object->stage < FSCACHE_OBJECT_STAGE_LIVE ?
+				  FSCACHE_COOKIE_STAGE_NO_DATA_YET :
+				  FSCACHE_COOKIE_STAGE_ACTIVE));
+	ret = true;
+
+out_free:
+	cache->ops->free_lookup_data(object, lookup_data);
+out:
+	return ret;
+}
+
+/*
+ * Create an object chain, making sure that the index chain is fully created.
+ */
+static struct fscache_object *fscache_lookup_object_chain(struct fscache_cookie *cookie,
+							  struct fscache_cache *cache)
+{
+	struct fscache_object *object = NULL, *parent, *xobject;
+
+	_enter("c=%08x", cookie->debug_id);
+
+	spin_lock(&cookie->lock);
+	hlist_for_each_entry(object, &cookie->backing_objects, cookie_link) {
+		if (object->cache == cache)
+			goto object_exists_grab;
+	}
+	spin_unlock(&cookie->lock);
+
+	/* Recurse to look up/create the parent index. */
+	parent = fscache_lookup_object_chain(cookie->parent, cache);
+	if (!parent)
+		goto error;
+
+	/* Ask the cache to allocate an object (we may end up with duplicate
+	 * objects at this stage, but we sort that out later).
+	 *
+	 * The object may be created, say, with O_TMPFILE at this point if the
+	 * parent index was unpopulated.  Note that this may race on index
+	 * creation with other callers.
+	 */
+	object = fscache_do_alloc_object(cookie, cache, parent);
+	if (!object)
+		goto error;
+
+	xobject = fscache_attach_object(cookie, object);
+	if (xobject != object) {
+		fscache_do_put_object(object, fscache_obj_put_alloc_dup);
+		if (!xobject)
+			goto error;
+		object = xobject;
+		if (fscache_cache_is_broken(object))
+			goto error_put;
+		goto object_exists;
+	}
+
+	if (!fscache_wrangle_object(cookie, cache, object))
+		goto error_detach;
+
+	_leave(" = new [o=%08x]", object->debug_id);
+	return object;
+
+object_exists_grab:
+	object = cache->ops->grab_object(object, fscache_obj_get_exists);
+	if (fscache_cache_is_broken(object)) {
+		spin_unlock(&cookie->lock);
+		goto error_put;
+	}
+
+	spin_unlock(&cookie->lock);
+
+object_exists:
+	wait_var_event(&object->stage,
+		       READ_ONCE(object->stage) >= FSCACHE_OBJECT_STAGE_LIVE_EMPTY);
+
+	if (object->stage >= FSCACHE_OBJECT_STAGE_DESTROYING)
+		goto error_put;
+
+	_leave(" = share [o=%08x]", object->debug_id);
+	return object;
+
+error_detach:
+	spin_lock(&cookie->lock);
+	spin_lock(&object->lock);
+	object->parent = NULL;
+	object->stage = FSCACHE_OBJECT_STAGE_DEAD;
+	cookie->stage = FSCACHE_COOKIE_STAGE_FAILED;
+	hlist_del_init(&object->cookie_link);
+	spin_unlock(&object->lock);
+	spin_unlock(&cookie->lock);
+	wake_up_cookie_stage(cookie);
+	fscache_drop_object(cookie, object, false);
+error_put:
+	fscache_do_put_object(object, fscache_obj_put_lookup_fail);
+error:
+	if (cookie->stage != FSCACHE_COOKIE_STAGE_FAILED)
+		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_QUIESCENT);
+	_leave(" = NULL");
+	return NULL;
+}
+
+/*
+ * Create an object in the cache.
+ * - this must make sure the index chain is instantiated and instantiate the
+ *   object representation too
+ */
+static void fscache_lookup_object_locked(struct fscache_cookie *cookie)
+{
+	struct fscache_object *object;
+	struct fscache_cache *cache;
+
+	_enter("");
+
+	/* select a cache in which to store the object */
+	cache = fscache_select_cache_for_object(cookie);
+	if (!cache) {
+		fscache_stat(&fscache_n_acquires_no_cache);
+		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_QUIESCENT);
+		_leave(" [no cache]");
+		return;
+	}
+
+	_debug("cache %s", cache->tag->name);
+
+	object = fscache_lookup_object_chain(cookie, cache);
+	if (!object) {
+		_leave(" [fail]");
+		return;
+	}
+
+	fscache_do_put_object(object, fscache_obj_put);
+	_leave(" [done]");
+}
+
+void fscache_lookup_object(struct fscache_cookie *cookie,
+			   struct fscache_object *object, int param)
+{
+	down_read(&fscache_addremove_sem);
+	fscache_lookup_object_locked(cookie);
+	up_read(&fscache_addremove_sem);
+	__fscache_unuse_cookie(cookie, NULL, NULL);
+}
+
+/*
+ * Invalidate an object
+ */
+void fscache_invalidate_object(struct fscache_cookie *cookie,
+			       struct fscache_object *unused, int param)
+{
+	struct fscache_object *object = NULL;
+	bool success = true;
+
+	spin_lock(&cookie->lock);
+
+	if (!hlist_empty(&cookie->backing_objects)) {
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object,
+				     cookie_link);
+		object = object->cache->ops->grab_object(object,
+							 fscache_obj_get_inval);
+	}
+
+	spin_unlock(&cookie->lock);
+
+	if (object) {
+		success = object->cache->ops->invalidate_object(object);
+		fscache_do_put_object(object, fscache_obj_put_inval);
+	}
+
+	if (success)
+		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_NO_DATA_YET);
+	else
+		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_FAILED);
+	fscache_end_io_operation(cookie);
+}
+
+/*
+ * Drop an object's attachments
+ */
+void fscache_drop_object(struct fscache_cookie *cookie,
+			 struct fscache_object *object,
+			 bool invalidate)
+{
+	struct fscache_object *parent = object->parent;
+	struct fscache_cache *cache = object->cache;
+
+	if (WARN(cookie->stage != FSCACHE_COOKIE_STAGE_INDEX &&
+		 cookie->stage != FSCACHE_COOKIE_STAGE_WITHDRAWING &&
+		 cookie->stage != FSCACHE_COOKIE_STAGE_FAILED &&
+		 cookie->stage != FSCACHE_COOKIE_STAGE_RELINQUISHING,
+		 "Can't drop object in stage %u\n", cookie->stage))
+		return;
+
+	_enter("{o=%08x,%d},%u",
+	       object->debug_id, object->n_children, invalidate);
+
+	if (!invalidate &&
+	    test_bit(FSCACHE_OBJECT_NEEDS_UPDATE, &object->flags)) {
+		_debug("final update");
+		fscache_do_update_object(object);
+	}
+
+	spin_lock(&cache->object_list_lock);
+	list_del_init(&object->cache_link);
+	spin_unlock(&cache->object_list_lock);
+
+	fscache_do_drop_object(cache, object, invalidate);
+
+	/* The parent object wants to know when all it dependents have gone */
+	if (parent) {
+		bool wake = false;
+
+		_debug("release parent o=%08x {%d}",
+		       parent->debug_id, parent->n_children);
+
+		spin_lock(&parent->lock);
+		parent->n_children--;
+		if (parent->n_children == 0)
+			wake = true;
+		spin_unlock(&parent->lock);
+		if (wake) {
+			smp_mb();
+			wake_up_var(&parent->n_children);
+		}
+		fscache_do_put_object(parent, fscache_obj_put_drop_child);
+	}
+
+	fscache_do_put_object(object, fscache_obj_put_drop_obj);
+	fscache_stat(&fscache_n_object_dead);
+	_leave("");
+}
+
+/*
+ * Discard objects on cookie relinquishement.  param==1 to invalidate it at the
+ * same time.
+ */
+void fscache_relinquish_objects(struct fscache_cookie *cookie,
+				struct fscache_object *unused, int param)
+{
+	_enter("c=%08x", cookie->debug_id);
+
+	wait_var_event(&cookie->n_active, atomic_read(&cookie->n_active) == 0);
+	WARN_ON(cookie->stage != FSCACHE_COOKIE_STAGE_RELINQUISHING);
+
+	for (;;) {
+		struct fscache_object *object = NULL;
+
+		trace_fscache_cookie(cookie, fscache_cookie_see_discard,
+				     atomic_read(&cookie->usage));
+
+		spin_lock(&cookie->lock);
+		if (!hlist_empty(&cookie->backing_objects)) {
+			object = hlist_entry(cookie->backing_objects.first,
+					     struct fscache_object,
+					     cookie_link);
+			hlist_del_init(&object->cookie_link);
+		}
+		spin_unlock(&cookie->lock);
+
+		if (!object)
+			break;
+
+		_debug("DISCARD o=%08x", object->debug_id);
+		fscache_drop_object(cookie, object, param);
+	}
+
+	fscache_drop_cookie(cookie);
+}
diff --git a/fs/fscache/object-list.c b/fs/fscache/object-list.c
index 147c556ee01b..5777f909d31a 100644
--- a/fs/fscache/object-list.c
+++ b/fs/fscache/object-list.c
@@ -23,10 +23,6 @@ struct fscache_objlist_data {
 #define FSCACHE_OBJLIST_CONFIG_AUX	0x00000002	/* show object auxdata */
 #define FSCACHE_OBJLIST_CONFIG_BUSY	0x00000010	/* show busy objects */
 #define FSCACHE_OBJLIST_CONFIG_IDLE	0x00000020	/* show idle objects */
-#define FSCACHE_OBJLIST_CONFIG_EVENTS	0x00000400	/* show objects with events */
-#define FSCACHE_OBJLIST_CONFIG_NOEVENTS	0x00000800	/* show objects without no events */
-#define FSCACHE_OBJLIST_CONFIG_WORK	0x00001000	/* show objects with work */
-#define FSCACHE_OBJLIST_CONFIG_NOWORK	0x00002000	/* show objects without work */
 };
 
 /*
@@ -162,32 +158,15 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 	u8 *p;
 
 	if ((unsigned long) v == 1) {
-		seq_puts(m, "OBJECT   PARENT   STAT CHLDN OPS OOP"
-			 " EM EV FL S"
-			 " | COOKIE   TYPE    TY FL");
-		if (config & (FSCACHE_OBJLIST_CONFIG_KEY |
-			      FSCACHE_OBJLIST_CONFIG_AUX))
-			seq_puts(m, "       ");
-		if (config & FSCACHE_OBJLIST_CONFIG_KEY)
-			seq_puts(m, "OBJECT_KEY");
-		if ((config & (FSCACHE_OBJLIST_CONFIG_KEY |
-			       FSCACHE_OBJLIST_CONFIG_AUX)) ==
-		    (FSCACHE_OBJLIST_CONFIG_KEY | FSCACHE_OBJLIST_CONFIG_AUX))
-			seq_puts(m, ", ");
-		if (config & FSCACHE_OBJLIST_CONFIG_AUX)
-			seq_puts(m, "AUX_DATA");
+		seq_puts(m, "OBJECT   PARENT   USE CHLDN OPS FL  S"
+			 " | COOKIE   TYPE    TY S FLG CONTENT_MAP");
 		seq_puts(m, "\n");
 		return 0;
 	}
 
 	if ((unsigned long) v == 2) {
-		seq_puts(m, "======== ======== ==== ===== === ==="
-			 " == == == ="
-			 " | ======== ======= == ===");
-		if (config & (FSCACHE_OBJLIST_CONFIG_KEY |
-			      FSCACHE_OBJLIST_CONFIG_AUX))
-			seq_puts(m, " ================");
-		seq_puts(m, "\n");
+		seq_puts(m, "======== ======== === ===== === === ="
+			 " | ======== ======= == = === ================\n");
 		return 0;
 	}
 
@@ -207,29 +186,19 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 
 	cookie = obj->cookie;
 	if (~config) {
-		FILTER(fscache_object_is_active(obj) ||
-		       obj->n_ops != 0 ||
-		       obj->n_obj_ops != 0 ||
-		       obj->flags ||
-		       !list_empty(&obj->dependents),
+		FILTER(atomic_read(&cookie->n_ops) > 0,
 		       BUSY, IDLE);
-		FILTER(obj->events & obj->event_mask,
-		       EVENTS, NOEVENTS);
-		FILTER(work_busy(&obj->work), WORK, NOWORK);
 	}
 
 	seq_printf(m,
-		   "%08x %08x %s %5u %3u %3u %2lx %2lx %2lx %1x | ",
+		   "%08x %08x %3u %5u %3u %3lx %u | ",
 		   obj->debug_id,
 		   obj->parent ? obj->parent->debug_id : UINT_MAX,
-		   obj->state->short_name,
+		   obj->cache->ops->get_object_usage(obj),
 		   obj->n_children,
-		   obj->n_ops,
-		   obj->n_obj_ops,
-		   obj->event_mask,
-		   obj->events,
+		   atomic_read(&obj->cookie->n_ops),
 		   obj->flags,
-		   work_busy(&obj->work));
+		   obj->stage);
 
 	if (obj->cookie) {
 		uint16_t keylen = 0, auxlen = 0;
@@ -248,10 +217,11 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 			break;
 		}
 
-		seq_printf(m, "%08x %-7s %s %3lx",
+		seq_printf(m, "%08x %-7s %s %u %3lx",
 			   cookie->debug_id,
 			   cookie->type_name,
 			   type,
+			   cookie->stage,
 			   cookie->flags);
 
 		if (config & FSCACHE_OBJLIST_CONFIG_KEY)
@@ -325,8 +295,6 @@ static void fscache_objlist_config(struct fscache_objlist_data *data)
 		case 'A': config |= FSCACHE_OBJLIST_CONFIG_AUX;		break;
 		case 'B': config |= FSCACHE_OBJLIST_CONFIG_BUSY;	break;
 		case 'b': config |= FSCACHE_OBJLIST_CONFIG_IDLE;	break;
-		case 'S': config |= FSCACHE_OBJLIST_CONFIG_WORK;	break;
-		case 's': config |= FSCACHE_OBJLIST_CONFIG_NOWORK;	break;
 		}
 	}
 
@@ -335,10 +303,6 @@ static void fscache_objlist_config(struct fscache_objlist_data *data)
 
 	if (!(config & (FSCACHE_OBJLIST_CONFIG_BUSY | FSCACHE_OBJLIST_CONFIG_IDLE)))
 	    config   |= FSCACHE_OBJLIST_CONFIG_BUSY | FSCACHE_OBJLIST_CONFIG_IDLE;
-	if (!(config & (FSCACHE_OBJLIST_CONFIG_EVENTS | FSCACHE_OBJLIST_CONFIG_NOEVENTS)))
-	    config   |= FSCACHE_OBJLIST_CONFIG_EVENTS | FSCACHE_OBJLIST_CONFIG_NOEVENTS;
-	if (!(config & (FSCACHE_OBJLIST_CONFIG_WORK | FSCACHE_OBJLIST_CONFIG_NOWORK)))
-	    config   |= FSCACHE_OBJLIST_CONFIG_WORK | FSCACHE_OBJLIST_CONFIG_NOWORK;
 
 	data->config = config;
 	return;
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
deleted file mode 100644
index efdd5309d88e..000000000000
--- a/fs/fscache/object.c
+++ /dev/null
@@ -1,981 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* FS-Cache object state machine handler
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * See Documentation/filesystems/caching/object.rst for a description of the
- * object state machine and the in-kernel representations.
- */
-
-#define FSCACHE_DEBUG_LEVEL COOKIE
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/prefetch.h>
-#include "internal.h"
-
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
-
-#define __STATE_NAME(n) fscache_osm_##n
-#define STATE(n) (&__STATE_NAME(n))
-
-/*
- * Define a work state.  Work states are execution states.  No event processing
- * is performed by them.  The function attached to a work state returns a
- * pointer indicating the next state to which the state machine should
- * transition.  Returning NO_TRANSIT repeats the current state, but goes back
- * to the scheduler first.
- */
-#define WORK_STATE(n, sn, f) \
-	const struct fscache_state __STATE_NAME(n) = {			\
-		.name = #n,						\
-		.short_name = sn,					\
-		.work = f						\
-	}
-
-/*
- * Returns from work states.
- */
-#define transit_to(state) ({ prefetch(&STATE(state)->work); STATE(state); })
-
-#define NO_TRANSIT ((struct fscache_state *)NULL)
-
-/*
- * Define a wait state.  Wait states are event processing states.  No execution
- * is performed by them.  Wait states are just tables of "if event X occurs,
- * clear it and transition to state Y".  The dispatcher returns to the
- * scheduler if none of the events in which the wait state has an interest are
- * currently pending.
- */
-#define WAIT_STATE(n, sn, ...) \
-	const struct fscache_state __STATE_NAME(n) = {			\
-		.name = #n,						\
-		.short_name = sn,					\
-		.work = NULL,						\
-		.transitions = { __VA_ARGS__, { 0, NULL } }		\
-	}
-
-#define TRANSIT_TO(state, emask) \
-	{ .events = (emask), .transit_to = STATE(state) }
-
-/*
- * The object state machine.
- */
-static WORK_STATE(INIT_OBJECT,		"INIT", fscache_initialise_object);
-static WORK_STATE(PARENT_READY,		"PRDY", fscache_parent_ready);
-static WORK_STATE(ABORT_INIT,		"ABRT", fscache_abort_initialisation);
-static WORK_STATE(LOOK_UP_OBJECT,	"LOOK", fscache_look_up_object);
-static WORK_STATE(CREATE_OBJECT,	"CRTO", fscache_look_up_object);
-static WORK_STATE(OBJECT_AVAILABLE,	"AVBL", fscache_object_available);
-static WORK_STATE(JUMPSTART_DEPS,	"JUMP", fscache_jumpstart_dependents);
-
-static WORK_STATE(INVALIDATE_OBJECT,	"INVL", fscache_invalidate_object);
-static WORK_STATE(UPDATE_OBJECT,	"UPDT", fscache_update_object);
-
-static WORK_STATE(LOOKUP_FAILURE,	"LCFL", fscache_lookup_failure);
-static WORK_STATE(KILL_OBJECT,		"KILL", fscache_kill_object);
-static WORK_STATE(KILL_DEPENDENTS,	"KDEP", fscache_kill_dependents);
-static WORK_STATE(DROP_OBJECT,		"DROP", fscache_drop_object);
-static WORK_STATE(OBJECT_DEAD,		"DEAD", fscache_object_dead);
-
-static WAIT_STATE(WAIT_FOR_INIT,	"?INI",
-		  TRANSIT_TO(INIT_OBJECT,	1 << FSCACHE_OBJECT_EV_NEW_CHILD));
-
-static WAIT_STATE(WAIT_FOR_PARENT,	"?PRN",
-		  TRANSIT_TO(PARENT_READY,	1 << FSCACHE_OBJECT_EV_PARENT_READY));
-
-static WAIT_STATE(WAIT_FOR_CMD,		"?CMD",
-		  TRANSIT_TO(INVALIDATE_OBJECT,	1 << FSCACHE_OBJECT_EV_INVALIDATE),
-		  TRANSIT_TO(UPDATE_OBJECT,	1 << FSCACHE_OBJECT_EV_UPDATE),
-		  TRANSIT_TO(JUMPSTART_DEPS,	1 << FSCACHE_OBJECT_EV_NEW_CHILD));
-
-static WAIT_STATE(WAIT_FOR_CLEARANCE,	"?CLR",
-		  TRANSIT_TO(KILL_OBJECT,	1 << FSCACHE_OBJECT_EV_CLEARED));
-
-/*
- * Out-of-band event transition tables.  These are for handling unexpected
- * events, such as an I/O error.  If an OOB event occurs, the state machine
- * clears and disables the event and forces a transition to the nominated work
- * state (acurrently executing work states will complete first).
- *
- * In such a situation, object->state remembers the state the machine should
- * have been in/gone to and returning NO_TRANSIT returns to that.
- */
-static const struct fscache_transition fscache_osm_init_oob[] = {
-	   TRANSIT_TO(ABORT_INIT,
-		      (1 << FSCACHE_OBJECT_EV_ERROR) |
-		      (1 << FSCACHE_OBJECT_EV_KILL)),
-	   { 0, NULL }
-};
-
-static const struct fscache_transition fscache_osm_lookup_oob[] = {
-	   TRANSIT_TO(LOOKUP_FAILURE,
-		      (1 << FSCACHE_OBJECT_EV_ERROR) |
-		      (1 << FSCACHE_OBJECT_EV_KILL)),
-	   { 0, NULL }
-};
-
-static const struct fscache_transition fscache_osm_run_oob[] = {
-	   TRANSIT_TO(KILL_OBJECT,
-		      (1 << FSCACHE_OBJECT_EV_ERROR) |
-		      (1 << FSCACHE_OBJECT_EV_KILL)),
-	   { 0, NULL }
-};
-
-static int  fscache_get_object(struct fscache_object *,
-			       enum fscache_obj_ref_trace);
-static void fscache_put_object(struct fscache_object *,
-			       enum fscache_obj_ref_trace);
-static bool fscache_enqueue_dependents(struct fscache_object *, int);
-static void fscache_dequeue_object(struct fscache_object *);
-static void fscache_update_aux_data(struct fscache_object *);
-
-/*
- * we need to notify the parent when an op completes that we had outstanding
- * upon it
- */
-static inline void fscache_done_parent_op(struct fscache_object *object)
-{
-	struct fscache_object *parent = object->parent;
-
-	_enter("OBJ%x {OBJ%x,%x}",
-	       object->debug_id, parent->debug_id, parent->n_ops);
-
-	spin_lock_nested(&parent->lock, 1);
-	parent->n_obj_ops--;
-	parent->n_ops--;
-	if (parent->n_ops == 0)
-		fscache_raise_event(parent, FSCACHE_OBJECT_EV_CLEARED);
-	spin_unlock(&parent->lock);
-}
-
-/*
- * Object state machine dispatcher.
- */
-static void fscache_object_sm_dispatcher(struct fscache_object *object)
-{
-	const struct fscache_transition *t;
-	const struct fscache_state *state, *new_state;
-	unsigned long events, event_mask;
-	bool oob;
-	int event = -1;
-
-	ASSERT(object != NULL);
-
-	_enter("{OBJ%x,%s,%lx}",
-	       object->debug_id, object->state->name, object->events);
-
-	event_mask = object->event_mask;
-restart:
-	object->event_mask = 0; /* Mask normal event handling */
-	state = object->state;
-restart_masked:
-	events = object->events;
-
-	/* Handle any out-of-band events (typically an error) */
-	if (events & object->oob_event_mask) {
-		_debug("{OBJ%x} oob %lx",
-		       object->debug_id, events & object->oob_event_mask);
-		oob = true;
-		for (t = object->oob_table; t->events; t++) {
-			if (events & t->events) {
-				state = t->transit_to;
-				ASSERT(state->work != NULL);
-				event = fls(events & t->events) - 1;
-				__clear_bit(event, &object->oob_event_mask);
-				clear_bit(event, &object->events);
-				goto execute_work_state;
-			}
-		}
-	}
-	oob = false;
-
-	/* Wait states are just transition tables */
-	if (!state->work) {
-		if (events & event_mask) {
-			for (t = state->transitions; t->events; t++) {
-				if (events & t->events) {
-					new_state = t->transit_to;
-					event = fls(events & t->events) - 1;
-					trace_fscache_osm(object, state,
-							  true, false, event);
-					clear_bit(event, &object->events);
-					_debug("{OBJ%x} ev %d: %s -> %s",
-					       object->debug_id, event,
-					       state->name, new_state->name);
-					object->state = state = new_state;
-					goto execute_work_state;
-				}
-			}
-
-			/* The event mask didn't include all the tabled bits */
-			BUG();
-		}
-		/* Randomly woke up */
-		goto unmask_events;
-	}
-
-execute_work_state:
-	_debug("{OBJ%x} exec %s", object->debug_id, state->name);
-
-	trace_fscache_osm(object, state, false, oob, event);
-	new_state = state->work(object, event);
-	event = -1;
-	if (new_state == NO_TRANSIT) {
-		_debug("{OBJ%x} %s notrans", object->debug_id, state->name);
-		if (unlikely(state == STATE(OBJECT_DEAD))) {
-			_leave(" [dead]");
-			return;
-		}
-		fscache_enqueue_object(object);
-		event_mask = object->oob_event_mask;
-		goto unmask_events;
-	}
-
-	_debug("{OBJ%x} %s -> %s",
-	       object->debug_id, state->name, new_state->name);
-	object->state = state = new_state;
-
-	if (state->work) {
-		if (unlikely(state == STATE(OBJECT_DEAD))) {
-			_leave(" [dead]");
-			return;
-		}
-		goto restart_masked;
-	}
-
-	/* Transited to wait state */
-	event_mask = object->oob_event_mask;
-	for (t = state->transitions; t->events; t++)
-		event_mask |= t->events;
-
-unmask_events:
-	object->event_mask = event_mask;
-	smp_mb();
-	events = object->events;
-	if (events & event_mask)
-		goto restart;
-	_leave(" [msk %lx]", event_mask);
-}
-
-/*
- * execute an object
- */
-static void fscache_object_work_func(struct work_struct *work)
-{
-	struct fscache_object *object =
-		container_of(work, struct fscache_object, work);
-	unsigned long start;
-
-	_enter("{OBJ%x}", object->debug_id);
-
-	start = jiffies;
-	fscache_object_sm_dispatcher(object);
-	fscache_hist(fscache_objs_histogram, start);
-	fscache_put_object(object, fscache_obj_put_work);
-}
-
-/**
- * fscache_object_init - Initialise a cache object description
- * @object: Object description
- * @cookie: Cookie object will be attached to
- * @cache: Cache in which backing object will be found
- *
- * Initialise a cache object description to its basic values.
- *
- * See Documentation/filesystems/caching/backend-api.rst for a complete
- * description.
- */
-void fscache_object_init(struct fscache_object *object,
-			 struct fscache_cookie *cookie,
-			 struct fscache_cache *cache)
-{
-	const struct fscache_transition *t;
-
-	atomic_inc(&cache->object_count);
-
-	object->state = STATE(WAIT_FOR_INIT);
-	object->oob_table = fscache_osm_init_oob;
-	object->flags = 1 << FSCACHE_OBJECT_IS_LIVE;
-	spin_lock_init(&object->lock);
-	INIT_LIST_HEAD(&object->cache_link);
-	INIT_HLIST_NODE(&object->cookie_link);
-	INIT_WORK(&object->work, fscache_object_work_func);
-	INIT_LIST_HEAD(&object->dependents);
-	INIT_LIST_HEAD(&object->dep_link);
-	object->n_children = 0;
-	object->n_ops = 0;
-	object->events = 0;
-	object->cache = cache;
-	object->cookie = cookie;
-	fscache_cookie_get(cookie, fscache_cookie_get_attach_object);
-	object->parent = NULL;
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
-	RB_CLEAR_NODE(&object->objlist_link);
-#endif
-
-	object->oob_event_mask = 0;
-	for (t = object->oob_table; t->events; t++)
-		object->oob_event_mask |= t->events;
-	object->event_mask = object->oob_event_mask;
-	for (t = object->state->transitions; t->events; t++)
-		object->event_mask |= t->events;
-}
-EXPORT_SYMBOL(fscache_object_init);
-
-/*
- * Mark the object as no longer being live, making sure that we synchronise
- * against op submission.
- */
-static inline void fscache_mark_object_dead(struct fscache_object *object)
-{
-	spin_lock(&object->lock);
-	clear_bit(FSCACHE_OBJECT_IS_LIVE, &object->flags);
-	spin_unlock(&object->lock);
-}
-
-/*
- * Abort object initialisation before we start it.
- */
-static const struct fscache_state *fscache_abort_initialisation(struct fscache_object *object,
-								int event)
-{
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	object->oob_event_mask = 0;
-	fscache_dequeue_object(object);
-	return transit_to(KILL_OBJECT);
-}
-
-/*
- * initialise an object
- * - check the specified object's parent to see if we can make use of it
- *   immediately to do a creation
- * - we may need to start the process of creating a parent and we need to wait
- *   for the parent's lookup and creation to complete if it's not there yet
- */
-static const struct fscache_state *fscache_initialise_object(struct fscache_object *object,
-							     int event)
-{
-	struct fscache_object *parent;
-	bool success;
-
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	ASSERT(list_empty(&object->dep_link));
-
-	parent = object->parent;
-	if (!parent) {
-		_leave(" [no parent]");
-		return transit_to(DROP_OBJECT);
-	}
-
-	_debug("parent: %s of:%lx", parent->state->name, parent->flags);
-
-	if (fscache_object_is_dying(parent)) {
-		_leave(" [bad parent]");
-		return transit_to(DROP_OBJECT);
-	}
-
-	if (fscache_object_is_available(parent)) {
-		_leave(" [ready]");
-		return transit_to(PARENT_READY);
-	}
-
-	_debug("wait");
-
-	spin_lock(&parent->lock);
-	fscache_stat(&fscache_n_cop_grab_object);
-	success = false;
-	if (fscache_object_is_live(parent) &&
-	    object->cache->ops->grab_object(object, fscache_obj_get_add_to_deps)) {
-		list_add(&object->dep_link, &parent->dependents);
-		success = true;
-	}
-	fscache_stat_d(&fscache_n_cop_grab_object);
-	spin_unlock(&parent->lock);
-	if (!success) {
-		_leave(" [grab failed]");
-		return transit_to(DROP_OBJECT);
-	}
-
-	/* fscache_acquire_non_index_cookie() uses this
-	 * to wake the chain up */
-	fscache_raise_event(parent, FSCACHE_OBJECT_EV_NEW_CHILD);
-	_leave(" [wait]");
-	return transit_to(WAIT_FOR_PARENT);
-}
-
-/*
- * Once the parent object is ready, we should kick off our lookup op.
- */
-static const struct fscache_state *fscache_parent_ready(struct fscache_object *object,
-							int event)
-{
-	struct fscache_object *parent = object->parent;
-
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	ASSERT(parent != NULL);
-
-	spin_lock(&parent->lock);
-	parent->n_ops++;
-	parent->n_obj_ops++;
-	object->lookup_jif = jiffies;
-	spin_unlock(&parent->lock);
-
-	_leave("");
-	return transit_to(LOOK_UP_OBJECT);
-}
-
-/*
- * look an object up in the cache from which it was allocated
- * - we hold an "access lock" on the parent object, so the parent object cannot
- *   be withdrawn by either party till we've finished
- */
-static const struct fscache_state *fscache_look_up_object(struct fscache_object *object,
-							  int event)
-{
-	struct fscache_cookie *cookie = object->cookie;
-	struct fscache_object *parent = object->parent;
-	int ret;
-
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	object->oob_table = fscache_osm_lookup_oob;
-
-	ASSERT(parent != NULL);
-	ASSERTCMP(parent->n_ops, >, 0);
-	ASSERTCMP(parent->n_obj_ops, >, 0);
-
-	/* make sure the parent is still available */
-	ASSERT(fscache_object_is_available(parent));
-
-	if (fscache_object_is_dying(parent) ||
-	    test_bit(FSCACHE_IOERROR, &object->cache->flags) ||
-	    !fscache_use_cookie(object)) {
-		_leave(" [unavailable]");
-		return transit_to(LOOKUP_FAILURE);
-	}
-
-	_debug("LOOKUP \"%s\" in \"%s\"",
-	       cookie->type_name, object->cache->tag->name);
-
-	fscache_stat(&fscache_n_object_lookups);
-	fscache_stat(&fscache_n_cop_lookup_object);
-	ret = object->cache->ops->lookup_object(object);
-	fscache_stat_d(&fscache_n_cop_lookup_object);
-
-	fscache_unuse_cookie(object);
-
-	if (ret == -ETIMEDOUT) {
-		/* probably stuck behind another object, so move this one to
-		 * the back of the queue */
-		fscache_stat(&fscache_n_object_lookups_timed_out);
-		_leave(" [timeout]");
-		return NO_TRANSIT;
-	}
-
-	if (ret < 0) {
-		_leave(" [error]");
-		return transit_to(LOOKUP_FAILURE);
-	}
-
-	_leave(" [ok]");
-	return transit_to(OBJECT_AVAILABLE);
-}
-
-/**
- * fscache_object_lookup_negative - Note negative cookie lookup
- * @object: Object pointing to cookie to mark
- *
- * Note negative lookup, permitting those waiting to read data from an already
- * existing backing object to continue as there's no data for them to read.
- */
-void fscache_object_lookup_negative(struct fscache_object *object)
-{
-	struct fscache_cookie *cookie = object->cookie;
-
-	_enter("{OBJ%x,%s}", object->debug_id, object->state->name);
-
-	if (!test_and_set_bit(FSCACHE_OBJECT_IS_LOOKED_UP, &object->flags)) {
-		fscache_stat(&fscache_n_object_lookups_negative);
-
-		/* Allow write requests to begin stacking up and read requests to begin
-		 * returning ENODATA.
-		 */
-		set_bit(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
-		clear_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
-
-		clear_bit_unlock(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags);
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
-	}
-	_leave("");
-}
-EXPORT_SYMBOL(fscache_object_lookup_negative);
-
-/**
- * fscache_obtained_object - Note successful object lookup or creation
- * @object: Object pointing to cookie to mark
- *
- * Note successful lookup and/or creation, permitting those waiting to write
- * data to a backing object to continue.
- *
- * Note that after calling this, an object's cookie may be relinquished by the
- * netfs, and so must be accessed with object lock held.
- */
-void fscache_obtained_object(struct fscache_object *object)
-{
-	struct fscache_cookie *cookie = object->cookie;
-
-	_enter("{OBJ%x,%s}", object->debug_id, object->state->name);
-
-	/* if we were still looking up, then we must have a positive lookup
-	 * result, in which case there may be data available */
-	if (!test_and_set_bit(FSCACHE_OBJECT_IS_LOOKED_UP, &object->flags)) {
-		fscache_stat(&fscache_n_object_lookups_positive);
-
-		/* We do (presumably) have data */
-		clear_bit_unlock(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
-		clear_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
-
-		/* Allow write requests to begin stacking up and read requests
-		 * to begin shovelling data.
-		 */
-		clear_bit_unlock(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags);
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
-	} else {
-		fscache_stat(&fscache_n_object_created);
-	}
-
-	set_bit(FSCACHE_OBJECT_IS_AVAILABLE, &object->flags);
-	_leave("");
-}
-EXPORT_SYMBOL(fscache_obtained_object);
-
-/*
- * handle an object that has just become available
- */
-static const struct fscache_state *fscache_object_available(struct fscache_object *object,
-							    int event)
-{
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	object->oob_table = fscache_osm_run_oob;
-
-	spin_lock(&object->lock);
-
-	fscache_done_parent_op(object);
-	spin_unlock(&object->lock);
-
-	fscache_stat(&fscache_n_cop_lookup_complete);
-	object->cache->ops->lookup_complete(object);
-	fscache_stat_d(&fscache_n_cop_lookup_complete);
-
-	fscache_hist(fscache_obj_instantiate_histogram, object->lookup_jif);
-	fscache_stat(&fscache_n_object_avail);
-
-	_leave("");
-	return transit_to(JUMPSTART_DEPS);
-}
-
-/*
- * Wake up this object's dependent objects now that we've become available.
- */
-static const struct fscache_state *fscache_jumpstart_dependents(struct fscache_object *object,
-								int event)
-{
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	if (!fscache_enqueue_dependents(object, FSCACHE_OBJECT_EV_PARENT_READY))
-		return NO_TRANSIT; /* Not finished; requeue */
-	return transit_to(WAIT_FOR_CMD);
-}
-
-/*
- * Handle lookup or creation failute.
- */
-static const struct fscache_state *fscache_lookup_failure(struct fscache_object *object,
-							  int event)
-{
-	struct fscache_cookie *cookie;
-
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	object->oob_event_mask = 0;
-
-	fscache_stat(&fscache_n_cop_lookup_complete);
-	object->cache->ops->lookup_complete(object);
-	fscache_stat_d(&fscache_n_cop_lookup_complete);
-
-	set_bit(FSCACHE_OBJECT_KILLED_BY_CACHE, &object->flags);
-
-	cookie = object->cookie;
-	set_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
-	if (test_and_clear_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags))
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
-
-	fscache_done_parent_op(object);
-	return transit_to(KILL_OBJECT);
-}
-
-/*
- * Wait for completion of all active operations on this object and the death of
- * all child objects of this object.
- */
-static const struct fscache_state *fscache_kill_object(struct fscache_object *object,
-						       int event)
-{
-	_enter("{OBJ%x,%d,%d},%d",
-	       object->debug_id, object->n_ops, object->n_children, event);
-
-	fscache_mark_object_dead(object);
-	object->oob_event_mask = 0;
-
-	if (list_empty(&object->dependents) &&
-	    object->n_ops == 0 &&
-	    object->n_children == 0)
-		return transit_to(DROP_OBJECT);
-
-	if (!list_empty(&object->dependents))
-		return transit_to(KILL_DEPENDENTS);
-
-	return transit_to(WAIT_FOR_CLEARANCE);
-}
-
-/*
- * Kill dependent objects.
- */
-static const struct fscache_state *fscache_kill_dependents(struct fscache_object *object,
-							   int event)
-{
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	if (!fscache_enqueue_dependents(object, FSCACHE_OBJECT_EV_KILL))
-		return NO_TRANSIT; /* Not finished */
-	return transit_to(WAIT_FOR_CLEARANCE);
-}
-
-/*
- * Drop an object's attachments
- */
-static const struct fscache_state *fscache_drop_object(struct fscache_object *object,
-						       int event)
-{
-	struct fscache_object *parent = object->parent;
-	struct fscache_cookie *cookie = object->cookie;
-	struct fscache_cache *cache = object->cache;
-	bool awaken = false;
-
-	_enter("{OBJ%x,%d},%d", object->debug_id, object->n_children, event);
-
-	ASSERT(cookie != NULL);
-	ASSERT(!hlist_unhashed(&object->cookie_link));
-
-	if (test_bit(FSCACHE_COOKIE_AUX_UPDATED, &cookie->flags)) {
-		_debug("final update");
-		fscache_update_aux_data(object);
-	}
-
-	/* Make sure the cookie no longer points here and that the netfs isn't
-	 * waiting for us.
-	 */
-	spin_lock(&cookie->lock);
-	hlist_del_init(&object->cookie_link);
-	if (hlist_empty(&cookie->backing_objects) &&
-	    test_and_clear_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
-		awaken = true;
-	spin_unlock(&cookie->lock);
-
-	if (awaken)
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
-	if (test_and_clear_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags))
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP);
-
-
-	/* Prevent a race with our last child, which has to signal EV_CLEARED
-	 * before dropping our spinlock.
-	 */
-	spin_lock(&object->lock);
-	spin_unlock(&object->lock);
-
-	/* Discard from the cache's collection of objects */
-	spin_lock(&cache->object_list_lock);
-	list_del_init(&object->cache_link);
-	spin_unlock(&cache->object_list_lock);
-
-	fscache_stat(&fscache_n_cop_drop_object);
-	cache->ops->drop_object(object);
-	fscache_stat_d(&fscache_n_cop_drop_object);
-
-	/* The parent object wants to know when all it dependents have gone */
-	if (parent) {
-		_debug("release parent OBJ%x {%d}",
-		       parent->debug_id, parent->n_children);
-
-		spin_lock(&parent->lock);
-		parent->n_children--;
-		if (parent->n_children == 0)
-			fscache_raise_event(parent, FSCACHE_OBJECT_EV_CLEARED);
-		spin_unlock(&parent->lock);
-		object->parent = NULL;
-	}
-
-	/* this just shifts the object release to the work processor */
-	fscache_put_object(object, fscache_obj_put_drop_obj);
-	fscache_stat(&fscache_n_object_dead);
-
-	_leave("");
-	return transit_to(OBJECT_DEAD);
-}
-
-/*
- * get a ref on an object
- */
-static int fscache_get_object(struct fscache_object *object,
-			      enum fscache_obj_ref_trace why)
-{
-	int ret;
-
-	fscache_stat(&fscache_n_cop_grab_object);
-	ret = object->cache->ops->grab_object(object, why) ? 0 : -EAGAIN;
-	fscache_stat_d(&fscache_n_cop_grab_object);
-	return ret;
-}
-
-/*
- * Discard a ref on an object
- */
-static void fscache_put_object(struct fscache_object *object,
-			       enum fscache_obj_ref_trace why)
-{
-	fscache_stat(&fscache_n_cop_put_object);
-	object->cache->ops->put_object(object, why);
-	fscache_stat_d(&fscache_n_cop_put_object);
-}
-
-/**
- * fscache_object_destroy - Note that a cache object is about to be destroyed
- * @object: The object to be destroyed
- *
- * Note the imminent destruction and deallocation of a cache object record.
- */
-void fscache_object_destroy(struct fscache_object *object)
-{
-	fscache_objlist_remove(object);
-
-	/* We can get rid of the cookie now */
-	fscache_cookie_put(object->cookie, fscache_cookie_put_object);
-	object->cookie = NULL;
-}
-EXPORT_SYMBOL(fscache_object_destroy);
-
-/*
- * enqueue an object for metadata-type processing
- */
-void fscache_enqueue_object(struct fscache_object *object)
-{
-	_enter("{OBJ%x}", object->debug_id);
-
-	if (fscache_get_object(object, fscache_obj_get_queue) >= 0) {
-		wait_queue_head_t *cong_wq =
-			&get_cpu_var(fscache_object_cong_wait);
-
-		if (queue_work(fscache_object_wq, &object->work)) {
-			if (fscache_object_congested())
-				wake_up(cong_wq);
-		} else
-			fscache_put_object(object, fscache_obj_put_queue);
-
-		put_cpu_var(fscache_object_cong_wait);
-	}
-}
-
-/**
- * fscache_object_sleep_till_congested - Sleep until object wq is congested
- * @timeoutp: Scheduler sleep timeout
- *
- * Allow an object handler to sleep until the object workqueue is congested.
- *
- * The caller must set up a wake up event before calling this and must have set
- * the appropriate sleep mode (such as TASK_UNINTERRUPTIBLE) and tested its own
- * condition before calling this function as no test is made here.
- *
- * %true is returned if the object wq is congested, %false otherwise.
- */
-bool fscache_object_sleep_till_congested(signed long *timeoutp)
-{
-	wait_queue_head_t *cong_wq = this_cpu_ptr(&fscache_object_cong_wait);
-	DEFINE_WAIT(wait);
-
-	if (fscache_object_congested())
-		return true;
-
-	add_wait_queue_exclusive(cong_wq, &wait);
-	if (!fscache_object_congested())
-		*timeoutp = schedule_timeout(*timeoutp);
-	finish_wait(cong_wq, &wait);
-
-	return fscache_object_congested();
-}
-EXPORT_SYMBOL_GPL(fscache_object_sleep_till_congested);
-
-/*
- * Enqueue the dependents of an object for metadata-type processing.
- *
- * If we don't manage to finish the list before the scheduler wants to run
- * again then return false immediately.  We return true if the list was
- * cleared.
- */
-static bool fscache_enqueue_dependents(struct fscache_object *object, int event)
-{
-	struct fscache_object *dep;
-	bool ret = true;
-
-	_enter("{OBJ%x}", object->debug_id);
-
-	if (list_empty(&object->dependents))
-		return true;
-
-	spin_lock(&object->lock);
-
-	while (!list_empty(&object->dependents)) {
-		dep = list_entry(object->dependents.next,
-				 struct fscache_object, dep_link);
-		list_del_init(&dep->dep_link);
-
-		fscache_raise_event(dep, event);
-		fscache_put_object(dep, fscache_obj_put_enq_dep);
-
-		if (!list_empty(&object->dependents) && need_resched()) {
-			ret = false;
-			break;
-		}
-	}
-
-	spin_unlock(&object->lock);
-	return ret;
-}
-
-/*
- * remove an object from whatever queue it's waiting on
- */
-static void fscache_dequeue_object(struct fscache_object *object)
-{
-	_enter("{OBJ%x}", object->debug_id);
-
-	if (!list_empty(&object->dep_link)) {
-		spin_lock(&object->parent->lock);
-		list_del_init(&object->dep_link);
-		spin_unlock(&object->parent->lock);
-	}
-
-	_leave("");
-}
-
-static const struct fscache_state *fscache_invalidate_object(struct fscache_object *object,
-							     int event)
-{
-	return transit_to(UPDATE_OBJECT);
-}
-
-/*
- * Update auxiliary data.
- */
-static void fscache_update_aux_data(struct fscache_object *object)
-{
-	fscache_stat(&fscache_n_updates_run);
-	fscache_stat(&fscache_n_cop_update_object);
-	object->cache->ops->update_object(object);
-	fscache_stat_d(&fscache_n_cop_update_object);
-}
-
-/*
- * Asynchronously update an object.
- */
-static const struct fscache_state *fscache_update_object(struct fscache_object *object,
-							 int event)
-{
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	fscache_update_aux_data(object);
-
-	_leave("");
-	return transit_to(WAIT_FOR_CMD);
-}
-
-/**
- * fscache_object_retrying_stale - Note retrying stale object
- * @object: The object that will be retried
- *
- * Note that an object lookup found an on-disk object that was adjudged to be
- * stale and has been deleted.  The lookup will be retried.
- */
-void fscache_object_retrying_stale(struct fscache_object *object)
-{
-	fscache_stat(&fscache_n_cache_no_space_reject);
-}
-EXPORT_SYMBOL(fscache_object_retrying_stale);
-
-/**
- * fscache_object_mark_killed - Note that an object was killed
- * @object: The object that was culled
- * @why: The reason the object was killed.
- *
- * Note that an object was killed.  Returns true if the object was
- * already marked killed, false if it wasn't.
- */
-void fscache_object_mark_killed(struct fscache_object *object,
-				enum fscache_why_object_killed why)
-{
-	if (test_and_set_bit(FSCACHE_OBJECT_KILLED_BY_CACHE, &object->flags)) {
-		pr_err("Error: Object already killed by cache [%s]\n",
-		       object->cache->identifier);
-		return;
-	}
-
-	switch (why) {
-	case FSCACHE_OBJECT_NO_SPACE:
-		fscache_stat(&fscache_n_cache_no_space_reject);
-		break;
-	case FSCACHE_OBJECT_IS_STALE:
-		fscache_stat(&fscache_n_cache_stale_objects);
-		break;
-	case FSCACHE_OBJECT_WAS_RETIRED:
-		fscache_stat(&fscache_n_cache_retired_objects);
-		break;
-	case FSCACHE_OBJECT_WAS_CULLED:
-		fscache_stat(&fscache_n_cache_culled_objects);
-		break;
-	}
-}
-EXPORT_SYMBOL(fscache_object_mark_killed);
-
-/*
- * The object is dead.  We can get here if an object gets queued by an event
- * that would lead to its death (such as EV_KILL) when the dispatcher is
- * already running (and so can be requeued) but hasn't yet cleared the event
- * mask.
- */
-static const struct fscache_state *fscache_object_dead(struct fscache_object *object,
-						       int event)
-{
-	if (!test_and_set_bit(FSCACHE_OBJECT_RUN_AFTER_DEAD,
-			      &object->flags))
-		return NO_TRANSIT;
-
-	WARN(true, "FS-Cache object redispatched after death");
-	return NO_TRANSIT;
-}
diff --git a/fs/fscache/object_bits.c b/fs/fscache/object_bits.c
new file mode 100644
index 000000000000..5316d7d33ce0
--- /dev/null
+++ b/fs/fscache/object_bits.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Miscellaneous object routines.
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * See Documentation/filesystems/caching/netfs-api.txt for more information on
+ * the netfs API.
+ */
+
+#define FSCACHE_DEBUG_LEVEL OBJECT
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+static atomic_t fscache_object_debug_id;
+
+/**
+ * fscache_object_init - Initialise a cache object description
+ * @object: Object description
+ * @cookie: Cookie object will be attached to
+ * @cache: Cache in which backing object will be found
+ *
+ * Initialise a cache object description to its basic values.
+ *
+ * See Documentation/filesystems/caching/backend-api.txt for a complete
+ * description.
+ */
+void fscache_object_init(struct fscache_object *object,
+			 struct fscache_cookie *cookie,
+			 struct fscache_cache *cache)
+{
+	atomic_inc(&cache->object_count);
+
+	spin_lock_init(&object->lock);
+	INIT_LIST_HEAD(&object->cache_link);
+	INIT_HLIST_NODE(&object->cookie_link);
+	object->n_children = 0;
+	object->cache = cache;
+	object->cookie = fscache_cookie_get(cookie, fscache_cookie_get_attach_object);
+	object->parent = NULL;
+#ifdef CONFIG_FSCACHE_OBJECT_LIST
+	RB_CLEAR_NODE(&object->objlist_link);
+#endif
+	object->debug_id = atomic_inc_return(&fscache_object_debug_id);
+}
+EXPORT_SYMBOL(fscache_object_init);
+
+/**
+ * fscache_object_destroy - Note that a cache object is about to be destroyed
+ * @object: The object to be destroyed
+ *
+ * Note the imminent destruction and deallocation of a cache object record.
+ */
+void fscache_object_destroy(struct fscache_object *object)
+{
+	_enter("%u", atomic_read(&object->cache->object_count));
+
+	fscache_objlist_remove(object);
+
+	/* We can get rid of the cookie now */
+	fscache_cookie_put(object->cookie, fscache_cookie_put_object);
+	object->cookie = NULL;
+}
+EXPORT_SYMBOL(fscache_object_destroy);
+
+/**
+ * fscache_object_destroyed - Note destruction of an object in a cache
+ * @cache: The cache from which the object came
+ *
+ * Note the destruction and deallocation of an object record in a cache.
+ */
+void fscache_object_destroyed(struct fscache_cache *cache)
+{
+	_enter("%d", atomic_read(&cache->object_count));
+	if (atomic_dec_and_test(&cache->object_count))
+		wake_up_all(&fscache_cache_cleared_wq);
+}
+EXPORT_SYMBOL(fscache_object_destroyed);
+
+/**
+ * fscache_object_mark_killed - Note that an object was killed
+ * @object: The object that was culled
+ * @why: The reason the object was killed.
+ *
+ * Note that an object was killed.  Returns true if the object was
+ * already marked killed, false if it wasn't.
+ */
+void fscache_object_mark_killed(struct fscache_object *object,
+				enum fscache_why_object_killed why)
+{
+	switch (why) {
+	case FSCACHE_OBJECT_NO_SPACE:
+		fscache_stat(&fscache_n_cache_no_space_reject);
+		break;
+	case FSCACHE_OBJECT_IS_STALE:
+		fscache_stat(&fscache_n_cache_stale_objects);
+		break;
+	case FSCACHE_OBJECT_WAS_RETIRED:
+		fscache_stat(&fscache_n_cache_retired_objects);
+		break;
+	case FSCACHE_OBJECT_WAS_CULLED:
+		fscache_stat(&fscache_n_cache_culled_objects);
+		break;
+	}
+}
+EXPORT_SYMBOL(fscache_object_mark_killed);
+
+/**
+ * fscache_object_retrying_stale - Note retrying stale object
+ * @object: The object that will be retried
+ *
+ * Note that an object lookup found an on-disk object that was adjudged to be
+ * stale and has been deleted.  The lookup will be retried.
+ */
+void fscache_object_retrying_stale(struct fscache_object *object)
+{
+	fscache_stat(&fscache_n_cache_stale_objects);
+}
+EXPORT_SYMBOL(fscache_object_retrying_stale);
diff --git a/fs/fscache/proc.c b/fs/fscache/proc.c
index da51fdfc8641..729d083f1e91 100644
--- a/fs/fscache/proc.c
+++ b/fs/fscache/proc.c
@@ -5,7 +5,7 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
-#define FSCACHE_DEBUG_LEVEL OPERATION
+#define FSCACHE_DEBUG_LEVEL CACHE
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -16,8 +16,6 @@
  */
 int __init fscache_proc_init(void)
 {
-	_enter("");
-
 	if (!proc_mkdir("fs/fscache", NULL))
 		goto error_dir;
 
@@ -43,7 +41,6 @@ int __init fscache_proc_init(void)
 		goto error_objects;
 #endif
 
-	_leave(" = 0");
 	return 0;
 
 #ifdef CONFIG_FSCACHE_OBJECT_LIST
@@ -61,7 +58,6 @@ int __init fscache_proc_init(void)
 error_cookies:
 	remove_proc_entry("fs/fscache", NULL);
 error_dir:
-	_leave(" = -ENOMEM");
 	return -ENOMEM;
 }
 
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index 5b1cec456199..583817f4f113 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -5,7 +5,7 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
-#define FSCACHE_DEBUG_LEVEL THREAD
+#define FSCACHE_DEBUG_LEVEL CACHE
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 8b6aa11dee54..19770160dbb9 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -16,7 +16,6 @@
 
 #include <linux/fscache.h>
 #include <linux/sched.h>
-#include <linux/workqueue.h>
 
 #define NR_MAXCACHES BITS_PER_LONG
 
@@ -25,14 +24,21 @@ struct fscache_cache_ops;
 struct fscache_object;
 
 enum fscache_obj_ref_trace {
-	fscache_obj_get_add_to_deps,
-	fscache_obj_get_queue,
+	fscache_obj_get_attach,
+	fscache_obj_get_exists,
+	fscache_obj_get_inval,
+	fscache_obj_get_wait,
+	fscache_obj_get_withdraw,
+	fscache_obj_new,
+	fscache_obj_put,
+	fscache_obj_put_alloc_dup,
 	fscache_obj_put_alloc_fail,
 	fscache_obj_put_attach_fail,
+	fscache_obj_put_drop_child,
 	fscache_obj_put_drop_obj,
-	fscache_obj_put_enq_dep,
-	fscache_obj_put_queue,
-	fscache_obj_put_work,
+	fscache_obj_put_inval,
+	fscache_obj_put_lookup_fail,
+	fscache_obj_put_withdraw,
 	fscache_obj_ref__nr_traces
 };
 
@@ -80,16 +86,21 @@ struct fscache_cache_ops {
 	const char *name;
 
 	/* allocate an object record for a cookie */
-	struct fscache_object *(*alloc_object)(struct fscache_cache *cache,
-					       struct fscache_cookie *cookie);
+	struct fscache_object *(*alloc_object)(struct fscache_cookie *cookie,
+					       struct fscache_cache *cache,
+					       struct fscache_object *parent);
 
-	/* look up the object for a cookie
-	 * - return -ETIMEDOUT to be requeued
-	 */
-	int (*lookup_object)(struct fscache_object *object);
+	/* Prepare data used in lookup */
+	void *(*prepare_lookup_data)(struct fscache_object *object);
 
-	/* finished looking up */
-	void (*lookup_complete)(struct fscache_object *object);
+	/* Look up the object for a cookie */
+	bool (*lookup_object)(struct fscache_object *object, void *lookup_data);
+
+	/* Create the object for a cookie */
+	bool (*create_object)(struct fscache_object *object, void *lookup_data);
+
+	/* Clean up lookup data */
+	void (*free_lookup_data)(struct fscache_object *object, void *lookup_data);
 
 	/* increment the usage count on this object (may fail if unmounting) */
 	struct fscache_object *(*grab_object)(struct fscache_object *object,
@@ -105,16 +116,19 @@ struct fscache_cache_ops {
 	void (*update_object)(struct fscache_object *object);
 
 	/* Invalidate an object */
-	void (*invalidate_object)(struct fscache_object *object);
+	bool (*invalidate_object)(struct fscache_object *object);
 
 	/* discard the resources pinned by an object and effect retirement if
 	 * necessary */
-	void (*drop_object)(struct fscache_object *object);
+	void (*drop_object)(struct fscache_object *object, bool invalidate);
 
 	/* dispose of a reference to an object */
 	void (*put_object)(struct fscache_object *object,
 			   enum fscache_obj_ref_trace why);
 
+	/* Get object usage count */
+	unsigned int (*get_object_usage)(const struct fscache_object *object);
+
 	/* sync a cache */
 	void (*sync_cache)(struct fscache_cache *cache);
 
@@ -124,74 +138,34 @@ struct fscache_cache_ops {
 
 extern struct fscache_cookie fscache_fsdef_index;
 
-/*
- * Event list for fscache_object::{event_mask,events}
- */
-enum {
-	FSCACHE_OBJECT_EV_NEW_CHILD,	/* T if object has a new child */
-	FSCACHE_OBJECT_EV_PARENT_READY,	/* T if object's parent is ready */
-	FSCACHE_OBJECT_EV_UPDATE,	/* T if object should be updated */
-	FSCACHE_OBJECT_EV_INVALIDATE,	/* T if cache requested object invalidation */
-	FSCACHE_OBJECT_EV_CLEARED,	/* T if accessors all gone */
-	FSCACHE_OBJECT_EV_ERROR,	/* T if fatal error occurred during processing */
-	FSCACHE_OBJECT_EV_KILL,		/* T if netfs relinquished or cache withdrew object */
-	NR_FSCACHE_OBJECT_EVENTS
-};
-
-#define FSCACHE_OBJECT_EVENTS_MASK ((1UL << NR_FSCACHE_OBJECT_EVENTS) - 1)
-
-/*
- * States for object state machine.
- */
-struct fscache_transition {
-	unsigned long events;
-	const struct fscache_state *transit_to;
-};
-
-struct fscache_state {
-	char name[24];
-	char short_name[8];
-	const struct fscache_state *(*work)(struct fscache_object *object,
-					    int event);
-	const struct fscache_transition transitions[];
+enum fscache_object_stage {
+	FSCACHE_OBJECT_STAGE_INITIAL,
+	FSCACHE_OBJECT_STAGE_LOOKING_UP,
+	FSCACHE_OBJECT_STAGE_UNCREATED,		/* Needs creation */
+	FSCACHE_OBJECT_STAGE_LIVE_TEMP,		/* Temporary object created, can be no hits */
+	FSCACHE_OBJECT_STAGE_LIVE_EMPTY,	/* Object was freshly created, can be no hits */
+	FSCACHE_OBJECT_STAGE_LIVE,		/* Object is populated */
+	FSCACHE_OBJECT_STAGE_DESTROYING,
+	FSCACHE_OBJECT_STAGE_DEAD,
 };
 
 /*
  * on-disk cache file or index handle
  */
 struct fscache_object {
-	const struct fscache_state *state;	/* Object state machine state */
-	const struct fscache_transition *oob_table; /* OOB state transition table */
 	int			debug_id;	/* debugging ID */
 	int			n_children;	/* number of child objects */
-	int			n_ops;		/* number of extant ops on object */
-	int			n_obj_ops;	/* number of object ops outstanding on object */
+	enum fscache_object_stage stage;	/* Stage of object's lifecycle */
 	spinlock_t		lock;		/* state and operations lock */
 
-	unsigned long		lookup_jif;	/* time at which lookup started */
-	unsigned long		oob_event_mask;	/* OOB events this object is interested in */
-	unsigned long		event_mask;	/* events this object is interested in */
-	unsigned long		events;		/* events to be processed by this object
-						 * (order is important - using fls) */
-
 	unsigned long		flags;
-#define FSCACHE_OBJECT_LOCK		0	/* T if object is busy being processed */
-#define FSCACHE_OBJECT_WAITING		2	/* T if object is waiting on its parent */
-#define FSCACHE_OBJECT_IS_LIVE		3	/* T if object is not withdrawn or relinquished */
-#define FSCACHE_OBJECT_IS_LOOKED_UP	4	/* T if object has been looked up */
-#define FSCACHE_OBJECT_IS_AVAILABLE	5	/* T if object has become active */
-#define FSCACHE_OBJECT_RETIRED		6	/* T if object was retired on relinquishment */
-#define FSCACHE_OBJECT_KILLED_BY_CACHE	7	/* T if object was killed by the cache */
-#define FSCACHE_OBJECT_RUN_AFTER_DEAD	8	/* T if object has been dispatched after death */
+#define FSCACHE_OBJECT_NEEDS_UPDATE	9	/* T if object attrs need writing to disk */
 
 	struct list_head	cache_link;	/* link in cache->object_list */
 	struct hlist_node	cookie_link;	/* link in cookie->backing_objects */
 	struct fscache_cache	*cache;		/* cache that supplied this object */
 	struct fscache_cookie	*cookie;	/* netfs's file/index object */
 	struct fscache_object	*parent;	/* parent object */
-	struct work_struct	work;		/* attention scheduling record */
-	struct list_head	dependents;	/* FIFO of dependent objects */
-	struct list_head	dep_link;	/* link in parent's dependents list */
 #ifdef CONFIG_FSCACHE_OBJECT_LIST
 	struct rb_node		objlist_link;	/* link in global object list */
 #endif
@@ -201,101 +175,12 @@ extern void fscache_object_init(struct fscache_object *, struct fscache_cookie *
 				struct fscache_cache *);
 extern void fscache_object_destroy(struct fscache_object *);
 
-extern void fscache_object_lookup_negative(struct fscache_object *object);
-extern void fscache_obtained_object(struct fscache_object *object);
-
-static inline bool fscache_object_is_live(struct fscache_object *object)
-{
-	return test_bit(FSCACHE_OBJECT_IS_LIVE, &object->flags);
-}
-
-static inline bool fscache_object_is_dying(struct fscache_object *object)
-{
-	return !fscache_object_is_live(object);
-}
-
-static inline bool fscache_object_is_available(struct fscache_object *object)
-{
-	return test_bit(FSCACHE_OBJECT_IS_AVAILABLE, &object->flags);
-}
-
 static inline bool fscache_cache_is_broken(struct fscache_object *object)
 {
 	return test_bit(FSCACHE_IOERROR, &object->cache->flags);
 }
 
-static inline bool fscache_object_is_active(struct fscache_object *object)
-{
-	return fscache_object_is_available(object) &&
-		fscache_object_is_live(object) &&
-		!fscache_cache_is_broken(object);
-}
-
-/**
- * fscache_object_destroyed - Note destruction of an object in a cache
- * @cache: The cache from which the object came
- *
- * Note the destruction and deallocation of an object record in a cache.
- */
-static inline void fscache_object_destroyed(struct fscache_cache *cache)
-{
-	if (atomic_dec_and_test(&cache->object_count))
-		wake_up_all(&fscache_cache_cleared_wq);
-}
-
-/**
- * fscache_object_lookup_error - Note an object encountered an error
- * @object: The object on which the error was encountered
- *
- * Note that an object encountered a fatal error (usually an I/O error) and
- * that it should be withdrawn as soon as possible.
- */
-static inline void fscache_object_lookup_error(struct fscache_object *object)
-{
-	set_bit(FSCACHE_OBJECT_EV_ERROR, &object->events);
-}
-
-static inline void __fscache_use_cookie(struct fscache_cookie *cookie)
-{
-	atomic_inc(&cookie->n_active);
-}
-
-/**
- * fscache_use_cookie - Request usage of cookie attached to an object
- * @object: Object description
- * 
- * Request usage of the cookie attached to an object.  NULL is returned if the
- * relinquishment had reduced the cookie usage count to 0.
- */
-static inline bool fscache_use_cookie(struct fscache_object *object)
-{
-	struct fscache_cookie *cookie = object->cookie;
-	return atomic_inc_not_zero(&cookie->n_active) != 0;
-}
-
-static inline bool __fscache_unuse_cookie(struct fscache_cookie *cookie)
-{
-	return atomic_dec_and_test(&cookie->n_active);
-}
-
-static inline void __fscache_wake_unused_cookie(struct fscache_cookie *cookie)
-{
-	wake_up_var(&cookie->n_active);
-}
-
-/**
- * fscache_unuse_cookie - Cease usage of cookie attached to an object
- * @object: Object description
- * 
- * Cease usage of the cookie attached to an object.  When the users count
- * reaches zero then the cookie relinquishment will be permitted to proceed.
- */
-static inline void fscache_unuse_cookie(struct fscache_object *object)
-{
-	struct fscache_cookie *cookie = object->cookie;
-	if (__fscache_unuse_cookie(cookie))
-		__fscache_wake_unused_cookie(cookie);
-}
+extern void fscache_object_destroyed(struct fscache_cache *cache);
 
 /*
  * out-of-line cache backend functions
@@ -312,8 +197,6 @@ extern void fscache_withdraw_cache(struct fscache_cache *cache);
 
 extern void fscache_io_error(struct fscache_cache *cache);
 
-extern bool fscache_object_sleep_till_congested(signed long *timeoutp);
-
 extern void fscache_object_retrying_stale(struct fscache_object *object);
 
 enum fscache_why_object_killed {
@@ -347,4 +230,13 @@ static inline void *fscache_get_aux(struct fscache_cookie *cookie)
 		return cookie->aux;
 }
 
+/*
+ * Complete an I/O operation
+ */
+static inline void fscache_end_io_operation(struct fscache_cookie *cookie)
+{
+	if (atomic_dec_and_test(&cookie->n_ops))
+		wake_up_var(&cookie->n_ops);
+}
+
 #endif /* _LINUX_FSCACHE_CACHE_H */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index c62b62938c4d..9d5e0d7ba860 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -31,7 +31,7 @@
 
 /*
  * overload PG_private_2 to give us PG_fscache - this is used to indicate that
- * a page is currently backed by a local disk cache
+ * a page is currently being written to the cache, possibly by direct I/O.
  */
 #define PageFsCache(page)		PagePrivate2((page))
 #define SetPageFsCache(page)		SetPagePrivate2((page))
@@ -52,6 +52,8 @@ enum fscache_cookie_type {
 };
 
 #define FSCACHE_ADV_SINGLE_CHUNK	0x01 /* The object is a single chunk of data */
+#define FSCACHE_ADV_WRITE_CACHE		0x00 /* Do cache if written to locally */
+#define FSCACHE_ADV_WRITE_NOCACHE	0x02 /* Don't cache if written to locally */
 
 /*
  * fscache cached network filesystem type
@@ -64,6 +66,23 @@ struct fscache_netfs {
 	struct fscache_cookie		*primary_index;
 };
 
+/*
+ * Data object state.
+ */
+enum fscache_cookie_stage {
+	FSCACHE_COOKIE_STAGE_INDEX,		/* The cookie is an index cookie */
+	FSCACHE_COOKIE_STAGE_QUIESCENT,		/* The cookie is uncached */
+	FSCACHE_COOKIE_STAGE_INITIALISING,	/* The in-memory structs are being inited */
+	FSCACHE_COOKIE_STAGE_LOOKING_UP,	/* The cache object is being looked up */
+	FSCACHE_COOKIE_STAGE_NO_DATA_YET,	/* The cache has no data, read to network */
+	FSCACHE_COOKIE_STAGE_ACTIVE,		/* The cache is active, readable and writable */
+	FSCACHE_COOKIE_STAGE_INVALIDATING,	/* The cache is being invalidated */
+	FSCACHE_COOKIE_STAGE_FAILED,		/* The cache failed, withdraw to clear */
+	FSCACHE_COOKIE_STAGE_WITHDRAWING,	/* The cache is being withdrawn */
+	FSCACHE_COOKIE_STAGE_RELINQUISHING,	/* The cookie is being relinquished */
+	FSCACHE_COOKIE_STAGE_DROPPED,		/* The cookie has been dropped */
+} __attribute__((mode(byte)));
+
 /*
  * data file or index object cookie
  * - a file will only appear in one cache
@@ -74,7 +93,8 @@ struct fscache_netfs {
 struct fscache_cookie {
 	atomic_t			usage;		/* number of users of this cookie */
 	atomic_t			n_children;	/* number of children of this cookie */
-	atomic_t			n_active;	/* number of active users of netfs ptrs */
+	atomic_t			n_active;	/* number of active users of cookie */
+	atomic_t			n_ops;		/* Number of active ops on this cookie */
 	unsigned int			debug_id;
 	spinlock_t			lock;
 	struct hlist_head		backing_objects; /* object(s) backing this file/index */
@@ -86,19 +106,11 @@ struct fscache_cookie {
 	loff_t				object_size;	/* Size of the netfs object */
 
 	unsigned long			flags;
-#define FSCACHE_COOKIE_LOOKING_UP	0	/* T if non-index cookie being looked up still */
-#define FSCACHE_COOKIE_NO_DATA_YET	1	/* T if new object with no cached data yet */
-#define FSCACHE_COOKIE_UNAVAILABLE	2	/* T if cookie is unavailable (error, etc) */
-#define FSCACHE_COOKIE_INVALIDATING	3	/* T if cookie is being invalidated */
-#define FSCACHE_COOKIE_RELINQUISHED	4	/* T if cookie has been relinquished */
-#define FSCACHE_COOKIE_ENABLED		5	/* T if cookie is enabled */
-#define FSCACHE_COOKIE_ENABLEMENT_LOCK	6	/* T if cookie is being en/disabled */
-#define FSCACHE_COOKIE_AUX_UPDATED	8	/* T if the auxiliary data was updated */
-#define FSCACHE_COOKIE_ACQUIRED		9	/* T if cookie is in use */
-#define FSCACHE_COOKIE_RELINQUISHING	10	/* T if cookie is being relinquished */
+#define FSCACHE_COOKIE_RELINQUISHED	6		/* T if cookie has been relinquished */
 
+	enum fscache_cookie_stage	stage;
 	enum fscache_cookie_type	type:8;
-	u8				advice;		/* FSCACHE_COOKIE_ADV_* */
+	u8				advice;		/* FSCACHE_ADV_* */
 	u8				key_len;	/* Length of index key */
 	u8				aux_len;	/* Length of auxiliary data */
 	u32				key_hash;	/* Hash of parent, type, key, len */
@@ -112,11 +124,6 @@ struct fscache_cookie {
 	};
 };
 
-static inline bool fscache_cookie_enabled(struct fscache_cookie *cookie)
-{
-	return test_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
-}
-
 /*
  * slow-path functions for when there is actually caching available, and the
  * netfs does actually have a valid token
@@ -137,14 +144,12 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 	struct fscache_cache_tag *,
 	const void *, size_t,
 	const void *, size_t,
-	loff_t, bool);
-extern void __fscache_relinquish_cookie(struct fscache_cookie *, const void *, bool);
-extern void __fscache_update_cookie(struct fscache_cookie *, const void *);
+	loff_t);
+extern void __fscache_use_cookie(struct fscache_cookie *, bool);
+extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const loff_t *);
+extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
+extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_invalidate(struct fscache_cookie *);
-extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
-extern void __fscache_disable_cookie(struct fscache_cookie *, const void *, bool);
-extern void __fscache_enable_cookie(struct fscache_cookie *, const void *, loff_t,
-				    bool (*)(void *), void *);
 
 /**
  * fscache_register_netfs - Register a filesystem as desiring caching services
@@ -231,7 +236,6 @@ void fscache_release_cache_tag(struct fscache_cache_tag *tag)
  * @netfs_data: An arbitrary piece of data to be kept in the cookie to
  * represent the cache object to the netfs
  * @object_size: The initial size of object
- * @enable: Whether or not to enable a data cookie immediately
  *
  * This function is used to inform FS-Cache about part of an index hierarchy
  * that can be used to locate files.  This is done by requesting a cookie for
@@ -251,60 +255,92 @@ struct fscache_cookie *fscache_acquire_cookie(
 	size_t index_key_len,
 	const void *aux_data,
 	size_t aux_data_len,
-	loff_t object_size,
-	bool enable)
+	loff_t object_size)
 {
-	if (fscache_cookie_valid(parent) && fscache_cookie_enabled(parent))
+	if (fscache_cookie_valid(parent))
 		return __fscache_acquire_cookie(parent, type, type_name, advice,
 						preferred_cache,
 						index_key, index_key_len,
 						aux_data, aux_data_len,
-						object_size, enable);
+						object_size);
 	else
 		return NULL;
 }
 
+/**
+ * fscache_use_cookie - Request usage of cookie attached to an object
+ * @object: Object description
+ * @will_modify: If cache is expected to be modified locally
+ *
+ * Request usage of the cookie attached to an object.  The caller should tell
+ * the cache if the object's contents are about to be modified locally and then
+ * the cache can apply the policy that has been set to handle this case.
+ */
+static inline void fscache_use_cookie(struct fscache_cookie *cookie,
+				      bool will_modify)
+{
+	if (fscache_cookie_valid(cookie) &&
+	    cookie->type != FSCACHE_COOKIE_TYPE_INDEX)
+		__fscache_use_cookie(cookie, will_modify);
+}
+
+/**
+ * fscache_unuse_cookie - Cease usage of cookie attached to an object
+ * @object: Object description
+ * @aux_data: Updated auxiliary data (or NULL)
+ * @object_size: Revised size of the object (or NULL)
+ *
+ * Cease usage of the cookie attached to an object.  When the users count
+ * reaches zero then the cookie relinquishment will be permitted to proceed.
+ */
+static inline void fscache_unuse_cookie(struct fscache_cookie *cookie,
+					const void *aux_data,
+					const loff_t *object_size)
+{
+	if (fscache_cookie_valid(cookie) &&
+	    cookie->type != FSCACHE_COOKIE_TYPE_INDEX)
+		__fscache_unuse_cookie(cookie, aux_data, object_size);
+}
+
 /**
  * fscache_relinquish_cookie - Return the cookie to the cache, maybe discarding
  * it
  * @cookie: The cookie being returned
- * @aux_data: The updated auxiliary data for the cookie (may be NULL)
  * @retire: True if the cache object the cookie represents is to be discarded
  *
  * This function returns a cookie to the cache, forcibly discarding the
- * associated cache object if retire is set to true.  The opportunity is
- * provided to update the auxiliary data in the cache before the object is
- * disconnected.
+ * associated cache object if retire is set to true.
  *
  * See Documentation/filesystems/caching/netfs-api.rst for a complete
  * description.
  */
 static inline
-void fscache_relinquish_cookie(struct fscache_cookie *cookie,
-			       const void *aux_data,
-			       bool retire)
+void fscache_relinquish_cookie(struct fscache_cookie *cookie, bool retire)
 {
 	if (fscache_cookie_valid(cookie))
-		__fscache_relinquish_cookie(cookie, aux_data, retire);
+		__fscache_relinquish_cookie(cookie, retire);
 }
 
 /**
  * fscache_update_cookie - Request that a cache object be updated
  * @cookie: The cookie representing the cache object
  * @aux_data: The updated auxiliary data for the cookie (may be NULL)
+ * @object_size: The current size of the object (may be NULL)
  *
  * Request an update of the index data for the cache object associated with the
  * cookie.  The auxiliary data on the cookie will be updated first if @aux_data
- * is set.
+ * is set and the object size will be updated and the object possibly trimmed
+ * if @object_size is set.
  *
  * See Documentation/filesystems/caching/netfs-api.rst for a complete
  * description.
  */
 static inline
-void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data)
+void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
+			   const loff_t *object_size)
 {
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		__fscache_update_cookie(cookie, aux_data);
+	if (fscache_cookie_valid(cookie))
+		__fscache_update_cookie(cookie, aux_data, object_size);
 }
 
 /**
@@ -351,79 +387,9 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
  */
 static inline
 void fscache_invalidate(struct fscache_cookie *cookie)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		__fscache_invalidate(cookie);
-}
-
-/**
- * fscache_wait_on_invalidate - Wait for invalidation to complete
- * @cookie: The cookie representing the cache object
- *
- * Wait for the invalidation of an object to complete.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-void fscache_wait_on_invalidate(struct fscache_cookie *cookie)
 {
 	if (fscache_cookie_valid(cookie))
-		__fscache_wait_on_invalidate(cookie);
-}
-
-/**
- * fscache_disable_cookie - Disable a cookie
- * @cookie: The cookie representing the cache object
- * @aux_data: The updated auxiliary data for the cookie (may be NULL)
- * @invalidate: Invalidate the backing object
- *
- * Disable a cookie from accepting further alloc, read, write, invalidate,
- * update or acquire operations.  Outstanding operations can still be waited
- * upon and pages can still be uncached and the cookie relinquished.
- *
- * This will not return until all outstanding operations have completed.
- *
- * If @invalidate is set, then the backing object will be invalidated and
- * detached, otherwise it will just be detached.
- *
- * If @aux_data is set, then auxiliary data will be updated from that.
- */
-static inline
-void fscache_disable_cookie(struct fscache_cookie *cookie,
-			    const void *aux_data,
-			    bool invalidate)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		__fscache_disable_cookie(cookie, aux_data, invalidate);
-}
-
-/**
- * fscache_enable_cookie - Reenable a cookie
- * @cookie: The cookie representing the cache object
- * @aux_data: The updated auxiliary data for the cookie (may be NULL)
- * @object_size: Current size of object
- * @can_enable: A function to permit enablement once lock is held
- * @data: Data for can_enable()
- *
- * Reenable a previously disabled cookie, allowing it to accept further alloc,
- * read, write, invalidate, update or acquire operations.  An attempt will be
- * made to immediately reattach the cookie to a backing object.  If @aux_data
- * is set, the auxiliary data attached to the cookie will be updated.
- *
- * The can_enable() function is called (if not NULL) once the enablement lock
- * is held to rule on whether enablement is still permitted to go ahead.
- */
-static inline
-void fscache_enable_cookie(struct fscache_cookie *cookie,
-			   const void *aux_data,
-			   loff_t object_size,
-			   bool (*can_enable)(void *data),
-			   void *data)
-{
-	if (fscache_cookie_valid(cookie) && !fscache_cookie_enabled(cookie))
-		__fscache_enable_cookie(cookie, aux_data, object_size,
-					can_enable, data);
+		__fscache_invalidate(cookie);
 }
 
 #endif /* _LINUX_FSCACHE_H */
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index c877035c2946..4fedc2e9c428 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -36,14 +36,21 @@ enum cachefiles_obj_ref_trace {
 	E_(FSCACHE_OBJECT_WAS_CULLED,	"was_culled")
 
 #define cachefiles_obj_ref_traces					\
-	EM(fscache_obj_get_add_to_deps,		"GET add_to_deps")	\
-	EM(fscache_obj_get_queue,		"GET queue")		\
+	EM(fscache_obj_get_attach,		"GET attach")		\
+	EM(fscache_obj_get_exists,		"GET exists")		\
+	EM(fscache_obj_get_inval,		"GET inval")		\
+	EM(fscache_obj_get_wait,		"GET wait")		\
+	EM(fscache_obj_get_withdraw,		"GET withdraw")		\
+	EM(fscache_obj_new,			"NEW obj")		\
+	EM(fscache_obj_put,			"PUT general")		\
+	EM(fscache_obj_put_alloc_dup,		"PUT alloc_dup")	\
 	EM(fscache_obj_put_alloc_fail,		"PUT alloc_fail")	\
 	EM(fscache_obj_put_attach_fail,		"PUT attach_fail")	\
+	EM(fscache_obj_put_drop_child,		"PUT drop_child")	\
 	EM(fscache_obj_put_drop_obj,		"PUT drop_obj")		\
-	EM(fscache_obj_put_enq_dep,		"PUT enq_dep")		\
-	EM(fscache_obj_put_queue,		"PUT queue")		\
-	EM(fscache_obj_put_work,		"PUT work")		\
+	EM(fscache_obj_put_inval,		"PUT inval")		\
+	EM(fscache_obj_put_withdraw,		"PUT withdraw")		\
+	EM(fscache_obj_put_lookup_fail,		"PUT lookup_fail")	\
 	EM(cachefiles_obj_put_wait_retry,	"PUT wait_retry")	\
 	E_(cachefiles_obj_put_wait_timeo,	"PUT wait_timeo")
 
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index fb3fdf2921ee..0794900b7ab9 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -24,15 +24,20 @@ enum fscache_cookie_trace {
 	fscache_cookie_discard,
 	fscache_cookie_get_acquire_parent,
 	fscache_cookie_get_attach_object,
-	fscache_cookie_get_reacquire,
+	fscache_cookie_get_hash_collision,
+	fscache_cookie_get_ioreq,
 	fscache_cookie_get_register_netfs,
 	fscache_cookie_get_work,
-	fscache_cookie_put_acquire_nobufs,
+	fscache_cookie_new_acquire,
+	fscache_cookie_new_netfs,
 	fscache_cookie_put_dup_netfs,
-	fscache_cookie_put_relinquish,
+	fscache_cookie_put_hash_collision,
+	fscache_cookie_put_ioreq,
 	fscache_cookie_put_object,
 	fscache_cookie_put_parent,
+	fscache_cookie_put_relinquish,
 	fscache_cookie_put_work,
+	fscache_cookie_see_discard,
 };
 
 #endif
@@ -41,19 +46,22 @@ enum fscache_cookie_trace {
  * Declare tracing information enums and their string mappings for display.
  */
 #define fscache_cookie_traces						\
-	EM(fscache_cookie_collision,		"*COLLISION*")		\
-	EM(fscache_cookie_discard,		"DISCARD")		\
-	EM(fscache_cookie_get_acquire_parent,	"GET prn")		\
-	EM(fscache_cookie_get_attach_object,	"GET obj")		\
-	EM(fscache_cookie_get_reacquire,	"GET raq")		\
-	EM(fscache_cookie_get_register_netfs,	"GET net")		\
-	EM(fscache_cookie_get_work,		"GET wrk")		\
-	EM(fscache_cookie_put_acquire_nobufs,	"PUT nbf")		\
-	EM(fscache_cookie_put_dup_netfs,	"PUT dnt")		\
-	EM(fscache_cookie_put_relinquish,	"PUT rlq")		\
-	EM(fscache_cookie_put_object,		"PUT obj")		\
-	EM(fscache_cookie_put_parent,		"PUT prn")		\
-	E_(fscache_cookie_put_work,		"PUT wrk")
+	EM(fscache_cookie_collision,		"*COLLIDE*")		\
+	EM(fscache_cookie_discard,		"DISCARD  ")		\
+	EM(fscache_cookie_get_acquire_parent,	"GET paren")		\
+	EM(fscache_cookie_get_attach_object,	"GET attch")		\
+	EM(fscache_cookie_get_hash_collision,	"GET hcoll")		\
+	EM(fscache_cookie_get_register_netfs,	"GET rgstr")		\
+	EM(fscache_cookie_get_work,		"GET work ")		\
+	EM(fscache_cookie_new_acquire,		"NEW acq  ")		\
+	EM(fscache_cookie_new_netfs,		"NEW netfs")		\
+	EM(fscache_cookie_put_dup_netfs,	"PUT dupnf")		\
+	EM(fscache_cookie_put_hash_collision,	"PUT hcoll")		\
+	EM(fscache_cookie_put_object,		"PUT obj  ")		\
+	EM(fscache_cookie_put_parent,		"PUT paren")		\
+	EM(fscache_cookie_put_relinquish,	"PUT relnq")		\
+	EM(fscache_cookie_put_work,		"PUT work ")		\
+	E_(fscache_cookie_see_discard,		"SEE discd")
 
 /*
  * Export enum symbols via userspace.
@@ -102,9 +110,10 @@ TRACE_EVENT(fscache_cookie,
 		    __entry->flags	= cookie->flags;
 			   ),
 
-	    TP_printk("%s c=%08x u=%d p=%08x Nc=%d Na=%d f=%02x",
+	    TP_printk("c=%08x %s u=%d p=%08x Nc=%d Na=%d f=%02x",
+		      __entry->cookie,
 		      __print_symbolic(__entry->where, fscache_cookie_traces),
-		      __entry->cookie, __entry->usage,
+		      __entry->usage,
 		      __entry->parent, __entry->n_children, __entry->n_active,
 		      __entry->flags)
 	    );
@@ -189,96 +198,6 @@ TRACE_EVENT(fscache_relinquish,
 		      __entry->flags, __entry->retire)
 	    );
 
-TRACE_EVENT(fscache_enable,
-	    TP_PROTO(struct fscache_cookie *cookie),
-
-	    TP_ARGS(cookie),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(int,			usage		)
-		    __field(int,			n_children	)
-		    __field(int,			n_active	)
-		    __field(u8,				flags		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie	= cookie->debug_id;
-		    __entry->usage	= atomic_read(&cookie->usage);
-		    __entry->n_children	= atomic_read(&cookie->n_children);
-		    __entry->n_active	= atomic_read(&cookie->n_active);
-		    __entry->flags	= cookie->flags;
-			   ),
-
-	    TP_printk("c=%08x u=%d Nc=%d Na=%d f=%02x",
-		      __entry->cookie, __entry->usage,
-		      __entry->n_children, __entry->n_active, __entry->flags)
-	    );
-
-TRACE_EVENT(fscache_disable,
-	    TP_PROTO(struct fscache_cookie *cookie),
-
-	    TP_ARGS(cookie),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(int,			usage		)
-		    __field(int,			n_children	)
-		    __field(int,			n_active	)
-		    __field(u8,				flags		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie	= cookie->debug_id;
-		    __entry->usage	= atomic_read(&cookie->usage);
-		    __entry->n_children	= atomic_read(&cookie->n_children);
-		    __entry->n_active	= atomic_read(&cookie->n_active);
-		    __entry->flags	= cookie->flags;
-			   ),
-
-	    TP_printk("c=%08x u=%d Nc=%d Na=%d f=%02x",
-		      __entry->cookie, __entry->usage,
-		      __entry->n_children, __entry->n_active, __entry->flags)
-	    );
-
-TRACE_EVENT(fscache_osm,
-	    TP_PROTO(struct fscache_object *object,
-		     const struct fscache_state *state,
-		     bool wait, bool oob, s8 event_num),
-
-	    TP_ARGS(object, state, wait, oob, event_num),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		object		)
-		    __array(char,			state, 8	)
-		    __field(bool,			wait		)
-		    __field(bool,			oob		)
-		    __field(s8,				event_num	)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= object->cookie->debug_id;
-		    __entry->object		= object->debug_id;
-		    __entry->wait		= wait;
-		    __entry->oob		= oob;
-		    __entry->event_num		= event_num;
-		    memcpy(__entry->state, state->short_name, 8);
-			   ),
-
-	    TP_printk("c=%08x o=%08d %s %s%sev=%d",
-		      __entry->cookie,
-		      __entry->object,
-		      __entry->state,
-		      __print_symbolic(__entry->wait,
-				       { true,  "WAIT" },
-				       { false, "WORK" }),
-		      __print_symbolic(__entry->oob,
-				       { true,  " OOB " },
-				       { false, " " }),
-		      __entry->event_num)
-	    );
-
 #endif /* _TRACE_FSCACHE_H */
 
 /* This part must be outside protection */


