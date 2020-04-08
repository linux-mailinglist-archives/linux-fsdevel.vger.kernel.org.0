Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B451A278F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 18:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgDHQy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 12:54:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729133AbgDHQy0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:54:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 038GYRks167301
        for <linux-fsdevel@vger.kernel.org>; Wed, 8 Apr 2020 12:54:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 309gw0u8by-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2020 12:54:25 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 8 Apr 2020 17:53:59 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Apr 2020 17:53:56 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 038GsKLh43712608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Apr 2020 16:54:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0952A405C;
        Wed,  8 Apr 2020 16:54:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE36EA4054;
        Wed,  8 Apr 2020 16:54:17 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.42])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Apr 2020 16:54:17 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        sandeen@sandeen.net, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 1/1] ext4: Fix race in ext4_mb_discard_group_preallocations()
Date:   Wed,  8 Apr 2020 22:24:10 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1586358980.git.riteshh@linux.ibm.com>
References: <cover.1586358980.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040816-4275-0000-0000-000003BC2467
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040816-4276-0000-0000-000038D1894F
Message-Id: <2e231c371cc83357a6c9d55e4f7284f6c1fb1741.1586358980.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_10:2020-04-07,2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=3 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080125
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

This patch fixes this race by checking if nothing could be collected
in the local list. This could mean that someone else might have freed
all of this group PAs for us. So simply return group->bb_free which
should also give us an upper bound on the total available space for
allocation in this group.

We need not check the fast path of whether the list (bb_prealloc_list)
is empty, since we are anyway in the slow path where the
ext4_mb_regular_allocator() has failed and hence we are now desperately trying
to discard all the group PAs to free up some space for allocation.

Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1027e01c9011..a6c92567ec14 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3885,7 +3885,18 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
 }
 
 /*
- * releases all preallocations in given group
+ * This function discards all the preallocations for the given group.
+ * In this there could be a race with another process also trying to discard
+ * the PAs. So if we could not get any PA from grp->bb_prealloc_list into our
+ * local list, then we simply return grp->bb_free. This now will be an
+ * upper bound of the available space for that group. If we choose to return 0
+ * instead, then we may end up returning -ENOSPC error in the worst case
+ * scenario, which is certainly wrong.
+ *
+ * return value could be either of 2 below:-
+ *  - actual discarded PA blocks from grp->bb_prealloc_list.
+ *  - grp->bb_free value. (this will be 0 only when there are actually no free
+ *  block available to be allocated from this group anymore).
  *
  * first, we need to decide discard policy:
  * - when do we discard
@@ -3908,16 +3919,13 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 
 	mb_debug(1, "discard preallocation for group %u\n", group);
 
-	if (list_empty(&grp->bb_prealloc_list))
-		return 0;
-
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
 	if (IS_ERR(bitmap_bh)) {
 		err = PTR_ERR(bitmap_bh);
 		ext4_set_errno(sb, -err);
 		ext4_error(sb, "Error %d reading block bitmap for %u",
 			   err, group);
-		return 0;
+		goto out_dbg;
 	}
 
 	err = ext4_mb_load_buddy(sb, group, &e4b);
@@ -3925,7 +3933,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 		ext4_warning(sb, "Error %d loading buddy information for %u",
 			     err, group);
 		put_bh(bitmap_bh);
-		return 0;
+		goto out_dbg;
 	}
 
 	if (needed == 0)
@@ -3967,9 +3975,15 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
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
 
@@ -3994,6 +4008,9 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 	put_bh(bitmap_bh);
+out_dbg:
+	mb_debug(1, "discarded (%d) blocks preallocated for group %u\n",
+		 free, group);
 	return free;
 }
 
-- 
2.21.0

