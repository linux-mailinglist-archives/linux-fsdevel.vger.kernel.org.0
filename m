Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D7A2065B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfEPLwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 07:52:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfEPLwP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 07:52:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0393C6411E;
        Thu, 16 May 2019 11:52:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 839C67855A;
        Thu, 16 May 2019 11:52:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/4] uapi,
 fs: make all new mount api fds cloexec by default [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        christian@brauner.io, arnd@arndb.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 16 May 2019 12:52:11 +0100
Message-ID: <155800753177.4037.13590571364010928652.stgit@warthog.procyon.org.uk>
In-Reply-To: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 16 May 2019 11:52:15 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian@brauner.io>

This makes all file descriptors returned from new syscalls of the new mount
api cloexec by default.

>From a userspace perspective it is rarely the case that fds are supposed to
be inherited across exec. Having them not cloexec by default forces
userspace to remember to pass the <SPECIFIC>_CLOEXEC flag along or to
invoke fcntl() on the fd to prevent leaking it. And leaking the fd is a
much bigger issue than forgetting to remove the cloexec flag and failing to
inherit the fd.
For old fd types we can't break userspace. But for new ones we should
whenever reasonable make them cloexec by default (Examples of this policy
are the new seccomp notify fds and also pidfds.). If userspace wants to
inherit fds across exec they can remove the O_CLOEXEC flag and so opt in to
inheritance explicitly.

This patch also has the advantage that we can get rid of all the special
flags per file descriptor type for the new mount api. In total this lets us
remove 4 flags:
- FSMOUNT_CLOEXEC
- FSOPEN_CLOEXEC
- FSPICK_CLOEXEC
- OPEN_TREE_CLOEXEC

Signed-off-by: Christian Brauner <christian@brauner.io>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsopen.c                |   13 ++++++-------
 fs/namespace.c             |   11 ++++-------
 include/uapi/linux/mount.h |   18 +++---------------
 3 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 3bb9c0c8cbcc..a38fa8c616cf 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -88,12 +88,12 @@ const struct file_operations fscontext_fops = {
 /*
  * Attach a filesystem context to a file and an fd.
  */
-static int fscontext_create_fd(struct fs_context *fc, unsigned int o_flags)
+static int fscontext_create_fd(struct fs_context *fc)
 {
 	int fd;
 
 	fd = anon_inode_getfd("fscontext", &fscontext_fops, fc,
-			      O_RDWR | o_flags);
+			      O_RDWR | O_CLOEXEC);
 	if (fd < 0)
 		put_fs_context(fc);
 	return fd;
@@ -126,7 +126,7 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (flags & ~FSOPEN_CLOEXEC)
+	if (flags)
 		return -EINVAL;
 
 	fs_name = strndup_user(_fs_name, PAGE_SIZE);
@@ -149,7 +149,7 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 	if (ret < 0)
 		goto err_fc;
 
-	return fscontext_create_fd(fc, flags & FSOPEN_CLOEXEC ? O_CLOEXEC : 0);
+	return fscontext_create_fd(fc);
 
 err_fc:
 	put_fs_context(fc);
@@ -169,8 +169,7 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if ((flags & ~(FSPICK_CLOEXEC |
-		       FSPICK_SYMLINK_NOFOLLOW |
+	if ((flags & ~(FSPICK_SYMLINK_NOFOLLOW |
 		       FSPICK_NO_AUTOMOUNT |
 		       FSPICK_EMPTY_PATH)) != 0)
 		return -EINVAL;
@@ -203,7 +202,7 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 		goto err_fc;
 
 	path_put(&target);
-	return fscontext_create_fd(fc, flags & FSPICK_CLOEXEC ? O_CLOEXEC : 0);
+	return fscontext_create_fd(fc);
 
 err_fc:
 	put_fs_context(fc);
diff --git a/fs/namespace.c b/fs/namespace.c
index ffb13f0562b0..3d14e83787b1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2369,11 +2369,8 @@ SYSCALL_DEFINE3(open_tree, int, dfd, const char *, filename, unsigned, flags)
 	int error;
 	int fd;
 
-	BUILD_BUG_ON(OPEN_TREE_CLOEXEC != O_CLOEXEC);
-
 	if (flags & ~(AT_EMPTY_PATH | AT_NO_AUTOMOUNT | AT_RECURSIVE |
-		      AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLONE |
-		      OPEN_TREE_CLOEXEC))
+		      AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLONE))
 		return -EINVAL;
 
 	if ((flags & (AT_RECURSIVE | OPEN_TREE_CLONE)) == AT_RECURSIVE)
@@ -2389,7 +2386,7 @@ SYSCALL_DEFINE3(open_tree, int, dfd, const char *, filename, unsigned, flags)
 	if (detached && !may_mount())
 		return -EPERM;
 
-	fd = get_unused_fd_flags(flags & O_CLOEXEC);
+	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0)
 		return fd;
 
@@ -3352,7 +3349,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	if (!may_mount())
 		return -EPERM;
 
-	if ((flags & ~(FSMOUNT_CLOEXEC)) != 0)
+	if (flags)
 		return -EINVAL;
 
 	if (attr_flags & ~(MOUNT_ATTR_RDONLY |
@@ -3457,7 +3454,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	}
 	file->f_mode |= FMODE_NEED_UNMOUNT;
 
-	ret = get_unused_fd_flags((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC : 0);
+	ret = get_unused_fd_flags(O_CLOEXEC);
 	if (ret >= 0)
 		fd_install(ret, file);
 	else
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 96a0240f23fe..c688e4ac843b 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -59,7 +59,6 @@
  * open_tree() flags.
  */
 #define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
-#define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
 
 /*
  * move_mount() flags.
@@ -72,18 +71,12 @@
 #define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
 #define MOVE_MOUNT__MASK		0x00000077
 
-/*
- * fsopen() flags.
- */
-#define FSOPEN_CLOEXEC		0x00000001
-
 /*
  * fspick() flags.
  */
-#define FSPICK_CLOEXEC		0x00000001
-#define FSPICK_SYMLINK_NOFOLLOW	0x00000002
-#define FSPICK_NO_AUTOMOUNT	0x00000004
-#define FSPICK_EMPTY_PATH	0x00000008
+#define FSPICK_SYMLINK_NOFOLLOW	0x00000001
+#define FSPICK_NO_AUTOMOUNT	0x00000002
+#define FSPICK_EMPTY_PATH	0x00000004
 
 /*
  * The type of fsconfig() call made.
@@ -99,11 +92,6 @@ enum fsconfig_command {
 	FSCONFIG_CMD_RECONFIGURE = 7,	/* Invoke superblock reconfiguration */
 };
 
-/*
- * fsmount() flags.
- */
-#define FSMOUNT_CLOEXEC		0x00000001
-
 /*
  * Mount attributes.
  */

