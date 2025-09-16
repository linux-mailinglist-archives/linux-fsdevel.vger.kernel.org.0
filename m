Return-Path: <linux-fsdevel+bounces-61618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D484B58A57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE86D3B66F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9C51DE89A;
	Tue, 16 Sep 2025 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3ZP25Ns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685ED2FB;
	Tue, 16 Sep 2025 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984262; cv=none; b=C346UX54HAK9geJ2DeJxSB7CXAX0v0o5E2jQgX4zeZOhju485K6YdhGuQxOloFHLlSrKTtwPDG75C+1AIW11GaF+8Kc04O9grOgxxaKtVfULVGWPxJ7HozKUnW7sADRMeeOm5VS0bRV/qA0um7cLM3o7h7Pr1zkJGWyE+pKNVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984262; c=relaxed/simple;
	bh=ETgyghkln0eeL0CFPL7GzrbysbLz2soSxAO0hIQrQBI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+vgKeir5kiuUrjL1yZafQd+bQl+CKPvty2FCvxAUrgB4rrge+HLgb2Icv8JXoQWx3DueX+xUiGB0dfpfZhek+Qt6jietewn9VKP2GdDMMgyqiC7eR/jV4oX+Yy8TJyW6WZO2KEHz3yjI7nQZ7y5+roH3NrGC9Bp3PxWq+oJHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3ZP25Ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8ECC4CEF1;
	Tue, 16 Sep 2025 00:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984261;
	bh=ETgyghkln0eeL0CFPL7GzrbysbLz2soSxAO0hIQrQBI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=X3ZP25NsEQ4tIuGjgEpALNX0CDAsHKlVV3r1/LJr+apAVi8/kEXQZYvA84q71rFDk
	 FZ58dsp3A71BEpLMbnkzo8BJYKPUdA+2fd+xccIiOVKtN73O7bS1E6FVyWkhd3ayu8
	 Uq49A/Oo6+1NcV/PoxhZcR+FcwO7Io/XGaLjomta0e7lfaWMl1RLOFgmez9pRGBg8Y
	 AxvjxhleDiWcFgt6SRacZM2eJA6K4UC5OkzOE4o29EyhsPTx3U9yUE52bAOHvzrII/
	 BnEcXHldyGYc7dl2mDDlDaHDKqs4cmFWXlDowFP44D6grYWklv+rAb7u29clVwxYX/
	 v0SQjlS8/NLTg==
Date: Mon, 15 Sep 2025 17:57:41 -0700
Subject: [PATCH 06/10] libext2fs: only flush affected blocks in
 unix_write_byte
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798161432.390072.6086960824735789579.stgit@frogsfrogsfrogs>
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

There's no need to invalidate the entire cache when writing a range of
bytes to the device.  The only ones we need to invalidate are the ones
that we're writing separately.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index be253b5fddf281..d4973d1a878057 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1468,6 +1468,7 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 {
 	struct unix_private_data *data;
 	errcode_t	retval = 0;
+	unsigned long long bno, nbno;
 	ssize_t		actual;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
@@ -1483,10 +1484,17 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 
 #ifndef NO_IO_CACHE
 	/*
-	 * Flush out the cache completely
+	 * Flush all the dirty blocks, then invalidate the blocks we're about
+	 * to write.
 	 */
-	if ((retval = flush_cached_blocks(channel, data, FLUSH_INVALIDATE)))
+	retval = flush_cached_blocks(channel, data, 0);
+	if (retval)
 		return retval;
+
+	bno = offset / channel->block_size;
+	nbno = (offset + size + channel->block_size - 1) / channel->block_size;
+
+	invalidate_cached_blocks(channel, data, bno, nbno - bno);
 #endif
 
 	if (lseek(data->dev, offset + data->offset, SEEK_SET) < 0)


