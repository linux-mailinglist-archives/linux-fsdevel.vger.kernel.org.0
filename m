Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9C949BD19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 21:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiAYU2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 15:28:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231967AbiAYU17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643142478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAQeigfXZclvF2sUunC8ag1KeXBfpETCfH2w49pBHa0=;
        b=MQ+4D7o/FnJSQEckefpjOGkCKEr2yxsTszbX3rcYf1oP109a3rptksVBqM33cAhPUfApEC
        TE5KDfPWiIx1bEBpOs70TLuGrpqmC2CgPL34nvqQAZGK0da7bacfXcRGa6ZoVtPB+fs+vN
        YufbtVBkSk6Lmiduhtlp4RU8nGowV98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-tKsJfZKoMqiPbQD7uOLIRQ-1; Tue, 25 Jan 2022 15:27:56 -0500
X-MC-Unique: tKsJfZKoMqiPbQD7uOLIRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BABB41006AA3;
        Tue, 25 Jan 2022 20:27:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AA884D718;
        Tue, 25 Jan 2022 20:27:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2815558.1643127330@warthog.procyon.org.uk>
References: <2815558.1643127330@warthog.procyon.org.uk> <20220118131216.85338-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/20] fscache,erofs: fscache-based demand-read semantics
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3116561.1643142458.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 25 Jan 2022 20:27:38 +0000
Message-ID: <3116562.1643142458@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

>  (1) Duplicate the cachefiles backend.  You can discard a lot of it, sin=
ce a
>      much of it is concerned with managing local modifications - which y=
ou're
>      not going to do since you have a R/O filesystem and you're looking =
at
>      importing files into the cache externally to the kernel.

Take the attached as a start.  It's completely untested.  I've stripped ou=
t
anything to do with writing to the cache, making directories, etc. as that=
 can
probably be delegated to the on-demand creation.  You could drive on-deman=
d
creation from the points where it would create files.  I've put some "TODO=
"
comments in there as markers.

You could also strip out everything to do with invalidation and also make =
it
just fail if it encounters a file type that it doesn't like or a file that=
 is
not correctly labelled for a coherency attribute.

Also, since you aren't intending to write anything or create new files her=
e,
there's no need to do the space checking - so I've got rid of all that too=
.

I've also made it open the backing files read only and got rid of the trim=
ming
to I/O blocksize for DIO purposes.  The userspace side can take care of th=
at -
and, besides, you want to have multiple files within a backing file, right=
?

You might want to stop it from marking cache *files* in use (but only mark
directories).  It doesn't matter so much as you aren't going to get cohere=
ncy
issues from having multiple writers to the same file.

You then need to add a file offset member to the erofscache_object struct,=
 set
that when the backing file is looked up and add it to the file position in
erofscache_read().  You also need to look at erofscache_prepare_read().  I=
f
your files are contiguous complete blobs, that can be a lot simpler.

Also, you might want to rename erofscache to something more suitable.

David
---
commit 6fb0e557451e1cd909679fea183822ae92eed67f
Author: David Howells <dhowells@redhat.com>
Date:   Tue Jan 25 16:44:10 2022 +0000

    erofs: Create specialised cache backend

diff --git a/fs/Kconfig b/fs/Kconfig
index 7a2b11c0b803..4ed1e704c0d4 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -133,6 +133,7 @@ menu "Caches"
 source "fs/netfs/Kconfig"
 source "fs/fscache/Kconfig"
 source "fs/cachefiles/Kconfig"
+source "fs/erofscache/Kconfig"
 =

 endmenu
 =

diff --git a/fs/Makefile b/fs/Makefile
index dab324aea08f..4780b9c919a8 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -128,6 +128,7 @@ obj-$(CONFIG_NILFS2_FS)		+=3D nilfs2/
 obj-$(CONFIG_BEFS_FS)		+=3D befs/
 obj-$(CONFIG_HOSTFS)		+=3D hostfs/
 obj-$(CONFIG_CACHEFILES)	+=3D cachefiles/
+obj-$(CONFIG_EROFSCACHE)	+=3D erofscache/
 obj-$(CONFIG_DEBUG_FS)		+=3D debugfs/
 obj-$(CONFIG_TRACING)		+=3D tracefs/
 obj-$(CONFIG_OCFS2_FS)		+=3D ocfs2/
