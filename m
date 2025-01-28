Return-Path: <linux-fsdevel+bounces-40216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2AFA2089C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 11:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C77E1887852
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96DC19F127;
	Tue, 28 Jan 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUnWLmkD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726919F104
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060447; cv=none; b=tenuOH4TJxpILIDxwHdaK97iYB0ICRtEpCBVHc3kvsYetd3LAL05OkAXZSjQOS5GPd+qnO0JcoxdrimaEBOmFxYEaCWEguSKi1/hYCjeg/CgcKDDVGQH3dB+EFB+SZR912XbYkTTmzCT6yPeNYqnbV24OaGBRBUdfNU45o4JDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060447; c=relaxed/simple;
	bh=Y8BskR6ld4M3X7bKNH2f1EupxvCpoYJCPqGHpNiv6Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mwxmS4nnMyJ/cl8FsPM4eJH7hdQWRnnet9oHC/76eb7TizcKR9e7di6yin6NU9TlSTGiK/qJy2C3JZgBEz9U3ym7rOCX9I1VZSOuBLx5IzUPamewpgipRLlU0faKqJqAfWXXKiMNfnVSuxLBUm8YfEErSlUWmqBXV0jS1VodBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUnWLmkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CCFC4CED3;
	Tue, 28 Jan 2025 10:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738060446;
	bh=Y8BskR6ld4M3X7bKNH2f1EupxvCpoYJCPqGHpNiv6Fs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kUnWLmkDGQD86KRAfGTGpJRrJ2ryk2GXBlj+nRA2xdBrf0/Cr849L/BcdJvTPYo9a
	 CEAZ3mVNlpAE9se6GpKuUs3ivb50Zh72pfsmM7YS0aB+0mr7kmECwBjJYjX0LG5MNc
	 vgvAtcp32Wd1/JUaFA3hLGMMRvHhcLYAW+eyp74pKgzQunwBRDs+P+ydHip31/FVjC
	 vjPQK6bXry9ugTIOYGEVLXkdI2/3BX8s5R3ACSe9NPBvHxd6G8bIhnTtzlYEfCI/5n
	 98e9cgQOe60gNBWcGdAaf6WbrURf76GvgYLaW0vIIWWMCRjwRohzl/+U5iQVQyue4x
	 hpUpvPYumYpPQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Jan 2025 11:33:40 +0100
Subject: [PATCH 2/5] fs: add copy_mount_setattr() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-work-mnt_idmap-update-v2-v1-2-c25feb0d2eb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4292; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Y8BskR6ld4M3X7bKNH2f1EupxvCpoYJCPqGHpNiv6Fs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTP2DRV/tPWkx7Vk1iTD6e4qb//J5b/wWrtXK9tos6Ok
 12idkS/6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI7BNGhub5LaInbs/Rbwn3
 lwrZ5t//Mcjx6728lMJZFxhb80x0JjMyLBXO62hX/fql7LRbX9TmJCtO06+r+OZoSzPec0k9Pns
 KIwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Split out copy_mount_setattr() from mount_setattr() so we can use it in
later patches.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 73 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2a8ac568a08d125290ae3cdeeeec3280ea4c1721..ef7db39c8776ab13da968d7f69c56698e3846914 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4721,7 +4721,7 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 }
 
 static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
