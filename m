Return-Path: <linux-fsdevel+bounces-60734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1E4B50CD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 06:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D71463BDE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 04:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C072C2BD582;
	Wed, 10 Sep 2025 04:34:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6EF2BCF43;
	Wed, 10 Sep 2025 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757478889; cv=none; b=JVJmcKbV8eLC837gLwhE3iF6ziCSsGO4X+2qaW8PuVE3iTqLKSNzot+uDgnNkGphptwrQL/2UITZrX9ctnKI64+x3b67wNC486/zwGZ0pwAUSTm2kIvEU2+9l9WFqITH6I5x9F5+qdklkK54hRcTs3tAFKAFZ7NKkZ9oRT7Awn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757478889; c=relaxed/simple;
	bh=AFGyeqKpigoUto+uaLmTTOpZCzHn7rJEqsCULftoxUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ONOLZThlhmpr6i/BG5DSt6E/xrf3cbLZrbo99NKtn3+giWpqcmYsHE0UIwkloLY8nlgMSiwzeQ1uptJcQ9+OCkQzleESXrd9emF1HNldVhuJWxH0hoDu+6Fn4c7HNwbWwVKAPsuAPQqMWnZ2A1tcratE9LpDurx7eSh44x6A3lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cM7Bq0JLvzKHMqL;
	Wed, 10 Sep 2025 12:34:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3EA461A0FC9;
	Wed, 10 Sep 2025 12:34:43 +0800 (CST)
Received: from huawei.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIzf_8Boc5T_Bw--.31007S4;
	Wed, 10 Sep 2025 12:34:41 +0800 (CST)
From: Yongjian Sun <sunyongjian@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	jack@suse.cz,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	libaokun1@huawei.com,
	chengzhihao1@huawei.com,
	sunyongjian1@huawei.com
Subject: [PATCH v3] ext4: increase i_disksize to offset + len in ext4_update_disksize_before_punch()
Date: Wed, 10 Sep 2025 12:25:16 +0800
Message-Id: <20250910042516.3947590-1-sunyongjian@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Reply-To: sunyongjian1@huawei.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIzf_8Boc5T_Bw--.31007S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWDXr17KF45AFW8uw15Arb_yoW5Kw4Up3
	y5Gryktr4jg34rCws7W3Wjqw1jkay5ArWxGFy3Gr4Yv345Ww4IqF10qrya9a1DJrZ3Cr4j
	qFZ0qrsFva48ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 5vxq505qjmxt3q6k3tpzhluzxrxghudrp/

From: Yongjian Sun <sunyongjian1@huawei.com>

After running a stress test combined with fault injection,
we performed fsck -a followed by fsck -fn on the filesystem
image. During the second pass, fsck -fn reported:

Inode 131512, end of extent exceeds allowed value
	(logical block 405, physical block 1180540, len 2)

This inode was not in the orphan list. Analysis revealed the
following call chain that leads to the inconsistency:

                             ext4_da_write_end()
                              //does not update i_disksize
                             ext4_punch_hole()
                              //truncate folio, keep size
ext4_page_mkwrite()
 ext4_block_page_mkwrite()
  ext4_block_write_begin()
    ext4_get_block()
     //insert written extent without update i_disksize
journal commit
echo 1 > /sys/block/xxx/device/delete

da-write path updates i_size but does not update i_disksize. Then
ext4_punch_hole truncates the da-folio yet still leaves i_disksize
unchanged(in the ext4_update_disksize_before_punch function, the
condition offset + len < size is met). Then ext4_page_mkwrite sees
ext4_nonda_switch return 1 and takes the nodioread_nolock path, the
folio about to be written has just been punched out, and it’s offset
sits beyond the current i_disksize. This may result in a written
extent being inserted, but again does not update i_disksize. If the
journal gets committed and then the block device is yanked, we might
run into this. It should be noted that replacing ext4_punch_hole with
ext4_zero_range in the call sequence may also trigger this issue, as
neither will update i_disksize under these circumstances.

To fix this, we can modify ext4_update_disksize_before_punch to
increase i_disksize to min(offset + len) when both i_size and
(offset + len) are greater than i_disksize.

Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
---
Changes in v3:
- Add a condition to avoid increasing i_disksize and include some comments.
- Link to v2: https://lore.kernel.org/all/20250908063355.3149491-1-sunyongjian@huaweicloud.com/
Changes in v2:
- The modification of i_disksize should be moved into ext4_update_disksize_before_punch,
  rather than being done in ext4_page_mkwrite.
- Link to v1: https://lore.kernel.org/all/20250731140528.1554917-1-sunyongjian@huaweicloud.com/
---
 fs/ext4/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..3df03469d405 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4287,7 +4287,10 @@ int ext4_can_truncate(struct inode *inode)
  * We have to make sure i_disksize gets properly updated before we truncate
  * page cache due to hole punching or zero range. Otherwise i_disksize update
  * can get lost as it may have been postponed to submission of writeback but
- * that will never happen after we truncate page cache.
+ * 1) that will never happen after we truncate page cache to the end of i_size;
+ * 2) that will get deferred after we truncate page cache in i_size but beyond
+ *    i_disksize, another concurrent write page fault can allocate written
+ *    blocks in the range and lead to filesystem inconsistency.
  */
 int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 				      loff_t len)
@@ -4298,9 +4301,11 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	loff_t size = i_size_read(inode);
 
 	WARN_ON(!inode_is_locked(inode));
-	if (offset > size || offset + len < size)
+	if (offset > size)
 		return 0;
 
+	if (offset + len < size)
+		size = offset + len;
 	if (EXT4_I(inode)->i_disksize >= size)
 		return 0;
 
-- 
2.39.2


