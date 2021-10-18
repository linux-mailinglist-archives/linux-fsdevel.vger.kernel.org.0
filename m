Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D7C432190
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhJRPFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233555AbhJRPD1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/VMVPY3Zd09milyYLfDMV0nw0wF/nfvqEV6fmUcSps=;
        b=StTyaL0qnueHb74wtf9TnwMx+PdVKEs13P8fLNQ619zRFidNRv8YQWGxQuyH2v3DOEB52+
        DZT6OSzE/9ppDUWVla2lsM5UV3176PlUPKB7hP4UfZjHfF8mkIL9/VeV6OvPH7CoWtDdMu
        zaOmePtr9+XFhm+yMXPNrsaSnHR5/bE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-LJGDIiC4MxavSMMQ0x2aqg-1; Mon, 18 Oct 2021 11:01:12 -0400
X-MC-Unique: LJGDIiC4MxavSMMQ0x2aqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FBC880DDE1;
        Mon, 18 Oct 2021 15:01:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD31A5C1D0;
        Mon, 18 Oct 2021 15:01:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 42/67] cachefiles: Use tmpfile/link
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
Date:   Mon, 18 Oct 2021 16:01:06 +0100
Message-ID: <163456926609.2614702.17249270156115609970.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make cachefiles use a temporary file (created with vfs_tmpfile()) for a new
file rather than creating it immediately.  This means we don't have to wait
exclusively on the directory's inode lock at this point.

The directory entry creation is then deferred to the point at which the
file is committed.  Indeed, if the file is deleted before that point, it
can just be abandoned without ever modifying the directory.

Invalidation is achieved by simply closing the old file and creating a new
tmpfile.  Any in-progress ops hold the old file open till they've finished.
We don't need to cancel them and can just deal with reissuing a read to the
server upon completion (that will be a separate patch).

Note: This would be easier if linkat() could be given a flag to indicate
the destination should be overwritten or if RENAME_EXCHANGE could be
applied to tmpfiles, effectively unlinking the destination.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c         |   85 +++++++++-----
 fs/cachefiles/internal.h          |    9 ++
 fs/cachefiles/namei.c             |  219 ++++++++++++++++++++++++++-----------
 include/trace/events/cachefiles.h |   48 ++++++--
 4 files changed, 251 insertions(+), 110 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index d186a68ff810..a114b59e5b29 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -197,6 +197,9 @@ static void cachefiles_commit_object(struct cachefiles_object *object,
 		update = true;
 	if (update)
 		cachefiles_update_object(object);
+
+	if (test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags))
+		cachefiles_commit_tmpfile(cache, object);
 }
 
 /*
@@ -206,9 +209,14 @@ static void cachefiles_clean_up_object(struct cachefiles_object *object,
 				       struct cachefiles_cache *cache)
 {
 	if (test_bit(FSCACHE_COOKIE_RETIRED, &object->cookie->flags)) {
-		cachefiles_see_object(object, cachefiles_obj_see_clean_delete);
-		_debug("- inval object OBJ%x", object->debug_id);
-		cachefiles_delete_object(object, FSCACHE_OBJECT_WAS_RETIRED);
+		if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
+			cachefiles_see_object(object, cachefiles_obj_see_clean_delete);
+			_debug("- inval object OBJ%x", object->debug_id);
+			cachefiles_delete_object(object, FSCACHE_OBJECT_WAS_RETIRED);
+		} else {
+			cachefiles_see_object(object, cachefiles_obj_see_clean_drop_tmp);
+			_debug("- inval object OBJ%x tmpfile", object->debug_id);
+		}
 	} else {
 		cachefiles_see_object(object, cachefiles_obj_see_clean_commit);
 		cachefiles_commit_object(object, cache);
@@ -372,41 +380,58 @@ static bool cachefiles_invalidate_cookie(struct fscache_cookie *cookie,
 					 unsigned int flags)
 {
 	struct cachefiles_object *object = cookie->cache_priv;
-	struct cachefiles_cache *cache = object->volume->cache;
-	const struct cred *saved_cred;
-	struct file *file = object->file;
-	uint64_t ni_size = cookie->object_size;
-	int ret;
+	struct file *new_file, *old_file;
+	bool old_tmpfile;
 
-	_enter("{OBJ%x},[%llu]",
-	       object->debug_id, (unsigned long long)ni_size);
+	_enter("o=%x,[%llu]", object->debug_id, object->cookie->object_size);
 
-	if (file) {
-		ASSERT(d_is_reg(file->f_path.dentry));
+	old_tmpfile = test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
 
-		cachefiles_begin_secure(cache, &saved_cred);
-		trace_cachefiles_trunc(object, file_inode(file),
-				       i_size_read(file_inode(file)), 0,
-				       cachefiles_trunc_invalidate);
-		ret = vfs_truncate(&file->f_path, 0);
-		if (ret == 0) {
-			ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
-			trace_cachefiles_trunc(object, file_inode(file),
-					       0, ni_size,
-					       cachefiles_trunc_set_size);
-			ret = vfs_truncate(&file->f_path, ni_size);
-		}
-		cachefiles_end_secure(cache, saved_cred);
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
+	set_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
+	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags);
+
+	spin_unlock(&object->lock);
+	_debug("subbed");
+
+	/* Allow I/O to take place again */
+	fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_ACTIVE);
 
