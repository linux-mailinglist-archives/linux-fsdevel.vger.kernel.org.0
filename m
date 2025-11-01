Return-Path: <linux-fsdevel+bounces-66673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B07E7C2814F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 16:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22B22349B7E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684C67E792;
	Sat,  1 Nov 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b="G8XiMLtH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B3199939
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762010494; cv=none; b=TE9o4+e5zQgVV6xDDk4gj4ePS+xyIx9bi/QVQHvJ4jNvFEZJ/W3AQec6kotka9j6eG3WPRF31LLrR7RxPL5tvYWbMMrnk6+duX3yN/UBKSA9ArVx59Xa3QKcDbSIi98MJfB1FicF3fmP6HMjoyVFfYyaI1TUblSG+mhEdOoxXZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762010494; c=relaxed/simple;
	bh=8jqE+3n2/pGjqVh09ImLKgINXJe2O3Qm1c2w7BFRpdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7tlYTL8OdfiIadXaewaVDdF/dnn4NA6NFJhkZ03u7NAXBXKbfTXO9rUmhGW9zQJRmYbzbl0Rrazqb+z9kaCokI9hE+h2nVBPfNpfdvqKQMouYXxhJO52aPtxT//aSGhZ9CXPAeZbLoMePZNChDLcljoLCJUo0dhhockDqiafHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe; spf=pass smtp.mailfrom=snai.pe; dkim=pass (2048-bit key) header.d=snai.pe header.i=@snai.pe header.b=G8XiMLtH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snai.pe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snai.pe
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47109187c32so16083375e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Nov 2025 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snai.pe; s=snai.pe; t=1762010491; x=1762615291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lctyseE6NPklGWz+oiorlBgb04RBElM4DW5BKVaMCvw=;
        b=G8XiMLtHDH4j5oaaDwwF2P0GFOk7cEKRuUl2pBkr5lRo6ClPsEZvpc6V6AcbQOE7Cx
         cYipOlr1rb2qOIFddGhjNtxvFYiyT9rJjZGb7+FqeG/iQ0ldWnXzmYdwHDEYwzEtV8K7
         pcX/kVEslvR377QdqTUw2XeT7nMEfXzFHj1NE2ZeQ+ib8SKOocsz3EIShmRyf1Sjr7P1
         1Ybw/G53YG0BVal+hoM9lCd2PKYDqayncF+CyNENbMTiMhZxDopk/G2f2iJ+PioJ0zGb
         KZn2MYKpjPvMB7mLgHWJyfpmLGyEqz6B8MXaZnA7iBocmDwg9RWk5bmjPe+R3oOlu/D7
         MBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762010491; x=1762615291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lctyseE6NPklGWz+oiorlBgb04RBElM4DW5BKVaMCvw=;
        b=Yq1bDXGpH+TRCZCGvm0CzmAVci1QYqYvirvhs9P8ncSWt9+Z5uVA9MWZYr9FA7S69q
         oC6WjhU15g7bU7E86H4a3GJjMCyOH8sS8cLae8IGuAdohP1fn1Yn7wOZUB8F6gJHbFbT
         Hyw2zQKDD5NdFBdVlYai1mZnw12j3dAXJd+wvyvDEtLUipEwS8NlRq0jLvkOxVN1SiQZ
         O9dWQToS+bLzXgPONQgx1jSQcSI+udZnDYlnzcAgJyQB1Wt/VoCDCTLl0M5z7VTIeRqg
         cSMNefFXg+TjlWAi0Hzcu2DpyG2yHAwIRIwb9HdoaKiWQTR0B4r6qrMSd0+Y8BAkZi7d
         Xu+w==
X-Gm-Message-State: AOJu0YwniuDc3OwVvvCyQQ0ayKid7jwqm/mNLzQFGCQ/pWOmK38BW/Rk
	mszgb9EzU60t9n2WX9oZg0mWdb98S7x/HOj8eOekBFa9lmC/aI+d/Kli4nZRp0JbOJxsZ47vu6o
	GEPuW
