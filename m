Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D940E39974B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 02:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFCA5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 20:57:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34612 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhFCA5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:57:36 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1530rY7s022714
        for <linux-fsdevel@vger.kernel.org>; Wed, 2 Jun 2021 17:55:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Fl1FNCnrAGsBbQgATSvy4odFlVBqSEpU88o5rQ4At+U=;
 b=YFPvi2Ywe3LDMi4p561T3fhHhIx1pBgnNPKFd5gEim+egVvS4w94Iwc46SdM3ofoj2Lz
 s9Ofywrbjil+xDWdd0Bdr9HZ7oOuEyHnp+7Q8CW3Tl9U0jTKcg6+ZcQMe5PLgWjV3fBZ
 rJmmBU294YDUi3EI9fw1eScDX9QueGvwTjA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38xjg0gvgu-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jun 2021 17:55:51 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:55:28 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 969557F192A4; Wed,  2 Jun 2021 17:55:22 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v6 1/5] writeback, cgroup: switch to rcu_work API in inode_switch_wbs()
Date:   Wed, 2 Jun 2021 17:55:13 -0700
Message-ID: <20210603005517.1403689-2-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603005517.1403689-1-guro@fb.com>
References: <20210603005517.1403689-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tRA40ovGpn54TUEotwHFitNV6tNxx7mw
X-Proofpoint-ORIG-GUID: tRA40ovGpn54TUEotwHFitNV6tNxx7mw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_11:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030004
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
---
 fs/fs-writeback.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e91980f49388..1f51857e41d1 100644
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

