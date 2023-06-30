Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC1743A7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 13:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjF3LK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 07:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjF3LKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:10:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9877D10E5;
        Fri, 30 Jun 2023 04:10:49 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qst046GPzz1HBpR;
        Fri, 30 Jun 2023 19:10:28 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 30 Jun
 2023 19:10:47 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 3/5] quota: add new helper dquot_active()
Date:   Fri, 30 Jun 2023 19:08:20 +0800
Message-ID: <20230630110822.3881712-4-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230630110822.3881712-1-libaokun1@huawei.com>
References: <20230630110822.3881712-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new helper function dquot_active() to make the code more concise.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V2->V3:
	No change.

 fs/quota/dquot.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index a08698d9859a..88aa747f4800 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -336,6 +336,11 @@ static void wait_on_dquot(struct dquot *dquot)
 	mutex_unlock(&dquot->dq_lock);
 }
 
+static inline int dquot_active(struct dquot *dquot)
+{
+	return test_bit(DQ_ACTIVE_B, &dquot->dq_flags);
+}
+
 static inline int dquot_dirty(struct dquot *dquot)
 {
 	return test_bit(DQ_MOD_B, &dquot->dq_flags);
@@ -351,14 +356,14 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
 {
 	int ret = 1;
 
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+	if (!dquot_active(dquot))
 		return 0;
 
 	if (sb_dqopt(dquot->dq_sb)->flags & DQUOT_NOLIST_DIRTY)
 		return test_and_set_bit(DQ_MOD_B, &dquot->dq_flags);
 
 	/* If quota is dirty already, we don't have to acquire dq_list_lock */
-	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
+	if (dquot_dirty(dquot))
 		return 1;
 
 	spin_lock(&dq_list_lock);
@@ -440,7 +445,7 @@ int dquot_acquire(struct dquot *dquot)
 	smp_mb__before_atomic();
 	set_bit(DQ_READ_B, &dquot->dq_flags);
 	/* Instantiate dquot if needed */
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags) && !dquot->dq_off) {
+	if (!dquot_active(dquot) && !dquot->dq_off) {
 		ret = dqopt->ops[dquot->dq_id.type]->commit_dqblk(dquot);
 		/* Write the info if needed */
 		if (info_dirty(&dqopt->info[dquot->dq_id.type])) {
@@ -482,7 +487,7 @@ int dquot_commit(struct dquot *dquot)
 		goto out_lock;
 	/* Inactive dquot can be only if there was error during read/init
 	 * => we have better not writing it */
-	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+	if (dquot_active(dquot))
 		ret = dqopt->ops[dquot->dq_id.type]->commit_dqblk(dquot);
 	else
 		ret = -EIO;
@@ -597,7 +602,7 @@ int dquot_scan_active(struct super_block *sb,
 
 	spin_lock(&dq_list_lock);
 	list_for_each_entry(dquot, &inuse_list, dq_inuse) {
-		if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+		if (!dquot_active(dquot))
 			continue;
 		if (dquot->dq_sb != sb)
 			continue;
@@ -612,7 +617,7 @@ int dquot_scan_active(struct super_block *sb,
 		 * outstanding call and recheck the DQ_ACTIVE_B after that.
 		 */
 		wait_on_dquot(dquot);
-		if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+		if (dquot_active(dquot)) {
 			ret = fn(dquot, priv);
 			if (ret < 0)
 				goto out;
@@ -663,7 +668,7 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 			dquot = list_first_entry(&dirty, struct dquot,
 						 dq_dirty);
 
-			WARN_ON(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags));
+			WARN_ON(!dquot_active(dquot));
 
 			/* Now we have active dquot from which someone is
  			 * holding reference so we can safely just increase
@@ -800,7 +805,7 @@ void dqput(struct dquot *dquot)
 		dquot_write_dquot(dquot);
 		goto we_slept;
 	}
-	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+	if (dquot_active(dquot)) {
 		spin_unlock(&dq_list_lock);
 		dquot->dq_sb->dq_op->release_dquot(dquot);
 		goto we_slept;
@@ -901,7 +906,7 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 	 * already finished or it will be canceled due to dq_count > 1 test */
 	wait_on_dquot(dquot);
 	/* Read the dquot / allocate space in quota file */
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+	if (!dquot_active(dquot)) {
 		int err;
 
 		err = sb->dq_op->acquire_dquot(dquot);
-- 
2.31.1

