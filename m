Return-Path: <linux-fsdevel+bounces-50146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF551AC884F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 08:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30324A669C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 06:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A225213E65;
	Fri, 30 May 2025 06:41:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640941FF603;
	Fri, 30 May 2025 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748587295; cv=none; b=E6qYQ96RXcNRpVMB6Ps1v5RgMCo6rg9ZDrUBKGWOlxh/jQIZYWsg11Olrqz+QVBre7y30OLitbWX95JIDcvxFk/5IRkXsOheyPK/feTt2GvMbCfAnC8db4+QL/u4/JQ3bXet5UPF2qhMnScjU3b8AIYGfoRNO5B/tzmP0oO9U48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748587295; c=relaxed/simple;
	bh=31pg3NfsTdoDbfbC0W3wpIDc4mZQaJdYYDqYgSQlYt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrkcBENA+vA3HdcyX0Vnu6a21RX2Vr3SvaMzTBjxIbRyEN1ZS39yrfpKLpngtr0XG7GJ/YqqoHfX43KRBJ0dc4gOMWEKk2BndsPLri+Tkf32m6Lza+Fy3RHIsEjbV0P3Z+7Jl4H0qGBoGY9Qo7s8LtLW1K+k01N+YtzAopy6kQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b7ttg61XSzYQtH1;
	Fri, 30 May 2025 14:41:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E6A4F1A1349;
	Fri, 30 May 2025 14:41:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl8PUzlo_wXRNw--.6893S7;
	Fri, 30 May 2025 14:41:30 +0800 (CST)
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
Subject: [PATCH 3/5] ext4/jbd2: reintroduce jbd2_journal_blocks_per_page()
Date: Fri, 30 May 2025 14:28:56 +0800
Message-ID: <20250530062858.458039-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
References: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl8PUzlo_wXRNw--.6893S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCFW3uFW3ZFy8Gry7KrWDXFb_yoWrXry7pF
	ZrCFyrCr95uFyDuFs7Wr4DZryagay0kFWUWr9a9FnYqa9Fq3s7tFnrtw1ayFy5trWDGa10
	vF45G3yDGw1Dt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUHWlkUUUUU=
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
index d35c07c1dcac..1818a2a7ba8f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2516,7 +2516,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
  */
 static int ext4_da_writepages_trans_blocks(struct inode *inode)
 {
-	int bpp = ext4_journal_blocks_per_folio(inode);
+	int bpp = ext4_journal_blocks_per_page(inode);
 
 	return ext4_meta_trans_blocks(inode,
 				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
@@ -2594,7 +2594,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	ext4_lblk_t lblk;
 	struct buffer_head *head;
 	handle_t *handle = NULL;
-	int bpp = ext4_journal_blocks_per_folio(mpd->inode);
+	int bpp = ext4_journal_blocks_per_page(mpd->inode);
 
 	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
 		tag = PAGECACHE_TAG_TOWRITE;
@@ -6221,7 +6221,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
  */
 int ext4_writepage_trans_blocks(struct inode *inode)
 {
-	int bpp = ext4_journal_blocks_per_folio(inode);
+	int bpp = ext4_journal_blocks_per_page(inode);
 	int ret;
 
 	ret = ext4_meta_trans_blocks(inode, bpp, bpp);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 6d5e76848733..2d8e9053c3cf 100644
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


