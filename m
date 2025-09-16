Return-Path: <linux-fsdevel+bounces-61655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF883B58AC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB8E3ABAE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B471AC43A;
	Tue, 16 Sep 2025 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmhVJoNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F920322;
	Tue, 16 Sep 2025 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984826; cv=none; b=tmkLi7D3AFCf9GHP3+pdnp5QpagYdLkkWPBTJxpDzsejBBdzPyPdCBGVNeBQ45JYPl7HrlGYShXxZHY6FEdccvEVMb/EPDdL4KutHBe2HsVdDn3MQLuFZDRfHh+L2zKiWRLZitLVpO3xkmwkOOt9XLeMEp20bxH5lkXrc1a77Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984826; c=relaxed/simple;
	bh=c5NldX339crqQbNibwk4fXbrlazyBJdJjzX/1FNUXYg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1PexG0YmqNwockAz11alCZ2To2L9ppfzipmaAHaODJFONPUA0ypwtilqsSD1qwlybxHnIIgoXWtGGCcGJNRXqNR5CjwRcjLZmS+uJm0ioNjCFlj4baCGwatjeeN1iy2fJDWSMi0Mqz+YZlpfTad4/2Cb7glH4oLcF0DKNqdsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmhVJoNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C490DC4CEF1;
	Tue, 16 Sep 2025 01:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984825;
	bh=c5NldX339crqQbNibwk4fXbrlazyBJdJjzX/1FNUXYg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZmhVJoNXh8KyULWYaLfDqqELShlkT6BtUyUurcWiq+mbVqXHbwvGqoUaqJ5ARu0Lk
	 kev4znRRrvhFSN5IqJnZACNdxPrYObDx+UT7lMqN52fGAn3R+WXpRgLmXK3UkJuO9p
	 6cBIOLcEBbkbs+TZMM87P+p84uVvaxjwQ+bb2ece75d/+aaq333zfL3RcJw3XJC497
	 aGYCZe5pFoeeHecs4+Q3WXOV1AELrCh+BqIFf29LbDu2HIlex1kShnuMCd6Q+X3LGe
	 d2qNWQ1G6qLqEPJRRAKanF46ylN8YYGi/P8/HNQTjR9kCfXEH6G0t0JHxPsAY+Y2Ey
	 uzBsGKlooDHkA==
Date: Mon, 15 Sep 2025 18:07:05 -0700
Subject: [PATCH 1/6] libsupport: add caching IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162870.391868.5619533958862967464.stgit@frogsfrogsfrogs>
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

Start creating a caching IO manager so that we can have better caching
of metadata blocks in fuse2fs.  For now it's just a passthrough cache.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/iocache.h   |   17 +++
 lib/ext2fs/io_manager.c |    3 
 lib/support/Makefile.in |    6 +
 lib/support/iocache.c   |  306 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 331 insertions(+), 1 deletion(-)
 create mode 100644 lib/support/iocache.h
 create mode 100644 lib/support/iocache.c


diff --git a/lib/support/iocache.h b/lib/support/iocache.h
new file mode 100644
index 00000000000000..3c1d1df00e25bd
--- /dev/null
+++ b/lib/support/iocache.h
@@ -0,0 +1,17 @@
+/*
+ * iocache.h - IO cache
+ *
+ * Copyright (C) 2025 Oracle.
+ *
+ * %Begin-Header%
+ * This file may be redistributed under the terms of the GNU Public
+ * License.
+ * %End-Header%
+ */
+#ifndef __IOCACHE_H__
+#define __IOCACHE_H__
+
+errcode_t iocache_set_backing_manager(io_manager manager);
+extern io_manager iocache_io_manager;
+
+#endif /* __IOCACHE_H__ */
diff --git a/lib/ext2fs/io_manager.c b/lib/ext2fs/io_manager.c
index c91fab4eb290d5..7a6a6bfedc8a1c 100644
--- a/lib/ext2fs/io_manager.c
+++ b/lib/ext2fs/io_manager.c
@@ -16,9 +16,12 @@
 #if HAVE_SYS_TYPES_H
 #include <sys/types.h>
 #endif
+#include <stdbool.h>
 
 #include "ext2_fs.h"
 #include "ext2fs.h"
