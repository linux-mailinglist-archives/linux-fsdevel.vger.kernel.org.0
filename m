Return-Path: <linux-fsdevel+bounces-40215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AB5A2089B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 11:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44592166D37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7C19EEC2;
	Tue, 28 Jan 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/P5PNmp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F4519E965
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060444; cv=none; b=O7VysGRAtQqfypEqrOsKEzrNhQ2AOxDXXimjEOomLsXsg+mAKbQbFOEVlq7AvH4/KONyZj5vv+weM7hBsGWy6c5WUP7ZUq30wFtkMFYBYybL32OoGph1tenFyjYc3b8ohaBuflC3W++OtXbuyQsuIq7nj9jF6CcFq8WRc3g3vbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060444; c=relaxed/simple;
	bh=IBRscUIUI6xMwpf16BJSqNB0KlIBXsRA9FwvCpui/gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fGMJNyU//xUU0vLAt2WptIPqpJgn8/H11OTRIPdrJPlJcqIQKDOw51O5Ido8gOyW7RNn76zE2MSr0oPHx9gxq1Fh/F5hlcJjrEyxXjcTj3nkNrKQc3ErqPZ/BLMv1nQfVDaLqS+uUOzjDWvDikf2bnQXZvHJ1A9pLSEOc8n03wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/P5PNmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE72C4CEE5;
	Tue, 28 Jan 2025 10:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738060443;
	bh=IBRscUIUI6xMwpf16BJSqNB0KlIBXsRA9FwvCpui/gg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q/P5PNmpEGHCIByjQCGqW/j2IK69BBD0UvabZzQNlEvna6mWpOnQvkPZEIjiPQnam
	 KdjdVIogR7a+AbnsccbNwipwTGNtnTWR1VLWHr5rs1WL+0gr3P8/WEParxhnl4V0KC
	 OWSr4RQBdkHX0ZjEU/R6GdQxL5EphpUfWoPK2z5Dhy93DKJppk4qsINIDzPTTV3avk
	 9KwNd9QTUFY3CH88tQgW827FiNlAA9GChgNe4QWleaRNAZ17mUknVvEui6UzfbsSw4
	 EClvWXc5pCDrKQ/tP0EhOHsnWhItPkbkNLC6YRpFFh/u+B4Gn2xo+MD0VfeZY9SURM
	 G/ZIyhsFcmoOQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Jan 2025 11:33:39 +0100
Subject: [PATCH 1/5] fs: add vfs_open_tree() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-work-mnt_idmap-update-v2-v1-1-c25feb0d2eb3@kernel.org>
References: <20250128-work-mnt_idmap-update-v2-v1-0-c25feb0d2eb3@kernel.org>
In-Reply-To: <20250128-work-mnt_idmap-update-v2-v1-0-c25feb0d2eb3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.com>, Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2701; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IBRscUIUI6xMwpf16BJSqNB0KlIBXsRA9FwvCpui/gg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTP2DT1oGB2/xR2uw8Rq6/f3SZeMpl/Wtj2nw+feYurX
 ak0kHDN6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIzmxGht3up34sr3o/4/Zt
 lTd7ynm2r/J7zc+SxzNDajU/t8WJ+fMY/kq07RETOZWxgTddLsXZc9H3MPn6Z/NveW2S81w0eff
 HqewA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Split out vfs_open_tree() from open_tree() so we can use it in later
patches.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 4013fbac354a284732eb10e5a869b86184a52d1d..2a8ac568a08d125290ae3cdeeeec3280ea4c1721 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2889,24 +2889,22 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 	return file;
 }
 
-SYSCALL_DEFINE3(open_tree, int, dfd, const char __user *, filename, unsigned, flags)
+static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned int flags)
 {
-	struct file *file;
-	struct path path;
+	int ret;
+	struct path path __free(path_put) = {};
 	int lookup_flags = LOOKUP_AUTOMOUNT | LOOKUP_FOLLOW;
 	bool detached = flags & OPEN_TREE_CLONE;
-	int error;
-	int fd;
 
 	BUILD_BUG_ON(OPEN_TREE_CLOEXEC != O_CLOEXEC);
 
 	if (flags & ~(AT_EMPTY_PATH | AT_NO_AUTOMOUNT | AT_RECURSIVE |
 		      AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLONE |
 		      OPEN_TREE_CLOEXEC))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	if ((flags & (AT_RECURSIVE | OPEN_TREE_CLONE)) == AT_RECURSIVE)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	if (flags & AT_NO_AUTOMOUNT)
 		lookup_flags &= ~LOOKUP_AUTOMOUNT;
@@ -2916,27 +2914,32 @@ SYSCALL_DEFINE3(open_tree, int, dfd, const char __user *, filename, unsigned, fl
 		lookup_flags |= LOOKUP_EMPTY;
 
 	if (detached && !may_mount())
-		return -EPERM;
+		return ERR_PTR(-EPERM);
+
+	ret = user_path_at(dfd, filename, lookup_flags, &path);
+	if (unlikely(ret))
+		return ERR_PTR(ret);
+
+	if (detached)
+		return open_detached_copy(&path, flags & AT_RECURSIVE);
+
+	return dentry_open(&path, O_PATH, current_cred());
+}
+
+SYSCALL_DEFINE3(open_tree, int, dfd, const char __user *, filename, unsigned, flags)
+{
+	int fd;
+	struct file *file __free(fput) = NULL;
+
+	file = vfs_open_tree(dfd, filename, flags);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
 
 	fd = get_unused_fd_flags(flags & O_CLOEXEC);
 	if (fd < 0)
 		return fd;
 
-	error = user_path_at(dfd, filename, lookup_flags, &path);
-	if (unlikely(error)) {
-		file = ERR_PTR(error);
-	} else {
-		if (detached)
-			file = open_detached_copy(&path, flags & AT_RECURSIVE);
-		else
-			file = dentry_open(&path, O_PATH, current_cred());
-		path_put(&path);
-	}
-	if (IS_ERR(file)) {
-		put_unused_fd(fd);
-		return PTR_ERR(file);
-	}
-	fd_install(fd, file);
+	fd_install(fd, no_free_ptr(file));
 	return fd;
 }
 

-- 
2.45.2


