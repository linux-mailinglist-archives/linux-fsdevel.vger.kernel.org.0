Return-Path: <linux-fsdevel+bounces-12473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFCC85F8D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CE2286770
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4636C149002;
	Thu, 22 Feb 2024 12:51:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D1413959C;
	Thu, 22 Feb 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606305; cv=none; b=Bbu7CtQaO77Ur8hmefHWQltoJ/0PsBFxiQAH5ysl6cpVRpNY0pKF1rywRr2iOBH/cOrkIIX+ECrq51oqwlHRNgQkhOWzHK4Ga9oK1IuIzyrpQLThULo91PyaFXu5EkTOy2L6pP4SsS01VfNbCUeie10wOm6KZNAv1hbMbLd0rZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606305; c=relaxed/simple;
	bh=WhCMtRvTpjW+UTNlDKO2Ztj16Kba68pIXjBVhGY2t3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQrJ22WiY9QsR0Xur/JVEekZfjiAUgSlZ+1fxHA3dT4NhbJoVmjGkcXldhgov6N9rPBnDoZAFhrkS0YMCSusniKlGyL+7QckRz1V6neVtAyrYB4fgi+ApnAbCChu2KKR48B+7E04J7zRV8VUAP8w0UrP8DOnNXak5CqoOVSlIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TgY1K1wtfz4f3mHV;
	Thu, 22 Feb 2024 20:51:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6B2A71A0568;
	Thu, 22 Feb 2024 20:51:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFSQ9dlQ382Ew--.47909S22;
	Thu, 22 Feb 2024 20:51:40 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [RFC v4 linux-next 18/19] scsi: factor out a helper bdev_read_folio() from scsi_bios_ptable()
Date: Thu, 22 Feb 2024 20:45:54 +0800
Message-Id: <20240222124555.2049140-19-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFSQ9dlQ382Ew--.47909S22
X-Coremail-Antispam: 1UD129KBjvJXoWxur45Kr4xZryUZF18Ww17KFg_yoW5GFy8pF
	Z8Ga98ArW8GF17uw4DZwnrXw13K34Ikw17CayI93sIka9rtrWvgFyvya45AFy0krZ7JFsr
	XFy7AryF93WjkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

scsi_bios_ptable() is reading without opening disk as file, factor out
a helper to read into block device page cache to prevent access bd_inode
directly from scsi.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bdev.c           | 19 +++++++++++++++++++
 drivers/scsi/scsicam.c |  3 +--
 include/linux/blkdev.h |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 60a1479eae83..b7af04d34af2 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1211,6 +1211,25 @@ unsigned int block_size(struct block_device *bdev)
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
diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index e2c7d8ef205f..1c99b964a0eb 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -32,11 +32,10 @@
  */
 unsigned char *scsi_bios_ptable(struct block_device *dev)
 {
-	struct address_space *mapping = bdev_whole(dev)->bd_inode->i_mapping;
 	unsigned char *res = NULL;
 	struct folio *folio;
 
-	folio = read_mapping_folio(mapping, 0, NULL);
+	folio = bdev_read_folio(bdev_whole(dev), 0);
 	if (IS_ERR(folio))
 		return NULL;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c510f334c84f..3fb02e3a527a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1514,6 +1514,7 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);
+struct folio *bdev_read_folio(struct block_device *bdev, loff_t pos);
 
 /* just for blk-cgroup, don't use elsewhere */
 struct block_device *blkdev_get_no_open(dev_t dev);
-- 
2.39.2


