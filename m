Return-Path: <linux-fsdevel+bounces-16270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A13489A9E3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0663283449
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCBC2C690;
	Sat,  6 Apr 2024 09:17:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E54225CF;
	Sat,  6 Apr 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395069; cv=none; b=cmK+oZVeAJ+hKzt4sJW/jXiH1pQHJNM0mm7oNsoCcH4DeNYNcHbBk9G1d+JS29mpA8Kof/DGLXveRsU8PO6EWx30xI5UBmQKU9PETHN2f52j+C5LU955nt9EIHJOyE9o6ryVsblyYyKC3+p+DDj7SrgQURNtPiXUU3VutCT2p9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395069; c=relaxed/simple;
	bh=cqaJwJ89c1NnHHCX2IeUwDZs+ZSvdbogTUh2DBgyGXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hWf+6Hk9hzNpivq29ndyo8HHDq7TIO3RK//9r95RuuZ2wig516ErSTw230tAXCC8GPsa7LCwAK8CVsd+1XqQs/rhb/bhDToVcuYVkyxwiwrJonQCC07HaOuW4YkobBWNAzhFKN0KvL5EPL27/xp1iYGYwp0TmtpKF9st4AF7n2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVBC6wzqz4f3k69;
	Sat,  6 Apr 2024 17:17:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4A5D51A0BF8;
	Sat,  6 Apr 2024 17:17:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S9;
	Sat, 06 Apr 2024 17:17:44 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH vfs.all 05/26] block: add a helper bdev_read_folio()
Date: Sat,  6 Apr 2024 17:09:09 +0800
Message-Id: <20240406090930.2252838-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr17XF1UXFWfKrW5Wr1xKrg_yoW8uFW3pF
	9rGay5CrW8GFnrWF47Z3W7Xw1fK3y0kw1fCFWa9r1SkrWUtrZ7uFyvyr1UAryjkws7JF4v
	qFy7ury0gryjkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently scsi driver is reading without opening disk as file(
scsi_bios_ptable()), factor out a helper to read into block device page
cache to prevent access bd_inode directly from scsi.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c           | 19 +++++++++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index c0b30392563a..4335df6d1266 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1266,6 +1266,25 @@ unsigned int block_size(struct block_device *bdev)
 }
 EXPORT_SYMBOL_GPL(block_size);
 
+/**
+ * bdev_read_folio - Read into block device page cache.
+ * @bdev: the block device which holds the cache to read.
+ * @pos: the offset that allocated folio will contain.
+ *
+ * Read one page into the block device page cache. If it succeeds, the folio
+ * returned will contain @pos;
+ *
+ * This is only used for scsi_bios_ptable(), the bdev is not opened as files.
+ *
+ * Return: Uptodate folio on success, ERR_PTR() on failure.
+ */
+struct folio *bdev_read_folio(struct block_device *bdev, loff_t pos)
+{
+	return mapping_read_folio_gfp(bdev_mapping(bdev),
+				      pos >> PAGE_SHIFT, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(bdev_read_folio);
+
 static int __init setup_bdev_allow_write_mounted(char *str)
 {
 	if (kstrtobool(str, &bdev_allow_write_mounted))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 08d4e6a0940c..bc840e0fb6e5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1519,6 +1519,7 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
+struct folio *bdev_read_folio(struct block_device *bdev, loff_t pos);
 
 /* just for blk-cgroup, don't use elsewhere */
 struct block_device *blkdev_get_no_open(dev_t dev);
-- 
2.39.2


