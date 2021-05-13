Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56AE37F09F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 02:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhEMArC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 20:47:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236497AbhEMAoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 20:44:23 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14D0VaDD015395
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 17:43:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=XVKZCM0hTdKOjDP1wMWYQBm0tSdwZVIy/h93ls22Sxc=;
 b=KTioC8sMXIyEGXyrdf7UWTFJG1swRldbb1EYbrxI8M9fXEVNwOq8WI9beOVJoIKtBxj/
 S7Dr1r0UOFMevhsnH87X/I7frB415xSBGIEQ/W0nbcc7i3+avGqqlca3oZhJSp46kNdC
 /FvU8wvlUCDHOSxw3SiANr6XowpnfrnvaFw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38gpm8s0t1-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 17:43:10 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 12 May 2021 17:43:05 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 6893A73472C7; Wed, 12 May 2021 17:43:01 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v4] cgroup, blkcg: prevent dirty inodes to pin dying memory cgroups
Date:   Wed, 12 May 2021 17:42:58 -0700
Message-ID: <20210513004258.1610273-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9OplOiRs3DaYtOpjINGZBo6YwtD0zTJQ
X-Proofpoint-GUID: 9OplOiRs3DaYtOpjINGZBo6YwtD0zTJQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_13:2021-05-12,2021-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When an inode is getting dirty for the first time it's associated
with a wb structure (see __inode_attach_wb()). It can later be
switched to another wb (if e.g. some other cgroup is writing a lot of
data to the same inode), but otherwise stays attached to the original
wb until being reclaimed.

The problem is that the wb structure holds a reference to the original
memory and blkcg cgroups. So if an inode has been dirty once and later
is actively used in read-only mode, it has a good chance to pin down
the original memory and blkcg cgroups. This is often the case with
services bringing data for other services, e.g. updating some rpm
packages.

In the real life it becomes a problem due to a large size of the memcg
structure, which can easily be 1000x larger than an inode. Also a
really large number of dying cgroups can raise different scalability
issues, e.g. making the memory reclaim costly and less effective.

To solve the problem inodes should be eventually detached from the
corresponding writeback structure. It's inefficient to do it after
every writeback completion. Instead it can be done whenever the
original memory cgroup is offlined and writeback structure is getting
killed. Scanning over a (potentially long) list of inodes and detach
them from the writeback structure can take quite some time. To avoid
scanning all inodes, attached inodes are kept on a new list (b_attached).
To make it less noticeable to a user, the scanning is performed from a
work context.

Big thanks to Jan Kara and Dennis Zhou for their ideas and
contribution to the previous iterations of this patch.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 fs/fs-writeback.c                | 84 ++++++++++++++++++++++++--------
 include/linux/backing-dev-defs.h |  4 ++
 include/linux/backing-dev.h      | 17 -------
 include/linux/writeback.h        |  1 +
 mm/backing-dev.c                 | 68 ++++++++++++++++++++++++--
 5 files changed, 132 insertions(+), 42 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e91980f49388..3deba686d3d4 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -109,10 +109,10 @@ static void wb_io_lists_depopulated(struct bdi_writ=
eback *wb)
  * inode_io_list_move_locked - move an inode onto a bdi_writeback IO lis=
t
  * @inode: inode to be moved
  * @wb: target bdi_writeback
- * @head: one of @wb->b_{dirty|io|more_io|dirty_time}
+ * @head: one of @wb->b_{dirty|io|more_io|dirty_time|attached}
  *
  * Move @inode->i_io_list to @list of @wb and set %WB_has_dirty_io.
