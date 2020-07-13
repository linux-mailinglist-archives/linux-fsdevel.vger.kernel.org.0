Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0421DD02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgGMQgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:36:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37517 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729751AbgGMQgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594658168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zp0Zx5Rtne2iAp2FELym6VDTOjz+nqoJf2nUNSuz50w=;
        b=Bb8m7WZYcPHU2lg+O6L0avAJ5H66cY0dwKSVXKiPmp+i1nme4bQSDU88I2eHCxvmDlnHjh
        SpXjGbw9iMy7bL+lWgDl870uMn+JjKZO5pvfUyW7k+DzBg2zKQ8A7Bh2mn8b/CCtsa5r6A
        suqJX6wgmtW3psVtvG09xxfB/YXANYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-vEKL5XtbPim6o-hYRlTNDg-1; Mon, 13 Jul 2020 12:36:04 -0400
X-MC-Unique: vEKL5XtbPim6o-hYRlTNDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8FB11009600;
        Mon, 13 Jul 2020 16:36:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7546E5FC34;
        Mon, 13 Jul 2020 16:35:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 28/32] fscache, cachefiles: Rewrite invalidation
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:35:55 +0100
Message-ID: <159465815567.1376674.11728768649953111384.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rewrite the cache object invalidation code in fscache and cachefiles.  The
following changes are made to fscache:

 (1) Invalidation is now ignored or allowed to proceed depending on the
     'stage' a non-index cookie is in with respect to the backing object.

 (2) If invalidation is proceeds, it pins the object and holds an operation
     count  for the duration.

 (3) The fscache_object struct is given an invalidation counter that is
     incremented any time fscache_invalidate() is called, even if the
     cookie is at a stage in which it cannot be applied.  The counter,
     however, can be noted and applied retroactively later.

 (4) The invalidation counter is noted in the operation struct when a cache
     operation is begun and can be checked on operation completion to find
     out if any consequent metadata changes should be dropped.

 (5) New operations aren't allowed to proceed if the object is being
     invalidated.

and to cachefiles:

 (1) If an open object is invalidated, the open backing file is replaced
     with a tmpfile (as if opened O_TMPFILE).  This is held unlinked until
     the object released from memory, at which point the file is simply
     abandoned if it was retired or the old file is unlinked and the new
     one linked into its place.

     Note: This would be easier if linkat() could be given a flag to
     indicate the destination should be overwritten or if RENAME_EXCHANGE
     could be applied to tmpfiles, effectively unlinking the destination.

 (2) Upon invalidation, the content map is replaced with a blank one.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c                |    8 ++-
 fs/cachefiles/content-map.c   |   32 ++++++++++
 fs/cachefiles/interface.c     |  130 ++++++++++++++++++++++++++++++++++-------
 fs/cachefiles/internal.h      |    9 ++-
 fs/cachefiles/namei.c         |   69 ++++++++++++++++++++--
 fs/cachefiles/xattr.c         |    6 +-
 fs/fscache/cookie.c           |   47 +++++++++++++--
 fs/fscache/io.c               |    2 +
 fs/fscache/obj.c              |   31 +++-------
 include/linux/fscache-cache.h |    5 +-
 include/linux/fscache.h       |   15 +++--
 11 files changed, 283 insertions(+), 71 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index b0772e64a844..eab191b9c01d 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -569,7 +569,13 @@ static void afs_zap_data(struct afs_vnode *vnode)
 	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
 #ifdef CONFIG_AFS_FSCACHE
-	fscache_invalidate(vnode->cache, i_size_read(&vnode->vfs_inode));
+	{
+		struct afs_vnode_cache_aux aux = {
+			.data_version = vnode->status.data_version,
+		};
+		fscache_invalidate(afs_vnode_cache(vnode), &aux,
+				   i_size_read(&vnode->vfs_inode), 0);
+	}
 #endif
 
 	/* nuke all the non-dirty pages that aren't locked, mapped or being
diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
index f2a10e8d8d6d..3e310fd58497 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -192,6 +192,34 @@ void cachefiles_shape_request(struct fscache_object *obj,
 	       shape->to_be_done, shape->actual_start, shape->actual_nr_pages);
 }
 
+/*
+ * Allocate a new content map.
+ */
+u8 *cachefiles_new_content_map(struct cachefiles_object *object,
+			       unsigned int *_size)
+{
+	size_t size;
+	u8 *map = NULL;
+
+	_enter("");
+
+	if (!(object->fscache.cookie->advice & FSCACHE_ADV_SINGLE_CHUNK)) {
+		/* Single-chunk object.  The presence or absence of the content
+		 * map xattr is sufficient indication.
+		 */
+		*_size = 0;
+		return NULL;
+	}
+
+	/* Granular object. */
+	size = cachefiles_map_size(object->fscache.cookie->object_size);
+	map = kzalloc(size, GFP_KERNEL);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+	*_size = size;
+	return map;
+}
+
 /*
  * Mark the content map to indicate stored granule.
  */
