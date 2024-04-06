Return-Path: <linux-fsdevel+bounces-16285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADB189AA04
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACDBFB22ADF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757353D965;
	Sat,  6 Apr 2024 09:17:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697B0383A3;
	Sat,  6 Apr 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395075; cv=none; b=m7THCg10YAjFObJwfqH/F7Fe9DQm/X4XIYa74sRK1TrhLaRHACFT8lzCALURknOBaYu9zZVZIBfFr01gux/gwKLBonL9EKwFMlSd5FpfdAkCfKqWFox0SbpJCYEaPrEYksegIoy3twkANdXPiN5a75HTZDgkTL3aujlUhqbTMVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395075; c=relaxed/simple;
	bh=IVNvL7M+0fIXRVg8xk89r3IChLHlduOXWlBxUNT4Nvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eEdWjZxg4Dmj+1WGiXt2YOTiZ+jw0JKVuVDyQUACnE1jR7G81MkKM0F5Wjm8Fxqbw0RvrHxD9eA0bD1jnYbQDcMlGtyfOwBGPQ5B3qszK2CtvwW3YWQ7up2ndN74P2VW5Rorl5/ppoCba3uIKE5SzbGIfjjaoeODRIWaQzMGDQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VBVBH5rdKz4f3kFR;
	Sat,  6 Apr 2024 17:17:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 74DDD1A0568;
	Sat,  6 Apr 2024 17:17:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S24;
	Sat, 06 Apr 2024 17:17:50 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH vfs.all 20/26] block: factor out a helper init_bdev_file()
Date: Sat,  6 Apr 2024 17:09:24 +0800
Message-Id: <20240406090930.2252838-21-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S24
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47Kr4xtry7uF47WFWUCFg_yoW8Aw1fpr
	9xWFZ0gr1UGw1DWay7Xa42qF90vw18Aa48Zr12qa4ayFZrJrZ29F1rKr1UuFWUt34kJw1D
	XF4UuryUWFySk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

There are no functional changes, the helper will be used in later
patches to initialize stashed bdev_file as well.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 4335df6d1266..82fb1688f4c9 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -832,6 +832,20 @@ static void bdev_yield_write_access(struct file *bdev_file)
 		bdev->bd_writers--;
 }
 
+static void init_bdev_file(struct file *bdev_file, struct block_device *bdev,
+			   blk_mode_t mode, void *holder)
+{
+	bdev_file->f_flags |= O_LARGEFILE;
+	bdev_file->f_mode |= FMODE_CAN_ODIRECT;
+	if (bdev_nowait(bdev))
+		bdev_file->f_mode |= FMODE_NOWAIT;
+	if (mode & BLK_OPEN_RESTRICT_WRITES)
+		bdev_file->f_mode |= FMODE_WRITE_RESTRICTED;
+	bdev_file->f_mapping = bdev_mapping(bdev);
+	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
+	bdev_file->private_data = holder;
+}
+
 /**
  * bdev_open - open a block device
  * @bdev: block device to open
@@ -905,15 +919,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	if (unblock_events)
 		disk_unblock_events(disk);
 
-	bdev_file->f_flags |= O_LARGEFILE;
-	bdev_file->f_mode |= FMODE_CAN_ODIRECT;
-	if (bdev_nowait(bdev))
-		bdev_file->f_mode |= FMODE_NOWAIT;
-	if (mode & BLK_OPEN_RESTRICT_WRITES)
-		bdev_file->f_mode |= FMODE_WRITE_RESTRICTED;
-	bdev_file->f_mapping = bdev_mapping(bdev);
-	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
-	bdev_file->private_data = holder;
+	init_bdev_file(bdev_file, bdev, mode, holder);
 
 	return 0;
 put_module:
-- 
2.39.2


