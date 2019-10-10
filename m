Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C87C3D3496
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 01:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfJJXuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 19:50:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27680 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbfJJXuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:50:03 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9ANnswY027102
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2019 16:50:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=WnG8rfHkks+JEAPlcvX3dZBfBJsbvtcxZemU4JXo1zs=;
 b=Ovf7VbbK2J6ZwS2yhxwbNyUcEoZSbuFJiU2LMA3cGUVlcL8eoKkTDsy8ibII8pXICfFD
 /xTiOLxDsQzksMAgXJ1g0nz61OxZeJriOqdJh0mA5MFSmRo6W5pcqpi/yWemErLBSvNW
 xRApga4tD06Es1+uHSw7ka9u9VSuCWulb5w= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vj8jfswr4-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2019 16:50:01 -0700
Received: from 2401:db00:30:600c:face:0:1f:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 10 Oct 2019 16:40:39 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 31A84188254E0; Thu, 10 Oct 2019 16:40:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, "Jan Kara" <jack@suse.cz>,
        Dennis Zhou <dennis@kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2] cgroup, blkcg: prevent dirty inodes to pin dying memory cgroups
Date:   Thu, 10 Oct 2019 16:40:36 -0700
Message-ID: <20191010234036.2860655-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_09:2019-10-10,2019-10-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 mlxlogscore=774 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910100209
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We've noticed that the number of dying cgroups on our production hosts
tends to grow with the uptime. This time it's caused by the writeback
code.

An inode which is getting dirty for the first time is associated
with the wb structure (look at __inode_attach_wb()). It can later
be switched to another wb under some conditions (e.g. some other
cgroup is writing a lot of data to the same inode), but generally
stays associated up to the end of life of the inode structure.

The problem is that the wb structure holds a reference to the original
memory cgroup. So if an inode has been dirty once, it has a good chance
to pin down the original memory cgroup.

An example from the real life: some service runs periodically and
updates rpm packages. Each time in a new memory cgroup. Installed
.so files are heavily used by other cgroups, so corresponding inodes
tend to stay alive for a long. So do pinned memory cgroups.
In production I've seen many hosts with 1-2 thousands of dying
cgroups.

This is not the first problem with the dying memory cgroups. As
always, the problem is with their relative size: memory cgroups
are large objects, easily 100x-1000x larger that inodes. So keeping
a couple of thousands of dying cgroups in memory without a good reason
(what we easily do with inodes) is quite costly (and is measured
in tens and hundreds of Mb).

To solve this problem let's perform a periodic scan of inodes
attached to the dying wbs, and detach those of them, which are clean
and don't have an active io operation.
That will eventually release the wb structure and corresponding
memory cgroup.

To make this scanning effective, let's keep a list of attached
inodes. inode->i_io_list can be reused for this purpose.

The scan is performed from the cgroup offlining path. Dying wbs
are placed on the global list. On each cgroup removal we traverse
the whole list ignoring wbs with active io operations. That will
allow the majority of io operations to be finished after the
removal of the cgroup.

Big thanks to Jan Kara and Dennis Zhou for their ideas and
contribution to this patch.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 fs/fs-writeback.c                | 52 +++++++++++++++++++++++---
 include/linux/backing-dev-defs.h |  2 +
 include/linux/writeback.h        |  1 +
 mm/backing-dev.c                 | 63 ++++++++++++++++++++++++++++++--
 4 files changed, 108 insertions(+), 10 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e88421d9a48d..c792db951274 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -136,16 +136,21 @@ static bool inode_io_list_move_locked(struct inode *inode,
  * inode_io_list_del_locked - remove an inode from its bdi_writeback IO list
  * @inode: inode to be removed
  * @wb: bdi_writeback @inode is being removed from
+ * @keep_attached: keep the inode on the list of inodes attached to wb
  *
  * Remove @inode which may be on one of @wb->b_{dirty|io|more_io} lists and
  * clear %WB_has_dirty_io if all are empty afterwards.
  */
 static void inode_io_list_del_locked(struct inode *inode,
-				     struct bdi_writeback *wb)
+				     struct bdi_writeback *wb,
+				     bool keep_attached)
 {
 	assert_spin_locked(&wb->list_lock);
 
-	list_del_init(&inode->i_io_list);
+	if (keep_attached)
+		list_move(&inode->i_io_list, &wb->b_attached);
+	else
+		list_del_init(&inode->i_io_list);
 	wb_io_lists_depopulated(wb);
 }
 
