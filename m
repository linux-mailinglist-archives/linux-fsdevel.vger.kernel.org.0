Return-Path: <linux-fsdevel+bounces-61656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263D1B58AC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AEF3AA1BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495DB1F5834;
	Tue, 16 Sep 2025 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYpIsmVO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3324E571;
	Tue, 16 Sep 2025 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984841; cv=none; b=mTbt5KIzIgVm/SyrxomXmu0SPfc5Krr5KVWL5euL3T2akgcYH5l0Nbst2jyipL4mtoiK4NFqbPE/MAjxSr/Ful7yYhyPnJpckPyj4iUuKI/crVMqrbOxTMESLz0uN1h/SGYW6C21D253T+wyYQi/3cQ2eFmMZiSXxlhZVi7KnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984841; c=relaxed/simple;
	bh=kSX9iVb3p+vX+r9uQ1W0SZDgfOipH3A0earEWrzVh78=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/MLM9NrwTFpb0X75jREl6k9XaGpc7x17/ChH9XW5LogKcb87WIt2RangEj5xoWwrVEVW38Xia9+GvOV8hMgNklEclg97I6tXA6uIsSEeQLHk8v0ouNl5VGLsAiBXlrPdvkYqivvJPkjUSJ3lm7PMRNEVzXcRwmEb8kjQz7snfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYpIsmVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66289C4CEF1;
	Tue, 16 Sep 2025 01:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984841;
	bh=kSX9iVb3p+vX+r9uQ1W0SZDgfOipH3A0earEWrzVh78=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iYpIsmVO69AQS9E1rp/LuTdV1rX/ZWR98KxbVAqVg0IcvnWuCAKEi04FTqQz1gWio
	 0w083cqgI+d4map2w/9XUu0b+nymdA4o6HspWJhjOiA+iQv2WP1sOp31KpyeUXDmLf
	 c+bP4VSW1d0TubPBUpmR4E52goUMyUHGu4mZDB+0KXpzcpd+v5X9eHuqKorRP7KJRf
	 Q6fsHnmwUqbaKfjmzDB7cxI36g692QfwNy2yZWjJtxp2CsF4udoWSOEGeabGDbMSUD
	 H/GE3hjbUX6M4a01GVywgF31h+4vpAvKCyaKfpsvWtv5XbvAmBBQiwIm7Jlc1vP5ds
	 2lzIDdDhTHjzA==
Date: Mon, 15 Sep 2025 18:07:20 -0700
Subject: [PATCH 2/6] iocache: add the actual buffer cache
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162888.391868.9185646628937727979.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162827.391868.5088762964182041258.stgit@frogsfrogsfrogs>
References: <175798162827.391868.5088762964182041258.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Wire up buffer caching into our new caching IO manager.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/iocache.c |  469 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 447 insertions(+), 22 deletions(-)


diff --git a/lib/support/iocache.c b/lib/support/iocache.c
index 9870780d65ef61..ab879e85d18f2a 100644
--- a/lib/support/iocache.c
+++ b/lib/support/iocache.c
@@ -9,46 +9,288 @@
  * %End-Header%
  */
 #include "config.h"
+#include <assert.h>
+#include <stdbool.h>
+#include <pthread.h>
+#include <unistd.h>
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fs.h"
 #include "ext2fs/ext2fsP.h"
 #include "support/iocache.h"
+#include "support/list.h"
+#include "support/cache.h"
 
 #define IOCACHE_IO_CHANNEL_MAGIC	0x424F5254	/* BORT */
 
 static io_manager iocache_backing_manager;
 
+static inline uint64_t B_TO_FSBT(io_channel channel, uint64_t number) {
+	return number / channel->block_size;
+}
+
+static inline uint64_t B_TO_FSB(io_channel channel, uint64_t number) {
+	return (number + channel->block_size - 1) / channel->block_size;
+}
+
 struct iocache_private_data {
 	int			magic;
-	io_channel		real;
+	io_channel		real;		/* lower level io channel */
+	io_channel		channel;	/* cache channel */
+	struct cache		cache;
+	pthread_mutex_t		stats_lock;
+	struct struct_io_stats	io_stats;
+	unsigned long long	write_errors;
 };
 
