Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8200B437CEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhJVTCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233933AbhJVTBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9jWy7o8g+aHi7gTuBGFGyJ8Cwrf7ZwqTAn8xdk7pdk=;
        b=LedLhoc+5kXB/gNAXqauZKbacbddICEOGMjpliHrK8YyVIpZsi/97Wpqphc/BYBGq9TACN
        4jZs0p3WfJ3vHoFpdhuH2jzBuhX4m5CJpa1JlCQhn+eNZk56UVRTd4hrVrr7eqo11rppwS
        /mTsrFSc4V7GGQa1yZSzB1Fi7z/hkTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-iTnM9CZjM1q5NfBPp7RdTw-1; Fri, 22 Oct 2021 14:59:31 -0400
X-MC-Unique: iTnM9CZjM1q5NfBPp7RdTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741E71005E53;
        Fri, 22 Oct 2021 18:59:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 530EF10023B8;
        Fri, 22 Oct 2021 18:59:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 03/53] cachefiles_old:  Move the old cachefiles driver to
 one side
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
Date:   Fri, 22 Oct 2021 19:59:21 +0100
Message-ID: <163492916149.1038219.15930833185244190497.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the old cachefiles driver to fs/cachefiles_old/.  This leaves
fs/cachefiles/ free for a rewritten driver.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/Kconfig                            |    2 
 fs/Makefile                           |    2 
 fs/cachefiles/Kconfig                 |   21 -
 fs/cachefiles/Makefile                |   17 -
 fs/cachefiles/bind.c                  |  278 ---------
 fs/cachefiles/daemon.c                |  748 ------------------------
 fs/cachefiles/interface.c             |  557 ------------------
 fs/cachefiles/internal.h              |  312 ----------
 fs/cachefiles/io.c                    |  445 --------------
 fs/cachefiles/key.c                   |  155 -----
 fs/cachefiles/main.c                  |   94 ---
 fs/cachefiles/namei.c                 | 1018 ---------------------------------
 fs/cachefiles/security.c              |  112 ----
 fs/cachefiles/xattr.c                 |  324 -----------
 fs/cachefiles_old/Kconfig             |   21 +
 fs/cachefiles_old/Makefile            |   17 +
 fs/cachefiles_old/bind.c              |  278 +++++++++
 fs/cachefiles_old/daemon.c            |  748 ++++++++++++++++++++++++
 fs/cachefiles_old/interface.c         |  557 ++++++++++++++++++
 fs/cachefiles_old/internal.h          |  312 ++++++++++
 fs/cachefiles_old/io.c                |  445 ++++++++++++++
 fs/cachefiles_old/key.c               |  155 +++++
 fs/cachefiles_old/main.c              |   94 +++
 fs/cachefiles_old/namei.c             | 1018 +++++++++++++++++++++++++++++++++
 fs/cachefiles_old/security.c          |  112 ++++
 fs/cachefiles_old/xattr.c             |  324 +++++++++++
 include/trace/events/cachefiles.h     |  321 ----------
 include/trace/events/cachefiles_old.h |  321 ++++++++++
 28 files changed, 4404 insertions(+), 4404 deletions(-)
 delete mode 100644 fs/cachefiles/Kconfig
 delete mode 100644 fs/cachefiles/Makefile
 delete mode 100644 fs/cachefiles/bind.c
 delete mode 100644 fs/cachefiles/daemon.c
 delete mode 100644 fs/cachefiles/interface.c
 delete mode 100644 fs/cachefiles/internal.h
 delete mode 100644 fs/cachefiles/io.c
 delete mode 100644 fs/cachefiles/key.c
 delete mode 100644 fs/cachefiles/main.c
 delete mode 100644 fs/cachefiles/namei.c
 delete mode 100644 fs/cachefiles/security.c
 delete mode 100644 fs/cachefiles/xattr.c
 create mode 100644 fs/cachefiles_old/Kconfig
 create mode 100644 fs/cachefiles_old/Makefile
 create mode 100644 fs/cachefiles_old/bind.c
 create mode 100644 fs/cachefiles_old/daemon.c
 create mode 100644 fs/cachefiles_old/interface.c
 create mode 100644 fs/cachefiles_old/internal.h
 create mode 100644 fs/cachefiles_old/io.c
 create mode 100644 fs/cachefiles_old/key.c
 create mode 100644 fs/cachefiles_old/main.c
 create mode 100644 fs/cachefiles_old/namei.c
 create mode 100644 fs/cachefiles_old/security.c
 create mode 100644 fs/cachefiles_old/xattr.c
 delete mode 100644 include/trace/events/cachefiles.h
 create mode 100644 include/trace/events/cachefiles_old.h

diff --git a/fs/Kconfig b/fs/Kconfig
index 966361e471bc..944f8b21f17c 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -132,7 +132,7 @@ menu "Caches"
 
 source "fs/netfs/Kconfig"
 source "fs/fscache_old/Kconfig"
-source "fs/cachefiles/Kconfig"
+source "fs/cachefiles_old/Kconfig"
 
 endmenu
 
diff --git a/fs/Makefile b/fs/Makefile
index 21cf51dbf8b2..6e6dbcd04cae 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -125,7 +125,7 @@ obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_NILFS2_FS)		+= nilfs2/
 obj-$(CONFIG_BEFS_FS)		+= befs/
 obj-$(CONFIG_HOSTFS)		+= hostfs/
-obj-$(CONFIG_CACHEFILES)	+= cachefiles/
+obj-$(CONFIG_CACHEFILES)	+= cachefiles_old/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
 obj-$(CONFIG_TRACING)		+= tracefs/
 obj-$(CONFIG_OCFS2_FS)		+= ocfs2/
diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
deleted file mode 100644
index 7f3e1881fb21..000000000000
--- a/fs/cachefiles/Kconfig
+++ /dev/null
@@ -1,21 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-
-config CACHEFILES
-	tristate "Filesystem caching on files"
-	depends on FSCACHE_OLD && BLOCK
-	help
-	  This permits use of a mounted filesystem as a cache for other
-	  filesystems - primarily networking filesystems - thus allowing fast
-	  local disk to enhance the speed of slower devices.
-
-	  See Documentation/filesystems/caching/cachefiles.rst for more
-	  information.
-
-config CACHEFILES_DEBUG
-	bool "Debug CacheFiles"
-	depends on CACHEFILES
-	help
-	  This permits debugging to be dynamically enabled in the filesystem
-	  caching on files module.  If this is set, the debugging output may be
-	  enabled by setting bits in /sys/modules/cachefiles/parameter/debug or
-	  by including a debugging specifier in /etc/cachefilesd.conf.
diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
deleted file mode 100644
index 714e84b3ca24..000000000000
--- a/fs/cachefiles/Makefile
+++ /dev/null
@@ -1,17 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for caching in a mounted filesystem
-#
-
-cachefiles-y := \
-	bind.o \
-	daemon.o \
-	interface.o \
-	io.o \
-	key.o \
-	main.o \
-	namei.o \
-	security.o \
-	xattr.o
-
-obj-$(CONFIG_CACHEFILES) := cachefiles.o
diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
deleted file mode 100644
index d463d89f5db8..000000000000
--- a/fs/cachefiles/bind.c
+++ /dev/null
@@ -1,278 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Bind and unbind a cache from the filesystem backing it
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/completion.h>
-#include <linux/slab.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/namei.h>
-#include <linux/mount.h>
-#include <linux/statfs.h>
-#include <linux/ctype.h>
-#include <linux/xattr.h>
-#include "internal.h"
-
-static int cachefiles_daemon_add_cache(struct cachefiles_cache *caches);
-
-/*
- * bind a directory as a cache
- */
-int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
-{
-	_enter("{%u,%u,%u,%u,%u,%u},%s",
-	       cache->frun_percent,
-	       cache->fcull_percent,
-	       cache->fstop_percent,
-	       cache->brun_percent,
-	       cache->bcull_percent,
-	       cache->bstop_percent,
-	       args);
-
-	/* start by checking things over */
-	ASSERT(cache->fstop_percent >= 0 &&
-	       cache->fstop_percent < cache->fcull_percent &&
-	       cache->fcull_percent < cache->frun_percent &&
-	       cache->frun_percent  < 100);
-
-	ASSERT(cache->bstop_percent >= 0 &&
-	       cache->bstop_percent < cache->bcull_percent &&
-	       cache->bcull_percent < cache->brun_percent &&
-	       cache->brun_percent  < 100);
-
-	if (*args) {
-		pr_err("'bind' command doesn't take an argument\n");
-		return -EINVAL;
-	}
-
-	if (!cache->rootdirname) {
-		pr_err("No cache directory specified\n");
-		return -EINVAL;
-	}
-
-	/* don't permit already bound caches to be re-bound */
-	if (test_bit(CACHEFILES_READY, &cache->flags)) {
-		pr_err("Cache already bound\n");
-		return -EBUSY;
-	}
-
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
-	return cachefiles_daemon_add_cache(cache);
-}
-
-/*
- * add a cache
- */
-static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
-{
-	struct cachefiles_object *fsdef;
-	struct path path;
-	struct kstatfs stats;
-	struct dentry *graveyard, *cachedir, *root;
-	const struct cred *saved_cred;
-	int ret;
-
-	_enter("");
-
-	/* we want to work under the module's security ID */
-	ret = cachefiles_get_security_ID(cache);
-	if (ret < 0)
-		return ret;
-
-	cachefiles_begin_secure(cache, &saved_cred);
-
-	/* allocate the root index object */
-	ret = -ENOMEM;
-
-	fsdef = kmem_cache_alloc(cachefiles_object_jar, GFP_KERNEL);
-	if (!fsdef)
-		goto error_root_object;
-
-	ASSERTCMP(fsdef->backer, ==, NULL);
-
-	atomic_set(&fsdef->usage, 1);
-	fsdef->type = FSCACHE_COOKIE_TYPE_INDEX;
-
-	/* look up the directory at the root of the cache */
-	ret = kern_path(cache->rootdirname, LOOKUP_DIRECTORY, &path);
-	if (ret < 0)
-		goto error_open_root;
-
-	cache->mnt = path.mnt;
-	root = path.dentry;
-
-	ret = -EINVAL;
-	if (mnt_user_ns(path.mnt) != &init_user_ns) {
-		pr_warn("File cache on idmapped mounts not supported");
-		goto error_unsupported;
-	}
-
-	/* check parameters */
-	ret = -EOPNOTSUPP;
-	if (d_is_negative(root) ||
-	    !d_backing_inode(root)->i_op->lookup ||
-	    !d_backing_inode(root)->i_op->mkdir ||
-	    !(d_backing_inode(root)->i_opflags & IOP_XATTR) ||
-	    !root->d_sb->s_op->statfs ||
-	    !root->d_sb->s_op->sync_fs)
-		goto error_unsupported;
-
-	ret = -EROFS;
-	if (sb_rdonly(root->d_sb))
-		goto error_unsupported;
-
-	/* determine the security of the on-disk cache as this governs
-	 * security ID of files we create */
-	ret = cachefiles_determine_cache_security(cache, root, &saved_cred);
-	if (ret < 0)
-		goto error_unsupported;
-
-	/* get the cache size and blocksize */
-	ret = vfs_statfs(&path, &stats);
-	if (ret < 0)
-		goto error_unsupported;
-
-	ret = -ERANGE;
-	if (stats.f_bsize <= 0)
-		goto error_unsupported;
-
-	ret = -EOPNOTSUPP;
-	if (stats.f_bsize > PAGE_SIZE)
-		goto error_unsupported;
-
-	cache->bsize = stats.f_bsize;
-	cache->bshift = 0;
-	if (stats.f_bsize < PAGE_SIZE)
-		cache->bshift = PAGE_SHIFT - ilog2(stats.f_bsize);
-
-	_debug("blksize %u (shift %u)",
-	       cache->bsize, cache->bshift);
-
-	_debug("size %llu, avail %llu",
-	       (unsigned long long) stats.f_blocks,
-	       (unsigned long long) stats.f_bavail);
-
-	/* set up caching limits */
-	do_div(stats.f_files, 100);
-	cache->fstop = stats.f_files * cache->fstop_percent;
-	cache->fcull = stats.f_files * cache->fcull_percent;
-	cache->frun  = stats.f_files * cache->frun_percent;
-
-	_debug("limits {%llu,%llu,%llu} files",
-	       (unsigned long long) cache->frun,
-	       (unsigned long long) cache->fcull,
-	       (unsigned long long) cache->fstop);
-
-	stats.f_blocks >>= cache->bshift;
-	do_div(stats.f_blocks, 100);
-	cache->bstop = stats.f_blocks * cache->bstop_percent;
-	cache->bcull = stats.f_blocks * cache->bcull_percent;
-	cache->brun  = stats.f_blocks * cache->brun_percent;
-
-	_debug("limits {%llu,%llu,%llu} blocks",
-	       (unsigned long long) cache->brun,
-	       (unsigned long long) cache->bcull,
-	       (unsigned long long) cache->bstop);
-
-	/* get the cache directory and check its type */
-	cachedir = cachefiles_get_directory(cache, root, "cache");
-	if (IS_ERR(cachedir)) {
-		ret = PTR_ERR(cachedir);
-		goto error_unsupported;
-	}
-
-	fsdef->dentry = cachedir;
-	fsdef->fscache.cookie = NULL;
-
-	ret = cachefiles_check_object_type(fsdef);
-	if (ret < 0)
-		goto error_unsupported;
-
-	/* get the graveyard directory */
-	graveyard = cachefiles_get_directory(cache, root, "graveyard");
-	if (IS_ERR(graveyard)) {
-		ret = PTR_ERR(graveyard);
-		goto error_unsupported;
-	}
-
-	cache->graveyard = graveyard;
-
-	/* publish the cache */
-	fscache_init_cache(&cache->cache,
-			   &cachefiles_cache_ops,
-			   "%s",
-			   fsdef->dentry->d_sb->s_id);
-
-	fscache_object_init(&fsdef->fscache, &fscache_fsdef_index,
-			    &cache->cache);
-
-	ret = fscache_add_cache(&cache->cache, &fsdef->fscache, cache->tag);
-	if (ret < 0)
-		goto error_add_cache;
-
-	/* done */
-	set_bit(CACHEFILES_READY, &cache->flags);
-	dput(root);
-
-	pr_info("File cache on %s registered\n", cache->cache.identifier);
-
-	/* check how much space the cache has */
-	cachefiles_has_space(cache, 0, 0);
-	cachefiles_end_secure(cache, saved_cred);
-	return 0;
-
-error_add_cache:
-	dput(cache->graveyard);
-	cache->graveyard = NULL;
-error_unsupported:
-	mntput(cache->mnt);
-	cache->mnt = NULL;
-	dput(fsdef->dentry);
-	fsdef->dentry = NULL;
-	dput(root);
-error_open_root:
-	kmem_cache_free(cachefiles_object_jar, fsdef);
-error_root_object:
-	cachefiles_end_secure(cache, saved_cred);
-	pr_err("Failed to register: %d\n", ret);
-	return ret;
-}
-
-/*
- * unbind a cache on fd release
- */
-void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
-{
-	_enter("");
-
-	if (test_bit(CACHEFILES_READY, &cache->flags)) {
-		pr_info("File cache on %s unregistering\n",
-			cache->cache.identifier);
-
-		fscache_withdraw_cache(&cache->cache);
-	}
-
-	dput(cache->graveyard);
-	mntput(cache->mnt);
-
-	kfree(cache->rootdirname);
-	kfree(cache->secctx);
-	kfree(cache->tag);
-
-	_leave("");
-}
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
deleted file mode 100644
index 752c1e43416f..000000000000
--- a/fs/cachefiles/daemon.c
+++ /dev/null
@@ -1,748 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Daemon interface
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/completion.h>
-#include <linux/slab.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/namei.h>
-#include <linux/poll.h>
-#include <linux/mount.h>
-#include <linux/statfs.h>
-#include <linux/ctype.h>
-#include <linux/string.h>
-#include <linux/fs_struct.h>
-#include "internal.h"
-
-static int cachefiles_daemon_open(struct inode *, struct file *);
-static int cachefiles_daemon_release(struct inode *, struct file *);
-static ssize_t cachefiles_daemon_read(struct file *, char __user *, size_t,
-				      loff_t *);
-static ssize_t cachefiles_daemon_write(struct file *, const char __user *,
-				       size_t, loff_t *);
-static __poll_t cachefiles_daemon_poll(struct file *,
-					   struct poll_table_struct *);
-static int cachefiles_daemon_frun(struct cachefiles_cache *, char *);
-static int cachefiles_daemon_fcull(struct cachefiles_cache *, char *);
-static int cachefiles_daemon_fstop(struct cachefiles_cache *, char *);
-static int cachefiles_daemon_brun(struct cachefiles_cache *, char *);
-static int cachefiles_daemon_bcull(struct cachefiles_cache *, char *);
-static int cachefiles_daemon_bstop(struct cachefiles_cache *, char *);
-static int cachefiles_daemon_cull(struct cachefiles_cache *, char *);
-static int cachefiles_daemon_debug(struct cachefiles_cache *, char *);
-static int cachefiles_daemon_dir(struct cachefiles_cache *, char *);
-static int cachefiles_daemon_inuse(struct cachefiles_cache *, char *);
-static int cachefiles_daemon_secctx(struct cachefiles_cache *, char *);
-static int cachefiles_daemon_tag(struct cachefiles_cache *, char *);
-
-static unsigned long cachefiles_open;
-
-const struct file_operations cachefiles_daemon_fops = {
-	.owner		= THIS_MODULE,
-	.open		= cachefiles_daemon_open,
-	.release	= cachefiles_daemon_release,
-	.read		= cachefiles_daemon_read,
-	.write		= cachefiles_daemon_write,
-	.poll		= cachefiles_daemon_poll,
-	.llseek		= noop_llseek,
-};
-
-struct cachefiles_daemon_cmd {
-	char name[8];
-	int (*handler)(struct cachefiles_cache *cache, char *args);
-};
-
-static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
-	{ "bind",	cachefiles_daemon_bind		},
-	{ "brun",	cachefiles_daemon_brun		},
-	{ "bcull",	cachefiles_daemon_bcull		},
-	{ "bstop",	cachefiles_daemon_bstop		},
-	{ "cull",	cachefiles_daemon_cull		},
-	{ "debug",	cachefiles_daemon_debug		},
-	{ "dir",	cachefiles_daemon_dir		},
-	{ "frun",	cachefiles_daemon_frun		},
-	{ "fcull",	cachefiles_daemon_fcull		},
-	{ "fstop",	cachefiles_daemon_fstop		},
-	{ "inuse",	cachefiles_daemon_inuse		},
-	{ "secctx",	cachefiles_daemon_secctx	},
-	{ "tag",	cachefiles_daemon_tag		},
-	{ "",		NULL				}
-};
-
-
-/*
- * do various checks
- */
-static int cachefiles_daemon_open(struct inode *inode, struct file *file)
-{
-	struct cachefiles_cache *cache;
-
-	_enter("");
-
-	/* only the superuser may do this */
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	/* the cachefiles device may only be open once at a time */
-	if (xchg(&cachefiles_open, 1) == 1)
-		return -EBUSY;
-
-	/* allocate a cache record */
-	cache = kzalloc(sizeof(struct cachefiles_cache), GFP_KERNEL);
-	if (!cache) {
-		cachefiles_open = 0;
-		return -ENOMEM;
-	}
-
-	mutex_init(&cache->daemon_mutex);
-	cache->active_nodes = RB_ROOT;
-	rwlock_init(&cache->active_lock);
-	init_waitqueue_head(&cache->daemon_pollwq);
-
-	/* set default caching limits
-	 * - limit at 1% free space and/or free files
-	 * - cull below 5% free space and/or free files
-	 * - cease culling above 7% free space and/or free files
-	 */
-	cache->frun_percent = 7;
-	cache->fcull_percent = 5;
-	cache->fstop_percent = 1;
-	cache->brun_percent = 7;
-	cache->bcull_percent = 5;
-	cache->bstop_percent = 1;
-
-	file->private_data = cache;
-	cache->cachefilesd = file;
-	return 0;
-}
-
-/*
- * release a cache
- */
-static int cachefiles_daemon_release(struct inode *inode, struct file *file)
-{
-	struct cachefiles_cache *cache = file->private_data;
-
-	_enter("");
-
-	ASSERT(cache);
-
-	set_bit(CACHEFILES_DEAD, &cache->flags);
-
-	cachefiles_daemon_unbind(cache);
-
-	ASSERT(!cache->active_nodes.rb_node);
-
-	/* clean up the control file interface */
-	cache->cachefilesd = NULL;
-	file->private_data = NULL;
-	cachefiles_open = 0;
-
-	kfree(cache);
-
-	_leave("");
-	return 0;
-}
-
-/*
- * read the cache state
- */
-static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
-				      size_t buflen, loff_t *pos)
-{
-	struct cachefiles_cache *cache = file->private_data;
-	unsigned long long b_released;
-	unsigned f_released;
-	char buffer[256];
-	int n;
-
-	//_enter(",,%zu,", buflen);
-
-	if (!test_bit(CACHEFILES_READY, &cache->flags))
-		return 0;
-
-	/* check how much space the cache has */
-	cachefiles_has_space(cache, 0, 0);
-
-	/* summarise */
-	f_released = atomic_xchg(&cache->f_released, 0);
-	b_released = atomic_long_xchg(&cache->b_released, 0);
-	clear_bit(CACHEFILES_STATE_CHANGED, &cache->flags);
-
-	n = snprintf(buffer, sizeof(buffer),
-		     "cull=%c"
-		     " frun=%llx"
-		     " fcull=%llx"
-		     " fstop=%llx"
-		     " brun=%llx"
-		     " bcull=%llx"
-		     " bstop=%llx"
-		     " freleased=%x"
-		     " breleased=%llx",
-		     test_bit(CACHEFILES_CULLING, &cache->flags) ? '1' : '0',
-		     (unsigned long long) cache->frun,
-		     (unsigned long long) cache->fcull,
-		     (unsigned long long) cache->fstop,
-		     (unsigned long long) cache->brun,
-		     (unsigned long long) cache->bcull,
-		     (unsigned long long) cache->bstop,
-		     f_released,
-		     b_released);
-
-	if (n > buflen)
-		return -EMSGSIZE;
-
-	if (copy_to_user(_buffer, buffer, n) != 0)
-		return -EFAULT;
-
-	return n;
-}
-
-/*
- * command the cache
- */
-static ssize_t cachefiles_daemon_write(struct file *file,
-				       const char __user *_data,
-				       size_t datalen,
-				       loff_t *pos)
-{
-	const struct cachefiles_daemon_cmd *cmd;
-	struct cachefiles_cache *cache = file->private_data;
-	ssize_t ret;
-	char *data, *args, *cp;
-
-	//_enter(",,%zu,", datalen);
-
-	ASSERT(cache);
-
-	if (test_bit(CACHEFILES_DEAD, &cache->flags))
-		return -EIO;
-
-	if (datalen < 0 || datalen > PAGE_SIZE - 1)
-		return -EOPNOTSUPP;
-
-	/* drag the command string into the kernel so we can parse it */
-	data = memdup_user_nul(_data, datalen);
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
-	ret = -EINVAL;
-	if (memchr(data, '\0', datalen))
-		goto error;
-
-	/* strip any newline */
-	cp = memchr(data, '\n', datalen);
-	if (cp) {
-		if (cp == data)
-			goto error;
-
-		*cp = '\0';
-	}
-
-	/* parse the command */
-	ret = -EOPNOTSUPP;
-
-	for (args = data; *args; args++)
-		if (isspace(*args))
-			break;
-	if (*args) {
-		if (args == data)
-			goto error;
-		*args = '\0';
-		args = skip_spaces(++args);
-	}
-
-	/* run the appropriate command handler */
-	for (cmd = cachefiles_daemon_cmds; cmd->name[0]; cmd++)
-		if (strcmp(cmd->name, data) == 0)
-			goto found_command;
-
-error:
-	kfree(data);
-	//_leave(" = %zd", ret);
-	return ret;
-
-found_command:
-	mutex_lock(&cache->daemon_mutex);
-
-	ret = -EIO;
-	if (!test_bit(CACHEFILES_DEAD, &cache->flags))
-		ret = cmd->handler(cache, args);
-
-	mutex_unlock(&cache->daemon_mutex);
-
-	if (ret == 0)
-		ret = datalen;
-	goto error;
-}
-
-/*
- * poll for culling state
- * - use EPOLLOUT to indicate culling state
- */
-static __poll_t cachefiles_daemon_poll(struct file *file,
-					   struct poll_table_struct *poll)
-{
-	struct cachefiles_cache *cache = file->private_data;
-	__poll_t mask;
-
-	poll_wait(file, &cache->daemon_pollwq, poll);
-	mask = 0;
-
-	if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
-		mask |= EPOLLIN;
-
-	if (test_bit(CACHEFILES_CULLING, &cache->flags))
-		mask |= EPOLLOUT;
-
-	return mask;
-}
-
-/*
- * give a range error for cache space constraints
- * - can be tail-called
- */
-static int cachefiles_daemon_range_error(struct cachefiles_cache *cache,
-					 char *args)
-{
-	pr_err("Free space limits must be in range 0%%<=stop<cull<run<100%%\n");
-
-	return -EINVAL;
-}
-
-/*
- * set the percentage of files at which to stop culling
- * - command: "frun <N>%"
- */
-static int cachefiles_daemon_frun(struct cachefiles_cache *cache, char *args)
-{
-	unsigned long frun;
-
-	_enter(",%s", args);
-
-	if (!*args)
-		return -EINVAL;
-
-	frun = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
-		return -EINVAL;
-
-	if (frun <= cache->fcull_percent || frun >= 100)
-		return cachefiles_daemon_range_error(cache, args);
-
-	cache->frun_percent = frun;
-	return 0;
-}
-
-/*
- * set the percentage of files at which to start culling
- * - command: "fcull <N>%"
- */
-static int cachefiles_daemon_fcull(struct cachefiles_cache *cache, char *args)
-{
-	unsigned long fcull;
-
-	_enter(",%s", args);
-
-	if (!*args)
-		return -EINVAL;
-
-	fcull = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
-		return -EINVAL;
-
-	if (fcull <= cache->fstop_percent || fcull >= cache->frun_percent)
-		return cachefiles_daemon_range_error(cache, args);
-
-	cache->fcull_percent = fcull;
-	return 0;
-}
-
-/*
- * set the percentage of files at which to stop allocating
- * - command: "fstop <N>%"
- */
-static int cachefiles_daemon_fstop(struct cachefiles_cache *cache, char *args)
-{
-	unsigned long fstop;
-
-	_enter(",%s", args);
-
-	if (!*args)
-		return -EINVAL;
-
-	fstop = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
-		return -EINVAL;
-
-	if (fstop < 0 || fstop >= cache->fcull_percent)
-		return cachefiles_daemon_range_error(cache, args);
-
-	cache->fstop_percent = fstop;
-	return 0;
-}
-
-/*
- * set the percentage of blocks at which to stop culling
- * - command: "brun <N>%"
- */
-static int cachefiles_daemon_brun(struct cachefiles_cache *cache, char *args)
-{
-	unsigned long brun;
-
-	_enter(",%s", args);
-
-	if (!*args)
-		return -EINVAL;
-
-	brun = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
-		return -EINVAL;
-
-	if (brun <= cache->bcull_percent || brun >= 100)
-		return cachefiles_daemon_range_error(cache, args);
-
-	cache->brun_percent = brun;
-	return 0;
-}
-
-/*
- * set the percentage of blocks at which to start culling
- * - command: "bcull <N>%"
- */
-static int cachefiles_daemon_bcull(struct cachefiles_cache *cache, char *args)
-{
-	unsigned long bcull;
-
-	_enter(",%s", args);
-
-	if (!*args)
-		return -EINVAL;
-
-	bcull = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
-		return -EINVAL;
-
-	if (bcull <= cache->bstop_percent || bcull >= cache->brun_percent)
-		return cachefiles_daemon_range_error(cache, args);
-
-	cache->bcull_percent = bcull;
-	return 0;
-}
-
-/*
- * set the percentage of blocks at which to stop allocating
- * - command: "bstop <N>%"
- */
-static int cachefiles_daemon_bstop(struct cachefiles_cache *cache, char *args)
-{
-	unsigned long bstop;
-
-	_enter(",%s", args);
-
-	if (!*args)
-		return -EINVAL;
-
-	bstop = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
-		return -EINVAL;
-
-	if (bstop < 0 || bstop >= cache->bcull_percent)
-		return cachefiles_daemon_range_error(cache, args);
-
-	cache->bstop_percent = bstop;
-	return 0;
-}
-
-/*
- * set the cache directory
- * - command: "dir <name>"
- */
-static int cachefiles_daemon_dir(struct cachefiles_cache *cache, char *args)
-{
-	char *dir;
-
-	_enter(",%s", args);
-
-	if (!*args) {
-		pr_err("Empty directory specified\n");
-		return -EINVAL;
-	}
-
-	if (cache->rootdirname) {
-		pr_err("Second cache directory specified\n");
-		return -EEXIST;
-	}
-
-	dir = kstrdup(args, GFP_KERNEL);
-	if (!dir)
-		return -ENOMEM;
-
-	cache->rootdirname = dir;
-	return 0;
-}
-
-/*
- * set the cache security context
- * - command: "secctx <ctx>"
- */
-static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
-{
-	char *secctx;
-
-	_enter(",%s", args);
-
-	if (!*args) {
-		pr_err("Empty security context specified\n");
-		return -EINVAL;
-	}
-
-	if (cache->secctx) {
-		pr_err("Second security context specified\n");
-		return -EINVAL;
-	}
-
-	secctx = kstrdup(args, GFP_KERNEL);
-	if (!secctx)
-		return -ENOMEM;
-
-	cache->secctx = secctx;
-	return 0;
-}
-
-/*
- * set the cache tag
- * - command: "tag <name>"
- */
-static int cachefiles_daemon_tag(struct cachefiles_cache *cache, char *args)
-{
-	char *tag;
-
-	_enter(",%s", args);
-
-	if (!*args) {
-		pr_err("Empty tag specified\n");
-		return -EINVAL;
-	}
-
-	if (cache->tag)
-		return -EEXIST;
-
-	tag = kstrdup(args, GFP_KERNEL);
-	if (!tag)
-		return -ENOMEM;
-
-	cache->tag = tag;
-	return 0;
-}
-
-/*
- * request a node in the cache be culled from the current working directory
- * - command: "cull <name>"
- */
-static int cachefiles_daemon_cull(struct cachefiles_cache *cache, char *args)
-{
-	struct path path;
-	const struct cred *saved_cred;
-	int ret;
-
-	_enter(",%s", args);
-
-	if (strchr(args, '/'))
-		goto inval;
-
-	if (!test_bit(CACHEFILES_READY, &cache->flags)) {
-		pr_err("cull applied to unready cache\n");
-		return -EIO;
-	}
-
-	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
-		pr_err("cull applied to dead cache\n");
-		return -EIO;
-	}
-
-	/* extract the directory dentry from the cwd */
-	get_fs_pwd(current->fs, &path);
-
-	if (!d_can_lookup(path.dentry))
-		goto notdir;
-
-	cachefiles_begin_secure(cache, &saved_cred);
-	ret = cachefiles_cull(cache, path.dentry, args);
-	cachefiles_end_secure(cache, saved_cred);
-
-	path_put(&path);
-	_leave(" = %d", ret);
-	return ret;
-
-notdir:
-	path_put(&path);
-	pr_err("cull command requires dirfd to be a directory\n");
-	return -ENOTDIR;
-
-inval:
-	pr_err("cull command requires dirfd and filename\n");
-	return -EINVAL;
-}
-
-/*
- * set debugging mode
- * - command: "debug <mask>"
- */
-static int cachefiles_daemon_debug(struct cachefiles_cache *cache, char *args)
-{
-	unsigned long mask;
-
-	_enter(",%s", args);
-
-	mask = simple_strtoul(args, &args, 0);
-	if (args[0] != '\0')
-		goto inval;
-
-	cachefiles_debug = mask;
-	_leave(" = 0");
-	return 0;
-
-inval:
-	pr_err("debug command requires mask\n");
-	return -EINVAL;
-}
-
-/*
- * find out whether an object in the current working directory is in use or not
- * - command: "inuse <name>"
- */
-static int cachefiles_daemon_inuse(struct cachefiles_cache *cache, char *args)
-{
-	struct path path;
-	const struct cred *saved_cred;
-	int ret;
-
-	//_enter(",%s", args);
-
-	if (strchr(args, '/'))
-		goto inval;
-
-	if (!test_bit(CACHEFILES_READY, &cache->flags)) {
-		pr_err("inuse applied to unready cache\n");
-		return -EIO;
-	}
-
-	if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
-		pr_err("inuse applied to dead cache\n");
-		return -EIO;
-	}
-
-	/* extract the directory dentry from the cwd */
-	get_fs_pwd(current->fs, &path);
-
-	if (!d_can_lookup(path.dentry))
-		goto notdir;
-
-	cachefiles_begin_secure(cache, &saved_cred);
-	ret = cachefiles_check_in_use(cache, path.dentry, args);
-	cachefiles_end_secure(cache, saved_cred);
-
-	path_put(&path);
-	//_leave(" = %d", ret);
-	return ret;
-
-notdir:
-	path_put(&path);
-	pr_err("inuse command requires dirfd to be a directory\n");
-	return -ENOTDIR;
-
-inval:
-	pr_err("inuse command requires dirfd and filename\n");
-	return -EINVAL;
-}
-
-/*
- * see if we have space for a number of pages and/or a number of files in the
- * cache
- */
-int cachefiles_has_space(struct cachefiles_cache *cache,
-			 unsigned fnr, unsigned bnr)
-{
-	struct kstatfs stats;
-	struct path path = {
-		.mnt	= cache->mnt,
-		.dentry	= cache->mnt->mnt_root,
-	};
-	int ret;
-
-	//_enter("{%llu,%llu,%llu,%llu,%llu,%llu},%u,%u",
-	//       (unsigned long long) cache->frun,
-	//       (unsigned long long) cache->fcull,
-	//       (unsigned long long) cache->fstop,
-	//       (unsigned long long) cache->brun,
-	//       (unsigned long long) cache->bcull,
-	//       (unsigned long long) cache->bstop,
-	//       fnr, bnr);
-
-	/* find out how many pages of blockdev are available */
-	memset(&stats, 0, sizeof(stats));
-
-	ret = vfs_statfs(&path, &stats);
-	if (ret < 0) {
-		if (ret == -EIO)
-			cachefiles_io_error(cache, "statfs failed");
-		_leave(" = %d", ret);
-		return ret;
-	}
-
-	stats.f_bavail >>= cache->bshift;
-
-	//_debug("avail %llu,%llu",
-	//       (unsigned long long) stats.f_ffree,
-	//       (unsigned long long) stats.f_bavail);
-
-	/* see if there is sufficient space */
-	if (stats.f_ffree > fnr)
-		stats.f_ffree -= fnr;
-	else
-		stats.f_ffree = 0;
-
-	if (stats.f_bavail > bnr)
-		stats.f_bavail -= bnr;
-	else
-		stats.f_bavail = 0;
-
-	ret = -ENOBUFS;
-	if (stats.f_ffree < cache->fstop ||
-	    stats.f_bavail < cache->bstop)
-		goto begin_cull;
-
-	ret = 0;
-	if (stats.f_ffree < cache->fcull ||
-	    stats.f_bavail < cache->bcull)
-		goto begin_cull;
-
-	if (test_bit(CACHEFILES_CULLING, &cache->flags) &&
-	    stats.f_ffree >= cache->frun &&
-	    stats.f_bavail >= cache->brun &&
-	    test_and_clear_bit(CACHEFILES_CULLING, &cache->flags)
-	    ) {
-		_debug("cease culling");
-		cachefiles_state_changed(cache);
-	}
-
-	//_leave(" = 0");
-	return 0;
-
-begin_cull:
-	if (!test_and_set_bit(CACHEFILES_CULLING, &cache->flags)) {
-		_debug("### CULL CACHE ###");
-		cachefiles_state_changed(cache);
-	}
-
-	_leave(" = %d", ret);
-	return ret;
-}
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
deleted file mode 100644
index 83671488a323..000000000000
--- a/fs/cachefiles/interface.c
+++ /dev/null
@@ -1,557 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* FS-Cache interface to CacheFiles
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/slab.h>
-#include <linux/mount.h>
-#include "internal.h"
-
-struct cachefiles_lookup_data {
-	struct cachefiles_xattr	*auxdata;	/* auxiliary data */
-	char			*key;		/* key path */
-};
-
-static int cachefiles_attr_changed(struct fscache_object *_object);
-
-/*
- * allocate an object record for a cookie lookup and prepare the lookup data
- */
-static struct fscache_object *cachefiles_alloc_object(
-	struct fscache_cache *_cache,
-	struct fscache_cookie *cookie)
-{
-	struct cachefiles_lookup_data *lookup_data;
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	struct cachefiles_xattr *auxdata;
-	unsigned keylen, auxlen;
-	void *buffer, *p;
-	char *key;
-
-	cache = container_of(_cache, struct cachefiles_cache, cache);
-
-	_enter("{%s},%x,", cache->cache.identifier, cookie->debug_id);
-
-	lookup_data = kmalloc(sizeof(*lookup_data), cachefiles_gfp);
-	if (!lookup_data)
-		goto nomem_lookup_data;
-
-	/* create a new object record and a temporary leaf image */
-	object = kmem_cache_alloc(cachefiles_object_jar, cachefiles_gfp);
-	if (!object)
-		goto nomem_object;
-
-	ASSERTCMP(object->backer, ==, NULL);
-
-	BUG_ON(test_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags));
-	atomic_set(&object->usage, 1);
-
-	fscache_object_init(&object->fscache, cookie, &cache->cache);
-
-	object->type = cookie->def->type;
-
-	/* get hold of the raw key
-	 * - stick the length on the front and leave space on the back for the
-	 *   encoder
-	 */
-	buffer = kmalloc((2 + 512) + 3, cachefiles_gfp);
-	if (!buffer)
-		goto nomem_buffer;
-
-	keylen = cookie->key_len;
-	if (keylen <= sizeof(cookie->inline_key))
-		p = cookie->inline_key;
-	else
-		p = cookie->key;
-	memcpy(buffer + 2, p, keylen);
-
-	*(uint16_t *)buffer = keylen;
-	((char *)buffer)[keylen + 2] = 0;
-	((char *)buffer)[keylen + 3] = 0;
-	((char *)buffer)[keylen + 4] = 0;
-
-	/* turn the raw key into something that can work with as a filename */
-	key = cachefiles_cook_key(buffer, keylen + 2, object->type);
-	if (!key)
-		goto nomem_key;
-
-	/* get hold of the auxiliary data and prepend the object type */
-	auxdata = buffer;
-	auxlen = cookie->aux_len;
-	if (auxlen) {
-		if (auxlen <= sizeof(cookie->inline_aux))
-			p = cookie->inline_aux;
-		else
-			p = cookie->aux;
-		memcpy(auxdata->data, p, auxlen);
-	}
-
-	auxdata->len = auxlen + 1;
-	auxdata->type = cookie->type;
-
-	lookup_data->auxdata = auxdata;
-	lookup_data->key = key;
-	object->lookup_data = lookup_data;
-
-	_leave(" = %x [%p]", object->fscache.debug_id, lookup_data);
-	return &object->fscache;
-
-nomem_key:
-	kfree(buffer);
-nomem_buffer:
-	BUG_ON(test_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags));
-	kmem_cache_free(cachefiles_object_jar, object);
-	fscache_object_destroyed(&cache->cache);
-nomem_object:
-	kfree(lookup_data);
-nomem_lookup_data:
-	_leave(" = -ENOMEM");
-	return ERR_PTR(-ENOMEM);
-}
-
-/*
- * attempt to look up the nominated node in this cache
- * - return -ETIMEDOUT to be scheduled again
- */
-static int cachefiles_lookup_object(struct fscache_object *_object)
-{
-	struct cachefiles_lookup_data *lookup_data;
-	struct cachefiles_object *parent, *object;
-	struct cachefiles_cache *cache;
-	const struct cred *saved_cred;
-	int ret;
-
-	_enter("{OBJ%x}", _object->debug_id);
-
-	cache = container_of(_object->cache, struct cachefiles_cache, cache);
-	parent = container_of(_object->parent,
-			      struct cachefiles_object, fscache);
-	object = container_of(_object, struct cachefiles_object, fscache);
-	lookup_data = object->lookup_data;
-
-	ASSERTCMP(lookup_data, !=, NULL);
-
-	/* look up the key, creating any missing bits */
-	cachefiles_begin_secure(cache, &saved_cred);
-	ret = cachefiles_walk_to_object(parent, object,
-					lookup_data->key,
-					lookup_data->auxdata);
-	cachefiles_end_secure(cache, saved_cred);
-
-	/* polish off by setting the attributes of non-index files */
-	if (ret == 0 &&
-	    object->fscache.cookie->def->type != FSCACHE_COOKIE_TYPE_INDEX)
-		cachefiles_attr_changed(&object->fscache);
-
-	if (ret < 0 && ret != -ETIMEDOUT) {
-		if (ret != -ENOBUFS)
-			pr_warn("Lookup failed error %d\n", ret);
-		fscache_object_lookup_error(&object->fscache);
-	}
-
-	_leave(" [%d]", ret);
-	return ret;
-}
-
-/*
- * indication of lookup completion
- */
-static void cachefiles_lookup_complete(struct fscache_object *_object)
-{
-	struct cachefiles_object *object;
-
-	object = container_of(_object, struct cachefiles_object, fscache);
-
-	_enter("{OBJ%x,%p}", object->fscache.debug_id, object->lookup_data);
-
-	if (object->lookup_data) {
-		kfree(object->lookup_data->key);
-		kfree(object->lookup_data->auxdata);
-		kfree(object->lookup_data);
-		object->lookup_data = NULL;
-	}
-}
-
-/*
- * increment the usage count on an inode object (may fail if unmounting)
- */
-static
-struct fscache_object *cachefiles_grab_object(struct fscache_object *_object,
-					      enum fscache_obj_ref_trace why)
-{
-	struct cachefiles_object *object =
-		container_of(_object, struct cachefiles_object, fscache);
-	int u;
-
-	_enter("{OBJ%x,%d}", _object->debug_id, atomic_read(&object->usage));
-
-#ifdef CACHEFILES_DEBUG_SLAB
-	ASSERT((atomic_read(&object->usage) & 0xffff0000) != 0x6b6b0000);
-#endif
-
-	u = atomic_inc_return(&object->usage);
-	trace_cachefiles_ref(object, _object->cookie,
-			     (enum cachefiles_obj_ref_trace)why, u);
-	return &object->fscache;
-}
-
-/*
- * update the auxiliary data for an object object on disk
- */
-static void cachefiles_update_object(struct fscache_object *_object)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_xattr *auxdata;
-	struct cachefiles_cache *cache;
-	struct fscache_cookie *cookie;
-	const struct cred *saved_cred;
-	const void *aux;
-	unsigned auxlen;
-
-	_enter("{OBJ%x}", _object->debug_id);
-
-	object = container_of(_object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache, struct cachefiles_cache,
-			     cache);
-
-	if (!fscache_use_cookie(_object)) {
-		_leave(" [relinq]");
-		return;
-	}
-
-	cookie = object->fscache.cookie;
-	auxlen = cookie->aux_len;
-
-	if (!auxlen) {
-		fscache_unuse_cookie(_object);
-		_leave(" [no aux]");
-		return;
-	}
-
-	auxdata = kmalloc(2 + auxlen + 3, cachefiles_gfp);
-	if (!auxdata) {
-		fscache_unuse_cookie(_object);
-		_leave(" [nomem]");
-		return;
-	}
-
-	aux = (auxlen <= sizeof(cookie->inline_aux)) ?
-		cookie->inline_aux : cookie->aux;
-
-	memcpy(auxdata->data, aux, auxlen);
-	fscache_unuse_cookie(_object);
-
-	auxdata->len = auxlen + 1;
-	auxdata->type = cookie->type;
-
-	cachefiles_begin_secure(cache, &saved_cred);
-	cachefiles_update_object_xattr(object, auxdata);
-	cachefiles_end_secure(cache, saved_cred);
-	kfree(auxdata);
-	_leave("");
-}
-
-/*
- * discard the resources pinned by an object and effect retirement if
- * requested
- */
-static void cachefiles_drop_object(struct fscache_object *_object)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	const struct cred *saved_cred;
-	struct inode *inode;
-	blkcnt_t i_blocks = 0;
-
-	ASSERT(_object);
-
-	object = container_of(_object, struct cachefiles_object, fscache);
-
-	_enter("{OBJ%x,%d}",
-	       object->fscache.debug_id, atomic_read(&object->usage));
-
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-
-#ifdef CACHEFILES_DEBUG_SLAB
-	ASSERT((atomic_read(&object->usage) & 0xffff0000) != 0x6b6b0000);
-#endif
-
-	/* We need to tidy the object up if we did in fact manage to open it.
-	 * It's possible for us to get here before the object is fully
-	 * initialised if the parent goes away or the object gets retired
-	 * before we set it up.
-	 */
-	if (object->dentry) {
-		/* delete retired objects */
-		if (test_bit(FSCACHE_OBJECT_RETIRED, &object->fscache.flags) &&
-		    _object != cache->cache.fsdef
-		    ) {
-			_debug("- retire object OBJ%x", object->fscache.debug_id);
-			inode = d_backing_inode(object->dentry);
-			if (inode)
-				i_blocks = inode->i_blocks;
-
-			cachefiles_begin_secure(cache, &saved_cred);
-			cachefiles_delete_object(cache, object);
-			cachefiles_end_secure(cache, saved_cred);
-		}
-
-		/* close the filesystem stuff attached to the object */
-		if (object->backer != object->dentry)
-			dput(object->backer);
-		object->backer = NULL;
-	}
-
-	/* note that the object is now inactive */
-	if (test_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags))
-		cachefiles_mark_object_inactive(cache, object, i_blocks);
-
-	dput(object->dentry);
-	object->dentry = NULL;
-
-	_leave("");
-}
-
-/*
- * dispose of a reference to an object
- */
-void cachefiles_put_object(struct fscache_object *_object,
-			   enum fscache_obj_ref_trace why)
-{
-	struct cachefiles_object *object;
-	struct fscache_cache *cache;
-	int u;
-
-	ASSERT(_object);
-
-	object = container_of(_object, struct cachefiles_object, fscache);
-
-	_enter("{OBJ%x,%d}",
-	       object->fscache.debug_id, atomic_read(&object->usage));
-
-#ifdef CACHEFILES_DEBUG_SLAB
-	ASSERT((atomic_read(&object->usage) & 0xffff0000) != 0x6b6b0000);
-#endif
-
-	ASSERTIFCMP(object->fscache.parent,
-		    object->fscache.parent->n_children, >, 0);
-
-	u = atomic_dec_return(&object->usage);
-	trace_cachefiles_ref(object, _object->cookie,
-			     (enum cachefiles_obj_ref_trace)why, u);
-	ASSERTCMP(u, !=, -1);
-	if (u == 0) {
-		_debug("- kill object OBJ%x", object->fscache.debug_id);
-
-		ASSERT(!test_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags));
-		ASSERTCMP(object->fscache.parent, ==, NULL);
-		ASSERTCMP(object->backer, ==, NULL);
-		ASSERTCMP(object->dentry, ==, NULL);
-		ASSERTCMP(object->fscache.n_ops, ==, 0);
-		ASSERTCMP(object->fscache.n_children, ==, 0);
-
-		if (object->lookup_data) {
-			kfree(object->lookup_data->key);
-			kfree(object->lookup_data->auxdata);
-			kfree(object->lookup_data);
-			object->lookup_data = NULL;
-		}
-
-		cache = object->fscache.cache;
-		fscache_object_destroy(&object->fscache);
-		kmem_cache_free(cachefiles_object_jar, object);
-		fscache_object_destroyed(cache);
-	}
-
-	_leave("");
-}
-
-/*
- * sync a cache
- */
-static void cachefiles_sync_cache(struct fscache_cache *_cache)
-{
-	struct cachefiles_cache *cache;
-	const struct cred *saved_cred;
-	int ret;
-
-	_enter("%s", _cache->tag->name);
-
-	cache = container_of(_cache, struct cachefiles_cache, cache);
-
-	/* make sure all pages pinned by operations on behalf of the netfs are
-	 * written to disc */
-	cachefiles_begin_secure(cache, &saved_cred);
-	down_read(&cache->mnt->mnt_sb->s_umount);
-	ret = sync_filesystem(cache->mnt->mnt_sb);
-	up_read(&cache->mnt->mnt_sb->s_umount);
-	cachefiles_end_secure(cache, saved_cred);
-
-	if (ret == -EIO)
-		cachefiles_io_error(cache,
-				    "Attempt to sync backing fs superblock"
-				    " returned error %d",
-				    ret);
-}
-
-/*
- * check if the backing cache is updated to FS-Cache
- * - called by FS-Cache when evaluates if need to invalidate the cache
- */
-static int cachefiles_check_consistency(struct fscache_operation *op)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	const struct cred *saved_cred;
-	int ret;
-
-	_enter("{OBJ%x}", op->object->debug_id);
-
-	object = container_of(op->object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-
-	cachefiles_begin_secure(cache, &saved_cred);
-	ret = cachefiles_check_auxdata(object);
-	cachefiles_end_secure(cache, saved_cred);
-
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * notification the attributes on an object have changed
- * - called with reads/writes excluded by FS-Cache
- */
-static int cachefiles_attr_changed(struct fscache_object *_object)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	const struct cred *saved_cred;
-	struct iattr newattrs;
-	uint64_t ni_size;
-	loff_t oi_size;
-	int ret;
-
-	ni_size = _object->store_limit_l;
-
-	_enter("{OBJ%x},[%llu]",
-	       _object->debug_id, (unsigned long long) ni_size);
-
-	object = container_of(_object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-
-	if (ni_size == object->i_size)
-		return 0;
-
-	if (!object->backer)
-		return -ENOBUFS;
-
-	ASSERT(d_is_reg(object->backer));
-
-	fscache_set_store_limit(&object->fscache, ni_size);
-
-	oi_size = i_size_read(d_backing_inode(object->backer));
-	if (oi_size == ni_size)
-		return 0;
-
-	cachefiles_begin_secure(cache, &saved_cred);
-	inode_lock(d_inode(object->backer));
-
-	/* if there's an extension to a partial page at the end of the backing
-	 * file, we need to discard the partial page so that we pick up new
-	 * data after it */
-	if (oi_size & ~PAGE_MASK && ni_size > oi_size) {
-		_debug("discard tail %llx", oi_size);
-		newattrs.ia_valid = ATTR_SIZE;
-		newattrs.ia_size = oi_size & PAGE_MASK;
-		ret = notify_change(&init_user_ns, object->backer, &newattrs, NULL);
-		if (ret < 0)
-			goto truncate_failed;
-	}
-
-	newattrs.ia_valid = ATTR_SIZE;
-	newattrs.ia_size = ni_size;
-	ret = notify_change(&init_user_ns, object->backer, &newattrs, NULL);
-
-truncate_failed:
-	inode_unlock(d_inode(object->backer));
-	cachefiles_end_secure(cache, saved_cred);
-
-	if (ret == -EIO) {
-		fscache_set_store_limit(&object->fscache, 0);
-		cachefiles_io_error_obj(object, "Size set failed");
-		ret = -ENOBUFS;
-	}
-
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * Invalidate an object
- */
-static void cachefiles_invalidate_object(struct fscache_operation *op)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	const struct cred *saved_cred;
-	struct path path;
-	uint64_t ni_size;
-	int ret;
-
-	object = container_of(op->object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-
-	ni_size = op->object->store_limit_l;
-
-	_enter("{OBJ%x},[%llu]",
-	       op->object->debug_id, (unsigned long long)ni_size);
-
-	if (object->backer) {
-		ASSERT(d_is_reg(object->backer));
-
-		fscache_set_store_limit(&object->fscache, ni_size);
-
-		path.dentry = object->backer;
-		path.mnt = cache->mnt;
-
-		cachefiles_begin_secure(cache, &saved_cred);
-		ret = vfs_truncate(&path, 0);
-		if (ret == 0)
-			ret = vfs_truncate(&path, ni_size);
-		cachefiles_end_secure(cache, saved_cred);
-
-		if (ret != 0) {
-			fscache_set_store_limit(&object->fscache, 0);
-			if (ret == -EIO)
-				cachefiles_io_error_obj(object,
-							"Invalidate failed");
-		}
-	}
-
-	fscache_op_complete(op, true);
-	_leave("");
-}
-
-const struct fscache_cache_ops cachefiles_cache_ops = {
-	.name			= "cachefiles",
-	.alloc_object		= cachefiles_alloc_object,
-	.lookup_object		= cachefiles_lookup_object,
-	.lookup_complete	= cachefiles_lookup_complete,
-	.grab_object		= cachefiles_grab_object,
-	.update_object		= cachefiles_update_object,
-	.invalidate_object	= cachefiles_invalidate_object,
-	.drop_object		= cachefiles_drop_object,
-	.put_object		= cachefiles_put_object,
-	.sync_cache		= cachefiles_sync_cache,
-	.attr_changed		= cachefiles_attr_changed,
-	.check_consistency	= cachefiles_check_consistency,
-	.begin_operation	= cachefiles_begin_operation,
-};
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
deleted file mode 100644
index 7dee24d1c6f2..000000000000
--- a/fs/cachefiles/internal.h
+++ /dev/null
@@ -1,312 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/* General netfs cache on cache files internal defs
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#ifdef pr_fmt
-#undef pr_fmt
-#endif
-
-#define pr_fmt(fmt) "CacheFiles: " fmt
-
-
-#include <linux/fscache_old-cache.h>
-#include <linux/timer.h>
-#include <linux/wait_bit.h>
-#include <linux/cred.h>
-#include <linux/workqueue.h>
-#include <linux/security.h>
-
-struct cachefiles_cache;
-struct cachefiles_object;
-
-extern unsigned cachefiles_debug;
-#define CACHEFILES_DEBUG_KENTER	1
-#define CACHEFILES_DEBUG_KLEAVE	2
-#define CACHEFILES_DEBUG_KDEBUG	4
-
-#define cachefiles_gfp (__GFP_RECLAIM | __GFP_NORETRY | __GFP_NOMEMALLOC)
-
-/*
- * node records
- */
-struct cachefiles_object {
-	struct fscache_object		fscache;	/* fscache handle */
-	struct cachefiles_lookup_data	*lookup_data;	/* cached lookup data */
-	struct dentry			*dentry;	/* the file/dir representing this object */
-	struct dentry			*backer;	/* backing file */
-	loff_t				i_size;		/* object size */
-	unsigned long			flags;
-#define CACHEFILES_OBJECT_ACTIVE	0		/* T if marked active */
-	atomic_t			usage;		/* object usage count */
-	uint8_t				type;		/* object type */
-	uint8_t				new;		/* T if object new */
-	struct rb_node			active_node;	/* link in active tree (dentry is key) */
-};
-
-extern struct kmem_cache *cachefiles_object_jar;
-
-/*
- * Cache files cache definition
- */
-struct cachefiles_cache {
-	struct fscache_cache		cache;		/* FS-Cache record */
-	struct vfsmount			*mnt;		/* mountpoint holding the cache */
-	struct dentry			*graveyard;	/* directory into which dead objects go */
-	struct file			*cachefilesd;	/* manager daemon handle */
-	const struct cred		*cache_cred;	/* security override for accessing cache */
-	struct mutex			daemon_mutex;	/* command serialisation mutex */
-	wait_queue_head_t		daemon_pollwq;	/* poll waitqueue for daemon */
-	struct rb_root			active_nodes;	/* active nodes (can't be culled) */
-	rwlock_t			active_lock;	/* lock for active_nodes */
-	atomic_t			gravecounter;	/* graveyard uniquifier */
-	atomic_t			f_released;	/* number of objects released lately */
-	atomic_long_t			b_released;	/* number of blocks released lately */
-	unsigned			frun_percent;	/* when to stop culling (% files) */
-	unsigned			fcull_percent;	/* when to start culling (% files) */
-	unsigned			fstop_percent;	/* when to stop allocating (% files) */
-	unsigned			brun_percent;	/* when to stop culling (% blocks) */
-	unsigned			bcull_percent;	/* when to start culling (% blocks) */
-	unsigned			bstop_percent;	/* when to stop allocating (% blocks) */
-	unsigned			bsize;		/* cache's block size */
-	unsigned			bshift;		/* min(ilog2(PAGE_SIZE / bsize), 0) */
-	uint64_t			frun;		/* when to stop culling */
-	uint64_t			fcull;		/* when to start culling */
-	uint64_t			fstop;		/* when to stop allocating */
-	sector_t			brun;		/* when to stop culling */
-	sector_t			bcull;		/* when to start culling */
-	sector_t			bstop;		/* when to stop allocating */
-	unsigned long			flags;
-#define CACHEFILES_READY		0	/* T if cache prepared */
-#define CACHEFILES_DEAD			1	/* T if cache dead */
-#define CACHEFILES_CULLING		2	/* T if cull engaged */
-#define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
-	char				*rootdirname;	/* name of cache root directory */
-	char				*secctx;	/* LSM security context */
-	char				*tag;		/* cache binding tag */
-};
-
-/*
- * auxiliary data xattr buffer
- */
-struct cachefiles_xattr {
-	uint16_t			len;
-	uint8_t				type;
-	uint8_t				data[];
-};
-
-#include <trace/events/cachefiles.h>
-
-/*
- * note change of state for daemon
- */
-static inline void cachefiles_state_changed(struct cachefiles_cache *cache)
-{
-	set_bit(CACHEFILES_STATE_CHANGED, &cache->flags);
-	wake_up_all(&cache->daemon_pollwq);
-}
-
-/*
- * bind.c
- */
-extern int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args);
-extern void cachefiles_daemon_unbind(struct cachefiles_cache *cache);
-
-/*
- * daemon.c
- */
-extern const struct file_operations cachefiles_daemon_fops;
-
-extern int cachefiles_has_space(struct cachefiles_cache *cache,
-				unsigned fnr, unsigned bnr);
-
-/*
- * interface.c
- */
-extern const struct fscache_cache_ops cachefiles_cache_ops;
-
-void cachefiles_put_object(struct fscache_object *_object,
-			   enum fscache_obj_ref_trace why);
-
-/*
- * key.c
- */
-extern char *cachefiles_cook_key(const u8 *raw, int keylen, uint8_t type);
-
-/*
- * namei.c
- */
-extern void cachefiles_mark_object_inactive(struct cachefiles_cache *cache,
-					    struct cachefiles_object *object,
-					    blkcnt_t i_blocks);
-extern int cachefiles_delete_object(struct cachefiles_cache *cache,
-				    struct cachefiles_object *object);
-extern int cachefiles_walk_to_object(struct cachefiles_object *parent,
-				     struct cachefiles_object *object,
-				     const char *key,
-				     struct cachefiles_xattr *auxdata);
-extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
-					       struct dentry *dir,
-					       const char *name);
-
-extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
-			   char *filename);
-
-extern int cachefiles_check_in_use(struct cachefiles_cache *cache,
-				   struct dentry *dir, char *filename);
-
-/*
- * rdwr2.c
- */
-extern int cachefiles_begin_operation(struct netfs_cache_resources *,
-				      struct fscache_operation *);
-
-/*
- * security.c
- */
-extern int cachefiles_get_security_ID(struct cachefiles_cache *cache);
-extern int cachefiles_determine_cache_security(struct cachefiles_cache *cache,
-					       struct dentry *root,
-					       const struct cred **_saved_cred);
-
-static inline void cachefiles_begin_secure(struct cachefiles_cache *cache,
-					   const struct cred **_saved_cred)
-{
-	*_saved_cred = override_creds(cache->cache_cred);
-}
-
-static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
-					 const struct cred *saved_cred)
-{
-	revert_creds(saved_cred);
-}
-
-/*
- * xattr.c
- */
-extern int cachefiles_check_object_type(struct cachefiles_object *object);
-extern int cachefiles_set_object_xattr(struct cachefiles_object *object,
-				       struct cachefiles_xattr *auxdata);
-extern int cachefiles_update_object_xattr(struct cachefiles_object *object,
-					  struct cachefiles_xattr *auxdata);
-extern int cachefiles_check_auxdata(struct cachefiles_object *object);
-extern int cachefiles_check_object_xattr(struct cachefiles_object *object,
-					 struct cachefiles_xattr *auxdata);
-extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
-					  struct dentry *dentry);
-
-
-/*
- * error handling
- */
-
-#define cachefiles_io_error(___cache, FMT, ...)		\
-do {							\
-	pr_err("I/O Error: " FMT"\n", ##__VA_ARGS__);	\
-	fscache_io_error(&(___cache)->cache);		\
-	set_bit(CACHEFILES_DEAD, &(___cache)->flags);	\
-} while (0)
-
-#define cachefiles_io_error_obj(object, FMT, ...)			\
-do {									\
-	struct cachefiles_cache *___cache;				\
-									\
-	___cache = container_of((object)->fscache.cache,		\
-				struct cachefiles_cache, cache);	\
-	cachefiles_io_error(___cache, FMT, ##__VA_ARGS__);		\
-} while (0)
-
-
-/*
- * debug tracing
- */
-#define dbgprintk(FMT, ...) \
-	printk(KERN_DEBUG "[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
-
-#define kenter(FMT, ...) dbgprintk("==> %s("FMT")", __func__, ##__VA_ARGS__)
-#define kleave(FMT, ...) dbgprintk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
-#define kdebug(FMT, ...) dbgprintk(FMT, ##__VA_ARGS__)
-
-
-#if defined(__KDEBUG)
-#define _enter(FMT, ...) kenter(FMT, ##__VA_ARGS__)
-#define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
-#define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
-
-#elif defined(CONFIG_CACHEFILES_DEBUG)
-#define _enter(FMT, ...)				\
-do {							\
-	if (cachefiles_debug & CACHEFILES_DEBUG_KENTER)	\
-		kenter(FMT, ##__VA_ARGS__);		\
-} while (0)
-
-#define _leave(FMT, ...)				\
-do {							\
-	if (cachefiles_debug & CACHEFILES_DEBUG_KLEAVE)	\
-		kleave(FMT, ##__VA_ARGS__);		\
-} while (0)
-
-#define _debug(FMT, ...)				\
-do {							\
-	if (cachefiles_debug & CACHEFILES_DEBUG_KDEBUG)	\
-		kdebug(FMT, ##__VA_ARGS__);		\
-} while (0)
-
-#else
-#define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
-#define _leave(FMT, ...) no_printk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
-#define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
-#endif
-
-#if 1 /* defined(__KDEBUGALL) */
-
-#define ASSERT(X)							\
-do {									\
-	if (unlikely(!(X))) {						\
-		pr_err("\n");						\
-		pr_err("Assertion failed\n");		\
-		BUG();							\
-	}								\
-} while (0)
-
-#define ASSERTCMP(X, OP, Y)						\
-do {									\
-	if (unlikely(!((X) OP (Y)))) {					\
-		pr_err("\n");						\
-		pr_err("Assertion failed\n");		\
-		pr_err("%lx " #OP " %lx is false\n",			\
-		       (unsigned long)(X), (unsigned long)(Y));		\
-		BUG();							\
-	}								\
-} while (0)
-
-#define ASSERTIF(C, X)							\
-do {									\
-	if (unlikely((C) && !(X))) {					\
-		pr_err("\n");						\
-		pr_err("Assertion failed\n");		\
-		BUG();							\
-	}								\
-} while (0)
-
-#define ASSERTIFCMP(C, X, OP, Y)					\
-do {									\
-	if (unlikely((C) && !((X) OP (Y)))) {				\
-		pr_err("\n");						\
-		pr_err("Assertion failed\n");		\
-		pr_err("%lx " #OP " %lx is false\n",			\
-		       (unsigned long)(X), (unsigned long)(Y));		\
-		BUG();							\
-	}								\
-} while (0)
-
-#else
-
-#define ASSERT(X)			do {} while (0)
-#define ASSERTCMP(X, OP, Y)		do {} while (0)
-#define ASSERTIF(C, X)			do {} while (0)
-#define ASSERTIFCMP(C, X, OP, Y)	do {} while (0)
-
-#endif
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
deleted file mode 100644
index 5ead97de4bb7..000000000000
--- a/fs/cachefiles/io.c
+++ /dev/null
@@ -1,445 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* kiocb-using read/write
- *
- * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/mount.h>
-#include <linux/slab.h>
-#include <linux/file.h>
-#include <linux/uio.h>
-#include <linux/sched/mm.h>
-#include <linux/netfs.h>
-#include "internal.h"
-
-struct cachefiles_kiocb {
-	struct kiocb		iocb;
-	refcount_t		ki_refcnt;
-	loff_t			start;
-	union {
-		size_t		skipped;
-		size_t		len;
-	};
-	netfs_io_terminated_t	term_func;
-	void			*term_func_priv;
-	bool			was_async;
-};
-
-static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
-{
-	if (refcount_dec_and_test(&ki->ki_refcnt)) {
-		fput(ki->iocb.ki_filp);
-		kfree(ki);
-	}
-}
-
-/*
- * Handle completion of a read from the cache.
- */
-static void cachefiles_read_complete(struct kiocb *iocb, long ret, long ret2)
-{
-	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
-
-	_enter("%ld,%ld", ret, ret2);
-
-	if (ki->term_func) {
-		if (ret >= 0)
-			ret += ki->skipped;
-		ki->term_func(ki->term_func_priv, ret, ki->was_async);
-	}
-
-	cachefiles_put_kiocb(ki);
-}
-
-/*
- * Initiate a read from the cache.
- */
-static int cachefiles_read(struct netfs_cache_resources *cres,
-			   loff_t start_pos,
-			   struct iov_iter *iter,
-			   enum netfs_read_from_hole read_hole,
-			   netfs_io_terminated_t term_func,
-			   void *term_func_priv)
-{
-	struct cachefiles_kiocb *ki;
-	struct file *file = cres->cache_priv2;
-	unsigned int old_nofs;
-	ssize_t ret = -ENODATA;
-	size_t len = iov_iter_count(iter), skipped = 0;
-
-	_enter("%pD,%li,%llx,%zx/%llx",
-	       file, file_inode(file)->i_ino, start_pos, len,
-	       i_size_read(file_inode(file)));
-
-	/* If the caller asked us to seek for data before doing the read, then
-	 * we should do that now.  If we find a gap, we fill it with zeros.
-	 */
-	if (read_hole != NETFS_READ_HOLE_IGNORE) {
-		loff_t off = start_pos, off2;
-
-		off2 = vfs_llseek(file, off, SEEK_DATA);
-		if (off2 < 0 && off2 >= (loff_t)-MAX_ERRNO && off2 != -ENXIO) {
-			skipped = 0;
-			ret = off2;
-			goto presubmission_error;
-		}
-
-		if (off2 == -ENXIO || off2 >= start_pos + len) {
-			/* The region is beyond the EOF or there's no more data
-			 * in the region, so clear the rest of the buffer and
-			 * return success.
-			 */
-			if (read_hole == NETFS_READ_HOLE_FAIL)
-				goto presubmission_error;
-
-			iov_iter_zero(len, iter);
-			skipped = len;
-			ret = 0;
-			goto presubmission_error;
-		}
-
-		skipped = off2 - off;
-		iov_iter_zero(skipped, iter);
-	}
-
-	ret = -ENOBUFS;
-	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
-	if (!ki)
-		goto presubmission_error;
-
-	refcount_set(&ki->ki_refcnt, 2);
-	ki->iocb.ki_filp	= file;
-	ki->iocb.ki_pos		= start_pos + skipped;
-	ki->iocb.ki_flags	= IOCB_DIRECT;
-	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
-	ki->iocb.ki_ioprio	= get_current_ioprio();
-	ki->skipped		= skipped;
-	ki->term_func		= term_func;
-	ki->term_func_priv	= term_func_priv;
-	ki->was_async		= true;
-
-	if (ki->term_func)
-		ki->iocb.ki_complete = cachefiles_read_complete;
-
-	get_file(ki->iocb.ki_filp);
-
-	old_nofs = memalloc_nofs_save();
-	ret = vfs_iocb_iter_read(file, &ki->iocb, iter);
-	memalloc_nofs_restore(old_nofs);
-	switch (ret) {
-	case -EIOCBQUEUED:
-		goto in_progress;
-
-	case -ERESTARTSYS:
-	case -ERESTARTNOINTR:
-	case -ERESTARTNOHAND:
-	case -ERESTART_RESTARTBLOCK:
-		/* There's no easy way to restart the syscall since other AIO's
-		 * may be already running. Just fail this IO with EINTR.
-		 */
-		ret = -EINTR;
-		fallthrough;
-	default:
-		ki->was_async = false;
-		cachefiles_read_complete(&ki->iocb, ret, 0);
-		if (ret > 0)
-			ret = 0;
-		break;
-	}
-
-in_progress:
-	cachefiles_put_kiocb(ki);
-	_leave(" = %zd", ret);
-	return ret;
-
-presubmission_error:
-	if (term_func)
-		term_func(term_func_priv, ret < 0 ? ret : skipped, false);
-	return ret;
-}
-
-/*
- * Handle completion of a write to the cache.
- */
-static void cachefiles_write_complete(struct kiocb *iocb, long ret, long ret2)
-{
-	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
-	struct inode *inode = file_inode(ki->iocb.ki_filp);
-
-	_enter("%ld,%ld", ret, ret2);
-
-	/* Tell lockdep we inherited freeze protection from submission thread */
-	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
-	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
-
-	if (ki->term_func)
-		ki->term_func(ki->term_func_priv, ret, ki->was_async);
-
-	cachefiles_put_kiocb(ki);
-}
-
-/*
- * Initiate a write to the cache.
- */
-static int cachefiles_write(struct netfs_cache_resources *cres,
-			    loff_t start_pos,
-			    struct iov_iter *iter,
-			    netfs_io_terminated_t term_func,
-			    void *term_func_priv)
-{
-	struct cachefiles_kiocb *ki;
-	struct inode *inode;
-	struct file *file = cres->cache_priv2;
-	unsigned int old_nofs;
-	ssize_t ret = -ENOBUFS;
-	size_t len = iov_iter_count(iter);
-
-	_enter("%pD,%li,%llx,%zx/%llx",
-	       file, file_inode(file)->i_ino, start_pos, len,
-	       i_size_read(file_inode(file)));
-
-	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
-	if (!ki)
-		goto presubmission_error;
-
-	refcount_set(&ki->ki_refcnt, 2);
-	ki->iocb.ki_filp	= file;
-	ki->iocb.ki_pos		= start_pos;
-	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
-	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
-	ki->iocb.ki_ioprio	= get_current_ioprio();
-	ki->start		= start_pos;
-	ki->len			= len;
-	ki->term_func		= term_func;
-	ki->term_func_priv	= term_func_priv;
-	ki->was_async		= true;
-
-	if (ki->term_func)
-		ki->iocb.ki_complete = cachefiles_write_complete;
-
-	/* Open-code file_start_write here to grab freeze protection, which
-	 * will be released by another thread in aio_complete_rw().  Fool
-	 * lockdep by telling it the lock got released so that it doesn't
-	 * complain about the held lock when we return to userspace.
-	 */
-	inode = file_inode(file);
-	__sb_start_write(inode->i_sb, SB_FREEZE_WRITE);
-	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
-
-	get_file(ki->iocb.ki_filp);
-
-	old_nofs = memalloc_nofs_save();
-	ret = vfs_iocb_iter_write(file, &ki->iocb, iter);
-	memalloc_nofs_restore(old_nofs);
-	switch (ret) {
-	case -EIOCBQUEUED:
-		goto in_progress;
-
-	case -ERESTARTSYS:
-	case -ERESTARTNOINTR:
-	case -ERESTARTNOHAND:
-	case -ERESTART_RESTARTBLOCK:
-		/* There's no easy way to restart the syscall since other AIO's
-		 * may be already running. Just fail this IO with EINTR.
-		 */
-		ret = -EINTR;
-		fallthrough;
-	default:
-		ki->was_async = false;
-		cachefiles_write_complete(&ki->iocb, ret, 0);
-		if (ret > 0)
-			ret = 0;
-		break;
-	}
-
-in_progress:
-	cachefiles_put_kiocb(ki);
-	_leave(" = %zd", ret);
-	return ret;
-
-presubmission_error:
-	if (term_func)
-		term_func(term_func_priv, -ENOMEM, false);
-	return -ENOMEM;
-}
-
-/*
- * Prepare a read operation, shortening it to a cached/uncached
- * boundary as appropriate.
- */
-static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *subreq,
-						      loff_t i_size)
-{
-	struct fscache_operation *op = subreq->rreq->cache_resources.cache_priv;
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	const struct cred *saved_cred;
-	struct file *file = subreq->rreq->cache_resources.cache_priv2;
-	enum netfs_read_source ret = NETFS_DOWNLOAD_FROM_SERVER;
-	loff_t off, to;
-
-	_enter("%zx @%llx/%llx", subreq->len, subreq->start, i_size);
-
-	object = container_of(op->object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-
-	cachefiles_begin_secure(cache, &saved_cred);
-
-	if (subreq->start >= i_size) {
-		ret = NETFS_FILL_WITH_ZEROES;
-		goto out;
-	}
-
-	if (!file)
-		goto out;
-
-	if (test_bit(FSCACHE_COOKIE_NO_DATA_YET, &object->fscache.cookie->flags))
-		goto download_and_store;
-
-	off = vfs_llseek(file, subreq->start, SEEK_DATA);
-	if (off < 0 && off >= (loff_t)-MAX_ERRNO) {
-		if (off == (loff_t)-ENXIO)
-			goto download_and_store;
-		goto out;
-	}
-
-	if (off >= subreq->start + subreq->len)
-		goto download_and_store;
-
-	if (off > subreq->start) {
-		off = round_up(off, cache->bsize);
-		subreq->len = off - subreq->start;
-		goto download_and_store;
-	}
-
-	to = vfs_llseek(file, subreq->start, SEEK_HOLE);
-	if (to < 0 && to >= (loff_t)-MAX_ERRNO)
-		goto out;
-
-	if (to < subreq->start + subreq->len) {
-		if (subreq->start + subreq->len >= i_size)
-			to = round_up(to, cache->bsize);
-		else
-			to = round_down(to, cache->bsize);
-		subreq->len = to - subreq->start;
-	}
-
-	ret = NETFS_READ_FROM_CACHE;
-	goto out;
-
-download_and_store:
-	if (cachefiles_has_space(cache, 0, (subreq->len + PAGE_SIZE - 1) / PAGE_SIZE) == 0)
-		__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
-out:
-	cachefiles_end_secure(cache, saved_cred);
-	return ret;
-}
-
-/*
- * Prepare for a write to occur.
- */
-static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
-				    loff_t *_start, size_t *_len, loff_t i_size)
-{
-	loff_t start = *_start;
-	size_t len = *_len, down;
-
-	/* Round to DIO size */
-	down = start - round_down(start, PAGE_SIZE);
-	*_start = start - down;
-	*_len = round_up(down + len, PAGE_SIZE);
-	return 0;
-}
-
-/*
- * Prepare for a write to occur from the fallback I/O API.
- */
-static int cachefiles_prepare_fallback_write(struct netfs_cache_resources *cres,
-					     pgoff_t index)
-{
-	struct fscache_operation *op = cres->cache_priv;
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-
-	_enter("%lx", index);
-
-	object = container_of(op->object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-	return cachefiles_has_space(cache, 0, 1);
-}
-
-/*
- * Clean up an operation.
- */
-static void cachefiles_end_operation(struct netfs_cache_resources *cres)
-{
-	struct fscache_operation *op = cres->cache_priv;
-	struct file *file = cres->cache_priv2;
-
-	_enter("");
-
-	if (file)
-		fput(file);
-	if (op) {
-		fscache_op_complete(op, false);
-		fscache_put_operation(op);
-	}
-
-	_leave("");
-}
-
-static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
-	.end_operation		= cachefiles_end_operation,
-	.read			= cachefiles_read,
-	.write			= cachefiles_write,
-	.prepare_read		= cachefiles_prepare_read,
-	.prepare_write		= cachefiles_prepare_write,
-	.prepare_fallback_write	= cachefiles_prepare_fallback_write,
-};
-
-/*
- * Open the cache file when beginning a cache operation.
- */
-int cachefiles_begin_operation(struct netfs_cache_resources *cres,
-			       struct fscache_operation *op)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	struct path path;
-	struct file *file;
-
-	_enter("");
-
-	object = container_of(op->object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache,
-			     struct cachefiles_cache, cache);
-
-	path.mnt = cache->mnt;
-	path.dentry = object->backer;
-	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
-				   d_inode(object->backer), cache->cache_cred);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-	if (!S_ISREG(file_inode(file)->i_mode))
-		goto error_file;
-	if (unlikely(!file->f_op->read_iter) ||
-	    unlikely(!file->f_op->write_iter)) {
-		pr_notice("Cache does not support read_iter and write_iter\n");
-		goto error_file;
-	}
-
-	atomic_inc(&op->usage);
-	cres->cache_priv = op;
-	cres->cache_priv2 = file;
-	cres->ops = &cachefiles_netfs_cache_ops;
-	cres->debug_id = object->fscache.debug_id;
-	_leave("");
-	return 0;
-
-error_file:
-	fput(file);
-	return -EIO;
-}
diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
deleted file mode 100644
index 7f94efc97e23..000000000000
--- a/fs/cachefiles/key.c
+++ /dev/null
@@ -1,155 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Key to pathname encoder
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/slab.h>
-#include "internal.h"
-
-static const char cachefiles_charmap[64] =
-	"0123456789"			/* 0 - 9 */
-	"abcdefghijklmnopqrstuvwxyz"	/* 10 - 35 */
-	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"	/* 36 - 61 */
-	"_-"				/* 62 - 63 */
-	;
-
-static const char cachefiles_filecharmap[256] = {
-	/* we skip space and tab and control chars */
-	[33 ... 46] = 1,		/* '!' -> '.' */
-	/* we skip '/' as it's significant to pathwalk */
-	[48 ... 127] = 1,		/* '0' -> '~' */
-};
-
-/*
- * turn the raw key into something cooked
- * - the raw key should include the length in the two bytes at the front
- * - the key may be up to 514 bytes in length (including the length word)
- *   - "base64" encode the strange keys, mapping 3 bytes of raw to four of
- *     cooked
- *   - need to cut the cooked key into 252 char lengths (189 raw bytes)
- */
-char *cachefiles_cook_key(const u8 *raw, int keylen, uint8_t type)
-{
-	unsigned char csum, ch;
-	unsigned int acc;
-	char *key;
-	int loop, len, max, seg, mark, print;
-
-	_enter(",%d", keylen);
-
-	BUG_ON(keylen < 2 || keylen > 514);
-
-	csum = raw[0] + raw[1];
-	print = 1;
-	for (loop = 2; loop < keylen; loop++) {
-		ch = raw[loop];
-		csum += ch;
-		print &= cachefiles_filecharmap[ch];
-	}
-
-	if (print) {
-		/* if the path is usable ASCII, then we render it directly */
-		max = keylen - 2;
-		max += 2;	/* two base64'd length chars on the front */
-		max += 5;	/* @checksum/M */
-		max += 3 * 2;	/* maximum number of segment dividers (".../M")
-				 * is ((514 + 251) / 252) = 3
-				 */
-		max += 1;	/* NUL on end */
-	} else {
-		/* calculate the maximum length of the cooked key */
-		keylen = (keylen + 2) / 3;
-
-		max = keylen * 4;
-		max += 5;	/* @checksum/M */
-		max += 3 * 2;	/* maximum number of segment dividers (".../M")
-				 * is ((514 + 188) / 189) = 3
-				 */
-		max += 1;	/* NUL on end */
-	}
-
-	max += 1;	/* 2nd NUL on end */
-
-	_debug("max: %d", max);
-
-	key = kmalloc(max, cachefiles_gfp);
-	if (!key)
-		return NULL;
-
-	len = 0;
-
-	/* build the cooked key */
-	sprintf(key, "@%02x%c+", (unsigned) csum, 0);
-	len = 5;
-	mark = len - 1;
-
-	if (print) {
-		acc = *(uint16_t *) raw;
-		raw += 2;
-
-		key[len + 1] = cachefiles_charmap[acc & 63];
-		acc >>= 6;
-		key[len] = cachefiles_charmap[acc & 63];
-		len += 2;
-
-		seg = 250;
-		for (loop = keylen; loop > 0; loop--) {
-			if (seg <= 0) {
-				key[len++] = '\0';
-				mark = len;
-				key[len++] = '+';
-				seg = 252;
-			}
-
-			key[len++] = *raw++;
-			ASSERT(len < max);
-		}
-
-		switch (type) {
-		case FSCACHE_COOKIE_TYPE_INDEX:		type = 'I';	break;
-		case FSCACHE_COOKIE_TYPE_DATAFILE:	type = 'D';	break;
-		default:				type = 'S';	break;
-		}
-	} else {
-		seg = 252;
-		for (loop = keylen; loop > 0; loop--) {
-			if (seg <= 0) {
-				key[len++] = '\0';
-				mark = len;
-				key[len++] = '+';
-				seg = 252;
-			}
-
-			acc = *raw++;
-			acc |= *raw++ << 8;
-			acc |= *raw++ << 16;
-
-			_debug("acc: %06x", acc);
-
-			key[len++] = cachefiles_charmap[acc & 63];
-			acc >>= 6;
-			key[len++] = cachefiles_charmap[acc & 63];
-			acc >>= 6;
-			key[len++] = cachefiles_charmap[acc & 63];
-			acc >>= 6;
-			key[len++] = cachefiles_charmap[acc & 63];
-
-			ASSERT(len < max);
-		}
-
-		switch (type) {
-		case FSCACHE_COOKIE_TYPE_INDEX:		type = 'J';	break;
-		case FSCACHE_COOKIE_TYPE_DATAFILE:	type = 'E';	break;
-		default:				type = 'T';	break;
-		}
-	}
-
-	key[mark] = type;
-	key[len++] = 0;
-	key[len] = 0;
-
-	_leave(" = %s %d", key, len);
-	return key;
-}
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
deleted file mode 100644
index d3115106b22b..000000000000
--- a/fs/cachefiles/main.c
+++ /dev/null
@@ -1,94 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Network filesystem caching backend to use cache files on a premounted
- * filesystem
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/completion.h>
-#include <linux/slab.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/namei.h>
-#include <linux/mount.h>
-#include <linux/statfs.h>
-#include <linux/sysctl.h>
-#include <linux/miscdevice.h>
-#define CREATE_TRACE_POINTS
-#include "internal.h"
-
-unsigned cachefiles_debug;
-module_param_named(debug, cachefiles_debug, uint, S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(cachefiles_debug, "CacheFiles debugging mask");
-
-MODULE_DESCRIPTION("Mounted-filesystem based cache");
-MODULE_AUTHOR("Red Hat, Inc.");
-MODULE_LICENSE("GPL");
-
-struct kmem_cache *cachefiles_object_jar;
-
-static struct miscdevice cachefiles_dev = {
-	.minor	= MISC_DYNAMIC_MINOR,
-	.name	= "cachefiles",
-	.fops	= &cachefiles_daemon_fops,
-};
-
-static void cachefiles_object_init_once(void *_object)
-{
-	struct cachefiles_object *object = _object;
-
-	memset(object, 0, sizeof(*object));
-}
-
-/*
- * initialise the fs caching module
- */
-static int __init cachefiles_init(void)
-{
-	int ret;
-
-	ret = misc_register(&cachefiles_dev);
-	if (ret < 0)
-		goto error_dev;
-
-	/* create an object jar */
-	ret = -ENOMEM;
-	cachefiles_object_jar =
-		kmem_cache_create("cachefiles_object_jar",
-				  sizeof(struct cachefiles_object),
-				  0,
-				  SLAB_HWCACHE_ALIGN,
-				  cachefiles_object_init_once);
-	if (!cachefiles_object_jar) {
-		pr_notice("Failed to allocate an object jar\n");
-		goto error_object_jar;
-	}
-
-	pr_info("Loaded\n");
-	return 0;
-
-error_object_jar:
-	misc_deregister(&cachefiles_dev);
-error_dev:
-	pr_err("failed to register: %d\n", ret);
-	return ret;
-}
-
-fs_initcall(cachefiles_init);
-
-/*
- * clean up on module removal
- */
-static void __exit cachefiles_exit(void)
-{
-	pr_info("Unloading\n");
-
-	kmem_cache_destroy(cachefiles_object_jar);
-	misc_deregister(&cachefiles_dev);
-}
-
-module_exit(cachefiles_exit);
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
deleted file mode 100644
index a9aca5ab5970..000000000000
--- a/fs/cachefiles/namei.c
+++ /dev/null
@@ -1,1018 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* CacheFiles path walking and related routines
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/file.h>
-#include <linux/fs.h>
-#include <linux/fsnotify.h>
-#include <linux/quotaops.h>
-#include <linux/xattr.h>
-#include <linux/mount.h>
-#include <linux/namei.h>
-#include <linux/security.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-#define CACHEFILES_KEYBUF_SIZE 512
-
-/*
- * dump debugging info about an object
- */
-static noinline
-void __cachefiles_printk_object(struct cachefiles_object *object,
-				const char *prefix)
-{
-	struct fscache_cookie *cookie;
-	const u8 *k;
-	unsigned loop;
-
-	pr_err("%sobject: OBJ%x\n", prefix, object->fscache.debug_id);
-	pr_err("%sobjstate=%s fl=%lx wbusy=%x ev=%lx[%lx]\n",
-	       prefix, object->fscache.state->name,
-	       object->fscache.flags, work_busy(&object->fscache.work),
-	       object->fscache.events, object->fscache.event_mask);
-	pr_err("%sops=%u inp=%u exc=%u\n",
-	       prefix, object->fscache.n_ops, object->fscache.n_in_progress,
-	       object->fscache.n_exclusive);
-	pr_err("%sparent=%x\n",
-	       prefix, object->fscache.parent ? object->fscache.parent->debug_id : 0);
-
-	spin_lock(&object->fscache.lock);
-	cookie = object->fscache.cookie;
-	if (cookie) {
-		pr_err("%scookie=%x [pr=%x nd=%p fl=%lx]\n",
-		       prefix,
-		       cookie->debug_id,
-		       cookie->parent ? cookie->parent->debug_id : 0,
-		       cookie->netfs_data,
-		       cookie->flags);
-		pr_err("%skey=[%u] '", prefix, cookie->key_len);
-		k = (cookie->key_len <= sizeof(cookie->inline_key)) ?
-			cookie->inline_key : cookie->key;
-		for (loop = 0; loop < cookie->key_len; loop++)
-			pr_cont("%02x", k[loop]);
-		pr_cont("'\n");
-	} else {
-		pr_err("%scookie=NULL\n", prefix);
-	}
-	spin_unlock(&object->fscache.lock);
-}
-
-/*
- * dump debugging info about a pair of objects
- */
-static noinline void cachefiles_printk_object(struct cachefiles_object *object,
-					      struct cachefiles_object *xobject)
-{
-	if (object)
-		__cachefiles_printk_object(object, "");
-	if (xobject)
-		__cachefiles_printk_object(xobject, "x");
-}
-
-/*
- * mark the owner of a dentry, if there is one, to indicate that that dentry
- * has been preemptively deleted
- * - the caller must hold the i_mutex on the dentry's parent as required to
- *   call vfs_unlink(), vfs_rmdir() or vfs_rename()
- */
-static void cachefiles_mark_object_buried(struct cachefiles_cache *cache,
-					  struct dentry *dentry,
-					  enum fscache_why_object_killed why)
-{
-	struct cachefiles_object *object;
-	struct rb_node *p;
-
-	_enter(",'%pd'", dentry);
-
-	write_lock(&cache->active_lock);
-
-	p = cache->active_nodes.rb_node;
-	while (p) {
-		object = rb_entry(p, struct cachefiles_object, active_node);
-		if (object->dentry > dentry)
-			p = p->rb_left;
-		else if (object->dentry < dentry)
-			p = p->rb_right;
-		else
-			goto found_dentry;
-	}
-
-	write_unlock(&cache->active_lock);
-	trace_cachefiles_mark_buried(NULL, dentry, why);
-	_leave(" [no owner]");
-	return;
-
-	/* found the dentry for  */
-found_dentry:
-	kdebug("preemptive burial: OBJ%x [%s] %pd",
-	       object->fscache.debug_id,
-	       object->fscache.state->name,
-	       dentry);
-
-	trace_cachefiles_mark_buried(object, dentry, why);
-
-	if (fscache_object_is_live(&object->fscache)) {
-		pr_err("\n");
-		pr_err("Error: Can't preemptively bury live object\n");
-		cachefiles_printk_object(object, NULL);
-	} else {
-		if (why != FSCACHE_OBJECT_IS_STALE)
-			fscache_object_mark_killed(&object->fscache, why);
-	}
-
-	write_unlock(&cache->active_lock);
-	_leave(" [owner marked]");
-}
-
-/*
- * record the fact that an object is now active
- */
-static int cachefiles_mark_object_active(struct cachefiles_cache *cache,
-					 struct cachefiles_object *object)
-{
-	struct cachefiles_object *xobject;
-	struct rb_node **_p, *_parent = NULL;
-	struct dentry *dentry;
-
-	_enter(",%x", object->fscache.debug_id);
-
-try_again:
-	write_lock(&cache->active_lock);
-
-	dentry = object->dentry;
-	trace_cachefiles_mark_active(object, dentry);
-
-	if (test_and_set_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags)) {
-		pr_err("Error: Object already active\n");
-		cachefiles_printk_object(object, NULL);
-		BUG();
-	}
-
-	_p = &cache->active_nodes.rb_node;
-	while (*_p) {
-		_parent = *_p;
-		xobject = rb_entry(_parent,
-				   struct cachefiles_object, active_node);
-
-		ASSERT(xobject != object);
-
-		if (xobject->dentry > dentry)
-			_p = &(*_p)->rb_left;
-		else if (xobject->dentry < dentry)
-			_p = &(*_p)->rb_right;
-		else
-			goto wait_for_old_object;
-	}
-
-	rb_link_node(&object->active_node, _parent, _p);
-	rb_insert_color(&object->active_node, &cache->active_nodes);
-
-	write_unlock(&cache->active_lock);
-	_leave(" = 0");
-	return 0;
-
-	/* an old object from a previous incarnation is hogging the slot - we
-	 * need to wait for it to be destroyed */
-wait_for_old_object:
-	trace_cachefiles_wait_active(object, dentry, xobject);
-	clear_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags);
-
-	if (fscache_object_is_live(&xobject->fscache)) {
-		pr_err("\n");
-		pr_err("Error: Unexpected object collision\n");
-		cachefiles_printk_object(object, xobject);
-	}
-	atomic_inc(&xobject->usage);
-	write_unlock(&cache->active_lock);
-
-	if (test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags)) {
-		wait_queue_head_t *wq;
-
-		signed long timeout = 60 * HZ;
-		wait_queue_entry_t wait;
-		bool requeue;
-
-		/* if the object we're waiting for is queued for processing,
-		 * then just put ourselves on the queue behind it */
-		if (work_pending(&xobject->fscache.work)) {
-			_debug("queue OBJ%x behind OBJ%x immediately",
-			       object->fscache.debug_id,
-			       xobject->fscache.debug_id);
-			goto requeue;
-		}
-
-		/* otherwise we sleep until either the object we're waiting for
-		 * is done, or the fscache_object is congested */
-		wq = bit_waitqueue(&xobject->flags, CACHEFILES_OBJECT_ACTIVE);
-		init_wait(&wait);
-		requeue = false;
-		do {
-			prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
-			if (!test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags))
-				break;
-
-			requeue = fscache_object_sleep_till_congested(&timeout);
-		} while (timeout > 0 && !requeue);
-		finish_wait(wq, &wait);
-
-		if (requeue &&
-		    test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags)) {
-			_debug("queue OBJ%x behind OBJ%x after wait",
-			       object->fscache.debug_id,
-			       xobject->fscache.debug_id);
-			goto requeue;
-		}
-
-		if (timeout <= 0) {
-			pr_err("\n");
-			pr_err("Error: Overlong wait for old active object to go away\n");
-			cachefiles_printk_object(object, xobject);
-			goto requeue;
-		}
-	}
-
-	ASSERT(!test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags));
-
-	cache->cache.ops->put_object(&xobject->fscache,
-		(enum fscache_obj_ref_trace)cachefiles_obj_put_wait_retry);
-	goto try_again;
-
-requeue:
-	cache->cache.ops->put_object(&xobject->fscache,
-		(enum fscache_obj_ref_trace)cachefiles_obj_put_wait_timeo);
-	_leave(" = -ETIMEDOUT");
-	return -ETIMEDOUT;
-}
-
-/*
- * Mark an object as being inactive.
- */
-void cachefiles_mark_object_inactive(struct cachefiles_cache *cache,
-				     struct cachefiles_object *object,
-				     blkcnt_t i_blocks)
-{
-	struct dentry *dentry = object->dentry;
-	struct inode *inode = d_backing_inode(dentry);
-
-	trace_cachefiles_mark_inactive(object, dentry, inode);
-
-	write_lock(&cache->active_lock);
-	rb_erase(&object->active_node, &cache->active_nodes);
-	clear_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags);
-	write_unlock(&cache->active_lock);
-
-	wake_up_bit(&object->flags, CACHEFILES_OBJECT_ACTIVE);
-
-	/* This object can now be culled, so we need to let the daemon know
-	 * that there is something it can remove if it needs to.
-	 */
-	atomic_long_add(i_blocks, &cache->b_released);
-	if (atomic_inc_return(&cache->f_released))
-		cachefiles_state_changed(cache);
-}
-
-/*
- * delete an object representation from the cache
- * - file backed objects are unlinked
- * - directory backed objects are stuffed into the graveyard for userspace to
- *   delete
- * - unlocks the directory mutex
- */
-static int cachefiles_bury_object(struct cachefiles_cache *cache,
-				  struct cachefiles_object *object,
-				  struct dentry *dir,
-				  struct dentry *rep,
-				  bool preemptive,
-				  enum fscache_why_object_killed why)
-{
-	struct dentry *grave, *trap;
-	struct path path, path_to_graveyard;
-	char nbuffer[8 + 8 + 1];
-	int ret;
-
-	_enter(",'%pd','%pd'", dir, rep);
-
-	/* non-directories can just be unlinked */
-	if (!d_is_dir(rep)) {
-		_debug("unlink stale object");
-
-		path.mnt = cache->mnt;
-		path.dentry = dir;
-		ret = security_path_unlink(&path, rep);
-		if (ret < 0) {
-			cachefiles_io_error(cache, "Unlink security error");
-		} else {
-			trace_cachefiles_unlink(object, rep, why);
-			ret = vfs_unlink(&init_user_ns, d_inode(dir), rep,
-					 NULL);
-
-			if (preemptive)
-				cachefiles_mark_object_buried(cache, rep, why);
-		}
-
-		inode_unlock(d_inode(dir));
-
-		if (ret == -EIO)
-			cachefiles_io_error(cache, "Unlink failed");
-
-		_leave(" = %d", ret);
-		return ret;
-	}
-
-	/* directories have to be moved to the graveyard */
-	_debug("move stale object to graveyard");
-	inode_unlock(d_inode(dir));
-
-try_again:
-	/* first step is to make up a grave dentry in the graveyard */
-	sprintf(nbuffer, "%08x%08x",
-		(uint32_t) ktime_get_real_seconds(),
-		(uint32_t) atomic_inc_return(&cache->gravecounter));
-
-	/* do the multiway lock magic */
-	trap = lock_rename(cache->graveyard, dir);
-
-	/* do some checks before getting the grave dentry */
-	if (rep->d_parent != dir || IS_DEADDIR(d_inode(rep))) {
-		/* the entry was probably culled when we dropped the parent dir
-		 * lock */
-		unlock_rename(cache->graveyard, dir);
-		_leave(" = 0 [culled?]");
-		return 0;
-	}
-
-	if (!d_can_lookup(cache->graveyard)) {
-		unlock_rename(cache->graveyard, dir);
-		cachefiles_io_error(cache, "Graveyard no longer a directory");
-		return -EIO;
-	}
-
-	if (trap == rep) {
-		unlock_rename(cache->graveyard, dir);
-		cachefiles_io_error(cache, "May not make directory loop");
-		return -EIO;
-	}
-
-	if (d_mountpoint(rep)) {
-		unlock_rename(cache->graveyard, dir);
-		cachefiles_io_error(cache, "Mountpoint in cache");
-		return -EIO;
-	}
-
-	grave = lookup_one_len(nbuffer, cache->graveyard, strlen(nbuffer));
-	if (IS_ERR(grave)) {
-		unlock_rename(cache->graveyard, dir);
-
-		if (PTR_ERR(grave) == -ENOMEM) {
-			_leave(" = -ENOMEM");
-			return -ENOMEM;
-		}
-
-		cachefiles_io_error(cache, "Lookup error %ld",
-				    PTR_ERR(grave));
-		return -EIO;
-	}
-
-	if (d_is_positive(grave)) {
-		unlock_rename(cache->graveyard, dir);
-		dput(grave);
-		grave = NULL;
-		cond_resched();
-		goto try_again;
-	}
-
-	if (d_mountpoint(grave)) {
-		unlock_rename(cache->graveyard, dir);
-		dput(grave);
-		cachefiles_io_error(cache, "Mountpoint in graveyard");
-		return -EIO;
-	}
-
-	/* target should not be an ancestor of source */
-	if (trap == grave) {
-		unlock_rename(cache->graveyard, dir);
-		dput(grave);
-		cachefiles_io_error(cache, "May not make directory loop");
-		return -EIO;
-	}
-
-	/* attempt the rename */
-	path.mnt = cache->mnt;
-	path.dentry = dir;
-	path_to_graveyard.mnt = cache->mnt;
-	path_to_graveyard.dentry = cache->graveyard;
-	ret = security_path_rename(&path, rep, &path_to_graveyard, grave, 0);
-	if (ret < 0) {
-		cachefiles_io_error(cache, "Rename security error %d", ret);
-	} else {
-		struct renamedata rd = {
-			.old_mnt_userns	= &init_user_ns,
-			.old_dir	= d_inode(dir),
-			.old_dentry	= rep,
-			.new_mnt_userns	= &init_user_ns,
-			.new_dir	= d_inode(cache->graveyard),
-			.new_dentry	= grave,
-		};
-		trace_cachefiles_rename(object, rep, grave, why);
-		ret = vfs_rename(&rd);
-		if (ret != 0 && ret != -ENOMEM)
-			cachefiles_io_error(cache,
-					    "Rename failed with error %d", ret);
-
-		if (preemptive)
-			cachefiles_mark_object_buried(cache, rep, why);
-	}
-
-	unlock_rename(cache->graveyard, dir);
-	dput(grave);
-	_leave(" = 0");
-	return 0;
-}
-
-/*
- * delete an object representation from the cache
- */
-int cachefiles_delete_object(struct cachefiles_cache *cache,
-			     struct cachefiles_object *object)
-{
-	struct dentry *dir;
-	int ret;
-
-	_enter(",OBJ%x{%pd}", object->fscache.debug_id, object->dentry);
-
-	ASSERT(object->dentry);
-	ASSERT(d_backing_inode(object->dentry));
-	ASSERT(object->dentry->d_parent);
-
-	dir = dget_parent(object->dentry);
-
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
-
-	if (test_bit(FSCACHE_OBJECT_KILLED_BY_CACHE, &object->fscache.flags)) {
-		/* object allocation for the same key preemptively deleted this
-		 * object's file so that it could create its own file */
-		_debug("object preemptively buried");
-		inode_unlock(d_inode(dir));
-		ret = 0;
-	} else {
-		/* we need to check that our parent is _still_ our parent - it
-		 * may have been renamed */
-		if (dir == object->dentry->d_parent) {
-			ret = cachefiles_bury_object(cache, object, dir,
-						     object->dentry, false,
-						     FSCACHE_OBJECT_WAS_RETIRED);
-		} else {
-			/* it got moved, presumably by cachefilesd culling it,
-			 * so it's no longer in the key path and we can ignore
-			 * it */
-			inode_unlock(d_inode(dir));
-			ret = 0;
-		}
-	}
-
-	dput(dir);
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * walk from the parent object to the child object through the backing
- * filesystem, creating directories as we go
- */
-int cachefiles_walk_to_object(struct cachefiles_object *parent,
-			      struct cachefiles_object *object,
-			      const char *key,
-			      struct cachefiles_xattr *auxdata)
-{
-	struct cachefiles_cache *cache;
-	struct dentry *dir, *next = NULL;
-	struct inode *inode;
-	struct path path;
-	const char *name;
-	int ret, nlen;
-
-	_enter("OBJ%x{%pd},OBJ%x,%s,",
-	       parent->fscache.debug_id, parent->dentry,
-	       object->fscache.debug_id, key);
-
-	cache = container_of(parent->fscache.cache,
-			     struct cachefiles_cache, cache);
-	path.mnt = cache->mnt;
-
-	ASSERT(parent->dentry);
-	ASSERT(d_backing_inode(parent->dentry));
-
-	if (!(d_is_dir(parent->dentry))) {
-		// TODO: convert file to dir
-		_leave("looking up in none directory");
-		return -ENOBUFS;
-	}
-
-	dir = dget(parent->dentry);
-
-advance:
-	/* attempt to transit the first directory component */
-	name = key;
-	nlen = strlen(key);
-
-	/* key ends in a double NUL */
-	key = key + nlen + 1;
-	if (!*key)
-		key = NULL;
-
-lookup_again:
-	/* search the current directory for the element name */
-	_debug("lookup '%s'", name);
-
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
-
-	next = lookup_one_len(name, dir, nlen);
-	if (IS_ERR(next)) {
-		trace_cachefiles_lookup(object, next, NULL);
-		goto lookup_error;
-	}
-
-	inode = d_backing_inode(next);
-	trace_cachefiles_lookup(object, next, inode);
-	_debug("next -> %pd %s", next, inode ? "positive" : "negative");
-
-	if (!key)
-		object->new = !inode;
-
-	/* if this element of the path doesn't exist, then the lookup phase
-	 * failed, and we can release any readers in the certain knowledge that
-	 * there's nothing for them to actually read */
-	if (d_is_negative(next))
-		fscache_object_lookup_negative(&object->fscache);
-
-	/* we need to create the object if it's negative */
-	if (key || object->type == FSCACHE_COOKIE_TYPE_INDEX) {
-		/* index objects and intervening tree levels must be subdirs */
-		if (d_is_negative(next)) {
-			ret = cachefiles_has_space(cache, 1, 0);
-			if (ret < 0)
-				goto no_space_error;
-
-			path.dentry = dir;
-			ret = security_path_mkdir(&path, next, 0);
-			if (ret < 0)
-				goto create_error;
-			ret = vfs_mkdir(&init_user_ns, d_inode(dir), next, 0);
-			if (!key)
-				trace_cachefiles_mkdir(object, next, ret);
-			if (ret < 0)
-				goto create_error;
-
-			if (unlikely(d_unhashed(next))) {
-				dput(next);
-				inode_unlock(d_inode(dir));
-				goto lookup_again;
-			}
-			ASSERT(d_backing_inode(next));
-
-			_debug("mkdir -> %pd{ino=%lu}",
-			       next, d_backing_inode(next)->i_ino);
-
-		} else if (!d_can_lookup(next)) {
-			pr_err("inode %lu is not a directory\n",
-			       d_backing_inode(next)->i_ino);
-			ret = -ENOBUFS;
-			goto error;
-		}
-
-	} else {
-		/* non-index objects start out life as files */
-		if (d_is_negative(next)) {
-			ret = cachefiles_has_space(cache, 1, 0);
-			if (ret < 0)
-				goto no_space_error;
-
-			path.dentry = dir;
-			ret = security_path_mknod(&path, next, S_IFREG, 0);
-			if (ret < 0)
-				goto create_error;
-			ret = vfs_create(&init_user_ns, d_inode(dir), next,
-					 S_IFREG, true);
-			trace_cachefiles_create(object, next, ret);
-			if (ret < 0)
-				goto create_error;
-
-			ASSERT(d_backing_inode(next));
-
-			_debug("create -> %pd{ino=%lu}",
-			       next, d_backing_inode(next)->i_ino);
-
-		} else if (!d_can_lookup(next) &&
-			   !d_is_reg(next)
-			   ) {
-			pr_err("inode %lu is not a file or directory\n",
-			       d_backing_inode(next)->i_ino);
-			ret = -ENOBUFS;
-			goto error;
-		}
-	}
-
-	/* process the next component */
-	if (key) {
-		_debug("advance");
-		inode_unlock(d_inode(dir));
-		dput(dir);
-		dir = next;
-		next = NULL;
-		goto advance;
-	}
-
-	/* we've found the object we were looking for */
-	object->dentry = next;
-
-	/* if we've found that the terminal object exists, then we need to
-	 * check its attributes and delete it if it's out of date */
-	if (!object->new) {
-		_debug("validate '%pd'", next);
-
-		ret = cachefiles_check_object_xattr(object, auxdata);
-		if (ret == -ESTALE) {
-			/* delete the object (the deleter drops the directory
-			 * mutex) */
-			object->dentry = NULL;
-
-			ret = cachefiles_bury_object(cache, object, dir, next,
-						     true,
-						     FSCACHE_OBJECT_IS_STALE);
-			dput(next);
-			next = NULL;
-
-			if (ret < 0)
-				goto delete_error;
-
-			_debug("redo lookup");
-			fscache_object_retrying_stale(&object->fscache);
-			goto lookup_again;
-		}
-	}
-
-	/* note that we're now using this object */
-	ret = cachefiles_mark_object_active(cache, object);
-
-	inode_unlock(d_inode(dir));
-	dput(dir);
-	dir = NULL;
-
-	if (ret == -ETIMEDOUT)
-		goto mark_active_timed_out;
-
-	_debug("=== OBTAINED_OBJECT ===");
-
-	if (object->new) {
-		/* attach data to a newly constructed terminal object */
-		ret = cachefiles_set_object_xattr(object, auxdata);
-		if (ret < 0)
-			goto check_error;
-	} else {
-		/* always update the atime on an object we've just looked up
-		 * (this is used to keep track of culling, and atimes are only
-		 * updated by read, write and readdir but not lookup or
-		 * open) */
-		path.dentry = next;
-		touch_atime(&path);
-	}
-
-	/* open a file interface onto a data file */
-	if (object->type != FSCACHE_COOKIE_TYPE_INDEX) {
-		if (d_is_reg(object->dentry)) {
-			const struct address_space_operations *aops;
-
-			ret = -EPERM;
-			aops = d_backing_inode(object->dentry)->i_mapping->a_ops;
-			if (!aops->bmap)
-				goto check_error;
-			if (object->dentry->d_sb->s_blocksize > PAGE_SIZE)
-				goto check_error;
-
-			object->backer = object->dentry;
-		} else {
-			BUG(); // TODO: open file in data-class subdir
-		}
-	}
-
-	object->new = 0;
-	fscache_obtained_object(&object->fscache);
-
-	_leave(" = 0 [%lu]", d_backing_inode(object->dentry)->i_ino);
-	return 0;
-
-no_space_error:
-	fscache_object_mark_killed(&object->fscache, FSCACHE_OBJECT_NO_SPACE);
-create_error:
-	_debug("create error %d", ret);
-	if (ret == -EIO)
-		cachefiles_io_error(cache, "Create/mkdir failed");
-	goto error;
-
-mark_active_timed_out:
-	_debug("mark active timed out");
-	goto release_dentry;
-
-check_error:
-	_debug("check error %d", ret);
-	cachefiles_mark_object_inactive(
-		cache, object, d_backing_inode(object->dentry)->i_blocks);
-release_dentry:
-	dput(object->dentry);
-	object->dentry = NULL;
-	goto error_out;
-
-delete_error:
-	_debug("delete error %d", ret);
-	goto error_out2;
-
-lookup_error:
-	_debug("lookup error %ld", PTR_ERR(next));
-	ret = PTR_ERR(next);
-	if (ret == -EIO)
-		cachefiles_io_error(cache, "Lookup failed");
-	next = NULL;
-error:
-	inode_unlock(d_inode(dir));
-	dput(next);
-error_out2:
-	dput(dir);
-error_out:
-	_leave(" = error %d", -ret);
-	return ret;
-}
-
-/*
- * get a subdirectory
- */
-struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
-					struct dentry *dir,
-					const char *dirname)
-{
-	struct dentry *subdir;
-	struct path path;
-	int ret;
-
-	_enter(",,%s", dirname);
-
-	/* search the current directory for the element name */
-	inode_lock(d_inode(dir));
-
-retry:
-	subdir = lookup_one_len(dirname, dir, strlen(dirname));
-	if (IS_ERR(subdir)) {
-		if (PTR_ERR(subdir) == -ENOMEM)
-			goto nomem_d_alloc;
-		goto lookup_error;
-	}
-
-	_debug("subdir -> %pd %s",
-	       subdir, d_backing_inode(subdir) ? "positive" : "negative");
-
-	/* we need to create the subdir if it doesn't exist yet */
-	if (d_is_negative(subdir)) {
-		ret = cachefiles_has_space(cache, 1, 0);
-		if (ret < 0)
-			goto mkdir_error;
-
-		_debug("attempt mkdir");
-
-		path.mnt = cache->mnt;
-		path.dentry = dir;
-		ret = security_path_mkdir(&path, subdir, 0700);
-		if (ret < 0)
-			goto mkdir_error;
-		ret = vfs_mkdir(&init_user_ns, d_inode(dir), subdir, 0700);
-		if (ret < 0)
-			goto mkdir_error;
-
-		if (unlikely(d_unhashed(subdir))) {
-			dput(subdir);
-			goto retry;
-		}
-		ASSERT(d_backing_inode(subdir));
-
-		_debug("mkdir -> %pd{ino=%lu}",
-		       subdir, d_backing_inode(subdir)->i_ino);
-	}
-
-	inode_unlock(d_inode(dir));
-
-	/* we need to make sure the subdir is a directory */
-	ASSERT(d_backing_inode(subdir));
-
-	if (!d_can_lookup(subdir)) {
-		pr_err("%s is not a directory\n", dirname);
-		ret = -EIO;
-		goto check_error;
-	}
-
-	ret = -EPERM;
-	if (!(d_backing_inode(subdir)->i_opflags & IOP_XATTR) ||
-	    !d_backing_inode(subdir)->i_op->lookup ||
-	    !d_backing_inode(subdir)->i_op->mkdir ||
-	    !d_backing_inode(subdir)->i_op->create ||
-	    !d_backing_inode(subdir)->i_op->rename ||
-	    !d_backing_inode(subdir)->i_op->rmdir ||
-	    !d_backing_inode(subdir)->i_op->unlink)
-		goto check_error;
-
-	_leave(" = [%lu]", d_backing_inode(subdir)->i_ino);
-	return subdir;
-
-check_error:
-	dput(subdir);
-	_leave(" = %d [check]", ret);
-	return ERR_PTR(ret);
-
-mkdir_error:
-	inode_unlock(d_inode(dir));
-	dput(subdir);
-	pr_err("mkdir %s failed with error %d\n", dirname, ret);
-	return ERR_PTR(ret);
-
-lookup_error:
-	inode_unlock(d_inode(dir));
-	ret = PTR_ERR(subdir);
-	pr_err("Lookup %s failed with error %d\n", dirname, ret);
-	return ERR_PTR(ret);
-
-nomem_d_alloc:
-	inode_unlock(d_inode(dir));
-	_leave(" = -ENOMEM");
-	return ERR_PTR(-ENOMEM);
-}
-
-/*
- * find out if an object is in use or not
- * - if finds object and it's not in use:
- *   - returns a pointer to the object and a reference on it
- *   - returns with the directory locked
- */
-static struct dentry *cachefiles_check_active(struct cachefiles_cache *cache,
-					      struct dentry *dir,
-					      char *filename)
-{
-	struct cachefiles_object *object;
-	struct rb_node *_n;
-	struct dentry *victim;
-	int ret;
-
-	//_enter(",%pd/,%s",
-	//       dir, filename);
-
-	/* look up the victim */
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
-
-	victim = lookup_one_len(filename, dir, strlen(filename));
-	if (IS_ERR(victim))
-		goto lookup_error;
-
-	//_debug("victim -> %pd %s",
-	//       victim, d_backing_inode(victim) ? "positive" : "negative");
-
-	/* if the object is no longer there then we probably retired the object
-	 * at the netfs's request whilst the cull was in progress
-	 */
-	if (d_is_negative(victim)) {
-		inode_unlock(d_inode(dir));
-		dput(victim);
-		_leave(" = -ENOENT [absent]");
-		return ERR_PTR(-ENOENT);
-	}
-
-	/* check to see if we're using this object */
-	read_lock(&cache->active_lock);
-
-	_n = cache->active_nodes.rb_node;
-
-	while (_n) {
-		object = rb_entry(_n, struct cachefiles_object, active_node);
-
-		if (object->dentry > victim)
-			_n = _n->rb_left;
-		else if (object->dentry < victim)
-			_n = _n->rb_right;
-		else
-			goto object_in_use;
-	}
-
-	read_unlock(&cache->active_lock);
-
-	//_leave(" = %pd", victim);
-	return victim;
-
-object_in_use:
-	read_unlock(&cache->active_lock);
-	inode_unlock(d_inode(dir));
-	dput(victim);
-	//_leave(" = -EBUSY [in use]");
-	return ERR_PTR(-EBUSY);
-
-lookup_error:
-	inode_unlock(d_inode(dir));
-	ret = PTR_ERR(victim);
-	if (ret == -ENOENT) {
-		/* file or dir now absent - probably retired by netfs */
-		_leave(" = -ESTALE [absent]");
-		return ERR_PTR(-ESTALE);
-	}
-
-	if (ret == -EIO) {
-		cachefiles_io_error(cache, "Lookup failed");
-	} else if (ret != -ENOMEM) {
-		pr_err("Internal error: %d\n", ret);
-		ret = -EIO;
-	}
-
-	_leave(" = %d", ret);
-	return ERR_PTR(ret);
-}
-
-/*
- * cull an object if it's not in use
- * - called only by cache manager daemon
- */
-int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
-		    char *filename)
-{
-	struct dentry *victim;
-	int ret;
-
-	_enter(",%pd/,%s", dir, filename);
-
-	victim = cachefiles_check_active(cache, dir, filename);
-	if (IS_ERR(victim))
-		return PTR_ERR(victim);
-
-	_debug("victim -> %pd %s",
-	       victim, d_backing_inode(victim) ? "positive" : "negative");
-
-	/* okay... the victim is not being used so we can cull it
-	 * - start by marking it as stale
-	 */
-	_debug("victim is cullable");
-
-	ret = cachefiles_remove_object_xattr(cache, victim);
-	if (ret < 0)
-		goto error_unlock;
-
-	/*  actually remove the victim (drops the dir mutex) */
-	_debug("bury");
-
-	ret = cachefiles_bury_object(cache, NULL, dir, victim, false,
-				     FSCACHE_OBJECT_WAS_CULLED);
-	if (ret < 0)
-		goto error;
-
-	dput(victim);
-	_leave(" = 0");
-	return 0;
-
-error_unlock:
-	inode_unlock(d_inode(dir));
-error:
-	dput(victim);
-	if (ret == -ENOENT) {
-		/* file or dir now absent - probably retired by netfs */
-		_leave(" = -ESTALE [absent]");
-		return -ESTALE;
-	}
-
-	if (ret != -ENOMEM) {
-		pr_err("Internal error: %d\n", ret);
-		ret = -EIO;
-	}
-
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * find out if an object is in use or not
- * - called only by cache manager daemon
- * - returns -EBUSY or 0 to indicate whether an object is in use or not
- */
-int cachefiles_check_in_use(struct cachefiles_cache *cache, struct dentry *dir,
-			    char *filename)
-{
-	struct dentry *victim;
-
-	//_enter(",%pd/,%s",
-	//       dir, filename);
-
-	victim = cachefiles_check_active(cache, dir, filename);
-	if (IS_ERR(victim))
-		return PTR_ERR(victim);
-
-	inode_unlock(d_inode(dir));
-	dput(victim);
-	//_leave(" = 0");
-	return 0;
-}
diff --git a/fs/cachefiles/security.c b/fs/cachefiles/security.c
deleted file mode 100644
index aec13fd94692..000000000000
--- a/fs/cachefiles/security.c
+++ /dev/null
@@ -1,112 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* CacheFiles security management
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/fs.h>
-#include <linux/cred.h>
-#include "internal.h"
-
-/*
- * determine the security context within which we access the cache from within
- * the kernel
- */
-int cachefiles_get_security_ID(struct cachefiles_cache *cache)
-{
-	struct cred *new;
-	int ret;
-
-	_enter("{%s}", cache->secctx);
-
-	new = prepare_kernel_cred(current);
-	if (!new) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	if (cache->secctx) {
-		ret = set_security_override_from_ctx(new, cache->secctx);
-		if (ret < 0) {
-			put_cred(new);
-			pr_err("Security denies permission to nominate security context: error %d\n",
-			       ret);
-			goto error;
-		}
-	}
-
-	cache->cache_cred = new;
-	ret = 0;
-error:
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * see if mkdir and create can be performed in the root directory
- */
-static int cachefiles_check_cache_dir(struct cachefiles_cache *cache,
-				      struct dentry *root)
-{
-	int ret;
-
-	ret = security_inode_mkdir(d_backing_inode(root), root, 0);
-	if (ret < 0) {
-		pr_err("Security denies permission to make dirs: error %d",
-		       ret);
-		return ret;
-	}
-
-	ret = security_inode_create(d_backing_inode(root), root, 0);
-	if (ret < 0)
-		pr_err("Security denies permission to create files: error %d",
-		       ret);
-
-	return ret;
-}
-
-/*
- * check the security details of the on-disk cache
- * - must be called with security override in force
- * - must return with a security override in force - even in the case of an
- *   error
- */
-int cachefiles_determine_cache_security(struct cachefiles_cache *cache,
-					struct dentry *root,
-					const struct cred **_saved_cred)
-{
-	struct cred *new;
-	int ret;
-
-	_enter("");
-
-	/* duplicate the cache creds for COW (the override is currently in
-	 * force, so we can use prepare_creds() to do this) */
-	new = prepare_creds();
-	if (!new)
-		return -ENOMEM;
-
-	cachefiles_end_secure(cache, *_saved_cred);
-
-	/* use the cache root dir's security context as the basis with
-	 * which create files */
-	ret = set_create_files_as(new, d_backing_inode(root));
-	if (ret < 0) {
-		abort_creds(new);
-		cachefiles_begin_secure(cache, _saved_cred);
-		_leave(" = %d [cfa]", ret);
-		return ret;
-	}
-
-	put_cred(cache->cache_cred);
-	cache->cache_cred = new;
-
-	cachefiles_begin_secure(cache, _saved_cred);
-	ret = cachefiles_check_cache_dir(cache, root);
-
-	if (ret == -EOPNOTSUPP)
-		ret = 0;
-	_leave(" = %d", ret);
-	return ret;
-}
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
deleted file mode 100644
index 9e82de668595..000000000000
--- a/fs/cachefiles/xattr.c
+++ /dev/null
@@ -1,324 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* CacheFiles extended attribute management
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/file.h>
-#include <linux/fs.h>
-#include <linux/fsnotify.h>
-#include <linux/quotaops.h>
-#include <linux/xattr.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-static const char cachefiles_xattr_cache[] =
-	XATTR_USER_PREFIX "CacheFiles.cache";
-
-/*
- * check the type label on an object
- * - done using xattrs
- */
-int cachefiles_check_object_type(struct cachefiles_object *object)
-{
-	struct dentry *dentry = object->dentry;
-	char type[3], xtype[3];
-	int ret;
-
-	ASSERT(dentry);
-	ASSERT(d_backing_inode(dentry));
-
-	if (!object->fscache.cookie)
-		strcpy(type, "C3");
-	else
-		snprintf(type, 3, "%02x", object->fscache.cookie->def->type);
-
-	_enter("%x{%s}", object->fscache.debug_id, type);
-
-	/* attempt to install a type label directly */
-	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache, type,
-			   2, XATTR_CREATE);
-	if (ret == 0) {
-		_debug("SET"); /* we succeeded */
-		goto error;
-	}
-
-	if (ret != -EEXIST) {
-		pr_err("Can't set xattr on %pd [%lu] (err %d)\n",
-		       dentry, d_backing_inode(dentry)->i_ino,
-		       -ret);
-		goto error;
-	}
-
-	/* read the current type label */
-	ret = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, xtype,
-			   3);
-	if (ret < 0) {
-		if (ret == -ERANGE)
-			goto bad_type_length;
-
-		pr_err("Can't read xattr on %pd [%lu] (err %d)\n",
-		       dentry, d_backing_inode(dentry)->i_ino,
-		       -ret);
-		goto error;
-	}
-
-	/* check the type is what we're expecting */
-	if (ret != 2)
-		goto bad_type_length;
-
-	if (xtype[0] != type[0] || xtype[1] != type[1])
-		goto bad_type;
-
-	ret = 0;
-
-error:
-	_leave(" = %d", ret);
-	return ret;
-
-bad_type_length:
-	pr_err("Cache object %lu type xattr length incorrect\n",
-	       d_backing_inode(dentry)->i_ino);
-	ret = -EIO;
-	goto error;
-
-bad_type:
-	xtype[2] = 0;
-	pr_err("Cache object %pd [%lu] type %s not %s\n",
-	       dentry, d_backing_inode(dentry)->i_ino,
-	       xtype, type);
-	ret = -EIO;
-	goto error;
-}
-
-/*
- * set the state xattr on a cache file
- */
-int cachefiles_set_object_xattr(struct cachefiles_object *object,
-				struct cachefiles_xattr *auxdata)
-{
-	struct dentry *dentry = object->dentry;
-	int ret;
-
-	ASSERT(dentry);
-
-	_enter("%p,#%d", object, auxdata->len);
-
-	/* attempt to install the cache metadata directly */
-	_debug("SET #%u", auxdata->len);
-
-	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
-	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
-			   &auxdata->type, auxdata->len, XATTR_CREATE);
-	if (ret < 0 && ret != -ENOMEM)
-		cachefiles_io_error_obj(
-			object,
-			"Failed to set xattr with error %d", ret);
-
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * update the state xattr on a cache file
- */
-int cachefiles_update_object_xattr(struct cachefiles_object *object,
-				   struct cachefiles_xattr *auxdata)
-{
-	struct dentry *dentry = object->dentry;
-	int ret;
-
-	if (!dentry)
-		return -ESTALE;
-
-	_enter("%x,#%d", object->fscache.debug_id, auxdata->len);
-
-	/* attempt to install the cache metadata directly */
-	_debug("SET #%u", auxdata->len);
-
-	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
-	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
-			   &auxdata->type, auxdata->len, XATTR_REPLACE);
-	if (ret < 0 && ret != -ENOMEM)
-		cachefiles_io_error_obj(
-			object,
-			"Failed to update xattr with error %d", ret);
-
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * check the consistency between the backing cache and the FS-Cache cookie
- */
-int cachefiles_check_auxdata(struct cachefiles_object *object)
-{
-	struct cachefiles_xattr *auxbuf;
-	enum fscache_checkaux validity;
-	struct dentry *dentry = object->dentry;
-	ssize_t xlen;
-	int ret;
-
-	ASSERT(dentry);
-	ASSERT(d_backing_inode(dentry));
-	ASSERT(object->fscache.cookie->def->check_aux);
-
-	auxbuf = kmalloc(sizeof(struct cachefiles_xattr) + 512, GFP_KERNEL);
-	if (!auxbuf)
-		return -ENOMEM;
-
-	xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
-			    &auxbuf->type, 512 + 1);
-	ret = -ESTALE;
-	if (xlen < 1 ||
-	    auxbuf->type != object->fscache.cookie->def->type)
-		goto error;
-
-	xlen--;
-	validity = fscache_check_aux(&object->fscache, &auxbuf->data, xlen,
-				     i_size_read(d_backing_inode(dentry)));
-	if (validity != FSCACHE_CHECKAUX_OKAY)
-		goto error;
-
-	ret = 0;
-error:
-	kfree(auxbuf);
-	return ret;
-}
-
-/*
- * check the state xattr on a cache file
- * - return -ESTALE if the object should be deleted
- */
-int cachefiles_check_object_xattr(struct cachefiles_object *object,
-				  struct cachefiles_xattr *auxdata)
-{
-	struct cachefiles_xattr *auxbuf;
-	struct dentry *dentry = object->dentry;
-	int ret;
-
-	_enter("%p,#%d", object, auxdata->len);
-
-	ASSERT(dentry);
-	ASSERT(d_backing_inode(dentry));
-
-	auxbuf = kmalloc(sizeof(struct cachefiles_xattr) + 512, cachefiles_gfp);
-	if (!auxbuf) {
-		_leave(" = -ENOMEM");
-		return -ENOMEM;
-	}
-
-	/* read the current type label */
-	ret = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
-			   &auxbuf->type, 512 + 1);
-	if (ret < 0) {
-		if (ret == -ENODATA)
-			goto stale; /* no attribute - power went off
-				     * mid-cull? */
-
-		if (ret == -ERANGE)
-			goto bad_type_length;
-
-		cachefiles_io_error_obj(object,
-					"Can't read xattr on %lu (err %d)",
-					d_backing_inode(dentry)->i_ino, -ret);
-		goto error;
-	}
-
-	/* check the on-disk object */
-	if (ret < 1)
-		goto bad_type_length;
-
-	if (auxbuf->type != auxdata->type)
-		goto stale;
-
-	auxbuf->len = ret;
-
-	/* consult the netfs */
-	if (object->fscache.cookie->def->check_aux) {
-		enum fscache_checkaux result;
-		unsigned int dlen;
-
-		dlen = auxbuf->len - 1;
-
-		_debug("checkaux %s #%u",
-		       object->fscache.cookie->def->name, dlen);
-
-		result = fscache_check_aux(&object->fscache,
-					   &auxbuf->data, dlen,
-					   i_size_read(d_backing_inode(dentry)));
-
-		switch (result) {
-			/* entry okay as is */
-		case FSCACHE_CHECKAUX_OKAY:
-			goto okay;
-
-			/* entry requires update */
-		case FSCACHE_CHECKAUX_NEEDS_UPDATE:
-			break;
-
-			/* entry requires deletion */
-		case FSCACHE_CHECKAUX_OBSOLETE:
-			goto stale;
-
-		default:
-			BUG();
-		}
-
-		/* update the current label */
-		ret = vfs_setxattr(&init_user_ns, dentry,
-				   cachefiles_xattr_cache, &auxdata->type,
-				   auxdata->len, XATTR_REPLACE);
-		if (ret < 0) {
-			cachefiles_io_error_obj(object,
-						"Can't update xattr on %lu"
-						" (error %d)",
-						d_backing_inode(dentry)->i_ino, -ret);
-			goto error;
-		}
-	}
-
-okay:
-	ret = 0;
-
-error:
-	kfree(auxbuf);
-	_leave(" = %d", ret);
-	return ret;
-
-bad_type_length:
-	pr_err("Cache object %lu xattr length incorrect\n",
-	       d_backing_inode(dentry)->i_ino);
-	ret = -EIO;
-	goto error;
-
-stale:
-	ret = -ESTALE;
-	goto error;
-}
-
-/*
- * remove the object's xattr to mark it stale
- */
-int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
-				   struct dentry *dentry)
-{
-	int ret;
-
-	ret = vfs_removexattr(&init_user_ns, dentry, cachefiles_xattr_cache);
-	if (ret < 0) {
-		if (ret == -ENOENT || ret == -ENODATA)
-			ret = 0;
-		else if (ret != -ENOMEM)
-			cachefiles_io_error(cache,
-					    "Can't remove xattr from %lu"
-					    " (error %d)",
-					    d_backing_inode(dentry)->i_ino, -ret);
-	}
-
-	_leave(" = %d", ret);
-	return ret;
-}
diff --git a/fs/cachefiles_old/Kconfig b/fs/cachefiles_old/Kconfig
new file mode 100644
index 000000000000..7f3e1881fb21
--- /dev/null
+++ b/fs/cachefiles_old/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config CACHEFILES
+	tristate "Filesystem caching on files"
+	depends on FSCACHE_OLD && BLOCK
+	help
+	  This permits use of a mounted filesystem as a cache for other
+	  filesystems - primarily networking filesystems - thus allowing fast
+	  local disk to enhance the speed of slower devices.
+
+	  See Documentation/filesystems/caching/cachefiles.rst for more
+	  information.
+
+config CACHEFILES_DEBUG
+	bool "Debug CacheFiles"
+	depends on CACHEFILES
+	help
+	  This permits debugging to be dynamically enabled in the filesystem
+	  caching on files module.  If this is set, the debugging output may be
+	  enabled by setting bits in /sys/modules/cachefiles/parameter/debug or
+	  by including a debugging specifier in /etc/cachefilesd.conf.
diff --git a/fs/cachefiles_old/Makefile b/fs/cachefiles_old/Makefile
new file mode 100644
index 000000000000..714e84b3ca24
--- /dev/null
+++ b/fs/cachefiles_old/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for caching in a mounted filesystem
+#
+
+cachefiles-y := \
+	bind.o \
+	daemon.o \
+	interface.o \
+	io.o \
+	key.o \
+	main.o \
+	namei.o \
+	security.o \
+	xattr.o
+
+obj-$(CONFIG_CACHEFILES) := cachefiles.o
diff --git a/fs/cachefiles_old/bind.c b/fs/cachefiles_old/bind.c
new file mode 100644
index 000000000000..d463d89f5db8
--- /dev/null
+++ b/fs/cachefiles_old/bind.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Bind and unbind a cache from the filesystem backing it
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
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
+#include "internal.h"
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
+	ASSERT(cache->fstop_percent >= 0 &&
+	       cache->fstop_percent < cache->fcull_percent &&
+	       cache->fcull_percent < cache->frun_percent &&
+	       cache->frun_percent  < 100);
+
+	ASSERT(cache->bstop_percent >= 0 &&
+	       cache->bstop_percent < cache->bcull_percent &&
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
+	/* make sure we have copies of the tag and dirname strings */
+	if (!cache->tag) {
+		/* the tag string is released by the fops->release()
+		 * function, so we don't release it on error here */
+		cache->tag = kstrdup("CacheFiles", GFP_KERNEL);
+		if (!cache->tag)
+			return -ENOMEM;
+	}
+
+	/* add the cache */
+	return cachefiles_daemon_add_cache(cache);
+}
+
+/*
+ * add a cache
+ */
+static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
+{
+	struct cachefiles_object *fsdef;
+	struct path path;
+	struct kstatfs stats;
+	struct dentry *graveyard, *cachedir, *root;
+	const struct cred *saved_cred;
+	int ret;
+
+	_enter("");
+
+	/* we want to work under the module's security ID */
+	ret = cachefiles_get_security_ID(cache);
+	if (ret < 0)
+		return ret;
+
+	cachefiles_begin_secure(cache, &saved_cred);
+
+	/* allocate the root index object */
+	ret = -ENOMEM;
+
+	fsdef = kmem_cache_alloc(cachefiles_object_jar, GFP_KERNEL);
+	if (!fsdef)
+		goto error_root_object;
+
+	ASSERTCMP(fsdef->backer, ==, NULL);
+
+	atomic_set(&fsdef->usage, 1);
+	fsdef->type = FSCACHE_COOKIE_TYPE_INDEX;
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
+	    !root->d_sb->s_op->sync_fs)
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
+	fsdef->dentry = cachedir;
+	fsdef->fscache.cookie = NULL;
+
+	ret = cachefiles_check_object_type(fsdef);
+	if (ret < 0)
+		goto error_unsupported;
+
+	/* get the graveyard directory */
+	graveyard = cachefiles_get_directory(cache, root, "graveyard");
+	if (IS_ERR(graveyard)) {
+		ret = PTR_ERR(graveyard);
+		goto error_unsupported;
+	}
+
+	cache->graveyard = graveyard;
+
+	/* publish the cache */
+	fscache_init_cache(&cache->cache,
+			   &cachefiles_cache_ops,
+			   "%s",
+			   fsdef->dentry->d_sb->s_id);
+
+	fscache_object_init(&fsdef->fscache, &fscache_fsdef_index,
+			    &cache->cache);
+
+	ret = fscache_add_cache(&cache->cache, &fsdef->fscache, cache->tag);
+	if (ret < 0)
+		goto error_add_cache;
+
+	/* done */
+	set_bit(CACHEFILES_READY, &cache->flags);
+	dput(root);
+
+	pr_info("File cache on %s registered\n", cache->cache.identifier);
+
+	/* check how much space the cache has */
+	cachefiles_has_space(cache, 0, 0);
+	cachefiles_end_secure(cache, saved_cred);
+	return 0;
+
+error_add_cache:
+	dput(cache->graveyard);
+	cache->graveyard = NULL;
+error_unsupported:
+	mntput(cache->mnt);
+	cache->mnt = NULL;
+	dput(fsdef->dentry);
+	fsdef->dentry = NULL;
+	dput(root);
+error_open_root:
+	kmem_cache_free(cachefiles_object_jar, fsdef);
+error_root_object:
+	cachefiles_end_secure(cache, saved_cred);
+	pr_err("Failed to register: %d\n", ret);
+	return ret;
+}
+
+/*
+ * unbind a cache on fd release
+ */
+void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
+{
+	_enter("");
+
+	if (test_bit(CACHEFILES_READY, &cache->flags)) {
+		pr_info("File cache on %s unregistering\n",
+			cache->cache.identifier);
+
+		fscache_withdraw_cache(&cache->cache);
+	}
+
+	dput(cache->graveyard);
+	mntput(cache->mnt);
+
+	kfree(cache->rootdirname);
+	kfree(cache->secctx);
+	kfree(cache->tag);
+
+	_leave("");
+}
diff --git a/fs/cachefiles_old/daemon.c b/fs/cachefiles_old/daemon.c
new file mode 100644
index 000000000000..752c1e43416f
--- /dev/null
+++ b/fs/cachefiles_old/daemon.c
@@ -0,0 +1,748 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Daemon interface
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
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
+#include <linux/poll.h>
+#include <linux/mount.h>
+#include <linux/statfs.h>
+#include <linux/ctype.h>
+#include <linux/string.h>
+#include <linux/fs_struct.h>
+#include "internal.h"
+
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
+	cache->active_nodes = RB_ROOT;
+	rwlock_init(&cache->active_lock);
+	init_waitqueue_head(&cache->daemon_pollwq);
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
+	ASSERT(!cache->active_nodes.rb_node);
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
+	if (datalen < 0 || datalen > PAGE_SIZE - 1)
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
+	if (fstop < 0 || fstop >= cache->fcull_percent)
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
+	if (bstop < 0 || bstop >= cache->bcull_percent)
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
+	struct path path;
+	const struct cred *saved_cred;
+	int ret;
+
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
+	struct path path;
+	const struct cred *saved_cred;
+	int ret;
+
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
+
+inval:
+	pr_err("inuse command requires dirfd and filename\n");
+	return -EINVAL;
+}
+
+/*
+ * see if we have space for a number of pages and/or a number of files in the
+ * cache
+ */
+int cachefiles_has_space(struct cachefiles_cache *cache,
+			 unsigned fnr, unsigned bnr)
+{
+	struct kstatfs stats;
+	struct path path = {
+		.mnt	= cache->mnt,
+		.dentry	= cache->mnt->mnt_root,
+	};
+	int ret;
+
+	//_enter("{%llu,%llu,%llu,%llu,%llu,%llu},%u,%u",
+	//       (unsigned long long) cache->frun,
+	//       (unsigned long long) cache->fcull,
+	//       (unsigned long long) cache->fstop,
+	//       (unsigned long long) cache->brun,
+	//       (unsigned long long) cache->bcull,
+	//       (unsigned long long) cache->bstop,
+	//       fnr, bnr);
+
+	/* find out how many pages of blockdev are available */
+	memset(&stats, 0, sizeof(stats));
+
+	ret = vfs_statfs(&path, &stats);
+	if (ret < 0) {
+		if (ret == -EIO)
+			cachefiles_io_error(cache, "statfs failed");
+		_leave(" = %d", ret);
+		return ret;
+	}
+
+	stats.f_bavail >>= cache->bshift;
+
+	//_debug("avail %llu,%llu",
+	//       (unsigned long long) stats.f_ffree,
+	//       (unsigned long long) stats.f_bavail);
+
+	/* see if there is sufficient space */
+	if (stats.f_ffree > fnr)
+		stats.f_ffree -= fnr;
+	else
+		stats.f_ffree = 0;
+
+	if (stats.f_bavail > bnr)
+		stats.f_bavail -= bnr;
+	else
+		stats.f_bavail = 0;
+
+	ret = -ENOBUFS;
+	if (stats.f_ffree < cache->fstop ||
+	    stats.f_bavail < cache->bstop)
+		goto begin_cull;
+
+	ret = 0;
+	if (stats.f_ffree < cache->fcull ||
+	    stats.f_bavail < cache->bcull)
+		goto begin_cull;
+
+	if (test_bit(CACHEFILES_CULLING, &cache->flags) &&
+	    stats.f_ffree >= cache->frun &&
+	    stats.f_bavail >= cache->brun &&
+	    test_and_clear_bit(CACHEFILES_CULLING, &cache->flags)
+	    ) {
+		_debug("cease culling");
+		cachefiles_state_changed(cache);
+	}
+
+	//_leave(" = 0");
+	return 0;
+
+begin_cull:
+	if (!test_and_set_bit(CACHEFILES_CULLING, &cache->flags)) {
+		_debug("### CULL CACHE ###");
+		cachefiles_state_changed(cache);
+	}
+
+	_leave(" = %d", ret);
+	return ret;
+}
diff --git a/fs/cachefiles_old/interface.c b/fs/cachefiles_old/interface.c
new file mode 100644
index 000000000000..83671488a323
--- /dev/null
+++ b/fs/cachefiles_old/interface.c
@@ -0,0 +1,557 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* FS-Cache interface to CacheFiles
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/slab.h>
+#include <linux/mount.h>
+#include "internal.h"
+
+struct cachefiles_lookup_data {
+	struct cachefiles_xattr	*auxdata;	/* auxiliary data */
+	char			*key;		/* key path */
+};
+
+static int cachefiles_attr_changed(struct fscache_object *_object);
+
+/*
+ * allocate an object record for a cookie lookup and prepare the lookup data
+ */
+static struct fscache_object *cachefiles_alloc_object(
+	struct fscache_cache *_cache,
+	struct fscache_cookie *cookie)
+{
+	struct cachefiles_lookup_data *lookup_data;
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	struct cachefiles_xattr *auxdata;
+	unsigned keylen, auxlen;
+	void *buffer, *p;
+	char *key;
+
+	cache = container_of(_cache, struct cachefiles_cache, cache);
+
+	_enter("{%s},%x,", cache->cache.identifier, cookie->debug_id);
+
+	lookup_data = kmalloc(sizeof(*lookup_data), cachefiles_gfp);
+	if (!lookup_data)
+		goto nomem_lookup_data;
+
+	/* create a new object record and a temporary leaf image */
+	object = kmem_cache_alloc(cachefiles_object_jar, cachefiles_gfp);
+	if (!object)
+		goto nomem_object;
+
+	ASSERTCMP(object->backer, ==, NULL);
+
+	BUG_ON(test_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags));
+	atomic_set(&object->usage, 1);
+
+	fscache_object_init(&object->fscache, cookie, &cache->cache);
+
+	object->type = cookie->def->type;
+
+	/* get hold of the raw key
+	 * - stick the length on the front and leave space on the back for the
+	 *   encoder
+	 */
+	buffer = kmalloc((2 + 512) + 3, cachefiles_gfp);
+	if (!buffer)
+		goto nomem_buffer;
+
+	keylen = cookie->key_len;
+	if (keylen <= sizeof(cookie->inline_key))
+		p = cookie->inline_key;
+	else
+		p = cookie->key;
+	memcpy(buffer + 2, p, keylen);
+
+	*(uint16_t *)buffer = keylen;
+	((char *)buffer)[keylen + 2] = 0;
+	((char *)buffer)[keylen + 3] = 0;
+	((char *)buffer)[keylen + 4] = 0;
+
+	/* turn the raw key into something that can work with as a filename */
+	key = cachefiles_cook_key(buffer, keylen + 2, object->type);
+	if (!key)
+		goto nomem_key;
+
+	/* get hold of the auxiliary data and prepend the object type */
+	auxdata = buffer;
+	auxlen = cookie->aux_len;
+	if (auxlen) {
+		if (auxlen <= sizeof(cookie->inline_aux))
+			p = cookie->inline_aux;
+		else
+			p = cookie->aux;
+		memcpy(auxdata->data, p, auxlen);
+	}
+
+	auxdata->len = auxlen + 1;
+	auxdata->type = cookie->type;
+
+	lookup_data->auxdata = auxdata;
+	lookup_data->key = key;
+	object->lookup_data = lookup_data;
+
+	_leave(" = %x [%p]", object->fscache.debug_id, lookup_data);
+	return &object->fscache;
+
+nomem_key:
+	kfree(buffer);
+nomem_buffer:
+	BUG_ON(test_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags));
+	kmem_cache_free(cachefiles_object_jar, object);
+	fscache_object_destroyed(&cache->cache);
+nomem_object:
+	kfree(lookup_data);
+nomem_lookup_data:
+	_leave(" = -ENOMEM");
+	return ERR_PTR(-ENOMEM);
+}
+
+/*
+ * attempt to look up the nominated node in this cache
+ * - return -ETIMEDOUT to be scheduled again
+ */
+static int cachefiles_lookup_object(struct fscache_object *_object)
+{
+	struct cachefiles_lookup_data *lookup_data;
+	struct cachefiles_object *parent, *object;
+	struct cachefiles_cache *cache;
+	const struct cred *saved_cred;
+	int ret;
+
+	_enter("{OBJ%x}", _object->debug_id);
+
+	cache = container_of(_object->cache, struct cachefiles_cache, cache);
+	parent = container_of(_object->parent,
+			      struct cachefiles_object, fscache);
+	object = container_of(_object, struct cachefiles_object, fscache);
+	lookup_data = object->lookup_data;
+
+	ASSERTCMP(lookup_data, !=, NULL);
+
+	/* look up the key, creating any missing bits */
+	cachefiles_begin_secure(cache, &saved_cred);
+	ret = cachefiles_walk_to_object(parent, object,
+					lookup_data->key,
+					lookup_data->auxdata);
+	cachefiles_end_secure(cache, saved_cred);
+
+	/* polish off by setting the attributes of non-index files */
+	if (ret == 0 &&
+	    object->fscache.cookie->def->type != FSCACHE_COOKIE_TYPE_INDEX)
+		cachefiles_attr_changed(&object->fscache);
+
+	if (ret < 0 && ret != -ETIMEDOUT) {
+		if (ret != -ENOBUFS)
+			pr_warn("Lookup failed error %d\n", ret);
+		fscache_object_lookup_error(&object->fscache);
+	}
+
+	_leave(" [%d]", ret);
+	return ret;
+}
+
+/*
+ * indication of lookup completion
+ */
+static void cachefiles_lookup_complete(struct fscache_object *_object)
+{
+	struct cachefiles_object *object;
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+
+	_enter("{OBJ%x,%p}", object->fscache.debug_id, object->lookup_data);
+
+	if (object->lookup_data) {
+		kfree(object->lookup_data->key);
+		kfree(object->lookup_data->auxdata);
+		kfree(object->lookup_data);
+		object->lookup_data = NULL;
+	}
+}
+
+/*
+ * increment the usage count on an inode object (may fail if unmounting)
+ */
+static
+struct fscache_object *cachefiles_grab_object(struct fscache_object *_object,
+					      enum fscache_obj_ref_trace why)
+{
+	struct cachefiles_object *object =
+		container_of(_object, struct cachefiles_object, fscache);
+	int u;
+
+	_enter("{OBJ%x,%d}", _object->debug_id, atomic_read(&object->usage));
+
+#ifdef CACHEFILES_DEBUG_SLAB
+	ASSERT((atomic_read(&object->usage) & 0xffff0000) != 0x6b6b0000);
+#endif
+
+	u = atomic_inc_return(&object->usage);
+	trace_cachefiles_ref(object, _object->cookie,
+			     (enum cachefiles_obj_ref_trace)why, u);
+	return &object->fscache;
+}
+
+/*
+ * update the auxiliary data for an object object on disk
+ */
+static void cachefiles_update_object(struct fscache_object *_object)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_xattr *auxdata;
+	struct cachefiles_cache *cache;
+	struct fscache_cookie *cookie;
+	const struct cred *saved_cred;
+	const void *aux;
+	unsigned auxlen;
+
+	_enter("{OBJ%x}", _object->debug_id);
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache, struct cachefiles_cache,
+			     cache);
+
+	if (!fscache_use_cookie(_object)) {
+		_leave(" [relinq]");
+		return;
+	}
+
+	cookie = object->fscache.cookie;
+	auxlen = cookie->aux_len;
+
+	if (!auxlen) {
+		fscache_unuse_cookie(_object);
+		_leave(" [no aux]");
+		return;
+	}
+
+	auxdata = kmalloc(2 + auxlen + 3, cachefiles_gfp);
+	if (!auxdata) {
+		fscache_unuse_cookie(_object);
+		_leave(" [nomem]");
+		return;
+	}
+
+	aux = (auxlen <= sizeof(cookie->inline_aux)) ?
+		cookie->inline_aux : cookie->aux;
+
+	memcpy(auxdata->data, aux, auxlen);
+	fscache_unuse_cookie(_object);
+
+	auxdata->len = auxlen + 1;
+	auxdata->type = cookie->type;
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	cachefiles_update_object_xattr(object, auxdata);
+	cachefiles_end_secure(cache, saved_cred);
+	kfree(auxdata);
+	_leave("");
+}
+
+/*
+ * discard the resources pinned by an object and effect retirement if
+ * requested
+ */
+static void cachefiles_drop_object(struct fscache_object *_object)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	const struct cred *saved_cred;
+	struct inode *inode;
+	blkcnt_t i_blocks = 0;
+
+	ASSERT(_object);
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+
+	_enter("{OBJ%x,%d}",
+	       object->fscache.debug_id, atomic_read(&object->usage));
+
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+
+#ifdef CACHEFILES_DEBUG_SLAB
+	ASSERT((atomic_read(&object->usage) & 0xffff0000) != 0x6b6b0000);
+#endif
+
+	/* We need to tidy the object up if we did in fact manage to open it.
+	 * It's possible for us to get here before the object is fully
+	 * initialised if the parent goes away or the object gets retired
+	 * before we set it up.
+	 */
+	if (object->dentry) {
+		/* delete retired objects */
+		if (test_bit(FSCACHE_OBJECT_RETIRED, &object->fscache.flags) &&
+		    _object != cache->cache.fsdef
+		    ) {
+			_debug("- retire object OBJ%x", object->fscache.debug_id);
+			inode = d_backing_inode(object->dentry);
+			if (inode)
+				i_blocks = inode->i_blocks;
+
+			cachefiles_begin_secure(cache, &saved_cred);
+			cachefiles_delete_object(cache, object);
+			cachefiles_end_secure(cache, saved_cred);
+		}
+
+		/* close the filesystem stuff attached to the object */
+		if (object->backer != object->dentry)
+			dput(object->backer);
+		object->backer = NULL;
+	}
+
+	/* note that the object is now inactive */
+	if (test_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags))
+		cachefiles_mark_object_inactive(cache, object, i_blocks);
+
+	dput(object->dentry);
+	object->dentry = NULL;
+
+	_leave("");
+}
+
+/*
+ * dispose of a reference to an object
+ */
+void cachefiles_put_object(struct fscache_object *_object,
+			   enum fscache_obj_ref_trace why)
+{
+	struct cachefiles_object *object;
+	struct fscache_cache *cache;
+	int u;
+
+	ASSERT(_object);
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+
+	_enter("{OBJ%x,%d}",
+	       object->fscache.debug_id, atomic_read(&object->usage));
+
+#ifdef CACHEFILES_DEBUG_SLAB
+	ASSERT((atomic_read(&object->usage) & 0xffff0000) != 0x6b6b0000);
+#endif
+
+	ASSERTIFCMP(object->fscache.parent,
+		    object->fscache.parent->n_children, >, 0);
+
+	u = atomic_dec_return(&object->usage);
+	trace_cachefiles_ref(object, _object->cookie,
+			     (enum cachefiles_obj_ref_trace)why, u);
+	ASSERTCMP(u, !=, -1);
+	if (u == 0) {
+		_debug("- kill object OBJ%x", object->fscache.debug_id);
+
+		ASSERT(!test_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags));
+		ASSERTCMP(object->fscache.parent, ==, NULL);
+		ASSERTCMP(object->backer, ==, NULL);
+		ASSERTCMP(object->dentry, ==, NULL);
+		ASSERTCMP(object->fscache.n_ops, ==, 0);
+		ASSERTCMP(object->fscache.n_children, ==, 0);
+
+		if (object->lookup_data) {
+			kfree(object->lookup_data->key);
+			kfree(object->lookup_data->auxdata);
+			kfree(object->lookup_data);
+			object->lookup_data = NULL;
+		}
+
+		cache = object->fscache.cache;
+		fscache_object_destroy(&object->fscache);
+		kmem_cache_free(cachefiles_object_jar, object);
+		fscache_object_destroyed(cache);
+	}
+
+	_leave("");
+}
+
+/*
+ * sync a cache
+ */
+static void cachefiles_sync_cache(struct fscache_cache *_cache)
+{
+	struct cachefiles_cache *cache;
+	const struct cred *saved_cred;
+	int ret;
+
+	_enter("%s", _cache->tag->name);
+
+	cache = container_of(_cache, struct cachefiles_cache, cache);
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
+				    "Attempt to sync backing fs superblock"
+				    " returned error %d",
+				    ret);
+}
+
+/*
+ * check if the backing cache is updated to FS-Cache
+ * - called by FS-Cache when evaluates if need to invalidate the cache
+ */
+static int cachefiles_check_consistency(struct fscache_operation *op)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	const struct cred *saved_cred;
+	int ret;
+
+	_enter("{OBJ%x}", op->object->debug_id);
+
+	object = container_of(op->object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	ret = cachefiles_check_auxdata(object);
+	cachefiles_end_secure(cache, saved_cred);
+
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * notification the attributes on an object have changed
+ * - called with reads/writes excluded by FS-Cache
+ */
+static int cachefiles_attr_changed(struct fscache_object *_object)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	const struct cred *saved_cred;
+	struct iattr newattrs;
+	uint64_t ni_size;
+	loff_t oi_size;
+	int ret;
+
+	ni_size = _object->store_limit_l;
+
+	_enter("{OBJ%x},[%llu]",
+	       _object->debug_id, (unsigned long long) ni_size);
+
+	object = container_of(_object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+
+	if (ni_size == object->i_size)
+		return 0;
+
+	if (!object->backer)
+		return -ENOBUFS;
+
+	ASSERT(d_is_reg(object->backer));
+
+	fscache_set_store_limit(&object->fscache, ni_size);
+
+	oi_size = i_size_read(d_backing_inode(object->backer));
+	if (oi_size == ni_size)
+		return 0;
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	inode_lock(d_inode(object->backer));
+
+	/* if there's an extension to a partial page at the end of the backing
+	 * file, we need to discard the partial page so that we pick up new
+	 * data after it */
+	if (oi_size & ~PAGE_MASK && ni_size > oi_size) {
+		_debug("discard tail %llx", oi_size);
+		newattrs.ia_valid = ATTR_SIZE;
+		newattrs.ia_size = oi_size & PAGE_MASK;
+		ret = notify_change(&init_user_ns, object->backer, &newattrs, NULL);
+		if (ret < 0)
+			goto truncate_failed;
+	}
+
+	newattrs.ia_valid = ATTR_SIZE;
+	newattrs.ia_size = ni_size;
+	ret = notify_change(&init_user_ns, object->backer, &newattrs, NULL);
+
+truncate_failed:
+	inode_unlock(d_inode(object->backer));
+	cachefiles_end_secure(cache, saved_cred);
+
+	if (ret == -EIO) {
+		fscache_set_store_limit(&object->fscache, 0);
+		cachefiles_io_error_obj(object, "Size set failed");
+		ret = -ENOBUFS;
+	}
+
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Invalidate an object
+ */
+static void cachefiles_invalidate_object(struct fscache_operation *op)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	const struct cred *saved_cred;
+	struct path path;
+	uint64_t ni_size;
+	int ret;
+
+	object = container_of(op->object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+
+	ni_size = op->object->store_limit_l;
+
+	_enter("{OBJ%x},[%llu]",
+	       op->object->debug_id, (unsigned long long)ni_size);
+
+	if (object->backer) {
+		ASSERT(d_is_reg(object->backer));
+
+		fscache_set_store_limit(&object->fscache, ni_size);
+
+		path.dentry = object->backer;
+		path.mnt = cache->mnt;
+
+		cachefiles_begin_secure(cache, &saved_cred);
+		ret = vfs_truncate(&path, 0);
+		if (ret == 0)
+			ret = vfs_truncate(&path, ni_size);
+		cachefiles_end_secure(cache, saved_cred);
+
+		if (ret != 0) {
+			fscache_set_store_limit(&object->fscache, 0);
+			if (ret == -EIO)
+				cachefiles_io_error_obj(object,
+							"Invalidate failed");
+		}
+	}
+
+	fscache_op_complete(op, true);
+	_leave("");
+}
+
+const struct fscache_cache_ops cachefiles_cache_ops = {
+	.name			= "cachefiles",
+	.alloc_object		= cachefiles_alloc_object,
+	.lookup_object		= cachefiles_lookup_object,
+	.lookup_complete	= cachefiles_lookup_complete,
+	.grab_object		= cachefiles_grab_object,
+	.update_object		= cachefiles_update_object,
+	.invalidate_object	= cachefiles_invalidate_object,
+	.drop_object		= cachefiles_drop_object,
+	.put_object		= cachefiles_put_object,
+	.sync_cache		= cachefiles_sync_cache,
+	.attr_changed		= cachefiles_attr_changed,
+	.check_consistency	= cachefiles_check_consistency,
+	.begin_operation	= cachefiles_begin_operation,
+};
diff --git a/fs/cachefiles_old/internal.h b/fs/cachefiles_old/internal.h
new file mode 100644
index 000000000000..28351d62d8d2
--- /dev/null
+++ b/fs/cachefiles_old/internal.h
@@ -0,0 +1,312 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* General netfs cache on cache files internal defs
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) "CacheFiles: " fmt
+
+
+#include <linux/fscache_old-cache.h>
+#include <linux/timer.h>
+#include <linux/wait_bit.h>
+#include <linux/cred.h>
+#include <linux/workqueue.h>
+#include <linux/security.h>
+
+struct cachefiles_cache;
+struct cachefiles_object;
+
+extern unsigned cachefiles_debug;
+#define CACHEFILES_DEBUG_KENTER	1
+#define CACHEFILES_DEBUG_KLEAVE	2
+#define CACHEFILES_DEBUG_KDEBUG	4
+
+#define cachefiles_gfp (__GFP_RECLAIM | __GFP_NORETRY | __GFP_NOMEMALLOC)
+
+/*
+ * node records
+ */
+struct cachefiles_object {
+	struct fscache_object		fscache;	/* fscache handle */
+	struct cachefiles_lookup_data	*lookup_data;	/* cached lookup data */
+	struct dentry			*dentry;	/* the file/dir representing this object */
+	struct dentry			*backer;	/* backing file */
+	loff_t				i_size;		/* object size */
+	unsigned long			flags;
+#define CACHEFILES_OBJECT_ACTIVE	0		/* T if marked active */
+	atomic_t			usage;		/* object usage count */
+	uint8_t				type;		/* object type */
+	uint8_t				new;		/* T if object new */
+	struct rb_node			active_node;	/* link in active tree (dentry is key) */
+};
+
+extern struct kmem_cache *cachefiles_object_jar;
+
+/*
+ * Cache files cache definition
+ */
+struct cachefiles_cache {
+	struct fscache_cache		cache;		/* FS-Cache record */
+	struct vfsmount			*mnt;		/* mountpoint holding the cache */
+	struct dentry			*graveyard;	/* directory into which dead objects go */
+	struct file			*cachefilesd;	/* manager daemon handle */
+	const struct cred		*cache_cred;	/* security override for accessing cache */
+	struct mutex			daemon_mutex;	/* command serialisation mutex */
+	wait_queue_head_t		daemon_pollwq;	/* poll waitqueue for daemon */
+	struct rb_root			active_nodes;	/* active nodes (can't be culled) */
+	rwlock_t			active_lock;	/* lock for active_nodes */
+	atomic_t			gravecounter;	/* graveyard uniquifier */
+	atomic_t			f_released;	/* number of objects released lately */
+	atomic_long_t			b_released;	/* number of blocks released lately */
+	unsigned			frun_percent;	/* when to stop culling (% files) */
+	unsigned			fcull_percent;	/* when to start culling (% files) */
+	unsigned			fstop_percent;	/* when to stop allocating (% files) */
+	unsigned			brun_percent;	/* when to stop culling (% blocks) */
+	unsigned			bcull_percent;	/* when to start culling (% blocks) */
+	unsigned			bstop_percent;	/* when to stop allocating (% blocks) */
+	unsigned			bsize;		/* cache's block size */
+	unsigned			bshift;		/* min(ilog2(PAGE_SIZE / bsize), 0) */
+	uint64_t			frun;		/* when to stop culling */
+	uint64_t			fcull;		/* when to start culling */
+	uint64_t			fstop;		/* when to stop allocating */
+	sector_t			brun;		/* when to stop culling */
+	sector_t			bcull;		/* when to start culling */
+	sector_t			bstop;		/* when to stop allocating */
+	unsigned long			flags;
+#define CACHEFILES_READY		0	/* T if cache prepared */
+#define CACHEFILES_DEAD			1	/* T if cache dead */
+#define CACHEFILES_CULLING		2	/* T if cull engaged */
+#define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
+	char				*rootdirname;	/* name of cache root directory */
+	char				*secctx;	/* LSM security context */
+	char				*tag;		/* cache binding tag */
+};
+
+/*
+ * auxiliary data xattr buffer
+ */
+struct cachefiles_xattr {
+	uint16_t			len;
+	uint8_t				type;
+	uint8_t				data[];
+};
+
+#include <trace/events/cachefiles_old.h>
+
+/*
+ * note change of state for daemon
+ */
+static inline void cachefiles_state_changed(struct cachefiles_cache *cache)
+{
+	set_bit(CACHEFILES_STATE_CHANGED, &cache->flags);
+	wake_up_all(&cache->daemon_pollwq);
+}
+
+/*
+ * bind.c
+ */
+extern int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args);
+extern void cachefiles_daemon_unbind(struct cachefiles_cache *cache);
+
+/*
+ * daemon.c
+ */
+extern const struct file_operations cachefiles_daemon_fops;
+
+extern int cachefiles_has_space(struct cachefiles_cache *cache,
+				unsigned fnr, unsigned bnr);
+
+/*
+ * interface.c
+ */
+extern const struct fscache_cache_ops cachefiles_cache_ops;
+
+void cachefiles_put_object(struct fscache_object *_object,
+			   enum fscache_obj_ref_trace why);
+
+/*
+ * key.c
+ */
+extern char *cachefiles_cook_key(const u8 *raw, int keylen, uint8_t type);
+
+/*
+ * namei.c
+ */
+extern void cachefiles_mark_object_inactive(struct cachefiles_cache *cache,
+					    struct cachefiles_object *object,
+					    blkcnt_t i_blocks);
+extern int cachefiles_delete_object(struct cachefiles_cache *cache,
+				    struct cachefiles_object *object);
+extern int cachefiles_walk_to_object(struct cachefiles_object *parent,
+				     struct cachefiles_object *object,
+				     const char *key,
+				     struct cachefiles_xattr *auxdata);
+extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
+					       struct dentry *dir,
+					       const char *name);
+
+extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
+			   char *filename);
+
+extern int cachefiles_check_in_use(struct cachefiles_cache *cache,
+				   struct dentry *dir, char *filename);
+
+/*
+ * rdwr2.c
+ */
+extern int cachefiles_begin_operation(struct netfs_cache_resources *,
+				      struct fscache_operation *);
+
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
+/*
+ * xattr.c
+ */
+extern int cachefiles_check_object_type(struct cachefiles_object *object);
+extern int cachefiles_set_object_xattr(struct cachefiles_object *object,
+				       struct cachefiles_xattr *auxdata);
+extern int cachefiles_update_object_xattr(struct cachefiles_object *object,
+					  struct cachefiles_xattr *auxdata);
+extern int cachefiles_check_auxdata(struct cachefiles_object *object);
+extern int cachefiles_check_object_xattr(struct cachefiles_object *object,
+					 struct cachefiles_xattr *auxdata);
+extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
+					  struct dentry *dentry);
+
+
+/*
+ * error handling
+ */
+
+#define cachefiles_io_error(___cache, FMT, ...)		\
+do {							\
+	pr_err("I/O Error: " FMT"\n", ##__VA_ARGS__);	\
+	fscache_io_error(&(___cache)->cache);		\
+	set_bit(CACHEFILES_DEAD, &(___cache)->flags);	\
+} while (0)
+
+#define cachefiles_io_error_obj(object, FMT, ...)			\
+do {									\
+	struct cachefiles_cache *___cache;				\
+									\
+	___cache = container_of((object)->fscache.cache,		\
+				struct cachefiles_cache, cache);	\
+	cachefiles_io_error(___cache, FMT, ##__VA_ARGS__);		\
+} while (0)
+
+
+/*
+ * debug tracing
+ */
+#define dbgprintk(FMT, ...) \
+	printk(KERN_DEBUG "[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
+
+#define kenter(FMT, ...) dbgprintk("==> %s("FMT")", __func__, ##__VA_ARGS__)
+#define kleave(FMT, ...) dbgprintk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
+#define kdebug(FMT, ...) dbgprintk(FMT, ##__VA_ARGS__)
+
+
+#if defined(__KDEBUG)
+#define _enter(FMT, ...) kenter(FMT, ##__VA_ARGS__)
+#define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
+#define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
+
+#elif defined(CONFIG_CACHEFILES_DEBUG)
+#define _enter(FMT, ...)				\
+do {							\
+	if (cachefiles_debug & CACHEFILES_DEBUG_KENTER)	\
+		kenter(FMT, ##__VA_ARGS__);		\
+} while (0)
+
+#define _leave(FMT, ...)				\
+do {							\
+	if (cachefiles_debug & CACHEFILES_DEBUG_KLEAVE)	\
+		kleave(FMT, ##__VA_ARGS__);		\
+} while (0)
+
+#define _debug(FMT, ...)				\
+do {							\
+	if (cachefiles_debug & CACHEFILES_DEBUG_KDEBUG)	\
+		kdebug(FMT, ##__VA_ARGS__);		\
+} while (0)
+
+#else
+#define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
+#define _leave(FMT, ...) no_printk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
+#define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
+#endif
+
+#if 1 /* defined(__KDEBUGALL) */
+
+#define ASSERT(X)							\
+do {									\
+	if (unlikely(!(X))) {						\
+		pr_err("\n");						\
+		pr_err("Assertion failed\n");		\
+		BUG();							\
+	}								\
+} while (0)
+
+#define ASSERTCMP(X, OP, Y)						\
+do {									\
+	if (unlikely(!((X) OP (Y)))) {					\
+		pr_err("\n");						\
+		pr_err("Assertion failed\n");		\
+		pr_err("%lx " #OP " %lx is false\n",			\
+		       (unsigned long)(X), (unsigned long)(Y));		\
+		BUG();							\
+	}								\
+} while (0)
+
+#define ASSERTIF(C, X)							\
+do {									\
+	if (unlikely((C) && !(X))) {					\
+		pr_err("\n");						\
+		pr_err("Assertion failed\n");		\
+		BUG();							\
+	}								\
+} while (0)
+
+#define ASSERTIFCMP(C, X, OP, Y)					\
+do {									\
+	if (unlikely((C) && !((X) OP (Y)))) {				\
+		pr_err("\n");						\
+		pr_err("Assertion failed\n");		\
+		pr_err("%lx " #OP " %lx is false\n",			\
+		       (unsigned long)(X), (unsigned long)(Y));		\
+		BUG();							\
+	}								\
+} while (0)
+
+#else
+
+#define ASSERT(X)			do {} while (0)
+#define ASSERTCMP(X, OP, Y)		do {} while (0)
+#define ASSERTIF(C, X)			do {} while (0)
+#define ASSERTIFCMP(C, X, OP, Y)	do {} while (0)
+
+#endif
diff --git a/fs/cachefiles_old/io.c b/fs/cachefiles_old/io.c
new file mode 100644
index 000000000000..5ead97de4bb7
--- /dev/null
+++ b/fs/cachefiles_old/io.c
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* kiocb-using read/write
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/mount.h>
+#include <linux/slab.h>
+#include <linux/file.h>
+#include <linux/uio.h>
+#include <linux/sched/mm.h>
+#include <linux/netfs.h>
+#include "internal.h"
+
+struct cachefiles_kiocb {
+	struct kiocb		iocb;
+	refcount_t		ki_refcnt;
+	loff_t			start;
+	union {
+		size_t		skipped;
+		size_t		len;
+	};
+	netfs_io_terminated_t	term_func;
+	void			*term_func_priv;
+	bool			was_async;
+};
+
+static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
+{
+	if (refcount_dec_and_test(&ki->ki_refcnt)) {
+		fput(ki->iocb.ki_filp);
+		kfree(ki);
+	}
+}
+
+/*
+ * Handle completion of a read from the cache.
+ */
+static void cachefiles_read_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
+
+	_enter("%ld,%ld", ret, ret2);
+
+	if (ki->term_func) {
+		if (ret >= 0)
+			ret += ki->skipped;
+		ki->term_func(ki->term_func_priv, ret, ki->was_async);
+	}
+
+	cachefiles_put_kiocb(ki);
+}
+
+/*
+ * Initiate a read from the cache.
+ */
+static int cachefiles_read(struct netfs_cache_resources *cres,
+			   loff_t start_pos,
+			   struct iov_iter *iter,
+			   enum netfs_read_from_hole read_hole,
+			   netfs_io_terminated_t term_func,
+			   void *term_func_priv)
+{
+	struct cachefiles_kiocb *ki;
+	struct file *file = cres->cache_priv2;
+	unsigned int old_nofs;
+	ssize_t ret = -ENODATA;
+	size_t len = iov_iter_count(iter), skipped = 0;
+
+	_enter("%pD,%li,%llx,%zx/%llx",
+	       file, file_inode(file)->i_ino, start_pos, len,
+	       i_size_read(file_inode(file)));
+
+	/* If the caller asked us to seek for data before doing the read, then
+	 * we should do that now.  If we find a gap, we fill it with zeros.
+	 */
+	if (read_hole != NETFS_READ_HOLE_IGNORE) {
+		loff_t off = start_pos, off2;
+
+		off2 = vfs_llseek(file, off, SEEK_DATA);
+		if (off2 < 0 && off2 >= (loff_t)-MAX_ERRNO && off2 != -ENXIO) {
+			skipped = 0;
+			ret = off2;
+			goto presubmission_error;
+		}
+
+		if (off2 == -ENXIO || off2 >= start_pos + len) {
+			/* The region is beyond the EOF or there's no more data
+			 * in the region, so clear the rest of the buffer and
+			 * return success.
+			 */
+			if (read_hole == NETFS_READ_HOLE_FAIL)
+				goto presubmission_error;
+
+			iov_iter_zero(len, iter);
+			skipped = len;
+			ret = 0;
+			goto presubmission_error;
+		}
+
+		skipped = off2 - off;
+		iov_iter_zero(skipped, iter);
+	}
+
+	ret = -ENOBUFS;
+	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
+	if (!ki)
+		goto presubmission_error;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	ki->iocb.ki_filp	= file;
+	ki->iocb.ki_pos		= start_pos + skipped;
+	ki->iocb.ki_flags	= IOCB_DIRECT;
+	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
+	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->skipped		= skipped;
+	ki->term_func		= term_func;
+	ki->term_func_priv	= term_func_priv;
+	ki->was_async		= true;
+
+	if (ki->term_func)
+		ki->iocb.ki_complete = cachefiles_read_complete;
+
+	get_file(ki->iocb.ki_filp);
+
+	old_nofs = memalloc_nofs_save();
+	ret = vfs_iocb_iter_read(file, &ki->iocb, iter);
+	memalloc_nofs_restore(old_nofs);
+	switch (ret) {
+	case -EIOCBQUEUED:
+		goto in_progress;
+
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/* There's no easy way to restart the syscall since other AIO's
+		 * may be already running. Just fail this IO with EINTR.
+		 */
+		ret = -EINTR;
+		fallthrough;
+	default:
+		ki->was_async = false;
+		cachefiles_read_complete(&ki->iocb, ret, 0);
+		if (ret > 0)
+			ret = 0;
+		break;
+	}
+
+in_progress:
+	cachefiles_put_kiocb(ki);
+	_leave(" = %zd", ret);
+	return ret;
+
+presubmission_error:
+	if (term_func)
+		term_func(term_func_priv, ret < 0 ? ret : skipped, false);
+	return ret;
+}
+
+/*
+ * Handle completion of a write to the cache.
+ */
+static void cachefiles_write_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
+	struct inode *inode = file_inode(ki->iocb.ki_filp);
+
+	_enter("%ld,%ld", ret, ret2);
+
+	/* Tell lockdep we inherited freeze protection from submission thread */
+	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
+	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
+
+	if (ki->term_func)
+		ki->term_func(ki->term_func_priv, ret, ki->was_async);
+
+	cachefiles_put_kiocb(ki);
+}
+
+/*
+ * Initiate a write to the cache.
+ */
+static int cachefiles_write(struct netfs_cache_resources *cres,
+			    loff_t start_pos,
+			    struct iov_iter *iter,
+			    netfs_io_terminated_t term_func,
+			    void *term_func_priv)
+{
+	struct cachefiles_kiocb *ki;
+	struct inode *inode;
+	struct file *file = cres->cache_priv2;
+	unsigned int old_nofs;
+	ssize_t ret = -ENOBUFS;
+	size_t len = iov_iter_count(iter);
+
+	_enter("%pD,%li,%llx,%zx/%llx",
+	       file, file_inode(file)->i_ino, start_pos, len,
+	       i_size_read(file_inode(file)));
+
+	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
+	if (!ki)
+		goto presubmission_error;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	ki->iocb.ki_filp	= file;
+	ki->iocb.ki_pos		= start_pos;
+	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
+	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
+	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->start		= start_pos;
+	ki->len			= len;
+	ki->term_func		= term_func;
+	ki->term_func_priv	= term_func_priv;
+	ki->was_async		= true;
+
+	if (ki->term_func)
+		ki->iocb.ki_complete = cachefiles_write_complete;
+
+	/* Open-code file_start_write here to grab freeze protection, which
+	 * will be released by another thread in aio_complete_rw().  Fool
+	 * lockdep by telling it the lock got released so that it doesn't
+	 * complain about the held lock when we return to userspace.
+	 */
+	inode = file_inode(file);
+	__sb_start_write(inode->i_sb, SB_FREEZE_WRITE);
+	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+
+	get_file(ki->iocb.ki_filp);
+
+	old_nofs = memalloc_nofs_save();
+	ret = vfs_iocb_iter_write(file, &ki->iocb, iter);
+	memalloc_nofs_restore(old_nofs);
+	switch (ret) {
+	case -EIOCBQUEUED:
+		goto in_progress;
+
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/* There's no easy way to restart the syscall since other AIO's
+		 * may be already running. Just fail this IO with EINTR.
+		 */
+		ret = -EINTR;
+		fallthrough;
+	default:
+		ki->was_async = false;
+		cachefiles_write_complete(&ki->iocb, ret, 0);
+		if (ret > 0)
+			ret = 0;
+		break;
+	}
+
+in_progress:
+	cachefiles_put_kiocb(ki);
+	_leave(" = %zd", ret);
+	return ret;
+
+presubmission_error:
+	if (term_func)
+		term_func(term_func_priv, -ENOMEM, false);
+	return -ENOMEM;
+}
+
+/*
+ * Prepare a read operation, shortening it to a cached/uncached
+ * boundary as appropriate.
+ */
+static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subrequest *subreq,
+						      loff_t i_size)
+{
+	struct fscache_operation *op = subreq->rreq->cache_resources.cache_priv;
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	const struct cred *saved_cred;
+	struct file *file = subreq->rreq->cache_resources.cache_priv2;
+	enum netfs_read_source ret = NETFS_DOWNLOAD_FROM_SERVER;
+	loff_t off, to;
+
+	_enter("%zx @%llx/%llx", subreq->len, subreq->start, i_size);
+
+	object = container_of(op->object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+
+	cachefiles_begin_secure(cache, &saved_cred);
+
+	if (subreq->start >= i_size) {
+		ret = NETFS_FILL_WITH_ZEROES;
+		goto out;
+	}
+
+	if (!file)
+		goto out;
+
+	if (test_bit(FSCACHE_COOKIE_NO_DATA_YET, &object->fscache.cookie->flags))
+		goto download_and_store;
+
+	off = vfs_llseek(file, subreq->start, SEEK_DATA);
+	if (off < 0 && off >= (loff_t)-MAX_ERRNO) {
+		if (off == (loff_t)-ENXIO)
+			goto download_and_store;
+		goto out;
+	}
+
+	if (off >= subreq->start + subreq->len)
+		goto download_and_store;
+
+	if (off > subreq->start) {
+		off = round_up(off, cache->bsize);
+		subreq->len = off - subreq->start;
+		goto download_and_store;
+	}
+
+	to = vfs_llseek(file, subreq->start, SEEK_HOLE);
+	if (to < 0 && to >= (loff_t)-MAX_ERRNO)
+		goto out;
+
+	if (to < subreq->start + subreq->len) {
+		if (subreq->start + subreq->len >= i_size)
+			to = round_up(to, cache->bsize);
+		else
+			to = round_down(to, cache->bsize);
+		subreq->len = to - subreq->start;
+	}
+
+	ret = NETFS_READ_FROM_CACHE;
+	goto out;
+
+download_and_store:
+	if (cachefiles_has_space(cache, 0, (subreq->len + PAGE_SIZE - 1) / PAGE_SIZE) == 0)
+		__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+out:
+	cachefiles_end_secure(cache, saved_cred);
+	return ret;
+}
+
+/*
+ * Prepare for a write to occur.
+ */
+static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
+				    loff_t *_start, size_t *_len, loff_t i_size)
+{
+	loff_t start = *_start;
+	size_t len = *_len, down;
+
+	/* Round to DIO size */
+	down = start - round_down(start, PAGE_SIZE);
+	*_start = start - down;
+	*_len = round_up(down + len, PAGE_SIZE);
+	return 0;
+}
+
+/*
+ * Prepare for a write to occur from the fallback I/O API.
+ */
+static int cachefiles_prepare_fallback_write(struct netfs_cache_resources *cres,
+					     pgoff_t index)
+{
+	struct fscache_operation *op = cres->cache_priv;
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+
+	_enter("%lx", index);
+
+	object = container_of(op->object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+	return cachefiles_has_space(cache, 0, 1);
+}
+
+/*
+ * Clean up an operation.
+ */
+static void cachefiles_end_operation(struct netfs_cache_resources *cres)
+{
+	struct fscache_operation *op = cres->cache_priv;
+	struct file *file = cres->cache_priv2;
+
+	_enter("");
+
+	if (file)
+		fput(file);
+	if (op) {
+		fscache_op_complete(op, false);
+		fscache_put_operation(op);
+	}
+
+	_leave("");
+}
+
+static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
+	.end_operation		= cachefiles_end_operation,
+	.read			= cachefiles_read,
+	.write			= cachefiles_write,
+	.prepare_read		= cachefiles_prepare_read,
+	.prepare_write		= cachefiles_prepare_write,
+	.prepare_fallback_write	= cachefiles_prepare_fallback_write,
+};
+
+/*
+ * Open the cache file when beginning a cache operation.
+ */
+int cachefiles_begin_operation(struct netfs_cache_resources *cres,
+			       struct fscache_operation *op)
+{
+	struct cachefiles_object *object;
+	struct cachefiles_cache *cache;
+	struct path path;
+	struct file *file;
+
+	_enter("");
+
+	object = container_of(op->object, struct cachefiles_object, fscache);
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+
+	path.mnt = cache->mnt;
+	path.dentry = object->backer;
+	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
+				   d_inode(object->backer), cache->cache_cred);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+	if (!S_ISREG(file_inode(file)->i_mode))
+		goto error_file;
+	if (unlikely(!file->f_op->read_iter) ||
+	    unlikely(!file->f_op->write_iter)) {
+		pr_notice("Cache does not support read_iter and write_iter\n");
+		goto error_file;
+	}
+
+	atomic_inc(&op->usage);
+	cres->cache_priv = op;
+	cres->cache_priv2 = file;
+	cres->ops = &cachefiles_netfs_cache_ops;
+	cres->debug_id = object->fscache.debug_id;
+	_leave("");
+	return 0;
+
+error_file:
+	fput(file);
+	return -EIO;
+}
diff --git a/fs/cachefiles_old/key.c b/fs/cachefiles_old/key.c
new file mode 100644
index 000000000000..7f94efc97e23
--- /dev/null
+++ b/fs/cachefiles_old/key.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Key to pathname encoder
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
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
+/*
+ * turn the raw key into something cooked
+ * - the raw key should include the length in the two bytes at the front
+ * - the key may be up to 514 bytes in length (including the length word)
+ *   - "base64" encode the strange keys, mapping 3 bytes of raw to four of
+ *     cooked
+ *   - need to cut the cooked key into 252 char lengths (189 raw bytes)
+ */
+char *cachefiles_cook_key(const u8 *raw, int keylen, uint8_t type)
+{
+	unsigned char csum, ch;
+	unsigned int acc;
+	char *key;
+	int loop, len, max, seg, mark, print;
+
+	_enter(",%d", keylen);
+
+	BUG_ON(keylen < 2 || keylen > 514);
+
+	csum = raw[0] + raw[1];
+	print = 1;
+	for (loop = 2; loop < keylen; loop++) {
+		ch = raw[loop];
+		csum += ch;
+		print &= cachefiles_filecharmap[ch];
+	}
+
+	if (print) {
+		/* if the path is usable ASCII, then we render it directly */
+		max = keylen - 2;
+		max += 2;	/* two base64'd length chars on the front */
+		max += 5;	/* @checksum/M */
+		max += 3 * 2;	/* maximum number of segment dividers (".../M")
+				 * is ((514 + 251) / 252) = 3
+				 */
+		max += 1;	/* NUL on end */
+	} else {
+		/* calculate the maximum length of the cooked key */
+		keylen = (keylen + 2) / 3;
+
+		max = keylen * 4;
+		max += 5;	/* @checksum/M */
+		max += 3 * 2;	/* maximum number of segment dividers (".../M")
+				 * is ((514 + 188) / 189) = 3
+				 */
+		max += 1;	/* NUL on end */
+	}
+
+	max += 1;	/* 2nd NUL on end */
+
+	_debug("max: %d", max);
+
+	key = kmalloc(max, cachefiles_gfp);
+	if (!key)
+		return NULL;
+
+	len = 0;
+
+	/* build the cooked key */
+	sprintf(key, "@%02x%c+", (unsigned) csum, 0);
+	len = 5;
+	mark = len - 1;
+
+	if (print) {
+		acc = *(uint16_t *) raw;
+		raw += 2;
+
+		key[len + 1] = cachefiles_charmap[acc & 63];
+		acc >>= 6;
+		key[len] = cachefiles_charmap[acc & 63];
+		len += 2;
+
+		seg = 250;
+		for (loop = keylen; loop > 0; loop--) {
+			if (seg <= 0) {
+				key[len++] = '\0';
+				mark = len;
+				key[len++] = '+';
+				seg = 252;
+			}
+
+			key[len++] = *raw++;
+			ASSERT(len < max);
+		}
+
+		switch (type) {
+		case FSCACHE_COOKIE_TYPE_INDEX:		type = 'I';	break;
+		case FSCACHE_COOKIE_TYPE_DATAFILE:	type = 'D';	break;
+		default:				type = 'S';	break;
+		}
+	} else {
+		seg = 252;
+		for (loop = keylen; loop > 0; loop--) {
+			if (seg <= 0) {
+				key[len++] = '\0';
+				mark = len;
+				key[len++] = '+';
+				seg = 252;
+			}
+
+			acc = *raw++;
+			acc |= *raw++ << 8;
+			acc |= *raw++ << 16;
+
+			_debug("acc: %06x", acc);
+
+			key[len++] = cachefiles_charmap[acc & 63];
+			acc >>= 6;
+			key[len++] = cachefiles_charmap[acc & 63];
+			acc >>= 6;
+			key[len++] = cachefiles_charmap[acc & 63];
+			acc >>= 6;
+			key[len++] = cachefiles_charmap[acc & 63];
+
+			ASSERT(len < max);
+		}
+
+		switch (type) {
+		case FSCACHE_COOKIE_TYPE_INDEX:		type = 'J';	break;
+		case FSCACHE_COOKIE_TYPE_DATAFILE:	type = 'E';	break;
+		default:				type = 'T';	break;
+		}
+	}
+
+	key[mark] = type;
+	key[len++] = 0;
+	key[len] = 0;
+
+	_leave(" = %s %d", key, len);
+	return key;
+}
diff --git a/fs/cachefiles_old/main.c b/fs/cachefiles_old/main.c
new file mode 100644
index 000000000000..d3115106b22b
--- /dev/null
+++ b/fs/cachefiles_old/main.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Network filesystem caching backend to use cache files on a premounted
+ * filesystem
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
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
+#include <linux/sysctl.h>
+#include <linux/miscdevice.h>
+#define CREATE_TRACE_POINTS
+#include "internal.h"
+
+unsigned cachefiles_debug;
+module_param_named(debug, cachefiles_debug, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(cachefiles_debug, "CacheFiles debugging mask");
+
+MODULE_DESCRIPTION("Mounted-filesystem based cache");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+struct kmem_cache *cachefiles_object_jar;
+
+static struct miscdevice cachefiles_dev = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= "cachefiles",
+	.fops	= &cachefiles_daemon_fops,
+};
+
+static void cachefiles_object_init_once(void *_object)
+{
+	struct cachefiles_object *object = _object;
+
+	memset(object, 0, sizeof(*object));
+}
+
+/*
+ * initialise the fs caching module
+ */
+static int __init cachefiles_init(void)
+{
+	int ret;
+
+	ret = misc_register(&cachefiles_dev);
+	if (ret < 0)
+		goto error_dev;
+
+	/* create an object jar */
+	ret = -ENOMEM;
+	cachefiles_object_jar =
+		kmem_cache_create("cachefiles_object_jar",
+				  sizeof(struct cachefiles_object),
+				  0,
+				  SLAB_HWCACHE_ALIGN,
+				  cachefiles_object_init_once);
+	if (!cachefiles_object_jar) {
+		pr_notice("Failed to allocate an object jar\n");
+		goto error_object_jar;
+	}
+
+	pr_info("Loaded\n");
+	return 0;
+
+error_object_jar:
+	misc_deregister(&cachefiles_dev);
+error_dev:
+	pr_err("failed to register: %d\n", ret);
+	return ret;
+}
+
+fs_initcall(cachefiles_init);
+
+/*
+ * clean up on module removal
+ */
+static void __exit cachefiles_exit(void)
+{
+	pr_info("Unloading\n");
+
+	kmem_cache_destroy(cachefiles_object_jar);
+	misc_deregister(&cachefiles_dev);
+}
+
+module_exit(cachefiles_exit);
diff --git a/fs/cachefiles_old/namei.c b/fs/cachefiles_old/namei.c
new file mode 100644
index 000000000000..a9aca5ab5970
--- /dev/null
+++ b/fs/cachefiles_old/namei.c
@@ -0,0 +1,1018 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* CacheFiles path walking and related routines
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
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
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/security.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+#define CACHEFILES_KEYBUF_SIZE 512
+
+/*
+ * dump debugging info about an object
+ */
+static noinline
+void __cachefiles_printk_object(struct cachefiles_object *object,
+				const char *prefix)
+{
+	struct fscache_cookie *cookie;
+	const u8 *k;
+	unsigned loop;
+
+	pr_err("%sobject: OBJ%x\n", prefix, object->fscache.debug_id);
+	pr_err("%sobjstate=%s fl=%lx wbusy=%x ev=%lx[%lx]\n",
+	       prefix, object->fscache.state->name,
+	       object->fscache.flags, work_busy(&object->fscache.work),
+	       object->fscache.events, object->fscache.event_mask);
+	pr_err("%sops=%u inp=%u exc=%u\n",
+	       prefix, object->fscache.n_ops, object->fscache.n_in_progress,
+	       object->fscache.n_exclusive);
+	pr_err("%sparent=%x\n",
+	       prefix, object->fscache.parent ? object->fscache.parent->debug_id : 0);
+
+	spin_lock(&object->fscache.lock);
+	cookie = object->fscache.cookie;
+	if (cookie) {
+		pr_err("%scookie=%x [pr=%x nd=%p fl=%lx]\n",
+		       prefix,
+		       cookie->debug_id,
+		       cookie->parent ? cookie->parent->debug_id : 0,
+		       cookie->netfs_data,
+		       cookie->flags);
+		pr_err("%skey=[%u] '", prefix, cookie->key_len);
+		k = (cookie->key_len <= sizeof(cookie->inline_key)) ?
+			cookie->inline_key : cookie->key;
+		for (loop = 0; loop < cookie->key_len; loop++)
+			pr_cont("%02x", k[loop]);
+		pr_cont("'\n");
+	} else {
+		pr_err("%scookie=NULL\n", prefix);
+	}
+	spin_unlock(&object->fscache.lock);
+}
+
+/*
+ * dump debugging info about a pair of objects
+ */
+static noinline void cachefiles_printk_object(struct cachefiles_object *object,
+					      struct cachefiles_object *xobject)
+{
+	if (object)
+		__cachefiles_printk_object(object, "");
+	if (xobject)
+		__cachefiles_printk_object(xobject, "x");
+}
+
+/*
+ * mark the owner of a dentry, if there is one, to indicate that that dentry
+ * has been preemptively deleted
+ * - the caller must hold the i_mutex on the dentry's parent as required to
+ *   call vfs_unlink(), vfs_rmdir() or vfs_rename()
+ */
+static void cachefiles_mark_object_buried(struct cachefiles_cache *cache,
+					  struct dentry *dentry,
+					  enum fscache_why_object_killed why)
+{
+	struct cachefiles_object *object;
+	struct rb_node *p;
+
+	_enter(",'%pd'", dentry);
+
+	write_lock(&cache->active_lock);
+
+	p = cache->active_nodes.rb_node;
+	while (p) {
+		object = rb_entry(p, struct cachefiles_object, active_node);
+		if (object->dentry > dentry)
+			p = p->rb_left;
+		else if (object->dentry < dentry)
+			p = p->rb_right;
+		else
+			goto found_dentry;
+	}
+
+	write_unlock(&cache->active_lock);
+	trace_cachefiles_mark_buried(NULL, dentry, why);
+	_leave(" [no owner]");
+	return;
+
+	/* found the dentry for  */
+found_dentry:
+	kdebug("preemptive burial: OBJ%x [%s] %pd",
+	       object->fscache.debug_id,
+	       object->fscache.state->name,
+	       dentry);
+
+	trace_cachefiles_mark_buried(object, dentry, why);
+
+	if (fscache_object_is_live(&object->fscache)) {
+		pr_err("\n");
+		pr_err("Error: Can't preemptively bury live object\n");
+		cachefiles_printk_object(object, NULL);
+	} else {
+		if (why != FSCACHE_OBJECT_IS_STALE)
+			fscache_object_mark_killed(&object->fscache, why);
+	}
+
+	write_unlock(&cache->active_lock);
+	_leave(" [owner marked]");
+}
+
+/*
+ * record the fact that an object is now active
+ */
+static int cachefiles_mark_object_active(struct cachefiles_cache *cache,
+					 struct cachefiles_object *object)
+{
+	struct cachefiles_object *xobject;
+	struct rb_node **_p, *_parent = NULL;
+	struct dentry *dentry;
+
+	_enter(",%x", object->fscache.debug_id);
+
+try_again:
+	write_lock(&cache->active_lock);
+
+	dentry = object->dentry;
+	trace_cachefiles_mark_active(object, dentry);
+
+	if (test_and_set_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags)) {
+		pr_err("Error: Object already active\n");
+		cachefiles_printk_object(object, NULL);
+		BUG();
+	}
+
+	_p = &cache->active_nodes.rb_node;
+	while (*_p) {
+		_parent = *_p;
+		xobject = rb_entry(_parent,
+				   struct cachefiles_object, active_node);
+
+		ASSERT(xobject != object);
+
+		if (xobject->dentry > dentry)
+			_p = &(*_p)->rb_left;
+		else if (xobject->dentry < dentry)
+			_p = &(*_p)->rb_right;
+		else
+			goto wait_for_old_object;
+	}
+
+	rb_link_node(&object->active_node, _parent, _p);
+	rb_insert_color(&object->active_node, &cache->active_nodes);
+
+	write_unlock(&cache->active_lock);
+	_leave(" = 0");
+	return 0;
+
+	/* an old object from a previous incarnation is hogging the slot - we
+	 * need to wait for it to be destroyed */
+wait_for_old_object:
+	trace_cachefiles_wait_active(object, dentry, xobject);
+	clear_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags);
+
+	if (fscache_object_is_live(&xobject->fscache)) {
+		pr_err("\n");
+		pr_err("Error: Unexpected object collision\n");
+		cachefiles_printk_object(object, xobject);
+	}
+	atomic_inc(&xobject->usage);
+	write_unlock(&cache->active_lock);
+
+	if (test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags)) {
+		wait_queue_head_t *wq;
+
+		signed long timeout = 60 * HZ;
+		wait_queue_entry_t wait;
+		bool requeue;
+
+		/* if the object we're waiting for is queued for processing,
+		 * then just put ourselves on the queue behind it */
+		if (work_pending(&xobject->fscache.work)) {
+			_debug("queue OBJ%x behind OBJ%x immediately",
+			       object->fscache.debug_id,
+			       xobject->fscache.debug_id);
+			goto requeue;
+		}
+
+		/* otherwise we sleep until either the object we're waiting for
+		 * is done, or the fscache_object is congested */
+		wq = bit_waitqueue(&xobject->flags, CACHEFILES_OBJECT_ACTIVE);
+		init_wait(&wait);
+		requeue = false;
+		do {
+			prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
+			if (!test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags))
+				break;
+
+			requeue = fscache_object_sleep_till_congested(&timeout);
+		} while (timeout > 0 && !requeue);
+		finish_wait(wq, &wait);
+
+		if (requeue &&
+		    test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags)) {
+			_debug("queue OBJ%x behind OBJ%x after wait",
+			       object->fscache.debug_id,
+			       xobject->fscache.debug_id);
+			goto requeue;
+		}
+
+		if (timeout <= 0) {
+			pr_err("\n");
+			pr_err("Error: Overlong wait for old active object to go away\n");
+			cachefiles_printk_object(object, xobject);
+			goto requeue;
+		}
+	}
+
+	ASSERT(!test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags));
+
+	cache->cache.ops->put_object(&xobject->fscache,
+		(enum fscache_obj_ref_trace)cachefiles_obj_put_wait_retry);
+	goto try_again;
+
+requeue:
+	cache->cache.ops->put_object(&xobject->fscache,
+		(enum fscache_obj_ref_trace)cachefiles_obj_put_wait_timeo);
+	_leave(" = -ETIMEDOUT");
+	return -ETIMEDOUT;
+}
+
+/*
+ * Mark an object as being inactive.
+ */
+void cachefiles_mark_object_inactive(struct cachefiles_cache *cache,
+				     struct cachefiles_object *object,
+				     blkcnt_t i_blocks)
+{
+	struct dentry *dentry = object->dentry;
+	struct inode *inode = d_backing_inode(dentry);
+
+	trace_cachefiles_mark_inactive(object, dentry, inode);
+
+	write_lock(&cache->active_lock);
+	rb_erase(&object->active_node, &cache->active_nodes);
+	clear_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags);
+	write_unlock(&cache->active_lock);
+
+	wake_up_bit(&object->flags, CACHEFILES_OBJECT_ACTIVE);
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
+ * - unlocks the directory mutex
+ */
+static int cachefiles_bury_object(struct cachefiles_cache *cache,
+				  struct cachefiles_object *object,
+				  struct dentry *dir,
+				  struct dentry *rep,
+				  bool preemptive,
+				  enum fscache_why_object_killed why)
+{
+	struct dentry *grave, *trap;
+	struct path path, path_to_graveyard;
+	char nbuffer[8 + 8 + 1];
+	int ret;
+
+	_enter(",'%pd','%pd'", dir, rep);
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
+			ret = vfs_unlink(&init_user_ns, d_inode(dir), rep,
+					 NULL);
+
+			if (preemptive)
+				cachefiles_mark_object_buried(cache, rep, why);
+		}
+
+		inode_unlock(d_inode(dir));
+
+		if (ret == -EIO)
+			cachefiles_io_error(cache, "Unlink failed");
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
+
+		if (PTR_ERR(grave) == -ENOMEM) {
+			_leave(" = -ENOMEM");
+			return -ENOMEM;
+		}
+
+		cachefiles_io_error(cache, "Lookup error %ld",
+				    PTR_ERR(grave));
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
+		ret = vfs_rename(&rd);
+		if (ret != 0 && ret != -ENOMEM)
+			cachefiles_io_error(cache,
+					    "Rename failed with error %d", ret);
+
+		if (preemptive)
+			cachefiles_mark_object_buried(cache, rep, why);
+	}
+
+	unlock_rename(cache->graveyard, dir);
+	dput(grave);
+	_leave(" = 0");
+	return 0;
+}
+
+/*
+ * delete an object representation from the cache
+ */
+int cachefiles_delete_object(struct cachefiles_cache *cache,
+			     struct cachefiles_object *object)
+{
+	struct dentry *dir;
+	int ret;
+
+	_enter(",OBJ%x{%pd}", object->fscache.debug_id, object->dentry);
+
+	ASSERT(object->dentry);
+	ASSERT(d_backing_inode(object->dentry));
+	ASSERT(object->dentry->d_parent);
+
+	dir = dget_parent(object->dentry);
+
+	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+
+	if (test_bit(FSCACHE_OBJECT_KILLED_BY_CACHE, &object->fscache.flags)) {
+		/* object allocation for the same key preemptively deleted this
+		 * object's file so that it could create its own file */
+		_debug("object preemptively buried");
+		inode_unlock(d_inode(dir));
+		ret = 0;
+	} else {
+		/* we need to check that our parent is _still_ our parent - it
+		 * may have been renamed */
+		if (dir == object->dentry->d_parent) {
+			ret = cachefiles_bury_object(cache, object, dir,
+						     object->dentry, false,
+						     FSCACHE_OBJECT_WAS_RETIRED);
+		} else {
+			/* it got moved, presumably by cachefilesd culling it,
+			 * so it's no longer in the key path and we can ignore
+			 * it */
+			inode_unlock(d_inode(dir));
+			ret = 0;
+		}
+	}
+
+	dput(dir);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * walk from the parent object to the child object through the backing
+ * filesystem, creating directories as we go
+ */
+int cachefiles_walk_to_object(struct cachefiles_object *parent,
+			      struct cachefiles_object *object,
+			      const char *key,
+			      struct cachefiles_xattr *auxdata)
+{
+	struct cachefiles_cache *cache;
+	struct dentry *dir, *next = NULL;
+	struct inode *inode;
+	struct path path;
+	const char *name;
+	int ret, nlen;
+
+	_enter("OBJ%x{%pd},OBJ%x,%s,",
+	       parent->fscache.debug_id, parent->dentry,
+	       object->fscache.debug_id, key);
+
+	cache = container_of(parent->fscache.cache,
+			     struct cachefiles_cache, cache);
+	path.mnt = cache->mnt;
+
+	ASSERT(parent->dentry);
+	ASSERT(d_backing_inode(parent->dentry));
+
+	if (!(d_is_dir(parent->dentry))) {
+		// TODO: convert file to dir
+		_leave("looking up in none directory");
+		return -ENOBUFS;
+	}
+
+	dir = dget(parent->dentry);
+
+advance:
+	/* attempt to transit the first directory component */
+	name = key;
+	nlen = strlen(key);
+
+	/* key ends in a double NUL */
+	key = key + nlen + 1;
+	if (!*key)
+		key = NULL;
+
+lookup_again:
+	/* search the current directory for the element name */
+	_debug("lookup '%s'", name);
+
+	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+
+	next = lookup_one_len(name, dir, nlen);
+	if (IS_ERR(next)) {
+		trace_cachefiles_lookup(object, next, NULL);
+		goto lookup_error;
+	}
+
+	inode = d_backing_inode(next);
+	trace_cachefiles_lookup(object, next, inode);
+	_debug("next -> %pd %s", next, inode ? "positive" : "negative");
+
+	if (!key)
+		object->new = !inode;
+
+	/* if this element of the path doesn't exist, then the lookup phase
+	 * failed, and we can release any readers in the certain knowledge that
+	 * there's nothing for them to actually read */
+	if (d_is_negative(next))
+		fscache_object_lookup_negative(&object->fscache);
+
+	/* we need to create the object if it's negative */
+	if (key || object->type == FSCACHE_COOKIE_TYPE_INDEX) {
+		/* index objects and intervening tree levels must be subdirs */
+		if (d_is_negative(next)) {
+			ret = cachefiles_has_space(cache, 1, 0);
+			if (ret < 0)
+				goto no_space_error;
+
+			path.dentry = dir;
+			ret = security_path_mkdir(&path, next, 0);
+			if (ret < 0)
+				goto create_error;
+			ret = vfs_mkdir(&init_user_ns, d_inode(dir), next, 0);
+			if (!key)
+				trace_cachefiles_mkdir(object, next, ret);
+			if (ret < 0)
+				goto create_error;
+
+			if (unlikely(d_unhashed(next))) {
+				dput(next);
+				inode_unlock(d_inode(dir));
+				goto lookup_again;
+			}
+			ASSERT(d_backing_inode(next));
+
+			_debug("mkdir -> %pd{ino=%lu}",
+			       next, d_backing_inode(next)->i_ino);
+
+		} else if (!d_can_lookup(next)) {
+			pr_err("inode %lu is not a directory\n",
+			       d_backing_inode(next)->i_ino);
+			ret = -ENOBUFS;
+			goto error;
+		}
+
+	} else {
+		/* non-index objects start out life as files */
+		if (d_is_negative(next)) {
+			ret = cachefiles_has_space(cache, 1, 0);
+			if (ret < 0)
+				goto no_space_error;
+
+			path.dentry = dir;
+			ret = security_path_mknod(&path, next, S_IFREG, 0);
+			if (ret < 0)
+				goto create_error;
+			ret = vfs_create(&init_user_ns, d_inode(dir), next,
+					 S_IFREG, true);
+			trace_cachefiles_create(object, next, ret);
+			if (ret < 0)
+				goto create_error;
+
+			ASSERT(d_backing_inode(next));
+
+			_debug("create -> %pd{ino=%lu}",
+			       next, d_backing_inode(next)->i_ino);
+
+		} else if (!d_can_lookup(next) &&
+			   !d_is_reg(next)
+			   ) {
+			pr_err("inode %lu is not a file or directory\n",
+			       d_backing_inode(next)->i_ino);
+			ret = -ENOBUFS;
+			goto error;
+		}
+	}
+
+	/* process the next component */
+	if (key) {
+		_debug("advance");
+		inode_unlock(d_inode(dir));
+		dput(dir);
+		dir = next;
+		next = NULL;
+		goto advance;
+	}
+
+	/* we've found the object we were looking for */
+	object->dentry = next;
+
+	/* if we've found that the terminal object exists, then we need to
+	 * check its attributes and delete it if it's out of date */
+	if (!object->new) {
+		_debug("validate '%pd'", next);
+
+		ret = cachefiles_check_object_xattr(object, auxdata);
+		if (ret == -ESTALE) {
+			/* delete the object (the deleter drops the directory
+			 * mutex) */
+			object->dentry = NULL;
+
+			ret = cachefiles_bury_object(cache, object, dir, next,
+						     true,
+						     FSCACHE_OBJECT_IS_STALE);
+			dput(next);
+			next = NULL;
+
+			if (ret < 0)
+				goto delete_error;
+
+			_debug("redo lookup");
+			fscache_object_retrying_stale(&object->fscache);
+			goto lookup_again;
+		}
+	}
+
+	/* note that we're now using this object */
+	ret = cachefiles_mark_object_active(cache, object);
+
+	inode_unlock(d_inode(dir));
+	dput(dir);
+	dir = NULL;
+
+	if (ret == -ETIMEDOUT)
+		goto mark_active_timed_out;
+
+	_debug("=== OBTAINED_OBJECT ===");
+
+	if (object->new) {
+		/* attach data to a newly constructed terminal object */
+		ret = cachefiles_set_object_xattr(object, auxdata);
+		if (ret < 0)
+			goto check_error;
+	} else {
+		/* always update the atime on an object we've just looked up
+		 * (this is used to keep track of culling, and atimes are only
+		 * updated by read, write and readdir but not lookup or
+		 * open) */
+		path.dentry = next;
+		touch_atime(&path);
+	}
+
+	/* open a file interface onto a data file */
+	if (object->type != FSCACHE_COOKIE_TYPE_INDEX) {
+		if (d_is_reg(object->dentry)) {
+			const struct address_space_operations *aops;
+
+			ret = -EPERM;
+			aops = d_backing_inode(object->dentry)->i_mapping->a_ops;
+			if (!aops->bmap)
+				goto check_error;
+			if (object->dentry->d_sb->s_blocksize > PAGE_SIZE)
+				goto check_error;
+
+			object->backer = object->dentry;
+		} else {
+			BUG(); // TODO: open file in data-class subdir
+		}
+	}
+
+	object->new = 0;
+	fscache_obtained_object(&object->fscache);
+
+	_leave(" = 0 [%lu]", d_backing_inode(object->dentry)->i_ino);
+	return 0;
+
+no_space_error:
+	fscache_object_mark_killed(&object->fscache, FSCACHE_OBJECT_NO_SPACE);
+create_error:
+	_debug("create error %d", ret);
+	if (ret == -EIO)
+		cachefiles_io_error(cache, "Create/mkdir failed");
+	goto error;
+
+mark_active_timed_out:
+	_debug("mark active timed out");
+	goto release_dentry;
+
+check_error:
+	_debug("check error %d", ret);
+	cachefiles_mark_object_inactive(
+		cache, object, d_backing_inode(object->dentry)->i_blocks);
+release_dentry:
+	dput(object->dentry);
+	object->dentry = NULL;
+	goto error_out;
+
+delete_error:
+	_debug("delete error %d", ret);
+	goto error_out2;
+
+lookup_error:
+	_debug("lookup error %ld", PTR_ERR(next));
+	ret = PTR_ERR(next);
+	if (ret == -EIO)
+		cachefiles_io_error(cache, "Lookup failed");
+	next = NULL;
+error:
+	inode_unlock(d_inode(dir));
+	dput(next);
+error_out2:
+	dput(dir);
+error_out:
+	_leave(" = error %d", -ret);
+	return ret;
+}
+
+/*
+ * get a subdirectory
+ */
+struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
+					struct dentry *dir,
+					const char *dirname)
+{
+	struct dentry *subdir;
+	struct path path;
+	int ret;
+
+	_enter(",,%s", dirname);
+
+	/* search the current directory for the element name */
+	inode_lock(d_inode(dir));
+
+retry:
+	subdir = lookup_one_len(dirname, dir, strlen(dirname));
+	if (IS_ERR(subdir)) {
+		if (PTR_ERR(subdir) == -ENOMEM)
+			goto nomem_d_alloc;
+		goto lookup_error;
+	}
+
+	_debug("subdir -> %pd %s",
+	       subdir, d_backing_inode(subdir) ? "positive" : "negative");
+
+	/* we need to create the subdir if it doesn't exist yet */
+	if (d_is_negative(subdir)) {
+		ret = cachefiles_has_space(cache, 1, 0);
+		if (ret < 0)
+			goto mkdir_error;
+
+		_debug("attempt mkdir");
+
+		path.mnt = cache->mnt;
+		path.dentry = dir;
+		ret = security_path_mkdir(&path, subdir, 0700);
+		if (ret < 0)
+			goto mkdir_error;
+		ret = vfs_mkdir(&init_user_ns, d_inode(dir), subdir, 0700);
+		if (ret < 0)
+			goto mkdir_error;
+
+		if (unlikely(d_unhashed(subdir))) {
+			dput(subdir);
+			goto retry;
+		}
+		ASSERT(d_backing_inode(subdir));
+
+		_debug("mkdir -> %pd{ino=%lu}",
+		       subdir, d_backing_inode(subdir)->i_ino);
+	}
+
+	inode_unlock(d_inode(dir));
+
+	/* we need to make sure the subdir is a directory */
+	ASSERT(d_backing_inode(subdir));
+
+	if (!d_can_lookup(subdir)) {
+		pr_err("%s is not a directory\n", dirname);
+		ret = -EIO;
+		goto check_error;
+	}
+
+	ret = -EPERM;
+	if (!(d_backing_inode(subdir)->i_opflags & IOP_XATTR) ||
+	    !d_backing_inode(subdir)->i_op->lookup ||
+	    !d_backing_inode(subdir)->i_op->mkdir ||
+	    !d_backing_inode(subdir)->i_op->create ||
+	    !d_backing_inode(subdir)->i_op->rename ||
+	    !d_backing_inode(subdir)->i_op->rmdir ||
+	    !d_backing_inode(subdir)->i_op->unlink)
+		goto check_error;
+
+	_leave(" = [%lu]", d_backing_inode(subdir)->i_ino);
+	return subdir;
+
+check_error:
+	dput(subdir);
+	_leave(" = %d [check]", ret);
+	return ERR_PTR(ret);
+
+mkdir_error:
+	inode_unlock(d_inode(dir));
+	dput(subdir);
+	pr_err("mkdir %s failed with error %d\n", dirname, ret);
+	return ERR_PTR(ret);
+
+lookup_error:
+	inode_unlock(d_inode(dir));
+	ret = PTR_ERR(subdir);
+	pr_err("Lookup %s failed with error %d\n", dirname, ret);
+	return ERR_PTR(ret);
+
+nomem_d_alloc:
+	inode_unlock(d_inode(dir));
+	_leave(" = -ENOMEM");
+	return ERR_PTR(-ENOMEM);
+}
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
+	struct cachefiles_object *object;
+	struct rb_node *_n;
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
+	/* check to see if we're using this object */
+	read_lock(&cache->active_lock);
+
+	_n = cache->active_nodes.rb_node;
+
+	while (_n) {
+		object = rb_entry(_n, struct cachefiles_object, active_node);
+
+		if (object->dentry > victim)
+			_n = _n->rb_left;
+		else if (object->dentry < victim)
+			_n = _n->rb_right;
+		else
+			goto object_in_use;
+	}
+
+	read_unlock(&cache->active_lock);
+
+	//_leave(" = %pd", victim);
+	return victim;
+
+object_in_use:
+	read_unlock(&cache->active_lock);
+	inode_unlock(d_inode(dir));
+	dput(victim);
+	//_leave(" = -EBUSY [in use]");
+	return ERR_PTR(-EBUSY);
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
+	int ret;
+
+	_enter(",%pd/,%s", dir, filename);
+
+	victim = cachefiles_check_active(cache, dir, filename);
+	if (IS_ERR(victim))
+		return PTR_ERR(victim);
+
+	_debug("victim -> %pd %s",
+	       victim, d_backing_inode(victim) ? "positive" : "negative");
+
+	/* okay... the victim is not being used so we can cull it
+	 * - start by marking it as stale
+	 */
+	_debug("victim is cullable");
+
+	ret = cachefiles_remove_object_xattr(cache, victim);
+	if (ret < 0)
+		goto error_unlock;
+
+	/*  actually remove the victim (drops the dir mutex) */
+	_debug("bury");
+
+	ret = cachefiles_bury_object(cache, NULL, dir, victim, false,
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
+
+	//_enter(",%pd/,%s",
+	//       dir, filename);
+
+	victim = cachefiles_check_active(cache, dir, filename);
+	if (IS_ERR(victim))
+		return PTR_ERR(victim);
+
+	inode_unlock(d_inode(dir));
+	dput(victim);
+	//_leave(" = 0");
+	return 0;
+}
diff --git a/fs/cachefiles_old/security.c b/fs/cachefiles_old/security.c
new file mode 100644
index 000000000000..aec13fd94692
--- /dev/null
+++ b/fs/cachefiles_old/security.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* CacheFiles security management
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
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
diff --git a/fs/cachefiles_old/xattr.c b/fs/cachefiles_old/xattr.c
new file mode 100644
index 000000000000..9e82de668595
--- /dev/null
+++ b/fs/cachefiles_old/xattr.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* CacheFiles extended attribute management
+ *
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
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
+static const char cachefiles_xattr_cache[] =
+	XATTR_USER_PREFIX "CacheFiles.cache";
+
+/*
+ * check the type label on an object
+ * - done using xattrs
+ */
+int cachefiles_check_object_type(struct cachefiles_object *object)
+{
+	struct dentry *dentry = object->dentry;
+	char type[3], xtype[3];
+	int ret;
+
+	ASSERT(dentry);
+	ASSERT(d_backing_inode(dentry));
+
+	if (!object->fscache.cookie)
+		strcpy(type, "C3");
+	else
+		snprintf(type, 3, "%02x", object->fscache.cookie->def->type);
+
+	_enter("%x{%s}", object->fscache.debug_id, type);
+
+	/* attempt to install a type label directly */
+	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache, type,
+			   2, XATTR_CREATE);
+	if (ret == 0) {
+		_debug("SET"); /* we succeeded */
+		goto error;
+	}
+
+	if (ret != -EEXIST) {
+		pr_err("Can't set xattr on %pd [%lu] (err %d)\n",
+		       dentry, d_backing_inode(dentry)->i_ino,
+		       -ret);
+		goto error;
+	}
+
+	/* read the current type label */
+	ret = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, xtype,
+			   3);
+	if (ret < 0) {
+		if (ret == -ERANGE)
+			goto bad_type_length;
+
+		pr_err("Can't read xattr on %pd [%lu] (err %d)\n",
+		       dentry, d_backing_inode(dentry)->i_ino,
+		       -ret);
+		goto error;
+	}
+
+	/* check the type is what we're expecting */
+	if (ret != 2)
+		goto bad_type_length;
+
+	if (xtype[0] != type[0] || xtype[1] != type[1])
+		goto bad_type;
+
+	ret = 0;
+
+error:
+	_leave(" = %d", ret);
+	return ret;
+
+bad_type_length:
+	pr_err("Cache object %lu type xattr length incorrect\n",
+	       d_backing_inode(dentry)->i_ino);
+	ret = -EIO;
+	goto error;
+
+bad_type:
+	xtype[2] = 0;
+	pr_err("Cache object %pd [%lu] type %s not %s\n",
+	       dentry, d_backing_inode(dentry)->i_ino,
+	       xtype, type);
+	ret = -EIO;
+	goto error;
+}
+
+/*
+ * set the state xattr on a cache file
+ */
+int cachefiles_set_object_xattr(struct cachefiles_object *object,
+				struct cachefiles_xattr *auxdata)
+{
+	struct dentry *dentry = object->dentry;
+	int ret;
+
+	ASSERT(dentry);
+
+	_enter("%p,#%d", object, auxdata->len);
+
+	/* attempt to install the cache metadata directly */
+	_debug("SET #%u", auxdata->len);
+
+	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
+	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
+			   &auxdata->type, auxdata->len, XATTR_CREATE);
+	if (ret < 0 && ret != -ENOMEM)
+		cachefiles_io_error_obj(
+			object,
+			"Failed to set xattr with error %d", ret);
+
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * update the state xattr on a cache file
+ */
+int cachefiles_update_object_xattr(struct cachefiles_object *object,
+				   struct cachefiles_xattr *auxdata)
+{
+	struct dentry *dentry = object->dentry;
+	int ret;
+
+	if (!dentry)
+		return -ESTALE;
+
+	_enter("%x,#%d", object->fscache.debug_id, auxdata->len);
+
+	/* attempt to install the cache metadata directly */
+	_debug("SET #%u", auxdata->len);
+
+	clear_bit(FSCACHE_COOKIE_AUX_UPDATED, &object->fscache.cookie->flags);
+	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
+			   &auxdata->type, auxdata->len, XATTR_REPLACE);
+	if (ret < 0 && ret != -ENOMEM)
+		cachefiles_io_error_obj(
+			object,
+			"Failed to update xattr with error %d", ret);
+
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * check the consistency between the backing cache and the FS-Cache cookie
+ */
+int cachefiles_check_auxdata(struct cachefiles_object *object)
+{
+	struct cachefiles_xattr *auxbuf;
+	enum fscache_checkaux validity;
+	struct dentry *dentry = object->dentry;
+	ssize_t xlen;
+	int ret;
+
+	ASSERT(dentry);
+	ASSERT(d_backing_inode(dentry));
+	ASSERT(object->fscache.cookie->def->check_aux);
+
+	auxbuf = kmalloc(sizeof(struct cachefiles_xattr) + 512, GFP_KERNEL);
+	if (!auxbuf)
+		return -ENOMEM;
+
+	xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
+			    &auxbuf->type, 512 + 1);
+	ret = -ESTALE;
+	if (xlen < 1 ||
+	    auxbuf->type != object->fscache.cookie->def->type)
+		goto error;
+
+	xlen--;
+	validity = fscache_check_aux(&object->fscache, &auxbuf->data, xlen,
+				     i_size_read(d_backing_inode(dentry)));
+	if (validity != FSCACHE_CHECKAUX_OKAY)
+		goto error;
+
+	ret = 0;
+error:
+	kfree(auxbuf);
+	return ret;
+}
+
+/*
+ * check the state xattr on a cache file
+ * - return -ESTALE if the object should be deleted
+ */
+int cachefiles_check_object_xattr(struct cachefiles_object *object,
+				  struct cachefiles_xattr *auxdata)
+{
+	struct cachefiles_xattr *auxbuf;
+	struct dentry *dentry = object->dentry;
+	int ret;
+
+	_enter("%p,#%d", object, auxdata->len);
+
+	ASSERT(dentry);
+	ASSERT(d_backing_inode(dentry));
+
+	auxbuf = kmalloc(sizeof(struct cachefiles_xattr) + 512, cachefiles_gfp);
+	if (!auxbuf) {
+		_leave(" = -ENOMEM");
+		return -ENOMEM;
+	}
+
+	/* read the current type label */
+	ret = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
+			   &auxbuf->type, 512 + 1);
+	if (ret < 0) {
+		if (ret == -ENODATA)
+			goto stale; /* no attribute - power went off
+				     * mid-cull? */
+
+		if (ret == -ERANGE)
+			goto bad_type_length;
+
+		cachefiles_io_error_obj(object,
+					"Can't read xattr on %lu (err %d)",
+					d_backing_inode(dentry)->i_ino, -ret);
+		goto error;
+	}
+
+	/* check the on-disk object */
+	if (ret < 1)
+		goto bad_type_length;
+
+	if (auxbuf->type != auxdata->type)
+		goto stale;
+
+	auxbuf->len = ret;
+
+	/* consult the netfs */
+	if (object->fscache.cookie->def->check_aux) {
+		enum fscache_checkaux result;
+		unsigned int dlen;
+
+		dlen = auxbuf->len - 1;
+
+		_debug("checkaux %s #%u",
+		       object->fscache.cookie->def->name, dlen);
+
+		result = fscache_check_aux(&object->fscache,
+					   &auxbuf->data, dlen,
+					   i_size_read(d_backing_inode(dentry)));
+
+		switch (result) {
+			/* entry okay as is */
+		case FSCACHE_CHECKAUX_OKAY:
+			goto okay;
+
+			/* entry requires update */
+		case FSCACHE_CHECKAUX_NEEDS_UPDATE:
+			break;
+
+			/* entry requires deletion */
+		case FSCACHE_CHECKAUX_OBSOLETE:
+			goto stale;
+
+		default:
+			BUG();
+		}
+
+		/* update the current label */
+		ret = vfs_setxattr(&init_user_ns, dentry,
+				   cachefiles_xattr_cache, &auxdata->type,
+				   auxdata->len, XATTR_REPLACE);
+		if (ret < 0) {
+			cachefiles_io_error_obj(object,
+						"Can't update xattr on %lu"
+						" (error %d)",
+						d_backing_inode(dentry)->i_ino, -ret);
+			goto error;
+		}
+	}
+
+okay:
+	ret = 0;
+
+error:
+	kfree(auxbuf);
+	_leave(" = %d", ret);
+	return ret;
+
+bad_type_length:
+	pr_err("Cache object %lu xattr length incorrect\n",
+	       d_backing_inode(dentry)->i_ino);
+	ret = -EIO;
+	goto error;
+
+stale:
+	ret = -ESTALE;
+	goto error;
+}
+
+/*
+ * remove the object's xattr to mark it stale
+ */
+int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
+				   struct dentry *dentry)
+{
+	int ret;
+
+	ret = vfs_removexattr(&init_user_ns, dentry, cachefiles_xattr_cache);
+	if (ret < 0) {
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
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
deleted file mode 100644
index 920b6a303d60..000000000000
--- a/include/trace/events/cachefiles.h
+++ /dev/null
@@ -1,321 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/* CacheFiles tracepoints
- *
- * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM cachefiles
-
-#if !defined(_TRACE_CACHEFILES_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_CACHEFILES_H
-
-#include <linux/tracepoint.h>
-
-/*
- * Define enums for tracing information.
- */
-#ifndef __CACHEFILES_DECLARE_TRACE_ENUMS_ONCE_ONLY
-#define __CACHEFILES_DECLARE_TRACE_ENUMS_ONCE_ONLY
-
-enum cachefiles_obj_ref_trace {
-	cachefiles_obj_put_wait_retry = fscache_obj_ref__nr_traces,
-	cachefiles_obj_put_wait_timeo,
-	cachefiles_obj_ref__nr_traces
-};
-
-#endif
-
-/*
- * Define enum -> string mappings for display.
- */
-#define cachefiles_obj_kill_traces				\
-	EM(FSCACHE_OBJECT_IS_STALE,	"stale")		\
-	EM(FSCACHE_OBJECT_NO_SPACE,	"no_space")		\
-	EM(FSCACHE_OBJECT_WAS_RETIRED,	"was_retired")		\
-	E_(FSCACHE_OBJECT_WAS_CULLED,	"was_culled")
-
-#define cachefiles_obj_ref_traces					\
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
-
-/*
- * Export enum symbols via userspace.
- */
-#undef EM
-#undef E_
-#define EM(a, b) TRACE_DEFINE_ENUM(a);
-#define E_(a, b) TRACE_DEFINE_ENUM(a);
-
-cachefiles_obj_kill_traces;
-cachefiles_obj_ref_traces;
-
-/*
- * Now redefine the EM() and E_() macros to map the enums to the strings that
- * will be printed in the output.
- */
-#undef EM
-#undef E_
-#define EM(a, b)	{ a, b },
-#define E_(a, b)	{ a, b }
-
-
-TRACE_EVENT(cachefiles_ref,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct fscache_cookie *cookie,
-		     enum cachefiles_obj_ref_trace why,
-		     int usage),
-
-	    TP_ARGS(obj, cookie, why, usage),
-
-	    /* Note that obj may be NULL */
-	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj		)
-		    __field(unsigned int,			cookie		)
-		    __field(enum cachefiles_obj_ref_trace,	why		)
-		    __field(int,				usage		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
-		    __entry->cookie	= cookie->debug_id;
-		    __entry->usage	= usage;
-		    __entry->why	= why;
-			   ),
-
-	    TP_printk("c=%08x o=%08x u=%d %s",
-		      __entry->cookie, __entry->obj, __entry->usage,
-		      __print_symbolic(__entry->why, cachefiles_obj_ref_traces))
-	    );
-
-TRACE_EVENT(cachefiles_lookup,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de,
-		     struct inode *inode),
-
-	    TP_ARGS(obj, de, inode),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj	)
-		    __field(struct dentry *,		de	)
-		    __field(struct inode *,		inode	)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
-		    __entry->de		= de;
-		    __entry->inode	= inode;
-			   ),
-
-	    TP_printk("o=%08x d=%p i=%p",
-		      __entry->obj, __entry->de, __entry->inode)
-	    );
-
-TRACE_EVENT(cachefiles_mkdir,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de, int ret),
-
-	    TP_ARGS(obj, de, ret),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj	)
-		    __field(struct dentry *,		de	)
-		    __field(int,			ret	)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
-		    __entry->de		= de;
-		    __entry->ret	= ret;
-			   ),
-
-	    TP_printk("o=%08x d=%p r=%u",
-		      __entry->obj, __entry->de, __entry->ret)
-	    );
-
-TRACE_EVENT(cachefiles_create,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de, int ret),
-
-	    TP_ARGS(obj, de, ret),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj	)
-		    __field(struct dentry *,		de	)
-		    __field(int,			ret	)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
-		    __entry->de		= de;
-		    __entry->ret	= ret;
-			   ),
-
-	    TP_printk("o=%08x d=%p r=%u",
-		      __entry->obj, __entry->de, __entry->ret)
-	    );
-
-TRACE_EVENT(cachefiles_unlink,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de,
-		     enum fscache_why_object_killed why),
-
-	    TP_ARGS(obj, de, why),
-
-	    /* Note that obj may be NULL */
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(struct dentry *,		de		)
-		    __field(enum fscache_why_object_killed, why		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj ? obj->fscache.debug_id : UINT_MAX;
-		    __entry->de		= de;
-		    __entry->why	= why;
-			   ),
-
-	    TP_printk("o=%08x d=%p w=%s",
-		      __entry->obj, __entry->de,
-		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
-	    );
-
-TRACE_EVENT(cachefiles_rename,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de,
-		     struct dentry *to,
-		     enum fscache_why_object_killed why),
-
-	    TP_ARGS(obj, de, to, why),
-
-	    /* Note that obj may be NULL */
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(struct dentry *,		de		)
-		    __field(struct dentry *,		to		)
-		    __field(enum fscache_why_object_killed, why		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj ? obj->fscache.debug_id : UINT_MAX;
-		    __entry->de		= de;
-		    __entry->to		= to;
-		    __entry->why	= why;
-			   ),
-
-	    TP_printk("o=%08x d=%p t=%p w=%s",
-		      __entry->obj, __entry->de, __entry->to,
-		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
-	    );
-
-TRACE_EVENT(cachefiles_mark_active,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de),
-
-	    TP_ARGS(obj, de),
-
-	    /* Note that obj may be NULL */
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(struct dentry *,		de		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
-		    __entry->de		= de;
-			   ),
-
-	    TP_printk("o=%08x d=%p",
-		      __entry->obj, __entry->de)
-	    );
-
-TRACE_EVENT(cachefiles_wait_active,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de,
-		     struct cachefiles_object *xobj),
-
-	    TP_ARGS(obj, de, xobj),
-
-	    /* Note that obj may be NULL */
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(unsigned int,		xobj		)
-		    __field(struct dentry *,		de		)
-		    __field(u16,			flags		)
-		    __field(u16,			fsc_flags	)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
-		    __entry->de		= de;
-		    __entry->xobj	= xobj->fscache.debug_id;
-		    __entry->flags	= xobj->flags;
-		    __entry->fsc_flags	= xobj->fscache.flags;
-			   ),
-
-	    TP_printk("o=%08x d=%p wo=%08x wf=%x wff=%x",
-		      __entry->obj, __entry->de, __entry->xobj,
-		      __entry->flags, __entry->fsc_flags)
-	    );
-
-TRACE_EVENT(cachefiles_mark_inactive,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de,
-		     struct inode *inode),
-
-	    TP_ARGS(obj, de, inode),
-
-	    /* Note that obj may be NULL */
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(struct dentry *,		de		)
-		    __field(struct inode *,		inode		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
-		    __entry->de		= de;
-		    __entry->inode	= inode;
-			   ),
-
-	    TP_printk("o=%08x d=%p i=%p",
-		      __entry->obj, __entry->de, __entry->inode)
-	    );
-
-TRACE_EVENT(cachefiles_mark_buried,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de,
-		     enum fscache_why_object_killed why),
-
-	    TP_ARGS(obj, de, why),
-
-	    /* Note that obj may be NULL */
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(struct dentry *,		de		)
-		    __field(enum fscache_why_object_killed, why		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj ? obj->fscache.debug_id : UINT_MAX;
-		    __entry->de		= de;
-		    __entry->why	= why;
-			   ),
-
-	    TP_printk("o=%08x d=%p w=%s",
-		      __entry->obj, __entry->de,
-		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
-	    );
-
-#endif /* _TRACE_CACHEFILES_H */
-
-/* This part must be outside protection */
-#include <trace/define_trace.h>
diff --git a/include/trace/events/cachefiles_old.h b/include/trace/events/cachefiles_old.h
new file mode 100644
index 000000000000..bffe2ce6de0e
--- /dev/null
+++ b/include/trace/events/cachefiles_old.h
@@ -0,0 +1,321 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* CacheFiles tracepoints
+ *
+ * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cachefiles_old
+
+#if !defined(_TRACE_CACHEFILES_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_CACHEFILES_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * Define enums for tracing information.
+ */
+#ifndef __CACHEFILES_DECLARE_TRACE_ENUMS_ONCE_ONLY
+#define __CACHEFILES_DECLARE_TRACE_ENUMS_ONCE_ONLY
+
+enum cachefiles_obj_ref_trace {
+	cachefiles_obj_put_wait_retry = fscache_obj_ref__nr_traces,
+	cachefiles_obj_put_wait_timeo,
+	cachefiles_obj_ref__nr_traces
+};
+
+#endif
+
+/*
+ * Define enum -> string mappings for display.
+ */
+#define cachefiles_obj_kill_traces				\
+	EM(FSCACHE_OBJECT_IS_STALE,	"stale")		\
+	EM(FSCACHE_OBJECT_NO_SPACE,	"no_space")		\
+	EM(FSCACHE_OBJECT_WAS_RETIRED,	"was_retired")		\
+	E_(FSCACHE_OBJECT_WAS_CULLED,	"was_culled")
+
+#define cachefiles_obj_ref_traces					\
+	EM(fscache_obj_get_add_to_deps,		"GET add_to_deps")	\
+	EM(fscache_obj_get_queue,		"GET queue")		\
+	EM(fscache_obj_put_alloc_fail,		"PUT alloc_fail")	\
+	EM(fscache_obj_put_attach_fail,		"PUT attach_fail")	\
+	EM(fscache_obj_put_drop_obj,		"PUT drop_obj")		\
+	EM(fscache_obj_put_enq_dep,		"PUT enq_dep")		\
+	EM(fscache_obj_put_queue,		"PUT queue")		\
+	EM(fscache_obj_put_work,		"PUT work")		\
+	EM(cachefiles_obj_put_wait_retry,	"PUT wait_retry")	\
+	E_(cachefiles_obj_put_wait_timeo,	"PUT wait_timeo")
+
+/*
+ * Export enum symbols via userspace.
+ */
+#undef EM
+#undef E_
+#define EM(a, b) TRACE_DEFINE_ENUM(a);
+#define E_(a, b) TRACE_DEFINE_ENUM(a);
+
+cachefiles_obj_kill_traces;
+cachefiles_obj_ref_traces;
+
+/*
+ * Now redefine the EM() and E_() macros to map the enums to the strings that
+ * will be printed in the output.
+ */
+#undef EM
+#undef E_
+#define EM(a, b)	{ a, b },
+#define E_(a, b)	{ a, b }
+
+
+TRACE_EVENT(cachefiles_ref,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct fscache_cookie *cookie,
+		     enum cachefiles_obj_ref_trace why,
+		     int usage),
+
+	    TP_ARGS(obj, cookie, why, usage),
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
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->cookie	= cookie->debug_id;
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
+		     struct dentry *de,
+		     struct inode *inode),
+
+	    TP_ARGS(obj, de, inode),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj	)
+		    __field(struct dentry *,		de	)
+		    __field(struct inode *,		inode	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->de		= de;
+		    __entry->inode	= inode;
+			   ),
+
+	    TP_printk("o=%08x d=%p i=%p",
+		      __entry->obj, __entry->de, __entry->inode)
+	    );
+
+TRACE_EVENT(cachefiles_mkdir,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct dentry *de, int ret),
+
+	    TP_ARGS(obj, de, ret),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj	)
+		    __field(struct dentry *,		de	)
+		    __field(int,			ret	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->de		= de;
+		    __entry->ret	= ret;
+			   ),
+
+	    TP_printk("o=%08x d=%p r=%u",
+		      __entry->obj, __entry->de, __entry->ret)
+	    );
+
+TRACE_EVENT(cachefiles_create,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct dentry *de, int ret),
+
+	    TP_ARGS(obj, de, ret),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj	)
+		    __field(struct dentry *,		de	)
+		    __field(int,			ret	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->de		= de;
+		    __entry->ret	= ret;
+			   ),
+
+	    TP_printk("o=%08x d=%p r=%u",
+		      __entry->obj, __entry->de, __entry->ret)
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
+		    __entry->obj	= obj ? obj->fscache.debug_id : UINT_MAX;
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
+		    __entry->obj	= obj ? obj->fscache.debug_id : UINT_MAX;
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
+		     struct dentry *de),
+
+	    TP_ARGS(obj, de),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj		)
+		    __field(struct dentry *,		de		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->de		= de;
+			   ),
+
+	    TP_printk("o=%08x d=%p",
+		      __entry->obj, __entry->de)
+	    );
+
+TRACE_EVENT(cachefiles_wait_active,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct dentry *de,
+		     struct cachefiles_object *xobj),
+
+	    TP_ARGS(obj, de, xobj),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj		)
+		    __field(unsigned int,		xobj		)
+		    __field(struct dentry *,		de		)
+		    __field(u16,			flags		)
+		    __field(u16,			fsc_flags	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->de		= de;
+		    __entry->xobj	= xobj->fscache.debug_id;
+		    __entry->flags	= xobj->flags;
+		    __entry->fsc_flags	= xobj->fscache.flags;
+			   ),
+
+	    TP_printk("o=%08x d=%p wo=%08x wf=%x wff=%x",
+		      __entry->obj, __entry->de, __entry->xobj,
+		      __entry->flags, __entry->fsc_flags)
+	    );
+
+TRACE_EVENT(cachefiles_mark_inactive,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct dentry *de,
+		     struct inode *inode),
+
+	    TP_ARGS(obj, de, inode),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj		)
+		    __field(struct dentry *,		de		)
+		    __field(struct inode *,		inode		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->de		= de;
+		    __entry->inode	= inode;
+			   ),
+
+	    TP_printk("o=%08x d=%p i=%p",
+		      __entry->obj, __entry->de, __entry->inode)
+	    );
+
+TRACE_EVENT(cachefiles_mark_buried,
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
+		    __entry->obj	= obj ? obj->fscache.debug_id : UINT_MAX;
+		    __entry->de		= de;
+		    __entry->why	= why;
+			   ),
+
+	    TP_printk("o=%08x d=%p w=%s",
+		      __entry->obj, __entry->de,
+		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
+	    );
+
+#endif /* _TRACE_CACHEFILES_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>


