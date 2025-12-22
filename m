Return-Path: <linux-fsdevel+bounces-71812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E6CD4837
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 02:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80B80300B82C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 01:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2446F2D6607;
	Mon, 22 Dec 2025 01:34:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7332609C5;
	Mon, 22 Dec 2025 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766367262; cv=none; b=ewxSUsmbSP+WU6ZFykxfdEVteMphMPpAOj03CH2NqWjktLaTntr4+F1a/D5PIO93yx8PFAmcx0YQJr1dYyvEekXK8M2oHMYXF65+feBXflgnZumAj4q4u+tkLefCZ+3DmFpIsYg/GfI7b1Lxdc89tet2avT/y2TemQmitQk0NrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766367262; c=relaxed/simple;
	bh=GuDumnQGfwX+UPtwB319+YbaIfObOU6wVLTzokhKWh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxbhrIBACNd/PueiW9NvrNqhLKKnusX0zhNb29dUaG3lh1s6catTyuPMAOZ/hloilooJ5h66QtSNQNS2PvH0+kZ7yu3d9/ojOAzb7/lBwpcUfXfbRVC/BAujTvSzCZNVtt76sFH43PN6udedSd5VJDnKJdrZrBLCtNHiyArnyok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dZLJX3GDMzKHLx4;
	Mon, 22 Dec 2025 09:33:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7B4A140562;
	Mon, 22 Dec 2025 09:34:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgAXd_cDoEhp4rgkBA--.37336S4;
	Mon, 22 Dec 2025 09:34:04 +0800 (CST)
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
Subject: [PATCH] ext4: don't order data when zeroing unwritten or delayed block
Date: Mon, 22 Dec 2025 09:31:36 +0800
Message-ID: <20251222013136.2658907-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXd_cDoEhp4rgkBA--.37336S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AryxAF13tFyfAF1fuF43trb_yoW8WryDpa
	sxK3W8Gr4kG34q9a93uF1xZr1jka18WFW8GFWfG3yDZ3y3JF129F9rKry09a17trW7Ja4Y
	qF4UW3409FnxA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoWlkDUUUU
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
block. However, it does nothing since the block is not mapped, this
folio will be redirtied and written back agian through the normal write
back process.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fa579e857baf..fc16a89903b9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4104,9 +4104,13 @@ static int __ext4_block_zero_page_range(handle_t *handle,
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


