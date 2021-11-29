Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74FF46198B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378904AbhK2Ojb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:39:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378667AbhK2OhU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638196442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQOOc9VDFe5vHYRLEKi9FQyVdC+2ADbNA6aARhmEx8U=;
        b=Xji/9ESn8HC1EzhaKkCUuUzoF1BvCD6Tpu5d4DpZgDv50p2K4+73oJgk8zjVYcUVNcFW+u
        +5qZK4bGPOV8SG5dMbEhqZrGdbC0FbzNLI+a2d6vecRfGcwmIJbrQrlHpERDxI9u0Aa/Wb
        LIR+Wi+MpIdly7zZrHLt0rTkfm9raVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-e4Ei0rWJPn26W2nHjn3qlQ-1; Mon, 29 Nov 2021 09:33:58 -0500
X-MC-Unique: e4Ei0rWJPn26W2nHjn3qlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB2CC835E21;
        Mon, 29 Nov 2021 14:33:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98D3C60854;
        Mon, 29 Nov 2021 14:33:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 47/64] cachefiles: Implement culling daemon commands
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 14:33:51 +0000
Message-ID: <163819643179.215744.13641580295708315695.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the ability for the userspace daemon to try and cull a file or
directory in the cache.  Two daemon commands are implemented:

 (1) The "inuse" command.  This queries if a file is in use or whether it
     can be deleted.  It checks the S_KERNEL_FILE flag on the inode
     referred to by the specified filename.

 (2) The "cull" command.  This asks for a file or directory to be removed,
     where removal means either unlinking it or moving it to the graveyard
     directory for userspace to dismantle.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/daemon.c   |    4 -
 fs/cachefiles/internal.h |   11 ++
 fs/cachefiles/namei.c    |  307 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 337597a4e30c..985c3f3e6767 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -574,7 +574,7 @@ static int cachefiles_daemon_cull(struct cachefiles_cache *cache, char *args)
 		goto notdir;
 
 	cachefiles_begin_secure(cache, &saved_cred);
-	ret = -ENOANO; // PLACEHOLDER: Do culling
+	ret = cachefiles_cull(cache, path.dentry, args);
 	cachefiles_end_secure(cache, saved_cred);
 
 	path_put(&path);
@@ -645,7 +645,7 @@ static int cachefiles_daemon_inuse(struct cachefiles_cache *cache, char *args)
 		goto notdir;
 
 	cachefiles_begin_secure(cache, &saved_cred);
-	ret = -ENOANO; // PLACEHOLDER: Check if in use
+	ret = cachefiles_check_in_use(cache, path.dentry, args);
 	cachefiles_end_secure(cache, saved_cred);
 
 	path_put(&path);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index ebb39373716b..f2a4ec2f8668 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -189,11 +189,22 @@ extern struct kmem_cache *cachefiles_object_jar;
  */
 extern void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
 					   struct file *file);
+extern int cachefiles_bury_object(struct cachefiles_cache *cache,
+				  struct cachefiles_object *object,
+				  struct dentry *dir,
+				  struct dentry *rep,
+				  enum fscache_why_object_killed why);
 extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					       struct dentry *dir,
 					       const char *name);
 extern void cachefiles_put_directory(struct dentry *dir);
 
+extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
+			   char *filename);
+
+extern int cachefiles_check_in_use(struct cachefiles_cache *cache,
+				   struct dentry *dir, char *filename);
+
 /*
  * security.c
  */
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 2e209e403713..50d0668e54f8 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -215,3 +215,310 @@ void cachefiles_put_directory(struct dentry *dir)
 		dput(dir);
 	}
 }
