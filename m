Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86B3432127
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhJRPBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:01:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232548AbhJRPBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d1RAivTF6xv/uC0MaX1ywGL3S0mqqvm3SK6wtYXT08g=;
        b=WsYll4UsltchpK23A/j77MtOk78ZYOP1mRKEJAX5XrlpmnUvV/Z5Q+R5SR8Oi4QS5b4poo
        cw1vonW4hbKBdujYOyhtLshsLf1E6BYqlFOGrKU75z28frq96eE6hWh/76ixHXvw/4QFH8
        KsAGuaBzbLx6kfgxWPDxMZxyP9zYZr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-v6c1sQS0NyGAGGeMtnSkeQ-1; Mon, 18 Oct 2021 10:59:36 -0400
X-MC-Unique: v6c1sQS0NyGAGGeMtnSkeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22351814266;
        Mon, 18 Oct 2021 14:59:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64C91100E809;
        Mon, 18 Oct 2021 14:59:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 32/67] fscache: Replace the object management state machine
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
Date:   Mon, 18 Oct 2021 15:59:03 +0100
Message-ID: <163456914346.2614702.17800867984051216150.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Filesystems that use the fallback I/O API must set FSCACHE_ADV_FALLBACK_IO
when creating a cookie so that the content mapper doesn't try to interfere.
For cachefiles, this will cause I/O paths to use SEEK_DATA/SEEK_HOLE rather
than using a separate content map; this may result in data corruption if
the backing filesystem inserts bridging blocks[1].

At some point in the future, object records that aren't in use will get put
on an LRU and discarded under memory pressure or if they haven't been used
for a while.

Whilst accessing the cache, either fscache or the cache backend must hold
an access count on the cookie or volume cookie for the duration of an
operation to prevent the cache's structures from being deallocated if the
cache is simultaneously withdrawn; further, operations must be held up
until the backend finishes or fails at creating its structures in the
background.  In this case, cachefiles cannot access cache_priv pointers
until it has waited for the appropriate state to be achieved.

Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/YO17ZNOcq+9PajfQ@mit.edu [1]
---

 fs/9p/vfs_addr.c                  |    2 
 fs/afs/Makefile                   |    3 
 fs/afs/cache.c                    |   14 
 fs/afs/cell.c                     |   15 -
 fs/afs/file.c                     |   17 +
 fs/afs/inode.c                    |   16 -
 fs/afs/internal.h                 |    5 
 fs/afs/main.c                     |   14 
 fs/afs/volume.c                   |   16 -
 fs/cachefiles/Makefile            |    1 
 fs/cachefiles/bind.c              |  184 +++++--
 fs/cachefiles/daemon.c            |    8 
 fs/cachefiles/interface.c         |  340 +++++++-----
 fs/cachefiles/internal.h          |   90 +++
 fs/cachefiles/io.c                |  144 +++--
 fs/cachefiles/key.c               |  126 ++--
 fs/cachefiles/main.c              |   11 
 fs/cachefiles/namei.c             |  209 ++-----
 fs/cachefiles/volume.c            |  128 +++++
 fs/cachefiles/xattr.c             |    7 
 fs/fscache/Makefile               |    4 
 fs/fscache/cache.c                |  530 +++++++++----------
 fs/fscache/cookie.c               | 1043 +++++++++++++++++--------------------
 fs/fscache/fsdef.c                |   46 --
 fs/fscache/internal.h             |  160 +-----
 fs/fscache/io.c                   |  238 ++++----
 fs/fscache/main.c                 |  134 -----
 fs/fscache/netfs.c                |   76 ---
 fs/fscache/object.c               |  973 -----------------------------------
 fs/fscache/proc.c                 |   43 --
 fs/fscache/stats.c                |  143 +----
 fs/fscache/volume.c               |  449 ++++++++++++++++
 include/linux/fscache-cache.h     |  371 ++++---------
 include/linux/fscache.h           |  405 ++++++--------
 include/trace/events/cachefiles.h |   64 ++
 include/trace/events/fscache.h    |  395 +++++++++-----
 36 files changed, 2715 insertions(+), 3709 deletions(-)
 delete mode 100644 fs/afs/cache.c
 create mode 100644 fs/cachefiles/volume.c
 delete mode 100644 fs/fscache/fsdef.c
 delete mode 100644 fs/fscache/netfs.c
 delete mode 100644 fs/fscache/object.c
 create mode 100644 fs/fscache/volume.c

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index cff99f5c05e3..de857fa4629b 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -80,7 +80,7 @@ static bool v9fs_is_cache_enabled(struct inode *inode)
 {
 	struct fscache_cookie *cookie = v9fs_inode_cookie(V9FS_I(inode));
 
-	return fscache_cookie_enabled(cookie) && !hlist_empty(&cookie->backing_objects);
+	return fscache_cookie_valid(cookie) && cookie->cache_priv;
 }
 
 /**
diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index 75c4e4043d1d..e8956b65d7ff 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -3,10 +3,7 @@
 # Makefile for Red Hat Linux AFS client.
 #
 
-afs-cache-$(CONFIG_AFS_FSCACHE) := cache.o
-
 kafs-y := \
-	$(afs-cache-y) \
 	addr_list.o \
 	callback.o \
 	cell.o \
diff --git a/fs/afs/cache.c b/fs/afs/cache.c
deleted file mode 100644
index 0ee9ede6fc67..000000000000
--- a/fs/afs/cache.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* AFS caching stuff
- *
- * Copyright (C) 2008 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/sched.h>
-#include "internal.h"
-
-struct fscache_netfs afs_cache_netfs = {
-	.name			= "afs",
-	.version		= 2,
-};
diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index ebf140317232..07ad744eef77 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -680,16 +680,6 @@ static int afs_activate_cell(struct afs_net *net, struct afs_cell *cell)
 			return ret;
 	}
 
-#ifdef CONFIG_AFS_FSCACHE
-	cell->cache = fscache_acquire_cookie(afs_cache_netfs.primary_index,
-					     FSCACHE_COOKIE_TYPE_INDEX,
-					     "AFS.cell",
-					     0,
-					     NULL,
-					     cell->name, strlen(cell->name),
-					     NULL, 0,
-					     0, true);
-#endif
 	ret = afs_proc_cell_setup(cell);
 	if (ret < 0)
 		return ret;
@@ -726,11 +716,6 @@ static void afs_deactivate_cell(struct afs_net *net, struct afs_cell *cell)
 	afs_dynroot_rmdir(net, cell);
 	mutex_unlock(&net->proc_cells_lock);
 
-#ifdef CONFIG_AFS_FSCACHE
-	fscache_relinquish_cookie(cell->cache, NULL, false);
-	cell->cache = NULL;
-#endif
-
 	_leave("");
 }
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 4d5b6bfcf815..b4666da93b54 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -151,7 +151,9 @@ int afs_open(struct inode *inode, struct file *file)
 
 	if (file->f_flags & O_TRUNC)
 		set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
-	
+
+	fscache_use_cookie(afs_vnode_cache(vnode), file->f_mode & FMODE_WRITE);
+
 	file->private_data = af;
 	_leave(" = 0");
 	return 0;
@@ -170,8 +172,10 @@ int afs_open(struct inode *inode, struct file *file)
  */
 int afs_release(struct inode *inode, struct file *file)
 {
+	struct afs_vnode_cache_aux aux;
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct afs_file *af = file->private_data;
+	loff_t i_size;
 	int ret = 0;
 
 	_enter("{%llx:%llu},", vnode->fid.vid, vnode->fid.vnode);
@@ -182,6 +186,15 @@ int afs_release(struct inode *inode, struct file *file)
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
@@ -344,7 +357,7 @@ static bool afs_is_cache_enabled(struct inode *inode)
 {
 	struct fscache_cookie *cookie = afs_vnode_cache(AFS_FS_I(inode));
 
-	return fscache_cookie_enabled(cookie) && !hlist_empty(&cookie->backing_objects);
+	return fscache_cookie_valid(cookie) && cookie->cache_priv;
 }
 
 static int afs_begin_cache_operation(struct netfs_read_request *rreq)
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index f761c9a5067f..c2f4afff9837 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -432,13 +432,10 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 
 	vnode->cache = fscache_acquire_cookie(
 		vnode->volume->cache,
-		FSCACHE_COOKIE_TYPE_DATAFILE,
-		"AFS.vnode",
 		vnode->status.type == AFS_FTYPE_FILE ? 0 : FSCACHE_ADV_SINGLE_CHUNK,
-		NULL,
 		&key, sizeof(key),
 		&aux, sizeof(aux),
-		vnode->status.size, true);
+		vnode->status.size);
 #endif
 }
 
@@ -790,14 +787,9 @@ void afs_evict_inode(struct inode *inode)
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
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index bdcc677338fb..8e168c3fa5d1 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -364,9 +364,6 @@ struct afs_cell {
 	struct key		*anonymous_key;	/* anonymous user key for this cell */
 	struct work_struct	manager;	/* Manager for init/deinit/dns */
 	struct hlist_node	proc_link;	/* /proc cell list link */
-#ifdef CONFIG_AFS_FSCACHE
-	struct fscache_cookie	*cache;		/* caching cookie */
-#endif
 	time64_t		dns_expiry;	/* Time AFSDB/SRV record expires */
 	time64_t		last_inactive;	/* Time of last drop of usage count */
 	atomic_t		ref;		/* Struct refcount */
@@ -590,7 +587,7 @@ struct afs_volume {
 #define AFS_VOLUME_BUSY		5	/* - T if volume busy notice given */
 #define AFS_VOLUME_MAYBE_NO_IBULK 6	/* - T if some servers don't have InlineBulkStatus */
 #ifdef CONFIG_AFS_FSCACHE
-	struct fscache_cookie	*cache;		/* caching cookie */
+	struct fscache_volume	*cache;		/* Caching cookie */
 #endif
 	struct afs_server_list __rcu *servers;	/* List of servers on which volume resides */
 	rwlock_t		servers_lock;	/* Lock for ->servers */
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 179004b15566..eae288c8d40a 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -186,13 +186,6 @@ static int __init afs_init(void)
 	if (!afs_lock_manager)
 		goto error_lockmgr;
 
-#ifdef CONFIG_AFS_FSCACHE
-	/* we want to be able to cache */
-	ret = fscache_register_netfs(&afs_cache_netfs);
-	if (ret < 0)
-		goto error_cache;
-#endif
-
 	ret = register_pernet_device(&afs_net_ops);
 	if (ret < 0)
 		goto error_net;
@@ -215,10 +208,6 @@ static int __init afs_init(void)
 error_fs:
 	unregister_pernet_device(&afs_net_ops);
 error_net:
-#ifdef CONFIG_AFS_FSCACHE
-	fscache_unregister_netfs(&afs_cache_netfs);
-error_cache:
-#endif
 	destroy_workqueue(afs_lock_manager);
 error_lockmgr:
 	destroy_workqueue(afs_async_calls);
@@ -245,9 +234,6 @@ static void __exit afs_exit(void)
 	proc_remove(afs_proc_symlink);
 	afs_fs_exit();
 	unregister_pernet_device(&afs_net_ops);
-#ifdef CONFIG_AFS_FSCACHE
-	fscache_unregister_netfs(&afs_cache_netfs);
-#endif
 	destroy_workqueue(afs_lock_manager);
 	destroy_workqueue(afs_async_calls);
 	destroy_workqueue(afs_wq);
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 5eaaa762fbd9..1269ec08170e 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -271,12 +271,14 @@ void afs_put_volume(struct afs_net *net, struct afs_volume *volume,
 void afs_activate_volume(struct afs_volume *volume)
 {
 #ifdef CONFIG_AFS_FSCACHE
-	volume->cache = fscache_acquire_cookie(volume->cell->cache,
-					       FSCACHE_COOKIE_TYPE_INDEX,
-					       "AFS.vol",
-					       0, NULL,
-					       &volume->vid, sizeof(volume->vid),
-					       NULL, 0, 0, true);
+	char *name;
+
+	name = kasprintf(GFP_KERNEL, "afs,%s,%llx",
+			 volume->cell->name, volume->vid);
+	if (name) {
+		volume->cache = fscache_acquire_volume(name, NULL, 0);
+		kfree(name);
+	}
 #endif
 }
 
@@ -288,7 +290,7 @@ void afs_deactivate_volume(struct afs_volume *volume)
 	_enter("%s", volume->name);
 
 #ifdef CONFIG_AFS_FSCACHE
-	fscache_relinquish_cookie(volume->cache, NULL,
+	fscache_relinquish_volume(volume->cache, 0,
 				  test_bit(AFS_VOLUME_DELETED, &volume->flags));
 	volume->cache = NULL;
 #endif
diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 714e84b3ca24..9062767331e8 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -12,6 +12,7 @@ cachefiles-y := \
 	main.o \
 	namei.o \
 	security.o \
+	volume.o \
 	xattr.o
 
 obj-$(CONFIG_CACHEFILES) := cachefiles.o
diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index 4ea8c93e14d8..53aac6323753 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -17,8 +17,11 @@
 #include <linux/statfs.h>
 #include <linux/ctype.h>
 #include <linux/xattr.h>
+#include <trace/events/fscache.h>
 #include "internal.h"
 
+DECLARE_WAIT_QUEUE_HEAD(cachefiles_clearance_wq);
+
 static int cachefiles_daemon_add_cache(struct cachefiles_cache *caches);
 
 /*
@@ -60,16 +63,6 @@ int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 		return -EBUSY;
 	}
 
-	/* make sure we have copies of the tag and dirname strings */
-	if (!cache->tag) {
-		/* the tag string is released by the fops->release()
-		 * function, so we don't release it on error here */
-		cache->tag = kstrdup("CacheFiles", GFP_KERNEL);
-		if (!cache->tag)
-			return -ENOMEM;
-	}
-
-	/* add the cache */
 	return cachefiles_daemon_add_cache(cache);
 }
 
@@ -78,33 +71,34 @@ int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
  */
 static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 {
-	struct cachefiles_object *fsdef;
+	struct fscache_cache *cache_cookie;
 	struct path path;
 	struct kstatfs stats;
 	struct dentry *graveyard, *cachedir, *root;
-	struct file *dirf;
 	const struct cred *saved_cred;
 	int ret;
 
 	_enter("");
 
+	cache_cookie = fscache_acquire_cache(cache->tag);
+	if (IS_ERR(cache_cookie))
+		return PTR_ERR(cache_cookie);
+
+	if (!fscache_set_cache_state_maybe(cache_cookie,
+					   FSCACHE_CACHE_IS_NOT_PRESENT,
+					   FSCACHE_CACHE_IS_PREPARING)) {
+		pr_warn("Cache tag in use\n");
+		ret = -EBUSY;
+		goto error_preparing;
+	}
+
 	/* we want to work under the module's security ID */
 	ret = cachefiles_get_security_ID(cache);
 	if (ret < 0)
-		return ret;
+		goto error_getsec;
 
 	cachefiles_begin_secure(cache, &saved_cred);
 
-	/* allocate the root index object */
-	ret = -ENOMEM;
-
-	fsdef = kmem_cache_alloc(cachefiles_object_jar, GFP_KERNEL);
-	if (!fsdef)
-		goto error_root_object;
-
-	atomic_set(&fsdef->usage, 1);
-	fsdef->type = FSCACHE_COOKIE_TYPE_INDEX;
-
 	/* look up the directory at the root of the cache */
 	ret = kern_path(cache->rootdirname, LOOKUP_DIRECTORY, &path);
 	if (ret < 0)
@@ -188,40 +182,25 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	       (unsigned long long) cache->bstop);
 
 	/* get the cache directory and check its type */
-	cachedir = cachefiles_get_directory(cache, root, "cache", NULL);
+	cachedir = cachefiles_get_directory(cache, root, "cache");
 	if (IS_ERR(cachedir)) {
 		ret = PTR_ERR(cachedir);
 		goto error_unsupported;
 	}
 
-	dirf = open_with_fake_path(&path, O_RDONLY | O_DIRECTORY,
-				   d_inode(cachedir), cache->cache_cred);
-	if (IS_ERR(dirf)) {
-		ret = PTR_ERR(dirf);
-		goto error_unsupported;
-	}
-	fsdef->file = dirf;
-	fsdef->cookie = NULL;
+	cache->store = cachedir;
 
 	/* get the graveyard directory */
-	graveyard = cachefiles_get_directory(cache, root, "graveyard", NULL);
+	graveyard = cachefiles_get_directory(cache, root, "graveyard");
 	if (IS_ERR(graveyard)) {
 		ret = PTR_ERR(graveyard);
 		goto error_unsupported;
 	}
 
 	cache->graveyard = graveyard;
+	cache->cache = cache_cookie;
 
-	/* publish the cache */
-	fscache_init_cache(&cache->cache,
-			   &cachefiles_cache_ops,
-			   "%s",
-			   graveyard->d_sb->s_id);
-
-	fscache_object_init(fsdef, &fscache_fsdef_index,
-			    &cache->cache);
-
-	ret = fscache_add_cache(&cache->cache, fsdef, cache->tag);
+	ret = fscache_add_cache(cache_cookie, &cachefiles_cache_ops, cache);
 	if (ret < 0)
 		goto error_add_cache;
 
@@ -229,47 +208,140 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	set_bit(CACHEFILES_READY, &cache->flags);
 	dput(root);
 
-	pr_info("File cache on %s registered\n", cache->cache.identifier);
+	pr_info("File cache on %s registered\n", cache_cookie->name);
 
 	/* check how much space the cache has */
 	cachefiles_has_space(cache, 0, 0);
 	cachefiles_end_secure(cache, saved_cred);
+	_leave(" = 0 [%px]", cache->cache);
 	return 0;
 
 error_add_cache:
 	dput(cache->graveyard);
 	cache->graveyard = NULL;
 error_unsupported:
+	dput(cache->store);
+	cache->store = NULL;
 	mntput(cache->mnt);
 	cache->mnt = NULL;
-	if (fsdef->file) {
-		fput(fsdef->file);
-		fsdef->file = NULL;
-	}
 	dput(root);
 error_open_root:
-	kmem_cache_free(cachefiles_object_jar, fsdef);
-error_root_object:
 	cachefiles_end_secure(cache, saved_cred);
+error_getsec:
+	fscache_set_cache_state(cache_cookie, FSCACHE_CACHE_IS_NOT_PRESENT);
+error_preparing:
+	fscache_put_cache(cache_cookie, fscache_cache_put_cache);
+	cache->cache = NULL;
 	pr_err("Failed to register: %d\n", ret);
 	return ret;
 }
 
 /*
- * unbind a cache on fd release
+ * Mark all the objects as being out of service and queue them all for cleanup.
  */
-void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
+static void cachefiles_withdraw_objects(struct cachefiles_cache *cache)
 {
+	struct cachefiles_object *object;
+	unsigned int count = 0;
+
 	_enter("");
 
-	if (test_bit(CACHEFILES_READY, &cache->flags)) {
-		pr_info("File cache on %s unregistering\n",
-			cache->cache.identifier);
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
+/*
+ * Withdraw volumes.
+ */
+static void cachefiles_withdraw_volumes(struct cachefiles_cache *cache)
+{
+	_enter("");
 
-		fscache_withdraw_cache(&cache->cache);
+	for (;;) {
+		struct cachefiles_volume *volume = NULL;
+
+		spin_lock(&cache->object_list_lock);
+		if (!list_empty(&cache->volumes)) {
+			volume = list_first_entry(&cache->volumes,
+						  struct cachefiles_volume, cache_link);
+			list_del_init(&volume->cache_link);
+		}
+		spin_unlock(&cache->object_list_lock);
+		if (!volume)
+			break;
+
+		cachefiles_withdraw_volume(volume);
 	}
 
+	_leave("");
+}
+
+/*
+ * Withdraw cache objects.
+ */
+static void cachefiles_withdraw_cache(struct cachefiles_cache *cache)
+{
+	struct fscache_cache *fscache = cache->cache;
+
+	pr_info("File cache on %s unregistering\n", fscache->name);
+
+	fscache_withdraw_cache(fscache);
+
+	/* we now have to destroy all the active objects pertaining to this
+	 * cache - which we do by passing them off to thread pool to be
+	 * disposed of */
+	cachefiles_withdraw_objects(cache);
+
+	/* wait for all extant objects to finish their outstanding operations
+	 * and go away */
+	_debug("wait for finish %u", atomic_read(&fscache->object_count));
+	wait_event(cachefiles_clearance_wq,
+		   atomic_read(&fscache->object_count) == 0);
+	_debug("cleared");
+
+	cachefiles_withdraw_volumes(cache);
+
+	/* make sure all outstanding data is written to disk */
+	cachefiles_sync_cache(cache);
+
+	_debug("wait for clearance");
+	wait_event(cachefiles_clearance_wq, list_empty(&cache->object_list));
+
+	cache->cache = NULL;
+	fscache->ops = NULL;
+	fscache->cache_priv = NULL;
+	fscache_set_cache_state(fscache, FSCACHE_CACHE_IS_NOT_PRESENT);
+	fscache_put_cache(fscache, fscache_cache_put_withdraw);
+}
+
+/*
+ * unbind a cache on fd release
+ */
+void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
+{
+	_enter("%px", cache->cache);
+
+	if (test_bit(CACHEFILES_READY, &cache->flags))
+		cachefiles_withdraw_cache(cache);
+
 	dput(cache->graveyard);
+	dput(cache->store);
 	mntput(cache->mnt);
 
 	kfree(cache->rootdirname);
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index e8ab3ab57147..6d31fba31ce9 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -103,6 +103,9 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 
 	mutex_init(&cache->daemon_mutex);
 	init_waitqueue_head(&cache->daemon_pollwq);
+	INIT_LIST_HEAD(&cache->volumes);
+	INIT_LIST_HEAD(&cache->object_list);
+	spin_lock_init(&cache->object_list_lock);
 
 	/* set default caching limits
 	 * - limit at 1% free space and/or free files
@@ -668,11 +671,12 @@ int cachefiles_has_space(struct cachefiles_cache *cache,
 			 unsigned fnr, unsigned bnr)
 {
 	struct kstatfs stats;
+	int ret;
+
 	struct path path = {
 		.mnt	= cache->mnt,
-		.dentry	= cache->mnt->mnt_root,
+		.dentry	= cache->store,
 	};
-	int ret;
 
 	//_enter("{%llu,%llu,%llu,%llu,%llu,%llu},%u,%u",
 	//       (unsigned long long) cache->frun,
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 674d3d75fa70..d186a68ff810 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -8,114 +8,128 @@
 #include <linux/slab.h>
 #include <linux/mount.h>
 #include <linux/xattr.h>
+#include <linux/file.h>
+#include <trace/events/fscache.h>
 #include "internal.h"
 
+static atomic_t cachefiles_object_debug_id;
+
 static int cachefiles_attr_changed(struct cachefiles_object *object);
 
 /*
- * allocate an object record for a cookie lookup and prepare the lookup data
+ * Allocate a cache object record.
  */
-static struct cachefiles_object *cachefiles_alloc_object(
-	struct fscache_cache *_cache,
-	struct fscache_cookie *cookie)
+static
+struct cachefiles_object *cachefiles_alloc_object(struct fscache_cookie *cookie)
 {
+	struct fscache_volume *vcookie = cookie->volume;
 	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-
-	cache = container_of(_cache, struct cachefiles_cache, cache);
+	struct cachefiles_volume *volume = vcookie->cache_priv;
+	int n_accesses;
 
-	_enter("{%s},%x,", cache->cache.identifier, cookie->debug_id);
+	_enter("{%s},%x,", vcookie->key, cookie->debug_id);
 
-	/* create a new object record and a temporary leaf image */
-	object = kmem_cache_alloc(cachefiles_object_jar, cachefiles_gfp);
+	object = kmem_cache_zalloc(cachefiles_object_jar, cachefiles_gfp);
 	if (!object)
-		goto nomem_object;
+		return NULL;
 
 	atomic_set(&object->usage, 1);
 
-	fscache_object_init(object, cookie, &cache->cache);
+	spin_lock_init(&object->lock);
+	INIT_LIST_HEAD(&object->cache_link);
+	object->volume = volume;
+	object->debug_id = atomic_inc_return(&cachefiles_object_debug_id);
+	object->cookie = fscache_get_cookie(cookie, fscache_cookie_get_attach_object);
 
-	object->type = cookie->type;
-
-	/* turn the raw key into something that can work with as a filename */
-	if (!cachefiles_cook_key(object))
-		goto nomem_key;
+	atomic_inc(&vcookie->cache->object_count);
+	trace_cachefiles_ref(object->debug_id, cookie->debug_id, 1,
+			     cachefiles_obj_new);
 
-	_leave(" = %x [%s]", object->debug_id, object->d_name);
+	/* Get a ref on the cookie and keep its n_accesses counter raised by 1
+	 * to prevent wakeups from transitioning it to 0 until we're
+	 * withdrawing caching services from it.
+	 */
+	n_accesses = atomic_inc_return(&cookie->n_accesses);
+	trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
+			     n_accesses, fscache_access_cache_pin);
+	set_bit(FSCACHE_COOKIE_NACC_ELEVATED, &cookie->flags);
 	return object;
-
-nomem_key:
-	kmem_cache_free(cachefiles_object_jar, object);
-	fscache_object_destroyed(&cache->cache);
-nomem_object:
-	_leave(" = -ENOMEM");
-	return ERR_PTR(-ENOMEM);
 }
 
 /*
- * attempt to look up the nominated node in this cache
- * - return -ETIMEDOUT to be scheduled again
+ * Attempt to look up the nominated node in this cache
  */
-static int cachefiles_lookup_object(struct cachefiles_object *object)
+static bool cachefiles_lookup_cookie(struct fscache_cookie *cookie)
 {
-	struct cachefiles_object *parent;
-	struct cachefiles_cache *cache;
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache = cookie->volume->cache->cache_priv;
 	const struct cred *saved_cred;
-	int ret;
+	bool success;
+
+	object = cachefiles_alloc_object(cookie);
+	if (!object)
+		goto fail;
 
 	_enter("{OBJ%x}", object->debug_id);
 
-	cache = container_of(object->cache, struct cachefiles_cache, cache);
-	parent = object->parent;
+	if (!cachefiles_cook_key(object))
+		goto fail_put;
 
-	ASSERT(object->d_name);
+	cookie->cache_priv = object;
 
 	/* look up the key, creating any missing bits */
 	cachefiles_begin_secure(cache, &saved_cred);
-	ret = cachefiles_walk_to_object(parent, object);
+	success = cachefiles_walk_to_object(object);
 	cachefiles_end_secure(cache, saved_cred);
 
-	/* polish off by setting the attributes of non-index files */
-	if (ret == 0 &&
-	    object->cookie->type != FSCACHE_COOKIE_TYPE_INDEX)
-		cachefiles_attr_changed(object);
-
-	if (ret < 0 && ret != -ETIMEDOUT) {
-		if (ret != -ENOBUFS)
-			pr_warn("Lookup failed error %d\n", ret);
-		fscache_object_lookup_error(object);
-	}
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
+	kdebug("failed c=%08x o=%08x", cookie->debug_id, object->debug_id);
+	/* The caller holds an access count on the cookie, so we need them to
+	 * drop it before we can withdraw the object.
+	 */
+	return false;
 
-	_leave(" [%d]", ret);
-	return ret;
+fail_put:
+	cachefiles_put_object(object, cachefiles_obj_put_alloc_fail);
+fail:
+	return false;
 }
 
 /*
- * indication of lookup completion
+ * Note that an object has been seen.
  */
-static void cachefiles_lookup_complete(struct cachefiles_object *object)
+void cachefiles_see_object(struct cachefiles_object *object,
+			   enum cachefiles_obj_ref_trace why)
 {
-	_enter("{OBJ%x}", object->debug_id);
+	trace_cachefiles_ref(object->debug_id, object->cookie->debug_id,
+			     atomic_read(&object->usage), why);
 }
 
 /*
  * increment the usage count on an inode object (may fail if unmounting)
  */
-static
 struct cachefiles_object *cachefiles_grab_object(struct cachefiles_object *object,
-						 enum fscache_obj_ref_trace why)
+						 enum cachefiles_obj_ref_trace why)
 {
 	int u;
 
-	_enter("{OBJ%x,%d}", object->debug_id, atomic_read(&object->usage));
-
-#ifdef CACHEFILES_DEBUG_SLAB
-	ASSERT((atomic_read(&object->usage) & 0xffff0000) != 0x6b6b0000);
-#endif
-
 	u = atomic_inc_return(&object->usage);
-	trace_cachefiles_ref(object, object->cookie,
-			     (enum cachefiles_obj_ref_trace)why, u);
+	trace_cachefiles_ref(object->debug_id, object->cookie->debug_id, u, why);
 	return object;
 }
 
@@ -124,102 +138,144 @@ struct cachefiles_object *cachefiles_grab_object(struct cachefiles_object *objec
  */
 static void cachefiles_update_object(struct cachefiles_object *object)
 {
-	struct cachefiles_cache *cache;
+	struct cachefiles_cache *cache = object->volume->cache;
 	const struct cred *saved_cred;
+	struct file *file = object->file;
+	loff_t object_size, i_size;
+	int ret;
 
 	_enter("{OBJ%x}", object->debug_id);
 
-	cache = container_of(object->cache, struct cachefiles_cache, cache);
-
 	cachefiles_begin_secure(cache, &saved_cred);
+
+	object_size = object->cookie->object_size;
+	i_size = i_size_read(file_inode(file));
+	if (i_size > object_size) {
+		_debug("trunc %llx -> %llx", i_size, object_size);
+		trace_cachefiles_trunc(object, file_inode(file),
+				       i_size, object_size,
+				       cachefiles_trunc_shrink);
+		ret = vfs_truncate(&file->f_path, object_size);
+		if (ret < 0) {
+			cachefiles_io_error_obj(object, "Trunc-to-size failed");
+			cachefiles_remove_object_xattr(cache, file->f_path.dentry);
+			goto out;
+		}
+
+		object_size = round_up(object_size, CACHEFILES_DIO_BLOCK_SIZE);
+		i_size = i_size_read(file_inode(file));
+		_debug("trunc %llx -> %llx", i_size, object_size);
+		if (i_size < object_size) {
+			trace_cachefiles_trunc(object, file_inode(file),
+					       i_size, object_size,
+					       cachefiles_trunc_dio_adjust);
+			ret = vfs_truncate(&file->f_path, object_size);
+			if (ret < 0) {
+				cachefiles_io_error_obj(object, "Trunc-to-dio-size failed");
+				cachefiles_remove_object_xattr(cache, file->f_path.dentry);
+				goto out;
+			}
+		}
+	}
+
 	cachefiles_set_object_xattr(object);
+
+out:
 	cachefiles_end_secure(cache, saved_cred);
 	_leave("");
 }
 
 /*
- * discard the resources pinned by an object and effect retirement if
- * requested
+ * Commit changes to the object as we drop it.
  */
-static void cachefiles_drop_object(struct cachefiles_object *object)
+static void cachefiles_commit_object(struct cachefiles_object *object,
+				     struct cachefiles_cache *cache)
 {
-	struct cachefiles_cache *cache;
-	const struct cred *saved_cred;
-
-	ASSERT(object);
+	bool update = false;
 
-	_enter("{OBJ%x,%d}", object->debug_id, atomic_read(&object->usage));
-
-	cache = container_of(object->cache, struct cachefiles_cache, cache);
+	if (test_and_clear_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags))
+		update = true;
+	if (update)
+		cachefiles_update_object(object);
+}
 
-#ifdef CACHEFILES_DEBUG_SLAB
-	ASSERT((atomic_read(&object->usage) & 0xffff0000) != 0x6b6b0000);
-#endif
+/*
+ * Finalise and object and close the VFS structs that we have.
+ */
+static void cachefiles_clean_up_object(struct cachefiles_object *object,
+				       struct cachefiles_cache *cache)
+{
+	if (test_bit(FSCACHE_COOKIE_RETIRED, &object->cookie->flags)) {
+		cachefiles_see_object(object, cachefiles_obj_see_clean_delete);
+		_debug("- inval object OBJ%x", object->debug_id);
+		cachefiles_delete_object(object, FSCACHE_OBJECT_WAS_RETIRED);
+	} else {
+		cachefiles_see_object(object, cachefiles_obj_see_clean_commit);
+		cachefiles_commit_object(object, cache);
+	}
 
-	/* We need to tidy the object up if we did in fact manage to open it.
-	 * It's possible for us to get here before the object is fully
-	 * initialised if the parent goes away or the object gets retired
-	 * before we set it up.
-	 */
+	cachefiles_unmark_inode_in_use(object);
 	if (object->file) {
-		/* delete retired objects */
-		if (test_bit(FSCACHE_OBJECT_RETIRED, &object->flags) &&
-		    object != cache->cache.fsdef
-		    ) {
-			_debug("- retire object OBJ%x", object->debug_id);
-			cachefiles_begin_secure(cache, &saved_cred);
-			cachefiles_delete_object(cache, object);
-			cachefiles_end_secure(cache, saved_cred);
-		}
-
-		/* close the filesystem stuff attached to the object */
-		cachefiles_unmark_inode_in_use(object);
 		fput(object->file);
 		object->file = NULL;
 	}
+}
 
-	_leave("");
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
 }
 
 /*
  * dispose of a reference to an object
  */
 void cachefiles_put_object(struct cachefiles_object *object,
-			   enum fscache_obj_ref_trace why)
+			   enum cachefiles_obj_ref_trace why)
 {
+	unsigned int object_debug_id = object->debug_id;
+	unsigned int cookie_debug_id = object->cookie->debug_id;
 	struct fscache_cache *cache;
 	int u;
 
-	ASSERT(object);
-
-	_enter("{OBJ%x,%d}",
-	       object->debug_id, atomic_read(&object->usage));
-
-#ifdef CACHEFILES_DEBUG_SLAB
-	ASSERT((atomic_read(&object->usage) & 0xffff0000) != 0x6b6b0000);
-#endif
-
-	ASSERTIFCMP(object->parent,
-		    object->parent->n_children, >, 0);
-
 	u = atomic_dec_return(&object->usage);
-	trace_cachefiles_ref(object, object->cookie,
-			     (enum cachefiles_obj_ref_trace)why, u);
-	ASSERTCMP(u, !=, -1);
+	trace_cachefiles_ref(object_debug_id, cookie_debug_id, u, why);
 	if (u == 0) {
-		_debug("- kill object OBJ%x", object->debug_id);
+		_debug("- kill object OBJ%x", object_debug_id);
 
-		ASSERTCMP(object->parent, ==, NULL);
 		ASSERTCMP(object->file, ==, NULL);
-		ASSERTCMP(object->n_ops, ==, 0);
-		ASSERTCMP(object->n_children, ==, 0);
 
 		kfree(object->d_name);
 
-		cache = object->cache;
-		fscache_object_destroy(object);
+		cache = object->volume->cache->cache;
+		fscache_put_cookie(object->cookie, fscache_cookie_put_object);
+		object->cookie = NULL;
 		kmem_cache_free(cachefiles_object_jar, object);
-		fscache_object_destroyed(cache);
+		if (atomic_dec_and_test(&cache->object_count))
+			wake_up_all(&cachefiles_clearance_wq);
 	}
 
 	_leave("");
@@ -228,15 +284,12 @@ void cachefiles_put_object(struct cachefiles_object *object,
 /*
  * sync a cache
  */
-static void cachefiles_sync_cache(struct fscache_cache *_cache)
+void cachefiles_sync_cache(struct cachefiles_cache *cache)
 {
-	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
 	int ret;
 
-	_enter("%s", _cache->tag->name);
-
-	cache = container_of(_cache, struct cachefiles_cache, cache);
+	_enter("%s", cache->cache->name);
 
 	/* make sure all pages pinned by operations on behalf of the netfs are
 	 * written to disc */
@@ -248,8 +301,7 @@ static void cachefiles_sync_cache(struct fscache_cache *_cache)
 
 	if (ret == -EIO)
 		cachefiles_io_error(cache,
-				    "Attempt to sync backing fs superblock"
-				    " returned error %d",
+				    "Attempt to sync backing fs superblock returned error %d",
 				    ret);
 }
 
@@ -259,7 +311,7 @@ static void cachefiles_sync_cache(struct fscache_cache *_cache)
  */
 static int cachefiles_attr_changed(struct cachefiles_object *object)
 {
-	struct cachefiles_cache *cache;
+	struct cachefiles_cache *cache = object->volume->cache;
 	const struct cred *saved_cred;
 	struct iattr newattrs;
 	struct file *file = object->file;
@@ -276,13 +328,6 @@ static int cachefiles_attr_changed(struct cachefiles_object *object)
 	if (!file)
 		return -ENOBUFS;
 
-	cache = container_of(object->cache, struct cachefiles_cache, cache);
-
-	if (ni_size == object->i_size)
-		return 0;
-
-	ASSERT(d_is_reg(file->f_path.dentry));
-
 	oi_size = i_size_read(file_inode(file));
 	if (oi_size == ni_size)
 		return 0;
@@ -321,20 +366,18 @@ static int cachefiles_attr_changed(struct cachefiles_object *object)
 }
 
 /*
- * Invalidate an object
+ * Invalidate the storage associated with a cookie.
  */
-static void cachefiles_invalidate_object(struct cachefiles_object *object)
+static bool cachefiles_invalidate_cookie(struct fscache_cookie *cookie,
+					 unsigned int flags)
 {
-	struct cachefiles_cache *cache;
+	struct cachefiles_object *object = cookie->cache_priv;
+	struct cachefiles_cache *cache = object->volume->cache;
 	const struct cred *saved_cred;
 	struct file *file = object->file;
-	uint64_t ni_size;
+	uint64_t ni_size = cookie->object_size;
 	int ret;
 
-	cache = container_of(object->cache, struct cachefiles_cache, cache);
-
-	ni_size = object->cookie->object_size;
-
 	_enter("{OBJ%x},[%llu]",
 	       object->debug_id, (unsigned long long)ni_size);
 
@@ -359,22 +402,19 @@ static void cachefiles_invalidate_object(struct cachefiles_object *object)
 			if (ret == -EIO)
 				cachefiles_io_error_obj(object,
 							"Invalidate failed");
+			return false;
 		}
 	}
 
-	_leave("");
+	return true;
 }
 
 const struct fscache_cache_ops cachefiles_cache_ops = {
 	.name			= "cachefiles",
-	.alloc_object		= cachefiles_alloc_object,
-	.lookup_object		= cachefiles_lookup_object,
-	.lookup_complete	= cachefiles_lookup_complete,
-	.grab_object		= cachefiles_grab_object,
-	.update_object		= cachefiles_update_object,
-	.invalidate_object	= cachefiles_invalidate_object,
-	.drop_object		= cachefiles_drop_object,
-	.put_object		= cachefiles_put_object,
-	.sync_cache		= cachefiles_sync_cache,
+	.acquire_volume		= cachefiles_acquire_volume,
+	.free_volume		= cachefiles_free_volume,
+	.lookup_cookie		= cachefiles_lookup_cookie,
+	.withdraw_cookie	= cachefiles_withdraw_cookie,
+	.invalidate_cookie	= cachefiles_invalidate_cookie,
 	.begin_operation	= cachefiles_begin_operation,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 92f90a5a4e93..d8a70ecbe94a 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -31,16 +31,50 @@ extern unsigned cachefiles_debug;
 
 #define cachefiles_gfp (__GFP_RECLAIM | __GFP_NORETRY | __GFP_NOMEMALLOC)
 
+/*
+ * Cached volume representation.
+ */
+struct cachefiles_volume {
+	struct cachefiles_cache		*cache;
+	struct list_head		cache_link;	/* Link in cache->volumes */
+	struct fscache_volume		*vcookie;	/* The netfs's representation */
+	struct dentry			*dentry;	/* The volume dentry */
+	struct dentry			*fanout[256];	/* Fanout subdirs */
+};
+
+/*
+ * node records
+ */
+struct cachefiles_object {
+	int				debug_id;	/* debugging ID */
+	spinlock_t			lock;		/* state and operations lock */
+
+	struct list_head		cache_link;	/* Link in cache->*_list */
+	struct cachefiles_volume	*volume;	/* Cache volume that holds this object */
+	struct fscache_cookie		*cookie;	/* netfs's file/index object */
+	struct file			*file;		/* The file representing this object */
+	char				*d_name;	/* Filename */
+	atomic_t			usage;		/* object usage count */
+	u8				d_name_len;	/* Length of filename */
+	u8				key_hash;	/* Hash of object key */
+	unsigned long			flags;
+#define CACHEFILES_OBJECT_IS_NEW	0		/* Set if object is new */
+};
+
 extern struct kmem_cache *cachefiles_object_jar;
 
 /*
  * Cache files cache definition
  */
 struct cachefiles_cache {
-	struct fscache_cache		cache;		/* FS-Cache record */
+	struct fscache_cache		*cache;		/* Cache cookie */
 	struct vfsmount			*mnt;		/* mountpoint holding the cache */
+	struct dentry			*store;		/* Directory into which live objects go */
 	struct dentry			*graveyard;	/* directory into which dead objects go */
 	struct file			*cachefilesd;	/* manager daemon handle */
+	struct list_head		volumes;	/* List of volume objects */
+	struct list_head		object_list;	/* List of active objects */
+	spinlock_t			object_list_lock;
 	const struct cred		*cache_cred;	/* security override for accessing cache */
 	struct mutex			daemon_mutex;	/* command serialisation mutex */
 	wait_queue_head_t		daemon_pollwq;	/* poll waitqueue for daemon */
@@ -79,6 +113,12 @@ struct file *cachefiles_cres_file(struct netfs_cache_resources *cres)
 	return cres->cache_priv2;
 }
 
+static inline
+struct cachefiles_object *cachefiles_cres_object(struct netfs_cache_resources *cres)
+{
+	return fscache_cres_cookie(cres)->cache_priv;
+}
+
 /*
  * note change of state for daemon
  */
@@ -91,6 +131,8 @@ static inline void cachefiles_state_changed(struct cachefiles_cache *cache)
 /*
  * bind.c
  */
+extern wait_queue_head_t cachefiles_clearance_wq;
+
 extern int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args);
 extern void cachefiles_daemon_unbind(struct cachefiles_cache *cache);
 
@@ -106,9 +148,19 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  * interface.c
  */
 extern const struct fscache_cache_ops cachefiles_cache_ops;
+extern void cachefiles_see_object(struct cachefiles_object *object,
+				  enum cachefiles_obj_ref_trace why);
+extern struct cachefiles_object *cachefiles_grab_object(struct cachefiles_object *object,
+							enum cachefiles_obj_ref_trace why);
+extern void cachefiles_put_object(struct cachefiles_object *object,
+				  enum cachefiles_obj_ref_trace why);
+extern void cachefiles_sync_cache(struct cachefiles_cache *cache);
 
-void cachefiles_put_object(struct cachefiles_object *_object,
-			   enum fscache_obj_ref_trace why);
+/*
+ * io.c
+ */
+extern bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
+				       enum fscache_want_stage want_stage);
 
 /*
  * key.c
@@ -119,14 +171,12 @@ extern bool cachefiles_cook_key(struct cachefiles_object *object);
  * namei.c
  */
 extern void cachefiles_unmark_inode_in_use(struct cachefiles_object *object);
