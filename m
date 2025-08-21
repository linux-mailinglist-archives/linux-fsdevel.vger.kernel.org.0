Return-Path: <linux-fsdevel+bounces-58539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC8B2EA74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C755E0E79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA20B1FAC42;
	Thu, 21 Aug 2025 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zuq5y0YW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148636CE02;
	Thu, 21 Aug 2025 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739084; cv=none; b=cxwlNsQqBP+eyVp022nsKT+ERBzBR7Om4Fu5ki1xgfzEJNa0rVQBjU5ZReL9Edvne6DXm+W0qaSJA2y9+GsWimKClGYx8k4vlgWeFLRANCmGH/fzeABz3qYUXTNng+EDXm7mSIjNAIJ99xypxKOVW4E4hbHp+6Ie1dAzZe/asTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739084; c=relaxed/simple;
	bh=geMGclj+G3S+zniYTxarX14FrdNwelJDGvlS3TzV4nQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2c4m5LK+0aDCCErORtyQFl3cYXAI5/BNX7CSI3Xr1U1X5sG5s0PEY3pb7nAebwXq/bGYydguxPeKJGD+u4+ACfhEcykMvNOkt0o+FgXEXq4UpNfxhYUVVUOy9Vu/KX7O0wNrgNLvKFwr7SCGJI6r468soi/iG+MOgc44Z3tdYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zuq5y0YW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF00C4CEE7;
	Thu, 21 Aug 2025 01:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739083;
	bh=geMGclj+G3S+zniYTxarX14FrdNwelJDGvlS3TzV4nQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Zuq5y0YWfHhwZYw1pKufA5mjYZO0UzHPO0TkqkQ5zwZv+XL0xJkT0MW9mkXtcguNg
	 9T/OGkDoTjGx64lPhRace7K/Xq0v6Cu+thUQ4AUEMsTxl3qeOdkiPmzO20dv7+Mmiz
	 Do4ZPq78DeUqbqbJAW4I8mL7HUwIIMaDBGoJVdBkk1qcoxtOyTBrm2ELP4GeV/hxA3
	 YkaOI9rgixHMhlBE0JAzByLVLUxoqwpiC21APYP9An52uALyK7TsNTW7JcCdYfFJTU
	 jLCiwnRlRBY5eujd3uI2D1SK4l7LgiLgI4LVI1rjgwP6yxdLPF+WrZg5BSjTZgZnA3
	 rRhVusNsPvvhA==
Date: Wed, 20 Aug 2025 18:18:03 -0700
Subject: [PATCH 09/19] fuse2fs: don't zero bytes in punch hole
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713892.21970.18164422790433615852.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
References: <175573713645.21970.9783397720493472605.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

When iomap is in use for the pagecache, it will take care of zeroing the
unaligned parts of punched out regions so we don't have to do it
ourselves.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    9 +++++++++
 misc/fuse4fs.c |    8 ++++++++
 2 files changed, 17 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 895addcbc59e04..dcf002f380b843 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -576,6 +576,7 @@ static inline int fuse2fs_iomap_enabled(const struct fuse2fs *ff)
 }
 #else
 # define fuse2fs_iomap_enabled(...)	(0)
+# define fuse2fs_iomap_enabled(...)	(0)
 #endif
 
 static inline void fuse2fs_dump_extents(struct fuse2fs *ff, ext2_ino_t ino,
@@ -4857,6 +4858,10 @@ static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
 	int retflags;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (fuse2fs_iomap_enabled(ff))
+		return 0;
+
 	if (!*buf) {
 		err = ext2fs_get_mem(fs->blocksize, buf);
 		if (err)
@@ -4893,6 +4898,10 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	off_t residue;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (fuse2fs_iomap_enabled(ff))
+		return 0;
+
 	residue = FUSE2FS_OFF_IN_FSB(ff, offset);
 	if (residue == 0)
 		return 0;
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 2373c5a371e2b0..3082c23e398adf 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -5265,6 +5265,10 @@ static errcode_t fuse4fs_zero_middle(struct fuse4fs *ff, ext2_ino_t ino,
 	int retflags;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (fuse4fs_iomap_enabled(ff))
+		return 0;
+
 	if (!*buf) {
 		err = ext2fs_get_mem(fs->blocksize, buf);
 		if (err)
@@ -5301,6 +5305,10 @@ static errcode_t fuse4fs_zero_edge(struct fuse4fs *ff, ext2_ino_t ino,
 	off_t residue;
 	errcode_t err;
 
+	/* the kernel does this for us in iomap mode */
+	if (fuse4fs_iomap_enabled(ff))
+		return 0;
+
 	residue = FUSE4FS_OFF_IN_FSB(ff, offset);
 	if (residue == 0)
 		return 0;


