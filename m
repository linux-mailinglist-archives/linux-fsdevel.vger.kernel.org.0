Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF79024227F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 00:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgHKW2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 18:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgHKW2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:28:12 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E9FC061787
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 15:28:12 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id h3so40848oie.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 15:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5T/nvak5wlxXblbVTDHVOmc2hAwvvYVV2Vb3CvH/W8=;
        b=FkoozWqxK2C1WKuQ4NC4YGvyueUcXzIWWlOKER9Qe8T8H340YvtTUs4QELxhSsGo5o
         Oa9yC282vrk51zpjZb5oBHDIZOZVumtTCq7RKubo5TU7hzKGc0TmqZKUSfIHvOv1PY1l
         dw/x5whCK+oeYF+D3N1iLnOBTkPA9AmvZMhRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5T/nvak5wlxXblbVTDHVOmc2hAwvvYVV2Vb3CvH/W8=;
        b=cPbiKPdNLy2JgUr2PlwNAk5JFRGb7nO5bT0WW5kYfw/UqyUDGicMtdYCxDazMj2O6d
         3z3TnS5pXTLcyOEB7U9WxYo2ihSDPxKYHxQ/UsgyELyUTNZsEOHuRI2AldS0Dy8uYwgC
         Y+UoQdYCJmzeySClvK+T2CsRGELM/LVgBppmIoBo92I9mgg4cSBAIFAnJfTWR/hrXrdz
         gCYBCvNjGGFsLKrg5gd4niMKNRHaki0QznAvJ/TpKDRyu5WWjP8RmVKZ3aJxPvMJ5cSp
         XX0g46voppQOBvFcCUmrSvA6MGAkjrhsWgyBCSW8J/oC3upQEEXR7aLYqdxg9Jbtx7wM
         kA4w==
X-Gm-Message-State: AOAM5339JTHa6vRHG0gBfbuYSlzSnHJfzhY4kFzAbP2NJr9jGOyIKZ7h
        BwkbrOHRUm2iwUcnxYzSwEtMA4pQKDE=
X-Google-Smtp-Source: ABdhPJx/6R87UtohjzEQ/WkYwP5qfUTLNSsZE7FoVNPZ6oRQnrSp6u/2k+KUhO/yQ9ANMXfvVWRV+g==
X-Received: by 2002:aca:4e92:: with SMTP id c140mr5044717oib.70.1597184892059;
        Tue, 11 Aug 2020 15:28:12 -0700 (PDT)
Received: from ravnica.hsd1.co.comcast.net ([2601:285:8380:9270:7220:84ff:fe09:9945])
        by smtp.gmail.com with ESMTPSA id v36sm4582934ooi.46.2020.08.11.15.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 15:28:11 -0700 (PDT)
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
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH v7] Add a "nosymfollow" mount option.
Date:   Tue, 11 Aug 2020 16:28:03 -0600
Message-Id: <20200811222803.3224434-1-zwisler@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
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
Changes since v6 [1]:
 * Rebased onto v5.8.
 * Another round of testing including readlink(1), readlink(2),
   realpath(1), realpath(3), statfs(2) and mount(2) to make sure
   everything still works.

After this lands I will upstream changes to util-linux[2] and man-pages
[3].

[1]: https://lkml.org/lkml/2020/3/4/770
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
index 72d4219c93acb..ed68478fb1fb6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1626,7 +1626,8 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 			return ERR_PTR(error);
 	}
 
-	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS))
+	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS) ||
+			unlikely(nd->path.mnt->mnt_flags & MNT_NOSYMFOLLOW))
 		return ERR_PTR(-ELOOP);
 
 	if (!(nd->flags & LOOKUP_RCU)) {
diff --git a/fs/namespace.c b/fs/namespace.c
index 4a0f600a33285..1cbbf5a9b954f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3167,6 +3167,8 @@ long do_mount(const char *dev_name, const char __user *dir_name,
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
2.28.0.236.gb10cc79966-goog

