Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E3A130458
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 21:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgADUQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 15:16:44 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47790 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgADUQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 15:16:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D91CF8EE0CE;
        Sat,  4 Jan 2020 12:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578169003;
        bh=s6DKoLEUhwmiwUTjahwex5toWuavDWXEAxBFRBIY/44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uzk3227xHZ6YVGeM5oeEeoLEwaTgsydaffP8VId6l8b4mMzzCnQkBIbCJFQOix5bS
         2S3m5ZNfH4EudUofUi+70gJ+CzNEq6BxYaGWI3v/LmoAVJJgV5lRHeFYuGyMFh+0RV
         J1zm4hkn5objhQu6JHiEvK/Fsrm75Q8tOMsmBcGQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LCx24NiVzPp7; Sat,  4 Jan 2020 12:16:43 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6D18F8EE079;
        Sat,  4 Jan 2020 12:16:43 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v2 6/6] fs: bind: add configfs type for bind mounts
Date:   Sat,  4 Jan 2020 12:14:32 -0800
Message-Id: <20200104201432.27320-7-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200104201432.27320-1-James.Bottomley@HansenPartnership.com>
References: <20200104201432.27320-1-James.Bottomley@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This can do the equivalent of open_tree and also do bind mount
reconfiguration from ro to rw and vice versa.

To get the equvalent of open tree you need to do

   mnt = open("/path/to/tree", O_PATH);
   fd = configfs_open(bind, O_CLOEXEC);
   configfs_action(fd, CONFIGFD_SET_FD, "pathfd", NULL, mnt);
   configfs_action(fd, CONFIGFD_SET_FLAG, "detached", NULL, 0);
   configfs_action(fd, CONFIGFD_SET_FLAG, "recursive", NULL, 0);
   configfs_action(fd, CONFIGFD_CMD_CREATE, NULL, NULL, 0);
   configfs_action(fd, CONFIGFD_GET_FD, "bindfd", &bfd, NULL, O_CLOEXEC);

And bfd will now contain the file descriptor to pass to move_tree.
There is a deficiency over the original implementation in that the
open system call has no way of clearing the LOOKUP_AUTOMOUNT path, but
that's fixable.

To do a mount reconfigure to change the bind mount to readonly do

   mnt = open("/path/to/tree", O_PATH);
   fd = configfs_open(bind, O_CLOEXEC);
   configfs_action(fd, CONFIGFD_SET_FD, "pathfd", NULL, mnt);
   configfs_action(fd, CONFIGFD_SET_FLAG, "ro", NULL, 0);
   configfs_action(fd, CONFIGFD_CMD_RECONFIGURE, NULL, NULL, 0);

And the bind properties will be changed.  You can also pass the "rw"
flag to reset the read only.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
v2: add nodev and noexec mount reconfigurations
---
 fs/Makefile |   2 +-
 fs/bind.c   | 232 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 233 insertions(+), 1 deletion(-)
 create mode 100644 fs/bind.c