-extern int cachefiles_delete_object(struct cachefiles_cache *cache,
-				    struct cachefiles_object *object);
-extern int cachefiles_walk_to_object(struct cachefiles_object *parent,
-				     struct cachefiles_object *object);
+extern int cachefiles_delete_object(struct cachefiles_object *object,
+				    enum fscache_why_object_killed why);
+extern bool cachefiles_walk_to_object(struct cachefiles_object *object);
 extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					       struct dentry *dir,
-					       const char *name,
-					       struct cachefiles_object *object);
+					       const char *name);
 
 extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 			   char *filename);
@@ -134,11 +184,6 @@ extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 extern int cachefiles_check_in_use(struct cachefiles_cache *cache,
 				   struct dentry *dir, char *filename);
 
-/*
- * rdwr2.c
- */
-extern int cachefiles_begin_operation(struct netfs_cache_resources *);
-
 /*
  * security.c
  */
@@ -159,6 +204,13 @@ static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
 	revert_creds(saved_cred);
 }
 
+/*
+ * volume.c
+ */
+void cachefiles_acquire_volume(struct fscache_volume *volume);
+void cachefiles_free_volume(struct fscache_volume *volume);
+void cachefiles_withdraw_volume(struct cachefiles_volume *volume);
+
 /*
  * xattr.c
  */
@@ -175,7 +227,7 @@ extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 #define cachefiles_io_error(___cache, FMT, ...)		\
 do {							\
 	pr_err("I/O Error: " FMT"\n", ##__VA_ARGS__);	\
-	fscache_io_error(&(___cache)->cache);		\
+	fscache_io_error((___cache)->cache);		\
 	set_bit(CACHEFILES_DEAD, &(___cache)->flags);	\
 } while (0)
 
@@ -183,9 +235,9 @@ do {							\
 do {									\
 	struct cachefiles_cache *___cache;				\
 									\
-	___cache = container_of((object)->cache,			\
-				struct cachefiles_cache, cache);	\
-	cachefiles_io_error(___cache, FMT, ##__VA_ARGS__);		\
+	___cache = (object)->volume->cache;				\
+	cachefiles_io_error(___cache, FMT " [o=%08x]", ##__VA_ARGS__,	\
+			    (object)->debug_id);			\
 } while (0)
 
 
@@ -193,7 +245,7 @@ do {									\
  * debug tracing
  */
 #define dbgprintk(FMT, ...) \
-	printk(KERN_DEBUG "[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
+	printk("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
 
 #define kenter(FMT, ...) dbgprintk("==> %s("FMT")", __func__, ##__VA_ARGS__)
 #define kleave(FMT, ...) dbgprintk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index f703a93e238b..e5c29c0decea 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -10,7 +10,7 @@
 #include <linux/file.h>
 #include <linux/uio.h>
 #include <linux/sched/mm.h>
-#include <linux/netfs.h>
+#include <trace/events/fscache.h>
 #include "internal.h"
 
 struct cachefiles_kiocb {
@@ -21,14 +21,17 @@ struct cachefiles_kiocb {
 		size_t		skipped;
 		size_t		len;
 	};
+	struct cachefiles_object *object;
 	netfs_io_terminated_t	term_func;
 	void			*term_func_priv;
 	bool			was_async;
+	unsigned int		inval_counter;	/* Copy of cookie->inval_counter */
 };
 
 static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
 {
 	if (refcount_dec_and_test(&ki->ki_refcnt)) {
+		cachefiles_put_object(ki->object, cachefiles_obj_put_ioreq);
 		fput(ki->iocb.ki_filp);
 		kfree(ki);
 	}
@@ -44,8 +47,13 @@ static void cachefiles_read_complete(struct kiocb *iocb, long ret, long ret2)
 	_enter("%ld,%ld", ret, ret2);
 
 	if (ki->term_func) {
-		if (ret >= 0)
-			ret += ki->skipped;
+		if (ret >= 0) {
+			if (ki->object->cookie->inval_counter == ki->inval_counter)
+				ki->skipped += ret;
+			else
+				ret = -ESTALE;
+		}
+
 		ki->term_func(ki->term_func_priv, ret, ki->was_async);
 	}
 
@@ -62,13 +70,20 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 			   netfs_io_terminated_t term_func,
 			   void *term_func_priv)
 {
-	struct cachefiles_object *object = cres->cache_priv;
+	struct cachefiles_object *object;
 	struct cachefiles_kiocb *ki;
-	struct file *file = cachefiles_cres_file(cres);
+	struct file *file;
 	unsigned int old_nofs;
-	ssize_t ret = -ENODATA;
+	ssize_t ret = -ENOBUFS;
 	size_t len = iov_iter_count(iter), skipped = 0;
 
+	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_READ))
+		goto presubmission_error;
+
+	fscache_count_read();
+	object = cachefiles_cres_object(cres);
+	file = cachefiles_cres_file(cres);
+
 	_enter("%pD,%li,%llx,%zx/%llx",
 	       file, file_inode(file)->i_ino, start_pos, len,
 	       i_size_read(file_inode(file)));
@@ -91,6 +106,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 			 * in the region, so clear the rest of the buffer and
 			 * return success.
 			 */
+			ret = -ENODATA;
 			if (read_hole == NETFS_READ_HOLE_FAIL)
 				goto presubmission_error;
 
@@ -104,7 +120,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 		iov_iter_zero(skipped, iter);
 	}
 
-	ret = -ENOBUFS;
+	ret = -ENOMEM;
 	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
 	if (!ki)
 		goto presubmission_error;
@@ -116,6 +132,8 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
 	ki->iocb.ki_ioprio	= get_current_ioprio();
 	ki->skipped		= skipped;
+	ki->object		= object;
+	ki->inval_counter	= object->cookie->inval_counter;
 	ki->term_func		= term_func;
 	ki->term_func_priv	= term_func_priv;
 	ki->was_async		= true;
@@ -124,6 +142,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 		ki->iocb.ki_complete = cachefiles_read_complete;
 
 	get_file(ki->iocb.ki_filp);
+	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
 
 	trace_cachefiles_read(object, file_inode(file), ki->iocb.ki_pos, len - skipped);
 	old_nofs = memalloc_nofs_save();
@@ -177,7 +196,6 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret, long ret2)
 
 	if (ki->term_func)
 		ki->term_func(ki->term_func_priv, ret, ki->was_async);
-
 	cachefiles_put_kiocb(ki);
 }
 
@@ -190,18 +208,25 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 			    netfs_io_terminated_t term_func,
 			    void *term_func_priv)
 {
-	struct cachefiles_object *object = cres->cache_priv;
+	struct cachefiles_object *object;
 	struct cachefiles_kiocb *ki;
 	struct inode *inode;
-	struct file *file = cachefiles_cres_file(cres);
+	struct file *file;
 	unsigned int old_nofs;
 	ssize_t ret = -ENOBUFS;
 	size_t len = iov_iter_count(iter);
 
+	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
+		goto presubmission_error;
+	fscache_count_write();
+	object = cachefiles_cres_object(cres);
+	file = cachefiles_cres_file(cres);
+
 	_enter("%pD,%li,%llx,%zx/%llx",
 	       file, file_inode(file)->i_ino, start_pos, len,
 	       i_size_read(file_inode(file)));
 
+	ret = -ENOMEM;
 	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
 	if (!ki)
 		goto presubmission_error;
@@ -212,6 +237,8 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
 	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
 	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->object		= object;
+	ki->inval_counter	= object->cookie->inval_counter;
 	ki->start		= start_pos;
 	ki->len			= len;
 	ki->term_func		= term_func;
@@ -231,6 +258,7 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
 
 	get_file(ki->iocb.ki_filp);
+	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
 
 	trace_cachefiles_write(object, inode, ki->iocb.ki_pos, len);
 	old_nofs = memalloc_nofs_save();
@@ -264,8 +292,8 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 
 presubmission_error:
 	if (term_func)
-		term_func(term_func_priv, -ENOMEM, false);
-	return -ENOMEM;
+		term_func(term_func_priv, ret, false);
+	return ret;
 }
 
 /*
@@ -275,33 +303,40 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *subreq,
 						      loff_t i_size)
 {
-#if 0
-	struct fscache_operation *op = subreq->rreq->cache_resources.cache_priv;
+	struct netfs_read_request *rreq = subreq->rreq;
+	struct netfs_cache_resources *cres = &rreq->cache_resources;
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
+	struct fscache_cookie *cookie = fscache_cres_cookie(cres);
 	const struct cred *saved_cred;
-	struct file *file = subreq->rreq->cache_resources.cache_priv2;
+	struct file *file = cachefiles_cres_file(cres);
 	enum netfs_read_source ret = NETFS_DOWNLOAD_FROM_SERVER;
 	loff_t off, to;
 
 	_enter("%zx @%llx/%llx", subreq->len, subreq->start, i_size);
 
-	object = container_of(op->object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-
-	cachefiles_begin_secure(cache, &saved_cred);
-
 	if (subreq->start >= i_size) {
 		ret = NETFS_FILL_WITH_ZEROES;
-		goto out;
+		goto out_no_object;
 	}
 
-	if (!file)
-		goto out;
+	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
+		__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+		goto out_no_object;
+	}
 
-	if (test_bit(FSCACHE_COOKIE_NO_DATA_YET, &object->fscache.cookie->flags))
-		goto download_and_store;
+	/* The object and the file may be being created in the background. */
+	if (!file) {
+		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_READ))
+			goto out_no_object;
+		file = cachefiles_cres_file(cres);
+		if (!file)
+			goto out_no_object;
+	}
+
+	object = cachefiles_cres_object(cres);
+	cache = object->volume->cache;
+	cachefiles_begin_secure(cache, &saved_cred);
 
 	off = vfs_llseek(file, subreq->start, SEEK_DATA);
 	if (off < 0 && off >= (loff_t)-MAX_ERRNO) {
@@ -339,10 +374,8 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 		__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
 out:
 	cachefiles_end_secure(cache, saved_cred);
+out_no_object:
 	return ret;
-#endif
-	return subreq->start >= i_size ?
-		NETFS_FILL_WITH_ZEROES : NETFS_DOWNLOAD_FROM_SERVER;
 }
 
 /*
@@ -367,19 +400,12 @@ static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
 static int cachefiles_prepare_fallback_write(struct netfs_cache_resources *cres,
 					     pgoff_t index)
 {
-#if 0
-	struct fscache_operation *op = cres->cache_priv;
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
+	struct cachefiles_object *object = cachefiles_cres_object(cres);
+	struct cachefiles_cache *cache = object->volume->cache;
 
 	_enter("%lx", index);
 
-	object = container_of(op->object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
 	return cachefiles_has_space(cache, 0, 1);
-#endif
-	return -ENOBUFS;
 }
 
 /*
@@ -387,20 +413,11 @@ static int cachefiles_prepare_fallback_write(struct netfs_cache_resources *cres,
  */
 static void cachefiles_end_operation(struct netfs_cache_resources *cres)
 {
-#if 0
-	struct fscache_operation *op = cres->cache_priv;
 	struct file *file = cachefiles_cres_file(cres);
 
-	_enter("");
-
 	if (file)
 		fput(file);
-	if (op) {
-		fscache_op_complete(op, false);
-		fscache_put_operation(op);
-	}
-	_leave("");
-#endif
+	fscache_end_cookie_access(fscache_cres_cookie(cres), fscache_access_io_end);
 }
 
 static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
@@ -415,20 +432,25 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 /*
  * Open the cache file when beginning a cache operation.
  */
-int cachefiles_begin_operation(struct netfs_cache_resources *cres)
+bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
+				enum fscache_want_stage want_stage)
 {
-#if 0
-	struct cachefiles_object *object = op->object;
+	struct cachefiles_object *object = cachefiles_cres_object(cres);
+
+	if (!cachefiles_cres_file(cres)) {
+		cres->ops = &cachefiles_netfs_cache_ops;
+		if (object) {
+			spin_lock(&object->lock);
+			if (!cres->cache_priv2 && object->file)
+				cres->cache_priv2 = get_file(object->file);
+			spin_unlock(&object->lock);
+		}
+	}
 
-	_enter("");
+	if (!cachefiles_cres_file(cres) && want_stage != FSCACHE_WANT_PARAMS) {
+		pr_err("failed to get cres->file\n");
+		return false;
+	}
 
-	cres->cache_priv	= object;
-	cres->cache_priv2	= get_file(object->file);
-	cres->ops		= &cachefiles_netfs_cache_ops;
-	cres->debug_id		= object->cookie->debug_id;
-	_leave("");
-	return 0;
-#endif
-	cres->ops = &cachefiles_netfs_cache_ops;
-	return -EIO;
+	return true;
 }
diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
index ccadbc4776f1..635166d2d7a9 100644
--- a/fs/cachefiles/key.c
+++ b/fs/cachefiles/key.c
@@ -22,6 +22,11 @@ static const char cachefiles_filecharmap[256] = {
 	[48 ... 127] = 1,		/* '0' -> '~' */
 };
 
