Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F47D5E62DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 14:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiIVMxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 08:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiIVMx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:53:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E99E8D98;
        Thu, 22 Sep 2022 05:53:22 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYFT15ZRszMnyl;
        Thu, 22 Sep 2022 20:48:37 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:53:20 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 20:53:19 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <jack@suse.com>, <tytso@mit.edu>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH v2 1/3] quota: Check next/prev free block number after reading from quota file
Date:   Thu, 22 Sep 2022 21:03:59 +0800
Message-ID: <20220922130401.1792256-2-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220922130401.1792256-1-chengzhihao1@huawei.com>
References: <20220922130401.1792256-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Following process:
 Init: v2_read_file_info: <3> dqi_free_blk 0 dqi_free_entry 5 dqi_blks 6

 Step 1. chown bin f_a -> dquot_acquire -> v2_write_dquot:
  qtree_write_dquot
   do_insert_tree
    find_free_dqentry
     get_free_dqblk
      write_blk(info->dqi_blocks) // info->dqi_blocks = 6, failure. The
	   content in physical block (corresponding to blk 6) is random.

 Step 2. chown root f_a -> dquot_transfer -> dqput_all -> dqput ->
         ext4_release_dquot -> v2_release_dquot -> qtree_delete_dquot:
  dquot_release
   remove_tree
    free_dqentry
     put_free_dqblk(6)
      info->dqi_free_blk = blk    // info->dqi_free_blk = 6

 Step 3. drop cache (buffer head for block 6 is released)

 Step 4. chown bin f_b -> dquot_acquire -> commit_dqblk -> v2_write_dquot:
  qtree_write_dquot
   do_insert_tree
    find_free_dqentry
     get_free_dqblk
      dh = (struct qt_disk_dqdbheader *)buf
      blk = info->dqi_free_blk     // 6
      ret = read_blk(info, blk, buf)  // The content of buf is random
      info->dqi_free_blk = le32_to_cpu(dh->dqdh_next_free)  // random blk

 Step 5. chown bin f_c -> notify_change -> ext4_setattr -> dquot_transfer:
  dquot = dqget -> acquire_dquot -> ext4_acquire_dquot -> dquot_acquire ->
          commit_dqblk -> v2_write_dquot -> dq_insert_tree:
   do_insert_tree
    find_free_dqentry
     get_free_dqblk
      blk = info->dqi_free_blk    // If blk < 0 and blk is not an error
				     code, it will be returned as dquot

  transfer_to[USRQUOTA] = dquot  // A random negative value
  __dquot_transfer(transfer_to)
   dquot_add_inodes(transfer_to[cnt])
    spin_lock(&dquot->dq_dqb_lock)  // page fault

, which will lead to kernel page fault:
 Quota error (device sda): qtree_write_dquot: Error -8000 occurred
 while creating quota
 BUG: unable to handle page fault for address: ffffffffffffe120
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 Oops: 0002 [#1] PREEMPT SMP
 CPU: 0 PID: 5974 Comm: chown Not tainted 6.0.0-rc1-00004
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 RIP: 0010:_raw_spin_lock+0x3a/0x90
 Call Trace:
  dquot_add_inodes+0x28/0x270
  __dquot_transfer+0x377/0x840
  dquot_transfer+0xde/0x540
  ext4_setattr+0x405/0x14d0
  notify_change+0x68e/0x9f0
  chown_common+0x300/0x430
  __x64_sys_fchownat+0x29/0x40

In order to avoid accessing invalid quota memory address, this patch adds
block number checking of next/prev free block read from quota file.

Fetch a reproducer in [Link].

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216372
Fixes: 1da177e4c3f4152 ("Linux-2.6.12-rc2")
CC: stable@vger.kernel.org
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/quota/quota_tree.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index 5f2405994280..f89186b6db1d 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -71,6 +71,35 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
 	return ret;
 }
 
+static inline int do_check_range(struct super_block *sb, uint val, uint max_val)
+{
+	if (val >= max_val) {
+		quota_error(sb, "Getting block too big (%u >= %u)",
+			    val, max_val);
+		return -EUCLEAN;
+	}
+
+	return 0;
+}
+
+static int check_dquot_block_header(struct qtree_mem_dqinfo *info,
+				    struct qt_disk_dqdbheader *dh)
+{
+	int err = 0;
+	uint nextblk, prevblk;
+
+	nextblk = le32_to_cpu(dh->dqdh_next_free);
+	err = do_check_range(info->dqi_sb, nextblk, info->dqi_blocks);
+	if (err)
+		return err;
+	prevblk = le32_to_cpu(dh->dqdh_prev_free);
+	err = do_check_range(info->dqi_sb, prevblk, info->dqi_blocks);
+	if (err)
+		return err;
+
+	return err;
+}
+
 /* Remove empty block from list and return it */
 static int get_free_dqblk(struct qtree_mem_dqinfo *info)
 {
@@ -85,6 +114,9 @@ static int get_free_dqblk(struct qtree_mem_dqinfo *info)
 		ret = read_blk(info, blk, buf);
 		if (ret < 0)
 			goto out_buf;
+		ret = check_dquot_block_header(info, dh);
+		if (ret)
+			goto out_buf;
 		info->dqi_free_blk = le32_to_cpu(dh->dqdh_next_free);
 	}
 	else {
@@ -232,6 +264,9 @@ static uint find_free_dqentry(struct qtree_mem_dqinfo *info,
 		*err = read_blk(info, blk, buf);
 		if (*err < 0)
 			goto out_buf;
+		*err = check_dquot_block_header(info, dh);
+		if (*err)
+			goto out_buf;
 	} else {
 		blk = get_free_dqblk(info);
 		if ((int)blk < 0) {
@@ -424,6 +459,9 @@ static int free_dqentry(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 		goto out_buf;
 	}
 	dh = (struct qt_disk_dqdbheader *)buf;
+	ret = check_dquot_block_header(info, dh);
+	if (ret)
+		goto out_buf;
 	le16_add_cpu(&dh->dqdh_entries, -1);
 	if (!le16_to_cpu(dh->dqdh_entries)) {	/* Block got free? */
 		ret = remove_free_dqentry(info, buf, blk);
-- 
2.31.1

