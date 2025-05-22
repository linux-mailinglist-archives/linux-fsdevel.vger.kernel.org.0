Return-Path: <linux-fsdevel+bounces-49640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB279AC0128
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129C11BC44BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09DF20EB;
	Thu, 22 May 2025 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKdNG1u7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27875645;
	Thu, 22 May 2025 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872730; cv=none; b=FGkWcPnwOGfP5zrmjick1DAwJfZexoRSEOJHanVb7voQ6ptFzsuJORVADToDc/nS4zKYA1qHMP/cb6gD1YpEPv2fz0qGIUx1Zkjy6Vr3rrXeS48K7Z2MTDwilxgT8f68OLgZi8RqBI5wx0V05xQfaBXMDWtEbGcuuwaph/yS0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872730; c=relaxed/simple;
	bh=FVKvZDzwwjDBlN5cJ8s8Uwys2Yv4tVE23Eg4QIh9iWg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fF8EnRumLM1iJxOg0xATUlW1nxqsR7MeMjCqclpTOhifP14Tx4mkCWtFXAxTCQYdL1ZGfCmMimmolraeIVelLWdgStevu/jTutBlyeIn5wQr60WH+ZUiTFR9VyEJggn11OprGk9WozzdcPUn63PK2OWa0ipBivK+437EPmK402Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKdNG1u7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815A3C4CEE4;
	Thu, 22 May 2025 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872729;
	bh=FVKvZDzwwjDBlN5cJ8s8Uwys2Yv4tVE23Eg4QIh9iWg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MKdNG1u7nyl82mXaYnq3Ro9C+JYd1eGd9+6b/5vX3dROagBnRmdrjjlw0kY0631fk
	 TdusEKzdw3u5VTpuCNCtB8+Apu2vybOfugZcZUzzbF+1PuK7+d6MKaAQ11NtGQZn0b
	 7X6KYkQ3hsOeFw2dMK4PytUNjcHD7HvOEHSoaxcaaj0DBykx+WI4ppOZSntEoznN+O
	 Q138d2/RqxMsoMDXBYt2IdHG3YJH2/mPi5nIksg82EGGVbLM4mFIijhX7MMDQ3EVwP
	 s5zuJJFWry+tngTAGFSp2zPVChKPoICivt6ea3KoU+WRzgyRFkmZUfkmiUK8Km4dXI
	 y/x19yUGdI0hQ==
Date: Wed, 21 May 2025 17:12:09 -0700
Subject: [PATCH 05/16] fuse2fs: use tagged block IO for zeroing sub-block
 regions
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198523.1484996.7666857476962480399.stgit@frogsfrogsfrogs>
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

Change the punch hole helpers to use the tagged block IO commands now
that libext2fs uses tagged block IO commands for file IO.  We'll need
this in the next patch when we turn on selective IO manager cache
clearing and invalidation.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index b1f3002ec8c481..c0f868e8f01ed4 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4510,13 +4510,13 @@ static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
 	if (!blk || (retflags & BMAP_RET_UNINIT))
 		return 0;
 
-	err = io_channel_read_blk(fs->io, blk, 1, *buf);
+	err = io_channel_read_tagblk(fs->io, ino, blk, 1, *buf);
 	if (err)
 		return err;
 
 	memset(*buf + residue, 0, len);
 
-	return io_channel_write_blk(fs->io, blk, 1, *buf);
+	return io_channel_write_tagblk(fs->io, ino, blk, 1, *buf);
 }
 
 static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
@@ -4544,7 +4544,7 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	if (err)
 		return err;
 
-	err = io_channel_read_blk(fs->io, blk, 1, *buf);
+	err = io_channel_read_tagblk(fs->io, ino, blk, 1, *buf);
 	if (err)
 		return err;
 	if (!blk || (retflags & BMAP_RET_UNINIT))
@@ -4555,7 +4555,7 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	else
 		memset(*buf + residue, 0, fs->blocksize - residue);
 
-	return io_channel_write_blk(fs->io, blk, 1, *buf);
+	return io_channel_write_tagblk(fs->io, ino, blk, 1, *buf);
 }
 
 static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,


