Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A695437DEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhJVTLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234325AbhJVTKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1I1g+jMJjTNPxktPPq0ahC5WNvciw0RepqZVH6shlk=;
        b=DahrPFRbr2PEXh2EXULGE+7ouBko1fmet4XOovqqAzygKpT5OK1JDTKRXVtJ+PGn926EPa
        0MZ/UV0XtEq3OQGLhS5rrmDLIrblKPVI25Eq/702VI1r4OABdkB7vx6AvND383qFL7n0lv
        RdqSBqyDOb3IVwKqlHAIFVjpV9BTwH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-4gofB3QPM3ScrQxNSaT1TQ-1; Fri, 22 Oct 2021 15:07:52 -0400
X-MC-Unique: 4gofB3QPM3ScrQxNSaT1TQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F940806688;
        Fri, 22 Oct 2021 19:07:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED90B60C04;
        Fri, 22 Oct 2021 19:07:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 38/53] cachefiles: Implement data storage object handling
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
Date:   Fri, 22 Oct 2021 20:07:43 +0100
Message-ID: <163492966313.1038219.16694710752489269856.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the handling of data storage objects, including the following
pieces:

 (1) An S_KERNEL_FILE inode flag is provided that a kernel service,
     e.g. cachefiles, can set to ward off other kernel services and drivers
     (including itself) from using files it is actively using.

 (2) Allocation of a cachefiles_object struct for storing state.

 (3) Rendering the binary key into something that can be used as a
     filename.  A number of encoding are considered, including plain text,
     hex rendering of arrays of le32 or be32 words or a base64 encoding.

 (4) Lookup and creation of a file on disk, using a tmpfile if the file
     isn't yet present.  The file is then opened, sized for DIO and the
     file handle is attached to the cachefiles_object struct.  The inode is
     marked S_KERNEL_FILE to indicate that it's in use by a kernel service.

 (5) Reading and checking the xattr on a file to check coherency,

 (6) Resizing an object, using truncate and/or fallocate to adjust the
     object.

 (7) Invalidation of an object, creating a tmpfile and switching the file
     pointer in the cachefiles object.

 (8) Committing a file to disk, including setting the coherency xattr on it
     and, if necessary, creating a hard link to it.

     Note that this would be a good place to use Omar Sandoval's vfs_link()
     with AT_LINK_REPLACE[1] as I may have to unlink an old file before I
     can link a tmpfile into place.

 (9) Withdrawal of open objects when a cache is being withdrawn or a cookie
     is relinquished.  This involves committing or discarding the file.

(10) Culling a file at the behest of the daemon.

(11) A method by which the daemon can query to see if a file is in use by
     the cache.

Changes
=======
ver #2)
  - Disabled a debugging statement.

Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/163363935000.1980952.15279841414072653108.stgit@warthog.procyon.org.uk [1]
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/Makefile            |    4 
 fs/cachefiles/bind.c              |   32 ++
 fs/cachefiles/daemon.c            |   46 ++
 fs/cachefiles/interface.c         |  438 ++++++++++++++++++++++
 fs/cachefiles/internal.h          |   57 +++
 fs/cachefiles/key.c               |  142 +++++++
 fs/cachefiles/main.c              |   16 +
 fs/cachefiles/namei.c             |  739 +++++++++++++++++++++++++++++++++++++
 fs/cachefiles/xattr.c             |  181 +++++++++
 include/linux/fs.h                |    1 
 include/trace/events/cachefiles.h |  354 ++++++++++++++++++
 include/trace/events/fscache.h    |    4 
 12 files changed, 2010 insertions(+), 4 deletions(-)
 create mode 100644 fs/cachefiles/key.c
 create mode 100644 fs/cachefiles/xattr.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 607f7c684a97..5dd99ca8df05 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -7,10 +7,12 @@ cachefiles-y := \
 	bind.o \
 	daemon.o \
 	interface.o \
+	key.o \
 	main.o \
 	namei.o \
 	security.o \
-	volume.o
+	volume.o \
+	xattr.o
 
 cachefiles-$(CONFIG_CACHEFILES_ERROR_INJECTION) += error_inject.o
 
diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index 70924997b0cc..59c9d141f1fe 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -236,6 +236,36 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	return ret;
 }
 
+/*
+ * Mark all the objects as being out of service and queue them all for cleanup.
+ */
+static void cachefiles_withdraw_objects(struct cachefiles_cache *cache)
+{
+	struct cachefiles_object *object;
+	unsigned int count = 0;
+
+	_enter("");
+
+	spin_lock(&cache->object_list_lock);
+
+	while (!list_empty(&cache->object_list)) {
+		object = list_first_entry(&cache->object_list,
+					  struct cachefiles_object, cache_link);
+		cachefiles_see_object(object, cachefiles_obj_see_withdrawal);
+		list_del_init(&object->cache_link);
+		fscache_withdraw_cookie(object->cookie);
+		count++;
+		if ((count & 63) == 0) {
+			spin_unlock(&cache->object_list_lock);
+			cond_resched();
+			spin_lock(&cache->object_list_lock);
+		}
+	}
+
+	spin_unlock(&cache->object_list_lock);
+	_leave(" [%u objs]", count);
+}
+
 /*
  * Withdraw volumes.
  */
@@ -276,7 +306,7 @@ static void cachefiles_withdraw_cache(struct cachefiles_cache *cache)
 	/* we now have to destroy all the active objects pertaining to this
 	 * cache - which we do by passing them off to thread pool to be
 	 * disposed of */
-	// PLACEHOLDER: Withdraw objects
+	cachefiles_withdraw_objects(cache);
 
 	/* wait for all extant objects to finish their outstanding operations
 	 * and go away */
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index c23d22a5d4a6..50ec292c7213 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -548,6 +548,10 @@ static int cachefiles_daemon_tag(struct cachefiles_cache *cache, char *args)
  */
 static int cachefiles_daemon_cull(struct cachefiles_cache *cache, char *args)
 {
+	struct path path;
+	const struct cred *saved_cred;
+	int ret;
+
 	_enter(",%s", args);
 
 	if (strchr(args, '/'))
@@ -563,7 +567,24 @@ static int cachefiles_daemon_cull(struct cachefiles_cache *cache, char *args)
 		return -EIO;
 	}
 
-	return -EOPNOTSUPP; // PLACEHOLDER: Implement culling
+	/* extract the directory dentry from the cwd */
+	get_fs_pwd(current->fs, &path);
+
+	if (!d_can_lookup(path.dentry))
+		goto notdir;
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	ret = cachefiles_cull(cache, path.dentry, args);
+	cachefiles_end_secure(cache, saved_cred);
+
+	path_put(&path);
+	_leave(" = %d", ret);
+	return ret;
+
+notdir:
+	path_put(&path);
+	pr_err("cull command requires dirfd to be a directory\n");
+	return -ENOTDIR;
 
 inval:
 	pr_err("cull command requires dirfd and filename\n");
@@ -599,6 +620,10 @@ static int cachefiles_daemon_debug(struct cachefiles_cache *cache, char *args)
  */
 static int cachefiles_daemon_inuse(struct cachefiles_cache *cache, char *args)
 {
+	struct path path;
+	const struct cred *saved_cred;
+	int ret;
+
 	//_enter(",%s", args);
 
 	if (strchr(args, '/'))
@@ -614,7 +639,24 @@ static int cachefiles_daemon_inuse(struct cachefiles_cache *cache, char *args)
 		return -EIO;
 	}
 
-	return -EOPNOTSUPP; // PLACEHOLDER: Implement check in use
+	/* extract the directory dentry from the cwd */
+	get_fs_pwd(current->fs, &path);
+
+	if (!d_can_lookup(path.dentry))
+		goto notdir;
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	ret = cachefiles_check_in_use(cache, path.dentry, args);
+	cachefiles_end_secure(cache, saved_cred);
+
+	path_put(&path);
+	//_leave(" = %d", ret);
+	return ret;
+
+notdir:
+	path_put(&path);
+	pr_err("inuse command requires dirfd to be a directory\n");
+	return -ENOTDIR;
 
 inval:
 	pr_err("inuse command requires dirfd and filename\n");
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 8624ee52b98b..b4a0bd2e803f 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -13,6 +13,310 @@
 #include <trace/events/fscache.h>
 #include "internal.h"
 
