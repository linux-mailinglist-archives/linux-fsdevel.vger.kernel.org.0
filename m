Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01912437DDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbhJVTKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234190AbhJVTJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yf6zWh4iNZNcLivkbyXqcsfhxflYJe6QShRw1LGxKZ0=;
        b=fyRTzsn3gypmiaVOl5KSC9Wpk4yQq+ZEnlsaJxYoBGg2qIoYkKm6fHDLO/uXBvFxDTYqUv
        31Vy/3YmLyxkTJGyhSXbAUfc7nRmnkCqRHJoVTp1ejNJbn/daTTI6iZ08Ay4nQtEIAx/rQ
        QY6avY8QUGaI1eiL6yQT8xn/aNJBZbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-wq9WeYGOOJuatIyF6CSX2g-1; Fri, 22 Oct 2021 15:07:28 -0400
X-MC-Unique: wq9WeYGOOJuatIyF6CSX2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4168B801FCE;
        Fri, 22 Oct 2021 19:07:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F09F1346F;
        Fri, 22 Oct 2021 19:07:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 36/53] cachefiles: Implement daemon UAPI and cache
 registration
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
Date:   Fri, 22 Oct 2021 20:07:19 +0100
Message-ID: <163492963955.1038219.12980947942512814993.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a number of parts of the cachefiles driver.  Firstly, the daemon
UAPI interface:

 (1) The miscdev file that is the point of contact with the cachefiled
     daemon.

 (2) An open method that will create a cache record.

 (3) A write method by which the daemon can issue commands, a parser to
     parse those commands and implementations for most of the commands (the
     culling management is deferred to a separate patch).

 (4) A read method by which the state of a cache can be queried.

 (5) A release method that will cause the cache to be withdrawn from
     service.

 (6) A poll method that allows the daemon to check for culling state
     changes.

Secondly, dealing with security and cache registration:

 (1) Getting the cache cookie from fscache, preventing other caches from
     trying to set it up for themselves, adding and withdrawing the cache.

 (2) Looking up/creating the directories that form the structure of the
     cache.

 (3) Computing the credentials that will be used for cache access,
     including security labels.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/Makefile    |    5 
 fs/cachefiles/bind.c      |  296 ++++++++++++++++++++++
 fs/cachefiles/daemon.c    |  600 +++++++++++++++++++++++++++++++++++++++++++++
 fs/cachefiles/interface.c |   42 +++
 fs/cachefiles/internal.h  |   36 +++
 fs/cachefiles/main.c      |   13 +
 fs/cachefiles/security.c  |  112 ++++++++
 7 files changed, 1103 insertions(+), 1 deletion(-)
 create mode 100644 fs/cachefiles/bind.c
 create mode 100644 fs/cachefiles/interface.c
 create mode 100644 fs/cachefiles/security.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 06a87f78b88c..7017c9113074 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -4,9 +4,12 @@
 #
 
 cachefiles-y := \
+	bind.o \
 	daemon.o \
+	interface.o \
 	main.o \
-	namei.o
+	namei.o \
+	security.o
 
 cachefiles-$(CONFIG_CACHEFILES_ERROR_INJECTION) += error_inject.o
 
diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
new file mode 100644
index 000000000000..9ca10290064b
--- /dev/null
+++ b/fs/cachefiles/bind.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Bind and unbind a cache from the filesystem backing it
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/namei.h>
+#include <linux/mount.h>
+#include <linux/statfs.h>
+#include <linux/ctype.h>
+#include <linux/xattr.h>
+#include <trace/events/fscache.h>
+#include "internal.h"
+
+DECLARE_WAIT_QUEUE_HEAD(cachefiles_clearance_wq);
+
+static int cachefiles_daemon_add_cache(struct cachefiles_cache *caches);
+
+/*
+ * bind a directory as a cache
+ */
+int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
+{
+	_enter("{%u,%u,%u,%u,%u,%u},%s",
+	       cache->frun_percent,
+	       cache->fcull_percent,
+	       cache->fstop_percent,
+	       cache->brun_percent,
+	       cache->bcull_percent,
+	       cache->bstop_percent,
+	       args);
+
+	/* start by checking things over */
+	ASSERT(cache->fstop_percent < cache->fcull_percent &&
+	       cache->fcull_percent < cache->frun_percent &&
+	       cache->frun_percent  < 100);
+
+	ASSERT(cache->bstop_percent < cache->bcull_percent &&
+	       cache->bcull_percent < cache->brun_percent &&
+	       cache->brun_percent  < 100);
+
+	if (*args) {
+		pr_err("'bind' command doesn't take an argument\n");
+		return -EINVAL;
+	}
+
+	if (!cache->rootdirname) {
+		pr_err("No cache directory specified\n");
+		return -EINVAL;
+	}
+
+	/* don't permit already bound caches to be re-bound */
+	if (test_bit(CACHEFILES_READY, &cache->flags)) {
+		pr_err("Cache already bound\n");
+		return -EBUSY;
+	}
+
+	return cachefiles_daemon_add_cache(cache);
+}
+
+/*
+ * add a cache
+ */
+static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
+{
+	struct fscache_cache *cache_cookie;
+	struct path path;
+	struct kstatfs stats;
+	struct dentry *graveyard, *cachedir, *root;
+	const struct cred *saved_cred;
+	int ret;
+
+	_enter("");
+
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
+	/* we want to work under the module's security ID */
+	ret = cachefiles_get_security_ID(cache);
+	if (ret < 0)
+		goto error_getsec;
+
+	cachefiles_begin_secure(cache, &saved_cred);
+
+	/* look up the directory at the root of the cache */
+	ret = kern_path(cache->rootdirname, LOOKUP_DIRECTORY, &path);
+	if (ret < 0)
+		goto error_open_root;
+
+	cache->mnt = path.mnt;
+	root = path.dentry;
+
+	ret = -EINVAL;
+	if (mnt_user_ns(path.mnt) != &init_user_ns) {
+		pr_warn("File cache on idmapped mounts not supported");
+		goto error_unsupported;
+	}
+
+	/* check parameters */
+	ret = -EOPNOTSUPP;
+	if (d_is_negative(root) ||
+	    !d_backing_inode(root)->i_op->lookup ||
+	    !d_backing_inode(root)->i_op->mkdir ||
+	    !(d_backing_inode(root)->i_opflags & IOP_XATTR) ||
+	    !root->d_sb->s_op->statfs ||
+	    !root->d_sb->s_op->sync_fs ||
+	    root->d_sb->s_blocksize > PAGE_SIZE)
+		goto error_unsupported;
+
+	ret = -EROFS;
+	if (sb_rdonly(root->d_sb))
+		goto error_unsupported;
+
+	/* determine the security of the on-disk cache as this governs
+	 * security ID of files we create */
+	ret = cachefiles_determine_cache_security(cache, root, &saved_cred);
+	if (ret < 0)
+		goto error_unsupported;
+
+	/* get the cache size and blocksize */
+	ret = vfs_statfs(&path, &stats);
+	if (ret < 0)
+		goto error_unsupported;
+
+	ret = -ERANGE;
+	if (stats.f_bsize <= 0)
+		goto error_unsupported;
+
+	ret = -EOPNOTSUPP;
+	if (stats.f_bsize > PAGE_SIZE)
+		goto error_unsupported;
+
+	cache->bsize = stats.f_bsize;
+	cache->bshift = 0;
+	if (stats.f_bsize < PAGE_SIZE)
+		cache->bshift = PAGE_SHIFT - ilog2(stats.f_bsize);
+
+	_debug("blksize %u (shift %u)",
+	       cache->bsize, cache->bshift);
+
+	_debug("size %llu, avail %llu",
+	       (unsigned long long) stats.f_blocks,
+	       (unsigned long long) stats.f_bavail);
+
+	/* set up caching limits */
+	do_div(stats.f_files, 100);
+	cache->fstop = stats.f_files * cache->fstop_percent;
+	cache->fcull = stats.f_files * cache->fcull_percent;
+	cache->frun  = stats.f_files * cache->frun_percent;
+
+	_debug("limits {%llu,%llu,%llu} files",
+	       (unsigned long long) cache->frun,
+	       (unsigned long long) cache->fcull,
+	       (unsigned long long) cache->fstop);
+
+	stats.f_blocks >>= cache->bshift;
+	do_div(stats.f_blocks, 100);
+	cache->bstop = stats.f_blocks * cache->bstop_percent;
+	cache->bcull = stats.f_blocks * cache->bcull_percent;
+	cache->brun  = stats.f_blocks * cache->brun_percent;
+
+	_debug("limits {%llu,%llu,%llu} blocks",
+	       (unsigned long long) cache->brun,
+	       (unsigned long long) cache->bcull,
+	       (unsigned long long) cache->bstop);
+
+	/* get the cache directory and check its type */
+	cachedir = cachefiles_get_directory(cache, root, "cache");
+	if (IS_ERR(cachedir)) {
+		ret = PTR_ERR(cachedir);
+		goto error_unsupported;
+	}
+
+	cache->store = cachedir;
+
+	/* get the graveyard directory */
+	graveyard = cachefiles_get_directory(cache, root, "graveyard");
+	if (IS_ERR(graveyard)) {
+		ret = PTR_ERR(graveyard);
+		goto error_unsupported;
+	}
+
+	cache->graveyard = graveyard;
+	cache->cache = cache_cookie;
+
+	ret = fscache_add_cache(cache_cookie, &cachefiles_cache_ops, cache);
+	if (ret < 0)
+		goto error_add_cache;
+
+	/* done */
+	set_bit(CACHEFILES_READY, &cache->flags);
+	dput(root);
+
+	pr_info("File cache on %s registered\n", cache_cookie->name);
+
+	/* check how much space the cache has */
+	cachefiles_has_space(cache, 0, 0);
+	cachefiles_end_secure(cache, saved_cred);
+	_leave(" = 0 [%px]", cache->cache);
+	return 0;
+
+error_add_cache:
+	dput(cache->graveyard);
+	cache->graveyard = NULL;
+error_unsupported:
+	dput(cache->store);
+	cache->store = NULL;
+	mntput(cache->mnt);
+	cache->mnt = NULL;
+	dput(root);
+error_open_root:
+	cachefiles_end_secure(cache, saved_cred);
+error_getsec:
+	fscache_set_cache_state(cache_cookie, FSCACHE_CACHE_IS_NOT_PRESENT);
+error_preparing:
+	fscache_put_cache(cache_cookie, fscache_cache_put_cache);
+	cache->cache = NULL;
+	pr_err("Failed to register: %d\n", ret);
+	return ret;
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
+	// PLACEHOLDER: Withdraw objects
+
+	/* wait for all extant objects to finish their outstanding operations
+	 * and go away */
+	_debug("wait for finish %u", atomic_read(&fscache->object_count));
+	wait_event(cachefiles_clearance_wq,
+		   atomic_read(&fscache->object_count) == 0);
+	_debug("cleared");
+
+	// PLACEHOLDER: Withdraw volume
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
+	dput(cache->graveyard);
+	dput(cache->store);
+	mntput(cache->mnt);
+
+	kfree(cache->rootdirname);
+	kfree(cache->secctx);
+	kfree(cache->tag);
+
+	_leave("");
+}
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index dca2520a14ee..c23d22a5d4a6 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -21,6 +21,606 @@
 #include <linux/fs_struct.h>
 #include "internal.h"
 
