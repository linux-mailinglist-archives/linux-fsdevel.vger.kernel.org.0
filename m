Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D4161C8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 21:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgBQU7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 15:59:36 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37908 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727300AbgBQU7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 15:59:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 614348EE218;
        Mon, 17 Feb 2020 12:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581973175;
        bh=oOI+sLNi+8MOJdLASIqHxh9N3SDyW7HWx2KX5RZprbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQSlVDQOYtYdaMioisaXRS0q0Te0CzgQ5P/3pLjNFG4eqnhYznDu1ur4deLaCTPjh
         6z4B8616X7jPBB+Tepv6vA74h1SV8VZ8q3NKvJWZzWTVdhEas0FXp5gN56TSRR0rjs
         01zL60h2GRp8ZcIsxm6+0ve9yUpRiO/d6IatdCKM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Tpcxp99wljSs; Mon, 17 Feb 2020 12:59:35 -0800 (PST)
Received: from jarvis.lan (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 682788EE0F5;
        Mon, 17 Feb 2020 12:59:34 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-unionfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tycho Andersen <tycho@tycho.ws>,
        containers@lists.linux-foundation.org
Subject: [PATCH v3 3/3] fs: expose shifting bind mount to userspace
Date:   Mon, 17 Feb 2020 12:53:07 -0800
Message-Id: <20200217205307.32256-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
References: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This capability is exposed currently through the proposed new bind
API. To mark a mount for shifting, you add the allow-shift flag to the
properties, either by a reconfigure or a rebind.  Only real root on
the system can do this.  Once this is done, admin in a user namespace
(i.e. an unprivileged user) can take that mount point and bind it with
a shift in effect.

This patch has the ability to shift image uids built in.  The way you
do this is create a usernamespace where the fake root of the image is
seen by the interior uid as zero.  Then pass this namespace in using
the "ns" option of the bind.  One of the key design criteria is that
the mounted image never appears at exterior uid zero, so the image
shift isn't activated until the whole shift is applied.

The way an admin marks a mount is:

pathfd = open("/path/to/shift", O_PATH);
fd = configfd_open("bind", O_CLOEXEC);
configfd_action(fd, CONFIGFD_SET_FD, "pathfd", NULL, pathfd);
configfd_action(fd, CONFIGFD_SET_FLAG, "allow-shift", NULL, 0);
configfd_action(fd, CONFIGFD_SET_FLAG, "detached", NULL, 0);
/* optionally apply a shift to the base image */
nsfd = open("/proc/567/ns/user", O_RDONLY);  /* note: not O_PATH */
configfd_action(fd, CONFIGFD_SET_FD, "ns", NULL, nsfd);
/* then create the detached object */
configfd_action(fd, CONFIGFD_CMD_CREATE, NULL, NULL, 0);
configfd_action(fd, CONFIGFD_GET_FD, "bindfd", &bindfd, O_CLOEXEC);

move_mount(bindfd, "", AT_FDCWD, "/path/to/allow", MOVE_MOUNT_F_EMPTY_PATH);

Technically /path/to/shift and /path/to/allow can be the same, which
basically installs a mnt at the path that allows onward traversal.

Then any mount namespace in a user namespace can do:

pathfd = open("/path/to/allow", O_PATH);
fd = configfd_open("bind", O_CLOEXEC);
configfd_action(fd, CONFIGFD_SET_FD, "pathfd", NULL, pathfd);
configfd_action(fd, CONFIGFD_SET_FLAG, "shift", NULL, 0);
configfd_action(fd, CONFIGFD_SET_FLAG, "detached", NULL, 0);
configfd_action(fd, CONFIGFD_CMD_CREATE, NULL, NULL, 0);
configfd_action(fd, CONFIGFD_GET_FD, "bindfd", &bindfd, O_CLOEXEC);

move_mount(bindfd, "", AT_FDCWD, "/path/to/mount", MOVE_MOUNT_F_EMPTY_PATH);

And /path/to/mount will have the uid/gid shifting bind mount installed.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v3: added ns option to do base image shifting
---
 fs/bind.c           | 105 +++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/mount.h          |   2 +
 fs/namespace.c      |   1 +
 fs/proc_namespace.c |   4 ++
 4 files changed, 103 insertions(+), 9 deletions(-)

diff --git a/fs/bind.c b/fs/bind.c
index c1dedef40169..0cb40d3d4289 100644
--- a/fs/bind.c
+++ b/fs/bind.c
@@ -6,23 +6,29 @@
  */
 
 #include <linux/configfd.h>
+#include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/nsproxy.h>
+#include <linux/proc_ns.h>
+#include <linux/user_namespace.h>
 
 #include "internal.h"
 #include "mount.h"
 
 struct bind_data {
-	bool		ro:1;
-	bool		noexec:1;
-	bool		nosuid:1;
-	bool		nodev:1;
-	bool		detached:1;
-	bool		recursive:1;
-	struct file	*file;
-	struct file	*retfile;
+	bool			ro:1;
+	bool			noexec:1;
+	bool			nosuid:1;
+	bool			nodev:1;
+	bool			detached:1;
+	bool			recursive:1;
+	bool			shift:1;
+	bool			allow_shift:1;
+	struct file		*file;
+	struct file		*retfile;
+	struct user_namespace	*userns;
 };
 
 struct bind_data *to_bind_data(const struct configfd_context *cfc)
@@ -30,13 +36,54 @@ struct bind_data *to_bind_data(const struct configfd_context *cfc)
 	return cfc->data;
 }
 
