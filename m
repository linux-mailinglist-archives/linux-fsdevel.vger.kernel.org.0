Return-Path: <linux-fsdevel+bounces-49632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8BAAC0115
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7258C9E516B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DD920EB;
	Thu, 22 May 2025 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzEaheOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9F980B;
	Thu, 22 May 2025 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872604; cv=none; b=F3oFtOIFANoIJYwx76Z8bNshKl/m6j14PiozEROESgNhJ1ZOym5tX19AumaX2iatvfKTlXk+MMIA0L5ruzwQNvhuA3huq+RUfnjftcmw3y9NViWToA5OYhCfbHK/Hr0qp09j/OCDYI3jalxQV3oOWfNLruAz/vOJVNXw3esFvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872604; c=relaxed/simple;
	bh=60t+nU8VdLLMKJy6v7iu79RXkiJeYRXD+MqDrD06Yo4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqG276/n0xYn9K1Mu4wpfk5USU3HdY8AB/UMvWnv/wyq/4gnlF6SXPZejA65TSj5xx0LsMsXBJSi7S9UVm+ZaTtiKZPlDUkSkVfLhORy1NoVs7DNf8qbW7DzrCJARJ0l+ujKSzqDFBAH/E3e62UuUjKhF7p0GyPCufjNTtOuPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzEaheOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3441AC4CEE4;
	Thu, 22 May 2025 00:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872604;
	bh=60t+nU8VdLLMKJy6v7iu79RXkiJeYRXD+MqDrD06Yo4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LzEaheOw+5UFSBs2GJQHKlXXr/SNRSjXm6m+AK54OD9R7RpGMWTBlgMXgjGomPtAg
	 iRGxsa6L/Ffg+O5HBcYbXHm4SLFoqb3Lxld20EdYRmZvBjl54tgX2lfeMdtzC37lc6
	 ib5LHhhcdlzd7vQqkIoS0pxGg5TlNX9/Y5gLnxeN3/zmnLbAgQfMev+uqycGaaLyrv
	 VLQSxo5ZOHrm3tZEjIJyP/fxtwGtRIgNgGZFzfGP5HnirYbYI2Na0mjaj7hb0lByfM
	 ///gebGIQjflFCaYCn9Eqlbf35LTtTbHyLqXqwSMnF6IgDNCRlqxv1RnRarwPuzJVu
	 y4/noTbDSozKg==
Date: Wed, 21 May 2025 17:10:03 -0700
Subject: [PATCH 07/10] libext2fs: only flush affected blocks in
 unix_write_byte
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198193.1484572.10506467294798929934.stgit@frogsfrogsfrogs>
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

There's no need to invalidate the entire cache when writing a range of
bytes to the device.  The only ones we need to invalidate are the ones
that we're writing separately.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 8a8afe47ee4503..4c924ec9ee0760 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1523,6 +1523,7 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 {
 	struct unix_private_data *data;
 	errcode_t	retval = 0;
+	unsigned long long bno, nbno;
 	ssize_t		actual;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
@@ -1538,12 +1539,18 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 
 #ifndef NO_IO_CACHE
 	/*
-	 * Flush out the cache completely
+	 * Flush all the dirty blocks, then invalidate the blocks we're about
+	 * to write.
 	 */
-	retval = flush_cached_blocks(channel, data, IO_CHANNEL_TAG_NULL,
-				     FLUSH_INVALIDATE);
+	retval = flush_cached_blocks(channel, data, IO_CHANNEL_TAG_NULL, 0);
 	if (retval)
 		return retval;
+
+	bno = offset / channel->block_size;
+	nbno = (offset + size + channel->block_size - 1) / channel->block_size;
+
+	for (; bno < nbno; bno++)
+		invalidate_cached_block(channel, data, bno);
 #endif
 
 	if (lseek(data->dev, offset + data->offset, SEEK_SET) < 0)


