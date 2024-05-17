Return-Path: <linux-fsdevel+bounces-19674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5236C8C8695
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 14:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC53B211A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 12:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AABC5FBB2;
	Fri, 17 May 2024 12:51:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B35A0E1;
	Fri, 17 May 2024 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715950267; cv=none; b=nL6k0HxC+S6k9h1fCPGOOiF+K7jRlJvj8ftR+gxXeSsAFt8cA1u/LgSrEQeYOoP1ARrMmysSQI/ku3D5nTxx0Y/HzFd1JUhEVMClBIdCaPU2QeYnK9BoyzS+xv3JWKvvLsbQlZ9ImmZdC8VlxAYlwuLbwdufC1bGQwC3FOFopA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715950267; c=relaxed/simple;
	bh=LF3P4K1JXgnnAdYIFQNjnxl2Wf2DKh3kU51qvqL+8D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VifZX+5vYYvrFvh3jEO4iihph52ELbffI9GZImBfYHa3qjNB1e7ayZrzGJaUWcTvK9iFOkynCeubNdp6OLCH+KNOTAWhXnO87hUNP3N5yooqm5djtC1ragBKU8bnmhhdNC3K/e+dBpYiHF56BtHP4npxAXigcUnDhCc7aEemcUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VgmzC345Wz4f3jdp;
	Fri, 17 May 2024 20:50:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2D8611A017F;
	Fri, 17 May 2024 20:50:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBGdUkdmdAmqMw--.14380S7;
	Fri, 17 May 2024 20:50:56 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v5 03/10] ext4: warn if delalloc counters are not zero on inactive
Date: Fri, 17 May 2024 20:39:58 +0800
Message-Id: <20240517124005.347221-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
References: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBGdUkdmdAmqMw--.14380S7
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4UZFyDAFW7Kw4UXr4rGrg_yoW8Xw15p3
	9xC3W8GF95WFy8Wws7Xw47Xr1Sga18KF48Gr4xWr1UZF9xJa4Sqr1DtFy5A3WjgrZ3uw4S
	qa4fKr17ua4UG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUCXdbUUUUU
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The per-inode i_reserved_data_blocks count the reserved delalloc blocks
in a regular file, it should be zero when destroying the file. The
per-fs s_dirtyclusters_counter count all reserved delalloc blocks in a
filesystem, it also should be zero when umounting the filesystem. Now we
have only an error message if the i_reserved_data_blocks is not zero,
which is unable to be simply captured, so add WARN_ON_ONCE to make it
more visable.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 044135796f2b..b68064c877e3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1343,6 +1343,9 @@ static void ext4_put_super(struct super_block *sb)
 
 	ext4_group_desc_free(sbi);
 	ext4_flex_groups_free(sbi);
+
+	WARN_ON_ONCE(!(sbi->s_mount_state & EXT4_ERROR_FS) &&
+		     percpu_counter_sum(&sbi->s_dirtyclusters_counter));
 	ext4_percpu_param_destroy(sbi);
 #ifdef CONFIG_QUOTA
 	for (int i = 0; i < EXT4_MAXQUOTAS; i++)
@@ -1473,7 +1476,8 @@ static void ext4_destroy_inode(struct inode *inode)
 		dump_stack();
 	}
 
-	if (EXT4_I(inode)->i_reserved_data_blocks)
+	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_ERROR_FS) &&
+	    WARN_ON_ONCE(EXT4_I(inode)->i_reserved_data_blocks))
 		ext4_msg(inode->i_sb, KERN_ERR,
 			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
 			 inode->i_ino, EXT4_I(inode),
-- 
2.39.2


