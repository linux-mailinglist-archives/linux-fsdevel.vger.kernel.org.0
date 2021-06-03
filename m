Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16E39974C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 02:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFCA5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 20:57:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58202 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229738AbhFCA5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:57:36 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1530sQIp013288
        for <linux-fsdevel@vger.kernel.org>; Wed, 2 Jun 2021 17:55:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=L8m8gyrfdV8KT/gd5pz1QPnzKy0K3EfCtK1Ky3VDACI=;
 b=WNQRQrAbIQrsfmeHxmDfx7FDsTJeloDZEsYBu+QxbpPrd0Mr62WIabW2KO1yT7Qg9ypm
 cJLsmzefYlz/WVXTqJv0Mch0enoqKI3M3/PZZuBPDlE3XICLbGVBXcvuSE3oZt+civ7k
 2HASo8smIXmtX8ZlxZwOfRtvuVaGdHnzBso= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38xj5k8yx4-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jun 2021 17:55:52 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:55:29 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id A5C807F192AA; Wed,  2 Jun 2021 17:55:22 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v6 4/5] writeback, cgroup: support switching multiple inodes at once
Date:   Wed, 2 Jun 2021 17:55:16 -0700
Message-ID: <20210603005517.1403689-5-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603005517.1403689-1-guro@fb.com>
References: <20210603005517.1403689-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LK0B7sjnlOb9Oks-ZCSIFHlteJXIQ1ub
X-Proofpoint-ORIG-GUID: LK0B7sjnlOb9Oks-ZCSIFHlteJXIQ1ub
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_11:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=933 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030004
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
will contain a NULL-terminated array of inode
pointers. inode_do_switch_wbs() will be called for each inode.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 fs/fs-writeback.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 212494d89cc2..49d7b23a7cfe 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -335,10 +335,10 @@ static struct bdi_writeback *inode_to_wb_and_lock_l=
ist(struct inode *inode)
 }
=20
 struct inode_switch_wbs_context {
-	struct inode		*inode;
-	struct bdi_writeback	*new_wb;
-
 	struct rcu_work		work;
+
+	struct bdi_writeback	*new_wb;
+	struct inode		*inodes[];
 };
=20
 static void bdi_down_write_wb_switch_rwsem(struct backing_dev_info *bdi)
@@ -473,10 +473,14 @@ static void inode_switch_wbs_work_fn(struct work_st=
ruct *work)
 {
 	struct inode_switch_wbs_context *isw =3D
 		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work)=
;
+	struct inode **inodep;
+
+	for (inodep =3D &isw->inodes[0]; *inodep; inodep++) {
+		inode_do_switch_wbs(*inodep, isw->new_wb);
+		iput(*inodep);
+	}
=20
-	inode_do_switch_wbs(isw->inode, isw->new_wb);
 	wb_put(isw->new_wb);
-	iput(isw->inode);
 	kfree(isw);
 	atomic_dec(&isw_nr_in_flight);
 }
@@ -503,7 +507,7 @@ static void inode_switch_wbs(struct inode *inode, int=
 new_wb_id)
 	if (atomic_read(&isw_nr_in_flight) > WB_FRN_MAX_IN_FLIGHT)
 		return;
=20
-	isw =3D kzalloc(sizeof(*isw), GFP_ATOMIC);
+	isw =3D kzalloc(sizeof(*isw) + 2 * sizeof(struct inode *), GFP_ATOMIC);
 	if (!isw)
 		return;
=20
@@ -528,7 +532,7 @@ static void inode_switch_wbs(struct inode *inode, int=
 new_wb_id)
 	__iget(inode);
 	spin_unlock(&inode->i_lock);
=20
-	isw->inode =3D inode;
+	isw->inodes[0] =3D inode;
=20
 	/*
 	 * In addition to synchronizing among switchers, I_WB_SWITCH tells
--=20
2.31.1

