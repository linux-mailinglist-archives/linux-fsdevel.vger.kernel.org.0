Return-Path: <linux-fsdevel+bounces-49629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2072DAC010F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16164E7A14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0300320EB;
	Thu, 22 May 2025 00:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV/F0Yfc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82A383;
	Thu, 22 May 2025 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872557; cv=none; b=X+aTrt72LJWfoKE0yWtyIjZo/crb6u8aJmTIjdISCGGPgO8BlVKEmGijy+Kfol9I2tUqKBtwUHPaXJJW8i5zk2Xbyxj3JSpeiITD2zFWqmW3IONLKxwrIOZBmoFYwzx04zBwn1xvKa9xAPBXixOv//8fssz2qfyyys+RERWNltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872557; c=relaxed/simple;
	bh=v5sf11inzQnKQK59EuewqHXiY80f0qwfW7ZvpfjabVM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6bI0GypqMseZwi44649t7wwDinEvPexIAVv/35DhswOEtmN6ZvDM61fcbL/B/nGTg1U6wYWuCRRo0VhxdoaCTGQSV4RR6i2x93pd58AJy7pF9yhV/6gnxUMNqTib9N3qZbtUQaLttowyJL6ikx6RzHMER9IakQTTqfR3e2zI4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV/F0Yfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D2CC4CEE4;
	Thu, 22 May 2025 00:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872557;
	bh=v5sf11inzQnKQK59EuewqHXiY80f0qwfW7ZvpfjabVM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iV/F0Yfc5tgnetSrECr2+240OIn6s0DlXehJHt+VyB1Kp3urlrHCRNnnU65bn9u0X
	 E+w41YnFaoAN3mQR/zoHSRY1CRlZzz6eSPN+i/hQ7nUHSlGw5+Kyc/40xWGasi23AB
	 0CtF0YnzzZ8q5CHsFhTRMUWYijbUnwJ/GOr5WjbNffXhyBPM53JWa9axIb34d07Eec
	 VQwQaLykz24817wd8NWfF1RNrAfKPbvWpowBouz/t/S+j4oq83vQ7a4yn5Ef9EyapS
	 /apF+L09ZGzsL0hxJA723sA3fTuCMP3vwGRMNBbeNhvJbFRH5QvOcxeTOyE3oIPBQ9
	 YM1NszKcMX+Hg==
Date: Wed, 21 May 2025 17:09:16 -0700
Subject: [PATCH 04/10] libext2fs: invalidate cached blocks when freeing them
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198139.1484572.1050142334724521309.stgit@frogsfrogsfrogs>
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

When we're freeing blocks, we should tell the IO manager to drop them
from any cache it might be maintaining to improve performance.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2_io.h         |    6 +++++-
 debian/libext2fs2t64.symbols |    1 +
 lib/ext2fs/alloc_stats.c     |    7 +++++++
 lib/ext2fs/io_manager.c      |    8 ++++++++
 lib/ext2fs/unix_io.c         |   32 ++++++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 78c988374c8808..bab7f2a6a44b81 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -103,7 +103,9 @@ struct struct_io_manager {
 	errcode_t (*zeroout)(io_channel channel, unsigned long long block,
 			     unsigned long long count);
 	errcode_t (*get_fd)(io_channel channel, int *fd);
-	long	reserved[13];
+	errcode_t (*invalidate_blk)(io_channel channel,
+				    unsigned long long block);
+	long	reserved[12];
 };
 
 #define IO_FLAG_RW		0x0001
@@ -147,6 +149,8 @@ extern errcode_t io_channel_cache_readahead(io_channel io,
 					    unsigned long long block,
 					    unsigned long long count);
 extern errcode_t io_channel_fd(io_channel io, int *fd);
+extern errcode_t io_channel_invalidate_blk(io_channel io,
+					   unsigned long long block);
 
 #ifdef _WIN32
 /* windows_io.c */
diff --git a/debian/libext2fs2t64.symbols b/debian/libext2fs2t64.symbols
index 9cf3b33ca15f91..13870c4b545b2f 100644
--- a/debian/libext2fs2t64.symbols
+++ b/debian/libext2fs2t64.symbols
@@ -689,6 +689,7 @@ libext2fs.so.2 libext2fs2t64 #MINVER#
  io_channel_cache_readahead@Base 1.43
  io_channel_discard@Base 1.42
  io_channel_fd@Base 1.47.3
