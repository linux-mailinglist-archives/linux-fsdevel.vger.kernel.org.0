Return-Path: <linux-fsdevel+bounces-16284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE3989AA03
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8BFB22B00
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565AE3D387;
	Sat,  6 Apr 2024 09:17:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B050383A6;
	Sat,  6 Apr 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395075; cv=none; b=YhOODVPhTcRPIOGwmMZdruF9Nro2sneiO/8DgqL63U7jcgpWgAM3krph8Gi7b8Z1pPwLnoDljMTxsgCofSzSr8akcD8Ddurcqv9baiXNtsTFnZDawmWds4QBC6IgjcY/B9bhxg1Nmvrv+OnbbXoCK+zXTO2quxtpbZFjIoBhKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395075; c=relaxed/simple;
	bh=oITzHCczE+PR9WvzwFwNQD/O6vI0Xdj/12ViSedP+jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+UuGJeyh6xgjSGZCT53+CwOqgAtURAS5j7k1tqGeDnmFvN0kybCUfFAOzgXCkBs9zDaoAEUUeBZjH9feFl6E1hbLEqmsMxYNXkuPnizUffVhjB4oHpOKhVFa3wVzuHlRwvuSTzuxPduXGabAZIr/ZatDR9JdZssXCCfC1i5uAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVBG2lB7z4f3lgK;
	Sat,  6 Apr 2024 17:17:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D8DE91A0572;
	Sat,  6 Apr 2024 17:17:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S25;
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
Subject: [PATCH vfs.all 21/26] block: fix module reference leakage from bdev_open_by_dev error path
Date: Sat,  6 Apr 2024 17:09:25 +0800
Message-Id: <20240406090930.2252838-22-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S25
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1xurykXrW7uw48ZF17GFg_yoWfGFb_u3
	WrCry8ur4rA34fCw4ayFyrXrs5t3W8JrWFyayxJF97CFy7Jas7uanxXr95ZF43XayDGw45
	C3WYqrs8Zr1IgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

At the time bdev_may_open() is called, module reference is grabbed
already, hence module reference should be released if bdev_may_open()
failed.

This problem is found by code review.

Fixes: ed5cc702d311 ("block: Add config option to not allow writing to mounted devices")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 82fb1688f4c9..86db97b0709e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -890,7 +890,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 		goto abort_claiming;
 	ret = -EBUSY;
 	if (!bdev_may_open(bdev, mode))
-		goto abort_claiming;
+		goto put_module;
 	if (bdev_is_partition(bdev))
 		ret = blkdev_get_part(bdev, mode);
 	else
-- 
2.39.2


