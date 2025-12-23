Return-Path: <linux-fsdevel+bounces-71927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9EBCD7A12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 02:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CA813002E99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B78233722;
	Tue, 23 Dec 2025 01:20:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1995F1D9663;
	Tue, 23 Dec 2025 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452848; cv=none; b=iykQBpLsYIoSJmU47wfrA2boqmQuAfvQMXgF29lRS7WKaxSdsZB2v3bjVTMoPnMQBfnmcdRHkyLy+U+nTJDclxgWyH+xvxbxDxirfyU//uyRkShX6o6syMtpS9M3wH2Tc3ABLtWyJPN/h7gzxKTwGkZVcZv0+5nTAzv6o0nUJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452848; c=relaxed/simple;
	bh=ej4LwHcE5Re+8J+VVLrVMGPahKesONPAkdp0Ig6yXsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZZkCVIAH3j8381zgRUw0N1lzlwg4BKAmQUG8jMuVogvMMhs7aeCxQ7QLyVt7twzr+f2oqygfd/MOTTrmXe/+VY4eXOCbbvf6byrqJka4vXn0ja0U9bGzKPWOOJx5iJzOzbTXzOzQB0m7CaxW45oKhxAQP7gopySJM/pUdk9Xac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dZxyJ1dSDzYQtgv;
	Tue, 23 Dec 2025 09:20:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6694940579;
	Tue, 23 Dec 2025 09:20:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAXd_dY7klpHOeZBA--.61342S8;
	Tue, 23 Dec 2025 09:20:44 +0800 (CST)
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
Subject: [PATCH -next v2 4/7] ext4: remove useless ext4_iomap_overwrite_ops
Date: Tue, 23 Dec 2025 09:17:59 +0800
Message-ID: <20251223011802.31238-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
References: <20251223011802.31238-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXd_dY7klpHOeZBA--.61342S8
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyUCFyrGF18Zw1DXr1kKrg_yoWrXFy8pa
	s8KF13GF4xXryq9F4UKFWxZryYkw17Kw48Xry3Gwn5uryqv34IqFW8Ka4Yk3W5J3yxAry2
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
Reviewed-by: Jan Kara <jack@suse.cz>
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
index ff3ad1a2df45..b84a2a10dfb8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3833,10 +3833,6 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		}
 		ret = ext4_iomap_alloc(inode, &map, flags);
 	} else {
-		/*
-		 * This can be called for overwrites path from
-		 * ext4_iomap_overwrite_begin().
-		 */
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
 	}
 
@@ -3865,30 +3861,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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
2.52.0