+static int match_file(const void *p, struct file *file, unsigned int fd)
+{
+	if (p == file)
+		return fd + 1;
+	return 0;
+}
+
+static int bind_set_userns(const struct configfd_context *cfc,
+			   struct configfd_param *p)
+{
+	struct bind_data *bd = to_bind_data(cfc);
+	int fd;
+	struct file *file;
+	struct ns_common *ns;
+
+	if (!bd->allow_shift) {
+		plogger_err(&cfc->log, "ns may only be specified if allow_shift is also");
+		return -EINVAL;
+	}
+
+	/* huge fuss here because nsfs matches on fd not file */
+	fd = iterate_fd(current->files, 0, match_file, p->file);
+	if (fd == 0)
+		return -EINVAL;
+	fd--;
+	file = proc_ns_fget(fd);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ns = get_proc_ns(file_inode(file));
+	if (ns->ops->type != CLONE_NEWUSER)
+		return -EINVAL;
+
+	bd->userns = get_user_ns(container_of(ns, struct user_namespace, ns));
+
+	/* note we haven't consumed p->file so configfd will release it */
+	return 0;
+}
+
 static int bind_set_fd(const struct configfd_context *cfc,
 		       struct configfd_param *p)
 {
 	struct bind_data *bd = to_bind_data(cfc);
 	struct path *path;
 
-	if (strcmp(p->key, "pathfd") != 0)
+	if (strcmp(p->key, "ns") == 0)
+		return bind_set_userns(cfc, p);
+	else if (strcmp(p->key, "pathfd") != 0)
 		return -EINVAL;
 
 	path = &p->file->f_path;
@@ -66,6 +113,25 @@ static int bind_set_flag(const struct configfd_context *cfc,
 		bd->nodev = true;
 	} else if (strcmp(p->key, "noexec") == 0) {
 		bd->noexec = true;
+	} else if (strcmp(p->key, "shift") == 0) {
+		struct mount *m;
+
+		if (!bd->file) {
+			plogger_err(&cfc->log, "can't shift without setting pathfd");
+			return -EINVAL;
+		}
+		m = real_mount(bd->file->f_path.mnt);
+		if (!m->allow_shift) {
+			plogger_err(&cfc->log, "pathfd doesn't allow shifting");
+			return -EINVAL;
+		}
+		bd->shift = true;
+	} else if (strcmp(p->key, "allow-shift") == 0) {
+		if (!capable(CAP_SYS_ADMIN)) {
+			plogger_err(&cfc->log, "must be root to set allow-shift");
+			return -EPERM;
+		}
+		bd->allow_shift = true;
 	} else if (strcmp(p->key, "recursive") == 0 &&
 		   cfc->op == CONFIGFD_CMD_CREATE) {
 		bd->recursive = true;
@@ -126,6 +192,8 @@ static int bind_get_mnt_flags(struct bind_data *bd, int mnt_flags)
 		mnt_flags |= MNT_NODEV;
 	if (bd->noexec)
 		mnt_flags |= MNT_NOEXEC;
+	if (bd->shift)
+		mnt_flags |= MNT_SHIFT;
 
 	return mnt_flags;
 }
@@ -143,6 +211,13 @@ static int bind_reconfigure(const struct configfd_context *cfc)
 	mnt_flags = bd->file->f_path.mnt->mnt_flags & MNT_ATIME_MASK;
 	mnt_flags = bind_get_mnt_flags(bd, mnt_flags);
 
+	if (bd->allow_shift) {
+		struct mount *m = real_mount(bd->file->f_path.mnt);
+
+		/* FIXME: this should be set with the reconfigure locking */
+		m->allow_shift = true;
+	}
+
 	return do_reconfigure_mnt(&bd->file->f_path, mnt_flags);
 }
 