-		if (ret != 0) {
-			if (ret == -EIO)
-				cachefiles_io_error_obj(object,
-							"Invalidate failed");
-			return false;
+	if (old_file) {
+		if (!old_tmpfile) {
+			struct cachefiles_volume *volume = object->volume;
+			struct dentry *fan = volume->fanout[(u8)object->key_hash];
+
+			inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
+			cachefiles_bury_object(volume->cache, object, fan,
+					       old_file->f_path.dentry,
+					       FSCACHE_OBJECT_INVALIDATED);
 		}
+		fput(old_file);
 	}
 
+	_leave(" = t");
 	return true;
+
+failed:
+	fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_FAILED);
+	_leave(" = f");
+	return false;
 }
 
 const struct fscache_cache_ops cachefiles_cache_ops = {
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index d8a70ecbe94a..6cc22c85c8f2 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -59,6 +59,7 @@ struct cachefiles_object {
 	u8				key_hash;	/* Hash of object key */
 	unsigned long			flags;
 #define CACHEFILES_OBJECT_IS_NEW	0		/* Set if object is new */
+#define CACHEFILES_OBJECT_USING_TMPFILE	1		/* Have an unlinked tmpfile */
 };
 
 extern struct kmem_cache *cachefiles_object_jar;
@@ -171,6 +172,11 @@ extern bool cachefiles_cook_key(struct cachefiles_object *object);
  * namei.c
  */
 extern void cachefiles_unmark_inode_in_use(struct cachefiles_object *object);
+extern int cachefiles_bury_object(struct cachefiles_cache *cache,
+				  struct cachefiles_object *object,
+				  struct dentry *dir,
+				  struct dentry *rep,
+				  enum fscache_why_object_killed why);
 extern int cachefiles_delete_object(struct cachefiles_object *object,
 				    enum fscache_why_object_killed why);
 extern bool cachefiles_walk_to_object(struct cachefiles_object *object);
@@ -183,6 +189,9 @@ extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 
 extern int cachefiles_check_in_use(struct cachefiles_cache *cache,
 				   struct dentry *dir, char *filename);
+extern struct file *cachefiles_create_tmpfile(struct cachefiles_object *object);
+extern bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
+				      struct cachefiles_object *object);
 
 /*
  * security.c
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f7e73aba9104..0edf1276768b 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -80,11 +80,11 @@ static void cachefiles_mark_object_inactive(struct cachefiles_object *object)
  * - directory backed objects are stuffed into the graveyard for userspace to
  *   delete
  */
