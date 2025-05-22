Return-Path: <linux-fsdevel+bounces-49634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DED5AC011B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DE39E52CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6FD8828;
	Thu, 22 May 2025 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoG1aPdG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E673FE7;
	Thu, 22 May 2025 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872635; cv=none; b=OpK4L3/FTo4r7hHFZmURxVtlu448WC6H9jTPOeH0BNB8YRyzZ0nFWemzzKGKeFPVsvJJgobxFLVJYrNptC0gCyLr4Hw80VYvJPbvFxlBeC4EUu1Fglc4qKmz7BK5ayZozmNsXmuX8nJvKDuAZnYpVANceBEQtRHWL5iNnHSR/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872635; c=relaxed/simple;
	bh=IZp2PH4Y4QsxPor4JPMDYyd/tvjM4k0q6kQX7eWPux8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tdg3+Pnp4bXbvhXods8Y2IICMq15HqLKv+rC/F4pqK5StRdaWdzSb5JYu4Vtu6GsWE9+aj85HKoOAnz40irJwL++TSZLRa7U0NSJ5Ikkk+N2h7pLiSdUZMO3ckSAPPkwxaDBXTjKAmjUbC8fmkQMGiuHVdYd5OugGtTqjW3TuYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoG1aPdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83312C4CEEB;
	Thu, 22 May 2025 00:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872635;
	bh=IZp2PH4Y4QsxPor4JPMDYyd/tvjM4k0q6kQX7eWPux8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aoG1aPdGn0BBRoAbXJeSsmS7XY0B5VJq123j2IdKbFfzjXED9SR6KPq3BV9jKLncD
	 LP+BhfwjULIYLevbd8sgD+NZER362krTvNlmojFVksGr9kNEM3GjH20QRATnQar85b
	 dZO+hQmK7vcKntKnTb4Ab2B+fWnm/u0NeN610O6y6rmA60avkWBbfxmPYCMnt01zUS
	 Ru4Gan9z/Ae8tWWtNaZfJw4FcXAYQaF+DkBHhqDngtx2qVvwGbM0SLqRCm6v3HlQ6b
	 6FzYj9foYAq1zkYQYbjwVlXmIMscRHxJXJ7xLvaRc6Slm6j/EuX8yLgINYrH3Nw5A4
	 3KbXwD/8/KLWg==
Date: Wed, 21 May 2025 17:10:35 -0700
Subject: [PATCH 09/10] libext2fs: allow clients to ask to write full
 superblocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198229.1484572.9967956151235591161.stgit@frogsfrogsfrogs>
In-Reply-To: <174787198025.1484572.10345977324531146086.stgit@frogsfrogsfrogs>
References: <174787198025.1484572.10345977324531146086.stgit@frogsfrogsfrogs>
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

At this point in 2025 it's kind of stupid to still be doing this, and it
makes fuse2fs syncfs slow because we now perform a bunch of small writes
and introduce extra fsyncs.  It will become especially painful when
fuse2fs turns on iomap, at which point it will need to use directio to
access the disk, which then runs the Really Sad Path where we change the
blocksize and completely obliterate the cache contents.

So, add a new flag to ask for full superblock writes, which fuse2fs will
use later.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2fs.h  |    1 +
 lib/ext2fs/closefs.c |    7 +++++++
 2 files changed, 8 insertions(+)


diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 2661e10f57c047..22d56ad7554496 100644
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