+#define IOCACHEDATA(cache) \
+	(container_of(cache, struct iocache_private_data, cache))
+
 static struct iocache_private_data *IOCACHE(io_channel channel)
 {
 	return (struct iocache_private_data *)channel->private_data;
 }
 
-static errcode_t iocache_read_error(io_channel channel, unsigned long block,
-				    int count, void *data, size_t size,
-				    int actual_bytes_read, errcode_t error)
+struct iocache_buf {
+	struct cache_node	node;
+	struct list_head	list;
+	blk64_t			block;
+	void			*buf;
+	errcode_t		write_error;
+	unsigned int		uptodate:1;
+	unsigned int		dirty:1;
+};
+
+static inline void iocache_buf_lock(struct iocache_buf *ubuf)
 {
-	io_channel iocache_channel = channel->app_data;
+	pthread_mutex_lock(&ubuf->node.cn_mutex);
+}
 
-	return iocache_channel->read_error(iocache_channel, block, count, data,
-					   size, actual_bytes_read, error);
+static inline void iocache_buf_unlock(struct iocache_buf *ubuf)
+{
+	pthread_mutex_unlock(&ubuf->node.cn_mutex);
 }
 
-static errcode_t iocache_write_error(io_channel channel, unsigned long block,
-				     int count, const void *data, size_t size,
-				     int actual_bytes_written,
-				     errcode_t error)
+struct iocache_key {
+	blk64_t			block;
+};
+
+#define IOKEY(key)	((struct iocache_key *)(key))
+#define IOBUF(node)	(container_of((node), struct iocache_buf, node))
+
+static unsigned int
+iocache_hash(cache_key_t key, unsigned int hashsize, unsigned int hashshift)
 {
-	io_channel iocache_channel = channel->app_data;
+	uint64_t	hashval = IOKEY(key)->block;
+	uint64_t	tmp;
 
-	return iocache_channel->write_error(iocache_channel, block, count, data,
-					    size, actual_bytes_written, error);
+	tmp = hashval ^ (GOLDEN_RATIO_PRIME + hashval) / CACHE_LINE_SIZE;
+	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> hashshift);
+	return tmp % hashsize;
 }
 