@@ -205,7 +233,9 @@ void cachefiles_mark_content_map(struct fscache_io_request *req)
 
 	read_lock_bh(&object->content_map_lock);
 
-	if (object->fscache.cookie->advice & FSCACHE_ADV_SINGLE_CHUNK) {
+	if (req->inval_counter != object->fscache.inval_counter) {
+		_debug("inval mark");
+	} else if (object->fscache.cookie->advice & FSCACHE_ADV_SINGLE_CHUNK) {
 		if (pos == 0) {
 			object->content_info = CACHEFILES_CONTENT_SINGLE;
 			set_bit(FSCACHE_OBJECT_NEEDS_UPDATE, &object->fscache.flags);
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 78180d269c5f..76f3a89d3e6c 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -203,7 +203,7 @@ static void cachefiles_update_object(struct fscache_object *_object)
 		}
 	}
 
-	cachefiles_set_object_xattr(object, XATTR_REPLACE);
+	cachefiles_set_object_xattr(object);
 
 out:
 	cachefiles_end_secure(cache, saved_cred);
@@ -213,11 +213,15 @@ static void cachefiles_update_object(struct fscache_object *_object)
 /*
  * Commit changes to the object as we drop it.
  */
-static void cachefiles_commit_object(struct cachefiles_object *object,
+static bool cachefiles_commit_object(struct cachefiles_object *object,
 				     struct cachefiles_cache *cache)
 {
 	if (object->content_map_changed)
 		cachefiles_save_content_map(object);
+
+	if (test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags))
+		return cachefiles_commit_tmpfile(cache, object);
+	return true;
 }
 
 /*
@@ -424,47 +428,127 @@ static int cachefiles_attr_changed(struct cachefiles_object *object)
 }
 
 /*
- * Invalidate an object
+ * Create a temporary file and leave it unattached and un-xattr'd until the
+ * time comes to discard the object from memory.
  */
-static void cachefiles_invalidate_object(struct fscache_object *_object)
+static struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 {
-	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
+	struct file *file;
 	struct path path;
 	uint64_t ni_size;
-	int ret;
+	long ret;
 
-	object = container_of(_object, struct cachefiles_object, fscache);
 	cache = container_of(object->fscache.cache,
 			     struct cachefiles_cache, cache);
 
 	ni_size = object->fscache.cookie->object_size;
 	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
 
+	cachefiles_begin_secure(cache, &saved_cred);
+
+	path.mnt = cache->mnt;
+	path.dentry = vfs_tmpfile(cache->graveyard, S_IFREG, O_RDWR);
+	if (IS_ERR(path.dentry)) {
+		if (PTR_ERR(path.dentry) == -EIO)
+			cachefiles_io_error_obj(object, "Failed to create tmpfile");
+		file = ERR_CAST(path.dentry);
+		goto out;
+	}
+
+	trace_cachefiles_tmpfile(object, d_inode(path.dentry));
+
+	if (ni_size > 0) {
+		trace_cachefiles_trunc(object, d_inode(path.dentry), 0, ni_size);
+		ret = vfs_truncate(&path, ni_size);
+		if (ret < 0) {
+			file = ERR_PTR(ret);
+			goto out_dput;
+		}
+	}
+
+	file = open_with_fake_path(&path,
+				   O_RDWR | O_LARGEFILE | O_DIRECT,
+				   d_backing_inode(path.dentry),
+				   cache->cache_cred);
+out_dput:
+	dput(path.dentry);
+out:
+	cachefiles_end_secure(cache, saved_cred);
+	return file;
+}
+
+/*
+ * Invalidate an object
+ */
+static bool cachefiles_invalidate_object(struct fscache_object *_object,
+					 unsigned int flags)
+{
+	struct cachefiles_object *object;
+	struct file *file, *old_file;
+	u8 *map, *old_map;
+	unsigned int map_size;
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+
 	_enter("{OBJ%x},[%llu]",
-	       object->fscache.debug_id, (unsigned long long)ni_size);
+	       object->fscache.debug_id, _object->cookie->object_size);
+
+	if ((flags & FSCACHE_INVAL_LIGHT) &&
+	    test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
+		_leave(" = t [light]");
+		return true;
+	}
 
 	if (object->dentry) {
 		ASSERT(d_is_reg(object->dentry));
 
-		path.dentry = object->dentry;
-		path.mnt = cache->mnt;
-
-		cachefiles_begin_secure(cache, &saved_cred);
-		ret = vfs_truncate(&path, 0);
-		if (ret == 0)
-			ret = vfs_truncate(&path, ni_size);
-		cachefiles_end_secure(cache, saved_cred);
-
-		if (ret != 0) {
-			if (ret == -EIO)
-				cachefiles_io_error_obj(object,
-							"Invalidate failed");
-		}
+		file = cachefiles_create_tmpfile(object);
+		if (IS_ERR(file))
+			goto failed;
+
+		map = cachefiles_new_content_map(object, &map_size);
+		if (IS_ERR(map))
+			goto failed_fput;
+
+		/* Substitute the VFS target */
+		_debug("sub");
+		dget(file->f_path.dentry); /* Do outside of content_map_lock */
+		spin_lock(&object->fscache.lock);
+		write_lock_bh(&object->content_map_lock);
+
+		if (!object->old)
+			/* Save the dentry carrying the path information */
+			object->old = object->dentry;
+
+		old_file = object->backing_file;
+		old_map = object->content_map;
+		object->backing_file = file;
+		object->dentry = file->f_path.dentry;
+		object->content_info = CACHEFILES_CONTENT_NO_DATA;
+		object->content_map = map;
+		object->content_map_size = map_size;
+		object->content_map_changed = true;
+		set_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
+		set_bit(FSCACHE_OBJECT_NEEDS_UPDATE, &object->fscache.flags);
+
+		write_unlock_bh(&object->content_map_lock);
+		spin_unlock(&object->fscache.lock);
+		_debug("subbed");
+
+		kfree(old_map);
+		fput(old_file);
 	}
 
-	_leave("");
+	_leave(" = t [tmpfile]");
+	return true;
+
+failed_fput:
+	fput(file);
+failed:
+	_leave(" = f");
+	return false;
 }
 
 static unsigned int cachefiles_get_object_usage(const struct fscache_object *_object)
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index c91a9b3c5bd5..ba60fc9dda0a 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -54,6 +54,8 @@ struct cachefiles_object {
 	struct file			*backing_file;	/* File open on backing storage */
 	loff_t				i_size;		/* object size */
 	atomic_t			usage;		/* object usage count */
+	unsigned long			flags;
+#define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Object has a tmpfile that need linking */
 	uint8_t				type;		/* object type */
 	bool				new;		/* T if object new */
 
@@ -127,6 +129,7 @@ extern void cachefiles_daemon_unbind(struct cachefiles_cache *cache);
  */
 extern void cachefiles_shape_request(struct fscache_object *object,
 				     struct fscache_request_shape *shape);
+extern u8 *cachefiles_new_content_map(struct cachefiles_object *object, unsigned int *_size);
 extern void cachefiles_mark_content_map(struct fscache_io_request *req);
 extern void cachefiles_expand_content_map(struct cachefiles_object *object, loff_t size);
 extern void cachefiles_shorten_content_map(struct cachefiles_object *object, loff_t new_size);
@@ -185,6 +188,9 @@ extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 extern int cachefiles_check_in_use(struct cachefiles_cache *cache,
 				   struct dentry *dir, char *filename);
 
+extern bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
+				      struct cachefiles_object *object);
+
 /*
  * proc.c
  */
