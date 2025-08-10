Return-Path: <linux-fsdevel+bounces-57210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17473B1F920
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455503BE94B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DAC2472A1;
	Sun, 10 Aug 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDcjjnng"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D9243951;
	Sun, 10 Aug 2025 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812809; cv=none; b=miTnqkc8GwVxsjq1yj6ae7KDNLnnlIzhYo3ce1b3VMgugjNcindoTsOJsLwDgw0hoxPA0jqz/3JR8tEURlRUOjWVBQpVpHLesVb7y1tXX62TmA6vmVNaO5jTVz4kdNAILnTlAVnnhIE9K9Atsso3r/0qbXvDA62NqWJ0dZXYd18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812809; c=relaxed/simple;
	bh=0QKYi4i563jkQBHgIWsIphouZcaUjg0BpGQZ0ifH+ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZSMbM4cFxcGIUsAa+l0RTn8X3vZo4PKIOv16V4Z0BeaYER7dHfd6jeGCsJoEWIMiRYujS0Z72hfJ7CWTCn5GNtGwaaKYlMLk4xi4alFR6mno7FKbowC6WcnU+L8Vz9GrYJNCZwaT29JdRO21qZLQKo/TAczCtVdZyy0envojyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDcjjnng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2CAC4CEF7;
	Sun, 10 Aug 2025 08:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754812809;
	bh=0QKYi4i563jkQBHgIWsIphouZcaUjg0BpGQZ0ifH+ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QDcjjnngyBOJ5esSVTp3mHZ3is51fgNdzKZ8LmYnb33VmjyO9RcMLkqreDQTZwjrB
	 2Rl6SoPZ9JRA6iNZndXA9iVpPeh/w8BMSKuWPZBt+w/RQvB/3uKBDXfMFh6p/7GRSV
	 UgE3NLSJpf1mCsoM8OWYSmiwvjGefsN0I+CUPLy7lbyEuiQKbAK/MamSqDeEggHRBN
	 BoQw6FAVCBXodbd4VKYsNP+5j/531I3hzTyxmBD1qdvjet8VZdYSWx14mRU83iJioL
	 S3lzoNyBVxRI9jJ7QQ1L0oYfj7MOwRDwOpfXI9AVowxFIhA1A2xbk96nakWEhhadeK
	 MgFISk3CIGUnA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mtd@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v5 03/13] ext4: move crypt info pointer to fs-specific part of inode
Date: Sun, 10 Aug 2025 00:56:56 -0700
Message-ID: <20250810075706.172910-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810075706.172910-1-ebiggers@kernel.org>
References: <20250810075706.172910-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the fscrypt_inode_info pointer into the filesystem-specific part of
the inode by adding the field ext4_inode_info::i_crypt_info and
configuring fscrypt_operations::inode_info_offs accordingly.

This is a prerequisite for a later commit that removes
inode::i_crypt_info, saving memory and improving cache efficiency with
filesystems that don't support fscrypt.

Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/ext4/crypto.c | 2 ++
 fs/ext4/ext4.h   | 4 ++++
 fs/ext4/super.c  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index 0a056d97e6402..cf0a0970c0956 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -225,10 +225,12 @@ static bool ext4_has_stable_inodes(struct super_block *sb)
 {
 	return ext4_has_feature_stable_inodes(sb);
 }
 
 const struct fscrypt_operations ext4_cryptops = {
+	.inode_info_offs	= (int)offsetof(struct ext4_inode_info, i_crypt_info) -
+				  (int)offsetof(struct ext4_inode_info, vfs_inode),
 	.needs_bounce_pages	= 1,
 	.has_32bit_inodes	= 1,
 	.supports_subblock_data_units = 1,
 	.legacy_key_prefix	= "ext4:",
 	.get_context		= ext4_get_context,
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 01a6e2de7fc3e..c897109dadb15 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1180,10 +1180,14 @@ struct ext4_inode_info {
 
 	/* Precomputed uuid+inum+igen checksum for seeding inode checksums */
 	__u32 i_csum_seed;
 
 	kprojid_t i_projid;
+
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_crypt_info;
+#endif
 };
 
 /*
  * File system states
  */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c7d39da7e733b..0c3059ecce37c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1468,10 +1468,13 @@ static void init_once(void *foo)
 	INIT_LIST_HEAD(&ei->i_orphan);
 	init_rwsem(&ei->xattr_sem);
 	init_rwsem(&ei->i_data_sem);
 	inode_init_once(&ei->vfs_inode);
 	ext4_fc_init_inode(&ei->vfs_inode);
+#ifdef CONFIG_FS_ENCRYPTION
+	ei->i_crypt_info = NULL;
+#endif
 }
 
 static int __init init_inodecache(void)
 {
 	ext4_inode_cachep = kmem_cache_create_usercopy("ext4_inode_cache",
-- 
2.50.1


