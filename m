Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B329439AFD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 03:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhFDBeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 21:34:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7832 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230254AbhFDBeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:34:06 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1541TnRb027130
        for <linux-fsdevel@vger.kernel.org>; Thu, 3 Jun 2021 18:32:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Vqxf7pouF2HKQvdyKweAIE4k/gI6eWJAR2yrnONWQ3Y=;
 b=oZog3uVIc/Ze1zoMZIC1+Ab165b3GB2udTBifTFmT9Jsr16PpJY7xEZ3o7+GJM+oWLFK
 I5Rf8TG+ohagEpJSbx5O6nhuP1KzSPgPxYsRepYTWJQ5N+5AMipO1vPs3le2RGueJSNy
 3WiUXdJeq5pd+KUf4xDX1naxMnlQoDxfsFM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38xtkjwjnt-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jun 2021 18:32:20 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 18:32:04 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 787307FA36D4; Thu,  3 Jun 2021 18:32:00 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v7 2/6] writeback, cgroup: switch to rcu_work API in inode_switch_wbs()
Date:   Thu, 3 Jun 2021 18:31:55 -0700
Message-ID: <20210604013159.3126180-3-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210604013159.3126180-1-guro@fb.com>
References: <20210604013159.3126180-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ydnN5Kg56rsF9hkNrCcrO5aQii4dUWvs
X-Proofpoint-ORIG-GUID: ydnN5Kg56rsF9hkNrCcrO5aQii4dUWvs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_01:2021-06-04,2021-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Inode's wb switching requires two steps divided by an RCU grace
period. It's currently implemented as an RCU callback
inode_switch_wbs_rcu_fn(), which schedules inode_switch_wbs_work_fn()
as a work.

Switching to the rcu_work API allows to do the same in a cleaner and
slightly shorter form.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index bd99890599e0..9f378a670db4 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -335,8 +335,7 @@ struct inode_switch_wbs_context {
 	struct inode		*inode;
 	struct bdi_writeback	*new_wb;
=20
-	struct rcu_head		rcu_head;
-	struct work_struct	work;
+	struct rcu_work		work;
 };
=20
 static void bdi_down_write_wb_switch_rwsem(struct backing_dev_info *bdi)
@@ -352,7 +351,7 @@ static void bdi_up_write_wb_switch_rwsem(struct backi=
ng_dev_info *bdi)
 static void inode_switch_wbs_work_fn(struct work_struct *work)
 {
 	struct inode_switch_wbs_context *isw =3D
-		container_of(work, struct inode_switch_wbs_context, work);
+		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work)=
;
 	struct inode *inode =3D isw->inode;
 	struct backing_dev_info *bdi =3D inode_to_bdi(inode);
 	struct address_space *mapping =3D inode->i_mapping;
@@ -469,16 +468,6 @@ static void inode_switch_wbs_work_fn(struct work_str=
uct *work)
 	atomic_dec(&isw_nr_in_flight);
 }
=20
-static void inode_switch_wbs_rcu_fn(struct rcu_head *rcu_head)
-{
-	struct inode_switch_wbs_context *isw =3D container_of(rcu_head,
-				struct inode_switch_wbs_context, rcu_head);
-
-	/* needs to grab bh-unsafe locks, bounce to work item */
-	INIT_WORK(&isw->work, inode_switch_wbs_work_fn);
-	queue_work(isw_wq, &isw->work);
-}
-
 /**
  * inode_switch_wbs - change the wb association of an inode
  * @inode: target inode
@@ -534,7 +523,8 @@ static void inode_switch_wbs(struct inode *inode, int=
 new_wb_id)
 	 * lock so that stat transfer can synchronize against them.
 	 * Let's continue after I_WB_SWITCH is guaranteed to be visible.
 	 */
-	call_rcu(&isw->rcu_head, inode_switch_wbs_rcu_fn);
+	INIT_RCU_WORK(&isw->work, inode_switch_wbs_work_fn);
+	queue_rcu_work(isw_wq, &isw->work);
=20
 	atomic_inc(&isw_nr_in_flight);
 	return;
--=20
2.31.1

