Return-Path: <linux-fsdevel+bounces-54122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C94AFB5E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460283B7BE2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2682DC34E;
	Mon,  7 Jul 2025 14:23:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69072DA747;
	Mon,  7 Jul 2025 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898185; cv=none; b=frJ8PhMMGt41yAANzCMxsfYwyMDLkVG7o5G351+xUBuPVZW3T/JMV/DT7UfJnDAHpd6or6yW0LY7P54yYRbNbMW+g70blla7zhYjiguDIWtxbZdWScNprkG6bZLuEcDYfuHRBID0apZwqciFXhW4pYPxxuyEK3y7SRudWLCyMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898185; c=relaxed/simple;
	bh=R2asvLQhBdfY8dbrbq7YimBkMAdxaJcr/EZrATrWVw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilR+8GM62bPRaEWvOaSJZfYusqt9jr/frWOtvVKDsiX0F3s60nWRz37Q3HP8PZGQnq406ozmIpgzr6C/BvEyjdjlZ2ZKzBneLiFPKXZnbH99+QQPgM5W426METgcVRtoJoPMnyJgZgxaE9ji3NLM/AJgwMAIpBFhLi2OZsyJXzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bbRKd4gWkzKHMZR;
	Mon,  7 Jul 2025 22:23:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 1D58D1A0AE1;
	Mon,  7 Jul 2025 22:23:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgBnxyQ22GtoNazLAw--.46745S12;
	Mon, 07 Jul 2025 22:22:59 +0800 (CST)
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
Subject: [PATCH v4 08/11] ext4: reserved credits for one extent during the folio writeback
Date: Mon,  7 Jul 2025 22:08:11 +0800
Message-ID: <20250707140814.542883-9-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgBnxyQ22GtoNazLAw--.46745S12
X-Coremail-Antispam: 1UD129KBjvJXoWxZry5KryruFyDAFy7Cw1Dtrb_yoW5WryDpF
	W3CrWkWr17WFyUuF4xWa1xZF1fWa48C3yUJr9xKFn7Wa98Z34IgFn8KayY9FW5KrWxGa4j
	vF45C34Duay2yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

After ext4 supports large folios, reserving journal credits for one
maximum-ordered folio based on the worst case cenario during the
writeback process can easily exceed the maximum transaction credits.
Additionally, reserving journal credits for one page is also no
longer appropriate.

Currently, the folio writeback process can either extend the journal
credits or initiate a new transaction if the currently reserved journal
credits are insufficient. Therefore, it can be modified to reserve
credits for only one extent at the outset. In most cases involving
continuous mapping, these credits are generally adequate, and we may
only need to perform some basic credit expansion. However, in extreme
cases where the block size and folio size differ significantly, or when
the folios are sufficiently discontinuous, it may be necessary to
restart a new transaction and resubmit the folios.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3ed4bc6c02f8..d9d12529b7fc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2547,21 +2547,6 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 	return err;
 }
 
-/*
- * Calculate the total number of credits to reserve for one writepages
- * iteration. This is called from ext4_writepages(). We map an extent of
- * up to MAX_WRITEPAGES_EXTENT_LEN blocks and then we go on and finish mapping
- * the last partial page. So in total we can map MAX_WRITEPAGES_EXTENT_LEN +
- * bpp - 1 blocks in bpp different extents.
- */
-static int ext4_da_writepages_trans_blocks(struct inode *inode)
-{
-	int bpp = ext4_journal_blocks_per_folio(inode);
-
-	return ext4_meta_trans_blocks(inode,
-				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
-}
-
 static int ext4_journal_folio_buffers(handle_t *handle, struct folio *folio,
 				     size_t len)
 {
@@ -2918,8 +2903,14 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		 * not supported by delalloc.
 		 */
 		BUG_ON(ext4_should_journal_data(inode));
-		needed_blocks = ext4_da_writepages_trans_blocks(inode);
-
+		/*
+		 * Calculate the number of credits needed to reserve for one
+		 * extent of up to MAX_WRITEPAGES_EXTENT_LEN blocks. It will
+		 * attempt to extend the transaction or start a new iteration
+		 * if the reserved credits are insufficient.
+		 */
+		needed_blocks = ext4_chunk_trans_blocks(inode,
+						MAX_WRITEPAGES_EXTENT_LEN);
 		/* start a new transaction */
 		handle = ext4_journal_start_with_reserve(inode,
 				EXT4_HT_WRITE_PAGE, needed_blocks, rsv_blocks);
-- 
2.46.1


