Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B363A47DAA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 00:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245660AbhLVXXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Dec 2021 18:23:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238308AbhLVXXc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640215402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1goU2C4G3BIo7b60Rn5XCOvPYyp/yIASHJtosz/QDtk=;
        b=bj0WRZNkgp7H1uepHZm25qcnFC4RzpU+8Qw6jGjE3yzTXsGLvgS0xsfx2r018BAEBQPBpR
        xsSYcc2GypM77rZr7PD6pZGTQa2cHvscehP6zwN1RZo3l2eND0/wtzXDy0Y6AVtaEXEZFN
        hXi1DRUIF9JOAK0up1X9x2LElGylh1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-qq8JBlqJMsaCg9JZ0zoQdg-1; Wed, 22 Dec 2021 18:23:16 -0500
X-MC-Unique: qq8JBlqJMsaCg9JZ0zoQdg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5685510168C0;
        Wed, 22 Dec 2021 23:23:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E400E7ED6A;
        Wed, 22 Dec 2021 23:23:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 36/68] cachefiles: Register a miscdev and parse commands
 over it
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
Date:   Wed, 22 Dec 2021 23:23:04 +0000
Message-ID: <164021538400.640689.9172006906288062041.stgit@warthog.procyon.org.uk>
In-Reply-To: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Register a misc device with which to talk to the daemon.  The misc device
holds a cache set up through it around and closing the device kills the
cache.

cachefilesd communicates with the kernel by passing it single-line text
commands.  Parse these and use them to parameterise the cache state.  This
does not implement the command to actually bring a cache online.  That's
left for later.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819628388.215744.17712097043607299608.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906929128.143852.14065207858943654011.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163967139085.1823006.3514846391807454287.stgit@warthog.procyon.org.uk/ # v3
---

 fs/cachefiles/Makefile   |    1 
 fs/cachefiles/daemon.c   |  725 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h |   14 +
 fs/cachefiles/main.c     |   12 +
 4 files changed, 752 insertions(+)
 create mode 100644 fs/cachefiles/daemon.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 28bbb0d14868..f008524bb78f 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -4,6 +4,7 @@
 #
 
 cachefiles-y := \
+	daemon.o \
 	main.o \
 	security.o
 
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
new file mode 100644
index 000000000000..4cfb7c8b37d0
--- /dev/null
+++ b/fs/cachefiles/daemon.c
@@ -0,0 +1,725 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Daemon interface
+ *
+ * Copyright (C) 2007, 2021 Red Hat, Inc. All Rights Reserved.
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
+static int cachefiles_daemon_bind(struct cachefiles_cache *, char *);
+static void cachefiles_daemon_unbind(struct cachefiles_cache *);
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
+ * Prepare a cache for caching.
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
+ * Release a cache.
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
+ * Read the cache state.
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
+	// PLACEHOLDER: Check space
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
+ * Take a command from cachefilesd, parse it and act on it.
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
+ * Poll for culling state
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
+ * Give a range error for cache space constraints
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
+ * Set the percentage of files at which to stop culling
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
+ * Set the percentage of files at which to start culling
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
+ * Set the percentage of files at which to stop allocating
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
+ * Set the percentage of blocks at which to stop culling
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
+ * Set the percentage of blocks at which to start culling
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
+ * Set the percentage of blocks at which to stop allocating
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
+ * Set the cache directory
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
+ * Set the cache security context
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
+ * Set the cache tag
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
+ * Request a node in the cache be culled from the current working directory
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
+	get_fs_pwd(current->fs, &path);
+
+	if (!d_can_lookup(path.dentry))
+		goto notdir;
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	ret = -ENOANO; // PLACEHOLDER: Do culling
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
+ * Set debugging mode
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
+ * Find out whether an object in the current working directory is in use or not
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
+	get_fs_pwd(current->fs, &path);
+
+	if (!d_can_lookup(path.dentry))
+		goto notdir;
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	ret = -ENOANO; // PLACEHOLDER: Check if in use
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
+ * Bind a directory as a cache
+ */
+static int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
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
+	if (cache->fstop_percent >= cache->fcull_percent ||
+	    cache->fcull_percent >= cache->frun_percent ||
+	    cache->frun_percent  >= 100)
+		return -ERANGE;
+
+	if (cache->bstop_percent >= cache->bcull_percent ||
+	    cache->bcull_percent >= cache->brun_percent ||
+	    cache->brun_percent  >= 100)
+		return -ERANGE;
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
+	/* Don't permit already bound caches to be re-bound */
+	if (test_bit(CACHEFILES_READY, &cache->flags)) {
+		pr_err("Cache already bound\n");
+		return -EBUSY;
+	}
+
+	pr_warn("Cache is disabled for development\n");
+	return -ENOANO; // Don't allow the cache to operate yet
+}
+
+/*
+ * Unbind a cache.
+ */
+static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
+{
+	_enter("");
+
+	if (test_bit(CACHEFILES_READY, &cache->flags)) {
+		// PLACEHOLDER: Withdraw cache
+	}
+
+	mntput(cache->mnt);
+
+	kfree(cache->rootdirname);
+	kfree(cache->secctx);
+	kfree(cache->tag);
+
+	_leave("");
+}
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index e57ce5ef875c..7fd5429715ea 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -65,6 +65,20 @@ struct cachefiles_cache {
 
 #include <trace/events/cachefiles.h>
 
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
+ * daemon.c
+ */
+extern const struct file_operations cachefiles_daemon_fops;
+
 /*
  * error_inject.c
  */
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index 387d42c7185f..533e3067d80f 100644
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
@@ -41,10 +47,15 @@ static int __init cachefiles_init(void)
 	ret = cachefiles_register_error_injection();
 	if (ret < 0)
 		goto error_einj;
+	ret = misc_register(&cachefiles_dev);
+	if (ret < 0)
+		goto error_dev;
 
 	pr_info("Loaded\n");
 	return 0;
 
+error_dev:
+	cachefiles_unregister_error_injection();
 error_einj:
 	pr_err("failed to register: %d\n", ret);
 	return ret;
@@ -59,6 +70,7 @@ static void __exit cachefiles_exit(void)
 {
 	pr_info("Unloading\n");
 
+	misc_deregister(&cachefiles_dev);
 	cachefiles_unregister_error_injection();
 }
 


