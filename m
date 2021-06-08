Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4FD3A07A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 01:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhFHXQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 19:16:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51994 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235400AbhFHXQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:16:08 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158NEAcm025258
        for <linux-fsdevel@vger.kernel.org>; Tue, 8 Jun 2021 16:14:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=suAdtI0mUr0NgYHSsmrZzr/Gvyno3LP91rYdqG1JjOQ=;
 b=Zn0IZuQdhzep9I1eSaWtlIq0ULw0THUDIY/lG2PbbTv04LtIsWaDfhlqZjvdBbF5kAPq
 2GlGA5zIZOSwO30RMWzdaNsKQVqeXjirGBD8N3aQmZ7rWQgX1Xp5KHPKOxVw66g5rcmK
 YsKnlqw73LYejdNDl+lzb5b37wK8dibCERY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 391mx0tf05-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jun 2021 16:14:14 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:14:04 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 5A99082542DD; Tue,  8 Jun 2021 16:02:28 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v9 8/8] writeback, cgroup: release dying cgwbs by switching attached inodes
Date:   Tue, 8 Jun 2021 16:02:25 -0700
Message-ID: <20210608230225.2078447-9-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608230225.2078447-1-guro@fb.com>
References: <20210608230225.2078447-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WWA2nxEY67ZusgFlp3G069pwazpdcimd
X-Proofpoint-ORIG-GUID: WWA2nxEY67ZusgFlp3G069pwazpdcimd
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_17:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=443 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106080147
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Asynchronously try to release dying cgwbs by switching attached inodes
to the nearest living ancestor wb. It helps to get rid of per-cgroup
writeback structures themselves and of pinned memory and block cgroups,
which are significantly larger structures (mostly due to large per-cpu
statistics data). This prevents memory waste and helps to avoid
different scalability problems caused by large piles of dying cgroups.

Reuse the existing mechanism of inode switching used for foreign inode
detection. To speed things up batch up to 115 inode switching in a
single operation (the maximum number is selected so that the resulting
struct inode_switch_wbs_context can fit into 1024 bytes). Because
every switching consists of two steps divided by an RCU grace period,
it would be too slow without batching. Please note that the whole
batch counts as a single operation (when increasing/decreasing
isw_nr_in_flight). This allows to keep umounting working (flush the
switching queue), however prevents cleanups from consuming the whole
switching quota and effectively blocking the frn switching.

A cgwb cleanup operation can fail due to different reasons (e.g. not
enough memory, the cgwb has an in-flight/pending io, an attached inode
in a wrong state, etc). In this case the next scheduled cleanup will
make a new attempt. An attempt is made each time a new cgwb is offlined
(in other words a memcg and/or a blkcg is deleted by a user). In the
future an additional attempt scheduled by a timer can be implemented.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c                | 102 ++++++++++++++++++++++++++++---
 include/linux/backing-dev-defs.h |   1 +
 include/linux/writeback.h        |   1 +
 mm/backing-dev.c                 |  67 +++++++++++++++++++-
 4 files changed, 159 insertions(+), 12 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 2d7c5e1e32e7..49b33300b1b8 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -225,6 +225,12 @@ void wb_wait_for_completion(struct wb_completion *do=
ne)
 					/* one round can affect upto 5 slots */
 #define WB_FRN_MAX_IN_FLIGHT	1024	/* don't queue too many concurrently *=
/
=20
+/*
+ * Maximum inodes per isw.  A specific value has been chosen to make
+ * struct inode_switch_wbs_context fit into 1024 bytes kmalloc.
+ */
+#define WB_MAX_INODES_PER_ISW	115
+
 static atomic_t isw_nr_in_flight =3D ATOMIC_INIT(0);
 static struct workqueue_struct *isw_wq;
=20
@@ -503,6 +509,24 @@ static void inode_switch_wbs_work_fn(struct work_str=
uct *work)
 	atomic_dec(&isw_nr_in_flight);
 }
