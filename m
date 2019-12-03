Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77C0410F46D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 02:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfLCBPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 20:15:36 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51532 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbfLCBPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 20:15:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6A4358EE180;
        Mon,  2 Dec 2019 17:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575335736;
        bh=FLjq0K5fC33XstOnt8A0wqQ3SSh7uD8GV0njjaCWdKk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eZUKwk5Pn6zbToPq7WB9wsA7DAaCuc4hEJmhdQe19/e+aWmDzds4Bgcb/xw99T9oG
         UDSCxuf/TokXnhWCmHi18dadAYoFcrtQPv+JRNUtK5n6mjGOFYwGupIIwkuMYjyQC+
         3cxkjN6FMlnvq8G225lM7nFaz6x5qqd4QdGfF0A8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Pq85qty6NgKo; Mon,  2 Dec 2019 17:15:36 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E8F168EE11D;
        Mon,  2 Dec 2019 17:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575335736;
        bh=FLjq0K5fC33XstOnt8A0wqQ3SSh7uD8GV0njjaCWdKk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eZUKwk5Pn6zbToPq7WB9wsA7DAaCuc4hEJmhdQe19/e+aWmDzds4Bgcb/xw99T9oG
         UDSCxuf/TokXnhWCmHi18dadAYoFcrtQPv+JRNUtK5n6mjGOFYwGupIIwkuMYjyQC+
         3cxkjN6FMlnvq8G225lM7nFaz6x5qqd4QdGfF0A8=
Message-ID: <1575335735.24227.28.camel@HansenPartnership.com>
Subject: [PATCH 2/2] fs: expose shifting bind mount to userspace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 02 Dec 2019 17:15:35 -0800
In-Reply-To: <1575335637.24227.26.camel@HansenPartnership.com>
References: <1575335637.24227.26.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

The way an admin marks a mount is:

pathfd = open("/path/to/shift", O_PATH);
fd = configfd_open("bind", O_CLOEXEC);
configfd_action(fd, CONFIGFD_SET_FD, "pathfd", NULL, pathfd);
configfd_action(fd, CONFIGFD_SET_FLAG, "allow-shift", NULL, 0);
configfd_action(fd, CONFIGFD_SET_FLAG, "detached", NULL, 0);
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
 fs/bind.c           | 35 +++++++++++++++++++++++++++++++++++
 fs/mount.h          |  2 ++
 fs/namespace.c      |  1 +
 fs/proc_namespace.c |  4 ++++
 4 files changed, 42 insertions(+)

diff --git a/fs/bind.c b/fs/bind.c
index eea4e6cd5108..6b4668041248 100644
--- a/fs/bind.c
+++ b/fs/bind.c
@@ -21,6 +21,8 @@ struct bind_data {
 	bool		nodev:1;
 	bool		detached:1;
 	bool		recursive:1;
+	bool		shift:1;
+	bool		allow_shift:1;
 	struct file	*file;
 	struct file	*retfile;
 };
@@ -66,6 +68,25 @@ static int bind_set_flag(const struct configfd_context *cfc,
 		bd->nodev = true;
 	} else if (strcmp(p->key, "noexec") == 0) {
 		bd->noexec = true;
+	} else if (strcmp(p->key, "shift") == 0) {
+		struct mount *m;
+
+		if (!bd->file) {
+			logger_err(cfc->log, "can't shift without setting pathfd");
+			return -EINVAL;
+		}
+		m = real_mount(bd->file->f_path.mnt);
+		if (!m->allow_shift) {
+			logger_err(cfc->log, "pathfd doesn't allow shifting");
+			return -EINVAL;
+		}
+		bd->shift = true;
+	} else if (strcmp(p->key, "allow-shift") == 0) {
+		if (!capable(CAP_SYS_ADMIN)) {
+			logger_err(cfc->log, "must be root to set allow-shift");
+			return -EPERM;
+		}
+		bd->allow_shift = true;
 	} else if (strcmp(p->key, "recursive") == 0 &&
 		   cfc->op == CONFIGFD_CMD_CREATE) {
 		bd->recursive = true;
@@ -126,6 +147,8 @@ static int bind_get_mnt_flags(struct bind_data *bd, int mnt_flags)
 		mnt_flags |= MNT_NODEV;
 	if (bd->noexec)
 		mnt_flags |= MNT_NOEXEC;
+	if (bd->shift)
+		mnt_flags |= MNT_SHIFT;
 
 	return mnt_flags;
 }
@@ -143,6 +166,13 @@ static int bind_reconfigure(const struct configfd_context *cfc)
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
 
@@ -183,6 +213,11 @@ static int bind_create(const struct configfd_context *cfc)
 
 		/* since this is a detached copy, we can do without locking */
 		f->f_path.mnt->mnt_flags |= mnt_flags;
+		if (bd->allow_shift) {
+			struct mount *m = real_mount(f->f_path.mnt);
+
+			m->allow_shift = true;
+		}
 	}
 
 	bd->retfile = f;
diff --git a/fs/mount.h b/fs/mount.h
index 711a4093e475..14c76eccb89f 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -72,6 +72,8 @@ struct mount {
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
 	struct hlist_head mnt_stuck_children;
+	/* shifting bind moutn parameters */
+	bool allow_shift:1;
 } __randomize_layout;
 
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
diff --git a/fs/namespace.c b/fs/namespace.c
index 9dcbafe62e4e..7fe3be8fca01 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1038,6 +1038,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 
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

