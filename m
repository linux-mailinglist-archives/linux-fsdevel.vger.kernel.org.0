Return-Path: <linux-fsdevel+bounces-61612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B4DB58A48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BA9188F061
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D838B1C5F23;
	Tue, 16 Sep 2025 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc46e6AC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40258FC1D;
	Tue, 16 Sep 2025 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984168; cv=none; b=SZo0g3ZV5mzR0wDbRKB/XFTdK4KZ7puZNEiS8LbYZIvebLfLCFVslyCvcvL5JlJtttP9cu+5PN7CC3gS7QCd77sUkcpsiEGgh9EvfnYQAf87bfjg1Xoc14tAXdGplm08v/pPV0INyEwioEvUygVpxfwC/pJpP/CTP6KRN7z3AQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984168; c=relaxed/simple;
	bh=EOfiuPUAYz+qsjKKNNeU7ZJIr+FrHNyoNpj4M4UOUps=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAD/ajlvVJxd9ULtRlmlbevAKI0pHjq5dGN6LpfpNiEk2exQIdABBYxey5lqD9H9/olSifwRca1WY6XPu138K6N/Dpy7fuA374XlQKHOdX3breBJg3jou5qCpGmE+gvLDxQDP4y+mVZud6M3FTN8Qf4EU4hYZ0lLENPnGGr4A1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc46e6AC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A0DC4CEF1;
	Tue, 16 Sep 2025 00:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984167;
	bh=EOfiuPUAYz+qsjKKNNeU7ZJIr+FrHNyoNpj4M4UOUps=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jc46e6ACgUmGmpth83q7vyjr8mGrBmE+2L4gnlBB5k8V6QW1+jZ3ryVmkxZwRQcJA
	 pxNYQMoNuo6uWPi/rLrh3gOES2FagsVqXvBUQSUGbgRiOT0ao6AsHMFPSHOG5LfuoC
	 86C36ZdZk1xzviP9UZPtWY7HRSa78rPowg6S3/0RLuCRF2WS2xoESG1H/mLletstOw
	 OGziRJg4tRVqBoBkFf5Ig3LoW8pkowPrmJQ9OY0MElYYlX8YWykXF6ZKNjTgIwZf2p
	 mTqf6iwseNnol/Pz2/hRKVN63400yWQWrLSx0Gv06lf0X7aNnnVBC5L8D09Kgz8XG7
	 LwmWDp488snkA==
Date: Mon, 15 Sep 2025 17:56:07 -0700
Subject: [PATCH 21/21] fuse4fs: create incore reverse orphan list
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798161153.389252.13503698518033268560.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
References: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create an incore orphan list so that removing open unlinked inodes
doesn't take forever.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |  178 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 4 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 1015b13f4adac7..9a6913f6eef16a 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -356,10 +356,20 @@ static inline int u_log2(unsigned int arg)
 	return l;
 }
 
+/* inode is not on unlinked list */
+#define FUSE4FS_NULL_INO	((ext2_ino_t)~0ULL)
+
 struct fuse4fs_inode {
 	struct cache_node	i_cnode;
 	ext2_ino_t		i_ino;
 	unsigned int		i_open_count;
+
+	/*
+	 * FUSE4FS_NULL_INO: inode is not on the orphan list
+	 * 0: inode is the first on the orphan list
+	 * otherwise: inode is in the middle of the list
+	 */
+	ext2_ino_t		i_prev_orphan;
 };
 
 struct fuse4fs_ikey {
@@ -401,12 +411,15 @@ static struct cache_node *icache_alloc(struct cache *c, cache_key_t key)
 		return NULL;
 
 	fi->i_ino = ikey->i_ino;
+	fi->i_prev_orphan = FUSE4FS_NULL_INO;
 	return &fi->i_cnode;
 }
 
 static bool icache_flush(struct cache *c, struct cache_node *node)
 {
-	return false;
+	struct fuse4fs_inode *fi = ICNODE(node);
+
+	return fi->i_prev_orphan != FUSE4FS_NULL_INO;
 }
 
 static void icache_relse(struct cache *c, struct cache_node *node)
