Return-Path: <linux-fsdevel+bounces-79846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NF3Hjwfr2neOAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:27:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA2223FEA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FCD63069850
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 19:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFD73EDAAF;
	Mon,  9 Mar 2026 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzSuy/HA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B2364E82;
	Mon,  9 Mar 2026 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084273; cv=none; b=fPNobbxxWj/5Fi/Y6Zw8bBmiyVX+d35xZlkFOdIY7cS5NdaTCa8d0tOgd4fADNc91lFMTpoindfYoDj6O1+a1WZN/GsB2woTn270Z58w0XRRJOUesl2TCQGZU6UOR89dmtc9f/92v0aoflwvNN3I5GM2bAt2liWXBnzNhsKRn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084273; c=relaxed/simple;
	bh=GTiRK2sd3X+SG47fdZEJy9c8siSkYjUFGMkG+ufGJ9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iev/7iWk/Nq0/cyqaVSzIyC6CIgY2VtPKSy+LB+WTJVTALlbYbzFJqOl7F62SWCKsM9PKEYnXsNKgGCr0pKyLN9Dih3TizK17yX2owv3yRWaxw09VSyNxAQL0Zef0ZzZ2F9Va68rYnU5946UiWRA/DTJkpV/uAbLphCcI7Rb3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzSuy/HA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA1CC2BC9E;
	Mon,  9 Mar 2026 19:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773084272;
	bh=GTiRK2sd3X+SG47fdZEJy9c8siSkYjUFGMkG+ufGJ9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WzSuy/HA3SvLsWJJVMgc2Ygj+7SixaQU6vT1pznzJKOhs+H5gPF++eSnRwViHa4Iu
	 TS3v9KookcXa88G8tRLopRfE3invYQaZaoArpeLOSz5DNCiFWdlEs39POG8PmKBzzM
	 0DLphE/4Osmgr/WJSR7q2+e/j3850R7Gi9PQfM+6XfMEt6hKtJxB6HpP4q6vQWUOvX
	 XEeAxLXjLGV+hvUWVL/tza4oYTmPQYNPBeroQ2J/bZHjpFuwf8W2SpYIWxNA9qICfm
	 iDfgEtz5B5H/OCPxKnyKnDC0/m06ow8JVcoRCz9PuyLXMjl1oEvmjmYvRAZQQk+OW4
	 4wB39MVFKa4Qw==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	djwong@kernel.org
Subject: [PATCH v4 05/25] fsverity: pass digest size and hash of the empty block to ->write
Date: Mon,  9 Mar 2026 20:23:20 +0100
Message-ID: <20260309192355.176980-6-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260309192355.176980-1-aalbersh@kernel.org>
References: <20260309192355.176980-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CA2223FEA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79846-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Let filesystem iterate over hashes in the block and check if these are
hashes of zeroed data blocks. XFS will use this to decide if it want to
store tree block full of these hashes.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/btrfs/verity.c        | 6 +++++-
 fs/ext4/verity.c         | 4 +++-
 fs/f2fs/verity.c         | 4 +++-
 fs/verity/enable.c       | 4 +++-
 include/linux/fsverity.h | 6 +++++-
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 0062b3a55781..6d8d3808d75d 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -773,11 +773,15 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
  * @buf:	Merkle tree block to write
  * @pos:	the position of the block in the Merkle tree (in bytes)
  * @size:	the Merkle tree block size (in bytes)
+ * @zero_digest:	the hash of a merkle block-sized buffer of zeroes
+ * @digest_size:	size of zero_digest, in bytes
  *
  * Returns 0 on success or negative error code on failure
  */
 static int btrfs_write_merkle_tree_block(struct file *file, const void *buf,
-					 u64 pos, unsigned int size)
+					 u64 pos, unsigned int size,
+					 const u8 *zero_digest,
+					 unsigned int digest_size)
 {
 	struct inode *inode = file_inode(file);
 	loff_t merkle_pos = merkle_file_pos(inode);
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index ca61da53f313..347945ac23a4 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -374,7 +374,9 @@ static void ext4_readahead_merkle_tree(struct inode *inode, pgoff_t index,
 }
 
 static int ext4_write_merkle_tree_block(struct file *file, const void *buf,
-					u64 pos, unsigned int size)
+					u64 pos, unsigned int size,
+					const u8 *zero_digest,
+					unsigned int digest_size)
 {
 	pos += ext4_verity_metadata_pos(file_inode(file));
 
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 92ebcc19cab0..b3b3e71604ac 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -270,7 +270,9 @@ static void f2fs_readahead_merkle_tree(struct inode *inode, pgoff_t index,
 }
 
 static int f2fs_write_merkle_tree_block(struct file *file, const void *buf,
-					u64 pos, unsigned int size)
+					u64 pos, unsigned int size,
+					const u8 *zero_digest,
+					unsigned int digest_size)
 {
 	pos += f2fs_verity_metadata_pos(file_inode(file));
 
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 42dfed1ce0ce..ad4ff71d7dd9 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -50,7 +50,9 @@ static int write_merkle_tree_block(struct file *file, const u8 *buf,
 	int err;
 
 	err = inode->i_sb->s_vop->write_merkle_tree_block(file, buf, pos,
-							  params->block_size);
+							  params->block_size,
+							  params->zero_digest,
+							  params->digest_size);
 	if (err)
 		fsverity_err(inode, "Error %d writing Merkle tree block %lu",
 			     err, index);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index b490b2c8a393..1ca8de129323 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -124,6 +124,8 @@ struct fsverity_operations {
 	 * @buf: the Merkle tree block to write
 	 * @pos: the position of the block in the Merkle tree (in bytes)
 	 * @size: the Merkle tree block size (in bytes)
+	 * @zero_digest: the hash of a merkle block-sized buffer of zeroes
+	 * @digest_size: size of zero_digest, in bytes
 	 *
 	 * This is only called between ->begin_enable_verity() and
 	 * ->end_enable_verity().
@@ -131,7 +133,9 @@ struct fsverity_operations {
 	 * Return: 0 on success, -errno on failure
 	 */
 	int (*write_merkle_tree_block)(struct file *file, const void *buf,
-				       u64 pos, unsigned int size);
+				       u64 pos, unsigned int size,
+				       const u8 *zero_digest,
+				       unsigned int digest_size);
 };
 
 #ifdef CONFIG_FS_VERITY
-- 
2.51.2


