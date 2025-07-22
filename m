Return-Path: <linux-fsdevel+bounces-55681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627B6B0DA53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454537B2279
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00AD2EA146;
	Tue, 22 Jul 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOCsH5sL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D112E9EB2;
	Tue, 22 Jul 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189100; cv=none; b=JJ97mALl/Vq4wAfpU5QmkVPa4f/TaHEehgUqV3hOPZBsjxLS3PmCz7vMVwnSsJ6C0Fg+9WirFg3uDdaXK4RO+u/rywonTktxM8sE5LjnGsqUmas0kUyt1EbJSRmTDkpzHQ01g6NJZb8yJQiW0LDXG6XZZ8USbpx55sGIFT5lIRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189100; c=relaxed/simple;
	bh=507TswfPqPaFWG+Ii24NSg6PgIkRzK9SJ5MsY9om0+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qjk7ODupel5Vv+LrxKos80L1hD5W229nwVJCLnEV/vs8o5oV7t53K2RrTi8toULxYtwR2aT2P+8douXhnYucn7nlsVB+XS5/Kiz4A7tUN9sTGdfyqSTu6kYid0DcaPqz68Zi99K8nk5PfK48qB4Tj8j6D7JVzHpIy780TcHhtjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOCsH5sL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCEEC4CEF1;
	Tue, 22 Jul 2025 12:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189099;
	bh=507TswfPqPaFWG+Ii24NSg6PgIkRzK9SJ5MsY9om0+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOCsH5sLA4+p9ndIHV7dScJ058U0nzJyF7r00Ka//S5FpmO7s9F+rLgJfRfegzDlA
	 RCYGAKjaSAC/S07KfSzUdjIoTBs2wLuaIu8SsNZnEtR59cWQb5yY04+9pyRrKkieLG
	 5WRnjdvSj+yC94/WqrCBxzWjeY7AgpSp4FWO26/JL2Bmheypz35Tsyot6qYOsQraOF
	 H2o61rLA0Ec3j6tXEFnA9dYhu68GJI2yQlZ/Jx9y73VDzjVxjW86O8HuTPIgauu+GU
	 SsrnY3MHk/FWUvTAN6XLTZz/n7n1xDeju0XqbWaVgCa0dIw10lv7hHZXM7rLQWmHnL
	 opIHT8Cdru84A==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH RFC DRAFT v2 11/13] ext4: move fsverity to filesystem inode
Date: Tue, 22 Jul 2025 14:57:17 +0200
Message-ID: <20250722-work-inode-fscrypt-v2-11-782f1fdeaeba@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
References: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=4474; i=brauner@kernel.org; h=from:subject:message-id; bh=507TswfPqPaFWG+Ii24NSg6PgIkRzK9SJ5MsY9om0+M=; b=kA0DAAoWkcYbwGV43KIByyZiAGh/irOgBiC8iN6tZHOZLW9kMbPhgfvX/YWXofIuUh7r7Z1rg Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmh/irMACgkQkcYbwGV43KKCNQEAi0Q6 dsuYKWJCBWfiPExbyIt3BESnHrt5mKivqQxLGDMBAO55dDHHlgh/CQB/K4sgf+609yhus3+GjCP mgKI182kB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fsverity data pointer into the filesystem's private inode and
record the offset from the embedded struct inode.

This will allow us to drop the fsverity data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/ext4.h    |  4 ++++
 fs/ext4/file.c    |  4 ++++
 fs/ext4/namei.c   |  8 ++++++++
 fs/ext4/super.c   |  3 +++
 fs/ext4/symlink.c | 12 ++++++++++++
 5 files changed, 31 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index e9710366d87a..d388a7fb1a87 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1201,6 +1201,10 @@ struct ext4_inode_info {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct fscrypt_inode_info	*i_fscrypt_info;
 #endif
+
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info	*i_fsverity_info;
+#endif
 };
 
 /*
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 9bdee2757bdf..06347086b87e 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -984,6 +984,10 @@ const struct inode_operations ext4_file_inode_operations = {
 #ifdef CONFIG_FS_ENCRYPTION
 	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
 			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct ext4_inode_info, i_fsverity_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
 #endif
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_file_getattr,
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index fb953834265c..c80ac16d9ca8 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -4217,6 +4217,10 @@ const struct inode_operations ext4_dir_inode_operations = {
 #ifdef CONFIG_FS_ENCRYPTION
 	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
 			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct ext4_inode_info, i_fsverity_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
 #endif
 	.create		= ext4_create,
 	.lookup		= ext4_lookup,
@@ -4242,6 +4246,10 @@ const struct inode_operations ext4_special_inode_operations = {
 #ifdef CONFIG_FS_ENCRYPTION
 	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
 			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct ext4_inode_info, i_fsverity_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
 #endif
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6085d6c9169b..f003b23a62e7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1414,6 +1414,9 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	spin_lock_init(&ei->i_fc_lock);
 #ifdef CONFIG_FS_ENCRYPTION
 	ei->i_fscrypt_info = NULL;
+#endif
+#ifdef CONFIG_FS_VERITY
+	ei->i_fsverity_info = NULL;
 #endif
 	return &ei->vfs_inode;
 }
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index 6b67a9a5c02c..4cb96956a17e 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -118,6 +118,10 @@ const struct inode_operations ext4_encrypted_symlink_inode_operations = {
 #ifdef CONFIG_FS_ENCRYPTION
 	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
 			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct ext4_inode_info, i_fsverity_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
 #endif
 	.get_link	= ext4_encrypted_get_link,
 	.setattr	= ext4_setattr,
@@ -129,6 +133,10 @@ const struct inode_operations ext4_symlink_inode_operations = {
 #ifdef CONFIG_FS_ENCRYPTION
 	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
 			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct ext4_inode_info, i_fsverity_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
 #endif
 	.get_link	= ext4_get_link,
 	.setattr	= ext4_setattr,
@@ -140,6 +148,10 @@ const struct inode_operations ext4_fast_symlink_inode_operations = {
 #ifdef CONFIG_FS_ENCRYPTION
 	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
 			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct ext4_inode_info, i_fsverity_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
 #endif
 	.get_link	= simple_get_link,
 	.setattr	= ext4_setattr,

-- 
2.47.2