+static inline unsigned int how_many_hex_digits(unsigned int x)
+{
+	return x ? round_up(ilog2(x) + 1, 4) / 4 : 0;
+}
+
 /*
  * turn the raw key into something cooked
  * - the key may be up to NAME_MAX in length (including the length word)
@@ -31,21 +36,20 @@ static const char cachefiles_filecharmap[256] = {
  */
 bool cachefiles_cook_key(struct cachefiles_object *object)
 {
-	const u8 *key = fscache_get_key(object->cookie);
-	unsigned int acc, sum, keylen = object->cookie->key_len;
-	char *name;
-	u8 *buffer, *p;
-	int i, len, elem3, print;
-	u8 type;
+	const u8 *key = fscache_get_key(object->cookie), *kend;
+	unsigned char sum, ch;
+	unsigned int acc, i, n, nle, nbe, keylen = object->cookie->key_len;
+	unsigned int b64len, len, print, pad;
+	char *name, sep;
 
-	_enter(",%d", keylen);
+	_enter(",%u,%*phN", keylen, keylen, key);
 
 	BUG_ON(keylen > NAME_MAX - 3);
 
 	sum = 0;
 	print = 1;
 	for (i = 0; i < keylen; i++) {
-		u8 ch = key[i];
+		ch = key[i];
 		sum += ch;
 		print &= cachefiles_filecharmap[ch];
 	}
@@ -53,63 +57,72 @@ bool cachefiles_cook_key(struct cachefiles_object *object)
 
 	/* If the path is usable ASCII, then we render it directly */
 	if (print) {
-		name = kmalloc(3 + keylen + 1, cachefiles_gfp);
+		len = 1 + keylen + 1;
+		name = kmalloc(len, cachefiles_gfp);
 		if (!name)
 			return false;
 
-		switch (object->cookie->type) {
-		case FSCACHE_COOKIE_TYPE_INDEX:		type = 'I';	break;
-		case FSCACHE_COOKIE_TYPE_DATAFILE:	type = 'D';	break;
-		default:				type = 'S';	break;
-		}
-
-		name[0] = type;
-		name[1] = cachefiles_charmap[(keylen >> 6) & 63];
-		name[2] = cachefiles_charmap[keylen & 63];
-
-		memcpy(name + 3, key, keylen);
-		name[3 + keylen] = 0;
-		object->d_name = name;
-		object->d_name_len = 3 + keylen;
+		name[0] = 'D'; /* Data object type, string encoding */
+		name[1 + keylen] = 0;
+		memcpy(name + 1, key, keylen);
 		goto success;
 	}
 
-	/* Construct the key we actually want to render.  We stick the length
-	 * on the front and leave NULs on the back for the encoder to overread.
+	/* See if it makes sense to encode it as "hex,hex,hex" for each 32-bit
+	 * chunk.  We rely on the key having been padded out to a whole number
+	 * of 32-bit words.
 	 */
-	buffer = kmalloc(2 + keylen + 3, cachefiles_gfp);
-	if (!buffer)
-		return false;
-
-	memcpy(buffer + 2, key, keylen);
-
-	*(uint16_t *)buffer = keylen;
-	((char *)buffer)[keylen + 2] = 0;
-	((char *)buffer)[keylen + 3] = 0;
-	((char *)buffer)[keylen + 4] = 0;
-
-	elem3 = DIV_ROUND_UP(2 + keylen, 3); /* Count of 3-byte elements */
-	len = elem3 * 4;
-
-	name = kmalloc(1 + len + 1, cachefiles_gfp);
-	if (!name) {
-		kfree(buffer);
-		return false;
+	n = round_up(keylen, 4);
+	nbe = nle = 0;
+	for (i = 0; i < n; i += 4) {
+		u32 be = be32_to_cpu(*(__be32 *)(key + i));
+		u32 le = le32_to_cpu(*(__le32 *)(key + i));
+
+		nbe += 1 + how_many_hex_digits(be);
+		nle += 1 + how_many_hex_digits(le);
 	}
 
-	switch (object->cookie->type) {
-	case FSCACHE_COOKIE_TYPE_INDEX:		type = 'J';	break;
-	case FSCACHE_COOKIE_TYPE_DATAFILE:	type = 'E';	break;
-	default:				type = 'T';	break;
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
 	}
 
-	name[0] = type;
-	len = 1;
-	p = buffer;
-	for (i = 0; i < elem3; i++) {
-		acc = *p++;
-		acc |= *p++ << 8;
-		acc |= *p++ << 16;
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
 
 		name[len++] = cachefiles_charmap[acc & 63];
 		acc >>= 6;
@@ -118,13 +131,12 @@ bool cachefiles_cook_key(struct cachefiles_object *object)
 		name[len++] = cachefiles_charmap[acc & 63];
 		acc >>= 6;
 		name[len++] = cachefiles_charmap[acc & 63];
-	}
+	} while (key < kend);
 
+success:
 	name[len] = 0;
 	object->d_name = name;
 	object->d_name_len = len;
-	kfree(buffer);
-success:
 	_leave(" = %s", object->d_name);
 	return true;
 }
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index d3115106b22b..dc7731812b98 100644
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
index cb08be5fb28e..f7e73aba9104 100644
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
@@ -51,6 +49,9 @@ void cachefiles_unmark_inode_in_use(struct cachefiles_object *object)
 {
 	struct inode *inode = file_inode(object->file);
 
+	if (!inode)
+		return;
+
 	inode_lock(inode);
 	inode->i_flags &= ~S_KERNEL_FILE;
 	inode_unlock(inode);
@@ -60,9 +61,9 @@ void cachefiles_unmark_inode_in_use(struct cachefiles_object *object)
 /*
  * Mark an object as being inactive.
  */
-static void cachefiles_mark_object_inactive(struct cachefiles_cache *cache,
-					    struct cachefiles_object *object)
+static void cachefiles_mark_object_inactive(struct cachefiles_object *object)
 {
+	struct cachefiles_cache *cache = object->volume->cache;
 	blkcnt_t i_blocks = file_inode(object->file)->i_blocks;
 
 	/* This object can now be culled, so we need to let the daemon know
@@ -78,7 +79,6 @@ static void cachefiles_mark_object_inactive(struct cachefiles_cache *cache,
  * - file backed objects are unlinked
  * - directory backed objects are stuffed into the graveyard for userspace to
  *   delete
- * - unlocks the directory mutex
  */
 static int cachefiles_bury_object(struct cachefiles_cache *cache,
 				  struct cachefiles_object *object,
@@ -93,6 +93,12 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 
 	_enter(",'%pd','%pd'", dir, rep);
 
+	if (rep->d_parent != dir) {
+		inode_unlock(d_inode(dir));
+		_leave(" = -ESTALE");
+		return -ESTALE;
+	}
+
 	/* non-directories can just be unlinked */
 	if (!d_is_dir(rep)) {
 		_debug("unlink stale object");
@@ -229,45 +235,24 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 /*
  * delete an object representation from the cache
  */
-int cachefiles_delete_object(struct cachefiles_cache *cache,
-			     struct cachefiles_object *object)
+int cachefiles_delete_object(struct cachefiles_object *object,
+			     enum fscache_why_object_killed why)
 {
-	struct dentry *dentry = object->file->f_path.dentry, *dir;
-	int ret;
+	struct cachefiles_volume *volume = object->volume;
+	struct dentry *fan = volume->fanout[(u8)object->key_hash];
 
 	_enter(",OBJ%x{%pD}", object->debug_id, object->file);
 
-	ASSERT(d_backing_inode(dentry));
-	ASSERT(dentry->d_parent);
-
-	dir = dget_parent(dentry);
-
-	inode_lock_nested(d_backing_inode(dir), I_MUTEX_PARENT);
-
-	/* We need to check that our parent is _still_ our parent - it may have
-	 * been renamed.
-	 */
-	if (dir == dentry->d_parent) {
-		ret = cachefiles_bury_object(cache, object, dir, dentry,
-					     FSCACHE_OBJECT_WAS_RETIRED);
-	} else {
-		/* It got moved, presumably by cachefilesd culling it, so it's
-		 * no longer in the key path and we can ignore it.
-		 */
-		inode_unlock(d_backing_inode(dir));
-		ret = 0;
-	}
-
-	dput(dir);
-	_leave(" = %d", ret);
-	return ret;
+	inode_lock_nested(d_backing_inode(fan), I_MUTEX_PARENT);
+	return cachefiles_bury_object(volume->cache, object, fan,
+				      object->file->f_path.dentry, why);
 }
 
 /*
- * Check and open the terminal object.
+ * Check the attributes on a file we've just opened and delete it if it's out
+ * of date.
  */
-static int cachefiles_check_open_object(struct cachefiles_cache *cache,
-					struct cachefiles_object *object,
+static int cachefiles_check_open_object(struct cachefiles_object *object,
 					struct dentry *fan)
 {
 	int ret;
@@ -275,43 +260,32 @@ static int cachefiles_check_open_object(struct cachefiles_cache *cache,
 	if (!cachefiles_mark_inode_in_use(object))
 		return -EBUSY;
 
-	/* if we've found that the terminal object exists, then we need to
-	 * check its attributes and delete it if it's out of date */
-	if (!object->new) {
-		_debug("validate '%pD'", object->file);
-
-		ret = cachefiles_check_auxdata(object);
-		if (ret == -ESTALE)
-			goto stale;
-		if (ret < 0)
-			goto error_unmark;
-	}
-
-	_debug("=== OBTAINED_OBJECT ===");
+	_enter("%pD", object->file);
 
-	if (object->new) {
-		/* attach data to a newly constructed terminal object */
-		ret = cachefiles_set_object_xattr(object);
-		if (ret < 0)
-			goto error_unmark;
-	} else {
-		/* always update the atime on an object we've just looked up
-		 * (this is used to keep track of culling, and atimes are only
-		 * updated by read, write and readdir but not lookup or
-		 * open) */
-		touch_atime(&object->file->f_path);
-	}
+	ret = cachefiles_check_auxdata(object);
+	if (ret == -ESTALE)
+		goto stale;
+	if (ret < 0)
+		goto error_unmark;
 
+	/* Always update the atime on an object we've just looked up (this is
+	 * used to keep track of culling, and atimes are only updated by read,
+	 * write and readdir but not lookup or open).
+	 */
+	touch_atime(&object->file->f_path);
 	return 0;
 
 stale:
+	set_bit(CACHEFILES_OBJECT_IS_NEW, &object->flags);
+	fscache_cookie_lookup_negative(object->cookie);
 	cachefiles_unmark_inode_in_use(object);
 	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
-	ret = cachefiles_bury_object(cache, object, fan,
+	ret = cachefiles_bury_object(object->volume->cache, object, fan,
 				     object->file->f_path.dentry,
 				     FSCACHE_OBJECT_IS_STALE);
 	if (ret < 0)
 		return ret;
+	cachefiles_mark_object_inactive(object);
 	_debug("redo lookup");
 	return -ESTALE;
 
@@ -321,12 +295,12 @@ static int cachefiles_check_open_object(struct cachefiles_cache *cache,
 }
 
 /*
- * Walk to a file, creating it if necessary.
+ * Look up a file, creating it if necessary.
  */
-static int cachefiles_open_file(struct cachefiles_cache *cache,
-				struct cachefiles_object *object,
+static int cachefiles_open_file(struct cachefiles_object *object,
 				struct dentry *fan)
 {
+	struct cachefiles_cache *cache = object->volume->cache;
 	struct dentry *dentry;
 	struct inode *dinode = d_backing_inode(fan), *inode;
 	struct file *file;
@@ -345,16 +319,11 @@ static int cachefiles_open_file(struct cachefiles_cache *cache,
 	}
 
 	if (d_is_negative(dentry)) {
-		/* This element of the path doesn't exist, so we can release
-		 * any readers in the certain knowledge that there's nothing
-		 * for them to actually read */
-		fscache_object_lookup_negative(object);
+		fscache_cookie_lookup_negative(object->cookie);
 
 		ret = cachefiles_has_space(cache, 1, 0);
-		if (ret < 0) {
-			fscache_object_mark_killed(object, FSCACHE_OBJECT_NO_SPACE);
+		if (ret < 0)
 			goto error_dput;
-		}
 
 		fan_path.mnt = cache->mnt;
 		fan_path.dentry = fan;
@@ -368,6 +337,7 @@ static int cachefiles_open_file(struct cachefiles_cache *cache,
 
 		inode = d_backing_inode(dentry);
 		_debug("create -> %pd{ino=%lu}", dentry, inode->i_ino);
+		set_bit(CACHEFILES_OBJECT_IS_NEW, &object->flags);
 
 	} else if (!d_is_reg(dentry)) {
 		inode = d_backing_inode(dentry);
@@ -415,81 +385,36 @@ static int cachefiles_open_file(struct cachefiles_cache *cache,
 	return ret;
 }
 
-/*
- * Walk over the fanout directory.
- */
-static struct dentry *cachefiles_walk_over_fanout(struct cachefiles_object *object,
-						  struct cachefiles_cache *cache,
-						  struct dentry *dir)
-{
-	char name[4];
-
-	snprintf(name, sizeof(name), "@%02x", object->key_hash);
-	return cachefiles_get_directory(cache, dir, name, object);
-}
-
 /*
  * walk from the parent object to the child object through the backing
  * filesystem, creating directories as we go
  */
-int cachefiles_walk_to_object(struct cachefiles_object *parent,
-			      struct cachefiles_object *object)
+bool cachefiles_walk_to_object(struct cachefiles_object *object)
 {
-	struct cachefiles_cache *cache;
+	struct cachefiles_volume *volume = object->cookie->volume->cache_priv;
 	struct dentry *fan;
 	int ret;
 
-	_enter("OBJ%x{%pD},OBJ%x,%s,",
-	       parent->debug_id, parent->file,
-	       object->debug_id, object->d_name);
-
-	cache = container_of(parent->cache, struct cachefiles_cache, cache);
-	ASSERT(parent->file);
+	_enter("OBJ%x,%s,", object->debug_id, object->d_name);
 
 lookup_again:
-	fan = cachefiles_walk_over_fanout(object, cache, parent->file->f_path.dentry);
-	if (IS_ERR(fan))
-		return PTR_ERR(fan);
-
-	/* Open path "parent/fanout/object". */
-	if (object->type == FSCACHE_COOKIE_TYPE_INDEX) {
-		struct dentry *dentry;
-		struct file *file;
-		struct path path;
-
-		dentry = cachefiles_get_directory(cache, fan, object->d_name,
-						  object);
-		if (IS_ERR(dentry)) {
-			dput(fan);
-			return PTR_ERR(dentry);
-		}
-		path.mnt = cache->mnt;
-		path.dentry = dentry;
-		file = open_with_fake_path(&path, O_RDONLY | O_DIRECTORY,
-					   d_backing_inode(dentry),
-					   cache->cache_cred);
-		dput(dentry);
-		if (IS_ERR(file)) {
-			dput(fan);
-			return PTR_ERR(file);
-		}
-		object->file = file;
+	/* Open path "cache/vol/fanout/file". */
+	fan = volume->fanout[(u8)object->key_hash];
+	ret = cachefiles_open_file(object, fan);
+	if (ret < 0)
+		goto lookup_error;
+
+	if (!test_bit(CACHEFILES_OBJECT_IS_NEW, &object->flags)) {
+		ret = cachefiles_check_open_object(object, fan);
+		if (ret < 0)
+			goto check_error;
 	} else {
-		ret = cachefiles_open_file(cache, object, fan);
-		if (ret < 0) {
-			dput(fan);
-			return ret;
-		}
+		ret = -EBUSY;
+		if (!cachefiles_mark_inode_in_use(object))
+			goto check_error;
 	}
 
-	ret = cachefiles_check_open_object(cache, object, fan);
-	dput(fan);
-	fan = NULL;
-	if (ret < 0)
-		goto check_error;
-
-	object->new = false;
-	fscache_obtained_object(object);
+	clear_bit(CACHEFILES_OBJECT_IS_NEW, &object->flags);
 	_leave(" = t [%lu]", file_inode(object->file)->i_ino);
 	return true;
 
@@ -498,11 +423,10 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	object->file = NULL;
 	if (ret == -ESTALE)
 		goto lookup_again;
+lookup_error:
 	if (ret == -EIO)
 		cachefiles_io_error_obj(object, "Lookup failed");
-	cachefiles_mark_object_inactive(cache, object);
-	_leave(" = error %d", ret);
-	return ret;
+	return false;
 }
 
 /*
@@ -510,8 +434,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
  */
 struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					struct dentry *dir,
-					const char *dirname,
-					struct cachefiles_object *object)
+					const char *dirname)
 {
 	struct dentry *subdir;
 	struct path path;
@@ -535,12 +458,6 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 
 	/* we need to create the subdir if it doesn't exist yet */
 	if (d_is_negative(subdir)) {
-		/* This element of the path doesn't exist, so we can release
-		 * any readers in the certain knowledge that there's nothing
-		 * for them to actually read */
-		if (object)
-			fscache_object_lookup_negative(object);
-
 		ret = cachefiles_has_space(cache, 1, 0);
 		if (ret < 0)
 			goto mkdir_error;
@@ -564,8 +481,6 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 
 		_debug("mkdir -> %pd{ino=%lu}",
 		       subdir, d_backing_inode(subdir)->i_ino);
-		if (object)
-			object->new = true;
 	}
 
 	inode_unlock(d_inode(dir));
diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
new file mode 100644
index 000000000000..f5e527b56228
--- /dev/null
+++ b/fs/cachefiles/volume.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Volume handling.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include "internal.h"
+#include <trace/events/fscache.h>
+
+/*
+ * Allocate and set up a volume representation.  We make sure all the fanout
+ * directories are created and pinned.
+ */
+void cachefiles_acquire_volume(struct fscache_volume *vcookie)
+{
+	struct cachefiles_volume *volume;
+	struct cachefiles_cache *cache = vcookie->cache->cache_priv;
+	const struct cred *saved_cred;
+	struct dentry *vdentry, *fan;
+	size_t len;
+	char *name;
+	int n_accesses, i;
+
+	_enter("");
+
+	volume = kzalloc(sizeof(struct cachefiles_volume), GFP_KERNEL);
+	if (!volume)
+		return;
+	volume->vcookie = vcookie;
+	volume->cache = cache;
+	INIT_LIST_HEAD(&volume->cache_link);
+
+	cachefiles_begin_secure(cache, &saved_cred);
+
+	len = vcookie->key[0];
+	name = kmalloc(len + 3, GFP_NOFS);
+	if (!name)
+		goto error_vol;
+	name[0] = 'I';
+	memcpy(name + 1, vcookie->key + 1, len);
+	name[len + 1] = 0;
+
+	vdentry = cachefiles_get_directory(cache, cache->store, name);
+	if (IS_ERR(vdentry))
+		goto error_name;
+	volume->dentry = vdentry;
+
+	for (i = 0; i < 256; i++) {
+		sprintf(name, "@%02x", i);
+		fan = cachefiles_get_directory(cache, vdentry, name);
+		if (IS_ERR(fan))
+			goto error_fan;
+		volume->fanout[i] = fan;
+	}
+
+	cachefiles_end_secure(cache, saved_cred);
+
+	vcookie->cache_priv = volume;
+	n_accesses = atomic_inc_return(&vcookie->n_accesses); /* Stop wakeups on dec-to-0 */
+	trace_fscache_access_volume(vcookie->debug_id, refcount_read(&vcookie->ref),
+				    n_accesses, fscache_access_cache_pin);
+
+	spin_lock(&cache->object_list_lock);
+	list_add(&volume->cache_link, &volume->cache->volumes);
+	spin_unlock(&cache->object_list_lock);
+
+	kfree(name);
+	return;
+
+error_fan:
+	for (i = 0; i < 256; i++)
+		dput(volume->fanout[i]);
+	dput(volume->dentry);
+error_name:
+	kfree(name);
+error_vol:
+	kfree(volume);
+	cachefiles_end_secure(cache, saved_cred);
+}
+
+/*
+ * Release a volume representation.
+ */
+static void __cachefiles_free_volume(struct cachefiles_volume *volume)
+{
+	int i;
+
+	_enter("");
+
+	volume->vcookie->cache_priv = NULL;
+
+	for (i = 0; i < 256; i++)
+		dput(volume->fanout[i]);
+	dput(volume->dentry);
+	kfree(volume);
+}
+
+void cachefiles_free_volume(struct fscache_volume *vcookie)
+{
+	struct cachefiles_volume *volume = vcookie->cache_priv;
+
+	if (volume) {
+		spin_lock(&volume->cache->object_list_lock);
+		list_del_init(&volume->cache_link);
+		spin_unlock(&volume->cache->object_list_lock);
+		__cachefiles_free_volume(volume);
+	}
+}
+
+void cachefiles_withdraw_volume(struct cachefiles_volume *volume)
+{
+	struct fscache_volume *vcookie = volume->vcookie;
+	int n_accesses;
+
+	_debug("withdraw V=%x", vcookie->debug_id);
+
+	/* Allow wakeups on dec-to-0 */
+	n_accesses = atomic_dec_return(&vcookie->n_accesses);
+	trace_fscache_access_volume(vcookie->debug_id, refcount_read(&vcookie->ref),
+				    n_accesses, fscache_access_cache_unpin);
+
+	wait_var_event(&vcookie->n_accesses,
+		       atomic_read(&vcookie->n_accesses) == 0);
+	__cachefiles_free_volume(volume);
+}
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 82c822bb71af..b77bbb6c4a17 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -15,6 +15,8 @@
 #include <linux/slab.h>
 #include "internal.h"
 
+#define CACHEFILES_COOKIE_TYPE_DATA 1
+
 struct cachefiles_xattr {
 	uint8_t				type;
 	uint8_t				data[];
@@ -44,11 +46,10 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 	if (!buf)
 		return -ENOMEM;
 
-	buf->type = object->cookie->type;
+	buf->type = CACHEFILES_COOKIE_TYPE_DATA;
 	if (len > 0)
 		memcpy(buf->data, fscache_get_aux(object->cookie), len);
 
-	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->cookie->flags);
 	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
 			   buf, sizeof(struct cachefiles_xattr) + len, 0);
 	if (ret < 0) {
@@ -95,7 +96,7 @@ int cachefiles_check_auxdata(struct cachefiles_object *object)
 				object,
 				"Failed to read aux with error %zd", xlen);
 		why = cachefiles_coherency_check_xattr;
-	} else if (buf->type != object->cookie->type) {
+	} else if (buf->type != CACHEFILES_COOKIE_TYPE_DATA) {
 		why = cachefiles_coherency_check_type;
 	} else if (memcmp(buf->data, p, len) != 0) {
 		why = cachefiles_coherency_check_aux;
diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index 14dfdce1c045..afb090ea16c4 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -6,11 +6,9 @@
 fscache-y := \
 	cache.o \
 	cookie.o \
-	fsdef.o \
 	io.o \
 	main.o \
-	netfs.o \
-	object.o
+	volume.o
 
 fscache-$(CONFIG_PROC_FS) += proc.o
 fscache-$(CONFIG_FSCACHE_STATS) += stats.o
diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index 8a3191a89c32..45bb38f5cf1c 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -1,198 +1,181 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /* FS-Cache cache handling
  *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2007, 2021 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  */
 
 #define FSCACHE_DEBUG_LEVEL CACHE
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include "internal.h"
 
-LIST_HEAD(fscache_cache_list);
+static LIST_HEAD(fscache_caches);
 DECLARE_RWSEM(fscache_addremove_sem);
-DECLARE_WAIT_QUEUE_HEAD(fscache_cache_cleared_wq);
-EXPORT_SYMBOL(fscache_cache_cleared_wq);
+EXPORT_SYMBOL(fscache_addremove_sem);
 
-static LIST_HEAD(fscache_cache_tag_list);
+static atomic_t fscache_cache_debug_id;
 
 /*
- * look up a cache tag
+ * Allocate a cache cookie.
  */
-struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *name)
+static struct fscache_cache *fscache_alloc_cache(const char *name)
 {
-	struct fscache_cache_tag *tag, *xtag;
-
-	/* firstly check for the existence of the tag under read lock */
-	down_read(&fscache_addremove_sem);
-
-	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
-		if (strcmp(tag->name, name) == 0) {
-			atomic_inc(&tag->usage);
-			refcount_inc(&tag->ref);
-			up_read(&fscache_addremove_sem);
-			return tag;
-		}
-	}
-
-	up_read(&fscache_addremove_sem);
-
-	/* the tag does not exist - create a candidate */
-	xtag = kzalloc(sizeof(*xtag) + strlen(name) + 1, GFP_KERNEL);
-	if (!xtag)
-		/* return a dummy tag if out of memory */
-		return ERR_PTR(-ENOMEM);
-
-	atomic_set(&xtag->usage, 1);
-	refcount_set(&xtag->ref, 1);
-	strcpy(xtag->name, name);
-
-	/* write lock, search again and add if still not present */
-	down_write(&fscache_addremove_sem);
+	struct fscache_cache *cache;
 
-	list_for_each_entry(tag, &fscache_cache_tag_list, link) {
-		if (strcmp(tag->name, name) == 0) {
-			atomic_inc(&tag->usage);
-			refcount_inc(&tag->ref);
-			up_write(&fscache_addremove_sem);
-			kfree(xtag);
-			return tag;
+	cache = kzalloc(sizeof(*cache), GFP_KERNEL);
+	if (cache) {
+		if (name) {
+			cache->name = kstrdup(name, GFP_KERNEL);
+			if (!cache->name) {
+				kfree(cache);
+				return NULL;
+			}
 		}
+		refcount_set(&cache->ref, 1);
+		INIT_LIST_HEAD(&cache->cache_link);
+		cache->debug_id = atomic_inc_return(&fscache_cache_debug_id);
 	}
-
-	list_add_tail(&xtag->link, &fscache_cache_tag_list);
-	up_write(&fscache_addremove_sem);
-	return xtag;
+	return cache;
 }
 
-/*
- * Unuse a cache tag
- */
-void __fscache_release_cache_tag(struct fscache_cache_tag *tag)
+static bool fscache_get_cache_maybe(struct fscache_cache *cache,
+				    enum fscache_cache_trace where)
 {
-	if (tag != ERR_PTR(-ENOMEM)) {
-		down_write(&fscache_addremove_sem);
-
-		if (atomic_dec_and_test(&tag->usage))
-			list_del_init(&tag->link);
-		else
-			tag = NULL;
+	bool success;
+	int ref;
 
-		up_write(&fscache_addremove_sem);
-		fscache_put_cache_tag(tag);
-	}
+	success = __refcount_inc_not_zero(&cache->ref, &ref);
+	if (success)
+		trace_fscache_cache(cache->debug_id, ref + 1, where);
+	return success;
 }
 
 /*
- * select a cache in which to store an object
- * - the cache addremove semaphore must be at least read-locked by the caller
- * - the object will never be an index
+ * Look up a cache cookie.
  */
-struct fscache_cache *fscache_select_cache_for_object(
-	struct fscache_cookie *cookie)
+struct fscache_cache *fscache_lookup_cache(const char *name, bool is_cache)
 {
-	struct fscache_cache_tag *tag;
-	struct cachefiles_object *object;
-	struct fscache_cache *cache;
+	struct fscache_cache *candidate, *cache, *unnamed = NULL;
 
-	_enter("");
+	/* firstly check for the existence of the cache under read lock */
+	down_read(&fscache_addremove_sem);
 
-	if (list_empty(&fscache_cache_list)) {
-		_leave(" = NULL [no cache]");
-		return NULL;
+	list_for_each_entry(cache, &fscache_caches, cache_link) {
+		if (cache->name && name && strcmp(cache->name, name) == 0 &&
+		    fscache_get_cache_maybe(cache, fscache_cache_get_acquire))
+			goto got_cache_r;
+		if (!cache->name && !name &&
+		    fscache_get_cache_maybe(cache, fscache_cache_get_acquire))
+			goto got_cache_r;
 	}
 
-	/* we check the parent to determine the cache to use */
-	spin_lock(&cookie->lock);
+	if (!name) {
+		list_for_each_entry(cache, &fscache_caches, cache_link) {
+			if (cache->name &&
+			    fscache_get_cache_maybe(cache, fscache_cache_get_acquire))
+				goto got_cache_r;
+		}
+	}
 
-	/* the first in the parent's backing list should be the preferred
-	 * cache */
-	if (!hlist_empty(&cookie->backing_objects)) {
-		object = hlist_entry(cookie->backing_objects.first,
-				     struct cachefiles_object, cookie_link);
+	up_read(&fscache_addremove_sem);
 
-		cache = object->cache;
-		if (fscache_object_is_dying(object) ||
-		    test_bit(FSCACHE_IOERROR, &cache->flags))
-			cache = NULL;
+	/* the cache does not exist - create a candidate */
+	candidate = fscache_alloc_cache(name);
+	if (!candidate)
+		return ERR_PTR(-ENOMEM);
 
-		spin_unlock(&cookie->lock);
-		_leave(" = %s [parent]", cache ? cache->tag->name : "NULL");
-		return cache;
-	}
+	/* write lock, search again and add if still not present */
+	down_write(&fscache_addremove_sem);
 
-	/* the parent is unbacked */
-	if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX) {
-		/* cookie not an index and is unbacked */
-		spin_unlock(&cookie->lock);
-		_leave(" = NULL [cookie ub,ni]");
-		return NULL;
+	list_for_each_entry(cache, &fscache_caches, cache_link) {
+		if (cache->name && name && strcmp(cache->name, name) == 0 &&
+		    fscache_get_cache_maybe(cache, fscache_cache_get_acquire))
+			goto got_cache_w;
+		if (!cache->name) {
+			unnamed = cache;
+			if (!name &&
+			    fscache_get_cache_maybe(cache, fscache_cache_get_acquire))
+				goto got_cache_w;
+		}
 	}
 
-	spin_unlock(&cookie->lock);
-
-	tag = cookie->preferred_cache;
-	if (!tag)
-		goto no_preference;
+	if (unnamed && is_cache &&
+	    fscache_get_cache_maybe(unnamed, fscache_cache_get_acquire))
+		goto use_unnamed_cache;
 
-	if (!tag->cache) {
-		_leave(" = NULL [unbacked tag]");
-		return NULL;
+	if (!name) {
+		list_for_each_entry(cache, &fscache_caches, cache_link) {
+			if (cache->name &&
+			    fscache_get_cache_maybe(cache, fscache_cache_get_acquire))
+				goto got_cache_w;
+		}
 	}
 
-	if (test_bit(FSCACHE_IOERROR, &tag->cache->flags))
-		return NULL;
-
-	_leave(" = %s [specific]", tag->name);
-	return tag->cache;
+	list_add_tail(&candidate->cache_link, &fscache_caches);
+	trace_fscache_cache(candidate->debug_id,
+			    refcount_read(&candidate->ref),
+			    fscache_cache_new_acquire);
+	up_write(&fscache_addremove_sem);
+	return candidate;
 
-no_preference:
-	/* netfs has no preference - just select first cache */
-	cache = list_entry(fscache_cache_list.next,
-			   struct fscache_cache, link);
-	_leave(" = %s [first]", cache->tag->name);
+got_cache_r:
+	up_read(&fscache_addremove_sem);
+	return cache;
+use_unnamed_cache:
+	cache = unnamed;
+	cache->name = candidate->name;
+	candidate->name = NULL;
+got_cache_w:
+	up_write(&fscache_addremove_sem);
+	kfree(candidate->name);
+	kfree(candidate);
 	return cache;
 }
 
 /**
- * fscache_init_cache - Initialise a cache record
- * @cache: The cache record to be initialised
- * @ops: The cache operations to be installed in that record
- * @idfmt: Format string to define identifier
- * @...: sprintf-style arguments
- *
- * Initialise a record of a cache and fill in the name.
+ * fscache_acquire_cache - Acquire a cache record for a cache.
+ * @name: The name of the cache.
  *
- * See Documentation/filesystems/caching/backend-api.rst for a complete
- * description.
+ * Get a cache record for a cache.  If there is a nameless cache record
+ * available, this will acquire that and set its name, directing all the
+ * volumes using it to this cache.
  */
-void fscache_init_cache(struct fscache_cache *cache,
-			const struct fscache_cache_ops *ops,
-			const char *idfmt,
-			...)
+struct fscache_cache *fscache_acquire_cache(const char *name)
 {
-	va_list va;
+	ASSERT(name);
+	return fscache_lookup_cache(name, true);
+}
+EXPORT_SYMBOL(fscache_acquire_cache);
 
-	memset(cache, 0, sizeof(*cache));
+void fscache_put_cache(struct fscache_cache *cache,
+		       enum fscache_cache_trace where)
+{
+	unsigned int debug_id = cache->debug_id;
+	bool zero;
+	int ref;
 
-	cache->ops = ops;
+	if (IS_ERR_OR_NULL(cache))
+		return;
 
-	va_start(va, idfmt);
-	vsnprintf(cache->identifier, sizeof(cache->identifier), idfmt, va);
-	va_end(va);
+	zero = __refcount_dec_and_test(&cache->ref, &ref);
+	trace_fscache_cache(debug_id, ref - 1, where);
 
-	INIT_LIST_HEAD(&cache->link);
-	INIT_LIST_HEAD(&cache->object_list);
-	spin_lock_init(&cache->object_list_lock);
+	if (zero) {
+		down_write(&fscache_addremove_sem);
+		list_del_init(&cache->cache_link);
+		up_write(&fscache_addremove_sem);
+		kfree(cache->name);
+		kfree(cache);
+	}
 }
-EXPORT_SYMBOL(fscache_init_cache);
+EXPORT_SYMBOL(fscache_put_cache);
 
 /**
  * fscache_add_cache - Declare a cache as being open for business
  * @cache: The record describing the cache
- * @ifsdef: The record of the cache object describing the top-level index
- * @tagname: The tag describing this cache
+ * @ops: Table of cache operations to use
+ * @cache_priv: Private data for the cache record
  *
  * Add a cache to the system, making it available for netfs's to use.
  *
@@ -200,93 +183,72 @@ EXPORT_SYMBOL(fscache_init_cache);
  * description.
  */
 int fscache_add_cache(struct fscache_cache *cache,
-		      struct cachefiles_object *ifsdef,
-		      const char *tagname)
+		      const struct fscache_cache_ops *ops,
+		      void *cache_priv)
 {
-	struct fscache_cache_tag *tag;
-
-	ASSERTCMP(ifsdef->cookie, ==, &fscache_fsdef_index);
-	BUG_ON(!cache->ops);
-	BUG_ON(!ifsdef);
-
-	cache->flags = 0;
-	ifsdef->event_mask =
-		((1 << NR_FSCACHE_OBJECT_EVENTS) - 1) &
-		~(1 << FSCACHE_OBJECT_EV_CLEARED);
-	__set_bit(FSCACHE_OBJECT_IS_AVAILABLE, &ifsdef->flags);
-
-	if (!tagname)
-		tagname = cache->identifier;
-
-	BUG_ON(!tagname[0]);
-
-	_enter("{%s.%s},,%s", cache->ops->name, cache->identifier, tagname);
-
-	/* we use the cache tag to uniquely identify caches */
-	tag = __fscache_lookup_cache_tag(tagname);
-	if (IS_ERR(tag))
-		goto nomem;
+	int n_accesses;
 
-	if (test_and_set_bit(FSCACHE_TAG_RESERVED, &tag->flags))
-		goto tag_in_use;
+	_enter("{%s,%s}", ops->name, cache->name);
 
-	cache->kobj = kobject_create_and_add(tagname, fscache_root);
-	if (!cache->kobj)
-		goto error;
+	BUG_ON(fscache_cache_state(cache) != FSCACHE_CACHE_IS_PREPARING);
 
-	ifsdef->cache = cache;
-	cache->fsdef = ifsdef;
+	/* Get a ref on the cache cookie and keep its n_accesses counter raised
+	 * by 1 to prevent wakeups from transitioning it to 0 until we're
+	 * withdrawing caching services from it.
+	 */
+	n_accesses = atomic_inc_return(&cache->n_accesses);
+	trace_fscache_access_cache(cache->debug_id, refcount_read(&cache->ref),
+				   n_accesses, fscache_access_cache_pin);
 
 	down_write(&fscache_addremove_sem);
 
-	tag->cache = cache;
-	cache->tag = tag;
-
-	/* add the cache to the list */
-	list_add(&cache->link, &fscache_cache_list);
-
-	/* add the cache's netfs definition index object to the cache's
-	 * list */
-	spin_lock(&cache->object_list_lock);
-	list_add_tail(&ifsdef->cache_link, &cache->object_list);
-	spin_unlock(&cache->object_list_lock);
-
-	/* add the cache's netfs definition index object to the top level index
-	 * cookie as a known backing object */
-	spin_lock(&fscache_fsdef_index.lock);
-
-	hlist_add_head(&ifsdef->cookie_link,
-		       &fscache_fsdef_index.backing_objects);
-
-	refcount_inc(&fscache_fsdef_index.ref);
+	cache->ops = ops;
+	cache->cache_priv = cache_priv;
+	fscache_set_cache_state(cache, FSCACHE_CACHE_IS_ACTIVE);
 
-	/* done */
-	spin_unlock(&fscache_fsdef_index.lock);
 	up_write(&fscache_addremove_sem);
-
-	pr_notice("Cache \"%s\" added (type %s)\n",
-		  cache->tag->name, cache->ops->name);
-	kobject_uevent(cache->kobj, KOBJ_ADD);
-
-	_leave(" = 0 [%s]", cache->identifier);
+	pr_notice("Cache \"%s\" added (type %s)\n", cache->name, ops->name);
+	_leave(" = 0 [%s]", cache->name);
 	return 0;
+}
+EXPORT_SYMBOL(fscache_add_cache);
 
-tag_in_use:
-	pr_err("Cache tag '%s' already in use\n", tagname);
-	__fscache_release_cache_tag(tag);
-	_leave(" = -EXIST");
-	return -EEXIST;
-
-error:
-	__fscache_release_cache_tag(tag);
-	_leave(" = -EINVAL");
-	return -EINVAL;
+/*
+ * Get an increment on a cache's access counter if the cache is live to prevent
+ * it from going away whilst we're accessing it.
+ */
+bool fscache_begin_cache_access(struct fscache_cache *cache, enum fscache_access_trace why)
+{
+	int n_accesses;
+
+	if (!fscache_cache_is_live(cache))
+		return false;
+
+	n_accesses = atomic_inc_return(&cache->n_accesses);
+	smp_mb__after_atomic(); /* Reread live flag after n_accesses */
+	trace_fscache_access_cache(cache->debug_id, refcount_read(&cache->ref),
+				   n_accesses, why);
+	if (!fscache_cache_is_live(cache)) {
+		fscache_end_cache_access(cache, fscache_access_unlive);
+		return false;
+	}
+	return true;
+}
 
-nomem:
-	_leave(" = -ENOMEM");
-	return -ENOMEM;
+/*
+ * Drop an increment on a cache's access counter.
+ */
+void fscache_end_cache_access(struct fscache_cache *cache, enum fscache_access_trace why)
+{
+	int n_accesses;
+
+	smp_mb__before_atomic();
+	n_accesses = atomic_dec_return(&cache->n_accesses);
+	trace_fscache_access_cache(cache->debug_id, refcount_read(&cache->ref),
+				   n_accesses, why);
+	if (n_accesses == 0)
+		wake_up_var(&cache->n_accesses);
 }
-EXPORT_SYMBOL(fscache_add_cache);
 
 /**
  * fscache_io_error - Note a cache I/O error
@@ -300,100 +262,92 @@ EXPORT_SYMBOL(fscache_add_cache);
  */
 void fscache_io_error(struct fscache_cache *cache)
 {
-	if (!test_and_set_bit(FSCACHE_IOERROR, &cache->flags))
+	if (fscache_set_cache_state_maybe(cache,
+					  FSCACHE_CACHE_IS_ACTIVE,
+					  FSCACHE_CACHE_GOT_IOERROR))
 		pr_err("Cache '%s' stopped due to I/O error\n",
-		       cache->ops->name);
+		       cache->name);
 }
 EXPORT_SYMBOL(fscache_io_error);
 
-/*
- * request withdrawal of all the objects in a cache
- * - all the objects being withdrawn are moved onto the supplied list
+/**
+ * fscache_withdraw_cache - Withdraw a cache from the active service
+ * @cache: The cache cookie
+ *
+ * Begin the process of withdrawing a cache from service.
  */
-static void fscache_withdraw_all_objects(struct fscache_cache *cache,
-					 struct list_head *dying_objects)
+void fscache_withdraw_cache(struct fscache_cache *cache)
 {
-	struct cachefiles_object *object;
-
-	while (!list_empty(&cache->object_list)) {
-		spin_lock(&cache->object_list_lock);
+	int n_accesses;
 
-		if (!list_empty(&cache->object_list)) {
-			object = list_entry(cache->object_list.next,
-					    struct cachefiles_object, cache_link);
-			list_move_tail(&object->cache_link, dying_objects);
+	pr_notice("Withdrawing cache \"%s\" (%u objs)\n",
+		  cache->name, atomic_read(&cache->object_count));
 
-			_debug("withdraw %x", object->cookie->debug_id);
+	fscache_set_cache_state(cache, FSCACHE_CACHE_IS_WITHDRAWN);
 
-			/* This must be done under object_list_lock to prevent
-			 * a race with fscache_drop_object().
-			 */
-			fscache_raise_event(object, FSCACHE_OBJECT_EV_KILL);
-		}
+	/* Allow wakeups on dec-to-0 */
+	n_accesses = atomic_dec_return(&cache->n_accesses);
+	trace_fscache_access_cache(cache->debug_id, refcount_read(&cache->ref),
+				   n_accesses, fscache_access_cache_unpin);
 
-		spin_unlock(&cache->object_list_lock);
-		cond_resched();
-	}
+	wait_var_event(&cache->n_accesses,
+		       atomic_read(&cache->n_accesses) == 0);
 }
+EXPORT_SYMBOL(fscache_withdraw_cache);
 
-/**
- * fscache_withdraw_cache - Withdraw a cache from the active service
- * @cache: The record describing the cache
- *
- * Withdraw a cache from service, unbinding all its cache objects from the
- * netfs cookies they're currently representing.
- *
- * See Documentation/filesystems/caching/backend-api.rst for a complete
- * description.
+#ifdef CONFIG_PROC_FS
+static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
+
+/*
+ * Generate a list of caches in /proc/fs/fscache/caches
  */
-void fscache_withdraw_cache(struct fscache_cache *cache)
+static int fscache_caches_seq_show(struct seq_file *m, void *v)
 {
-	LIST_HEAD(dying_objects);
+	struct fscache_cache *cache;
 
-	_enter("");
+	if (v == &fscache_caches) {
+		seq_puts(m,
+			 "CACHE    REF   VOLS  OBJS  ACCES S NAME\n"
+			 "======== ===== ===== ===== ===== = ===============\n"
+			 );
+		return 0;
+	}
 
-	pr_notice("Withdrawing cache \"%s\"\n",
-		  cache->tag->name);
+	cache = list_entry(v, struct fscache_cache, cache_link);
+	seq_printf(m,
+		   "%08x %5d %5d %5d %5d %c %s\n",
+		   cache->debug_id,
+		   refcount_read(&cache->ref),
+		   atomic_read(&cache->n_volumes),
+		   atomic_read(&cache->object_count),
+		   atomic_read(&cache->n_accesses),
+		   fscache_cache_states[cache->state],
+		   cache->name ?: "-");
+	return 0;
+}
 
-	/* make the cache unavailable for cookie acquisition */
-	if (test_and_set_bit(FSCACHE_CACHE_WITHDRAWN, &cache->flags))
-		BUG();
+static void *fscache_caches_seq_start(struct seq_file *m, loff_t *_pos)
+	__acquires(fscache_addremove_sem)
+{
+	down_read(&fscache_addremove_sem);
+	return seq_list_start_head(&fscache_caches, *_pos);
+}
 
-	down_write(&fscache_addremove_sem);
-	list_del_init(&cache->link);
-	cache->tag->cache = NULL;
-	up_write(&fscache_addremove_sem);
+static void *fscache_caches_seq_next(struct seq_file *m, void *v, loff_t *_pos)
+{
+	return seq_list_next(v, &fscache_caches, _pos);
+}
 
-	/* make sure all pages pinned by operations on behalf of the netfs are
-	 * written to disk */
-	fscache_stat(&fscache_n_cop_sync_cache);
-	cache->ops->sync_cache(cache);
-	fscache_stat_d(&fscache_n_cop_sync_cache);
-
-	/* we now have to destroy all the active objects pertaining to this
-	 * cache - which we do by passing them off to thread pool to be
-	 * disposed of */
-	_debug("destroy");
-
-	fscache_withdraw_all_objects(cache, &dying_objects);
-
-	/* wait for all extant objects to finish their outstanding operations
-	 * and go away */
-	_debug("wait for finish");
-	wait_event(fscache_cache_cleared_wq,
-		   atomic_read(&cache->object_count) == 0);
-	_debug("wait for clearance");
-	wait_event(fscache_cache_cleared_wq,
-		   list_empty(&cache->object_list));
-	_debug("cleared");
-	ASSERT(list_empty(&dying_objects));
-
-	kobject_put(cache->kobj);
-
-	clear_bit(FSCACHE_TAG_RESERVED, &cache->tag->flags);
-	fscache_release_cache_tag(cache->tag);
-	cache->tag = NULL;
-
-	_leave("");
+static void fscache_caches_seq_stop(struct seq_file *m, void *v)
+	__releases(fscache_addremove_sem)
+{
+	up_read(&fscache_addremove_sem);
 }
-EXPORT_SYMBOL(fscache_withdraw_cache);
+
+const struct seq_operations fscache_caches_seq_ops = {
+	.start  = fscache_caches_seq_start,
+	.next   = fscache_caches_seq_next,
+	.stop   = fscache_caches_seq_stop,
+	.show   = fscache_caches_seq_show,
+};
+#endif /* CONFIG_PROC_FS */
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 3f7bb2eecdc3..90a16e6d6917 100644
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
@@ -15,66 +15,164 @@
 
 struct kmem_cache *fscache_cookie_jar;
 
-static atomic_t fscache_object_debug_id = ATOMIC_INIT(0);
+static void fscache_cookie_worker(struct work_struct *work);
+static void fscache_drop_cookie(struct fscache_cookie *cookie);
+static void fscache_lookup_cookie(struct fscache_cookie *cookie);
+static void fscache_invalidate_cookie(struct fscache_cookie *cookie);
 
 #define fscache_cookie_hash_shift 15
 static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
 static LIST_HEAD(fscache_cookies);
 static DEFINE_RWLOCK(fscache_cookies_lock);
+static const char fscache_cookie_stages[FSCACHE_COOKIE_STAGE__NR] = "-LCAIFWRD";
 
-static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie);
-static int fscache_alloc_object(struct fscache_cache *cache,
-				struct fscache_cookie *cookie);
-static int fscache_attach_object(struct fscache_cookie *cookie,
-				 struct cachefiles_object *object);
-
-static void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
+void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 {
-	struct cachefiles_object *object;
-	struct hlist_node *o;
 	const u8 *k;
-	unsigned loop;
 
-	pr_err("%c-cookie c=%08x [p=%08x fl=%lx nc=%u na=%u]\n",
+	pr_err("%c-cookie c=%08x [fl=%lx na=%u nA=%u s=%c]\n",
 	       prefix,
 	       cookie->debug_id,
-	       cookie->parent ? cookie->parent->debug_id : 0,
 	       cookie->flags,
-	       atomic_read(&cookie->n_children),
-	       atomic_read(&cookie->n_active));
-	pr_err("%c-cookie d=%s\n",
+	       atomic_read(&cookie->n_active),
+	       atomic_read(&cookie->n_accesses),
+	       fscache_cookie_stages[cookie->stage]);
+	pr_err("%c-cookie V=%08x [%s]\n",
 	       prefix,
-	       cookie->type_name);
-
-	o = READ_ONCE(cookie->backing_objects.first);
-	if (o) {
-		object = hlist_entry(o, struct cachefiles_object, cookie_link);
-		pr_err("%c-cookie o=%u\n", prefix, object->debug_id);
-	}
+	       cookie->volume->debug_id,
+	       cookie->volume->key);
 
-	pr_err("%c-key=[%u] '", prefix, cookie->key_len);
 	k = (cookie->key_len <= sizeof(cookie->inline_key)) ?
 		cookie->inline_key : cookie->key;
-	for (loop = 0; loop < cookie->key_len; loop++)
-		pr_cont("%02x", k[loop]);
-	pr_cont("'\n");
-}
-
-void fscache_free_cookie(struct fscache_cookie *cookie)
-{
-	if (cookie) {
-		BUG_ON(!hlist_empty(&cookie->backing_objects));
-		write_lock(&fscache_cookies_lock);
-		list_del(&cookie->proc_link);
-		write_unlock(&fscache_cookies_lock);
-		if (cookie->aux_len > sizeof(cookie->inline_aux))
-			kfree(cookie->aux);
-		if (cookie->key_len > sizeof(cookie->inline_key))
-			kfree(cookie->key);
-		fscache_put_cache_tag(cookie->preferred_cache);
-		kmem_cache_free(fscache_cookie_jar, cookie);
+	pr_err("%c-key=[%u] '%*phN'\n", prefix, cookie->key_len, cookie->key_len, k);
+}
+
+static void fscache_free_cookie(struct fscache_cookie *cookie)
+{
+	write_lock(&fscache_cookies_lock);
+	list_del(&cookie->proc_link);
+	write_unlock(&fscache_cookies_lock);
+	if (cookie->aux_len > sizeof(cookie->inline_aux))
+		kfree(cookie->aux);
+	if (cookie->key_len > sizeof(cookie->inline_key))
+		kfree(cookie->key);
+	fscache_stat_d(&fscache_n_cookies);
+	kmem_cache_free(fscache_cookie_jar, cookie);
+}
+
+static void __fscache_queue_cookie(struct fscache_cookie *cookie)
+{
+	if (!queue_work(fscache_wq, &cookie->work))
+		fscache_put_cookie(cookie, fscache_cookie_put_over_queued);
+}
+
+static void fscache_queue_cookie(struct fscache_cookie *cookie,
+				 enum fscache_cookie_trace where)
+{
+	fscache_get_cookie(cookie, where);
+	__fscache_queue_cookie(cookie);
+}
+
+static void __fscache_end_cookie_access(struct fscache_cookie *cookie)
+{
+	if (test_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags))
+		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_RELINQUISHING);
+	else if (test_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags))
+		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_WITHDRAWING);
+	fscache_queue_cookie(cookie, fscache_cookie_get_end_access);
+}
+
+/*
+ * Mark the end of an access on a cookie.  This brings a deferred
+ * relinquishment or withdrawal stage into effect.
+ */
+void fscache_end_cookie_access(struct fscache_cookie *cookie,
+			       enum fscache_access_trace why)
+{
+	int n_accesses;
+
+	smp_mb__before_atomic();
+	n_accesses = atomic_dec_return(&cookie->n_accesses);
+	trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
+			     n_accesses, why);
+	if (n_accesses == 0)
+		__fscache_end_cookie_access(cookie);
+}
+EXPORT_SYMBOL(fscache_end_cookie_access);
+
+/*
+ * Pin the cache behind a cookie so that we can access it.
+ */
+static void __fscache_begin_cookie_access(struct fscache_cookie *cookie,
+					  enum fscache_access_trace why)
+{
+	int n_accesses;
+
+	n_accesses = atomic_inc_return(&cookie->n_accesses);
+	smp_mb__after_atomic(); /* (Future) read stage after is-caching.
+				 * Reread n_accesses after is-caching
+				 */
+	trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
+			     n_accesses, why);
+}
+
+/*
+ * Pin the cache behind a cookie so that we can access it.
+ */
+bool fscache_begin_cookie_access(struct fscache_cookie *cookie,
+				 enum fscache_access_trace why)
+{
+	if (!test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags))
+		return false;
+	__fscache_begin_cookie_access(cookie, why);
+	if (!test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags) ||
+	    !fscache_cache_is_live(cookie->volume->cache)) {
+		fscache_end_cookie_access(cookie, fscache_access_unlive);
+		return false;
+	}
+	return true;
+}
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
+static void __fscache_set_cookie_stage(struct fscache_cookie *cookie,
+				       enum fscache_cookie_stage stage)
+{
+	cookie->stage = stage;
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
+	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
+		break;
+	default:
+		__fscache_set_cookie_stage(cookie, stage);
+		changed = true;
+		break;
 	}
+	spin_unlock(&cookie->lock);
+	if (changed)
+		wake_up_cookie_stage(cookie);
 }
+EXPORT_SYMBOL(fscache_set_cookie_stage);
 
 /*
  * Set the index key in a cookie.  The cookie struct has space for a 16-byte
@@ -100,7 +198,7 @@ static int fscache_set_key(struct fscache_cookie *cookie,
 	}
 
 	memcpy(buf, index_key, index_key_len);
-	cookie->key_hash = fscache_hash(0, buf, bufs);
+	cookie->key_hash = fscache_hash(cookie->volume->key_hash, buf, bufs);
 	return 0;
 }
 
@@ -111,12 +209,10 @@ static long fscache_compare_cookie(const struct fscache_cookie *a,
 
 	if (a->key_hash != b->key_hash)
 		return (long)a->key_hash - (long)b->key_hash;
-	if (a->parent != b->parent)
-		return (long)a->parent - (long)b->parent;
+	if (a->volume != b->volume)
+		return (long)a->volume - (long)b->volume;
 	if (a->key_len != b->key_len)
 		return (long)a->key_len - (long)b->key_len;
-	if (a->type != b->type)
-		return (long)a->type - (long)b->type;
 
 	if (a->key_len <= sizeof(a->inline_key)) {
 		ka = &a->inline_key;
@@ -133,12 +229,9 @@ static atomic_t fscache_cookie_debug_id = ATOMIC_INIT(1);
 /*
  * Allocate a cookie.
  */
-struct fscache_cookie *fscache_alloc_cookie(
-	struct fscache_cookie *parent,
-	enum fscache_cookie_type type,
-	const char *type_name,
+static struct fscache_cookie *fscache_alloc_cookie(
+	struct fscache_volume *volume,
 	u8 advice,
-	struct fscache_cache_tag *preferred_cache,
 	const void *index_key, size_t index_key_len,
 	const void *aux_data, size_t aux_data_len,
 	loff_t object_size)
@@ -149,13 +242,13 @@ struct fscache_cookie *fscache_alloc_cookie(
 	cookie = kmem_cache_zalloc(fscache_cookie_jar, GFP_KERNEL);
 	if (!cookie)
 		return NULL;
+	fscache_stat(&fscache_n_cookies);
 
-	cookie->type = type;
-	cookie->advice = advice;
-	cookie->key_len = index_key_len;
-	cookie->aux_len = aux_data_len;
-	cookie->object_size = object_size;
-	strlcpy(cookie->type_name, type_name, sizeof(cookie->type_name));
+	cookie->volume		= volume;
+	cookie->advice		= advice;
+	cookie->key_len		= index_key_len;
+	cookie->aux_len		= aux_data_len;
+	cookie->object_size	= object_size;
 
 	if (fscache_set_key(cookie, index_key, index_key_len) < 0)
 		goto nomem;
@@ -169,24 +262,15 @@ struct fscache_cookie *fscache_alloc_cookie(
 	}
 
 	refcount_set(&cookie->ref, 1);
-	atomic_set(&cookie->n_children, 0);
 	cookie->debug_id = atomic_inc_return(&fscache_cookie_debug_id);
-
-	/* We keep the active count elevated until relinquishment to prevent an
-	 * attempt to wake up every time the object operations queue quiesces.
-	 */
-	atomic_set(&cookie->n_active, 1);
-
-	cookie->parent		= parent;
-	cookie->preferred_cache	= fscache_get_cache_tag(preferred_cache);
-
-	cookie->flags		= (1 << FSCACHE_COOKIE_NO_DATA_YET);
+	cookie->stage = FSCACHE_COOKIE_STAGE_QUIESCENT;
 	spin_lock_init(&cookie->lock);
-	INIT_HLIST_HEAD(&cookie->backing_objects);
+	INIT_WORK(&cookie->work, fscache_cookie_worker);
 
 	write_lock(&fscache_cookies_lock);
 	list_add_tail(&cookie->proc_link, &fscache_cookies);
 	write_unlock(&fscache_cookies_lock);
+	fscache_see_cookie(cookie, fscache_cookie_new_acquire);
 	return cookie;
 
 nomem:
@@ -194,13 +278,28 @@ struct fscache_cookie *fscache_alloc_cookie(
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
-struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
+static bool fscache_hash_cookie(struct fscache_cookie *candidate)
 {
-	struct fscache_cookie *cursor;
+	struct fscache_cookie *cursor, *wait_for = NULL;
 	struct hlist_bl_head *h;
 	struct hlist_bl_node *p;
 	unsigned int bucket;
@@ -210,61 +309,52 @@ struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *candidate)
 
 	hlist_bl_lock(h);
 	hlist_bl_for_each_entry(cursor, p, h, hash_link) {
-		if (fscache_compare_cookie(candidate, cursor) == 0)
-			goto collision;
+		if (fscache_compare_cookie(candidate, cursor) == 0) {
+			if (!test_bit(FSCACHE_COOKIE_RELINQUISHED, &cursor->flags))
+				goto collision;
+			wait_for = fscache_get_cookie(cursor,
+						      fscache_cookie_get_hash_collision);
+			break;
+		}
 	}
 
-	__set_bit(FSCACHE_COOKIE_ACQUIRED, &candidate->flags);
-	fscache_get_cookie(candidate->parent, fscache_cookie_get_acquire_parent);
-	atomic_inc(&candidate->parent->n_children);
+	fscache_get_volume(candidate->volume, fscache_volume_get_cookie);
+	atomic_inc(&candidate->volume->n_cookies);
 	hlist_bl_add_head(&candidate->hash_link, h);
 	hlist_bl_unlock(h);
-	return candidate;
 
-collision:
-	if (test_and_set_bit(FSCACHE_COOKIE_ACQUIRED, &cursor->flags)) {
-		trace_fscache_cookie(cursor->debug_id, refcount_read(&cursor->ref),
-				     fscache_cookie_collision);
-		pr_err("Duplicate cookie detected\n");
-		fscache_print_cookie(cursor, 'O');
-		fscache_print_cookie(candidate, 'N');
-		hlist_bl_unlock(h);
-		return NULL;
+	if (wait_for) {
+		fscache_wait_on_collision(candidate, wait_for);
+		fscache_put_cookie(wait_for, fscache_cookie_put_hash_collision);
 	}
+	return true;
 
-	fscache_get_cookie(cursor, fscache_cookie_get_reacquire);
+collision:
+	trace_fscache_cookie(cursor->debug_id, refcount_read(&cursor->ref),
+			     fscache_cookie_collision);
+	pr_err("Duplicate cookie detected\n");
+	fscache_print_cookie(cursor, 'O');
+	fscache_print_cookie(candidate, 'N');
 	hlist_bl_unlock(h);
-	return cursor;
+	return false;
 }
 
 /*
- * request a cookie to represent an object (index, datafile, xattr, etc)
- * - parent specifies the parent object
- *   - the top level index cookie for each netfs is stored in the fscache_netfs
- *     struct upon registration
- * - all attached caches will be searched to see if they contain this object
- * - index objects aren't stored on disk until there's a dependent file that
- *   needs storing
- * - other objects are stored in a selected cache immediately, and all the
- *   indices forming the path to it are instantiated if necessary
- * - we never let on to the netfs about errors
- *   - we may set a negative cookie pointer, but that's okay
+ * Request a cookie to represent a data storage object within a volume.
+ *
+ * We never let on to the netfs about errors.  We may set a negative cookie
+ * pointer, but that's okay
  */
 struct fscache_cookie *__fscache_acquire_cookie(
-	struct fscache_cookie *parent,
-	enum fscache_cookie_type type,
-	const char *type_name,
+	struct fscache_volume *volume,
 	u8 advice,
-	struct fscache_cache_tag *preferred_cache,
 	const void *index_key, size_t index_key_len,
 	const void *aux_data, size_t aux_data_len,
-	loff_t object_size,
-	bool enable)
+	loff_t object_size)
 {
-	struct fscache_cookie *candidate, *cookie;
+	struct fscache_cookie *cookie;
 
-	_enter("{%s},{%s},%u",
-	       parent ? parent->type_name : "<no-parent>", type_name, enable);
+	_enter("V=%x", volume->debug_id);
 
 	if (!index_key || !index_key_len || index_key_len > 255 || aux_data_len > 255)
 		return NULL;
@@ -275,336 +365,229 @@ struct fscache_cookie *__fscache_acquire_cookie(
 
 	fscache_stat(&fscache_n_acquires);
 
-	/* if there's no parent cookie, then we don't create one here either */
-	if (!parent) {
-		fscache_stat(&fscache_n_acquires_null);
-		_leave(" [no parent]");
-		return NULL;
-	}
-
-	/* validate the definition */
-	BUG_ON(type == FSCACHE_COOKIE_TYPE_INDEX &&
-	       parent->type != FSCACHE_COOKIE_TYPE_INDEX);
-
-	candidate = fscache_alloc_cookie(parent, type, type_name, advice,
-					 preferred_cache,
-					 index_key, index_key_len,
-					 aux_data, aux_data_len,
-					 object_size);
-	if (!candidate) {
+	cookie = fscache_alloc_cookie(volume, advice,
+				      index_key, index_key_len,
+				      aux_data, aux_data_len,
+				      object_size);
+	if (!cookie) {
 		fscache_stat(&fscache_n_acquires_oom);
-		_leave(" [ENOMEM]");
 		return NULL;
 	}
 
-	cookie = fscache_hash_cookie(candidate);
-	if (!cookie) {
-		trace_fscache_cookie(candidate->debug_id, 1,
-				     fscache_cookie_discard);
-		goto out;
-	}
-
-	if (cookie == candidate)
-		candidate = NULL;
-
-	switch (cookie->type) {
-	case FSCACHE_COOKIE_TYPE_INDEX:
-		fscache_stat(&fscache_n_cookie_index);
-		break;
-	case FSCACHE_COOKIE_TYPE_DATAFILE:
-		fscache_stat(&fscache_n_cookie_data);
-		break;
-	default:
-		fscache_stat(&fscache_n_cookie_special);
-		break;
+	if (!fscache_hash_cookie(cookie)) {
+		fscache_see_cookie(cookie, fscache_cookie_discard);
+		fscache_free_cookie(cookie);
+		return NULL;
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
-				fscache_put_cookie(cookie,
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
-
-out:
-	fscache_free_cookie(candidate);
+	_leave(" = c=%08x", cookie->debug_id);
 	return cookie;
 }
 EXPORT_SYMBOL(__fscache_acquire_cookie);
 
 /*
- * Enable a cookie to permit it to accept new operations.
+ * Look up a cookie to the cache.
  */
-void __fscache_enable_cookie(struct fscache_cookie *cookie,
-			     const void *aux_data,
-			     loff_t object_size,
-			     bool (*can_enable)(void *data),
-			     void *data)
+static void fscache_lookup_cookie(struct fscache_cookie *cookie)
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
-
-	if (test_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags))
-		goto out_unlock;
-
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
-	struct cachefiles_object *object;
-	struct fscache_cache *cache;
-	int ret;
+	bool changed_stage = false, need_withdraw = false;
 
 	_enter("");
 
-	set_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags);
-
-	/* now we need to see whether the backing objects for this cookie yet
-	 * exist, if not there'll be nothing to search */
-	down_read(&fscache_addremove_sem);
-
-	if (list_empty(&fscache_cache_list)) {
-		up_read(&fscache_addremove_sem);
-		_leave(" = 0 [no caches]");
-		return 0;
-	}
-
-	/* select a cache in which to store the object */
-	cache = fscache_select_cache_for_object(cookie->parent);
-	if (!cache) {
-		up_read(&fscache_addremove_sem);
-		fscache_stat(&fscache_n_acquires_no_cache);
-		_leave(" = -ENOMEDIUM [no cache]");
-		return -ENOMEDIUM;
+	if (!cookie->volume->cache_priv) {
+		fscache_create_volume(cookie->volume, true);
+		if (!cookie->volume->cache_priv) {
+			fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_QUIESCENT);
+			goto out;
+		}
 	}
 
-	_debug("cache %s", cache->tag->name);
-
-	set_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags);
-
-	/* ask the cache to allocate objects for this cookie and its parent
-	 * chain */
-	ret = fscache_alloc_object(cache, cookie);
-	if (ret < 0) {
-		up_read(&fscache_addremove_sem);
-		_leave(" = %d", ret);
-		return ret;
+	if (!cookie->volume->cache->ops->lookup_cookie(cookie)) {
+		if (cookie->stage != FSCACHE_COOKIE_STAGE_FAILED)
+			fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_QUIESCENT);
+		need_withdraw = true;
+		_leave(" [fail]");
+		goto out;
 	}
 
 	spin_lock(&cookie->lock);
-	if (hlist_empty(&cookie->backing_objects)) {
-		spin_unlock(&cookie->lock);
-		goto unavailable;
+	if (cookie->stage != FSCACHE_COOKIE_STAGE_RELINQUISHING) {
+		__fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_ACTIVE);
+		fscache_see_cookie(cookie, fscache_cookie_see_active);
+		changed_stage = true;
 	}
-
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct cachefiles_object, cookie_link);
-
-	/* initiate the process of looking up all the objects in the chain
-	 * (done by fscache_initialise_object()) */
-	fscache_raise_event(object, FSCACHE_OBJECT_EV_NEW_CHILD);
-
 	spin_unlock(&cookie->lock);
+	if (changed_stage)
+		wake_up_cookie_stage(cookie);
 
-	/* we may be required to wait for lookup to complete at this point */
-	if (!fscache_defer_lookup) {
-		wait_on_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP,
-			    TASK_UNINTERRUPTIBLE);
-		if (test_bit(FSCACHE_COOKIE_UNAVAILABLE, &cookie->flags))
-			goto unavailable;
-	}
-
-	up_read(&fscache_addremove_sem);
-	_leave(" = 0 [deferred]");
-	return 0;
-
-unavailable:
-	up_read(&fscache_addremove_sem);
-	_leave(" = -ENOBUFS");
-	return -ENOBUFS;
+out:
+	fscache_end_cookie_access(cookie, fscache_access_lookup_cookie_end);
+	if (need_withdraw)
+		cookie->volume->cache->ops->withdraw_cookie(cookie);
+	fscache_end_volume_access(cookie->volume, fscache_access_lookup_cookie_end);
 }
 
 /*
- * recursively allocate cache object records for a cookie/cache combination
- * - caller must be holding the addremove sem
+ * Start using the cookie for I/O.  This prevents the backing object from being
+ * reaped by VM pressure.
  */
-static int fscache_alloc_object(struct fscache_cache *cache,
-				struct fscache_cookie *cookie)
+void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
 {
-	struct cachefiles_object *object;
-	int ret;
+	enum fscache_cookie_stage stage;
+	bool changed_stage = false, queue = false;
 
-	_enter("%s,%x{%s}", cache->tag->name, cookie->debug_id, cookie->type_name);
+	_enter("c=%08x", cookie->debug_id);
 
-	spin_lock(&cookie->lock);
-	hlist_for_each_entry(object, &cookie->backing_objects,
-			     cookie_link) {
-		if (object->cache == cache)
-			goto object_already_extant;
-	}
-	spin_unlock(&cookie->lock);
+	if (WARN(test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags),
+		 "Trying to use relinquished cookie\n"))
+		return;
 
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
+	spin_lock(&cookie->lock);
 
-	ASSERTCMP(object->cookie, ==, cookie);
-	fscache_stat(&fscache_n_object_alloc);
+	atomic_inc(&cookie->n_active);
 
-	object->debug_id = atomic_inc_return(&fscache_object_debug_id);
+	stage = cookie->stage;
+	switch (stage) {
+	case FSCACHE_COOKIE_STAGE_QUIESCENT:
+		if (!fscache_begin_volume_access(cookie->volume,
+						 fscache_access_lookup_cookie))
+			break;
 
-	_debug("ALLOC OBJ%x: %s {%lx}",
-	       object->debug_id, cookie->type_name, object->events);
+		__fscache_begin_cookie_access(cookie, fscache_access_lookup_cookie);
+		__fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_LOOKING_UP);
+		smp_mb__before_atomic(); /* Set stage before is-caching
+					  * vs __fscache_begin_cookie_access()
+					  */
+		set_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags);
+		set_bit(FSCACHE_COOKIE_HAS_BEEN_CACHED, &cookie->flags);
+		changed_stage = true;
+		queue = true;
+		break;
 
-	ret = fscache_alloc_object(cache, cookie->parent);
-	if (ret < 0)
-		goto error_put;
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+	case FSCACHE_COOKIE_STAGE_CREATING:
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+	case FSCACHE_COOKIE_STAGE_INVALIDATING:
+	case FSCACHE_COOKIE_STAGE_FAILED:
+	case FSCACHE_COOKIE_STAGE_WITHDRAWING:
+		break;
 
-	/* only attach if we managed to allocate all we needed, otherwise
-	 * discard the object we just allocated and instead use the one
-	 * attached to the cookie */
-	if (fscache_attach_object(cookie, object) < 0) {
-		fscache_stat(&fscache_n_cop_put_object);
-		cache->ops->put_object(object, fscache_obj_put_attach_fail);
-		fscache_stat_d(&fscache_n_cop_put_object);
+	case FSCACHE_COOKIE_STAGE_DROPPED:
+	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
+		WARN(1, "Can't use cookie in stage %u\n", cookie->stage);
+		break;
 	}
 
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
 	spin_unlock(&cookie->lock);
-	_leave(" = 0 [found]");
-	return 0;
+	if (changed_stage)
+		wake_up_cookie_stage(cookie);
+	if (queue)
+		fscache_queue_cookie(cookie, fscache_cookie_get_use_work);
+	_leave("");
+}
+EXPORT_SYMBOL(__fscache_use_cookie);
 
-error_put:
-	fscache_stat(&fscache_n_cop_put_object);
-	cache->ops->put_object(object, fscache_obj_put_alloc_fail);
-	fscache_stat_d(&fscache_n_cop_put_object);
-error:
-	_leave(" = %d", ret);
-	return ret;
+/*
+ * Stop using the cookie for I/O.
+ */
+void __fscache_unuse_cookie(struct fscache_cookie *cookie,
+			    const void *aux_data, const loff_t *object_size)
+{
+	if (aux_data || object_size)
+		__fscache_update_cookie(cookie, aux_data, object_size);
+	atomic_dec(&cookie->n_active);
 }
+EXPORT_SYMBOL(__fscache_unuse_cookie);
 
 /*
- * attach a cache object to a cookie
+ * Perform work upon the cookie, such as committing its cache state,
+ * relinquishing it or withdrawing the backing cache.  We're protected from the
+ * cache going away under us as object withdrawal must come through this
+ * non-reentrant work item.
  */
-static int fscache_attach_object(struct fscache_cookie *cookie,
-				 struct cachefiles_object *object)
+static void __fscache_cookie_worker(struct fscache_cookie *cookie)
 {
-	struct cachefiles_object *p;
-	struct fscache_cache *cache = object->cache;
-	int ret;
+	_enter("c=%x", cookie->debug_id);
 
-	_enter("{%s},{OBJ%x}", cookie->type_name, object->debug_id);
+again:
+	switch (READ_ONCE(cookie->stage)) {
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		break;
 
-	ASSERTCMP(object->cookie, ==, cookie);
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+		fscache_lookup_cookie(cookie);
+		goto again;
 
-	spin_lock(&cookie->lock);
+	case FSCACHE_COOKIE_STAGE_CREATING:
+		WARN_ONCE(1, "Cookie %x in unexpected stage %u\n",
+			  cookie->debug_id, cookie->stage);
+		break;
 
-	/* there may be multiple initial creations of this object, but we only
-	 * want one */
-	ret = -EEXIST;
-	hlist_for_each_entry(p, &cookie->backing_objects, cookie_link) {
-		if (p->cache == object->cache) {
-			if (fscache_object_is_dying(p))
-				ret = -ENOBUFS;
-			goto cant_attach_object;
-		}
-	}
+	case FSCACHE_COOKIE_STAGE_INVALIDATING:
+		fscache_invalidate_cookie(cookie);
+		goto again;
 
-	/* pin the parent object */
-	spin_lock_nested(&cookie->parent->lock, 1);
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
+	case FSCACHE_COOKIE_STAGE_FAILED:
+		break;
+
+	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
+	case FSCACHE_COOKIE_STAGE_WITHDRAWING:
+		if (test_and_clear_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags) &&
+		    cookie->cache_priv)
+			cookie->volume->cache->ops->withdraw_cookie(cookie);
+		if (cookie->stage == FSCACHE_COOKIE_STAGE_RELINQUISHING) {
+			fscache_see_cookie(cookie, fscache_cookie_see_relinquish);
+			fscache_drop_cookie(cookie);
 			break;
+		} else {
+			fscache_see_cookie(cookie, fscache_cookie_see_withdraw);
 		}
+		fallthrough;
+
+	case FSCACHE_COOKIE_STAGE_QUIESCENT:
+	case FSCACHE_COOKIE_STAGE_DROPPED:
+		clear_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
+		clear_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags);
+		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_QUIESCENT);
+		break;
 	}
