Return-Path: <linux-fsdevel+bounces-58524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 731C0B2EA48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81669A273D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F002620B81B;
	Thu, 21 Aug 2025 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhKYoDEN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC91A9FB1;
	Thu, 21 Aug 2025 01:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738848; cv=none; b=iZeJMWfBF7l6n6y7YHKiTMEOvbEchVfnXqhn9d061O3Iwx91G367xDzHAW5wkD13xJOl+E9vBubcVPPDufsIuuhGr4xI/GXJGIU7/TCjaPYIsDLKhfuYhzzccT7V7Xa1FHKdmA/fNgJ4V+enisjSLXq2tBRx0V+moZ7IeyDlsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738848; c=relaxed/simple;
	bh=3o1LiC6wQP1G8Tzr6izvREJM6pzmncp1kn98vVNA1Xs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpT1RRh/xWs4FfvOgiv+Vs2abNAafpQxzMxrqZmU9qNrw8/uMUxNxILR/AAs5mrxK5SuxhUDIzGQQHrUorrBPYfiYBPRVsAIREOzQq3iJLsA4+yTJ5OSLuKHQAJIgweJrA9yM4r0zQqeVIN7wodb4FQs5tEVEuLuvE18eIrkeg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhKYoDEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30478C4CEE7;
	Thu, 21 Aug 2025 01:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738848;
	bh=3o1LiC6wQP1G8Tzr6izvREJM6pzmncp1kn98vVNA1Xs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bhKYoDEN7hxo78cm1q6Ac18Yj+kJHi2zbLuEHYaiX02K12NBXmVBZDvF+KQLNQAx3
	 xWgnSwG2RWnhRpTwANzcYjWVrP6MwN8Fs0HH9Nwx3hHM30HOCMPO+K7+reNll1tuHH
	 Vt/iv3ZdQzUCdxl4ACzlDhqevAcY/8SsCkW/8ZxzWKsZuFKekKlT5z+VdEjuUe95bY
	 V9pqiHNcr/DVRATfCkW92LEIzlR4Eg3vt8ydBF/D+J/BpXpc1srVqcbLKxgMUc2g+s
	 qTPKX0Fpx25x1ocuJsV1NgLox2qDoPoH/+GGF/Srnuv5UR8VWSSJNr4QmI57u5yUA6
	 5d97tqtFavFpQ==
Date: Wed, 20 Aug 2025 18:14:07 -0700
Subject: [PATCH 04/10] libext2fs: only fsync the unix fd if we wrote to the
 device
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713407.21546.2184760292379016555.stgit@frogsfrogsfrogs>
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

As an optimization, only fsync the block device fd if we tried to write
to the io channel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |   48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 80fff984e48224..61ecdc9b8b56b2 100644
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
@@ -1132,10 +1135,37 @@ static errcode_t unix_open(const char *name, int flags,
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
@@ -1148,8 +1178,9 @@ static errcode_t unix_close(io_channel channel)
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
@@ -1317,6 +1348,8 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 	data = (struct unix_private_data *) channel->private_data;
 	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
 
+	mark_dirty(channel);
+
 #ifdef NO_IO_CACHE
 	return raw_write_blk(channel, data, block, count, buf, 0);
 #else
@@ -1441,6 +1474,8 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 	if (lseek(data->dev, offset + data->offset, SEEK_SET) < 0)
 		return errno;
 
+	mark_dirty(channel);
+
 	actual = write(data->dev, buf, size);
 	if (actual < 0)
 		return errno;
@@ -1456,7 +1491,7 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 static errcode_t unix_flush(io_channel channel)
 {
 	struct unix_private_data *data;
-	errcode_t retval = 0;
+	errcode_t retval = 0, retval2;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	data = (struct unix_private_data *) channel->private_data;
@@ -1467,8 +1502,9 @@ static errcode_t unix_flush(io_channel channel)
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


