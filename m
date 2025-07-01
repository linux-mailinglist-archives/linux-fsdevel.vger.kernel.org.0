Return-Path: <linux-fsdevel+bounces-53519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7CAEFA57
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F40485D21
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D92E2797A0;
	Tue,  1 Jul 2025 13:21:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8E277027;
	Tue,  1 Jul 2025 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376066; cv=none; b=LbxRwdie98B1mqXb1QBdkYxFRBtI325WFQnLKZSKofx2fRwJdstcQKpDhcH7BRn/981muX1V6YhVbvgX6Fcnxs2mcdElV+JY0bhFRA8hi/NFLeTblik6HYyg2EiILfNJJxYdCPyQYBTZyUWVfOtM6M7xhu8kVDmh/OqrXiE8z0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376066; c=relaxed/simple;
	bh=UUz/d+j4G1YWUM542UYP4iqTguhEMqe/b1oTWwaRojI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPpbUlW9zML06HEc185ew0+0TOj3ytsfzVRfg+KaKmY/EflqhAFLsUDXArLr/QZSSHpGCCmeIlepeUWA7XqjoiCVfe0IE4ycgeDA/i38Id+1xdgRxn9DsKbYS0AFUEaHwBntdYThecNXsOkUdIPsDNKV/b5baOUREkvOWCz8Ohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bWkDt6CYQzYQvPt;
	Tue,  1 Jul 2025 21:21:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B8D241A0E9A;
	Tue,  1 Jul 2025 21:21:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXeCWu4GNoXmJGAQ--.26904S13;
	Tue, 01 Jul 2025 21:21:01 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	sashal@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 09/10] ext4: replace ext4_writepage_trans_blocks()
Date: Tue,  1 Jul 2025 21:06:34 +0800
Message-ID: <20250701130635.4079595-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXeCWu4GNoXmJGAQ--.26904S13
X-Coremail-Antispam: 1UD129KBjvJXoWxtry3tF48Gr4Dtw43tr4kXrb_yoW3Zr43pa
	sxCF1rKr15W34kuFWI9r47Zr4aga18Cr4UXrySkrnYgayDXw1IgFn0v3WYyFy5trW8Wws0
	vF4Yk34UWa1ak37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

After ext4 supports large folios, the semantics of reserving credits in
pages is no longer applicable. In most scenarios, reserving credits in
extents is sufficient. Therefore, introduce ext4_chunk_trans_extent()
to replace ext4_writepage_trans_blocks(). move_extent_per_page() is the
only remaining location where we are still processing extents in pages.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h        |  2 +-
 fs/ext4/extents.c     |  6 +++---
 fs/ext4/inline.c      |  6 +++---
 fs/ext4/inode.c       | 33 +++++++++++++++------------------
 fs/ext4/move_extent.c |  3 ++-
 fs/ext4/xattr.c       |  2 +-
 6 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18373de980f2..f705046ba6c6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3064,9 +3064,9 @@ extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
 extern void ext4_set_inode_flags(struct inode *, bool init);
 extern int ext4_alloc_da_blocks(struct inode *inode);
 extern void ext4_set_aops(struct inode *inode);
-extern int ext4_writepage_trans_blocks(struct inode *);
 extern int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode);
 extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
+extern int ext4_chunk_trans_extent(struct inode *inode, int nrblocks);
 extern int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
 extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b543a46fc809..f0f155458697 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5171,7 +5171,7 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
 				credits = depth + 2;
 			}
 
-			restart_credits = ext4_writepage_trans_blocks(inode);
+			restart_credits = ext4_chunk_trans_extent(inode, 0);
 			err = ext4_datasem_ensure_credits(handle, inode, credits,
 					restart_credits, 0);
 			if (err) {
@@ -5431,7 +5431,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 
 	truncate_pagecache(inode, start);
 
-	credits = ext4_writepage_trans_blocks(inode);
+	credits = ext4_chunk_trans_extent(inode, 0);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
@@ -5527,7 +5527,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 
 	truncate_pagecache(inode, start);
 
-	credits = ext4_writepage_trans_blocks(inode);
+	credits = ext4_chunk_trans_extent(inode, 0);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index a1bbcdf40824..d5b32d242495 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -562,7 +562,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		return 0;
 	}
 
