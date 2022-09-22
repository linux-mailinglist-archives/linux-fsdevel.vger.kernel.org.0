Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B9F5E62E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 14:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiIVMx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 08:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiIVMxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:53:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C55E99AE;
        Thu, 22 Sep 2022 05:53:28 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYFTn3lFlzlXJl;
        Thu, 22 Sep 2022 20:49:17 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:53:21 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 20:53:20 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <jack@suse.com>, <tytso@mit.edu>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH v2 2/3] quota: Replace all block number checking with helper function
Date:   Thu, 22 Sep 2022 21:04:00 +0800
Message-ID: <20220922130401.1792256-3-chengzhihao1@huawei.com>
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

Cleanup all block checking places, replace them with helper function
do_check_range().

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/quota/quota_tree.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index f89186b6db1d..47711e739ddb 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -71,11 +71,12 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
 	return ret;
 }
 
-static inline int do_check_range(struct super_block *sb, uint val, uint max_val)
+static inline int do_check_range(struct super_block *sb, uint val,
+				 uint min_val, uint max_val)
 {
-	if (val >= max_val) {
-		quota_error(sb, "Getting block too big (%u >= %u)",
-			    val, max_val);
+	if (val < min_val || val >= max_val) {
+		quota_error(sb, "Getting block %u out of range %u-%u",
+			    val, min_val, max_val);
 		return -EUCLEAN;
 	}
 
@@ -89,11 +90,11 @@ static int check_dquot_block_header(struct qtree_mem_dqinfo *info,
 	uint nextblk, prevblk;
 
 	nextblk = le32_to_cpu(dh->dqdh_next_free);
-	err = do_check_range(info->dqi_sb, nextblk, info->dqi_blocks);
+	err = do_check_range(info->dqi_sb, nextblk, 0, info->dqi_blocks);
 	if (err)
 		return err;
 	prevblk = le32_to_cpu(dh->dqdh_prev_free);
-	err = do_check_range(info->dqi_sb, prevblk, info->dqi_blocks);
+	err = do_check_range(info->dqi_sb, prevblk, 0, info->dqi_blocks);
 	if (err)
 		return err;
 
@@ -518,12 +519,10 @@ static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 		goto out_buf;
 	}
 	newblk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
-	if (newblk < QT_TREEOFF || newblk >= info->dqi_blocks) {
-		quota_error(dquot->dq_sb, "Getting block too big (%u >= %u)",
-			    newblk, info->dqi_blocks);
-		ret = -EUCLEAN;
+	ret = do_check_range(dquot->dq_sb, newblk, QT_TREEOFF,
+			     info->dqi_blocks);
+	if (ret)
 		goto out_buf;
-	}
 
 	if (depth == info->dqi_qtree_depth - 1) {
 		ret = free_dqentry(info, dquot, newblk);
@@ -624,12 +623,9 @@ static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
 	blk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
 	if (!blk)	/* No reference? */
 		goto out_buf;
-	if (blk < QT_TREEOFF || blk >= info->dqi_blocks) {
-		quota_error(dquot->dq_sb, "Getting block too big (%u >= %u)",
-			    blk, info->dqi_blocks);
-		ret = -EUCLEAN;
+	ret = do_check_range(dquot->dq_sb, blk, QT_TREEOFF, info->dqi_blocks);
+	if (ret)
 		goto out_buf;
-	}
 
 	if (depth < info->dqi_qtree_depth - 1)
 		ret = find_tree_dqentry(info, dquot, blk, depth+1);
-- 
2.31.1

