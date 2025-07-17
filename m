Return-Path: <linux-fsdevel+bounces-55375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42EDB09854
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01F35867AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E118241676;
	Thu, 17 Jul 2025 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tw59p4WB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D5BE46;
	Thu, 17 Jul 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795736; cv=none; b=T7V8Z+r+/Y+P8wPp620hR2cLnS2GSwkETXCafdDQwGfZOt8aIz2/IlmEsD/xDEQLMoN6VC/nqzqVjRX0/6a6L3VgXU4/bmppjvCaq65NTw4X8tTWfy2WlAJg22ZU4tz4aElF6EgMOzyV+WK7uLgqB7ix3/XB/k/92s66QKDeiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795736; c=relaxed/simple;
	bh=IAW0Ql1Kc5Z6LjL9S+fETaN2wjwriL0nTBGXdZSlxic=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3z/qj7ztCVVpQlZHwGalPhsoLxWr/W3S0T53h4d+69ildy2vAJ9Hr4yRP13D7MqLPS++BWgOD2j7JMH/NRXijpz93DbAb9hkQFmihmdOpzP1EB+bNKs0F03fNp0Rh77aU2YyKqvaPndNtQqbNatv1pAFS9lyjKnKANFRaIYHio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tw59p4WB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BE3C4CEE3;
	Thu, 17 Jul 2025 23:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795734;
	bh=IAW0Ql1Kc5Z6LjL9S+fETaN2wjwriL0nTBGXdZSlxic=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tw59p4WBXYUiyPKjDEWMlzhyZ1zan0kIJmcPtItHPDa9KICLrR2kX15j4haG0XXV6
	 SHDnfOguxTTRCumDiGU1IaEsbVCrFgxcO2cGKdrTRyrkqtkiKoyxKr53ID1fZSplOO
	 PhzqhVjS/SO2Z2tU9yQk9nwNPMp/QCY9hyDdmpiqgVkoj4MMpcmeyCstJwkYejyd5n
	 HLGcuLfGFUsKK3RJYO4fwSn8hwc4yOFKhZeiOBa75m8ojAQWWTE0L4jqvb7LKyr/9r
	 bXLZaPsJl99/Rwj3VEZQak63pRhSlYvR/eK+0tCNcPFnvCHHuE8GI8SWBCEUJKTv8D
	 pF9zMMTTjIUUA==
Date: Thu, 17 Jul 2025 16:42:14 -0700
Subject: [PATCH 11/22] fuse2fs: turn on iomap for pagecache IO
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461232.715479.2021022656537276961.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
References: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 7 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 8c3cc7adc72579..a8fb18650ec080 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1346,6 +1346,10 @@ static void *op_init(struct fuse_conn_info *conn
 	if (fuse2fs_iomap_enabled(ff))
 		fuse_set_feature_flag(conn, FUSE_CAP_IOMAP_DIRECTIO);
 #endif
+#if defined(HAVE_FUSE_IOMAP) && defined(FUSE_CAP_IOMAP_FILEIO)
+	if (fuse2fs_iomap_enabled(ff))
+		fuse_set_feature_flag(conn, FUSE_CAP_IOMAP_FILEIO);
+#endif
 
 	/*
 	 * If we're mounting in iomap mode, we need to unmount in op_destroy
@@ -5239,9 +5243,6 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 {
 	errcode_t err;
 
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	/* fall back to slow path for inline data reads */
 	if (inode->i_flags & EXT4_INLINE_DATA_FL)
 		return -ENOSYS;
@@ -5322,9 +5323,6 @@ static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,
 	errcode_t err;
 	int ret;
 
-	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
-		return -ENOSYS;
-
 	if (pos >= max_size)
 		return -EFBIG;
 
@@ -5422,12 +5420,51 @@ static int op_iomap_begin(const char *path, uint64_t nodeid, uint64_t attr_ino,
 	return ret;
 }
 
+static int fuse2fs_iomap_append_setsize(struct fuse2fs *ff, ext2_ino_t ino,
+					loff_t newsize)
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
 
@@ -5442,7 +5479,21 @@ static int op_iomap_end(const char *path, uint64_t nodeid, uint64_t attr_ino,
 		   written,
 		   iomap->flags);
 
-	return 0;
+	fuse2fs_start(ff);
+
+	/* XXX is this really necessary? */
+	if ((opflags & FUSE_IOMAP_OP_WRITE) &&
+	    !(opflags & FUSE_IOMAP_OP_DIRECT) &&
+	    (iomap->flags & FUSE_IOMAP_F_SIZE_CHANGED) &&
+	    written > 0) {
+		ret = fuse2fs_iomap_append_setsize(ff, attr_ino, pos + written);
+		if (ret)
+			goto out_unlock;
+	}
+
+out_unlock:
+	fuse2fs_finish(ff, ret);
+	return ret;
 }
 
 /*