+ io_channel_invalidate_blk@Base 1.47.3
  io_channel_read_blk64@Base 1.41.1
  io_channel_set_options@Base 1.37
  io_channel_write_blk64@Base 1.41.1
diff --git a/lib/ext2fs/alloc_stats.c b/lib/ext2fs/alloc_stats.c
index 6f98bcc7cbd5f3..4aeaa286b88a7e 100644
--- a/lib/ext2fs/alloc_stats.c
+++ b/lib/ext2fs/alloc_stats.c
@@ -84,6 +84,13 @@ void ext2fs_block_alloc_stats2(ext2_filsys fs, blk64_t blk, int inuse)
 	ext2fs_mark_bb_dirty(fs);
 	if (fs->block_alloc_stats)
 		(fs->block_alloc_stats)(fs, (blk64_t) blk, inuse);
+
+	if (inuse < 0) {
+		unsigned int i;
+
+		for (i = 0; i < EXT2FS_CLUSTER_RATIO(fs); i++)
+			io_channel_invalidate_blk(fs->io, blk + i);
+	}
 }
 
 void ext2fs_block_alloc_stats(ext2_filsys fs, blk_t blk, int inuse)
diff --git a/lib/ext2fs/io_manager.c b/lib/ext2fs/io_manager.c
index 1bab069de63e12..aa7fc58b846be8 100644
--- a/lib/ext2fs/io_manager.c
+++ b/lib/ext2fs/io_manager.c
@@ -158,3 +158,11 @@ errcode_t io_channel_fd(io_channel io, int *fd)
 
 	return io->manager->get_fd(io, fd);
 }
+
+errcode_t io_channel_invalidate_blk(io_channel io, unsigned long long block)
+{
+	if (!io->manager->invalidate_blk)
+		return EXT2_ET_OP_NOT_SUPPORTED;
+
+	return io->manager->invalidate_blk(io, block);
+}
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 0fc83e471ca0fe..89f7915371307f 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -664,6 +664,23 @@ static errcode_t reuse_cache(io_channel channel,
 #define FLUSH_INVALIDATE	0x01
 #define FLUSH_NOLOCK		0x02
 
+/* Remove a block from the cache.  Dirty contents are discarded. */
+static void invalidate_cached_block(io_channel channel,
+				    struct unix_private_data *data,
+				    unsigned long long block)
+{
+	struct unix_cache	*cache;
+	int			i;
+
+	mutex_lock(data, CACHE_MTX);
+	for (i = 0, cache = data->cache; i < data->cache_size; i++, cache++) {
+		if (!cache->in_use || cache->block != block)
+			continue;
+		cache->in_use = 0;
+	}
+	mutex_unlock(data, CACHE_MTX);
+}
+
 /*
  * Flush all of the blocks in the cache
  */
@@ -1705,6 +1722,19 @@ static errcode_t unix_get_fd(io_channel channel, int *fd)
 	return 0;
 }
 
+static errcode_t unix_invalidate_blk(io_channel channel,
+				     unsigned long long block)
+{
+	struct unix_private_data *data;
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	data = (struct unix_private_data *) channel->private_data;
+	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
+
+	invalidate_cached_block(channel, data, block);
+	return 0;
+}
+
 #if __GNUC_PREREQ (4, 6)
 #pragma GCC diagnostic pop
 #endif
@@ -1727,6 +1757,7 @@ static struct struct_io_manager struct_unix_manager = {
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
 	.get_fd		= unix_get_fd,
+	.invalidate_blk	= unix_invalidate_blk,
 };
 
 io_manager unix_io_manager = &struct_unix_manager;
@@ -1749,6 +1780,7 @@ static struct struct_io_manager struct_unixfd_manager = {
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
 	.get_fd		= unix_get_fd,
+	.invalidate_blk	= unix_invalidate_blk,
 };
 
 io_manager unixfd_io_manager = &struct_unixfd_manager;


