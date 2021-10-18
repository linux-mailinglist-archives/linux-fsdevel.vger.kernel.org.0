Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B0D432198
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhJRPFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233827AbhJRPEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yningHCiF+JNcaDdJUvwrvzRunm5YGgC/t3Jjc4joZU=;
        b=X0kPCaKmvJfMbUzS2ymnbrvd3XQEWRaWpZg4vYG37N+BUYVaiAZ4O7q7Rgkd1Tiz0+DXBt
        AOWptXAnxY+lcAizqO/2sDaGXVkzoTnFklis0CRlABTeDiYTpYXo1UQCLGlzMJWsiMVQS9
        sdGpVsGX30+J3MEKdkoyoKTzmPA8qjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-HgCP1VLlPdO0Eavo72OJyw-1; Mon, 18 Oct 2021 11:01:49 -0400
X-MC-Unique: HgCP1VLlPdO0Eavo72OJyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B39F872FEF;
        Mon, 18 Oct 2021 15:01:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5405380;
        Mon, 18 Oct 2021 15:01:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 45/67] cachefiles: Simplify the file lookup/creation/check
 code
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
Date:   Mon, 18 Oct 2021 16:01:42 +0100
Message-ID: <163456930292.2614702.7454348292713792435.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplify the code that does file lookup, creation and checking.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c         |    4 -
 fs/cachefiles/internal.h          |   11 +
 fs/cachefiles/io.c                |    2 
 fs/cachefiles/namei.c             |  276 ++++++++++++++++++++-----------------
 fs/cachefiles/xattr.c             |    6 -
 include/trace/events/cachefiles.h |    2 
 6 files changed, 160 insertions(+), 141 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 96a703d5f62c..38ae34b7aaf4 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -79,7 +79,7 @@ static bool cachefiles_lookup_cookie(struct fscache_cookie *cookie)
 
 	/* look up the key, creating any missing bits */
 	cachefiles_begin_secure(cache, &saved_cred);
-	success = cachefiles_walk_to_object(object);
+	success = cachefiles_look_up_object(object);
 	cachefiles_end_secure(cache, saved_cred);
 
 	if (!success)
@@ -222,7 +222,7 @@ static void cachefiles_clean_up_object(struct cachefiles_object *object,
 		cachefiles_commit_object(object, cache);
 	}
 
