Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4843A0788
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 01:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhFHXKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 19:10:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24144 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235381AbhFHXKA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:10:00 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158N61jf027515
        for <linux-fsdevel@vger.kernel.org>; Tue, 8 Jun 2021 16:08:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Y6Lte7k+x+m8kEVnaBrF4622rOW8f0AmfUvQ98eX5ng=;
 b=FuapzUxEVa8KOgKLgQaxuvrNq1ujRgK9xp+HnWJnTQ+f11vghbB3iJR1l/0OmUKnGiE+
 eqG1D/lMcSN6AlXb/xTz4sQIL9SeF3+NU8brn6xWea8Ho1LUgh/Jp4lYDqg6BXUDmRvQ
 yHP5sibK6U76NTLfar+JJcV3O7cS9ERu2d4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 392fmdrsp0-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jun 2021 16:08:06 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:07:57 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 4D65C82542D5; Tue,  8 Jun 2021 16:02:28 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v9 6/8] writeback, cgroup: split out the functional part of inode_switch_wbs_work_fn()
Date:   Tue, 8 Jun 2021 16:02:23 -0700
Message-ID: <20210608230225.2078447-7-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608230225.2078447-1-guro@fb.com>
References: <20210608230225.2078447-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: azzkCkQTLeVqlm8LiHEROiu_yoKtyvYP
X-Proofpoint-ORIG-GUID: azzkCkQTLeVqlm8LiHEROiu_yoKtyvYP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_17:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=948 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split out the functional part of the inode_switch_wbs_work_fn()
function as inode_do switch_wbs() to reuse it later for switching
inodes attached to dying cgwbs.

This commit doesn't bring any functional changes.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Dennis Zhou <dennis@kernel.org>
---
 fs/fs-writeback.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 18f4a27b8046..8240eb0803dc 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -351,15 +351,12 @@ static void bdi_up_write_wb_switch_rwsem(struct bac=
king_dev_info *bdi)
 	up_write(&bdi->wb_switch_rwsem);
 }
=20
-static void inode_switch_wbs_work_fn(struct work_struct *work)
+static void inode_do_switch_wbs(struct inode *inode,
+				struct bdi_writeback *new_wb)
 {
-	struct inode_switch_wbs_context *isw =3D
-		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work)=
;
-	struct inode *inode =3D isw->inode;
 	struct backing_dev_info *bdi =3D inode_to_bdi(inode);
 	struct address_space *mapping =3D inode->i_mapping;
 	struct bdi_writeback *old_wb =3D inode->i_wb;
-	struct bdi_writeback *new_wb =3D isw->new_wb;
 	XA_STATE(xas, &mapping->i_pages, 0);
 	struct page *page;
 	bool switched =3D false;
@@ -470,11 +467,17 @@ static void inode_switch_wbs_work_fn(struct work_st=
ruct *work)
 		wb_wakeup(new_wb);
 		wb_put(old_wb);
 	}
-	wb_put(new_wb);
+}
=20
-	iput(inode);
-	kfree(isw);
+static void inode_switch_wbs_work_fn(struct work_struct *work)
+{
+	struct inode_switch_wbs_context *isw =3D
+		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work)=
;
=20
+	inode_do_switch_wbs(isw->inode, isw->new_wb);
+	wb_put(isw->new_wb);
+	iput(isw->inode);
+	kfree(isw);
 	atomic_dec(&isw_nr_in_flight);
 }
=20
--=20
2.31.1