+static atomic_t cachefiles_object_debug_id;
+
+static int cachefiles_attr_changed(struct cachefiles_object *object);
+
+/*
+ * Allocate a cache object record.
+ */
+static
+struct cachefiles_object *cachefiles_alloc_object(struct fscache_cookie *cookie)
+{
+	struct fscache_volume *vcookie = cookie->volume;
+	struct cachefiles_object *object;
+	struct cachefiles_volume *volume = vcookie->cache_priv;
+	int n_accesses;
+
+	_enter("{%s},%x,", vcookie->key, cookie->debug_id);
+
+	object = kmem_cache_zalloc(cachefiles_object_jar, cachefiles_gfp);
+	if (!object)
+		return NULL;
+
+	atomic_set(&object->usage, 1);
+
+	spin_lock_init(&object->lock);
+	INIT_LIST_HEAD(&object->cache_link);
+	object->volume = volume;
+	object->debug_id = atomic_inc_return(&cachefiles_object_debug_id);
+	object->cookie = fscache_get_cookie(cookie, fscache_cookie_get_attach_object);
+
+	atomic_inc(&vcookie->cache->object_count);
+	trace_cachefiles_ref(object->debug_id, cookie->debug_id, 1,
+			     cachefiles_obj_new);
+
+	/* Get a ref on the cookie and keep its n_accesses counter raised by 1
+	 * to prevent wakeups from transitioning it to 0 until we're
+	 * withdrawing caching services from it.
+	 */
+	n_accesses = atomic_inc_return(&cookie->n_accesses);
+	trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
+			     n_accesses, fscache_access_cache_pin);
+	set_bit(FSCACHE_COOKIE_NACC_ELEVATED, &cookie->flags);
+	return object;
+}
+
+/*
+ * Attempt to look up the nominated node in this cache
+ */
+static bool cachefiles_lookup_cookie(struct fscache_cookie *cookie)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache = cookie->volume->cache->cache_priv;
+	const struct cred *saved_cred;
+	bool success;
+
+	object = cachefiles_alloc_object(cookie);
+	if (!object)
+		goto fail;
+
+	_enter("{OBJ%x}", object->debug_id);
+
+	if (!cachefiles_cook_key(object))
+		goto fail_put;
+
+	cookie->cache_priv = object;
+
+	/* look up the key, creating any missing bits */
+	cachefiles_begin_secure(cache, &saved_cred);
+	success = cachefiles_look_up_object(object);
+	cachefiles_end_secure(cache, saved_cred);
+
+	if (!success)
+		goto fail_withdraw;
+
+	cachefiles_see_object(object, cachefiles_obj_see_lookup_cookie);
+
+	spin_lock(&cache->object_list_lock);
+	list_add(&object->cache_link, &cache->object_list);
+	spin_unlock(&cache->object_list_lock);
+	cachefiles_attr_changed(object);
+	_leave(" = t");
+	return true;
+
+fail_withdraw:
+	cachefiles_see_object(object, cachefiles_obj_see_lookup_failed);
+	clear_bit(FSCACHE_COOKIE_IS_CACHING, &object->flags);
+	fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_FAILED);
+	_debug("failed c=%08x o=%08x", cookie->debug_id, object->debug_id);
+	/* The caller holds an access count on the cookie, so we need them to
+	 * drop it before we can withdraw the object.
+	 */
+	return false;
+
+fail_put:
+	cachefiles_put_object(object, cachefiles_obj_put_alloc_fail);
+fail:
+	return false;
+}
+
+/*
+ * Note that an object has been seen.
+ */
+void cachefiles_see_object(struct cachefiles_object *object,
+			   enum cachefiles_obj_ref_trace why)
+{
+	trace_cachefiles_ref(object->debug_id, object->cookie->debug_id,
+			     atomic_read(&object->usage), why);
+}
+
+/*
+ * increment the usage count on an inode object (may fail if unmounting)
+ */
+struct cachefiles_object *cachefiles_grab_object(struct cachefiles_object *object,
+						 enum cachefiles_obj_ref_trace why)
+{
+	int u;
+
+	u = atomic_inc_return(&object->usage);
+	trace_cachefiles_ref(object->debug_id, object->cookie->debug_id, u, why);
+	return object;
+}
+
+/*
+ * Shorten the backing object to discard any dirty data and free up
+ * any unused granules.
+ */
+static bool cachefiles_shorten_object(struct cachefiles_object *object,
+				      struct file *file, loff_t new_size)
+{
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct inode *inode = file_inode(file);
+	loff_t i_size, dio_size;
+	int ret;
+
+	dio_size = round_up(new_size, CACHEFILES_DIO_BLOCK_SIZE);
+	i_size = i_size_read(inode);
+
+	trace_cachefiles_trunc(object, inode, i_size, dio_size,
+			       cachefiles_trunc_shrink);
+	ret = cachefiles_inject_remove_error();
+	if (ret == 0)
+		ret = vfs_truncate(&file->f_path, dio_size);
+	if (ret < 0) {
+		trace_cachefiles_io_error(object, file_inode(file), ret,
+					  cachefiles_trace_trunc_error);
+		cachefiles_io_error_obj(object, "Trunc-to-size failed %d", ret);
+		cachefiles_remove_object_xattr(cache, object, file->f_path.dentry);
+		return false;
+	}
+
+	if (new_size < dio_size) {
+		trace_cachefiles_trunc(object, inode, dio_size, new_size,
+				       cachefiles_trunc_dio_adjust);
+		ret = cachefiles_inject_write_error();
+		if (ret == 0)
+			ret = vfs_fallocate(file, FALLOC_FL_ZERO_RANGE,
+					    new_size, dio_size);
+		if (ret < 0) {
+			trace_cachefiles_io_error(object, file_inode(file), ret,
+						  cachefiles_trace_fallocate_error);
+			cachefiles_io_error_obj(object, "Trunc-to-dio-size failed %d", ret);
+			cachefiles_remove_object_xattr(cache, object, file->f_path.dentry);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+/*
+ * Resize the backing object.
+ */
+static void cachefiles_resize_cookie(struct netfs_cache_resources *cres,
+				     loff_t new_size)
+{
+	struct cachefiles_object *object = cachefiles_cres_object(cres);
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct fscache_cookie *cookie = object->cookie;
+	const struct cred *saved_cred;
+	struct file *file = cachefiles_cres_file(cres);
+	loff_t old_size = cookie->object_size;
+
+	_enter("%llu->%llu", old_size, new_size);
+
+	if (new_size < old_size) {
+		cachefiles_begin_secure(cache, &saved_cred);
+		cachefiles_shorten_object(object, file, new_size);
+		cachefiles_end_secure(cache, saved_cred);
+		object->cookie->object_size = new_size;
+		return;
+	}
+
+	/* The file is being expanded.  We don't need to do anything
+	 * particularly.  cookie->initial_size doesn't change and so the point
+	 * at which we have to download before doesn't change.
+	 */
+	cookie->object_size = new_size;
+}
+
+/*
+ * Commit changes to the object as we drop it.
+ */
+static void cachefiles_commit_object(struct cachefiles_object *object,
+				     struct cachefiles_cache *cache)
+{
+	bool update = false;
+
+	if (test_and_clear_bit(FSCACHE_COOKIE_LOCAL_WRITE, &object->cookie->flags))
+		update = true;
+	if (test_and_clear_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags))
+		update = true;
+	if (update)
+		cachefiles_set_object_xattr(object);
+
+	if (test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags))
+		cachefiles_commit_tmpfile(cache, object);
+}
+
+/*
+ * Finalise and object and close the VFS structs that we have.
+ */
+static void cachefiles_clean_up_object(struct cachefiles_object *object,
+				       struct cachefiles_cache *cache)
+{
+	if (test_bit(FSCACHE_COOKIE_RETIRED, &object->cookie->flags)) {
+		if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
+			cachefiles_see_object(object, cachefiles_obj_see_clean_delete);
+			_debug("- inval object OBJ%x", object->debug_id);
+			cachefiles_delete_object(object, FSCACHE_OBJECT_WAS_RETIRED);
+		} else {
+			cachefiles_see_object(object, cachefiles_obj_see_clean_drop_tmp);
+			_debug("- inval object OBJ%x tmpfile", object->debug_id);
+		}
+	} else {
+		cachefiles_see_object(object, cachefiles_obj_see_clean_commit);
+		cachefiles_commit_object(object, cache);
+	}
+
+	cachefiles_unmark_inode_in_use(object, object->file);
+	if (object->file) {
+		fput(object->file);
+		object->file = NULL;
+	}
+}
+
+/*
+ * Withdraw caching for a cookie.
+ */
+static void cachefiles_withdraw_cookie(struct fscache_cookie *cookie)
+{
+	struct cachefiles_object *object = cookie->cache_priv;
+	struct cachefiles_cache *cache = object->volume->cache;
+	const struct cred *saved_cred;
+
+	_enter("o=%x", object->debug_id);
+	cachefiles_see_object(object, cachefiles_obj_see_withdraw_cookie);
+
+	if (!list_empty(&object->cache_link)) {
+		spin_lock(&cache->object_list_lock);
+		cachefiles_see_object(object, cachefiles_obj_see_withdrawal);
+		list_del_init(&object->cache_link);
+		spin_unlock(&cache->object_list_lock);
+	}
+
+	if (object->file) {
+		cachefiles_begin_secure(cache, &saved_cred);
+		cachefiles_clean_up_object(object, cache);
+		cachefiles_end_secure(cache, saved_cred);
+	}
+
+	cookie->cache_priv = NULL;
+	cachefiles_put_object(object, cachefiles_obj_put_detach);
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
+	int u;
+
+	u = atomic_dec_return(&object->usage);
+	trace_cachefiles_ref(object_debug_id, cookie_debug_id, u, why);
+	if (u == 0) {
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
+		if (atomic_dec_and_test(&cache->object_count))
+			wake_up_all(&cachefiles_clearance_wq);
+	}
+
+	_leave("");
+}
+
 /*
  * sync a cache
  */