-	cachefiles_unmark_inode_in_use(object);
+	cachefiles_unmark_inode_in_use(object, object->file);
 	if (object->file) {
 		fput(object->file);
 		object->file = NULL;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 6cc22c85c8f2..a2d2ed2f19eb 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -58,8 +58,7 @@ struct cachefiles_object {
 	u8				d_name_len;	/* Length of filename */
 	u8				key_hash;	/* Hash of object key */
 	unsigned long			flags;
-#define CACHEFILES_OBJECT_IS_NEW	0		/* Set if object is new */
-#define CACHEFILES_OBJECT_USING_TMPFILE	1		/* Have an unlinked tmpfile */
+#define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 };
 
 extern struct kmem_cache *cachefiles_object_jar;
@@ -171,7 +170,8 @@ extern bool cachefiles_cook_key(struct cachefiles_object *object);
 /*
  * namei.c
  */
-extern void cachefiles_unmark_inode_in_use(struct cachefiles_object *object);
+extern void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
+					   struct file *file);
 extern int cachefiles_bury_object(struct cachefiles_cache *cache,
 				  struct cachefiles_object *object,
 				  struct dentry *dir,
@@ -179,7 +179,7 @@ extern int cachefiles_bury_object(struct cachefiles_cache *cache,
 				  enum fscache_why_object_killed why);
 extern int cachefiles_delete_object(struct cachefiles_object *object,
 				    enum fscache_why_object_killed why);
-extern bool cachefiles_walk_to_object(struct cachefiles_object *object);
+extern bool cachefiles_look_up_object(struct cachefiles_object *object);
 extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					       struct dentry *dir,
 					       const char *name);
@@ -224,7 +224,8 @@ void cachefiles_withdraw_volume(struct cachefiles_volume *volume);
  * xattr.c
  */
 extern int cachefiles_set_object_xattr(struct cachefiles_object *object);
-extern int cachefiles_check_auxdata(struct cachefiles_object *object);
+extern int cachefiles_check_auxdata(struct cachefiles_object *object,
+				    struct file *file);
 extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 					  struct dentry *dentry);
 
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 67ea9f44931f..9b3b55a94e66 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -525,7 +525,7 @@ bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
 
 	if (!cachefiles_cres_file(cres)) {
 		cres->ops = &cachefiles_netfs_cache_ops;
-		if (object) {
+		if (object->file) {
 			spin_lock(&object->lock);
 			if (!cres->cache_priv2 && object->file)
 				cres->cache_priv2 = get_file(object->file);
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 0edf1276768b..989df918570b 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -21,9 +21,10 @@
 /*
  * Mark the backing file as being a cache file if it's not already in use so.
  */
-static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object)
+static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object,
+					 struct dentry *dentry)
 {
-	struct inode *inode = file_inode(object->file);
+	struct inode *inode = d_backing_inode(dentry);
 	bool can_use = false;
 
 	_enter(",%x", object->debug_id);
@@ -45,9 +46,10 @@ static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object)
 /*
  * Unmark a backing inode.
  */
-void cachefiles_unmark_inode_in_use(struct cachefiles_object *object)
+void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
+				    struct file *file)
 {
-	struct inode *inode = file_inode(object->file);
+	struct inode *inode = file_inode(file);
 
 	if (!inode)
 		return;
@@ -61,10 +63,11 @@ void cachefiles_unmark_inode_in_use(struct cachefiles_object *object)
 /*
  * Mark an object as being inactive.
  */
-static void cachefiles_mark_object_inactive(struct cachefiles_object *object)
+static void cachefiles_mark_object_inactive(struct cachefiles_object *object,
+					    struct file *file)
 {
 	struct cachefiles_cache *cache = object->volume->cache;
-	blkcnt_t i_blocks = file_inode(object->file)->i_blocks;
+	blkcnt_t i_blocks = file_inode(file)->i_blocks;
 
 	/* This object can now be culled, so we need to let the daemon know
 	 * that there is something it can remove if it needs to.
@@ -232,191 +235,180 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 	return 0;
 }
 
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
+		ret = vfs_unlink(&init_user_ns, d_backing_inode(fan), dentry, NULL);
+	return ret;
+}
+
 /*
- * delete an object representation from the cache
+ * Delete a cache file.
  */
 int cachefiles_delete_object(struct cachefiles_object *object,
 			     enum fscache_why_object_killed why)
 {
 	struct cachefiles_volume *volume = object->volume;
+	struct dentry *dentry = object->file->f_path.dentry;
 	struct dentry *fan = volume->fanout[(u8)object->key_hash];
+	int ret;
 
 	_enter(",OBJ%x{%pD}", object->debug_id, object->file);
 
+	/* Stop the dentry being negated if it's only pinned by a file struct. */
+	dget(dentry);
+
 	inode_lock_nested(d_backing_inode(fan), I_MUTEX_PARENT);
-	return cachefiles_bury_object(volume->cache, object, fan,
-				      object->file->f_path.dentry, why);
+	ret = cachefiles_unlink(object, fan, dentry, why);
+	inode_unlock(d_backing_inode(fan));
+	dput(dentry);
+
+	if (ret < 0 && ret != -ENOENT)
+		cachefiles_io_error(volume->cache, "Unlink failed");
+	return ret;
 }
 
 /*
- * Check the attributes on a file we've just opened and delete it if it's out
- * of date.
+ * Create a new file.
  */
-static int cachefiles_check_open_object(struct cachefiles_object *object,
-					struct dentry *fan)
+static bool cachefiles_create_file(struct cachefiles_object *object)
 {
+	struct file *file;
 	int ret;
 
-	if (!cachefiles_mark_inode_in_use(object))
-		return -EBUSY;
-
-	_enter("%pD", object->file);
-
-	ret = cachefiles_check_auxdata(object);
-	if (ret == -ESTALE)
-		goto stale;
+	ret = cachefiles_has_space(object->volume->cache, 1, 0);
 	if (ret < 0)
-		goto error_unmark;
+		return false;
 
-	/* Always update the atime on an object we've just looked up (this is
-	 * used to keep track of culling, and atimes are only updated by read,
-	 * write and readdir but not lookup or open).
-	 */
-	touch_atime(&object->file->f_path);
-	return 0;
-
-stale:
-	set_bit(CACHEFILES_OBJECT_IS_NEW, &object->flags);
-	fscache_cookie_lookup_negative(object->cookie);
-	cachefiles_unmark_inode_in_use(object);
-	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
-	ret = cachefiles_bury_object(object->volume->cache, object, fan,
-				     object->file->f_path.dentry,
-				     FSCACHE_OBJECT_IS_STALE);
-	if (ret < 0)
-		return ret;
-	cachefiles_mark_object_inactive(object);
-	_debug("redo lookup");
-	return -ESTALE;
+	file = cachefiles_create_tmpfile(object);
+	if (IS_ERR(file))
+		return false;
 
-error_unmark:
-	cachefiles_unmark_inode_in_use(object);
-	return ret;
+	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags);
+	set_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
+	_debug("create -> %pD{ino=%lu}", file, file_inode(file)->i_ino);
+	object->file = file;
+	return true;
 }
 
 /*
- * Look up a file, creating it if necessary.
+ * Open an existing file, checking its attributes and replacing it if it is
+ * stale.
  */
-static int cachefiles_open_file(struct cachefiles_object *object,
-				struct dentry *fan)
+static bool cachefiles_open_file(struct cachefiles_object *object,
+				 struct dentry *dentry)
 {
 	struct cachefiles_cache *cache = object->volume->cache;
-	struct dentry *dentry;
 	struct file *file;
 	struct path path;
 	int ret;
 
-	_enter("%pd %s", fan, object->d_name);
+	_enter("%pd", dentry);
 
-	dentry = lookup_positive_unlocked(object->d_name, fan, object->d_name_len);
-	trace_cachefiles_lookup(object, dentry);
-	if (dentry == ERR_PTR(-ENOENT)) {
-		set_bit(CACHEFILES_OBJECT_IS_NEW, &object->flags);
-		fscache_cookie_lookup_negative(object->cookie);
-
-		ret = cachefiles_has_space(cache, 1, 0);
-		if (ret < 0)
-			goto error;
+	if (!cachefiles_mark_inode_in_use(object, dentry))
+		return false;
 
-		file = cachefiles_create_tmpfile(object);
-		if (IS_ERR(file)) {
-			ret = PTR_ERR(file);
-			goto error;
-		}
+	/* We need to open a file interface onto a data file now as we can't do
+	 * it on demand because writeback called from do_exit() sees
+	 * current->fs == NULL - which breaks d_path() called from ext4 open.
+	 */
+	path.mnt = cache->mnt;
+	path.dentry = dentry;
+	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
+				   d_backing_inode(dentry), cache->cache_cred);
+	if (IS_ERR(file))
+		goto error;
 
-		set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags);
-		set_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
-		_debug("create -> %pD{ino=%lu}", file, file_inode(file)->i_ino);
-		goto out;
+	if (unlikely(!file->f_op->read_iter) ||
+	    unlikely(!file->f_op->write_iter)) {
+		pr_notice("Cache does not support read_iter and write_iter\n");
+		goto error_fput;
 	}
+	_debug("file -> %pd positive", dentry);
 
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto error;
-	}
+	ret = cachefiles_check_auxdata(object, file);
+	if (ret < 0)
+		goto check_failed;
 