+static int cachefiles_daemon_open(struct inode *, struct file *);
+static int cachefiles_daemon_release(struct inode *, struct file *);
+static ssize_t cachefiles_daemon_read(struct file *, char __user *, size_t,
+				      loff_t *);
+static ssize_t cachefiles_daemon_write(struct file *, const char __user *,
+				       size_t, loff_t *);
+static __poll_t cachefiles_daemon_poll(struct file *,
+					   struct poll_table_struct *);
+static int cachefiles_daemon_frun(struct cachefiles_cache *, char *);
+static int cachefiles_daemon_fcull(struct cachefiles_cache *, char *);
+static int cachefiles_daemon_fstop(struct cachefiles_cache *, char *);
+static int cachefiles_daemon_brun(struct cachefiles_cache *, char *);
+static int cachefiles_daemon_bcull(struct cachefiles_cache *, char *);
+static int cachefiles_daemon_bstop(struct cachefiles_cache *, char *);
+static int cachefiles_daemon_cull(struct cachefiles_cache *, char *);
+static int cachefiles_daemon_debug(struct cachefiles_cache *, char *);
+static int cachefiles_daemon_dir(struct cachefiles_cache *, char *);
+static int cachefiles_daemon_inuse(struct cachefiles_cache *, char *);
+static int cachefiles_daemon_secctx(struct cachefiles_cache *, char *);
+static int cachefiles_daemon_tag(struct cachefiles_cache *, char *);
+
+static unsigned long cachefiles_open;
+
+const struct file_operations cachefiles_daemon_fops = {
+	.owner		= THIS_MODULE,
+	.open		= cachefiles_daemon_open,
+	.release	= cachefiles_daemon_release,
+	.read		= cachefiles_daemon_read,
+	.write		= cachefiles_daemon_write,
+	.poll		= cachefiles_daemon_poll,
+	.llseek		= noop_llseek,
+};
+
+struct cachefiles_daemon_cmd {
+	char name[8];
+	int (*handler)(struct cachefiles_cache *cache, char *args);
+};
+
+static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
+	{ "bind",	cachefiles_daemon_bind		},
+	{ "brun",	cachefiles_daemon_brun		},
+	{ "bcull",	cachefiles_daemon_bcull		},
+	{ "bstop",	cachefiles_daemon_bstop		},
+	{ "cull",	cachefiles_daemon_cull		},
+	{ "debug",	cachefiles_daemon_debug		},
+	{ "dir",	cachefiles_daemon_dir		},
+	{ "frun",	cachefiles_daemon_frun		},
+	{ "fcull",	cachefiles_daemon_fcull		},
+	{ "fstop",	cachefiles_daemon_fstop		},
+	{ "inuse",	cachefiles_daemon_inuse		},
+	{ "secctx",	cachefiles_daemon_secctx	},
+	{ "tag",	cachefiles_daemon_tag		},
+	{ "",		NULL				}
+};
+
+
+/*
+ * do various checks
+ */
+static int cachefiles_daemon_open(struct inode *inode, struct file *file)
+{
+	struct cachefiles_cache *cache;
+
+	_enter("");
+
+	/* only the superuser may do this */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* the cachefiles device may only be open once at a time */
+	if (xchg(&cachefiles_open, 1) == 1)
+		return -EBUSY;
+
+	/* allocate a cache record */
+	cache = kzalloc(sizeof(struct cachefiles_cache), GFP_KERNEL);
+	if (!cache) {
+		cachefiles_open = 0;
+		return -ENOMEM;
+	}
+
+	mutex_init(&cache->daemon_mutex);
+	init_waitqueue_head(&cache->daemon_pollwq);
+	INIT_LIST_HEAD(&cache->volumes);
+	INIT_LIST_HEAD(&cache->object_list);
+	spin_lock_init(&cache->object_list_lock);
+
+	/* set default caching limits
+	 * - limit at 1% free space and/or free files
+	 * - cull below 5% free space and/or free files
+	 * - cease culling above 7% free space and/or free files
+	 */
+	cache->frun_percent = 7;
+	cache->fcull_percent = 5;
+	cache->fstop_percent = 1;
+	cache->brun_percent = 7;
+	cache->bcull_percent = 5;
+	cache->bstop_percent = 1;
+
+	file->private_data = cache;
+	cache->cachefilesd = file;
+	return 0;
+}
+
+/*
+ * release a cache
+ */
+static int cachefiles_daemon_release(struct inode *inode, struct file *file)
+{
+	struct cachefiles_cache *cache = file->private_data;
+
+	_enter("");
+
+	ASSERT(cache);
+
+	set_bit(CACHEFILES_DEAD, &cache->flags);
+
+	cachefiles_daemon_unbind(cache);
+
+	/* clean up the control file interface */
+	cache->cachefilesd = NULL;
+	file->private_data = NULL;
+	cachefiles_open = 0;
+
+	kfree(cache);
+
+	_leave("");
+	return 0;
+}
+
+/*
+ * read the cache state
+ */
+static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
+				      size_t buflen, loff_t *pos)
+{
+	struct cachefiles_cache *cache = file->private_data;
+	unsigned long long b_released;
+	unsigned f_released;
+	char buffer[256];
+	int n;
+
+	//_enter(",,%zu,", buflen);
+
+	if (!test_bit(CACHEFILES_READY, &cache->flags))
+		return 0;
+
+	/* check how much space the cache has */
+	cachefiles_has_space(cache, 0, 0);
+
+	/* summarise */
+	f_released = atomic_xchg(&cache->f_released, 0);
+	b_released = atomic_long_xchg(&cache->b_released, 0);
+	clear_bit(CACHEFILES_STATE_CHANGED, &cache->flags);
+
+	n = snprintf(buffer, sizeof(buffer),
+		     "cull=%c"
+		     " frun=%llx"
+		     " fcull=%llx"
+		     " fstop=%llx"
+		     " brun=%llx"
+		     " bcull=%llx"
+		     " bstop=%llx"
+		     " freleased=%x"
+		     " breleased=%llx",
+		     test_bit(CACHEFILES_CULLING, &cache->flags) ? '1' : '0',
+		     (unsigned long long) cache->frun,
+		     (unsigned long long) cache->fcull,
+		     (unsigned long long) cache->fstop,
+		     (unsigned long long) cache->brun,
+		     (unsigned long long) cache->bcull,
+		     (unsigned long long) cache->bstop,
+		     f_released,
+		     b_released);
+
+	if (n > buflen)
+		return -EMSGSIZE;
+
+	if (copy_to_user(_buffer, buffer, n) != 0)
+		return -EFAULT;
+
+	return n;
+}
+
+/*
+ * command the cache
+ */
+static ssize_t cachefiles_daemon_write(struct file *file,
+				       const char __user *_data,
+				       size_t datalen,
+				       loff_t *pos)
+{
+	const struct cachefiles_daemon_cmd *cmd;
+	struct cachefiles_cache *cache = file->private_data;
+	ssize_t ret;
+	char *data, *args, *cp;
+
+	//_enter(",,%zu,", datalen);
+
+	ASSERT(cache);
+
+	if (test_bit(CACHEFILES_DEAD, &cache->flags))
+		return -EIO;
+
+	if (datalen > PAGE_SIZE - 1)
+		return -EOPNOTSUPP;
+
+	/* drag the command string into the kernel so we can parse it */
+	data = memdup_user_nul(_data, datalen);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	ret = -EINVAL;
+	if (memchr(data, '\0', datalen))
+		goto error;
+
+	/* strip any newline */
+	cp = memchr(data, '\n', datalen);
+	if (cp) {
+		if (cp == data)
+			goto error;
+
+		*cp = '\0';
+	}
+
+	/* parse the command */
+	ret = -EOPNOTSUPP;
+
+	for (args = data; *args; args++)
+		if (isspace(*args))
+			break;
+	if (*args) {
+		if (args == data)
+			goto error;
+		*args = '\0';
+		args = skip_spaces(++args);
+	}
+
+	/* run the appropriate command handler */
+	for (cmd = cachefiles_daemon_cmds; cmd->name[0]; cmd++)
+		if (strcmp(cmd->name, data) == 0)
+			goto found_command;
+
+error:
+	kfree(data);
+	//_leave(" = %zd", ret);
+	return ret;
+
+found_command:
+	mutex_lock(&cache->daemon_mutex);
+
+	ret = -EIO;
+	if (!test_bit(CACHEFILES_DEAD, &cache->flags))
+		ret = cmd->handler(cache, args);
+
+	mutex_unlock(&cache->daemon_mutex);
+
+	if (ret == 0)
+		ret = datalen;
+	goto error;
+}
+
+/*
+ * poll for culling state
+ * - use EPOLLOUT to indicate culling state
+ */
+static __poll_t cachefiles_daemon_poll(struct file *file,
+					   struct poll_table_struct *poll)
+{
+	struct cachefiles_cache *cache = file->private_data;
+	__poll_t mask;
+
+	poll_wait(file, &cache->daemon_pollwq, poll);
+	mask = 0;
+
+	if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
+		mask |= EPOLLIN;
+
+	if (test_bit(CACHEFILES_CULLING, &cache->flags))
+		mask |= EPOLLOUT;
+
+	return mask;
+}
+
+/*
+ * give a range error for cache space constraints
+ * - can be tail-called
+ */
+static int cachefiles_daemon_range_error(struct cachefiles_cache *cache,
+					 char *args)
+{
+	pr_err("Free space limits must be in range 0%%<=stop<cull<run<100%%\n");
+
+	return -EINVAL;
+}
+
+/*
+ * set the percentage of files at which to stop culling
+ * - command: "frun <N>%"
+ */
+static int cachefiles_daemon_frun(struct cachefiles_cache *cache, char *args)
+{
+	unsigned long frun;
+
+	_enter(",%s", args);
+
+	if (!*args)
+		return -EINVAL;
+
+	frun = simple_strtoul(args, &args, 10);
+	if (args[0] != '%' || args[1] != '\0')
+		return -EINVAL;
+
+	if (frun <= cache->fcull_percent || frun >= 100)
+		return cachefiles_daemon_range_error(cache, args);
+
+	cache->frun_percent = frun;
+	return 0;
+}
+
+/*
+ * set the percentage of files at which to start culling
+ * - command: "fcull <N>%"
+ */
+static int cachefiles_daemon_fcull(struct cachefiles_cache *cache, char *args)
+{
+	unsigned long fcull;
+
+	_enter(",%s", args);
+
+	if (!*args)
+		return -EINVAL;
+
+	fcull = simple_strtoul(args, &args, 10);
+	if (args[0] != '%' || args[1] != '\0')
+		return -EINVAL;
+
+	if (fcull <= cache->fstop_percent || fcull >= cache->frun_percent)
+		return cachefiles_daemon_range_error(cache, args);
+
+	cache->fcull_percent = fcull;
+	return 0;
+}
+
+/*
+ * set the percentage of files at which to stop allocating
+ * - command: "fstop <N>%"
+ */
+static int cachefiles_daemon_fstop(struct cachefiles_cache *cache, char *args)
+{
+	unsigned long fstop;
+
+	_enter(",%s", args);
+
+	if (!*args)
+		return -EINVAL;
+
+	fstop = simple_strtoul(args, &args, 10);
+	if (args[0] != '%' || args[1] != '\0')
+		return -EINVAL;
+
+	if (fstop >= cache->fcull_percent)
+		return cachefiles_daemon_range_error(cache, args);
+
+	cache->fstop_percent = fstop;
+	return 0;
+}
+
+/*
+ * set the percentage of blocks at which to stop culling
+ * - command: "brun <N>%"
+ */
+static int cachefiles_daemon_brun(struct cachefiles_cache *cache, char *args)
+{
+	unsigned long brun;
+
+	_enter(",%s", args);
+
+	if (!*args)
+		return -EINVAL;
+
+	brun = simple_strtoul(args, &args, 10);
+	if (args[0] != '%' || args[1] != '\0')
+		return -EINVAL;
+
+	if (brun <= cache->bcull_percent || brun >= 100)
+		return cachefiles_daemon_range_error(cache, args);
+
+	cache->brun_percent = brun;
+	return 0;
+}
+
+/*
+ * set the percentage of blocks at which to start culling
+ * - command: "bcull <N>%"
+ */
+static int cachefiles_daemon_bcull(struct cachefiles_cache *cache, char *args)
+{
+	unsigned long bcull;
+
+	_enter(",%s", args);
+
+	if (!*args)
+		return -EINVAL;
+
+	bcull = simple_strtoul(args, &args, 10);
+	if (args[0] != '%' || args[1] != '\0')
+		return -EINVAL;
+
+	if (bcull <= cache->bstop_percent || bcull >= cache->brun_percent)
+		return cachefiles_daemon_range_error(cache, args);
+
+	cache->bcull_percent = bcull;
+	return 0;
+}
+
+/*
+ * set the percentage of blocks at which to stop allocating
+ * - command: "bstop <N>%"
+ */
+static int cachefiles_daemon_bstop(struct cachefiles_cache *cache, char *args)
+{
+	unsigned long bstop;
+
+	_enter(",%s", args);
+
+	if (!*args)
+		return -EINVAL;
+
+	bstop = simple_strtoul(args, &args, 10);
+	if (args[0] != '%' || args[1] != '\0')
+		return -EINVAL;
+
+	if (bstop >= cache->bcull_percent)
+		return cachefiles_daemon_range_error(cache, args);
+
+	cache->bstop_percent = bstop;
+	return 0;
+}
+
+/*
+ * set the cache directory
+ * - command: "dir <name>"
+ */
+static int cachefiles_daemon_dir(struct cachefiles_cache *cache, char *args)
+{
+	char *dir;
+
+	_enter(",%s", args);
+
+	if (!*args) {
+		pr_err("Empty directory specified\n");
+		return -EINVAL;
+	}
+
+	if (cache->rootdirname) {
+		pr_err("Second cache directory specified\n");
+		return -EEXIST;
+	}
+
+	dir = kstrdup(args, GFP_KERNEL);
+	if (!dir)
+		return -ENOMEM;
+
+	cache->rootdirname = dir;
+	return 0;
+}
+
+/*
+ * set the cache security context
+ * - command: "secctx <ctx>"
+ */
+static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
+{
+	char *secctx;
+
+	_enter(",%s", args);
+
+	if (!*args) {
+		pr_err("Empty security context specified\n");
+		return -EINVAL;
+	}
+
+	if (cache->secctx) {
+		pr_err("Second security context specified\n");
+		return -EINVAL;
+	}
+
+	secctx = kstrdup(args, GFP_KERNEL);
+	if (!secctx)
+		return -ENOMEM;
+
+	cache->secctx = secctx;
+	return 0;
+}
+
+/*
+ * set the cache tag
+ * - command: "tag <name>"
+ */
+static int cachefiles_daemon_tag(struct cachefiles_cache *cache, char *args)
+{
+	char *tag;
+
+	_enter(",%s", args);
+
+	if (!*args) {
+		pr_err("Empty tag specified\n");
+		return -EINVAL;
+	}
+
+	if (cache->tag)
+		return -EEXIST;
+
+	tag = kstrdup(args, GFP_KERNEL);
+	if (!tag)
+		return -ENOMEM;
+
+	cache->tag = tag;
+	return 0;
+}
+
+/*
+ * request a node in the cache be culled from the current working directory
+ * - command: "cull <name>"
+ */
+static int cachefiles_daemon_cull(struct cachefiles_cache *cache, char *args)
+{
+	_enter(",%s", args);
+
+	if (strchr(args, '/'))
+		goto inval;
+
+	if (!test_bit(CACHEFILES_READY, &cache->flags)) {
+		pr_err("cull applied to unready cache\n");
+		return -EIO;
+	}
+
+	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+		pr_err("cull applied to dead cache\n");
+		return -EIO;
+	}
+
+	return -EOPNOTSUPP; // PLACEHOLDER: Implement culling
+
+inval:
+	pr_err("cull command requires dirfd and filename\n");
+	return -EINVAL;
+}
+
+/*
+ * set debugging mode
+ * - command: "debug <mask>"
+ */
+static int cachefiles_daemon_debug(struct cachefiles_cache *cache, char *args)
+{
+	unsigned long mask;
+
+	_enter(",%s", args);
+
+	mask = simple_strtoul(args, &args, 0);
+	if (args[0] != '\0')
+		goto inval;
+
+	cachefiles_debug = mask;
+	_leave(" = 0");
+	return 0;
+
+inval:
+	pr_err("debug command requires mask\n");
+	return -EINVAL;
+}
+
+/*
+ * find out whether an object in the current working directory is in use or not
+ * - command: "inuse <name>"
+ */
+static int cachefiles_daemon_inuse(struct cachefiles_cache *cache, char *args)
+{
+	//_enter(",%s", args);
+
+	if (strchr(args, '/'))
+		goto inval;
+
+	if (!test_bit(CACHEFILES_READY, &cache->flags)) {
+		pr_err("inuse applied to unready cache\n");
+		return -EIO;
+	}
+
+	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+		pr_err("inuse applied to dead cache\n");
+		return -EIO;
+	}
+
+	return -EOPNOTSUPP; // PLACEHOLDER: Implement check in use
+
+inval:
+	pr_err("inuse command requires dirfd and filename\n");
+	return -EINVAL;
+}
+
 /*
  * see if we have space for a number of pages and/or a number of files in the
  * cache
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
new file mode 100644
index 000000000000..236d55c13fb1
--- /dev/null
+++ b/fs/cachefiles/interface.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* FS-Cache interface to CacheFiles
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/slab.h>
+#include <linux/mount.h>
+#include <linux/xattr.h>
+#include <linux/file.h>
+#include <linux/falloc.h>
+#include <trace/events/fscache.h>
+#include "internal.h"
+
+/*
+ * sync a cache
+ */
+void cachefiles_sync_cache(struct cachefiles_cache *cache)
+{
+	const struct cred *saved_cred;
+	int ret;
+
+	_enter("%s", cache->cache->name);
+
+	/* make sure all pages pinned by operations on behalf of the netfs are
+	 * written to disc */
+	cachefiles_begin_secure(cache, &saved_cred);
+	down_read(&cache->mnt->mnt_sb->s_umount);
+	ret = sync_filesystem(cache->mnt->mnt_sb);
+	up_read(&cache->mnt->mnt_sb->s_umount);
+	cachefiles_end_secure(cache, saved_cred);
+
+	if (ret == -EIO)
+		cachefiles_io_error(cache,
+				    "Attempt to sync backing fs superblock returned error %d",
+				    ret);
+}
+
+const struct fscache_cache_ops cachefiles_cache_ops = {
+	.name			= "cachefiles",
+};
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 4e77c3004d98..c472766cdce3 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -123,9 +123,19 @@ static inline void cachefiles_state_changed(struct cachefiles_cache *cache)
 	wake_up_all(&cache->daemon_pollwq);
 }
 
