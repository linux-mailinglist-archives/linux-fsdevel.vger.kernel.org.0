Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8DC399747
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 02:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhFCA5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 20:57:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64766 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229751AbhFCA5N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:57:13 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1530rU7K019135
        for <linux-fsdevel@vger.kernel.org>; Wed, 2 Jun 2021 17:55:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=0fG4JLk1fyAoxam5ZuE7kbueuZi+wYFcd9kOUAD9PBw=;
 b=SYfn/GSYyxZhSrWwYQ4JKXq4f6GHnd9PUPaqrimtMP2iIuTPdqV0HpkYx9t4YCf5rzLy
 4Kn03BmNUXNvifLSu5I3OBjMsg52Rax2SW/1yidtOf9Ie6XA7D99JDDkxUXBn5o+o/Jq
 SyrcudpT1vKUJFHjufWmX9clhcR56qhBLhQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38xjg0gvcu-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jun 2021 17:55:29 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:55:27 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id AB1DA7F192AC; Wed,  2 Jun 2021 17:55:22 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v6 5/5] writeback, cgroup: release dying cgwbs by switching attached inodes
Date:   Wed, 2 Jun 2021 17:55:17 -0700
Message-ID: <20210603005517.1403689-6-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603005517.1403689-1-guro@fb.com>
References: <20210603005517.1403689-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: m00N1enpJbisYKywfDhtLADJRQDpCv3x
X-Proofpoint-ORIG-GUID: m00N1enpJbisYKywfDhtLADJRQDpCv3x
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_11:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 mlxlogscore=686 bulkscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Asynchronously try to release dying cgwbs by switching attached inodes
to the bdi's wb. It helps to get rid of per-cgroup writeback
structures themselves and of pinned memory and block cgroups, which
are significantly larger structures (mostly due to large per-cpu
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
---
 fs/fs-writeback.c                | 68 ++++++++++++++++++++++++++++++++
 include/linux/backing-dev-defs.h |  1 +
 include/linux/writeback.h        |  1 +
 mm/backing-dev.c                 | 58 ++++++++++++++++++++++++++-
 4 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 49d7b23a7cfe..e8517ad677eb 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -225,6 +225,8 @@ void wb_wait_for_completion(struct wb_completion *don=
e)
 					/* one round can affect upto 5 slots */
 #define WB_FRN_MAX_IN_FLIGHT	1024	/* don't queue too many concurrently *=
/
=20
+#define WB_MAX_INODES_PER_ISW	116	/* maximum inodes per isw */
+
 static atomic_t isw_nr_in_flight =3D ATOMIC_INIT(0);
 static struct workqueue_struct *isw_wq;
=20
@@ -552,6 +554,72 @@ static void inode_switch_wbs(struct inode *inode, in=
t new_wb_id)
 	kfree(isw);
 }
=20
+/**
+ * cleanup_offline_cgwb - detach associated inodes
+ * @wb: target wb
+ *
+ * Switch all inodes attached to @wb to the bdi's root wb in order to ev=
entually
+ * release the dying @wb.  Returns %true if not all inodes were switched=
 and
+ * the function has to be restarted.
+ */
+bool cleanup_offline_cgwb(struct bdi_writeback *wb)
+{
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
+	/* no need to call wb_get() here: bdi's root wb is not refcounted */
+	isw->new_wb =3D &wb->bdi->wb;
+
+	nr =3D 0;
+	spin_lock(&wb->list_lock);
+	list_for_each_entry(inode, &wb->b_attached, i_io_list) {
+		spin_lock(&inode->i_lock);
+		if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
+		    inode->i_state & (I_WB_SWITCH | I_FREEING) ||
+		    inode_to_wb(inode) =3D=3D isw->new_wb) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+		inode->i_state |=3D I_WB_SWITCH;
+		__iget(inode);
+		spin_unlock(&inode->i_lock);
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
+	atomic_inc(&isw_nr_in_flight);
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
index e5dc238ebe4f..07d6b6d6dbdf 100644
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
index 8e5c5bb16e2d..95de51c10248 100644
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
index 54c5dc4b8c24..f1fc04412bd7 100644
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
@@ -635,6 +645,48 @@ static void cgwb_bdi_unregister(struct backing_dev_i=
nfo *bdi)
 	mutex_unlock(&bdi->cgwb_release_mutex);
 }
=20
+/**
+ * cleanup_offline_cgwbs - try to release dying cgwbs
+ *
+ * Try to release dying cgwbs by switching attached inodes to the wb
+ * belonging to the root memory cgroup. Processed wbs are placed at the
+ * end of the list to guarantee the forward progress.
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
+		if (wb_has_dirty_io(wb))
+			continue;
+
+		if (!wb_tryget(wb))
+			continue;
+
+		spin_unlock_irq(&cgwb_lock);
+		while ((cleanup_offline_cgwb(wb)))
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
@@ -651,6 +703,8 @@ void wb_memcg_offline(struct mem_cgroup *memcg)
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

