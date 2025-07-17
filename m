Return-Path: <linux-fsdevel+bounces-55386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8436B09877
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96485A2937
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F48825D917;
	Thu, 17 Jul 2025 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjBO1kHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09446246793;
	Thu, 17 Jul 2025 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795908; cv=none; b=WWEtZLP79RWyAZbE1qyi0u898WOZD3nTLDGVUTjJthFwutPzUiLBoHOWDe9R0JM08ee+PLQFTEexs8dLwq7rkvr3hG8QnqeEsi26oIlXD7JGzr6+V39ntarRh8SP8SDbw6Da1wGS7lBwBciEphiHyy4aLhQbDEG2M/xIvcUpkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795908; c=relaxed/simple;
	bh=P0NTt4284QAop+DB9kLz3QRupL5QWs6foHQzGxZHa9M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOceD9niB48MnKMkOo97cUhLSIog/U1yxnQNmzYDWUXZX20F3rE+qoW/sgH+nyhTH27SBz/E8rA2ZUQmQzeX1uNfKVPFmtYGyIpNkhDRcsWyYmEsRAbq+XV3m6WiU30vIqUVGMa1FWiZbJLcBN8G6cr/gZ9FBGX12YarhUtH5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjBO1kHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60B8C4CEEB;
	Thu, 17 Jul 2025 23:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795907;
	bh=P0NTt4284QAop+DB9kLz3QRupL5QWs6foHQzGxZHa9M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HjBO1kHDAf5izG61OczfdoHroEO4Sx4fOsoMlgKZQDzANNd4f3vJs5oDszor38CDU
	 fOTDyx1bmOX93PTvIwhni4oVXlNqyIbPcKnwWzLarRMj4NnAvP0WlqQ2rksSlQMqX9
	 /oqKAtZ3yq3C/3DNHwgs0ECvoFPNQgn+nbATNqH7jr0Ke34ipCljyZRy0A+SkeXile
	 ZZr2GXQvOtGDqNApL2i41kahUNyiU0/sQApwDAichyIYneEthCOO0A8DwcjSwwkUPc
	 nKC7/ysdN20OWIffh8Qkhp4pQ40RK9yuggcpBTqUCZEM3+QR2gybeGD/d6Ui7HwlUa
	 jd3ecj8CjrzpA==
Date: Thu, 17 Jul 2025 16:45:07 -0700
Subject: [PATCH 22/22] fuse2fs: configure block device block size
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461430.715479.13971213588209519937.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
References: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Set the blocksize of the block device to the filesystem blocksize.
This prevents the bdev pagecache from caching file data blocks that
iomap will read and write directly.  Cache duplication is dangerous.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index b5f665ada36991..d0478af036a25e 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5683,6 +5683,42 @@ static off_t fuse2fs_max_size(struct fuse2fs *ff, off_t upper_limit)
 	return res;
 }
 
+/*
+ * Set the block device's blocksize to the fs blocksize.
+ *
+ * This is required to avoid creating uptodate bdev pagecache that aliases file
+ * data blocks because iomap reads and writes directly to file data blocks.
+ */
+static int fuse2fs_set_bdev_blocksize(struct fuse2fs *ff, int fd)
+{
+	int blocksize = ff->fs->blocksize;
+	int set_error;
+	int ret;
+
+	ret = ioctl(fd, BLKBSZSET, &blocksize);
+	if (!ret)
+		return 0;
+
+	/*
+	 * Save the original errno so we can report that if the block device
+	 * blocksize isn't set in an agreeable way.
+	 */
+	set_error = errno;
+
+	ret = ioctl(fd, BLKBSZGET, &blocksize);
+	if (ret)
+		goto out_bad;
+
+	if (blocksize > ff->fs->blocksize)
+		set_error = -EINVAL;
+
+	return 0;
+out_bad:
+	err_printf(ff, "%s: cannot set blocksize %u: %s\n", __func__,
+		   blocksize, strerror(set_error));
+	return -EIO;
+}
+
 static errcode_t fuse2fs_iomap_config_devices(struct fuse_context *ctxt,
 					      struct fuse2fs *ff)
 {
@@ -5695,6 +5731,10 @@ static errcode_t fuse2fs_iomap_config_devices(struct fuse_context *ctxt,
 	if (err)
 		return err;
 
+	ret = fuse2fs_set_bdev_blocksize(ff, fd);
+	if (ret)
+		return ret;
+
 	ret = fuse_iomap_add_device(se, fd, 0);
 
 	dbg_printf(ff, "%s: registering iomap dev fd=%d ret=%d iomap_dev=%u\n",