-static int cachefiles_bury_object(struct cachefiles_cache *cache,
-				  struct cachefiles_object *object,
-				  struct dentry *dir,
-				  struct dentry *rep,
-				  enum fscache_why_object_killed why)
+int cachefiles_bury_object(struct cachefiles_cache *cache,
+			   struct cachefiles_object *object,
+			   struct dentry *dir,
+			   struct dentry *rep,
+			   enum fscache_why_object_killed why)
 {
 	struct dentry *grave, *trap;
 	struct path path, path_to_graveyard;
@@ -302,83 +302,73 @@ static int cachefiles_open_file(struct cachefiles_object *object,
 {
 	struct cachefiles_cache *cache = object->volume->cache;
 	struct dentry *dentry;
-	struct inode *dinode = d_backing_inode(fan), *inode;
 	struct file *file;
-	struct path fan_path, path;
+	struct path path;
 	int ret;
 
 	_enter("%pd %s", fan, object->d_name);
 
-	inode_lock_nested(dinode, I_MUTEX_PARENT);
-
-	dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+	dentry = lookup_positive_unlocked(object->d_name, fan, object->d_name_len);
 	trace_cachefiles_lookup(object, dentry);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto error_unlock;
-	}
-
-	if (d_is_negative(dentry)) {
+	if (dentry == ERR_PTR(-ENOENT)) {
+		set_bit(CACHEFILES_OBJECT_IS_NEW, &object->flags);
 		fscache_cookie_lookup_negative(object->cookie);
 
 		ret = cachefiles_has_space(cache, 1, 0);
 		if (ret < 0)
-			goto error_dput;
-
-		fan_path.mnt = cache->mnt;
-		fan_path.dentry = fan;
-		ret = security_path_mknod(&fan_path, dentry, S_IFREG, 0);
-		if (ret < 0)
-			goto error_dput;
-		ret = vfs_create(&init_user_ns, dinode, dentry, S_IFREG, true);
-		trace_cachefiles_create(object, dentry, ret);
-		if (ret < 0)
-			goto error_dput;
+			goto error;
 
-		inode = d_backing_inode(dentry);
-		_debug("create -> %pd{ino=%lu}", dentry, inode->i_ino);
-		set_bit(CACHEFILES_OBJECT_IS_NEW, &object->flags);
+		file = cachefiles_create_tmpfile(object);
+		if (IS_ERR(file)) {
+			ret = PTR_ERR(file);
+			goto error;
+		}
 
-	} else if (!d_is_reg(dentry)) {
-		inode = d_backing_inode(dentry);
-		pr_err("inode %lu is not a file\n", inode->i_ino);
-		ret = -EIO;
-		goto error_dput;
-	} else {
-		inode = d_backing_inode(dentry);
-		_debug("file -> %pd positive", dentry);
+		set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags);
+		set_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
+		_debug("create -> %pD{ino=%lu}", file, file_inode(file)->i_ino);
+		goto out;
 	}
 
-	inode_unlock(dinode);
-
-	/* We need to open a file interface onto a data file now as we can't do
-	 * it on demand because writeback called from do_exit() sees
-	 * current->fs == NULL - which breaks d_path() called from ext4 open.
-	 */
-	path.mnt = cache->mnt;
-	path.dentry = dentry;
-	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
-				   inode, cache->cache_cred);
-	dput(dentry);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
 		goto error;
 	}
-	if (unlikely(!file->f_op->read_iter) ||
-	    unlikely(!file->f_op->write_iter)) {
-		pr_notice("Cache does not support read_iter and write_iter\n");
+
+	if (!d_is_reg(dentry)) {
+		pr_err("%pd is not a file\n", dentry);
+		dput(dentry);
 		ret = -EIO;
-		goto error_fput;
+		goto error;
+	} else {
+		clear_bit(CACHEFILES_OBJECT_IS_NEW, &object->flags);
+
+		/* We need to open a file interface onto a data file now as we
+		 * can't do it on demand because writeback called from
+		 * do_exit() sees current->fs == NULL - which breaks d_path()
+		 * called from ext4 open.
+		 */
+		path.mnt = cache->mnt;
+		path.dentry = dentry;
+		file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
+					   d_backing_inode(dentry), cache->cache_cred);
+		dput(dentry);
+		if (IS_ERR(file)) {
+			ret = PTR_ERR(file);
+			goto error;
+		}
+		if (unlikely(!file->f_op->read_iter) ||
+		    unlikely(!file->f_op->write_iter)) {
+			pr_notice("Cache does not support read_iter and write_iter\n");
+			ret = -EIO;
+			goto error_fput;
+		}
+		_debug("file -> %pd positive", dentry);
 	}
 
+out:
 	object->file = file;
 	return 0;
-
-error_dput:
-	dput(dentry);
-error_unlock:
-	inode_unlock(dinode);
-	return ret;
 error_fput:
 	fput(file);
 error:
