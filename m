Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5774814E697
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 01:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgAaA2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 19:28:12 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:39132 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgAaA2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 19:28:12 -0500
Received: by mail-il1-f193.google.com with SMTP id f70so4704619ill.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2020 16:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ROJG3uYhVm/nO8xbwsGieRNbZvdCR5sey5l7a+PU2Q=;
        b=TjAL1AJjI9BnZIshIxhWxMDY1DFedMYxFM1FuouAtJ2A0sB6NH1j8jIk1s+ojTWpyv
         C6s2/7FJTM4u9/vFLHr+Mh1aUmIj5nF0iVUK0FIrKa+TdFKkJ7gOZwc6nMfTGTMB8v4c
         yVpCpjJ65nHijq2yI29W7o9puxiTQnEP38PdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ROJG3uYhVm/nO8xbwsGieRNbZvdCR5sey5l7a+PU2Q=;
        b=QPqy9VvKAWUFBmuchfURGP6O02SeRdUTky/Cir31/OPqLVpTOVJzUsv3JtkY4xeHuy
         g5iY/sMF/Nq9K0GxjzYrHYMeZQVAqGF+o5s/WPJawcfFd2SYj/b7eXXtGYmSwcM8T2fs
         36PoHu8GaVVM+gF7Eot/fe2kaJB1v4X9ZOF5Av1SnDUHC/Dqxz9gY+979He0nPznEZAZ
         MLW/PfP+9J/kBmHul4FMVRW481Eq32C/6EKwf0Dvm1iZcFc9gLpCIZWxZq2A11ljaBXc
         +jgQkCiTzZTF7gpcpN+qm7YgnINzVOYxIrDZZzQOxWqrIRZp+5Y9cfDa3RmAAjDp18A8
         E8bg==
X-Gm-Message-State: APjAAAU79eTM/mIs4ruM3lbeonZfpltGKFeMiyTaXyzSrU1j2MxYWE7t
        QXId987YwMkbtePKpasbD4ZDXA==
X-Google-Smtp-Source: APXvYqzlog8EP9AhoM70a7aP2EyToH/eoXoIkRPpgv5HccvB3Ewx1sJYYURkSax3vGrEXphg4ornGA==
X-Received: by 2002:a92:5d16:: with SMTP id r22mr7199743ilb.230.1580430490830;
        Thu, 30 Jan 2020 16:28:10 -0800 (PST)
Received: from localhost ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id b12sm2456075iln.62.2020.01.30.16.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 16:28:10 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mattias Nissler <mnissler@chromium.org>,
        Benjamin Gordon <bmgordon@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Raul Rangel <rrangel@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4] Add a "nosymfollow" mount option.
Date:   Thu, 30 Jan 2020 17:27:50 -0700
Message-Id: <20200131002750.257358-1-zwisler@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mattias Nissler <mnissler@chromium.org>

For mounts that have the new "nosymfollow" option, don't follow
symlinks when resolving paths. The new option is similar in spirit to
the existing "nodev", "noexec", and "nosuid" options. Various BSD
variants have been supporting the "nosymfollow" mount option for a
long time with equivalent implementations.

Note that symlinks may still be created on file systems mounted with
the "nosymfollow" option present. readlink() remains functional, so
user space code that is aware of symlinks can still choose to follow
them explicitly.

Setting the "nosymfollow" mount option helps prevent privileged
writers from modifying files unintentionally in case there is an
unexpected link along the accessed path. The "nosymfollow" option is
thus useful as a defensive measure for systems that need to deal with
untrusted file systems in privileged contexts.

Signed-off-by: Mattias Nissler <mnissler@chromium.org>
Signed-off-by: Ross Zwisler <zwisler@google.com>

---

This was previously posted a few years ago:

v2: https://patchwork.kernel.org/patch/9384153/
v3: https://lore.kernel.org/patchwork/patch/736423/

The problem that this patch solves still exists.  I rebased and retested
this patch against kernel v5.5.

FreeBSD solves this with an equivalent flag:

https://github.com/freebsd/freebsd/blob/master/sys/kern/vfs_lookup.c#L1040
https://www.freebsd.org/cgi/man.cgi?mount(8)

And ChromeOS has been solving this with 200+ lines of LSM code:

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1334029/

This kernel patch is much shorter (13 lines!) and IMO is a much cleaner
solution.  Let's reconsider getting this merged.

There is some follow-up work that will need to be done:
 - Upstream support for the flag to util-linux.  Example CL that I've
   been testing with:
   https://github.com/rzwisler/util-linux/commit/e3b8e365492e8cc87c750c4946eb013a486978d2
 - Update man pages for mount(8) and mount(2).
 - Update man page for statfs(2).
 - Add this option to the new fsmount(2) syscall:
   https://lwn.net/Articles/802096/

