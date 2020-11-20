Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E78F2BAE2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgKTPNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728242AbgKTPNp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLsfHIAZ2NpC9Yp7pCQAyh0mYl0RZEvHJ8U8JSNhZ1I=;
        b=I9XwE/An1h7ym8hSSiHJ0oMAVjf3s0J8XvjicUa+v0lwwG+h5R0qfmU0nhP8DKjcYFw+fS
        +5ekYsMqraGEZOSE/oOVFCd1Mg4T0Qt70XQUMaDUY1jQM6Pyv5VUaTJhPnq36fryk+YlSl
        h8iQXq07XCVfJk4yOz4QyD4W4xgm4yM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-uGgk-OiBOkSNp3VH58vjXQ-1; Fri, 20 Nov 2020 10:13:40 -0500
X-MC-Unique: uGgk-OiBOkSNp3VH58vjXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2336A801B1E;
        Fri, 20 Nov 2020 15:13:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA79860853;
        Fri, 20 Nov 2020 15:13:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 51/76] fscache, cachefiles: Rewrite invalidation
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
Date:   Fri, 20 Nov 2020 15:13:27 +0000
Message-ID: <160588520789.3465195.15242944688760722625.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

 fs/afs/inode.c                 |    8 ++
 fs/cachefiles/content-map.c    |   38 ++++++++++-
 fs/cachefiles/interface.c      |  133 +++++++++++++++++++++++++++++++++-------
 fs/cachefiles/internal.h       |   12 +++-
 fs/cachefiles/io.c             |   17 ++++-
 fs/cachefiles/namei.c          |   69 +++++++++++++++++++--
 fs/cachefiles/xattr.c          |    6 +-
 fs/fscache/cookie.c            |   22 +++++--
 fs/fscache/io.c                |    1 
 fs/fscache/obj.c               |   25 ++------
 include/linux/fscache-cache.h  |    5 +-
 include/linux/fscache.h        |   20 +++++-
 include/trace/events/fscache.h |   19 ++++++
 13 files changed, 299 insertions(+), 76 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 0ba2815f8152..3930f051f39a 100644
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
index 4c8dc11d2d4c..da0a81e3f751 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -204,21 +204,47 @@ enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *sub
 	return NETFS_READ_FROM_CACHE;
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
 void cachefiles_mark_content_map(struct cachefiles_object *object,
-				 loff_t start, loff_t len)
+				 loff_t start, loff_t len,
+				 unsigned int inval_counter)
 {
 	_enter("%llx", start);
 
 	read_lock_bh(&object->content_map_lock);
 
-	if (object->fscache.cookie->advice & FSCACHE_ADV_SINGLE_CHUNK) {
-		if (start == 0) {
-			object->content_info = CACHEFILES_CONTENT_SINGLE;
-			set_bit(FSCACHE_OBJECT_NEEDS_UPDATE, &object->fscache.flags);
-		}
+	if (object->fscache.inval_counter != inval_counter) {
+		_debug("inval mark");
 	} else {
 		pgoff_t granule;
 		loff_t end = start + len;
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index c083d9833b87..4da10640611c 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -201,7 +201,7 @@ static void cachefiles_update_object(struct fscache_object *_object)
 		}
 	}
 
-	cachefiles_set_object_xattr(object, XATTR_REPLACE);
+	cachefiles_set_object_xattr(object);
 
 out:
 	cachefiles_end_secure(cache, saved_cred);
@@ -211,11 +211,15 @@ static void cachefiles_update_object(struct fscache_object *_object)
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
@@ -422,48 +426,133 @@ static int cachefiles_attr_changed(struct cachefiles_object *object)
 }
 
 /*
- * Invalidate an object
+ * Create a temporary file and leave it unattached and un-xattr'd until the
+ * time comes to discard the object from memory.
  */
