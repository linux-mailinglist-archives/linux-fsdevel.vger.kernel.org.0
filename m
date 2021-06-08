Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F2339EB83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 03:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhFHBgB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 21:36:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55298 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230272AbhFHBgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:36:00 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1581XwKs003575
        for <linux-fsdevel@vger.kernel.org>; Mon, 7 Jun 2021 18:34:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=UnR5/HPn3nu3OonRftQmCkI+MWqhatoGojrvOHmp0+Q=;
 b=I7Kdkfz34jOsjRUVQU6uPuOEAD4BRpnlOa7n4+gbGUK8MLFmcRK7iZyUCmT2cl4n5iWD
 9j18LYMIQLGFGtqBtLYkYyrlVdcylSNVFhHFzlWcnCNcdhlSeABRG69P3knc3j+PPOGo
 rG5dqybsYqQ3EzQmDltzLIf+pg9/9F5fUXU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 391m0t4154-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jun 2021 18:34:08 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 18:34:03 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 9654F81D6D47; Mon,  7 Jun 2021 18:31:29 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Jan Kara <jack@suse.com>
Subject: [PATCH v8 3/8] writeback, cgroup: increment isw_nr_in_flight before grabbing an inode
Date:   Mon, 7 Jun 2021 18:31:18 -0700
Message-ID: <20210608013123.1088882-4-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608013123.1088882-1-guro@fb.com>
References: <20210608013123.1088882-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qeOc4D_KFTVkyN-8EkivofehUmiHDLaW
X-Proofpoint-ORIG-GUID: qeOc4D_KFTVkyN-8EkivofehUmiHDLaW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_01:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

isw_nr_in_flight is used do determine whether the inode switch queue
should be flushed from the umount path. Currently it's increased
after grabbing an inode and even scheduling the switch work. It means
the umount path can be walked past cleanup_offline_cgwb() with active
inode references, which can result in a "Busy inodes after unmount."
message and use-after-free issues (with inode->i_sb which gets freed).

Fix it by incrementing isw_nr_in_flight before doing anything with
the inode and decrementing in the case when switching wasn't scheduled.

The problem hasn't yet been seen in the real life and was discovered
by Jan Kara by looking into the code.

Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 fs/fs-writeback.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 3564efcc4b78..e2cc860a001b 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -505,6 +505,8 @@ static void inode_switch_wbs(struct inode *inode, int=
 new_wb_id)
 	if (!isw)
 		return;
=20
+	atomic_inc(&isw_nr_in_flight);
+
 	/* find and pin the new wb */
 	rcu_read_lock();
 	memcg_css =3D css_from_id(new_wb_id, &memory_cgrp_subsys);
@@ -535,11 +537,10 @@ static void inode_switch_wbs(struct inode *inode, i=
nt new_wb_id)
 	 * Let's continue after I_WB_SWITCH is guaranteed to be visible.
 	 */
 	call_rcu(&isw->rcu_head, inode_switch_wbs_rcu_fn);
-
-	atomic_inc(&isw_nr_in_flight);
 	return;
=20
 out_free:
+	atomic_dec(&isw_nr_in_flight);
 	if (isw->new_wb)
 		wb_put(isw->new_wb);
 	kfree(isw);
--=20
2.31.1

