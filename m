Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894AD1CC76F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 09:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgEJHIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 03:08:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8460 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbgEJHIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 03:08:51 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A72IY8190950;
        Sun, 10 May 2020 03:08:45 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30xa4gay3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 03:08:45 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A75IaA001370;
        Sun, 10 May 2020 07:08:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 30wm55a2pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 07:08:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A78fn157802926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 07:08:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CF9542041;
        Sun, 10 May 2020 07:08:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57DCA4203F;
        Sun, 10 May 2020 07:08:39 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 07:08:39 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFCv4 1/6] ext4: mballoc: Refactor ext4_mb_good_group()
Date:   Sun, 10 May 2020 12:38:21 +0530
Message-Id: <aa1b1da1feb9b38174822410a4049b7c7bdfa0e7.1589086820.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086820.git.riteshh@linux.ibm.com>
References: <cover.1589086820.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_02:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 suspectscore=3 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100060
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext4_mb_good_group() definition was changed some time back
and now it even initializes the buddy cache (via ext4_mb_init_group()),
if in case the EXT4_MB_GRP_NEED_INIT() is true for a group.
Note that ext4_mb_init_group() could sleep and so should not be called
under a spinlock held.
This is fine as of now because ext4_mb_good_group() is called before
loading the buddy bitmap without ext4_lock_group() held
and again called after loading the bitmap, only this time with
ext4_lock_group() held.
But still this whole thing is confusing.

So this patch refactors out ext4_mb_good_group_nolock() which should be
called when without holding ext4_lock_group().
Also in further patches we hold the spinlock (ext4_lock_group()) while
doing any calculations which involves grp->bb_free or grp->bb_fragments.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 80 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 33a69424942c..da11a4a738bd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2066,15 +2066,16 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
 }
 
 /*
- * This is now called BEFORE we load the buddy bitmap.
+ * This is also called BEFORE we load the buddy bitmap.
  * Returns either 1 or 0 indicating that the group is either suitable
- * for the allocation or not. In addition it can also return negative
- * error code when something goes wrong.
+ * for the allocation or not. This should be called with ext4_lock_group()
+ * held to protect grp->bb_free from getting changed due to another
+ * allocation/discard is happening in parallel.
  */
-static int ext4_mb_good_group(struct ext4_allocation_context *ac,
+static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 				ext4_group_t group, int cr)
 {
-	unsigned free, fragments;
+	ext4_grpblk_t free, fragments;
 	int flex_size = ext4_flex_bg_size(EXT4_SB(ac->ac_sb));
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 
@@ -2082,23 +2083,16 @@ static int ext4_mb_good_group(struct ext4_allocation_context *ac,
 
 	free = grp->bb_free;
 	if (free == 0)
-		return 0;
+		return false;
 	if (cr <= 2 && free < ac->ac_g_ex.fe_len)
-		return 0;
+		return false;
 
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
-		return 0;
-
-	/* We only do this if the grp has never been initialized */
-	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
-		int ret = ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
-		if (ret)
-			return ret;
-	}
+		return false;
 
 	fragments = grp->bb_fragments;
 	if (fragments == 0)
-		return 0;
+		return false;
 
 	switch (cr) {
 	case 0:
@@ -2108,31 +2102,63 @@ static int ext4_mb_good_group(struct ext4_allocation_context *ac,
 		if ((ac->ac_flags & EXT4_MB_HINT_DATA) &&
 		    (flex_size >= EXT4_FLEX_SIZE_DIR_ALLOC_SCHEME) &&
 		    ((group % flex_size) == 0))
-			return 0;
+			return false;
 
 		if ((ac->ac_2order > ac->ac_sb->s_blocksize_bits+1) ||
 		    (free / fragments) >= ac->ac_g_ex.fe_len)
-			return 1;
+			return true;
 
 		if (grp->bb_largest_free_order < ac->ac_2order)
-			return 0;
+			return false;
 
-		return 1;
+		return true;
 	case 1:
 		if ((free / fragments) >= ac->ac_g_ex.fe_len)
-			return 1;
+			return true;
 		break;
 	case 2:
 		if (free >= ac->ac_g_ex.fe_len)
-			return 1;
+			return true;
 		break;
 	case 3:
-		return 1;
+		return true;
 	default:
 		BUG();
 	}
 
-	return 0;
+	return false;
+}
+
+/*
+ * This could return negative error code if something goes wrong
+ * during ext4_mb_init_group(). This should not be called with
+ * ext4_lock_group() held.
+ */
+static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
+				     ext4_group_t group, int cr)
+{
+	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
+	ext4_grpblk_t free;
+	int ret = 0;
+
+	free = grp->bb_free;
+	if (free == 0)
+		goto out;
+	if (cr <= 2 && free < ac->ac_g_ex.fe_len)
+		goto out;
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
+		goto out;
+
+	/* We only do this if the grp has never been initialized */
+	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
+		ret = ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
+		if (ret)
+			return ret;
+	}
+
+	ret = ext4_mb_good_group(ac, group, cr);
+out:
+	return ret;
 }
 
 static noinline_for_stack int
@@ -2220,7 +2246,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				group = 0;
 
 			/* This now checks without needing the buddy page */
-			ret = ext4_mb_good_group(ac, group, cr);
+			ret = ext4_mb_good_group_nolock(ac, group, cr);
 			if (ret <= 0) {
 				if (!first_err)
 					first_err = ret;
@@ -2238,11 +2264,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			 * block group
 			 */
 			ret = ext4_mb_good_group(ac, group, cr);
-			if (ret <= 0) {
+			if (ret == 0) {
 				ext4_unlock_group(sb, group);
 				ext4_mb_unload_buddy(&e4b);
-				if (!first_err)
-					first_err = ret;
 				continue;
 			}
 
-- 
2.21.0

