Return-Path: <linux-fsdevel+bounces-49644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A50AC0130
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 700E67B26E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077C928F3;
	Thu, 22 May 2025 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNfSSc/A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6483664D;
	Thu, 22 May 2025 00:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872792; cv=none; b=g/VjBC75QLvf/O0j1AvO9iiUVhLRJklt6vqnqwIFT1FN1w5eoTIjgMOStN4b5RHAUgT2s+y3nbsCAzeenwT7A+lzWpziI/gTkyqTnylnJ3dNPI21Dl1nMngb9yzwPc6BiuRBcwVkNPYKY25GOzuxoaHtAqPELp+kXQZmy4hyG0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872792; c=relaxed/simple;
	bh=U718/zdWrW1T8Sk5f6cYwhoMRQ9Ykiakpts5dgdq3To=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LB8LPSgvLQ+WXofqBCia/BN8n/vOOi/BUSGI57MhUBYwHQ9ZDoO/DZGaeMQLcWtCM5uTJX0hGlBEdkzVkznm1loL1q8jUD903GIuvZViMkFXvv5yTnqu48ATYg+j/K8N7BVJkEkxJrtNBaFJwTjno0Gy7/koxdw88AH2EFTrIuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNfSSc/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B812C4CEE4;
	Thu, 22 May 2025 00:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872792;
	bh=U718/zdWrW1T8Sk5f6cYwhoMRQ9Ykiakpts5dgdq3To=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qNfSSc/ARsMx+XBemfAe678wcS16d0ZlhhqaLyp0MF0zvrF8lFK75W+sHwIN0MxlM
	 EYlSLriL+U5td96B8zufl54TvWxmEnhj2A5OKc2OB16bCW6B9JuhDHDpDhNxzJ53iO
	 KnV9PG/2/SeI0+4hcwGJVlW9ex+FXqaIdAprwFchqLTZLkoVqYrUlGQ1SdwY9r5XO2
	 NNHkmsWBfF9kKlSlHKMopQzWU9JSDzE69eeGRPjSuSy43ZlSMJiUPkT/4720QZPG1i
	 Z57dZUp+ZExwkDwYvSoKmyGBUDiMvXd0g80+uX7fxynSLbzU6EAHm7DY/hLa748TLw
	 6RJj5fLS2qWhA==
Date: Wed, 21 May 2025 17:13:11 -0700
Subject: [PATCH 09/16] fuse2fs: turn on iomap for pagecache IO
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198595.1484996.5765521463651696077.stgit@frogsfrogsfrogs>
In-Reply-To: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
References: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Turn on iomap for pagecache IO to regular files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 7 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ec17f6203b4b70..7152979ed6694e 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1175,6 +1175,10 @@ static void *op_init(struct fuse_conn_info *conn
 	if (iomap_enabled(ff))
 		fuse_set_feature_flag(conn, FUSE_CAP_IOMAP_DIRECTIO);
 #endif
+#if defined(HAVE_FUSE_IOMAP) && defined(FUSE_CAP_IOMAP_PAGECACHE)
+	if (iomap_enabled(ff))
+		fuse_set_feature_flag(conn, FUSE_CAP_IOMAP_PAGECACHE);
+#endif
 
 	/* Clear the valid flag so that an unclean shutdown forces a fsck */
 	if (ff->writable) {
@@ -5017,9 +5021,6 @@ static int fuse_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 {
 	errcode_t err;
 
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
 		return -ENOSYS;
@@ -5099,9 +5100,6 @@ static int fuse_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
 	errcode_t err;
 	int ret;
 
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	if (pos >= max_size)
 		return -EFBIG;
 
@@ -5235,12 +5233,51 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	return ret;
 }
 
+static int iomap_append_setsize(struct fuse2fs *ff, ext2_ino_t ino,
+				loff_t newsize)
+{
+	ext2_filsys fs = ff->fs;
+	struct ext2_inode_large inode;
+	ext2_off64_t isize;
+	errcode_t err;
+
+	dbg_printf(ff, "%s: ino=%u newsize=%llu\n", __func__, ino,
+		   (unsigned long long)newsize);
+
+	err = fuse2fs_read_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	isize = EXT2_I_SIZE(&inode);
+	if (newsize <= isize)
+		return 0;
+
+	dbg_printf(ff, "%s: ino=%u oldsize=%llu newsize=%llu\n", __func__, ino,
+		   (unsigned long long)isize,
+		   (unsigned long long)newsize);
+
+	/*
+	 * XXX cheesily update the ondisk size even though we only want to do
+	 * the incore size until writeback happens
+	 */
+	err = ext2fs_inode_size_set(fs, EXT2_INODE(&inode), newsize);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	err = fuse2fs_write_inode(fs, ino, &inode);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	return 0;
+}
+
 static int op_iomap_end(const char *path, uint64_t nodeid, uint64_t attr_ino,
 			off_t pos, uint64_t count, uint32_t opflags,
 			ssize_t written, const struct fuse_iomap *iomap)
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 
@@ -5255,9 +5292,22 @@ static int op_iomap_end(const char *path, uint64_t nodeid, uint64_t attr_ino,
 		   opflags,
 		   written,
 		   iomap->flags);
+
+	if ((opflags & FUSE_IOMAP_OP_WRITE) &&
+	    !(opflags & FUSE_IOMAP_OP_DIRECT) &&
+	    (iomap->flags & FUSE_IOMAP_F_SIZE_CHANGED) &&
+	    written > 0) {
+		ret = iomap_append_setsize(ff, attr_ino, pos + written);
+		if (ret)
+			goto out_unlock;
+	}
+
+out_unlock:
+	if (ret < 0)
+		dbg_printf(ff, "%s: libfuse ret=%d\n", __func__, ret);
 	pthread_mutex_unlock(&ff->bfl);
 
-	return 0;
+	return ret;
 }
 
 static inline bool can_merge_mappings(const struct ext2fs_extent *left,