=20
+static bool inode_prepare_wbs_switch(struct inode *inode,
+				     struct bdi_writeback *new_wb)
+{
+	/* while holding I_WB_SWITCH, no one else can update the association */
+	spin_lock(&inode->i_lock);
+	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
+	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
+	    inode_to_wb(inode) =3D=3D new_wb) {
+		spin_unlock(&inode->i_lock);
+		return false;
+	}
+	inode->i_state |=3D I_WB_SWITCH;
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
+
+	return true;
+}
+
 /**
  * inode_switch_wbs - change the wb association of an inode
  * @inode: target inode
@@ -540,17 +564,8 @@ static void inode_switch_wbs(struct inode *inode, in=
t new_wb_id)
 	if (!isw->new_wb)
 		goto out_free;
=20
-	/* while holding I_WB_SWITCH, no one else can update the association */
-	spin_lock(&inode->i_lock);
-	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
-	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
-	    inode_to_wb(inode) =3D=3D isw->new_wb) {
-		spin_unlock(&inode->i_lock);
+	if (!inode_prepare_wbs_switch(inode, isw->new_wb))
 		goto out_free;
-	}
-	inode->i_state |=3D I_WB_SWITCH;
-	__iget(inode);
-	spin_unlock(&inode->i_lock);
=20
 	isw->inodes[0] =3D inode;
=20
@@ -571,6 +586,73 @@ static void inode_switch_wbs(struct inode *inode, in=
t new_wb_id)
 	kfree(isw);
 }
=20
+/**
+ * cleanup_offline_cgwb - detach associated inodes
+ * @wb: target wb
+ *
+ * Switch all inodes attached to @wb to a nearest living ancestor's wb i=
n order
+ * to eventually release the dying @wb.  Returns %true if not all inodes=
 were
+ * switched and the function has to be restarted.
+ */
+bool cleanup_offline_cgwb(struct bdi_writeback *wb)
+{
+	struct cgroup_subsys_state *memcg_css;
+	struct inode_switch_wbs_context *isw;
+	struct inode *inode;
+	int nr;
+	bool restart =3D false;
+
+	isw =3D kzalloc(sizeof(*isw) + WB_MAX_INODES_PER_ISW *
+		      sizeof(struct inode *), GFP_KERNEL);
+	if (!isw)
+		return restart;
+
+	atomic_inc(&isw_nr_in_flight);
+
+	for (memcg_css =3D wb->memcg_css->parent; memcg_css;
+	     memcg_css =3D memcg_css->parent) {
+		isw->new_wb =3D wb_get_create(wb->bdi, memcg_css, GFP_KERNEL);
+		if (isw->new_wb)
+			break;
+	}
+	if (unlikely(!isw->new_wb))
+		isw->new_wb =3D &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
+
+	nr =3D 0;
+	spin_lock(&wb->list_lock);
+	list_for_each_entry(inode, &wb->b_attached, i_io_list) {
+		if (!inode_prepare_wbs_switch(inode, isw->new_wb))
+			continue;
+
+		isw->inodes[nr++] =3D inode;
+
+		if (nr >=3D WB_MAX_INODES_PER_ISW - 1) {
+			restart =3D true;
+			break;
+		}
+	}
+	spin_unlock(&wb->list_lock);
+
+	/* no attached inodes? bail out */
+	if (nr =3D=3D 0) {
+		atomic_dec(&isw_nr_in_flight);
+		wb_put(isw->new_wb);
+		kfree(isw);
+		return restart;
+	}
+
+	/*
+	 * In addition to synchronizing among switchers, I_WB_SWITCH tells
+	 * the RCU protected stat update paths to grab the i_page
+	 * lock so that stat transfer can synchronize against them.
+	 * Let's continue after I_WB_SWITCH is guaranteed to be visible.
+	 */
+	INIT_RCU_WORK(&isw->work, inode_switch_wbs_work_fn);
+	queue_rcu_work(isw_wq, &isw->work);
+
+	return restart;
+}
+
 /**
  * wbc_attach_and_unlock_inode - associate wbc with target inode and unl=
ock it
  * @wbc: writeback_control of interest
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev=
-defs.h
index 63f52ad2ce7a..1d7edad9914f 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -155,6 +155,7 @@ struct bdi_writeback {
 	struct list_head memcg_node;	/* anchored at memcg->cgwb_list */
 	struct list_head blkcg_node;	/* anchored at blkcg->cgwb_list */
 	struct list_head b_attached;	/* attached inodes, protected by list_lock=
 */
