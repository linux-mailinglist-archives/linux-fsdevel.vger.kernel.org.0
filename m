Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58D35E7BF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 15:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiIWNfV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiIWNfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:35:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF85923FE;
        Fri, 23 Sep 2022 06:35:16 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYtPp6vpyzHpsN;
        Fri, 23 Sep 2022 21:33:02 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 21:35:14 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 21:35:13 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <jack@suse.com>, <tytso@mit.edu>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH v3 2/3] quota: Replace all block number checking with helper function
Date:   Fri, 23 Sep 2022 21:45:53 +0800
Message-ID: <20220923134555.2623931-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220923134555.2623931-1-chengzhihao1@huawei.com>
References: <20220923134555.2623931-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 fs/quota/quota_tree.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index 7e65d67de9f3..0fa73ca28045 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -518,12 +518,10 @@ static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 		goto out_buf;
 	}
 	newblk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
-	if (newblk < QT_TREEOFF || newblk >= info->dqi_blocks) {
-		quota_error(dquot->dq_sb, "Getting block too big (%u >= %u)",
-			    newblk, info->dqi_blocks);
-		ret = -EUCLEAN;
+	ret = do_check_range(dquot->dq_sb, "block", newblk, QT_TREEOFF,
+			     info->dqi_blocks - 1);
+	if (ret)
 		goto out_buf;
-	}
 
 	if (depth == info->dqi_qtree_depth - 1) {
 		ret = free_dqentry(info, dquot, newblk);
@@ -624,12 +622,10 @@ static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
 	blk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
 	if (!blk)	/* No reference? */
 		goto out_buf;
-	if (blk < QT_TREEOFF || blk >= info->dqi_blocks) {
-		quota_error(dquot->dq_sb, "Getting block too big (%u >= %u)",
-			    blk, info->dqi_blocks);
-		ret = -EUCLEAN;
+	ret = do_check_range(dquot->dq_sb, "block", blk, QT_TREEOFF,
+			     info->dqi_blocks - 1);
+	if (ret)
 		goto out_buf;
-	}
 
 	if (depth < info->dqi_qtree_depth - 1)
 		ret = find_tree_dqentry(info, dquot, blk, depth+1);
-- 
2.31.1

