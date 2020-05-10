Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA31CC744
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgEJGZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:25:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727122AbgEJGZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:25:57 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A61tbt023783;
        Sun, 10 May 2020 02:25:50 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ws0kc5jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:50 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6KUM0022915;
        Sun, 10 May 2020 06:25:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 30wm558teu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:48 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6PjYk53608454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:25:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A5DD4204F;
        Sun, 10 May 2020 06:25:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FB6B42042;
        Sun, 10 May 2020 06:25:44 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:43 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 14/16] ext4: mballoc: Make mb_debug() implementation to use pr_debug()
Date:   Sun, 10 May 2020 11:54:54 +0530
Message-Id: <f0c660cbde9e2edbe95c67942ca9ad80dd2231eb.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=3 lowpriorityscore=0 phishscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005100050
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
 fs/ext4/mballoc.c | 104 +++++++++++++++++++++-------------------------
 fs/ext4/mballoc.h |  16 +++----
 3 files changed, 55 insertions(+), 68 deletions(-)

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
index c713d06e70b7..33a69424942c 100644
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
@@ -858,14 +851,14 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
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
@@ -905,7 +898,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			bh[i] = NULL;
 			goto out;
 		}
-		mb_debug(1, "read bitmap for group %u\n", group);
+		mb_debug(sb, "read bitmap for group %u\n", group);
 	}
 
 	/* wait for I/O completion */