-	spin_unlock(&cookie->parent->lock);
+	_leave("");
+}
 
-	/* attach to the cache's object list */
-	if (list_empty(&object->cache_link)) {
-		spin_lock(&cache->object_list_lock);
-		list_add(&object->cache_link, &cache->object_list);
-		spin_unlock(&cache->object_list_lock);
-	}
+static void fscache_cookie_worker(struct work_struct *work)
+{
+	struct fscache_cookie *cookie = container_of(work, struct fscache_cookie, work);
 
-	/* Attach to the cookie.  The object already has a ref on it. */
-	hlist_add_head(&object->cookie_link, &cookie->backing_objects);
-	ret = 0;
+	fscache_see_cookie(cookie, fscache_cookie_see_work);
+	__fscache_cookie_worker(cookie);
+	fscache_put_cookie(cookie, fscache_cookie_put_work);
+}
 
-cant_attach_object:
-	spin_unlock(&cookie->lock);
-	_leave(" = %d", ret);
-	return ret;
+/*
+ * Wait for the object to become inactive.  The cookie's work item will be
+ * scheduled when someone transitions n_accesses to 0.
+ */
+static void __fscache_withdraw_cookie(struct fscache_cookie *cookie)
+{
+	if (test_and_clear_bit(FSCACHE_COOKIE_NACC_ELEVATED, &cookie->flags))
+		fscache_end_cookie_access(cookie, fscache_access_cache_unpin);
+	else
+		__fscache_end_cookie_access(cookie);
+}
+
+/*
+ * Ask the cache to effect invalidation of a cookie.
+ */
+static void fscache_invalidate_cookie(struct fscache_cookie *cookie)
+{
+	if (cookie->volume->cache->ops->invalidate_cookie(cookie, 0))
+		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_ACTIVE);
+	else
+		fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_FAILED);
+	fscache_end_cookie_access(cookie, fscache_access_invalidate_cookie_end);
 }
 
 /*
@@ -612,67 +595,60 @@ static int fscache_attach_object(struct fscache_cookie *cookie,
  */
 void __fscache_invalidate(struct fscache_cookie *cookie)
 {
-	_enter("{%s}", cookie->type_name);
+	bool is_caching;
+
+	_enter("c=%x", cookie->debug_id);
 
 	fscache_stat(&fscache_n_invalidates);
 
-	/* Only permit invalidation of data files.  Invalidating an index will
-	 * require the caller to release all its attachments to the tree rooted
-	 * there, and if it's doing that, it may as well just retire the
-	 * cookie.
-	 */
-	ASSERTCMP(cookie->type, ==, FSCACHE_COOKIE_TYPE_DATAFILE);
+	if (WARN(test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags),
+		 "Trying to invalidate relinquished cookie\n"))
+		return;
 
