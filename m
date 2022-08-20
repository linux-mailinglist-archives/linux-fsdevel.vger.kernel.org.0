Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AF259AD54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 12:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345306AbiHTKyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 06:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344492AbiHTKy0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:54:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EFF92F64;
        Sat, 20 Aug 2022 03:54:24 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M8wPW6pLhzXdcp;
        Sat, 20 Aug 2022 18:50:07 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 20 Aug 2022 18:54:22 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 20 Aug
 2022 18:54:21 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <jack@suse.com>, <tytso@mit.edu>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 3/3] quota: Add more checking after reading from quota file
Date:   Sat, 20 Aug 2022 19:05:14 +0800
Message-ID: <20220820110514.881373-4-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220820110514.881373-1-chengzhihao1@huawei.com>
References: <20220820110514.881373-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It would be better to do more sanity checking (eg. dqdh_entries,
block no.) for the content read from quota file, which can prevent
corrupting the quota file.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/quota/quota_tree.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index efbdef9fbcf3..bca71640d0ae 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -71,12 +71,12 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
 	return ret;
 }
 
-static inline int do_check_range(struct super_block *sb, uint val,
-				 uint min_val, uint max_val)
+static inline int do_check_range(struct super_block *sb, const char *val_name,
+				 uint val, uint min_val, uint max_val)
 {
 	if (val < min_val || val >= max_val) {
-		quota_error(sb, "Getting block %u out of range %u-%u",
-			    val, min_val, max_val);
+		quota_error(sb, "Getting %s %u out of range %u-%u",
+			    val_name, val, min_val, max_val);
 		return -EUCLEAN;
 	}
 
@@ -90,11 +90,13 @@ static int check_free_block(struct qtree_mem_dqinfo *info,
 	uint nextblk, prevblk;
 
 	nextblk = le32_to_cpu(dh->dqdh_next_free);
-	err = do_check_range(info->dqi_sb, nextblk, 0, info->dqi_blocks);
+	err = do_check_range(info->dqi_sb, "dqdh_next_free", nextblk, 0,
+			     info->dqi_blocks);
 	if (err)
 		return err;
 	prevblk = le32_to_cpu(dh->dqdh_prev_free);
-	err = do_check_range(info->dqi_sb, prevblk, 0, info->dqi_blocks);
+	err = do_check_range(info->dqi_sb, "dqdh_prev_free", prevblk, 0,
+			     info->dqi_blocks);
 	if (err)
 		return err;
 
@@ -268,6 +270,11 @@ static uint find_free_dqentry(struct qtree_mem_dqinfo *info,
 		*err = check_free_block(info, dh);
 		if (*err)
 			goto out_buf;
+		*err = do_check_range(info->dqi_sb, "dqdh_entries",
+				      le16_to_cpu(dh->dqdh_entries), 0,
+				      qtree_dqstr_in_blk(info));
+		if (*err)
+			goto out_buf;
 	} else {
 		blk = get_free_dqblk(info);
 		if ((int)blk < 0) {
@@ -349,6 +356,10 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 	}
 	ref = (__le32 *)buf;
 	newblk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
+	ret = do_check_range(dquot->dq_sb, "block", newblk, 0,
+			     info->dqi_blocks);
+	if (ret)
+		goto out_buf;
 	if (!newblk)
 		newson = 1;
 	if (depth == info->dqi_qtree_depth - 1) {
@@ -461,6 +472,11 @@ static int free_dqentry(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 	}
 	dh = (struct qt_disk_dqdbheader *)buf;
 	ret = check_free_block(info, dh);
+	if (ret)
+		goto out_buf;
+	ret = do_check_range(info->dqi_sb, "dqdh_entries",
+			     le16_to_cpu(dh->dqdh_entries), 1,
+			     qtree_dqstr_in_blk(info) + 1);
 	if (ret)
 		goto out_buf;
 	le16_add_cpu(&dh->dqdh_entries, -1);
@@ -519,7 +535,7 @@ static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 		goto out_buf;
 	}
 	newblk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
-	ret = do_check_range(dquot->dq_sb, newblk, QT_TREEOFF,
+	ret = do_check_range(dquot->dq_sb, "block", newblk, QT_TREEOFF,
 			     info->dqi_blocks);
 	if (ret)
 		goto out_buf;
@@ -623,7 +639,8 @@ static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
 	blk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
 	if (!blk)	/* No reference? */
 		goto out_buf;
-	ret = do_check_range(dquot->dq_sb, blk, QT_TREEOFF, info->dqi_blocks);
+	ret = do_check_range(dquot->dq_sb, "block", blk, QT_TREEOFF,
+			     info->dqi_blocks);
 	if (ret)
 		goto out_buf;
 
@@ -739,7 +756,13 @@ static int find_next_id(struct qtree_mem_dqinfo *info, qid_t *id,
 		goto out_buf;
 	}
 	for (i = __get_index(info, *id, depth); i < epb; i++) {
-		if (ref[i] == cpu_to_le32(0)) {
+		uint blk_no = le32_to_cpu(ref[i]);
+
+		ret = do_check_range(info->dqi_sb, "block", blk_no, 0,
+				     info->dqi_blocks);
+		if (ret)
+			goto out_buf;
+		if (blk_no == 0) {
 			*id += level_inc;
 			continue;
 		}
@@ -747,7 +770,7 @@ static int find_next_id(struct qtree_mem_dqinfo *info, qid_t *id,
 			ret = 0;
 			goto out_buf;
 		}
-		ret = find_next_id(info, id, le32_to_cpu(ref[i]), depth + 1);
+		ret = find_next_id(info, id, blk_no, depth + 1);
 		if (ret != -ENOENT)
 			break;
 	}
-- 
2.31.1

