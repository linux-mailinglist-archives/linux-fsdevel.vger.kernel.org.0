Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8A33A07A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 01:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhFHXPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 19:15:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38148 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233618AbhFHXPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:15:53 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158N4wcb005784
        for <linux-fsdevel@vger.kernel.org>; Tue, 8 Jun 2021 16:13:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=axkOO9x/6aankbMHjRCuy7zetTVE8dInIT00aHgGpNE=;
 b=VWWuM6YX2SebujpNV/4dpAC3sxwRgYZ2vMWpzeR+WW6PK5f1oSksAOoUPIDgthX58BrY
 dgNTZbjwghRVZyjBjK0sZn+6hq6gUvoCVh2d2BZevo8HCpSPj3pB3lZXYPso4Ugb41JJ
 iflPi+yEMpXaL3NzOijIq6PWnHTJjehc1IA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3929n4bn0t-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jun 2021 16:13:59 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:13:57 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 52DC182542D7; Tue,  8 Jun 2021 16:02:28 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v9 7/8] writeback, cgroup: support switching multiple inodes at once
Date:   Tue, 8 Jun 2021 16:02:24 -0700
Message-ID: <20210608230225.2078447-8-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608230225.2078447-1-guro@fb.com>
References: <20210608230225.2078447-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: I99aqin9OeXf9mYuX3q-YXhBYRJbymng
X-Proofpoint-ORIG-GUID: I99aqin9OeXf9mYuX3q-YXhBYRJbymng
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_17:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=933 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106080146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently only a single inode can be switched to another writeback
structure at once. That means to switch an inode a separate
inode_switch_wbs_context structure must be allocated, and a separate
rcu callback and work must be scheduled.

It's fine for the existing ad-hoc switching, which is not happening
that often, but sub-optimal for massive switching required in order to
release a writeback structure. To prepare for it, let's add a support
for switching multiple inodes at once.

Instead of containing a single inode pointer, inode_switch_wbs_context
will contain a NULL-terminated array of inode pointers.
inode_do_switch_wbs() will be called for each inode.

To optimize the locking bdi->wb_switch_rwsem, old_wb's and new_wb's
list_locks will be acquired and released only once altogether for all
inodes. wb_wakeup() will be also be called only once. Instead of
calling wb_put(old_wb) after each successful switch, wb_put_many()
is introduced and used.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dennis Zhou <dennis@kernel.org>
---
 fs/fs-writeback.c                | 106 +++++++++++++++++++------------
 include/linux/backing-dev-defs.h |  18 +++++-
 2 files changed, 80 insertions(+), 44 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 8240eb0803dc..2d7c5e1e32e7 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -335,10 +335,18 @@ static struct bdi_writeback *inode_to_wb_and_lock_l=
ist(struct inode *inode)
 }
=20
 struct inode_switch_wbs_context {
-	struct inode		*inode;
-	struct bdi_writeback	*new_wb;
-
 	struct rcu_work		work;
+
+	/*
+	 * Multiple inodes can be switched at once.  The switching procedure
+	 * consists of two parts, separated by a RCU grace period.  To make
+	 * sure that the second part is executed for each inode gone through
+	 * the first part, all inode pointers are placed into a NULL-terminated
+	 * array embedded into struct inode_switch_wbs_context.  Otherwise
+	 * an inode could be left in a non-consistent state.
+	 */
+	struct bdi_writeback	*new_wb;
+	struct inode		*inodes[];
 };
=20
 static void bdi_down_write_wb_switch_rwsem(struct backing_dev_info *bdi)
@@ -351,39 +359,15 @@ static void bdi_up_write_wb_switch_rwsem(struct bac=
king_dev_info *bdi)
 	up_write(&bdi->wb_switch_rwsem);
 }
