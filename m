Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD233A0785
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 01:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhFHXJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 19:09:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54792 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234875AbhFHXJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:09:57 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 158N59ub002186
        for <linux-fsdevel@vger.kernel.org>; Tue, 8 Jun 2021 16:08:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MUAjG6PINsHwWGtBR3B+/AiuS0iPqgCmD8To4p368U0=;
 b=UZ8sYLSqX4SG/Qwhj3EMY09f0L0PTReOfqFAz4OL4N7dZcvuz3lpKqqXTaZ+fGiM/4fM
 MHnKDm6tFYlfufyDrzl3BDiIrVqZg8XwppS9oIpeX2LvlLtl2kTSTFAyE22GYrbl+5wF
 j/u2rzGh/V+tsXqggbcwIxIQWygeNq6nV5o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 391nwp9svv-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jun 2021 16:08:03 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:07:55 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 46CC182542D3; Tue,  8 Jun 2021 16:02:28 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v9 5/8] writeback, cgroup: keep list of inodes attached to bdi_writeback
Date:   Tue, 8 Jun 2021 16:02:22 -0700
Message-ID: <20210608230225.2078447-6-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608230225.2078447-1-guro@fb.com>
References: <20210608230225.2078447-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: i6NOQmjYTrzl7bc8nPAOoyilp4Txf4rz
X-Proofpoint-GUID: i6NOQmjYTrzl7bc8nPAOoyilp4Txf4rz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_17:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=385 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently there is no way to iterate over inodes attached to a
specific cgwb structure. It limits the ability to efficiently
reclaim the writeback structure itself and associated memory and
block cgroup structures without scanning all inodes belonging to a sb,
which can be prohibitively expensive.

While dirty/in-active-writeback an inode belongs to one of the
bdi_writeback's io lists: b_dirty, b_io, b_more_io and b_dirty_time.
Once cleaned up, it's removed from all io lists. So the
inode->i_io_list can be reused to maintain the list of inodes,
attached to a bdi_writeback structure.

This patch introduces a new wb->b_attached list, which contains all
inodes which were dirty at least once and are attached to the given
cgwb. Inodes attached to the root bdi_writeback structures are never
placed on such list. The following patch will use this list to try to
release cgwbs structures more efficiently.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Dennis Zhou <dennis@kernel.org>
---
 fs/fs-writeback.c                | 93 ++++++++++++++++++++------------
 include/linux/backing-dev-defs.h |  1 +
 mm/backing-dev.c                 |  2 +
 3 files changed, 62 insertions(+), 34 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 8265dccd8da5..18f4a27b8046 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -131,25 +131,6 @@ static bool inode_io_list_move_locked(struct inode *=
inode,
 	return false;
 }
=20
-/**
- * inode_io_list_del_locked - remove an inode from its bdi_writeback IO =
list
- * @inode: inode to be removed
- * @wb: bdi_writeback @inode is being removed from
- *
- * Remove @inode which may be on one of @wb->b_{dirty|io|more_io} lists =
and
- * clear %WB_has_dirty_io if all are empty afterwards.
- */
-static void inode_io_list_del_locked(struct inode *inode,
-				     struct bdi_writeback *wb)
-{
-	assert_spin_locked(&wb->list_lock);
-	assert_spin_locked(&inode->i_lock);
-
-	inode->i_state &=3D ~I_SYNC_QUEUED;
-	list_del_init(&inode->i_io_list);
-	wb_io_lists_depopulated(wb);
-}
-
 static void wb_wakeup(struct bdi_writeback *wb)
 {
 	spin_lock_bh(&wb->work_lock);
@@ -278,6 +259,28 @@ void __inode_attach_wb(struct inode *inode, struct p=
age *page)
 }
 EXPORT_SYMBOL_GPL(__inode_attach_wb);
