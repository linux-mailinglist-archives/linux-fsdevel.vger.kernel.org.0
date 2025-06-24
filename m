Return-Path: <linux-fsdevel+bounces-52705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9FFAE5F62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6AD4C1DD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041F25B69E;
	Tue, 24 Jun 2025 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/OjibEK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3125B675;
	Tue, 24 Jun 2025 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753792; cv=none; b=IrZAb0qKUUegKTQEryKVAR5TBr2IKLlIPnl41zxZ42ZdgXOWh7B7vFJNFD8STGDbB3wSmIxunP3E6OXjBmc9PLgJRpHffvT7twx3CrjrqXJ+CnyelYpojmR0+fw9YYvegWSlrNUytnSrvvMtIoEeKFxPhH6PC9wqotw/x33YGnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753792; c=relaxed/simple;
	bh=QGhdkds6tNtrL2dBz/1V3M09RW+7EzjI9qj+pDE1Yrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQj+PmhJwVAM7AaUeCfzVxhcqxCaxd1wG38/xNLhn8dB1jyLF04/B3UCCmUiSgP4P/Qg8k2EVuXwES7yvjAqpi2l//iWLMC5SjE2NcXIjbBFgDX+GbrI90MF5kSX4QX6Fddxa0omZYsHsqLrbD/PoCdXdTFe5Cuj3wLmtcnKd9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/OjibEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C76C4CEEF;
	Tue, 24 Jun 2025 08:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753792;
	bh=QGhdkds6tNtrL2dBz/1V3M09RW+7EzjI9qj+pDE1Yrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o/OjibEK82m7YW76MXh/iMPBQlSua7ImjbsWIAzuXtbZU5M1tVEjdDJmRtlDZOq6x
	 +t+sYgEyEbRHjSr6wFpuWtzbHJoX7sE7VvoROxVHZ3+xoPWFkzqfehk64WrwUOtXbw
	 sejRREZGfeT0Y42tPUQB0c5V9WJm1l7kttrfxFBF9/di6hg352rDwN3bA4kyzq3Eoc
	 oNqa2sGPz3dbK04ZYooUGel6lPLW9RlwnuGqFFlMc5mnWt+gxA3iumjcagOs9XBO80
	 VMv8bESl+Gpmrxn3BYTLlOAT/5z8j7sH9xwkUx9OzlIM01Vjf8yrYhMptPpi26eYZk
	 ZqzlcxIG5wFeA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Jun 2025 10:29:13 +0200
Subject: [PATCH v2 10/11] fhandle, pidfs: support open_by_handle_at()
 purely based on file handle
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3017; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QGhdkds6tNtrL2dBz/1V3M09RW+7EzjI9qj+pDE1Yrw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREJb64zb+i1cf9XR87+0Wzv9LeGZ+68zfuOq37Vnvj1
 2tiTNOSOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy5zTDP4sdHGeqDU5eZpEy
 vO3Bdl7zy/K7insO7PT6UfglZJtNXiPDfz9LRquNNfyOkRtm5Xw4bjLpYUqexQmWgpluN/S2BLy
 4wQ0A
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
 fs/fhandle.c | 22 ++++++++++++++++++++--
 fs/pidfs.c   |  5 ++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index ab4891925b52..54081e19f594 100644
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
@@ -193,6 +193,24 @@ static int get_path_anchor(int fd, struct path *root)
 		return 0;
 	}
 
+	/*
+	 * Only autonomous handles can be decoded without a file
+	 * descriptor.
+	 */
+	if (!(handle_type & FILEID_IS_AUTONOMOUS))
+		return -EOPNOTSUPP;
+
+	if (fd != FD_INVALID)
+		return -EINVAL;
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
 
@@ -347,7 +365,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS)
 		return -EINVAL;
 
-	retval = get_path_anchor(mountdirfd, &ctx.root);
+	retval = get_path_anchor(mountdirfd, &ctx.root, f_handle.handle_type);
 	if (retval)
 		return retval;
 
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 69b0541042b5..2ab9b47fbfae 100644
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


