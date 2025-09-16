Return-Path: <linux-fsdevel+bounces-61620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE90B58A5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6121B26371
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB361DE8AF;
	Tue, 16 Sep 2025 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqOup76k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC22BB13;
	Tue, 16 Sep 2025 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984293; cv=none; b=cujtuDCL/Zhu0Cw4Q8KAizIAPuThEgZJ7ld7RxNEUlAFf7js3EU3RDFLScCFJ1/sFvkS+k/dkoVjIWtSyUb3uZ+uGJ7DPNTHuTGcNsV/4OzGsWm5UAp9GNYVTNQHtnRsoFW3+k4kvIY4RbfmpuEGSKrt/2rFBKzUE4d+Z8PEIIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984293; c=relaxed/simple;
	bh=dOVECjXnHQlvqibR2C6MFOknbi/gaeGv7Fs3OjqNujk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFywr2SzgjwwJpyR2An7ARfkurp8zNHY/cZSkS+mEEipU0q9LGBFms9DzJ6VOBJ3s0jhGhErfo/k4ql+L56tLEku9qW0DAlSpe8KZGzv4iGAbiQRprdZIwsO7BOIrVA10+nz7pE+NoQ64z1du452ggdcE8QqNPpqdEYjD56R4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqOup76k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A9FC4CEF1;
	Tue, 16 Sep 2025 00:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984292;
	bh=dOVECjXnHQlvqibR2C6MFOknbi/gaeGv7Fs3OjqNujk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KqOup76ksXgcCBkDmRcdDg01bTBAqZkk6ExQn1Sg0amGHAL9XuoKi+ME1XqZ/mPXk
	 Hy6IitPiKAuPGI8MviubauJn0KuZwaX6la1tKU5GmFg+NOYUWYQ8T4WBHzdSUd8VSQ
	 1ox+1edIvKsHUYfvjA7NA8TWfB1mXDSbJJMD39ykF3GgEA84ey5UUPrhAJNZQZYBin
	 e//x7YfKf20j0NKbiucREfzv4fEsAsEV6Ebk4mAwi1TdvX83v4ZLNsqKCyyBuKRwER
	 T/3keYXGjq7EDKaFOHi9Yr5fIDSwhKZhGcZWyCExhZY8CdEopmRwS6fhkEtjaXFM5N
	 I12kiMUA5STBw==
Date: Mon, 15 Sep 2025 17:58:12 -0700
Subject: [PATCH 08/10] libext2fs: allow clients to ask to write full
 superblocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161468.390072.11146917931126174508.stgit@frogsfrogsfrogs>
In-Reply-To: <175798161283.390072.8565583077948994821.stgit@frogsfrogsfrogs>
References: <175798161283.390072.8565583077948994821.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

write_primary_superblock currently does this weird dance where it will
try to write only the dirty bytes of the primary superblock to disk.  In
theory, this is done so that tune2fs can incrementally update superblock
bytes when the filesystem is mounted; ext2 was famous for allowing using
this dance to set new fs parameters and have them take effect in real
time.

The ability to do this safely was obliterated back in 2001 when ext3 was
introduced with journalling, because tune2fs has no way to know if the
journal has already logged an updated primary superblock but not yet
written it to disk, which means that they can race to write, and changes
can be lost.

This (non-)safety was further obliterated back in 2012 when I added
checksums to all the metadata blocks in ext4 because anyone else with
the block device open can see the primary superblock in an intermediate
state where the checksum does not match the superblock contents.

At this point in 2025 it's kind of stupid for fuse2fs to be doing this
because you can't have the kernel and fuse2fs mount the same filesystem
at the same time.  It also makes fuse2fs op_fsync slow because libext2fs
performs a bunch of small writes and introduce extra fsyncs.

So, add a new flag to ask for full superblock writes, which fuse2fs will
use later.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2fs.h  |    1 +
 lib/ext2fs/closefs.c |    7 +++++++
 2 files changed, 8 insertions(+)


diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index bb2170b78d6308..dee9feb02624ed 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -220,6 +220,7 @@ typedef struct ext2_file *ext2_file_t;
 #define EXT2_FLAG_IBITMAP_TAIL_PROBLEM	0x2000000
 #define EXT2_FLAG_THREADS		0x4000000
 #define EXT2_FLAG_IGNORE_SWAP_DIRENT	0x8000000
+#define EXT2_FLAG_WRITE_FULL_SUPER	0x10000000
 
 /*
  * Internal flags for use by the ext2fs library only
diff --git a/lib/ext2fs/closefs.c b/lib/ext2fs/closefs.c
index 8e5bec03a050de..9a67db76e7b326 100644
--- a/lib/ext2fs/closefs.c
+++ b/lib/ext2fs/closefs.c
@@ -196,6 +196,13 @@ static errcode_t write_primary_superblock(ext2_filsys fs,
 	int		check_idx, write_idx, size;
 	errcode_t	retval;
 
+	if (fs->flags & EXT2_FLAG_WRITE_FULL_SUPER) {
+		retval = io_channel_write_byte(fs->io, SUPERBLOCK_OFFSET,
+					       SUPERBLOCK_SIZE, super);
+		if (!retval)
+			return 0;
+	}
+
 	if (!fs->io->manager->write_byte || !fs->orig_super) {
 	fallback:
 		io_channel_set_blksize(fs->io, SUPERBLOCK_OFFSET);


