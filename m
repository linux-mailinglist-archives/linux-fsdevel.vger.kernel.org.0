Return-Path: <linux-fsdevel+bounces-61617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84C6B58A55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70276166531
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CA91DE89A;
	Tue, 16 Sep 2025 00:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8W7MR/D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E975D2FB;
	Tue, 16 Sep 2025 00:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984246; cv=none; b=Ui4DOWZACm4/oMPZq3eKNtfRxPfFQXEUR6fVuThLlwEcSh3RBOuwdbeLHlL0Ru0o2Rep+Pv3L7lrtRcwEdl9MNJK3F0lUJjkYfxStssmxhbHDz8RvBLzs6JrmcHNbjoEHKyP8487xliN725fSXeYkbdpQRp+7r+vixdB6JBELho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984246; c=relaxed/simple;
	bh=M04+T8ik4csOPlFmfEdw1492b+INz9MEExTyiZUYXKU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muTNTHvzMMIbZ1A1PIE27M9j2YTco/P+lM8OdbNioyvIM/sWJDPItnylYzUahSBrz/wzwqWt5nLxzi4ODo2sEH2nKshE+8yyz2gyCHQjC4rp6EVxy7y/iTyL+kd1HW35L69gOvlK1pJI+kxC5A6xfElSrexNuliRC9j6yozRsXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8W7MR/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F38C4CEF1;
	Tue, 16 Sep 2025 00:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984245;
	bh=M04+T8ik4csOPlFmfEdw1492b+INz9MEExTyiZUYXKU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=f8W7MR/DV+MjoGIjaV7kaJEAJAfJtVwnFKR1cKDsDh48O2kNYF1JuIxlfhyK7ZLHg
	 gvlCCCnl/FkPmH7/4Y3HfEWLctEJHtpgzJhKWozPBnFdQBwnAO6iNCL6mzOw/6XQ+a
	 Ba5Q3RUgwuZDIokQHkTwtNyyPJlC1lPHvdWsWRzzTULkMPSin03wuoHQ97hoJVJ9yo
	 yTtlmVmrI463ln3lTXZP2oJ7TqvKg5uml/mpv8WGc/6yAd401oQ5rG2m2fZpz15b7b
	 1aWCp1hmcJBVNZnaxrcbHNpvai18KzQq+VQBmMpMTM5QNsT/lRWB5zgnZZSEcVUfO0
	 upH05nyJt3gOQ==
Date: Mon, 15 Sep 2025 17:57:25 -0700
Subject: [PATCH 05/10] libext2fs: invalidate cached blocks when freeing them
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161414.390072.5421071763819634486.stgit@frogsfrogsfrogs>
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
index b462c587e3e2ac..be253b5fddf281 100644
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
@@ -1715,6 +1734,20 @@ static errcode_t unix_get_fd(io_channel channel, int *fd)
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
@@ -1737,6 +1770,7 @@ static struct struct_io_manager struct_unix_manager = {
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
 	.get_fd		= unix_get_fd,
+	.invalidate_blocks = unix_invalidate_blocks,
 };
 
 io_manager unix_io_manager = &struct_unix_manager;
@@ -1759,6 +1793,7 @@ static struct struct_io_manager struct_unixfd_manager = {
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
 	.get_fd		= unix_get_fd,
+	.invalidate_blocks = unix_invalidate_blocks,
 };
 
 io_manager unixfd_io_manager = &struct_unixfd_manager;


