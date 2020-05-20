Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB641DAAC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 08:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgETGlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 02:41:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbgETGlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 02:41:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04K6c9wO177503;
        Wed, 20 May 2020 02:41:07 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312ageeua1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 02:41:07 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04K6f5ZI014148;
        Wed, 20 May 2020 06:41:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 313xcd18r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 06:41:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04K6f2Et58458538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 06:41:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9CF9A4060;
        Wed, 20 May 2020 06:41:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54E2FA405C;
        Wed, 20 May 2020 06:41:00 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.188.115])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 May 2020 06:41:00 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv5 3/5] ext4: mballoc: Introduce pcpu seqcnt for freeing PA to improve ENOSPC handling
Date:   Wed, 20 May 2020 12:10:34 +0530
Message-Id: <7f254686903b87c419d798742fd9a1be34f0657b.1589955723.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589955723.git.riteshh@linux.ibm.com>
References: <cover.1589955723.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_02:2020-05-19,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=3 cotscore=-2147483648
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200051
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There could be a race in function ext4_mb_discard_group_preallocations()
where the 1st thread may iterate through group's bb_prealloc_list and
remove all the PAs and add to function's local list head.
Now if the 2nd thread comes in to discard the group preallocations,
it will see that the group->bb_prealloc_list is empty and will return 0.

Consider for a case where we have less number of groups
(for e.g. just group 0),
this may even return an -ENOSPC error from ext4_mb_new_blocks()
(where we call for ext4_mb_discard_group_preallocations()).
But that is wrong, since 2nd thread should have waited for 1st thread
to release all the PAs and should have retried for allocation.
Since 1st thread was anyway going to discard the PAs.

The algorithm using this percpu seq counter goes below:
1. We sample the percpu discard_pa_seq counter before trying for block
   allocation in ext4_mb_new_blocks().
2. We increment this percpu discard_pa_seq counter when we either allocate
   or free these blocks i.e. while marking those blocks as used/free in
   mb_mark_used()/mb_free_blocks().
3. We also increment this percpu seq counter when we successfully identify
   that the bb_prealloc_list is not empty and hence proceed for discarding
   of those PAs inside ext4_mb_discard_group_preallocations().

Now to make sure that the regular fast path of block allocation is not
affected, as a small optimization we only sample the percpu seq counter
on that cpu. Only when the block allocation fails and when freed blocks
found were 0, that is when we sample percpu seq counter for all cpus using
below function ext4_get_discard_pa_seq_sum(). This happens after making
sure that all the PAs on grp->bb_prealloc_list got freed or if it's empty.

It can be well argued that why don't just check for grp->bb_free to
see if there are any free blocks to be allocated. So here are the two
concerns which were discussed:-

1. If for some reason the blocks available in the group are not
   appropriate for allocation logic (say for e.g.
   EXT4_MB_HINT_GOAL_ONLY, although this is not yet implemented), then
   the retry logic may result into infinte looping since grp->bb_free is
   non-zero.

2. Also before preallocation was clubbed with block allocation with the
   same ext4_lock_group() held, there were lot of races where grp->bb_free
   could not be reliably relied upon.
Due to above, this patch considers discard_pa_seq logic to determine if
we should retry for block allocation. Say if there are are n threads
trying for block allocation and none of those could allocate or discard
any of the blocks, then all of those n threads will fail the block
allocation and return -ENOSPC error. (Since the seq counter for all of
those will match as no block allocation/discard was done during that
duration).

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 56 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b75408d72773..754ff9f65199 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -351,6 +351,35 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 						ext4_group_t group);
 static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 
