Return-Path: <linux-fsdevel+bounces-71934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D63FCD7BA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 02:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 486B331270C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B43D292918;
	Tue, 23 Dec 2025 01:22:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D08275B0F;
	Tue, 23 Dec 2025 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452934; cv=none; b=ZmnC07NqE/Nmq+0FQxeeA5SbL3ExbGiue/h4PXjUxhHVJPlgLYWUDoaDLOc/nxBEUNBlopWZrgQw6ohXhLpwxzo0upFT9lnKZOTDndYY3R4fc9eeVePzkU43bbxkFv/D3NzhkiK19vb3IyElE9VRb02fkOA0TGi77BSbU/04l9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452934; c=relaxed/simple;
	bh=enW0RG4rfCC1wkokoyc0WeEvlHsnAmgcMZsz1RaC6fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfniut31LVog0rRjcWgC9kxY7jG7FZBurq5u5sdjd8+TRHMuEdgKzDcRTaM8nSFvCyl4R5E7foRwBQZzI7OsOXebB54/TEcqOXBf+KERsAkHLGimjpvOmQwp1tAIg1o1zRZ8f9wcjVU/mK+gPrlu/JOu58pS9xylpj6Jct7VuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dZy0C5LDmzKHMKc;
	Tue, 23 Dec 2025 09:21:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4A44540577;
	Tue, 23 Dec 2025 09:22:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAHaPis7klpsgSaBA--.63035S4;
	Tue, 23 Dec 2025 09:22:05 +0800 (CST)
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
Subject: [PATCH v2] ext4: don't order data when zeroing unwritten or delayed block
Date: Tue, 23 Dec 2025 09:19:27 +0800
Message-ID: <20251223011927.34042-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHaPis7klpsgSaBA--.63035S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AryxAF13tFyxWFyfZF17GFg_yoW8WFWUpa
	sxK3W8Gr4kW34q9a97uF1xZryjka18WFWxGFWfG3yqv3y3JF1YvF9Fg3409a12yrW7Ga4Y
	qF4UW3409FnxA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When zeroing out a written partial block, it is necessary to order the
data to prevent exposing stale data on disk. However, if the buffer is
unwritten or delayed, it is not allocated as written, so ordering the
data is not required. This can prevent strange and unnecessary ordered
writes when appending data across a region within a block.

Assume we have a 2K unwritten file on a filesystem with 4K blocksize,
and buffered write from 3K to 4K. Before this patch,
__ext4_block_zero_page_range() would add the range [2k,3k) to the
ordered range, and then the JBD2 commit process would write back this
block. However, it does nothing since the block is not mapped as
written, this folio will be redirtied and written back agian through the
normal write back process.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2e79b09fe2f0..f2d70c9af446 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4109,9 +4109,13 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	if (ext4_should_journal_data(inode)) {
 		err = ext4_dirty_journalled_data(handle, bh);
 	} else {
-		err = 0;
 		mark_buffer_dirty(bh);
-		if (ext4_should_order_data(inode))
+		/*
+		 * Only the written block requires ordered data to prevent
+		 * exposing stale data.
+		 */
+		if (!buffer_unwritten(bh) && !buffer_delay(bh) &&
+		    ext4_should_order_data(inode))
 			err = ext4_jbd2_inode_add_write(handle, inode, from,
 					length);
 	}
-- 
2.52.0


