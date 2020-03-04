Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A6C1796D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgCDRfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 12:35:22 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45894 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgCDRfW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:35:22 -0500
Received: by mail-io1-f66.google.com with SMTP id w9so3278693iob.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2020 09:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZTD9KMsKfztS9z4ihucA5Dr5NrKiyOZlSRfhuTSHZ0=;
        b=WGELEpODqQ2xvAWmt7hf8UU7aiWEjaLDxusURIHdxWcZTSn/wjRxcXpmKmnV6raulL
         RBUBaoZkOVap9hzzhM77/lwCokBIrGvyblmYg95FCMps5W8l3LD6byUevYLxJfU/rGEJ
         hBo2gByRPNaW0YUmr3fqqJM2AOXKVaa9/pgYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mZTD9KMsKfztS9z4ihucA5Dr5NrKiyOZlSRfhuTSHZ0=;
        b=C7rlkL74Z1QFbitp0fy19SmANtRmFmELIo7/ySskCwVd1YUPz01ziSshhaXUAYiXCb
         ZDK+yHxE/+/60GRwttTi5mY8N+L4NdKtVdF5EBErsF0c/M5yi/5lIrwzY4MMwLDCvCwT
         BR8R6NdEZcGgGJbBkX4cT4RSZM97B2rSgiaVjbXhsxV/Rnc4OlBqExo3kKiL1nAwv95A
         Oj3BQ/qAUZKkF+wOFKkKuSFGTYJblEnpHToM5hMc1QS9Zwk0iMY3CZWsEsGqlL7YvTQ0
         qT6KpehzXNqb0XqXXOfN45F2hmCmcvownYYXQL/Zu5nPkWoWckf7Tad/qUwC8BgEOGmj
         Qyxw==
X-Gm-Message-State: ANhLgQ1GiOHb9wgWxPOSqYjWKyIA6aMPqflTjRLw7zArA6PbiA6DRcZF
        NggRM2RZtXDEIMHdy3cmh2rShA==
X-Google-Smtp-Source: ADFU+vsvhwY1ciSk27AccTZgx6m46/Y31Yyx/ZPc8zFT1PN27HXTw0DnGPGKT4cgsMyGVOy1irPzZg==
X-Received: by 2002:a02:a1c9:: with SMTP id o9mr3798084jah.33.1583343319866;
        Wed, 04 Mar 2020 09:35:19 -0800 (PST)
Received: from localhost ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id q83sm5807706ilb.31.2020.03.04.09.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 09:35:19 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mattias Nissler <mnissler@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Raul Rangel <rrangel@google.com>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6] Add a "nosymfollow" mount option.
Date:   Wed,  4 Mar 2020 10:34:46 -0700
Message-Id: <20200304173446.122990-1-zwisler@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
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
Resending v6 which was previously posted here [0].

Aleksa, if I've addressed all of your feedback, would you mind adding
your Reviewed-by?

Andrew, would you please consider merging this?

This patch adds a security measure which we feel is necessary to have in
Chrome OS, and which would be beneficial to have in other Linux setups
as well.  Lots of details on exactly what we're protecting against exist
in the write-up that I linked to in the commit message.

Changes since v5 [1]:
 * Redefined MS_NOSYMFOLLOW to use a lower unused bit value (256) so it
   doesn't collide with MS_SUBMOUNT.
 * Updated the mount code in util-linux [2] to use the newly defined
   flag value.
 * Updated man pages for mount(8) [2], as well as mount(2) and statfs(2) [3].

[0]: https://patchwork.kernel.org/patch/11405065/
[1]: https://patchwork.kernel.org/patch/11365291/
[2]: https://github.com/rzwisler/util-linux/commit/7f8771acd85edb70d97921c026c55e1e724d4e15
[3]: https://github.com/rzwisler/man-pages/commit/b8fe8079f64b5068940c0144586e580399a71668
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
index db6565c998259..026a774d28c3d 100644
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
index 85b5f7bea82e7..9b843b66d39e4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3074,6 +3074,8 @@ long do_mount(const char *dev_name, const char __user *dir_name,
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
index 96a0240f23fed..dd8306ea336c1 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -16,6 +16,7 @@
 #define MS_REMOUNT	32	/* Alter flags of a mounted FS */
 #define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
 #define MS_DIRSYNC	128	/* Directory modifications are synchronous */
+#define MS_NOSYMFOLLOW	256	/* Do not follow symlinks */
 #define MS_NOATIME	1024	/* Do not update access times. */
 #define MS_NODIRATIME	2048	/* Do not update directory access times */
 #define MS_BIND		4096
-- 
2.25.1.481.gfbce0eb801-goog

