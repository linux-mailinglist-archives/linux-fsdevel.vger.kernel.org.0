Return-Path: <linux-fsdevel+bounces-52504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EDDAE3956
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA97C16D3A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DA4238C12;
	Mon, 23 Jun 2025 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8QK9HsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAB7238176;
	Mon, 23 Jun 2025 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669315; cv=none; b=MdFXUEjOYnv6iBS3KQJyhc9srs2OKu75bRccigFqOBZHpRc+vrbVd7i/pnX7xUf7LjBXoy4flrLHxlpCevXWE4R7X/rOBp0lpw677JFbKJVInYvHbR2SKcDnS9uGajCoLBDKRa8t+Iz3jB/FvUAeG3ibYx4gT0XnpFOenKKPokE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669315; c=relaxed/simple;
	bh=a6sUFhCHKDgGHVZmg22ALl6fvlDWpmIFOyTGHkPjUAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rabqakr8+/med4YCdhhR/wBzN13MjjuihsIxQZVdM1c66DWBKZTJApuBXMF2ct+IjRHwI0y+/UgqaG0AmIZwaFBVAW0Eyu7F0PLzVNGYniGBuQUwfnSpVnuAqyOzyftEf1q3KAcJNMm9F0oosAJ6m6h2VMUGmLAARBmK0RffPxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8QK9HsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE206C4CEED;
	Mon, 23 Jun 2025 09:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669315;
	bh=a6sUFhCHKDgGHVZmg22ALl6fvlDWpmIFOyTGHkPjUAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r8QK9HsMbKkYTqKC0+l4pD3+CPkaHjLSj/0OCERGDdq2Hc08oPzGbKaMEak3mTp0T
	 xPm3P8GlQBahaZQO5JjcPnyTPmsSeJWxmza8jtLzQUnfdiAQ25oZ5nemLYD2ryKDlv
	 ccYCKu4NVqtUpXU5qCXHem0dFH0WU8uVwVMan+SmodcLWVeKpsWvmOE8/QfqqfqIJ4
	 lUOm7jHENxEa//ww1YQ21yyLymAG40yMctxLMIulB/A51ZB3Ec/Tcg2U1pCjN4HBbz
	 bmaqXUmqFdGIRouqmCEAsbDsMPBC4FjQSfH2336CYnp8W/EqXK8lIvJdCii8wQMTPM
	 3O/MD6f9bsAug==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Jun 2025 11:01:30 +0200
Subject: [PATCH 8/9] fhandle, pidfs: support open_by_handle_at() purely
 based on file handle
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-work-pidfs-fhandle-v1-8-75899d67555f@kernel.org>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
In-Reply-To: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2966; i=brauner@kernel.org;
 h=from:subject:message-id; bh=a6sUFhCHKDgGHVZmg22ALl6fvlDWpmIFOyTGHkPjUAk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREir+u8av/eyLXYMvcxRzquUnpQtl24rc2Ne6RvvjNU
 k1usdCsjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInYvmJk2P76wgq9v7f3HKoz
 Cvf/uHo/J+OW21myLl3TnnE0fPqxk5eRYU+i9cK3NmmnvjYaa1R+fZuSHSnJ/q96fWL47Psn04o
 mcQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Various filesystems such as pidfs (and likely drm in the future) have a
use-case to support opening files purely based on the handle without
having to require a file descriptor to another object. That's especially
the case for filesystems that don't do any lookup whatsoever and there's
zero relationship between the objects. Such filesystems are also
singletons that stay around for the lifetime of the system meaning that
they can be uniquely identified and accessed purely based on the file
handle type. Enable that so that userspace doesn't have to allocate an
object needlessly especially if they can't do that for whatever reason.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 19 +++++++++++++++++--
 fs/pidfs.c   |  5 ++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index ab4891925b52..20d6477b5a9e 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -173,7 +173,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 	return err;
 }
 
-static int get_path_anchor(int fd, struct path *root)
+static int get_path_anchor(int fd, struct path *root, int handle_type)
 {
 	if (fd >= 0) {
 		CLASS(fd, f)(fd);
@@ -193,6 +193,21 @@ static int get_path_anchor(int fd, struct path *root)
 		return 0;
 	}
 
+	/*
+	 * Only autonomous handles can be decoded without a file
+	 * descriptor.
+	 */
+	if (!(handle_type & FILEID_IS_AUTONOMOUS))
+		return -EOPNOTSUPP;
+
+	switch (handle_type & ~FILEID_USER_FLAGS_MASK) {
+	case FILEID_PIDFS:
+		pidfs_get_root(root);
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -347,7 +362,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS)
 		return -EINVAL;
 
-	retval = get_path_anchor(mountdirfd, &ctx.root);
+	retval = get_path_anchor(mountdirfd, &ctx.root, f_handle.handle_type);
 	if (retval)
 		return retval;
 
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 1b7bd14366dc..ea50a6afc325 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -747,7 +747,7 @@ static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 
 	*max_len = 2;
 	*(u64 *)fh = pid->ino;
-	return FILEID_KERNFS;
+	return FILEID_PIDFS;
 }
 
 static int pidfs_ino_find(const void *key, const struct rb_node *node)
@@ -802,6 +802,8 @@ static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
 		return NULL;
 
 	switch (fh_type) {
+	case FILEID_PIDFS:
+		fallthrough;
 	case FILEID_KERNFS:
 		pid_ino = *(u64 *)fid;
 		break;
@@ -860,6 +862,7 @@ static const struct export_operations pidfs_export_operations = {
 	.fh_to_dentry	= pidfs_fh_to_dentry,
 	.open		= pidfs_export_open,
 	.permission	= pidfs_export_permission,
+	.flags		= EXPORT_OP_AUTONOMOUS_HANDLES,
 };
 
 static int pidfs_init_inode(struct inode *inode, void *data)

-- 
2.47.2