=20
+/**
+ * inode_cgwb_move_to_attached - put the inode onto wb->b_attached list
+ * @inode: inode of interest with i_lock held
+ * @wb: target bdi_writeback
+ *
+ * Remove the inode from wb's io lists and if necessarily put onto b_att=
ached
+ * list.  Only inodes attached to cgwb's are kept on this list.
+ */
+static void inode_cgwb_move_to_attached(struct inode *inode,
+					struct bdi_writeback *wb)
+{
+	assert_spin_locked(&wb->list_lock);
+	assert_spin_locked(&inode->i_lock);
+
+	inode->i_state &=3D ~I_SYNC_QUEUED;
+	if (wb !=3D &wb->bdi->wb)
+		list_move(&inode->i_io_list, &wb->b_attached);
+	else
+		list_del_init(&inode->i_io_list);
+	wb_io_lists_depopulated(wb);
+}
+
 /**
  * locked_inode_to_wb_and_lock_list - determine a locked inode's wb and =
lock it
  * @inode: inode of interest with i_lock held
@@ -418,21 +421,28 @@ static void inode_switch_wbs_work_fn(struct work_st=
ruct *work)
 	wb_get(new_wb);
=20
 	/*
-	 * Transfer to @new_wb's IO list if necessary.  The specific list
-	 * @inode was on is ignored and the inode is put on ->b_dirty which
-	 * is always correct including from ->b_dirty_time.  The transfer
-	 * preserves @inode->dirtied_when ordering.
+	 * Transfer to @new_wb's IO list if necessary.  If the @inode is dirty,
+	 * the specific list @inode was on is ignored and the @inode is put on
+	 * ->b_dirty which is always correct including from ->b_dirty_time.
+	 * The transfer preserves @inode->dirtied_when ordering.  If the @inode
+	 * was clean, it means it was on the b_attached list, so move it onto
+	 * the b_attached list of @new_wb.
 	 */
 	if (!list_empty(&inode->i_io_list)) {
-		struct inode *pos;
-
-		inode_io_list_del_locked(inode, old_wb);
 		inode->i_wb =3D new_wb;
-		list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
-			if (time_after_eq(inode->dirtied_when,
-					  pos->dirtied_when))
-				break;
-		inode_io_list_move_locked(inode, new_wb, pos->i_io_list.prev);
+
+		if (inode->i_state & I_DIRTY_ALL) {
+			struct inode *pos;
+
+			list_for_each_entry(pos, &new_wb->b_dirty, i_io_list)
+				if (time_after_eq(inode->dirtied_when,
+						  pos->dirtied_when))
+					break;
+			inode_io_list_move_locked(inode, new_wb,
+						  pos->i_io_list.prev);
+		} else {
+			inode_cgwb_move_to_attached(inode, new_wb);
+		}
 	} else {
 		inode->i_wb =3D new_wb;
 	}
@@ -1021,6 +1031,17 @@ fs_initcall(cgroup_writeback_init);
 static void bdi_down_write_wb_switch_rwsem(struct backing_dev_info *bdi)=
 { }
 static void bdi_up_write_wb_switch_rwsem(struct backing_dev_info *bdi) {=
 }
=20
+static void inode_cgwb_move_to_attached(struct inode *inode,
+					struct bdi_writeback *wb)
+{
+	assert_spin_locked(&wb->list_lock);
+	assert_spin_locked(&inode->i_lock);
+
+	inode->i_state &=3D ~I_SYNC_QUEUED;
+	list_del_init(&inode->i_io_list);
+	wb_io_lists_depopulated(wb);
+}
+
 static struct bdi_writeback *
 locked_inode_to_wb_and_lock_list(struct inode *inode)
 	__releases(&inode->i_lock)
@@ -1121,7 +1142,11 @@ void inode_io_list_del(struct inode *inode)
=20
 	wb =3D inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
-	inode_io_list_del_locked(inode, wb);
+
+	inode->i_state &=3D ~I_SYNC_QUEUED;
+	list_del_init(&inode->i_io_list);
+	wb_io_lists_depopulated(wb);
+
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&wb->list_lock);
 }
@@ -1434,7 +1459,7 @@ static void requeue_inode(struct inode *inode, stru=
ct bdi_writeback *wb,
 		inode->i_state &=3D ~I_SYNC_QUEUED;
 	} else {
 		/* The inode is clean. Remove from writeback lists. */
-		inode_io_list_del_locked(inode, wb);
+		inode_cgwb_move_to_attached(inode, wb);
 	}
 }
=20
@@ -1586,7 +1611,7 @@ static int writeback_single_inode(struct inode *ino=
de,
 	 * responsible for the writeback lists.
 	 */
 	if (!(inode->i_state & I_DIRTY_ALL))
-		inode_io_list_del_locked(inode, wb);
+		inode_cgwb_move_to_attached(inode, wb);
 	spin_unlock(&wb->list_lock);
 	inode_sync_complete(inode);
 out:
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev=
-defs.h
index fff9367a6348..e5dc238ebe4f 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -154,6 +154,7 @@ struct bdi_writeback {
 	struct cgroup_subsys_state *blkcg_css; /* and blkcg */
 	struct list_head memcg_node;	/* anchored at memcg->cgwb_list */
 	struct list_head blkcg_node;	/* anchored at blkcg->cgwb_list */
+	struct list_head b_attached;	/* attached inodes, protected by list_lock=
 */
=20
 	union {
 		struct work_struct release_work;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 576220acd686..54c5dc4b8c24 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -396,6 +396,7 @@ static void cgwb_release_workfn(struct work_struct *w=
ork)
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 	percpu_ref_exit(&wb->refcnt);
 	wb_exit(wb);
+	WARN_ON_ONCE(!list_empty(&wb->b_attached));
 	kfree_rcu(wb, rcu);
 }
=20
@@ -472,6 +473,7 @@ static int cgwb_create(struct backing_dev_info *bdi,
=20
 	wb->memcg_css =3D memcg_css;
 	wb->blkcg_css =3D blkcg_css;
+	INIT_LIST_HEAD(&wb->b_attached);
 	INIT_WORK(&wb->release_work, cgwb_release_workfn);
 	set_bit(WB_registered, &wb->state);
=20
--=20
2.31.1

