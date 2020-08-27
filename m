Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26CC254BA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 19:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgH0RKE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 13:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0RJ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:09:59 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE49BC061264
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 10:09:58 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u126so6562545iod.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zy8MaawGAdFvMcnl51+12kZuV9xAVAJV7h+dgIdsiM=;
        b=KPLMugwGcD3nlza4Rs5RTIo6IMyVGmmVEgEVxvajeNXATLXtpr5Lr+ALT6hqbzvd3f
         mGP000eROkxNeYFFhZnd1SNyNe+xFCBghJgQiDThi+TkPDGOG9c6yQfZmN40JpuLnfe+
         tcS9hA1cPKax8hys2sUSc7+7+SjxthF+giWyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zy8MaawGAdFvMcnl51+12kZuV9xAVAJV7h+dgIdsiM=;
        b=hv8DAgrg3g/359SzG71ZNdopN7AsfRbe36RCyrua2vuHBz82RYGi0p+/wF+CdIfReW
         0aii6SZTdbIY6iualzmc3Hco9TewMu7Ie2355eYkJVzLEpAOHj3SGszfU1i1QIYxOa6e
         OkarYFN00Puq1fQR/GTYH4l8lSAUANM6gB/obobt/aIlal2J0vxjPuEBHEAxs5NicGPZ
         5W9lNLaVcu7n3otqC8gVOSeqysFXp9ft49El+8GW3Dq7ov+2u0tpyqe3Ag7aCy/9j7FI
         n+l3ILhiD7p6O5ZgLrMWQ0lls9rAysuLQ7CDmoWQvnQMxXVefYVwPe2bNeA08eK67fK9
         xv2g==
X-Gm-Message-State: AOAM531BcRTktqfvuaxipubso8dq/g0VUMUoeg0yG8AxriG+96hkRr2h
        CQcyuNzJPFKqXzGtL9eYuMNyIQ==
X-Google-Smtp-Source: ABdhPJxdXpbX9zOohWhDwMe+Emquhqqdolb1snr/FP4PBePPjkpr8GDZfiZBB0hWDpxh8BYaDA0sfg==
X-Received: by 2002:a6b:c404:: with SMTP id y4mr2930588ioa.153.1598548197970;
        Thu, 27 Aug 2020 10:09:57 -0700 (PDT)
Received: from ravnica.hsd1.co.comcast.net ([2601:285:8380:9270::f2a2])
        by smtp.gmail.com with ESMTPSA id 137sm1501157ioc.20.2020.08.27.10.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 10:09:57 -0700 (PDT)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH v9 1/2] Add a "nosymfollow" mount option.
Date:   Thu, 27 Aug 2020 11:09:46 -0600
Message-Id: <20200827170947.429611-1-zwisler@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
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
Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
---
Changes since v8 [1]:
 * Look for MNT_NOSYMFOLLOW in link->mnt->mnt_flags so we are testing
   the link itself rather than the directory holding the link. (Al Viro)
 * Rebased onto v5.9-rc2.

After this lands I will upstream changes to util-linux[2] and man-pages
[3].

[1]: https://patchwork.kernel.org/patch/11724607/
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
index e99e2a9da0f7d..33e8c79bc761e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1626,7 +1626,8 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 			return ERR_PTR(error);
 	}
 
-	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS))
+	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS) ||
+			unlikely(link->mnt->mnt_flags & MNT_NOSYMFOLLOW))
 		return ERR_PTR(-ELOOP);
 
 	if (!(nd->flags & LOOKUP_RCU)) {
diff --git a/fs/namespace.c b/fs/namespace.c
index bae0e95b3713a..6408788a649e1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3160,6 +3160,8 @@ int path_mount(const char *dev_name, struct path *path,
 		mnt_flags &= ~(MNT_RELATIME | MNT_NOATIME);
 	if (flags & MS_RDONLY)
 		mnt_flags |= MNT_READONLY;
+	if (flags & MS_NOSYMFOLLOW)
+		mnt_flags |= MNT_NOSYMFOLLOW;
 
 	/* The default atime for remount is preservation */
 	if ((flags & MS_REMOUNT) &&
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 3059a9394c2d6..e59d4bb3a89e4 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -70,6 +70,7 @@ static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
 		{ MNT_NOATIME, ",noatime" },
 		{ MNT_NODIRATIME, ",nodiratime" },
 		{ MNT_RELATIME, ",relatime" },
+		{ MNT_NOSYMFOLLOW, ",nosymfollow" },
 		{ 0, NULL }
 	};
 	const struct proc_fs_opts *fs_infop;
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
index de657bd211fa6..aaf343b38671c 100644
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
2.28.0.297.g1956fa8f8d-goog