@@ -458,9 +448,11 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 
 	/* we need to create the subdir if it doesn't exist yet */
 	if (d_is_negative(subdir)) {
-		ret = cachefiles_has_space(cache, 1, 0);
-		if (ret < 0)
-			goto mkdir_error;
+		if (cache->store) {
+			ret = cachefiles_has_space(cache, 1, 0);
+			if (ret < 0)
+				goto mkdir_error;
+		}
 
 		_debug("attempt mkdir");
 
@@ -498,7 +490,6 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	if (!(d_backing_inode(subdir)->i_opflags & IOP_XATTR) ||
 	    !d_backing_inode(subdir)->i_op->lookup ||
 	    !d_backing_inode(subdir)->i_op->mkdir ||
-	    !d_backing_inode(subdir)->i_op->create ||
 	    !d_backing_inode(subdir)->i_op->rename ||
 	    !d_backing_inode(subdir)->i_op->rmdir ||
 	    !d_backing_inode(subdir)->i_op->unlink)
@@ -687,3 +678,101 @@ int cachefiles_check_in_use(struct cachefiles_cache *cache, struct dentry *dir,
 	//_leave(" = 0");
 	return ret;
 }
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
+	path.mnt = cache->mnt,
+	path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);
+	if (IS_ERR(path.dentry)) {
+		if (PTR_ERR(path.dentry) == -EIO)
+			cachefiles_io_error_obj(object, "Failed to create tmpfile");
+		file = ERR_CAST(path.dentry);
+		goto out;
+	}
+
+	trace_cachefiles_tmpfile(object, d_backing_inode(path.dentry));
+
+	if (ni_size > 0) {
+		trace_cachefiles_trunc(object, d_backing_inode(path.dentry), 0, ni_size,
+				       cachefiles_trunc_expand_tmpfile);
+		ret = vfs_truncate(&path, ni_size);
+		if (ret < 0) {
+			file = ERR_PTR(ret);
+			goto out_dput;
+		}
+	}
+
+	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
+				   d_backing_inode(path.dentry), cache->cache_cred);
+	if (IS_ERR(file))
+		goto out_dput;
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
+	dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+	if (IS_ERR(dentry)) {
+		_debug("lookup fail %ld", PTR_ERR(dentry));
+		goto out_unlock;
+	}
+
+	ret = vfs_link(object->file->f_path.dentry, &init_user_ns,
+		       d_inode(fan), dentry, NULL);
+	if (ret < 0) {
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
+	dput(dentry);
+out_unlock:
+	inode_unlock(d_inode(fan));
+	_leave(" = %u", success);
+	return success;
+}
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index d63e5fb46d27..c0632ee8cf69 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -35,6 +35,7 @@ enum cachefiles_obj_ref_trace {
 
 enum fscache_why_object_killed {
 	FSCACHE_OBJECT_IS_STALE,
+	FSCACHE_OBJECT_INVALIDATED,
 	FSCACHE_OBJECT_NO_SPACE,
 	FSCACHE_OBJECT_WAS_RETIRED,
 	FSCACHE_OBJECT_WAS_CULLED,
@@ -54,9 +55,8 @@ enum cachefiles_coherency_trace {
 };
 
 enum cachefiles_trunc_trace {
-	cachefiles_trunc_invalidate,
-	cachefiles_trunc_set_size,
 	cachefiles_trunc_dio_adjust,
+	cachefiles_trunc_expand_tmpfile,
 	cachefiles_trunc_shrink,
 };
 
@@ -78,6 +78,7 @@ enum cachefiles_prepare_read_trace {
  */
 #define cachefiles_obj_kill_traces				\
 	EM(FSCACHE_OBJECT_IS_STALE,	"stale")		\
+	EM(FSCACHE_OBJECT_INVALIDATED,	"inval")		\
 	EM(FSCACHE_OBJECT_NO_SPACE,	"no_space")		\
 	EM(FSCACHE_OBJECT_WAS_RETIRED,	"was_retired")		\
 	E_(FSCACHE_OBJECT_WAS_CULLED,	"was_culled")
@@ -109,9 +110,8 @@ enum cachefiles_prepare_read_trace {
 	E_(cachefiles_coherency_set_ok,		"SET ok  ")
 
 #define cachefiles_trunc_traces						\
-	EM(cachefiles_trunc_invalidate,		"INVAL ")		\
-	EM(cachefiles_trunc_set_size,		"SETSIZ")		\
 	EM(cachefiles_trunc_dio_adjust,		"DIOADJ")		\
+	EM(cachefiles_trunc_expand_tmpfile,	"EXPTMP")		\
 	E_(cachefiles_trunc_shrink,		"SHRINK")
 
 #define cachefiles_prepare_read_traces					\
@@ -200,26 +200,44 @@ TRACE_EVENT(cachefiles_lookup,
 		      __entry->obj, __entry->ino, __entry->error)
 	    );
 
-TRACE_EVENT(cachefiles_create,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de, int ret),
+TRACE_EVENT(cachefiles_tmpfile,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer),
 
-	    TP_ARGS(obj, de, ret),
+	    TP_ARGS(obj, backer),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj	)
-		    __field(struct dentry *,		de	)
-		    __field(int,			ret	)
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->obj	= obj->debug_id;
-		    __entry->de		= de;
-		    __entry->ret	= ret;
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
 			   ),
 
-	    TP_printk("o=%08x d=%p r=%u",
-		      __entry->obj, __entry->de, __entry->ret)
+	    TP_printk("o=%08x b=%08x",
+		      __entry->obj,
+		      __entry->backer)
 	    );
 
 TRACE_EVENT(cachefiles_unlink,


