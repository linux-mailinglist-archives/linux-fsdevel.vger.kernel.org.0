Return-Path: <linux-fsdevel+bounces-19015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B518BF67A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243AEB20DE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B70124A04;
	Wed,  8 May 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YQKp4AMc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7588C2030B
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150695; cv=none; b=UR7OECkS/SbsJHR+J8IGxc9aqVGn4vXj1jbgGiSpsZ8o8w7uTPKl7KXPPyZk7cF8u1ySi6HhgPYYTzG+Eg19F3U6SrDMqXOrk9u0YCaDl1mcemPsH+Z6aWLnLQ0Sx46suFozI0Q6CS1GJZhHtcfWWli4JNTz0z4NfGXyoUAEzrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150695; c=relaxed/simple;
	bh=0x3TWXoMemWdoM+UC/vXMDCM00veAwur9b5N0LoMWIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H/bFMUKwFiE6IplhYOV7Ob3AmodEXqhs4WjkSdROhi2ZvtMzUm0wcA20msGEcl+eeOQs8WcBXcAcLIO7X9NfjDre0wD/LrTchzkhGgyDnUKnWvx/eI4RicpySFXg2wyV/k2gD6yh/UfOAptpSzu0I5jmx5xSQUga+RMglhPwx+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YQKp4AMc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Gex4TCI9Zq1eCbkhVrWd9ElwSyNS2IF9xsDUWC55+t4=; b=YQKp4AMcLrnjU2lXxCP4NhCisv
	zYoQGEY7btwel2ASBV3n3YnfEWyA8eloPr4ojqlDsacdKh2+FG4xIklmZGzJzQBOmI3Nmt66ZVM+Y
	6q12VAO3Oqz64tQmvoe8gfe2EaxzbAk2vRsIkpSRCkQ8OlXSQGgFe9BohIys5fdl7pDlYJGkJXvHu
	glnUChaSlHL2Z1Z7a0qX2TFxhXjnIq0pkaEpYiF0cg8bD3zv+4E4arttEF0MkWecs9MBBSSkXQ/tY
	b/eCwYkp0ok21U40AK33FYUJmIdFCcWTa09ZiEz4+1yf6Q4SM7BC/8GV8gKvVlIgZdyuIqEPGGYkn
	VRs3v1/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b2r-00FvzV-00;
	Wed, 08 May 2024 06:44:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 2 04/10] blk_ioctl_{discard,zeroout}(): we only want ->bd_inode->i_mapping here...
Date: Wed,  8 May 2024 07:44:46 +0100
Message-Id: <20240508064452.3797817-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20240411145346.2516848-6-viro@zeniv.linux.org.uk
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/ioctl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 7c13d8bed453..831d6350ca25 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -97,7 +97,6 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, len, end;
-	struct inode *inode = bdev->bd_inode;
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
@@ -121,13 +120,13 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
-	filemap_invalidate_lock(inode->i_mapping);
+	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (err)
 		goto fail;
 	err = blkdev_issue_discard(bdev, start >> 9, len >> 9, GFP_KERNEL);
 fail:
-	filemap_invalidate_unlock(inode->i_mapping);
+	filemap_invalidate_unlock(bdev->bd_mapping);
 	return err;
 }
 
@@ -167,7 +166,6 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, end, len;
-	struct inode *inode = bdev->bd_inode;
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
@@ -190,7 +188,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 		return -EINVAL;
 
 	/* Invalidate the page cache, including dirty pages */
-	filemap_invalidate_lock(inode->i_mapping);
+	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, end);
 	if (err)
 		goto fail;
@@ -199,7 +197,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 				   BLKDEV_ZERO_NOUNMAP);
 
 fail:
-	filemap_invalidate_unlock(inode->i_mapping);
+	filemap_invalidate_unlock(bdev->bd_mapping);
 	return err;
 }
 
-- 
2.39.2


