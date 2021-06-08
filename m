Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613E53A076C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 01:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhFHXGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 19:06:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47862 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235253AbhFHXGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:06:54 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158N4vop005745
        for <linux-fsdevel@vger.kernel.org>; Tue, 8 Jun 2021 16:05:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9vH82NMbkv7YQHgigSWFOT2nRhVyqg95XPt1dbBwV6E=;
 b=mQZ10dHM2zu3FbWXmJuhjhJu1Z2kzFIUyVBYat844+0c9Y6HYRFsQY8C0aEw1klitvBU
 BSeNIFtMN6qMC4S0mwdX3NkwvjiMcmWCYudzdcQqKy9kHbWlvA2hZnzlqZppoBfUsbCQ
 XejkcinZ0AmcVU3EJaW1b8DNLKBXZXBNvCY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3929n4bkmy-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jun 2021 16:05:00 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:04:52 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 3254D82542C7; Tue,  8 Jun 2021 16:02:28 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v9 1/8] writeback, cgroup: do not switch inodes with I_WILL_FREE flag
Date:   Tue, 8 Jun 2021 16:02:18 -0700
Message-ID: <20210608230225.2078447-2-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608230225.2078447-1-guro@fb.com>
References: <20210608230225.2078447-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tIBzDJ4A25lxaRCSKLZyYxyb3voddPmn
X-Proofpoint-ORIG-GUID: tIBzDJ4A25lxaRCSKLZyYxyb3voddPmn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_17:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=979 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106080146
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
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dennis Zhou <dennis@kernel.org>
---
 fs/fs-writeback.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 7c46d1588a19..7d2891d7ac12 100644
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