-				struct mount_kattr *kattr, unsigned int flags)
+				struct mount_kattr *kattr)
 {
 	struct ns_common *ns;
 	struct user_namespace *mnt_userns;
@@ -4772,22 +4772,8 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
 }
 
 static int build_mount_kattr(const struct mount_attr *attr, size_t usize,
-			     struct mount_kattr *kattr, unsigned int flags)
+			     struct mount_kattr *kattr)
 {
-	unsigned int lookup_flags = LOOKUP_AUTOMOUNT | LOOKUP_FOLLOW;
-
-	if (flags & AT_NO_AUTOMOUNT)
-		lookup_flags &= ~LOOKUP_AUTOMOUNT;
-	if (flags & AT_SYMLINK_NOFOLLOW)
-		lookup_flags &= ~LOOKUP_FOLLOW;
-	if (flags & AT_EMPTY_PATH)
-		lookup_flags |= LOOKUP_EMPTY;
-
-	*kattr = (struct mount_kattr) {
-		.lookup_flags	= lookup_flags,
-		.recurse	= !!(flags & AT_RECURSIVE),
-	};
-
 	if (attr->propagation & ~MOUNT_SETATTR_PROPAGATION_FLAGS)
 		return -EINVAL;
 	if (hweight32(attr->propagation & MOUNT_SETATTR_PROPAGATION_FLAGS) > 1)
@@ -4835,7 +4821,7 @@ static int build_mount_kattr(const struct mount_attr *attr, size_t usize,
 			return -EINVAL;
 	}
 
-	return build_mount_idmapped(attr, usize, kattr, flags);
+	return build_mount_idmapped(attr, usize, kattr);
 }
 
 static void finish_mount_kattr(struct mount_kattr *kattr)
@@ -4847,23 +4833,14 @@ static void finish_mount_kattr(struct mount_kattr *kattr)
 		mnt_idmap_put(kattr->mnt_idmap);
 }
 
-SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
-		unsigned int, flags, struct mount_attr __user *, uattr,
-		size_t, usize)
+static int copy_mount_setattr(struct mount_attr __user *uattr, size_t usize,
+			      struct mount_kattr *kattr)
 {
-	int err;
-	struct path target;
+	int ret;
 	struct mount_attr attr;
-	struct mount_kattr kattr;
 
 	BUILD_BUG_ON(sizeof(struct mount_attr) != MOUNT_ATTR_SIZE_VER0);
 
-	if (flags & ~(AT_EMPTY_PATH |
-		      AT_RECURSIVE |
-		      AT_SYMLINK_NOFOLLOW |
-		      AT_NO_AUTOMOUNT))
-		return -EINVAL;
-
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
 	if (unlikely(usize < MOUNT_ATTR_SIZE_VER0))
@@ -4872,9 +4849,9 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 	if (!may_mount())
 		return -EPERM;
 
-	err = copy_struct_from_user(&attr, sizeof(attr), uattr, usize);
-	if (err)
-		return err;
+	ret = copy_struct_from_user(&attr, sizeof(attr), uattr, usize);
+	if (ret)
+		return ret;
 
 	/* Don't bother walking through the mounts if this is a nop. */
 	if (attr.attr_set == 0 &&
@@ -4882,7 +4859,37 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 	    attr.propagation == 0)
 		return 0;
 
-	err = build_mount_kattr(&attr, usize, &kattr, flags);
+	return build_mount_kattr(&attr, usize, kattr);
+}
+
+SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
+		unsigned int, flags, struct mount_attr __user *, uattr,
+		size_t, usize)
+{
+	int err;
+	struct path target;
+	struct mount_kattr kattr;
+	unsigned int lookup_flags = LOOKUP_AUTOMOUNT | LOOKUP_FOLLOW;
+
+	if (flags & ~(AT_EMPTY_PATH |
+		      AT_RECURSIVE |
+		      AT_SYMLINK_NOFOLLOW |
+		      AT_NO_AUTOMOUNT))
+		return -EINVAL;
+
+	if (flags & AT_NO_AUTOMOUNT)
+		lookup_flags &= ~LOOKUP_AUTOMOUNT;
+	if (flags & AT_SYMLINK_NOFOLLOW)
+		lookup_flags &= ~LOOKUP_FOLLOW;
+	if (flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+	kattr = (struct mount_kattr) {
+		.lookup_flags	= lookup_flags,
+		.recurse	= !!(flags & AT_RECURSIVE),
+	};
+
+	err = copy_mount_setattr(uattr, usize, &kattr);
 	if (err)
 		return err;
 

-- 
2.45.2


