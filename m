Return-Path: <linux-fsdevel+bounces-10750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E590D84DCCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1EE28299B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40456F507;
	Thu,  8 Feb 2024 09:23:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106956EB61;
	Thu,  8 Feb 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384193; cv=none; b=Yc8EpRz+NvRC5G4lDmNLVbNK1yCuPI27H1r/V55XeYqy0HMxFOf/6kxqYvF0ibPVPP+rG+ouIGppVAn25HT1GHekTPPmJwgTou9OpjYZyw2dnlrmk73C0rqtS//WS4tg8O+tan6+O7qYBXEktPB3bccMBSXah3cPhKvlM0WuUIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384193; c=relaxed/simple;
	bh=IRBmSe+WJDODnV0rMri69fdXUTnMB3uoZQW0SYzVzPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XbAD24y9jIAvfYUDABHdhNasr+PLedsgue2ENXlCas121PByEKavymKc6Q8wT0biFrIyB2WlH41ayQ+tsD2EkKdqs0Vbv6plivd+ArqtPeBYkCOOMSka9MwHEjxgMnJli/4tmYHHQycDVLRDRkcU7qQNCjS1RYSg2vsaGTNZDzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TVs380PM2z4f3mHQ;
	Thu,  8 Feb 2024 17:23:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C96031A027B;
	Thu,  8 Feb 2024 17:23:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgAnSQx4ncRl3tGXDQ--.8574S3;
	Thu, 08 Feb 2024 17:23:06 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] fs/writeback: avoid to writeback non-expired inode in kupdate writeback
Date: Fri,  9 Feb 2024 01:20:18 +0800
Message-Id: <20240208172024.23625-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240208172024.23625-1-shikemeng@huaweicloud.com>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnSQx4ncRl3tGXDQ--.8574S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4rJF1xuw4xXF4kJr4rGrg_yoW5uw1DpF
	W5Gr15Jr4qva4xWrn3Aa429r15t3yrJF47JryfWay2q3W7XFW0gFy8WFy0yF48Jry3XrZa
	qF4FyryxCr40kaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0a0PDUUUUU==
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

Fix this by moving non-expired inode in io list from last wb_writeback to
dirty list in kudpate writeback.

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

Result before fix (run three tests):
1360MB/s
1329MB/s
1455MB/s

Result after fix (run three tests);
790MB/s
1820MB/s
1804MB/s

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/fs-writeback.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 5ab1aaf805f7..a9a918972719 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2046,6 +2046,23 @@ static long writeback_inodes_wb(struct bdi_writeback *wb, long nr_pages,
 	return nr_pages - work.nr_pages;
 }
 
+static void filter_expired_io(struct bdi_writeback *wb)
+{
+	struct inode *inode, *tmp;
+	unsigned long expired_jiffies = jiffies -
+		msecs_to_jiffies(dirty_expire_interval * 10);
+
+	spin_lock(&wb->list_lock);
+	list_for_each_entry_safe(inode, tmp, &wb->b_io, i_io_list)
+		if (inode_dirtied_after(inode, expired_jiffies))
+			redirty_tail(inode, wb);
+
+	list_for_each_entry_safe(inode, tmp, &wb->b_more_io, i_io_list)
+		if (inode_dirtied_after(inode, expired_jiffies))
+			redirty_tail(inode, wb);
+	spin_unlock(&wb->list_lock);
+}
+
 /*
  * Explicit flushing or periodic writeback of "old" data.
  *
@@ -2070,6 +2087,9 @@ static long wb_writeback(struct bdi_writeback *wb,
 	long progress;
 	struct blk_plug plug;
 
+	if (work->for_kupdate)
+		filter_expired_io(wb);
+
 	blk_start_plug(&plug);
 	for (;;) {
 		/*
-- 
2.30.0


