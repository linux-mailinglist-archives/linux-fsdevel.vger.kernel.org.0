Return-Path: <linux-fsdevel+bounces-42233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228DFA3F5AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB971884D89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3C52116E5;
	Fri, 21 Feb 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho5HW5Ju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE286211489
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143630; cv=none; b=dsmUYwnSjsoPSTQIm+2RI0M87yNyZIOxvyH+XQMx5q9J8ne7wiGf6wCyh/LX7Iz+GwiTCFFSWAP6mAgGuM2s4CEVqkGg5tUiqtfum81sMwxWi+VPlLtd0cKDnkr3nlnWB2noJXyNG7lhzKuJwi1tJSM1luvNrBWA/HuHWFIIVD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143630; c=relaxed/simple;
	bh=yuDWZ9+eDo5W/hiMFBgT4qAe2LTa/3e3Mq/F6p8d4bQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxVUOdILkuw6zZzLipUpCMQkqeZj9TZ97igVVlFBxSiUthVeRsDTKmm70IbY0Pi7O8yhylVlBdBLU3buptxO6EoYNKP7woT8BL4uUeLPAX4apDHWvc+mtf10vQV8x2/XOVJaQPGOLjyb6zepEwYdY/Q4JKRjGjBJE2acGH4pbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho5HW5Ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BA6C4CEE7;
	Fri, 21 Feb 2025 13:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143630;
	bh=yuDWZ9+eDo5W/hiMFBgT4qAe2LTa/3e3Mq/F6p8d4bQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ho5HW5Ju9zv9pigO9266YkZkYQSRAM/FubCzQ661BtUM2Ix0R5oQxe2I241lj8hnl
	 EcH1X5g3auAJGPXa0v80fLGNc6lz5wc9zQylPyCJm8fvOgQyYLZCrHCvv7YUxJYEDQ
	 nJPZSO2VR8BzKvH+w+Kn5C1cl3/Y7dCPuyXSWbpIhBaQxS/IipwpeCSBmq1i7JSSgS
	 BlOC7rRaekc9edf3xM9APshdqGZG2CrWQr6Fd3SnfWIFkX4tgUEyVXfMQsiJuNIbun
	 LmYF9il6NhLUr0gO3krMX37v0z09QHDQHSDYFzig9G4rHQ08U7w8/Zw5bsn7uGvmW3
	 Vn86gmyke3deg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:07 +0100
