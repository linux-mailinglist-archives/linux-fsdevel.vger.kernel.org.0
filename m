Return-Path: <linux-fsdevel+bounces-18570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC078BA5FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 06:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D861C22073
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 04:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D45326AC6;
	Fri,  3 May 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Re08tszy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB72262B
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709864; cv=none; b=smvKGgwpPiGRry8MmwqS+AN8H+y5o0E8vqTniYmZiJX5VEIu2nf4xG2jzlvo4ZXv7kpfZkCfZ2OBSZ3xApimtoY8Mrtr9TwlCJZ30cU/agidENjUFSHUx+nzj6loKioeKKQXw/jBcCvb7Ek/Tp6HBTHU7LfHKwnuPi6Xs3WYu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709864; c=relaxed/simple;
	bh=Ny/piFSeo/b8skljYppcXOeFUcUBl2a+DCCTPN5ciBM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHskI1BfighjVdk+AVuBGw5liUU6HlQQpI2hq9bV2EKLsNTHf9XnamuTGgrsWelq5Y14Pf41YLuXNfxIEdaQ5AudCNt/dy/2a2Yxopco0UGSzMsigALmLag7NYAy82ZcBuzqhW+qJ/v3qsY+79f7PEA7hbA4SLWUfCvz4wF1aKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Re08tszy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=93pWwp0Zz5qYrYHUR6o6Sk8WkFP1Q/YOlDatYiLWcaw=; b=Re08tszyiS62XXBe6kMyFI5u4N
	8vRH6rmag6icQiY9vAxRfO3rkivG4YTOd7XGiiMNa9GO7bu0nnDaTmChABpYq+PlRnXNJ1tHxFEwu
	73+n68l1lguMesS6MhDpylccI9A66zHZR60oTm1i/nbrE2k93Ch4uHsCEyRseQIHonz5md2fm9mjo
	vTKwbxdJE0UHy1ramGhTjTo/6hsnzPk3pbtDeRzOdjr10M/DtEhR8aMevVvjYDhxyugQAjVMcojVn
	1o1YMtATBI+QveoNmYbBojYuWpUD0VuhtwqDrVBrrnUk3gfenkmPDQAFd/SZbpTDA/5mgyLfY806S
	GYQReZNg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2kMe-00A5VG-2F
	for linux-fsdevel@vger.kernel.org;
	Fri, 03 May 2024 04:17:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/9] swapon(2)/swapoff(2): don't bother with block size
Date: Fri,  3 May 2024 05:17:34 +0100
Message-Id: <20240503041740.2404425-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
References: <20240503031833.GU2118490@ZenIV>
 <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

once upon a time that used to matter; these days we do swap IO for
swap devices at the level that doesn't give a damn about block size,
buffer_head or anything of that sort - just attach the page to
bio, set the location and size (the latter to PAGE_SIZE) and feed
into queue.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/swap.h |  1 -
 mm/swapfile.c        | 12 +-----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index f53d608daa01..a5b640cca459 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -301,7 +301,6 @@ struct swap_info_struct {
 	struct file *bdev_file;		/* open handle of the bdev */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
 	struct file *swap_file;		/* seldom referenced */
-	unsigned int old_block_size;	/* seldom referenced */
 	struct completion comp;		/* seldom referenced */
 	spinlock_t lock;		/*
 					 * protect map scan related fields like
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4919423cce76..304f74d039f3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2417,7 +2417,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	struct inode *inode;
 	struct filename *pathname;
 	int err, found = 0;
-	unsigned int old_block_size;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -2529,7 +2528,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	}
 
 	swap_file = p->swap_file;
-	old_block_size = p->old_block_size;
 	p->swap_file = NULL;
 	p->max = 0;
 	swap_map = p->swap_map;
@@ -2553,7 +2551,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	inode = mapping->host;
 	if (p->bdev_file) {
-		set_blocksize(p->bdev, old_block_size);
 		fput(p->bdev_file);
 		p->bdev_file = NULL;
 	}
@@ -2782,21 +2779,15 @@ static struct swap_info_struct *alloc_swap_info(void)
 
 static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 {
-	int error;
-
 	if (S_ISBLK(inode->i_mode)) {
 		p->bdev_file = bdev_file_open_by_dev(inode->i_rdev,
 				BLK_OPEN_READ | BLK_OPEN_WRITE, p, NULL);
 		if (IS_ERR(p->bdev_file)) {
-			error = PTR_ERR(p->bdev_file);
+			int error = PTR_ERR(p->bdev_file);
 			p->bdev_file = NULL;
 			return error;
 		}
 		p->bdev = file_bdev(p->bdev_file);
-		p->old_block_size = block_size(p->bdev);
-		error = set_blocksize(p->bdev, PAGE_SIZE);
-		if (error < 0)
-			return error;
 		/*
 		 * Zoned block devices contain zones that have a sequential
 		 * write only restriction.  Hence zoned block devices are not
@@ -3235,7 +3226,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
 	if (p->bdev_file) {
-		set_blocksize(p->bdev, p->old_block_size);
 		fput(p->bdev_file);
 		p->bdev_file = NULL;
 	}
-- 
2.39.2