@@ -2186,10 +2199,31 @@ static int fuse4fs_add_to_orphans(struct fuse4fs *ff, ext2_ino_t ino,
 				  struct ext2_inode_large *inode)
 {
 	ext2_filsys fs = ff->fs;
+	struct fuse4fs_inode *fi;
+	ext2_ino_t orphan_ino = fs->super->s_last_orphan;
+	errcode_t err;
 
 	dbg_printf(ff, "%s: orphan ino=%d dtime=%d next=%d\n",
 		   __func__, ino, inode->i_dtime, fs->super->s_last_orphan);
 
+	/* Make the first orphan on the list point back to us */
+	if (orphan_ino != 0) {
+		err = fuse4fs_iget(ff, orphan_ino, &fi);
+		if (err)
+			return translate_error(fs, orphan_ino, err);
+
+		fi->i_prev_orphan = ino;
+		fuse4fs_iput(ff, fi);
+	}
+
+	/* Add ourselves to the head of the orphan list */
+	err = fuse4fs_iget(ff, ino, &fi);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	fi->i_prev_orphan = 0;
+	fuse4fs_iput(ff, fi);
+
 	inode->i_dtime = fs->super->s_last_orphan;
 	fs->super->s_last_orphan = ino;
 	ext2fs_mark_super_dirty(fs);
@@ -2197,24 +2231,158 @@ static int fuse4fs_add_to_orphans(struct fuse4fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
+/*
+ * Given the orphan list excerpt: prev_orphan -> ino -> next_orphan, set
+ * next_orphan's backpointer to ino's backpointer (prev_orphan), having removed
+ * ino from the orphan list.
+ */
+static int fuse2fs_update_next_orphan_backlink(struct fuse4fs *ff,
+					       ext2_ino_t prev_orphan,
+					       ext2_ino_t ino,
+					       ext2_ino_t next_orphan)
+{
+	struct fuse4fs_inode *fi;
+	errcode_t err;
+	int ret = 0;
+
+	err = fuse4fs_iget(ff, next_orphan, &fi);
+	if (err)
+		return translate_error(ff->fs, next_orphan, err);
+
+	dbg_printf(ff, "%s: ino=%d cached next=%d nextprev=%d prev=%d\n",
+		   __func__, ino, next_orphan, fi->i_prev_orphan,
+		   prev_orphan);
+
+	if (fi->i_prev_orphan != ino) {
+		ret = translate_error(ff->fs, next_orphan,
+				      EXT2_ET_FILESYSTEM_CORRUPTED);
+		goto out_iput;
+	}
+
+	fi->i_prev_orphan = prev_orphan;
+out_iput:
+	fuse4fs_iput(ff, fi);
+	return ret;
+}
+
+/*
+ * Remove ino from the orphan list the fast way.  Returns 1 for success, 0 if
+ * it didn't do anything, or a negative errno.
+ */
+static int fuse4fs_fast_remove_from_orphans(struct fuse4fs *ff, ext2_ino_t ino,
+					    struct ext2_inode_large *inode)
+{
+	struct ext2_inode_large orphan;
+	ext2_filsys fs = ff->fs;
+	struct fuse4fs_inode *fi;
+	ext2_ino_t prev_orphan;
+	ext2_ino_t next_orphan = 0;
+	errcode_t err;
+	int ret = 0;
+
+	err = fuse4fs_iget(ff, ino, &fi);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	prev_orphan = fi->i_prev_orphan;
+	switch (prev_orphan) {
+	case 0:
+		/* First inode in the list */
+		dbg_printf(ff, "%s: ino=%d cached superblock\n", __func__, ino);
+
+		fs->super->s_last_orphan = inode->i_dtime;
+		next_orphan = inode->i_dtime;
+		inode->i_dtime = 0;
+		ext2fs_mark_super_dirty(fs);
+		fi->i_prev_orphan = FUSE4FS_NULL_INO;
+		break;
+	case FUSE4FS_NULL_INO:
+		/* unknown */
+		dbg_printf(ff, "%s: ino=%d broken list??\n", __func__, ino);
+		ret = 0;
+		goto out_iput;
+	default:
+		/* We're in the middle of the list */
+		err = fuse4fs_read_inode(fs, prev_orphan, &orphan);
+		if (err) {
+			ret = translate_error(fs, prev_orphan, err);
+			goto out_iput;
+		}
+
+		dbg_printf(ff,
+ "%s: ino=%d cached prev=%d prevnext=%d next=%d\n",
+			   __func__, ino, prev_orphan, orphan.i_dtime,
+			   inode->i_dtime);
+
+		if (orphan.i_dtime != ino) {
+			ret = translate_error(fs, prev_orphan,
+					      EXT2_ET_FILESYSTEM_CORRUPTED);
+			goto out_iput;
+		}
+
+		fi->i_prev_orphan = FUSE4FS_NULL_INO;
+		orphan.i_dtime = inode->i_dtime;
+		next_orphan = inode->i_dtime;
+		inode->i_dtime = 0;
+
+		err = fuse4fs_write_inode(fs, prev_orphan, &orphan);
+		if (err) {
+			ret = translate_error(fs, prev_orphan, err);
+			goto out_iput;
+		}
+
+		break;
+	}
+
+	/*
+	 * Make the next orphaned inode point back to the our own previous list
+	 * entry
+	 */
+	if (next_orphan != 0) {
+		ret = fuse2fs_update_next_orphan_backlink(ff, prev_orphan, ino,
+							  next_orphan);
+		if (ret)
+			goto out_iput;
+	}
+	ret = 1;
+
+out_iput:
+	fuse4fs_iput(ff, fi);
+	return ret;
+}
+
 static int fuse4fs_remove_from_orphans(struct fuse4fs *ff, ext2_ino_t ino,
 				       struct ext2_inode_large *inode)
 {
 	ext2_filsys fs = ff->fs;
 	ext2_ino_t prev_orphan;
+	ext2_ino_t next_orphan;
 	errcode_t err;
+	int ret;
 
 	dbg_printf(ff, "%s: super=%d ino=%d next=%d\n",
 		   __func__, fs->super->s_last_orphan, ino, inode->i_dtime);
 
-	/* If we're lucky, the ondisk superblock points to us */
+	/*
+	 * Fast way: use the incore list, which doesn't include any orphans
+	 * that were already on the superblock when we mounted.
+	 */
+	ret = fuse4fs_fast_remove_from_orphans(ff, ino, inode);
+	if (ret < 0)
+		return ret;
+	if (ret == 1)
+		return 0;
+
+	/* Slow way: If we're lucky, the ondisk superblock points to us */
 	if (fs->super->s_last_orphan == ino) {
 		dbg_printf(ff, "%s: superblock\n", __func__);
 
+		next_orphan = inode->i_dtime;
 		fs->super->s_last_orphan = inode->i_dtime;
 		inode->i_dtime = 0;
 		ext2fs_mark_super_dirty(fs);
-		return 0;
+		return fuse2fs_update_next_orphan_backlink(ff, 0, ino,
+							   next_orphan);
 	}
 
 	/* Otherwise walk the ondisk orphan list. */
@@ -2234,6 +2402,7 @@ static int fuse4fs_remove_from_orphans(struct fuse4fs *ff, ext2_ino_t ino,
 			dbg_printf(ff, "%s: prev=%d\n",
 				   __func__, prev_orphan);
 
+			next_orphan = inode->i_dtime;
 			orphan.i_dtime = inode->i_dtime;
 			inode->i_dtime = 0;
 
@@ -2241,7 +2410,8 @@ static int fuse4fs_remove_from_orphans(struct fuse4fs *ff, ext2_ino_t ino,
 			if (err)
 				return translate_error(fs, prev_orphan, err);
 
-			return 0;
+			return fuse2fs_update_next_orphan_backlink(ff,
+					prev_orphan, ino, next_orphan);
 		}
 
 		dbg_printf(ff, "%s: orphan=%d next=%d\n",


