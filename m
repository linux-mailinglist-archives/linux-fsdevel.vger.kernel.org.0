Return-Path: <linux-fsdevel+bounces-53518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C65EBAEFA56
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54D548579F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179E227934E;
	Tue,  1 Jul 2025 13:21:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68929277026;
	Tue,  1 Jul 2025 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376066; cv=none; b=SFHzlZoHQ27K+sOWqe93daQh6+sRYhoytFdivf8+7taTiW+BsoPa/hDvsPehm+Z/4aVTplKdB8R7UmsMR7vPIJOhDpnUqDGfe8D0X0IWFARJ2yOY56/N54LrVt4bzlKsBzD13fhnguqHP0EPyd03fWceksVkf8hXr0kpodhI2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376066; c=relaxed/simple;
	bh=HzQwYCnYv+cE7cxLCWkE45mPBh4oe+LIXmYno0y9hCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUcWOL+5eYT+2ls77z37smTacgaSpLnpKoesCdtZmkUoqzHZ1lmMQKfem4yX4cC+Bwsk7LDQclhsmxISzjASE7qpc2lsV6fk2n5PxhV6Vr4tsCMcQNZN7yLdqJSbGTeCdXWF9qRaTtCKkZR8ZUrOt77dYQM9LCK75cGXMu4JzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bWkDt2T3XzYQvPm;
	Tue,  1 Jul 2025 21:21:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 33A101A1347;
	Tue,  1 Jul 2025 21:21:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXeCWu4GNoXmJGAQ--.26904S12;
	Tue, 01 Jul 2025 21:21:00 +0800 (CST)
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
Subject: [PATCH v3 08/10] ext4: reserved credits for one extent during the folio writeback
Date: Tue,  1 Jul 2025 21:06:33 +0800
Message-ID: <20250701130635.4079595-9-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgAXeCWu4GNoXmJGAQ--.26904S12
X-Coremail-Antispam: 1UD129KBjvJXoWxZry5KryruFyDAFy7XrWUArb_yoW5Xw4xpr
	ZxCrWkWry7WFyUuFWxWa18ZF1fWa48CrWUJ39xKFn7Wa98Z34xKFn8KayY9FW5KrWxGa4j
	vF45C3s8Wa42ya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
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
---
 fs/ext4/inode.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3230734a3014..ceaede80d791 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2546,21 +2546,6 @@ static int mpage_map_and_submit_extent(handle_t *handle,
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
@@ -2917,8 +2902,14 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
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


