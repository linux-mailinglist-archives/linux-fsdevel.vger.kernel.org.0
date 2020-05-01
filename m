Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FE11C0E0E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgEAGa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:30:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728126AbgEAGa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:30:27 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04162m7O022282;
        Fri, 1 May 2020 02:30:18 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r7md9jr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 02:30:17 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0416AqO8009353;
        Fri, 1 May 2020 06:30:15 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 30mcu746ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 06:30:15 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0416UC6g51904974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 06:30:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC760A405B;
        Fri,  1 May 2020 06:30:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40C00A4062;
        Fri,  1 May 2020 06:30:11 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.81.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 06:30:11 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 02/20] ext4: Introduce percpu seq counter for freeing blocks(PA) to avoid ENOSPC err
Date:   Fri,  1 May 2020 11:59:44 +0530
Message-Id: <65959db57fa53e5d3d63099b0d5c039ab1154253.1588313626.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588313626.git.riteshh@linux.ibm.com>
References: <cover.1588313626.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_01:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010044
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
2. We increment this percpu discard_pa_seq counter when we succeed in
   allocating blocks and hence while adding the remaining blocks in group's
   bb_prealloc_list (ext4_mb_new_inode_pa/ext4_mb_new_group_pa).
3. We also increment this percpu seq counter when we successfully identify
   that the bb_prealloc_list is not empty and hence proceed for discarding
   of those PAs inside ext4_mb_discard_group_preallocations().

Now to make sure that the regular fast path of block allocation is not
affected, as a small optimization we only sample the percpu seq counter
on that cpu. Only when the block allocation fails and when freed blocks
found were 0, that is when we sample percpu seq counter for all cpus using
below function ext4_get_discard_pa_seq_sum(). This happens after making
sure that all the PAs on grp->bb_prealloc_list got freed.

TO CHECK: Though in here rcu_barrier only happens in ENOSPC path.
=================================================================
On rcu_barrier() - How expensive it can be?
Does that mean that every thread who is coming and waiting on
rcu_barrier() will actually check whether call_rcu() has completed by
checking that on every cpu? So will this be a O(n*m) operation?
(n = no. of threads, m = no. of cpus).
Or are there some sort of optimization in using rcu_barrier()?

---
Note: The other method [1] also used to check for grp->bb_free next time
if we couldn't discard anything. But it had below concerns due to which
we cannot use that approach.
1. But one suspicion with that was that if grp->bb_free is non-zero for some
reason (not sure), then we may result in that loop indefinitely but still
won't be able to satisfy any request.
2. To check for grp->bb_free all threads were to wait on grp's spin_lock
which might result in increased cpu usage.
3. In case of group's PA allocation (i.e. when file's size is < 1MB for
   64K blocksize), there is still a case where ENOSPC could be returned.
   This happens when the grp->bb_free is set to 0 but those blocks are
   actually not yet added to PA. Yes, this could actually happen since
   reducing grp->bb_free and adding those extra blocks in
   bb_prealloc_list are not done atomically. Hence the race.

[1]: https://patchwork.ozlabs.org/project/linux-ext4/patch/533ac1f5b19c520b08f8c99aec5baf8729185714.1586954511.git.riteshh@linux.ibm.com/

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 65 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a742e51e33b8..6bb08bb3c0ce 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -357,6 +357,35 @@ static void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 						ext4_group_t group);
 
+/*
+ * The algorithm using this percpu seq counter goes below:
+ * 1. We sample the percpu discard_pa_seq counter before trying for block
+ *    allocation in ext4_mb_new_blocks().
+ * 2. We increment this percpu discard_pa_seq counter when we succeed in
+ *    allocating blocks and hence while adding the remaining blocks in group's
+ *    bb_prealloc_list (ext4_mb_new_inode_pa/ext4_mb_new_group_pa).
+ * 3. We also increment this percpu seq counter when we successfully identify
+ *    that the bb_prealloc_list is not empty and hence proceed for discarding
+ *    of those PAs inside ext4_mb_discard_group_preallocations().
+ *
+ * Now to make sure that the regular fast path of block allocation is not
+ * affected, as a small optimization we only sample the percpu seq counter
+ * on that cpu. Only when the block allocation fails and when freed blocks
+ * found were 0, that is when we sample percpu seq counter for all cpus using
+ * below function ext4_get_discard_pa_seq_sum(). This happens after making
+ * sure that all the PAs on grp->bb_prealloc_list got freed.
+ */
+DEFINE_PER_CPU(u64, discard_pa_seq);
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
@@ -3730,6 +3759,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa->pa_inode = ac->ac_inode;
 
 	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
+	this_cpu_inc(discard_pa_seq);
 	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
 	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
 
@@ -3791,6 +3821,7 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	pa->pa_inode = NULL;
 
 	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
+	this_cpu_inc(discard_pa_seq);
 	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
 	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
 
@@ -3943,6 +3974,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	INIT_LIST_HEAD(&list);
 repeat:
 	ext4_lock_group(sb, group);
+	this_cpu_inc(discard_pa_seq);
 	list_for_each_entry_safe(pa, tmp,
 				&grp->bb_prealloc_list, pa_group_list) {
 		spin_lock(&pa->pa_lock);
@@ -4487,14 +4519,35 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
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
+	/*
+	 * Unless it is ensured that PAs are actually freed, we may hit
+	 * a ENOSPC error since the next time seq may match while the PA blocks
+	 * are still getting freed in ext4_mb_release_inode/group_pa().
+	 * So, rcu_barrier() here is to make sure that any call_rcu queued in
+	 * ext4_mb_discard_group_preallocations() is completed before we
+	 * proceed further to retry for block allocation.
+	 */
+	rcu_barrier();
+	seq_retry = ext4_get_discard_pa_seq_sum();
+	if (seq_retry != *seq) {
+		*seq = seq_retry;
+		ret = true;
+	}
+
+out_dbg:
+	mb_debug(1, "freed %d, retry ? %s\n", freed, ret ? "yes" : "no");
+	return ret;
 }
 
 /*
@@ -4511,6 +4564,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	ext4_fsblk_t block = 0;
 	unsigned int inquota = 0;
 	unsigned int reserv_clstrs = 0;
+	u64 seq;
 
 	might_sleep();
 	sb = ar->inode->i_sb;
@@ -4572,6 +4626,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	}
 
 	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
+	seq = *this_cpu_ptr(&discard_pa_seq);
 	if (!ext4_mb_use_preallocated(ac)) {
 		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
 		ext4_mb_normalize_request(ac, ar);
@@ -4603,7 +4658,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ar->len = ac->ac_b_ex.fe_len;
 		}
 	} else {
-		if (ext4_mb_discard_preallocations_should_retry(sb, ac))
+		if (ext4_mb_discard_preallocations_should_retry(sb, ac, &seq))
 			goto repeat;
 		*errp = -ENOSPC;
 	}
-- 
2.21.0

