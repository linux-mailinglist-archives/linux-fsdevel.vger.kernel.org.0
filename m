Return-Path: <linux-fsdevel+bounces-18216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D518B6855
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165E7282CAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD0DFC12;
	Tue, 30 Apr 2024 03:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXPAHHLo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2A1078F;
	Tue, 30 Apr 2024 03:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447243; cv=none; b=rBvEO2+iKze6MYn93QGe0e6Q5xq7HwHm1e55ppfvbZSc/vtMUTGNQkyjIqFa3yV1IkbuQB5jlxagpQJ+M03LY7YptJXF5F5VMaJ5KdJ56M2mWK+CVam5i+esl2aSy86UnfnIlolwqP88ypSj9NQuG/CBDDyTzfbJ3/J1UW3Rh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447243; c=relaxed/simple;
	bh=sKqNwK37OzWtHb7C8XlJ1v1Q1SWgKygPbIsG8JBKfOY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0jtSJRyTkWnn32E/+AEbEdhRJCjdf1oGKjVyAuCVHbmw1JyWVkqhG6vf8LLQGzRiioAxxXAcvRLWPKO00zm8JCJxq3f83y74k1JdxmPu5ZgtNd59YL25ilhCi27G8xZDDYa4ijvxdIcIOJSkK3IWULH8uh9P2982DCstlbbCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXPAHHLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCA1C116B1;
	Tue, 30 Apr 2024 03:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447243;
	bh=sKqNwK37OzWtHb7C8XlJ1v1Q1SWgKygPbIsG8JBKfOY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dXPAHHLoRI5jR/PIWEA82LWX45fGT3HCtyxHEpBZ3QKiW18zc29p13NX+eZ1jy4RM
	 cKQoOknoWAIuAabMLxl2BIOgDrF7xZPnaZ2UaQ9UOnNWSrqvWTw9wSRHBo6zrxhziD
	 q/eYG2I8n7aU7uV43jqV7k1Ga2lsZbu2Tqkz2d9O48iMkxuNcxh9CvtM/eoqrDhExI
	 qFu87xD/5JyxQMQw8bZ6J3iTa/iPNrzCzhEaVB9xD1kwsZJEziGi3AWNU9cbrK16iI
	 s1gEgfKiuymV4IunKPoM1NqihqwYb82O2PkaSBui8VthUpuZsPQ/YUejtRmpRoDgGr
	 LSBNU5ch0KqzQ==
Date: Mon, 29 Apr 2024 20:20:43 -0700
Subject: [PATCH 05/18] fsverity: pass the merkle tree block level to
 fsverity_read_merkle_tree_block
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679675.955480.12163095281875879169.stgit@frogsfrogsfrogs>
In-Reply-To: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The XFS fsverity implementation will cache merkle tree blocks on its
own.  It would be great if the shrinker that will be associated with
this cache could guesstimate the amount of pain associated with
reclaiming a cached merkle tree block.  We can use the tree level of a
block as this guesstimate, so export this information if we have it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/fsverity_private.h |    2 +-
 fs/verity/read_metadata.c    |    1 +
 fs/verity/verify.c           |   11 ++++++++---
 include/linux/fsverity.h     |    7 +++++++
 4 files changed, 17 insertions(+), 4 deletions(-)


diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index 8a41e27413284..c1f82a0ea4cfa 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -156,7 +156,7 @@ void __init fsverity_init_workqueue(void);
 
 int fsverity_read_merkle_tree_block(struct inode *inode,
 				    const struct merkle_tree_params *params,
-				    u64 pos, unsigned long ra_bytes,
+				    int level, u64 pos, unsigned long ra_bytes,
 				    struct fsverity_blockbuf *block);
 
 void fsverity_drop_merkle_tree_block(struct inode *inode,
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index 4011a02f5d32d..3ec6230425d65 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -40,6 +40,7 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 				      params->block_size - offs_in_block);
 
 		err = fsverity_read_merkle_tree_block(inode, &vi->tree_params,
+						      FSVERITY_STREAMING_READ,
 						      pos - offs_in_block,
 						      ra_bytes, &block);
 		if (err)
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 55ada2af290ac..daf2057dbe839 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -183,8 +183,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		else
 			ra_bytes = 0;
 
-		if (fsverity_read_merkle_tree_block(inode, params, hblock_pos,
-						    ra_bytes, block) != 0)
+		if (fsverity_read_merkle_tree_block(inode, params, level,
+						    hblock_pos, ra_bytes,
+						    block) != 0)
 			goto error;
 
 		if (is_hash_block_verified(inode, block, hblock_idx)) {
@@ -371,6 +372,8 @@ void __init fsverity_init_workqueue(void)
  * fsverity_read_merkle_tree_block() - read Merkle tree block
  * @inode: inode to which this Merkle tree block belongs
  * @params: merkle tree parameters
+ * @level: expected level of the block; level 0 are the leaves, -1 means a
+ * streaming read
  * @pos: byte position within merkle tree
  * @ra_bytes: try to read ahead this many bytes
  * @block: block to be loaded
@@ -379,7 +382,7 @@ void __init fsverity_init_workqueue(void)
  */
 int fsverity_read_merkle_tree_block(struct inode *inode,
 				    const struct merkle_tree_params *params,
-				    u64 pos, unsigned long ra_bytes,
+				    int level, u64 pos, unsigned long ra_bytes,
 				    struct fsverity_blockbuf *block)
 {
 	const struct fsverity_operations *vops = inode->i_sb->s_vop;
@@ -396,6 +399,8 @@ int fsverity_read_merkle_tree_block(struct inode *inode,
 	if (vops->read_merkle_tree_block) {
 		struct fsverity_readmerkle req = {
 			.inode = inode,
+			.level = level,
+			.num_levels = params->num_levels,
 			.ra_bytes = ra_bytes,
 		};
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index ad17f8553f9cf..15bf33be99d79 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -56,6 +56,9 @@ struct fsverity_blockbuf {
 /**
  * struct fsverity_readmerkle - Request to read a Merkle Tree block buffer
  * @inode: the inode to read
+ * @level: expected level of the block; level 0 are the leaves.
+ * 		A value of FSVERITY_STREAMING_READ means a streaming read.
+ * @num_levels: number of levels in the tree total
  * @ra_bytes: The number of bytes that should be prefetched starting at pos
  *		if the page at @block->offset isn't already cached.
  *		Implementations may ignore this argument; it's only a
@@ -64,8 +67,12 @@ struct fsverity_blockbuf {
 struct fsverity_readmerkle {
 	struct inode *inode;
 	unsigned long ra_bytes;
+	int level;
+	int num_levels;
 };
 
+#define FSVERITY_STREAMING_READ	(-1)
+
 /* Verity operations for filesystems */
 struct fsverity_operations {
 


