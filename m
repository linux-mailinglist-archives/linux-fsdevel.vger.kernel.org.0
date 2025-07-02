Return-Path: <linux-fsdevel+bounces-53613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 342C5AF0FDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4112748220A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CC6246797;
	Wed,  2 Jul 2025 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icQxknXl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20155244691
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448243; cv=none; b=g9mqefS9W813aj/K9RMj8G1MiIY8UptDvUVKB0ZZ/g5fo1tGdXYNiCEnrLrdx6cVEnQ5vVzCm7ZHGVEWrlwli4t6/jotMhfEra9ivYpvqc1FsM1v+w04XOB00CppuUtHR6Fhv/L3hwinpqmNXfGlDrR1i+6iIFltGqDb0jItYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448243; c=relaxed/simple;
	bh=y+jwCeltImwoxfsHNTbfEnw0h5CwJo4jTiPYvIyBZ9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I+p5mNhgMDsrWwywnedg1vFsvZX4daXrb4jE82MYlM0HSA1/Hp64cQe1rsyurY7pgIjWl+t4CWbGx8rGxPeAePhP47bsAdPl/gMgAJzvsPXfBzG0tRZ3UGdzYrqOsjdjNi4lkYVgTQ0nWoDw0KPlPDgIzxWXmrb8tnmKWcOMChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icQxknXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE34C4CEED;
	Wed,  2 Jul 2025 09:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751448242;
	bh=y+jwCeltImwoxfsHNTbfEnw0h5CwJo4jTiPYvIyBZ9s=;
	h=From:Date:Subject:To:Cc:From;
	b=icQxknXl9pgdU3jyh/BFQrYLarNSMUo04DMPDu4vWPPnefrf5gPlCsyetY/msSj+4
	 v5qyNIiJf8Sd4Ab9ESuQBPh9l0kGaWxGDWljTeZqSXUF1LtBnsMZ46hDpeBUkm7lrq
	 HrMNtd/yv2tnqlMQdxh4I1D3xcF75xEr9Y4FCUEGONOFYXO7h9mhRCBtScv4T/z0qe
	 Lg1DU/TT6FjLNY+cKVy1PDeLvpidiFmztig8Ld+kEfMnf9PyoYZa+xc3DKmyll75Gj
	 Zvha6T/zMPG0EI2hmVfPCigdHJfuY61/q6sUzHZTUOVZkBNBdF+KaiqHsoBoi2T0as
	 noKBBoneteqgg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Jul 2025 11:23:55 +0200
Subject: [PATCH] anon_inode: rework assertions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-work-fixes-v1-1-ff76ea589e33@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKr6ZGgC/yWMywqDQAxFf0Wybso0IgV/pXQxj0wNwlgSsAXx3
 xvt8nDuuRsYq7DB2G2gvIrJ0hxulw7yFNuLUYozUKAh3APhZ9EZq3zZsOSeh1hST5XAg7fyKXz
 /eDqnaIxJY8vTcbFWu/79vv8A6MdOxngAAAA=
X-Change-ID: 20250702-work-fixes-dc3e5adb32f2
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, stable@kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=3094; i=brauner@kernel.org;
 h=from:subject:message-id; bh=y+jwCeltImwoxfsHNTbfEnw0h5CwJo4jTiPYvIyBZ9s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSk/Nr4qPreZ2s9Bl/7vKeT/h3gEtu/d9K12Ht8HCnLR
 Bf5b9XR7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI/b0M/73Pf61I7a7Zfv2e
 8u4Djx9Js54V6F45uyFF2aEwfl3L6zSGf3obWq3C3e6cvcUeGX/k/oR963ffeKTLJa0usvnEzdN
 f3JkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Making anonymous inodes regular files comes with a lot of risk and
regression potential as evidenced by a recent hickup in io_uring. We're
better of continuing to not have them be regular files. Since we have
S_ANON_INODE we can port all of our assertions easily.

Fixes: cfd86ef7e8e7 ("anon_inode: use a proper mode internally")
Cc: stable@kernel.org
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/exec.c  | 9 +++++++--
 fs/libfs.c | 8 +++-----
 fs/namei.c | 2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1f5fdd2e096e..ba400aafd640 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -114,6 +114,9 @@ static inline void put_binfmt(struct linux_binfmt * fmt)
 
 bool path_noexec(const struct path *path)
 {
+	/* If it's an anonymous inode make sure that we catch any shenanigans. */
+	VFS_WARN_ON_ONCE(IS_ANON_FILE(d_inode(path->dentry)) &&
+			 !(path->mnt->mnt_sb->s_iflags & SB_I_NOEXEC));
 	return (path->mnt->mnt_flags & MNT_NOEXEC) ||
 	       (path->mnt->mnt_sb->s_iflags & SB_I_NOEXEC);
 }
@@ -781,13 +784,15 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	if (IS_ERR(file))
 		return file;
 
+	if (path_noexec(&file->f_path))
+		return ERR_PTR(-EACCES);
+
 	/*
 	 * In the past the regular type check was here. It moved to may_open() in
 	 * 633fb6ac3980 ("exec: move S_ISREG() check earlier"). Since then it is
 	 * an invariant that all non-regular files error out before we get here.
 	 */
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)) ||
-	    path_noexec(&file->f_path))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
 		return ERR_PTR(-EACCES);
 
 	err = exe_file_deny_write_access(file);
diff --git a/fs/libfs.c b/fs/libfs.c
index 9ea0ecc325a8..6f487fc6be34 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1649,12 +1649,10 @@ struct inode *alloc_anon_inode(struct super_block *s)
 	 */
 	inode->i_state = I_DIRTY;
 	/*
-	 * Historically anonymous inodes didn't have a type at all and
-	 * userspace has come to rely on this. Internally they're just
-	 * regular files but S_IFREG is masked off when reporting
-	 * information to userspace.
+	 * Historically anonymous inodes don't have a type at all and
+	 * userspace has come to rely on this.
 	 */
-	inode->i_mode = S_IFREG | S_IRUSR | S_IWUSR;
+	inode->i_mode = S_IRUSR | S_IWUSR;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
 	inode->i_flags |= S_PRIVATE | S_ANON_INODE;
diff --git a/fs/namei.c b/fs/namei.c
index 4bb889fc980b..ceb0d47aa6b1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3471,7 +3471,7 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
 			return -EACCES;
 		break;
 	default:
-		VFS_BUG_ON_INODE(1, inode);
+		VFS_BUG_ON_INODE(!IS_ANON_FILE(inode), inode);
 	}
 
 	error = inode_permission(idmap, inode, MAY_OPEN | acc_mode);

---
base-commit: d5cb81ba929c1b0d02dadd4be27fc1440dd2e014
change-id: 20250702-work-fixes-dc3e5adb32f2