I'm happy to take care of these, but wanted to get feedback on the
kernel patch first.
---
 fs/namei.c                 | 3 +++
 fs/namespace.c             | 2 ++
 fs/proc_namespace.c        | 1 +
 fs/statfs.c                | 2 ++
 include/linux/mount.h      | 3 ++-
 include/linux/statfs.h     | 1 +
 include/uapi/linux/mount.h | 1 +
 7 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4fb61e0754ed6..f198a0ea9b1c0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1059,6 +1059,9 @@ const char *get_link(struct nameidata *nd)
 		touch_atime(&last->link);
 	}
 
+	if (nd->path.mnt->mnt_flags & MNT_NOSYMFOLLOW)
+		return ERR_PTR(-EACCES);
+
 	error = security_inode_follow_link(dentry, inode,
 					   nd->flags & LOOKUP_RCU);
 	if (unlikely(error))
diff --git a/fs/namespace.c b/fs/namespace.c
index 5e1bf611a9eb6..240421e02940d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3109,6 +3109,8 @@ long do_mount(const char *dev_name, const char __user *dir_name,
 		mnt_flags &= ~(MNT_RELATIME | MNT_NOATIME);
 	if (flags & MS_RDONLY)
 		mnt_flags |= MNT_READONLY;
+	if (flags & MS_NOSYMFOLLOW)
+		mnt_flags |= MNT_NOSYMFOLLOW;
 
 	/* The default atime for remount is preservation */
 	if ((flags & MS_REMOUNT) &&
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 273ee82d8aa97..91a552f617406 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -70,6 +70,7 @@ static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
 		{ MNT_NOATIME, ",noatime" },
 		{ MNT_NODIRATIME, ",nodiratime" },
 		{ MNT_RELATIME, ",relatime" },
+		{ MNT_NOSYMFOLLOW, ",nosymfollow" },
 		{ 0, NULL }
 	};
 	const struct proc_fs_info *fs_infop;
diff --git a/fs/statfs.c b/fs/statfs.c
index 2616424012ea7..59f33752c1311 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -29,6 +29,8 @@ static int flags_by_mnt(int mnt_flags)
 		flags |= ST_NODIRATIME;
 	if (mnt_flags & MNT_RELATIME)
 		flags |= ST_RELATIME;
+	if (mnt_flags & MNT_NOSYMFOLLOW)
+		flags |= ST_NOSYMFOLLOW;
 	return flags;
 }
 
diff --git a/include/linux/mount.h b/include/linux/mount.h
index bf8cc4108b8f9..ff2d132c21f5d 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -30,6 +30,7 @@ struct fs_context;
 #define MNT_NODIRATIME	0x10
 #define MNT_RELATIME	0x20
 #define MNT_READONLY	0x40	/* does the user want this to be r/o? */
+#define MNT_NOSYMFOLLOW	0x80
 
 #define MNT_SHRINKABLE	0x100
 #define MNT_WRITE_HOLD	0x200
@@ -46,7 +47,7 @@ struct fs_context;
 #define MNT_SHARED_MASK	(MNT_UNBINDABLE)
 #define MNT_USER_SETTABLE_MASK  (MNT_NOSUID | MNT_NODEV | MNT_NOEXEC \
 				 | MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME \
-				 | MNT_READONLY)
+				 | MNT_READONLY | MNT_NOSYMFOLLOW)
 #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
 
 #define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index 9bc69edb8f188..fac4356ea1bfc 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -40,6 +40,7 @@ struct kstatfs {
 #define ST_NOATIME	0x0400	/* do not update access times */
 #define ST_NODIRATIME	0x0800	/* do not update directory access times */
 #define ST_RELATIME	0x1000	/* update atime relative to mtime/ctime */
+#define ST_NOSYMFOLLOW	0x2000	/* do not follow symlinks */
 
 struct dentry;
 extern int vfs_get_fsid(struct dentry *dentry, __kernel_fsid_t *fsid);
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 96a0240f23fed..c268ea586dbf4 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -34,6 +34,7 @@
 #define MS_I_VERSION	(1<<23) /* Update inode I_version field */
 #define MS_STRICTATIME	(1<<24) /* Always perform atime updates */
 #define MS_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
+#define MS_NOSYMFOLLOW	(1<<26) /* Do not follow symlinks */
 
 /* These sb flags are internal to the kernel */
 #define MS_SUBMOUNT     (1<<26)
-- 
2.25.0.341.g760bfbb309-goog

