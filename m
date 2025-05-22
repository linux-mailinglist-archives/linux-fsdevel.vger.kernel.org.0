Return-Path: <linux-fsdevel+bounces-49631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D098AC0113
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF2B9E50B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8917D2;
	Thu, 22 May 2025 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV8bfiW6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEEB380;
	Thu, 22 May 2025 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872589; cv=none; b=tt1sR8q2dB18VlbVvpPCzIw9oruTYVYKPfq8lVbF8mnvfNJQAmdVTJz5s50Tuag9TSZmsV/NBVGbITlrnwPB5Dfp2sqMj8ZYPYxrEZfPCwL2AatCe1o5RcvIvggbhQHofdzUUMBpGA0GwsSHMKDjT0zEMTDnmjrDXEfmouHelZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872589; c=relaxed/simple;
	bh=ivwEi76buQlY4qvTrNOK1S9fDpvjGYBtK5l9TOBPEKI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CiP27RcMmcXe27mf6ervXY0nkf5fp8OdIGdYKSow76ACitdxri0wU84KC7CjtHglB4t7utfgPOw/sEVqqOdeSOjqPOJCR/5jR4zRk+Yke8AYV+L+CGBJ/J0rZuXIdeQKqiz0QYImPds/lFBLByBs7/+Os1RfZMzJNRjy6NlRWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LV8bfiW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881ACC4CEE4;
	Thu, 22 May 2025 00:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872588;
	bh=ivwEi76buQlY4qvTrNOK1S9fDpvjGYBtK5l9TOBPEKI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LV8bfiW6vWwhZp4ojs1LQb2MDL5qqkF8eEt4rEcGxVXxP4k2YgIdWErvmaUdhWbCz
	 zWiA+vLa4aCK4UrQhTNvxzDM42g6q/WyZPYodosYfnwFaJ4c3meTi4paTRdUuIiv/6
	 Rlbr9D/Z1xS6Zn23KBP6lJ0n4DxmFxkM4y+lPc+2ljhkZptCqw12VaD8ttA88S45Iu
	 3Tsea0S447CudcZPtevxWvMASK76Nwogl5E1wBt1KgPT+k8JJEtD/WqRd0PQ/H3IW2
	 D8vU7QZHt1f8X2tNciLQJcB8bLHFcg3NHCrlY9NZf9VrXKeADSuINVntAeAFI0QYOD
	 4x3LlIlv3REpg==
Date: Wed, 21 May 2025 17:09:48 -0700
Subject: [PATCH 06/10] libext2fs: add tagged block IO caching to the unix IO
 manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198175.1484572.7300385195169992050.stgit@frogsfrogsfrogs>
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

