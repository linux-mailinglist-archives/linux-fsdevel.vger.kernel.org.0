Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7ED1399745
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 02:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFCA5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 20:57:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44396 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhFCA5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:57:12 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1530o2q4026923
        for <linux-fsdevel@vger.kernel.org>; Wed, 2 Jun 2021 17:55:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/DBsTJC33bFhaEU3PBMQzj0ujRVVcUYAVrv4stXzc5Y=;
 b=mV6W9OHNSFdLKkOytySRMra32H+5DcojjlazYqhuwG0wAoXwFpXCWOHGVtWQP9VZsNak
 1OJLBio2gXM20+fMWG2i4eH+7otfjKW3MYdUqb6K7iYTxSALySh+OiNMB/z4sd34YR/Y
 l3xBcdhgh0KAlu9RLOGJbd9PN/xgd7jGhyo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38xcnm3ahv-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jun 2021 17:55:27 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 17:55:27 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id A09227F192A8; Wed,  2 Jun 2021 17:55:22 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v6 3/5] writeback, cgroup: split out the functional part of inode_switch_wbs_work_fn()
Date:   Wed, 2 Jun 2021 17:55:15 -0700
Message-ID: <20210603005517.1403689-4-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603005517.1403689-1-guro@fb.com>
References: <20210603005517.1403689-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bvdnivk0qVcdB2b0iuMKWiMKUvhshLF9
X-Proofpoint-GUID: bvdnivk0qVcdB2b0iuMKWiMKUvhshLF9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_11:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106030003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split out the functional part of the inode_switch_wbs_work_fn()
function as inode_do switch_wbs() to reuse it later for switching
inodes attached to dying cgwbs.

This commit doesn't bring any functional changes.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 fs/fs-writeback.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 09d2770449ef..212494d89cc2 100644
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