@@ -426,7 +431,7 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	if (!list_empty(&inode->i_io_list)) {
 		struct inode *pos;
 
-		inode_io_list_del_locked(inode, old_wb);
+		inode_io_list_del_locked(inode, old_wb, false);
 		inode->i_wb = new_wb;
 		list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
 			if (time_after_eq(inode->dirtied_when,
@@ -544,6 +549,41 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	kfree(isw);
 }
 
+/**
+ * cleanup_offline_wb - detach attached clean inodes
+ * @wb: target wb
+ *
+ * Clear the ->i_wb pointer of the attached inodes and drop
+ * the corresponding wb reference. Skip inodes which are dirty,
+ * freeing, switching or in the active writeback process.
+ */
+void cleanup_offline_wb(struct bdi_writeback *wb)
+{
+	struct inode *inode, *tmp;
+	bool ret = true;
+
+	spin_lock(&wb->list_lock);
+	if (list_empty(&wb->b_attached))
+		goto unlock;
+
+	list_for_each_entry_safe(inode, tmp, &wb->b_attached, i_io_list) {
+		if (!spin_trylock(&inode->i_lock))
+			continue;
+		xa_lock_irq(&inode->i_mapping->i_pages);
+		if (!(inode->i_state &
+		      (I_FREEING | I_CLEAR | I_SYNC | I_DIRTY | I_WB_SWITCH))) {
+			WARN_ON_ONCE(inode->i_wb != wb);
+			inode->i_wb = NULL;
+			wb_put(wb);
+			list_del_init(&inode->i_io_list);
+		}
+		xa_unlock_irq(&inode->i_mapping->i_pages);
+		spin_unlock(&inode->i_lock);
+	}
+unlock:
+	spin_unlock(&wb->list_lock);
+}
+
 /**
  * wbc_attach_and_unlock_inode - associate wbc with target inode and unlock it
  * @wbc: writeback_control of interest
@@ -1120,7 +1160,7 @@ void inode_io_list_del(struct inode *inode)
 	struct bdi_writeback *wb;
 
 	wb = inode_to_wb_and_lock_list(inode);
-	inode_io_list_del_locked(inode, wb);
+	inode_io_list_del_locked(inode, wb, false);
 	spin_unlock(&wb->list_lock);
 }
 
@@ -1425,7 +1465,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 		inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
 	} else {
 		/* The inode is clean. Remove from writeback lists. */
-		inode_io_list_del_locked(inode, wb);
+		inode_io_list_del_locked(inode, wb, true);
 	}
 }
 
