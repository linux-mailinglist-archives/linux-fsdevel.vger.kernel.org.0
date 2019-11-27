Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDCA10BF90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 22:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfK0UiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 15:38:10 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57298 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728683AbfK0UiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:38:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 492818EE133;
        Wed, 27 Nov 2019 12:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574887086;
        bh=QIZNCMB80ftV5d1UinGrc84GdeVRvJxclpCio76u7Fs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MqMylRWuTLs5KGzMrrmTGLUmshusbHt/kUF3atlBjUcIf3/YYcO+MncpS9pfEeQkm
         gf0jBq9aA1A46fXJxdm3vnfhS64RTu1vsPdeyikmFMrWPoRHR+2JdLRpK3hh/4LNkV
         DuN98tcYqy4QX//1bh8qQbfifymZc/q/m9PM4950=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zK_TOr3ZYZN7; Wed, 27 Nov 2019 12:38:06 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DA8428EE130;
        Wed, 27 Nov 2019 12:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574887086;
        bh=QIZNCMB80ftV5d1UinGrc84GdeVRvJxclpCio76u7Fs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MqMylRWuTLs5KGzMrrmTGLUmshusbHt/kUF3atlBjUcIf3/YYcO+MncpS9pfEeQkm
         gf0jBq9aA1A46fXJxdm3vnfhS64RTu1vsPdeyikmFMrWPoRHR+2JdLRpK3hh/4LNkV
         DuN98tcYqy4QX//1bh8qQbfifymZc/q/m9PM4950=
Message-ID: <1574887085.21593.13.camel@HansenPartnership.com>
Subject: [RFC 6/6] fs: bind: add configfs type for bind mounts
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 27 Nov 2019 12:38:05 -0800
In-Reply-To: <1574886778.21593.7.camel@HansenPartnership.com>
References: <1574295100.17153.25.camel@HansenPartnership.com>
         <17268.1574323839@warthog.procyon.org.uk>
         <1574352920.3277.18.camel@HansenPartnership.com>
         <1574886778.21593.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
 fs/Makefile |   2 +-
 fs/bind.c   | 193 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 fs/bind.c

diff --git a/fs/Makefile b/fs/Makefile
index 569563f6c0d5..c676ca15c644 100644
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
index 000000000000..905572c70260
--- /dev/null
+++ b/fs/bind.c
@@ -0,0 +1,193 @@
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
+	if (strcmp(p->key, "ro") == 0 &&
+	    cfc->op == CONFIGFD_CMD_RECONFIGURE) {
+		bd->ro = true;
+	} else if (strcmp(p->key, "rw") == 0 &&
+		   cfc->op == CONFIGFD_CMD_RECONFIGURE) {
+		bd->ro = false;
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
+static int bind_reconfigure(const struct configfd_context *cfc)
+{
+	struct bind_data *bd = to_bind_data(cfc);
+	unsigned int mnt_flags = 0;
+
+	if (!bd->file) {
+		logger_err(cfc->log, "bind reconfigure: fd must be set");
+		return -EINVAL;
+	}
+	if (bd->ro)
+		mnt_flags |= MNT_READONLY;
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
+	p = &bd->file->f_path;
+
+	if (bd->detached)
+		f = open_detached_copy(p, bd->recursive);
+	else
+		f = dentry_open(p, O_PATH, current_cred());
+	if (IS_ERR(f))
+		return PTR_ERR(f);
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