diff --git a/fs/erofscache/Kconfig b/fs/erofscache/Kconfig
new file mode 100644
index 000000000000..29503879dce4
--- /dev/null
+++ b/fs/erofscache/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config EROFSCACHE
+	tristate "Filesystem caching on files"
+	depends on FSCACHE && BLOCK
+	help
+	  This permits use of a mounted filesystem as a cache for other
+	  filesystems - primarily networking filesystems - thus allowing fast
+	  local disk to enhance the speed of slower devices.
+
+	  See Documentation/filesystems/caching/erofscache.rst for more
+	  information.
+
+config EROFSCACHE_DEBUG
+	bool "Debug Erofscache"
+	depends on EROFSCACHE
+	help
+	  This permits debugging to be dynamically enabled in the filesystem
+	  caching on files module.  If this is set, the debugging output may be
+	  enabled by setting bits in /sys/modules/erofscache/parameter/debug or
+	  by including a debugging specifier in /etc/erofscached.conf.
+
+config EROFSCACHE_ERROR_INJECTION
+	bool "Provide error injection for erofscache"
+	depends on EROFSCACHE && SYSCTL
+	help
+	  This permits error injection to be enabled in erofscache whilst a
+	  cache is in service.
diff --git a/fs/erofscache/Makefile b/fs/erofscache/Makefile
new file mode 100644
index 000000000000..e22df4eb400b
--- /dev/null
+++ b/fs/erofscache/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for on-demand caching for erofs
+#
+
+erofscache-y :=3D \
+	cache.o \
+	daemon.o \
+	interface.o \
+	io.o \
+	key.o \
+	main.o \
+	namei.o \
+	security.o \
+	volume.o \
+	xattr.o
+
+erofscache-$(CONFIG_EROFSCACHE_ERROR_INJECTION) +=3D error_inject.o
+
+obj-$(CONFIG_EROFSCACHE) :=3D erofscache.o
diff --git a/fs/erofscache/cache.c b/fs/erofscache/cache.c
new file mode 100644
index 000000000000..fad00abbc218
--- /dev/null
+++ b/fs/erofscache/cache.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Manage high-level VFS aspects of a cache.
+ *
+ * Copyright (C) 2007, 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/slab.h>
+#include <linux/statfs.h>
+#include <linux/namei.h>
+#include "internal.h"
+
+/*
+ * Bring a cache online.
+ */
+int erofscache_add_cache(struct erofscache_cache *cache)
+{
+	struct fscache_cache *cache_cookie;
+	struct path path;
+	struct dentry *graveyard, *cachedir, *root;
+	const struct cred *saved_cred;
+	int ret;
+
+	_enter("");
+
+	cache_cookie =3D fscache_acquire_cache(cache->tag);
+	if (IS_ERR(cache_cookie))
+		return PTR_ERR(cache_cookie);
+
+	/* we want to work under the module's security ID */
+	ret =3D erofscache_get_security_ID(cache);
+	if (ret < 0)
+		goto error_getsec;
+
+	erofscache_begin_secure(cache, &saved_cred);
+
+	/* look up the directory at the root of the cache */
+	ret =3D kern_path(cache->rootdirname, LOOKUP_DIRECTORY, &path);
+	if (ret < 0)
+		goto error_open_root;
+
+	cache->mnt =3D path.mnt;
+	root =3D path.dentry;
+
+	cache->bsize =3D EROFSCACHE_DIO_BLOCK_SIZE;
+	cache->bshift =3D ilog2(cache->bsize);
+
+	ret =3D -EINVAL;
+	if (is_idmapped_mnt(path.mnt)) {
+		pr_warn("File cache on idmapped mounts not supported");
+		goto error_unsupported;
+	}
+
+	/* Check features of the backing filesystem:
+	 * - Directories must support looking up
+	 * - We use xattrs to store metadata
+	 * - We use DIO to pages, so the blocksize mustn't be too big.
+	 */
+	ret =3D -EOPNOTSUPP;
+	if (d_is_negative(root) ||
+	    !d_backing_inode(root)->i_op->lookup ||
+	    !(d_backing_inode(root)->i_opflags & IOP_XATTR) ||
+	    root->d_sb->s_blocksize > PAGE_SIZE)
+		goto error_unsupported;
+
+	/* determine the security of the on-disk cache as this governs
+	 * security ID of files we create */
+	ret =3D erofscache_determine_cache_security(cache, root, &saved_cred);
+	if (ret < 0)
+		goto error_unsupported;
+
+	/* get the cache directory and check its type */
+	cachedir =3D erofscache_get_directory(cache, root, "cache");
+	if (IS_ERR(cachedir)) {
+		ret =3D PTR_ERR(cachedir);
+		goto error_unsupported;
+	}
+
+	cache->store =3D cachedir;
+
+	/* get the graveyard directory */
+	graveyard =3D erofscache_get_directory(cache, root, "graveyard");
+	if (IS_ERR(graveyard)) {
+		ret =3D PTR_ERR(graveyard);
+		goto error_unsupported;
+	}
+
+	cache->graveyard =3D graveyard;
+	cache->cache =3D cache_cookie;
+
+	ret =3D fscache_add_cache(cache_cookie, &erofscache_cache_ops, cache);
+	if (ret < 0)
+		goto error_add_cache;
+
+	/* done */
+	set_bit(EROFSCACHE_READY, &cache->flags);
+	dput(root);
+
+	pr_info("File cache on %s registered\n", cache_cookie->name);
+
+	erofscache_end_secure(cache, saved_cred);
+	_leave(" =3D 0 [%px]", cache->cache);
+	return 0;
+
+error_add_cache:
+	erofscache_put_directory(cache->graveyard);
+	cache->graveyard =3D NULL;
+error_unsupported:
+	erofscache_put_directory(cache->store);
+	cache->store =3D NULL;
+	mntput(cache->mnt);
+	cache->mnt =3D NULL;
+	dput(root);
+error_open_root:
+	erofscache_end_secure(cache, saved_cred);
+error_getsec:
+	fscache_relinquish_cache(cache_cookie);
+	cache->cache =3D NULL;
+	pr_err("Failed to register: %d\n", ret);
+	return ret;
+}
+
+/*
+ * Mark all the objects as being out of service and queue them all for cl=
eanup.
+ */
+static void erofscache_withdraw_objects(struct erofscache_cache *cache)
+{
+	struct erofscache_object *object;
+	unsigned int count =3D 0;
+
+	_enter("");
+
+	spin_lock(&cache->object_list_lock);
+
+	while (!list_empty(&cache->object_list)) {
+		object =3D list_first_entry(&cache->object_list,
+					  struct erofscache_object, cache_link);
+		erofscache_see_object(object, erofscache_obj_see_withdrawal);
+		list_del_init(&object->cache_link);
+		fscache_withdraw_cookie(object->cookie);
+		count++;
+		if ((count & 63) =3D=3D 0) {
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
+static void erofscache_withdraw_volumes(struct erofscache_cache *cache)
+{
+	_enter("");
+
+	for (;;) {
+		struct erofscache_volume *volume =3D NULL;
+
+		spin_lock(&cache->object_list_lock);
+		if (!list_empty(&cache->volumes)) {
+			volume =3D list_first_entry(&cache->volumes,
+						  struct erofscache_volume, cache_link);
+			list_del_init(&volume->cache_link);
+		}
+		spin_unlock(&cache->object_list_lock);
+		if (!volume)
+			break;
+
+		erofscache_withdraw_volume(volume);
+	}
+
+	_leave("");
+}
+
+/*
+ * Withdraw cache objects.
+ */
+void erofscache_withdraw_cache(struct erofscache_cache *cache)
+{
+	struct fscache_cache *fscache =3D cache->cache;
+
+	pr_info("File cache on %s unregistering\n", fscache->name);
+
+	fscache_withdraw_cache(fscache);
+
+	/* we now have to destroy all the active objects pertaining to this
+	 * cache - which we do by passing them off to thread pool to be
+	 * disposed of */
+	erofscache_withdraw_objects(cache);
+	fscache_wait_for_objects(fscache);
+
+	erofscache_withdraw_volumes(cache);
+	cache->cache =3D NULL;
+	fscache_relinquish_cache(fscache);
+}
diff --git a/fs/erofscache/daemon.c b/fs/erofscache/daemon.c
new file mode 100644
index 000000000000..863db9a61f37
--- /dev/null
+++ b/fs/erofscache/daemon.c
@@ -0,0 +1,525 @@
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
+static int erofscache_daemon_open(struct inode *, struct file *);
+static int erofscache_daemon_release(struct inode *, struct file *);
+static ssize_t erofscache_daemon_read(struct file *, char __user *, size_=
t,
+				      loff_t *);
+static ssize_t erofscache_daemon_write(struct file *, const char __user *=
,
+				       size_t, loff_t *);
+static __poll_t erofscache_daemon_poll(struct file *,
+					   struct poll_table_struct *);
+static int erofscache_daemon_cull(struct erofscache_cache *, char *);
+static int erofscache_daemon_debug(struct erofscache_cache *, char *);
+static int erofscache_daemon_dir(struct erofscache_cache *, char *);
+static int erofscache_daemon_inuse(struct erofscache_cache *, char *);
+static int erofscache_daemon_secctx(struct erofscache_cache *, char *);
+static int erofscache_daemon_tag(struct erofscache_cache *, char *);
+static int erofscache_daemon_bind(struct erofscache_cache *, char *);
+static void erofscache_daemon_unbind(struct erofscache_cache *);
+
+static unsigned long erofscache_open;
+
+const struct file_operations erofscache_daemon_fops =3D {
+	.owner		=3D THIS_MODULE,
+	.open		=3D erofscache_daemon_open,
+	.release	=3D erofscache_daemon_release,
+	.read		=3D erofscache_daemon_read,
+	.write		=3D erofscache_daemon_write,
+	.poll		=3D erofscache_daemon_poll,
+	.llseek		=3D noop_llseek,
+};
+
+struct erofscache_daemon_cmd {
+	char name[8];
+	int (*handler)(struct erofscache_cache *cache, char *args);
+};
+
+static const struct erofscache_daemon_cmd erofscache_daemon_cmds[] =3D {
+	{ "bind",	erofscache_daemon_bind		},
+	{ "cull",	erofscache_daemon_cull		},
+	{ "debug",	erofscache_daemon_debug		},
+	{ "dir",	erofscache_daemon_dir		},
+	{ "inuse",	erofscache_daemon_inuse		},
+	{ "secctx",	erofscache_daemon_secctx	},
+	{ "tag",	erofscache_daemon_tag		},
+	{ "",		NULL				}
+};
+
+
+/*
+ * Prepare a cache for caching.
+ */
+static int erofscache_daemon_open(struct inode *inode, struct file *file)
+{
+	struct erofscache_cache *cache;
+
+	_enter("");
+
+	/* only the superuser may do this */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* the erofscache device may only be open once at a time */
+	if (xchg(&erofscache_open, 1) =3D=3D 1)
+		return -EBUSY;
+
+	/* allocate a cache record */
+	cache =3D kzalloc(sizeof(struct erofscache_cache), GFP_KERNEL);
+	if (!cache) {
+		erofscache_open =3D 0;
+		return -ENOMEM;
+	}
+
+	mutex_init(&cache->daemon_mutex);
+	init_waitqueue_head(&cache->daemon_pollwq);
+	INIT_LIST_HEAD(&cache->volumes);
+	INIT_LIST_HEAD(&cache->object_list);
+	spin_lock_init(&cache->object_list_lock);
+
+	file->private_data =3D cache;
+	cache->erofscached =3D file;
+	return 0;
+}
+
+/*
+ * Release a cache.
+ */
+static int erofscache_daemon_release(struct inode *inode, struct file *fi=
le)
+{
+	struct erofscache_cache *cache =3D file->private_data;
+
+	_enter("");
+
+	ASSERT(cache);
+
+	set_bit(EROFSCACHE_DEAD, &cache->flags);
+
+	erofscache_daemon_unbind(cache);
+
+	/* clean up the control file interface */
+	cache->erofscached =3D NULL;
+	file->private_data =3D NULL;
+	erofscache_open =3D 0;
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
+static ssize_t erofscache_daemon_read(struct file *file, char __user *_bu=
ffer,
+				      size_t buflen, loff_t *pos)
+{
+	struct erofscache_cache *cache =3D file->private_data;
+	unsigned long long b_released;
+	unsigned f_released;
+	char buffer[256];
+	int n;
+
+	//_enter(",,%zu,", buflen);
+
+	if (!test_bit(EROFSCACHE_READY, &cache->flags))
+		return 0;
+
+	/* summarise */
+	f_released =3D atomic_xchg(&cache->f_released, 0);
+	b_released =3D atomic_long_xchg(&cache->b_released, 0);
+	clear_bit(EROFSCACHE_STATE_CHANGED, &cache->flags);
+
+	n =3D snprintf(buffer, sizeof(buffer),
+		     "cull=3D%c"
+		     " freleased=3D%x"
+		     " breleased=3D%llx",
+		     test_bit(EROFSCACHE_CULLING, &cache->flags) ? '1' : '0',
+		     f_released,
+		     b_released);
+
+	if (n > buflen)
+		return -EMSGSIZE;
+
+	if (copy_to_user(_buffer, buffer, n) !=3D 0)
+		return -EFAULT;
+
+	return n;
+}
+
+/*
+ * Take a command from erofscached, parse it and act on it.
+ */
+static ssize_t erofscache_daemon_write(struct file *file,
+				       const char __user *_data,
+				       size_t datalen,
+				       loff_t *pos)
+{
+	const struct erofscache_daemon_cmd *cmd;
+	struct erofscache_cache *cache =3D file->private_data;
+	ssize_t ret;
+	char *data, *args, *cp;
+
+	//_enter(",,%zu,", datalen);
+
+	ASSERT(cache);
+
+	if (test_bit(EROFSCACHE_DEAD, &cache->flags))
+		return -EIO;
+
+	if (datalen > PAGE_SIZE - 1)
+		return -EOPNOTSUPP;
+
+	/* drag the command string into the kernel so we can parse it */
+	data =3D memdup_user_nul(_data, datalen);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	ret =3D -EINVAL;
+	if (memchr(data, '\0', datalen))
+		goto error;
+
+	/* strip any newline */
+	cp =3D memchr(data, '\n', datalen);
+	if (cp) {
+		if (cp =3D=3D data)
+			goto error;
+
+		*cp =3D '\0';
+	}
+
+	/* parse the command */
+	ret =3D -EOPNOTSUPP;
+
+	for (args =3D data; *args; args++)
+		if (isspace(*args))
+			break;
+	if (*args) {
+		if (args =3D=3D data)
+			goto error;
+		*args =3D '\0';
+		args =3D skip_spaces(++args);
+	}
+
+	/* run the appropriate command handler */
+	for (cmd =3D erofscache_daemon_cmds; cmd->name[0]; cmd++)
+		if (strcmp(cmd->name, data) =3D=3D 0)
+			goto found_command;
+
+error:
+	kfree(data);
+	//_leave(" =3D %zd", ret);
+	return ret;
+
+found_command:
+	mutex_lock(&cache->daemon_mutex);
+
+	ret =3D -EIO;
+	if (!test_bit(EROFSCACHE_DEAD, &cache->flags))
+		ret =3D cmd->handler(cache, args);
+
+	mutex_unlock(&cache->daemon_mutex);
+
+	if (ret =3D=3D 0)
+		ret =3D datalen;
+	goto error;
+}
+
+/*
+ * Poll for culling state
+ * - use EPOLLOUT to indicate culling state
+ */
+static __poll_t erofscache_daemon_poll(struct file *file,
+					   struct poll_table_struct *poll)
+{
+	struct erofscache_cache *cache =3D file->private_data;
+	__poll_t mask;
+
+	poll_wait(file, &cache->daemon_pollwq, poll);
+	mask =3D 0;
+
+	if (test_bit(EROFSCACHE_STATE_CHANGED, &cache->flags))
+		mask |=3D EPOLLIN;
+
+	if (test_bit(EROFSCACHE_CULLING, &cache->flags))
+		mask |=3D EPOLLOUT;
+
+	return mask;
+}
+
+/*
+ * Set the cache directory
+ * - command: "dir <name>"
+ */
+static int erofscache_daemon_dir(struct erofscache_cache *cache, char *ar=
gs)
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
+	dir =3D kstrdup(args, GFP_KERNEL);
+	if (!dir)
+		return -ENOMEM;
+
+	cache->rootdirname =3D dir;
+	return 0;
+}
+
+/*
+ * Set the cache security context
+ * - command: "secctx <ctx>"
+ */
+static int erofscache_daemon_secctx(struct erofscache_cache *cache, char =
*args)
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
+	secctx =3D kstrdup(args, GFP_KERNEL);
+	if (!secctx)
+		return -ENOMEM;
+
+	cache->secctx =3D secctx;
+	return 0;
+}
+
+/*
+ * Set the cache tag
+ * - command: "tag <name>"
+ */
+static int erofscache_daemon_tag(struct erofscache_cache *cache, char *ar=
gs)
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
+	tag =3D kstrdup(args, GFP_KERNEL);
+	if (!tag)
+		return -ENOMEM;
+
+	cache->tag =3D tag;
+	return 0;
+}
+
+/*
+ * Request a node in the cache be culled from the current working directo=
ry
+ * - command: "cull <name>"
+ */
+static int erofscache_daemon_cull(struct erofscache_cache *cache, char *a=
rgs)
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
+	if (!test_bit(EROFSCACHE_READY, &cache->flags)) {
+		pr_err("cull applied to unready cache\n");
+		return -EIO;
+	}
+
+	if (test_bit(EROFSCACHE_DEAD, &cache->flags)) {
+		pr_err("cull applied to dead cache\n");
+		return -EIO;
+	}
+
+	get_fs_pwd(current->fs, &path);
+
+	if (!d_can_lookup(path.dentry))
+		goto notdir;
+
+	erofscache_begin_secure(cache, &saved_cred);
+	ret =3D erofscache_cull(cache, path.dentry, args);
+	erofscache_end_secure(cache, saved_cred);
+
+	path_put(&path);
+	_leave(" =3D %d", ret);
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
+static int erofscache_daemon_debug(struct erofscache_cache *cache, char *=
args)
+{
+	unsigned long mask;
+
+	_enter(",%s", args);
+
+	mask =3D simple_strtoul(args, &args, 0);
+	if (args[0] !=3D '\0')
+		goto inval;
+
+	erofscache_debug =3D mask;
+	_leave(" =3D 0");
+	return 0;
+
+inval:
+	pr_err("debug command requires mask\n");
+	return -EINVAL;
+}
+
+/*
+ * Find out whether an object in the current working directory is in use =
or not
+ * - command: "inuse <name>"
+ */
+static int erofscache_daemon_inuse(struct erofscache_cache *cache, char *=
args)
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
+	if (!test_bit(EROFSCACHE_READY, &cache->flags)) {
+		pr_err("inuse applied to unready cache\n");
+		return -EIO;
+	}
+
+	if (test_bit(EROFSCACHE_DEAD, &cache->flags)) {
+		pr_err("inuse applied to dead cache\n");
+		return -EIO;
+	}
+
+	get_fs_pwd(current->fs, &path);
+
+	if (!d_can_lookup(path.dentry))
+		goto notdir;
+
+	erofscache_begin_secure(cache, &saved_cred);
+	ret =3D erofscache_check_in_use(cache, path.dentry, args);
+	erofscache_end_secure(cache, saved_cred);
+
+	path_put(&path);
+	//_leave(" =3D %d", ret);
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
+static int erofscache_daemon_bind(struct erofscache_cache *cache, char *a=
rgs)
+{
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
+	if (test_bit(EROFSCACHE_READY, &cache->flags)) {
+		pr_err("Cache already bound\n");
+		return -EBUSY;
+	}
+
+	/* Make sure we have copies of the tag string */
+	if (!cache->tag) {
+		/*
+		 * The tag string is released by the fops->release()
+		 * function, so we don't release it on error here
+		 */
+		cache->tag =3D kstrdup("Erofscache", GFP_KERNEL);
+		if (!cache->tag)
+			return -ENOMEM;
+	}
+
+	return erofscache_add_cache(cache);
+}
+
+/*
+ * Unbind a cache.
+ */
+static void erofscache_daemon_unbind(struct erofscache_cache *cache)
+{
+	_enter("");
+
+	if (test_bit(EROFSCACHE_READY, &cache->flags))
+		erofscache_withdraw_cache(cache);
+
+	erofscache_put_directory(cache->graveyard);
+	erofscache_put_directory(cache->store);
+	mntput(cache->mnt);
+
+	kfree(cache->rootdirname);
+	kfree(cache->secctx);
+	kfree(cache->tag);
+
+	_leave("");
+}
diff --git a/fs/erofscache/error_inject.c b/fs/erofscache/error_inject.c
new file mode 100644
index 000000000000..958b61198b36
--- /dev/null
+++ b/fs/erofscache/error_inject.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Error injection handling.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/sysctl.h>
+#include "internal.h"
+
+unsigned int erofscache_error_injection_state;
+
+static struct ctl_table_header *erofscache_sysctl;
+static struct ctl_table erofscache_sysctls[] =3D {
+	{
+		.procname	=3D "error_injection",
+		.data		=3D &erofscache_error_injection_state,
+		.maxlen		=3D sizeof(unsigned int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_douintvec,
+	},
+	{}
+};
+
+static struct ctl_table erofscache_sysctls_root[] =3D {
+	{
+		.procname	=3D "erofscache",
+		.mode		=3D 0555,
+		.child		=3D erofscache_sysctls,
+	},
+	{}
+};
+
+int __init erofscache_register_error_injection(void)
+{
+	erofscache_sysctl =3D register_sysctl_table(erofscache_sysctls_root);
+	if (!erofscache_sysctl)
+		return -ENOMEM;
+	return 0;
+
+}
+
+void erofscache_unregister_error_injection(void)
+{
+	unregister_sysctl_table(erofscache_sysctl);
+}
diff --git a/fs/erofscache/interface.c b/fs/erofscache/interface.c
new file mode 100644
index 000000000000..a4cb182dacdd
--- /dev/null
+++ b/fs/erofscache/interface.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* FS-Cache interface to Erofscache
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
+static atomic_t erofscache_object_debug_id;
+
+/*
+ * Allocate a cache object record.
+ */
+static
+struct erofscache_object *erofscache_alloc_object(struct fscache_cookie *=
cookie)
+{
+	struct fscache_volume *vcookie =3D cookie->volume;
+	struct erofscache_volume *volume =3D vcookie->cache_priv;
+	struct erofscache_object *object;
+
+	_enter("{%s},%x,", vcookie->key, cookie->debug_id);
+
+	object =3D kmem_cache_zalloc(erofscache_object_jar, GFP_KERNEL);
+	if (!object)
+		return NULL;
+
+	refcount_set(&object->ref, 1);
+
+	spin_lock_init(&object->lock);
+	INIT_LIST_HEAD(&object->cache_link);
+	object->volume =3D volume;
+	object->debug_id =3D atomic_inc_return(&erofscache_object_debug_id);
+	object->cookie =3D fscache_get_cookie(cookie, fscache_cookie_get_attach_=
object);
+
+	fscache_count_object(vcookie->cache);
+	trace_erofscache_ref(object->debug_id, cookie->debug_id, 1,
+			     erofscache_obj_new);
+	return object;
+}
+
+/*
+ * Note that an object has been seen.
+ */
+void erofscache_see_object(struct erofscache_object *object,
+			   enum erofscache_obj_ref_trace why)
+{
+	trace_erofscache_ref(object->debug_id, object->cookie->debug_id,
+			     refcount_read(&object->ref), why);
+}
+
+/*
+ * Increment the usage count on an object;
+ */
+struct erofscache_object *erofscache_grab_object(struct erofscache_object=
 *object,
+						 enum erofscache_obj_ref_trace why)
+{
+	int r;
+
+	__refcount_inc(&object->ref, &r);
+	trace_erofscache_ref(object->debug_id, object->cookie->debug_id, r, why)=
;
+	return object;
+}
+
+/*
+ * dispose of a reference to an object
+ */
+void erofscache_put_object(struct erofscache_object *object,
+			   enum erofscache_obj_ref_trace why)
+{
+	unsigned int object_debug_id =3D object->debug_id;
+	unsigned int cookie_debug_id =3D object->cookie->debug_id;
+	struct fscache_cache *cache;
+	bool done;
+	int r;
+
+	done =3D __refcount_dec_and_test(&object->ref, &r);
+	trace_erofscache_ref(object_debug_id, cookie_debug_id, r, why);
+	if (done) {
+		_debug("- kill object OBJ%x", object_debug_id);
+
+		ASSERTCMP(object->file, =3D=3D, NULL);
+
+		kfree(object->d_name);
+
+		cache =3D object->volume->cache->cache;
+		fscache_put_cookie(object->cookie, fscache_cookie_put_object);
+		object->cookie =3D NULL;
+		kmem_cache_free(erofscache_object_jar, object);
+		fscache_uncount_object(cache);
+	}
+
+	_leave("");
+}
+
+/*
+ * Attempt to look up the nominated node in this cache
+ */
+static bool erofscache_lookup_cookie(struct fscache_cookie *cookie)
+{
+	struct erofscache_object *object;
+	struct erofscache_cache *cache =3D cookie->volume->cache->cache_priv;
+	const struct cred *saved_cred;
+	bool success;
+
+	object =3D erofscache_alloc_object(cookie);
+	if (!object)
+		goto fail;
+
+	_enter("{OBJ%x}", object->debug_id);
+
+	if (!erofscache_cook_key(object))
+		goto fail_put;
+
+	cookie->cache_priv =3D object;
+
+	erofscache_begin_secure(cache, &saved_cred);
+
+	success =3D erofscache_look_up_object(object);
+	if (!success)
+		goto fail_withdraw;
+
+	erofscache_see_object(object, erofscache_obj_see_lookup_cookie);
+
+	spin_lock(&cache->object_list_lock);
+	list_add(&object->cache_link, &cache->object_list);
+	spin_unlock(&cache->object_list_lock);
+	// TODO: Do we need erofscache_adjust_size(object)?
+
+	erofscache_end_secure(cache, saved_cred);
+	_leave(" =3D t");
+	return true;
+
+fail_withdraw:
+	erofscache_end_secure(cache, saved_cred);
+	erofscache_see_object(object, erofscache_obj_see_lookup_failed);
+	fscache_caching_failed(cookie);
+	_debug("failed c=3D%08x o=3D%08x", cookie->debug_id, object->debug_id);
+	/* The caller holds an access count on the cookie, so we need them to
+	 * drop it before we can withdraw the object.
+	 */
+	return false;
+
+fail_put:
+	erofscache_put_object(object, erofscache_obj_put_alloc_fail);
+fail:
+	return false;
+}
+
+/*
+ * Finalise and object and close the VFS structs that we have.
+ */
+static void erofscache_clean_up_object(struct erofscache_object *object,
+				       struct erofscache_cache *cache)
+{
+	if (test_bit(FSCACHE_COOKIE_RETIRED, &object->cookie->flags)) {
+		erofscache_see_object(object, erofscache_obj_see_clean_delete);
+		_debug("- inval object OBJ%x", object->debug_id);
+		erofscache_delete_object(object, FSCACHE_OBJECT_WAS_RETIRED);
+	}
+
+	erofscache_unmark_inode_in_use(object, object->file);
+	if (object->file) {
+		fput(object->file);
+		object->file =3D NULL;
+	}
+}
+
+/*
+ * Withdraw caching for a cookie.
+ */
+static void erofscache_withdraw_cookie(struct fscache_cookie *cookie)
+{
+	struct erofscache_object *object =3D cookie->cache_priv;
+	struct erofscache_cache *cache =3D object->volume->cache;
+	const struct cred *saved_cred;
+
+	_enter("o=3D%x", object->debug_id);
+	erofscache_see_object(object, erofscache_obj_see_withdraw_cookie);
+
+	if (!list_empty(&object->cache_link)) {
+		spin_lock(&cache->object_list_lock);
+		erofscache_see_object(object, erofscache_obj_see_withdrawal);
+		list_del_init(&object->cache_link);
+		spin_unlock(&cache->object_list_lock);
+	}
+
+	if (object->file) {
+		erofscache_begin_secure(cache, &saved_cred);
+		erofscache_clean_up_object(object, cache);
+		erofscache_end_secure(cache, saved_cred);
+	}
+
+	cookie->cache_priv =3D NULL;
+	erofscache_put_object(object, erofscache_obj_put_detach);
+}
+
+/*
+ * Invalidate the storage associated with a cookie.
+ */
+static bool erofscache_invalidate_cookie(struct fscache_cookie *cookie)
+{
+	struct erofscache_object *object =3D cookie->cache_priv;
+	struct erofscache_volume *volume =3D object->volume;
+	struct dentry *fan =3D volume->fanout[(u8)cookie->key_hash];
+	struct file *file;
+
+	_enter("o=3D%x,[%llu]", object->debug_id, object->cookie->object_size);
+
+	if (!object->file) {
+		fscache_resume_after_invalidation(cookie);
+		_leave(" =3D t [light]");
+		return true;
+	}
+
+	/* Remove the VFS target and mark disabled */
+	spin_lock(&object->lock);
+
+	file =3D object->file;
+	object->file =3D NULL;
+	set_bit(FSCACHE_COOKIE_DISABLED, &object->cookie->flags);
+
+	spin_unlock(&object->lock);
+
+	/* Allow I/O to take place again */
+	fscache_resume_after_invalidation(cookie);
+
+	if (file) {
+		inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
+		erofscache_bury_object(volume->cache, object, fan,
+				       file->f_path.dentry,
+				       FSCACHE_OBJECT_INVALIDATED);
+		fput(file);
+	}
+
+	_leave(" =3D t");
+	return true;
+}
+
+const struct fscache_cache_ops erofscache_cache_ops =3D {
+	.name			=3D "erofscache",
+	.acquire_volume		=3D erofscache_acquire_volume,
+	.free_volume		=3D erofscache_free_volume,
+	.lookup_cookie		=3D erofscache_lookup_cookie,
+	.withdraw_cookie	=3D erofscache_withdraw_cookie,
+	.invalidate_cookie	=3D erofscache_invalidate_cookie,
+	.begin_operation	=3D erofscache_begin_operation,
+};
diff --git a/fs/erofscache/internal.h b/fs/erofscache/internal.h
new file mode 100644
index 000000000000..f7f00ba42f11
--- /dev/null
+++ b/fs/erofscache/internal.h
@@ -0,0 +1,349 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Internal defs for erofs demand-load netfs cache on cache files.
+ *
+ * Copyright (C) 2022 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) "Erofscache: " fmt
+
+
+#include <linux/fscache-cache.h>
+#include <linux/cred.h>
+#include <linux/security.h>
+
+#define EROFSCACHE_DIO_BLOCK_SIZE 4096
+
+struct erofscache_cache;
+struct erofscache_object;
+
+/*
+ * Cached volume representation.
+ */
+struct erofscache_volume {
+	struct erofscache_cache		*cache;
+	struct list_head		cache_link;	/* Link in cache->volumes */
+	struct fscache_volume		*vcookie;	/* The netfs's representation */
+	struct dentry			*dentry;	/* The volume dentry */
+	struct dentry			*fanout[256];	/* Fanout subdirs */
+};
+
+/*
+ * Backing file state.
+ */
+struct erofscache_object {
+	struct fscache_cookie		*cookie;	/* Netfs data storage object cookie */
+	struct erofscache_volume	*volume;	/* Cache volume that holds this object=
 */
+	struct list_head		cache_link;	/* Link in cache->*_list */
+	struct file			*file;		/* The file representing this object */
+	char				*d_name;	/* Backing file name */
+	int				debug_id;
+	spinlock_t			lock;
+	refcount_t			ref;
+	u8				d_name_len;	/* Length of filename */
+};
+
+/*
+ * Cache files cache definition
+ */
+struct erofscache_cache {
+	struct fscache_cache		*cache;		/* Cache cookie */
+	struct vfsmount			*mnt;		/* mountpoint holding the cache */
+	struct dentry			*store;		/* Directory into which live objects go */
+	struct dentry			*graveyard;	/* directory into which dead objects go */
+	struct file			*erofscached;	/* manager daemon handle */
+	struct list_head		volumes;	/* List of volume objects */
+	struct list_head		object_list;	/* List of active objects */
+	spinlock_t			object_list_lock; /* Lock for volumes and object_list */
+	const struct cred		*cache_cred;	/* security override for accessing cache=
 */
+	struct mutex			daemon_mutex;	/* command serialisation mutex */
+	wait_queue_head_t		daemon_pollwq;	/* poll waitqueue for daemon */
+	unsigned			bsize;		/* cache's block size */
+	unsigned			bshift;		/* ilog2(bsize) */
+	atomic_t			gravecounter;	/* graveyard uniquifier */
+	atomic_t			f_released;	/* number of objects released lately */
+	atomic_long_t			b_released;	/* number of blocks released lately */
+	unsigned long			flags;
+#define EROFSCACHE_READY		0	/* T if cache prepared */
+#define EROFSCACHE_DEAD			1	/* T if cache dead */
+#define EROFSCACHE_CULLING		2	/* T if cull engaged */
+#define EROFSCACHE_STATE_CHANGED	3	/* T if state changed (poll trigger) *=
/
+	char				*rootdirname;	/* name of cache root directory */
+	char				*secctx;	/* LSM security context */
+	char				*tag;		/* cache binding tag */
+};
+
+#include <trace/events/erofscache.h>
+
+static inline
+struct file *erofscache_cres_file(struct netfs_cache_resources *cres)
+{
+	return cres->cache_priv2;
+}
+
+static inline
+struct erofscache_object *erofscache_cres_object(struct netfs_cache_resou=
rces *cres)
+{
+	return fscache_cres_cookie(cres)->cache_priv;
+}
+
+/*
+ * note change of state for daemon
+ */
+static inline void erofscache_state_changed(struct erofscache_cache *cach=
e)
+{
+	set_bit(EROFSCACHE_STATE_CHANGED, &cache->flags);
+	wake_up_all(&cache->daemon_pollwq);
+}
+
+/*
+ * cache.c
+ */
+extern int erofscache_add_cache(struct erofscache_cache *cache);
+extern void erofscache_withdraw_cache(struct erofscache_cache *cache);
+
+/*
+ * daemon.c
+ */
+extern const struct file_operations erofscache_daemon_fops;
+
+/*
+ * error_inject.c
+ */
+#ifdef CONFIG_EROFSCACHE_ERROR_INJECTION
+extern unsigned int erofscache_error_injection_state;
+extern int erofscache_register_error_injection(void);
+extern void erofscache_unregister_error_injection(void);
+
+#else
+#define erofscache_error_injection_state 0
+
+static inline int erofscache_register_error_injection(void)
+{
+	return 0;
+}
+
+static inline void erofscache_unregister_error_injection(void)
+{
+}
+#endif
+
+
+static inline int erofscache_inject_read_error(void)
+{
+	return erofscache_error_injection_state & 2 ? -EIO : 0;
+}
+
+static inline int erofscache_inject_remove_error(void)
+{
+	return erofscache_error_injection_state & 2 ? -EIO : 0;
+}
+
+/*
+ * interface.c
+ */
+extern const struct fscache_cache_ops erofscache_cache_ops;
+extern void erofscache_see_object(struct erofscache_object *object,
+				  enum erofscache_obj_ref_trace why);
+extern struct erofscache_object *erofscache_grab_object(struct erofscache=
_object *object,
+							enum erofscache_obj_ref_trace why);
+extern void erofscache_put_object(struct erofscache_object *object,
+				  enum erofscache_obj_ref_trace why);
+
+/*
+ * io.c
+ */
+extern bool erofscache_begin_operation(struct netfs_cache_resources *cres=
,
+				       enum fscache_want_state want_state);
+
+/*
+ * key.c
+ */
+extern bool erofscache_cook_key(struct erofscache_object *object);
+
+/*
+ * main.c
+ */
+extern struct kmem_cache *erofscache_object_jar;
+
+/*
+ * namei.c
+ */
+extern void erofscache_unmark_inode_in_use(struct erofscache_object *obje=
ct,
+					   struct file *file);
+extern int erofscache_bury_object(struct erofscache_cache *cache,
+				  struct erofscache_object *object,
+				  struct dentry *dir,
+				  struct dentry *rep,
+				  enum fscache_why_object_killed why);
+extern int erofscache_delete_object(struct erofscache_object *object,
+				    enum fscache_why_object_killed why);
+extern bool erofscache_look_up_object(struct erofscache_object *object);
+extern struct dentry *erofscache_get_directory(struct erofscache_cache *c=
ache,
+					       struct dentry *dir,
+					       const char *name);
+extern void erofscache_put_directory(struct dentry *dir);
+
+extern int erofscache_cull(struct erofscache_cache *cache, struct dentry =
*dir,
+			   char *filename);
+
+extern int erofscache_check_in_use(struct erofscache_cache *cache,
+				   struct dentry *dir, char *filename);
+
+/*
+ * security.c
+ */
+extern int erofscache_get_security_ID(struct erofscache_cache *cache);
+extern int erofscache_determine_cache_security(struct erofscache_cache *c=
ache,
+					       struct dentry *root,
+					       const struct cred **_saved_cred);
+
+static inline void erofscache_begin_secure(struct erofscache_cache *cache=
,
+					   const struct cred **_saved_cred)
+{
+	*_saved_cred =3D override_creds(cache->cache_cred);
+}
+
+static inline void erofscache_end_secure(struct erofscache_cache *cache,
+					 const struct cred *saved_cred)
+{
+	revert_creds(saved_cred);
+}
+
+/*
+ * volume.c
+ */
+void erofscache_acquire_volume(struct fscache_volume *volume);
+void erofscache_free_volume(struct fscache_volume *volume);
+void erofscache_withdraw_volume(struct erofscache_volume *volume);
+
+/*
+ * xattr.c
+ */
+extern int erofscache_check_auxdata(struct erofscache_object *object,
+				    struct file *file);
+extern int erofscache_remove_object_xattr(struct erofscache_cache *cache,
+					  struct erofscache_object *object,
+					  struct dentry *dentry);
+extern int erofscache_check_volume_xattr(struct erofscache_volume *volume=
);
+
+/*
+ * Error handling
+ */
+#define erofscache_io_error(___cache, FMT, ...)		\
+do {							\
+	pr_err("I/O Error: " FMT"\n", ##__VA_ARGS__);	\
+	fscache_io_error((___cache)->cache);		\
+	set_bit(EROFSCACHE_DEAD, &(___cache)->flags);	\
+} while (0)
+
+#define erofscache_io_error_obj(object, FMT, ...)			\
+do {									\
+	struct erofscache_cache *___cache;				\
+									\
+	___cache =3D (object)->volume->cache;				\
+	erofscache_io_error(___cache, FMT " [o=3D%08x]", ##__VA_ARGS__,	\
+			    (object)->debug_id);			\
+} while (0)
+
+
+/*
+ * Debug tracing
+ */
+extern unsigned erofscache_debug;
+#define EROFSCACHE_DEBUG_KENTER	1
+#define EROFSCACHE_DEBUG_KLEAVE	2
+#define EROFSCACHE_DEBUG_KDEBUG	4
+
+#define dbgprintk(FMT, ...) \
+	printk(KERN_DEBUG "[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
+
+#define kenter(FMT, ...) dbgprintk("=3D=3D> %s("FMT")", __func__, ##__VA_=
ARGS__)
+#define kleave(FMT, ...) dbgprintk("<=3D=3D %s()"FMT"", __func__, ##__VA_=
ARGS__)
+#define kdebug(FMT, ...) dbgprintk(FMT, ##__VA_ARGS__)
+
+
+#if defined(__KDEBUG)
+#define _enter(FMT, ...) kenter(FMT, ##__VA_ARGS__)
+#define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
+#define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
+
+#elif defined(CONFIG_EROFSCACHE_DEBUG)
+#define _enter(FMT, ...)				\
+do {							\
+	if (erofscache_debug & EROFSCACHE_DEBUG_KENTER)	\
+		kenter(FMT, ##__VA_ARGS__);		\
+} while (0)
+
+#define _leave(FMT, ...)				\
+do {							\
+	if (erofscache_debug & EROFSCACHE_DEBUG_KLEAVE)	\
+		kleave(FMT, ##__VA_ARGS__);		\
+} while (0)
+
+#define _debug(FMT, ...)				\
+do {							\
+	if (erofscache_debug & EROFSCACHE_DEBUG_KDEBUG)	\
+		kdebug(FMT, ##__VA_ARGS__);		\
+} while (0)
+
+#else
+#define _enter(FMT, ...) no_printk("=3D=3D> %s("FMT")", __func__, ##__VA_=
ARGS__)
+#define _leave(FMT, ...) no_printk("<=3D=3D %s()"FMT"", __func__, ##__VA_=
ARGS__)
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
diff --git a/fs/erofscache/io.c b/fs/erofscache/io.c
new file mode 100644
index 000000000000..0234e9a2a992
--- /dev/null
+++ b/fs/erofscache/io.c
@@ -0,0 +1,339 @@
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
+#include <linux/falloc.h>
+#include <linux/sched/mm.h>
+#include <trace/events/fscache.h>
+#include "internal.h"
+
+struct erofscache_kiocb {
+	struct kiocb		iocb;
+	refcount_t		ki_refcnt;
+	loff_t			start;
+	union {
+		size_t		skipped;
+		size_t		len;
+	};
+	struct erofscache_object *object;
+	netfs_io_terminated_t	term_func;
+	void			*term_func_priv;
+	bool			was_async;
+	unsigned int		inval_counter;	/* Copy of cookie->inval_counter */
+	u64			b_writing;
+};
+
+static inline void erofscache_put_kiocb(struct erofscache_kiocb *ki)
+{
+	if (refcount_dec_and_test(&ki->ki_refcnt)) {
+		erofscache_put_object(ki->object, erofscache_obj_put_ioreq);
+		fput(ki->iocb.ki_filp);
+		kfree(ki);
+	}
+}
+
+/*
+ * Handle completion of a read from the cache.
+ */
+static void erofscache_read_complete(struct kiocb *iocb, long ret)
+{
+	struct erofscache_kiocb *ki =3D container_of(iocb, struct erofscache_kio=
cb, iocb);
+	struct inode *inode =3D file_inode(ki->iocb.ki_filp);
+
+	_enter("%ld", ret);
+
+	if (ret < 0)
+		trace_erofscache_io_error(ki->object, inode, ret,
+					  erofscache_trace_read_error);
+
+	if (ki->term_func) {
+		if (ret >=3D 0) {
+			if (ki->object->cookie->inval_counter =3D=3D ki->inval_counter)
+				ki->skipped +=3D ret;
+			else
+				ret =3D -ESTALE;
+		}
+
+		ki->term_func(ki->term_func_priv, ret, ki->was_async);
+	}
+
+	erofscache_put_kiocb(ki);
+}
+
+/*
+ * Initiate a read from the cache.
+ */
+static int erofscache_read(struct netfs_cache_resources *cres,
+			   loff_t start_pos,
+			   struct iov_iter *iter,
+			   enum netfs_read_from_hole read_hole,
+			   netfs_io_terminated_t term_func,
+			   void *term_func_priv)
+{
+	struct erofscache_object *object;
+	struct erofscache_kiocb *ki;
+	struct file *file;
+	unsigned int old_nofs;
+	ssize_t ret =3D -ENOBUFS;
+	size_t len =3D iov_iter_count(iter), skipped =3D 0;
+
+	if (!fscache_wait_for_operation(cres, FSCACHE_WANT_READ))
+		goto presubmission_error;
+
+	fscache_count_read();
+	object =3D erofscache_cres_object(cres);
+	file =3D erofscache_cres_file(cres);
+
+	_enter("%pD,%li,%llx,%zx/%llx",
+	       file, file_inode(file)->i_ino, start_pos, len,
+	       i_size_read(file_inode(file)));
+
+	/* If the caller asked us to seek for data before doing the read, then
+	 * we should do that now.  If we find a gap, we fill it with zeros.
+	 */
+	if (read_hole !=3D NETFS_READ_HOLE_IGNORE) {
+		loff_t off =3D start_pos, off2;
+
+		off2 =3D erofscache_inject_read_error();
+		if (off2 =3D=3D 0)
+			off2 =3D vfs_llseek(file, off, SEEK_DATA);
+		if (off2 < 0 && off2 >=3D (loff_t)-MAX_ERRNO && off2 !=3D -ENXIO) {
+			skipped =3D 0;
+			ret =3D off2;
+			goto presubmission_error;
+		}
+
+		if (off2 =3D=3D -ENXIO || off2 >=3D start_pos + len) {
+			/* The region is beyond the EOF or there's no more data
+			 * in the region, so clear the rest of the buffer and
+			 * return success.
+			 */
+			ret =3D -ENODATA;
+			if (read_hole =3D=3D NETFS_READ_HOLE_FAIL)
+				goto presubmission_error;
+
+			iov_iter_zero(len, iter);
+			skipped =3D len;
+			ret =3D 0;
+			goto presubmission_error;
+		}
+
+		skipped =3D off2 - off;
+		iov_iter_zero(skipped, iter);
+	}
+
+	ret =3D -ENOMEM;
+	ki =3D kzalloc(sizeof(struct erofscache_kiocb), GFP_KERNEL);
+	if (!ki)
+		goto presubmission_error;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	ki->iocb.ki_filp	=3D file;
+	ki->iocb.ki_pos		=3D start_pos + skipped;
+	ki->iocb.ki_flags	=3D IOCB_DIRECT;
+	ki->iocb.ki_hint	=3D ki_hint_validate(file_write_hint(file));
+	ki->iocb.ki_ioprio	=3D get_current_ioprio();
+	ki->skipped		=3D skipped;
+	ki->object		=3D object;
+	ki->inval_counter	=3D cres->inval_counter;
+	ki->term_func		=3D term_func;
+	ki->term_func_priv	=3D term_func_priv;
+	ki->was_async		=3D true;
+
+	if (ki->term_func)
+		ki->iocb.ki_complete =3D erofscache_read_complete;
+
+	get_file(ki->iocb.ki_filp);
+	erofscache_grab_object(object, erofscache_obj_get_ioreq);
+
+	trace_erofscache_read(object, file_inode(file), ki->iocb.ki_pos, len - s=
kipped);
+	old_nofs =3D memalloc_nofs_save();
+	ret =3D erofscache_inject_read_error();
+	if (ret =3D=3D 0)
+		ret =3D vfs_iocb_iter_read(file, &ki->iocb, iter);
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
+		ret =3D -EINTR;
+		fallthrough;
+	default:
+		ki->was_async =3D false;
+		erofscache_read_complete(&ki->iocb, ret);
+		if (ret > 0)
+			ret =3D 0;
+		break;
+	}
+
+in_progress:
+	erofscache_put_kiocb(ki);
+	_leave(" =3D %zd", ret);
+	return ret;
+
+presubmission_error:
+	if (term_func)
+		term_func(term_func_priv, ret < 0 ? ret : skipped, false);
+	return ret;
+}
+
+/*
+ * Prepare a read operation, shortening it to a cached/uncached
+ * boundary as appropriate.
+ */
+static enum netfs_read_source erofscache_prepare_read(struct netfs_read_s=
ubrequest *subreq,
+						      loff_t i_size)
+{
+	enum erofscache_prepare_read_trace why;
+	struct netfs_read_request *rreq =3D subreq->rreq;
+	struct netfs_cache_resources *cres =3D &rreq->cache_resources;
+	struct erofscache_object *object;
+	struct erofscache_cache *cache;
+	struct fscache_cookie *cookie =3D fscache_cres_cookie(cres);
+	const struct cred *saved_cred;
+	struct file *file =3D erofscache_cres_file(cres);
+	enum netfs_read_source ret =3D NETFS_DOWNLOAD_FROM_SERVER;
+	loff_t off, to;
+	ino_t ino =3D file ? file_inode(file)->i_ino : 0;
+
+	_enter("%zx @%llx/%llx", subreq->len, subreq->start, i_size);
+
+	if (subreq->start >=3D i_size) {
+		ret =3D NETFS_FILL_WITH_ZEROES;
+		why =3D erofscache_trace_read_after_eof;
+		goto out_no_object;
+	}
+
+	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
+		__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+		why =3D erofscache_trace_read_no_data;
+		goto out_no_object;
+	}
+
+	/* The object and the file may be being created in the background. */
+	if (!file) {
+		why =3D erofscache_trace_read_no_file;
+		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_READ))
+			goto out_no_object;
+		file =3D erofscache_cres_file(cres);
+		if (!file)
+			goto out_no_object;
+		ino =3D file_inode(file)->i_ino;
+	}
+
+	object =3D erofscache_cres_object(cres);
+	cache =3D object->volume->cache;
+	erofscache_begin_secure(cache, &saved_cred);
+
+	off =3D erofscache_inject_read_error();
+	if (off =3D=3D 0)
+		off =3D vfs_llseek(file, subreq->start, SEEK_DATA);
+	if (off < 0 && off >=3D (loff_t)-MAX_ERRNO) {
+		if (off =3D=3D (loff_t)-ENXIO) {
+			why =3D erofscache_trace_read_seek_nxio;
+			goto out;
+		}
+		trace_erofscache_io_error(object, file_inode(file), off,
+					  erofscache_trace_seek_error);
+		why =3D erofscache_trace_read_seek_error;
+		goto out;
+	}
+
+	if (off >=3D subreq->start + subreq->len) {
+		why =3D erofscache_trace_read_found_hole;
+		goto out;
+	}
+
+	if (off > subreq->start) {
+		off =3D round_up(off, cache->bsize);
+		subreq->len =3D off - subreq->start;
+		why =3D erofscache_trace_read_found_part;
+		goto out;
+	}
+
+	to =3D erofscache_inject_read_error();
+	if (to =3D=3D 0)
+		to =3D vfs_llseek(file, subreq->start, SEEK_HOLE);
+	if (to < 0 && to >=3D (loff_t)-MAX_ERRNO) {
+		trace_erofscache_io_error(object, file_inode(file), to,
+					  erofscache_trace_seek_error);
+		why =3D erofscache_trace_read_seek_error;
+		goto out;
+	}
+
+	if (to < subreq->start + subreq->len) {
+		if (subreq->start + subreq->len >=3D i_size)
+			to =3D round_up(to, cache->bsize);
+		else
+			to =3D round_down(to, cache->bsize);
+		subreq->len =3D to - subreq->start;
+	}
+
+	why =3D erofscache_trace_read_have_data;
+	ret =3D NETFS_READ_FROM_CACHE;
+	goto out;
+
+out:
+	erofscache_end_secure(cache, saved_cred);
+out_no_object:
+	trace_erofscache_prep_read(subreq, ret, why, ino);
+	return ret;
+}
+
+/*
+ * Clean up an operation.
+ */
+static void erofscache_end_operation(struct netfs_cache_resources *cres)
+{
+	struct file *file =3D erofscache_cres_file(cres);
+
+	if (file)
+		fput(file);
+	fscache_end_cookie_access(fscache_cres_cookie(cres), fscache_access_io_e=
nd);
+}
+
+static const struct netfs_cache_ops erofscache_netfs_cache_ops =3D {
+	.end_operation		=3D erofscache_end_operation,
+	.read			=3D erofscache_read,
+	.prepare_read		=3D erofscache_prepare_read,
+};
+
+/*
+ * Open the cache file when beginning a cache operation.
+ */
+bool erofscache_begin_operation(struct netfs_cache_resources *cres,
+				enum fscache_want_state want_state)
+{
+	struct erofscache_object *object =3D erofscache_cres_object(cres);
+
+	if (!erofscache_cres_file(cres)) {
+		cres->ops =3D &erofscache_netfs_cache_ops;
+		if (object->file) {
+			spin_lock(&object->lock);
+			if (!cres->cache_priv2 && object->file)
+				cres->cache_priv2 =3D get_file(object->file);
+			spin_unlock(&object->lock);
+		}
+	}
+
+	if (!erofscache_cres_file(cres) && want_state !=3D FSCACHE_WANT_PARAMS) =
{
+		pr_err("failed to get cres->file\n");
+		return false;
+	}
+
+	return true;
+}
diff --git a/fs/erofscache/key.c b/fs/erofscache/key.c
new file mode 100644
index 000000000000..6bad2d461d42
--- /dev/null
+++ b/fs/erofscache/key.c
@@ -0,0 +1,138 @@
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
+static const char erofscache_charmap[64] =3D
+	"0123456789"			/* 0 - 9 */
+	"abcdefghijklmnopqrstuvwxyz"	/* 10 - 35 */
+	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"	/* 36 - 61 */
+	"_-"				/* 62 - 63 */
+	;
+
+static const char erofscache_filecharmap[256] =3D {
+	/* we skip space and tab and control chars */
+	[33 ... 46] =3D 1,		/* '!' -> '.' */
+	/* we skip '/' as it's significant to pathwalk */
+	[48 ... 127] =3D 1,		/* '0' -> '~' */
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
+ *   - "base64" encode the strange keys, mapping 3 bytes of raw to four o=
f
+ *     cooked
+ *   - need to cut the cooked key into 252 char lengths (189 raw bytes)
+ */
+bool erofscache_cook_key(struct erofscache_object *object)
+{
+	const u8 *key =3D fscache_get_key(object->cookie), *kend;
+	unsigned char ch;
+	unsigned int acc, i, n, nle, nbe, keylen =3D object->cookie->key_len;
+	unsigned int b64len, len, print, pad;
+	char *name, sep;
+
+	_enter(",%u,%*phN", keylen, keylen, key);
+
+	BUG_ON(keylen > NAME_MAX - 3);
+
+	print =3D 1;
+	for (i =3D 0; i < keylen; i++) {
+		ch =3D key[i];
+		print &=3D erofscache_filecharmap[ch];
+	}
+
+	/* If the path is usable ASCII, then we render it directly */
+	if (print) {
+		len =3D 1 + keylen;
+		name =3D kmalloc(len + 1, GFP_KERNEL);
+		if (!name)
+			return false;
+
+		name[0] =3D 'D'; /* Data object type, string encoding */
+		memcpy(name + 1, key, keylen);
+		goto success;
+	}
+
+	/* See if it makes sense to encode it as "hex,hex,hex" for each 32-bit
+	 * chunk.  We rely on the key having been padded out to a whole number
+	 * of 32-bit words.
+	 */
+	n =3D round_up(keylen, 4);
+	nbe =3D nle =3D 0;
+	for (i =3D 0; i < n; i +=3D 4) {
+		u32 be =3D be32_to_cpu(*(__be32 *)(key + i));
+		u32 le =3D le32_to_cpu(*(__le32 *)(key + i));
+
+		nbe +=3D 1 + how_many_hex_digits(be);
+		nle +=3D 1 + how_many_hex_digits(le);
+	}
+
+	b64len =3D DIV_ROUND_UP(keylen, 3);
+	pad =3D b64len * 3 - keylen;
+	b64len =3D 2 + b64len * 4; /* Length if we base64-encode it */
+	_debug("len=3D%u nbe=3D%u nle=3D%u b64=3D%u", keylen, nbe, nle, b64len);
+	if (nbe < b64len || nle < b64len) {
+		unsigned int nlen =3D min(nbe, nle) + 1;
+		name =3D kmalloc(nlen, GFP_KERNEL);
+		if (!name)
+			return false;
+		sep =3D (nbe <=3D nle) ? 'S' : 'T'; /* Encoding indicator */
+		len =3D 0;
+		for (i =3D 0; i < n; i +=3D 4) {
+			u32 x;
+			if (nbe <=3D nle)
+				x =3D be32_to_cpu(*(__be32 *)(key + i));
+			else
+				x =3D le32_to_cpu(*(__le32 *)(key + i));
+			name[len++] =3D sep;
+			if (x !=3D 0)
+				len +=3D snprintf(name + len, nlen - len, "%x", x);
+			sep =3D ',';
+		}
+		goto success;
+	}
+
+	/* We need to base64-encode it */
+	name =3D kmalloc(b64len + 1, GFP_KERNEL);
+	if (!name)
+		return false;
+
+	name[0] =3D 'E';
+	name[1] =3D '0' + pad;
+	len =3D 2;
+	kend =3D key + keylen;
+	do {
+		acc  =3D *key++;
+		if (key < kend) {
+			acc |=3D *key++ << 8;
+			if (key < kend)
+				acc |=3D *key++ << 16;
+		}
+
+		name[len++] =3D erofscache_charmap[acc & 63];
+		acc >>=3D 6;
+		name[len++] =3D erofscache_charmap[acc & 63];
+		acc >>=3D 6;
+		name[len++] =3D erofscache_charmap[acc & 63];
+		acc >>=3D 6;
+		name[len++] =3D erofscache_charmap[acc & 63];
+	} while (key < kend);
+
+success:
+	name[len] =3D 0;
+	object->d_name =3D name;
+	object->d_name_len =3D len;
+	_leave(" =3D %s", object->d_name);
+	return true;
+}
diff --git a/fs/erofscache/main.c b/fs/erofscache/main.c
new file mode 100644
index 000000000000..8daa4f06d09f
--- /dev/null
+++ b/fs/erofscache/main.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Network filesystem caching backend to use cache files on a premounted
+ * filesystem
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
+#include <linux/sysctl.h>
+#include <linux/miscdevice.h>
+#include <linux/netfs.h>
+#include <trace/events/netfs.h>
+#define CREATE_TRACE_POINTS
+#include "internal.h"
+
+unsigned erofscache_debug;
+module_param_named(debug, erofscache_debug, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(erofscache_debug, "Erofscache debugging mask");
+
+MODULE_DESCRIPTION("Mounted-filesystem based cache");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+struct kmem_cache *erofscache_object_jar;
+
+static struct miscdevice erofscache_dev =3D {
+	.minor	=3D MISC_DYNAMIC_MINOR,
+	.name	=3D "erofscache",
+	.fops	=3D &erofscache_daemon_fops,
+};
+
+/*
+ * initialise the fs caching module
+ */
+static int __init erofscache_init(void)
+{
+	int ret;
+
+	ret =3D erofscache_register_error_injection();
+	if (ret < 0)
+		goto error_einj;
+	ret =3D misc_register(&erofscache_dev);
+	if (ret < 0)
+		goto error_dev;
+
+	/* create an object jar */
+	ret =3D -ENOMEM;
+	erofscache_object_jar =3D
+		kmem_cache_create("erofscache_object_jar",
+				  sizeof(struct erofscache_object),
+				  0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!erofscache_object_jar) {
+		pr_notice("Failed to allocate an object jar\n");
+		goto error_object_jar;
+	}
+
+	pr_info("Loaded\n");
+	return 0;
+
+error_object_jar:
+	misc_deregister(&erofscache_dev);
+error_dev:
+	erofscache_unregister_error_injection();
+error_einj:
+	pr_err("failed to register: %d\n", ret);
+	return ret;
+}
+
+fs_initcall(erofscache_init);
+
+/*
+ * clean up on module removal
+ */
+static void __exit erofscache_exit(void)
+{
+	pr_info("Unloading\n");
+
+	kmem_cache_destroy(erofscache_object_jar);
+	misc_deregister(&erofscache_dev);
+	erofscache_unregister_error_injection();
+}
+
+module_exit(erofscache_exit);
diff --git a/fs/erofscache/namei.c b/fs/erofscache/namei.c
new file mode 100644
index 000000000000..28c3f11c0fae
--- /dev/null
+++ b/fs/erofscache/namei.c
@@ -0,0 +1,635 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Erofscache path walking and related routines
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include "internal.h"
+
+/*
+ * Mark the backing file as being a cache file if it's not already in use=
.  The
+ * mark tells the culling request command that it's not allowed to cull t=
he
+ * file or directory.  The caller must hold the inode lock.
+ */
+static bool __erofscache_mark_inode_in_use(struct erofscache_object *obje=
ct,
+					   struct dentry *dentry)
+{
+	struct inode *inode =3D d_backing_inode(dentry);
+	bool can_use =3D false;
+
+	if (!(inode->i_flags & S_KERNEL_FILE)) {
+		inode->i_flags |=3D S_KERNEL_FILE;
+		trace_erofscache_mark_active(object, inode);
+		can_use =3D true;
+	} else {
+		trace_erofscache_mark_failed(object, inode);
+		pr_notice("erofscache: Inode already in use: %pd (B=3D%lx)\n",
+			  dentry, inode->i_ino);
+	}
+
+	return can_use;
+}
+
+static bool erofscache_mark_inode_in_use(struct erofscache_object *object=
,
+					 struct dentry *dentry)
+{
+	struct inode *inode =3D d_backing_inode(dentry);
+	bool can_use;
+
+	inode_lock(inode);
+	can_use =3D __erofscache_mark_inode_in_use(object, dentry);
+	inode_unlock(inode);
+	return can_use;
+}
+
+/*
+ * Unmark a backing inode.  The caller must hold the inode lock.
+ */
+static void __erofscache_unmark_inode_in_use(struct erofscache_object *ob=
ject,
+					     struct dentry *dentry)
+{
+	struct inode *inode =3D d_backing_inode(dentry);
+
+	inode->i_flags &=3D ~S_KERNEL_FILE;
+	trace_erofscache_mark_inactive(object, inode);
+}
+
+/*
+ * Unmark a backing inode and tell erofscached that there's something tha=
t can
+ * be culled.
+ */
+void erofscache_unmark_inode_in_use(struct erofscache_object *object,
+				    struct file *file)
+{
+	struct erofscache_cache *cache =3D object->volume->cache;
+	struct inode *inode =3D file_inode(file);
+
+	if (inode) {
+		inode_lock(inode);
+		__erofscache_unmark_inode_in_use(object, file->f_path.dentry);
+		inode_unlock(inode);
+
+		atomic_long_add(inode->i_blocks, &cache->b_released);
+		if (atomic_inc_return(&cache->f_released))
+			erofscache_state_changed(cache);
+	}
+}
+
+/*
+ * get a subdirectory
+ */
+struct dentry *erofscache_get_directory(struct erofscache_cache *cache,
+					struct dentry *dir,
+					const char *dirname)
+{
+	struct dentry *subdir;
+	int ret;
+
+	_enter(",,%s", dirname);
+
+	/* search the current directory for the element name */
+	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+
+	ret =3D erofscache_inject_read_error();
+	if (ret =3D=3D 0)
+		subdir =3D lookup_one_len(dirname, dir, strlen(dirname));
+	else
+		subdir =3D ERR_PTR(ret);
+	trace_erofscache_lookup(NULL, dir, subdir);
+	if (IS_ERR(subdir)) {
+		trace_erofscache_vfs_error(NULL, d_backing_inode(dir),
+					   PTR_ERR(subdir),
+					   erofscache_trace_lookup_error);
+		if (PTR_ERR(subdir) =3D=3D -ENOMEM)
+			goto nomem_d_alloc;
+		goto lookup_error;
+	}
+
+	_debug("subdir -> %pd %s",
+	       subdir, d_backing_inode(subdir) ? "positive" : "negative");
+
+	/* TODO: Do we need to create the subdir if it doesn't exist? */
+	if (d_is_negative(subdir))
+		goto enoent;
+
+	/* Tell rmdir() it's not allowed to delete the subdir */
+	inode_lock(d_inode(subdir));
+	inode_unlock(d_inode(dir));
+
+	if (!__erofscache_mark_inode_in_use(NULL, subdir))
+		goto mark_error;
+
+	inode_unlock(d_inode(subdir));
+
+	/* we need to make sure the subdir is a directory */
+	ASSERT(d_backing_inode(subdir));
+
+	if (!d_can_lookup(subdir)) {
+		pr_err("%s is not a directory\n", dirname);
+		ret =3D -EIO;
+		goto check_error;
+	}
+
+	ret =3D -EPERM;
+	if (!(d_backing_inode(subdir)->i_opflags & IOP_XATTR) ||
+	    !d_backing_inode(subdir)->i_op->lookup ||
+	    !d_backing_inode(subdir)->i_op->rename ||
+	    !d_backing_inode(subdir)->i_op->rmdir ||
+	    !d_backing_inode(subdir)->i_op->unlink)
+		goto check_error;
+
+	_leave(" =3D [%lu]", d_backing_inode(subdir)->i_ino);
+	return subdir;
+
+check_error:
+	erofscache_put_directory(subdir);
+	_leave(" =3D %d [check]", ret);
+	return ERR_PTR(ret);
+
+mark_error:
+	inode_unlock(d_inode(subdir));
+	dput(subdir);
+	return ERR_PTR(-EBUSY);
+
+enoent:
+	inode_unlock(d_inode(dir));
+	dput(subdir);
+	pr_err("No such directory %s\n", dirname);
+	return ERR_PTR(-ENOENT);
+
+lookup_error:
+	inode_unlock(d_inode(dir));
+	ret =3D PTR_ERR(subdir);
+	pr_err("Lookup %s failed with error %d\n", dirname, ret);
+	return ERR_PTR(ret);
+
+nomem_d_alloc:
+	inode_unlock(d_inode(dir));
+	_leave(" =3D -ENOMEM");
+	return ERR_PTR(-ENOMEM);
+}
+
+/*
+ * Put a subdirectory.
+ */
+void erofscache_put_directory(struct dentry *dir)
+{
+	if (dir) {
+		inode_lock(dir->d_inode);
+		__erofscache_unmark_inode_in_use(NULL, dir);
+		inode_unlock(dir->d_inode);
+		dput(dir);
+	}
+}
+
+/*
+ * Remove a regular file from the cache.
+ */
+static int erofscache_unlink(struct erofscache_cache *cache,
+			     struct erofscache_object *object,
+			     struct dentry *dir, struct dentry *dentry,
+			     enum fscache_why_object_killed why)
+{
+	struct path path =3D {
+		.mnt	=3D cache->mnt,
+		.dentry	=3D dir,
+	};
+	int ret;
+
+	trace_erofscache_unlink(object, d_inode(dentry)->i_ino, why);
+	ret =3D security_path_unlink(&path, dentry);
+	if (ret < 0) {
+		erofscache_io_error(cache, "Unlink security error");
+		return ret;
+	}
+
+	ret =3D erofscache_inject_remove_error();
+	if (ret =3D=3D 0) {
+		ret =3D vfs_unlink(&init_user_ns, d_backing_inode(dir), dentry, NULL);
+		if (ret =3D=3D -EIO)
+			erofscache_io_error(cache, "Unlink failed");
+	}
+	if (ret !=3D 0)
+		trace_erofscache_vfs_error(object, d_backing_inode(dir), ret,
+					   erofscache_trace_unlink_error);
+	return ret;
+}
+
+/*
+ * Delete an object representation from the cache
+ * - File backed objects are unlinked
+ * - Directory backed objects are stuffed into the graveyard for userspac=
e to
+ *   delete
+ */
+int erofscache_bury_object(struct erofscache_cache *cache,
+			   struct erofscache_object *object,
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
+	if (rep->d_parent !=3D dir) {
+		inode_unlock(d_inode(dir));
+		_leave(" =3D -ESTALE");
+		return -ESTALE;
+	}
+
+	/* non-directories can just be unlinked */
+	if (!d_is_dir(rep)) {
+		dget(rep); /* Stop the dentry being negated if it's only pinned
+			    * by a file struct.
+			    */
+		ret =3D erofscache_unlink(cache, object, dir, rep, why);
+		dput(rep);
+
+		inode_unlock(d_inode(dir));
+		_leave(" =3D %d", ret);
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
+	trap =3D lock_rename(cache->graveyard, dir);
+
+	/* do some checks before getting the grave dentry */
+	if (rep->d_parent !=3D dir || IS_DEADDIR(d_inode(rep))) {
+		/* the entry was probably culled when we dropped the parent dir
+		 * lock */
+		unlock_rename(cache->graveyard, dir);
+		_leave(" =3D 0 [culled?]");
+		return 0;
+	}
+
+	if (!d_can_lookup(cache->graveyard)) {
+		unlock_rename(cache->graveyard, dir);
+		erofscache_io_error(cache, "Graveyard no longer a directory");
+		return -EIO;
+	}
+
+	if (trap =3D=3D rep) {
+		unlock_rename(cache->graveyard, dir);
+		erofscache_io_error(cache, "May not make directory loop");
+		return -EIO;
+	}
+
+	if (d_mountpoint(rep)) {
+		unlock_rename(cache->graveyard, dir);
+		erofscache_io_error(cache, "Mountpoint in cache");
+		return -EIO;
+	}
+
+	grave =3D lookup_one_len(nbuffer, cache->graveyard, strlen(nbuffer));
+	if (IS_ERR(grave)) {
+		unlock_rename(cache->graveyard, dir);
+		trace_erofscache_vfs_error(object, d_inode(cache->graveyard),
+					   PTR_ERR(grave),
+					   erofscache_trace_lookup_error);
+
+		if (PTR_ERR(grave) =3D=3D -ENOMEM) {
+			_leave(" =3D -ENOMEM");
+			return -ENOMEM;
+		}
+
+		erofscache_io_error(cache, "Lookup error %ld", PTR_ERR(grave));
+		return -EIO;
+	}
+
+	if (d_is_positive(grave)) {
+		unlock_rename(cache->graveyard, dir);
+		dput(grave);
+		grave =3D NULL;
+		cond_resched();
+		goto try_again;
+	}
+
+	if (d_mountpoint(grave)) {
+		unlock_rename(cache->graveyard, dir);
+		dput(grave);
+		erofscache_io_error(cache, "Mountpoint in graveyard");
+		return -EIO;
+	}
+
+	/* target should not be an ancestor of source */
+	if (trap =3D=3D grave) {
+		unlock_rename(cache->graveyard, dir);
+		dput(grave);
+		erofscache_io_error(cache, "May not make directory loop");
+		return -EIO;
+	}
+
+	/* attempt the rename */
+	path.mnt =3D cache->mnt;
+	path.dentry =3D dir;
+	path_to_graveyard.mnt =3D cache->mnt;
+	path_to_graveyard.dentry =3D cache->graveyard;
+	ret =3D security_path_rename(&path, rep, &path_to_graveyard, grave, 0);
+	if (ret < 0) {
+		erofscache_io_error(cache, "Rename security error %d", ret);
+	} else {
+		struct renamedata rd =3D {
+			.old_mnt_userns	=3D &init_user_ns,
+			.old_dir	=3D d_inode(dir),
+			.old_dentry	=3D rep,
+			.new_mnt_userns	=3D &init_user_ns,
+			.new_dir	=3D d_inode(cache->graveyard),
+			.new_dentry	=3D grave,
+		};
+		trace_erofscache_rename(object, d_inode(rep)->i_ino, why);
+		ret =3D erofscache_inject_read_error();
+		if (ret =3D=3D 0)
+			ret =3D vfs_rename(&rd);
+		if (ret !=3D 0)
+			trace_erofscache_vfs_error(object, d_inode(dir), ret,
+						   erofscache_trace_rename_error);
+		if (ret !=3D 0 && ret !=3D -ENOMEM)
+			erofscache_io_error(cache,
+					    "Rename failed with error %d", ret);
+	}
+
+	__erofscache_unmark_inode_in_use(object, rep);
+	unlock_rename(cache->graveyard, dir);
+	dput(grave);
+	_leave(" =3D 0");
+	return 0;
+}
+
+/*
+ * Delete a cache file.
+ */
+int erofscache_delete_object(struct erofscache_object *object,
+			     enum fscache_why_object_killed why)
+{
+	struct erofscache_volume *volume =3D object->volume;
+	struct dentry *dentry =3D object->file->f_path.dentry;
+	struct dentry *fan =3D volume->fanout[(u8)object->cookie->key_hash];
+	int ret;
+
+	_enter(",OBJ%x{%pD}", object->debug_id, object->file);
+
+	/* Stop the dentry being negated if it's only pinned by a file struct. *=
/
+	dget(dentry);
+
+	inode_lock_nested(d_backing_inode(fan), I_MUTEX_PARENT);
+	ret =3D erofscache_unlink(volume->cache, object, fan, dentry, why);
+	inode_unlock(d_backing_inode(fan));
+	dput(dentry);
+	return ret;
+}
+
+/*
+ * Open an existing file, checking its attributes and replacing it if it =
is
+ * stale.
+ */
+static bool erofscache_open_file(struct erofscache_object *object,
+				 struct dentry *dentry)
+{
+	struct erofscache_cache *cache =3D object->volume->cache;
+	struct file *file;
+	struct path path;
+	int ret;
+
+	_enter("%pd", dentry);
+
+	if (!erofscache_mark_inode_in_use(object, dentry))
+		return false;
+
+	/* We need to open a file interface onto a data file now as we can't do
+	 * it on demand because writeback called from do_exit() sees
+	 * current->fs =3D=3D NULL - which breaks d_path() called from ext4 open=
.
+	 */
+	path.mnt =3D cache->mnt;
+	path.dentry =3D dentry;
+	file =3D open_with_fake_path(&path, O_RDONLY | O_LARGEFILE | O_DIRECT,
+				   d_backing_inode(dentry), cache->cache_cred);
+	if (IS_ERR(file)) {
+		trace_erofscache_vfs_error(object, d_backing_inode(dentry),
+					   PTR_ERR(file),
+					   erofscache_trace_open_error);
+		goto error;
+	}
+
+	if (unlikely(!file->f_op->read_iter)) {
+		pr_notice("Cache does not support read_iter\n");
+		goto error_fput;
+	}
+	_debug("file -> %pd positive", dentry);
+
+	ret =3D erofscache_check_auxdata(object, file);
+	if (ret < 0)
+		goto check_failed;
+
+	object->file =3D file;
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
+	erofscache_unmark_inode_in_use(object, file);
+	if (ret =3D=3D -ESTALE) {
+		fput(file);
+		dput(dentry);
+		// TODO: Do on-demand load
+		return false;
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
+bool erofscache_look_up_object(struct erofscache_object *object)
+{
+	struct erofscache_volume *volume =3D object->volume;
+	struct dentry *dentry, *fan =3D volume->fanout[(u8)object->cookie->key_h=
ash];
+	int ret;
+
+	_enter("OBJ%x,%s,", object->debug_id, object->d_name);
+
+	/* Look up path "cache/vol/fanout/file". */
+	ret =3D erofscache_inject_read_error();
+	if (ret =3D=3D 0)
+		dentry =3D lookup_positive_unlocked(object->d_name, fan,
+						  object->d_name_len);
+	else
+		dentry =3D ERR_PTR(ret);
+	trace_erofscache_lookup(object, fan, dentry);
+	if (IS_ERR(dentry)) {
+		if (dentry =3D=3D ERR_PTR(-ENOENT))
+			goto new_file;
+		if (dentry =3D=3D ERR_PTR(-EIO))
+			erofscache_io_error_obj(object, "Lookup failed");
+		return false;
+	}
+
+	if (!d_is_reg(dentry)) {
+		pr_err("%pd is not a file\n", dentry);
+		inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
+		ret =3D erofscache_bury_object(volume->cache, object, fan, dentry,
+					     FSCACHE_OBJECT_IS_WEIRD);
+		dput(dentry);
+		if (ret < 0)
+			return false;
+		goto new_file;
+	}
+
+	if (!erofscache_open_file(object, dentry))
+		return false;
+
+	_leave(" =3D t [%lu]", file_inode(object->file)->i_ino);
+	return true;
+
+new_file:
+	fscache_cookie_lookup_negative(object->cookie);
+	return false; // TODO: Trigger on-demand file creation
+}
+
+/*
+ * Look up an inode to be checked or culled.  Return -EBUSY if the inode =
is
+ * marked in use.
+ */
+static struct dentry *erofscache_lookup_for_cull(struct erofscache_cache =
*cache,
+						 struct dentry *dir,
+						 char *filename)
+{
+	struct dentry *victim;
+	int ret =3D -ENOENT;
+
+	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+
+	victim =3D lookup_one_len(filename, dir, strlen(filename));
+	if (IS_ERR(victim))
+		goto lookup_error;
+	if (d_is_negative(victim))
+		goto lookup_put;
+	if (d_inode(victim)->i_flags & S_KERNEL_FILE)
+		goto lookup_busy;
+	return victim;
+
+lookup_busy:
+	ret =3D -EBUSY;
+lookup_put:
+	inode_unlock(d_inode(dir));
+	dput(victim);
+	return ERR_PTR(ret);
+
+lookup_error:
+	inode_unlock(d_inode(dir));
+	ret =3D PTR_ERR(victim);
+	if (ret =3D=3D -ENOENT)
+		return ERR_PTR(-ESTALE); /* Probably got retired by the netfs */
+
+	if (ret =3D=3D -EIO) {
+		erofscache_io_error(cache, "Lookup failed");
+	} else if (ret !=3D -ENOMEM) {
+		pr_err("Internal error: %d\n", ret);
+		ret =3D -EIO;
+	}
+
+	return ERR_PTR(ret);
+}
+
+/*
+ * Cull an object if it's not in use
+ * - called only by cache manager daemon
+ */
+int erofscache_cull(struct erofscache_cache *cache, struct dentry *dir,
+		    char *filename)
+{
+	struct dentry *victim;
+	struct inode *inode;
+	int ret;
+
+	_enter(",%pd/,%s", dir, filename);
+
+	victim =3D erofscache_lookup_for_cull(cache, dir, filename);
+	if (IS_ERR(victim))
+		return PTR_ERR(victim);
+
+	/* check to see if someone is using this object */
+	inode =3D d_inode(victim);
+	inode_lock(inode);
+	if (inode->i_flags & S_KERNEL_FILE) {
+		ret =3D -EBUSY;
+	} else {
+		/* Stop the cache from picking it back up */
+		inode->i_flags |=3D S_KERNEL_FILE;
+		ret =3D 0;
+	}
+	inode_unlock(inode);
+	if (ret < 0)
+		goto error_unlock;
+
+	ret =3D erofscache_bury_object(cache, NULL, dir, victim,
+				     FSCACHE_OBJECT_WAS_CULLED);
+	if (ret < 0)
+		goto error;
+
+	fscache_count_culled();
+	dput(victim);
+	_leave(" =3D 0");
+	return 0;
+
+error_unlock:
+	inode_unlock(d_inode(dir));
+error:
+	dput(victim);
+	if (ret =3D=3D -ENOENT)
+		return -ESTALE; /* Probably got retired by the netfs */
+
+	if (ret !=3D -ENOMEM) {
+		pr_err("Internal error: %d\n", ret);
+		ret =3D -EIO;
+	}
+
+	_leave(" =3D %d", ret);
+	return ret;
+}
+
+/*
+ * Find out if an object is in use or not
+ * - called only by cache manager daemon
+ * - returns -EBUSY or 0 to indicate whether an object is in use or not
+ */
+int erofscache_check_in_use(struct erofscache_cache *cache, struct dentry=
 *dir,
+			    char *filename)
+{
+	struct dentry *victim;
+	int ret =3D 0;
+
+	victim =3D erofscache_lookup_for_cull(cache, dir, filename);
+	if (IS_ERR(victim))
+		return PTR_ERR(victim);
+
+	inode_unlock(d_inode(dir));
+	dput(victim);
+	return ret;
+}
diff --git a/fs/erofscache/security.c b/fs/erofscache/security.c
new file mode 100644
index 000000000000..b642f106e761
--- /dev/null
+++ b/fs/erofscache/security.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Erofscache security management
+ *
+ * Copyright (C) 2007, 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/cred.h>
+#include "internal.h"
+
+/*
+ * determine the security context within which we access the cache from w=
ithin
+ * the kernel
+ */
+int erofscache_get_security_ID(struct erofscache_cache *cache)
+{
+	struct cred *new;
+	int ret;
+
+	_enter("{%s}", cache->secctx);
+
+	new =3D prepare_kernel_cred(current);
+	if (!new) {
+		ret =3D -ENOMEM;
+		goto error;
+	}
+
+	if (cache->secctx) {
+		ret =3D set_security_override_from_ctx(new, cache->secctx);
+		if (ret < 0) {
+			put_cred(new);
+			pr_err("Security denies permission to nominate security context: error=
 %d\n",
+			       ret);
+			goto error;
+		}
+	}
+
+	cache->cache_cred =3D new;
+	ret =3D 0;
+error:
+	_leave(" =3D %d", ret);
+	return ret;
+}
+
+/*
+ * check the security details of the on-disk cache
+ * - must be called with security override in force
+ * - must return with a security override in force - even in the case of =
an
+ *   error
+ */
+int erofscache_determine_cache_security(struct erofscache_cache *cache,
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
+	new =3D prepare_creds();
+	if (!new)
+		return -ENOMEM;
+
+	erofscache_end_secure(cache, *_saved_cred);
+
+	/* use the cache root dir's security context as the basis with
+	 * which create files */
+	ret =3D set_create_files_as(new, d_backing_inode(root));
+	if (ret < 0) {
+		abort_creds(new);
+		erofscache_begin_secure(cache, _saved_cred);
+		_leave(" =3D %d [cfa]", ret);
+		return ret;
+	}
+
+	put_cred(cache->cache_cred);
+	cache->cache_cred =3D new;
+
+	erofscache_begin_secure(cache, _saved_cred);
+	_leave(" =3D %d", ret);
+	return ret;
+}
diff --git a/fs/erofscache/volume.c b/fs/erofscache/volume.c
new file mode 100644
index 000000000000..8c18281b02fe
--- /dev/null
+++ b/fs/erofscache/volume.c
@@ -0,0 +1,129 @@
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
+ * Allocate and set up a volume representation.  We make sure all the fan=
out
+ * directories are created and pinned.
+ */
+void erofscache_acquire_volume(struct fscache_volume *vcookie)
+{
+	struct erofscache_volume *volume;
+	struct erofscache_cache *cache =3D vcookie->cache->cache_priv;
+	const struct cred *saved_cred;
+	struct dentry *vdentry, *fan;
+	size_t len;
+	char *name;
+	int ret, n_accesses, i;
+
+	_enter("");
+
+	volume =3D kzalloc(sizeof(struct erofscache_volume), GFP_KERNEL);
+	if (!volume)
+		return;
+	volume->vcookie =3D vcookie;
+	volume->cache =3D cache;
+	INIT_LIST_HEAD(&volume->cache_link);
+
+	erofscache_begin_secure(cache, &saved_cred);
+
+	len =3D vcookie->key[0];
+	name =3D kmalloc(len + 3, GFP_NOFS);
+	if (!name)
+		goto error_vol;
+	name[0] =3D 'I';
+	memcpy(name + 1, vcookie->key + 1, len);
+	name[len + 1] =3D 0;
+
+	vdentry =3D erofscache_get_directory(cache, cache->store, name);
+	if (IS_ERR(vdentry))
+		goto error_name;
+	volume->dentry =3D vdentry;
+
+	ret =3D erofscache_check_volume_xattr(volume);
+	if (ret < 0) {
+		if (ret !=3D -ESTALE)
+			goto error_dir;
+		inode_lock_nested(d_inode(cache->store), I_MUTEX_PARENT);
+		erofscache_bury_object(cache, NULL, cache->store, vdentry,
+				       FSCACHE_VOLUME_IS_WEIRD);
+		goto error_dir;
+	}
+	=

+	for (i =3D 0; i < 256; i++) {
+		sprintf(name, "@%02x", i);
+		fan =3D erofscache_get_directory(cache, vdentry, name);
+		if (IS_ERR(fan))
+			goto error_fan;
+		volume->fanout[i] =3D fan;
+	}
+
+	erofscache_end_secure(cache, saved_cred);
+
+	vcookie->cache_priv =3D volume;
+	n_accesses =3D atomic_inc_return(&vcookie->n_accesses); /* Stop wakeups =
on dec-to-0 */
+	trace_fscache_access_volume(vcookie->debug_id, 0,
+				    refcount_read(&vcookie->ref),
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
+	for (i =3D 0; i < 256; i++)
+		erofscache_put_directory(volume->fanout[i]);
+error_dir:
+	erofscache_put_directory(volume->dentry);
+error_name:
+	kfree(name);
+error_vol:
+	kfree(volume);
+	erofscache_end_secure(cache, saved_cred);
+}
+
+/*
+ * Release a volume representation.
+ */
+static void __erofscache_free_volume(struct erofscache_volume *volume)
+{
+	int i;
+
+	_enter("");
+
+	volume->vcookie->cache_priv =3D NULL;
+
+	for (i =3D 0; i < 256; i++)
+		erofscache_put_directory(volume->fanout[i]);
+	erofscache_put_directory(volume->dentry);
+	kfree(volume);
+}
+
+void erofscache_free_volume(struct fscache_volume *vcookie)
+{
+	struct erofscache_volume *volume =3D vcookie->cache_priv;
+
+	if (volume) {
+		spin_lock(&volume->cache->object_list_lock);
+		list_del_init(&volume->cache_link);
+		spin_unlock(&volume->cache->object_list_lock);
+		__erofscache_free_volume(volume);
+	}
+}
+
+void erofscache_withdraw_volume(struct erofscache_volume *volume)
+{
+	fscache_withdraw_volume(volume->vcookie);
+	__erofscache_free_volume(volume);
+}
diff --git a/fs/erofscache/xattr.c b/fs/erofscache/xattr.c
new file mode 100644
index 000000000000..1f2408131c9e
--- /dev/null
+++ b/fs/erofscache/xattr.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Erofscache extended attribute management
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
+#define EROFSCACHE_COOKIE_TYPE_DATA 1
+
+struct erofscache_xattr {
+	__be64	object_size;	/* Actual size of the object */
+	__u8	type;		/* Type of object */
+	__u8	data[];		/* netfs coherency data */
+} __packed;
+
+static const char erofscache_xattr_cache[] =3D
+	XATTR_USER_PREFIX "Erofscache.cache";
+
+/*
+ * check the consistency between the backing cache and the FS-Cache cooki=
e
+ */
+int erofscache_check_auxdata(struct erofscache_object *object, struct fil=
e *file)
+{
+	struct erofscache_xattr *buf;
+	struct dentry *dentry =3D file->f_path.dentry;
+	unsigned int len =3D object->cookie->aux_len, tlen;
+	const void *p =3D fscache_get_aux(object->cookie);
+	enum erofscache_coherency_trace why;
+	ssize_t xlen;
+	int ret =3D -ESTALE;
+
+	tlen =3D sizeof(struct erofscache_xattr) + len;
+	buf =3D kmalloc(tlen, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	xlen =3D erofscache_inject_read_error();
+	if (xlen =3D=3D 0)
+		xlen =3D vfs_getxattr(&init_user_ns, dentry, erofscache_xattr_cache, bu=
f, tlen);
+	if (xlen !=3D tlen) {
+		if (xlen < 0)
+			trace_erofscache_vfs_error(object, file_inode(file), xlen,
+						   erofscache_trace_getxattr_error);
+		if (xlen =3D=3D -EIO)
+			erofscache_io_error_obj(
+				object,
+				"Failed to read aux with error %zd", xlen);
+		why =3D erofscache_coherency_check_xattr;
+	} else if (buf->type !=3D EROFSCACHE_COOKIE_TYPE_DATA) {
+		why =3D erofscache_coherency_check_type;
+	} else if (memcmp(buf->data, p, len) !=3D 0) {
+		why =3D erofscache_coherency_check_aux;
+	} else if (be64_to_cpu(buf->object_size) !=3D object->cookie->object_siz=
e) {
+		why =3D erofscache_coherency_check_objsize;
+	} else {
+		why =3D erofscache_coherency_check_ok;
+		ret =3D 0;
+	}
+
+	trace_erofscache_coherency(object, file_inode(file)->i_ino, why);
+	kfree(buf);
+	return ret;
+}
+
+/*
+ * remove the object's xattr to mark it stale
+ */
+int erofscache_remove_object_xattr(struct erofscache_cache *cache,
+				   struct erofscache_object *object,
+				   struct dentry *dentry)
+{
+	int ret;
+
+	ret =3D erofscache_inject_remove_error();
+	if (ret =3D=3D 0)
+		ret =3D vfs_removexattr(&init_user_ns, dentry, erofscache_xattr_cache);
+	if (ret < 0) {
+		trace_erofscache_vfs_error(object, d_inode(dentry), ret,
+					   erofscache_trace_remxattr_error);
+		if (ret =3D=3D -ENOENT || ret =3D=3D -ENODATA)
+			ret =3D 0;
+		else if (ret !=3D -ENOMEM)
+			erofscache_io_error(cache,
+					    "Can't remove xattr from %lu"
+					    " (error %d)",
+					    d_backing_inode(dentry)->i_ino, -ret);
+	}
+
+	_leave(" =3D %d", ret);
+	return ret;
+}
+
+/*
+ * Check the consistency between the backing cache and the volume cookie.
+ */
+int erofscache_check_volume_xattr(struct erofscache_volume *volume)
+{
+	struct erofscache_xattr *buf;
+	struct dentry *dentry =3D volume->dentry;
+	unsigned int len =3D volume->vcookie->coherency_len;
+	const void *p =3D volume->vcookie->coherency;
+	enum erofscache_coherency_trace why;
+	ssize_t xlen;
+	int ret =3D -ESTALE;
+
+	_enter("");
+
+	buf =3D kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	xlen =3D erofscache_inject_read_error();
+	if (xlen =3D=3D 0)
+		xlen =3D vfs_getxattr(&init_user_ns, dentry, erofscache_xattr_cache, bu=
f, len);
+	if (xlen !=3D len) {
+		if (xlen < 0) {
+			trace_erofscache_vfs_error(NULL, d_inode(dentry), xlen,
+						   erofscache_trace_getxattr_error);
+			if (xlen =3D=3D -EIO)
+				erofscache_io_error(
+					volume->cache,
+					"Failed to read xattr with error %zd", xlen);
+		}
+		why =3D erofscache_coherency_vol_check_xattr;
+	} else if (memcmp(buf->data, p, len) !=3D 0) {
+		why =3D erofscache_coherency_vol_check_cmp;
+	} else {
+		why =3D erofscache_coherency_vol_check_ok;
+		ret =3D 0;
+	}
+
+	trace_erofscache_vol_coherency(volume, d_inode(dentry)->i_ino, why);
+	kfree(buf);
+	_leave(" =3D %d", ret);
+	return ret;
+}
diff --git a/include/trace/events/erofscache.h b/include/trace/events/erof=
scache.h
new file mode 100644
index 000000000000..96974fd097f0
--- /dev/null
+++ b/include/trace/events/erofscache.h
@@ -0,0 +1,515 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Erofscache tracepoints
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM erofscache
+
+#if !defined(_TRACE_EROFSCACHE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_EROFSCACHE_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * Define enums for tracing information.
+ */
+#ifndef __EROFSCACHE_DECLARE_TRACE_ENUMS_ONCE_ONLY
+#define __EROFSCACHE_DECLARE_TRACE_ENUMS_ONCE_ONLY
+
+enum erofscache_obj_ref_trace {
+	erofscache_obj_get_ioreq,
+	erofscache_obj_new,
+	erofscache_obj_put_alloc_fail,
+	erofscache_obj_put_detach,
+	erofscache_obj_put_ioreq,
+	erofscache_obj_see_clean_commit,
+	erofscache_obj_see_clean_delete,
+	erofscache_obj_see_clean_drop_tmp,
+	erofscache_obj_see_lookup_cookie,
+	erofscache_obj_see_lookup_failed,
+	erofscache_obj_see_withdraw_cookie,
+	erofscache_obj_see_withdrawal,
+};
+
+enum fscache_why_object_killed {
+	FSCACHE_OBJECT_IS_STALE,
+	FSCACHE_OBJECT_IS_WEIRD,
+	FSCACHE_OBJECT_INVALIDATED,
+	FSCACHE_OBJECT_NO_SPACE,
+	FSCACHE_OBJECT_WAS_RETIRED,
+	FSCACHE_OBJECT_WAS_CULLED,
+	FSCACHE_VOLUME_IS_WEIRD,
+};
+
+enum erofscache_coherency_trace {
+	erofscache_coherency_check_aux,
+	erofscache_coherency_check_content,
+	erofscache_coherency_check_dirty,
+	erofscache_coherency_check_len,
+	erofscache_coherency_check_objsize,
+	erofscache_coherency_check_ok,
+	erofscache_coherency_check_type,
+	erofscache_coherency_check_xattr,
+	erofscache_coherency_vol_check_cmp,
+	erofscache_coherency_vol_check_ok,
+	erofscache_coherency_vol_check_xattr,
+};
+
+enum erofscache_prepare_read_trace {
+	erofscache_trace_read_after_eof,
+	erofscache_trace_read_found_hole,
+	erofscache_trace_read_found_part,
+	erofscache_trace_read_have_data,
+	erofscache_trace_read_no_data,
+	erofscache_trace_read_no_file,
+	erofscache_trace_read_seek_error,
+	erofscache_trace_read_seek_nxio,
+};
+
+enum erofscache_error_trace {
+	erofscache_trace_getxattr_error,
+	erofscache_trace_link_error,
+	erofscache_trace_lookup_error,
+	erofscache_trace_open_error,
+	erofscache_trace_read_error,
+	erofscache_trace_remxattr_error,
+	erofscache_trace_rename_error,
+	erofscache_trace_seek_error,
+	erofscache_trace_unlink_error,
+};
+
+#endif
+
+/*
+ * Define enum -> string mappings for display.
+ */
+#define erofscache_obj_kill_traces				\
+	EM(FSCACHE_OBJECT_IS_STALE,	"stale")		\
+	EM(FSCACHE_OBJECT_IS_WEIRD,	"weird")		\
+	EM(FSCACHE_OBJECT_INVALIDATED,	"inval")		\
+	EM(FSCACHE_OBJECT_NO_SPACE,	"no_space")		\
+	EM(FSCACHE_OBJECT_WAS_RETIRED,	"was_retired")		\
+	EM(FSCACHE_OBJECT_WAS_CULLED,	"was_culled")		\
+	E_(FSCACHE_VOLUME_IS_WEIRD,	"volume_weird")
+
+#define erofscache_obj_ref_traces					\
+	EM(erofscache_obj_get_ioreq,		"GET ioreq")		\
+	EM(erofscache_obj_new,			"NEW obj")		\
+	EM(erofscache_obj_put_alloc_fail,	"PUT alloc_fail")	\
+	EM(erofscache_obj_put_detach,		"PUT detach")		\
+	EM(erofscache_obj_put_ioreq,		"PUT ioreq")		\
+	EM(erofscache_obj_see_clean_commit,	"SEE clean_commit")	\
+	EM(erofscache_obj_see_clean_delete,	"SEE clean_delete")	\
+	EM(erofscache_obj_see_clean_drop_tmp,	"SEE clean_drop_tmp")	\
+	EM(erofscache_obj_see_lookup_cookie,	"SEE lookup_cookie")	\
+	EM(erofscache_obj_see_lookup_failed,	"SEE lookup_failed")	\
+	EM(erofscache_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
+	E_(erofscache_obj_see_withdrawal,	"SEE withdrawal")
+
+#define erofscache_coherency_traces					\
+	EM(erofscache_coherency_check_aux,	"BAD aux ")		\
+	EM(erofscache_coherency_check_content,	"BAD cont")		\
+	EM(erofscache_coherency_check_dirty,	"BAD dirt")		\
+	EM(erofscache_coherency_check_len,	"BAD len ")		\
+	EM(erofscache_coherency_check_objsize,	"BAD osiz")		\
+	EM(erofscache_coherency_check_ok,	"OK      ")		\
+	EM(erofscache_coherency_check_type,	"BAD type")		\
+	EM(erofscache_coherency_check_xattr,	"BAD xatt")		\
+	EM(erofscache_coherency_vol_check_cmp,	"VOL BAD cmp ")		\
+	EM(erofscache_coherency_vol_check_ok,	"VOL OK      ")		\
+	E_(erofscache_coherency_vol_check_xattr,"VOL BAD xatt")
+
+#define erofscache_prepare_read_traces					\
+	EM(erofscache_trace_read_after_eof,	"after-eof ")		\
+	EM(erofscache_trace_read_found_hole,	"found-hole")		\
+	EM(erofscache_trace_read_found_part,	"found-part")		\
+	EM(erofscache_trace_read_have_data,	"have-data ")		\
+	EM(erofscache_trace_read_no_data,	"no-data   ")		\
+	EM(erofscache_trace_read_no_file,	"no-file   ")		\
+	EM(erofscache_trace_read_seek_error,	"seek-error")		\
+	E_(erofscache_trace_read_seek_nxio,	"seek-enxio")
+
+#define erofscache_error_traces						\
+	EM(erofscache_trace_getxattr_error,	"getxattr")		\
+	EM(erofscache_trace_lookup_error,	"lookup")		\
+	EM(erofscache_trace_open_error,		"open")			\
+	EM(erofscache_trace_read_error,		"read")			\
+	EM(erofscache_trace_remxattr_error,	"remxattr")		\
+	EM(erofscache_trace_rename_error,	"rename")		\
+	EM(erofscache_trace_seek_error,		"seek")			\
+	E_(erofscache_trace_unlink_error,	"unlink")
+
+
+/*
+ * Export enum symbols via userspace.
+ */
+#undef EM
+#undef E_
+#define EM(a, b) TRACE_DEFINE_ENUM(a);
+#define E_(a, b) TRACE_DEFINE_ENUM(a);
+
+erofscache_obj_kill_traces;
+erofscache_obj_ref_traces;
+erofscache_coherency_traces;
+erofscache_prepare_read_traces;
+erofscache_error_traces;
+
+/*
+ * Now redefine the EM() and E_() macros to map the enums to the strings =
that
+ * will be printed in the output.
+ */
+#undef EM
+#undef E_
+#define EM(a, b)	{ a, b },
+#define E_(a, b)	{ a, b }
+
+
+TRACE_EVENT(erofscache_ref,
+	    TP_PROTO(unsigned int object_debug_id,
+		     unsigned int cookie_debug_id,
+		     int usage,
+		     enum erofscache_obj_ref_trace why),
+
+	    TP_ARGS(object_debug_id, cookie_debug_id, usage, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj		)
+		    __field(unsigned int,			cookie		)
+		    __field(enum erofscache_obj_ref_trace,	why		)
+		    __field(int,				usage		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	=3D object_debug_id;
+		    __entry->cookie	=3D cookie_debug_id;
+		    __entry->usage	=3D usage;
+		    __entry->why	=3D why;
+			   ),
+
+	    TP_printk("c=3D%08x o=3D%08x u=3D%d %s",
+		      __entry->cookie, __entry->obj, __entry->usage,
+		      __print_symbolic(__entry->why, erofscache_obj_ref_traces))
+	    );
+
+TRACE_EVENT(erofscache_lookup,
+	    TP_PROTO(struct erofscache_object *obj,
+		     struct dentry *dir,
+		     struct dentry *de),
+
+	    TP_ARGS(obj, dir, de),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj	)
+		    __field(short,			error	)
+		    __field(unsigned long,		dino	)
+		    __field(unsigned long,		ino	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	=3D obj ? obj->debug_id : 0;
+		    __entry->dino	=3D d_backing_inode(dir)->i_ino;
+		    __entry->ino	=3D (!IS_ERR(de) && d_backing_inode(de) ?
+					   d_backing_inode(de)->i_ino : 0);
+		    __entry->error	=3D IS_ERR(de) ? PTR_ERR(de) : 0;
+			   ),
+
+	    TP_printk("o=3D%08x dB=3D%lx B=3D%lx e=3D%d",
+		      __entry->obj, __entry->dino, __entry->ino, __entry->error)
+	    );
+
+TRACE_EVENT(erofscache_unlink,
+	    TP_PROTO(struct erofscache_object *obj,
+		     ino_t ino,
+		     enum fscache_why_object_killed why),
+
+	    TP_ARGS(obj, ino, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj		)
+		    __field(unsigned int,		ino		)
+		    __field(enum fscache_why_object_killed, why		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	=3D obj ? obj->debug_id : UINT_MAX;
+		    __entry->ino	=3D ino;
+		    __entry->why	=3D why;
+			   ),
+
+	    TP_printk("o=3D%08x B=3D%x w=3D%s",
+		      __entry->obj, __entry->ino,
+		      __print_symbolic(__entry->why, erofscache_obj_kill_traces))
+	    );
+
+TRACE_EVENT(erofscache_rename,
+	    TP_PROTO(struct erofscache_object *obj,
+		     ino_t ino,
+		     enum fscache_why_object_killed why),
+
+	    TP_ARGS(obj, ino, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj		)
+		    __field(unsigned int,		ino		)
+		    __field(enum fscache_why_object_killed, why		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	=3D obj ? obj->debug_id : UINT_MAX;
+		    __entry->ino	=3D ino;
+		    __entry->why	=3D why;
+			   ),
+
+	    TP_printk("o=3D%08x B=3D%x w=3D%s",
+		      __entry->obj, __entry->ino,
+		      __print_symbolic(__entry->why, erofscache_obj_kill_traces))
+	    );
+
+TRACE_EVENT(erofscache_coherency,
+	    TP_PROTO(struct erofscache_object *obj,
+		     ino_t ino,
+		     enum erofscache_coherency_trace why),
+
+	    TP_ARGS(obj, ino, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(enum erofscache_coherency_trace,	why	)
+		    __field(u64,				ino	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	=3D obj->debug_id;
+		    __entry->why	=3D why;
+		    __entry->ino	=3D ino;
+			   ),
+
+	    TP_printk("o=3D%08x %s B=3D%llx",
+		      __entry->obj,
+		      __print_symbolic(__entry->why, erofscache_coherency_traces),
+		      __entry->ino)
+	    );
+
+TRACE_EVENT(erofscache_vol_coherency,
+	    TP_PROTO(struct erofscache_volume *volume,
+		     ino_t ino,
+		     enum erofscache_coherency_trace why),
+
+	    TP_ARGS(volume, ino, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			vol	)
+		    __field(enum erofscache_coherency_trace,	why	)
+		    __field(u64,				ino	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->vol	=3D volume->vcookie->debug_id;
+		    __entry->why	=3D why;
+		    __entry->ino	=3D ino;
+			   ),
+
+	    TP_printk("V=3D%08x %s B=3D%llx",
+		      __entry->vol,
+		      __print_symbolic(__entry->why, erofscache_coherency_traces),
+		      __entry->ino)
+	    );
+
+TRACE_EVENT(erofscache_prep_read,
+	    TP_PROTO(struct netfs_read_subrequest *sreq,
+		     enum netfs_read_source source,
+		     enum erofscache_prepare_read_trace why,
+		     ino_t cache_inode),
+
+	    TP_ARGS(sreq, source, why, cache_inode),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq		)
+		    __field(unsigned short,		index		)
+		    __field(unsigned short,		flags		)
+		    __field(enum netfs_read_source,	source		)
+		    __field(enum erofscache_prepare_read_trace,	why	)
+		    __field(size_t,			len		)
+		    __field(loff_t,			start		)
+		    __field(unsigned int,		netfs_inode	)
+		    __field(unsigned int,		cache_inode	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->rreq	=3D sreq->rreq->debug_id;
+		    __entry->index	=3D sreq->debug_index;
+		    __entry->flags	=3D sreq->flags;
+		    __entry->source	=3D source;
+		    __entry->why	=3D why;
+		    __entry->len	=3D sreq->len;
+		    __entry->start	=3D sreq->start;
+		    __entry->netfs_inode =3D sreq->rreq->inode->i_ino;
+		    __entry->cache_inode =3D cache_inode;
+			   ),
+
+	    TP_printk("R=3D%08x[%u] %s %s f=3D%02x s=3D%llx %zx ni=3D%x B=3D%x",
+		      __entry->rreq, __entry->index,
+		      __print_symbolic(__entry->source, netfs_sreq_sources),
+		      __print_symbolic(__entry->why, erofscache_prepare_read_traces),
+		      __entry->flags,
+		      __entry->start, __entry->len,
+		      __entry->netfs_inode, __entry->cache_inode)
+	    );
+
+TRACE_EVENT(erofscache_read,
+	    TP_PROTO(struct erofscache_object *obj,
+		     struct inode *backer,
+		     loff_t start,
+		     size_t len),
+
+	    TP_ARGS(obj, backer, start, len),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(size_t,				len	)
+		    __field(loff_t,				start	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	=3D obj->debug_id;
+		    __entry->backer	=3D backer->i_ino;
+		    __entry->start	=3D start;
+		    __entry->len	=3D len;
+			   ),
+
+	    TP_printk("o=3D%08x B=3D%x s=3D%llx l=3D%zx",
+		      __entry->obj,
+		      __entry->backer,
+		      __entry->start,
+		      __entry->len)
+	    );
+
+TRACE_EVENT(erofscache_mark_active,
+	    TP_PROTO(struct erofscache_object *obj,
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
+		    __entry->obj	=3D obj ? obj->debug_id : 0;
+		    __entry->inode	=3D inode->i_ino;
+			   ),
+
+	    TP_printk("o=3D%08x B=3D%lx",
+		      __entry->obj, __entry->inode)
+	    );
+
+TRACE_EVENT(erofscache_mark_failed,
+	    TP_PROTO(struct erofscache_object *obj,
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
+		    __entry->obj	=3D obj ? obj->debug_id : 0;
+		    __entry->inode	=3D inode->i_ino;
+			   ),
+
+	    TP_printk("o=3D%08x B=3D%lx",
+		      __entry->obj, __entry->inode)
+	    );
+
+TRACE_EVENT(erofscache_mark_inactive,
+	    TP_PROTO(struct erofscache_object *obj,
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
+		    __entry->obj	=3D obj ? obj->debug_id : 0;
+		    __entry->inode	=3D inode->i_ino;
+			   ),
+
+	    TP_printk("o=3D%08x B=3D%lx",
+		      __entry->obj, __entry->inode)
+	    );
+
+TRACE_EVENT(erofscache_vfs_error,
+	    TP_PROTO(struct erofscache_object *obj, struct inode *backer,
+		     int error, enum erofscache_error_trace where),
+
+	    TP_ARGS(obj, backer, error, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(enum erofscache_error_trace,	where	)
+		    __field(short,				error	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	=3D obj ? obj->debug_id : 0;
+		    __entry->backer	=3D backer->i_ino;
+		    __entry->error	=3D error;
+		    __entry->where	=3D where;
+			   ),
+
+	    TP_printk("o=3D%08x B=3D%x %s e=3D%d",
+		      __entry->obj,
+		      __entry->backer,
+		      __print_symbolic(__entry->where, erofscache_error_traces),
+		      __entry->error)
+	    );
+
+TRACE_EVENT(erofscache_io_error,
+	    TP_PROTO(struct erofscache_object *obj, struct inode *backer,
+		     int error, enum erofscache_error_trace where),
+
+	    TP_ARGS(obj, backer, error, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(enum erofscache_error_trace,	where	)
+		    __field(short,				error	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	=3D obj ? obj->debug_id : 0;
+		    __entry->backer	=3D backer->i_ino;
+		    __entry->error	=3D error;
+		    __entry->where	=3D where;
+			   ),
+
+	    TP_printk("o=3D%08x B=3D%x %s e=3D%d",
+		      __entry->obj,
+		      __entry->backer,
+		      __print_symbolic(__entry->where, erofscache_error_traces),
+		      __entry->error)
+	    );
+
+#endif /* _TRACE_EROFSCACHE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