@@ -1570,7 +1610,7 @@ static int writeback_single_inode(struct inode *inode,
 	 * touch it. See comment above for explanation.
 	 */
 	if (!(inode->i_state & I_DIRTY_ALL))
-		inode_io_list_del_locked(inode, wb);
+		inode_io_list_del_locked(inode, wb, true);
 	spin_unlock(&wb->list_lock);
 	inode_sync_complete(inode);
 out:
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 4fc87dee005a..68b167fda259 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -137,6 +137,7 @@ struct bdi_writeback {
 	struct list_head b_io;		/* parked for writeback */
 	struct list_head b_more_io;	/* parked for more writeback */
 	struct list_head b_dirty_time;	/* time stamps are dirty */
+	struct list_head b_attached;	/* attached inodes */
 	spinlock_t list_lock;		/* protects the b_* lists */
 
 	struct percpu_counter stat[NR_WB_STAT_ITEMS];
@@ -177,6 +178,7 @@ struct bdi_writeback {
 	struct cgroup_subsys_state *blkcg_css; /* and blkcg */
 	struct list_head memcg_node;	/* anchored at memcg->cgwb_list */
 	struct list_head blkcg_node;	/* anchored at blkcg->cgwb_list */
+	struct list_head offline_node;
 
 	union {
 		struct work_struct release_work;
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index a19d845dd7eb..44dfa575244d 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -220,6 +220,7 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_pages,
 			   enum wb_reason reason, struct wb_completion *done);
 void cgroup_writeback_umount(void);
+void cleanup_offline_wb(struct bdi_writeback *wb);
 
 /**
  * inode_attach_wb - associate an inode with its wb
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index d9daa3e422d0..50176d0ff724 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -52,10 +52,10 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 	unsigned long background_thresh;
 	unsigned long dirty_thresh;
 	unsigned long wb_thresh;
-	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time;
+	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time, nr_attached;
 	struct inode *inode;
 
-	nr_dirty = nr_io = nr_more_io = nr_dirty_time = 0;
+	nr_dirty = nr_io = nr_more_io = nr_dirty_time = nr_attached = 0;
 	spin_lock(&wb->list_lock);
 	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
 		nr_dirty++;
@@ -66,6 +66,8 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
 		if (inode->i_state & I_DIRTY_TIME)
 			nr_dirty_time++;
+	list_for_each_entry(inode, &wb->b_attached, i_io_list)
+		nr_attached++;
 	spin_unlock(&wb->list_lock);
 
 	global_dirty_limits(&background_thresh, &dirty_thresh);
@@ -85,6 +87,7 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 		   "b_io:               %10lu\n"
 		   "b_more_io:          %10lu\n"
 		   "b_dirty_time:       %10lu\n"
+		   "b_attached:         %10lu\n"
 		   "bdi_list:           %10u\n"
 		   "state:              %10lx\n",
 		   (unsigned long) K(wb_stat(wb, WB_WRITEBACK)),
@@ -99,6 +102,7 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 		   nr_io,
 		   nr_more_io,
 		   nr_dirty_time,
+		   nr_attached,
 		   !list_empty(&bdi->bdi_list), bdi->wb.state);
 #undef K
 
@@ -295,6 +299,7 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	INIT_LIST_HEAD(&wb->b_io);
 	INIT_LIST_HEAD(&wb->b_more_io);
 	INIT_LIST_HEAD(&wb->b_dirty_time);
+	INIT_LIST_HEAD(&wb->b_attached);
 	spin_lock_init(&wb->list_lock);
 
 	wb->bw_time_stamp = jiffies;
@@ -385,11 +390,12 @@ static void wb_exit(struct bdi_writeback *wb)
 
 /*
  * cgwb_lock protects bdi->cgwb_tree, bdi->cgwb_congested_tree,
- * blkcg->cgwb_list, and memcg->cgwb_list.  bdi->cgwb_tree is also RCU
- * protected.
+ * blkcg->cgwb_list, offline_cgwbs and memcg->cgwb_list.
+ * bdi->cgwb_tree is also RCU protected.
  */
 static DEFINE_SPINLOCK(cgwb_lock);
 static struct workqueue_struct *cgwb_release_wq;
+static LIST_HEAD(offline_cgwbs);
 
 /**
  * wb_congested_get_create - get or create a wb_congested
@@ -486,6 +492,10 @@ static void cgwb_release_workfn(struct work_struct *work)
 	mutex_lock(&wb->bdi->cgwb_release_mutex);
 	wb_shutdown(wb);
 
+	spin_lock_irq(&cgwb_lock);
+	list_del(&wb->offline_node);
+	spin_unlock_irq(&cgwb_lock);
+
 	css_put(wb->memcg_css);
 	css_put(wb->blkcg_css);
 	mutex_unlock(&wb->bdi->cgwb_release_mutex);
@@ -513,6 +523,7 @@ static void cgwb_kill(struct bdi_writeback *wb)
 	WARN_ON(!radix_tree_delete(&wb->bdi->cgwb_tree, wb->memcg_css->id));
 	list_del(&wb->memcg_node);
 	list_del(&wb->blkcg_node);
+	list_add(&wb->offline_node, &offline_cgwbs);
 	percpu_ref_kill(&wb->refcnt);
 }
 
@@ -734,6 +745,47 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
 	mutex_unlock(&bdi->cgwb_release_mutex);
 }
 
+/**
+ * cleanup_offline_cgwbs - try to release dying cgwbs
+ *
+ * Try to release dying cgwbs by clearing i_wb pointer of
+ * attached inodes. Processed wbs are placed at the end
+ * of the list to guarantee the forward progress.
+ *
+ * Should be called with the acquired cgwb_lock, which might
+ * be released and re-acquired in the process.
+ */
+static void cleanup_offline_cgwbs(void)
+{
+	struct bdi_writeback *wb;
+	LIST_HEAD(processed);
+
+	lockdep_assert_held(&cgwb_lock);
+
+	while (!list_empty(&offline_cgwbs)) {
+		wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
+				      offline_node);
+
+		list_move_tail(&wb->offline_node, &processed);
+
+		if (wb_has_dirty_io(wb))
+			continue;
+
+		if (!percpu_ref_tryget(&wb->refcnt))
+			continue;
+
+		spin_unlock_irq(&cgwb_lock);
+		cleanup_offline_wb(wb);
+		cond_resched();
+		spin_lock_irq(&cgwb_lock);
+
+		wb_put(wb);
+	}
+
+	if (!list_empty(&processed))
+		list_splice_tail(&processed, &offline_cgwbs);
+}
+
 /**
  * wb_memcg_offline - kill all wb's associated with a memcg being offlined
  * @memcg: memcg being offlined
@@ -749,6 +801,9 @@ void wb_memcg_offline(struct mem_cgroup *memcg)
 	list_for_each_entry_safe(wb, next, memcg_cgwb_list, memcg_node)
 		cgwb_kill(wb);
 	memcg_cgwb_list->next = NULL;	/* prevent new wb's */
+
+	cleanup_offline_cgwbs();
+
 	spin_unlock_irq(&cgwb_lock);
 }
 
-- 
2.21.0

