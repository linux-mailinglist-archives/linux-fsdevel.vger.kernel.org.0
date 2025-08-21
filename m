Return-Path: <linux-fsdevel+bounces-58520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D544AB2EA42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFCDA062B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10351F8676;
	Thu, 21 Aug 2025 01:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT0gyjge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957A5FEE6;
	Thu, 21 Aug 2025 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738786; cv=none; b=Ew7RI2QhKRvPD+2pJH9frj9iaRqgkra5TWyduEIZWhCut1oM+k6Q6AsZs4bx06rR5bMfyhpY8TFUC/Ym/zG6USkSd1pMfkCktAxp/Ji/da07D6RSCXBKlLES9BSClNB0E1TWUDVcXAjt18owVSHR8QtyVdp391Ysw0jYKvu3rLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738786; c=relaxed/simple;
	bh=qwOYLvi4G/65/MfehudT/ed/1/CiKRVbaDsLpiMtdfA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fud3QSXTxVs+DObtLgLQ79RjFQbjOJXBq8heIua8BbkhnSi6dogOHVtZGvPT023lgNcJkbCQ92Bv8CGefty/bq55tCd4Gm6Uro//diiyEEsWZ7b1Zlz4sW0HUnRnDeDqEbcNNQdq+pkQAJuw45TE5MkTVjXAdwW6G6OXUuqHuEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT0gyjge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A899DC4CEEB;
	Thu, 21 Aug 2025 01:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738785;
	bh=qwOYLvi4G/65/MfehudT/ed/1/CiKRVbaDsLpiMtdfA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DT0gyjgegj2TUX3TaGbgnYEd0OAtoJGG32RM7ayIsQ4NQGpHB/WTYchzLhiH0dObh
	 bWd89izSPiVBPwfLrM499l6Z1UMUpSyxcEvLb1BKrPjNw5GS9zaN4y1OqjjvqicxsO
	 XyBQfsqrs7wg8zwG77jQwxNp7JaOsGNXZ9f1KWxP2XGWumB3zMmn7KIjribDaYwiZx
	 hJ99f/qTugdGyyX3dDvKaIT38ReqrhstSuu4KMhtPvkuynPuC5E7+Pk3SLojj+Tsu3
	 uSc6YZDU+Xu0SQijJ7QKh4mTJof5Vk/aE9QSxRULxmeFIeAmEwMyi0dNevORXFGUZg
	 iSqwNEc0+2g+w==
Date: Wed, 20 Aug 2025 18:13:05 -0700
Subject: [PATCH 20/20] fuse4fs: create incore reverse orphan list
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <175573713168.20753.5541232630143908826.stgit@frogsfrogsfrogs>
In-Reply-To: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
References: <175573712721.20753.5223489399594191991.stgit@frogsfrogsfrogs>
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
 misc/fuse4fs.c |  178 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 4 deletions(-)


diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 3f88e98a20c203..cd7e30eaeb7757 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -351,10 +351,20 @@ static inline int u_log2(unsigned int arg)
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
@@ -396,12 +406,15 @@ static struct cache_node *icache_alloc(struct cache *c, cache_key_t key)
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
@@ -2164,10 +2177,31 @@ static int fuse4fs_add_to_orphans(struct fuse4fs *ff, ext2_ino_t ino,
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
@@ -2175,24 +2209,158 @@ static int fuse4fs_add_to_orphans(struct fuse4fs *ff, ext2_ino_t ino,
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
@@ -2212,6 +2380,7 @@ static int fuse4fs_remove_from_orphans(struct fuse4fs *ff, ext2_ino_t ino,
 			dbg_printf(ff, "%s: prev=%d\n",
 				   __func__, prev_orphan);
 
+			next_orphan = inode->i_dtime;
 			orphan.i_dtime = inode->i_dtime;
 			inode->i_dtime = 0;
 
@@ -2219,7 +2388,8 @@ static int fuse4fs_remove_from_orphans(struct fuse4fs *ff, ext2_ino_t ino,
 			if (err)
 				return translate_error(fs, prev_orphan, err);
 
-			return 0;
+			return fuse2fs_update_next_orphan_backlink(ff,
+					prev_orphan, ino, next_orphan);
 		}
 
 		dbg_printf(ff, "%s: orphan=%d next=%d\n",


