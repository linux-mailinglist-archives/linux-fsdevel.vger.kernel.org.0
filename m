Return-Path: <linux-fsdevel+bounces-58521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AC8B2EA38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A647188B64D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E601F8676;
	Thu, 21 Aug 2025 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTE2LmOs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803401A9F9F;
	Thu, 21 Aug 2025 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738801; cv=none; b=RaZx5373FhHtx5o6L2VlAdK3KDsO8fMifQZ7k+G04nDi41FA4Q3tVCRJkJGwyFehYY/NxwkYMIg5VqHiDk8Jb5cdUb0rx55Sovh+CXT4bG3JjFvLbsyplZjCdkVq+rojoC+G3R7qQA6afAbLz21khDJBK3VvI7K6o9NVGwzX2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738801; c=relaxed/simple;
	bh=xYZa5rf6/3OP9awOdPLdqkkDYZ+v77y941HYEuEIOB4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlWzRW9qzrMz9+0j9OfP94wHNu6b9qWK1HxdEo1Ah+TU7o88zVU9sXkNo7PS6WpLFinU/TQAujC9b9he4FGKSZx1FE3q6ciIlLDa+wN5x4E1aeZGJMDIQiJ+sPgMzpLz6QKQCH9IlprajxxvCD9Ur451R5oFNVY/XpA1crXkJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTE2LmOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5BDC113D0;
	Thu, 21 Aug 2025 01:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738801;
	bh=xYZa5rf6/3OP9awOdPLdqkkDYZ+v77y941HYEuEIOB4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nTE2LmOsNPw90CnBV+1BIh8m7nveB7jT8oP4fTeQfTF1ljwSRvyDuHpIvkTa5ehV1
	 eCGyNqzXIiKmQcsCHlf4zblk7R3egfi9XCRu6gQlZ8THxTzUDzEA0U4MxwCRglmkkT
	 LtTkU0cvHoCmsAhhAPiWzm+dn6LzDxOE5IMsrEjBXXmC1a+XYdi1ZxSx2Yy99mQwRq
	 jM79SXwwCXIkjhjcVKtKL+++G1baELkyFcYjXUr82BcDCv8BQ/k7NLa6NTL9k7Gb8Z
	 nOsu7R9O888LqvD5rAe5B8uG4LhhsxLVyor/nKFuSaCxozRtwWuMIdDz1WXGfqZ96/
	 OwJrKMquAk4ag==
Date: Wed, 20 Aug 2025 18:13:20 -0700
Subject: [PATCH 01/10] libext2fs: make it possible to extract the fd from an
 IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713352.21546.5725665141478488737.stgit@frogsfrogsfrogs>
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
index cb408f51779aa7..561eddad6b8b17 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1663,6 +1663,19 @@ static errcode_t unix_zeroout(io_channel channel, unsigned long long block,
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
@@ -1684,6 +1697,7 @@ static struct struct_io_manager struct_unix_manager = {
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
+	.get_fd		= unix_get_fd,
 };
 
 io_manager unix_io_manager = &struct_unix_manager;
@@ -1705,6 +1719,7 @@ static struct struct_io_manager struct_unixfd_manager = {
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
+	.get_fd		= unix_get_fd,
 };
 
 io_manager unixfd_io_manager = &struct_unixfd_manager;


