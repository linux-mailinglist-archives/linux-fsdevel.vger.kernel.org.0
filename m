Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711061C0E2E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgEAGa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:30:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728342AbgEAGa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:30:58 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04162RWc018977;
        Fri, 1 May 2020 02:30:52 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r82sgxex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 02:30:51 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0416Auf3014980;
        Fri, 1 May 2020 06:30:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 30mcu8fa9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 06:30:49 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0416Uk0J57147546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 06:30:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26561A405C;
        Fri,  1 May 2020 06:30:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E6F0A4054;
        Fri,  1 May 2020 06:30:44 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.81.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 06:30:43 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 18/20] ext4: mballoc: Make mb_debug() implementation to use pr_debug()
Date:   Fri,  1 May 2020 12:00:00 +0530
Message-Id: <a8056ffcc880cdb84584816ec817cb3393c18a2a.1588313626.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588313626.git.riteshh@linux.ibm.com>
References: <cover.1588313626.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_01:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=3 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010040
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mb_debug() msg had only 1 control level for all type of msgs.
And if we enable mballoc_debug then all of those msgs would be enabled.
Instead of adding multiple debug levels for mb_debug() msgs, use
pr_debug() with which we could have finer control to print msgs at all
of different levels (i.e. at file, func, line no.).

Also add process name/pid, superblk id, and other info in mb_debug()
msg. This also kills the mballoc_debug module parameter, since it is
not needed any more.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/Kconfig   |   3 +-
 fs/ext4/mballoc.c | 106 +++++++++++++++++++++-------------------------
 fs/ext4/mballoc.h |  16 +++----
 3 files changed, 56 insertions(+), 69 deletions(-)

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 2a592e38cdfe..02376ddb0cb5 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -99,8 +99,7 @@ config EXT4_DEBUG
 	  Enables run-time debugging support for the ext4 filesystem.
 
 	  If you select Y here, then you will be able to turn on debugging
-	  with a command such as:
-		echo 1 > /sys/module/ext4/parameters/mballoc_debug
+	  using dynamic debug control for mb_debug() msgs.
 
 config EXT4_KUNIT_TESTS
 	tristate "KUnit tests for ext4"
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index aa22ecf3f827..72d7bd6ac3ba 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -18,13 +18,6 @@
 #include <linux/backing-dev.h>
 #include <trace/events/ext4.h>
 
-#ifdef CONFIG_EXT4_DEBUG
-ushort ext4_mballoc_debug __read_mostly;
-
-module_param_named(mballoc_debug, ext4_mballoc_debug, ushort, 0644);
-MODULE_PARM_DESC(mballoc_debug, "Debugging level for ext4's mballoc");
-#endif
-
 /*
  * MUSTDO:
  *   - test ext4_ext_search_left() and ext4_ext_search_right()
@@ -889,14 +882,14 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 	char *bitmap;
 	struct ext4_group_info *grinfo;
 
-	mb_debug(1, "init page %lu\n", page->index);
-
 	inode = page->mapping->host;
 	sb = inode->i_sb;
 	ngroups = ext4_get_groups_count(sb);
 	blocksize = i_blocksize(inode);
 	blocks_per_page = PAGE_SIZE / blocksize;
 
+	mb_debug(sb, "init page %lu\n", page->index);
+
 	groups_per_page = blocks_per_page >> 1;
 	if (groups_per_page == 0)
 		groups_per_page = 1;
@@ -936,7 +929,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			bh[i] = NULL;
 			goto out;
 		}
-		mb_debug(1, "read bitmap for group %u\n", group);
+		mb_debug(sb, "read bitmap for group %u\n", group);
 	}
 
 	/* wait for I/O completion */
