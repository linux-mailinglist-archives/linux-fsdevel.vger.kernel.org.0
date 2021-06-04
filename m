Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48ED39AFC6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 03:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhFDBdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 21:33:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3832 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230149AbhFDBdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:33:52 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1541Ub8g031530
        for <linux-fsdevel@vger.kernel.org>; Thu, 3 Jun 2021 18:32:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=0gZxeDTVwwISi0mUQNjyH9+4fnDHEWwqdGc5QqFQf6Q=;
 b=HhVza4LorKtpD1j6N2ASKf7VUTEXpzbqgg8Ze6a0E/CZ8jaXoGBBem7TxNweH+PHyTs2
 onC5tbV47NFkOFm5lrAJzJn+vdEL2qvrWwP0cmyAaQuIN8CM0DyhpwNZMZEnEnCyVhoE
 09Sf2g5B6fZD2n1kuVc8kf96+KDKMriVvbg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38xj5kg1tk-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jun 2021 18:32:06 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 18:32:04 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 733C27FA36D2; Thu,  3 Jun 2021 18:32:00 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v7 1/6] writeback, cgroup: do not switch inodes with I_WILL_FREE flag
Date:   Thu, 3 Jun 2021 18:31:54 -0700
Message-ID: <20210604013159.3126180-2-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210604013159.3126180-1-guro@fb.com>
References: <20210604013159.3126180-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: xfhLEdL6iUuej1g9n7S3ZPZkg3DpdDap
X-Proofpoint-ORIG-GUID: xfhLEdL6iUuej1g9n7S3ZPZkg3DpdDap
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_01:2021-06-04,2021-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If an inode's state has I_WILL_FREE flag set, the inode will be
freed soon, so there is no point in trying to switch the inode
to a different cgwb.

I_WILL_FREE was ignored since the introduction of the inode switching,
so it looks like it doesn't lead to any noticeable issues for a user.
This is why the patch is not intended for a stable backport.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 fs/fs-writeback.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e91980f49388..bd99890599e0 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -389,10 +389,10 @@ static void inode_switch_wbs_work_fn(struct work_st=
ruct *work)
 	xa_lock_irq(&mapping->i_pages);
=20
 	/*
-	 * Once I_FREEING is visible under i_lock, the eviction path owns
-	 * the inode and we shouldn't modify ->i_io_list.
+	 * Once I_FREEING or I_WILL_FREE are visible under i_lock, the eviction
+	 * path owns the inode and we shouldn't modify ->i_io_list.
 	 */
-	if (unlikely(inode->i_state & I_FREEING))
+	if (unlikely(inode->i_state & (I_FREEING | I_WILL_FREE)))
 		goto skip_switch;
=20
 	trace_inode_switch_wbs(inode, old_wb, new_wb);
@@ -517,7 +517,7 @@ static void inode_switch_wbs(struct inode *inode, int=
 new_wb_id)
 	/* while holding I_WB_SWITCH, no one else can update the association */
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
-	    inode->i_state & (I_WB_SWITCH | I_FREEING) ||
+	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
 	    inode_to_wb(inode) =3D=3D isw->new_wb) {
 		spin_unlock(&inode->i_lock);
 		goto out_free;
--=20
2.31.1

