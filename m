Return-Path: <linux-fsdevel+bounces-55680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC872B0DA46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B893A77F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841D22E9ED9;
	Tue, 22 Jul 2025 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr/FlHD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09332D8DDF;
	Tue, 22 Jul 2025 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189097; cv=none; b=KtLknSrg0QZiW9o4cDuAduHvYdBHnV/Clr6zvvsc8hpg61uTg9d/9EgDswIv2iffO05x46LQORjw7i0aZSizcRBWPyzCK0kaRKYM1Ex4FaFVwLenArmaWlTmXiyL8kHSZuKChH70Y8z23l6mHraboWI7inVMKXe4Fd+qTpfVKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189097; c=relaxed/simple;
	bh=X26eArQQTqs2kWle9Cv4h9v2dlqJsfjGwnIHVzK5894=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kG1Cfn6g1JoaCYkzj//aaS+vN4VR53HFQ9RVSSAYnoizlPBAFM2npyc5P7mgVH4d4R7vZFlYZIRSe9FvKuHxijbE6CD5MMt/mCtDg4Y9hr6F4YMvaPlVCdIVnU9HFDTC7/42QDuM3NRBDun8CI0pZaGimr9NU390viRPy3apXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr/FlHD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D86C4CEF1;
	Tue, 22 Jul 2025 12:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189096;
	bh=X26eArQQTqs2kWle9Cv4h9v2dlqJsfjGwnIHVzK5894=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qr/FlHD0oNwvyvVnB4CVRxi+FEE+mJdeUrIIXyRvaV5YMkoMLoRz4SCzTo3foc7yp
	 S6E4PrwKb3lu8hrXdxr2ni6sNBAS8MMNBW2/tF3cdkCVGT1mu6men7SmbaofyilSvl
	 JxKgu5r+Z8JJIqt27rEifavifVKMmpn4AdmSW9I9H46n2itNCgu8isBZCxjiwcKGbk
	 PQFQYZXpWHVy5qMHe1y2DIrs5Nf3T0RQdQpcDIwR8/Jr1o54UMPZ3NeVxdAe8iSdhj
	 UT9g9UeLWPx0b9xEEUYFL5dp+ppm8yOWXNtJPtsmJ0qK7irPHHdG/JITzEsZwKZij3
	 +cZyjuG5kUxpQ==
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
Subject: [PATCH RFC DRAFT v2 10/13] btrfs: move fsverity to filesystem inode
Date: Tue, 22 Jul 2025 14:57:16 +0200
Message-ID: <20250722-work-inode-fscrypt-v2-10-782f1fdeaeba@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3052; i=brauner@kernel.org; h=from:subject:message-id; bh=X26eArQQTqs2kWle9Cv4h9v2dlqJsfjGwnIHVzK5894=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUd21Wn18dfMXg1DrpZZkatxO9Uj+X20Qt6/s/uSp62 0T1J2fud5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkTCbDP+2dR5YlRHS/baiL Yys+Wmnyd6N3aF+vn67kUttny21XJTL80+qMXM5stijix+Lklql8hWEvZyx4MSdG6oOa2+XfG4u dOQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fsverity data pointer into the filesystem's private inode and
record the offset from the embedded struct inode.

This will allow us to drop the fsverity data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/btrfs/btrfs_inode.h |  3 +++
 fs/btrfs/inode.c       | 20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index a79fa0726f1d..10852d13fa00 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -339,6 +339,9 @@ struct btrfs_inode {
 
 	struct rw_semaphore i_mmap_lock;
 	struct inode vfs_inode;
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info *i_fsverity_info;
+#endif
 };
 
 static inline u64 btrfs_get_first_dir_index_to_log(const struct btrfs_inode *inode)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c0c778243bf1..634be0e32759 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7873,7 +7873,9 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
 	INIT_LIST_HEAD(&ei->delayed_iput);
 	init_rwsem(&ei->i_mmap_lock);
-
+#ifdef CONFIG_FS_VERITY
+	ei->i_fsverity_info = NULL;
+#endif
 	return inode;
 }
 
@@ -10410,6 +10412,10 @@ struct btrfs_inode *btrfs_find_first_inode(struct btrfs_root *root, u64 min_ino)
 }
 
 static const struct inode_operations btrfs_dir_inode_operations = {
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct btrfs_inode, i_fsverity_info) -
+			  offsetof(struct btrfs_inode, vfs_inode),
+#endif
 	.getattr	= btrfs_getattr,
 	.lookup		= btrfs_lookup,
 	.create		= btrfs_create,
@@ -10471,6 +10477,10 @@ static const struct address_space_operations btrfs_aops = {
 };
 
 static const struct inode_operations btrfs_file_inode_operations = {
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct btrfs_inode, i_fsverity_info) -
+			  offsetof(struct btrfs_inode, vfs_inode),
+#endif
 	.getattr	= btrfs_getattr,
 	.setattr	= btrfs_setattr,
 	.listxattr      = btrfs_listxattr,
@@ -10483,6 +10493,10 @@ static const struct inode_operations btrfs_file_inode_operations = {
 	.fileattr_set	= btrfs_fileattr_set,
 };
 static const struct inode_operations btrfs_special_inode_operations = {
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct btrfs_inode, i_fsverity_info) -
+			  offsetof(struct btrfs_inode, vfs_inode),
+#endif
 	.getattr	= btrfs_getattr,
 	.setattr	= btrfs_setattr,
 	.permission	= btrfs_permission,
@@ -10492,6 +10506,10 @@ static const struct inode_operations btrfs_special_inode_operations = {
 	.update_time	= btrfs_update_time,
 };
 static const struct inode_operations btrfs_symlink_inode_operations = {
+#ifdef CONFIG_FS_VERITY
+	.i_fsverity	= offsetof(struct btrfs_inode, i_fsverity_info) -
+			  offsetof(struct btrfs_inode, vfs_inode),
+#endif
 	.get_link	= page_get_link,
 	.getattr	= btrfs_getattr,
 	.setattr	= btrfs_setattr,

-- 
2.47.2