@@ -981,7 +974,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 		if ((first_block + i) & 1) {
 			/* this is block of buddy */
 			BUG_ON(incore == NULL);
-			mb_debug(1, "put buddy for group %u in page %lu/%x\n",
+			mb_debug(sb, "put buddy for group %u in page %lu/%x\n",
 				group, page->index, i * blocksize);
 			trace_ext4_mb_buddy_bitmap_load(sb, group);
 			grinfo = ext4_get_group_info(sb, group);
@@ -1001,7 +994,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 		} else {
 			/* this is block of bitmap */
 			BUG_ON(incore != NULL);
-			mb_debug(1, "put bitmap for group %u in page %lu/%x\n",
+			mb_debug(sb, "put bitmap for group %u in page %lu/%x\n",
 				group, page->index, i * blocksize);
 			trace_ext4_mb_bitmap_load(sb, group);
 
@@ -1107,7 +1100,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 	int ret = 0;
 
 	might_sleep();
-	mb_debug(1, "init group %u\n", group);
+	mb_debug(sb, "init group %u\n", group);
 	this_grp = ext4_get_group_info(sb, group);
 	/*
 	 * This ensures that we don't reinit the buddy cache
@@ -1179,7 +1172,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	struct inode *inode = sbi->s_buddy_cache;
 
 	might_sleep();
-	mb_debug(1, "load group %u\n", group);
+	mb_debug(sb, "load group %u\n", group);
 
 	blocks_per_page = PAGE_SIZE / sb->s_blocksize;
 	grp = ext4_get_group_info(sb, group);
@@ -2327,7 +2320,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	if (!err && ac->ac_status != AC_STATUS_FOUND && first_err)
 		err = first_err;
 
-	mb_debug(1, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
+	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
 		 ac->ac_flags, cr, err);
 	return err;
@@ -2759,7 +2752,7 @@ int ext4_mb_init(struct super_block *sb)
 }
 
 /* need to called with the ext4 group lock held */
-static void ext4_mb_cleanup_pa(struct ext4_group_info *grp)
+static int ext4_mb_cleanup_pa(struct ext4_group_info *grp)
 {
 	struct ext4_prealloc_space *pa;
 	struct list_head *cur, *tmp;
@@ -2771,9 +2764,7 @@ static void ext4_mb_cleanup_pa(struct ext4_group_info *grp)
 		count++;
 		kmem_cache_free(ext4_pspace_cachep, pa);
 	}
-	if (count)
-		mb_debug(1, "mballoc: %u PAs left\n", count);
-
+	return count;
 }
 
 int ext4_mb_release(struct super_block *sb)
@@ -2784,6 +2775,7 @@ int ext4_mb_release(struct super_block *sb)
 	struct ext4_group_info *grinfo, ***group_info;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct kmem_cache *cachep = get_groupinfo_cache(sb->s_blocksize_bits);
+	int count;
 
 	if (sbi->s_group_info) {
 		for (i = 0; i < ngroups; i++) {
@@ -2791,7 +2783,10 @@ int ext4_mb_release(struct super_block *sb)
 			grinfo = ext4_get_group_info(sb, i);
 			mb_group_bb_bitmap_free(grinfo);
 			ext4_lock_group(sb, i);
-			ext4_mb_cleanup_pa(grinfo);
+			count = ext4_mb_cleanup_pa(grinfo);
+			if (count)
+				mb_debug(sb, "mballoc: %d PAs left\n",
+					 count);
 			ext4_unlock_group(sb, i);
 			kmem_cache_free(cachep, grinfo);
 		}
@@ -2864,7 +2859,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	struct ext4_group_info *db;
 	int err, count = 0, count2 = 0;
 
-	mb_debug(1, "gonna free %u blocks in group %u (0x%p):",
+	mb_debug(sb, "gonna free %u blocks in group %u (0x%p):",
 		 entry->efd_count, entry->efd_group, entry);
 
 	err = ext4_mb_load_buddy(sb, entry->efd_group, &e4b);
@@ -2904,7 +2899,8 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	kmem_cache_free(ext4_free_data_cachep, entry);
 	ext4_mb_unload_buddy(&e4b);
 
-	mb_debug(1, "freed %u blocks in %u structures\n", count, count2);
+	mb_debug(sb, "freed %d blocks in %d structures\n", count,
+		 count2);
 }
 
 /*
@@ -3135,8 +3131,7 @@ static void ext4_mb_normalize_group_request(struct ext4_allocation_context *ac)
 
 	BUG_ON(lg == NULL);
 	ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc;
-	mb_debug(1, "#%u: goal %u blocks for locality group\n",
-		current->pid, ac->ac_g_ex.fe_len);
+	mb_debug(sb, "goal %u blocks for locality group\n", ac->ac_g_ex.fe_len);
 }
 
 /*
@@ -3330,8 +3325,8 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
 	}
 
-	mb_debug(1, "goal: %lld(was %lld) blocks at %u\n", size, orig_size,
-		 start);
+	mb_debug(ac->ac_sb, "goal: %lld(was %lld) blocks at %u\n", size,
+		 orig_size, start);
 }
 
 static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
@@ -3420,7 +3415,7 @@ static void ext4_mb_use_inode_pa(struct ext4_allocation_context *ac,
 	BUG_ON(pa->pa_free < len);
 	pa->pa_free -= len;
 
-	mb_debug(1, "use %llu/%d from inode pa %p\n", start, len, pa);
+	mb_debug(ac->ac_sb, "use %llu/%d from inode pa %p\n", start, len, pa);
 }
 
 /*
@@ -3444,7 +3439,8 @@ static void ext4_mb_use_group_pa(struct ext4_allocation_context *ac,
 	 * in on-disk bitmap -- see ext4_mb_release_context()
 	 * Other CPUs are prevented from allocating from this pa by lg_mutex
 	 */
-	mb_debug(1, "use %u/%u from group pa %p\n", pa->pa_lstart-len, len, pa);
+	mb_debug(ac->ac_sb, "use %u/%u from group pa %p\n",
+		 pa->pa_lstart-len, len, pa);
 }
 
 /*
@@ -3627,7 +3623,7 @@ void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 		ext4_set_bits(bitmap, start, len);
 		preallocated += len;
 	}
-	mb_debug(1, "preallocated %d for group %u\n", preallocated, group);
+	mb_debug(sb, "preallocated %d for group %u\n", preallocated, group);
 }
 
 static void ext4_mb_pa_callback(struct rcu_head *head)
@@ -3770,8 +3766,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa->pa_deleted = 0;
 	pa->pa_type = MB_INODE_PA;
 
-	mb_debug(1, "new inode pa %p: %llu/%d for %u\n", pa,
-			pa->pa_pstart, pa->pa_len, pa->pa_lstart);
+	mb_debug(sb, "new inode pa %p: %llu/%d for %u\n", pa, pa->pa_pstart,
+		 pa->pa_len, pa->pa_lstart);
 	trace_ext4_mb_new_inode_pa(ac, pa);
 
 	ext4_mb_use_inode_pa(ac, pa);
@@ -3831,8 +3827,8 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	pa->pa_deleted = 0;
 	pa->pa_type = MB_GROUP_PA;
 
-	mb_debug(1, "new group pa %p: %llu/%d for %u\n", pa,
-			pa->pa_pstart, pa->pa_len, pa->pa_lstart);
+	mb_debug(sb, "new group pa %p: %llu/%d for %u\n", pa, pa->pa_pstart,
+		 pa->pa_len, pa->pa_lstart);
 	trace_ext4_mb_new_group_pa(ac, pa);
 
 	ext4_mb_use_group_pa(ac, pa);
@@ -3900,7 +3896,7 @@ ext4_mb_release_inode_pa(struct ext4_buddy *e4b, struct buffer_head *bitmap_bh,
 		if (bit >= end)
 			break;
 		next = mb_find_next_bit(bitmap_bh->b_data, end, bit);
-		mb_debug(1, "    free preallocated %u/%u in group %u\n",
+		mb_debug(sb, "free preallocated %u/%u in group %u\n",
 			 (unsigned) ext4_group_first_block_no(sb, group) + bit,
 			 (unsigned) next - bit, (unsigned) group);
 		free += next - bit;
@@ -3971,8 +3967,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	int busy = 0;
 	int free = 0;
 
-	mb_debug(1, "discard preallocation for group %u\n", group);
-
+	mb_debug(sb, "discard preallocation for group %u\n", group);
 	if (list_empty(&grp->bb_prealloc_list))
 		goto out_dbg;
 
@@ -4036,7 +4031,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	/* found anything to free? */
 	if (list_empty(&list)) {
 		BUG_ON(free != 0);
-		mb_debug(1, "Someone else may have freed PA for this group %u\n",
+		mb_debug(sb, "Someone else may have freed PA for this group %u\n",
 			 group);
 		goto out;
 	}
@@ -4063,7 +4058,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	ext4_mb_unload_buddy(&e4b);
 	put_bh(bitmap_bh);
 out_dbg:
-	mb_debug(1, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
+	mb_debug(sb, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
 		 free, group, grp->bb_free);
 	return free;
 }
@@ -4093,7 +4088,8 @@ void ext4_discard_preallocations(struct inode *inode)
 		return;
 	}
 
-	mb_debug(1, "discard preallocation for inode %lu\n", inode->i_ino);
+	mb_debug(sb, "discard preallocation for inode %lu\n",
+		 inode->i_ino);
 	trace_ext4_discard_preallocations(inode);
 
 	INIT_LIST_HEAD(&list);
@@ -4186,12 +4182,11 @@ static inline void ext4_mb_show_pa(struct super_block *sb)
 {
 	ext4_group_t i, ngroups;
 
-	if (!ext4_mballoc_debug ||
-	    (EXT4_SB(sb)->s_mount_flags & EXT4_MF_FS_ABORTED))
+	if (EXT4_SB(sb)->s_mount_flags & EXT4_MF_FS_ABORTED)
 		return;
 
 	ngroups = ext4_get_groups_count(sb);
-	ext4_msg(sb, KERN_ERR, "groups: ");
+	mb_debug(sb, "groups: ");
 	for (i = 0; i < ngroups; i++) {
 		struct ext4_group_info *grp = ext4_get_group_info(sb, i);
 		struct ext4_prealloc_space *pa;
@@ -4205,30 +4200,27 @@ static inline void ext4_mb_show_pa(struct super_block *sb)
 			ext4_get_group_no_and_offset(sb, pa->pa_pstart,
 						     NULL, &start);
 			spin_unlock(&pa->pa_lock);
-			printk(KERN_ERR "PA:%u:%d:%d \n", i,
-			       start, pa->pa_len);
+			mb_debug(sb, "PA:%u:%d:%d\n", i, start,
+				 pa->pa_len);
 		}
 		ext4_unlock_group(sb, i);
-
-		printk(KERN_ERR "%u: %d/%d \n",
-		       i, grp->bb_free, grp->bb_fragments);
+		mb_debug(sb, "%u: %d/%d\n", i, grp->bb_free,
+			 grp->bb_fragments);
 	}
-	printk(KERN_ERR "\n");
 }
 
 static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 {
 	struct super_block *sb = ac->ac_sb;
 
-	if (!ext4_mballoc_debug ||
-	    (EXT4_SB(sb)->s_mount_flags & EXT4_MF_FS_ABORTED))
+	if (EXT4_SB(sb)->s_mount_flags & EXT4_MF_FS_ABORTED)
 		return;
 
-	ext4_msg(sb, KERN_ERR, "Can't allocate:"
+	mb_debug(sb, "Can't allocate:"
 			" Allocation context details:");
-	ext4_msg(sb, KERN_ERR, "status %u flags 0x%x",
+	mb_debug(sb, "status %u flags 0x%x",
 			ac->ac_status, ac->ac_flags);
-	ext4_msg(sb, KERN_ERR, "orig %lu/%lu/%lu@%lu, "
+	mb_debug(sb, "orig %lu/%lu/%lu@%lu, "
 			"goal %lu/%lu/%lu@%lu, "
 			"best %lu/%lu/%lu@%lu cr %d",
 			(unsigned long)ac->ac_o_ex.fe_group,
@@ -4244,7 +4236,7 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 			(unsigned long)ac->ac_b_ex.fe_len,
 			(unsigned long)ac->ac_b_ex.fe_logical,
 			(int)ac->ac_criteria);
-	ext4_msg(sb, KERN_ERR, "%u found", ac->ac_found);
+	mb_debug(sb, "%u found", ac->ac_found);
 	ext4_mb_show_pa(sb);
 }
 #else
@@ -4354,7 +4346,7 @@ ext4_mb_initialize_context(struct ext4_allocation_context *ac,
 	 * locality group. this is a policy, actually */
 	ext4_mb_group_or_file(ac);
 
-	mb_debug(1, "init ac: %u blocks @ %u, goal %u, flags %x, 2^%d, "
+	mb_debug(sb, "init ac: %u blocks @ %u, goal %u, flags 0x%x, 2^%d, "
 			"left: %u/%u, right %u/%u to %swritable\n",
 			(unsigned) ar->len, (unsigned) ar->logical,
 			(unsigned) ar->goal, ac->ac_flags, ac->ac_2order,
@@ -4375,7 +4367,7 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 	struct list_head discard_list;
 	struct ext4_prealloc_space *pa, *tmp;
 
-	mb_debug(1, "discard locality group preallocation\n");
+	mb_debug(sb, "discard locality group preallocation\n");
 
 	INIT_LIST_HEAD(&discard_list);
 
@@ -4586,7 +4578,7 @@ static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
 	}
 
 out_dbg:
-	mb_debug(1, "freed %d, retry ? %s\n", freed, ret ? "yes" : "no");
+	mb_debug(sb, "freed %d, retry ? %s\n", freed, ret ? "yes" : "no");
 	return ret;
 }
 
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 88c98f17e3d9..6b4d17c2935d 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -24,19 +24,15 @@
 #include "ext4.h"
 
 /*
+ * mb_debug() dynamic printk msgs could be used to debug mballoc code.
  */
 #ifdef CONFIG_EXT4_DEBUG
-extern ushort ext4_mballoc_debug;
-
-#define mb_debug(n, fmt, ...)	                                        \
-do {									\
-	if ((n) <= ext4_mballoc_debug) {				\
-		printk(KERN_DEBUG "(%s, %d): %s: " fmt,			\
-		       __FILE__, __LINE__, __func__, ##__VA_ARGS__);	\
-	}								\
-} while (0)
+#define mb_debug(sb, fmt, ...)						\
+	pr_debug("[%s/%d] EXT4-fs (%s): (%s, %d): %s: " fmt,		\
+		current->comm, task_pid_nr(current), sb->s_id,		\
+	       __FILE__, __LINE__, __func__, ##__VA_ARGS__)
 #else
-#define mb_debug(n, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
+#define mb_debug(sb, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 #define EXT4_MB_HISTORY_ALLOC		1	/* allocation */
-- 
2.21.0

