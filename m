Return-Path: <linux-fsdevel+bounces-31564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF4F9987CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1881C20F1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C300D1CB332;
	Thu, 10 Oct 2024 13:35:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C51C3F34;
	Thu, 10 Oct 2024 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567347; cv=none; b=niI+tup7fuWo4BTQPHwf12LGamCq0UhafonDW7/fKSN+K67BzBB9S5NBKGjw4durcAv5ydcfyqxArLyaAWAK6nF4cSNAfkRyk4D8tzUM2OIwTmyTP4rSaE0GjH+vtoP7F8PbElxbzOPnOF9EP2oIKvtchKgR+A/6jsLDLD5lNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567347; c=relaxed/simple;
	bh=MxLOjZGAOSC9szCGPQl/dXlDGFC5Y8rm8OWUupTbMK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srNcCrKEOW45bLuMNfEDxzfM0PxYISk6B/EnX5uly26sscWV5VPKEU8iaXFI722yZxC20JMVr1QqyJmWuB3NQFzEVeMax0ft+GrdnTjhpUj51sBCTYp1aetlAl05puPW5ls1yoGBDw8ri376rdI2bfqLL/h4vfV8XwxaSyxNgcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XPW3Q13fqz4f3k6h;
	Thu, 10 Oct 2024 21:35:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E9BD31A0359;
	Thu, 10 Oct 2024 21:35:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYc2AdnDRnZDg--.21356S7;
	Thu, 10 Oct 2024 21:35:41 +0800 (CST)
From: Zhang Yi <yi.zhang@huawei.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 03/10] ext4: don't write back data before punch hole in nojournal mode
Date: Thu, 10 Oct 2024 21:33:26 +0800
Message-Id: <20241010133333.146793-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241010133333.146793-1-yi.zhang@huawei.com>
References: <20241010133333.146793-1-yi.zhang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYc2AdnDRnZDg--.21356S7
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1DWr4UAry8Kr1rCF13twb_yoW8Cw1kpr
	9IkrW5tF48WFZFkr4SqFsrXF1FgaykCrW8WFyxG3s7WayUAwn7KF4q9F18Ga1UtrZxArWj
	qF40qa4xWFyUZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k2
	0xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAEfOUUUUU=
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

There is no need to write back all data before punching a hole in
data=ordered|writeback mode since it will be dropped soon after removing
space, so just remove the filemap_write_and_wait_range() in these modes.
However, in data=journal mode, we need to write dirty pages out before
discarding page cache in case of crash before committing the freeing
data transaction, which could expose old, stale data.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f8796f7b0f94..94b923afcd9c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3965,17 +3965,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	trace_ext4_punch_hole(inode, offset, length, 0);
 
-	/*
-	 * Write out all dirty pages to avoid race conditions
-	 * Then release them.
-	 */
-	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
-		ret = filemap_write_and_wait_range(mapping, offset,
-						   offset + length - 1);
-		if (ret)
-			return ret;
-	}
-
 	inode_lock(inode);
 
 	/* No need to punch hole beyond i_size */
@@ -4037,6 +4026,21 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		ret = ext4_update_disksize_before_punch(inode, offset, length);
 		if (ret)
 			goto out_dio;
+
+		/*
+		 * For journalled data we need to write (and checkpoint) pages
+		 * before discarding page cache to avoid inconsitent data on
+		 * disk in case of crash before punching trans is committed.
+		 */
+		if (ext4_should_journal_data(inode)) {
+			ret = filemap_write_and_wait_range(mapping,
+					first_block_offset, last_block_offset);
+			if (ret)
+				goto out_dio;
+		}
+
+		ext4_truncate_folios_range(inode, first_block_offset,
+					   last_block_offset + 1);
 		truncate_pagecache_range(inode, first_block_offset,
 					 last_block_offset);
 	}
-- 
2.39.2


