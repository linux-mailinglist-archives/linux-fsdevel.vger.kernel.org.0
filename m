Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6DE743A77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjF3LKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 07:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjF3LKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:10:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40FB173C;
        Fri, 30 Jun 2023 04:10:49 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QssxF4bLbzpWLk;
        Fri, 30 Jun 2023 19:08:01 +0800 (CST)
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
Subject: [PATCH v3 4/5] quota: fix dqput() to follow the guarantees dquot_srcu should provide
Date:   Fri, 30 Jun 2023 19:08:21 +0800
Message-ID: <20230630110822.3881712-5-libaokun1@huawei.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The dquot_mark_dquot_dirty() using dquot references from the inode
should be protected by dquot_srcu. quota_off code takes care to call
synchronize_srcu(&dquot_srcu) to not drop dquot references while they
are used by other users. But dquot_transfer() breaks this assumption.
We call dquot_transfer() to drop the last reference of dquot and add
it to free_dquots, but there may still be other users using the dquot
at this time, as shown in the function graph below:

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
                         // add the dquot to free_dquots
      if (!test_and_set_bit(DQ_MOD_B, &dquot->dq_flags))
        add dqi_dirty_list // add released dquot to dirty_list

This can cause various issues, such as dquot being destroyed by
dqcache_shrink_scan() after being added to free_dquots, which can trigger
a UAF in dquot_mark_dquot_dirty(); or after dquot is added to free_dquots
and then to dirty_list, it is added to free_dquots again after
dquot_writeback_dquots() is executed, which causes the free_dquots list to
be corrupted and triggers a UAF when dqcache_shrink_scan() is called for
freeing dquot twice.

As Honza said, we need to fix dquot_transfer() to follow the guarantees
dquot_srcu should provide. But calling synchronize_srcu() directly from
dquot_transfer() is too expensive (and mostly unnecessary). So we add
dquot whose last reference should be dropped to the new global dquot
list releasing_dquots, and then queue work item which would call
synchronize_srcu() and after that perform the final cleanup of all the
dquots on releasing_dquots.