Add tagged block caching to the UNIX IO manager.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |  198 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 154 insertions(+), 44 deletions(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 89f7915371307f..8a8afe47ee4503 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -120,6 +120,7 @@ struct unix_cache {
 	char			*buf;
 	unsigned long long	block;
 	int			access_time;
+	io_channel_tag_t	tag;
 	unsigned		dirty:1;
 	unsigned		in_use:1;
 	unsigned		write_err:1;
@@ -526,6 +527,7 @@ static errcode_t alloc_cache(io_channel channel,
 		cache->access_time = 0;
 		cache->dirty = 0;
 		cache->in_use = 0;
+		cache->tag = IO_CHANNEL_TAG_NULL;
 		if (cache->buf)
 			ext2fs_free_mem(&cache->buf);
 		retval = io_channel_alloc_buf(channel, 0, &cache->buf);
@@ -552,6 +554,7 @@ static void free_cache(struct unix_private_data *data)
 		cache->access_time = 0;
 		cache->dirty = 0;
 		cache->in_use = 0;
+		cache->tag = IO_CHANNEL_TAG_NULL;
 		if (cache->buf)
 			ext2fs_free_mem(&cache->buf);
 	}
@@ -639,8 +642,9 @@ static struct unix_cache *find_cached_block(struct unix_private_data *data,
  * Reuse a particular cache entry for another block.
  */
 static errcode_t reuse_cache(io_channel channel,
-		struct unix_private_data *data, struct unix_cache *cache,
-		unsigned long long block)
+			     struct unix_private_data *data,
+			     struct unix_cache *cache, io_channel_tag_t tag,
+			     unsigned long long block)
 {
 	if (cache->dirty && cache->in_use) {
 		errcode_t retval;
@@ -653,7 +657,16 @@ static errcode_t reuse_cache(io_channel channel,
 		}
 	}
 
+#ifdef DEBUG
+	if (cache->in_use)
+		printf("Reusing cached block %llu(%u) for %llu(%u)\n",
+			cache->block, cache->tag, block, tag);
+	else
+		printf("Using cached block %llu(%u)\n", block, tag);
+#endif
+
 	cache->in_use = 1;
+	cache->tag = tag;
 	cache->dirty = 0;
 	cache->write_err = 0;
 	cache->block = block;
@@ -664,6 +677,17 @@ static errcode_t reuse_cache(io_channel channel,
 #define FLUSH_INVALIDATE	0x01
 #define FLUSH_NOLOCK		0x02
 
+static inline void invalidate_cache(struct unix_cache *cache)
+{
+#ifdef DEBUG
+	if (cache->in_use)
+		printf("Invalidating cache %llu(%u)\n", cache->block,
+				cache->tag);
+#endif
+	cache->in_use = 0;
+	cache->tag = IO_CHANNEL_TAG_NULL;
+}
+
 /* Remove a block from the cache.  Dirty contents are discarded. */
 static void invalidate_cached_block(io_channel channel,
 				    struct unix_private_data *data,
@@ -676,7 +700,7 @@ static void invalidate_cached_block(io_channel channel,
 	for (i = 0, cache = data->cache; i < data->cache_size; i++, cache++) {
 		if (!cache->in_use || cache->block != block)
 			continue;
-		cache->in_use = 0;
+		invalidate_cache(cache);
 	}
 	mutex_unlock(data, CACHE_MTX);
 }
@@ -686,7 +710,7 @@ static void invalidate_cached_block(io_channel channel,
  */
 static errcode_t flush_cached_blocks(io_channel channel,
 				     struct unix_private_data *data,
-				     int flags)
+				     io_channel_tag_t tag, int flags)
 {
 	struct unix_cache	*cache;
 	errcode_t		retval, retval2 = 0;
@@ -698,6 +722,11 @@ static errcode_t flush_cached_blocks(io_channel channel,
 	for (i=0, cache = data->cache; i < data->cache_size; i++, cache++) {
 		if (!cache->in_use)
 			continue;
+		if (tag && cache->tag != tag)
+			continue;
+#ifdef DEBUG
+		printf("Flushing %sblock %llu(%u)\n", cache->dirty ? "dirty " : "", cache->block, cache->tag);
+#endif
 		if (cache->dirty) {
 			int raw_flags = RAW_WRITE_NO_HANDLER;
 
@@ -715,10 +744,10 @@ static errcode_t flush_cached_blocks(io_channel channel,
 				cache->dirty = 0;
 				cache->write_err = 0;
 				if (flags & FLUSH_INVALIDATE)
-					cache->in_use = 0;
+					invalidate_cache(cache);
 			}
 		} else if (flags & FLUSH_INVALIDATE) {
-			cache->in_use = 0;
+			invalidate_cache(cache);
 		}
 	}
 	if ((flags & FLUSH_NOLOCK) == 0)
@@ -737,7 +766,7 @@ static errcode_t flush_cached_blocks(io_channel channel,
 				unsigned long long err_block = cache->block;
 
 				cache->dirty = 0;
-				cache->in_use = 0;
+				invalidate_cache(cache);
 				cache->write_err = 0;
 				if (io_channel_alloc_buf(channel, 0,
 							 &err_buf))
@@ -772,7 +801,7 @@ static errcode_t shrink_cache(io_channel channel,
 
 	mutex_lock(data, CACHE_MTX);
 
-	retval = flush_cached_blocks(channel, data,
+	retval = flush_cached_blocks(channel, data, IO_CHANNEL_TAG_NULL,
 			FLUSH_INVALIDATE | FLUSH_NOLOCK);
 	if (retval)
 		goto unlock;
@@ -784,6 +813,7 @@ static errcode_t shrink_cache(io_channel channel,
 		cache->access_time = 0;
 		cache->dirty = 0;
 		cache->in_use = 0;
+		cache->tag = IO_CHANNEL_TAG_NULL;
 		if (cache->buf)
 			ext2fs_free_mem(&cache->buf);
 	}
@@ -814,7 +844,7 @@ static errcode_t grow_cache(io_channel channel,
 
 	mutex_lock(data, CACHE_MTX);
 
-	retval = flush_cached_blocks(channel, data,
+	retval = flush_cached_blocks(channel, data, IO_CHANNEL_TAG_NULL,
 			FLUSH_INVALIDATE | FLUSH_NOLOCK);
 	if (retval)
 		goto unlock;
@@ -832,6 +862,7 @@ static errcode_t grow_cache(io_channel channel,
 		cache->access_time = 0;
 		cache->dirty = 0;
 		cache->in_use = 0;
+		cache->tag = IO_CHANNEL_TAG_NULL;
 		retval = io_channel_alloc_buf(channel, 0, &cache->buf);
 		if (retval)
 			goto unlock;
@@ -1181,7 +1212,7 @@ static errcode_t unix_close(io_channel channel)
 		return 0;
 
 #ifndef NO_IO_CACHE
-	retval = flush_cached_blocks(channel, data, 0);
+	retval = flush_cached_blocks(channel, data, IO_CHANNEL_TAG_NULL, 0);
 #endif
 	/* always fsync the device, even if flushing our own cache failed */
 	retval2 = maybe_fsync(channel);
@@ -1220,7 +1251,9 @@ static errcode_t unix_set_blksize(io_channel channel, int blksize)
 		mutex_lock(data, CACHE_MTX);
 		mutex_lock(data, BOUNCE_MTX);
 #ifndef NO_IO_CACHE
-		if ((retval = flush_cached_blocks(channel, data, FLUSH_NOLOCK))){
+		retval = flush_cached_blocks(channel, data, IO_CHANNEL_TAG_NULL,
+					     FLUSH_NOLOCK);
+		if (retval) {
 			mutex_unlock(data, BOUNCE_MTX);
 			mutex_unlock(data, CACHE_MTX);
 			return retval;
@@ -1236,8 +1269,9 @@ static errcode_t unix_set_blksize(io_channel channel, int blksize)
 	return retval;
 }
 
-static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
-			       int count, void *buf)
+static errcode_t unix_read_tagblk(io_channel channel, io_channel_tag_t tag,
+				  unsigned long long block, int count,
+				  void *buf)
 {
 	struct unix_private_data *data;
 	struct unix_cache *cache;
@@ -1249,6 +1283,10 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 	data = (struct unix_private_data *) channel->private_data;
 	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
 
+#ifdef DEBUG
+	printf("read block %llu(%u) count %u\n", block, tag, count);
+#endif
+
 #ifdef NO_IO_CACHE
 	return raw_read_blk(channel, data, block, count, buf);
 #else
@@ -1259,7 +1297,8 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 	 * flush out the cache and then do a direct read.
 	 */
 	if (count < 0 || count > WRITE_DIRECT_SIZE) {
-		if ((retval = flush_cached_blocks(channel, data, 0)))
+		retval = flush_cached_blocks(channel, data, tag, 0);
+		if (retval)
 			return retval;
 		return raw_read_blk(channel, data, block, count, buf);
 	}
@@ -1270,9 +1309,11 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 		/* If it's in the cache, use it! */
 		if ((cache = find_cached_block(data, block, NULL))) {
 #ifdef DEBUG
-			printf("Using cached block %lu\n", block);
+			printf("Reading from cached block %llu(%u)\n", block, tag);
 #endif
 			memcpy(cp, cache->buf, channel->block_size);
+			if (tag != IO_CHANNEL_TAG_NULL)
+				cache->tag = tag;
 			count--;
 			block++;
 			cp += channel->block_size;
@@ -1287,7 +1328,7 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 			if (find_cached_block(data, block+i, NULL))
 				break;
 #ifdef DEBUG
-		printf("Reading %d blocks starting at %lu\n", i, block);
+		printf("Reading %d blocks starting at %llu\n", i, block);
 #endif
 		mutex_unlock(data, CACHE_MTX);
 		if ((retval = raw_read_blk(channel, data, block, i, cp)))
@@ -1298,7 +1339,7 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 		for (j=0; j < i; j++) {
 			if (!find_cached_block(data, block, &cache)) {
 				retval = reuse_cache(channel, data,
-						     cache, block);
+						     cache, tag, block);
 				if (retval)
 					goto call_write_handler;
 				memcpy(cache->buf, cp, channel->block_size);
@@ -1317,7 +1358,7 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 		unsigned long long err_block = cache->block;
 
 		cache->dirty = 0;
-		cache->in_use = 0;
+		invalidate_cache(cache);
 		cache->write_err = 0;
 		if (io_channel_alloc_buf(channel, 0, &err_buf))
 			err_buf = NULL;
@@ -1335,14 +1376,22 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 #endif /* NO_IO_CACHE */
 }
 
+static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
+				  int count, void *buf)
+{
+	return unix_read_tagblk(channel, IO_CHANNEL_TAG_NULL, block, count,
+				buf);
+}
+
 static errcode_t unix_read_blk(io_channel channel, unsigned long block,
 			       int count, void *buf)
 {
 	return unix_read_blk64(channel, block, count, buf);
 }
 
-static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
-				int count, const void *buf)
+static errcode_t unix_write_tagblk(io_channel channel, io_channel_tag_t tag,
+				   unsigned long long block, int count,
+				   const void *buf)
 {
 	struct unix_private_data *data;
 	struct unix_cache *cache, *reuse;
@@ -1354,6 +1403,10 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 	data = (struct unix_private_data *) channel->private_data;
 	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
 
+#ifdef DEBUG
+	printf("write block %llu(%u) count %u\n", block, tag, count);
+#endif
+
 	mark_dirty(channel);
 
 #ifdef NO_IO_CACHE
@@ -1366,8 +1419,9 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 	 * flush out the cache completely and then do a direct write.
 	 */
 	if (count < 0 || count > WRITE_DIRECT_SIZE) {
-		if ((retval = flush_cached_blocks(channel, data,
-						  FLUSH_INVALIDATE)))
+		retval = flush_cached_blocks(channel, data, tag,
+					     FLUSH_INVALIDATE);
+		if (retval)
 			return retval;
 		return raw_write_blk(channel, data, block, count, buf, 0);
 	}
@@ -1385,11 +1439,17 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 	mutex_lock(data, CACHE_MTX);
 	while (count > 0) {
 		cache = find_cached_block(data, block, &reuse);
-		if (!cache) {
+		if (cache) {
+#ifdef DEBUG
+			printf("Writing to cached block %llu(%u)\n", block, tag);
+#endif
+			if (tag != IO_CHANNEL_TAG_NULL)
+				cache->tag = tag;
+		} else {
 			errcode_t err;
 
 			cache = reuse;
-			err = reuse_cache(channel, data, cache, block);
+			err = reuse_cache(channel, data, cache, tag, block);
 			if (err)
 				goto call_write_handler;
 		}
@@ -1409,7 +1469,7 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 		unsigned long long err_block = cache->block;
 
 		cache->dirty = 0;
-		cache->in_use = 0;
+		invalidate_cache(cache);
 		cache->write_err = 0;
 		if (io_channel_alloc_buf(channel, 0, &err_buf))
 			err_buf = NULL;
@@ -1427,6 +1487,13 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 #endif /* NO_IO_CACHE */
 }
 
+static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
+				  int count, const void *buf)
+{
+	return unix_write_tagblk(channel, IO_CHANNEL_TAG_NULL, block, count,
+				 buf);
+}
+
 static errcode_t unix_cache_readahead(io_channel channel,
 				      unsigned long long block,
 				      unsigned long long count)
@@ -1473,7 +1540,9 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 	/*
 	 * Flush out the cache completely
 	 */
-	if ((retval = flush_cached_blocks(channel, data, FLUSH_INVALIDATE)))
+	retval = flush_cached_blocks(channel, data, IO_CHANNEL_TAG_NULL,
+				     FLUSH_INVALIDATE);
+	if (retval)
 		return retval;
 #endif
 
@@ -1491,28 +1560,60 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 	return 0;
 }
 
+/*
+ * Flush data buffers with the given tag to disk and invalidate them.
+ */
+static errcode_t unix_invalidate_tag(io_channel channel, io_channel_tag_t tag)
+{
+	struct unix_private_data *data;
+	errcode_t retval = 0, retval2;
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	data = (struct unix_private_data *) channel->private_data;
+	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
+
+#ifndef NO_IO_CACHE
+	retval = flush_cached_blocks(channel, data, tag, FLUSH_INVALIDATE);
+#endif
+#ifdef HAVE_FSYNC
+	/* always fsync the device, even if flushing our own cache failed */
+	retval2 = maybe_fsync(channel);
+	if (retval2 && !retval)
+		retval = retval2;
+#endif
+	return retval;
+}
+
+/*
+ * Flush data buffers with the given tag to disk.
+ */
+static errcode_t unix_flush_tag(io_channel channel, io_channel_tag_t tag)
+{
+	struct unix_private_data *data;
+	errcode_t retval = 0, retval2;
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	data = (struct unix_private_data *) channel->private_data;
+	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
+
+#ifndef NO_IO_CACHE
+	retval = flush_cached_blocks(channel, data, tag, 0);
+#endif
+#ifdef HAVE_FSYNC
+	/* always fsync the device, even if flushing our own cache failed */
+	retval2 = maybe_fsync(channel);
+	if (retval2 && !retval)
+		retval = retval2;
+#endif
+	return retval;
+}
+
 /*
  * Flush data buffers to disk.
  */
 static errcode_t unix_flush(io_channel channel)
 {
-	struct unix_private_data *data;
-	errcode_t retval = 0, retval2;
-
-	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
-	data = (struct unix_private_data *) channel->private_data;
-	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
-
-#ifndef NO_IO_CACHE
-	retval = flush_cached_blocks(channel, data, 0);
-#endif
-#ifdef HAVE_FSYNC
-	/* always fsync the device, even if flushing our own cache failed */
-	retval2 = maybe_fsync(channel);
-	if (retval2 && !retval)
-		retval = retval2;
-#endif
-	return retval;
+	return unix_flush_tag(channel, 0);
 }
 
 static errcode_t unix_set_option(io_channel channel, const char *option,
@@ -1547,7 +1648,8 @@ static errcode_t unix_set_option(io_channel channel, const char *option,
 			return 0;
 		}
 		if (!strcmp(arg, "off")) {
-			retval = flush_cached_blocks(channel, data, 0);
+			retval = flush_cached_blocks(channel, data,
+						     IO_CHANNEL_TAG_NULL, 0);
 			data->flags |= IO_FLAG_NOCACHE;
 			return retval;
 		}
@@ -1748,11 +1850,15 @@ static struct struct_io_manager struct_unix_manager = {
 	.read_blk	= unix_read_blk,
 	.write_blk	= unix_write_blk,
 	.flush		= unix_flush,
+	.flush_tag	= unix_flush_tag,
+	.invalidate_tag	= unix_invalidate_tag,
 	.write_byte	= unix_write_byte,
 	.set_option	= unix_set_option,
 	.get_stats	= unix_get_stats,
 	.read_blk64	= unix_read_blk64,
 	.write_blk64	= unix_write_blk64,
+	.read_tagblk	= unix_read_tagblk,
+	.write_tagblk	= unix_write_tagblk,
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
@@ -1771,11 +1877,15 @@ static struct struct_io_manager struct_unixfd_manager = {
 	.read_blk	= unix_read_blk,
 	.write_blk	= unix_write_blk,
 	.flush		= unix_flush,
+	.flush_tag	= unix_flush_tag,
+	.invalidate_tag	= unix_invalidate_tag,
 	.write_byte	= unix_write_byte,
 	.set_option	= unix_set_option,
 	.get_stats	= unix_get_stats,
 	.read_blk64	= unix_read_blk64,
 	.write_blk64	= unix_write_blk64,
+	.read_tagblk	= unix_read_tagblk,
+	.write_tagblk	= unix_write_tagblk,
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,


