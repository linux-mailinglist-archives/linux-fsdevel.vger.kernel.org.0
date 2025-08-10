Return-Path: <linux-fsdevel+bounces-57218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF0BB1F939
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258267AA5B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 08:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF31A270ED7;
	Sun, 10 Aug 2025 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvISGINg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DDC24C060;
	Sun, 10 Aug 2025 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754812813; cv=none; b=sZhH4rm09wHUl9FQSTXz/oI9gXC+bjIg5mmEVHsGREy3wpF+Bmj9fEp8FW0e0jX/eH7Y0wpupYRAEyjWIdHKtyKIobUmXengJ5iwv/hhnr/DZNvnC1LNejP9YFXeYNoCjVNFcPST/qt6dmx8cljS7F7QbXdMbPX2wyX//uqzQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754812813; c=relaxed/simple;
	bh=uSWAqJvL/RiAtfpBphLEdbPpxmsErLOL7QyUHYYHGg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0oqI5bAsoDyKcYWYp88AXfEBRhR+FwWygzozXp39T5t6j5TP7MSxrvJxkrO76raOU1uv9RDuyCpjx0zK2TprCvAeA6rJN3q6ELMkXu+UQ0t0BNxfvI1EPGxKolm7nlD4WhZ8427UB8L7HDwEqMSyKOJDZJC7YdWs3VZbMzJ00Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvISGINg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3376CC19421;
	Sun, 10 Aug 2025 08:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754812812;
	bh=uSWAqJvL/RiAtfpBphLEdbPpxmsErLOL7QyUHYYHGg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvISGINgSttzGx8S1Yo6P0RNV1i2csXZr4uItP+Yiv8ictOEXawreDSudyFW5/fK3
	 TrwPhv1wyy4MawAWSn2oSte2ZGC1l5i5yo6Jtv2FSBFQ/p2zYBEF9QutXIQiBecGmi
	 JpxfpZIcybAHf26NvHx6M0iOxLRcc/g0TGocFP8mTe0GO5rP4SutVwcgL3p8EGl4uN
	 qUS2D/z/OLXWkHCjIv8gzAGFAcRuZoAivquHz1RBh847/S+SFMxhbYwiwFbk45SmQS
	 bBQlYp+rFGlZeRYHd59Wsn6XV4FG+gZ/PDxO+U3ame2WBmS/tDBEH2Tz1E4UFj/ith
	 d3raZqdhdM4RQ==
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
Subject: [PATCH v5 11/13] btrfs: move verity info pointer to fs-specific part of inode
Date: Sun, 10 Aug 2025 00:57:04 -0700
Message-ID: <20250810075706.172910-12-ebiggers@kernel.org>
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

Move the fsverity_info pointer into the filesystem-specific part of the
inode by adding the field btrfs_inode::i_verity_info and configuring
fsverity_operations::inode_info_offs accordingly.

This is a prerequisite for a later commit that removes
inode::i_verity_info, saving memory and improving cache efficiency on
filesystems that don't support fsverity.

Co-developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/btrfs/btrfs_inode.h | 5 +++++
 fs/btrfs/inode.c       | 3 +++
 fs/btrfs/verity.c      | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b99fb02732929..2c9489497cbea 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -336,10 +336,15 @@ struct btrfs_inode {
 
 	/* Hook into fs_info->delayed_iputs */
 	struct list_head delayed_iput;
 
 	struct rw_semaphore i_mmap_lock;
+
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info *i_verity_info;
+#endif
+
 	struct inode vfs_inode;
 };
 
 static inline u64 btrfs_get_first_dir_index_to_log(const struct btrfs_inode *inode)
 {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b77dd22b8cdbe..de722b232ec14 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7959,10 +7959,13 @@ int btrfs_drop_inode(struct inode *inode)
 static void init_once(void *foo)
 {
 	struct btrfs_inode *ei = foo;
 
 	inode_init_once(&ei->vfs_inode);
+#ifdef CONFIG_FS_VERITY
+	ei->i_verity_info = NULL;
+#endif
 }
 
 void __cold btrfs_destroy_cachep(void)
 {
 	/*
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index b7a96a005487e..4633cbcfcdb90 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -800,10 +800,12 @@ static int btrfs_write_merkle_tree_block(struct inode *inode, const void *buf,
 	return write_key_bytes(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY,
 			       pos, buf, size);
 }
 
 const struct fsverity_operations btrfs_verityops = {
+	.inode_info_offs         = (int)offsetof(struct btrfs_inode, i_verity_info) -
+				   (int)offsetof(struct btrfs_inode, vfs_inode),
 	.begin_enable_verity     = btrfs_begin_enable_verity,
 	.end_enable_verity       = btrfs_end_enable_verity,
 	.get_verity_descriptor   = btrfs_get_verity_descriptor,
 	.read_merkle_tree_page   = btrfs_read_merkle_tree_page,
 	.write_merkle_tree_block = btrfs_write_merkle_tree_block,
-- 
2.50.1


