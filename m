Return-Path: <linux-fsdevel+bounces-58525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA1AB2EA4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FF5A276CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4851FF1BF;
	Thu, 21 Aug 2025 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmK9VghA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100211F4188;
	Thu, 21 Aug 2025 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738864; cv=none; b=kHD3CDkh1xRUfHEAqQk5Sy9LaWAM8k4wtZ2Ehu7d8ZfrMCclw1JbkEb49zCHJ7eI2Pw7ZvhhW6oe+cdFFK3XjE1I4XthVprNPG3KDWfy35dyQT7O7EQDVDXWIpx+Q8PB8hS5wcZSAl5t/C20CSD3OlJBtZXBpefDHJUsrnfMEPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738864; c=relaxed/simple;
	bh=ove571Xi1/OfIMR09QF+V2YJE0qYjuRzqBOOwnEEtEM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swz2TQtFmgJE6qOV+oWqdOAOGb+7sFd+gfdcViadl2D6TVBSD3cp3iXxTdaftQW+mFKySvxQ3Hd/1dh0sEJUsNlZ/jZlkPWWq2qFQl+d2/9DIF0YT92TfR0jXZ1EneojHGAy1mjKQ9uuTaFlKx0agyP+hrKJsgAKO++VugMBVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmK9VghA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E4AC116C6;
	Thu, 21 Aug 2025 01:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738863;
	bh=ove571Xi1/OfIMR09QF+V2YJE0qYjuRzqBOOwnEEtEM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kmK9VghAoLhFdjftVsvywpZmDdiF0xXlKeGwMSZC07tKRZ2x2YzQW/jwqiZs52W56
	 xhRqD9/k2qtwegyGs9rz3dDhaBG//QxM9r4bWjI0jBQ5cRxjjKzWGPz00bshQ1ryO5
	 hrwUh7MrZVBOAoalHFPZmIqH3BJJah5QmYEwMiCEQajRbF178bwcnnmLfu7ufApJ3A
	 MkxJoekgmMw/W2Wmmy17OM4dw/C1cH520hxOAfpNDqNkSTdDpM2su8G/257hTTfhGQ
	 PXt0Rg/2F6krKkThUXjnyIpTDi3RBz2hf5LESVjQCJRiunuRwymKnlIekWx0e+pMZp
	 y6mY9tB6lVNlQ==
Date: Wed, 20 Aug 2025 18:14:23 -0700
Subject: [PATCH 05/10] libext2fs: invalidate cached blocks when freeing them
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713424.21546.10432603180960727990.stgit@frogsfrogsfrogs>
In-Reply-To: <175573713292.21546.5820947765655770281.stgit@frogsfrogsfrogs>
References: <175573713292.21546.5820947765655770281.stgit@frogsfrogsfrogs>
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
 lib/ext2fs/ext2_io.h         |    8 +++++++-
 debian/libext2fs2t64.symbols |    1 +
 lib/ext2fs/alloc_stats.c     |    6 ++++++
 lib/ext2fs/io_manager.c      |    9 +++++++++
 lib/ext2fs/unix_io.c         |   35 +++++++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index f53983b30996b4..26ecd128954a0e 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -103,7 +103,10 @@ struct struct_io_manager {
 	errcode_t (*zeroout)(io_channel channel, unsigned long long block,
 			     unsigned long long count);
 	errcode_t (*get_fd)(io_channel channel, int *fd);
-	long	reserved[13];
+	errcode_t (*invalidate_blocks)(io_channel channel,
+				       unsigned long long block,
+				       unsigned long long count);
+	long	reserved[12];
 };
 
 #define IO_FLAG_RW		0x0001
@@ -147,6 +150,9 @@ extern errcode_t io_channel_cache_readahead(io_channel io,
 					    unsigned long long block,
 					    unsigned long long count);
 extern errcode_t io_channel_get_fd(io_channel io, int *fd);
+extern errcode_t io_channel_invalidate_blocks(io_channel io,
+					      unsigned long long block,
+					      unsigned long long count);
 
 #ifdef _WIN32
 /* windows_io.c */
diff --git a/debian/libext2fs2t64.symbols b/debian/libext2fs2t64.symbols
index 8e3214ee31e337..864a284b940009 100644
--- a/debian/libext2fs2t64.symbols
+++ b/debian/libext2fs2t64.symbols
@@ -694,6 +694,7 @@ libext2fs.so.2 libext2fs2t64 #MINVER#
  io_channel_cache_readahead@Base 1.43
  io_channel_discard@Base 1.42
  io_channel_get_fd@Base 1.47.99
+ io_channel_invalidate_blocks@Base 1.47.99
  io_channel_read_blk64@Base 1.41.1
  io_channel_set_options@Base 1.37
  io_channel_write_blk64@Base 1.41.1