-	needed_blocks = ext4_writepage_trans_blocks(inode);
+	needed_blocks = ext4_chunk_trans_extent(inode, 1);
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)
@@ -1864,7 +1864,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 	};
 
 
-	needed_blocks = ext4_writepage_trans_blocks(inode);
+	needed_blocks = ext4_chunk_trans_extent(inode, 1);
 	handle = ext4_journal_start(inode, EXT4_HT_INODE, needed_blocks);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
@@ -1979,7 +1979,7 @@ int ext4_convert_inline_data(struct inode *inode)
 			return 0;
 	}
 
-	needed_blocks = ext4_writepage_trans_blocks(inode);
+	needed_blocks = ext4_chunk_trans_extent(inode, 1);
 
 	iloc.bh = NULL;
 	error = ext4_get_inode_loc(inode, &iloc);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ceaede80d791..572a70b6a934 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1295,7 +1295,8 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	 * Reserve one block more for addition to orphan list in case
 	 * we allocate blocks but write fails for some reason
 	 */
-	needed_blocks = ext4_writepage_trans_blocks(inode) + 1;
+	needed_blocks = ext4_chunk_trans_extent(inode,
+			ext4_journal_blocks_per_folio(inode)) + 1;
 	index = pos >> PAGE_SHIFT;
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
@@ -4462,7 +4463,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		return ret;
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		credits = ext4_writepage_trans_blocks(inode);
+		credits = ext4_chunk_trans_extent(inode, 2);
 	else
 		credits = ext4_blocks_for_truncate(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
@@ -4611,7 +4612,7 @@ int ext4_truncate(struct inode *inode)
 	}
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		credits = ext4_writepage_trans_blocks(inode);
+		credits = ext4_chunk_trans_extent(inode, 1);
 	else
 		credits = ext4_blocks_for_truncate(inode);
 
@@ -6238,25 +6239,19 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
 }
 
 /*
- * Calculate the total number of credits to reserve to fit
- * the modification of a single pages into a single transaction,
- * which may include multiple chunks of block allocations.
- *
- * This could be called via ext4_write_begin()
- *
- * We need to consider the worse case, when
- * one new block per extent.
+ * Calculate the journal credits for modifying the number of blocks
+ * in a single extent within one transaction. 'nrblocks' is used only
+ * for non-extent inodes. For extent type inodes, 'nrblocks' can be
+ * zero if the exact number of blocks is unknown.
  */
-int ext4_writepage_trans_blocks(struct inode *inode)
+int ext4_chunk_trans_extent(struct inode *inode, int nrblocks)
 {
-	int bpp = ext4_journal_blocks_per_folio(inode);
 	int ret;
 
-	ret = ext4_meta_trans_blocks(inode, bpp, bpp);
-
+	ret = ext4_meta_trans_blocks(inode, nrblocks, 1);
 	/* Account for data blocks for journalled mode */
 	if (ext4_should_journal_data(inode))
-		ret += bpp;
+		ret += nrblocks;
 	return ret;
 }
 
@@ -6634,10 +6629,12 @@ static int ext4_block_page_mkwrite(struct inode *inode, struct folio *folio,
 	handle_t *handle;
 	loff_t size;
 	unsigned long len;
+	int credits;
 	int ret;
 
-	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
-				    ext4_writepage_trans_blocks(inode));
+	credits = ext4_chunk_trans_extent(inode,
+			ext4_journal_blocks_per_folio(inode));
+	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 1f8493a56e8f..adae3caf175a 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -280,7 +280,8 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	 */
 again:
 	*err = 0;
-	jblocks = ext4_writepage_trans_blocks(orig_inode) * 2;
+	jblocks = ext4_meta_trans_blocks(orig_inode, block_len_in_page,
+					 block_len_in_page) * 2;
 	handle = ext4_journal_start(orig_inode, EXT4_HT_MOVE_EXTENTS, jblocks);
 	if (IS_ERR(handle)) {
 		*err = PTR_ERR(handle);
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 8d15acbacc20..3fb93247330d 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -962,7 +962,7 @@ int __ext4_xattr_set_credits(struct super_block *sb, struct inode *inode,
 	 * so we need to reserve credits for this eventuality
 	 */
 	if (inode && ext4_has_inline_data(inode))
-		credits += ext4_writepage_trans_blocks(inode) + 1;
+		credits += ext4_chunk_trans_extent(inode, 1) + 1;
 
 	/* We are done if ea_inode feature is not enabled. */
 	if (!ext4_has_feature_ea_inode(sb))
-- 
2.46.1


