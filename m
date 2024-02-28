Return-Path: <linux-fsdevel+bounces-13030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0679D86A4EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 02:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6E71C22AE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 01:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0971D6A6;
	Wed, 28 Feb 2024 01:23:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32ECDDD7;
	Wed, 28 Feb 2024 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083395; cv=none; b=BtPNewxsQrcFjA4E9MpH49snJQSFcRfk7fEIVZ8Oe3LTHZ0zrWfn45T8tTCvy0JoavGnfAXOAOUDGG+WlviS6wR4TcsdqpxGiL2NvF5iDX+hDwtXUuTAxcppFqUAfVH/I9Xha1R+1QM3JKLEaFl4ysd8SD5/ibj2c4Z+9YiFjSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083395; c=relaxed/simple;
	bh=tnwjWLmdbreP655Xgb5OPUq8EXE9EbebF4RSySrntEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZixu8KFCFEJ5jROMtKxwGybEQ3qVV/J6nfTDNsulaJC5WTTrEd8jczBR2lkFANVG4NtEsRSHQ8hCOFQqlMyGbmFlcMi3M9GrKhxEcnOxJTDudhW5FHoN7iGSpqEuS+z3neqJJCvd+mufmKvDtbINqlCUb43NbdjGvtYN9bI2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TkxS82TBZz4f3jsq;
	Wed, 28 Feb 2024 09:23:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8CDA31A0572;
	Wed, 28 Feb 2024 09:23:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDX8gv7it5lqQx6FQ--.57137S3;
	Wed, 28 Feb 2024 09:23:09 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tim.c.chen@linux.intel.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] fs/writeback: avoid to writeback non-expired inode in kupdate writeback
Date: Wed, 28 Feb 2024 17:19:53 +0800
Message-Id: <20240228091958.288260-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240228091958.288260-1-shikemeng@huaweicloud.com>
References: <20240228091958.288260-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX8gv7it5lqQx6FQ--.57137S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4rJF1xuw4xXF4kJr4rGrg_yoWrCF1xpF
	WUGr15tr4qvFWxWrnaka429r13tay8AF47Jr1xWay2q3WjqFWUtFyUuFy2yr18Jr93WrWS
	qF4vvryxAr40yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsgyZUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

In kupdate writeback, only expired inode (have been dirty for longer than
dirty_expire_interval) is supposed to be written back. However, kupdate
writeback will writeback non-expired inode left in b_io or b_more_io from
last wb_writeback. As a result, writeback will keep being triggered
unexpected when we keep dirtying pages even dirty memory is under
threshold and inode is not expired. To be more specific:
Assume dirty background threshold is > 1G and dirty_expire_centisecs is
> 60s. When we running fio -size=1G -invalidate=0 -ioengine=libaio
--time_based -runtime=60... (keep dirtying), the writeback will keep
being triggered as following:
wb_workfn
  wb_do_writeback
    wb_check_background_flush
      /*
       * Wb dirty background threshold starts at 0 if device was idle and
       * grows up when bandwidth of wb is updated. So a background
       * writeback is triggered.
       */
      wb_over_bg_thresh
      /*
       * Dirtied inode will be written back and added to b_more_io list
       * after slice used up (because we keep dirtying the inode).
       */
      wb_writeback

Writeback is triggered per dirty_writeback_centisecs as following:
wb_workfn
  wb_do_writeback
    wb_check_old_data_flush
      /*
       * Write back inode left in b_io and b_more_io from last wb_writeback
       * even the inode is non-expired and it will be added to b_more_io
       * again as slice will be used up (because we keep dirtying the
       * inode)
       */
      wb_writeback

Fix this by moving non-expired inode to dirty list instead of more io
list for kupdate writeback in requeue_inode.

Test as following:
/* make it more easier to observe the issue */
echo 300000 > /proc/sys/vm/dirty_expire_centisecs
echo 100 > /proc/sys/vm/dirty_writeback_centisecs
/* create a idle device */
mkfs.ext4 -F /dev/vdb
mount /dev/vdb /bdi1/
/* run buffer write with fio */
fio -name test -filename=/bdi1/file -size=800M -ioengine=libaio -bs=4K \
-iodepth=1 -rw=write -direct=0 --time_based -runtime=60 -invalidate=0

Fio result before fix (run three tests):
1360MB/s
1329MB/s
1455MB/s

Fio result after fix (run three tests):
1737MB/s
1729MB/s
1789MB/s

Writeback for non-expired inode is gone as expeted. Observe this with trace
writeback_start and writeback_written as following:
echo 1 > /sys/kernel/debug/tracing/events/writeback/writeback_start/enab
echo 1 > /sys/kernel/debug/tracing/events/writeback/writeback_written/enable
cat /sys/kernel/tracing/trace_pipe

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/fs-writeback.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 5ab1aaf805f7..4e6166e07eaf 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1561,7 +1561,8 @@ static void inode_sleep_on_writeback(struct inode *inode)
  * thread's back can have unexpected consequences.
  */
 static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
-			  struct writeback_control *wbc)
+			  struct writeback_control *wbc,
+			  unsigned long dirtied_before)
 {
 	if (inode->i_state & I_FREEING)
 		return;
@@ -1594,7 +1595,8 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 		 * We didn't write back all the pages.  nfs_writepages()
 		 * sometimes bales out without doing anything.
 		 */
-		if (wbc->nr_to_write <= 0) {
+		if (wbc->nr_to_write <= 0 &&
+		    !inode_dirtied_after(inode, dirtied_before)) {
 			/* Slice used up. Queue for next turn. */
 			requeue_io(inode, wb);
 		} else {
@@ -1862,6 +1864,11 @@ static long writeback_sb_inodes(struct super_block *sb,
 	unsigned long start_time = jiffies;
 	long write_chunk;
 	long total_wrote = 0;  /* count both pages and inodes */
+	unsigned long dirtied_before = jiffies;
+
+	if (work->for_kupdate)
+		dirtied_before = jiffies -
+			msecs_to_jiffies(dirty_expire_interval * 10);
 
 	while (!list_empty(&wb->b_io)) {
 		struct inode *inode = wb_inode(wb->b_io.prev);
@@ -1967,7 +1974,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		spin_lock(&inode->i_lock);
 		if (!(inode->i_state & I_DIRTY_ALL))
 			total_wrote++;
-		requeue_inode(inode, tmp_wb, &wbc);
+		requeue_inode(inode, tmp_wb, &wbc, dirtied_before);
 		inode_sync_complete(inode);
 		spin_unlock(&inode->i_lock);
 
-- 
2.30.0


