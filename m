Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E06152214
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 22:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgBDVuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 16:50:25 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33251 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgBDVuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:50:25 -0500
Received: by mail-io1-f67.google.com with SMTP id z8so22781118ioh.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2020 13:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0i3/3+XXmz+J9LUoNMltdqXtFQCY6ttO7G0zGfPbFE=;
        b=fIOsfh0x/I35igdo5knF4zup1aWEVAScD0wahqnjxg8zRW7zCBPQCt0zApOUQ5BzuE
         Em1gwA4flRAKFMCK4yDfH+fvrXompZS3zpmEcFL0XOJe5+uv425N1qbWIGLFcM5D4Isw
         8GfOK4fS05P0dDiCkzWSeMx9OHqJjvp31OJOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0i3/3+XXmz+J9LUoNMltdqXtFQCY6ttO7G0zGfPbFE=;
        b=dAMp7V3spu/BQbxprY20SCc8+EwWGQ9FlgKgMZ0v102bHkp0VL0v3t2wvkCet/czJU
         F0ysBYgal7BHo5FLtOge4VYLIEdTLQors/6hBbCYVhcW87pxzhq34bHr9O0dArP8aueV
         8oGj+5ZyYh6ZjQv48KGBSPnPoZaovxaDe9Cp1xJNmQ/fe3vpNrKYSEYZcypLkazAQWXp
         rSuAWRQLn8Fy9jMXfJ2Jzvv85UdjGGNsZtqLbFbq/MfRKB0bBf4W1pQcA7xAtSbEU9uW
         5C6RnPENk9BRTxmn6D4b2y2u0EWcfWBR+6QRmkwJTOO6sgO7iOs9YBVV/+O7p7YItyLW
         ieTQ==
X-Gm-Message-State: APjAAAVxdX1Zuvm6K54a69Weft4GtB6HoO//gn537Gb0UZUrXmY1SZAq
        m8L4AshdLdErRYlgocut1s7tEQ==
X-Google-Smtp-Source: APXvYqwS02wj0hdef7McBQ3xlASNktjUy6dIZhwla7gWfQXqau25RuyTMMs3Kikk9SubEl+5tQhijg==
X-Received: by 2002:a02:2a06:: with SMTP id w6mr27039731jaw.63.1580853024210;
        Tue, 04 Feb 2020 13:50:24 -0800 (PST)
Received: from localhost ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id x87sm9323483ilk.39.2020.02.04.13.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 13:50:23 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mattias Nissler <mnissler@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Raul Rangel <rrangel@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5] Add a "nosymfollow" mount option.
Date:   Tue,  4 Feb 2020 14:50:14 -0700
Message-Id: <20200204215014.257377-1-zwisler@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mattias Nissler <mnissler@chromium.org>

For mounts that have the new "nosymfollow" option, don't follow symlinks
when resolving paths. The new option is similar in spirit to the
existing "nodev", "noexec", and "nosuid" options, as well as to the
LOOKUP_NO_SYMLINKS resolve flag in the openat2(2) syscall. Various BSD
variants have been supporting the "nosymfollow" mount option for a long
time with equivalent implementations.

Note that symlinks may still be created on file systems mounted with
the "nosymfollow" option present. readlink() remains functional, so
user space code that is aware of symlinks can still choose to follow
them explicitly.

Setting the "nosymfollow" mount option helps prevent privileged
writers from modifying files unintentionally in case there is an
unexpected link along the accessed path. The "nosymfollow" option is
thus useful as a defensive measure for systems that need to deal with
untrusted file systems in privileged contexts.

More information on the history and motivation for this patch can be
found here:

https://sites.google.com/a/chromium.org/dev/chromium-os/chromiumos-design-docs/hardening-against-malicious-stateful-data#TOC-Restricting-symlink-traversal

Signed-off-by: Mattias Nissler <mnissler@chromium.org>
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
Changes since v4 [1]:
 * Rebased changes on top of the newly merged openat2(2) changes.  This
   changed the error value when trying to traverse symlinks on a
   restricted filesystem from -EACCESS to -ELOOP, which is what
   LOOKUP_NO_SYMLINKS uses.

[1]: https://lkml.org/lkml/2020/1/30/933
---
 fs/namei.c                 | 3 ++-
 fs/namespace.c             | 2 ++
 fs/proc_namespace.c        | 1 +
 fs/statfs.c                | 2 ++
 include/linux/mount.h      | 3 ++-
 include/linux/statfs.h     | 1 +
 include/uapi/linux/mount.h | 1 +
 7 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4167109297e0f..93af3d4353543 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1122,7 +1122,8 @@ const char *get_link(struct nameidata *nd)
 	int error;
 	const char *res;
 
-	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS))
+	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS) ||
+		unlikely(nd->path.mnt->mnt_flags & MNT_NOSYMFOLLOW))
 		return ERR_PTR(-ELOOP);
 
 	if (!(nd->flags & LOOKUP_RCU)) {
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

