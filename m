Return-Path: <linux-fsdevel+bounces-71234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B65CBA321
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 03:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA5030EC76B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 02:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E7625B1D2;
	Sat, 13 Dec 2025 02:22:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C825248F69;
	Sat, 13 Dec 2025 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765592562; cv=none; b=XehxiuMrqCr99UP7apiwU+38OBW/m3MVkL+QlcLbuOzboEeZKX+hQfWhn5vuuyrz5WQedfTahdS6nI+lbnpY5Iv4A/jwJDnqi1goJf6m7G61x1Yt7UAOHnhSSlhup5/Yx3/L9beps2oxTyzQSxB4/CVK/3GldNXJLX1E6sqcl7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765592562; c=relaxed/simple;
	bh=SuToqufgeedB76fXdmlaUjq0X4rUPq/B8dR/PMpeJWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdiXMHOyEf/Ve3+GwIxXNzzHS2co2ln+z+J9nig09f0XeZxJKLb4wZXhotQ4erKJvihIynvzFGoCsIuSkKGjK9NzCkDDCs9eQF2uEDn3XV5T1sZp2KkYO0vBh9e3VJf+GQIfySK2E5coLl8nn9Sl84qOP0WhvRN0TveFigr9l4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dSqpf5f9gzYQtxK;
	Sat, 13 Dec 2025 10:22:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1D4D01A0CC1;
	Sat, 13 Dec 2025 10:22:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgA3F1HTzTxpFXQ7Bg--.63968S8;
	Sat, 13 Dec 2025 10:22:28 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yukuai@fnnas.com
Subject: [PATCH -next 4/7] ext4: remove useless ext4_iomap_overwrite_ops
Date: Sat, 13 Dec 2025 10:20:05 +0800
Message-ID: <20251213022008.1766912-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
References: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3F1HTzTxpFXQ7Bg--.63968S8
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyUCFyrGF18Zw1DXr1kKrg_yoWrXryDpa
	s8KF13GF4xXryq9F4UKFW7ZryYkw13Kw48Xry3Gwn5uryqv34IqFW8Ka4YkF15J3yxAry2
	qF1jkry8JF1akrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUOyIUUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

ext4_iomap_overwrite_ops was introduced in commit 8cd115bdda17 ("ext4:
Optimize ext4 DIO overwrites"), which can optimize pure overwrite
performance by dropping the IOMAP_WRITE flag to only query the mapped
mapping information. This avoids starting a new journal handle, thereby
improving speed. Later, commit 9faac62d4013 ("ext4: optimize file
overwrites") also optimized similar scenarios, but it performs the check
later, examining the mappings status only when the actual block mapping
is needed. Thus, it can handle the previous commit scenario. That means
in the case of an overwrite scenario, the condition
"offset + length <= i_size_read(inode)" in the write path must always be
true.

Therefore, it is acceptable to remove the ext4_iomap_overwrite_ops,
which will also clarify the write and read paths of ext4_iomap_begin.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  1 -
 fs/ext4/file.c  |  5 +----
 fs/ext4/inode.c | 24 ------------------------
 3 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 56112f201cac..9a71357f192d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3909,7 +3909,6 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
 }
 
 extern const struct iomap_ops ext4_iomap_ops;
-extern const struct iomap_ops ext4_iomap_overwrite_ops;
 extern const struct iomap_ops ext4_iomap_report_ops;
 
 static inline int ext4_buffer_uptodate(struct buffer_head *bh)
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 9f571acc7782..6b4b68f830d5 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -506,7 +506,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	loff_t offset = iocb->ki_pos;
 	size_t count = iov_iter_count(from);
-	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
 	bool extend = false, unwritten = false;
 	bool ilock_shared = true;
 	int dio_flags = 0;
@@ -573,9 +572,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 	}
 
-	if (ilock_shared && !unwritten)
-		iomap_ops = &ext4_iomap_overwrite_ops;
-	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
+	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
 			   dio_flags, NULL, 0);
 	if (ret == -ENOTBLK)
 		ret = 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 08a296122fe0..88144e2ce3e2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3830,10 +3830,6 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		}
 		ret = ext4_iomap_alloc(inode, &map, flags);
 	} else {
-		/*
-		 * This can be called for overwrites path from
-		 * ext4_iomap_overwrite_begin().
-		 */
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
 	}
 
@@ -3862,30 +3858,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
-static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
-		loff_t length, unsigned flags, struct iomap *iomap,
-		struct iomap *srcmap)
-{
-	int ret;
-
-	/*
-	 * Even for writes we don't need to allocate blocks, so just pretend
-	 * we are reading to save overhead of starting a transaction.
-	 */
-	flags &= ~IOMAP_WRITE;
-	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
-	WARN_ON_ONCE(!ret && iomap->type != IOMAP_MAPPED);
-	return ret;
-}
-
 const struct iomap_ops ext4_iomap_ops = {
 	.iomap_begin		= ext4_iomap_begin,
 };
 
-const struct iomap_ops ext4_iomap_overwrite_ops = {
-	.iomap_begin		= ext4_iomap_overwrite_begin,
-};
-
 static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 				   loff_t length, unsigned int flags,
 				   struct iomap *iomap, struct iomap *srcmap)
-- 
2.46.1


