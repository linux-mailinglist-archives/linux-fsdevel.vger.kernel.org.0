Return-Path: <linux-fsdevel+bounces-17980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC098B483A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 23:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897EFB20C4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 21:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C93A145B3D;
	Sat, 27 Apr 2024 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oW5Iw2xj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80883A8EF;
	Sat, 27 Apr 2024 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252262; cv=none; b=VKouOY1LTVYR18emqg/vJsCAMllzKQLiVqxuNqJmhlpMx0eeCbtcD2w83OgSQLz4JuOQ4gi+DAuD7MBAuBytWwaYuOe3jtSTIa1kh0+c5RhGnICZmdBpCWRL3pwehlrrjxJgjRhnUdNDN9EIkKV2uALH7+/730jWCbpOievcMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252262; c=relaxed/simple;
	bh=pV4AKnwLUN6/zLcC1XNnmdJnkupWesLB1fJcblepBfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUYPEPUjMYl58gPVa2ZPt3cpa1kO8jefSUI8DWHL7MNx0Q65KsKlPFeL0/WW+/+BFBJVsZcb/Uo+4x/zcUhKCUcQrfKMJUPUlZW5XjOLEXyj5cqqb0nCHSPjhzILjrtbrC+03g1f/N5On+KR3X2dIDUejDCR6pzaZ398v9vCV0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oW5Iw2xj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZtY0zDJFh1bfYVr5+ZZnCLSP+bf/SXfawfhTG/pucxs=; b=oW5Iw2xjh5J37/WSeVlsGwYIwK
	Emz20AS/AmmX1FhRZaZDmaLx3oElfpmrK74GulHgBM6d3OHlz5QpDpjGIsH5O2nSVKwjnBzcu7Ye8
	zBfgEv16Cuu22zADjlGSzS9B0DSIwqvFsLVkUoDbcklvVhnjmB0MSTsY7HxXamylZc0Nh6FSWdI1Q
	tPD/5fnArCfj54pYAAjVh9o2cXS8zJgOyQdFXUbw+RXQ5+7rrAp9LDK3Pw/WNT3c0o6sEWslbs0Tx
	XHoQdPOYx0RxY4yBAmsaNfKKcesIT4P4LcOI+8I06no8EBuLgkOK2+TqR67gIkhDq9RyzM/jS4sQE
	Kw3CvaGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0pJz-006H4s-0g;
	Sat, 27 Apr 2024 21:10:59 +0000
Date: Sat, 27 Apr 2024 22:10:59 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/7] swapon(2)/swapoff(2): don't bother with block size
Message-ID: <20240427211059.GC1495312@ZenIV>
References: <20240427210920.GR2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427210920.GR2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

once upon a time that used to matter; these days we do swap IO for
swap devices at the level that doesn't give a damn about block size,
buffer_head or anything of that sort - just attach the page to
bio, set the location and size (the latter to PAGE_SIZE) and feed
into queue.

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


