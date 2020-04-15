Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DA71AAF70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 19:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410883AbgDORXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 13:23:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410902AbgDORXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:23:15 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FH7RuK113048
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 13:23:14 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30dnuu51fy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 13:23:14 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 15 Apr 2020 18:23:07 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 Apr 2020 18:23:05 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03FHN8AT38207846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 17:23:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C224552051;
        Wed, 15 Apr 2020 17:23:08 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.54.166])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 09DFE5204F;
        Wed, 15 Apr 2020 17:23:06 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        sandeen@sandeen.net
Subject: [RFCv2 1/1] ext4: Fix race in ext4 mb discard group preallocations
Date:   Wed, 15 Apr 2020 22:53:01 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1586954511.git.riteshh@linux.ibm.com>
References: <cover.1586954511.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041517-0028-0000-0000-000003F8D139
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041517-0029-0000-0000-000024BE84BD
Message-Id: <533ac1f5b19c520b08f8c99aec5baf8729185714.1586954511.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_06:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=2
 clxscore=1015 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150124
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There could be a race in function ext4_mb_discard_group_preallocations()
where the 1st thread may iterate through group's bb_prealloc_list and
remove all the PAs and add to function's local list head.
Now if the 2nd thread comes in to discard the group preallocations,
it will see that the group->bb_prealloc_list is empty and will return 0.

Consider for a case where we have less number of groups (for e.g. just group 0),
this may even return an -ENOSPC error from ext4_mb_new_blocks()
(where we call for ext4_mb_discard_group_preallocations()).
But that is wrong, since 2nd thread should have waited for 1st thread to release
all the PAs and should have retried for allocation. Since 1st thread
was anyway going to discard the PAs.

This patch fixes this race by introducing two paths (fastpath and
slowpath). We first try the fastpath via
ext4_mb_discard_preallocations(). So if any of the group's PA list is
empty then instead of waiting on the group_lock we continue to discard
other group's PA. This could help maintain the parallelism in trying to
discard multiple group's PA list. So if at the end some process is
not able to find any freed block, then we retry freeing all of the
groups PA list while holding the group_lock. And in case if the PA list
is empty, then we try return grp->bb_free which should tell us
whether there are any free blocks in the given group or not to make any
forward progress.

Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 76 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1027e01c9011..0728bfd3bc7e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3885,7 +3885,27 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
 }
 
 /*
- * releases all preallocations in given group
+ * This function discards all the preallocations for the given group.
+ * In this there could be a race with another process also trying to discard
+ * this group's PA. So, if we could not get any PA from grp->bb_prealloc_list
+ * into our local list (though when initially the list was non-empty),
+ * then we simply return grp->bb_free. Note that this need
+ * not be an upper bound value since it may happen that some of the PAs of
+ * a given group is in process-A local list while some other PAs of the same
+ * group could end up in process-B local list (this is due to cond_resched()
+ * busy logic below). But as long as there this process could free some PAs
+ * or if there are any grp->bb_free blocks freed by some other process, a
+ * forward progress could be made.
+ *
+ * return value could be either of either of below in fastpath:-
+ *  - 0 of the grp->bb_prealloc_list is empty.
+ *  - actual discarded PA blocks from grp->bb_prealloc_list.
+ *  - grp->bb_free.
+ *
+ * In case of slowpath, we try to free all the PAs of the given group in the
+ * similar manner. But if even after taking the group_lock, we find
+ * that the list is empty, then we return grp->bb_free blocks.
+ * This will be 0 only when there are acually no free blocks in this group.
  *
  * first, we need to decide discard policy:
  * - when do we discard
@@ -3894,8 +3914,8 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
  *   1) how many requested
  */
 static noinline_for_stack int
-ext4_mb_discard_group_preallocations(struct super_block *sb,
-					ext4_group_t group, int needed)
+ext4_mb_discard_group_preallocations(struct super_block *sb, ext4_group_t group,
+				     int needed, bool fastpath)
 {
 	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
 	struct buffer_head *bitmap_bh = NULL;
@@ -3907,9 +3927,8 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	int free = 0;
 
 	mb_debug(1, "discard preallocation for group %u\n", group);
-
-	if (list_empty(&grp->bb_prealloc_list))
-		return 0;
+	if (fastpath && list_empty(&grp->bb_prealloc_list))
+		goto out_dbg;
 
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
 	if (IS_ERR(bitmap_bh)) {
@@ -3917,7 +3936,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		ext4_set_errno(sb, -err);
 		ext4_error(sb, "Error %d reading block bitmap for %u",
 			   err, group);
-		return 0;
+		goto out_dbg;
 	}
 
 	err = ext4_mb_load_buddy(sb, group, &e4b);
@@ -3925,7 +3944,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		ext4_warning(sb, "Error %d loading buddy information for %u",
 			     err, group);
 		put_bh(bitmap_bh);
-		return 0;
+		goto out_dbg;
 	}
 
 	if (needed == 0)
@@ -3967,9 +3986,15 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		goto repeat;
 	}
 
-	/* found anything to free? */
+	/*
+	 * If this list is empty, then return the grp->bb_free. As someone
+	 * else may have freed the PAs and updated grp->bb_free.
+	 */
 	if (list_empty(&list)) {
 		BUG_ON(free != 0);
+		mb_debug(1, "Someone may have freed PA for this group %u, grp->bb_free %d\n",
+			 group, grp->bb_free);
+		free = grp->bb_free;
 		goto out;
 	}
 
@@ -3994,6 +4019,9 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 	put_bh(bitmap_bh);
+out_dbg:
+	mb_debug(1, "discarded (%d) blocks preallocated for group %u fastpath (%d)\n",
+		 free, group, fastpath);
 	return free;
 }
 
@@ -4464,17 +4492,39 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 	return 0;
 }
 
+/*
+ * ext4_mb_discard_preallocations: This function loop over each group's prealloc
+ * list and try to free it. It may so happen that more than 1 process try to
+ * call this function in parallel. That's why we initially take a fastpath
+ * approach in which we first check if the grp->bb_prealloc_list is empty,
+ * that could mean that, someone else may have removed all of it's PA and added
+ * into it's local list. So we quickly return from there and try to discard
+ * next group's PAs. This way we try to parallelize discarding of multiple group
+ * PAs. But in case if any of the process is unfortunate to not able to free
+ * any of group's PA, then we retry with slow path which will gurantee that
+ * either some PAs will be made free or we will get group->bb_free blocks
+ * (grp->bb_free if non-zero gurantees forward progress in ext4_mb_new_blocks())
+ */
 static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
 {
 	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
 	int ret;
 	int freed = 0;
+	bool fastpath = true;
+	int tmp_needed;
 
-	trace_ext4_mb_discard_preallocations(sb, needed);
-	for (i = 0; i < ngroups && needed > 0; i++) {
-		ret = ext4_mb_discard_group_preallocations(sb, i, needed);
+repeat:
+	tmp_needed = needed;
+	trace_ext4_mb_discard_preallocations(sb, tmp_needed);
+	for (i = 0; i < ngroups && tmp_needed > 0; i++) {
+		ret = ext4_mb_discard_group_preallocations(sb, i, tmp_needed,
+							   fastpath);
 		freed += ret;
-		needed -= ret;
+		tmp_needed -= ret;
+	}
+	if (!freed && fastpath) {
+		fastpath = false;
+		goto repeat;
 	}
 
 	return freed;
-- 
2.21.0

