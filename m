Return-Path: <linux-fsdevel+bounces-55812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A65B0F09C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9375640EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF67293B48;
	Wed, 23 Jul 2025 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqUCrzX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2229293D;
	Wed, 23 Jul 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268317; cv=none; b=grkUSzqBVlnG+b3Lb+CzQBSc90RbEnNYECUKNd9Paya7yXQk4icMRB6lXu9PYcHX3m0/Eeefysb6jA3imP5PjgboNWWSgEoeCdqvLOD91+LndQLHejc8czAiQypHm/1h84o6zCNwTE3ni7XUpEO71dY7vWVm8aQnCPHXUMXqCFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268317; c=relaxed/simple;
	bh=RMw2dBnDO1Ap9e7MdYubJ8PTn2HYnD6F0Hm0zF4NauQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZKf7A3pp0v8JaLvF0F+/IRQLM7kw/CnVrd9vAplaLA7ZUhBe/B/gUWyK4bZt9qDthUkUWumZGmc2MS7EMIVJjr7B0/j5SVsiUxOEjM5RXQUHcWwUWiSIL4MdzbIlBYcnw+TwYAuWyHRHSO0xq/J7K0qj9ZIWY1ie1FRdhyBaBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqUCrzX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C6FC4CEF5;
	Wed, 23 Jul 2025 10:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268317;
	bh=RMw2dBnDO1Ap9e7MdYubJ8PTn2HYnD6F0Hm0zF4NauQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqUCrzX1EFN7hLcka0re6ov2UcK3ikpLh8bYD0bS2xTQWTTSjfH6GfzbRKZ5ck6Yz
	 da7ByB0jANKHQyJPP2gH6UfFaJy9OC4SMbICsBXDRGeBdSKgXN2H0/o5FaJ12iQGAA
	 2vxe4cBB7Llvh/KifmIJhrvVEwRGr4I3uwadTxERFiwqyR5eGK0avKDe4iDU0zN08m
	 gj3Dnn5CWd8QwOd05EjdvMrvWSexuEHas12JKae88OH8vzUxM9F7VjBsnaocFCiFyQ
	 GJ9+8Cd7Ai/3OYNrPe2Decfabgh1XWBIWQfteuG3AtaUkySkWQD6yMAxOelXm3YcH+
	 Z4YPswG4v8iew==
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
Subject: [PATCH v4 11/15] btrfs: move fsverity to filesystem inode
Date: Wed, 23 Jul 2025 12:57:49 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-11-c8e11488a0e6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944; i=brauner@kernel.org; h=from:subject:message-id; bh=RMw2dBnDO1Ap9e7MdYubJ8PTn2HYnD6F0Hm0zF4NauQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HNBubvAXsM9+n7M32/JC9rZbqnHzLb0ZHpUzvzt/b It6X5F3RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET8HBn+aQp3Sq36VB0vEb5E bfU25q2G0dmLfr5fc2YPh4VpfJTXbIZ/NlO99v/yEZMxYmmImcsfuseD/YCoBUPG/rjC2JjLb54 yAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fsverity data pointer into the filesystem's private inode and
record the offset from the embedded struct inode.

This will allow us to drop the fsverity data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/btrfs/btrfs_inode.h | 3 +++
 fs/btrfs/inode.c       | 3 +++
 fs/btrfs/verity.c      | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index a79fa0726f1d..45a9221cf6cc 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -339,6 +339,9 @@ struct btrfs_inode {
 
 	struct rw_semaphore i_mmap_lock;
 	struct inode vfs_inode;
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info *i_verity_info;
+#endif
 };
 
 static inline u64 btrfs_get_first_dir_index_to_log(const struct btrfs_inode *inode)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c0c778243bf1..a5c39e93a6cd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7873,6 +7873,9 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&ei->delalloc_inodes);
 	INIT_LIST_HEAD(&ei->delayed_iput);
 	init_rwsem(&ei->i_mmap_lock);
+#ifdef CONFIG_FS_VERITY
+	ei->i_verity_info = NULL;
+#endif
 
 	return inode;
 }
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index b7a96a005487..487d6d00eff3 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -802,6 +802,10 @@ static int btrfs_write_merkle_tree_block(struct inode *inode, const void *buf,
 }
 
 const struct fsverity_operations btrfs_verityops = {
+#ifdef CONFIG_FS_VERITY
+	.inode_info_offs	= offsetof(struct btrfs_inode, i_verity_info) -
+				  offsetof(struct btrfs_inode, vfs_inode),
+#endif
 	.begin_enable_verity     = btrfs_begin_enable_verity,
 	.end_enable_verity       = btrfs_end_enable_verity,
 	.get_verity_descriptor   = btrfs_get_verity_descriptor,

-- 
2.47.2


