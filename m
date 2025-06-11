Return-Path: <linux-fsdevel+bounces-51312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 009C3AD5404
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF083AE7EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3612C27C162;
	Wed, 11 Jun 2025 11:29:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8825BF1F;
	Wed, 11 Jun 2025 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641385; cv=none; b=cchK0SvTAUIdNeBZt4+oZzApPzp4XZoxMZIxgKr3MAYRcDptYOfjBS78yrQnCjv+UkKu3C5wXdCUSfUDgnZw8h7y6CMzDltSy3uSUnlX7D5y9Ns8LN5iixjJfLWBMl3CVe0iInZ1HqWGY8Z1jBode4QaM2fWcNtE3oERmFel6Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641385; c=relaxed/simple;
	bh=IV36qXYR1r6Yzg131vx3tGM/NHJrjbq6W7QxVFzIZKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In0affXT82sz2jJok51YEtsT2/XdVyLiScMA64uJvtEM7vMZEA7Tx7JWeJkqAEth1LoiihXShxagQRRhW9pj04WG6CqZDCdursN/jHiUYC75Ey2CAJ9ydZcNE7VkPpTfxudYzlcGkAtJ22wySz5cC02sZAPqSURpVZYQdXZyhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bHNjf5bxtzKHNPG;
	Wed, 11 Jun 2025 19:29:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 259831A1883;
	Wed, 11 Jun 2025 19:29:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacOXaElofvDPOw--.32023S9;
	Wed, 11 Jun 2025 19:29:40 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 5/6] ext4/jbd2: reintroduce jbd2_journal_blocks_per_page()
Date: Wed, 11 Jun 2025 19:16:24 +0800
Message-ID: <20250611111625.1668035-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacOXaElofvDPOw--.32023S9
X-Coremail-Antispam: 1UD129KBjvJXoWxCFW3uFW3ZFy8Gry7KrWDXFb_yoWrXry7pF
	ZrCFyrCr95uryDuFs7Wr4UZry2ga40kFWUWr9a9FnYqa9Fq34xtFnrtw1ayFy5trWDGa10
	vF45G3yDGw4Dt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUo73vUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

This partially reverts commit d6bf294773a4 ("ext4/jbd2: convert
jbd2_journal_blocks_per_page() to support large folio"). This
jbd2_journal_blocks_per_folio() will lead to a significant
overestimation of journal credits. Since we still reserve credits for
one page and attempt to extend and restart handles during large folio
writebacks, so we should convert this helper back to
ext4_journal_blocks_per_page().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4_jbd2.h  | 7 +++++++
 fs/ext4/inode.c      | 6 +++---
 fs/jbd2/journal.c    | 6 ++++++
 include/linux/jbd2.h | 1 +
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 63d17c5201b5..c0ee756cb34c 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -326,6 +326,13 @@ static inline int ext4_journal_blocks_per_folio(struct inode *inode)
 	return 0;
 }
 
+static inline int ext4_journal_blocks_per_page(struct inode *inode)
+{
+	if (EXT4_JOURNAL(inode) != NULL)
+		return jbd2_journal_blocks_per_page(inode);
+	return 0;
+}
+
 static inline int ext4_journal_force_commit(journal_t *journal)
 {
 	if (journal)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 67e37dd546eb..9835145b1b27 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2556,7 +2556,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
  */
 static int ext4_da_writepages_trans_blocks(struct inode *inode)
 {
-	int bpp = ext4_journal_blocks_per_folio(inode);
+	int bpp = ext4_journal_blocks_per_page(inode);
 
 	return ext4_meta_trans_blocks(inode,
 				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
@@ -2634,7 +2634,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	ext4_lblk_t lblk;
 	struct buffer_head *head;
 	handle_t *handle = NULL;
-	int bpp = ext4_journal_blocks_per_folio(mpd->inode);
+	int bpp = ext4_journal_blocks_per_page(mpd->inode);
 
 	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
 		tag = PAGECACHE_TAG_TOWRITE;
@@ -6255,7 +6255,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
  */
 int ext4_writepage_trans_blocks(struct inode *inode)
 {
-	int bpp = ext4_journal_blocks_per_folio(inode);
+	int bpp = ext4_journal_blocks_per_page(inode);
 	int ret;
 
 	ret = ext4_meta_trans_blocks(inode, bpp, bpp);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..7fccb425907f 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -84,6 +84,7 @@ EXPORT_SYMBOL(jbd2_journal_start_commit);
 EXPORT_SYMBOL(jbd2_journal_force_commit_nested);
 EXPORT_SYMBOL(jbd2_journal_wipe);
 EXPORT_SYMBOL(jbd2_journal_blocks_per_folio);
+EXPORT_SYMBOL(jbd2_journal_blocks_per_page);
 EXPORT_SYMBOL(jbd2_journal_invalidate_folio);
 EXPORT_SYMBOL(jbd2_journal_try_to_free_buffers);
 EXPORT_SYMBOL(jbd2_journal_force_commit);
@@ -2661,6 +2662,11 @@ int jbd2_journal_blocks_per_folio(struct inode *inode)
 		     inode->i_sb->s_blocksize_bits);
 }
 
+int jbd2_journal_blocks_per_page(struct inode *inode)
+{
+	return 1 << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
+}
+
 /*
  * helper functions to deal with 32 or 64bit block numbers.
  */
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 43b9297fe8a7..f35369c104ba 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1724,6 +1724,7 @@ static inline int tid_geq(tid_t x, tid_t y)
 }
 
 extern int jbd2_journal_blocks_per_folio(struct inode *inode);
+extern int jbd2_journal_blocks_per_page(struct inode *inode);
 extern size_t journal_tag_bytes(journal_t *journal);
 
 static inline int jbd2_journal_has_csum_v2or3(journal_t *journal)
-- 
2.46.1