+/*
+ * The algorithm using this percpu seq counter goes below:
+ * 1. We sample the percpu discard_pa_seq counter before trying for block
+ *    allocation in ext4_mb_new_blocks().
+ * 2. We increment this percpu discard_pa_seq counter when we either allocate
+ *    or free these blocks i.e. while marking those blocks as used/free in
+ *    mb_mark_used()/mb_free_blocks().
+ * 3. We also increment this percpu seq counter when we successfully identify
+ *    that the bb_prealloc_list is not empty and hence proceed for discarding
+ *    of those PAs inside ext4_mb_discard_group_preallocations().
+ *
+ * Now to make sure that the regular fast path of block allocation is not
+ * affected, as a small optimization we only sample the percpu seq counter
+ * on that cpu. Only when the block allocation fails and when freed blocks
+ * found were 0, that is when we sample percpu seq counter for all cpus using
+ * below function ext4_get_discard_pa_seq_sum(). This happens after making
+ * sure that all the PAs on grp->bb_prealloc_list got freed or if it's empty.
+ */
+static DEFINE_PER_CPU(u64, discard_pa_seq);
+static inline u64 ext4_get_discard_pa_seq_sum(void)
+{
+	int __cpu;
+	u64 __seq = 0;
+
+	for_each_possible_cpu(__cpu)
+		__seq += per_cpu(discard_pa_seq, __cpu);
+	return __seq;
+}
+
 static inline void *mb_correct_addr_and_bit(int *bit, void *addr)
 {
 #if BITS_PER_LONG == 64
@@ -1462,6 +1491,7 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 	mb_check_buddy(e4b);
 	mb_free_blocks_double(inode, e4b, first, count);
 
+	this_cpu_inc(discard_pa_seq);
 	e4b->bd_info->bb_free += count;
 	if (first < e4b->bd_info->bb_first_free)
 		e4b->bd_info->bb_first_free = first;
@@ -1603,6 +1633,7 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
 	mb_check_buddy(e4b);
 	mb_mark_used_double(e4b, start, len);
 
+	this_cpu_inc(discard_pa_seq);
 	e4b->bd_info->bb_free -= len;
 	if (e4b->bd_info->bb_first_free == start)
 		e4b->bd_info->bb_first_free += len;
@@ -3962,6 +3993,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	INIT_LIST_HEAD(&list);
 repeat:
 	ext4_lock_group(sb, group);
+	this_cpu_inc(discard_pa_seq);
 	list_for_each_entry_safe(pa, tmp,
 				&grp->bb_prealloc_list, pa_group_list) {
 		spin_lock(&pa->pa_lock);
@@ -4544,14 +4576,26 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
 }
 
 static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
-			struct ext4_allocation_context *ac)
+			struct ext4_allocation_context *ac, u64 *seq)
 {
 	int freed;
+	u64 seq_retry = 0;
+	bool ret = false;
 
 	freed = ext4_mb_discard_preallocations(sb, ac->ac_o_ex.fe_len);
-	if (freed)
-		return true;
-	return false;
+	if (freed) {
+		ret = true;
+		goto out_dbg;
+	}
+	seq_retry = ext4_get_discard_pa_seq_sum();
+	if (seq_retry != *seq) {
+		*seq = seq_retry;
+		ret = true;
+	}
+
+out_dbg:
+	mb_debug(sb, "freed %d, retry ? %s\n", freed, ret ? "yes" : "no");
+	return ret;
 }
 
 /*
@@ -4568,6 +4612,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	ext4_fsblk_t block = 0;
 	unsigned int inquota = 0;
 	unsigned int reserv_clstrs = 0;
+	u64 seq;
 
 	might_sleep();
 	sb = ar->inode->i_sb;
@@ -4630,6 +4675,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	}
 
 	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
+	seq = *this_cpu_ptr(&discard_pa_seq);
 	if (!ext4_mb_use_preallocated(ac)) {
 		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
 		ext4_mb_normalize_request(ac, ar);
@@ -4666,7 +4712,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ar->len = ac->ac_b_ex.fe_len;
 		}
 	} else {
-		if (ext4_mb_discard_preallocations_should_retry(sb, ac))
+		if (ext4_mb_discard_preallocations_should_retry(sb, ac, &seq))
 			goto repeat;
 		/*
 		 * If block allocation fails then the pa allocated above
-- 
2.21.0