diff --git a/lib/ext2fs/alloc_stats.c b/lib/ext2fs/alloc_stats.c
index 95a6438f252e0f..68bbe6807a8ed3 100644
--- a/lib/ext2fs/alloc_stats.c
+++ b/lib/ext2fs/alloc_stats.c
@@ -82,6 +82,9 @@ void ext2fs_block_alloc_stats2(ext2_filsys fs, blk64_t blk, int inuse)
 			     -inuse * (blk64_t) EXT2FS_CLUSTER_RATIO(fs));
 	ext2fs_mark_super_dirty(fs);
 	ext2fs_mark_bb_dirty(fs);
+	if (inuse < 0)
+		io_channel_invalidate_blocks(fs->io, blk,
+					     EXT2FS_CLUSTER_RATIO(fs));
 	if (fs->block_alloc_stats)
 		(fs->block_alloc_stats)(fs, (blk64_t) blk, inuse);
 }
@@ -144,11 +147,14 @@ void ext2fs_block_alloc_stats_range(ext2_filsys fs, blk64_t blk,
 		ext2fs_bg_flags_clear(fs, group, EXT2_BG_BLOCK_UNINIT);
 		ext2fs_group_desc_csum_set(fs, group);
 		ext2fs_free_blocks_count_add(fs->super, -inuse * (blk64_t) n);
+
 		blk += n;
 		num -= n;
 	}
 	ext2fs_mark_super_dirty(fs);
 	ext2fs_mark_bb_dirty(fs);
+	if (inuse < 0)
+		io_channel_invalidate_blocks(fs->io, orig_blk, orig_num);
 	if (fs->block_alloc_stats_range)
 		(fs->block_alloc_stats_range)(fs, orig_blk, orig_num, inuse);
 }
diff --git a/lib/ext2fs/io_manager.c b/lib/ext2fs/io_manager.c
index 6b4dca5e4dbca2..c91fab4eb290d5 100644
--- a/lib/ext2fs/io_manager.c
+++ b/lib/ext2fs/io_manager.c
@@ -158,3 +158,12 @@ errcode_t io_channel_get_fd(io_channel io, int *fd)
 
 	return io->manager->get_fd(io, fd);
 }
+
+errcode_t io_channel_invalidate_blocks(io_channel io, unsigned long long block,
+				       unsigned long long count)
+{
+	if (!io->manager->invalidate_blocks)
+		return EXT2_ET_OP_NOT_SUPPORTED;
+
+	return io->manager->invalidate_blocks(io, block, count);
+}
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 61ecdc9b8b56b2..0d1006207c60cd 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -667,6 +667,25 @@ static errcode_t reuse_cache(io_channel channel,
 #define FLUSH_INVALIDATE	0x01
 #define FLUSH_NOLOCK		0x02
 
+/* Remove blocks from the cache.  Dirty contents are discarded. */
+static void invalidate_cached_blocks(io_channel channel,
+				     struct unix_private_data *data,
+				     unsigned long long block,
+				     unsigned long long count)
+{
+	struct unix_cache	*cache;
+	int			i;
+
+	mutex_lock(data, CACHE_MTX);
+	for (i = 0, cache = data->cache; i < data->cache_size; i++, cache++) {
+		if (!cache->in_use || cache->block < block ||
+		    cache->block >= block + count)
+			continue;
+		cache->in_use = 0;
+	}
+	mutex_unlock(data, CACHE_MTX);
+}
+
 /*
  * Flush all of the blocks in the cache
  */
@@ -1716,6 +1735,20 @@ static errcode_t unix_get_fd(io_channel channel, int *fd)
 	return 0;
 }
 
+static errcode_t unix_invalidate_blocks(io_channel channel,
+					unsigned long long block,
+					unsigned long long count)
+{
+	struct unix_private_data *data;
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	data = (struct unix_private_data *) channel->private_data;
+	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
+
+	invalidate_cached_blocks(channel, data, block, count);
+	return 0;
+}
+
 #if __GNUC_PREREQ (4, 6)
 #pragma GCC diagnostic pop
 #endif
@@ -1738,6 +1771,7 @@ static struct struct_io_manager struct_unix_manager = {
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
 	.get_fd		= unix_get_fd,
+	.invalidate_blocks = unix_invalidate_blocks,
 };
 
 io_manager unix_io_manager = &struct_unix_manager;
@@ -1760,6 +1794,7 @@ static struct struct_io_manager struct_unixfd_manager = {
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
 	.get_fd		= unix_get_fd,
+	.invalidate_blocks = unix_invalidate_blocks,
 };
 
 io_manager unixfd_io_manager = &struct_unixfd_manager;


