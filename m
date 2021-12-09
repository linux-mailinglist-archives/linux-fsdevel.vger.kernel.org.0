Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8446F07C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242268AbhLIRJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:09:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242244AbhLIRI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWbc5bBYMsCRf4CWCnwZsLuskjjr6lLGHgC4ozUYUm0=;
        b=AOLF0XyYocEs8F3xwpeM2GOfo72LHWadbhirVskkfMfP+UGPdJ6GzYYy4n/n/TeXLf8pes
        uQ2PB4nfxzqHUL4ZvLYK1vVaKt37nSuz1ypqrnIE6dSBMt5fuMaYfQteIvv6vzk8QgotgK
        tz5azMDt0sa+hLafi03Hp7CrQJtc6mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-0ROgdFWZMO-fLoV4ts1E_A-1; Thu, 09 Dec 2021 12:05:18 -0500
X-MC-Unique: 0ROgdFWZMO-fLoV4ts1E_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E82CB802C8F;
        Thu,  9 Dec 2021 17:05:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EED7B60C4A;
        Thu,  9 Dec 2021 17:04:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 48/67] cachefiles: Implement backing file wrangling
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
Date:   Thu, 09 Dec 2021 17:04:55 +0000
Message-ID: <163906949512.143852.14222856795032602080.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the wrangling of backing files, including the following pieces:

 (1) Lookup and creation of a file on disk, using a tmpfile if the file
     isn't yet present.  The file is then opened, sized for DIO and the
     file handle is attached to the cachefiles_object struct.  The inode is
     marked to indicate that it's in use by a kernel service.

 (2) Invalidation of an object, creating a tmpfile and switching the file
     pointer in the cachefiles object.

 (3) Committing a file to disk, including setting the coherency xattr on it
     and, if necessary, creating a hard link to it.

     Note that this would be a good place to use Omar Sandoval's vfs_link()
     with AT_LINK_REPLACE[1] as I may have to unlink an old file before I
     can link a tmpfile into place.

 (4) Withdrawal of open objects when a cache is being withdrawn or a cookie
     is relinquished.  This involves committing or discarding the file.