@@ -237,8 +243,7 @@ static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
  * xattr.c
  */
 extern int cachefiles_check_object_type(struct cachefiles_object *object);
-extern int cachefiles_set_object_xattr(struct cachefiles_object *object,
-				       unsigned int xattr_flags);
+extern int cachefiles_set_object_xattr(struct cachefiles_object *object);
 extern int cachefiles_check_auxdata(struct cachefiles_object *object);
 extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 					  struct dentry *dentry);
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 3dc64ae5dde8..e63ee4b88268 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -468,7 +468,7 @@ bool cachefiles_walk_to_object(struct cachefiles_object *parent,
 
 	if (object->new) {
 		/* attach data to a newly constructed terminal object */
-		ret = cachefiles_set_object_xattr(object, XATTR_CREATE);
+		ret = cachefiles_set_object_xattr(object);
 		if (ret < 0)
 			goto check_error;
 	} else {
@@ -487,8 +487,6 @@ bool cachefiles_walk_to_object(struct cachefiles_object *parent,
 				pr_warn("cachefiles: Block size too large\n");
 				goto check_error;
 			}
-
-			object->old = dget(object->dentry);
 		} else {
 			BUG(); // TODO: open file in data-class subdir
 		}
@@ -523,9 +521,7 @@ bool cachefiles_walk_to_object(struct cachefiles_object *parent,
 		cachefiles_unmark_inode_in_use(object, object->dentry);
 	cachefiles_mark_object_inactive(cache, object);
 	dput(object->dentry);
-	dput(object->old);
 	object->dentry = NULL;
-	object->old = NULL;
 	goto error_out;
 
 lookup_error:
@@ -811,3 +807,66 @@ int cachefiles_check_in_use(struct cachefiles_cache *cache, struct dentry *dir,
 	//_leave(" = 0");
 	return ret;
 }
+
+/*
+ * Attempt to link a temporary file into its rightful place in the cache.
+ */
+bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
+			       struct cachefiles_object *object)
+{
+	struct dentry *dir, *dentry, *old;
+	char *name;
+	unsigned int namelen;
+	bool success = false;
+	int ret;
+
+	_enter(",%pd", object->old);
+
+	namelen = object->old->d_name.len;
+	name = kmemdup_nul(object->old->d_name.name, namelen, GFP_KERNEL);
+	if (!name)
+		goto out;
+
+	dir = dget_parent(object->old);
+
+	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+	ret = cachefiles_bury_object(cache, object, dir, object->old,
+				     FSCACHE_OBJECT_IS_STALE);
+	dput(object->old);
+	object->old = NULL;
+	if (ret < 0 && ret != -ENOENT) {
+		_debug("bury fail %d", ret);
+		goto out_name;
+	}
+
+	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+	dentry = lookup_one_len(name, dir, namelen);
+	if (IS_ERR(dentry)) {
+		_debug("lookup fail %ld", PTR_ERR(dentry));
+		goto out_unlock;
+	}
+
+	ret = vfs_link(object->dentry, d_inode(dir), dentry, NULL);
+	if (ret < 0) {
+		_debug("link fail %d", ret);
+		dput(dentry);
+	} else {
+		trace_cachefiles_link(object, d_inode(object->dentry));
+		spin_lock(&object->fscache.lock);
+		old = object->dentry;
+		object->dentry = dentry;
+		success = true;
+		clear_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
+		spin_unlock(&object->fscache.lock);
+		dput(old);
+	}
+
+out_unlock:
+	inode_unlock(d_inode(dir));
+out_name:
+	kfree(name);
+	dput(dir);
+out:
+	_leave(" = %u", success);
+	return success;
+}
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index a1d4a3d1db69..22c56ca2fd0b 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -104,8 +104,7 @@ int cachefiles_check_object_type(struct cachefiles_object *object)
 /*
  * set the state xattr on a cache file
  */
-int cachefiles_set_object_xattr(struct cachefiles_object *object,
-				unsigned int xattr_flags)
+int cachefiles_set_object_xattr(struct cachefiles_object *object)
 {
 	struct cachefiles_xattr *buf;
 	struct dentry *dentry = object->dentry;
@@ -129,8 +128,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object,
 		memcpy(buf->data, fscache_get_aux(object->fscache.cookie), len);
 
 	ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
-			   buf, sizeof(struct cachefiles_xattr) + len,
-			   xattr_flags);
+			   buf, sizeof(struct cachefiles_xattr) + len, 0);
 	if (ret < 0) {
 		trace_cachefiles_coherency(object, d_inode(dentry)->i_ino,
 					   buf->content,
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 2d9d147411cd..fc93f4b69198 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -472,10 +472,14 @@ void fscache_set_cookie_stage(struct fscache_cookie *cookie,
 }
 
 /*
- * Invalidate an object.  Callable with spinlocks held.
+ * Invalidate an object.
  */
-void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
+void __fscache_invalidate(struct fscache_cookie *cookie,
+			  const void *aux_data, loff_t new_size,
+			  unsigned int flags)
 {
+	struct fscache_object *object = NULL;
+
 	_enter("{%s}", cookie->type_name);
 
 	fscache_stat(&fscache_n_invalidates);
@@ -488,13 +492,42 @@ void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
 	ASSERTCMP(cookie->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
 
 	spin_lock(&cookie->lock);
-	cookie->object_size = new_size;
+	fscache_update_aux(cookie, aux_data, &new_size);
 	cookie->zero_point = new_size;
-	spin_unlock(&cookie->lock);
 
-	if (!hlist_empty(&cookie->backing_objects) &&
-	    test_and_set_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
-		fscache_dispatch(cookie, NULL, 0, fscache_invalidate_object);
+	if (!hlist_empty(&cookie->backing_objects)) {
+		object = hlist_entry(cookie->backing_objects.first,
+				     struct fscache_object, cookie_link);
+		object->inval_counter++;
+	}
+
+	switch (cookie->stage) {
+	case FSCACHE_COOKIE_STAGE_QUIESCENT:
+	case FSCACHE_COOKIE_STAGE_DEAD:
+	case FSCACHE_COOKIE_STAGE_INITIALISING: /* Assume later checks will catch it */
+	case FSCACHE_COOKIE_STAGE_INVALIDATING: /* is_still_valid will catch it */
+		spin_unlock(&cookie->lock);
+		_leave(" [no %u]", cookie->stage);
+		return;
+
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+		spin_unlock(&cookie->lock);
+		_leave(" [look %x]", object->inval_counter);
+		return;
+
+	case FSCACHE_COOKIE_STAGE_NO_DATA_YET:
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		cookie->stage = FSCACHE_COOKIE_STAGE_INVALIDATING;
+		wake_up_var(&cookie->stage);
+
+		atomic_inc(&cookie->n_ops);
+		object->cache->ops->grab_object(object, fscache_obj_get_inval);
+		spin_unlock(&cookie->lock);
+
+		fscache_dispatch(cookie, object, flags, fscache_invalidate_object);
+		_leave(" [inv]");
+		return;
+	}
 }
 EXPORT_SYMBOL(__fscache_invalidate);
 
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index d38101d77d27..1885cfbe7f04 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -84,6 +84,8 @@ static struct fscache_object *fscache_begin_io_operation(
 		goto not_live;
 
 	object->cache->ops->grab_object(object, fscache_obj_get_ioreq);
+	if (req)
+		req->inval_counter = object->inval_counter;
 
 	atomic_inc(&cookie->n_ops);
 	spin_unlock(&cookie->lock);
diff --git a/fs/fscache/obj.c b/fs/fscache/obj.c
index baab7c465142..a7064a4cb486 100644
--- a/fs/fscache/obj.c
+++ b/fs/fscache/obj.c
@@ -241,32 +241,21 @@ void fscache_lookup_object(struct fscache_cookie *cookie,
 }
 
 /*
- * Invalidate an object
+ * Invalidate an object.  param passes the invalidation flags.
  */
 void fscache_invalidate_object(struct fscache_cookie *cookie,
-			       struct fscache_object *unused, int param)
+			       struct fscache_object *object, int flags)
 {
-	struct fscache_object *object = NULL;
+	bool success;
 
-	spin_lock(&cookie->lock);
-
-	if (!hlist_empty(&cookie->backing_objects)) {
-		object = hlist_entry(cookie->backing_objects.first,
-				     struct fscache_object,
-				     cookie_link);
-		object = object->cache->ops->grab_object(object,
-							 fscache_obj_get_inval);
-	}
-
-	spin_unlock(&cookie->lock);
-
-	if (object) {
-		object->cache->ops->invalidate_object(object);
-		fscache_do_put_object(object, fscache_obj_put_inval);
-	}
+	success = object->cache->ops->invalidate_object(object, flags);
+	fscache_do_put_object(object, fscache_obj_put_inval);
 
-	clear_bit_unlock(FSCACHE_COOKIE_INVALIDATING, &cookie->flags);
-	wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
+	if (success)
+		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_NO_DATA_YET);
+	else
+		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_DEAD);
+	fscache_end_io_operation(cookie);
 }
 
 /*
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 1357c44d371b..da85eb15b3c9 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -120,7 +120,8 @@ struct fscache_cache_ops {
 	void (*update_object)(struct fscache_object *object);
 
 	/* Invalidate an object */
-	void (*invalidate_object)(struct fscache_object *object);
+	bool (*invalidate_object)(struct fscache_object *object,
+				  unsigned int flags);
 
 	/* discard the resources pinned by an object and effect retirement if
 	 * necessary */
@@ -176,10 +177,12 @@ enum fscache_object_stage {
 struct fscache_object {
 	int			debug_id;	/* debugging ID */
 	int			n_children;	/* number of child objects */
+	unsigned int		inval_counter;	/* Number of invalidations applied */
 	enum fscache_object_stage stage;	/* Stage of object's lifecycle */
 	spinlock_t		lock;		/* state and operations lock */
 
 	unsigned long		flags;
+#define FSCACHE_OBJECT_NEEDS_INVAL	8	/* T if object needs invalidation */
 #define FSCACHE_OBJECT_NEEDS_UPDATE	9	/* T if object attrs need writing to disk */
 
 	struct list_head	cache_link;	/* link in cache->object_list */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 0aee6edef672..c313950afd8a 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -57,6 +57,8 @@ enum fscache_cookie_type {
 #define FSCACHE_ADV_WRITE_CACHE		0x00 /* Do cache if written to locally */
 #define FSCACHE_ADV_WRITE_NOCACHE	0x02 /* Don't cache if written to locally */
 
+#define FSCACHE_INVAL_LIGHT		0x01 /* Don't re-invalidate if temp object */
+
 /*
  * fscache cached network filesystem type
  * - name, version and ops must be filled in before registration
@@ -105,7 +107,6 @@ struct fscache_cookie {
 	loff_t				zero_point;	/* Size after which no data on server */
 
 	unsigned long			flags;
-#define FSCACHE_COOKIE_INVALIDATING	4	/* T if cookie is being invalidated */
 #define FSCACHE_COOKIE_ACQUIRED		5	/* T if cookie is in use */
 #define FSCACHE_COOKIE_RELINQUISHED	6	/* T if cookie has been relinquished */
 
@@ -178,6 +179,7 @@ struct fscache_io_request {
 	loff_t			len;		/* Size of the I/O */
 	loff_t			transferred;	/* Amount of data transferred */
 	short			error;		/* 0 or error that occurred */
+	unsigned int		inval_counter;	/* object->inval_counter at begin_op */
 	unsigned long		flags;
 #define FSCACHE_IO_DATA_FROM_SERVER	0	/* Set if data was read from server */
 #define FSCACHE_IO_DATA_FROM_CACHE	1	/* Set if data was read from the cache */
@@ -230,7 +232,7 @@ extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_shape_request(struct fscache_cookie *, struct fscache_request_shape *);
-extern void __fscache_invalidate(struct fscache_cookie *, loff_t);
+extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t, unsigned int);
 extern void __fscache_init_io_request(struct fscache_io_request *,
 				      struct fscache_cookie *);
 extern void __fscache_free_io_request(struct fscache_io_request *);
@@ -461,22 +463,23 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
 /**
  * fscache_invalidate - Notify cache that an object needs invalidation
  * @cookie: The cookie representing the cache object
+ * @aux_data: The updated auxiliary data for the cookie (may be NULL)
  * @size: The revised size of the object.
+ * @flags: Invalidation flags (FSCACHE_INVAL_*)
  *
  * Notify the cache that an object is needs to be invalidated and that it
  * should abort any retrievals or stores it is doing on the cache.  The object
  * is then marked non-caching until such time as the invalidation is complete.
  *
- * This can be called with spinlocks held.
- *
  * See Documentation/filesystems/caching/netfs-api.rst for a complete
  * description.
  */
 static inline
-void fscache_invalidate(struct fscache_cookie *cookie, loff_t size)
+void fscache_invalidate(struct fscache_cookie *cookie,
+			const void *aux_data, loff_t size, unsigned int flags)
 {
 	if (fscache_cookie_valid(cookie))
-		__fscache_invalidate(cookie, size);
+		__fscache_invalidate(cookie, aux_data, size, flags);
 }
 
 /**


