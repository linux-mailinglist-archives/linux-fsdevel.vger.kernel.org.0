Return-Path: <linux-fsdevel+bounces-78187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPhXO+HmnGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:46:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D8A17FF03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 915FB310B369
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFF937FF65;
	Mon, 23 Feb 2026 23:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxLoAah2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01A1E9B1A;
	Mon, 23 Feb 2026 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890296; cv=none; b=n22oHstC6owcsR+u7tFRC8OJA3iXL8p2zNBDgqby8vbEgYgR5tkPoid8Sq5aukPU4KQsNljgd2YGTPaWDPGEtQUDwWcUiEPsYE9w+fXGTR/TtKf/l4lUngPsV21C+BYQsH3rmJF/osc7A2LMhrCO32dt2Bscco4L1b710a8QWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890296; c=relaxed/simple;
	bh=15qJvEDtDzqQ5zF5OXJVtr1H+AX5Id6kF/aVve0ZAtE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pr5NK7Jy2r+LPTAl+VFFNw7hjVOCS3BELQAUMpoSQHX37u9HaknW5M15OCrjmQ1PYuTppwV0g+A3DKBbD3lAvZEUmLW9MJ0J42cXYJgdqFivHUBoLnNoqm0JQwiXbkNq/y7PezyYd4YmB1xC/K3eHFi2nm6TutY7odXIsczvUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxLoAah2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95377C116C6;
	Mon, 23 Feb 2026 23:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890296;
	bh=15qJvEDtDzqQ5zF5OXJVtr1H+AX5Id6kF/aVve0ZAtE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mxLoAah2jHy0s7ph/fwVajKIG/hl+pY1y6s24gV9Cx9q4pXsXGSm2V+bDettch1WB
	 Lzycf+zKar+xMhkQelaDwODOCoyjHY2PzKXcgh9VKuHX+LuL4edLm+zyp5ouIXzxN0
	 kvZr4fXqRiBYcQ4igh5lwF1VpoAKZ8qUDHfYSCbtJpTP65NESwmhRvnJjJIsQefWb6
	 8SwtDcSg7I1NO4b864GJPfIr1v5iVZWXTDpPzetrDpReAyzAGDPPteWWcq84RNW1kM
	 X/wz5qX+Quwt2DmOMdeJ3w1jwhSEocrIGpC5aggVADVFeQHM3diDk2DXZKUq14aUsT
	 t0e0BIDYP/LIw==
Date: Mon, 23 Feb 2026 15:44:56 -0800
Subject: [PATCH 1/6] libsupport: add caching IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745710.3944626.12922351035440029162.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745668.3944626.16408108516155796668.stgit@frogsfrogsfrogs>
References: <177188745668.3944626.16408108516155796668.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78187-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98D8A17FF03
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Start creating a caching IO manager so that we can have better caching
of metadata blocks in fuse2fs.  For now it's just a passthrough cache.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/iocache.h   |   17 +++
 lib/ext2fs/io_manager.c |    3 
 lib/support/Makefile.in |    6 +
 lib/support/iocache.c   |  317 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 342 insertions(+), 1 deletion(-)
 create mode 100644 lib/support/iocache.h
 create mode 100644 lib/support/iocache.c


diff --git a/lib/support/iocache.h b/lib/support/iocache.h
new file mode 100644
index 00000000000000..502eede08aadc5
--- /dev/null
+++ b/lib/support/iocache.h
@@ -0,0 +1,17 @@
+/*
+ * iocache.h - IO cache
+ *
+ * Copyright (C) 2025-2026 Oracle.
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
index a92dba7b9dc880..a93415c151ffa0 100644
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
index a09814f574008c..2950e80222ee72 100644
--- a/lib/support/Makefile.in
+++ b/lib/support/Makefile.in
@@ -15,6 +15,7 @@ all::
 
 OBJS=		bthread.o \
 		cstring.o \
+		iocache.o \
 		mkquota.o \
 		plausible.o \
 		profile.o \
@@ -44,7 +45,8 @@ SRCS=		$(srcdir)/argv_parse.c \
 		$(srcdir)/quotaio_v2.c \
 		$(srcdir)/dict.c \
 		$(srcdir)/devname.c \
-		$(srcdir)/cache.c
+		$(srcdir)/cache.c \
+		$(srcdir)/iocache.c
 
 LIBRARY= libsupport
 LIBDIR= support
@@ -191,3 +193,5 @@ devname.o: $(srcdir)/devname.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/devname.h $(srcdir)/nls-enable.h
 cache.o: $(srcdir)/cache.c $(top_builddir)/lib/config.h \
  $(srcdir)/cache.h $(srcdir)/list.h $(srcdir)/xbitops.h
+iocache.o: $(srcdir)/iocache.c $(top_builddir)/lib/config.h \
+ $(srcdir)/iocache.h $(srcdir)/cache.h $(srcdir)/list.h $(srcdir)/xbitops.h
diff --git a/lib/support/iocache.c b/lib/support/iocache.c
new file mode 100644
index 00000000000000..615f1fcc2d7f84
--- /dev/null
+++ b/lib/support/iocache.c
@@ -0,0 +1,317 @@
+/*
+ * iocache.c - caching IO manager
+ *
+ * Copyright (C) 2025-2026 Oracle.
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
+static errcode_t iocache_flock(io_channel channel, unsigned int flock_flags)
+{
+	struct iocache_private_data *data = IOCACHE(channel);
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	EXT2_CHECK_MAGIC(data, IOCACHE_IO_CHANNEL_MAGIC);
+
+	return io_channel_flock(data->real, flock_flags);
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
+	.flock			= iocache_flock,
+};
+
+io_manager iocache_io_manager = &struct_iocache_manager;
+
+errcode_t iocache_set_backing_manager(io_manager manager)
+{
+	iocache_backing_manager = manager;
+	return 0;
+}