+/*
+ * bind.c
+ */
+extern wait_queue_head_t cachefiles_clearance_wq;
+
+extern int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args);
+extern void cachefiles_daemon_unbind(struct cachefiles_cache *cache);
+
 /*
  * daemon.c
  */
+extern const struct file_operations cachefiles_daemon_fops;
+
 extern int cachefiles_has_space(struct cachefiles_cache *cache,
 				unsigned fnr, unsigned bnr);
 
@@ -168,6 +178,12 @@ static inline int cachefiles_inject_remove_error(void)
 	return cachefiles_error_injection_state & 2 ? -EIO : 0;
 }
 
+/*
+ * interface.c
+ */
+extern const struct fscache_cache_ops cachefiles_cache_ops;
+extern void cachefiles_sync_cache(struct cachefiles_cache *cache);
+
 /*
  * namei.c
  */
@@ -175,6 +191,26 @@ extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					       struct dentry *dir,
 					       const char *name);
 
+/*
+ * security.c
+ */
+extern int cachefiles_get_security_ID(struct cachefiles_cache *cache);
+extern int cachefiles_determine_cache_security(struct cachefiles_cache *cache,
+					       struct dentry *root,
+					       const struct cred **_saved_cred);
+
+static inline void cachefiles_begin_secure(struct cachefiles_cache *cache,
+					   const struct cred **_saved_cred)
+{
+	*_saved_cred = override_creds(cache->cache_cred);
+}
+
+static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
+					 const struct cred *saved_cred)
+{
+	revert_creds(saved_cred);
+}
+
 /*
  * error handling
  */
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index 387d42c7185f..22581099236b 100644
--- a/fs/cachefiles/main.c
+++ b/fs/cachefiles/main.c
@@ -31,6 +31,12 @@ MODULE_DESCRIPTION("Mounted-filesystem based cache");
 MODULE_AUTHOR("Red Hat, Inc.");
 MODULE_LICENSE("GPL");
 
