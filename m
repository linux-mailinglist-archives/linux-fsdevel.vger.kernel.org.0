Return-Path: <linux-fsdevel+bounces-35093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B20469D102E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D331B283F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A421A9B52;
	Mon, 18 Nov 2024 11:45:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6451993B7;
	Mon, 18 Nov 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731930322; cv=none; b=EVsOTQ1ac1L3qVnz9/XyrgKgCmWWrRlBBO7VGVODkj3ET0mbnvg982etaamGMCBRvNPN6JrVBlfqWqPOThDyvixWjM48G+2s8MrfahWQEwaYH2rLpRN87sS1jMTKuXdyckNLNXhw9eCP/rIWVVZ01GpzYgjBv5DJ1VyoT3umSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731930322; c=relaxed/simple;
	bh=tcEC9Qws+CAfgbzK3YhseY1iB07hGxl6Vnv/o2oi4YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cSfETIfG7OK1s0ZrwrWO7oevZF1OIZAG4qXXFDl+1nGegFR+X1qBmNmJU89wtbWHMmxd+xwlF4orT9krCK+330OTCXHwFVA6avg7FhL45TzfuEE3hALl3zaHuSxY8b8q+nxf6gOk/I/VMiiawmPWm4VzRTx92lHvCpCslnmMI5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XsQlv1G9fz4f3jY1;
	Mon, 18 Nov 2024 19:44:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 95A821A0194;
	Mon, 18 Nov 2024 19:45:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoLEKDtn3fCKCA--.48005S14;
	Mon, 18 Nov 2024 19:45:17 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	agruenba@redhat.com,
	gfs2@lists.linux.dev,
	amir73il@gmail.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Cc: yebin10@huawei.com,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 10/11] fs: fix hungtask due to repeated traversal of inodes list
Date: Mon, 18 Nov 2024 19:45:07 +0800
Message-Id: <20241118114508.1405494-11-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118114508.1405494-1-yebin@huaweicloud.com>
References: <20241118114508.1405494-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoLEKDtn3fCKCA--.48005S14
X-Coremail-Antispam: 1UD129KBjvJXoWxWF15Kr18WFWxJw1DtF1fWFg_yoWrKr1kpF
	y3tFW5Xw48Ca4qgr4rtr1rXryftayv9ws7JryfGr13u3WUG34aqF97JF13JF97GF47Za1a
	qF4DurW7Ar4kCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

There's a issue when remove scsi disk, the invalidate_inodes() function
cannot exit for a long time, then trigger hungtask:
INFO: task kworker/56:0:1391396 blocked for more than 122 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Workqueue: events_freezable virtscsi_handle_event [virtio_scsi]
Call Trace:
 __schedule+0x33c/0x7f0
 schedule+0x46/0xb0
 schedule_preempt_disabled+0xa/0x10
 __mutex_lock.constprop.0+0x22b/0x490
 mutex_lock+0x52/0x70
 scsi_scan_target+0x6d/0xf0
 virtscsi_handle_event+0x152/0x1a0 [virtio_scsi]
 process_one_work+0x1b2/0x350
 worker_thread+0x49/0x310
 kthread+0xfb/0x140
 ret_from_fork+0x1f/0x30

PID: 540499  TASK: ffff9b15e504c080  CPU: 44  COMMAND: "kworker/44:0"
Call trace:
 invalidate_inodes at ffffffff8f3b4784
 __invalidate_device at ffffffff8f3dfea3
 invalidate_partition at ffffffff8f526b49
 del_gendisk at ffffffff8f5280fb
 sd_remove at ffffffffc0186455 [sd_mod]
 __device_release_driver at ffffffff8f738ab2
 device_release_driver at ffffffff8f738bc4
 bus_remove_device at ffffffff8f737f66
 device_del at ffffffff8f73341b
 __scsi_remove_device at ffffffff8f780340
 scsi_remove_device at ffffffff8f7803a2
 virtscsi_handle_event at ffffffffc017204f [virtio_scsi]
 process_one_work at ffffffff8f1041f2
 worker_thread at ffffffff8f104789
 kthread at ffffffff8f109abb
 ret_from_fork at ffffffff8f001d6f

As commit 04646aebd30b ("fs: avoid softlockups in s_inodes iterators")
introduces the retry logic. In the problem environment, the 'i_count'
of millions of files is not zero. As a result, the time slice for each
traversal to the matching inode process is almost used up, and then the
traversal is started from scratch. The worst-case scenario is that only
one inode can be processed after each wakeup. Because this process holds
a lock, other processes will be stuck for a long time, causing a series
of problems.
To solve the problem of repeated traversal from the beginning, each time
the CPU needs to be freed, a cursor is inserted into the linked list, and
the traversal continues from the cursor next time.

Fixes: 04646aebd30b ("fs: avoid softlockups in s_inodes iterators")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/inode.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index dc966990bda6..b78895af8779 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -857,11 +857,16 @@ static void dispose_list(struct list_head *head)
 void evict_inodes(struct super_block *sb)
 {
 	struct inode *inode, *next;
+	struct inode cursor;
 	LIST_HEAD(dispose);
 
+	cursor.i_state = I_CURSOR;
+	INIT_LIST_HEAD(&cursor.i_sb_list);
+	inode = list_entry(&sb->s_inodes, typeof(*inode), i_sb_list);
+
 again:
 	spin_lock(&sb->s_inode_list_lock);
-	sb_for_each_inodes_safe(inode, next, &sb->s_inodes) {
+	sb_for_each_inodes_continue_safe(inode, next, &sb->s_inodes) {
 		if (atomic_read(&inode->i_count))
 			continue;
 
@@ -886,12 +891,16 @@ void evict_inodes(struct super_block *sb)
 		 * bit so we don't livelock.
 		 */
 		if (need_resched()) {
+			list_del(&cursor.i_sb_list);
+			list_add(&cursor.i_sb_list, &inode->i_sb_list);
+			inode = &cursor;
 			spin_unlock(&sb->s_inode_list_lock);
 			cond_resched();
 			dispose_list(&dispose);
 			goto again;
 		}
 	}
+	list_del(&cursor.i_sb_list);
 	spin_unlock(&sb->s_inode_list_lock);
 
 	dispose_list(&dispose);
@@ -907,11 +916,16 @@ EXPORT_SYMBOL_GPL(evict_inodes);
 void invalidate_inodes(struct super_block *sb)
 {
 	struct inode *inode, *next;
+	struct inode cursor;
 	LIST_HEAD(dispose);
 
+	cursor.i_state = I_CURSOR;
+	INIT_LIST_HEAD(&cursor.i_sb_list);
+	inode = list_entry(&sb->s_inodes, typeof(*inode), i_sb_list);
+
 again:
 	spin_lock(&sb->s_inode_list_lock);
-	sb_for_each_inodes_safe(inode, next, &sb->s_inodes) {
+	sb_for_each_inodes_continue_safe(inode, next, &sb->s_inodes) {
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
 			spin_unlock(&inode->i_lock);
@@ -927,12 +941,16 @@ void invalidate_inodes(struct super_block *sb)
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
 		if (need_resched()) {
+			list_del(&cursor.i_sb_list);
+			list_add(&cursor.i_sb_list, &inode->i_sb_list);
+			inode = &cursor;
 			spin_unlock(&sb->s_inode_list_lock);
 			cond_resched();
 			dispose_list(&dispose);
 			goto again;
 		}
 	}
+	list_del(&cursor.i_sb_list);
 	spin_unlock(&sb->s_inode_list_lock);
 
 	dispose_list(&dispose);
-- 
2.34.1


