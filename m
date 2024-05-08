Return-Path: <linux-fsdevel+bounces-19008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D6B8BF671
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9881B1F23BB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF3423772;
	Wed,  8 May 2024 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jCARK9tC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9221EB45
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150585; cv=none; b=cDr7fw1QjiMP7FMzIeAbmnWy0bMVqVDftj1xpR7vzrks8GYsc8PV/reew7uHMRpS2s3Y3SPd0OS2h73sxr5qWlc9+qyCRQRrz4q9OD053CZ2DWmsbft6Fr4mrg2/GWelOCTreYMfG10l8HFKj5pNay0Gzs25uGEHbcFU2R8O+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150585; c=relaxed/simple;
	bh=FI7nZOW4jAMQ7zWKk3/48y5CNUEqc9wZVzGIr6sBxAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XH7aFunVxQlP1brnNUTfhHLxOT1h1l0opVhEdDOIQMCdJagA1J080kdB0ghHxQvjjYXa3Z2aAWkdOS9EfsJ61W2gdUKpZ2McNc7VuzGPbDxPJIqGXSqij/td2opGIXXcfOte/fuuyXiZ4SoHz3/OwtnvOOXC6HM9U+fYNw9dmw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jCARK9tC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SUkXRrOO407hJED/veKQuzROfrF1mHglYDDOL6cKg8g=; b=jCARK9tCVFP9fVysfw8o0bFFiA
	9yZhP5HG8hqt6s9fZa3HTc2e9GHOf4r/J6l88vlWDQavLJ0PoKV1t3JF9tlv5UuNPIc7d4rV/duK2
	af4zoNuJ1Sx8oJaVT66cTfSE/9SeT3zPgi87noKGFoeia4k4b/vID6KLLxrC9aP2Yq83/4Qff9FdZ
	Tl3AiPFN5RflFsfGP+U1BKMHO/HQguEVwNf+KR/VM7R0XJjy9ttT/t4LLFvKNVxL3tdOHoA/AeFhg
	wRVeUV9O422mFEoKnM+MIPNWpHb2F1KlYm1yh6taqysewAY6wUXXPjRrEbeT56dqg5YzK0YG+WHJw
	gVh2u5/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b14-00FvpE-0T;
	Wed, 08 May 2024 06:43:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 1 3/7] blkdev_write_iter(): saner way to get inode and bdev
Date: Wed,  8 May 2024 07:42:57 +0100
Message-Id: <20240508064301.3797191-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064301.3797191-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064301.3797191-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... same as in other methods - bdev_file_inode() and I_BDEV() of that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20240411145346.2516848-5-viro@zeniv.linux.org.uk
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 679d9b752fe8..9d0f36688a5d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -668,8 +668,8 @@ static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-	struct block_device *bdev = I_BDEV(file->f_mapping->host);
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = bdev_file_inode(file);
+	struct block_device *bdev = I_BDEV(bd_inode);
 	loff_t size = bdev_nr_bytes(bdev);
 	size_t shorted = 0;
 	ssize_t ret;
-- 
2.39.2


