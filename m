Return-Path: <linux-fsdevel+bounces-49628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC00AC010D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C8E37B744D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CBC1FC3;
	Thu, 22 May 2025 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSdoAW5/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE2380;
	Thu, 22 May 2025 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872542; cv=none; b=r8UbOWSPTgrwTCnoux7nDfS0idC0yr/2Xc+/m2jAmUbYZXzF8xlan+QNsuDbDrPUyAs8l4uma+ME+s8/kJ6pzsP9voMuySZcbUUxqCOe2WzJz63zKMnii2Bm8m0Lb74zoYrMP5zL4y9ySiM5SSiRLJWjoYnv/R/4Qomo4rG3D3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872542; c=relaxed/simple;
	bh=2X048B/+KuK9L5+Gviy/KLyrN4DvwsxlqIbJT0YlRWY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qo3gEf8afDtsNLlwKekNKz0V0pYsjj84j830Q68XYuCd7w4dfNY/fGhg/wWgZDmAk6M4z3DyjR+NVzp8GysNFNzVMrgCnWoZy7wvTCZ3h9weIW3xQlyrl+1Cnl5u4DozvifQ4cJTUAd/sNDcvKCUB/E/FWOQoKucMcVGjZBFZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSdoAW5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90958C4CEE4;
	Thu, 22 May 2025 00:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872541;
	bh=2X048B/+KuK9L5+Gviy/KLyrN4DvwsxlqIbJT0YlRWY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FSdoAW5/q+VUuDBJeukConOD2iK3E0aH/i8VCYrTmDRAtHcOrSVcn2o0S2906AC98
	 qlErdCr4VoJ510DX+IyCE4XnJyhwPhOEREwE9fYpN6qvcQ3WqZVuy5DmW0UATkT43i
	 6qQxg9Y2cjmzufj7tCO0v1vPpdGNae12jy56euFBRbwOjzRgxAvy6a/TzrCpXEMetJ
	 IA6PnqAJXP/l4yykz1PlNR4GIyoz68V0Mrp1RZXu2SAlaaXuWFpUwMhAsMuz9g3S/h
	 VEPsXZ3PJ/jGFy3sMikPZ1lHAmdsTosmP4IJTiXO3LIdXWAA5/o6eKFx5QpWx8SOa3
	 BOYPqnhuSjSoQ==
Date: Wed, 21 May 2025 17:09:01 -0700
Subject: [PATCH 03/10] libext2fs: only fsync the unix fd if we wrote to the
 device
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198121.1484572.1065142120815903413.stgit@frogsfrogsfrogs>
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

As an optimization, only fsync the block device fd if we tried to  write
to the io channel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |   48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 7c5cb075d6b6b6..0fc83e471ca0fe 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -129,10 +129,13 @@ struct unix_cache {
 #define WRITE_DIRECT_SIZE 4	/* Must be smaller than CACHE_SIZE */
 #define READ_DIRECT_SIZE 4	/* Should be smaller than CACHE_SIZE */
 
+#define UNIX_STATE_DIRTY	(1U << 0) /* device needs fsyncing */
+
 struct unix_private_data {
 	int	magic;
 	int	dev;
 	int	flags;
+	unsigned int	state; /* UNIX_STATE_* */
 	int	align;
 	int	access_time;
 	ext2_loff_t offset;
@@ -1121,10 +1124,37 @@ static errcode_t unix_open(const char *name, int flags,
 	return unix_open_channel(name, fd, flags, channel, unix_io_manager);
 }
 
+static void mark_dirty(io_channel channel)
+{
+	struct unix_private_data *data =
+		(struct unix_private_data *) channel->private_data;
+
+	mutex_lock(data, CACHE_MTX);
+	data->state |= UNIX_STATE_DIRTY;
+	mutex_unlock(data, CACHE_MTX);
+}
+
+static errcode_t maybe_fsync(io_channel channel)
+{
+	struct unix_private_data *data =
+		(struct unix_private_data *) channel->private_data;
+	int was_dirty;
+
+	mutex_lock(data, CACHE_MTX);
+	was_dirty = data->state & UNIX_STATE_DIRTY;
+	data->state &= ~UNIX_STATE_DIRTY;
+	mutex_unlock(data, CACHE_MTX);
+
+	if (was_dirty && fsync(data->dev) != 0)
+		return errno;
+
+	return 0;
+}
+
 static errcode_t unix_close(io_channel channel)
 {
 	struct unix_private_data *data;
-	errcode_t	retval = 0;
+	errcode_t	retval = 0, retval2;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	data = (struct unix_private_data *) channel->private_data;
@@ -1137,8 +1167,9 @@ static errcode_t unix_close(io_channel channel)
 	retval = flush_cached_blocks(channel, data, 0);
 #endif
 	/* always fsync the device, even if flushing our own cache failed */
-	if (fsync(data->dev) != 0 && !retval)
-		retval = errno;
+	retval2 = maybe_fsync(channel);
+	if (retval2 && !retval)
+		retval = retval2;
 
 	if (close(data->dev) < 0 && !retval)
 		retval = errno;
@@ -1306,6 +1337,8 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 	data = (struct unix_private_data *) channel->private_data;
 	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
 
+	mark_dirty(channel);
+
 #ifdef NO_IO_CACHE
 	return raw_write_blk(channel, data, block, count, buf, 0);
 #else
@@ -1430,6 +1463,8 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 	if (lseek(data->dev, offset + data->offset, SEEK_SET) < 0)
 		return errno;
 
+	mark_dirty(channel);
+
 	actual = write(data->dev, buf, size);
 	if (actual < 0)
 		return errno;
@@ -1445,7 +1480,7 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 static errcode_t unix_flush(io_channel channel)
 {
 	struct unix_private_data *data;
-	errcode_t retval = 0;
+	errcode_t retval = 0, retval2;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	data = (struct unix_private_data *) channel->private_data;
@@ -1456,8 +1491,9 @@ static errcode_t unix_flush(io_channel channel)
 #endif
 #ifdef HAVE_FSYNC
 	/* always fsync the device, even if flushing our own cache failed */
-	if (fsync(data->dev) != 0 && !retval)
-		return errno;
+	retval2 = maybe_fsync(channel);
+	if (retval2 && !retval)
+		retval = retval2;
 #endif
 	return retval;
 }