@@ -37,8 +341,142 @@ void cachefiles_sync_cache(struct cachefiles_cache *cache)
 				    ret);
 }
 
+/*
+ * notification the attributes on an object have changed
+ * - called with reads/writes excluded by FS-Cache
+ */
+static int cachefiles_attr_changed(struct cachefiles_object *object)
+{
+	struct cachefiles_cache *cache = object->volume->cache;
+	const struct cred *saved_cred;
+	struct iattr newattrs;
+	struct file *file = object->file;
+	uint64_t ni_size;
+	loff_t oi_size;
+	int ret;
+
+	ni_size = object->cookie->object_size;
+	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
+
+	_enter("{OBJ%x},[%llu]",
+	       object->debug_id, (unsigned long long) ni_size);
+
+	if (!file)
+		return -ENOBUFS;
+
+	oi_size = i_size_read(file_inode(file));
+	if (oi_size == ni_size)
+		return 0;
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	inode_lock(file_inode(file));
+
+	/* if there's an extension to a partial page at the end of the backing
+	 * file, we need to discard the partial page so that we pick up new
+	 * data after it */
+	if (oi_size & ~PAGE_MASK && ni_size > oi_size) {
+		_debug("discard tail %llx", oi_size);
+		newattrs.ia_valid = ATTR_SIZE;
+		newattrs.ia_size = oi_size & PAGE_MASK;
+		ret = cachefiles_inject_remove_error();
+		if (ret == 0)
+			ret = notify_change(&init_user_ns, file->f_path.dentry,
+					    &newattrs, NULL);
+		if (ret < 0)
+			goto truncate_failed;
+	}
+
+	newattrs.ia_valid = ATTR_SIZE;
+	newattrs.ia_size = ni_size;
+	ret = cachefiles_inject_write_error();
+	if (ret == 0)
+		ret = notify_change(&init_user_ns, file->f_path.dentry,
+				    &newattrs, NULL);
+
+truncate_failed:
+	inode_unlock(file_inode(file));
+	cachefiles_end_secure(cache, saved_cred);
+
+	if (ret < 0)
+		trace_cachefiles_io_error(NULL, file_inode(file), ret,
+					  cachefiles_trace_notify_change_error);
+	if (ret == -EIO) {
+		cachefiles_io_error_obj(object, "Size set failed");
+		ret = -ENOBUFS;
+	}
+
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Invalidate the storage associated with a cookie.
+ */
+static bool cachefiles_invalidate_cookie(struct fscache_cookie *cookie)
+{
+	struct cachefiles_object *object = cookie->cache_priv;
+	struct file *new_file, *old_file;
+	bool old_tmpfile;
+
+	_enter("o=%x,[%llu]", object->debug_id, object->cookie->object_size);
+
+	old_tmpfile = test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
+
+	if (!object->file) {
+		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_ACTIVE);
+		_leave(" = t [light]");
+		return true;
+	}
+
+	new_file = cachefiles_create_tmpfile(object);
+	if (IS_ERR(new_file))
+		goto failed;
+
+	/* Substitute the VFS target */
+	_debug("sub");
+	spin_lock(&object->lock);
+
+	old_file = object->file;
+	object->file = new_file;
+	object->content_info = CACHEFILES_CONTENT_NO_DATA;
+	set_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
+	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags);
+
+	spin_unlock(&object->lock);
+	_debug("subbed");
+
+	/* Allow I/O to take place again */
+	fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_ACTIVE);
+
+	if (old_file) {
+		if (!old_tmpfile) {
+			struct cachefiles_volume *volume = object->volume;
+			struct dentry *fan = volume->fanout[(u8)object->key_hash];
+
+			inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
+			cachefiles_bury_object(volume->cache, object, fan,
+					       old_file->f_path.dentry,
+					       FSCACHE_OBJECT_INVALIDATED);
+		}
+		fput(old_file);
+	}
+
+	_leave(" = t");
+	return true;
+
+failed:
+	fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_FAILED);
+	_leave(" = f");
+	return false;
+}
+
 const struct fscache_cache_ops cachefiles_cache_ops = {
 	.name			= "cachefiles",
 	.acquire_volume		= cachefiles_acquire_volume,
 	.free_volume		= cachefiles_free_volume,
+	.lookup_cookie		= cachefiles_lookup_cookie,
+	.withdraw_cookie	= cachefiles_withdraw_cookie,
+	.invalidate_cookie	= cachefiles_invalidate_cookie,
+	.resize_cookie		= cachefiles_resize_cookie,
+	.prepare_to_write	= cachefiles_prepare_to_write,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 828b888a8bf3..3fa23710fc6f 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -19,6 +19,8 @@
 #include <linux/workqueue.h>
 #include <linux/security.h>
 
+#define CACHEFILES_DIO_BLOCK_SIZE 4096
+
 struct cachefiles_cache;
 struct cachefiles_object;
 
@@ -27,6 +29,8 @@ extern unsigned cachefiles_debug;
 #define CACHEFILES_DEBUG_KLEAVE	2
 #define CACHEFILES_DEBUG_KDEBUG	4
 
+#define cachefiles_gfp (__GFP_RECLAIM | __GFP_NORETRY | __GFP_NOMEMALLOC)
+
 enum cachefiles_content {
 	/* These values are saved on disk */
 	CACHEFILES_CONTENT_NO_DATA	= 0, /* No content stored */
@@ -114,6 +118,18 @@ struct cachefiles_cache {
 
 #include <trace/events/cachefiles.h>
 
+static inline
+struct file *cachefiles_cres_file(struct netfs_cache_resources *cres)
+{
+	return cres->cache_priv2;
+}
+
+static inline
+struct cachefiles_object *cachefiles_cres_object(struct netfs_cache_resources *cres)
+{
+	return fscache_cres_cookie(cres)->cache_priv;
+}
+
 /*
  * note change of state for daemon
  */
@@ -182,15 +198,45 @@ static inline int cachefiles_inject_remove_error(void)
  * interface.c
  */
 extern const struct fscache_cache_ops cachefiles_cache_ops;
+extern void cachefiles_see_object(struct cachefiles_object *object,
+				  enum cachefiles_obj_ref_trace why);
+extern struct cachefiles_object *cachefiles_grab_object(struct cachefiles_object *object,
+							enum cachefiles_obj_ref_trace why);
+extern void cachefiles_put_object(struct cachefiles_object *object,
+				  enum cachefiles_obj_ref_trace why);
 extern void cachefiles_sync_cache(struct cachefiles_cache *cache);
 
+/*
+ * key.c
+ */
+extern bool cachefiles_cook_key(struct cachefiles_object *object);
+
 /*
  * namei.c
  */
+extern void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
+					   struct file *file);
+extern int cachefiles_bury_object(struct cachefiles_cache *cache,
+				  struct cachefiles_object *object,
+				  struct dentry *dir,
+				  struct dentry *rep,
+				  enum fscache_why_object_killed why);
+extern int cachefiles_delete_object(struct cachefiles_object *object,
+				    enum fscache_why_object_killed why);
+extern bool cachefiles_look_up_object(struct cachefiles_object *object);
 extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					       struct dentry *dir,
 					       const char *name);
 
+extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
+			   char *filename);
+
+extern int cachefiles_check_in_use(struct cachefiles_cache *cache,
+				   struct dentry *dir, char *filename);
+extern struct file *cachefiles_create_tmpfile(struct cachefiles_object *object);
+extern bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
+				      struct cachefiles_object *object);
+
 /*
  * security.c
  */
@@ -218,6 +264,17 @@ void cachefiles_acquire_volume(struct fscache_volume *volume);
 void cachefiles_free_volume(struct fscache_volume *volume);
 void cachefiles_withdraw_volume(struct cachefiles_volume *volume);
 
+/*
+ * xattr.c
+ */
+extern int cachefiles_set_object_xattr(struct cachefiles_object *object);
+extern int cachefiles_check_auxdata(struct cachefiles_object *object,
+				    struct file *file);
+extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
+					  struct cachefiles_object *object,
+					  struct dentry *dentry);
+extern void cachefiles_prepare_to_write(struct fscache_cookie *cookie);
+
 /*
  * error handling
  */
diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
new file mode 100644
index 000000000000..10f2be29f892
--- /dev/null
+++ b/fs/cachefiles/key.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Key to pathname encoder
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/slab.h>
+#include "internal.h"
+
+static const char cachefiles_charmap[64] =
+	"0123456789"			/* 0 - 9 */
+	"abcdefghijklmnopqrstuvwxyz"	/* 10 - 35 */
+	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"	/* 36 - 61 */
+	"_-"				/* 62 - 63 */
+	;
+
+static const char cachefiles_filecharmap[256] = {
+	/* we skip space and tab and control chars */
+	[33 ... 46] = 1,		/* '!' -> '.' */
+	/* we skip '/' as it's significant to pathwalk */
+	[48 ... 127] = 1,		/* '0' -> '~' */
+};
+
+static inline unsigned int how_many_hex_digits(unsigned int x)
+{
+	return x ? round_up(ilog2(x) + 1, 4) / 4 : 0;
+}
+
+/*
+ * turn the raw key into something cooked
+ * - the key may be up to NAME_MAX in length (including the length word)
+ *   - "base64" encode the strange keys, mapping 3 bytes of raw to four of
+ *     cooked
+ *   - need to cut the cooked key into 252 char lengths (189 raw bytes)
+ */
+bool cachefiles_cook_key(struct cachefiles_object *object)
+{
+	const u8 *key = fscache_get_key(object->cookie), *kend;
+	unsigned char sum, ch;
+	unsigned int acc, i, n, nle, nbe, keylen = object->cookie->key_len;
+	unsigned int b64len, len, print, pad;
+	char *name, sep;
+
+	_enter(",%u,%*phN", keylen, keylen, key);
+
+	BUG_ON(keylen > NAME_MAX - 3);
+
+	sum = 0;
+	print = 1;
+	for (i = 0; i < keylen; i++) {
+		ch = key[i];
+		sum += ch;
+		print &= cachefiles_filecharmap[ch];
+	}
+	object->key_hash = sum;
+
+	/* If the path is usable ASCII, then we render it directly */
+	if (print) {
+		len = 1 + keylen + 1;
+		name = kmalloc(len, cachefiles_gfp);
+		if (!name)
+			return false;
+
+		name[0] = 'D'; /* Data object type, string encoding */
+		name[1 + keylen] = 0;
+		memcpy(name + 1, key, keylen);
+		goto success;
+	}
+
+	/* See if it makes sense to encode it as "hex,hex,hex" for each 32-bit
+	 * chunk.  We rely on the key having been padded out to a whole number
+	 * of 32-bit words.
+	 */
+	n = round_up(keylen, 4);
+	nbe = nle = 0;
+	for (i = 0; i < n; i += 4) {
+		u32 be = be32_to_cpu(*(__be32 *)(key + i));
+		u32 le = le32_to_cpu(*(__le32 *)(key + i));
+
+		nbe += 1 + how_many_hex_digits(be);
+		nle += 1 + how_many_hex_digits(le);
+	}
+
+	b64len = DIV_ROUND_UP(keylen, 3);
+	pad = b64len * 3 - keylen;
+	b64len = 2 + b64len * 4; /* Length if we base64-encode it */
+	_debug("len=%u nbe=%u nle=%u b64=%u", keylen, nbe, nle, b64len);
+	if (nbe < b64len || nle < b64len) {
+		unsigned int nlen = min(nbe, nle) + 1;
+		name = kmalloc(nlen, cachefiles_gfp);
+		if (!name)
+			return false;
+		sep = (nbe <= nle) ? 'S' : 'T'; /* Encoding indicator */
+		len = 0;
+		for (i = 0; i < n; i += 4) {
+			u32 x;
+			if (nbe <= nle)
+				x = be32_to_cpu(*(__be32 *)(key + i));
+			else
+				x = le32_to_cpu(*(__le32 *)(key + i));
+			name[len++] = sep;
+			if (x != 0)
+				len += snprintf(name + len, nlen - len, "%x", x);
+			sep = ',';
+		}
+		goto success;
+	}
+
+	/* We need to base64-encode it */
+	name = kmalloc(b64len + 1, cachefiles_gfp);
+	if (!name)
+		return false;
+
+	name[0] = 'E';
+	name[1] = '0' + pad;
+	len = 2;
+	kend = key + keylen;
+	do {
+		acc  = *key++;
+		if (key < kend) {
+			acc |= *key++ << 8;
+			if (key < kend)
+				acc |= *key++ << 16;
+		}
+
+		name[len++] = cachefiles_charmap[acc & 63];
+		acc >>= 6;
+		name[len++] = cachefiles_charmap[acc & 63];
+		acc >>= 6;
+		name[len++] = cachefiles_charmap[acc & 63];
+		acc >>= 6;
+		name[len++] = cachefiles_charmap[acc & 63];
+	} while (key < kend);
+
+success:
+	name[len] = 0;
+	object->d_name = name;
+	object->d_name_len = len;
+	_leave(" = %s", object->d_name);
+	return true;
+}
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index 22581099236b..7a459074d715 100644
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
@@ -52,9 +54,22 @@ static int __init cachefiles_init(void)
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
@@ -71,6 +86,7 @@ static void __exit cachefiles_exit(void)
 {
 	pr_info("Unloading\n");
 
+	kmem_cache_destroy(cachefiles_object_jar);
 	misc_deregister(&cachefiles_dev);
 	cachefiles_unregister_error_injection();
 }
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 69915dde0a83..ad87fb28b602 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -18,6 +18,431 @@
 #include <linux/slab.h>
 #include "internal.h"
 
