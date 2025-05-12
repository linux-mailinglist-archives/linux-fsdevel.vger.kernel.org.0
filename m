Return-Path: <linux-fsdevel+bounces-48698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B6AB2FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122D5179995
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 06:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B572580D5;
	Mon, 12 May 2025 06:44:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B27255F47;
	Mon, 12 May 2025 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747032296; cv=none; b=eluvpBOpXau3aI91xcxVH2khMJxCbTsR24IDmhNU9lrNUeKhDLQHvWjKKoRldeghQnQsWxWhbIqAio1rJtbuDu3h/AVo/tqhCsOUnDtQWFZnfK8PYHTQu7M/rdoX+Es9QIOCi9cy9GihG6QPCrR851SiOYBLcYG3nAftNTBJqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747032296; c=relaxed/simple;
	bh=TGqgcMl1R6pgeQfzt4WjqC7KVxHhDp7rrnLDLH77Ly4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHxCqFrLA8MA9JMrK1i94jQtueqhFZpG8eMcLQh3SUkwotvtBeoCMcrac/Gm8XMNgJMl2OrVuDFwszR21860XXYIiiRsQOTh0/1psFDFh2rnxL98vioabmAjnFUnD0SZTulHufqn7d5CJ5Pxefi5Et2lzSJrwsFxifh0O+JovO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZwqpQ73t6z4f3jtJ;
	Mon, 12 May 2025 14:44:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 725881A07BB;
	Mon, 12 May 2025 14:44:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2DXmCFoxF6sMA--.62010S8;
	Mon, 12 May 2025 14:44:50 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 4/8] ext4/jbd2: convert jbd2_journal_blocks_per_page() to support large folio
Date: Mon, 12 May 2025 14:33:15 +0800
Message-ID: <20250512063319.3539411-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHK2DXmCFoxF6sMA--.62010S8
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4fJw17XFWxJrykKr4rZrb_yoWrWryrpF
	WDCFy8Cry8uFyDuFs7Wr4UZry29a4jkFWUWr9I9FnYqa9Fq34xtF1Dt3W3AFyYy3yDGa10
	vF15G3yDGa1Ut3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
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

jbd2_journal_blocks_per_page() returns the number of blocks in a single
page. Rename it to jbd2_journal_blocks_per_folio() and make it returns
the number of blocks in the largest folio, preparing for the calculation
of journal credits blocks when allocating blocks within a large folio in
the writeback path.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4_jbd2.h  | 4 ++--
 fs/ext4/inode.c      | 6 +++---
 fs/jbd2/journal.c    | 7 ++++---
 include/linux/jbd2.h | 2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 3221714d9901..63d17c5201b5 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -319,10 +319,10 @@ static inline int ext4_journal_ensure_credits(handle_t *handle, int credits,
 				revoke_creds, 0);
 }
 
-static inline int ext4_journal_blocks_per_page(struct inode *inode)
+static inline int ext4_journal_blocks_per_folio(struct inode *inode)
 {
 	if (EXT4_JOURNAL(inode) != NULL)
-		return jbd2_journal_blocks_per_page(inode);
+		return jbd2_journal_blocks_per_folio(inode);
 	return 0;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 573ae0b3be1d..ffbf444b56d4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2361,7 +2361,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
  */
 static int ext4_da_writepages_trans_blocks(struct inode *inode)
 {
-	int bpp = ext4_journal_blocks_per_page(inode);
+	int bpp = ext4_journal_blocks_per_folio(inode);
 
 	return ext4_meta_trans_blocks(inode,
 				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
@@ -2439,7 +2439,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	ext4_lblk_t lblk;
 	struct buffer_head *head;
 	handle_t *handle = NULL;
-	int bpp = ext4_journal_blocks_per_page(mpd->inode);
+	int bpp = ext4_journal_blocks_per_folio(mpd->inode);
 
 	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
 		tag = PAGECACHE_TAG_TOWRITE;
@@ -5831,7 +5831,7 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
  */
 int ext4_writepage_trans_blocks(struct inode *inode)
 {
-	int bpp = ext4_journal_blocks_per_page(inode);
+	int bpp = ext4_journal_blocks_per_folio(inode);
 	int ret;
 
 	ret = ext4_meta_trans_blocks(inode, bpp, bpp);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 743a1d7633cd..ecf31af7d2fb 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -83,7 +83,7 @@ EXPORT_SYMBOL(jbd2_log_wait_commit);
 EXPORT_SYMBOL(jbd2_journal_start_commit);
 EXPORT_SYMBOL(jbd2_journal_force_commit_nested);
 EXPORT_SYMBOL(jbd2_journal_wipe);
-EXPORT_SYMBOL(jbd2_journal_blocks_per_page);
+EXPORT_SYMBOL(jbd2_journal_blocks_per_folio);
 EXPORT_SYMBOL(jbd2_journal_invalidate_folio);
 EXPORT_SYMBOL(jbd2_journal_try_to_free_buffers);
 EXPORT_SYMBOL(jbd2_journal_force_commit);
@@ -2657,9 +2657,10 @@ void jbd2_journal_ack_err(journal_t *journal)
 	write_unlock(&journal->j_state_lock);
 }
 
-int jbd2_journal_blocks_per_page(struct inode *inode)
+int jbd2_journal_blocks_per_folio(struct inode *inode)
 {
-	return 1 << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
+	return 1 << (PAGE_SHIFT + mapping_max_folio_order(inode->i_mapping) -
+		     inode->i_sb->s_blocksize_bits);
 }
 
 /*
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 023e8abdb99a..ebbcdab474d5 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1723,7 +1723,7 @@ static inline int tid_geq(tid_t x, tid_t y)
 	return (difference >= 0);
 }
 
-extern int jbd2_journal_blocks_per_page(struct inode *inode);
+extern int jbd2_journal_blocks_per_folio(struct inode *inode);
 extern size_t journal_tag_bytes(journal_t *journal);
 
 static inline int jbd2_journal_has_csum_v2or3(journal_t *journal)
-- 
2.46.1


