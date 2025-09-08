Return-Path: <linux-fsdevel+bounces-60477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D840B4845D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 08:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23763B953C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 06:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30900295516;
	Mon,  8 Sep 2025 06:43:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076A747F;
	Mon,  8 Sep 2025 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313799; cv=none; b=ddUqeQ1ZIbAv1qG7FglxqlbvyjmA5zqf+vwsZrYP0VNzOJz/Iy4ZAjE9bKJCtogBgGqMxMTQzZ7tg5/iUIx0pYZNBhHhtItaT+31poNaWowzHEOdlXWO50twjON1PibcJDT9gjOQPpSHbI5wFBb1NRqZ2A+YNj4Lkc5sv1QNELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313799; c=relaxed/simple;
	bh=/qSYSYnFxHlJfea2zb5qWOLs5xRN1kznMvoOm0/aMFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=vBMHuE3nuWb7ZuZ+gVbGSd9y1voq5VVJYUsozPNX7x13Twjxq3zznIKZwCoXcfP/Gw0LdtQhQRrosStlvN4eE26nWqY74gJ7f2BjbONSRU1ynayD1qr3Mhc4dxwzfhOZU+rA8hV0AZweu/HKqa1SBVAtlHgUjICqieLlocAebms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cKy820YBFzKHMws;
	Mon,  8 Sep 2025 14:43:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2BFC81A0E70;
	Mon,  8 Sep 2025 14:43:14 +0800 (CST)
Received: from huawei.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIz_er5oN9skBw--.41935S4;
	Mon, 08 Sep 2025 14:43:12 +0800 (CST)
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
Subject: [PATCH v2] ext4: increase i_disksize to offset + len in ext4_update_disksize_before_punch()
Date: Mon,  8 Sep 2025 14:33:55 +0800
Message-Id: <20250908063355.3149491-1-sunyongjian@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgAncIz_er5oN9skBw--.41935S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWDXr17KF45AFW8uw15Arb_yoW5AF1xp3
	45KFyUtwnYga4kuan5Wr4jgrWjyay5Gr47WFW7Gr4YqrW5Xw4IqFy8t34S9a1kJrs5uF4q
	vr4YqrsrZ348C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
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

To fix this, we can modify ext4_update_disksize_before_punch to always
increase i_disksize to offset + len.

Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
---
Changes in v2:
- The modification of i_disksize should be moved into ext4_update_disksize_before_punch,
  rather than being done in ext4_page_mkwrite.
- Link to v1: https://lore.kernel.org/all/20250731140528.1554917-1-sunyongjian@huaweicloud.com/
---
 fs/ext4/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..2b1ed729a0f0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4298,7 +4298,7 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	loff_t size = i_size_read(inode);
 
 	WARN_ON(!inode_is_locked(inode));
-	if (offset > size || offset + len < size)
+	if (offset > size)
 		return 0;
 
 	if (EXT4_I(inode)->i_disksize >= size)
@@ -4307,7 +4307,7 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	handle = ext4_journal_start(inode, EXT4_HT_MISC, 1);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
-	ext4_update_i_disksize(inode, size);
+	ext4_update_i_disksize(inode, min_t(loff_t, size, offset + len));
 	ret = ext4_mark_inode_dirty(handle, inode);
 	ext4_journal_stop(handle);
 
-- 
2.39.2