+/*
+ * Mark the backing file as being a cache file if it's not already in use so.
+ */
+static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object,
+					 struct dentry *dentry)
+{
+	struct inode *inode = d_backing_inode(dentry);
+	bool can_use = false;
+
+	_enter(",%x", object->debug_id);
+
+	inode_lock(inode);
+
+	if (!(inode->i_flags & S_KERNEL_FILE)) {
+		inode->i_flags |= S_KERNEL_FILE;
+		trace_cachefiles_mark_active(object, inode);
+		can_use = true;
+	} else {
+		pr_notice("cachefiles: Inode already in use: %pD\n", object->file);
+	}
+
+	inode_unlock(inode);
+	return can_use;
+}
+
+/*
+ * Unmark a backing inode.
+ */
+void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
+				    struct file *file)
+{
+	struct inode *inode = file_inode(file);
+
+	if (!inode)
+		return;
+
+	inode_lock(inode);
+	inode->i_flags &= ~S_KERNEL_FILE;
+	inode_unlock(inode);
+	trace_cachefiles_mark_inactive(object, inode);
+}
+
+/*
+ * Mark an object as being inactive.
+ */
+static void cachefiles_mark_object_inactive(struct cachefiles_object *object,
+					    struct file *file)
+{
+	struct cachefiles_cache *cache = object->volume->cache;
+	blkcnt_t i_blocks = file_inode(file)->i_blocks;
+
+	/* This object can now be culled, so we need to let the daemon know
+	 * that there is something it can remove if it needs to.
+	 */
+	atomic_long_add(i_blocks, &cache->b_released);
+	if (atomic_inc_return(&cache->f_released))
+		cachefiles_state_changed(cache);
+}
+
+/*
+ * delete an object representation from the cache
+ * - file backed objects are unlinked
+ * - directory backed objects are stuffed into the graveyard for userspace to
+ *   delete
+ */
+int cachefiles_bury_object(struct cachefiles_cache *cache,
+			   struct cachefiles_object *object,
+			   struct dentry *dir,
+			   struct dentry *rep,
+			   enum fscache_why_object_killed why)
+{
+	struct dentry *grave, *trap;
+	struct path path, path_to_graveyard;
+	char nbuffer[8 + 8 + 1];
+	int ret;
+
+	_enter(",'%pd','%pd'", dir, rep);
+
+	if (rep->d_parent != dir) {
+		inode_unlock(d_inode(dir));
+		_leave(" = -ESTALE");
+		return -ESTALE;
+	}
+
+	/* non-directories can just be unlinked */
+	if (!d_is_dir(rep)) {
+		_debug("unlink stale object");
+
+		path.mnt = cache->mnt;
+		path.dentry = dir;
+		ret = security_path_unlink(&path, rep);
+		if (ret < 0) {
+			cachefiles_io_error(cache, "Unlink security error");
+		} else {
+			trace_cachefiles_unlink(object, rep, why);
+			dget(rep); /* Stop the dentry being negated if it's
+				    * only pinned by a file struct.
+				    */
+			ret = cachefiles_inject_remove_error();
+			if (ret == 0)
+				ret = vfs_unlink(&init_user_ns, d_inode(dir), rep, NULL);
+			dput(rep);
+		}
+
+		inode_unlock(d_inode(dir));
+
+		if (ret < 0) {
+			trace_cachefiles_vfs_error(object, d_inode(dir), ret,
+						   cachefiles_trace_unlink_error);
+			if (ret == -EIO)
+				cachefiles_io_error(cache, "Unlink failed");
+		}
+
+		_leave(" = %d", ret);
+		return ret;
+	}
+
+	/* directories have to be moved to the graveyard */
+	_debug("move stale object to graveyard");
+	inode_unlock(d_inode(dir));
+
+try_again:
+	/* first step is to make up a grave dentry in the graveyard */
+	sprintf(nbuffer, "%08x%08x",
+		(uint32_t) ktime_get_real_seconds(),
+		(uint32_t) atomic_inc_return(&cache->gravecounter));
+
+	/* do the multiway lock magic */
+	trap = lock_rename(cache->graveyard, dir);
+
+	/* do some checks before getting the grave dentry */
+	if (rep->d_parent != dir || IS_DEADDIR(d_inode(rep))) {
+		/* the entry was probably culled when we dropped the parent dir
+		 * lock */
+		unlock_rename(cache->graveyard, dir);
+		_leave(" = 0 [culled?]");
+		return 0;
+	}
+
+	if (!d_can_lookup(cache->graveyard)) {
+		unlock_rename(cache->graveyard, dir);
+		cachefiles_io_error(cache, "Graveyard no longer a directory");
+		return -EIO;
+	}
+
+	if (trap == rep) {
+		unlock_rename(cache->graveyard, dir);
+		cachefiles_io_error(cache, "May not make directory loop");
+		return -EIO;
+	}
+
+	if (d_mountpoint(rep)) {
+		unlock_rename(cache->graveyard, dir);
+		cachefiles_io_error(cache, "Mountpoint in cache");
+		return -EIO;
+	}
+
+	grave = lookup_one_len(nbuffer, cache->graveyard, strlen(nbuffer));
+	if (IS_ERR(grave)) {
+		unlock_rename(cache->graveyard, dir);
+		trace_cachefiles_vfs_error(object, d_inode(cache->graveyard),
+					   PTR_ERR(grave),
+					   cachefiles_trace_lookup_error);
+
+		if (PTR_ERR(grave) == -ENOMEM) {
+			_leave(" = -ENOMEM");
+			return -ENOMEM;
+		}
+
+		cachefiles_io_error(cache, "Lookup error %ld", PTR_ERR(grave));
+		return -EIO;
+	}
+
+	if (d_is_positive(grave)) {
+		unlock_rename(cache->graveyard, dir);
+		dput(grave);
+		grave = NULL;
+		cond_resched();
+		goto try_again;
+	}
+
+	if (d_mountpoint(grave)) {
+		unlock_rename(cache->graveyard, dir);
+		dput(grave);
+		cachefiles_io_error(cache, "Mountpoint in graveyard");
+		return -EIO;
+	}
+
+	/* target should not be an ancestor of source */
+	if (trap == grave) {
+		unlock_rename(cache->graveyard, dir);
+		dput(grave);
+		cachefiles_io_error(cache, "May not make directory loop");
+		return -EIO;
+	}
+
+	/* attempt the rename */
+	path.mnt = cache->mnt;
+	path.dentry = dir;
+	path_to_graveyard.mnt = cache->mnt;
+	path_to_graveyard.dentry = cache->graveyard;
+	ret = security_path_rename(&path, rep, &path_to_graveyard, grave, 0);
+	if (ret < 0) {
+		cachefiles_io_error(cache, "Rename security error %d", ret);
+	} else {
+		struct renamedata rd = {
+			.old_mnt_userns	= &init_user_ns,
+			.old_dir	= d_inode(dir),
+			.old_dentry	= rep,
+			.new_mnt_userns	= &init_user_ns,
+			.new_dir	= d_inode(cache->graveyard),
+			.new_dentry	= grave,
+		};
+		trace_cachefiles_rename(object, rep, grave, why);
+		ret = cachefiles_inject_read_error();
+		if (ret == 0)
+			ret = vfs_rename(&rd);
+		if (ret != 0)
+			trace_cachefiles_vfs_error(object, d_inode(dir),
+						   PTR_ERR(grave),
+						   cachefiles_trace_rename_error);
+		if (ret != 0 && ret != -ENOMEM)
+			cachefiles_io_error(cache,
+					    "Rename failed with error %d", ret);
+	}
+
+	unlock_rename(cache->graveyard, dir);
+	dput(grave);
+	_leave(" = 0");
+	return 0;
+}
+
+static int cachefiles_unlink(struct cachefiles_object *object,
+			     struct dentry *fan, struct dentry *dentry,
+			     enum fscache_why_object_killed why)
+{
+	struct path path = {
+		.mnt	= object->volume->cache->mnt,
+		.dentry	= fan,
+	};
+	int ret;
+
+	trace_cachefiles_unlink(object, dentry, why);
+	ret = security_path_unlink(&path, dentry);
+	if (ret == 0)
+		ret = cachefiles_inject_remove_error();
+	if (ret == 0)
+		ret = vfs_unlink(&init_user_ns, d_backing_inode(fan), dentry, NULL);
+	if (ret != 0)
+		trace_cachefiles_vfs_error(object, d_backing_inode(fan), ret,
+					   cachefiles_trace_unlink_error);
+	return ret;
+}
+
+/*
+ * Delete a cache file.
+ */
+int cachefiles_delete_object(struct cachefiles_object *object,
+			     enum fscache_why_object_killed why)
+{
+	struct cachefiles_volume *volume = object->volume;
+	struct dentry *dentry = object->file->f_path.dentry;
+	struct dentry *fan = volume->fanout[(u8)object->key_hash];
+	int ret;
+
+	_enter(",OBJ%x{%pD}", object->debug_id, object->file);
+
+	/* Stop the dentry being negated if it's only pinned by a file struct. */
+	dget(dentry);
+
+	inode_lock_nested(d_backing_inode(fan), I_MUTEX_PARENT);
+	ret = cachefiles_unlink(object, fan, dentry, why);
+	inode_unlock(d_backing_inode(fan));
+	dput(dentry);
+
+	if (ret < 0)
+		trace_cachefiles_vfs_error(object, d_backing_inode(fan), ret,
+					   cachefiles_trace_unlink_error);
+	if (ret < 0 && ret != -ENOENT)
+		cachefiles_io_error(volume->cache, "Unlink failed");
+	return ret;
+}
+
+/*
+ * Create a new file.
+ */
+static bool cachefiles_create_file(struct cachefiles_object *object)
+{
+	struct file *file;
+	int ret;
+
+	ret = cachefiles_has_space(object->volume->cache, 1, 0);
+	if (ret < 0)
+		return false;
+
+	file = cachefiles_create_tmpfile(object);
+	if (IS_ERR(file))
+		return false;
+
+	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags);
+	set_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
+	_debug("create -> %pD{ino=%lu}", file, file_inode(file)->i_ino);
+	object->file = file;
+	return true;
+}
+
+/*
+ * Open an existing file, checking its attributes and replacing it if it is
+ * stale.
+ */
+static bool cachefiles_open_file(struct cachefiles_object *object,
+				 struct dentry *dentry)
+{
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct file *file;
+	struct path path;
+	int ret;
+
+	_enter("%pd", dentry);
+
+	if (!cachefiles_mark_inode_in_use(object, dentry))
+		return false;
+
+	/* We need to open a file interface onto a data file now as we can't do
+	 * it on demand because writeback called from do_exit() sees
+	 * current->fs == NULL - which breaks d_path() called from ext4 open.
+	 */
+	path.mnt = cache->mnt;
+	path.dentry = dentry;
+	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
+				   d_backing_inode(dentry), cache->cache_cred);
+	if (IS_ERR(file)) {
+		trace_cachefiles_vfs_error(object, d_backing_inode(dentry),
+					   PTR_ERR(file),
+					   cachefiles_trace_open_error);
+		goto error;
+	}
+
+	if (unlikely(!file->f_op->read_iter) ||
+	    unlikely(!file->f_op->write_iter)) {
+		pr_notice("Cache does not support read_iter and write_iter\n");
+		goto error_fput;
+	}
+	_debug("file -> %pd positive", dentry);
+
+	ret = cachefiles_check_auxdata(object, file);
+	if (ret < 0)
+		goto check_failed;
+
+	object->file = file;
+
+	/* Always update the atime on an object we've just looked up (this is
+	 * used to keep track of culling, and atimes are only updated by read,
+	 * write and readdir but not lookup or open).
+	 */
+	touch_atime(&file->f_path);
+	dput(dentry);
+	return true;
+
+check_failed:
+	fscache_cookie_lookup_negative(object->cookie);
+	cachefiles_unmark_inode_in_use(object, file);
+	cachefiles_mark_object_inactive(object, file);
+	if (ret == -ESTALE) {
+		fput(file);
+		dput(dentry);
+		return cachefiles_create_file(object);
+	}
+error_fput:
+	fput(file);
+error:
+	dput(dentry);
+	return false;
+}
+
+/*
+ * walk from the parent object to the child object through the backing
+ * filesystem, creating directories as we go
+ */
+bool cachefiles_look_up_object(struct cachefiles_object *object)
+{
+	struct cachefiles_volume *volume = object->volume;
+	struct dentry *dentry, *fan = volume->fanout[(u8)object->key_hash];
+	int ret;
+
+	_enter("OBJ%x,%s,", object->debug_id, object->d_name);
+
+	/* Look up path "cache/vol/fanout/file". */
+	ret = cachefiles_inject_read_error();
+	if (ret == 0)
+		dentry = lookup_positive_unlocked(object->d_name, fan,
+						  object->d_name_len);
+	else
+		dentry = ERR_PTR(ret);
+	trace_cachefiles_lookup(object, dentry);
+	if (IS_ERR(dentry)) {
+		if (dentry == ERR_PTR(-ENOENT))
+			goto new_file;
+		if (dentry == ERR_PTR(-EIO))
+			cachefiles_io_error_obj(object, "Lookup failed");
+		return false;
+	}
+
+	if (!d_is_reg(dentry)) {
+		pr_err("%pd is not a file\n", dentry);
+		inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
+		ret = cachefiles_bury_object(volume->cache, object, fan, dentry,
+					     FSCACHE_OBJECT_IS_WEIRD);
+		dput(dentry);
+		if (ret < 0)
+			return false;
+		goto new_file;
+	}
+
+	if (!cachefiles_open_file(object, dentry))
+		return false;
+
+	_leave(" = t [%lu]", file_inode(object->file)->i_ino);
+	return true;
+
+new_file:
+	fscache_cookie_lookup_negative(object->cookie);
+	return cachefiles_create_file(object);
+}
+
 /*
  * get a subdirectory
  */