Fixes: 4580b30ea887 ("quota: Do not dirty bad dquots")
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V2->V3:
	Correct some comments.
	Simplify the code in quota_release_workfn().
	Merge the patch that added releasing_dquots to the current patch.
	The dquots in releasing_dquots are no longer counted as free,
	  and are no longer cleared when shrinked.

 fs/quota/dquot.c | 96 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 18 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 88aa747f4800..c7afe433d991 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -225,13 +225,22 @@ static void put_quota_format(struct quota_format_type *fmt)
 
 /*
  * Dquot List Management:
- * The quota code uses four lists for dquot management: the inuse_list,
- * free_dquots, dqi_dirty_list, and dquot_hash[] array. A single dquot
- * structure may be on some of those lists, depending on its current state.
+ * The quota code uses five lists for dquot management: the inuse_list,
+ * releasing_dquots, free_dquots, dqi_dirty_list, and dquot_hash[] array.
+ * A single dquot structure may be on some of those lists, depending on
+ * its current state.
  *
  * All dquots are placed to the end of inuse_list when first created, and this
  * list is used for invalidate operation, which must look at every dquot.
  *
+ * When the last reference of a dquot will be dropped, the dquot will be
+ * added to releasing_dquots. We'd then queue work item which would call
+ * synchronize_srcu() and after that perform the final cleanup of all the
+ * dquots on the list. Both releasing_dquots and free_dquots use the
+ * dq_free list_head in the dquot struct. When a dquot is removed from
+ * releasing_dquots, a reference count is always subtracted, and if
+ * dq_count == 0 at that point, the dquot will be added to the free_dquots.
+ *
  * Unused dquots (dq_count == 0) are added to the free_dquots list when freed,
  * and this list is searched whenever we need an available dquot.  Dquots are
  * removed from the list as soon as they are used again, and
@@ -250,6 +259,7 @@ static void put_quota_format(struct quota_format_type *fmt)
 
 static LIST_HEAD(inuse_list);
 static LIST_HEAD(free_dquots);
+static LIST_HEAD(releasing_dquots);
 static unsigned int dq_hash_bits, dq_hash_mask;
 static struct hlist_head *dquot_hash;
 
@@ -260,6 +270,9 @@ static qsize_t inode_get_rsv_space(struct inode *inode);
 static qsize_t __inode_get_rsv_space(struct inode *inode);
 static int __dquot_initialize(struct inode *inode, int type);
 
+static void quota_release_workfn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(quota_release_work, quota_release_workfn);
+
 static inline unsigned int
 hashfn(const struct super_block *sb, struct kqid qid)
 {
@@ -305,12 +318,18 @@ static inline void put_dquot_last(struct dquot *dquot)
 	dqstats_inc(DQST_FREE_DQUOTS);
 }
 
+static inline void put_releasing_dquots(struct dquot *dquot)
+{
+	list_add_tail(&dquot->dq_free, &releasing_dquots);
+}
+
 static inline void remove_free_dquot(struct dquot *dquot)
 {
 	if (list_empty(&dquot->dq_free))
 		return;
 	list_del_init(&dquot->dq_free);
-	dqstats_dec(DQST_FREE_DQUOTS);
+	if (!atomic_read(&dquot->dq_count))
+		dqstats_dec(DQST_FREE_DQUOTS);
 }
 
 static inline void put_inuse(struct dquot *dquot)
@@ -552,6 +571,8 @@ static void invalidate_dquots(struct super_block *sb, int type)
 	struct dquot *dquot, *tmp;
 
 restart:
+	flush_delayed_work(&quota_release_work);
+
 	spin_lock(&dq_list_lock);
 	list_for_each_entry_safe(dquot, tmp, &inuse_list, dq_inuse) {
 		if (dquot->dq_sb != sb)
@@ -560,6 +581,12 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			continue;
 		/* Wait for dquot users */
 		if (atomic_read(&dquot->dq_count)) {
+			/* dquot in releasing_dquots, flush and retry */
+			if (!list_empty(&dquot->dq_free)) {
+				spin_unlock(&dq_list_lock);
+				goto restart;
+			}
+
 			atomic_inc(&dquot->dq_count);
 			spin_unlock(&dq_list_lock);
 			/*
@@ -770,6 +797,49 @@ static struct shrinker dqcache_shrinker = {
 	.seeks = DEFAULT_SEEKS,
 };
 
+/*
+ * Safely release dquot and put reference to dquot.
+ */
+static void quota_release_workfn(struct work_struct *work)
+{
+	struct dquot *dquot;
+	struct list_head rls_head;
+
+	spin_lock(&dq_list_lock);
+	/* Exchange the list head to avoid livelock. */
+	list_replace_init(&releasing_dquots, &rls_head);
+	spin_unlock(&dq_list_lock);
+
+restart:
+	synchronize_srcu(&dquot_srcu);
+	spin_lock(&dq_list_lock);
+	while (!list_empty(&rls_head)) {
+		dquot = list_first_entry(&rls_head, struct dquot, dq_free);
+		/* Dquot got used again? */
+		if (atomic_read(&dquot->dq_count) > 1) {
+			remove_free_dquot(dquot);
+			atomic_dec(&dquot->dq_count);
+			continue;
+		}
+		if (dquot_dirty(dquot)) {
+			spin_unlock(&dq_list_lock);
+			/* Commit dquot before releasing */
+			dquot_write_dquot(dquot);
+			goto restart;
+		}
+		if (dquot_active(dquot)) {
+			spin_unlock(&dq_list_lock);
+			dquot->dq_sb->dq_op->release_dquot(dquot);
+			goto restart;
+		}
+		/* Dquot is inactive and clean, now move it to free list */
+		remove_free_dquot(dquot);
+		atomic_dec(&dquot->dq_count);
+		put_dquot_last(dquot);
+	}
+	spin_unlock(&dq_list_lock);
+}
+
 /*
  * Put reference to dquot
  */
@@ -786,7 +856,7 @@ void dqput(struct dquot *dquot)
 	}
 #endif
 	dqstats_inc(DQST_DROPS);
-we_slept:
+
 	spin_lock(&dq_list_lock);
 	if (atomic_read(&dquot->dq_count) > 1) {
 		/* We have more than one user... nothing to do */
@@ -798,25 +868,15 @@ void dqput(struct dquot *dquot)
 		spin_unlock(&dq_list_lock);
 		return;
 	}
+
 	/* Need to release dquot? */
-	if (dquot_dirty(dquot)) {
-		spin_unlock(&dq_list_lock);
-		/* Commit dquot before releasing */
-		dquot_write_dquot(dquot);
-		goto we_slept;
-	}
-	if (dquot_active(dquot)) {
-		spin_unlock(&dq_list_lock);
-		dquot->dq_sb->dq_op->release_dquot(dquot);
-		goto we_slept;
-	}
-	atomic_dec(&dquot->dq_count);
 #ifdef CONFIG_QUOTA_DEBUG
 	/* sanity check */
 	BUG_ON(!list_empty(&dquot->dq_free));
 #endif
-	put_dquot_last(dquot);
+	put_releasing_dquots(dquot);
 	spin_unlock(&dq_list_lock);
+	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
 }
 EXPORT_SYMBOL(dqput);
 
-- 
2.31.1