-	if (!d_is_reg(dentry)) {
-		pr_err("%pd is not a file\n", dentry);
-		dput(dentry);
-		ret = -EIO;
-		goto error;
-	} else {
-		clear_bit(CACHEFILES_OBJECT_IS_NEW, &object->flags);
+	object->file = file;
 
-		/* We need to open a file interface onto a data file now as we
-		 * can't do it on demand because writeback called from
-		 * do_exit() sees current->fs == NULL - which breaks d_path()
-		 * called from ext4 open.
-		 */
-		path.mnt = cache->mnt;
-		path.dentry = dentry;
-		file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
-					   d_backing_inode(dentry), cache->cache_cred);
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
 		dput(dentry);
-		if (IS_ERR(file)) {
-			ret = PTR_ERR(file);
-			goto error;
-		}
-		if (unlikely(!file->f_op->read_iter) ||
-		    unlikely(!file->f_op->write_iter)) {
-			pr_notice("Cache does not support read_iter and write_iter\n");
-			ret = -EIO;
-			goto error_fput;
-		}
-		_debug("file -> %pd positive", dentry);
+		return cachefiles_create_file(object);
 	}
-
-out:
-	object->file = file;
-	return 0;
 error_fput:
 	fput(file);
 error:
-	return ret;
+	dput(dentry);
+	return false;
 }
 
 /*
  * walk from the parent object to the child object through the backing
  * filesystem, creating directories as we go
  */