diff --git a/fs/Makefile b/fs/Makefile
index de83671ce80d..a7077e5cd60d 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -14,7 +14,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_types.o fs_context.o fs_parser.o fsopen.o \
-		configfd.o
+		configfd.o bind.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
diff --git a/fs/bind.c b/fs/bind.c
new file mode 100644
index 000000000000..eea4e6cd5108
--- /dev/null
+++ b/fs/bind.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Dummy configfd handler for doing context based configuration
+ * on bind mounts
+ *
+ * Copyright (C) James.Bottomley@HansenPartnership.com
+ */
+
+#include <linux/configfd.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/nsproxy.h>
+
+#include "internal.h"
+#include "mount.h"
+
+struct bind_data {
+	bool		ro:1;
+	bool		noexec:1;
+	bool		nosuid:1;
+	bool		nodev:1;
+	bool		detached:1;
+	bool		recursive:1;
+	struct file	*file;
+	struct file	*retfile;
+};
+
+struct bind_data *to_bind_data(const struct configfd_context *cfc)
+{
+	return cfc->data;
+}
+
+static int bind_set_fd(const struct configfd_context *cfc,
+		       struct configfd_param *p)
+{
+	struct bind_data *bd = to_bind_data(cfc);
+	struct path *path;
+
+	if (strcmp(p->key, "pathfd") != 0)
+		return -EINVAL;
+
+	path = &p->file->f_path;
+
+	if (cfc->op == CONFIGFD_CMD_RECONFIGURE &&
+	    path->mnt->mnt_root != path->dentry) {
+		logger_err(cfc->log, "pathfd must be a bind mount");
+		return -EINVAL;
+	}
+	bd->file = p->file;
+	p->file = NULL;	/* we now own */
+	return 0;
+}
+
+static int bind_set_flag(const struct configfd_context *cfc,
+			 struct configfd_param *p)
+{
+	struct bind_data *bd = to_bind_data(cfc);
+
+	if (strcmp(p->key, "ro") == 0) {
+		bd->ro = true;
+	} else if (strcmp(p->key, "rw") == 0) {
+		bd->ro = false;
+	} else if (strcmp(p->key, "nosuid") == 0) {
+		bd->nosuid = true;
+	} else if (strcmp(p->key, "nodev") == 0) {
+		bd->nodev = true;
+	} else if (strcmp(p->key, "noexec") == 0) {
+		bd->noexec = true;
+	} else if (strcmp(p->key, "recursive") == 0 &&
+		   cfc->op == CONFIGFD_CMD_CREATE) {
+		bd->recursive = true;
+	} else if (strcmp(p->key, "detached") == 0 &&
+		   cfc->op == CONFIGFD_CMD_CREATE) {
+		if (!ns_capable(current->nsproxy->mnt_ns->user_ns,
+				CAP_SYS_ADMIN)) {
+			logger_err(cfc->log, "bind set: insufficient permission for detached tree");
+			return -EPERM;
+		}
+		bd->detached = true;
+	} else {
+		logger_err(cfc->log, "bind set: invalid flag %s", p->key);
+		return -EINVAL;
+	}
+	return 0;
+}
+static int bind_set(const struct configfd_context *cfc,
+		    struct configfd_param *p)
+{
+	switch (p->cmd) {
+	case CONFIGFD_SET_FLAG:
+		return bind_set_flag(cfc, p);
+	case CONFIGFD_SET_FD:
+		return bind_set_fd(cfc, p);
+	default:
+		logger_err(cfc->log, "bind only takes a flag or fd argument");
+		return -EINVAL;
+	}
+}
+
+static int bind_get(const struct configfd_context *cfc,
+		    struct configfd_param *p)
+{
+	struct bind_data *bd = to_bind_data(cfc);
+
+	if (strcmp(p->key, "bindfd") != 0 || p->cmd != CONFIGFD_GET_FD)
+		return -EINVAL;
+
+	if (!bd->retfile)
+		return -EINVAL;
+
+	p->file = bd->retfile;
+	bd->retfile = NULL;
+
+	return 0;
+}
+
+static int bind_get_mnt_flags(struct bind_data *bd, int mnt_flags)
+{
+	/* for an unprivileged bind, the ATIME will be locked so keep the same */
+	mnt_flags = mnt_flags & MNT_ATIME_MASK;
+	if (bd->ro)
+		mnt_flags |= MNT_READONLY;
+	if (bd->nosuid)
+		mnt_flags |= MNT_NOSUID;
+	if (bd->nodev)
+		mnt_flags |= MNT_NODEV;
+	if (bd->noexec)
+		mnt_flags |= MNT_NOEXEC;
+
+	return mnt_flags;
+}
+
+static int bind_reconfigure(const struct configfd_context *cfc)
+{
+	struct bind_data *bd = to_bind_data(cfc);
+	unsigned int mnt_flags;
+
+	if (!bd->file) {
+		logger_err(cfc->log, "bind reconfigure: fd must be set");
+		return -EINVAL;
+	}
+	/* for an unprivileged bind, the ATIME will be locked so keep the same */
+	mnt_flags = bd->file->f_path.mnt->mnt_flags & MNT_ATIME_MASK;
+	mnt_flags = bind_get_mnt_flags(bd, mnt_flags);
+
+	return do_reconfigure_mnt(&bd->file->f_path, mnt_flags);
+}
+
+static int bind_create(const struct configfd_context *cfc)
+{
+	struct bind_data *bd = to_bind_data(cfc);
+	struct path *p;
+	struct file *f;
+
+	if (!bd->file) {
+		logger_err(cfc->log, "bind create: fd must be set");
+		return -EINVAL;
+	}
+	if (bd->recursive && !bd->detached) {
+		logger_err(cfc->log, "bind create: recursive cannot be set without detached");
+		return -EINVAL;
+	}
+
+	if ((bd->ro || bd->nosuid || bd->noexec || bd->nodev) &&
+	    !bd->detached) {
+		logger_err(cfc->log, "bind create: to use ro,rw,nosuid or noexec, mount must be detached");
+		return -EINVAL;
+	}
+
+	p = &bd->file->f_path;
+
+	if (bd->detached)
+		f = open_detached_copy(p, bd->recursive);
+	else
+		f = dentry_open(p, O_PATH, current_cred());
+	if (IS_ERR(f))
+		return PTR_ERR(f);
+
+	if (bd->detached) {
+		int mnt_flags = f->f_path.mnt->mnt_flags & MNT_ATIME_MASK;
+
+		mnt_flags = bind_get_mnt_flags(bd, mnt_flags);
+
+		/* since this is a detached copy, we can do without locking */
+		f->f_path.mnt->mnt_flags |= mnt_flags;
+	}
+
+	bd->retfile = f;
+	return 0;
+}
+
+static int bind_act(const struct configfd_context *cfc, unsigned int cmd)
+{
+	switch (cmd) {
+	case CONFIGFD_CMD_RECONFIGURE:
+		return bind_reconfigure(cfc);
+	case CONFIGFD_CMD_CREATE:
+		return bind_create(cfc);
+	default:
+		logger_err(cfc->log, "bind only responds to reconfigure or create actions");
+		return -EINVAL;
+	}
+}
+
+static void bind_free(const struct configfd_context *cfc)
+{
+	struct bind_data *bd = to_bind_data(cfc);
+
+	if (bd->file)
+		fput(bd->file);
+}
+
+static struct configfd_ops bind_type_ops = {
+	.free = bind_free,
+	.get = bind_get,
+	.set = bind_set,
+	.act = bind_act,
+};
+
+static struct configfd_type bind_type = {
+	.name		= "bind",
+	.ops		= &bind_type_ops,
+	.data_size	= sizeof(struct bind_data),
+};
+
+static int __init bind_setup(void)
+{
+	configfd_type_register(&bind_type);
+
+	return 0;
+}
+fs_initcall(bind_setup);
-- 
2.16.4

