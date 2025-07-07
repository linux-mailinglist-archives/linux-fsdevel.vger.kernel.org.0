Return-Path: <linux-fsdevel+bounces-54124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DA9AFB5ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7723C4255BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B3F2DCF63;
	Mon,  7 Jul 2025 14:23:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7C12DAFAE;
	Mon,  7 Jul 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898186; cv=none; b=YOCinodBD+HezEDbZwp5pTGKphD9j1YTUffCV/7EqOFXJK7shPrvHtvN6u8YP3L1cIYD0dqcEfq6nfFlr5Ejd+iq//Q38ojQTaJWg4qGmW8gghzWdE6jmHOhKLyrLa/Ws/xLPuyEAeekVElbsnx+PdfdM1ev7Y3pJ4tJzmLyLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898186; c=relaxed/simple;
	bh=pD7hY1OcA4uWjfnB809xyY1iSJS5H+vjuHjwhhn46dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnuYIMVxRvtmYoxD6IrR8qzovorcyQ/SPiQlUyedTn6wJu7TGH81Z4MacZKJSV+jvwmuGFnVFWYdJkercNxabGrW0/BOKehusxVddjKS9EbIRUBL8yMlrGi/nXXwy5kAj9oMntkbw8fZpOhVLegDY52N/USYRW2Da3ROGqbowVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bbRKg094BzYQttj;
	Mon,  7 Jul 2025 22:23:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CF7661A0CF1;
	Mon,  7 Jul 2025 22:23:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgBnxyQ22GtoNazLAw--.46745S15;
	Mon, 07 Jul 2025 22:23:01 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	sashal@kernel.org,
	naresh.kamboju@linaro.org,
	jiangqi903@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 11/11] ext4: limit the maximum folio order
Date: Mon,  7 Jul 2025 22:08:14 +0800
Message-ID: <20250707140814.542883-12-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
References: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnxyQ22GtoNazLAw--.46745S15
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4kWw1rtr1xJw4kJF18Xwb_yoW5KFyfpF
	y7GF1rGr40q3sFgr4xtw47Zr13tayxGrWUA3yfCw43ZFWUX34rtF40kF13Z3WUtrWkXa1S
	qF42kFyUua13CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

In environments with a page size of 64KB, the maximum size of a folio
can reach up to 128MB. Consequently, during the write-back of folios,
the 'rsv_blocks' will be overestimated to 1,577, which can make
pressure on the journal space where the journal is small. This can
easily exceed the limit of a single transaction. Besides, an excessively
large folio is meaningless and will instead increase the overhead of
traversing the bhs within the folio. Therefore, limit the maximum order
of a folio to 2048 filesystem blocks.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Joseph Qi <jiangqi903@gmail.com>
Closes: https://lore.kernel.org/linux-ext4/CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com/
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h   |  2 +-
 fs/ext4/ialloc.c |  3 +--
 fs/ext4/inode.c  | 22 +++++++++++++++++++---
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f705046ba6c6..9ac0a7d4fa0c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3020,7 +3020,7 @@ int ext4_walk_page_buffers(handle_t *handle,
 				     struct buffer_head *bh));
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh);
-bool ext4_should_enable_large_folio(struct inode *inode);
+void ext4_set_inode_mapping_order(struct inode *inode);
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
 
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 79aa3df8d019..df4051613b29 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1335,8 +1335,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 
-	if (ext4_should_enable_large_folio(inode))
-		mapping_set_large_folios(inode->i_mapping);
+	ext4_set_inode_mapping_order(inode);
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4b679cb6c8bd..1bce9ebaedb7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5181,7 +5181,7 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
 	return -EFSCORRUPTED;
 }
 
-bool ext4_should_enable_large_folio(struct inode *inode)
+static bool ext4_should_enable_large_folio(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
@@ -5198,6 +5198,22 @@ bool ext4_should_enable_large_folio(struct inode *inode)
 	return true;
 }
 
+/*
+ * Limit the maximum folio order to 2048 blocks to prevent overestimation
+ * of reserve handle credits during the folio writeback in environments
+ * where the PAGE_SIZE exceeds 4KB.
+ */
+#define EXT4_MAX_PAGECACHE_ORDER(i)		\
+		min(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
+void ext4_set_inode_mapping_order(struct inode *inode)
+{
+	if (!ext4_should_enable_large_folio(inode))
+		return;
+
+	mapping_set_folio_order_range(inode->i_mapping, 0,
+				      EXT4_MAX_PAGECACHE_ORDER(inode));
+}
+
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			  ext4_iget_flags flags, const char *function,
 			  unsigned int line)
@@ -5515,8 +5531,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
-	if (ext4_should_enable_large_folio(inode))
-		mapping_set_large_folios(inode->i_mapping);
+
+	ext4_set_inode_mapping_order(inode);
 
 	ret = check_igot_inode(inode, flags, function, line);
 	/*
-- 
2.46.1


