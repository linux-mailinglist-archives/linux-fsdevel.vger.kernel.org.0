Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8612E620
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 13:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgABMbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 07:31:16 -0500
Received: from mgw-01.mpynet.fi ([82.197.21.90]:49090 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgABMbQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 07:31:16 -0500
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.27/8.16.0.27) with SMTP id 002Bxd4F065936;
        Thu, 2 Jan 2020 14:01:37 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 2x9egur3n4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 02 Jan 2020 14:01:37 +0200
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Jan
 2020 14:01:37 +0200
From:   Vladimir Zapolskiy <vladimir@tuxera.com>
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
CC:     Anton Altaparmakov <anton@tuxera.com>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 3/3] erofs: remove void tagging/untagging of workgroup pointers
Date:   Thu, 2 Jan 2020 14:01:18 +0200
Message-ID: <20200102120118.14979-4-vladimir@tuxera.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200102120118.14979-1-vladimir@tuxera.com>
References: <20200102120118.14979-1-vladimir@tuxera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001020108
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because workgroup pointers inserted to a radix tree are always tagged with
a single value of 0, it is possible to remove tagging and untagging of the
pointers completely.

Signed-off-by: Vladimir Zapolskiy <vladimir@tuxera.com>
---
 fs/erofs/utils.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 7b47c56b89b7..fddc5059c930 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -68,8 +68,6 @@ struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
 	rcu_read_lock();
 	grp = radix_tree_lookup(&sbi->workstn_tree, index);
 	if (grp) {
-		grp = xa_untag_pointer(grp);
-
 		if (erofs_workgroup_get(grp)) {
 			/* prefer to relax rcu read side */
 			rcu_read_unlock();
@@ -101,8 +99,6 @@ int erofs_register_workgroup(struct super_block *sb,
 	sbi = EROFS_SB(sb);
 	xa_lock(&sbi->workstn_tree);
 
-	grp = xa_tag_pointer(grp, 0);
-
 	/*
 	 * Bump up reference count before making this workgroup
 	 * visible to other users in order to avoid potential UAF
@@ -173,8 +169,7 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 	 * however in order to avoid some race conditions, add a
 	 * DBG_BUGON to observe this in advance.
 	 */
-	DBG_BUGON(xa_untag_pointer(radix_tree_delete(&sbi->workstn_tree,
-						     grp->index)) != grp);
+	DBG_BUGON(radix_tree_delete(&sbi->workstn_tree, grp->index) != grp);
 
 	/*
 	 * If managed cache is on, last refcount should indicate
@@ -199,7 +194,7 @@ static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 				       batch, first_index, PAGEVEC_SIZE);
 
 	for (i = 0; i < found; ++i) {
-		struct erofs_workgroup *grp = xa_untag_pointer(batch[i]);
+		struct erofs_workgroup *grp = batch[i];
 
 		first_index = grp->index + 1;
 
-- 
2.20.1