X-Gm-Gg: ASbGncs4hB2CQlZzCb26ysMDzxfKG4FRcK3T6igDeSX3ADz0NlYEggQZ1c/SEo7zxrx
	r3/zfYRC4QhSoF30ZrmGUTIV/SDpElsqCdmVtB23THlOhOk0/j7qdwq5X90lzXOux/hVw5H77D9
	oeOLmg2L/mMKzn6nvRcv/4+bnDIS0U6kqyWDYliLfguhqSZYfTrk4PYZ/poS1BKvdZvRgw4royv
	+9IipACbASMtHD7PAaweusTMvbVyIo78VKCTCfGBMruNZPuXWBQRte4hbDY2pMPNavnI06FVimH
	Bg+8TTcDy24XLsmNuw7Bekk/0Bh+XHLqUJMcDzLxkwGH1M6j3E5nMnUweIid6TubS4Lv+gpn1x1
	piUvaJp3cDc8p6SOvTJatCbY5IwjNJOm2Zle3eE9smklEeLcfXd+0/u7vHEFslBTl3p7PApk2ES
	nzqmUX58EABWNBS/U=
X-Google-Smtp-Source: AGHT+IG8UMxlz6d21eZXXwxJQgzYmGV/4bCcAn3EoI1B1TX0AHsPs7Fx/617wPLWINkpxDw1ZHTkwQ==
X-Received: by 2002:a05:600c:4ece:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-4773087b2dbmr65128435e9.24.1762010490935;
        Sat, 01 Nov 2025 08:21:30 -0700 (PDT)