+	struct list_head offline_node;	/* anchored at offline_cgwbs */
=20
 	union {
 		struct work_struct release_work;
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 9ef50176f3a1..667e86cfbdcf 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -221,6 +221,7 @@ void wbc_account_cgroup_owner(struct writeback_contro=
l *wbc, struct page *page,
 int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_pa=
ges,
 			   enum wb_reason reason, struct wb_completion *done);
 void cgroup_writeback_umount(void);
+bool cleanup_offline_cgwb(struct bdi_writeback *wb);
=20
 /**
  * inode_attach_wb - associate an inode with its wb
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 54c5dc4b8c24..52eaeee40da3 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -371,12 +371,16 @@ static void wb_exit(struct bdi_writeback *wb)
 #include <linux/memcontrol.h>
=20
 /*
- * cgwb_lock protects bdi->cgwb_tree, blkcg->cgwb_list, and memcg->cgwb_=
list.
- * bdi->cgwb_tree is also RCU protected.
+ * cgwb_lock protects bdi->cgwb_tree, blkcg->cgwb_list, offline_cgwbs an=
d
+ * memcg->cgwb_list.  bdi->cgwb_tree is also RCU protected.
  */
 static DEFINE_SPINLOCK(cgwb_lock);
 static struct workqueue_struct *cgwb_release_wq;
=20
+static LIST_HEAD(offline_cgwbs);
+static void cleanup_offline_cgwbs_workfn(struct work_struct *work);
+static DECLARE_WORK(cleanup_offline_cgwbs_work, cleanup_offline_cgwbs_wo=
rkfn);
+
 static void cgwb_release_workfn(struct work_struct *work)
 {
 	struct bdi_writeback *wb =3D container_of(work, struct bdi_writeback,
@@ -395,6 +399,11 @@ static void cgwb_release_workfn(struct work_struct *=
work)
=20
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 	percpu_ref_exit(&wb->refcnt);
+
+	spin_lock_irq(&cgwb_lock);
+	list_del(&wb->offline_node);
+	spin_unlock_irq(&cgwb_lock);
+
 	wb_exit(wb);
 	WARN_ON_ONCE(!list_empty(&wb->b_attached));
 	kfree_rcu(wb, rcu);
@@ -414,6 +423,7 @@ static void cgwb_kill(struct bdi_writeback *wb)
 	WARN_ON(!radix_tree_delete(&wb->bdi->cgwb_tree, wb->memcg_css->id));
 	list_del(&wb->memcg_node);
 	list_del(&wb->blkcg_node);
+	list_add(&wb->offline_node, &offline_cgwbs);
 	percpu_ref_kill(&wb->refcnt);
 }
=20
@@ -635,6 +645,57 @@ static void cgwb_bdi_unregister(struct backing_dev_i=
nfo *bdi)
 	mutex_unlock(&bdi->cgwb_release_mutex);
 }
=20
+/**
+ * cleanup_offline_cgwbs - try to release dying cgwbs
+ *
+ * Try to release dying cgwbs by switching attached inodes to the neares=
t
+ * living ancestor's writeback. Processed wbs are placed at the end
+ * of the list to guarantee the forward progress.
+ *
+ * Should be called with the acquired cgwb_lock lock, which might
+ * be released and re-acquired in the process.
+ */
+static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
+{
+	struct bdi_writeback *wb;
+	LIST_HEAD(processed);
+
+	spin_lock_irq(&cgwb_lock);
+
+	while (!list_empty(&offline_cgwbs)) {
+		wb =3D list_first_entry(&offline_cgwbs, struct bdi_writeback,
+				      offline_node);
+		list_move(&wb->offline_node, &processed);
+
+		/*
+		 * If wb is dirty, cleaning up the writeback by switching
+		 * attached inodes will result in an effective removal of any
+		 * bandwidth restrictions, which isn't the goal.  Instead,
+		 * it can be postponed until the next time, when all io
+		 * will be likely completed.  If in the meantime some inodes
+		 * will get re-dirtied, they should be eventually switched to
+		 * a new cgwb.
+		 */
+		if (wb_has_dirty_io(wb))
+			continue;
+
+		if (!wb_tryget(wb))
+			continue;
+
+		spin_unlock_irq(&cgwb_lock);
+		while (cleanup_offline_cgwb(wb))
+			cond_resched();
+		spin_lock_irq(&cgwb_lock);
+
+		wb_put(wb);
+	}
+
+	if (!list_empty(&processed))
+		list_splice_tail(&processed, &offline_cgwbs);
+
+	spin_unlock_irq(&cgwb_lock);
+}
+
 /**
  * wb_memcg_offline - kill all wb's associated with a memcg being offlin=
ed
  * @memcg: memcg being offlined
@@ -651,6 +712,8 @@ void wb_memcg_offline(struct mem_cgroup *memcg)
 		cgwb_kill(wb);
 	memcg_cgwb_list->next =3D NULL;	/* prevent new wb's */
 	spin_unlock_irq(&cgwb_lock);
+
+	queue_work(system_unbound_wq, &cleanup_offline_cgwbs_work);
 }
=20
 /**
--=20
2.31.1

