Return-Path: <linux-fsdevel+bounces-19014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E19D8BF678
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BAE282936
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8A123754;
	Wed,  8 May 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ooy/tN/2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE621E868
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150695; cv=none; b=eljq+q8NSUMQOPMBlFUTWRrbCW2s2uEL6w9CLvgXQFvW2LXVk7w4JIS4uFgiYsxvhvj+nK/O64/xYCvj65GU0YWxwFQf9E97F9BBHzgbMYjLYFq/mIjjjt1vObEuWNfpf78QuEEezPRj4Kj8LqjNMvIZJNIfYZzSmvBLD12OXJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150695; c=relaxed/simple;
	bh=bi0vggH2vlzCwkAngLM28XlmXymlAdgEAZFtw3fzSPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RlL6K6ThwpgG0crQ5SR72OXPoyU6C7UcSGZjFOzyCliskHsKEmEkZSvC5HjYz9jNFuXMJMDuBqZoSyijSU0h7NZSl/S1U14WYwyl2/T2tPwptAb84yo1twafHmt4Q6OyKR7WSWuXzt+SZml9pGGnQibM3vUZCo4HddHns+/4F3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ooy/tN/2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gIFk9tcSdCdQApnLN7C+jWLoijedJLlPZejoVEG++es=; b=Ooy/tN/2W2LqeW+hbEkfKSGaZc
	MEqbL5ysnatx5GY1IbM5cqet2Zk5D4t1w+CMgrcjJcKeY5lom0Y4AVeA9INyeHVzH/+NxHCcnXmtU
	CoEF8lAAZur2JRWNp9LOoKdC5jvzgwSGyDt3F3ABhsv6xSRSQOa0WkYihnf7cZ9Cr5CYNb/B/MSV4
	zavrWHXPtqSYNDmhf8glkIAdFTrXPPl5LzMHPHJg+dXHbHErfoO/NRUz0o1Y/cWjsv8RaC+OwF2WZ
	k7INfZyTJskBjtYKN+jaz50tAkqS5l9Hhcc8K2DjG9S99oOv99pne9BP++gzMXthifaOIeEEmgpby
	V1c3+FaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b2q-00FvzH-0w;
	Wed, 08 May 2024 06:44:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 2 01/10] block_device: add a pointer to struct address_space (page cache of bdev)
Date: Wed,  8 May 2024 07:44:43 +0100
Message-Id: <20240508064452.3797817-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508063522.GO2118490@ZenIV>
References: <20240508063522.GO2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

points to ->i_data of coallocated inode.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20240411145346.2516848-1-viro@zeniv.linux.org.uk
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c              | 1 +
 include/linux/blk_types.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 28e6f0423857..8e19101cbbb0 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -419,6 +419,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	mutex_init(&bdev->bd_holder_lock);
 	bdev->bd_partno = partno;
 	bdev->bd_inode = inode;
+	bdev->bd_mapping = &inode->i_data;
 	bdev->bd_queue = disk->queue;
 	if (partno)
 		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cb1526ec44b5..6438c75cbb35 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -51,6 +51,7 @@ struct block_device {
 	bool			bd_has_submit_bio;
 	dev_t			bd_dev;
 	struct inode		*bd_inode;	/* will die */
+	struct address_space	*bd_mapping;	/* page cache */
 
 	atomic_t		bd_openers;
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
-- 
2.39.2