Received: from snaipe-arista.aristanetworks.com ([81.255.216.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2e674csm53699555e9.4.2025.11.01.08.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 08:21:30 -0700 (PDT)
From: Franklin Snaipe Mathieu <me@snai.pe>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	"Franklin \"Snaipe\" Mathieu" <me@snai.pe>
Subject: [PATCH 1/1] fs: let open_tree open mounts from another namespace
Date: Sat,  1 Nov 2025 16:21:10 +0100
Message-ID: <20251101152110.2709624-2-me@snai.pe>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <CACyTCKhcoetvvokawDc4EsKwJcEDaLgmtXyb1gvqD59NNgh=_A@mail.gmail.com>
References: <CACyTCKhcoetvvokawDc4EsKwJcEDaLgmtXyb1gvqD59NNgh=_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Franklin \"Snaipe\" Mathieu" <me@snai.pe>

This commit adds the OPEN_TREE_CROSSNS flag, which relaxes the
requirement for the passed mount to be in the same mount namespace as
the current task. Without that flag, the following sequence does not
work:

    int fd = open("/tmp", O_PATH);
    unshare(CLONE_NEWNS);
    // returns -EINVAL
    open_tree(fd, "", OPEN_TREE_CLONE|AT_EMPTY_PATH|AT_RECURSIVE);

This is because __do_loopback calls may_copy_tree, which ultimately
rejects paths whose mount exist in a different mount namespace than the
caller.

With OPEN_TREE_CROSSNS, the same sequence works, and it becomes possible
for the new mount namespace to bind-mount trees by file descriptors
opened in a different mount namespace.

Currently, this new flag is only valid when used with OPEN_TREE_CLONE.

Signed-off-by: Franklin "Snaipe" Mathieu <me@snai.pe>
---
 fs/namespace.c                                | 26 +++++++++++--------
 include/uapi/linux/mount.h                    |  1 +
 tools/include/uapi/linux/mount.h              |  1 +
 .../trace/beauty/include/uapi/linux/mount.h   |  1 +
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..49239fa4d276 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2928,7 +2928,7 @@ static int do_change_type(const struct path *path, int ms_flags)
  *
  * Returns true if the mount tree can be copied, false otherwise.
  */
-static inline bool may_copy_tree(const struct path *path)
+static inline bool may_copy_tree(const struct path *path, bool cross_ns)
 {
 	struct mount *mnt = real_mount(path->mnt);
 	const struct dentry_operations *d_op;
@@ -2946,18 +2946,21 @@ static inline bool may_copy_tree(const struct path *path)
 	if (!is_mounted(path->mnt))
 		return false;
 
-	return check_anonymous_mnt(mnt);
+	if (check_anonymous_mnt(mnt))
+		return true;
+
+	return cross_ns;
 }
 
 
-static struct mount *__do_loopback(const struct path *old_path, int recurse)
+static struct mount *__do_loopback(const struct path *old_path, int recurse, bool cross_ns)
 {
 	struct mount *old = real_mount(old_path->mnt);
 
 	if (IS_MNT_UNBINDABLE(old))
 		return ERR_PTR(-EINVAL);
 
-	if (!may_copy_tree(old_path))
+	if (!may_copy_tree(old_path, cross_ns))
 		return ERR_PTR(-EINVAL);
 
 	if (!recurse && __has_locked_children(old, old_path->dentry))
@@ -2994,7 +2997,7 @@ static int do_loopback(const struct path *path, const char *old_name,
 	if (!check_mnt(mp.parent))
 		return -EINVAL;
 
-	mnt = __do_loopback(&old_path, recurse);
+	mnt = __do_loopback(&old_path, recurse, false);
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
@@ -3007,7 +3010,7 @@ static int do_loopback(const struct path *path, const char *old_name,
 	return err;
 }
 
-static struct mnt_namespace *get_detached_copy(const struct path *path, bool recursive)
+static struct mnt_namespace *get_detached_copy(const struct path *path, bool recursive, bool cross_ns)
 {
 	struct mnt_namespace *ns, *mnt_ns = current->nsproxy->mnt_ns, *src_mnt_ns;
 	struct user_namespace *user_ns = mnt_ns->user_ns;
@@ -3032,7 +3035,7 @@ static struct mnt_namespace *get_detached_copy(const struct path *path, bool rec
 			ns->seq_origin = src_mnt_ns->ns.ns_id;
 	}
 
-	mnt = __do_loopback(path, recursive);
+	mnt = __do_loopback(path, recursive, cross_ns);
 	if (IS_ERR(mnt)) {
 		emptied_ns = ns;
 		return ERR_CAST(mnt);
@@ -3046,9 +3049,9 @@ static struct mnt_namespace *get_detached_copy(const struct path *path, bool rec
 	return ns;
 }
 
-static struct file *open_detached_copy(struct path *path, bool recursive)
+static struct file *open_detached_copy(struct path *path, bool recursive, bool cross_ns)
 {
-	struct mnt_namespace *ns = get_detached_copy(path, recursive);
+	struct mnt_namespace *ns = get_detached_copy(path, recursive, cross_ns);
 	struct file *file;
 
 	if (IS_ERR(ns))
@@ -3070,12 +3073,13 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 	struct path path __free(path_put) = {};
 	int lookup_flags = LOOKUP_AUTOMOUNT | LOOKUP_FOLLOW;
 	bool detached = flags & OPEN_TREE_CLONE;
+	bool cross_ns = flags & OPEN_TREE_CROSSNS;
 
 	BUILD_BUG_ON(OPEN_TREE_CLOEXEC != O_CLOEXEC);
 
 	if (flags & ~(AT_EMPTY_PATH | AT_NO_AUTOMOUNT | AT_RECURSIVE |
 		      AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLONE |
-		      OPEN_TREE_CLOEXEC))
+		      OPEN_TREE_CLOEXEC | OPEN_TREE_CROSSNS))
 		return ERR_PTR(-EINVAL);
 
 	if ((flags & (AT_RECURSIVE | OPEN_TREE_CLONE)) == AT_RECURSIVE)
@@ -3096,7 +3100,7 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 		return ERR_PTR(ret);
 
 	if (detached)
-		return open_detached_copy(&path, flags & AT_RECURSIVE);
+		return open_detached_copy(&path, flags & AT_RECURSIVE, cross_ns);
 
 	return dentry_open(&path, O_PATH, current_cred());
 }
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 7fa67c2031a5..2b415115a651 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -62,6 +62,7 @@
  * open_tree() flags.
  */
 #define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
+#define OPEN_TREE_CROSSNS	2		/* Allow mounts of trees from other namespaces */
 #define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
 
 /*
diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
index 7fa67c2031a5..2b415115a651 100644
--- a/tools/include/uapi/linux/mount.h
+++ b/tools/include/uapi/linux/mount.h
@@ -62,6 +62,7 @@
  * open_tree() flags.
  */
 #define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
+#define OPEN_TREE_CROSSNS	2		/* Allow mounts of trees from other namespaces */
 #define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
 
 /*
diff --git a/tools/perf/trace/beauty/include/uapi/linux/mount.h b/tools/perf/trace/beauty/include/uapi/linux/mount.h
index 7fa67c2031a5..2b415115a651 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/mount.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/mount.h
@@ -62,6 +62,7 @@
  * open_tree() flags.
  */
 #define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
+#define OPEN_TREE_CROSSNS	2		/* Allow mounts of trees from other namespaces */
 #define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
 
 /*
-- 
2.51.2


