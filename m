Return-Path: <linux-fsdevel+bounces-61627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5C8B58A6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE842A44CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5BC1E32D6;
	Tue, 16 Sep 2025 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iv8Ok4ac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85F19F43A;
	Tue, 16 Sep 2025 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984402; cv=none; b=P1TouGspCmL2j4CJdJ3pi0iTspi3Q2AqMLHxe2YCxY6Ly6wEhEt8Hsmh3Hj246KZuEsuAJJG/40y0ZLFz4cwsPR7/FSe4FiwL0DYGars+2QgRD+4Ffp+s5ZZ4JyReF4+Hi8C4G6m33L9dEqhm1Y7JkqNdmtt6U/GgNnncCzmrl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984402; c=relaxed/simple;
	bh=BSXyg8WTRiSPxNbRPQlNANsph98TiTmgGyu8HQS8Ki8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5SStVn7MiIKkGHUQApKVz5VbYiZJOm9V9VJoSPGrDf9yeM0dJfPJh4WWlYYQ2NiNgUR4NGvCf/8l1SjffyjEwdKkNBU1cr5zUzAxgPIxGhL/rzxhxOzbxkRfUs0dk2cmebSFGjEkeGfLqZ2wPGvM6tGx0spwGdmG82Yi8Y+I0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv8Ok4ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D50C4CEF5;
	Tue, 16 Sep 2025 01:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984402;
	bh=BSXyg8WTRiSPxNbRPQlNANsph98TiTmgGyu8HQS8Ki8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Iv8Ok4ac4FdIaSv0nnqM8atDCP9DLVy6jXoTGkdLi3uYLUZORk72LIZRpzyEr35F/
	 hnM+OCCf/KPob/G1NTvUL2acVSUCLqhANJQk7f+7GsGhAjVFTY3ox/yg3316ZN11L8
	 PpOj4oCz6GLnYgVyIexa9mNHCO2+5qaQ9+6nXd70j843mXapxjUgXhn1wieVuGN4/6
	 lR84DV3zrUPVDy+WRSNLrlYJ20O5JLrekHLaGUMvc+r4mtN9+2jRE+c0pNEn1ofyPS
	 sDevZVo1pKrylh+uioh6UkxFuXenQOWWGN4MRz2QdD3Uqs9QiIFUO1ZvFoTrMdZKJV
	 Sp34KanZdjd0g==
Date: Mon, 15 Sep 2025 18:00:01 -0700
Subject: [PATCH 05/17] fuse2fs: implement directio file reads
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161809.390496.1402594231182652456.stgit@frogsfrogsfrogs>
In-Reply-To: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
References: <175798161643.390496.10274066827486065265.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement file reads via iomap.  Currently only directio is supported.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   14 +++++++++++++-
 misc/fuse2fs.c    |   14 +++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 958427efef04b7..90d94bb7404f90 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -5835,7 +5835,19 @@ static int fuse4fs_iomap_begin_read(struct fuse4fs *ff, ext2_ino_t ino,
 				    uint64_t count, uint32_t opflags,
 				    struct fuse_file_iomap *read)
 {
-	return -ENOSYS;
+	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
+		return -ENOSYS;
+
+	/* fall back to slow path for inline data reads */
+	if (inode->i_flags & EXT4_INLINE_DATA_FL)
+		return -ENOSYS;
+
+	if (inode->i_flags & EXT4_EXTENTS_FL)
+		return fuse4fs_iomap_begin_extent(ff, ino, inode, pos, count,
+						  opflags, read);
+
+	return fuse4fs_iomap_begin_indirect(ff, ino, inode, pos, count,
+					    opflags, read);
 }
 
 static int fuse4fs_iomap_begin_write(struct fuse4fs *ff, ext2_ino_t ino,
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index adaa25718ddaaf..31fd882dac4ef6 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5277,7 +5277,19 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 				    uint64_t count, uint32_t opflags,
 				    struct fuse_file_iomap *read)
 {
-	return -ENOSYS;
+	if (!(opflags & FUSE_IOMAP_OP_DIRECT))
+		return -ENOSYS;
+
+	/* fall back to slow path for inline data reads */
+	if (inode->i_flags & EXT4_INLINE_DATA_FL)
+		return -ENOSYS;
+
+	if (inode->i_flags & EXT4_EXTENTS_FL)
+		return fuse2fs_iomap_begin_extent(ff, ino, inode, pos, count,
+						  opflags, read);
+
+	return fuse2fs_iomap_begin_indirect(ff, ino, inode, pos, count,
+					    opflags, read);
 }
 
 static int fuse2fs_iomap_begin_write(struct fuse2fs *ff, ext2_ino_t ino,