+static struct miscdevice cachefiles_dev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "cachefiles",
+	.fops	= &cachefiles_daemon_fops,
+};
+
 /*
  * initialise the fs caching module
  */
@@ -42,9 +48,15 @@ static int __init cachefiles_init(void)
 	if (ret < 0)
 		goto error_einj;
 
+	ret = misc_register(&cachefiles_dev);
+	if (ret < 0)
+		goto error_dev;
+
 	pr_info("Loaded\n");
 	return 0;
 
+error_dev:
+	cachefiles_unregister_error_injection();
 error_einj:
 	pr_err("failed to register: %d\n", ret);
 	return ret;
@@ -59,6 +71,7 @@ static void __exit cachefiles_exit(void)
 {
 	pr_info("Unloading\n");
 
+	misc_deregister(&cachefiles_dev);
 	cachefiles_unregister_error_injection();
 }
 
diff --git a/fs/cachefiles/security.c b/fs/cachefiles/security.c
new file mode 100644
index 000000000000..51daa986aca3
--- /dev/null
+++ b/fs/cachefiles/security.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* CacheFiles security management
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/cred.h>
+#include "internal.h"
+
+/*
+ * determine the security context within which we access the cache from within
+ * the kernel
+ */
+int cachefiles_get_security_ID(struct cachefiles_cache *cache)
+{
+	struct cred *new;
+	int ret;
+
+	_enter("{%s}", cache->secctx);
+
+	new = prepare_kernel_cred(current);
+	if (!new) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	if (cache->secctx) {
+		ret = set_security_override_from_ctx(new, cache->secctx);
+		if (ret < 0) {
+			put_cred(new);
+			pr_err("Security denies permission to nominate security context: error %d\n",
+			       ret);
+			goto error;
+		}
+	}
+
+	cache->cache_cred = new;
+	ret = 0;
+error:
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * see if mkdir and create can be performed in the root directory
+ */
+static int cachefiles_check_cache_dir(struct cachefiles_cache *cache,
+				      struct dentry *root)
+{
+	int ret;
+
+	ret = security_inode_mkdir(d_backing_inode(root), root, 0);
+	if (ret < 0) {
+		pr_err("Security denies permission to make dirs: error %d",
+		       ret);
+		return ret;
+	}
+
+	ret = security_inode_create(d_backing_inode(root), root, 0);
+	if (ret < 0)
+		pr_err("Security denies permission to create files: error %d",
+		       ret);
+
+	return ret;
+}
+
+/*
+ * check the security details of the on-disk cache
+ * - must be called with security override in force
+ * - must return with a security override in force - even in the case of an
+ *   error
+ */
+int cachefiles_determine_cache_security(struct cachefiles_cache *cache,
+					struct dentry *root,
+					const struct cred **_saved_cred)
+{
+	struct cred *new;
+	int ret;
+
+	_enter("");
+
+	/* duplicate the cache creds for COW (the override is currently in
+	 * force, so we can use prepare_creds() to do this) */
+	new = prepare_creds();
+	if (!new)
+		return -ENOMEM;
+
+	cachefiles_end_secure(cache, *_saved_cred);
+
+	/* use the cache root dir's security context as the basis with
+	 * which create files */
+	ret = set_create_files_as(new, d_backing_inode(root));
+	if (ret < 0) {
+		abort_creds(new);
+		cachefiles_begin_secure(cache, _saved_cred);
+		_leave(" = %d [cfa]", ret);
+		return ret;
+	}
+
+	put_cred(cache->cache_cred);
+	cache->cache_cred = new;
+
+	cachefiles_begin_secure(cache, _saved_cred);
+	ret = cachefiles_check_cache_dir(cache, root);
+
+	if (ret == -EOPNOTSUPP)
+		ret = 0;
+	_leave(" = %d", ret);
+	return ret;
+}


