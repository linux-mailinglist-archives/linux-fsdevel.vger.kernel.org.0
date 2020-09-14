Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBE12693E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 19:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgINRow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 13:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgINRo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:44:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C587C06174A;
        Mon, 14 Sep 2020 10:44:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so568208wrr.4;
        Mon, 14 Sep 2020 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EuPkGgGoA4uFnzzhRpbE+z2Ng4wCuaRwpxF2iWsUijA=;
        b=bJdBk1O6nlV7gbE3XhrGCiwUt4mGVV5llaPYRKZP0fDDbNjVqj6u07NCjLGZu76NRO
         WJmCFupxPiZCwu5VFHvU54wNBHYE+V7N0mIYupq0WxIHRu0lRkRGIf6gVjLoii3lPFoy
         sCQFfaSqVpEM9EDwoklE8jTljfTMiUh0w4q7gy6hxlV2eBLwLOKCNQPHlgTVEQ6QerNh
         gvho3itP/hIjy0yNQhlmPS5cJDCTl+Bzq7PkVwE7Ym2YcEnht/NpCpYDjHa1bI2V+OHo
         jaSQwikq5ZN638mZB1C9QxAWVGq5jI01uqdtujZGQsxFwONTUkplOt5RpSRE2izbhMdP
         PGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EuPkGgGoA4uFnzzhRpbE+z2Ng4wCuaRwpxF2iWsUijA=;
        b=bbkSo66mXipL5VRxKNzucQFY7eTZcESlvxwIwY3CjMCrYFQ1BHHeF7FZ6EB2PKWW3x
         2eBL1lwJoPCNIcsPK1qHgE24iU6dFpIhppSdAP7GUKZb1n6oXX5zKugHRtLKQmX0QFM6
         h8cxLGUw6FrHSR/x/nZgIelz7dcmUkCkbMqDlZiHtP3TVU8jDpSak0MZL/zz/AmBrl7f
         WyqU8WoIjvmawMvknub1LzDKhtPLBDnZRFZZZXYOfXXQgnsoxFoGteC51lZBYxWpbBOm
         M8+3nyhpNRYXkBm6lxBSXMY9dWlPdlBCRvIKSzfOskkn5HxTUq0sdLUASwl0EJUaR7kN
         eNVQ==
X-Gm-Message-State: AOAM532KoXRFMMyeHblerAjEbuIB3nqdpRzTkBSRQ7buuxOah7TZHeYk
        +EpfkV2Dfo71J4hPysNhmvuupbK4w/fEvA==
X-Google-Smtp-Source: ABdhPJyAchnSnolYBWmZv09ugRhHS7C6rEn3A/iT1BpFHdOiKazIDWAW7iSHQLuTy3FG9SdAtk664Q==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr18264154wrn.175.1600105463301;
        Mon, 14 Sep 2020 10:44:23 -0700 (PDT)
Received: from localhost.localdomain (188.147.112.12.nat.umts.dynamic.t-mobile.pl. [188.147.112.12])
        by smtp.gmail.com with ESMTPSA id d5sm22863202wrb.28.2020.09.14.10.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 10:44:22 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, viro@zeniv.linux.org.uk
Subject: [RFC PATCH] fs: micro-optimization remove branches by adjusting flag values
Date:   Mon, 14 Sep 2020 19:43:38 +0200
Message-Id: <20200914174338.9808-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

When flags A and B have equal values than the following code

if(flags1 & A)
	flags2 |= B;

is equivalent to

flags2 |= (flags1 & A);

The latter code should generate less instructions and be faster as one
branch is omitted in it.

Introduced patch changes the value of 'LOOKUP_EMPTY' and makes it equal
to the value of 'AT_EMPTY_PATH'. Thanks to that, few branches can be
changed in a way showed above which improves both performance and the
size of the code.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 fs/exec.c             | 14 ++++++++++----
 fs/fhandle.c          |  4 ++--
 fs/namespace.c        |  4 ++--
 fs/open.c             |  8 ++++----
 fs/stat.c             |  4 ++--
 fs/utimes.c           |  6 +++---
 include/linux/namei.h |  4 ++--
 7 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a91003e28eaa..39e1ada1ee6c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -904,8 +904,8 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 		return ERR_PTR(-EINVAL);
 	if (flags & AT_SYMLINK_NOFOLLOW)
 		open_exec_flags.lookup_flags &= ~LOOKUP_FOLLOW;
-	if (flags & AT_EMPTY_PATH)
-		open_exec_flags.lookup_flags |= LOOKUP_EMPTY;
+	BUILD_BUG_ON(AT_EMPTY_PATH != LOOKUP_EMPTY);
+	open_exec_flags.lookup_flags |= (flags & AT_EMPTY_PATH);
 
 	file = do_filp_open(fd, name, &open_exec_flags);
 	if (IS_ERR(file))