- * Returns %true if @inode is the first occupant of the !dirty_time IO
+ * Returns %true if @inode is the first occupant of the dirty, io or mor=
e_io
  * lists; otherwise, %false.
  */
 static bool inode_io_list_move_locked(struct inode *inode,
@@ -123,12 +123,17 @@ static bool inode_io_list_move_locked(struct inode =
*inode,
=20
 	list_move(&inode->i_io_list, head);
=20
-	/* dirty_time doesn't count as dirty_io until expiration */
-	if (head !=3D &wb->b_dirty_time)
-		return wb_io_lists_populated(wb);
+	if (head =3D=3D &wb->b_dirty_time || head =3D=3D &wb->b_attached) {
+		/*
+		 * dirty_time doesn't count as dirty_io until expiration,
+		 * attached list keeps a list of clean inodes, which are
+		 * attached to wb.
+		 */
+		wb_io_lists_depopulated(wb);
+		return false;
+	}
=20
-	wb_io_lists_depopulated(wb);
-	return false;
+	return wb_io_lists_populated(wb);
 }
=20
 /**
@@ -545,6 +550,37 @@ static void inode_switch_wbs(struct inode *inode, in=
t new_wb_id)
 	kfree(isw);
 }
=20
+/**
+ * cleanup_offline_wb - detach attached clean inodes
+ * @wb: target wb
+ *
+ * Clear the ->i_wb pointer of the attached inodes and drop
+ * the corresponding wb reference. Skip inodes which are dirty,
+ * freeing, switching or in the active writeback process.
+ *
+ */
+void cleanup_offline_wb(struct bdi_writeback *wb)
+{
+	struct inode *inode, *tmp;
+
+	spin_lock(&wb->list_lock);
+	list_for_each_entry_safe(inode, tmp, &wb->b_attached, i_io_list) {
+		if (!spin_trylock(&inode->i_lock))
+			continue;
+		xa_lock_irq(&inode->i_mapping->i_pages);
+		if (!(inode->i_state &
+		      (I_FREEING | I_CLEAR | I_SYNC | I_DIRTY | I_WB_SWITCH))) {
+			WARN_ON_ONCE(inode->i_wb !=3D wb);
+			inode->i_wb =3D NULL;
+			wb_put(wb);
+			list_del_init(&inode->i_io_list);
+		}
+		xa_unlock_irq(&inode->i_mapping->i_pages);
+		spin_unlock(&inode->i_lock);
+	}
+	spin_unlock(&wb->list_lock);
+}
+
 /**
  * wbc_attach_and_unlock_inode - associate wbc with target inode and unl=
ock it
  * @wbc: writeback_control of interest
@@ -779,19 +815,18 @@ EXPORT_SYMBOL_GPL(wbc_account_cgroup_owner);
  */
 int inode_congested(struct inode *inode, int cong_bits)
 {
-	/*
-	 * Once set, ->i_wb never becomes NULL while the inode is alive.
-	 * Start transaction iff ->i_wb is visible.
-	 */
-	if (inode && inode_to_wb_is_valid(inode)) {
+	if (inode) {
 		struct bdi_writeback *wb;
 		struct wb_lock_cookie lock_cookie =3D {};
 		bool congested;
=20
 		wb =3D unlocked_inode_to_wb_begin(inode, &lock_cookie);
-		congested =3D wb_congested(wb, cong_bits);
+		if (wb) {
+			congested =3D wb_congested(wb, cong_bits);
+			unlocked_inode_to_wb_end(inode, &lock_cookie);
+			return congested;
+		}
 		unlocked_inode_to_wb_end(inode, &lock_cookie);
-		return congested;
 	}
=20
 	return wb_congested(&inode_to_bdi(inode)->wb, cong_bits);
@@ -1436,8 +1471,13 @@ static void requeue_inode(struct inode *inode, str=
uct bdi_writeback *wb,
 		inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
 		inode->i_state &=3D ~I_SYNC_QUEUED;
 	} else {
-		/* The inode is clean. Remove from writeback lists. */
-		inode_io_list_del_locked(inode, wb);
+		/*
+		 * The inode is clean. Remove from writeback lists and
+		 * move it to the attached list, because the inode is
+		 * still attached to wb.
+		 */
+		inode_io_list_move_locked(inode, wb, &wb->b_attached);
+		inode->i_state &=3D ~I_SYNC_QUEUED;
 	}
 }
=20
@@ -1584,12 +1624,14 @@ static int writeback_single_inode(struct inode *i=
node,
 	wb =3D inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 	/*
-	 * If the inode is now fully clean, then it can be safely removed from
-	 * its writeback list (if any).  Otherwise the flusher threads are
-	 * responsible for the writeback lists.
+	 * If inode is clean, remove it from writeback lists and put into
+	 * the attached list. Otherwise don't touch it. See comment above
+	 * for explanation.
 	 */
-	if (!(inode->i_state & I_DIRTY_ALL))
-		inode_io_list_del_locked(inode, wb);
+	if (!(inode->i_state & I_DIRTY_ALL)) {
+		inode_io_list_move_locked(inode, wb, &wb->b_attached);
+		inode->i_state &=3D ~I_SYNC_QUEUED;
+	}
 	spin_unlock(&wb->list_lock);
 	inode_sync_complete(inode);
 out:
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev=
-defs.h
index fff9367a6348..fb49434be4eb 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -114,6 +114,9 @@ struct bdi_writeback {
 	struct list_head b_io;		/* parked for writeback */
 	struct list_head b_more_io;	/* parked for more writeback */
 	struct list_head b_dirty_time;	/* time stamps are dirty */
+	struct list_head b_attached;	/* clean inodes pinning this wb
+					 * though inode->i_wb
+					 */
 	spinlock_t list_lock;		/* protects the b_* lists */
=20
 	struct percpu_counter stat[NR_WB_STAT_ITEMS];
@@ -154,6 +157,7 @@ struct bdi_writeback {
 	struct cgroup_subsys_state *blkcg_css; /* and blkcg */
 	struct list_head memcg_node;	/* anchored at memcg->cgwb_list */
 	struct list_head blkcg_node;	/* anchored at blkcg->cgwb_list */
+	struct list_head offline_node;
=20
 	union {
 		struct work_struct release_work;
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 44df4fcef65c..cca7eb0e602d 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -257,18 +257,6 @@ wb_get_create_current(struct backing_dev_info *bdi, =
gfp_t gfp)
 	return wb;
 }
=20
-/**
- * inode_to_wb_is_valid - test whether an inode has a wb associated
- * @inode: inode of interest
- *
- * Returns %true if @inode has a wb associated.  May be called without a=
ny
- * locking.
- */
-static inline bool inode_to_wb_is_valid(struct inode *inode)
-{
-	return inode->i_wb;
-}
-
 /**
  * inode_to_wb - determine the wb of an inode
  * @inode: inode of interest
@@ -356,11 +344,6 @@ wb_get_create_current(struct backing_dev_info *bdi, =
gfp_t gfp)
 	return &bdi->wb;
 }
=20
-static inline bool inode_to_wb_is_valid(struct inode *inode)
-{
-	return true;
-}
-
 static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
 {
 	return &inode_to_bdi(inode)->wb;
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 8e5c5bb16e2d..8ed76e7d54db 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -221,6 +221,7 @@ void wbc_account_cgroup_owner(struct writeback_contro=
l *wbc, struct page *page,
 int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_pa=
ges,
 			   enum wb_reason reason, struct wb_completion *done);
 void cgroup_writeback_umount(void);
+void cleanup_offline_wb(struct bdi_writeback *wb);
=20
 /**
  * inode_attach_wb - associate an inode with its wb
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 576220acd686..2176c5199c0d 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -53,10 +53,10 @@ static int bdi_debug_stats_show(struct seq_file *m, v=
oid *v)
 	unsigned long background_thresh;
 	unsigned long dirty_thresh;
 	unsigned long wb_thresh;
-	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time;
+	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time, nr_attached;
 	struct inode *inode;
=20
-	nr_dirty =3D nr_io =3D nr_more_io =3D nr_dirty_time =3D 0;
+	nr_dirty =3D nr_io =3D nr_more_io =3D nr_dirty_time =3D nr_attached =3D=
 0;
 	spin_lock(&wb->list_lock);
 	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
 		nr_dirty++;
@@ -67,6 +67,8 @@ static int bdi_debug_stats_show(struct seq_file *m, voi=
d *v)
 	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
 		if (inode->i_state & I_DIRTY_TIME)
 			nr_dirty_time++;
+	list_for_each_entry(inode, &wb->b_attached, i_io_list)
+		nr_attached++;
 	spin_unlock(&wb->list_lock);
=20
 	global_dirty_limits(&background_thresh, &dirty_thresh);
@@ -85,6 +87,7 @@ static int bdi_debug_stats_show(struct seq_file *m, voi=
d *v)
 		   "b_io:               %10lu\n"
 		   "b_more_io:          %10lu\n"
 		   "b_dirty_time:       %10lu\n"
+		   "b_attached:         %10lu\n"
 		   "bdi_list:           %10u\n"
 		   "state:              %10lx\n",
 		   (unsigned long) K(wb_stat(wb, WB_WRITEBACK)),
@@ -99,6 +102,7 @@ static int bdi_debug_stats_show(struct seq_file *m, vo=
id *v)
 		   nr_io,
 		   nr_more_io,
 		   nr_dirty_time,
+		   nr_attached,
 		   !list_empty(&bdi->bdi_list), bdi->wb.state);
=20
 	return 0;
@@ -291,6 +295,7 @@ static int wb_init(struct bdi_writeback *wb, struct b=
acking_dev_info *bdi,
 	INIT_LIST_HEAD(&wb->b_io);
 	INIT_LIST_HEAD(&wb->b_more_io);
 	INIT_LIST_HEAD(&wb->b_dirty_time);
+	INIT_LIST_HEAD(&wb->b_attached);
 	spin_lock_init(&wb->list_lock);
=20
 	wb->bw_time_stamp =3D jiffies;
@@ -371,12 +376,16 @@ static void wb_exit(struct bdi_writeback *wb)
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
@@ -386,6 +395,10 @@ static void cgwb_release_workfn(struct work_struct *=
work)
 	mutex_lock(&wb->bdi->cgwb_release_mutex);
 	wb_shutdown(wb);
=20
+	spin_lock_irq(&cgwb_lock);
+	list_del(&wb->offline_node);
+	spin_unlock_irq(&cgwb_lock);
+
 	css_put(wb->memcg_css);
 	css_put(wb->blkcg_css);
 	mutex_unlock(&wb->bdi->cgwb_release_mutex);
@@ -413,6 +426,7 @@ static void cgwb_kill(struct bdi_writeback *wb)
 	WARN_ON(!radix_tree_delete(&wb->bdi->cgwb_tree, wb->memcg_css->id));
 	list_del(&wb->memcg_node);
 	list_del(&wb->blkcg_node);
+	list_add(&wb->offline_node, &offline_cgwbs);
 	percpu_ref_kill(&wb->refcnt);
 }
=20
@@ -633,6 +647,48 @@ static void cgwb_bdi_unregister(struct backing_dev_i=
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
+
+		list_move(&wb->offline_node, &processed);
+
+		if (wb_has_dirty_io(wb))
+			continue;
+
+		if (!percpu_ref_tryget(&wb->refcnt))
+			continue;
+
+		spin_unlock_irq(&cgwb_lock);
+		cleanup_offline_wb(wb);
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
@@ -648,6 +704,10 @@ void wb_memcg_offline(struct mem_cgroup *memcg)
 	list_for_each_entry_safe(wb, next, memcg_cgwb_list, memcg_node)
 		cgwb_kill(wb);
 	memcg_cgwb_list->next =3D NULL;	/* prevent new wb's */
+
+	if (!list_empty(&offline_cgwbs))
+		schedule_work(&cleanup_offline_cgwbs_work);
+
 	spin_unlock_irq(&cgwb_lock);
 }
=20
--=20
2.30.2