-bool cachefiles_walk_to_object(struct cachefiles_object *object)
+bool cachefiles_look_up_object(struct cachefiles_object *object)
 {
-	struct cachefiles_volume *volume = object->cookie->volume->cache_priv;
-	struct dentry *fan;
+	struct cachefiles_volume *volume = object->volume;
+	struct dentry *dentry, *fan = volume->fanout[(u8)object->key_hash];
 	int ret;
 
 	_enter("OBJ%x,%s,", object->debug_id, object->d_name);
 
-lookup_again:
-	/* Open path "cache/vol/fanout/file". */
-	fan = volume->fanout[(u8)object->key_hash];
-	ret = cachefiles_open_file(object, fan);
-	if (ret < 0)
-		goto lookup_error;
+	/* Look up path "cache/vol/fanout/file". */
+	dentry = lookup_positive_unlocked(object->d_name, fan, object->d_name_len);
+	trace_cachefiles_lookup(object, dentry);
+	if (IS_ERR(dentry)) {
+		if (dentry == ERR_PTR(-ENOENT))
+			goto new_file;
+		if (dentry == ERR_PTR(-EIO))
+			cachefiles_io_error_obj(object, "Lookup failed");
+		return false;
+	}
 
-	if (!test_bit(CACHEFILES_OBJECT_IS_NEW, &object->flags)) {
-		ret = cachefiles_check_open_object(object, fan);
+	if (!d_is_reg(dentry)) {
+		pr_err("%pd is not a file\n", dentry);
+		inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
+		ret = cachefiles_bury_object(volume->cache, object, fan, dentry,
+					     FSCACHE_OBJECT_IS_WEIRD);
+		dput(dentry);
 		if (ret < 0)
-			goto check_error;
-	} else {
-		ret = -EBUSY;
-		if (!cachefiles_mark_inode_in_use(object))
-			goto check_error;
+			return false;
+		goto new_file;
 	}
 
-	clear_bit(CACHEFILES_OBJECT_IS_NEW, &object->flags);
+	if (!cachefiles_open_file(object, dentry))
+		return false;
+
 	_leave(" = t [%lu]", file_inode(object->file)->i_ino);
 	return true;
 
-check_error:
-	fput(object->file);
-	object->file = NULL;
-	if (ret == -ESTALE)
-		goto lookup_again;
-lookup_error:
-	if (ret == -EIO)
-		cachefiles_io_error_obj(object, "Lookup failed");
-	return false;
+new_file:
+	fscache_cookie_lookup_negative(object->cookie);
+	return cachefiles_create_file(object);
 }
 
 /*
@@ -709,6 +701,11 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 
 	trace_cachefiles_tmpfile(object, d_backing_inode(path.dentry));
 
+	if (!cachefiles_mark_inode_in_use(object, path.dentry)) {
+		file = ERR_PTR(-EBUSY);
+		goto out_dput;
+	}
+
 	if (ni_size > 0) {
 		trace_cachefiles_trunc(object, d_backing_inode(path.dentry), 0, ni_size,
 				       cachefiles_trunc_expand_tmpfile);
@@ -757,6 +754,24 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 		goto out_unlock;
 	}
 
+	if (!d_is_negative(dentry)) {
+		if (d_backing_inode(dentry) == file_inode(object->file)) {
+			success = true;
+			goto out_dput;
+		}
+
+		ret = cachefiles_unlink(object, fan, dentry, FSCACHE_OBJECT_IS_STALE);
+		if (ret < 0)
+			goto out_dput;
+
+		dput(dentry);
+		dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+		if (IS_ERR(dentry)) {
+			_debug("lookup fail %ld", PTR_ERR(dentry));
+			goto out_unlock;
+		}
+	}
+
 	ret = vfs_link(object->file->f_path.dentry, &init_user_ns,
 		       d_inode(fan), dentry, NULL);
 	if (ret < 0) {
@@ -770,6 +785,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 		success = true;
 	}
 
+out_dput:
 	dput(dentry);
 out_unlock:
 	inode_unlock(d_inode(fan));
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index b77bbb6c4a17..50b2a4588946 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -74,10 +74,10 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 /*
  * check the consistency between the backing cache and the FS-Cache cookie
  */
-int cachefiles_check_auxdata(struct cachefiles_object *object)
+int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file)
 {
 	struct cachefiles_xattr *buf;
-	struct dentry *dentry = object->file->f_path.dentry;
+	struct dentry *dentry = file->f_path.dentry;
 	unsigned int len = object->cookie->aux_len, tlen;
 	const void *p = fscache_get_aux(object->cookie);
 	enum cachefiles_coherency_trace why;
@@ -105,7 +105,7 @@ int cachefiles_check_auxdata(struct cachefiles_object *object)
 		ret = 0;
 	}
 