-	/* TODO: Do invalidation */
+	spin_lock(&cookie->lock);
+	set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+	cookie->inval_counter++;
 
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_invalidate);
+	switch (cookie->stage) {
+	case FSCACHE_COOKIE_STAGE_INVALIDATING: /* is_still_valid will catch it */
+	default:
+		spin_unlock(&cookie->lock);
+		_leave(" [no %u]", cookie->stage);
+		return;
 
-/*
- * Wait for object invalidation to complete.
- */
-void __fscache_wait_on_invalidate(struct fscache_cookie *cookie)
-{
-	_enter("%x", cookie->debug_id);
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+	case FSCACHE_COOKIE_STAGE_CREATING:
+		spin_unlock(&cookie->lock);
+		_leave(" [look %x]", cookie->inval_counter);
+		return;
 
-	wait_on_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING,
-		    TASK_UNINTERRUPTIBLE);
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		__fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_INVALIDATING);
+		is_caching = fscache_begin_cookie_access(
+			cookie, fscache_access_invalidate_cookie);
+		spin_unlock(&cookie->lock);
+		wake_up_cookie_stage(cookie);
 
-	_leave("");
+		if (is_caching)
+			fscache_queue_cookie(cookie, fscache_cookie_get_inval_work);
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
-	struct cachefiles_object *object;
-
 	fscache_stat(&fscache_n_updates);
 
-	if (!cookie) {
-		fscache_stat(&fscache_n_updates_null);
-		_leave(" [no cookie]");
-		return;
-	}
-
-	_enter("{%s}", cookie->type_name);
-
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
-	}
+	fscache_update_aux(cookie, aux_data, object_size);
+	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &cookie->flags);
 
 	spin_unlock(&cookie->lock);
 	_leave("");
@@ -680,169 +656,106 @@ void __fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data
 EXPORT_SYMBOL(__fscache_update_cookie);
 
 /*
- * Disable a cookie to stop it from accepting new requests from the netfs.
+ * Remove a cookie from the hash table.
  */
-void __fscache_disable_cookie(struct fscache_cookie *cookie,
-			      const void *aux_data,
-			      bool invalidate)
+static void fscache_unhash_cookie(struct fscache_cookie *cookie)
 {
-	struct cachefiles_object *object;
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
+	struct hlist_bl_head *h;
+	unsigned int bucket;
 
-	/* If the cookie is being invalidated, wait for that to complete first
-	 * so that we can reuse the flag.
-	 */
-	__fscache_wait_on_invalidate(cookie);
+	bucket = cookie->key_hash & (ARRAY_SIZE(fscache_cookie_hash) - 1);
+	h = &fscache_cookie_hash[bucket];
 
-	/* Dispose of the backing objects */
-	set_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags);
+	hlist_bl_lock(h);
+	hlist_bl_del(&cookie->hash_link);
+	hlist_bl_unlock(h);
+}
 
+/*
+ * Finalise a cookie after all its resources have been disposed of.
+ */
+static void fscache_drop_cookie(struct fscache_cookie *cookie)
+{
 	spin_lock(&cookie->lock);
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
+	__fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_DROPPED);
 	spin_unlock(&cookie->lock);
-	if (awaken)
-		wake_up_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING);
+	wake_up_cookie_stage(cookie);
 
-	/* Wait for cessation of activity requiring access to the netfs (when
-	 * n_active reaches 0).  This makes sure outstanding reads and writes
-	 * have completed.
-	 */
-	if (!atomic_dec_and_test(&cookie->n_active)) {
-		wait_var_event(&cookie->n_active,
-			       !atomic_read(&cookie->n_active));
-	}
+	fscache_unhash_cookie(cookie);
+	fscache_stat(&fscache_n_relinquishes_dropped);
+}
 
-	/* Reset the cookie state if it wasn't relinquished */
-	if (!test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags)) {
-		atomic_inc(&cookie->n_active);
-		set_bit(FSCACHE_COOKIE_NO_DATA_YET, &cookie->flags);
-	}
+static void fscache_drop_withdraw_cookie(struct fscache_cookie *cookie)
+{
+	__fscache_withdraw_cookie(cookie);
+}
 
-out_unlock_enable:
-	clear_bit_unlock(FSCACHE_COOKIE_ENABLEMENT_LOCK, &cookie->flags);
-	wake_up_bit(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK);
-	_leave("");
+/**
+ * fscache_withdraw_cookie - Mark a cookie for withdrawal
+ * @cookie: The cookie to be withdrawn.
+ *
+ * Allow the cache backend to withdraw the backing for a cookie for its own
+ * reasons, even if that cookie is in active use.
+ */
+void fscache_withdraw_cookie(struct fscache_cookie *cookie)
+{
+	set_bit(FSCACHE_COOKIE_DO_WITHDRAW, &cookie->flags);
+	fscache_drop_withdraw_cookie(cookie);
 }
-EXPORT_SYMBOL(__fscache_disable_cookie);
+EXPORT_SYMBOL(fscache_withdraw_cookie);
 
 /*
- * release a cookie back to the cache
+ * Allow the netfs to release a cookie back to the cache.
  * - the object will be marked as recyclable on disk if retire is true
- * - all dependents of this cookie must have already been unregistered
- *   (indices/files/pages)
  */
-void __fscache_relinquish_cookie(struct fscache_cookie *cookie,
-				 const void *aux_data,
-				 bool retire)
+void __fscache_relinquish_cookie(struct fscache_cookie *cookie, bool retire)
 {
 	fscache_stat(&fscache_n_relinquishes);
 	if (retire)
 		fscache_stat(&fscache_n_relinquishes_retire);
 
-	if (!cookie) {
-		fscache_stat(&fscache_n_relinquishes_null);
-		_leave(" [no cookie]");
-		return;
-	}
+	_enter("c=%08x{%d},%d",
+	       cookie->debug_id, atomic_read(&cookie->n_active), retire);
 
-	_enter("%x{%s,%d},%d",
-	       cookie->debug_id, cookie->type_name,
-	       atomic_read(&cookie->n_active), retire);
+	if (WARN(test_and_set_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags),
+		 "Cookie c=%x already relinquished\n", cookie->debug_id))
+		return;
 
+	if (retire)
+		set_bit(FSCACHE_COOKIE_RETIRED, &cookie->flags);
 	trace_fscache_relinquish(cookie, retire);
 
-	/* No further netfs-accessing operations on this cookie permitted */
-	if (test_and_set_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags))
-		BUG();
+	ASSERTCMP(atomic_read(&cookie->n_active), ==, 0);
+	ASSERTCMP(atomic_read(&cookie->volume->n_cookies), >, 0);
+	atomic_dec(&cookie->volume->n_cookies);
 
-	__fscache_disable_cookie(cookie, aux_data, retire);
+	set_bit(FSCACHE_COOKIE_DO_RELINQUISH, &cookie->flags);
 
-	if (cookie->parent) {
-		ASSERTCMP(refcount_read(&cookie->parent->ref), >, 0);
-		ASSERTCMP(atomic_read(&cookie->parent->n_children), >, 0);
-		atomic_dec(&cookie->parent->n_children);
-	}
-
-	/* Dispose of the netfs's link to the cookie */
+	if (test_bit(FSCACHE_COOKIE_HAS_BEEN_CACHED, &cookie->flags))
+		fscache_drop_withdraw_cookie(cookie);
+	else
+		fscache_drop_cookie(cookie);
 	fscache_put_cookie(cookie, fscache_cookie_put_relinquish);
-
-	_leave("");
 }
 EXPORT_SYMBOL(__fscache_relinquish_cookie);
 
-/*
- * Remove a cookie from the hash table.
- */
-static void fscache_unhash_cookie(struct fscache_cookie *cookie)
-{
-	struct hlist_bl_head *h;
-	unsigned int bucket;
-
-	bucket = cookie->key_hash & (ARRAY_SIZE(fscache_cookie_hash) - 1);
-	h = &fscache_cookie_hash[bucket];
-
-	hlist_bl_lock(h);
-	hlist_bl_del(&cookie->hash_link);
-	hlist_bl_unlock(h);
-}
-
 /*
  * Drop a reference to a cookie.
  */
 void fscache_put_cookie(struct fscache_cookie *cookie,
 			enum fscache_cookie_trace where)
 {
-	struct fscache_cookie *parent;
+	struct fscache_volume *volume = cookie->volume;
+	unsigned int cookie_debug_id = cookie->debug_id;
+	bool zero;
 	int ref;
 
-	_enter("%x", cookie->debug_id);
-
-	do {
-		unsigned int cookie_debug_id = cookie->debug_id;
-		bool zero = __refcount_dec_and_test(&cookie->ref, &ref);
-
-		trace_fscache_cookie(cookie_debug_id, ref - 1, where);
-		if (!zero)
-			return;
-
-		parent = cookie->parent;
-		fscache_unhash_cookie(cookie);
+	zero = __refcount_dec_and_test(&cookie->ref, &ref);
+	trace_fscache_cookie(cookie_debug_id, ref - 1, where);
+	if (zero) {
 		fscache_free_cookie(cookie);
-
-		cookie = parent;
-		where = fscache_cookie_put_parent;
-	} while (cookie);
-
-	_leave("");
+		fscache_put_volume(volume, fscache_volume_put_cookie);
+	}
 }
 EXPORT_SYMBOL(fscache_put_cookie);
 
@@ -867,43 +780,27 @@ static int fscache_cookies_seq_show(struct seq_file *m, void *v)
 {
 	struct fscache_cookie *cookie;
 	unsigned int keylen = 0, auxlen = 0;
-	char _type[3], *type;
 	u8 *p;
 
 	if (v == &fscache_cookies) {
 		seq_puts(m,
-			 "COOKIE   PARENT   USAGE CHILD ACT TY FL  DEF             \n"
-			 "======== ======== ===== ===== === == === ================\n"
+			 "COOKIE   VOLUME   REF ACT ACC S FL DEF             \n"
+			 "======== ======== === === === = == ================\n"
 			 );
 		return 0;
 	}
 
 	cookie = list_entry(v, struct fscache_cookie, proc_link);
 
-	switch (cookie->type) {
-	case 0:
-		type = "IX";
-		break;
-	case 1:
-		type = "DT";
-		break;
-	default:
-		snprintf(_type, sizeof(_type), "%02u",
-			 cookie->type);
-		type = _type;
-		break;
-	}
-
 	seq_printf(m,
-		   "%08x %08x %5u %5u %3u %s %03lx %-16s",
+		   "%08x %08x %3d %3d %3d %c %02lx",
 		   cookie->debug_id,
-		   cookie->parent ? cookie->parent->debug_id : 0,
+		   cookie->volume->debug_id,
 		   refcount_read(&cookie->ref),
-		   atomic_read(&cookie->n_children),
 		   atomic_read(&cookie->n_active),
-		   type,
-		   cookie->flags,
-		   cookie->type_name);
+		   atomic_read(&cookie->n_accesses) - 1,
+		   fscache_cookie_stages[cookie->stage],
+		   cookie->flags);
 
 	keylen = cookie->key_len;
 	auxlen = cookie->aux_len;
diff --git a/fs/fscache/fsdef.c b/fs/fscache/fsdef.c
deleted file mode 100644
index 15312f15848b..000000000000
--- a/fs/fscache/fsdef.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Filesystem index definition
- *
- * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL CACHE
-#include <linux/module.h>
-#include "internal.h"
-
-/*
- * The root index is owned by FS-Cache itself.
- *
- * When a netfs requests caching facilities, FS-Cache will, if one doesn't
- * already exist, create an entry in the root index with the key being the name
- * of the netfs ("AFS" for example), and the auxiliary data holding the index
- * structure version supplied by the netfs:
- *
- *				     FSDEF
- *				       |
- *				 +-----------+
- *				 |           |
- *				NFS         AFS
- *			       [v=1]       [v=1]
- *
- * If an entry with the appropriate name does already exist, the version is
- * compared.  If the version is different, the entire subtree from that entry
- * will be discarded and a new entry created.
- *
- * The new entry will be an index, and a cookie referring to it will be passed
- * to the netfs.  This is then the root handle by which the netfs accesses the
- * cache.  It can create whatever objects it likes in that index, including
- * further indices.
- */
-struct fscache_cookie fscache_fsdef_index = {
-	.debug_id	= 1,
-	.ref		= REFCOUNT_INIT(1),
-	.n_active	= ATOMIC_INIT(1),
-	.lock		= __SPIN_LOCK_UNLOCKED(fscache_fsdef_index.lock),
-	.backing_objects = HLIST_HEAD_INIT,
-	.type_name	= ".fscach",
-	.flags		= 1 << FSCACHE_COOKIE_ENABLED,
-	.type		= FSCACHE_COOKIE_TYPE_INDEX,
-};
-EXPORT_SYMBOL(fscache_fsdef_index);
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index eefcb6dfee3e..f74f7bdea633 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -1,23 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /* Internal definitions for FS-Cache
  *
- * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004-2007, 2001 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  */
 
-/*
- * Lock order, in the order in which multiple locks should be obtained:
- * - fscache_addremove_sem
- * - cookie->lock
- * - cookie->parent->lock
- * - cache->object_list_lock
- * - object->lock
- * - object->parent->lock
- * - cookie->stores_lock
- * - fscache_thread_lock
- *
- */
-
 #ifdef pr_fmt
 #undef pr_fmt
 #endif
@@ -30,31 +17,15 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 
-#define FSCACHE_MIN_THREADS	4
-#define FSCACHE_MAX_THREADS	32
-
 /*
  * cache.c
  */
-extern struct list_head fscache_cache_list;
-extern struct rw_semaphore fscache_addremove_sem;
-
-extern struct fscache_cache *fscache_select_cache_for_object(
-	struct fscache_cookie *);
-
-static inline
-struct fscache_cache_tag *fscache_get_cache_tag(struct fscache_cache_tag *tag)
-{
-	if (tag)
-		refcount_inc(&tag->ref);
-	return tag;
-}
-
-static inline void fscache_put_cache_tag(struct fscache_cache_tag *tag)
-{
-	if (tag && refcount_dec_and_test(&tag->ref))
-		kfree(tag);
-}
+#ifdef CONFIG_PROC_FS
+extern const struct seq_operations fscache_caches_seq_ops;
+#endif
+bool fscache_begin_cache_access(struct fscache_cache *cache, enum fscache_access_trace why);
+void fscache_end_cache_access(struct fscache_cache *cache, enum fscache_access_trace why);
+struct fscache_cache *fscache_lookup_cache(const char *name, bool is_cache);
 
 /*
  * cookie.c
@@ -62,16 +33,9 @@ static inline void fscache_put_cache_tag(struct fscache_cache_tag *tag)
 extern struct kmem_cache *fscache_cookie_jar;
 extern const struct seq_operations fscache_cookies_seq_ops;
 
-extern void fscache_free_cookie(struct fscache_cookie *);
-extern struct fscache_cookie *fscache_alloc_cookie(struct fscache_cookie *,
-						   enum fscache_cookie_type,
-						   const char *,
-						   u8,
-						   struct fscache_cache_tag *,
-						   const void *, size_t,
-						   const void *, size_t,
-						   loff_t);
-extern struct fscache_cookie *fscache_hash_cookie(struct fscache_cookie *);
+extern void fscache_print_cookie(struct fscache_cookie *cookie, char prefix);
+extern bool fscache_begin_cookie_access(struct fscache_cookie *cookie,
+					enum fscache_access_trace why);
 
 static inline void fscache_see_cookie(struct fscache_cookie *cookie,
 				      enum fscache_cookie_trace where)
@@ -80,34 +44,13 @@ static inline void fscache_see_cookie(struct fscache_cookie *cookie,
 			     where);
 }
 
-/*
- * fsdef.c
- */
-extern struct fscache_cookie fscache_fsdef_index;
-
 /*
  * main.c
  */
-extern unsigned fscache_defer_lookup;
-extern unsigned fscache_defer_create;
 extern unsigned fscache_debug;
-extern struct kobject *fscache_root;
-extern struct workqueue_struct *fscache_object_wq;
-extern struct workqueue_struct *fscache_op_wq;
-DECLARE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
 
 extern unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n);
 
-static inline bool fscache_object_congested(void)
-{
-	return workqueue_congested(WORK_CPU_UNBOUND, fscache_object_wq);
-}
-
-/*
- * object.c
- */
-extern void fscache_enqueue_object(struct cachefiles_object *);
-
 /*
  * proc.c
  */
@@ -123,15 +66,10 @@ extern void fscache_proc_cleanup(void);
  * stats.c
  */
 #ifdef CONFIG_FSCACHE_STATS
-extern atomic_t fscache_n_op_pend;
-extern atomic_t fscache_n_op_run;
-extern atomic_t fscache_n_op_enqueue;
-extern atomic_t fscache_n_op_deferred_release;
-extern atomic_t fscache_n_op_initialised;
-extern atomic_t fscache_n_op_release;
-extern atomic_t fscache_n_op_gc;
-extern atomic_t fscache_n_op_cancelled;
-extern atomic_t fscache_n_op_rejected;
+extern atomic_t fscache_n_volumes;
+extern atomic_t fscache_n_volumes_collision;
+extern atomic_t fscache_n_volumes_nomem;
+extern atomic_t fscache_n_cookies;
 
 extern atomic_t fscache_n_retrievals;
 extern atomic_t fscache_n_retrievals_ok;
@@ -171,36 +109,10 @@ extern atomic_t fscache_n_updates_run;
 extern atomic_t fscache_n_relinquishes;
 extern atomic_t fscache_n_relinquishes_null;
 extern atomic_t fscache_n_relinquishes_retire;
+extern atomic_t fscache_n_relinquishes_dropped;
 