@@ -950,7 +943,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 		if ((first_block + i) & 1) {
 			/* this is block of buddy */
 			BUG_ON(incore == NULL);
-			mb_debug(1, "put buddy for group %u in page %lu/%x\n",
+			mb_debug(sb, "put buddy for group %u in page %lu/%x\n",
 				group, page->index, i * blocksize);
 			trace_ext4_mb_buddy_bitmap_load(sb, group);
 			grinfo = ext4_get_group_info(sb, group);
@@ -970,7 +963,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 		} else {
 			/* this is block of bitmap */
 			BUG_ON(incore != NULL);
-			mb_debug(1, "put bitmap for group %u in page %lu/%x\n",
+			mb_debug(sb, "put bitmap for group %u in page %lu/%x\n",
 				group, page->index, i * blocksize);
 			trace_ext4_mb_bitmap_load(sb, group);
 
@@ -1076,7 +1069,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 	int ret = 0;
 
 	might_sleep();
-	mb_debug(1, "init group %u\n", group);
+	mb_debug(sb, "init group %u\n", group);
 	this_grp = ext4_get_group_info(sb, group);
 	/*
 	 * This ensures that we don't reinit the buddy cache
@@ -1148,7 +1141,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	struct inode *inode = sbi->s_buddy_cache;
 
 	might_sleep();
-	mb_debug(1, "load group %u\n", group);
+	mb_debug(sb, "load group %u\n", group);
 
 	blocks_per_page = PAGE_SIZE / sb->s_blocksize;
 	grp = ext4_get_group_info(sb, group);
@@ -2299,7 +2292,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	if (!err && ac->ac_status != AC_STATUS_FOUND && first_err)
 		err = first_err;
 
-	mb_debug(1, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
+	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
 		 ac->ac_flags, cr, err);
 	return err;
@@ -2731,7 +2724,7 @@ int ext4_mb_init(struct super_block *sb)
 }
 
 /* need to called with the ext4 group lock held */
-static void ext4_mb_cleanup_pa(struct ext4_group_info *grp)
+static int ext4_mb_cleanup_pa(struct ext4_group_info *grp)
 {
 	struct ext4_prealloc_space *pa;
 	struct list_head *cur, *tmp;
@@ -2743,9 +2736,7 @@ static void ext4_mb_cleanup_pa(struct ext4_group_info *grp)
 		count++;
 		kmem_cache_free(ext4_pspace_cachep, pa);
 	}
-	if (count)
-		mb_debug(1, "mballoc: %u PAs left\n", count);
-
+	return count;
 }
 
 int ext4_mb_release(struct super_block *sb)
@@ -2756,6 +2747,7 @@ int ext4_mb_release(struct super_block *sb)
 	struct ext4_group_info *grinfo, ***group_info;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct kmem_cache *cachep = get_groupinfo_cache(sb->s_blocksize_bits);
+	int count;
 
 	if (sbi->s_group_info) {
 		for (i = 0; i < ngroups; i++) {
@@ -2763,7 +2755,10 @@ int ext4_mb_release(struct super_block *sb)
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
@@ -2836,7 +2831,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	struct ext4_group_info *db;
 	int err, count = 0, count2 = 0;
 
-	mb_debug(1, "gonna free %u blocks in group %u (0x%p):",
+	mb_debug(sb, "gonna free %u blocks in group %u (0x%p):",
 		 entry->efd_count, entry->efd_group, entry);
 
 	err = ext4_mb_load_buddy(sb, entry->efd_group, &e4b);
@@ -2876,7 +2871,8 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	kmem_cache_free(ext4_free_data_cachep, entry);
 	ext4_mb_unload_buddy(&e4b);
 
-	mb_debug(1, "freed %u blocks in %u structures\n", count, count2);
+	mb_debug(sb, "freed %d blocks in %d structures\n", count,
+		 count2);
 }
 
 /*
@@ -3107,8 +3103,7 @@ static void ext4_mb_normalize_group_request(struct ext4_allocation_context *ac)
 
 	BUG_ON(lg == NULL);
 	ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc;
-	mb_debug(1, "#%u: goal %u blocks for locality group\n",
-		current->pid, ac->ac_g_ex.fe_len);
+	mb_debug(sb, "goal %u blocks for locality group\n", ac->ac_g_ex.fe_len);
 }
 
 /*
@@ -3306,8 +3301,8 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
 	}
 
-	mb_debug(1, "goal: %lld(was %lld) blocks at %u\n", size, orig_size,
-		 start);
+	mb_debug(ac->ac_sb, "goal: %lld(was %lld) blocks at %u\n", size,
+		 orig_size, start);
 }
 
 static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
@@ -3396,7 +3391,7 @@ static void ext4_mb_use_inode_pa(struct ext4_allocation_context *ac,
 	BUG_ON(pa->pa_free < len);
 	pa->pa_free -= len;
 
-	mb_debug(1, "use %llu/%d from inode pa %p\n", start, len, pa);
+	mb_debug(ac->ac_sb, "use %llu/%d from inode pa %p\n", start, len, pa);
 }
 
 /*
@@ -3420,7 +3415,8 @@ static void ext4_mb_use_group_pa(struct ext4_allocation_context *ac,
 	 * in on-disk bitmap -- see ext4_mb_release_context()
 	 * Other CPUs are prevented from allocating from this pa by lg_mutex
 	 */
-	mb_debug(1, "use %u/%u from group pa %p\n", pa->pa_lstart-len, len, pa);
+	mb_debug(ac->ac_sb, "use %u/%u from group pa %p\n",
+		 pa->pa_lstart-len, len, pa);
 }
 
 /*
@@ -3603,7 +3599,7 @@ void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 		ext4_set_bits(bitmap, start, len);
 		preallocated += len;
 	}
-	mb_debug(1, "preallocated %d for group %u\n", preallocated, group);
+	mb_debug(sb, "preallocated %d for group %u\n", preallocated, group);
 }
 
 static void ext4_mb_pa_callback(struct rcu_head *head)
@@ -3746,8 +3742,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 	pa->pa_deleted = 0;
 	pa->pa_type = MB_INODE_PA;
 
-	mb_debug(1, "new inode pa %p: %llu/%d for %u\n", pa,
-			pa->pa_pstart, pa->pa_len, pa->pa_lstart);
+	mb_debug(sb, "new inode pa %p: %llu/%d for %u\n", pa, pa->pa_pstart,
+		 pa->pa_len, pa->pa_lstart);
 	trace_ext4_mb_new_inode_pa(ac, pa);
 
 	ext4_mb_use_inode_pa(ac, pa);
@@ -3806,8 +3802,8 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	pa->pa_deleted = 0;
 	pa->pa_type = MB_GROUP_PA;
 
-	mb_debug(1, "new group pa %p: %llu/%d for %u\n", pa,
-			pa->pa_pstart, pa->pa_len, pa->pa_lstart);
+	mb_debug(sb, "new group pa %p: %llu/%d for %u\n", pa, pa->pa_pstart,
+		 pa->pa_len, pa->pa_lstart);
 	trace_ext4_mb_new_group_pa(ac, pa);
 
 	ext4_mb_use_group_pa(ac, pa);
@@ -3874,7 +3870,7 @@ ext4_mb_release_inode_pa(struct ext4_buddy *e4b, struct buffer_head *bitmap_bh,
 		if (bit >= end)
 			break;
 		next = mb_find_next_bit(bitmap_bh->b_data, end, bit);
-		mb_debug(1, "    free preallocated %u/%u in group %u\n",
+		mb_debug(sb, "free preallocated %u/%u in group %u\n",
 			 (unsigned) ext4_group_first_block_no(sb, group) + bit,
 			 (unsigned) next - bit, (unsigned) group);
 		free += next - bit;
@@ -3945,8 +3941,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	int busy = 0;
 	int free = 0;
 
-	mb_debug(1, "discard preallocation for group %u\n", group);
-
+	mb_debug(sb, "discard preallocation for group %u\n", group);
 	if (list_empty(&grp->bb_prealloc_list))
 		goto out_dbg;
 
@@ -4009,7 +4004,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	/* found anything to free? */
 	if (list_empty(&list)) {
 		BUG_ON(free != 0);
-		mb_debug(1, "Someone else may have freed PA for this group %u\n",
+		mb_debug(sb, "Someone else may have freed PA for this group %u\n",
 			 group);
 		goto out;
 	}
@@ -4036,7 +4031,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 	ext4_mb_unload_buddy(&e4b);
 	put_bh(bitmap_bh);
 out_dbg:
-	mb_debug(1, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
+	mb_debug(sb, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
 		 free, group, grp->bb_free);
 	return free;
 }
@@ -4066,7 +4061,8 @@ void ext4_discard_preallocations(struct inode *inode)
 		return;
 	}
 
-	mb_debug(1, "discard preallocation for inode %lu\n", inode->i_ino);
+	mb_debug(sb, "discard preallocation for inode %lu\n",
+		 inode->i_ino);
 	trace_ext4_discard_preallocations(inode);
 
 	INIT_LIST_HEAD(&list);
@@ -4159,12 +4155,11 @@ static inline void ext4_mb_show_pa(struct super_block *sb)
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
@@ -4178,30 +4173,27 @@ static inline void ext4_mb_show_pa(struct super_block *sb)
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
@@ -4217,7 +4209,7 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 			(unsigned long)ac->ac_b_ex.fe_len,
 			(unsigned long)ac->ac_b_ex.fe_logical,
 			(int)ac->ac_criteria);
-	ext4_msg(sb, KERN_ERR, "%u found", ac->ac_found);
+	mb_debug(sb, "%u found", ac->ac_found);
 	ext4_mb_show_pa(sb);
 }
 #else
@@ -4330,7 +4322,7 @@ ext4_mb_initialize_context(struct ext4_allocation_context *ac,
 	 * locality group. this is a policy, actually */
 	ext4_mb_group_or_file(ac);
 
-	mb_debug(1, "init ac: %u blocks @ %u, goal %u, flags %x, 2^%d, "
+	mb_debug(sb, "init ac: %u blocks @ %u, goal %u, flags 0x%x, 2^%d, "
 			"left: %u/%u, right %u/%u to %swritable\n",
 			(unsigned) ar->len, (unsigned) ar->logical,
 			(unsigned) ar->goal, ac->ac_flags, ac->ac_2order,
@@ -4351,7 +4343,7 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 	struct list_head discard_list;
 	struct ext4_prealloc_space *pa, *tmp;
 
-	mb_debug(1, "discard locality group preallocation\n");
+	mb_debug(sb, "discard locality group preallocation\n");
 
 	INIT_LIST_HEAD(&discard_list);
 
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

