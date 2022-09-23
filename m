Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0EC5E7BF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 15:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiIWNfY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 09:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiIWNfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:35:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D23397B0A;
        Fri, 23 Sep 2022 06:35:17 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYtP43PmCzbndY;
        Fri, 23 Sep 2022 21:32:24 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 21:35:15 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 21:35:14 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <jack@suse.com>, <tytso@mit.edu>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH v3 3/3] quota: Add more checking after reading from quota file
Date:   Fri, 23 Sep 2022 21:45:54 +0800
Message-ID: <20220923134555.2623931-4-chengzhihao1@huawei.com>
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

It would be better to do more sanity checking (eg. dqdh_entries,
block no.) for the content read from quota file, which can prevent
corrupting the quota file.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/quota/quota_tree.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index 0fa73ca28045..0f1493e0f6d0 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -96,6 +96,11 @@ static int check_dquot_block_header(struct qtree_mem_dqinfo *info,
 	err = do_check_range(info->dqi_sb, "dqdh_prev_free",
 			     le32_to_cpu(dh->dqdh_prev_free), 0,
 			     info->dqi_blocks - 1);
+	if (err)
+		return err;
+	err = do_check_range(info->dqi_sb, "dqdh_entries",
+			     le16_to_cpu(dh->dqdh_entries), 0,
+			     qtree_dqstr_in_blk(info));
 
 	return err;
 }
@@ -348,6 +353,10 @@ static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 	}
 	ref = (__le32 *)buf;
 	newblk = le32_to_cpu(ref[get_index(info, dquot->dq_id, depth)]);
+	ret = do_check_range(dquot->dq_sb, "block", newblk, 0,
+			     info->dqi_blocks - 1);
+	if (ret)
+		goto out_buf;
 	if (!newblk)
 		newson = 1;
 	if (depth == info->dqi_qtree_depth - 1) {
@@ -739,15 +748,21 @@ static int find_next_id(struct qtree_mem_dqinfo *info, qid_t *id,
 		goto out_buf;
 	}
 	for (i = __get_index(info, *id, depth); i < epb; i++) {
-		if (ref[i] == cpu_to_le32(0)) {
+		uint blk_no = le32_to_cpu(ref[i]);
+
+		if (blk_no == 0) {
 			*id += level_inc;
 			continue;
 		}
+		ret = do_check_range(info->dqi_sb, "block", blk_no, 0,
+				     info->dqi_blocks - 1);
+		if (ret)
+			goto out_buf;
 		if (depth == info->dqi_qtree_depth - 1) {
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