+
+/*
+ * Remove a regular file from the cache.
+ */
+static int cachefiles_unlink(struct cachefiles_cache *cache,
+			     struct cachefiles_object *object,
+			     struct dentry *dir, struct dentry *dentry,
+			     enum fscache_why_object_killed why)
+{
+	struct path path = {
+		.mnt	= cache->mnt,
+		.dentry	= dir,
+	};
+	int ret;
+
+	trace_cachefiles_unlink(object, dentry, why);
+	ret = security_path_unlink(&path, dentry);
+	if (ret < 0) {
+		cachefiles_io_error(cache, "Unlink security error");
+		return ret;
+	}
+
+	ret = cachefiles_inject_remove_error();
+	if (ret == 0) {
+		ret = vfs_unlink(&init_user_ns, d_backing_inode(dir), dentry, NULL);
+		if (ret == -EIO)
+			cachefiles_io_error(cache, "Unlink failed");
+	}
+	if (ret != 0)
+		trace_cachefiles_vfs_error(object, d_backing_inode(dir), ret,
+					   cachefiles_trace_unlink_error);
+	return ret;
+}
+
+/*
+ * Delete an object representation from the cache
+ * - File backed objects are unlinked
+ * - Directory backed objects are stuffed into the graveyard for userspace to
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
+		dget(rep); /* Stop the dentry being negated if it's only pinned
+			    * by a file struct.
+			    */
+		ret = cachefiles_unlink(cache, object, dir, rep, why);
+		dput(rep);
+
+		inode_unlock(d_inode(dir));
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
+/*
+ * Look up an inode to be checked or culled.  Return -EBUSY if the inode is
+ * marked in use.
+ */
+static struct dentry *cachefiles_lookup_for_cull(struct cachefiles_cache *cache,
+						 struct dentry *dir,
+						 char *filename)
+{
+	struct dentry *victim;
+	int ret = -ENOENT;
+
+	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+
+	victim = lookup_one_len(filename, dir, strlen(filename));
+	if (IS_ERR(victim))
+		goto lookup_error;
+	if (d_is_negative(victim))
+		goto lookup_put;
+	if (d_inode(victim)->i_flags & S_KERNEL_FILE)
+		goto lookup_busy;
+	return victim;
+
+lookup_busy:
+	ret = -EBUSY;
+lookup_put:
+	inode_unlock(d_inode(dir));
+	dput(victim);
+	return ERR_PTR(ret);
+
+lookup_error:
+	inode_unlock(d_inode(dir));
+	ret = PTR_ERR(victim);
+	if (ret == -ENOENT)
+		return ERR_PTR(-ESTALE); /* Probably got retired by the netfs */
+
+	if (ret == -EIO) {
+		cachefiles_io_error(cache, "Lookup failed");
+	} else if (ret != -ENOMEM) {
+		pr_err("Internal error: %d\n", ret);
+		ret = -EIO;
+	}
+
+	return ERR_PTR(ret);
+}
+
+/*
+ * Cull an object if it's not in use
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
+	victim = cachefiles_lookup_for_cull(cache, dir, filename);
+	if (IS_ERR(victim))
+		return PTR_ERR(victim);
+
+	/* check to see if someone is using this object */
+	inode = d_inode(victim);
+	inode_lock(inode);
+	if (inode->i_flags & S_KERNEL_FILE) {
+		ret = -EBUSY;
+	} else {
+		/* Stop the cache from picking it back up */
+		inode->i_flags |= S_KERNEL_FILE;
+		ret = 0;
+	}
+	inode_unlock(inode);
+	if (ret < 0)
+		goto error_unlock;
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
+	if (ret == -ENOENT)
+		return -ESTALE; /* Probably got retired by the netfs */
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
+ * Find out if an object is in use or not
+ * - called only by cache manager daemon
+ * - returns -EBUSY or 0 to indicate whether an object is in use or not
+ */
+int cachefiles_check_in_use(struct cachefiles_cache *cache, struct dentry *dir,
+			    char *filename)
+{
+	struct dentry *victim;
+	int ret = 0;
+
+	victim = cachefiles_lookup_for_cull(cache, dir, filename);
+	if (IS_ERR(victim))
+		return PTR_ERR(victim);
+
+	inode_unlock(d_inode(dir));
+	dput(victim);
+	return ret;
+}


