Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D809C17A7A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfEHNWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 09:22:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34962 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfEHNWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 09:22:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id w12so13749386wrp.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2019 06:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ohE2xbTpUYzLEqPlShDMeZUkRblKnapcCYi2034pYU=;
        b=NQIlrTy4z9jZyQQXlcz/rN7Lqf9MmMk1JIr30W0TLNui5ub3oP7KGK7nJSFBZtGmfF
         IVLv8rfHGiq31nZDgot2yHyJQgJko4j+dUo9txR4DV7SNJZwzcuWuBHnB04WOrFYYvZH
         7s8iy607QyK28ukYrHNmH+uAnoZFxG2qfN9ZTryqOoSsj453vgDHaIYuF90cVxPadMAK
         yKtwq1K7oFvuvWZS9cr0B0bPpp4ABSG3tXffQtg4b5xflnoDo/oiRdTrshrYupRNUtDH
         MjD1yZn77vIK7rObsU1zzNPfZ7Rx3Ghxl7ueOoLFhJKVWD5SkOQSOJRRRkl0Hh6kaPL/
         ekag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ohE2xbTpUYzLEqPlShDMeZUkRblKnapcCYi2034pYU=;
        b=Z+px+IVROdbBmGyEe9FjH5n+L+EHIzf481xcviyT+2zbwgKsOoNM5iGrKNs3hm2I+/
         dYwDRlzeTa6TxZmGc5m5vvSyww78A50ml+zLdJkk2lmC6bKnC1mlQJG+nfxoQr5eZSMZ
         uAQN6/BYDloslcSWe0cozotujYrzA//w73fb1I0dK7fDeSNwrEjga3ZGXrNsvXX8d+J3
         fbB787AFBwqj6AebOWYkUw7WHrsgQu2Kt3aJjS/G8p5J1bj0/fKSPnOiHyMJw+y1JxoJ
         SRPEikCy2cnuDcTIBRAQ7X46vPVVU5o7ftp/8FKUeNRpZcLfzEwVfyKAAZcwoHMw7+tT
         fkOQ==
X-Gm-Message-State: APjAAAXfazb7XKFNNtqL6VIok8+yGx8vAxfRhROiFVZhWyY4Z4gblQoj
        zarGuuVnhDnRO6biVPz5ztyRUipQI8xrBw==
X-Google-Smtp-Source: APXvYqxHkHuqm9N7LvcRDGJ3bK0VMl7t9TXHcMXpUw9vdDb3HAQ6mBgXXpIkglR1aEboyylnKqnCOQ==
X-Received: by 2002:adf:df88:: with SMTP id z8mr26199414wrl.209.1557321749191;
        Wed, 08 May 2019 06:22:29 -0700 (PDT)
Received: from localhost.localdomain (v22018046084765073.goodsrv.de. [185.183.158.195])
        by smtp.gmail.com with ESMTPSA id o4sm3144193wmo.20.2019.05.08.06.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 06:22:28 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH] fs: make all new mount api fds cloexec by default
Date:   Wed,  8 May 2019 15:22:18 +0200
Message-Id: <20190508132218.3617-1-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This makes file descriptors returned from the new syscalls of the new mount
api cloexec by default.

From a userspace perspective it is rarely the case that fds are supposed to
be inherited across exec. In fact, most of the time userspace either needs
to remember to pass the <SPECIFIC>_CLOEXEC flag along or needs to invoke
fcntl() on fd to prevent accidentally leaking the fd. This is a much bigger
issue than accidentally forgetting to remove the cloexec flag to inherit
the fd.
For old file descriptor types we can't break userspace but new ones should
- whenever reasonable - be cloexec by default. Examples of this policy are
the new seccomp notify fds and also pidfds. If userspace wants to inherit
fds across exec they can remove the O_CLOEXEC flag and need to opt in to
inheritance explicitly.

Note, this also has the advantage that we can get rid of all the special
flags per file descriptor type for the new mount api. In total this lets us
remove 4 flags:
- FSMOUNT_CLOEXEC
- FSOPEN_CLOEXEC
- FSPICK_CLOEXEC
- OPEN_TREE_CLOEXEC

Ideally, this would be changed before rc1 is out since this would
otherwise a UAPI break.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 fs/fsopen.c                | 13 ++++++-------
 fs/namespace.c             | 11 ++++-------
 include/uapi/linux/mount.h | 18 +++---------------
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
index 3357c3d65475..ab8cea5d745f 100644
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
+	fd = get_unused_fd_flags(flags | O_CLOEXEC);
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
+	ret = get_unused_fd_flags(flags | O_CLOEXEC);
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
-- 
2.21.0