@@ -2176,7 +2176,10 @@ SYSCALL_DEFINE5(execveat,
 		const char __user *const __user *, envp,
 		int, flags)
 {
-	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
+	int lookup_flags;
+
+	BUILD_BUG_ON(AT_EMPTY_PATH != LOOKUP_EMPTY);
+	lookup_flags = (flags & AT_EMPTY_PATH);
 
 	return do_execveat(fd,
 			   getname_flags(filename, lookup_flags, NULL),
@@ -2197,7 +2200,10 @@ COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
 		       const compat_uptr_t __user *, envp,
 		       int,  flags)
 {
-	int lookup_flags = (flags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
+	int lookup_flags;
+
+	BUILD_BUG_ON(AT_EMPTY_PATH != LOOKUP_EMPTY);
+	lookup_flags = (flags & AT_EMPTY_PATH);
 
 	return compat_do_execveat(fd,
 				  getname_flags(filename, lookup_flags, NULL),
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 01263ffbc4c0..579bf462bf89 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -102,8 +102,8 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 		return -EINVAL;
 
 	lookup_flags = (flag & AT_SYMLINK_FOLLOW) ? LOOKUP_FOLLOW : 0;
-	if (flag & AT_EMPTY_PATH)
-		lookup_flags |= LOOKUP_EMPTY;
+	BUILD_BUG_ON(AT_EMPTY_PATH != LOOKUP_EMPTY);
+	lookup_flags |= (flag & AT_EMPTY_PATH);
 	err = user_path_at(dfd, name, lookup_flags, &path);
 	if (!err) {
 		err = do_sys_name_to_handle(&path, handle, mnt_id);
diff --git a/fs/namespace.c b/fs/namespace.c
index 098f981dce54..319f42d11236 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2456,8 +2456,8 @@ SYSCALL_DEFINE3(open_tree, int, dfd, const char __user *, filename, unsigned, fl
 		lookup_flags &= ~LOOKUP_AUTOMOUNT;
 	if (flags & AT_SYMLINK_NOFOLLOW)
 		lookup_flags &= ~LOOKUP_FOLLOW;
-	if (flags & AT_EMPTY_PATH)
-		lookup_flags |= LOOKUP_EMPTY;
+	BUILD_BUG_ON(AT_EMPTY_PATH != LOOKUP_EMPTY);
+	lookup_flags |= (flags & AT_EMPTY_PATH);
 
 	if (detached && !may_mount())
 		return -EPERM;
diff --git a/fs/open.c b/fs/open.c
index 9af548fb841b..8b6fe1e89811 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -410,8 +410,8 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 
 	if (flags & AT_SYMLINK_NOFOLLOW)
 		lookup_flags &= ~LOOKUP_FOLLOW;
-	if (flags & AT_EMPTY_PATH)
-		lookup_flags |= LOOKUP_EMPTY;
+	BUILD_BUG_ON(AT_EMPTY_PATH != LOOKUP_EMPTY);
+	lookup_flags |= (flags & AT_EMPTY_PATH);
 
 	if (!(flags & AT_EACCESS)) {
 		old_cred = access_override_creds();
@@ -692,8 +692,8 @@ int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 		goto out;
 
 	lookup_flags = (flag & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
-	if (flag & AT_EMPTY_PATH)
-		lookup_flags |= LOOKUP_EMPTY;
+	BUILD_BUG_ON(AT_EMPTY_PATH != LOOKUP_EMPTY);
+	lookup_flags |= (flag & AT_EMPTY_PATH);
 retry:
 	error = user_path_at(dfd, filename, lookup_flags, &path);
 	if (error)
diff --git a/fs/stat.c b/fs/stat.c
index 44f8ad346db4..a9feb7a7e9ec 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -168,8 +168,8 @@ static inline unsigned vfs_stat_set_lookup_flags(unsigned *lookup_flags,
 		*lookup_flags &= ~LOOKUP_FOLLOW;
 	if (flags & AT_NO_AUTOMOUNT)
 		*lookup_flags &= ~LOOKUP_AUTOMOUNT;
-	if (flags & AT_EMPTY_PATH)
-		*lookup_flags |= LOOKUP_EMPTY;
+	BUILD_BUG_ON(AT_EMPTY_PATH != LOOKUP_EMPTY);
+	*lookup_flags |= (flags & AT_EMPTY_PATH);
 
 	return 0;
 }
diff --git a/fs/utimes.c b/fs/utimes.c
index fd3cc4226224..95a48dbda7e1 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -79,15 +79,15 @@ static int do_utimes_path(int dfd, const char __user *filename,
 		struct timespec64 *times, int flags)
 {
 	struct path path;
-	int lookup_flags = 0, error;
+	int lookup_flags, error;
 
 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
 		return -EINVAL;
 
+	BUILD_BUG_ON(AT_EMPTY_PATH != LOOKUP_EMPTY);
+	lookup_flags = (flags & AT_EMPTY_PATH);
 	if (!(flags & AT_SYMLINK_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
-	if (flags & AT_EMPTY_PATH)
-		lookup_flags |= LOOKUP_EMPTY;
 
 retry:
 	error = user_path_at(dfd, filename, lookup_flags, &path);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a4bb992623c4..52f8015717c0 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -21,7 +21,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_FOLLOW		0x0001	/* follow links at the end */
 #define LOOKUP_DIRECTORY	0x0002	/* require a directory */
 #define LOOKUP_AUTOMOUNT	0x0004  /* force terminal automount */
-#define LOOKUP_EMPTY		0x4000	/* accept empty path [user_... only] */
+#define LOOKUP_EMPTY		0x1000	/* accept empty path [user_... only], AT_EMPTY_PATH set */
 #define LOOKUP_DOWN		0x8000	/* follow mounts in the starting point */
 #define LOOKUP_MOUNTPOINT	0x0080	/* follow mounts in the end */
 
@@ -36,7 +36,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 
 /* internal use only */
 #define LOOKUP_PARENT		0x0010
-#define LOOKUP_JUMPED		0x1000
+#define LOOKUP_JUMPED		0x4000
 #define LOOKUP_ROOT		0x2000
 #define LOOKUP_ROOT_GRABBED	0x0008
 
-- 
2.20.1

