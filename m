Return-Path: <linux-fsdevel+bounces-55729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C899B0E42C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B4358167B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3003528504C;
	Tue, 22 Jul 2025 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyP2VFl+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B0284B4C;
	Tue, 22 Jul 2025 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212481; cv=none; b=ZGixPvLTSys17rN4+yZSj0N8Ek/SCvxMH1+YID7rsR0ywjXA+EGJQJ7z8NgwqrO4+yub7zMRsHLlHcX05v9Jd1S5+qqbMyfQLI97vTPS/3GlDWBZ6qtQOMAoW/c7JGC8RVjnwhnvTM1lG4w3TzlVgIVj940ju3UfnBARBhbfPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212481; c=relaxed/simple;
	bh=JfbACFl6ysDt5Vxbzil6fkQ8oKhjmpJrPtv+INp2Fkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpQRE/pNZevgnD170IpYKKFizPHWiMAKVcg+YHIMZ75FOPUsFPSkXji4OzPpYq0nOLZ1spF+xWDDKYxRuBvFZIs+6GiVCm0cLbwZi+fuXp5hIyMhGFTnDhA5Z+8YuOPmWWbgv3sayRJw8LFlNyxP+LJiJvEwTA3JnG3fPbiIPg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyP2VFl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A464C4CEF7;
	Tue, 22 Jul 2025 19:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753212481;
	bh=JfbACFl6ysDt5Vxbzil6fkQ8oKhjmpJrPtv+INp2Fkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyP2VFl+0YIwNeVz1z0TBS2MY99Ec2vO6Flss3XBgPOXHwoTpt6MbX0RGRLF+o7d+
	 gcdmoWypM81CAIKXnaz+2f2CTzXZP88cIutwkxyYITCwSnhS4we8j/xfPG3eQD4aBP
	 hU4N/S/sGRYk7JI4U9CAuLrc7LP/MmUgcfypXdSYiZ5FL3twHcO1Xe2ciU4Ka6mozd
	 8W4GH65ZdsBGSFvCrLEA9Qv6Y1jNyItP4cnZTY8IxsZyB1Aq9h9mWok/4YqQNJ5Gkb
	 ZutAw2gtDylf+SS7xjxxOYjzG3rvmtTmPJOtDUE1D4ZEbqzw9j5ctIqxtXzl7NTBM6
	 iFWU6yP61B1hw==
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
Subject: [PATCH v3 03/13] ext4: move fscrypt to filesystem inode
Date: Tue, 22 Jul 2025 21:27:21 +0200
Message-ID: <20250722-work-inode-fscrypt-v3-3-bdc1033420a0@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2193; i=brauner@kernel.org; h=from:subject:message-id; bh=JfbACFl6ysDt5Vxbzil6fkQ8oKhjmpJrPtv+INp2Fkc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUP5PtfHwgim3GE1bfxwxtpaq7c3bxVB5LtLA5dq12M afvFaunHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpbWBkeG1cti/vybEuL5dS uZOPt3CmL1J5/2j6TetV4TVbfmeoSDEyPJkrVH90jcFE78xbsvN3NW1/4W+U0nFqR+OjI5a1B78 dZwYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fscrypt data pointer into the filesystem's private inode and record
the offset from the embedded struct inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/ext4.h         | 4 ++++
 fs/ext4/mballoc-test.c | 4 ++++
 fs/ext4/super.c        | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18373de980f2..f27d57aea316 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1197,6 +1197,10 @@ struct ext4_inode_info {
 	__u32 i_csum_seed;
 
 	kprojid_t i_projid;
+
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info	*i_fscrypt_info;
+#endif
 };
 
 /*
diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index d634c12f1984..b8e039a666c3 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -53,6 +53,10 @@ static void mbt_free_inode(struct inode *inode)
 }
 
 static const struct super_operations mbt_sops = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
 	.alloc_inode	= mbt_alloc_inode,
 	.free_inode	= mbt_free_inode,
 };
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c7d39da7e733..2a03835b67d5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1412,6 +1412,9 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	spin_lock_init(&ei->i_fc_lock);
+#ifdef CONFIG_FS_ENCRYPTION
+	ei->i_fscrypt_info = NULL;
+#endif
 	return &ei->vfs_inode;
 }
 
@@ -1607,6 +1610,10 @@ static const struct quotactl_ops ext4_qctl_operations = {
 #endif
 
 static const struct super_operations ext4_sops = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt	= offsetof(struct ext4_inode_info, i_fscrypt_info) -
+			  offsetof(struct ext4_inode_info, vfs_inode),
+#endif
 	.alloc_inode	= ext4_alloc_inode,
 	.free_inode	= ext4_free_in_core_inode,
 	.destroy_inode	= ext4_destroy_inode,

-- 
2.47.2