-static bool cachefiles_invalidate_object(struct fscache_object *_object)
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
+	struct dentry *old_dentry;
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
-			return false;
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
+		if (!object->old) {
+			/* Save the dentry carrying the path information */
+			object->old = object->dentry;
+			old_dentry = NULL;
+		} else {
+			old_dentry = object->dentry;
 		}
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
+		dput(old_dentry);
 	}
 
+	_leave(" = t [tmpfile]");
 	return true;
+
+failed_fput:
+	fput(file);
+failed:
+	_leave(" = f");
+	return false;
 }
 
 static unsigned int cachefiles_get_object_usage(const struct fscache_object *_object)
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index b58177f65135..af68564598d5 100644
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
 
@@ -129,8 +131,10 @@ extern void cachefiles_expand_readahead(struct fscache_op_resources *opr,
 					loff_t *_start, size_t *_len, loff_t i_size);
 extern enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *subreq,
 						      loff_t i_size);
+extern u8 *cachefiles_new_content_map(struct cachefiles_object *object,
+				      unsigned int *_size);
 extern void cachefiles_mark_content_map(struct cachefiles_object *object,
-					loff_t start, loff_t len);
+					loff_t start, loff_t len, unsigned int inval_counter);
 extern void cachefiles_expand_content_map(struct cachefiles_object *object, loff_t size);
 extern void cachefiles_shorten_content_map(struct cachefiles_object *object, loff_t new_size);
 extern bool cachefiles_load_content_map(struct cachefiles_object *object);
@@ -195,6 +199,9 @@ extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 extern int cachefiles_check_in_use(struct cachefiles_cache *cache,
 				   struct dentry *dir, char *filename);
 
+extern bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
+				      struct cachefiles_object *object);
+
 /*
  * proc.c
  */
@@ -247,8 +254,7 @@ static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
  * xattr.c
  */
 extern int cachefiles_check_object_type(struct cachefiles_object *object);
