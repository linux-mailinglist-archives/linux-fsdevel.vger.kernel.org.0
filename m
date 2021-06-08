Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA5239EB6A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 03:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhFHBdd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 21:33:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46726 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231261AbhFHBda (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:33:30 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1581SQDk008154
        for <linux-fsdevel@vger.kernel.org>; Mon, 7 Jun 2021 18:31:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=VOS/cMlJuOP4R8dV3BlKjWy3sUpbjMUwJr4NHNPxER8=;
 b=UoOInWK62It3F5fZMJ6KYCjtLeW0WB0HC8bX83PE451a4VGo+dcN8KfOEr5xP0d7BaaN
 AKpYqquQkL+DZtfKVfCqRCL73NkIa3TPJoaHSNQKRBNT+sI36+8twRbmZVX7NaVX9ZiP
 Ri0kQqbmMo1LdF7OKkyMG09q9jK3zJ/FRCo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 391mx0ktjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jun 2021 18:31:38 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 18:31:37 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 9BC5581D6D49; Mon,  7 Jun 2021 18:31:29 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v8 4/8] writeback, cgroup: switch to rcu_work API in inode_switch_wbs()
Date:   Mon, 7 Jun 2021 18:31:19 -0700
Message-ID: <20210608013123.1088882-5-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608013123.1088882-1-guro@fb.com>
References: <20210608013123.1088882-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SYZ6RLd39GiM8GUewiVhomv7oLPrA9tt
X-Proofpoint-ORIG-GUID: SYZ6RLd39GiM8GUewiVhomv7oLPrA9tt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_01:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106080007
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
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Dennis Zhou <dennis@kernel.org>
---
 fs/fs-writeback.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e2cc860a001b..96974e13a203 100644
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
@@ -536,7 +525,8 @@ static void inode_switch_wbs(struct inode *inode, int=
 new_wb_id)
 	 * lock so that stat transfer can synchronize against them.
 	 * Let's continue after I_WB_SWITCH is guaranteed to be visible.
 	 */
-	call_rcu(&isw->rcu_head, inode_switch_wbs_rcu_fn);
+	INIT_RCU_WORK(&isw->work, inode_switch_wbs_work_fn);
+	queue_rcu_work(isw_wq, &isw->work);
 	return;
=20
 out_free:
--=20
2.31.1