=20
-static void inode_do_switch_wbs(struct inode *inode,
+static bool inode_do_switch_wbs(struct inode *inode,
+				struct bdi_writeback *old_wb,
 				struct bdi_writeback *new_wb)
 {
-	struct backing_dev_info *bdi =3D inode_to_bdi(inode);
 	struct address_space *mapping =3D inode->i_mapping;
-	struct bdi_writeback *old_wb =3D inode->i_wb;
 	XA_STATE(xas, &mapping->i_pages, 0);
 	struct page *page;
 	bool switched =3D false;
=20
-	/*
-	 * If @inode switches cgwb membership while sync_inodes_sb() is
-	 * being issued, sync_inodes_sb() might miss it.  Synchronize.
-	 */
-	down_read(&bdi->wb_switch_rwsem);
-
-	/*
-	 * By the time control reaches here, RCU grace period has passed
-	 * since I_WB_SWITCH assertion and all wb stat update transactions
-	 * between unlocked_inode_to_wb_begin/end() are guaranteed to be
-	 * synchronizing against the i_pages lock.
-	 *
-	 * Grabbing old_wb->list_lock, inode->i_lock and the i_pages lock
-	 * gives us exclusion against all wb related operations on @inode
-	 * including IO list manipulations and stat updates.
-	 */
-	if (old_wb < new_wb) {
-		spin_lock(&old_wb->list_lock);
-		spin_lock_nested(&new_wb->list_lock, SINGLE_DEPTH_NESTING);
-	} else {
-		spin_lock(&new_wb->list_lock);
-		spin_lock_nested(&old_wb->list_lock, SINGLE_DEPTH_NESTING);
-	}
 	spin_lock(&inode->i_lock);
 	xa_lock_irq(&mapping->i_pages);
=20
@@ -458,25 +442,63 @@ static void inode_do_switch_wbs(struct inode *inode=
,
=20
 	xa_unlock_irq(&mapping->i_pages);
 	spin_unlock(&inode->i_lock);
-	spin_unlock(&new_wb->list_lock);
-	spin_unlock(&old_wb->list_lock);
-
-	up_read(&bdi->wb_switch_rwsem);
=20
-	if (switched) {
-		wb_wakeup(new_wb);
-		wb_put(old_wb);
-	}
+	return switched;
 }
=20
 static void inode_switch_wbs_work_fn(struct work_struct *work)
 {
 	struct inode_switch_wbs_context *isw =3D
 		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work)=
;
+	struct backing_dev_info *bdi =3D inode_to_bdi(isw->inodes[0]);
+	struct bdi_writeback *old_wb =3D isw->inodes[0]->i_wb;
+	struct bdi_writeback *new_wb =3D isw->new_wb;
+	unsigned long nr_switched =3D 0;
+	struct inode **inodep;
+
+	/*
+	 * If @inode switches cgwb membership while sync_inodes_sb() is
+	 * being issued, sync_inodes_sb() might miss it.  Synchronize.
+	 */
+	down_read(&bdi->wb_switch_rwsem);
+
+	/*
+	 * By the time control reaches here, RCU grace period has passed
+	 * since I_WB_SWITCH assertion and all wb stat update transactions
+	 * between unlocked_inode_to_wb_begin/end() are guaranteed to be
+	 * synchronizing against the i_pages lock.
+	 *
+	 * Grabbing old_wb->list_lock, inode->i_lock and the i_pages lock
+	 * gives us exclusion against all wb related operations on @inode
+	 * including IO list manipulations and stat updates.
+	 */
+	if (old_wb < new_wb) {
+		spin_lock(&old_wb->list_lock);
+		spin_lock_nested(&new_wb->list_lock, SINGLE_DEPTH_NESTING);
+	} else {
+		spin_lock(&new_wb->list_lock);
+		spin_lock_nested(&old_wb->list_lock, SINGLE_DEPTH_NESTING);
+	}
+
+	for (inodep =3D isw->inodes; *inodep; inodep++) {
+		WARN_ON_ONCE((*inodep)->i_wb !=3D old_wb);
+		if (inode_do_switch_wbs(*inodep, old_wb, new_wb))
+			nr_switched++;
+	}
+
+	spin_unlock(&new_wb->list_lock);
+	spin_unlock(&old_wb->list_lock);
+
+	up_read(&bdi->wb_switch_rwsem);
+
+	if (nr_switched) {
+		wb_wakeup(new_wb);
+		wb_put_many(old_wb, nr_switched);
+	}
=20
-	inode_do_switch_wbs(isw->inode, isw->new_wb);
-	wb_put(isw->new_wb);
-	iput(isw->inode);
+	for (inodep =3D isw->inodes; *inodep; inodep++)
+		iput(*inodep);
+	wb_put(new_wb);
 	kfree(isw);
 	atomic_dec(&isw_nr_in_flight);
 }
@@ -503,7 +525,7 @@ static void inode_switch_wbs(struct inode *inode, int=
 new_wb_id)
 	if (atomic_read(&isw_nr_in_flight) > WB_FRN_MAX_IN_FLIGHT)
 		return;
=20
-	isw =3D kzalloc(sizeof(*isw), GFP_ATOMIC);
+	isw =3D kzalloc(sizeof(*isw) + 2 * sizeof(struct inode *), GFP_ATOMIC);
 	if (!isw)
 		return;
=20
@@ -530,7 +552,7 @@ static void inode_switch_wbs(struct inode *inode, int=
 new_wb_id)
 	__iget(inode);
 	spin_unlock(&inode->i_lock);
=20
-	isw->inode =3D inode;
+	isw->inodes[0] =3D inode;
=20
 	/*
 	 * In addition to synchronizing among switchers, I_WB_SWITCH tells
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev=
-defs.h
index e5dc238ebe4f..63f52ad2ce7a 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -240,8 +240,9 @@ static inline void wb_get(struct bdi_writeback *wb)
 /**
  * wb_put - decrement a wb's refcount
  * @wb: bdi_writeback to put
+ * @nr: number of references to put
  */
-static inline void wb_put(struct bdi_writeback *wb)
+static inline void wb_put_many(struct bdi_writeback *wb, unsigned long n=
r)
 {
 	if (WARN_ON_ONCE(!wb->bdi)) {
 		/*
@@ -252,7 +253,16 @@ static inline void wb_put(struct bdi_writeback *wb)
 	}
=20
 	if (wb !=3D &wb->bdi->wb)
-		percpu_ref_put(&wb->refcnt);
+		percpu_ref_put_many(&wb->refcnt, nr);
+}
+
+/**
+ * wb_put - decrement a wb's refcount
+ * @wb: bdi_writeback to put
+ */
+static inline void wb_put(struct bdi_writeback *wb)
+{
+	wb_put_many(wb, 1);
 }
=20
 /**
@@ -281,6 +291,10 @@ static inline void wb_put(struct bdi_writeback *wb)
 {
 }
=20
+static inline void wb_put_many(struct bdi_writeback *wb, unsigned long n=
r)
+{
+}
+
 static inline bool wb_dying(struct bdi_writeback *wb)
 {
 	return false;
--=20
2.31.1

