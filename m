Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C50A1CC780
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 09:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgEJHJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 03:09:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728575AbgEJHJD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 03:09:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A73mht072448;
        Sun, 10 May 2020 03:08:57 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30xa2g2uf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 03:08:56 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A75lND019199;
        Sun, 10 May 2020 07:08:55 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 30wm558u3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 07:08:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A78qKl34209958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 07:08:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10B4F4204C;
        Sun, 10 May 2020 07:08:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ED2942041;
        Sun, 10 May 2020 07:08:50 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 07:08:50 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFCv4 6/6] ext4: mballoc: Introduce pcpu seqcnt for freeing PA to improve ENOSPC handling
Date:   Sun, 10 May 2020 12:38:26 +0530
Message-Id: <c3b8a0dd3195c662666381023791d28242ef4552.1589086820.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086820.git.riteshh@linux.ibm.com>
References: <cover.1589086820.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_02:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=3 malwarescore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100065
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
index c18670924bbe..ddf2179ed7cf 100644
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
@@ -3989,6 +4020,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	INIT_LIST_HEAD(&list);
 repeat:
 	ext4_lock_group(sb, group);
+	this_cpu_inc(discard_pa_seq);
 	list_for_each_entry_safe(pa, tmp,
 				&grp->bb_prealloc_list, pa_group_list) {
 		spin_lock(&pa->pa_lock);
@@ -4571,14 +4603,26 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
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
@@ -4595,6 +4639,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	ext4_fsblk_t block = 0;
 	unsigned int inquota = 0;
 	unsigned int reserv_clstrs = 0;
+	u64 seq;
 
 	might_sleep();
 	sb = ar->inode->i_sb;
@@ -4657,6 +4702,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	}
 
 	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
+	seq = *this_cpu_ptr(&discard_pa_seq);
 	if (!ext4_mb_use_preallocated(ac)) {
 		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
 		ext4_mb_normalize_request(ac, ar);
@@ -4693,7 +4739,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
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

