Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389FE1CC775
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 09:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgEJHI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 03:08:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbgEJHI4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 03:08:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A72j5j040838;
        Sun, 10 May 2020 03:08:51 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ws5cvmkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 03:08:51 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A75xxK011156;
        Sun, 10 May 2020 07:08:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 30wm55gtqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 07:08:48 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A78jXR46727178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 07:08:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6F6142052;
        Sun, 10 May 2020 07:08:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D629542041;
        Sun, 10 May 2020 07:08:43 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 07:08:43 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFCv4 3/6] ext4: mballoc: Optimize ext4_mb_good_group_nolock further if grp needs init
Date:   Sun, 10 May 2020 12:38:23 +0530
Message-Id: <cb388ae67bfb70998fe8d12a17d9a169448823f9.1589086820.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086820.git.riteshh@linux.ibm.com>
References: <cover.1589086820.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_02:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=3
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=883
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005100065
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently in case if EXT4_MB_GRP_NEED_INIT(grp) is true, then we first
check for few things like grp->bb_free etc with spinlock (ext4_lock_group)
held. Then we drop the lock only to initialize the group's buddy cache
and then again take the lock and check for ext4_mb_good_group().

Once this step is done we return to ext4_mb_regular_allocator(), load
the buddy and then again take the lock only to check
ext4_mb_good_group(), which was anyways done in previous step.

I believe we can optimize one step here where if the group needs init
we can check for only few things and return early. Then recheck for
ext4_mb_good_group() only once after loading the buddy cache.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index dcd05ff7c012..7d766dc34cdd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2134,33 +2134,34 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
  * during ext4_mb_init_group(). This should not be called with
  * ext4_lock_group() held.
  */
-static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
+static bool ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 				     ext4_group_t group, int cr)
 {
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 	struct super_block *sb = ac->ac_sb;
 	ext4_grpblk_t free;
-	int ret = 0;
+	bool ret = false, need_init = EXT4_MB_GRP_NEED_INIT(grp);
 
 	ext4_lock_group(sb, group);
-	free = grp->bb_free;
-	if (free == 0)
-		goto out;
-	if (cr <= 2 && free < ac->ac_g_ex.fe_len)
-		goto out;
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
-		goto out;
-	ext4_unlock_group(sb, group);
-
-	/* We only do this if the grp has never been initialized */
-	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
-		ret = ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
-		if (ret)
-			return ret;
+	/*
+	 * If the group needs init then no need to call ext4_mb_init_group()
+	 * after dropping the lock. It's better we check bb_free/other things
+	 * here and if it meets the criteria than return true. Later we
+	 * will anyway check for good group after loading the buddy cache
+	 * which, if required will call ext4_mb_init_group() from within.
+	 */
+	if (unlikely(need_init)) {
+		free = grp->bb_free;
+		if (free == 0)
+			goto out;
+		if (cr <= 2 && free < ac->ac_g_ex.fe_len)
+			goto out;
+		if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
+			goto out;
+		ret = true;
+	} else {
+		ret = ext4_mb_good_group(ac, group, cr);
 	}
-
-	ext4_lock_group(sb, group);
-	ret = ext4_mb_good_group(ac, group, cr);
 out:
 	ext4_unlock_group(sb, group);
 	return ret;
@@ -2252,11 +2253,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 
 			/* This now checks without needing the buddy page */
 			ret = ext4_mb_good_group_nolock(ac, group, cr);
-			if (ret <= 0) {
-				if (!first_err)
-					first_err = ret;
+			if (ret == 0)
 				continue;
-			}
 
 			err = ext4_mb_load_buddy(sb, group, &e4b);
 			if (err)
-- 
2.21.0