+static int iocache_compare(struct cache_node *node, cache_key_t key)
+{
+	struct iocache_buf *ubuf = IOBUF(node);
+	struct iocache_key *ukey = IOKEY(key);
+
+	if (ubuf->block == ukey->block)
+		return CACHE_HIT;
+
+	return CACHE_MISS;
+}
+
+static struct cache_node *iocache_alloc_node(struct cache *cache,
+					     cache_key_t key)
+{
+	struct iocache_private_data *data = IOCACHEDATA(cache);
+	struct iocache_key *ukey = IOKEY(key);
+	struct iocache_buf *ubuf;
+	errcode_t retval;
+
+	retval = ext2fs_get_mem(sizeof(struct iocache_buf), &ubuf);
+	if (retval)
+		return NULL;
+	memset(ubuf, 0, sizeof(*ubuf));
+
+	retval = io_channel_alloc_buf(data->channel, 0, &ubuf->buf);
+	if (retval) {
+		free(ubuf);
+		return NULL;
+	}
+	memset(ubuf->buf, 0, data->channel->block_size);
+
+	INIT_LIST_HEAD(&ubuf->list);
+	ubuf->block = ukey->block;
+	return &ubuf->node;
+}
+
+static bool iocache_flush_node(struct cache *cache, struct cache_node *node)
+{
+	struct iocache_private_data *data = IOCACHEDATA(cache);
+	struct iocache_buf *ubuf = IOBUF(node);
+	errcode_t retval;
+
+	if (ubuf->dirty) {
+		retval = io_channel_write_blk64(data->real, ubuf->block, 1,
+						ubuf->buf);
+		if (retval) {
+			ubuf->write_error = retval;
+			data->write_errors++;
+		} else {
+			ubuf->dirty = 0;
+			ubuf->write_error = 0;
+		}
+	}
+
+	return ubuf->dirty;
+}
+
+static void iocache_relse(struct cache *cache, struct cache_node *node)
+{
+	struct iocache_buf *ubuf = IOBUF(node);
+
+	assert(!ubuf->dirty);
+
+	ext2fs_free_mem(&ubuf->buf);
+	ext2fs_free_mem(&ubuf);
+}
+
+static unsigned int iocache_bulkrelse(struct cache *cache,
+				      struct list_head *list)
+{
+	struct cache_node *cn, *n;
+	int count = 0;
+
+	if (list_empty(list))
+		return 0;
+
+	list_for_each_entry_safe(cn, n, list, cn_mru) {
+		iocache_relse(cache, cn);
+		count++;
+	}
+
+	return count;
+}
+
+/* Flush all dirty buffers in the cache to disk. */
+static errcode_t iocache_flush_cache(struct iocache_private_data *data)
+{
+	return cache_flush(&data->cache) ? 0 : EIO;
+}
+
+/* Flush all dirty buffers in this range of the cache to disk. */
+static errcode_t iocache_flush_range(struct iocache_private_data *data,
+				     blk64_t block, uint64_t count)
+{
+	uint64_t i;
+	bool still_dirty = false;
+
+	for (i = 0; i < count; i++) {
+		struct iocache_key ukey = {
+			.block = block + i,
+		};
+		struct cache_node *node;
+
+		cache_node_get(&data->cache, &ukey, CACHE_GET_INCORE,
+			       &node);
+		if (!node)
+			continue;
+
+		/* cache_flush holds cn_mutex across the node flush */
+		pthread_mutex_unlock(&node->cn_mutex);
+		still_dirty |= iocache_flush_node(&data->cache, node);
+		pthread_mutex_unlock(&node->cn_mutex);
+
+		cache_node_put(&data->cache, node);
+	}
+
+	return still_dirty ? EIO : 0;
+}
+
+static void iocache_add_list(struct cache *cache, struct cache_node *node,
+			     void *data)
+{
+	struct iocache_buf *ubuf = IOBUF(node);
+	struct list_head *list = data;
+
+	assert(node->cn_count == 0 || node->cn_count == 1);
+
+	iocache_buf_lock(ubuf);
+	cache_node_grab(cache, node);
+	list_add_tail(&ubuf->list, list);
+	iocache_buf_unlock(ubuf);
+}
+
+static void iocache_invalidate_bufs(struct iocache_private_data *data,
+				    struct list_head *list)
+{
+	struct iocache_buf *ubuf, *n;
+
+	list_for_each_entry_safe(ubuf, n, list, list) {
+		struct iocache_key ukey = {
+			.block = ubuf->block,
+		};
+
+		assert(ubuf->node.cn_count == 1);
+
+		iocache_buf_lock(ubuf);
+		ubuf->dirty = 0;
+		list_del_init(&ubuf->list);
+		iocache_buf_unlock(ubuf);
+
+		cache_node_put(&data->cache, &ubuf->node);
+		cache_node_purge(&data->cache, &ukey, &ubuf->node);
+	}
+}
+
+/*
+ * Remove all blocks from the cache.  Dirty contents are discarded.  Buffer
+ * refcounts must be zero!
+ */
+static void iocache_invalidate_cache(struct iocache_private_data *data)
+{
+	LIST_HEAD(list);
+
+	cache_walk(&data->cache, iocache_add_list, &list);
+	iocache_invalidate_bufs(data, &list);
+}
+
+/*
+ * Remove a range of blocks from the cache.  Dirty contents are discarded.
+ * Buffer refcounts must be zero!
+ */
+static void iocache_invalidate_range(struct iocache_private_data *data,
+				     blk64_t block, uint64_t count)
+{
+	LIST_HEAD(list);
+	uint64_t i;
+
+	for (i = 0; i < count; i++) {
+		struct iocache_key ukey = {
+			.block = block + i,
+		};
+		struct cache_node *node;
+
+		cache_node_get(&data->cache, &ukey, CACHE_GET_INCORE,
+			       &node);
+		if (node) {
+			iocache_add_list(&data->cache, node, &list);
+			cache_node_put(&data->cache, node);
+		}
+	}
+	iocache_invalidate_bufs(data, &list);
+}
+
+static const struct cache_operations iocache_ops = {
+	.hash		= iocache_hash,
+	.alloc		= iocache_alloc_node,
+	.flush		= iocache_flush_node,
+	.relse		= iocache_relse,
+	.compare	= iocache_compare,
+	.bulkrelse	= iocache_bulkrelse,
+	.resize		= cache_gradual_resize,
+};
+
 static errcode_t iocache_open(const char *name, int flags, io_channel *channel)
 {
 	io_channel	io = NULL;
@@ -65,6 +307,9 @@ static errcode_t iocache_open(const char *name, int flags, io_channel *channel)
 	if (retval)
 		return retval;
 
+	/* disable any static cache in the lower io manager */
+	real->manager->set_option(real, "cache", "off");
+
 	retval = ext2fs_get_mem(sizeof(struct struct_io_channel), &io);
 	if (retval)
 		goto out_backing;
@@ -76,12 +321,19 @@ static errcode_t iocache_open(const char *name, int flags, io_channel *channel)
 		goto out_channel;
 	memset(data, 0, sizeof(struct iocache_private_data));
 	data->magic = IOCACHE_IO_CHANNEL_MAGIC;
+	data->io_stats.num_fields = 4;
+	data->channel = io;
 
 	io->manager = iocache_io_manager;
 	retval = ext2fs_get_mem(strlen(name) + 1, &io->name);
 	if (retval)
 		goto out_data;
 
+	retval = cache_init(CACHE_CAN_SHRINK, 1U << 10, &iocache_ops,
+			    &data->cache);
+	if (retval)
+		goto out_name;
+
 	strcpy(io->name, name);
 	io->private_data = data;
 	io->block_size = real->block_size;
@@ -91,12 +343,14 @@ static errcode_t iocache_open(const char *name, int flags, io_channel *channel)
 	io->flags = real->flags;
 	data->real = real;
 	real->app_data = io;
-	real->read_error = iocache_read_error;
-	real->write_error = iocache_write_error;
+
+	pthread_mutex_init(&data->stats_lock, NULL);
 
 	*channel = io;
 	return 0;
 
+out_name:
+	ext2fs_free_mem(&io->name);
 out_data:
 	ext2fs_free_mem(&data);
 out_channel:
@@ -116,6 +370,10 @@ static errcode_t iocache_close(io_channel channel)
 
 	if (--channel->refcount > 0)
 		return 0;
+	pthread_mutex_destroy(&data->stats_lock);
+	cache_flush(&data->cache);
+	cache_purge(&data->cache);
+	cache_destroy(&data->cache);
 	if (data->real)
 		retval = io_channel_close(data->real);
 	ext2fs_free_mem(&channel->private_data);
@@ -134,6 +392,11 @@ static errcode_t iocache_set_blksize(io_channel channel, int blksize)
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
 
+	retval = iocache_flush_cache(data);
+	if (retval)
+		return retval;
+	iocache_invalidate_cache(data);
+
 	retval = io_channel_set_blksize(data->real, blksize);
 	if (retval)
 		return retval;
@@ -145,21 +408,34 @@ static errcode_t iocache_set_blksize(io_channel channel, int blksize)
 static errcode_t iocache_flush(io_channel channel)
 {
 	struct iocache_private_data *data = IOCACHE(channel);
+	errcode_t retval = 0;
+	errcode_t retval2;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
 
-	return io_channel_flush(data->real);
+	retval = iocache_flush_cache(data);
+	retval2 = io_channel_flush(data->real);
+	if (retval)
+		return retval;
+	return retval2;
 }
 
 static errcode_t iocache_write_byte(io_channel channel, unsigned long offset,
 				    int count, const void *buf)
 {
 	struct iocache_private_data *data = IOCACHE(channel);
+	blk64_t bno = B_TO_FSBT(channel, offset);
+	blk64_t next_bno = B_TO_FSB(channel, offset + count);
+	errcode_t retval;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
 
+	retval = iocache_flush_range(data, bno, next_bno - bno);
+	if (retval)
+		return retval;
+	iocache_invalidate_range(data, bno, next_bno - bno);
 	return io_channel_write_byte(data->real, offset, count, buf);
 }
 
@@ -170,6 +446,16 @@ static errcode_t iocache_set_option(io_channel channel, const char *option,
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+	errcode_t retval;
+
+	/* don't let unix io cache options leak through */
+	if (!strcmp(option, "cache_blocks") || !strcmp(option, "cache"))
+		return 0;
+
+	retval = iocache_flush_cache(data);
+	if (retval)
+		return retval;
+	iocache_invalidate_cache(data);
 
 	return data->real->manager->set_option(data->real, option, arg);
 }
@@ -181,31 +467,157 @@ static errcode_t iocache_get_stats(io_channel channel, io_stats *io_stats)
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
 
-	return data->real->manager->get_stats(data->real, io_stats);
+	/*
+	 * Yes, io_stats is a double-pointer, and we let the caller scribble on
+	 * our stats struct WITHOUT LOCKING!
+	 */
+	if (io_stats)
+		*io_stats = &data->io_stats;
+	return 0;
+}
+
+static void iocache_update_stats(struct iocache_private_data *data,
+				 unsigned long long bytes_read,
+				 unsigned long long bytes_written,
+				 int cache_op)
+{
+	pthread_mutex_lock(&data->stats_lock);
+	data->io_stats.bytes_read += bytes_read;
+	data->io_stats.bytes_written += bytes_written;
+	if (cache_op == CACHE_HIT)
+		data->io_stats.cache_hits++;
+	else
+		data->io_stats.cache_misses++;
+	pthread_mutex_unlock(&data->stats_lock);
 }
 
 static errcode_t iocache_read_blk64(io_channel channel,
 				    unsigned long long block, int count,
 				    void *buf)
 {
+	struct iocache_key ukey = {
+		.block = block,
+	};
 	struct iocache_private_data *data = IOCACHE(channel);
+	unsigned long long i;
+	errcode_t retval;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
 
-	return io_channel_read_blk64(data->real, block, count, buf);
+	/*
+	 * If we're doing an odd-sized read, flush out the cache and then do a
+	 * direct read.
+	 */
+	if (count < 0) {
+		uint64_t fsbcount = B_TO_FSB(channel, -count);
+
+		retval = iocache_flush_range(data, block, fsbcount);
+		if (retval)
+			return retval;
+		iocache_invalidate_range(data, block, fsbcount);
+		iocache_update_stats(data, 0, 0, CACHE_MISS);
+		return io_channel_read_blk64(data->real, block, count, buf);
+	}
+
+	for (i = 0; i < count; i++, ukey.block++, buf += channel->block_size) {
+		struct cache_node *node;
+		struct iocache_buf *ubuf;
+
+		cache_node_get(&data->cache, &ukey, 0, &node);
+		if (!node) {
+			/* cannot instantiate cache, just do a direct read */
+			retval = io_channel_read_blk64(data->real, ukey.block,
+						       1, buf);
+			if (retval)
+				return retval;
+			iocache_update_stats(data, channel->block_size, 0,
+					     CACHE_MISS);
+			continue;
+		}
+
+		ubuf = IOBUF(node);
+		iocache_buf_lock(ubuf);
+		if (!ubuf->uptodate) {
+			retval = io_channel_read_blk64(data->real, ukey.block,
+						       1, ubuf->buf);
+			if (!retval) {
+				ubuf->uptodate = 1;
+				iocache_update_stats(data, channel->block_size,
+						     0, CACHE_MISS);
+			}
+		} else {
+			iocache_update_stats(data, channel->block_size, 0,
+					     CACHE_HIT);
+		}
+		if (ubuf->uptodate)
+			memcpy(buf, ubuf->buf, channel->block_size);
+		iocache_buf_unlock(ubuf);
+		cache_node_put(&data->cache, node);
+		if (retval)
+			return retval;
+	}
+
+	return 0;
 }
 
 static errcode_t iocache_write_blk64(io_channel channel,
 				     unsigned long long block, int count,
 				     const void *buf)
 {
+	struct iocache_key ukey = {
+		.block = block,
+	};
 	struct iocache_private_data *data = IOCACHE(channel);
+	unsigned long long i;
+	errcode_t retval;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
 
-	return io_channel_write_blk64(data->real, block, count, buf);
+	/*
+	 * If we're doing an odd-sized write, flush out the cache and then do a
+	 * direct write.
+	 */
+	if (count < 0) {
+		uint64_t fsbcount = B_TO_FSB(channel, -count);
+
+		retval = iocache_flush_range(data, block, fsbcount);
+		if (retval)
+			return retval;
+		iocache_invalidate_range(data, block, fsbcount);
+		iocache_update_stats(data, 0, 0, CACHE_MISS);
+		return io_channel_write_blk64(data->real, block, count, buf);
+	}
+
+	for (i = 0; i < count; i++, ukey.block++, buf += channel->block_size) {
+		struct cache_node *node;
+		struct iocache_buf *ubuf;
+
+		cache_node_get(&data->cache, &ukey, 0, &node);
+		if (!node) {
+			/* cannot instantiate cache, do a direct write */
+			retval = io_channel_write_blk64(data->real, ukey.block,
+							1, buf);
+			if (retval)
+				return retval;
+			iocache_update_stats(data, 0, channel->block_size,
+					     CACHE_MISS);
+			continue;
+		}
+
+		ubuf = IOBUF(node);
+		iocache_buf_lock(ubuf);
+		memcpy(ubuf->buf, buf, channel->block_size);
+		iocache_update_stats(data, 0, channel->block_size,
+				     ubuf->uptodate ? CACHE_HIT : CACHE_MISS);
+		ubuf->dirty = 1;
+		ubuf->uptodate = 1;
+		iocache_buf_unlock(ubuf);
+		cache_node_put(&data->cache, node);
+	}
+
+	return 0;
 }
 
 static errcode_t iocache_read_blk(io_channel channel, unsigned long block,
@@ -224,11 +636,17 @@ static errcode_t iocache_discard(io_channel channel, unsigned long long block,
 				 unsigned long long count)
 {
 	struct iocache_private_data *data = IOCACHE(channel);
+	errcode_t retval;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
 
-	return io_channel_discard(data->real, block, count);
+	retval = io_channel_discard(data->real, block, count);
+	if (retval)
+		return retval;
+
+	iocache_invalidate_range(data, block, count);
+	return 0;
 }
 
 static errcode_t iocache_cache_readahead(io_channel channel,
@@ -247,11 +665,17 @@ static errcode_t iocache_zeroout(io_channel channel, unsigned long long block,
 				 unsigned long long count)
 {
 	struct iocache_private_data *data = IOCACHE(channel);
+	errcode_t retval;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
 
-	return io_channel_zeroout(data->real, block, count);
+	retval = io_channel_zeroout(data->real, block, count);
+	if (retval)
+		return retval;
+
+	iocache_invalidate_range(data, block, count);
+	return 0;
 }
 
 static errcode_t iocache_get_fd(io_channel channel, int *fd)
@@ -273,6 +697,7 @@ static errcode_t iocache_invalidate_blocks(io_channel channel,
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
 
+	iocache_invalidate_range(data, block, count);
 	return io_channel_invalidate_blocks(data->real, block, count);
 }
 


