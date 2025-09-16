Return-Path: <linux-fsdevel+bounces-61616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B2CB58A53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481615232A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8AF19EEC2;
	Tue, 16 Sep 2025 00:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqeZKS3y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96942BB13;
	Tue, 16 Sep 2025 00:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984230; cv=none; b=u/tV6+TUh3IDR3RUUZET7ysXJcu4nunrKHqFfEYULqN936SaKa0WeGiWX7yPBUoXVH/7uxVFOsslDIsWP2BeKvkSBW/+0kynPNsmAyi6lc24A4SK+iCsm0hXpfDB7N2BYU518uyn0Wok8qQNLOYue+gVsSMnNZxaUa4jO2JbcFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984230; c=relaxed/simple;
	bh=mLT87nu3hKq67XV11m9lZmTaiL1pcLyExuP/U6I+fbk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEUcaW9+4ZM+mae/Aq+rHTWdS/Gn4ShcHBk4yXHzbvCoTHLP51AjTVYlwNJ9loeFh6gBzV9Ul+ecIHcUzqVdvQfg936UUzsCpw3B4TeIa9zQsp4NVGlK+BH9Xjs99c+49CncVVRK+1HGsyKdxKduDr0KMgmFsBDbXI9QkhTn3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqeZKS3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E21CC4CEF1;
	Tue, 16 Sep 2025 00:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984230;
	bh=mLT87nu3hKq67XV11m9lZmTaiL1pcLyExuP/U6I+fbk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nqeZKS3yWB6G3s+hr+V6hLLOqh4e2R+X9vKjuz/hS7HN2ELvlchtVtt8o1Ihq/AI2
	 bbg7yeZfOgHQmoxhMFd1I4Act4+90YNFEH2NvCN67lx+oc6Vob6bNa2YS8gJHLwjv0
	 HJzss1FZk7ROKoJjhcnyIan9dqN3Pfyg7PCyeCrjzu68n8gibAbI/IuOdbKZnO7gY1
	 qhuDhAuZHIiVVtjUFRSEocjDDQmktOknsVsvkEPnwEZEppqjCx+IhlBAu2auriD3km
	 9viOhc4ZjQv+/JQfFpa9s5ShSLZj+TXX6r1wCn7LT6OCv+vhuXDkoBOtbc7eAnOXGa
	 JMGqXJNyNHgeA==
Date: Mon, 15 Sep 2025 17:57:09 -0700
Subject: [PATCH 04/10] libext2fs: only fsync the unix fd if we wrote to the
 device
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161396.390072.16003898544488175439.stgit@frogsfrogsfrogs>
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

As an optimization, only fsync the block device fd if we tried to write
to the io channel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |   48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index b04e8a89a951dd..b462c587e3e2ac 100644
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
@@ -1131,10 +1134,37 @@ static errcode_t unix_open(const char *name, int flags,
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
@@ -1147,8 +1177,9 @@ static errcode_t unix_close(io_channel channel)
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
@@ -1316,6 +1347,8 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 	data = (struct unix_private_data *) channel->private_data;
 	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
 
+	mark_dirty(channel);
+
 #ifdef NO_IO_CACHE
 	return raw_write_blk(channel, data, block, count, buf, 0);
 #else
@@ -1440,6 +1473,8 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 	if (lseek(data->dev, offset + data->offset, SEEK_SET) < 0)
 		return errno;
 
+	mark_dirty(channel);
+
 	actual = write(data->dev, buf, size);
 	if (actual < 0)
 		return errno;
@@ -1455,7 +1490,7 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 static errcode_t unix_flush(io_channel channel)
 {
 	struct unix_private_data *data;
-	errcode_t retval = 0;
+	errcode_t retval = 0, retval2;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	data = (struct unix_private_data *) channel->private_data;
@@ -1466,8 +1501,9 @@ static errcode_t unix_flush(io_channel channel)
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


