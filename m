Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519D2732AB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 10:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242847AbjFPI6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 04:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjFPI6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:58:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9917910F6;
        Fri, 16 Jun 2023 01:58:16 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QjCfN57KjzGplF;
        Fri, 16 Jun 2023 16:55:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 16:58:14 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH] quota: fix race condition between dqput() and dquot_mark_dquot_dirty()
Date:   Fri, 16 Jun 2023 16:56:08 +0800
Message-ID: <20230616085608.42435-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

We ran into a problem that dqput() and dquot_mark_dquot_dirty() may race
like the function graph below, causing a released dquot to be added to the
dqi_dirty_list, and this leads to that dquot being released again in
dquot_writeback_dquots(), making two identical quotas in free_dquots.

       cpu1              cpu2
_________________|_________________
wb_do_writeback         CHOWN(1)
 ...
  ext4_da_update_reserve_space
   dquot_claim_block
    ...
     dquot_mark_dquot_dirty // try to dirty old quota
      test_bit(DQ_ACTIVE_B, &dquot->dq_flags) // still ACTIVE
      if (test_bit(DQ_MOD_B, &dquot->dq_flags))
      // test no dirty, wait dq_list_lock
                    ...
                     dquot_transfer
                      __dquot_transfer
                      dqput_all(transfer_from) // rls old dquot
                       dqput // last dqput
                        dquot_release
                         clear_bit(DQ_ACTIVE_B, &dquot->dq_flags)
                        atomic_dec(&dquot->dq_count)
                        put_dquot_last(dquot)
                         list_add_tail(&dquot->dq_free, &free_dquots)
                         // first add the dquot to free_dquots
      if (!test_and_set_bit(DQ_MOD_B, &dquot->dq_flags))
        add dqi_dirty_list // add freed dquot to dirty_list
P3:
ksys_sync
 ...
  dquot_writeback_dquots
   WARN_ON(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
   dqgrab(dquot)
    WARN_ON_ONCE(!atomic_read(&dquot->dq_count))
    WARN_ON_ONCE(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
   dqput(dquot)
    put_dquot_last(dquot)
     list_add_tail(&dquot->dq_free, &free_dquots)
     // Double add the dquot to free_dquots

This causes a list_del corruption when removing the entry from free_dquots,
and even trying to free the dquot twice in dqcache_shrink_scan triggers a
use-after-free.

A warning may also be triggered by a race like the function diagram below:

       cpu1            cpu2           cpu3
________________|_______________|________________
wb_do_writeback   CHOWN(1)        QUOTASYNC(1)
 ...                              ...
  ext4_da_update_reserve_space
    ...           __dquot_transfer
                   dqput // last dqput
                    dquot_release
                     dquot_is_busy
                      if (test_bit(DQ_MOD_B, &dquot->dq_flags))
                       // not dirty and still active
     dquot_mark_dquot_dirty
      if (!test_and_set_bit(DQ_MOD_B, &dquot->dq_flags))
        add dqi_dirty_list
                       clear_bit(DQ_ACTIVE_B, &dquot->dq_flags)
                                   dquot_writeback_dquots
                                    WARN_ON(!test_bit(DQ_ACTIVE_B))

To solve this problem, it is similar to the way dqget() avoids racing with
dquot_release(). First set the DQ_MOD_B flag, then execute wait_on_dquot(),
after this we know that either dquot_release() is already finished or it
will be canceled due to DQ_MOD_B flag test, at this point if the quota is
DQ_ACTIVE_B, then we can safely add the dquot to the dqi_dirty_list,
otherwise clear the DQ_MOD_B flag and exit directly.

Fixes: 4580b30ea887 ("quota: Do not dirty bad dquots")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---

Hello Honza,

This problem can also be solved by modifying the reference count mechanism,
where dquots hold a reference count after they are allocated until they are
destroyed, i.e. the dquots in the free_dquots list have dq_count == 1. This
allows us to reduce the reference count as soon as we enter the dqput(),
and then add the dquot to the dqi_dirty_list only when dq_count > 1. This
also prevents the dquot in the dqi_dirty_list from not having the
DQ_ACTIVE_B flag, but this is a more impactful modification, so we chose to
refer to dqget() to avoid racing with dquot_release(). If you prefer this
solution by modifying the dq_count mechanism, I would be happy to send
another version of the patch.

Thanks,
Baokun.

 fs/quota/dquot.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index e3e4f4047657..2a04cd74c7c5 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -362,11 +362,26 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
 		return 1;
 
 	spin_lock(&dq_list_lock);
-	if (!test_and_set_bit(DQ_MOD_B, &dquot->dq_flags)) {
+	ret = test_and_set_bit(DQ_MOD_B, &dquot->dq_flags);
+	if (ret)
+		goto out_lock;
+	spin_unlock(&dq_list_lock);
+
+	/*
+	 * Wait for dq_lock - after this we know that either dquot_release() is
+	 * already finished or it will be canceled due to DQ_MOD_B flag test.
+	 */
+	wait_on_dquot(dquot);
+	spin_lock(&dq_list_lock);
+	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+		clear_bit(DQ_MOD_B, &dquot->dq_flags);
+		goto out_lock;
+	}
+	/* DQ_MOD_B is cleared means that the dquot has been written back */
+	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
 		list_add(&dquot->dq_dirty, &sb_dqopt(dquot->dq_sb)->
 				info[dquot->dq_id.type].dqi_dirty_list);
-		ret = 0;
-	}
+out_lock:
 	spin_unlock(&dq_list_lock);
 	return ret;
 }
@@ -791,7 +806,7 @@ void dqput(struct dquot *dquot)
 		return;
 	}
 	/* Need to release dquot? */
-	if (dquot_dirty(dquot)) {
+	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags) && dquot_dirty(dquot)) {
 		spin_unlock(&dq_list_lock);
 		/* Commit dquot before releasing */
 		ret = dquot->dq_sb->dq_op->write_dquot(dquot);
-- 
2.31.1

