Return-Path: <linux-fsdevel+bounces-54744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95450B02970
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 07:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9E41BC8331
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 05:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304C11BFE00;
	Sat, 12 Jul 2025 05:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="g3fBSqL3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204AA139B
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 05:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752296558; cv=none; b=htyjMNoCq6BlV0BAQwQK87xyeaR7lgVLf2fP7Inn/y8iIm4wm9u4Wkp018Pk31I2b/0pNu4ZEgB0jZUdUcUPb50NMpjIP6coeziCbEW8U/pMUpDaMgbyrQl+UrMuoEHma6VFZAxCDr4vd3FrXZcnY7Lr+/xEauA5EjAeM8DHuS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752296558; c=relaxed/simple;
	bh=g+JNRFJjoktcPHfNrrnvKFPIRHtD7ycBqTBN1fViQpg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qTDF3iNhZdlCZ2XNM9Mcv03sSf+F5G1rhbmnDHjC0SmTtyf5w8xjI/w3aaYfiwbXU+jwSyph07cYuhrOFmrLskdwPL1iskEzLPj1WCZA5fL1WkgMKOF6QmiH2xWJkSmOc8d6YHLwsxx5VdNW1AtnJGiB76p5jkb+i/BZ/EmkZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=g3fBSqL3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Voc1d95P04gWZr1fFgrqInE7JwmLx8U8/J8TlOkmays=; b=g3fBSqL3v2KAOak+Z1fGiIfC6U
	b51uMUe3zSDhR8aTW0cM/NHK1xv8uDlYOFx/yDCprVViCylMvfienjvRCU5R8k+/+n2LsBYc4oMzf
	HPAWa/2Vx9wbzdaCr6P2xxT7UKhjAN7Z7mUFWINiGbenVY7RXrmS2RgwoTHRWcCZCC8MYgoRSKG2y
	AIN+ufbcRmpp13ya2edOIfyXBaHizz8bISZBwf44IGh4zLBllW9h3+sQhAcFUssxWYPh02tEVo5TQ
	wQAZBqF/GbcKw12axcvttN14XGqXC2yYUkeON/KmNxMdzp7GegFzwNXAmEqYWEvlPx5/gXrPZ45Gt
	xTSzU/2A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaSNb-00000004bfX-0Kue;
	Sat, 12 Jul 2025 05:02:31 +0000
Date: Sat, 12 Jul 2025 06:02:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs: fix UAF in export_dmabuf()
Message-ID: <20250712050231.GX1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[dma_buf_fd() fixes; no preferences regarding the tree it goes through -
up to dri folks]

As soon as we'd inserted a file reference into descriptor table, another
thread could close it.  That's fine for the case when all we are doing is
returning that descriptor to userland (it's a race, but it's a userland
race and there's nothing the kernel can do about it).  However, if we
follow fd_install() with any kind of access to objects that would be
destroyed on close (be it the struct file itself or anything destroyed
by its ->release()), we have a UAF.

dma_buf_fd() is a combination of reserving a descriptor and fd_install().
habanalabs export_dmabuf() calls it and then proceeds to access the
objects destroyed on close.  In particular, it grabs an extra reference to
another struct file that will be dropped as part of ->release() for ours;
that "will be" is actually "might have already been".

Fix that by reserving descriptor before anything else and do fd_install()
only when everything had been set up.  As a side benefit, we no longer
have the failure exit with file already created, but reference to
underlying file (as well as ->dmabuf_export_cnt, etc.) not grabbed yet;
unlike dma_buf_fd(), fd_install() can't fail.

Fixes: db1a8dd916aa ("habanalabs: add support for dma-buf exporter")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/accel/habanalabs/common/memory.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/accel/habanalabs/common/memory.c b/drivers/accel/habanalabs/common/memory.c
index 601fdbe70179..61472a381904 100644
--- a/drivers/accel/habanalabs/common/memory.c
+++ b/drivers/accel/habanalabs/common/memory.c
@@ -1829,9 +1829,6 @@ static void hl_release_dmabuf(struct dma_buf *dmabuf)
 	struct hl_dmabuf_priv *hl_dmabuf = dmabuf->priv;
 	struct hl_ctx *ctx;
 
-	if (!hl_dmabuf)
-		return;
-
 	ctx = hl_dmabuf->ctx;
 
 	if (hl_dmabuf->memhash_hnode)
@@ -1859,7 +1856,12 @@ static int export_dmabuf(struct hl_ctx *ctx,
 {
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct hl_device *hdev = ctx->hdev;
-	int rc, fd;
+	CLASS(get_unused_fd, fd)(flags);
+
+	if (fd < 0) {
+		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", fd);
+		return fd;
+	}
 
 	exp_info.ops = &habanalabs_dmabuf_ops;
 	exp_info.size = total_size;
@@ -1872,13 +1874,6 @@ static int export_dmabuf(struct hl_ctx *ctx,
 		return PTR_ERR(hl_dmabuf->dmabuf);
 	}
 
-	fd = dma_buf_fd(hl_dmabuf->dmabuf, flags);
-	if (fd < 0) {
-		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", fd);
-		rc = fd;
-		goto err_dma_buf_put;
-	}
-
 	hl_dmabuf->ctx = ctx;
 	hl_ctx_get(hl_dmabuf->ctx);
 	atomic_inc(&ctx->hdev->dmabuf_export_cnt);
@@ -1890,13 +1885,9 @@ static int export_dmabuf(struct hl_ctx *ctx,
 	get_file(ctx->hpriv->file_priv->filp);
 
 	*dmabuf_fd = fd;
+	fd_install(take_fd(fd), hl_dmabuf->dmabuf->file);
 
 	return 0;
-
-err_dma_buf_put:
-	hl_dmabuf->dmabuf->priv = NULL;
-	dma_buf_put(hl_dmabuf->dmabuf);
-	return rc;
 }
 
 static int validate_export_params_common(struct hl_device *hdev, u64 addr, u64 size, u64 offset)
-- 
2.39.5