Changes
=======
ver #2:
 - Fix logging of wrong error[1].

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/20211203094950.GA2480@kili/ [1]
Link: https://lore.kernel.org/r/163819644097.215744.4505389616742411239.stgit@warthog.procyon.org.uk/ # v1
---

 fs/cachefiles/cache.c     |   32 ++++-
 fs/cachefiles/daemon.c    |    1 
 fs/cachefiles/interface.c |  260 +++++++++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h  |    9 +
 fs/cachefiles/namei.c     |  318 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 619 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index d87db9b6e4c8..2f7f5381afbe 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -262,6 +262,36 @@ int cachefiles_has_space(struct cachefiles_cache *cache,
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
@@ -326,7 +356,7 @@ void cachefiles_withdraw_cache(struct cachefiles_cache *cache)
 	/* we now have to destroy all the active objects pertaining to this
 	 * cache - which we do by passing them off to thread pool to be
 	 * disposed of */
-	// PLACEHOLDER: Withdraw objects
+	cachefiles_withdraw_objects(cache);
 	fscache_wait_for_objects(fscache);
 
 	cachefiles_withdraw_volumes(cache);
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 985c3f3e6767..61e8740d01be 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -106,6 +106,7 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	mutex_init(&cache->daemon_mutex);
 	init_waitqueue_head(&cache->daemon_pollwq);
 	INIT_LIST_HEAD(&cache->volumes);
+	INIT_LIST_HEAD(&cache->object_list);
 	spin_lock_init(&cache->object_list_lock);
 
 	/* set default caching limits
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 68bb7b6c4945..e47c52c34071 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -99,8 +99,268 @@ void cachefiles_put_object(struct cachefiles_object *object,
 	_leave("");
 }
 
+/*
+ * Adjust the size of a cache file if necessary to match the DIO size.  We keep
+ * the EOF marker a multiple of DIO blocks so that we don't fall back to doing
+ * non-DIO for a partial block straddling the EOF, but we also have to be
+ * careful of someone expanding the file and accidentally accreting the
+ * padding.
+ */
+static int cachefiles_adjust_size(struct cachefiles_object *object)
+{
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
+	cachefiles_begin_secure(cache, &saved_cred);
+
+	success = cachefiles_look_up_object(object);
+	if (!success)
+		goto fail_withdraw;
+
+	cachefiles_see_object(object, cachefiles_obj_see_lookup_cookie);
+
+	spin_lock(&cache->object_list_lock);
+	list_add(&object->cache_link, &cache->object_list);
+	spin_unlock(&cache->object_list_lock);
+	cachefiles_adjust_size(object);
+
+	cachefiles_end_secure(cache, saved_cred);
+	_leave(" = t");
+	return true;
+
+fail_withdraw:
+	cachefiles_end_secure(cache, saved_cred);
+	cachefiles_see_object(object, cachefiles_obj_see_lookup_failed);
+	fscache_caching_failed(cookie);
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
+		fscache_resume_after_invalidation(cookie);
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
+	fscache_resume_after_invalidation(cookie);
+
+	if (old_file) {
+		if (!old_tmpfile) {
+			struct cachefiles_volume *volume = object->volume;
+			struct dentry *fan = volume->fanout[(u8)cookie->key_hash];
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
+	.prepare_to_write	= cachefiles_prepare_to_write,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index f2a4ec2f8668..c10c04593f5a 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -16,6 +16,8 @@
 #include <linux/cred.h>
 #include <linux/security.h>
 
+#define CACHEFILES_DIO_BLOCK_SIZE 4096
+
 struct cachefiles_cache;
 struct cachefiles_object;
 
@@ -68,6 +70,7 @@ struct cachefiles_cache {
 	struct dentry			*graveyard;	/* directory into which dead objects go */
 	struct file			*cachefilesd;	/* manager daemon handle */
 	struct list_head		volumes;	/* List of volume objects */
+	struct list_head		object_list;	/* List of active objects */
 	spinlock_t			object_list_lock; /* Lock for volumes and object_list */
 	const struct cred		*cache_cred;	/* security override for accessing cache */
 	struct mutex			daemon_mutex;	/* command serialisation mutex */
@@ -194,6 +197,9 @@ extern int cachefiles_bury_object(struct cachefiles_cache *cache,
 				  struct dentry *dir,
 				  struct dentry *rep,
 				  enum fscache_why_object_killed why);
+extern int cachefiles_delete_object(struct cachefiles_object *object,
+				    enum fscache_why_object_killed why);
+extern bool cachefiles_look_up_object(struct cachefiles_object *object);
 extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					       struct dentry *dir,
 					       const char *name);
@@ -204,6 +210,9 @@ extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 
 extern int cachefiles_check_in_use(struct cachefiles_cache *cache,
 				   struct dentry *dir, char *filename);
+extern struct file *cachefiles_create_tmpfile(struct cachefiles_object *object);
+extern bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
+				      struct cachefiles_object *object);
 
 /*
  * security.c
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index d992d7c21c71..1e9845b8e939 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -402,6 +402,324 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 	return 0;
 }
 
+/*
+ * Delete a cache file.
+ */
+int cachefiles_delete_object(struct cachefiles_object *object,
+			     enum fscache_why_object_killed why)
+{
+	struct cachefiles_volume *volume = object->volume;
+	struct dentry *dentry = object->file->f_path.dentry;
+	struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
+	int ret;
+
+	_enter(",OBJ%x{%pD}", object->debug_id, object->file);
+
+	/* Stop the dentry being negated if it's only pinned by a file struct. */
+	dget(dentry);
+
+	inode_lock_nested(d_backing_inode(fan), I_MUTEX_PARENT);
+	ret = cachefiles_unlink(volume->cache, object, fan, dentry, why);
+	inode_unlock(d_backing_inode(fan));
+	dput(dentry);
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
+	struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
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
+	struct dentry *dentry, *fan = volume->fanout[(u8)object->cookie->key_hash];
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
+/*
+ * Attempt to link a temporary file into its rightful place in the cache.
+ */
+bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
+			       struct cachefiles_object *object)
+{
+	struct cachefiles_volume *volume = object->volume;
+	struct dentry *dentry, *fan = volume->fanout[(u8)object->cookie->key_hash];
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
+		ret = cachefiles_unlink(volume->cache, object, fan, dentry,
+					FSCACHE_OBJECT_IS_STALE);
+		if (ret < 0)
+			goto out_dput;
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
+		trace_cachefiles_vfs_error(object, d_inode(fan), ret,
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
+
 /*
  * Look up an inode to be checked or culled.  Return -EBUSY if the inode is
  * marked in use.


