Return-Path: <linux-fsdevel+bounces-58526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0408EB2EA43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA19B17A7B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E011FF5E3;
	Thu, 21 Aug 2025 01:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEAbD/8p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E806E46447;
	Thu, 21 Aug 2025 01:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738880; cv=none; b=UePJOoy5gXkbKut2D3LTqvi1nMBLy/rB447TJ/xATE5ErK2yYxf8V91DUSZbpsyIKNPjv1Q7wTMerrsYTgPrc2egblISiFH9hD40K+P1Ew7Qug+QlOScnEH80XbLEd3RhykQYe7htBhmQ3vjejtujcqKzA9Kbld/pMLPv2BZQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738880; c=relaxed/simple;
	bh=jT8So2Cjd9TF1HUrBZ0JSUyDf7in5vhO0Bqm25q/ApQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuclU4A2rB6jkCsq2AFORiEF8lNB0pHno71CNu1cMO1DeVq3aSn1kxU5rvLUPNlBRB9MgmqaMpcE5rWw9wsU58lAnSQ6LIQrFICj6uyjGukU8uMKMKHDKiIeWLw/VRxTayE6gw+DCdCu7aOyEmb9CcuM0QjBoAcE3FTUgL6/zvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEAbD/8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DE4C4CEE7;
	Thu, 21 Aug 2025 01:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738879;
	bh=jT8So2Cjd9TF1HUrBZ0JSUyDf7in5vhO0Bqm25q/ApQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SEAbD/8pdGLvJxbFXlZIDJoQ2s+ZzNKzOIxkzKre0Re5wENyYhjI2e9sMo0BJD4Xr
	 AvwM+Rn1Nqni2rEvhwAVuJomo73xcINSwXWqLEiOMWe1dznN2TROAos877ml0ZswBC
	 t0IuC4e3RFsyscc2J5BmHLNdPy8s+s+9DbZGoWxzkD3DcW3ISzAHOngWua+blpuXC5
	 RpTbddhxmeOfeUItfXN6JkxfGta+KEuuG8DqIUm0S+PcNS58O3K2BxXaJN8iCz+OAu
	 +Y5CySvsEIGT+qE4eqcVe6I2fX6QDr6WJ3owjk2rQ2phzwMlUTBZ9RuNwlNXzMzPLp
	 vjVCzrD8kQk8w==
Date: Wed, 20 Aug 2025 18:14:38 -0700
Subject: [PATCH 06/10] libext2fs: only flush affected blocks in
 unix_write_byte
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573713442.21546.1469237500636906426.stgit@frogsfrogsfrogs>
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

There's no need to invalidate the entire cache when writing a range of
bytes to the device.  The only ones we need to invalidate are the ones
that we're writing separately.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 0d1006207c60cd..4036c4b6f1481e 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1469,6 +1469,7 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 {
 	struct unix_private_data *data;
 	errcode_t	retval = 0;
+	unsigned long long bno, nbno;
 	ssize_t		actual;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
@@ -1484,10 +1485,17 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 
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


