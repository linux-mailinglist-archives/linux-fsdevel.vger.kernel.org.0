Return-Path: <linux-fsdevel+bounces-17272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4A18AA704
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 04:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0791F22242
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 02:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A296D6107;
	Fri, 19 Apr 2024 02:39:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC529372;
	Fri, 19 Apr 2024 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713494352; cv=none; b=JJO2B7yYMxsrjZf5lerMOKjcz9lS3t04P4rtADZ3heZADRcdnd5k3iqVlu4f75IkOdbUX94nAVyUSGXoUI4eYeSe5lX2jrU64uly3pk4o2tIIWyBxX9SJvtA1+ZDjLwaLsJQAne+6Lrje8wVYnCcKdc7dkZlMQfLZ4TnS8sQh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713494352; c=relaxed/simple;
	bh=9dEafjMPmsvuMRFpGECnHFXu2SS68ra4H3QM8YdyOuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AfK7OdYxE56xop2GduSZoU97qg6jFseGJ2ztjJMQKgqWRFZW4ZoM8jNSy9WCWnZ/xuR1Z6EzDbYerqyji21A3q5zVDSrtZfqrmCqGLWQ0kEPLdB/8Khk9Sj7myJuW07isObLqs6Q/7hzM4if+OQq3OtRNS9ffkntnX/iu65x2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VLJk730plz4f3jqr;
	Fri, 19 Apr 2024 10:38:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1E6511A0572;
	Fri, 19 Apr 2024 10:39:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFB2SFmC8VxKQ--.51816S4;
	Fri, 19 Apr 2024 10:38:59 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH] ext4: remove the redundant folio_wait_stable()
Date: Fri, 19 Apr 2024 10:30:05 +0800
Message-Id: <20240419023005.2719050-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFB2SFmC8VxKQ--.51816S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyUKF13GrWkWr17Cr1kAFb_yoWDtwcEg3
	y8Xa1rXa4fXrn3Ars3AF15Zrna9F1kWw17uF4FyFySvFy5Jas5CwnYyrn8CrWxWr4Y9rs8
	Zr47XrWS9rykXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

__filemap_get_folio() with FGP_WRITEBEGIN parameter has already wait
for stable folio, so remove the redundant folio_wait_stable() in
ext4_da_write_begin(), it was left over from the commit cc883236b792
("ext4: drop unnecessary journal handle in delalloc write") that
removed the retry getting page logic.

Fixes: cc883236b792 ("ext4: drop unnecessary journal handle in delalloc write")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 537803250ca9..6de6bf57699b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2887,9 +2887,6 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	/* In case writeback began while the folio was unlocked */
-	folio_wait_stable(folio);
-
 #ifdef CONFIG_FS_ENCRYPTION
 	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
 #else
-- 
2.39.2


