Return-Path: <linux-fsdevel+bounces-49630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9F4AC0110
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECB89E5168
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2714917D2;
	Thu, 22 May 2025 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGFWHkLG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758AF2904;
	Thu, 22 May 2025 00:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872573; cv=none; b=fJAzY1ImXeni+KzO1tiP9++OPN2EHL1d1FzhUWFubhVvS+bSTWT3vxMWXIrcTBQZiW8gdWRK7hLkQMldxChgnMNihEJSfIQ+8e8vs/F8feJ3ivpGQe2H72Gzeblje9yJTtM94Uko7yR4JNZ211ny0nDoE3svgCI6fHrP9wu7suo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872573; c=relaxed/simple;
	bh=ZG0gGYkfJjrMTq0g9IvhpAkKjX2ta3Vpjj2WzdeIggo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giB605HEehLBSKgYSrNQpg5gLsg9qdEf9ExUrvR5lcuQwS4etiMRJRfPRBPq/8CbwPSHzi5jHnKK9qO/pR5mrhjFIaa7HiPx6HOU/v2YiwygUHjLvU42JmKdeAQsDrfDSTLShfE5YHS4EYRTtP4G+iCGYQVFIpDU/6b5TJgH9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGFWHkLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB4FC4CEE4;
	Thu, 22 May 2025 00:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872572;
	bh=ZG0gGYkfJjrMTq0g9IvhpAkKjX2ta3Vpjj2WzdeIggo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gGFWHkLG1D0bqcQOql9RAPvWMGH0hmpai1o/ToAKF9fAyAcXbLjhCWawWW7bvTjBB
	 jvXxmkpXM5KFamrpwWWw3unUVMVz69ND+qiuOabSwx8mNDZDunr4LXMhcIXJ+t/Vim
	 0hSRnrVOdJ6eHReL/z4k1+C/3o+4CIu6vzucIZOm2RDRoSjxcXQjIFR0YBvrNxAEF0
	 cH3Wbm9vck0nj2LNUgUnOw0y9DVPC6p5VrXI4K+amj2l53TB8g1OL11HhD3dwRm7Gh
	 zx42A3vv1czYbDEmOId1iUNhjdkTeIKLEV4HCc89e/mee73xuBEPbraHh1bnKkuN43
	 TRNIzAsX1mDCw==
Date: Wed, 21 May 2025 17:09:32 -0700
Subject: [PATCH 05/10] libext2fs: add tagged block IO for better caching
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198157.1484572.10418424942755145536.stgit@frogsfrogsfrogs>
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

Pass inode numbers from the fileio.c code through the io manager to the
unix io manager so that we can manage the disk cache more effectively.
In the next few patches we'll need the ability to flush and invalidate
the caches for specific files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2_io.h         |   25 +++++++++++++++++++++-
 debian/libext2fs2t64.symbols |    4 ++++
 lib/ext2fs/fileio.c          |   14 +++++++-----
 lib/ext2fs/io_manager.c      |   48 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 7 deletions(-)


diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index bab7f2a6a44b81..64b35b31d669e7 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -39,6 +39,11 @@ typedef struct struct_io_stats *io_stats;
 
 #define io_channel_discard_zeroes_data(i) (i->flags & CHANNEL_FLAGS_DISCARD_ZEROES)
 
