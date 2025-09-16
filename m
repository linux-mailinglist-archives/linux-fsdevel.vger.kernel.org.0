Return-Path: <linux-fsdevel+bounces-61613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D3B58A4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC3D524005
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EFA1A00F0;
	Tue, 16 Sep 2025 00:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeBwmyU5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8902EFC1D;
	Tue, 16 Sep 2025 00:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984183; cv=none; b=L/REN0d2FjWHr2AT/CuJA4Si3OQOk9U0pdxePCDfsnq+su0Ehrgnd16eZRnebgFM/DornNP4K7lcHVwB8PZcRweUuKqfrn5ioNk6kvfJm4hUQqIKALnFzCm3Zr9Mcy0zLzGBhEefksH8Jo1YdTRedpGiKfiNW2tk3f1C2r91Fj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984183; c=relaxed/simple;
	bh=r/kCrrUIXJF7r4C86ELRawHvE0wSUX8TY/uRN6aZ/9A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cy0An/DIvDpmevgMFk6NZODkRvW/ztN0ImoDVGZ1TulRqcYLw3/UBjpW2CoyqN7zXiICqWdng7Y5UA4YLPKhfRF05FdMUOG6XeRsySNt1gOykehGSQDrMAk5638vrfHjrN8sJT+X+WMTbapXqqhexW4Brz7P1OUzT8E/VQUmBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeBwmyU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA2CC4CEF1;
	Tue, 16 Sep 2025 00:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984183;
	bh=r/kCrrUIXJF7r4C86ELRawHvE0wSUX8TY/uRN6aZ/9A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TeBwmyU5JY3JZqCsxNp/L3qQovEzDPvnT+6gYbtbP5awtZEYuBSvKQY6SG++v5e6b
	 fkBpEcZZ4zDQGyzPEaS/0rxw3UNGy2tJenYNRkyknNWa87B2t4XaH47m4tEX/f6EO3
	 rJeRPU1NMG9UBhQ6wH84QNi9/qZc6tMFuQs5zzaKtNbAwlsudGlsPUwUmVmOW4blje
	 aVDfNYbFVlMuX+JHAPvJy5foX3JJ16VwDfhq4UjYtHQXq9xrxO3yIE7qf2GRJcOrK6
	 M0K9tJRp6Q16jeakD2SO4+OwV/ksGSUFEl2TahvA6aCQKGQF4GSdDgvcK2q1bgCOhV
	 RXZrnq0YFUX4Q==
Date: Mon, 15 Sep 2025 17:56:22 -0700
Subject: [PATCH 01/10] libext2fs: make it possible to extract the fd from an
 IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161343.390072.4704386563813665952.stgit@frogsfrogsfrogs>
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

Make it so that we can extract the fd from an open IO manager.  This
will be used in subsequent patches to register the open block device
with the fuse iomap kernel driver.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2_io.h         |    4 +++-
 debian/libext2fs2t64.symbols |    1 +
 lib/ext2fs/io_manager.c      |    8 ++++++++
 lib/ext2fs/unix_io.c         |   15 +++++++++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 39a4e8fcf6b515..f53983b30996b4 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -102,7 +102,8 @@ struct struct_io_manager {
 				     unsigned long long count);
 	errcode_t (*zeroout)(io_channel channel, unsigned long long block,
 			     unsigned long long count);
-	long	reserved[14];
+	errcode_t (*get_fd)(io_channel channel, int *fd);
+	long	reserved[13];
 };
 
 #define IO_FLAG_RW		0x0001
@@ -145,6 +146,7 @@ extern errcode_t io_channel_alloc_buf(io_channel channel,
 extern errcode_t io_channel_cache_readahead(io_channel io,
 					    unsigned long long block,
 					    unsigned long long count);
+extern errcode_t io_channel_get_fd(io_channel io, int *fd);
 
 #ifdef _WIN32
 /* windows_io.c */
diff --git a/debian/libext2fs2t64.symbols b/debian/libext2fs2t64.symbols
index a3042c3292da93..8e3214ee31e337 100644
--- a/debian/libext2fs2t64.symbols
+++ b/debian/libext2fs2t64.symbols
@@ -693,6 +693,7 @@ libext2fs.so.2 libext2fs2t64 #MINVER#
  io_channel_alloc_buf@Base 1.42.3
  io_channel_cache_readahead@Base 1.43
  io_channel_discard@Base 1.42
+ io_channel_get_fd@Base 1.47.99
  io_channel_read_blk64@Base 1.41.1
  io_channel_set_options@Base 1.37
  io_channel_write_blk64@Base 1.41.1
diff --git a/lib/ext2fs/io_manager.c b/lib/ext2fs/io_manager.c
index dca6af09996b70..6b4dca5e4dbca2 100644
--- a/lib/ext2fs/io_manager.c
+++ b/lib/ext2fs/io_manager.c
@@ -150,3 +150,11 @@ errcode_t io_channel_cache_readahead(io_channel io, unsigned long long block,
 
 	return io->manager->cache_readahead(io, block, count);
 }
+
+errcode_t io_channel_get_fd(io_channel io, int *fd)
+{
+	if (!io->manager->get_fd)
+		return EXT2_ET_OP_NOT_SUPPORTED;
+
+	return io->manager->get_fd(io, fd);
+}
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 723a5c2474cdd5..a540572a840d17 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1662,6 +1662,19 @@ static errcode_t unix_zeroout(io_channel channel, unsigned long long block,
 unimplemented:
 	return EXT2_ET_UNIMPLEMENTED;
 }
+
+static errcode_t unix_get_fd(io_channel channel, int *fd)
+{
+	struct unix_private_data *data;
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	data = (struct unix_private_data *) channel->private_data;
+	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
+
+	*fd = data->dev;
+	return 0;
+}
+
 #if __GNUC_PREREQ (4, 6)
 #pragma GCC diagnostic pop
 #endif
@@ -1683,6 +1696,7 @@ static struct struct_io_manager struct_unix_manager = {
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
+	.get_fd		= unix_get_fd,
 };
 
 io_manager unix_io_manager = &struct_unix_manager;
@@ -1704,6 +1718,7 @@ static struct struct_io_manager struct_unixfd_manager = {
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
+	.get_fd		= unix_get_fd,
 };
 
 io_manager unixfd_io_manager = &struct_unixfd_manager;


