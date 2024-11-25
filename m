Return-Path: <linux-fsdevel+bounces-35783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA799D84BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B83B28563B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37AE1AE01E;
	Mon, 25 Nov 2024 11:46:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C0199920;
	Mon, 25 Nov 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535195; cv=none; b=QGxw0ldcfbQOE1rnGVG3k9aZLrTx0Jq/eF/RHmU1uvDan0hIMxc0u4IAhybRS97r3Nuk6uj2yQ0zSh+Q4vvdeQTZG6CCply1UP1h9vYkrbaDQaWrxYz6z3tJHEhCvXtj8dRY2tjymJhzqsHK3IezhK+0/jSmjgQ4q6RZY/QiF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535195; c=relaxed/simple;
	bh=k95u1rOfck9eBEYgj7sOPjTligZqXVqqiOiT22V5WD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ra07LMJcjc+TZ5qM1nYwlqEGHWJUIRR4GpoTGYvtzmv21TGgn7xoDqD51NsVAhMdpFnmaSj3z1mIiog2vW0ovIkyXkbTIw0xLhcHh/zk3QCPXTsAuzNOSPGTGVua+oNU4cQZf8ssJfOCIej3QIGwpDMcuzc9/uokYCXyPhLDv90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XxkS30FB0z4f3jXJ;
	Mon, 25 Nov 2024 19:46:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B4CB21A0568;
	Mon, 25 Nov 2024 19:46:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4eFY0RnNicrCw--.44046S9;
	Mon, 25 Nov 2024 19:46:29 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	brauner@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 5/9] ext4/jbd2: convert jbd2_journal_blocks_per_page() to support large folio
Date: Mon, 25 Nov 2024 19:44:15 +0800
Message-ID: <20241125114419.903270-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241125114419.903270-1-yi.zhang@huaweicloud.com>
References: <20241125114419.903270-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHY4eFY0RnNicrCw--.44046S9
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4fJw17XFyDZrykAFyDGFg_yoWrWry3pF
	WDCFyrCry8uFyDuFn2grsrZry29a4jkFWUWr9a9FnYqa9Fq34xtF1Dt3WayFyUtrWDGa10
	vF45G3yDG3WUt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUriihUUUUU
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
index 0c77697d5e90..59df14547d26 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -403,10 +403,10 @@ static inline int ext4_journal_ensure_credits(handle_t *handle, int credits,
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
index 38d33569c26e..e7b485b0f81b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2346,7 +2346,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
  */
 static int ext4_da_writepages_trans_blocks(struct inode *inode)
 {
-	int bpp = ext4_journal_blocks_per_page(inode);
+	int bpp = ext4_journal_blocks_per_folio(inode);
 
 	return ext4_meta_trans_blocks(inode,
 				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
@@ -2424,7 +2424,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	ext4_lblk_t lblk;
 	struct buffer_head *head;
 	handle_t *handle = NULL;
-	int bpp = ext4_journal_blocks_per_page(mpd->inode);
+	int bpp = ext4_journal_blocks_per_folio(mpd->inode);
 
 	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
 		tag = PAGECACHE_TAG_TOWRITE;
@@ -5715,7 +5715,7 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
  */
 int ext4_writepage_trans_blocks(struct inode *inode)
 {
-	int bpp = ext4_journal_blocks_per_page(inode);
+	int bpp = ext4_journal_blocks_per_folio(inode);
 	int ret;
 
 	ret = ext4_meta_trans_blocks(inode, bpp, bpp);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 97f487c3d8fc..a0b8662bc5d7 100644
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
@@ -2680,9 +2680,10 @@ void jbd2_journal_ack_err(journal_t *journal)
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
index 8aef9bb6ad57..591f93ef7851 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1740,7 +1740,7 @@ static inline int tid_geq(tid_t x, tid_t y)
 	return (difference >= 0);
 }
 
-extern int jbd2_journal_blocks_per_page(struct inode *inode);
+extern int jbd2_journal_blocks_per_folio(struct inode *inode);
 extern size_t journal_tag_bytes(journal_t *journal);
 
 static inline bool jbd2_journal_has_csum_v2or3_feature(journal_t *j)
-- 
2.46.1