-extern atomic_t fscache_n_cookie_index;
-extern atomic_t fscache_n_cookie_data;
-extern atomic_t fscache_n_cookie_special;
-
-extern atomic_t fscache_n_object_alloc;
-extern atomic_t fscache_n_object_no_alloc;
-extern atomic_t fscache_n_object_lookups;
-extern atomic_t fscache_n_object_lookups_negative;
-extern atomic_t fscache_n_object_lookups_positive;
-extern atomic_t fscache_n_object_lookups_timed_out;
-extern atomic_t fscache_n_object_created;
-extern atomic_t fscache_n_object_avail;
-extern atomic_t fscache_n_object_dead;
-
-extern atomic_t fscache_n_cop_alloc_object;
-extern atomic_t fscache_n_cop_lookup_object;
-extern atomic_t fscache_n_cop_lookup_complete;
-extern atomic_t fscache_n_cop_grab_object;
-extern atomic_t fscache_n_cop_invalidate_object;
-extern atomic_t fscache_n_cop_update_object;
-extern atomic_t fscache_n_cop_drop_object;
-extern atomic_t fscache_n_cop_put_object;
-extern atomic_t fscache_n_cop_sync_cache;
-extern atomic_t fscache_n_cop_attr_changed;
-
-extern atomic_t fscache_n_cache_no_space_reject;
-extern atomic_t fscache_n_cache_stale_objects;
-extern atomic_t fscache_n_cache_retired_objects;
-extern atomic_t fscache_n_cache_culled_objects;
+extern atomic_t fscache_n_resizes;
+extern atomic_t fscache_n_resizes_null;
 
 static inline void fscache_stat(atomic_t *stat)
 {
@@ -223,35 +135,31 @@ int fscache_stats_show(struct seq_file *m, void *v);
 #endif
 
 /*
- * raise an event on an object
- * - if the event is not masked for that object, then the object is
- *   queued for attention by the thread pool.
+ * volume.c
  */
-static inline void fscache_raise_event(struct cachefiles_object *object,
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
+extern const struct seq_operations fscache_volumes_seq_ops;
+
+struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
+					  enum fscache_volume_trace where);
+void fscache_put_volume(struct fscache_volume *volume,
+			enum fscache_volume_trace where);
+bool fscache_begin_volume_access(struct fscache_volume *volume,
+				 enum fscache_access_trace why);
+void fscache_create_volume(struct fscache_volume *volume, bool wait);
 
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
@@ -259,7 +167,7 @@ void fscache_update_aux(struct fscache_cookie *cookie, const void *aux_data)
  * debug tracing
  */
 #define dbgprintk(FMT, ...) \
-	printk(KERN_DEBUG "[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
+	printk("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
 
 #define kenter(FMT, ...) dbgprintk("==> %s("FMT")", __func__, ##__VA_ARGS__)
 #define kleave(FMT, ...) dbgprintk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
@@ -312,7 +220,7 @@ do {						\
 
 #define FSCACHE_DEBUG_CACHE	0
 #define FSCACHE_DEBUG_COOKIE	1
-#define FSCACHE_DEBUG_PAGE	2
+#define FSCACHE_DEBUG_OBJECT	2
 #define FSCACHE_DEBUG_OPERATION	3
 
 #define FSCACHE_POINT_ENTER	1
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 2547892a6064..2b1c9f433530 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -4,160 +4,148 @@
  * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  */
-
-#define FSCACHE_DEBUG_LEVEL PAGE
-#include <linux/module.h>
+#define FSCACHE_DEBUG_LEVEL OPERATION
 #define FSCACHE_USE_NEW_IO_API
 #define FSCACHE_USE_FALLBACK_IO_API
 #include <linux/fscache-cache.h>
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
-#include <linux/netfs.h>
 #include "internal.h"
 
-/*
- * Start a cache operation.
- * - we return:
- *   -ENOMEM	- out of memory, some pages may be being read
- *   -ERESTARTSYS - interrupted, some pages may be being read
- *   -ENOBUFS	- no backing object or space available in which to cache any
- *                pages not being read
- *   -ENODATA	- no data available in the backing object for some or all of
- *                the pages
- *   0		- dispatched a read on all pages
+/**
+ * fscache_wait_for_operation - Wait for an object become accessible
+ * @cres: The cache resources for the operation being performed
+ * @want_stage: The minimum stage the object must be at
+ *
+ * See if the target cache object is at the specified minimum stage of
+ * accessibility yet, and if not, wait for it.
  */
-int __fscache_begin_operation(struct netfs_cache_resources *cres,
-			      struct fscache_cookie *cookie,
-			      bool for_write)
+bool fscache_wait_for_operation(struct netfs_cache_resources *cres,
+				enum fscache_want_stage want_stage)
 {
-#if 0
-	struct fscache_operation *op;
-	struct fscache_object *object;
-	bool wake_cookie = false;
-	int ret;
-
-	_enter("c=%08x", cres->debug_id);
-
-	if (for_write)
-		fscache_stat(&fscache_n_stores);
-	else
-		fscache_stat(&fscache_n_retrievals);
+	struct fscache_cookie *cookie = fscache_cres_cookie(cres);
+	enum fscache_cookie_stage stage;
 
-	if (hlist_empty(&cookie->backing_objects))
-		goto nobufs;
+again:
+	if (!fscache_cache_is_live(cookie->volume->cache)) {
+		_leave(" [broken]");
+		return false;
+	}
 
-	if (test_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags)) {
-		_leave(" = -ENOBUFS [invalidating]");
-		return -ENOBUFS;
+	stage = READ_ONCE(cookie->stage);
+	_enter("c=%08x{%u},%x", cookie->debug_id, stage, want_stage);
+
+	switch (stage) {
+	case FSCACHE_COOKIE_STAGE_CREATING:
+	case FSCACHE_COOKIE_STAGE_INVALIDATING:
+		if (want_stage == FSCACHE_WANT_PARAMS)
+			goto ready; /* There can be no content */
+		fallthrough;
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+		wait_var_event(&cookie->stage, READ_ONCE(cookie->stage) != stage);
+		goto again;
+
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		goto ready;
+	case FSCACHE_COOKIE_STAGE_DROPPED:
+	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
+	default:
+		_leave(" [not live]");
+		return false;
 	}
 
-	ASSERTCMP(cookie->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
+ready:
+	if (!cres->cache_priv2)
+		return cookie->volume->cache->ops->begin_operation(cres, want_stage);
+	return true;
+}
+EXPORT_SYMBOL(fscache_wait_for_operation);
 
-	if (fscache_wait_for_deferred_lookup(cookie) < 0)
-		return -ERESTARTSYS;
+/*
+ * Begin an I/O operation on the cache, waiting till we reach the right state.
+ *
+ * Attaches the resources required to the operation resources record.
+ */
+static int fscache_begin_operation(struct netfs_cache_resources *cres,
+				   struct fscache_cookie *cookie,
+				   enum fscache_want_stage want_stage,
+				   enum fscache_access_trace why)
+{
+	enum fscache_cookie_stage stage;
+	long timeo;
+	bool once_only = false;
 
-	op = kzalloc(sizeof(*op), GFP_KERNEL);
-	if (!op)
-		return -ENOMEM;
+	cres->ops		= NULL;
+	cres->cache_priv	= cookie;
+	cres->cache_priv2	= NULL;
+	cres->debug_id		= cookie->debug_id;
 
-	fscache_operation_init(cookie, op, NULL, NULL, NULL);
-	op->flags = FSCACHE_OP_MYTHREAD |
-		(1UL << FSCACHE_OP_WAITING) |
-		(1UL << FSCACHE_OP_UNUSE_COOKIE);
+	if (!fscache_begin_cookie_access(cookie, why))
+		return -ENOBUFS;
 
+again:
 	spin_lock(&cookie->lock);
 
-	if (!fscache_cookie_enabled(cookie) ||
-	    hlist_empty(&cookie->backing_objects))
-		goto nobufs_unlock;
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-
-	__fscache_use_cookie(cookie);
-	atomic_inc(&object->n_reads);
-	__set_bit(FSCACHE_OP_DEC_READ_CNT, &op->flags);
+	stage = cookie->stage;
+	_enter("c=%08x{%u},%x", cookie->debug_id, stage, want_stage);
+
+	switch (stage) {
+	case FSCACHE_COOKIE_STAGE_LOOKING_UP:
+		goto wait_and_validate;
+	case FSCACHE_COOKIE_STAGE_INVALIDATING:
+	case FSCACHE_COOKIE_STAGE_CREATING:
+		if (want_stage == FSCACHE_WANT_PARAMS)
+			goto ready; /* There can be no content */
+		goto wait_and_validate;
+	case FSCACHE_COOKIE_STAGE_ACTIVE:
+		goto ready;
+	case FSCACHE_COOKIE_STAGE_DROPPED:
+	case FSCACHE_COOKIE_STAGE_RELINQUISHING:
+		WARN(1, "Can't use cookie in stage %u\n", cookie->stage);
+		goto not_live;
+	default:
+		goto not_live;
+	}
 
-	if (fscache_submit_op(object, op) < 0)
-		goto nobufs_unlock_dec;
+ready:
 	spin_unlock(&cookie->lock);
+	if (!cookie->volume->cache->ops->begin_operation(cres, want_stage))
+		goto failed;
+	return 0;
 
-	/* we wait for the operation to become active, and then process it
-	 * *here*, in this thread, and not in the thread pool */
-	if (for_write) {
-		fscache_stat(&fscache_n_store_ops);
-
-		ret = fscache_wait_for_operation_activation(
-			object, op,
-			__fscache_stat(&fscache_n_store_op_waits),
-			__fscache_stat(&fscache_n_stores_object_dead));
-	} else {
-		fscache_stat(&fscache_n_retrieval_ops);
-
-		ret = fscache_wait_for_operation_activation(
-			object, op,
-			__fscache_stat(&fscache_n_retrieval_op_waits),
-			__fscache_stat(&fscache_n_retrievals_object_dead));
-	}
-	if (ret < 0)
-		goto error;
-
-	/* ask the cache to honour the operation */
-	ret = object->cache->ops->begin_operation(cres, op);
-
-error:
-	if (for_write) {
-		if (ret == -ENOMEM)
-			fscache_stat(&fscache_n_stores_oom);
-		else if (ret == -ERESTARTSYS)
-			fscache_stat(&fscache_n_stores_intr);
-		else if (ret < 0)
-			fscache_stat(&fscache_n_stores_nobufs);
-		else
-			fscache_stat(&fscache_n_stores_ok);
-	} else {
-		if (ret == -ENOMEM)
-			fscache_stat(&fscache_n_retrievals_nomem);
-		else if (ret == -ERESTARTSYS)
-			fscache_stat(&fscache_n_retrievals_intr);
-		else if (ret == -ENODATA)
-			fscache_stat(&fscache_n_retrievals_nodata);
-		else if (ret < 0)
-			fscache_stat(&fscache_n_retrievals_nobufs);
-		else
-			fscache_stat(&fscache_n_retrievals_ok);
+wait_and_validate:
+	spin_unlock(&cookie->lock);
+	trace_fscache_access(cookie->debug_id, refcount_read(&cookie->ref),
+			     atomic_read(&cookie->n_accesses),
+			     fscache_access_io_wait);
+	timeo = wait_var_event_timeout(&cookie->stage,
+				       READ_ONCE(cookie->stage) != stage, 20 * HZ);
+	if (timeo <= 1 && !once_only) {
+		pr_warn("%s: cookie stage change wait timed out: cookie->stage=%u stage=%u",
+			__func__, READ_ONCE(cookie->stage), stage);
+		fscache_print_cookie(cookie, 'O');
+		once_only = true;
 	}
+	goto again;
 
-	fscache_put_operation(op);
-	_leave(" = %d", ret);
-	return ret;
-
-nobufs_unlock_dec:
-	atomic_dec(&object->n_reads);
-	wake_cookie = __fscache_unuse_cookie(cookie);
-nobufs_unlock:
+not_live:
 	spin_unlock(&cookie->lock);
-	fscache_put_operation(op);
-	if (wake_cookie)
-		__fscache_wake_unused_cookie(cookie);
-nobufs:
-	if (for_write)
-		fscache_stat(&fscache_n_stores_nobufs);
-	else
-		fscache_stat(&fscache_n_retrievals_nobufs);
-#endif
+failed:
+	cres->cache_priv = NULL;
+	cres->ops = NULL;
+	fscache_end_cookie_access(cookie, fscache_access_io_not_live);
 	_leave(" = -ENOBUFS");
 	return -ENOBUFS;
 }
-EXPORT_SYMBOL(__fscache_begin_operation);
 
-/*
- * Clean up an operation.
- */
-static void fscache_end_operation(struct netfs_cache_resources *cres)
+int __fscache_begin_read_operation(struct netfs_cache_resources *cres,
+				   struct fscache_cookie *cookie)
 {
-	cres->ops->end_operation(cres);
+	return fscache_begin_operation(cres, cookie, FSCACHE_WANT_PARAMS,
+				       fscache_access_io_read);
 }
+EXPORT_SYMBOL(__fscache_begin_read_operation);
 
 /*
  * Fallback page reading interface.
@@ -177,7 +165,8 @@ int __fscache_fallback_read_page(struct fscache_cookie *cookie, struct page *pag
 	bvec[0].bv_len		= PAGE_SIZE;
 	iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
 
-	ret = fscache_begin_read_operation(&cres, cookie);
+	ret = fscache_begin_operation(&cres, cookie, FSCACHE_WANT_READ,
+				      fscache_access_io_write);
 	if (ret < 0)
 		return ret;
 
@@ -207,7 +196,8 @@ int __fscache_fallback_write_page(struct fscache_cookie *cookie, struct page *pa
 	bvec[0].bv_len		= PAGE_SIZE;
 	iov_iter_bvec(&iter, WRITE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
 
-	ret = __fscache_begin_operation(&cres, cookie, true);
+	ret = fscache_begin_operation(&cres, cookie, FSCACHE_WANT_WRITE,
+				      fscache_access_io_write);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index 4207f98e405f..ba23745146cf 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -8,10 +8,6 @@
 #define FSCACHE_DEBUG_LEVEL CACHE
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/completion.h>
-#include <linux/slab.h>
-#include <linux/seq_file.h>
 #define CREATE_TRACE_POINTS
 #include "internal.h"
 
@@ -19,79 +15,18 @@ MODULE_DESCRIPTION("FS Cache Manager");
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
 MODULE_PARM_DESC(fscache_debug,
 		 "FS-Cache debugging mask");
 
-struct kobject *fscache_root;
-struct workqueue_struct *fscache_object_wq;
-struct workqueue_struct *fscache_op_wq;
-
-DEFINE_PER_CPU(wait_queue_head_t, fscache_object_cong_wait);
+EXPORT_TRACEPOINT_SYMBOL(fscache_access_cache);
+EXPORT_TRACEPOINT_SYMBOL(fscache_access_volume);
+EXPORT_TRACEPOINT_SYMBOL(fscache_access);
 
-/* these values serve as lower bounds, will be adjusted in fscache_init() */
-static unsigned fscache_object_max_active = 4;
-static unsigned fscache_op_max_active = 2;
-
-#ifdef CONFIG_SYSCTL
-static struct ctl_table_header *fscache_sysctl_header;
-
-static int fscache_max_active_sysctl(struct ctl_table *table, int write,
-				     void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct workqueue_struct **wqp = table->extra1;
-	unsigned int *datap = table->data;
-	int ret;
-
-	ret = proc_dointvec(table, write, buffer, lenp, ppos);
-	if (ret == 0)
-		workqueue_set_max_active(*wqp, *datap);
-	return ret;
-}
-
-static struct ctl_table fscache_sysctls[] = {
-	{
-		.procname	= "object_max_active",
-		.data		= &fscache_object_max_active,
-		.maxlen		= sizeof(unsigned),
-		.mode		= 0644,
-		.proc_handler	= fscache_max_active_sysctl,
-		.extra1		= &fscache_object_wq,
-	},
-	{
-		.procname	= "operation_max_active",
-		.data		= &fscache_op_max_active,
-		.maxlen		= sizeof(unsigned),
-		.mode		= 0644,
-		.proc_handler	= fscache_max_active_sysctl,
-		.extra1		= &fscache_op_wq,
-	},
-	{}
-};
-
-static struct ctl_table fscache_sysctls_root[] = {
-	{
-		.procname	= "fscache",
-		.mode		= 0555,
-		.child		= fscache_sysctls,
-	},
-	{}
-};
-#endif
+struct workqueue_struct *fscache_wq;
+EXPORT_SYMBOL(fscache_wq);
 
 /*
  * Mixing scores (in bits) for (7,20):
@@ -137,44 +72,16 @@ unsigned int fscache_hash(unsigned int salt, unsigned int *data, unsigned int n)
  */
 static int __init fscache_init(void)
 {
-	unsigned int nr_cpus = num_possible_cpus();
-	unsigned int cpu;
-	int ret;
-
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
-	fscache_op_max_active =
-		clamp_val(fscache_object_max_active / 2,
-			  fscache_op_max_active, WQ_UNBOUND_MAX_ACTIVE);
+	int ret = -ENOMEM;
 
-	ret = -ENOMEM;
-	fscache_op_wq = alloc_workqueue("fscache_operation", WQ_UNBOUND,
-					fscache_op_max_active);
-	if (!fscache_op_wq)
-		goto error_op_wq;
-
-	for_each_possible_cpu(cpu)
-		init_waitqueue_head(&per_cpu(fscache_object_cong_wait, cpu));
+	fscache_wq = alloc_workqueue("fscache", WQ_UNBOUND | WQ_FREEZABLE, 0);
+	if (!fscache_wq)
+		goto error_wq;
 
 	ret = fscache_proc_init();
 	if (ret < 0)
 		goto error_proc;
 
-#ifdef CONFIG_SYSCTL
-	ret = -ENOMEM;
-	fscache_sysctl_header = register_sysctl_table(fscache_sysctls_root);
-	if (!fscache_sysctl_header)
-		goto error_sysctl;
-#endif
-
 	fscache_cookie_jar = kmem_cache_create("fscache_cookie_jar",
 					       sizeof(struct fscache_cookie),
 					       0, 0, NULL);
@@ -184,26 +91,14 @@ static int __init fscache_init(void)
 		goto error_cookie_jar;
 	}
 
-	fscache_root = kobject_create_and_add("fscache", kernel_kobj);
-	if (!fscache_root)
-		goto error_kobj;
-
 	pr_notice("Loaded\n");
 	return 0;
 
-error_kobj:
-	kmem_cache_destroy(fscache_cookie_jar);
 error_cookie_jar:
-#ifdef CONFIG_SYSCTL
-	unregister_sysctl_table(fscache_sysctl_header);
-error_sysctl:
-#endif
 	fscache_proc_cleanup();
 error_proc:
-	destroy_workqueue(fscache_op_wq);
-error_op_wq:
-	destroy_workqueue(fscache_object_wq);
-error_object_wq:
+	destroy_workqueue(fscache_wq);
+error_wq:
 	return ret;
 }
 
@@ -216,14 +111,9 @@ static void __exit fscache_exit(void)
 {
 	_enter("");
 
-	kobject_put(fscache_root);
 	kmem_cache_destroy(fscache_cookie_jar);
-#ifdef CONFIG_SYSCTL
-	unregister_sysctl_table(fscache_sysctl_header);
-#endif
 	fscache_proc_cleanup();
-	destroy_workqueue(fscache_op_wq);
-	destroy_workqueue(fscache_object_wq);
+	destroy_workqueue(fscache_wq);
 	pr_notice("Unloaded\n");
 }
 
diff --git a/fs/fscache/netfs.c b/fs/fscache/netfs.c
deleted file mode 100644
index d746365f1daf..000000000000
--- a/fs/fscache/netfs.c
+++ /dev/null
@@ -1,76 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* FS-Cache netfs (client) registration
- *
- * Copyright (C) 2008 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL COOKIE
-#include <linux/module.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-/*
- * register a network filesystem for caching
- */
-int __fscache_register_netfs(struct fscache_netfs *netfs)
-{
-	struct fscache_cookie *candidate, *cookie;
-
-	_enter("{%s}", netfs->name);
-
-	/* allocate a cookie for the primary index */
-	candidate = fscache_alloc_cookie(&fscache_fsdef_index,
-					 FSCACHE_COOKIE_TYPE_INDEX,
-					 ".netfs",
-					 0, NULL,
-					 netfs->name, strlen(netfs->name),
-					 &netfs->version, sizeof(netfs->version),
-					 0);
-	if (!candidate) {
-		_leave(" = -ENOMEM");
-		return -ENOMEM;
-	}
-
-	candidate->flags = 1 << FSCACHE_COOKIE_ENABLED;
-
-	/* check the netfs type is not already present */
-	cookie = fscache_hash_cookie(candidate);
-	if (!cookie)
-		goto already_registered;
-	if (cookie != candidate) {
-		trace_fscache_cookie(candidate->debug_id, 1, fscache_cookie_discard);
-		fscache_free_cookie(candidate);
-	}
-
-	fscache_get_cookie(cookie->parent, fscache_cookie_get_register_netfs);
-	atomic_inc(&cookie->parent->n_children);
-
-	netfs->primary_index = cookie;
-
-	pr_notice("Netfs '%s' registered for caching\n", netfs->name);
-	trace_fscache_netfs(netfs);
-	_leave(" = 0");
-	return 0;
-
-already_registered:
-	fscache_put_cookie(candidate, fscache_cookie_put_dup_netfs);
-	_leave(" = -EEXIST");
-	return -EEXIST;
-}
-EXPORT_SYMBOL(__fscache_register_netfs);
-
-/*
- * unregister a network filesystem from the cache
- * - all cookies must have been released first
- */
-void __fscache_unregister_netfs(struct fscache_netfs *netfs)
-{
-	_enter("{%s.%u}", netfs->name, netfs->version);
-
-	fscache_relinquish_cookie(netfs->primary_index, NULL, false);
-	pr_notice("Netfs '%s' unregistered from caching\n", netfs->name);
-
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_unregister_netfs);
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
deleted file mode 100644
index e653d0194f71..000000000000
--- a/fs/fscache/object.c
+++ /dev/null
@@ -1,973 +0,0 @@
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
-static const struct fscache_state *fscache_abort_initialisation(struct cachefiles_object *, int);
-static const struct fscache_state *fscache_kill_dependents(struct cachefiles_object *, int);
-static const struct fscache_state *fscache_drop_object(struct cachefiles_object *, int);
-static const struct fscache_state *fscache_initialise_object(struct cachefiles_object *, int);
-static const struct fscache_state *fscache_invalidate_object(struct cachefiles_object *, int);
-static const struct fscache_state *fscache_jumpstart_dependents(struct cachefiles_object *, int);
-static const struct fscache_state *fscache_kill_object(struct cachefiles_object *, int);
-static const struct fscache_state *fscache_lookup_failure(struct cachefiles_object *, int);
-static const struct fscache_state *fscache_look_up_object(struct cachefiles_object *, int);
-static const struct fscache_state *fscache_object_available(struct cachefiles_object *, int);
-static const struct fscache_state *fscache_parent_ready(struct cachefiles_object *, int);
-static const struct fscache_state *fscache_update_object(struct cachefiles_object *, int);
-static const struct fscache_state *fscache_object_dead(struct cachefiles_object *, int);
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
-static int  fscache_get_object(struct cachefiles_object *,
-			       enum fscache_obj_ref_trace);
-static void fscache_put_object(struct cachefiles_object *,
-			       enum fscache_obj_ref_trace);
-static bool fscache_enqueue_dependents(struct cachefiles_object *, int);
-static void fscache_dequeue_object(struct cachefiles_object *);
-static void fscache_update_aux_data(struct cachefiles_object *);
-
-/*
- * we need to notify the parent when an op completes that we had outstanding
- * upon it
- */
-static inline void fscache_done_parent_op(struct cachefiles_object *object)
-{
-	struct cachefiles_object *parent = object->parent;
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
-static void fscache_object_sm_dispatcher(struct cachefiles_object *object)
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
-	struct cachefiles_object *object =
-		container_of(work, struct cachefiles_object, work);
-
-	_enter("{OBJ%x}", object->debug_id);
-
-	fscache_object_sm_dispatcher(object);
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
-void fscache_object_init(struct cachefiles_object *object,
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
-	fscache_get_cookie(cookie, fscache_cookie_get_attach_object);
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
-static inline void fscache_mark_object_dead(struct cachefiles_object *object)
-{
-	spin_lock(&object->lock);
-	clear_bit(FSCACHE_OBJECT_IS_LIVE, &object->flags);
-	spin_unlock(&object->lock);
-}
-
-/*
- * Abort object initialisation before we start it.
- */
-static const struct fscache_state *fscache_abort_initialisation(struct cachefiles_object *object,
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
-static const struct fscache_state *fscache_initialise_object(struct cachefiles_object *object,
-							     int event)
-{
-	struct cachefiles_object *parent;
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
-static const struct fscache_state *fscache_parent_ready(struct cachefiles_object *object,
-							int event)
-{
-	struct cachefiles_object *parent = object->parent;
-
-	_enter("{OBJ%x},%d", object->debug_id, event);
-
-	ASSERT(parent != NULL);
-
-	spin_lock(&parent->lock);
-	parent->n_ops++;
-	parent->n_obj_ops++;
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
-static const struct fscache_state *fscache_look_up_object(struct cachefiles_object *object,
-							  int event)
-{
-	struct fscache_cookie *cookie = object->cookie;
-	struct cachefiles_object *parent = object->parent;
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
-void fscache_object_lookup_negative(struct cachefiles_object *object)
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
-void fscache_obtained_object(struct cachefiles_object *object)
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
-static const struct fscache_state *fscache_object_available(struct cachefiles_object *object,
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
-	fscache_stat(&fscache_n_object_avail);
-
-	_leave("");
-	return transit_to(JUMPSTART_DEPS);
-}
-
-/*
- * Wake up this object's dependent objects now that we've become available.
- */
-static const struct fscache_state *fscache_jumpstart_dependents(struct cachefiles_object *object,
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
-static const struct fscache_state *fscache_lookup_failure(struct cachefiles_object *object,
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
-static const struct fscache_state *fscache_kill_object(struct cachefiles_object *object,
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
-static const struct fscache_state *fscache_kill_dependents(struct cachefiles_object *object,
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
-static const struct fscache_state *fscache_drop_object(struct cachefiles_object *object,
-						       int event)
-{
-	struct cachefiles_object *parent = object->parent;
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
-static int fscache_get_object(struct cachefiles_object *object,
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
-static void fscache_put_object(struct cachefiles_object *object,
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
-void fscache_object_destroy(struct cachefiles_object *object)
-{
-	/* We can get rid of the cookie now */
-	fscache_put_cookie(object->cookie, fscache_cookie_put_object);
-	object->cookie = NULL;
-}
-EXPORT_SYMBOL(fscache_object_destroy);
-
-/*
- * enqueue an object for metadata-type processing
- */
-void fscache_enqueue_object(struct cachefiles_object *object)
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
-static bool fscache_enqueue_dependents(struct cachefiles_object *object, int event)
-{
-	struct cachefiles_object *dep;
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
-				 struct cachefiles_object, dep_link);
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
-static void fscache_dequeue_object(struct cachefiles_object *object)
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
-static const struct fscache_state *fscache_invalidate_object(struct cachefiles_object *object,
-							     int event)
-{
-	return transit_to(UPDATE_OBJECT);
-}
-
-/*
- * Update auxiliary data.
- */
-static void fscache_update_aux_data(struct cachefiles_object *object)
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
-static const struct fscache_state *fscache_update_object(struct cachefiles_object *object,
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
-void fscache_object_retrying_stale(struct cachefiles_object *object)
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
-void fscache_object_mark_killed(struct cachefiles_object *object,
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
-static const struct fscache_state *fscache_object_dead(struct cachefiles_object *object,
-						       int event)
-{
-	if (!test_and_set_bit(FSCACHE_OBJECT_RUN_AFTER_DEAD,
-			      &object->flags))
-		return NO_TRANSIT;
-
-	WARN(true, "FS-Cache object redispatched after death");
-	return NO_TRANSIT;
-}
diff --git a/fs/fscache/proc.c b/fs/fscache/proc.c
index 061df8f61ffc..b3fc14f08ced 100644
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
@@ -16,42 +16,32 @@
  */
 int __init fscache_proc_init(void)
 {
-	_enter("");
-
 	if (!proc_mkdir("fs/fscache", NULL))
 		goto error_dir;
 
+	if (!proc_create_seq("fs/fscache/caches", S_IFREG | 0444, NULL,
+			     &fscache_caches_seq_ops))
+		goto error;
+
+	if (!proc_create_seq("fs/fscache/volumes", S_IFREG | 0444, NULL,
+			     &fscache_volumes_seq_ops))
+		goto error;
+
 	if (!proc_create_seq("fs/fscache/cookies", S_IFREG | 0444, NULL,
 			     &fscache_cookies_seq_ops))
-		goto error_cookies;
+		goto error;
 
 #ifdef CONFIG_FSCACHE_STATS
 	if (!proc_create_single("fs/fscache/stats", S_IFREG | 0444, NULL,
-			fscache_stats_show))
-		goto error_stats;
+				fscache_stats_show))
+		goto error;
 #endif
 
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
-	if (!proc_create("fs/fscache/objects", S_IFREG | 0444, NULL,
-			 &fscache_objlist_proc_ops))
-		goto error_objects;
-#endif
-
-	_leave(" = 0");
 	return 0;
 
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
-error_objects:
-#endif
-#ifdef CONFIG_FSCACHE_STATS
-	remove_proc_entry("fs/fscache/stats", NULL);
-error_stats:
-#endif
-	remove_proc_entry("fs/fscache/cookies", NULL);
-error_cookies:
+error:
 	remove_proc_entry("fs/fscache", NULL);
 error_dir:
-	_leave(" = -ENOMEM");
 	return -ENOMEM;
 }
 
@@ -60,12 +50,5 @@ int __init fscache_proc_init(void)
  */
 void fscache_proc_cleanup(void)
 {
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
-	remove_proc_entry("fs/fscache/objects", NULL);
-#endif
-#ifdef CONFIG_FSCACHE_STATS
-	remove_proc_entry("fs/fscache/stats", NULL);
-#endif
-	remove_proc_entry("fs/fscache/cookies", NULL);
 	remove_proc_entry("fs/fscache", NULL);
 }
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index cb9dd0a93e0d..13e90b940bd2 100644
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
@@ -14,15 +14,10 @@
 /*
  * operation counters
  */
-atomic_t fscache_n_op_pend;
-atomic_t fscache_n_op_run;
-atomic_t fscache_n_op_enqueue;
-atomic_t fscache_n_op_deferred_release;
-atomic_t fscache_n_op_initialised;
-atomic_t fscache_n_op_release;
-atomic_t fscache_n_op_gc;
-atomic_t fscache_n_op_cancelled;
-atomic_t fscache_n_op_rejected;
+atomic_t fscache_n_volumes;
+atomic_t fscache_n_volumes_collision;
+atomic_t fscache_n_volumes_nomem;
+atomic_t fscache_n_cookies;
 
 atomic_t fscache_n_retrievals;
 atomic_t fscache_n_retrievals_ok;
@@ -62,36 +57,15 @@ atomic_t fscache_n_updates_run;
 atomic_t fscache_n_relinquishes;
 atomic_t fscache_n_relinquishes_null;
 atomic_t fscache_n_relinquishes_retire;
+atomic_t fscache_n_relinquishes_dropped;
 
-atomic_t fscache_n_cookie_index;
-atomic_t fscache_n_cookie_data;
-atomic_t fscache_n_cookie_special;
-
-atomic_t fscache_n_object_alloc;
-atomic_t fscache_n_object_no_alloc;
-atomic_t fscache_n_object_lookups;
-atomic_t fscache_n_object_lookups_negative;
-atomic_t fscache_n_object_lookups_positive;
-atomic_t fscache_n_object_lookups_timed_out;
-atomic_t fscache_n_object_created;
-atomic_t fscache_n_object_avail;
-atomic_t fscache_n_object_dead;
-
-atomic_t fscache_n_cop_alloc_object;
-atomic_t fscache_n_cop_lookup_object;
-atomic_t fscache_n_cop_lookup_complete;
-atomic_t fscache_n_cop_grab_object;
-atomic_t fscache_n_cop_invalidate_object;
-atomic_t fscache_n_cop_update_object;
-atomic_t fscache_n_cop_drop_object;
-atomic_t fscache_n_cop_put_object;
-atomic_t fscache_n_cop_sync_cache;
-atomic_t fscache_n_cop_attr_changed;
-
-atomic_t fscache_n_cache_no_space_reject;
-atomic_t fscache_n_cache_stale_objects;
-atomic_t fscache_n_cache_retired_objects;
-atomic_t fscache_n_cache_culled_objects;
+atomic_t fscache_n_resizes;
+atomic_t fscache_n_resizes_null;
+
+atomic_t fscache_n_read;
+EXPORT_SYMBOL(fscache_n_read);
+atomic_t fscache_n_write;
+EXPORT_SYMBOL(fscache_n_write);
 
 /*
  * display the general statistics
@@ -99,17 +73,12 @@ atomic_t fscache_n_cache_culled_objects;
 int fscache_stats_show(struct seq_file *m, void *v)
 {
 	seq_puts(m, "FS-Cache statistics\n");
-
-	seq_printf(m, "Cookies: idx=%u dat=%u spc=%u\n",
-		   atomic_read(&fscache_n_cookie_index),
-		   atomic_read(&fscache_n_cookie_data),
-		   atomic_read(&fscache_n_cookie_special));
-
-	seq_printf(m, "Objects: alc=%u nal=%u avl=%u ded=%u\n",
-		   atomic_read(&fscache_n_object_alloc),
-		   atomic_read(&fscache_n_object_no_alloc),
-		   atomic_read(&fscache_n_object_avail),
-		   atomic_read(&fscache_n_object_dead));
+	seq_printf(m, "Cookies: n=%d v=%d vcol=%u voom=%u\n",
+		   atomic_read(&fscache_n_cookies),
+		   atomic_read(&fscache_n_volumes),
+		   atomic_read(&fscache_n_volumes_collision),
+		   atomic_read(&fscache_n_volumes_nomem)
+		   );
 
 	seq_printf(m, "Acquire: n=%u nul=%u noc=%u ok=%u nbf=%u"
 		   " oom=%u\n",
@@ -120,13 +89,6 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_acquires_nobufs),
 		   atomic_read(&fscache_n_acquires_oom));
 
-	seq_printf(m, "Lookups: n=%u neg=%u pos=%u crt=%u tmo=%u\n",
-		   atomic_read(&fscache_n_object_lookups),
-		   atomic_read(&fscache_n_object_lookups_negative),
-		   atomic_read(&fscache_n_object_lookups_positive),
-		   atomic_read(&fscache_n_object_created),
-		   atomic_read(&fscache_n_object_lookups_timed_out));
-
 	seq_printf(m, "Invals : n=%u run=%u\n",
 		   atomic_read(&fscache_n_invalidates),
 		   atomic_read(&fscache_n_invalidates_run));
@@ -136,66 +98,15 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_updates_null),
 		   atomic_read(&fscache_n_updates_run));
 
-	seq_printf(m, "Relinqs: n=%u nul=%u rtr=%u\n",
+	seq_printf(m, "Relinqs: n=%u rtr=%u drop=%u\n",
 		   atomic_read(&fscache_n_relinquishes),
-		   atomic_read(&fscache_n_relinquishes_null),
-		   atomic_read(&fscache_n_relinquishes_retire));
-
-	seq_printf(m, "Retrvls: n=%u ok=%u wt=%u nod=%u nbf=%u"
-		   " int=%u oom=%u\n",
-		   atomic_read(&fscache_n_retrievals),
-		   atomic_read(&fscache_n_retrievals_ok),
-		   atomic_read(&fscache_n_retrievals_wait),
-		   atomic_read(&fscache_n_retrievals_nodata),
-		   atomic_read(&fscache_n_retrievals_nobufs),
-		   atomic_read(&fscache_n_retrievals_intr),
-		   atomic_read(&fscache_n_retrievals_nomem));
-	seq_printf(m, "Retrvls: ops=%u owt=%u abt=%u\n",
-		   atomic_read(&fscache_n_retrieval_ops),
-		   atomic_read(&fscache_n_retrieval_op_waits),
-		   atomic_read(&fscache_n_retrievals_object_dead));
-
-	seq_printf(m, "Stores : n=%u ok=%u agn=%u nbf=%u int=%u oom=%u\n",
-		   atomic_read(&fscache_n_stores),
-		   atomic_read(&fscache_n_stores_ok),
-		   atomic_read(&fscache_n_stores_again),
-		   atomic_read(&fscache_n_stores_nobufs),
-		   atomic_read(&fscache_n_stores_intr),
-		   atomic_read(&fscache_n_stores_oom));
-	seq_printf(m, "Stores : ops=%u owt=%u abt=%u\n",
-		   atomic_read(&fscache_n_store_ops),
-		   atomic_read(&fscache_n_store_op_waits),
-		   atomic_read(&fscache_n_stores_object_dead));
-
-	seq_printf(m, "Ops    : pend=%u run=%u enq=%u can=%u rej=%u\n",
-		   atomic_read(&fscache_n_op_pend),
-		   atomic_read(&fscache_n_op_run),
-		   atomic_read(&fscache_n_op_enqueue),
-		   atomic_read(&fscache_n_op_cancelled),
-		   atomic_read(&fscache_n_op_rejected));
-	seq_printf(m, "Ops    : ini=%u dfr=%u rel=%u gc=%u\n",
-		   atomic_read(&fscache_n_op_initialised),
-		   atomic_read(&fscache_n_op_deferred_release),
-		   atomic_read(&fscache_n_op_release),
-		   atomic_read(&fscache_n_op_gc));
-
-	seq_printf(m, "CacheOp: alo=%d luo=%d luc=%d gro=%d\n",
-		   atomic_read(&fscache_n_cop_alloc_object),
-		   atomic_read(&fscache_n_cop_lookup_object),
-		   atomic_read(&fscache_n_cop_lookup_complete),
-		   atomic_read(&fscache_n_cop_grab_object));
-	seq_printf(m, "CacheOp: inv=%d upo=%d dro=%d pto=%d atc=%d syn=%d\n",
-		   atomic_read(&fscache_n_cop_invalidate_object),
-		   atomic_read(&fscache_n_cop_update_object),
-		   atomic_read(&fscache_n_cop_drop_object),
-		   atomic_read(&fscache_n_cop_put_object),
-		   atomic_read(&fscache_n_cop_attr_changed),
-		   atomic_read(&fscache_n_cop_sync_cache));
-	seq_printf(m, "CacheEv: nsp=%d stl=%d rtr=%d cul=%d\n",
-		   atomic_read(&fscache_n_cache_no_space_reject),
-		   atomic_read(&fscache_n_cache_stale_objects),
-		   atomic_read(&fscache_n_cache_retired_objects),
-		   atomic_read(&fscache_n_cache_culled_objects));
+		   atomic_read(&fscache_n_relinquishes_retire),
+		   atomic_read(&fscache_n_relinquishes_dropped));
+
+	seq_printf(m, "IO     : rd=%u wr=%u\n",
+		   atomic_read(&fscache_n_read),
+		   atomic_read(&fscache_n_write));
+
 	netfs_stats_show(m);
 	return 0;
 }
diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
new file mode 100644
index 000000000000..d1e57ce95b72
--- /dev/null
+++ b/fs/fscache/volume.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Volume-level cache cookie handling.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define FSCACHE_DEBUG_LEVEL COOKIE
+#include <linux/export.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+#define fscache_volume_hash_shift 10
+static struct hlist_bl_head fscache_volume_hash[1 << fscache_volume_hash_shift];
+static atomic_t fscache_volume_debug_id;
+static LIST_HEAD(fscache_volumes);
+
+static void fscache_create_volume_work(struct work_struct *work);
+
+struct fscache_volume *fscache_get_volume(struct fscache_volume *volume,
+					  enum fscache_volume_trace where)
+{
+	int ref;
+
+	__refcount_inc(&volume->ref, &ref);
+	trace_fscache_volume(volume->debug_id, ref + 1, where);
+	return volume;
+}
+
+static void fscache_see_volume(struct fscache_volume *volume,
+			       enum fscache_volume_trace where)
+{
+	int ref = refcount_read(&volume->ref);
+
+	trace_fscache_volume(volume->debug_id, ref, where);
+}
+
+/*
+ * Pin the cache behind a volume so that we can access it.
+ */
+static void __fscache_begin_volume_access(struct fscache_volume *volume,
+					  enum fscache_access_trace why)
+{
+	int n_accesses;
+
+	n_accesses = atomic_inc_return(&volume->n_accesses);
+	smp_mb__after_atomic();
+	trace_fscache_access_volume(volume->debug_id, refcount_read(&volume->ref),
+				    n_accesses, why);
+}
+
+/*
+ * If the cache behind a volume is live, pin it so that we can access it.
+ */
+bool fscache_begin_volume_access(struct fscache_volume *volume,
+				 enum fscache_access_trace why)
+{
+	if (!fscache_cache_is_live(volume->cache))
+		return false;
+	__fscache_begin_volume_access(volume, why);
+	if (!fscache_cache_is_live(volume->cache)) {
+		fscache_end_volume_access(volume, fscache_access_unlive);
+		return false;
+	}
+	return true;
+}
+
+/*
+ * Mark the end of an access on a volume.
+ */
+void fscache_end_volume_access(struct fscache_volume *volume,
+			       enum fscache_access_trace why)
+{
+	int n_accesses;
+
+	smp_mb__before_atomic();
+	n_accesses = atomic_dec_return(&volume->n_accesses);
+	trace_fscache_access_volume(volume->debug_id, refcount_read(&volume->ref),
+				    n_accesses, why);
+	if (n_accesses == 0)
+		wake_up_var(&volume->n_accesses);
+}
+EXPORT_SYMBOL(fscache_end_volume_access);
+
+static long fscache_compare_volume(const struct fscache_volume *a,
+				   const struct fscache_volume *b)
+{
+	size_t klen;
+
+	if (a->key_hash != b->key_hash)
+		return (long)a->key_hash - (long)b->key_hash;
+	if (a->cache != b->cache)
+		return (long)a->cache    - (long)b->cache;
+	if (a->key[0] != b->key[0])
+		return (long)a->key[0]   - (long)b->key[0];
+
+	klen = round_up(a->key[0] + 1, sizeof(unsigned int));
+	return memcmp(a->key, b->key, klen);
+}
+
+static bool fscache_is_acquire_pending(struct fscache_volume *volume)
+{
+	return test_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &volume->flags);
+}
+
+static void fscache_wait_on_volume_collision(struct fscache_volume *candidate,
+					     unsigned int collidee_debug_id)
+{
+	wait_var_event_timeout(&candidate->flags,
+			       fscache_is_acquire_pending(candidate), 20 * HZ);
+	if (!fscache_is_acquire_pending(candidate)) {
+		pr_notice("Potential volume collision new=%08x old=%08x",
+			  candidate->debug_id, collidee_debug_id);
+		fscache_stat(&fscache_n_volumes_collision);
+		wait_var_event(&candidate->flags, fscache_is_acquire_pending(candidate));
+	}
+}
+
+/*
+ * Attempt to insert the new volume into the hash.  If there's a collision, we
+ * wait for the old volume to complete if it's being relinquished and an error
+ * otherwise.
+ */
+static struct fscache_volume *fscache_hash_volume(struct fscache_volume *candidate)
+{
+	struct fscache_volume *cursor;
+	struct hlist_bl_head *h;
+	struct hlist_bl_node *p;
+	unsigned int bucket, collidee_debug_id = 0;
+
+	bucket = candidate->key_hash & (ARRAY_SIZE(fscache_volume_hash) - 1);
+	h = &fscache_volume_hash[bucket];
+
+	hlist_bl_lock(h);
+	hlist_bl_for_each_entry(cursor, p, h, hash_link) {
+		if (fscache_compare_volume(candidate, cursor) == 0) {
+			if (!test_bit(FSCACHE_VOLUME_RELINQUISHED, &cursor->flags))
+				goto collision;
+			fscache_see_volume(cursor, fscache_volume_get_hash_collision);
+			set_bit(FSCACHE_VOLUME_COLLIDED_WITH, &cursor->flags);
+			set_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &candidate->flags);
+			collidee_debug_id = cursor->debug_id;
+			break;
+		}
+	}
+
+	hlist_bl_add_head(&candidate->hash_link, h);
+	hlist_bl_unlock(h);
+
+	if (test_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &candidate->flags))
+		fscache_wait_on_volume_collision(candidate, collidee_debug_id);
+	return candidate;
+
+collision:
+	fscache_see_volume(cursor, fscache_volume_collision);
+	pr_err("Cache volume already in use\n");
+	hlist_bl_unlock(h);
+	return NULL;
+}
+
+/*
+ * Allocate and initialise a volume representation cookie.
+ */
+static struct fscache_volume *fscache_alloc_volume(const char *volume_key,
+						   const char *cache_name,
+						   u64 coherency_data)
+{
+	struct fscache_volume *volume;
+	struct fscache_cache *cache;
+	size_t klen, hlen;
+	char *key;
+
+	cache = fscache_lookup_cache(cache_name, false);
+	if (!cache)
+		return NULL;
+
+	volume = kzalloc(sizeof(*volume), GFP_KERNEL);
+	if (!volume)
+		goto err_cache;
+
+	volume->cache = cache;
+	volume->coherency = coherency_data;
+	INIT_LIST_HEAD(&volume->proc_link);
+	INIT_WORK(&volume->work, fscache_create_volume_work);
+	refcount_set(&volume->ref, 1);
+	spin_lock_init(&volume->lock);
+
+	/* Stick the length on the front of the key and pad it out to make
+	 * hashing easier.
+	 */
+	klen = strlen(volume_key);
+	hlen = round_up(1 + klen + 1, sizeof(unsigned int));
+	key = kzalloc(hlen, GFP_KERNEL);
+	if (!key)
+		goto err_vol;
+	key[0] = klen;
+	memcpy(key + 1, volume_key, klen);
+
+	volume->key = key;
+	volume->key_hash = fscache_hash(0, (unsigned int *)key,
+					hlen / sizeof(unsigned int));
+
+	volume->debug_id = atomic_inc_return(&fscache_volume_debug_id);
+	down_write(&fscache_addremove_sem);
+	atomic_inc(&cache->n_volumes);
+	list_add_tail(&volume->proc_link, &fscache_volumes);
+	fscache_see_volume(volume, fscache_volume_new_acquire);
+	fscache_stat(&fscache_n_volumes);
+	up_write(&fscache_addremove_sem);
+	_leave(" = v=%x", volume->debug_id);
+	return volume;
+
+err_vol:
+	kfree(volume);
+err_cache:
+	fscache_put_cache(cache, fscache_cache_put_alloc_volume);
+	fscache_stat(&fscache_n_volumes_nomem);
+	return NULL;
+}
+
+/*
+ * Create a volume's representation on disk.  Have a volume ref and a cache
+ * access we have to release.
+ */
+static void fscache_create_volume_work(struct work_struct *work)
+{
+	const struct fscache_cache_ops *ops;
+	struct fscache_volume *volume =
+		container_of(work, struct fscache_volume, work);
+
+	fscache_see_volume(volume, fscache_volume_see_create_work);
+
+	ops = volume->cache->ops;
+	if (ops->acquire_volume)
+		ops->acquire_volume(volume);
+	fscache_end_cache_access(volume->cache,
+				 fscache_access_acquire_volume_end);
+
+	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
+	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
+	fscache_put_volume(volume, fscache_volume_put_create_work);
+}
+
+/*
+ * Dispatch a worker thread to create a volume's representation on disk.
+ */
+void fscache_create_volume(struct fscache_volume *volume, bool wait)
+{
+	if (test_and_set_bit(FSCACHE_VOLUME_CREATING, &volume->flags))
+		goto maybe_wait;
+	if (volume->cache_priv)
+		goto no_wait; /* We raced */
+	if (!fscache_begin_cache_access(volume->cache,
+					fscache_access_acquire_volume))
+		goto no_wait;
+
+	fscache_get_volume(volume, fscache_volume_get_create_work);
+	if (!schedule_work(&volume->work))
+		fscache_put_volume(volume, fscache_volume_put_create_work);
+
+maybe_wait:
+	if (wait) {
+		fscache_see_volume(volume, fscache_volume_wait_create_work);
+		wait_on_bit(&volume->flags, FSCACHE_VOLUME_CREATING,
+			    TASK_UNINTERRUPTIBLE);
+	}
+	return;
+no_wait:
+	clear_bit_unlock(FSCACHE_VOLUME_CREATING, &volume->flags);
+	wake_up_bit(&volume->flags, FSCACHE_VOLUME_CREATING);
+}
+
+/*
+ * Acquire a volume representation cookie and link it to a (proposed) cache.
+ */
+struct fscache_volume *__fscache_acquire_volume(const char *volume_key,
+						const char *cache_name,
+						u64 coherency_data)
+{
+	struct fscache_volume *volume;
+
+	volume = fscache_alloc_volume(volume_key, cache_name, coherency_data);
+	if (!volume)
+		return NULL;
+
+	if (!fscache_hash_volume(volume)) {
+		fscache_put_volume(volume, fscache_volume_put_hash_collision);
+		return NULL;
+	}
+
+	fscache_create_volume(volume, false);
+	return volume;
+}
+EXPORT_SYMBOL(__fscache_acquire_volume);
+
+static void fscache_wake_pending_volume(struct fscache_volume *volume,
+					struct hlist_bl_head *h)
+{
+	struct fscache_volume *cursor;
+	struct hlist_bl_node *p;
+
+	hlist_bl_for_each_entry(cursor, p, h, hash_link) {
+		if (fscache_compare_volume(cursor, volume) == 0) {
+			fscache_see_volume(cursor, fscache_volume_see_hash_wake);
+			clear_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &cursor->flags);
+			wake_up_bit(&cursor->flags, FSCACHE_VOLUME_ACQUIRE_PENDING);
+			return;
+		}
+	}
+}
+
+/*
+ * Remove a volume cookie from the hash table.
+ */
+static void fscache_unhash_volume(struct fscache_volume *volume)
+{
+	struct hlist_bl_head *h;
+	unsigned int bucket;
+
+	bucket = volume->key_hash & (ARRAY_SIZE(fscache_volume_hash) - 1);
+	h = &fscache_volume_hash[bucket];
+
+	hlist_bl_lock(h);
+	hlist_bl_del(&volume->hash_link);
+	if (test_bit(FSCACHE_VOLUME_COLLIDED_WITH, &volume->flags))
+		fscache_wake_pending_volume(volume, h);
+	hlist_bl_unlock(h);
+}
+
+/*
+ * Drop a cache's volume attachments.
+ */
+static void fscache_free_volume(struct fscache_volume *volume)
+{
+	struct fscache_cache *cache = volume->cache;
+
+	if (volume->cache_priv) {
+		__fscache_begin_volume_access(volume, fscache_access_relinquish_volume);
+		if (volume->cache_priv) {
+			const struct fscache_cache_ops *ops = cache->ops;
+			if (ops->free_volume)
+				ops->free_volume(volume);
+		}
+		fscache_end_volume_access(volume, fscache_access_relinquish_volume_end);
+	}
+
+	down_write(&fscache_addremove_sem);
+	list_del_init(&volume->proc_link);
+	atomic_dec(&volume->cache->n_volumes);
+	up_write(&fscache_addremove_sem);
+
+	if (!hlist_bl_unhashed(&volume->hash_link))
+		fscache_unhash_volume(volume);
+
+	trace_fscache_volume(volume->debug_id, 0, fscache_volume_free);
+	kfree(volume->key);
+	kfree(volume);
+	fscache_stat_d(&fscache_n_volumes);
+	fscache_put_cache(cache, fscache_cache_put_volume);
+}
+
+/*
+ * Drop a reference to a volume cookie.
+ */
+void fscache_put_volume(struct fscache_volume *volume,
+			enum fscache_volume_trace where)
+{
+	if (volume) {
+		unsigned int debug_id = volume->debug_id;
+		bool zero;
+		int ref;
+
+		zero = __refcount_dec_and_test(&volume->ref, &ref);
+		trace_fscache_volume(debug_id, ref - 1, where);
+		if (zero)
+			fscache_free_volume(volume);
+	}
+}
+
+/*
+ * Relinquish a volume representation cookie.
+ */
+void __fscache_relinquish_volume(struct fscache_volume *volume,
+				 u64 coherency_data,
+				 bool invalidate)
+{
+	if (WARN_ON(test_and_set_bit(FSCACHE_VOLUME_RELINQUISHED, &volume->flags)))
+		return;
+
+	if (invalidate)
+		set_bit(FSCACHE_VOLUME_INVALIDATE, &volume->flags);
+
+	fscache_put_volume(volume, fscache_volume_put_relinquish);
+}
+EXPORT_SYMBOL(__fscache_relinquish_volume);
+
+#ifdef CONFIG_PROC_FS
+/*
+ * Generate a list of volumes in /proc/fs/fscache/volumes
+ */
+static int fscache_volumes_seq_show(struct seq_file *m, void *v)
+{
+	struct fscache_volume *volume;
+
+	if (v == &fscache_volumes) {
+		seq_puts(m,
+			 "VOLUME   REF   nCOOK ACC FL CACHE           KEY\n"
+			 "======== ===== ===== === == =============== ================\n");
+		return 0;
+	}
+
+	volume = list_entry(v, struct fscache_volume, proc_link);
+	seq_printf(m,
+		   "%08x %5d %5d %3d %02lx %-15.15s %s\n",
+		   volume->debug_id,
+		   refcount_read(&volume->ref),
+		   atomic_read(&volume->n_cookies),
+		   atomic_read(&volume->n_accesses),
+		   volume->flags,
+		   volume->cache->name ?: "-",
+		   volume->key + 1);
+	return 0;
+}
+
+static void *fscache_volumes_seq_start(struct seq_file *m, loff_t *_pos)
+	__acquires(&fscache_addremove_sem)
+{
+	down_read(&fscache_addremove_sem);
+	return seq_list_start_head(&fscache_volumes, *_pos);
+}
+
+static void *fscache_volumes_seq_next(struct seq_file *m, void *v, loff_t *_pos)
+{
+	return seq_list_next(v, &fscache_volumes, _pos);
+}
+
+static void fscache_volumes_seq_stop(struct seq_file *m, void *v)
+	__releases(&fscache_addremove_sem)
+{
+	up_read(&fscache_addremove_sem);
+}
+
+const struct seq_operations fscache_volumes_seq_ops = {
+	.start  = fscache_volumes_seq_start,
+	.next   = fscache_volumes_seq_next,
+	.stop   = fscache_volumes_seq_stop,
+	.show   = fscache_volumes_seq_show,
+};
+#endif /* CONFIG_PROC_FS */
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 90a7c92fca98..657e54b4cd90 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /* General filesystem caching backing cache interface
  *
- * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004-2007, 2021 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * NOTE!!! See:
@@ -15,64 +15,38 @@
 #define _LINUX_FSCACHE_CACHE_H
 
 #include <linux/fscache.h>
-#include <linux/sched.h>
-#include <linux/workqueue.h>
-
-#define NR_MAXCACHES BITS_PER_LONG
 
 struct fscache_cache;
 struct fscache_cache_ops;
-struct cachefiles_object;
+enum fscache_cache_trace;
 enum fscache_cookie_trace;
-
-enum fscache_obj_ref_trace {
-	fscache_obj_get_add_to_deps,
-	fscache_obj_get_queue,
-	fscache_obj_put_alloc_fail,
-	fscache_obj_put_attach_fail,
-	fscache_obj_put_drop_obj,
-	fscache_obj_put_enq_dep,
-	fscache_obj_put_queue,
-	fscache_obj_put_work,
-	fscache_obj_ref__nr_traces
-};
-
-/*
- * cache tag definition
- */
-struct fscache_cache_tag {
-	struct list_head	link;
-	struct fscache_cache	*cache;		/* cache referred to by this tag */
-	unsigned long		flags;
-#define FSCACHE_TAG_RESERVED	0		/* T if tag is reserved for a cache */
-	atomic_t		usage;		/* Number of using netfs's */
-	refcount_t		ref;		/* Reference count on structure */
-	char			name[];		/* tag name */
+enum fscache_access_trace;
+
+enum fscache_cache_state {
+	FSCACHE_CACHE_IS_NOT_PRESENT,	/* No cache is present for this name */
+	FSCACHE_CACHE_IS_PREPARING,	/* A cache is preparing to come live */
+	FSCACHE_CACHE_IS_ACTIVE,	/* Attached cache is active and can be used */
+	FSCACHE_CACHE_GOT_IOERROR,	/* Attached cache stopped on I/O error */
+	FSCACHE_CACHE_IS_WITHDRAWN,	/* Attached cache is being withdrawn */
+#define NR__FSCACHE_CACHE_STATE (FSCACHE_CACHE_IS_WITHDRAWN + 1)
 };
 
 /*
- * cache definition
+ * Cache cookie.
  */
 struct fscache_cache {
 	const struct fscache_cache_ops *ops;
-	struct fscache_cache_tag *tag;		/* tag representing this cache */
-	struct kobject		*kobj;		/* system representation of this cache */
-	struct list_head	link;		/* link in list of caches */
-	size_t			max_index_size;	/* maximum size of index data */
-	char			identifier[36];	/* cache label */
-
-	/* node management */
-	struct list_head	object_list;	/* list of data/index objects */
-	spinlock_t		object_list_lock;
+	struct list_head	cache_link;	/* Link in cache list */
+	void			*cache_priv;	/* Private cache data (or NULL) */
+	refcount_t		ref;
+	atomic_t		n_volumes;	/* Number of active volumes; */
+	atomic_t		n_accesses;	/* Number of in-progress accesses on the cache */
 	atomic_t		object_count;	/* no. of live objects in this cache */
-	struct cachefiles_object	*fsdef;		/* object for the fsdef index */
-	unsigned long		flags;
-#define FSCACHE_IOERROR		0	/* cache stopped on I/O error */
-#define FSCACHE_CACHE_WITHDRAWN	1	/* cache has been withdrawn */
+	unsigned int		debug_id;
+	enum fscache_cache_state state;
+	char			*name;
 };
 
-extern wait_queue_head_t fscache_cache_cleared_wq;
-
 /*
  * cache operations
  */
@@ -80,265 +54,79 @@ struct fscache_cache_ops {
 	/* name of cache provider */
 	const char *name;
 
-	/* allocate an object record for a cookie */
-	struct cachefiles_object *(*alloc_object)(struct fscache_cache *cache,
-					       struct fscache_cookie *cookie);
-
-	/* look up the object for a cookie
-	 * - return -ETIMEDOUT to be requeued
-	 */
-	int (*lookup_object)(struct cachefiles_object *object);
+	/* Acquire a volume */
+	void (*acquire_volume)(struct fscache_volume *volume);
 
-	/* finished looking up */
-	void (*lookup_complete)(struct cachefiles_object *object);
+	/* Free the cache's data attached to a volume */
+	void (*free_volume)(struct fscache_volume *volume);
 
-	/* increment the usage count on this object (may fail if unmounting) */
-	struct cachefiles_object *(*grab_object)(struct cachefiles_object *object,
-					      enum fscache_obj_ref_trace why);
+	/* Look up a cookie in the cache */
+	bool (*lookup_cookie)(struct fscache_cookie *cookie);
 
-	/* pin an object in the cache */
-	int (*pin_object)(struct cachefiles_object *object);
-
-	/* unpin an object in the cache */
-	void (*unpin_object)(struct cachefiles_object *object);
-
-	/* store the updated auxiliary data on an object */
-	void (*update_object)(struct cachefiles_object *object);
+	/* Withdraw an object without any cookie access counts held */
+	void (*withdraw_cookie)(struct fscache_cookie *cookie);
 
 	/* Invalidate an object */
-	void (*invalidate_object)(struct cachefiles_object *object);
-
-	/* discard the resources pinned by an object and effect retirement if
-	 * necessary */
-	void (*drop_object)(struct cachefiles_object *object);
-
-	/* dispose of a reference to an object */
-	void (*put_object)(struct cachefiles_object *object,
-			   enum fscache_obj_ref_trace why);
-
-	/* sync a cache */
-	void (*sync_cache)(struct fscache_cache *cache);
-
-	/* reserve space for an object's data and associated metadata */
-	int (*reserve_space)(struct cachefiles_object *object, loff_t i_size);
+	bool (*invalidate_cookie)(struct fscache_cookie *cookie,
+				  unsigned int flags);
 
 	/* Begin an operation for the netfs lib */
-	int (*begin_operation)(struct netfs_cache_resources *cres);
+	bool (*begin_operation)(struct netfs_cache_resources *cres,
+				enum fscache_want_stage want_stage);
 };
 
-extern struct fscache_cookie fscache_fsdef_index;
-
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
-	const struct fscache_state *(*work)(struct cachefiles_object *object,
-					    int event);
-	const struct fscache_transition transitions[];
-};
-
-/*
- * on-disk cache file or index handle
- */
-struct cachefiles_object {
-	const struct fscache_state *state;	/* Object state machine state */
-	const struct fscache_transition *oob_table; /* OOB state transition table */
-	int			debug_id;	/* debugging ID */
-	int			n_children;	/* number of child objects */
-	int			n_ops;		/* number of extant ops on object */
-	int			n_obj_ops;	/* number of object ops outstanding on object */
-	spinlock_t		lock;		/* state and operations lock */
-
-	unsigned long		lookup_jif;	/* time at which lookup started */
-	unsigned long		oob_event_mask;	/* OOB events this object is interested in */
-	unsigned long		event_mask;	/* events this object is interested in */
-	unsigned long		events;		/* events to be processed by this object
-						 * (order is important - using fls) */
-
-	unsigned long		flags;
-#define FSCACHE_OBJECT_LOCK		0	/* T if object is busy being processed */
-#define FSCACHE_OBJECT_WAITING		2	/* T if object is waiting on its parent */
-#define FSCACHE_OBJECT_IS_LIVE		3	/* T if object is not withdrawn or relinquished */
-#define FSCACHE_OBJECT_IS_LOOKED_UP	4	/* T if object has been looked up */
-#define FSCACHE_OBJECT_IS_AVAILABLE	5	/* T if object has become active */
-#define FSCACHE_OBJECT_RETIRED		6	/* T if object was retired on relinquishment */
-#define FSCACHE_OBJECT_KILLED_BY_CACHE	7	/* T if object was killed by the cache */
-#define FSCACHE_OBJECT_RUN_AFTER_DEAD	8	/* T if object has been dispatched after death */
-
-	struct list_head	cache_link;	/* link in cache->object_list */
-	struct hlist_node	cookie_link;	/* link in cookie->backing_objects */
-	struct fscache_cache	*cache;		/* cache that supplied this object */
-	struct fscache_cookie	*cookie;	/* netfs's file/index object */
-	struct cachefiles_object	*parent;	/* parent object */
-	struct work_struct	work;		/* attention scheduling record */
-	struct list_head	dependents;	/* FIFO of dependent objects */
-	struct list_head	dep_link;	/* link in parent's dependents list */
-
-	char				*d_name;	/* Filename */
-	struct file			*file;		/* The file representing this object */
-	loff_t				i_size;		/* object size */
-	atomic_t			usage;		/* object usage count */
-	uint8_t				type;		/* object type */
-	bool				new;		/* T if object new */
-	u8				d_name_len;	/* Length of filename */
-	u8				key_hash;
-};
-
-extern void fscache_object_init(struct cachefiles_object *, struct fscache_cookie *,
-				struct fscache_cache *);
-extern void fscache_object_destroy(struct cachefiles_object *);
-
-extern void fscache_object_lookup_negative(struct cachefiles_object *object);
-extern void fscache_obtained_object(struct cachefiles_object *object);
-
-static inline bool fscache_object_is_live(struct cachefiles_object *object)
+static inline enum fscache_cache_state fscache_cache_state(const struct fscache_cache *cache)
 {
-	return test_bit(FSCACHE_OBJECT_IS_LIVE, &object->flags);
+	return smp_load_acquire(&cache->state);
 }
 
-static inline bool fscache_object_is_dying(struct cachefiles_object *object)
+static inline bool fscache_cache_is_live(const struct fscache_cache *cache)
 {
-	return !fscache_object_is_live(object);
+	return fscache_cache_state(cache) == FSCACHE_CACHE_IS_ACTIVE;
 }
 
-static inline bool fscache_object_is_available(struct cachefiles_object *object)
+static inline void fscache_set_cache_state(struct fscache_cache *cache,
+					   enum fscache_cache_state new_state)
 {
-	return test_bit(FSCACHE_OBJECT_IS_AVAILABLE, &object->flags);
-}
+	smp_store_release(&cache->state, new_state);
 
-static inline bool fscache_cache_is_broken(struct cachefiles_object *object)
-{
-	return test_bit(FSCACHE_IOERROR, &object->cache->flags);
 }
 
-static inline bool fscache_object_is_active(struct cachefiles_object *object)
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
+static inline bool fscache_set_cache_state_maybe(struct fscache_cache *cache,
+						 enum fscache_cache_state old_state,
+						 enum fscache_cache_state new_state)
 {
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
-static inline void fscache_object_lookup_error(struct cachefiles_object *object)
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
-static inline bool fscache_use_cookie(struct cachefiles_object *object)
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
-static inline void fscache_unuse_cookie(struct cachefiles_object *object)
-{
-	struct fscache_cookie *cookie = object->cookie;
-	if (__fscache_unuse_cookie(cookie))
-		__fscache_wake_unused_cookie(cookie);
+	return try_cmpxchg_release(&cache->state, &old_state, new_state);
 }
 
 /*
  * out-of-line cache backend functions
  */
-extern __printf(3, 4)
-void fscache_init_cache(struct fscache_cache *cache,
-			const struct fscache_cache_ops *ops,
-			const char *idfmt, ...);
-
+extern struct rw_semaphore fscache_addremove_sem;
+extern struct fscache_cache *fscache_acquire_cache(const char *name);
 extern int fscache_add_cache(struct fscache_cache *cache,
-			     struct cachefiles_object *fsdef,
-			     const char *tagname);
+			     const struct fscache_cache_ops *ops,
+			     void *cache_priv);
+extern void fscache_put_cache(struct fscache_cache *cache,
+			      enum fscache_cache_trace where);
 extern void fscache_withdraw_cache(struct fscache_cache *cache);
+extern void fscache_withdraw_cookie(struct fscache_cookie *cookie);
 
 extern void fscache_io_error(struct fscache_cache *cache);
 
-extern bool fscache_object_sleep_till_congested(signed long *timeoutp);
-
-extern void fscache_object_retrying_stale(struct cachefiles_object *object);
-
-enum fscache_why_object_killed {
-	FSCACHE_OBJECT_IS_STALE,
-	FSCACHE_OBJECT_NO_SPACE,
-	FSCACHE_OBJECT_WAS_RETIRED,
-	FSCACHE_OBJECT_WAS_CULLED,
-};
-extern void fscache_object_mark_killed(struct cachefiles_object *object,
-				       enum fscache_why_object_killed why);
+extern void fscache_end_volume_access(struct fscache_volume *volume,
+				      enum fscache_access_trace why);
 
 extern struct fscache_cookie *fscache_get_cookie(struct fscache_cookie *cookie,
 						 enum fscache_cookie_trace where);
 extern void fscache_put_cookie(struct fscache_cookie *cookie,
 			       enum fscache_cookie_trace where);
+extern void fscache_end_cookie_access(struct fscache_cookie *cookie,
+				      enum fscache_access_trace why);
+extern void fscache_set_cookie_stage(struct fscache_cookie *cookie,
+				     enum fscache_cookie_stage stage);
+extern bool fscache_wait_for_operation(struct netfs_cache_resources *cred,
+				       enum fscache_want_stage stage);
 
 /*
  * Find the key on a cookie.
@@ -362,4 +150,47 @@ static inline void *fscache_get_aux(struct fscache_cookie *cookie)
 		return cookie->aux;
 }
 
+/**
+ * fscache_cookie_lookup_negative - Note negative lookup
+ * @cookie: The cookie that was being looked up
+ *
+ * Note that some part of the metadata path in the cache doesn't exist and so
+ * we can release any waiting readers in the certain knowledge that there's
+ * nothing for them to actually read.
+ */
+static inline void fscache_cookie_lookup_negative(struct fscache_cookie *cookie)
+{
+	set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
+	fscache_set_cookie_stage(cookie, FSCACHE_COOKIE_STAGE_CREATING);
+}
+
+static inline struct fscache_cookie *fscache_cres_cookie(struct netfs_cache_resources *cres)
+{
+	return cres->cache_priv;
+}
+
+/**
+ * fscache_end_operation - End an fscache I/O operation.
+ * @cres: The resources to dispose of.
+ */
+static inline
+void fscache_end_operation(struct netfs_cache_resources *cres)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	if (ops)
+		ops->end_operation(cres);
+}
+
+#ifdef CONFIG_FSCACHE_STATS
+extern atomic_t fscache_n_read;
+extern atomic_t fscache_n_write;
+#define fscache_count_read() atomic_inc(&fscache_n_read)
+#define fscache_count_write() atomic_inc(&fscache_n_write)
+#else
+#define fscache_count_read() do {} while(0)
+#define fscache_count_write() do {} while(0)
+#endif
+
+extern struct workqueue_struct *fscache_wq;
+
 #endif /* _LINUX_FSCACHE_CACHE_H */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 1dba014e848f..aeee14f5663a 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /* General filesystem caching interface
  *
- * Copyright (C) 2004-2007 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004-2007, 2021 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * NOTE!!! See:
@@ -23,76 +23,110 @@
 #include <linux/netfs.h>
 
 #if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
+#define __fscache_available (1)
 #define fscache_available() (1)
+#define fscache_volume_valid(volume) (volume)
 #define fscache_cookie_valid(cookie) (cookie)
 #define fscache_resources_valid(cres) ((cres)->cache_priv)
 #else
+#define __fscache_available (0)
 #define fscache_available() (0)
+#define fscache_volume_valid(volume) (0)
 #define fscache_cookie_valid(cookie) (0)
 #define fscache_resources_valid(cres) (false)
 #endif
 
-struct fscache_cache_tag;
 struct fscache_cookie;
-struct fscache_netfs;
-struct netfs_read_request;
 
-enum fscache_cookie_type {
-	FSCACHE_COOKIE_TYPE_INDEX,
-	FSCACHE_COOKIE_TYPE_DATAFILE,
+#define FSCACHE_ADV_SINGLE_CHUNK	0x01 /* The object is a single chunk of data */
+#define FSCACHE_ADV_WRITE_CACHE		0x00 /* Do cache if written to locally */
+#define FSCACHE_ADV_WRITE_NOCACHE	0x02 /* Don't cache if written to locally */
+#define FSCACHE_ADV_FALLBACK_IO		0x04 /* Going to use the fallback I/O API (dangerous) */
+
+enum fscache_want_stage {
+	FSCACHE_WANT_PARAMS,
+	FSCACHE_WANT_WRITE,
+	FSCACHE_WANT_READ,
 };
 
-#define FSCACHE_ADV_SINGLE_CHUNK	0x01 /* The object is a single chunk of data */
+/*
+ * Data object state.
+ */
+enum fscache_cookie_stage {
+	FSCACHE_COOKIE_STAGE_QUIESCENT,		/* The cookie is uncached */
+	FSCACHE_COOKIE_STAGE_LOOKING_UP,	/* The cache object is being looked up */
+	FSCACHE_COOKIE_STAGE_CREATING,		/* The cache object is being created */
+	FSCACHE_COOKIE_STAGE_ACTIVE,		/* The cache is active, readable and writable */
+	FSCACHE_COOKIE_STAGE_INVALIDATING,	/* The cache is being invalidated */
+	FSCACHE_COOKIE_STAGE_FAILED,		/* The cache failed, withdraw to clear */
+	FSCACHE_COOKIE_STAGE_WITHDRAWING,	/* The cookie is being withdrawn */
+	FSCACHE_COOKIE_STAGE_RELINQUISHING,	/* The cookie is being relinquished */
+	FSCACHE_COOKIE_STAGE_DROPPED,		/* The cookie has been dropped */
+#define FSCACHE_COOKIE_STAGE__NR (FSCACHE_COOKIE_STAGE_DROPPED + 1)
+} __attribute__((mode(byte)));
 
 /*
- * fscache cached network filesystem type
- * - name, version and ops must be filled in before registration
- * - all other fields will be set during registration
+ * Volume representation cookie.
  */
-struct fscache_netfs {
-	uint32_t			version;	/* indexing version */
-	const char			*name;		/* filesystem name */
-	struct fscache_cookie		*primary_index;
+struct fscache_volume {
+	refcount_t			ref;
+	atomic_t			n_cookies;	/* Number of data cookies in volume */
+	atomic_t			n_accesses;	/* Number of cache accesses in progress */
+	unsigned int			debug_id;
+	unsigned int			key_hash;	/* Hash of key string */
+	char				*key;		/* Volume ID, eg. "afs@example.com@1234" */
+	struct list_head		proc_link;	/* Link in /proc/fs/fscache/volumes */
+	struct hlist_bl_node		hash_link;	/* Link in hash table */
+	struct work_struct		work;
+	struct fscache_cache		*cache;		/* The cache in which this resides */
+	void				*cache_priv;	/* Cache private data */
+	u64				coherency;	/* Coherency data */
+	spinlock_t			lock;
+	unsigned long			flags;
+#define FSCACHE_VOLUME_RELINQUISHED	0	/* Volume is being cleaned up */
+#define FSCACHE_VOLUME_INVALIDATE	1	/* Volume was invalidated */
+#define FSCACHE_VOLUME_COLLIDED_WITH	2	/* Volume was collided with */
+#define FSCACHE_VOLUME_ACQUIRE_PENDING	3	/* Volume is waiting to complete acquisition */
+#define FSCACHE_VOLUME_CREATING		4	/* Volume is being created on disk */
 };
 
 /*
- * data file or index object cookie
+ * Data file representation cookie.
  * - a file will only appear in one cache
  * - a request to cache a file may or may not be honoured, subject to
  *   constraints such as disk space
  * - indices are created on disk just-in-time
  */
 struct fscache_cookie {
-	refcount_t			ref;		/* number of users of this cookie */
-	atomic_t			n_children;	/* number of children of this cookie */
-	atomic_t			n_active;	/* number of active users of netfs ptrs */
+	refcount_t			ref;
+	atomic_t			n_active;	/* number of active users of cookie */
+	atomic_t			n_accesses;	/* Number of cache accesses in progress */
 	unsigned int			debug_id;
+	unsigned int			inval_counter;	/* Number of invalidations made */
 	spinlock_t			lock;
-	struct hlist_head		backing_objects; /* object(s) backing this file/index */
-	struct fscache_cookie		*parent;	/* parent of this entry */
-	struct fscache_cache_tag	*preferred_cache; /* The preferred cache or NULL */
+	struct fscache_volume		*volume;	/* Parent volume of this file. */
+	void				*cache_priv;	/* Cache-side representation */
 	struct hlist_bl_node		hash_link;	/* Link in hash table */
 	struct list_head		proc_link;	/* Link in proc list */
-	char				type_name[8];	/* Cookie type name */
+	struct work_struct		work;		/* Commit/relinq/withdraw work */
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
-
-	enum fscache_cookie_type	type:8;
-	u8				advice;		/* FSCACHE_COOKIE_ADV_* */
+#define FSCACHE_COOKIE_RELINQUISHED	0		/* T if cookie has been relinquished */
+#define FSCACHE_COOKIE_RETIRED		1		/* T if this cookie has retired on relinq */
+#define FSCACHE_COOKIE_IS_CACHING	2		/* T if this cookie is cached */
+#define FSCACHE_COOKIE_NO_DATA_TO_READ	3		/* T if this cookie has nothing to read */
+#define FSCACHE_COOKIE_NEEDS_UPDATE	4		/* T if attrs have been updated */
+#define FSCACHE_COOKIE_HAS_BEEN_CACHED	5		/* T if cookie needs withdraw-on-relinq */
+#define FSCACHE_COOKIE_NACC_ELEVATED	8		/* T if n_accesses is incremented */
+#define FSCACHE_COOKIE_DO_RELINQUISH	9		/* T if this cookie needs relinquishment */
+#define FSCACHE_COOKIE_DO_WITHDRAW	10		/* T if this cookie needs withdrawing */
+
+	enum fscache_cookie_stage	stage;
+	u8				advice;		/* FSCACHE_ADV_* */
 	u8				key_len;	/* Length of index key */
 	u8				aux_len;	/* Length of auxiliary data */
-	u32				key_hash;	/* Hash of parent, type, key, len */
+	u32				key_hash;	/* Hash of volume, key, len */
 	union {
 		void			*key;		/* Index key */
 		u8			inline_key[16];	/* - If the key is short enough */
@@ -103,12 +137,6 @@ struct fscache_cookie {
 	};
 };
 
-static inline bool fscache_cookie_enabled(struct fscache_cookie *cookie)
-{
-	return (fscache_cookie_valid(cookie) &&
-		test_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags));
-}
-
 /*
  * slow-path functions for when there is actually caching available, and the
  * netfs does actually have a valid token
@@ -116,195 +144,172 @@ static inline bool fscache_cookie_enabled(struct fscache_cookie *cookie)
  * - these are undefined symbols when FS-Cache is not configured and the
  *   optimiser takes care of not using them
  */
-extern int __fscache_register_netfs(struct fscache_netfs *);
-extern void __fscache_unregister_netfs(struct fscache_netfs *);
-extern struct fscache_cache_tag *__fscache_lookup_cache_tag(const char *);
-extern void __fscache_release_cache_tag(struct fscache_cache_tag *);
+extern struct fscache_volume *__fscache_acquire_volume(const char *, const char *, u64);
+extern void __fscache_relinquish_volume(struct fscache_volume *, u64, bool);
 
 extern struct fscache_cookie *__fscache_acquire_cookie(
-	struct fscache_cookie *,
-	enum fscache_cookie_type,
-	const char *,
+	struct fscache_volume *,
 	u8,
-	struct fscache_cache_tag *,
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
 #ifdef FSCACHE_USE_NEW_IO_API
-extern int __fscache_begin_operation(struct netfs_cache_resources *, struct fscache_cookie *,
-				     bool);
+extern int __fscache_begin_read_operation(struct netfs_cache_resources *, struct fscache_cookie *);
 #endif
 #ifdef FSCACHE_USE_FALLBACK_IO_API
 extern int __fscache_fallback_read_page(struct fscache_cookie *, struct page *);
 extern int __fscache_fallback_write_page(struct fscache_cookie *, struct page *);
 #endif
-extern void __fscache_disable_cookie(struct fscache_cookie *, const void *, bool);
-extern void __fscache_enable_cookie(struct fscache_cookie *, const void *, loff_t,
-				    bool (*)(void *), void *);
 
 /**
- * fscache_register_netfs - Register a filesystem as desiring caching services
- * @netfs: The description of the filesystem
- *
- * Register a filesystem as desiring caching services if they're available.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
+ * fscache_acquire_volume - Register a volume as desiring caching services
+ * @volume_key: An identification string for the volume
+ * @cache_name: The name of the cache to use (or NULL for the default)
+ * @coherency_data: Piece of arbitrary coherency data to check
+ *
+ * Register a volume as desiring caching services if they're available.  The
+ * caller must provide an identifier for the volume and may also indicate which
+ * cache it should be in.  If a preexisting volume entry is found in the cache,
+ * the coherency data must match otherwise the entry will be invalidated.
  */
 static inline
-int fscache_register_netfs(struct fscache_netfs *netfs)
+struct fscache_volume *fscache_acquire_volume(const char *volume_key,
+					      const char *cache_name,
+					      u64 coherency_data)
 {
-	if (fscache_available())
-		return __fscache_register_netfs(netfs);
-	else
-		return 0;
+	if (!fscache_available())
+		return NULL;
+	return __fscache_acquire_volume(volume_key, cache_name, coherency_data);
 }
 
 /**
- * fscache_unregister_netfs - Indicate that a filesystem no longer desires
- * caching services
- * @netfs: The description of the filesystem
- *
- * Indicate that a filesystem no longer desires caching services for the
- * moment.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
+ * fscache_relinquish_volume - Cease caching a volume
+ * @volume: The volume cookie
+ * @coherency_data: Piece of arbitrary coherency data to set
+ * @invalidate: True if the volume should be invalidated
+ *
+ * Indicate that a filesystem no longer desires caching services for a volume.
+ * The caller must have relinquished all file cookies prior to calling this.
+ * The coherency data stored is updated.
  */
 static inline
-void fscache_unregister_netfs(struct fscache_netfs *netfs)
+void fscache_relinquish_volume(struct fscache_volume *volume,
+			       u64 coherency_data,
+			       bool invalidate)
 {
-	if (fscache_available())
-		__fscache_unregister_netfs(netfs);
+	if (fscache_volume_valid(volume))
+		__fscache_relinquish_volume(volume, coherency_data, invalidate);
 }
 
 /**
- * fscache_lookup_cache_tag - Look up a cache tag
- * @name: The name of the tag to search for
+ * fscache_acquire_cookie - Acquire a cookie to represent a cache object
+ * @volume: The volume in which to locate/create this cookie
+ * @advice: Advice flags (FSCACHE_COOKIE_ADV_*)
+ * @index_key: The index key for this cookie
+ * @index_key_len: Size of the index key
+ * @aux_data: The auxiliary data for the cookie (may be NULL)
+ * @aux_data_len: Size of the auxiliary data buffer
+ * @object_size: The initial size of object
  *
- * Acquire a specific cache referral tag that can be used to select a specific
- * cache in which to cache an index.
+ * Acquire a cookie to represent a data file within the given cache volume.
  *
  * See Documentation/filesystems/caching/netfs-api.rst for a complete
  * description.
  */
 static inline
-struct fscache_cache_tag *fscache_lookup_cache_tag(const char *name)
+struct fscache_cookie *fscache_acquire_cookie(struct fscache_volume *volume,
+					      u8 advice,
+					      const void *index_key,
+					      size_t index_key_len,
+					      const void *aux_data,
+					      size_t aux_data_len,
+					      loff_t object_size)
 {
-	if (fscache_available())
-		return __fscache_lookup_cache_tag(name);
-	else
+	if (!fscache_volume_valid(volume))
 		return NULL;
+	return __fscache_acquire_cookie(volume, advice,
+					index_key, index_key_len,
+					aux_data, aux_data_len,
+					object_size);
 }
 
 /**
- * fscache_release_cache_tag - Release a cache tag
- * @tag: The tag to release
+ * fscache_use_cookie - Request usage of cookie attached to an object
+ * @object: Object description
+ * @will_modify: If cache is expected to be modified locally
  *
- * Release a reference to a cache referral tag previously looked up.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
+ * Request usage of the cookie attached to an object.  The caller should tell
+ * the cache if the object's contents are about to be modified locally and then
+ * the cache can apply the policy that has been set to handle this case.
  */
-static inline
-void fscache_release_cache_tag(struct fscache_cache_tag *tag)
+static inline void fscache_use_cookie(struct fscache_cookie *cookie,
+				      bool will_modify)
 {
-	if (fscache_available())
-		__fscache_release_cache_tag(tag);
+	if (fscache_cookie_valid(cookie))
+		__fscache_use_cookie(cookie, will_modify);
 }
 
 /**
- * fscache_acquire_cookie - Acquire a cookie to represent a cache object
- * @parent: The cookie that's to be the parent of this one
- * @type: Type of the cookie
- * @type_name: Name of cookie type (max 7 chars)
- * @advice: Advice flags (FSCACHE_COOKIE_ADV_*)
- * @preferred_cache: The cache to use (or NULL)
- * @index_key: The index key for this cookie
- * @index_key_len: Size of the index key
- * @aux_data: The auxiliary data for the cookie (may be NULL)
- * @aux_data_len: Size of the auxiliary data buffer
- * @netfs_data: An arbitrary piece of data to be kept in the cookie to
- * represent the cache object to the netfs
- * @object_size: The initial size of object
- * @enable: Whether or not to enable a data cookie immediately
+ * fscache_unuse_cookie - Cease usage of cookie attached to an object
+ * @object: Object description
+ * @aux_data: Updated auxiliary data (or NULL)
+ * @object_size: Revised size of the object (or NULL)
  *
- * This function is used to inform FS-Cache about part of an index hierarchy
- * that can be used to locate files.  This is done by requesting a cookie for
- * each index in the path to the file.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
+ * Cease usage of the cookie attached to an object.  When the users count
+ * reaches zero then the cookie relinquishment will be permitted to proceed.
  */
-static inline
-struct fscache_cookie *fscache_acquire_cookie(
-	struct fscache_cookie *parent,
-	enum fscache_cookie_type type,
-	const char *type_name,
-	u8 advice,
-	struct fscache_cache_tag *preferred_cache,
-	const void *index_key,
-	size_t index_key_len,
-	const void *aux_data,
-	size_t aux_data_len,
-	loff_t object_size,
-	bool enable)
+static inline void fscache_unuse_cookie(struct fscache_cookie *cookie,
+					const void *aux_data,
+					const loff_t *object_size)
 {
-	if (fscache_cookie_valid(parent) && fscache_cookie_enabled(parent))
-		return __fscache_acquire_cookie(parent, type, type_name, advice,
-						preferred_cache,
-						index_key, index_key_len,
-						aux_data, aux_data_len,
-						object_size, enable);
-	else
-		return NULL;
+	if (fscache_cookie_valid(cookie))
+		__fscache_unuse_cookie(cookie, aux_data, object_size);
 }
 
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
@@ -352,24 +357,20 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
 static inline
 void fscache_invalidate(struct fscache_cookie *cookie)
 {
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
+	if (fscache_cookie_valid(cookie))
 		__fscache_invalidate(cookie);
 }
 
 /**
- * fscache_wait_on_invalidate - Wait for invalidation to complete
- * @cookie: The cookie representing the cache object
- *
- * Wait for the invalidation of an object to complete.
+ * fscache_operation_valid - Return true if operations resources are usable
+ * @cres: The resources to check.
  *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
+ * Returns a pointer to the operations table if usable or NULL if not.
  */
 static inline
-void fscache_wait_on_invalidate(struct fscache_cookie *cookie)
+const struct netfs_cache_ops *fscache_operation_valid(const struct netfs_cache_resources *cres)
 {
-	if (fscache_cookie_valid(cookie))
-		__fscache_wait_on_invalidate(cookie);
+	return fscache_resources_valid(cres) ? cres->ops : NULL;
 }
 
 #ifdef FSCACHE_USE_NEW_IO_API
@@ -395,23 +396,11 @@ static inline
 int fscache_begin_read_operation(struct netfs_cache_resources *cres,
 				 struct fscache_cookie *cookie)
 {
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		return __fscache_begin_operation(cres, cookie, false);
+	if (fscache_cookie_valid(cookie))
+		return __fscache_begin_read_operation(cres, cookie);
 	return -ENOBUFS;
 }
 
-/**
- * fscache_operation_valid - Return true if operations resources are usable
- * @cres: The resources to check.
- *
- * Returns a pointer to the operations table if usable or NULL if not.
- */
-static inline
-const struct netfs_cache_ops *fscache_operation_valid(const struct netfs_cache_resources *cres)
-{
-	return fscache_resources_valid(cres) ? cres->ops : NULL;
-}
-
 /**
  * fscache_read - Start a read from the cache.
  * @cres: The cache resources to use
@@ -478,60 +467,6 @@ int fscache_write(struct netfs_cache_resources *cres,
 
 #endif /* FSCACHE_USE_NEW_IO_API */
 
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
-}
-
 #ifdef FSCACHE_USE_FALLBACK_IO_API
 
 /**
@@ -549,7 +484,7 @@ void fscache_enable_cookie(struct fscache_cookie *cookie,
 static inline
 int fscache_fallback_read_page(struct fscache_cookie *cookie, struct page *page)
 {
-	if (fscache_cookie_enabled(cookie))
+	if (fscache_cookie_valid(cookie))
 		return __fscache_fallback_read_page(cookie, page);
 	return -ENOBUFS;
 }
@@ -569,7 +504,7 @@ int fscache_fallback_read_page(struct fscache_cookie *cookie, struct page *page)
 static inline
 int fscache_fallback_write_page(struct fscache_cookie *cookie, struct page *page)
 {
-	if (fscache_cookie_enabled(cookie))
+	if (fscache_cookie_valid(cookie))
 		return __fscache_fallback_write_page(cookie, page);
 	return -ENOBUFS;
 }
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 47df44550ad6..d98adabce92e 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -19,9 +19,25 @@
 #define __CACHEFILES_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
 enum cachefiles_obj_ref_trace {
-	cachefiles_obj_put_wait_retry = fscache_obj_ref__nr_traces,
-	cachefiles_obj_put_wait_timeo,
-	cachefiles_obj_ref__nr_traces
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
+	FSCACHE_OBJECT_NO_SPACE,
+	FSCACHE_OBJECT_WAS_RETIRED,
+	FSCACHE_OBJECT_WAS_CULLED,
 };
 
 enum cachefiles_coherency_trace {
@@ -40,6 +56,8 @@ enum cachefiles_coherency_trace {
 enum cachefiles_trunc_trace {
 	cachefiles_trunc_invalidate,
 	cachefiles_trunc_set_size,
+	cachefiles_trunc_dio_adjust,
+	cachefiles_trunc_shrink,
 };
 
 #endif
@@ -54,16 +72,18 @@ enum cachefiles_trunc_trace {
 	E_(FSCACHE_OBJECT_WAS_CULLED,	"was_culled")
 
 #define cachefiles_obj_ref_traces					\
-	EM(fscache_obj_get_add_to_deps,		"GET add_to_deps")	\
-	EM(fscache_obj_get_queue,		"GET queue")		\
-	EM(fscache_obj_put_alloc_fail,		"PUT alloc_fail")	\
-	EM(fscache_obj_put_attach_fail,		"PUT attach_fail")	\
-	EM(fscache_obj_put_drop_obj,		"PUT drop_obj")		\
-	EM(fscache_obj_put_enq_dep,		"PUT enq_dep")		\
-	EM(fscache_obj_put_queue,		"PUT queue")		\
-	EM(fscache_obj_put_work,		"PUT work")		\
-	EM(cachefiles_obj_put_wait_retry,	"PUT wait_retry")	\
-	E_(cachefiles_obj_put_wait_timeo,	"PUT wait_timeo")
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
 
 #define cachefiles_coherency_traces					\
 	EM(cachefiles_coherency_check_aux,	"BAD aux ")		\
@@ -79,7 +99,9 @@ enum cachefiles_trunc_trace {
 
 #define cachefiles_trunc_traces						\
 	EM(cachefiles_trunc_invalidate,		"INVAL ")		\
-	E_(cachefiles_trunc_set_size,		"SETSIZ")
+	EM(cachefiles_trunc_set_size,		"SETSIZ")		\
+	EM(cachefiles_trunc_dio_adjust,		"DIOADJ")		\
+	E_(cachefiles_trunc_shrink,		"SHRINK")
 
 /*
  * Export enum symbols via userspace.
@@ -105,12 +127,12 @@ cachefiles_trunc_traces;
 
 
 TRACE_EVENT(cachefiles_ref,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct fscache_cookie *cookie,
-		     enum cachefiles_obj_ref_trace why,
-		     int usage),
+	    TP_PROTO(unsigned int object_debug_id,
+		     unsigned int cookie_debug_id,
+		     int usage,
+		     enum cachefiles_obj_ref_trace why),
 
-	    TP_ARGS(obj, cookie, why, usage),
+	    TP_ARGS(object_debug_id, cookie_debug_id, usage, why),
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
@@ -121,8 +143,8 @@ TRACE_EVENT(cachefiles_ref,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj->debug_id;
-		    __entry->cookie	= cookie->debug_id;
+		    __entry->obj	= object_debug_id;
+		    __entry->cookie	= cookie_debug_id;
 		    __entry->usage	= usage;
 		    __entry->why	= why;
 			   ),
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 412f016f6975..0d9789745a91 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -19,18 +19,76 @@
 #ifndef __FSCACHE_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __FSCACHE_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
+enum fscache_cache_trace {
+	fscache_cache_collision,
+	fscache_cache_get_acquire,
+	fscache_cache_new_acquire,
+	fscache_cache_put_alloc_volume,
+	fscache_cache_put_cache,
+	fscache_cache_put_volume,
+	fscache_cache_put_withdraw,
+};
+
+enum fscache_volume_trace {
+	fscache_volume_collision,
+	fscache_volume_get_cookie,
+	fscache_volume_get_create_work,
+	fscache_volume_get_hash_collision,
+	fscache_volume_free,
+	fscache_volume_new_acquire,
+	fscache_volume_put_cookie,
+	fscache_volume_put_create_work,
+	fscache_volume_put_hash_collision,
+	fscache_volume_put_relinquish,
+	fscache_volume_see_create_work,
+	fscache_volume_see_hash_wake,
+	fscache_volume_wait_create_work,
+};
+
 enum fscache_cookie_trace {
 	fscache_cookie_collision,
 	fscache_cookie_discard,
-	fscache_cookie_get_acquire_parent,
 	fscache_cookie_get_attach_object,
-	fscache_cookie_get_reacquire,
-	fscache_cookie_get_register_netfs,
-	fscache_cookie_put_acquire_nobufs,
-	fscache_cookie_put_dup_netfs,
-	fscache_cookie_put_relinquish,
+	fscache_cookie_get_end_access,
+	fscache_cookie_get_hash_collision,
+	fscache_cookie_get_inval_work,
+	fscache_cookie_get_use_work,
+	fscache_cookie_get_withdraw,
+	fscache_cookie_new_acquire,
+	fscache_cookie_put_hash_collision,
 	fscache_cookie_put_object,
-	fscache_cookie_put_parent,
+	fscache_cookie_put_over_queued,
+	fscache_cookie_put_relinquish,
+	fscache_cookie_put_withdrawn,
+	fscache_cookie_put_work,
+	fscache_cookie_see_active,
+	fscache_cookie_see_relinquish,
+	fscache_cookie_see_withdraw,
+	fscache_cookie_see_work,
+};
+
+enum fscache_access_trace {
+	fscache_access_acquire_volume,
+	fscache_access_acquire_volume_end,
+	fscache_access_cache_pin,
+	fscache_access_cache_unpin,
+	fscache_access_invalidate_cookie,
+	fscache_access_invalidate_cookie_end,
+	fscache_access_io_end,
+	fscache_access_io_no_data_yet,
+	fscache_access_io_not_live,
+	fscache_access_io_read,
+	fscache_access_io_resize,
+	fscache_access_io_wait,
+	fscache_access_io_write,
+	fscache_access_lookup_cookie,
+	fscache_access_lookup_cookie_end,
+	fscache_access_relinquish_cookie,
+	fscache_access_relinquish_cookie_end,
+	fscache_access_relinquish_defer,
+	fscache_access_relinquish_volume,
+	fscache_access_relinquish_volume_end,
+	fscache_access_unlive,
 };
 
 #endif
@@ -38,18 +96,73 @@ enum fscache_cookie_trace {
 /*
  * Declare tracing information enums and their string mappings for display.
  */
+#define fscache_cache_traces						\
+	EM(fscache_cache_collision,		"*COLLIDE*")		\
+	EM(fscache_cache_get_acquire,		"GET acq  ")		\
+	EM(fscache_cache_new_acquire,		"NEW acq  ")		\
+	EM(fscache_cache_put_alloc_volume,	"PUT alvol")		\
+	EM(fscache_cache_put_cache,		"PUT cache")		\
+	EM(fscache_cache_put_volume,		"PUT vol  ")		\
+	E_(fscache_cache_put_withdraw,		"PUT withd")
+
+#define fscache_volume_traces						\
+	EM(fscache_volume_collision,		"*COLLIDE*")		\
+	EM(fscache_volume_get_cookie,		"GET cook ")		\
+	EM(fscache_volume_get_create_work,	"GET creat")		\
+	EM(fscache_volume_get_hash_collision,	"GET hcoll")		\
+	EM(fscache_volume_free,			"FREE     ")		\
+	EM(fscache_volume_new_acquire,		"NEW acq  ")		\
+	EM(fscache_volume_put_cookie,		"PUT cook ")		\
+	EM(fscache_volume_put_create_work,	"PUT creat")		\
+	EM(fscache_volume_put_hash_collision,	"PUT hcoll")		\
+	EM(fscache_volume_put_relinquish,	"PUT relnq")		\
+	EM(fscache_volume_see_create_work,	"SEE creat")		\
+	EM(fscache_volume_see_hash_wake,	"SEE hwake")		\
+	E_(fscache_volume_wait_create_work,	"WAIT crea")
+
 #define fscache_cookie_traces						\
-	EM(fscache_cookie_collision,		"*COLLISION*")		\
-	EM(fscache_cookie_discard,		"DISCARD")		\
-	EM(fscache_cookie_get_acquire_parent,	"GET prn")		\
-	EM(fscache_cookie_get_attach_object,	"GET obj")		\
-	EM(fscache_cookie_get_reacquire,	"GET raq")		\
-	EM(fscache_cookie_get_register_netfs,	"GET net")		\
-	EM(fscache_cookie_put_acquire_nobufs,	"PUT nbf")		\
-	EM(fscache_cookie_put_dup_netfs,	"PUT dnt")		\
-	EM(fscache_cookie_put_relinquish,	"PUT rlq")		\
-	EM(fscache_cookie_put_object,		"PUT obj")		\
-	E_(fscache_cookie_put_parent,		"PUT prn")
+	EM(fscache_cookie_collision,		"*COLLIDE*")		\
+	EM(fscache_cookie_discard,		"DISCARD  ")		\
+	EM(fscache_cookie_get_attach_object,	"GET attch")		\
+	EM(fscache_cookie_get_hash_collision,	"GET hcoll")		\
+	EM(fscache_cookie_get_end_access,	"GQ  endac")		\
+	EM(fscache_cookie_get_inval_work,	"GQ  inval")		\
+	EM(fscache_cookie_get_use_work,		"GQ  use  ")		\
+	EM(fscache_cookie_get_withdraw,		"GQ  wthdr")		\
+	EM(fscache_cookie_new_acquire,		"NEW acq  ")		\
+	EM(fscache_cookie_put_hash_collision,	"PUT hcoll")		\
+	EM(fscache_cookie_put_object,		"PUT obj  ")		\
+	EM(fscache_cookie_put_over_queued,	"PQ  overq")		\
+	EM(fscache_cookie_put_relinquish,	"PUT relnq")		\
+	EM(fscache_cookie_put_withdrawn,	"PUT wthdn")		\
+	EM(fscache_cookie_put_work,		"PQ  work ")		\
+	EM(fscache_cookie_see_active,		"-   active")		\
+	EM(fscache_cookie_see_relinquish,	"-   x-rlq")		\
+	EM(fscache_cookie_see_withdraw,		"-   x-wth")		\
+	E_(fscache_cookie_see_work,		"-   work ")
+
+#define fscache_access_traces		\
+	EM(fscache_access_acquire_volume,	"BEGIN acq_vol")	\
+	EM(fscache_access_acquire_volume_end,	"END   acq_vol")	\
+	EM(fscache_access_cache_pin,		"PIN   cache  ")	\
+	EM(fscache_access_cache_unpin,		"UNPIN cache  ")	\
+	EM(fscache_access_invalidate_cookie,	"BEGIN inval  ")	\
+	EM(fscache_access_invalidate_cookie_end,"END   inval  ")	\
+	EM(fscache_access_io_end,		"END   io     ")	\
+	EM(fscache_access_io_no_data_yet,	"END   io_nody")	\
+	EM(fscache_access_io_not_live,		"END   io_notl")	\
+	EM(fscache_access_io_read,		"BEGIN io_read")	\
+	EM(fscache_access_io_resize,		"BEGIN io_resz")	\
+	EM(fscache_access_io_wait,		"WAIT  io    ")		\
+	EM(fscache_access_io_write,		"BEGIN io_writ")	\
+	EM(fscache_access_lookup_cookie,	"BEGIN lookup ")	\
+	EM(fscache_access_lookup_cookie_end,	"END   lookup ")	\
+	EM(fscache_access_relinquish_cookie,	"BEGIN relinq ")	\
+	EM(fscache_access_relinquish_cookie_end,"END   relinq ")	\
+	EM(fscache_access_relinquish_defer,	"DEFER relinq ")	\
+	EM(fscache_access_relinquish_volume,	"BEGIN rlq_vol")	\
+	EM(fscache_access_relinquish_volume_end,"END   rlq_vol")	\
+	E_(fscache_access_unlive,		"END   unlive ")
 
 /*
  * Export enum symbols via userspace.
@@ -59,7 +172,10 @@ enum fscache_cookie_trace {
 #define EM(a, b) TRACE_DEFINE_ENUM(a);
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 
+fscache_cache_traces;
+fscache_volume_traces;
 fscache_cookie_traces;
+fscache_access_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -71,6 +187,56 @@ fscache_cookie_traces;
 #define E_(a, b)	{ a, b }
 
 
+TRACE_EVENT(fscache_cache,
+	    TP_PROTO(unsigned int cache_debug_id,
+		     int usage,
+		     enum fscache_cache_trace where),
+
+	    TP_ARGS(cache_debug_id, usage, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		cache		)
+		    __field(int,			usage		)
+		    __field(enum fscache_cache_trace,	where		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->cache	= cache_debug_id;
+		    __entry->usage	= usage;
+		    __entry->where	= where;
+			   ),
+
+	    TP_printk("C=%08x %s r=%d",
+		      __entry->cache,
+		      __print_symbolic(__entry->where, fscache_cache_traces),
+		      __entry->usage)
+	    );
+
+TRACE_EVENT(fscache_volume,
+	    TP_PROTO(unsigned int volume_debug_id,
+		     int usage,
+		     enum fscache_volume_trace where),
+
+	    TP_ARGS(volume_debug_id, usage, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		volume		)
+		    __field(int,			usage		)
+		    __field(enum fscache_volume_trace,	where		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->volume	= volume_debug_id;
+		    __entry->usage	= usage;
+		    __entry->where	= where;
+			   ),
+
+	    TP_printk("V=%08x %s u=%d",
+		      __entry->volume,
+		      __print_symbolic(__entry->where, fscache_volume_traces),
+		      __entry->usage)
+	    );
+
 TRACE_EVENT(fscache_cookie,
 	    TP_PROTO(unsigned int cookie_debug_id,
 		     int ref,
@@ -80,189 +246,160 @@ TRACE_EVENT(fscache_cookie,
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		cookie		)
-		    __field(enum fscache_cookie_trace,	where		)
 		    __field(int,			ref		)
+		    __field(enum fscache_cookie_trace,	where		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->cookie	= cookie_debug_id;
-		    __entry->where	= where;
 		    __entry->ref	= ref;
+		    __entry->where	= where;
 			   ),
 
-	    TP_printk("%s c=%08x r=%d",
+	    TP_printk("c=%08x %s r=%d",
+		      __entry->cookie,
 		      __print_symbolic(__entry->where, fscache_cookie_traces),
-		      __entry->cookie, __entry->ref)
+		      __entry->ref)
 	    );
 
-TRACE_EVENT(fscache_netfs,
-	    TP_PROTO(struct fscache_netfs *netfs),
+TRACE_EVENT(fscache_access_cache,
+	    TP_PROTO(unsigned int cache_debug_id,
+		     int ref,
+		     int n_accesses,
+		     enum fscache_access_trace why),
 
-	    TP_ARGS(netfs),
+	    TP_ARGS(cache_debug_id, ref, n_accesses, why),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __array(char,			name, 8		)
+		    __field(unsigned int,		cache		)
+		    __field(int,			ref		)
+		    __field(int,			n_accesses	)
+		    __field(enum fscache_access_trace,	why		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie		= netfs->primary_index->debug_id;
-		    strncpy(__entry->name, netfs->name, 8);
-		    __entry->name[7]		= 0;
+		    __entry->cache	= cache_debug_id;
+		    __entry->ref	= ref;
+		    __entry->n_accesses	= n_accesses;
+		    __entry->why	= why;
 			   ),
 
-	    TP_printk("c=%08x n=%s",
-		      __entry->cookie, __entry->name)
+	    TP_printk("C=%08x %s r=%d a=%d",
+		      __entry->cache,
+		      __print_symbolic(__entry->why, fscache_access_traces),
+		      __entry->ref,
+		      __entry->n_accesses)
 	    );
 
-TRACE_EVENT(fscache_acquire,
-	    TP_PROTO(struct fscache_cookie *cookie),
+TRACE_EVENT(fscache_access_volume,
+	    TP_PROTO(unsigned int volume_debug_id,
+		     int ref,
+		     int n_accesses,
+		     enum fscache_access_trace why),
 
-	    TP_ARGS(cookie),
+	    TP_ARGS(volume_debug_id, ref, n_accesses, why),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		parent		)
-		    __array(char,			name, 8		)
-		    __field(int,			p_ref		)
-		    __field(int,			p_n_children	)
-		    __field(u8,				p_flags		)
+		    __field(unsigned int,		volume		)
+		    __field(int,			ref		)
+		    __field(int,			n_accesses	)
+		    __field(enum fscache_access_trace,	why		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-		    __entry->parent		= cookie->parent->debug_id;
-		    __entry->p_ref		= refcount_read(&cookie->parent->ref);
-		    __entry->p_n_children	= atomic_read(&cookie->parent->n_children);
-		    __entry->p_flags		= cookie->parent->flags;
-		    memcpy(__entry->name, cookie->type_name, 8);
-		    __entry->name[7]		= 0;
+		    __entry->volume	= volume_debug_id;
+		    __entry->ref	= ref;
+		    __entry->n_accesses	= n_accesses;
+		    __entry->why	= why;
 			   ),
 
-	    TP_printk("c=%08x p=%08x pr=%d pc=%d pf=%02x n=%s",
-		      __entry->cookie, __entry->parent, __entry->p_ref,
-		      __entry->p_n_children, __entry->p_flags, __entry->name)
+	    TP_printk("V=%08x %s r=%d a=%d",
+		      __entry->volume,
+		      __print_symbolic(__entry->why, fscache_access_traces),
+		      __entry->ref,
+		      __entry->n_accesses)
 	    );
 
-TRACE_EVENT(fscache_relinquish,
-	    TP_PROTO(struct fscache_cookie *cookie, bool retire),
+TRACE_EVENT(fscache_access,
+	    TP_PROTO(unsigned int cookie_debug_id,
+		     int ref,
+		     int n_accesses,
+		     enum fscache_access_trace why),
 
-	    TP_ARGS(cookie, retire),
+	    TP_ARGS(cookie_debug_id, ref, n_accesses, why),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		parent		)
 		    __field(int,			ref		)
-		    __field(int,			n_children	)
-		    __field(int,			n_active	)
-		    __field(u8,				flags		)
-		    __field(bool,			retire		)
+		    __field(int,			n_accesses	)
+		    __field(enum fscache_access_trace,	why		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie	= cookie->debug_id;
-		    __entry->parent	= cookie->parent->debug_id;
-		    __entry->ref	= refcount_read(&cookie->ref);
-		    __entry->n_children	= atomic_read(&cookie->n_children);
-		    __entry->n_active	= atomic_read(&cookie->n_active);
-		    __entry->flags	= cookie->flags;
-		    __entry->retire	= retire;
+		    __entry->cookie	= cookie_debug_id;
+		    __entry->ref	= ref;
+		    __entry->n_accesses	= n_accesses;
+		    __entry->why	= why;
 			   ),
 
-	    TP_printk("c=%08x r=%d p=%08x Nc=%d Na=%d f=%02x r=%u",
-		      __entry->cookie, __entry->ref,
-		      __entry->parent, __entry->n_children, __entry->n_active,
-		      __entry->flags, __entry->retire)
+	    TP_printk("c=%08x %s r=%d a=%d",
+		      __entry->cookie,
+		      __print_symbolic(__entry->why, fscache_access_traces),
+		      __entry->ref,
+		      __entry->n_accesses)
 	    );
 
-TRACE_EVENT(fscache_enable,
+TRACE_EVENT(fscache_acquire,
 	    TP_PROTO(struct fscache_cookie *cookie),
 
 	    TP_ARGS(cookie),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		cookie		)
-		    __field(int,			ref		)
-		    __field(int,			n_children	)
-		    __field(int,			n_active	)
-		    __field(u8,				flags		)
+		    __field(unsigned int,		volume		)
+		    __field(int,			v_ref		)
+		    __field(int,			v_n_cookies	)
+		    __field(struct fscache_cookie *,	cookie_p	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie	= cookie->debug_id;
-		    __entry->ref	= refcount_read(&cookie->ref);
-		    __entry->n_children	= atomic_read(&cookie->n_children);
-		    __entry->n_active	= atomic_read(&cookie->n_active);
-		    __entry->flags	= cookie->flags;
+		    __entry->cookie		= cookie->debug_id;
+		    __entry->volume		= cookie->volume->debug_id;
+		    __entry->v_ref		= refcount_read(&cookie->volume->ref);
+		    __entry->v_n_cookies	= atomic_read(&cookie->volume->n_cookies);
 			   ),
 
-	    TP_printk("c=%08x r=%d Nc=%d Na=%d f=%02x",
-		      __entry->cookie, __entry->ref,
-		      __entry->n_children, __entry->n_active, __entry->flags)
+	    TP_printk("c=%08x V=%08x vr=%d vc=%d",
+		      __entry->cookie,
+		      __entry->volume, __entry->v_ref, __entry->v_n_cookies)
 	    );
 
-TRACE_EVENT(fscache_disable,
-	    TP_PROTO(struct fscache_cookie *cookie),
+TRACE_EVENT(fscache_relinquish,
+	    TP_PROTO(struct fscache_cookie *cookie, bool retire),
 
-	    TP_ARGS(cookie),
+	    TP_ARGS(cookie, retire),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		volume		)
 		    __field(int,			ref		)
-		    __field(int,			n_children	)
 		    __field(int,			n_active	)
 		    __field(u8,				flags		)
+		    __field(bool,			retire		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->cookie	= cookie->debug_id;
+		    __entry->volume	= cookie->volume->debug_id;
 		    __entry->ref	= refcount_read(&cookie->ref);
-		    __entry->n_children	= atomic_read(&cookie->n_children);
 		    __entry->n_active	= atomic_read(&cookie->n_active);
 		    __entry->flags	= cookie->flags;
+		    __entry->retire	= retire;
 			   ),
 
-	    TP_printk("c=%08x r=%d Nc=%d Na=%d f=%02x",
-		      __entry->cookie, __entry->ref,
-		      __entry->n_children, __entry->n_active, __entry->flags)
-	    );
-
-TRACE_EVENT(fscache_osm,
-	    TP_PROTO(struct cachefiles_object *object,
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
+	    TP_printk("c=%08x V=%08x r=%d U=%d f=%02x rt=%u",
+		      __entry->cookie, __entry->volume, __entry->ref,
+		      __entry->n_active, __entry->flags, __entry->retire)
 	    );
 
 #endif /* _TRACE_FSCACHE_H */