@@ -178,11 +253,21 @@ static int bind_create(const struct configfd_context *cfc)
 
 	if (bd->detached) {
 		int mnt_flags = f->f_path.mnt->mnt_flags & MNT_ATIME_MASK;
+		struct mount *m = real_mount(f->f_path.mnt);
 
 		mnt_flags = bind_get_mnt_flags(bd, mnt_flags);
 
 		/* since this is a detached copy, we can do without locking */
 		f->f_path.mnt->mnt_flags |= mnt_flags;
+
+		if (bd->allow_shift)
+			m->allow_shift = true;
+
+		if (bd->userns) {
+			put_user_ns(m->mnt_userns);
+			m->mnt_userns = bd->userns;
+			bd->userns = NULL; /* transfer the reference */
+		}
 	}
 
 	bd->retfile = f;
@@ -208,6 +293,8 @@ static void bind_free(const struct configfd_context *cfc)
 
 	if (bd->file)
 		fput(bd->file);
+	if (bd->userns)
+		put_user_ns(bd->userns);
 }
 
 static struct configfd_ops bind_type_ops = {
diff --git a/fs/mount.h b/fs/mount.h
index c3bfc6ced4c7..157e86cf9930 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -72,6 +72,8 @@ struct mount {
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
 	struct hlist_head mnt_stuck_children;
+	/* shifting bind mount parameters */
+	bool allow_shift:1;
 	struct user_namespace *mnt_userns; /* mapping for underlying mount uid/gid */
 } __randomize_layout;
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 4720647588ab..75e4df4ddf54 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1040,6 +1040,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 
 	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
 	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
+	mnt->allow_shift = old->allow_shift;
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_sb = sb;
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 273ee82d8aa9..bdf8d23cf42e 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -70,14 +70,18 @@ static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
 		{ MNT_NOATIME, ",noatime" },
 		{ MNT_NODIRATIME, ",nodiratime" },
 		{ MNT_RELATIME, ",relatime" },
+		{ MNT_SHIFT, ",shift" },
 		{ 0, NULL }
 	};
 	const struct proc_fs_info *fs_infop;
+	struct mount *rm = real_mount(mnt);
 
 	for (fs_infop = mnt_info; fs_infop->flag; fs_infop++) {
 		if (mnt->mnt_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
 	}
+	if (rm->allow_shift)
+		seq_puts(m, ",allow-shift");
 }
 
 static inline void mangle(struct seq_file *m, const char *s)
-- 
2.16.4