@@ -131,3 +556,317 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	_leave(" = -ENOMEM");
 	return ERR_PTR(-ENOMEM);
 }
+
+/*
+ * find out if an object is in use or not
+ * - if finds object and it's not in use:
+ *   - returns a pointer to the object and a reference on it
+ *   - returns with the directory locked
+ */
+static struct dentry *cachefiles_check_active(struct cachefiles_cache *cache,
+					      struct dentry *dir,
+					      char *filename)
+{
+	struct dentry *victim;
+	int ret;
+
+	//_enter(",%pd/,%s",
+	//       dir, filename);
+
+	/* look up the victim */
+	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+
+	victim = lookup_one_len(filename, dir, strlen(filename));
+	if (IS_ERR(victim))
+		goto lookup_error;
+
+	//_debug("victim -> %pd %s",
+	//       victim, d_backing_inode(victim) ? "positive" : "negative");
+
+	/* if the object is no longer there then we probably retired the object
+	 * at the netfs's request whilst the cull was in progress
+	 */
+	if (d_is_negative(victim)) {
+		inode_unlock(d_inode(dir));
+		dput(victim);
+		_leave(" = -ENOENT [absent]");
+		return ERR_PTR(-ENOENT);
+	}
+
+	//_leave(" = %pd", victim);
+	return victim;
+
+lookup_error:
+	inode_unlock(d_inode(dir));
+	ret = PTR_ERR(victim);
+	if (ret == -ENOENT) {
+		/* file or dir now absent - probably retired by netfs */
+		_leave(" = -ESTALE [absent]");
+		return ERR_PTR(-ESTALE);
+	}
+
+	if (ret == -EIO) {
+		cachefiles_io_error(cache, "Lookup failed");
+	} else if (ret != -ENOMEM) {
+		pr_err("Internal error: %d\n", ret);
+		ret = -EIO;
+	}
+
+	_leave(" = %d", ret);
+	return ERR_PTR(ret);
+}
+
+/*
+ * cull an object if it's not in use
+ * - called only by cache manager daemon
+ */
+int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
+		    char *filename)
+{
+	struct dentry *victim;
+	struct inode *inode;
+	int ret;
+
+	_enter(",%pd/,%s", dir, filename);
+
+	victim = cachefiles_check_active(cache, dir, filename);
+	if (IS_ERR(victim))
+		return PTR_ERR(victim);
+
+	/* check to see if someone is using this object */
+	inode = d_inode(victim);
+	inode_lock(inode);
+	if (inode->i_flags & S_KERNEL_FILE) {
+		ret = -EBUSY;
+	} else {
+		inode->i_flags |= S_KERNEL_FILE;
+		ret = 0;
+	}
+	inode_unlock(inode);
+	if (ret < 0)
+		goto error_unlock;
+
+	_debug("victim -> %pd %s",
+	       victim, d_backing_inode(victim) ? "positive" : "negative");
+
+	/* okay... the victim is not being used so we can cull it
+	 * - start by marking it as stale
+	 */
+	_debug("victim is cullable");
+
+	ret = cachefiles_remove_object_xattr(cache, NULL, victim);
+	if (ret < 0)
+		goto error_unlock;
+
+	/*  actually remove the victim (drops the dir mutex) */
+	_debug("bury");
+
+	ret = cachefiles_bury_object(cache, NULL, dir, victim,
+				     FSCACHE_OBJECT_WAS_CULLED);
+	if (ret < 0)
+		goto error;
+
+	dput(victim);
+	_leave(" = 0");
+	return 0;
+
+error_unlock:
+	inode_unlock(d_inode(dir));
+error:
+	dput(victim);
+	if (ret == -ENOENT) {
+		/* file or dir now absent - probably retired by netfs */
+		_leave(" = -ESTALE [absent]");
+		return -ESTALE;
+	}
+
+	if (ret != -ENOMEM) {
+		pr_err("Internal error: %d\n", ret);
+		ret = -EIO;
+	}
+
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * find out if an object is in use or not
+ * - called only by cache manager daemon
+ * - returns -EBUSY or 0 to indicate whether an object is in use or not
+ */
+int cachefiles_check_in_use(struct cachefiles_cache *cache, struct dentry *dir,
+			    char *filename)
+{
+	struct dentry *victim;
+	int ret = 0;
+
+	//_enter(",%pd/,%s",
+	//       dir, filename);
+
+	victim = cachefiles_check_active(cache, dir, filename);
+	if (IS_ERR(victim))
+		return PTR_ERR(victim);
+
+	inode_unlock(d_inode(dir));
+	if (d_inode(victim)->i_flags & S_KERNEL_FILE)
+		ret = -EBUSY;
+	dput(victim);
+	//_leave(" = 0");
+	return ret;
+}
+
+/*
+ * Create a temporary file and leave it unattached and un-xattr'd until the
+ * time comes to discard the object from memory.
+ */
+struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
+{
+	struct cachefiles_volume *volume = object->volume;
+	struct cachefiles_cache *cache = volume->cache;
+	const struct cred *saved_cred;
+	struct dentry *fan = volume->fanout[(u8)object->key_hash];
+	struct file *file;
+	struct path path;
+	uint64_t ni_size = object->cookie->object_size;
+	long ret;
+
+	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
+
+	cachefiles_begin_secure(cache, &saved_cred);
+
+	path.mnt = cache->mnt;
+	ret = cachefiles_inject_write_error();
+	if (ret == 0)
+		path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);
+	else
+		path.dentry = ERR_PTR(ret);
+	if (IS_ERR(path.dentry)) {
+		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(path.dentry),
+					   cachefiles_trace_tmpfile_error);
+		if (PTR_ERR(path.dentry) == -EIO)
+			cachefiles_io_error_obj(object, "Failed to create tmpfile");
+		file = ERR_CAST(path.dentry);
+		goto out;
+	}
+
+	trace_cachefiles_tmpfile(object, d_backing_inode(path.dentry));
+
+	if (!cachefiles_mark_inode_in_use(object, path.dentry)) {
+		file = ERR_PTR(-EBUSY);
+		goto out_dput;
+	}
+
+	if (ni_size > 0) {
+		trace_cachefiles_trunc(object, d_backing_inode(path.dentry), 0, ni_size,
+				       cachefiles_trunc_expand_tmpfile);
+		ret = cachefiles_inject_write_error();
+		if (ret == 0)
+			ret = vfs_truncate(&path, ni_size);
+		if (ret < 0) {
+			trace_cachefiles_vfs_error(
+				object, d_backing_inode(path.dentry), ret,
+				cachefiles_trace_trunc_error);
+			file = ERR_PTR(ret);
+			goto out_dput;
+		}
+	}
+
+	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
+				   d_backing_inode(path.dentry), cache->cache_cred);
+	if (IS_ERR(file)) {
+		trace_cachefiles_vfs_error(object, d_backing_inode(path.dentry),
+					   PTR_ERR(file),
+					   cachefiles_trace_open_error);
+		goto out_dput;
+	}
+	if (unlikely(!file->f_op->read_iter) ||
+	    unlikely(!file->f_op->write_iter)) {
+		fput(file);
+		pr_notice("Cache does not support read_iter and write_iter\n");
+		file = ERR_PTR(-EINVAL);
+	}
+
+out_dput:
+	dput(path.dentry);
+out:
+	cachefiles_end_secure(cache, saved_cred);
+	return file;
+}
+
+/*
+ * Attempt to link a temporary file into its rightful place in the cache.
+ */
+bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
+			       struct cachefiles_object *object)
+{
+	struct cachefiles_volume *volume = object->volume;
+	struct dentry *dentry, *fan = volume->fanout[(u8)object->key_hash];
+	bool success = false;
+	int ret;
+
+	_enter(",%pD", object->file);
+
+	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
+	ret = cachefiles_inject_read_error();
+	if (ret == 0)
+		dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+	else
+		dentry = ERR_PTR(ret);
+	if (IS_ERR(dentry)) {
+		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
+					   cachefiles_trace_lookup_error);
+		_debug("lookup fail %ld", PTR_ERR(dentry));
+		goto out_unlock;
+	}
+
+	if (!d_is_negative(dentry)) {
+		if (d_backing_inode(dentry) == file_inode(object->file)) {
+			success = true;
+			goto out_dput;
+		}
+
+		ret = cachefiles_unlink(object, fan, dentry, FSCACHE_OBJECT_IS_STALE);
+		if (ret < 0) {
+			trace_cachefiles_vfs_error(object, d_inode(fan), ret,
+						   cachefiles_trace_unlink_error);
+			goto out_dput;
+		}
+
+		dput(dentry);
+		ret = cachefiles_inject_read_error();
+		if (ret == 0)
+			dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+		else
+			dentry = ERR_PTR(ret);
+		if (IS_ERR(dentry)) {
+			trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
+						   cachefiles_trace_lookup_error);
+			_debug("lookup fail %ld", PTR_ERR(dentry));
+			goto out_unlock;
+		}
+	}
+
+	ret = cachefiles_inject_read_error();
+	if (ret == 0)
+		ret = vfs_link(object->file->f_path.dentry, &init_user_ns,
+			       d_inode(fan), dentry, NULL);
+	if (ret < 0) {
+		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
+					   cachefiles_trace_link_error);
+		_debug("link fail %d", ret);
+	} else {
+		trace_cachefiles_link(object, file_inode(object->file));
+		spin_lock(&object->lock);
+		/* TODO: Do we want to switch the file pointer to the new dentry? */
+		clear_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
+		spin_unlock(&object->lock);
+		success = true;
+	}
+
+out_dput:
+	dput(dentry);
+out_unlock:
+	inode_unlock(d_inode(fan));
+	_leave(" = %u", success);
+	return success;
+}
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
new file mode 100644
index 000000000000..0601c46a22ef
--- /dev/null
+++ b/fs/cachefiles/xattr.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* CacheFiles extended attribute management
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/fsnotify.h>
+#include <linux/quotaops.h>
+#include <linux/xattr.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+#define CACHEFILES_COOKIE_TYPE_DATA 1
+
+struct cachefiles_xattr {
+	__be64	object_size;	/* Actual size of the object */
+	__be64	zero_point;	/* Size after which server has no data not written by us */
+	__u8	type;		/* Type of object */
+	__u8	content;	/* Content presence (enum cachefiles_content) */
+	__u8	data[];		/* netfs coherency data */
+} __packed;
+
+static const char cachefiles_xattr_cache[] =
+	XATTR_USER_PREFIX "CacheFiles.cache";
+
+/*
+ * set the state xattr on a cache file
+ */
+int cachefiles_set_object_xattr(struct cachefiles_object *object)
+{
+	struct cachefiles_xattr *buf;
+	struct dentry *dentry;
+	struct file *file = object->file;
+	unsigned int len = object->cookie->aux_len;
+	int ret;
+
+	if (!file)
+		return -ESTALE;
+	dentry = file->f_path.dentry;
+
+	_enter("%x,#%d", object->debug_id, len);
+
+	buf = kmalloc(sizeof(struct cachefiles_xattr) + len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf->object_size	= cpu_to_be64(object->cookie->object_size);
+	buf->zero_point		= 0;
+	buf->type		= CACHEFILES_COOKIE_TYPE_DATA;
+	buf->content		= object->content_info;
+	if (test_bit(FSCACHE_COOKIE_LOCAL_WRITE, &object->cookie->flags))
+		buf->content	= CACHEFILES_CONTENT_DIRTY;
+	if (len > 0)
+		memcpy(buf->data, fscache_get_aux(object->cookie), len);
+
+	ret = cachefiles_inject_write_error();
+	if (ret == 0)
+		ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
+				   buf, sizeof(struct cachefiles_xattr) + len, 0);
+	if (ret < 0) {
+		trace_cachefiles_vfs_error(object, file_inode(file), ret,
+					   cachefiles_trace_setxattr_error);
+		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+					   buf->content,
+					   cachefiles_coherency_set_fail);
+		if (ret != -ENOMEM)
+			cachefiles_io_error_obj(
+				object,
+				"Failed to set xattr with error %d", ret);
+	} else {
+		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+					   buf->content,
+					   cachefiles_coherency_set_ok);
+	}
+
+	kfree(buf);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * check the consistency between the backing cache and the FS-Cache cookie
+ */
+int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file)
+{
+	struct cachefiles_xattr *buf;
+	struct dentry *dentry = file->f_path.dentry;
+	unsigned int len = object->cookie->aux_len, tlen;
+	const void *p = fscache_get_aux(object->cookie);
+	enum cachefiles_coherency_trace why;
+	ssize_t xlen;
+	int ret = -ESTALE;
+
+	tlen = sizeof(struct cachefiles_xattr) + len;
+	buf = kmalloc(tlen, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	xlen = cachefiles_inject_read_error();
+	if (xlen == 0)
+		xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, buf, tlen);
+	if (xlen != tlen) {
+		if (xlen < 0)
+			trace_cachefiles_vfs_error(object, file_inode(file), xlen,
+						   cachefiles_trace_getxattr_error);
+		if (xlen == -EIO)
+			cachefiles_io_error_obj(
+				object,
+				"Failed to read aux with error %zd", xlen);
+		why = cachefiles_coherency_check_xattr;
+	} else if (buf->type != CACHEFILES_COOKIE_TYPE_DATA) {
+		why = cachefiles_coherency_check_type;
+	} else if (memcmp(buf->data, p, len) != 0) {
+		why = cachefiles_coherency_check_aux;
+	} else if (be64_to_cpu(buf->object_size) != object->cookie->object_size) {
+		why = cachefiles_coherency_check_objsize;
+	} else if (buf->content == CACHEFILES_CONTENT_DIRTY) {
+		// TODO: Begin conflict resolution
+		pr_warn("Dirty object in cache\n");
+		why = cachefiles_coherency_check_dirty;
+	} else {
+		why = cachefiles_coherency_check_ok;
+		ret = 0;
+	}
+
+	trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+				   buf->content, why);
+	kfree(buf);
+	return ret;
+}
+
+/*
+ * remove the object's xattr to mark it stale
+ */
+int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
+				   struct cachefiles_object *object,
+				   struct dentry *dentry)
+{
+	int ret;
+
+	ret = cachefiles_inject_remove_error();
+	if (ret == 0)
+		ret = vfs_removexattr(&init_user_ns, dentry, cachefiles_xattr_cache);
+	if (ret < 0) {
+		trace_cachefiles_vfs_error(object, d_inode(dentry), ret,
+					   cachefiles_trace_remxattr_error);
+		if (ret == -ENOENT || ret == -ENODATA)
+			ret = 0;
+		else if (ret != -ENOMEM)
+			cachefiles_io_error(cache,
+					    "Can't remove xattr from %lu"
+					    " (error %d)",
+					    d_backing_inode(dentry)->i_ino, -ret);
+	}
+
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Stick a marker on the cache object to indicate that it's dirty.
+ */
+void cachefiles_prepare_to_write(struct fscache_cookie *cookie)
+{
+	const struct cred *saved_cred;
+	struct cachefiles_object *object = cookie->cache_priv;
+	struct cachefiles_cache *cache = object->volume->cache;
+
+	_enter("c=%08x", object->cookie->debug_id);
+
+	if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
+		cachefiles_begin_secure(cache, &saved_cred);
+		cachefiles_set_object_xattr(object);
+		cachefiles_end_secure(cache, saved_cred);
+	}
+}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 908ea452a2cf..336739fed3e9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2250,6 +2250,7 @@ struct super_operations {
 #define S_ENCRYPTED	(1 << 14) /* Encrypted file (using fs/crypto/) */
 #define S_CASEFOLD	(1 << 15) /* Casefolded file */
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
+#define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 9bd5a8a60801..5412991ab5e1 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -18,6 +18,60 @@
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
+enum fscache_why_object_killed {
+	FSCACHE_OBJECT_IS_STALE,
+	FSCACHE_OBJECT_IS_WEIRD,
+	FSCACHE_OBJECT_INVALIDATED,
+	FSCACHE_OBJECT_NO_SPACE,
+	FSCACHE_OBJECT_WAS_RETIRED,
+	FSCACHE_OBJECT_WAS_CULLED,
+};
+
+enum cachefiles_coherency_trace {
+	cachefiles_coherency_check_aux,
+	cachefiles_coherency_check_content,
+	cachefiles_coherency_check_dirty,
+	cachefiles_coherency_check_len,
+	cachefiles_coherency_check_objsize,
+	cachefiles_coherency_check_ok,
+	cachefiles_coherency_check_type,
+	cachefiles_coherency_check_xattr,
+	cachefiles_coherency_set_fail,
+	cachefiles_coherency_set_ok,
+};
+
+enum cachefiles_trunc_trace {
+	cachefiles_trunc_dio_adjust,
+	cachefiles_trunc_expand_tmpfile,
+	cachefiles_trunc_shrink,
+};
+
+enum cachefiles_prepare_read_trace {
+	cachefiles_trace_read_after_eof,
+	cachefiles_trace_read_found_hole,
+	cachefiles_trace_read_found_part,
+	cachefiles_trace_read_have_data,
+	cachefiles_trace_read_no_data,
+	cachefiles_trace_read_no_file,
+	cachefiles_trace_read_seek_error,
+	cachefiles_trace_read_seek_nxio,
+};
+
 enum cachefiles_error_trace {
 	cachefiles_trace_fallocate_error,
 	cachefiles_trace_getxattr_error,
@@ -43,6 +97,55 @@ enum cachefiles_error_trace {
 /*
  * Define enum -> string mappings for display.
  */
+#define cachefiles_obj_kill_traces				\
+	EM(FSCACHE_OBJECT_IS_STALE,	"stale")		\
+	EM(FSCACHE_OBJECT_IS_WEIRD,	"weird")		\
+	EM(FSCACHE_OBJECT_INVALIDATED,	"inval")		\
+	EM(FSCACHE_OBJECT_NO_SPACE,	"no_space")		\
+	EM(FSCACHE_OBJECT_WAS_RETIRED,	"was_retired")		\
+	E_(FSCACHE_OBJECT_WAS_CULLED,	"was_culled")
+
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
+#define cachefiles_coherency_traces					\
+	EM(cachefiles_coherency_check_aux,	"BAD aux ")		\
+	EM(cachefiles_coherency_check_content,	"BAD cont")		\
+	EM(cachefiles_coherency_check_dirty,	"BAD dirt")		\
+	EM(cachefiles_coherency_check_len,	"BAD len ")		\
+	EM(cachefiles_coherency_check_objsize,	"BAD osiz")		\
+	EM(cachefiles_coherency_check_ok,	"OK      ")		\
+	EM(cachefiles_coherency_check_type,	"BAD type")		\
+	EM(cachefiles_coherency_check_xattr,	"BAD xatt")		\
+	EM(cachefiles_coherency_set_fail,	"SET fail")		\
+	E_(cachefiles_coherency_set_ok,		"SET ok  ")
+
+#define cachefiles_trunc_traces						\
+	EM(cachefiles_trunc_dio_adjust,		"DIOADJ")		\
+	EM(cachefiles_trunc_expand_tmpfile,	"EXPTMP")		\
+	E_(cachefiles_trunc_shrink,		"SHRINK")
+
+#define cachefiles_prepare_read_traces					\
+	EM(cachefiles_trace_read_after_eof,	"after-eof ")		\
+	EM(cachefiles_trace_read_found_hole,	"found-hole")		\
+	EM(cachefiles_trace_read_found_part,	"found-part")		\
+	EM(cachefiles_trace_read_have_data,	"have-data ")		\
+	EM(cachefiles_trace_read_no_data,	"no-data   ")		\
+	EM(cachefiles_trace_read_no_file,	"no-file   ")		\
+	EM(cachefiles_trace_read_seek_error,	"seek-error")		\
+	E_(cachefiles_trace_read_seek_nxio,	"seek-enxio")
+
 #define cachefiles_error_traces						\
 	EM(cachefiles_trace_fallocate_error,	"fallocate")		\
 	EM(cachefiles_trace_getxattr_error,	"getxattr")		\
@@ -71,6 +174,11 @@ enum cachefiles_error_trace {
 #define EM(a, b) TRACE_DEFINE_ENUM(a);
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 
+cachefiles_obj_kill_traces;
+cachefiles_obj_ref_traces;
+cachefiles_coherency_traces;
+cachefiles_trunc_traces;
+cachefiles_prepare_read_traces;
 cachefiles_error_traces;
 
 /*
@@ -83,6 +191,252 @@ cachefiles_error_traces;
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
+TRACE_EVENT(cachefiles_lookup,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct dentry *de),
+
+	    TP_ARGS(obj, de),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj	)
+		    __field(short,			error	)
+		    __field(unsigned long,		ino	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->ino	= (!IS_ERR(de) && d_backing_inode(de) ?
+					   d_backing_inode(de)->i_ino : 0);
+		    __entry->error	= IS_ERR(de) ? PTR_ERR(de) : 0;
+			   ),
+
+	    TP_printk("o=%08x i=%lx e=%d",
+		      __entry->obj, __entry->ino, __entry->error)
+	    );
+
+TRACE_EVENT(cachefiles_tmpfile,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer),
+
+	    TP_ARGS(obj, backer),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->backer	= backer->i_ino;
+			   ),
+
+	    TP_printk("o=%08x b=%08x",
+		      __entry->obj,
+		      __entry->backer)
+	    );
+
+TRACE_EVENT(cachefiles_link,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer),
+
+	    TP_ARGS(obj, backer),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->backer	= backer->i_ino;
+			   ),
+
+	    TP_printk("o=%08x b=%08x",
+		      __entry->obj,
+		      __entry->backer)
+	    );
+
+TRACE_EVENT(cachefiles_unlink,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct dentry *de,
+		     enum fscache_why_object_killed why),
+
+	    TP_ARGS(obj, de, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj		)
+		    __field(struct dentry *,		de		)
+		    __field(enum fscache_why_object_killed, why		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : UINT_MAX;
+		    __entry->de		= de;
+		    __entry->why	= why;
+			   ),
+
+	    TP_printk("o=%08x d=%p w=%s",
+		      __entry->obj, __entry->de,
+		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
+	    );
+
+TRACE_EVENT(cachefiles_rename,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct dentry *de,
+		     struct dentry *to,
+		     enum fscache_why_object_killed why),
+
+	    TP_ARGS(obj, de, to, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj		)
+		    __field(struct dentry *,		de		)
+		    __field(struct dentry *,		to		)
+		    __field(enum fscache_why_object_killed, why		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : UINT_MAX;
+		    __entry->de		= de;
+		    __entry->to		= to;
+		    __entry->why	= why;
+			   ),
+
+	    TP_printk("o=%08x d=%p t=%p w=%s",
+		      __entry->obj, __entry->de, __entry->to,
+		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
+	    );
+
+TRACE_EVENT(cachefiles_mark_active,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct inode *inode),
+
+	    TP_ARGS(obj, inode),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj		)
+		    __field(ino_t,			inode		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->inode	= inode->i_ino;
+			   ),
+
+	    TP_printk("o=%08x i=%lx",
+		      __entry->obj, __entry->inode)
+	    );
+
+TRACE_EVENT(cachefiles_mark_inactive,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct inode *inode),
+
+	    TP_ARGS(obj, inode),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj		)
+		    __field(ino_t,			inode		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->inode	= inode->i_ino;
+			   ),
+
+	    TP_printk("o=%08x i=%lx",
+		      __entry->obj, __entry->inode)
+	    );
+
+TRACE_EVENT(cachefiles_coherency,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     ino_t ino,
+		     enum cachefiles_content content,
+		     enum cachefiles_coherency_trace why),
+
+	    TP_ARGS(obj, ino, content, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(enum cachefiles_coherency_trace,	why	)
+		    __field(enum cachefiles_content,		content	)
+		    __field(u64,				ino	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->why	= why;
+		    __entry->content	= content;
+		    __entry->ino	= ino;
+			   ),
+
+	    TP_printk("o=%08x %s i=%llx c=%u",
+		      __entry->obj,
+		      __print_symbolic(__entry->why, cachefiles_coherency_traces),
+		      __entry->ino,
+		      __entry->content)
+	    );
+
+TRACE_EVENT(cachefiles_trunc,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
+		     loff_t from, loff_t to, enum cachefiles_trunc_trace why),
+
+	    TP_ARGS(obj, backer, from, to, why),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(enum cachefiles_trunc_trace,	why	)
+		    __field(loff_t,				from	)
+		    __field(loff_t,				to	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->backer	= backer->i_ino;
+		    __entry->from	= from;
+		    __entry->to		= to;
+		    __entry->why	= why;
+			   ),
+
+	    TP_printk("o=%08x b=%08x %s l=%llx->%llx",
+		      __entry->obj,
+		      __entry->backer,
+		      __print_symbolic(__entry->why, cachefiles_trunc_traces),
+		      __entry->from,
+		      __entry->to)
+	    );
+
 TRACE_EVENT(cachefiles_vfs_error,
 	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
 		     int error, enum cachefiles_error_trace where),
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index b01784370963..3ebb874b5f0f 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -48,6 +48,7 @@ enum fscache_volume_trace {
 enum fscache_cookie_trace {
 	fscache_cookie_collision,
 	fscache_cookie_discard,
+	fscache_cookie_get_attach_object,
 	fscache_cookie_get_end_access,
 	fscache_cookie_get_hash_collision,
 	fscache_cookie_get_inval_work,
@@ -56,6 +57,7 @@ enum fscache_cookie_trace {
 	fscache_cookie_new_acquire,
 	fscache_cookie_put_hash_collision,
 	fscache_cookie_put_lru,
+	fscache_cookie_put_object,
 	fscache_cookie_put_over_queued,
 	fscache_cookie_put_relinquish,
 	fscache_cookie_put_withdrawn,
@@ -119,6 +121,7 @@ enum fscache_access_trace {
 #define fscache_cookie_traces						\
 	EM(fscache_cookie_collision,		"*COLLIDE*")		\
 	EM(fscache_cookie_discard,		"DISCARD  ")		\
+	EM(fscache_cookie_get_attach_object,	"GET attch")		\
 	EM(fscache_cookie_get_hash_collision,	"GET hcoll")		\
 	EM(fscache_cookie_get_end_access,	"GQ  endac")		\
 	EM(fscache_cookie_get_inval_work,	"GQ  inval")		\
@@ -127,6 +130,7 @@ enum fscache_access_trace {
 	EM(fscache_cookie_new_acquire,		"NEW acq  ")		\
 	EM(fscache_cookie_put_hash_collision,	"PUT hcoll")		\
 	EM(fscache_cookie_put_lru,		"PUT lru  ")		\
+	EM(fscache_cookie_put_object,		"PUT obj  ")		\
 	EM(fscache_cookie_put_over_queued,	"PQ  overq")		\
 	EM(fscache_cookie_put_relinquish,	"PUT relnq")		\
 	EM(fscache_cookie_put_withdrawn,	"PUT wthdn")		\