-extern int cachefiles_set_object_xattr(struct cachefiles_object *object,
-				       unsigned int xattr_flags);
+extern int cachefiles_set_object_xattr(struct cachefiles_object *object);
 extern int cachefiles_check_auxdata(struct cachefiles_object *object);
 extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 					  struct dentry *dentry);
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 1060c1c57008..3ad62a39133e 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -17,6 +17,7 @@
 struct cachefiles_kiocb {
 	struct kiocb		iocb;
 	refcount_t		ki_refcnt;
+	unsigned int		inval_counter;
 	loff_t			start;
 	union {
 		size_t		skipped;
@@ -46,10 +47,15 @@ static void cachefiles_read_complete(struct kiocb *iocb, long ret, long ret2)
 	_enter("%ld,%ld", ret, ret2);
 
 	if (ki->term_func) {
-		if (ret < 0)
+		if (ret < 0) {
 			ki->term_func(ki->term_func_priv, ret);
-		else
-			ki->term_func(ki->term_func_priv, ki->skipped + ret);
+		} else {
+			if (ki->object->fscache.inval_counter == ki->inval_counter)
+				ki->skipped += ret;
+			else
+				ret = -ESTALE;
+			ki->term_func(ki->term_func_priv, ret);
+		}
 	}
 
 	fscache_uncount_io_operation(ki->object->fscache.cookie);
@@ -126,6 +132,7 @@ int cachefiles_read(struct fscache_op_resources *opr,
 	ki->iocb.ki_flags	= IOCB_DIRECT;
 	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
 	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->inval_counter	= opr->inval_counter;
 	ki->skipped		= skipped;
 	ki->object		= object;
 	ki->term_func		= term_func;
@@ -197,7 +204,8 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret, long ret2)
 			ki->term_func(ki->term_func_priv, ret);
 	} else {
 		if (ret == ki->len)
-			cachefiles_mark_content_map(ki->object, ki->start, ki->len);
+			cachefiles_mark_content_map(ki->object, ki->start, ki->len,
+						    ki->inval_counter);
 		if (ki->term_func)
 			ki->term_func(ki->term_func_priv, ret);
 	}
@@ -246,6 +254,7 @@ int cachefiles_write(struct fscache_op_resources *opr,
 	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
 	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
 	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->inval_counter	= opr->inval_counter;
 	ki->start		= start_pos;
 	ki->len			= len;
 	ki->object		= object;
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 9f6c91cff55d..69a7ce9a62c3 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -466,7 +466,7 @@ bool cachefiles_walk_to_object(struct cachefiles_object *parent,
 
 	if (object->new) {
 		/* attach data to a newly constructed terminal object */
-		ret = cachefiles_set_object_xattr(object, XATTR_CREATE);
+		ret = cachefiles_set_object_xattr(object);
 		if (ret < 0)
 			goto check_error;
 	} else {
@@ -485,8 +485,6 @@ bool cachefiles_walk_to_object(struct cachefiles_object *parent,
 				pr_warn("cachefiles: Block size too large\n");
 				goto check_error;
 			}
-
-			object->old = dget(object->dentry);
 		} else {
 			BUG(); // TODO: open file in data-class subdir
 		}
@@ -521,9 +519,7 @@ bool cachefiles_walk_to_object(struct cachefiles_object *parent,
 		cachefiles_unmark_inode_in_use(object, object->dentry);
 	cachefiles_mark_object_inactive(cache, object);
 	dput(object->dentry);
-	dput(object->old);
 	object->dentry = NULL;
-	object->old = NULL;
 	goto error_out;
 
 lookup_error:
@@ -807,3 +803,66 @@ int cachefiles_check_in_use(struct cachefiles_cache *cache, struct dentry *dir,
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
index cbd43855dc0d..991ecda1f140 100644
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
index 8d8aba14912a..1b30b28f7cf6 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -531,9 +531,11 @@ void fscache_set_cookie_stage(struct fscache_cookie *cookie,
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
 	struct fscache_object *object = NULL;
 
@@ -541,6 +543,10 @@ void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
 
 	fscache_stat(&fscache_n_invalidates);
 
+	if (WARN(test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags),
+		 "Trying to invalidate relinquished cookie\n"))
+		return;
+
 	/* Only permit invalidation of data files.  Invalidating an index will
 	 * require the caller to release all its attachments to the tree rooted
 	 * there, and if it's doing that, it may as well just retire the
@@ -549,12 +555,16 @@ void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
 	ASSERTCMP(cookie->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
 
 	spin_lock(&cookie->lock);
-	cookie->object_size = new_size;
+	fscache_update_aux(cookie, aux_data, &new_size);
 	cookie->zero_point = new_size;
 
-	if (!hlist_empty(&cookie->backing_objects))
+	trace_fscache_invalidate(cookie, new_size);
+
+	if (!hlist_empty(&cookie->backing_objects)) {
 		object = hlist_entry(cookie->backing_objects.first,
 				     struct fscache_object, cookie_link);
+		object->inval_counter++;
+	}
 
 	switch (cookie->stage) {
 	case FSCACHE_COOKIE_STAGE_INITIALISING: /* Assume later checks will catch it */
@@ -566,7 +576,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
 
 	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
 		spin_unlock(&cookie->lock);
-		_leave(" [look]");
+		_leave(" [look %x]", object->inval_counter);
 		return;
 
 	case FSCACHE_COOKIE_STAGE_NO_DATA_YET:
@@ -578,7 +588,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
 		spin_unlock(&cookie->lock);
 		wake_up_cookie_stage(cookie);
 
-		fscache_dispatch(cookie, object, 0, fscache_invalidate_object);
+		fscache_dispatch(cookie, object, flags, fscache_invalidate_object);
 		_leave(" [inv]");
 		return;
 	}
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 90c056e85cea..f13a7729bad3 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -111,6 +111,7 @@ int __fscache_begin_operation(struct fscache_cookie *cookie,
 		goto not_live;
 
 	opr->object = object;
+	opr->inval_counter = object->inval_counter;
 	object->cache->ops->grab_object(object, fscache_obj_get_ioreq);
 	object->cache->ops->begin_operation(opr);
 
diff --git a/fs/fscache/obj.c b/fs/fscache/obj.c
index 23598bec639e..60c70c0e474d 100644
--- a/fs/fscache/obj.c
+++ b/fs/fscache/obj.c
@@ -245,30 +245,15 @@ void fscache_lookup_object(struct fscache_cookie *cookie,
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
-	bool success = true;
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
-		success = object->cache->ops->invalidate_object(object);
-		fscache_do_put_object(object, fscache_obj_put_inval);
-	}
+	success = object->cache->ops->invalidate_object(object, flags);
+	fscache_do_put_object(object, fscache_obj_put_inval);
 
 	if (success)
 		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_NO_DATA_YET);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index dacfda1d3c20..a0bb526735b5 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -119,7 +119,8 @@ struct fscache_cache_ops {
 	void (*update_object)(struct fscache_object *object);
 
 	/* Invalidate an object */
-	bool (*invalidate_object)(struct fscache_object *object);
+	bool (*invalidate_object)(struct fscache_object *object,
+				  unsigned int flags);
 
 	/* discard the resources pinned by an object and effect retirement if
 	 * necessary */
@@ -164,10 +165,12 @@ enum fscache_object_stage {
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
index 3c53386e4f6e..1d141d17f63b 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -71,6 +71,9 @@ enum fscache_want_stage {
 	FSCACHE_WANT_READ,
 };
 
+#define FSCACHE_INVAL_LIGHT		0x01 /* Don't re-invalidate if temp object */
+#define FSCACHE_INVAL_DIO_WRITE		0x02 /* Invalidate due to DIO write */
+
 /*
  * fscache cached network filesystem type
  * - name, version and ops must be filled in before registration
@@ -148,6 +151,7 @@ struct fscache_op_resources {
 #if __fscache_available
 	const struct fscache_op_ops	*ops;
 	struct fscache_object		*object;
+	unsigned int			inval_counter;	/* object->inval_counter at begin_op */
 #endif
 };
 
@@ -214,7 +218,7 @@ extern int __fscache_begin_operation(struct fscache_cookie *, struct fscache_op_
 				     enum fscache_want_stage);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
-extern void __fscache_invalidate(struct fscache_cookie *, loff_t);
+extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t, unsigned int);
 extern void fscache_put_super(struct super_block *,
 			      struct fscache_cookie *(*get_cookie)(struct inode *));
 
@@ -442,22 +446,30 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
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
+ * FSCACHE_INVAL_LIGHT indicates that if the object has been invalidated and
+ * replaced by a temporary object, the temporary object need not be replaced
+ * again.  This is primarily intended for use with FSCACHE_ADV_SINGLE_CHUNK.
+ *
+ * FSCACHE_INVAL_DIO_WRITE indicates that this is due to a direct I/O write and
+ * may cause caching to be suspended on this cookie.
  *
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
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 2edf74c40e83..adb5618ce0c1 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -200,6 +200,25 @@ TRACE_EVENT(fscache_relinquish,
 		      __entry->flags, __entry->retire)
 	    );
 
+TRACE_EVENT(fscache_invalidate,
+	    TP_PROTO(struct fscache_cookie *cookie, loff_t new_size),
+
+	    TP_ARGS(cookie, new_size),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cookie		)
+		    __field(loff_t,			new_size	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cookie	= cookie->debug_id;
+		    __entry->new_size	= new_size;
+			   ),
+
+	    TP_printk("c=%08x sz=%llx",
+		      __entry->cookie, __entry->new_size)
+	    );
+
 #endif /* _TRACE_FSCACHE_H */
 
 /* This part must be outside protection */