-	trace_cachefiles_coherency(object, file_inode(object->file)->i_ino, 0, why);
+	trace_cachefiles_coherency(object, file_inode(file)->i_ino, 0, why);
 	kfree(buf);
 	return ret;
 }
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index c0632ee8cf69..a7b31b248f2d 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -35,6 +35,7 @@ enum cachefiles_obj_ref_trace {
 
 enum fscache_why_object_killed {
 	FSCACHE_OBJECT_IS_STALE,
+	FSCACHE_OBJECT_IS_WEIRD,
 	FSCACHE_OBJECT_INVALIDATED,
 	FSCACHE_OBJECT_NO_SPACE,
 	FSCACHE_OBJECT_WAS_RETIRED,
@@ -78,6 +79,7 @@ enum cachefiles_prepare_read_trace {
  */
 #define cachefiles_obj_kill_traces				\
 	EM(FSCACHE_OBJECT_IS_STALE,	"stale")		\
+	EM(FSCACHE_OBJECT_IS_WEIRD,	"weird")		\
 	EM(FSCACHE_OBJECT_INVALIDATED,	"inval")		\
 	EM(FSCACHE_OBJECT_NO_SPACE,	"no_space")		\
 	EM(FSCACHE_OBJECT_WAS_RETIRED,	"was_retired")		\