Subject: [PATCH RFC 08/16] fs: support getname_maybe_null() in move_mount()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-8-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=5677; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yuDWZ9+eDo5W/hiMFBgT4qAe2LTa/3e3Mq/F6p8d4bQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP51o2fRokMrfhjbLZl2u5D95Jy/wUdjl0p2XGmPn
 Mz0d87Fhx2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATqbrN8FdmfcLsBz+KH94+
 09eu7Cl1Qfts/PmVvpx+iwsWqXyL457PyLCnf0aPePsunhSxhkV/W6M26543O2llu6pLX/SSQX2
 kCRcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow move_mount() to work with NULL path arguments.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c     | 93 +++++++++++++++++++++++++++++++++++-------------------
 include/linux/fs.h |  1 +
 2 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 66b9cea1cf66..612f73481d35 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2465,6 +2465,7 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
 enum mnt_tree_flags_t {
 	MNT_TREE_MOVE = BIT(0),
 	MNT_TREE_BENEATH = BIT(1),
+	MNT_TREE_PROPAGATION = BIT(2),
 };
 
 /**
@@ -3434,8 +3435,8 @@ static int can_move_mount_beneath(const struct path *from,
 	return 0;
 }
 
-static int do_move_mount(struct path *old_path, struct path *new_path,
-			 bool beneath)
+static int do_move_mount(struct path *old_path,
+			 struct path *new_path, enum mnt_tree_flags_t flags)
 {
 	struct mnt_namespace *ns;
 	struct mount *p;
@@ -3443,8 +3444,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path,
 	struct mount *parent;
 	struct mountpoint *mp, *old_mp;
 	int err;
-	bool attached;
-	enum mnt_tree_flags_t flags = 0;
+	bool attached, beneath = flags & MNT_TREE_BENEATH;
 
 	mp = do_lock_mount(new_path, beneath);
 	if (IS_ERR(mp))
@@ -3545,7 +3545,7 @@ static int do_move_mount_old(struct path *path, const char *old_name)
 	if (err)
 		return err;
 
-	err = do_move_mount(&old_path, path, false);
+	err = do_move_mount(&old_path, path, 0);
 	path_put(&old_path);
 	return err;
 }
@@ -4386,6 +4386,21 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	return ret;
 }
 
+static inline int vfs_move_mount(struct path *from_path, struct path *to_path,
+				 enum mnt_tree_flags_t mflags)
+{
+	int ret;
+
+	ret = security_move_mount(from_path, to_path);
+	if (ret)
+		return ret;
+
+	if (mflags & MNT_TREE_PROPAGATION)
+		return do_set_group(from_path, to_path);
+
+	return do_move_mount(from_path, to_path, mflags);
+}
+
 /*
  * Move a mount from one place to another.  In combination with
  * fsopen()/fsmount() this is used to install a new mount and in combination
@@ -4399,8 +4414,12 @@ SYSCALL_DEFINE5(move_mount,
 		int, to_dfd, const char __user *, to_pathname,
 		unsigned int, flags)
 {
-	struct path from_path, to_path;
-	unsigned int lflags;
+	struct path to_path __free(path_put) = {};
+	struct path from_path __free(path_put) = {};
+	struct filename *to_name __free(putname) = NULL;
+	struct filename *from_name __free(putname) = NULL;
+	unsigned int lflags, uflags;
+	enum mnt_tree_flags_t mflags = 0;
 	int ret = 0;
 
 	if (!may_mount())
@@ -4413,43 +4432,51 @@ SYSCALL_DEFINE5(move_mount,
 	    (MOVE_MOUNT_BENEATH | MOVE_MOUNT_SET_GROUP))
 		return -EINVAL;
 
-	/* If someone gives a pathname, they aren't permitted to move
-	 * from an fd that requires unmount as we can't get at the flag
-	 * to clear it afterwards.
-	 */
+	if (flags & MOVE_MOUNT_SET_GROUP)	mflags |= MNT_TREE_PROPAGATION;
+	if (flags & MOVE_MOUNT_BENEATH)		mflags |= MNT_TREE_BENEATH;
+
 	lflags = 0;
 	if (flags & MOVE_MOUNT_F_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
 	if (flags & MOVE_MOUNT_F_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
-	if (flags & MOVE_MOUNT_F_EMPTY_PATH)	lflags |= LOOKUP_EMPTY;
-
-	ret = user_path_at(from_dfd, from_pathname, lflags, &from_path);
-	if (ret < 0)
-		return ret;
+	if (flags & MOVE_MOUNT_F_EMPTY_PATH)	uflags = AT_EMPTY_PATH;
+	from_name = getname_maybe_null(from_pathname, uflags);
+	if (IS_ERR(from_name))
+		return PTR_ERR(from_name);
 
 	lflags = 0;
 	if (flags & MOVE_MOUNT_T_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
 	if (flags & MOVE_MOUNT_T_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
-	if (flags & MOVE_MOUNT_T_EMPTY_PATH)	lflags |= LOOKUP_EMPTY;
+	if (flags & MOVE_MOUNT_T_EMPTY_PATH)	uflags = AT_EMPTY_PATH;
+	to_name = getname_maybe_null(to_pathname, uflags);
+	if (IS_ERR(to_name))
+		return PTR_ERR(to_name);
+
+	if (!to_name && to_dfd >= 0) {
+		CLASS(fd_raw, f_to)(to_dfd);
+		if (fd_empty(f_to))
+			return -EBADF;
+
+		to_path = fd_file(f_to)->f_path;
+		path_get(&to_path);
+	} else {
+		ret = filename_lookup(to_dfd, to_name, lflags, &to_path, NULL);
+		if (ret)
+			return ret;
+	}
 
-	ret = user_path_at(to_dfd, to_pathname, lflags, &to_path);
-	if (ret < 0)
-		goto out_from;
+	if (!from_name && from_dfd >= 0) {
+		CLASS(fd_raw, f_from)(from_dfd);
+		if (fd_empty(f_from))
+			return -EBADF;
 
-	ret = security_move_mount(&from_path, &to_path);
-	if (ret < 0)
-		goto out_to;
+		return vfs_move_mount(&fd_file(f_from)->f_path, &to_path, mflags);
+	}
 
-	if (flags & MOVE_MOUNT_SET_GROUP)
-		ret = do_set_group(&from_path, &to_path);
-	else
-		ret = do_move_mount(&from_path, &to_path,
-				    (flags & MOVE_MOUNT_BENEATH));
+	ret = filename_lookup(from_dfd, from_name, lflags, &from_path, NULL);
+	if (ret)
+		return ret;
 
-out_to:
-	path_put(&to_path);
-out_from:
-	path_put(&from_path);
-	return ret;
+	return vfs_move_mount(&from_path, &to_path, mflags);
 }
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e71d58c7f59c..7e9df867538d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2855,6 +2855,7 @@ static inline struct filename *getname_maybe_null(const char __user *name, int f
 	return __getname_maybe_null(name);
 }
 extern void putname(struct filename *name);
+DEFINE_FREE(putname, struct filename *, if (!IS_ERR_OR_NULL(_T)) putname(_T))
 
 extern int finish_open(struct file *file, struct dentry *dentry,
 			int (*open)(struct inode *, struct file *));

-- 
2.47.2


