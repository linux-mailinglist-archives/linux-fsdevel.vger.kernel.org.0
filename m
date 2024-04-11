Return-Path: <linux-fsdevel+bounces-16690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392778A17DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525621C2169E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9009DF78;
	Thu, 11 Apr 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wXYwUNYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BDEDDCB;
	Thu, 11 Apr 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847234; cv=none; b=IUOfshB8jiZCBAo7chnXUz9VRWajKv5DeoMBYRgF1XxNg0TZ8X4rN2TnZzrcpVp8/8pS9ZSryE+b7JwZ+1jO9atDdukwUPlxCKCH7TUI1BhpKKO+pEuKVOfNRxqTCuhis7Ls2DI6cBksvD6B33nRjRgPMNLXAQ6nPGK6eyjzNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847234; c=relaxed/simple;
	bh=gYkT1rroFZYYsvGbXCgl+lQ2OCtn0nKgFpRQL/w/ULc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=stRn7O9E7ATeroE2LavuHj5qA8ganutoLagfr2kkvJJ5jXoIlxVGeElWsgXEJxgv5YCzoyyLU7+MoMyVxZNk6L1s3TRRKBAHLXhBghE6SaF0Zcr0zi+enBaXSJwyI7Y3o3trkCmIMT4raICKmcQMm9RYKmBCxvu9JXXPLUfaR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wXYwUNYS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SOqH2f5L3FyMhnYaJIYbEjAo1KCEL9u4bjfLgLLZxj0=; b=wXYwUNYSrAiC4g9AFrEB2zg6MO
	oQNIbSiBGOV/Qgv6A2xrQAZ0+ECdKwkeZJOKx7Pjpl4Qh0G2zgFnAWJXUs5DRHqvHXc3Kd/QiKdOz
	vmhMvs+//BLLUjdjG4dleuc8SuzI1E2eUIXY9EXUVzgkaMCVzj9q610fH5DCC9CNlIGXAbwuR3qHn
	JUJA6w+YZTjFAhqFgjfFHsgC5TmagzifEU5U2CcWkmwTOWP7uXi8sHD58HR/LyO1fLcGzwfeqdKcN
	7yLC662JdkqFxpJOZHp/8mc42mm+pBlLoFz2DHiyOpvlc3s9YCHSBeIX1IsH0JgCQcQHEXLFTETYg
	Df55ZvSg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ruvoA-00AYkR-0y;
	Thu, 11 Apr 2024 14:53:46 +0000
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
Subject: [PATCH 01/11] block_device: add a pointer to struct address_space (page cache of bdev)
Date: Thu, 11 Apr 2024 15:53:36 +0100
Message-Id: <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240411144930.GI2118490@ZenIV>
References: <20240411144930.GI2118490@ZenIV>
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
---
 block/bdev.c              | 1 +
 include/linux/blk_types.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index dd26d37356aa..1c3462fba6ce 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -413,6 +413,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
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