+typedef unsigned int	io_channel_tag_t;
+
+/* I/O operation has no associated tag */
+#define IO_CHANNEL_TAG_NULL		(0)
+
 struct struct_io_channel {
 	errcode_t	magic;
 	io_manager	manager;
@@ -105,7 +110,15 @@ struct struct_io_manager {
 	errcode_t (*get_fd)(io_channel channel, int *fd);
 	errcode_t (*invalidate_blk)(io_channel channel,
 				    unsigned long long block);
-	long	reserved[12];
+	errcode_t (*read_tagblk)(io_channel channel, io_channel_tag_t tag,
+				 unsigned long long block, int count,
+				 void *data);
+	errcode_t (*write_tagblk)(io_channel channel, io_channel_tag_t tag,
+				   unsigned long long block, int count,
+				   const void *data);
+	errcode_t (*flush_tag)(io_channel channel, io_channel_tag_t tag);
+	errcode_t (*invalidate_tag)(io_channel channel, io_channel_tag_t tag);
+	long	reserved[8];
 };
 
 #define IO_FLAG_RW		0x0001
@@ -134,9 +147,17 @@ extern errcode_t io_channel_write_byte(io_channel channel,
 extern errcode_t io_channel_read_blk64(io_channel channel,
 				       unsigned long long block,
 				       int count, void *data);
+extern errcode_t io_channel_read_tagblk(io_channel channel,
+					io_channel_tag_t tag,
+					unsigned long long block, int count,
+					void *data);
 extern errcode_t io_channel_write_blk64(io_channel channel,
 					unsigned long long block,
 					int count, const void *data);
+extern errcode_t io_channel_write_tagblk(io_channel channel,
+					 io_channel_tag_t tag,
+					 unsigned long long block, int count,
+					 const void *data);
 extern errcode_t io_channel_discard(io_channel channel,
 				    unsigned long long block,
 				    unsigned long long count);
@@ -151,6 +172,8 @@ extern errcode_t io_channel_cache_readahead(io_channel io,
 extern errcode_t io_channel_fd(io_channel io, int *fd);
 extern errcode_t io_channel_invalidate_blk(io_channel io,
 					   unsigned long long block);
+extern errcode_t io_channel_flush_tag(io_channel io, io_channel_tag_t tag);
+extern errcode_t io_channel_invalidate_tag(io_channel io, io_channel_tag_t tag);
 
 #ifdef _WIN32
 /* windows_io.c */
diff --git a/debian/libext2fs2t64.symbols b/debian/libext2fs2t64.symbols
index 13870c4b545b2f..87ed63155702e0 100644
--- a/debian/libext2fs2t64.symbols
+++ b/debian/libext2fs2t64.symbols
@@ -689,11 +689,15 @@ libext2fs.so.2 libext2fs2t64 #MINVER#
  io_channel_cache_readahead@Base 1.43
  io_channel_discard@Base 1.42
  io_channel_fd@Base 1.47.3
+ io_channel_flush_tag@Base 1.47.3
  io_channel_invalidate_blk@Base 1.47.3
+ io_channel_invalidate_tag@Base 1.47.3
  io_channel_read_blk64@Base 1.41.1
+ io_channel_read_tagblk@Base 1.47.3
  io_channel_set_options@Base 1.37
  io_channel_write_blk64@Base 1.41.1
  io_channel_write_byte@Base 1.37
+ io_channel_write_tagblk@Base 1.47.3
  io_channel_zeroout@Base 1.43
  qcow2_read_header@Base 1.42
  qcow2_write_raw_image@Base 1.42
diff --git a/lib/ext2fs/fileio.c b/lib/ext2fs/fileio.c
index 818f7f05420029..1b7e88d990036b 100644
--- a/lib/ext2fs/fileio.c
+++ b/lib/ext2fs/fileio.c
@@ -167,7 +167,8 @@ errcode_t ext2fs_file_flush(ext2_file_t file)
 			return retval;
 	}
 
-	retval = io_channel_write_blk64(fs->io, file->physblock, 1, file->buf);
+	retval = io_channel_write_tagblk(fs->io, file->ino, file->physblock,
+					  1, file->buf);
 	if (retval)
 		return retval;
 
@@ -220,9 +221,10 @@ static errcode_t load_buffer(ext2_file_t file, int dontfill)
 		if (!dontfill) {
 			if (file->physblock &&
 			    !(ret_flags & BMAP_RET_UNINIT)) {
-				retval = io_channel_read_blk64(fs->io,
-							       file->physblock,
-							       1, file->buf);
+				retval = io_channel_read_tagblk(fs->io,
+								 file->ino,
+								 file->physblock,
+								 1, file->buf);
 				if (retval)
 					return retval;
 			} else
@@ -603,13 +605,13 @@ static errcode_t ext2fs_file_zero_past_offset(ext2_file_t file,
 		return retval;
 
 	/* Read/zero/write block */
-	retval = io_channel_read_blk64(fs->io, blk, 1, b);
+	retval = io_channel_read_tagblk(fs->io, file->ino, blk, 1, b);
 	if (retval)
 		goto out;
 
 	memset(b + off, 0, fs->blocksize - off);
 
-	retval = io_channel_write_blk64(fs->io, blk, 1, b);
+	retval = io_channel_write_tagblk(fs->io, file->ino, blk, 1, b);
 	if (retval)
 		goto out;
 
diff --git a/lib/ext2fs/io_manager.c b/lib/ext2fs/io_manager.c
index aa7fc58b846be8..357a3bc7698129 100644
--- a/lib/ext2fs/io_manager.c
+++ b/lib/ext2fs/io_manager.c
@@ -85,6 +85,22 @@ errcode_t io_channel_read_blk64(io_channel channel, unsigned long long block,
 					     count, data);
 }
 
+errcode_t io_channel_read_tagblk(io_channel channel, io_channel_tag_t tag,
+				 unsigned long long block, int count,
+				 void *data)
+{
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+
+	if (channel->manager->read_tagblk)
+		return (channel->manager->read_tagblk)(channel, tag, block,
+						       count, data);
+
+	if (tag != IO_CHANNEL_TAG_NULL)
+		return EXT2_ET_OP_NOT_SUPPORTED;
+
+	return io_channel_read_blk64(channel, block, count, data);
+}
+
 errcode_t io_channel_write_blk64(io_channel channel, unsigned long long block,
 				 int count, const void *data)
 {
@@ -101,6 +117,22 @@ errcode_t io_channel_write_blk64(io_channel channel, unsigned long long block,
 					     count, data);
 }
 
+errcode_t io_channel_write_tagblk(io_channel channel, io_channel_tag_t tag,
+				  unsigned long long block, int count,
+				  const void *data)
+{
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+
+	if (channel->manager->write_tagblk)
+		return (channel->manager->write_tagblk)(channel, tag, block,
+							count, data);
+
+	if (tag != IO_CHANNEL_TAG_NULL)
+		return EXT2_ET_OP_NOT_SUPPORTED;
+
+	return io_channel_write_blk64(channel, block, count, data);
+}
+
 errcode_t io_channel_discard(io_channel channel, unsigned long long block,
 			     unsigned long long count)
 {
@@ -166,3 +198,19 @@ errcode_t io_channel_invalidate_blk(io_channel io, unsigned long long block)
 
 	return io->manager->invalidate_blk(io, block);
 }
+
+errcode_t io_channel_flush_tag(io_channel io, io_channel_tag_t tag)
+{
+	if (!io->manager->flush_tag && tag != IO_CHANNEL_TAG_NULL)
+		return EXT2_ET_OP_NOT_SUPPORTED;
+
+	return io->manager->flush_tag(io, tag);
+}
+
+errcode_t io_channel_invalidate_tag(io_channel io, io_channel_tag_t tag)
+{
+	if (!io->manager->invalidate_tag && tag != IO_CHANNEL_TAG_NULL)
+		return EXT2_ET_OP_NOT_SUPPORTED;
+
+	return io->manager->invalidate_tag(io, tag);
+}


