Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2094E741254
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 15:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjF1NY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 09:24:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16307 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjF1NYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:24:21 -0400
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Qrj115qDXzLmyW;
        Wed, 28 Jun 2023 21:22:13 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Jun
 2023 21:24:18 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 5/7] quota: fix dqput() to follow the guarantees dquot_srcu should provide
Date:   Wed, 28 Jun 2023 21:21:53 +0800
Message-ID: <20230628132155.1560425-6-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628132155.1560425-1-libaokun1@huawei.com>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
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
 fs/quota/dquot.c | 85 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 14 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 09787e4f6a00..e8e702ac64e5 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -270,6 +270,9 @@ static qsize_t inode_get_rsv_space(struct inode *inode);
 static qsize_t __inode_get_rsv_space(struct inode *inode);
 static int __dquot_initialize(struct inode *inode, int type);
 
+static void quota_release_workfn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(quota_release_work, quota_release_workfn);
+
 static inline unsigned int
 hashfn(const struct super_block *sb, struct kqid qid)
 {
@@ -569,6 +572,8 @@ static void invalidate_dquots(struct super_block *sb, int type)
 	struct dquot *dquot, *tmp;
 
 restart:
+	flush_delayed_work(&quota_release_work);
+
 	spin_lock(&dq_list_lock);
 	list_for_each_entry_safe(dquot, tmp, &inuse_list, dq_inuse) {
 		if (dquot->dq_sb != sb)
@@ -577,6 +582,12 @@ static void invalidate_dquots(struct super_block *sb, int type)
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
@@ -760,6 +771,8 @@ dqcache_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	struct dquot *dquot;
 	unsigned long freed = 0;
 
+	flush_delayed_work(&quota_release_work);
+
 	spin_lock(&dq_list_lock);
 	while (!list_empty(&free_dquots) && sc->nr_to_scan) {
 		dquot = list_first_entry(&free_dquots, struct dquot, dq_free);
@@ -787,6 +800,60 @@ static struct shrinker dqcache_shrinker = {
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
+		if (dquot_dirty(dquot)) {
+			spin_unlock(&dq_list_lock);
+			/* Commit dquot before releasing */
+			dquot_write_dquot(dquot);
+			goto restart;
+		}
+		/* Always clear DQ_ACTIVE_B, unless racing with dqget() */
+		if (dquot_active(dquot)) {
+			spin_unlock(&dq_list_lock);
+			dquot->dq_sb->dq_op->release_dquot(dquot);
+			spin_lock(&dq_list_lock);
+		}
+		/*
+		 * During the execution of dquot_release() outside the
+		 * dq_list_lock, another process may have completed
+		 * dqget()/dqput()/mark_dirty().
+		 */
+		if (atomic_read(&dquot->dq_count) == 1 &&
+		    (dquot_active(dquot) || dquot_dirty(dquot))) {
+			spin_unlock(&dq_list_lock);
+			goto restart;
+		}
+		/*
+		 * Now it is safe to remove this dquot from releasing_dquots
+		 * and reduce its reference count.
+		 */
+		remove_free_dquot(dquot);
+		atomic_dec(&dquot->dq_count);
+
+		/* We may be racing with some other dqget(). */
+		if (!atomic_read(&dquot->dq_count))
+			put_dquot_last(dquot);
+	}
+	spin_unlock(&dq_list_lock);
+}
+
 /*
  * Put reference to dquot
  */
@@ -803,7 +870,7 @@ void dqput(struct dquot *dquot)
 	}
 #endif
 	dqstats_inc(DQST_DROPS);
-we_slept:
+
 	spin_lock(&dq_list_lock);
 	if (atomic_read(&dquot->dq_count) > 1) {
 		/* We have more than one user... nothing to do */
@@ -815,25 +882,15 @@ void dqput(struct dquot *dquot)
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

