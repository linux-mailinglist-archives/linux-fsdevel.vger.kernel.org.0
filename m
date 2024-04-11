Return-Path: <linux-fsdevel+bounces-16693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE898A17E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD781C21319
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEE81118D;
	Thu, 11 Apr 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AP8CMg2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C2EF9DE;
	Thu, 11 Apr 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847236; cv=none; b=cHMiyimor8poZjAOrxdk+7dBs+Abnp+StUiPe5QQwk6PvoMZV/hDMLwcR5MB5lgGtocxETsUs8La940lABa38hxORsqn6AN19C/CcVOwuh5dtPSUqJKVH3LSbAjnBEEwyr1+glNlsIoBAdJIxfJQnSAID+B4l0Od6a1EFXydF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847236; c=relaxed/simple;
	bh=SOrFXL4kiKZvZZnLAh+S+lDmHGKHtDDvua9I+aj8gCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HEWPEcfVSyKRzu7j1IStbD8LtByXH2+nTLC7JAzXL8tYVHd3IIdYkt50RQKl7LpH+FRd6ylGnwXLy85OVgtpD7bbsIxD8SXD0oVU2hUgYRCfRdPOOj8v3awO2a4zjK9tVOIR0alQNFjDodlfRUWPaifXaAxn6eH4ufc07nngvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AP8CMg2k; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=D/CKG/G9+a3XCGJfE4tOrUIvB6OKU22LVdiIVyIX6BI=; b=AP8CMg2kx/cFxtE58t2VAxJW0T
	BX0uThPLbqVZaOgHWdzfel3QB2ClJCgy1JzWRa/VJ+aT3hggYlB7TwGlSrXn8A2Fn+zILciNJ67Kv
	JIO9SrFdYU7lkv2/tRMtubHkTuUtHiL4+m1OljxxzXQ4Q2tOya2E2KT61t1a7Nubu+LOuQiwvxrN0
	gxeCkoqPr8PttAzlpNJPkgiOXWYH+Zf6D3rgJx3qLgrqiaVUxyOVz1SnNAQcwkcjMoxE3LXmyGPIi
	iHQs+nRoiSaqA9RN937QQzBCYloAllZYQ+5xhxUctv1dlfEkUYTcD9xk6XWs8lHQPsOoVSGTYEMyT
	mSnlESxQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ruvoB-00AYkk-0n;
	Thu, 11 Apr 2024 14:53:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	hch@lst.de,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: [PATCH 06/11] blk_ioctl_{discard,zeroout}(): we only want ->bd_inode->i_mapping here...
Date: Thu, 11 Apr 2024 15:53:41 +0100
Message-Id: <20240411145346.2516848-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
References: <20240411144930.GI2118490@ZenIV>
 <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/ioctl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index d365d8e92f98..e0c2d834df7a 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -97,7 +97,6 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, len;
-	struct inode *inode = bdev->bd_inode;
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
@@ -120,13 +119,13 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	if (start + len > bdev_nr_bytes(bdev))
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
 
@@ -166,7 +165,6 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, end, len;
-	struct inode *inode = bdev->bd_inode;
 	int err;
 
 	if (!(mode & BLK_OPEN_WRITE))
@@ -189,7 +187,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 		return -EINVAL;
 
 	/* Invalidate the page cache, including dirty pages */
-	filemap_invalidate_lock(inode->i_mapping);
+	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, end);
 	if (err)
 		goto fail;
@@ -198,7 +196,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 				   BLKDEV_ZERO_NOUNMAP);
 
 fail:
-	filemap_invalidate_unlock(inode->i_mapping);
+	filemap_invalidate_unlock(bdev->bd_mapping);
 	return err;
 }
 
-- 
2.39.2