+#include "support/list.h"
+#include "support/cache.h"
 
 errcode_t io_channel_set_options(io_channel channel, const char *opts)
 {
diff --git a/lib/support/Makefile.in b/lib/support/Makefile.in
index 13d6f06f150afd..98a9bd42eef55e 100644
--- a/lib/support/Makefile.in
+++ b/lib/support/Makefile.in
@@ -14,6 +14,7 @@ MKDIR_P = @MKDIR_P@
 all::
 
 OBJS=		cstring.o \
+		iocache.o \
 		mkquota.o \
 		plausible.o \
 		profile.o \
@@ -42,7 +43,8 @@ SRCS=		$(srcdir)/argv_parse.c \
 		$(srcdir)/quotaio_v2.c \
 		$(srcdir)/dict.c \
 		$(srcdir)/devname.c \
-		$(srcdir)/cache.c
+		$(srcdir)/cache.c \
+		$(srcdir)/iocache.c
 
 LIBRARY= libsupport
 LIBDIR= support
@@ -187,3 +189,5 @@ devname.o: $(srcdir)/devname.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/devname.h $(srcdir)/nls-enable.h
 cache.o: $(srcdir)/cache.c $(top_builddir)/lib/config.h \
  $(srcdir)/cache.h $(srcdir)/list.h $(srcdir)/xbitops.h
+iocache.o: $(srcdir)/iocache.c $(top_builddir)/lib/config.h \
+ $(srcdir)/iocache.h $(srcdir)/cache.h $(srcdir)/list.h $(srcdir)/xbitops.h
diff --git a/lib/support/iocache.c b/lib/support/iocache.c
new file mode 100644
index 00000000000000..9870780d65ef61
--- /dev/null
+++ b/lib/support/iocache.c
@@ -0,0 +1,306 @@
+/*
+ * fuse4fs.c - FUSE low-level server for e2fsprogs.
+ *
+ * Copyright (C) 2025 Oracle.
+ *
+ * %Begin-Header%
+ * This file may be redistributed under the terms of the GNU Public
+ * License.
+ * %End-Header%
+ */
+#include "config.h"
+#include "ext2fs/ext2_fs.h"
+#include "ext2fs/ext2fs.h"
+#include "ext2fs/ext2fsP.h"
+#include "support/iocache.h"
+
+#define IOCACHE_IO_CHANNEL_MAGIC	0x424F5254	/* BORT */
+
+static io_manager iocache_backing_manager;
+
+struct iocache_private_data {
+	int			magic;
+	io_channel		real;
+};
+
+static struct iocache_private_data *IOCACHE(io_channel channel)
+{
+	return (struct iocache_private_data *)channel->private_data;
+}
+
+static errcode_t iocache_read_error(io_channel channel, unsigned long block,
+				    int count, void *data, size_t size,
+				    int actual_bytes_read, errcode_t error)
+{
+	io_channel iocache_channel = channel->app_data;
+
+	return iocache_channel->read_error(iocache_channel, block, count, data,
+					   size, actual_bytes_read, error);
+}
+
+static errcode_t iocache_write_error(io_channel channel, unsigned long block,
+				     int count, const void *data, size_t size,
+				     int actual_bytes_written,
+				     errcode_t error)
+{
+	io_channel iocache_channel = channel->app_data;
+
+	return iocache_channel->write_error(iocache_channel, block, count, data,
+					    size, actual_bytes_written, error);
+}
+
+static errcode_t iocache_open(const char *name, int flags, io_channel *channel)
+{
+	io_channel	io = NULL;
+	io_channel	real;
+	struct iocache_private_data *data = NULL;
+	errcode_t	retval;
+
+	if (!name)
+		return EXT2_ET_BAD_DEVICE_NAME;
+	if (!iocache_backing_manager)
+		return EXT2_ET_INVALID_ARGUMENT;
+
+	retval = iocache_backing_manager->open(name, flags, &real);
+	if (retval)
+		return retval;
+
+	retval = ext2fs_get_mem(sizeof(struct struct_io_channel), &io);
+	if (retval)
+		goto out_backing;
+	memset(io, 0, sizeof(struct struct_io_channel));
+	io->magic = EXT2_ET_MAGIC_IO_CHANNEL;
+
+	retval = ext2fs_get_mem(sizeof(struct iocache_private_data), &data);
+	if (retval)
+		goto out_channel;
+	memset(data, 0, sizeof(struct iocache_private_data));
+	data->magic = IOCACHE_IO_CHANNEL_MAGIC;
+
+	io->manager = iocache_io_manager;
+	retval = ext2fs_get_mem(strlen(name) + 1, &io->name);
+	if (retval)
+		goto out_data;
+
+	strcpy(io->name, name);
+	io->private_data = data;
+	io->block_size = real->block_size;
+	io->read_error = 0;
+	io->write_error = 0;
+	io->refcount = 1;
+	io->flags = real->flags;
+	data->real = real;
+	real->app_data = io;
+	real->read_error = iocache_read_error;
+	real->write_error = iocache_write_error;
+
+	*channel = io;
+	return 0;
+
+out_data:
+	ext2fs_free_mem(&data);
+out_channel:
+	ext2fs_free_mem(&io);
+out_backing:
+	io_channel_close(real);
+	return retval;
+}
+
+static errcode_t iocache_close(io_channel channel)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+	errcode_t	retval = 0;
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	if (--channel->refcount > 0)
+		return 0;
+	if (data->real)
+		retval = io_channel_close(data->real);
+	ext2fs_free_mem(&channel->private_data);
+	if (channel->name)
+		ext2fs_free_mem(&channel->name);
+	ext2fs_free_mem(&channel);
+
+	return retval;
+}
+
+static errcode_t iocache_set_blksize(io_channel channel, int blksize)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+	errcode_t retval;
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	retval = io_channel_set_blksize(data->real, blksize);
+	if (retval)
+		return retval;
+
+	channel->block_size = data->real->block_size;
+	return 0;
+}
+
+static errcode_t iocache_flush(io_channel channel)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	return io_channel_flush(data->real);
+}
+
+static errcode_t iocache_write_byte(io_channel channel, unsigned long offset,
+				    int count, const void *buf)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	return io_channel_write_byte(data->real, offset, count, buf);
+}
+
+static errcode_t iocache_set_option(io_channel channel, const char *option,
+				    const char *arg)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	return data->real->manager->set_option(data->real, option, arg);
+}
+
+static errcode_t iocache_get_stats(io_channel channel, io_stats *io_stats)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	return data->real->manager->get_stats(data->real, io_stats);
+}
+
+static errcode_t iocache_read_blk64(io_channel channel,
+				    unsigned long long block, int count,
+				    void *buf)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	return io_channel_read_blk64(data->real, block, count, buf);
+}
+
+static errcode_t iocache_write_blk64(io_channel channel,
+				     unsigned long long block, int count,
+				     const void *buf)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	return io_channel_write_blk64(data->real, block, count, buf);
+}
+
+static errcode_t iocache_read_blk(io_channel channel, unsigned long block,
+				  int count, void *buf)
+{
+	return iocache_read_blk64(channel, block, count, buf);
+}
+
+static errcode_t iocache_write_blk(io_channel channel, unsigned long block,
+				   int count, const void *buf)
+{
+	return iocache_write_blk64(channel, block, count, buf);
+}
+
+static errcode_t iocache_discard(io_channel channel, unsigned long long block,
+				 unsigned long long count)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	return io_channel_discard(data->real, block, count);
+}
+
+static errcode_t iocache_cache_readahead(io_channel channel,
+					 unsigned long long block,
+					 unsigned long long count)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	return io_channel_cache_readahead(data->real, block, count);
+}
+
+static errcode_t iocache_zeroout(io_channel channel, unsigned long long block,
+				 unsigned long long count)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	return io_channel_zeroout(data->real, block, count);
+}
+
+static errcode_t iocache_get_fd(io_channel channel, int *fd)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	return io_channel_get_fd(data->real, fd);
+}
+
+static errcode_t iocache_invalidate_blocks(io_channel channel,
+					   unsigned long long block,
+					   unsigned long long count)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	return io_channel_invalidate_blocks(data->real, block, count);
+}
+
+static struct struct_io_manager struct_iocache_manager = {
+	.magic			= EXT2_ET_MAGIC_IO_MANAGER,
+	.name			= "iocache I/O manager",
+	.open			= iocache_open,
+	.close			= iocache_close,
+	.set_blksize		= iocache_set_blksize,
+	.read_blk		= iocache_read_blk,
+	.write_blk		= iocache_write_blk,
+	.flush			= iocache_flush,
+	.write_byte		= iocache_write_byte,
+	.set_option		= iocache_set_option,
+	.get_stats		= iocache_get_stats,
+	.read_blk64		= iocache_read_blk64,
+	.write_blk64		= iocache_write_blk64,
+	.discard		= iocache_discard,
+	.cache_readahead	= iocache_cache_readahead,
+	.zeroout		= iocache_zeroout,
+	.get_fd			= iocache_get_fd,
+	.invalidate_blocks	= iocache_invalidate_blocks,
+};
+
+io_manager iocache_io_manager = &struct_iocache_manager;
+
+errcode_t iocache_set_backing_manager(io_manager manager)
+{
+	iocache_backing_manager = manager;
+	return 0;
+}


