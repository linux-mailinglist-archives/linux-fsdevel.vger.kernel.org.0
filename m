Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A01170045
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 14:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgBZNlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 08:41:24 -0500
Received: from relay.sw.ru ([185.231.240.75]:44744 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgBZNlX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:41:23 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j6ww8-0006rf-CG; Wed, 26 Feb 2020 16:41:16 +0300
Subject: [PATCH RFC 5/5] ext4: Add fallocate2() support
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        ktkhai@virtuozzo.com, dmonakhov@gmail.com,
        mbobrowski@mbobrowski.org, enwlinux@gmail.com, sblbir@amazon.com,
        khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 26 Feb 2020 16:41:16 +0300
Message-ID: <158272447616.281342.14858371265376818660.stgit@localhost.localdomain>
In-Reply-To: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a support of physical hint for fallocate2() syscall.
In case of @physical argument is set for ext4_fallocate(),
we try to allocate blocks only from [@phisical, @physical + len]
range, while other blocks are not used.

ext4_fallocate(struct file *file, int mode,
                    loff_t offset, loff_t len, u64 physical)

In case of some of blocks from the range are occupied, the syscall
returns with error. This is the only difference from fallocate().
The same as fallocate(), less then @len blocks may be allocated
with error as a return value.

We try to find hint blocks both in preallocated and ordinary blocks.
Note, that ext4_mb_use_preallocated() looks for the hint only in
inode's preallocations. In case of there are no desired block,
further ext4_mb_discard_preallocations() tries to release group
preallocations.

Note, that this patch makes EXT4_MB_HINT_GOAL_ONLY flag be used,
it used to be unused before for years.
New EXT4_GET_BLOCKS_FROM_GOAL flag of ext4_map_blocks() is added.
It indicates, that struct ext4_map_blocks::m_goal_pblk is valid.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/ext4/ext4.h    |    3 +++
 fs/ext4/extents.c |   31 ++++++++++++++++++++++++-------
 fs/ext4/inode.c   |   14 ++++++++++++++
 fs/ext4/mballoc.c |   17 ++++++++++++++---
 4 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5a98081c5369..299fbb8350ac 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -181,6 +181,7 @@ struct ext4_allocation_request {
 struct ext4_map_blocks {
 	ext4_fsblk_t m_pblk;
 	ext4_lblk_t m_lblk;
+	ext4_fsblk_t m_goal_pblk;
 	unsigned int m_len;
 	unsigned int m_flags;
 };
@@ -621,6 +622,8 @@ enum {
 	/* Caller will submit data before dropping transaction handle. This
 	 * allows jbd2 to avoid submitting data before commit. */
 #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
+	/* Caller wants blocks from provided physical offset */
+#define EXT4_GET_BLOCKS_FROM_GOAL		0x0800
 
 /*
  * The bit position of these flags must not overlap with any of the
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 10d0188a712d..5f2790c1c4fb 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4412,7 +4412,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 
 	/* allocate new block */
 	ar.inode = inode;
-	ar.goal = ext4_ext_find_goal(inode, path, map->m_lblk);
 	ar.logical = map->m_lblk;
 	/*
 	 * We calculate the offset from the beginning of the cluster
@@ -4437,6 +4436,13 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		ar.flags |= EXT4_MB_DELALLOC_RESERVED;
 	if (flags & EXT4_GET_BLOCKS_METADATA_NOFAIL)
 		ar.flags |= EXT4_MB_USE_RESERVED;
+	if (flags & EXT4_GET_BLOCKS_FROM_GOAL) {
+		ar.flags |= EXT4_MB_HINT_TRY_GOAL|EXT4_MB_HINT_GOAL_ONLY;
+		ar.goal = map->m_goal_pblk;
+	} else {
+		ar.goal = ext4_ext_find_goal(inode, path, map->m_lblk);
+	}
+
 	newblock = ext4_mb_new_blocks(handle, &ar, &err);
 	if (!newblock)
 		goto out2;
@@ -4580,8 +4586,8 @@ int ext4_ext_truncate(handle_t *handle, struct inode *inode)
 }
 
 static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
-				  ext4_lblk_t len, loff_t new_size,
-				  int flags)
+				  ext4_lblk_t len, ext4_fsblk_t goal_pblk,
+				  loff_t new_size, int flags)
 {
 	struct inode *inode = file_inode(file);
 	handle_t *handle;
@@ -4603,6 +4609,10 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	 */
 	if (len <= EXT_UNWRITTEN_MAX_LEN)
 		flags |= EXT4_GET_BLOCKS_NO_NORMALIZE;
+	if (goal_pblk != (ext4_fsblk_t)-1) {
+		map.m_goal_pblk = goal_pblk;
+		flags |= EXT4_GET_BLOCKS_FROM_GOAL;
+	}
 
 	/*
 	 * credits to insert 1 extent into extent tree
@@ -4637,6 +4647,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 			break;
 		}
 		map.m_lblk += ret;
+		map.m_goal_pblk += ret;
 		map.m_len = len = len - ret;
 		epos = (loff_t)map.m_lblk << inode->i_blkbits;
 		inode->i_ctime = current_time(inode);
@@ -4746,6 +4757,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 				round_down(offset, 1 << blkbits) >> blkbits,
 				(round_up((offset + len), 1 << blkbits) -
 				 round_down(offset, 1 << blkbits)) >> blkbits,
+				(ext4_fsblk_t)-1,
 				new_size, flags);
 		if (ret)
 			goto out_mutex;
@@ -4778,8 +4790,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		truncate_pagecache_range(inode, start, end - 1);
 		inode->i_mtime = inode->i_ctime = current_time(inode);
 
-		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
-					     flags);
+		ret = ext4_alloc_file_blocks(file, lblk, max_blocks,
+					     (ext4_fsblk_t)-1, new_size, flags);
 		up_write(&EXT4_I(inode)->i_mmap_sem);
 		if (ret)
 			goto out_mutex;
@@ -4839,10 +4851,12 @@ long ext4_fallocate(struct file *file, int mode,
 		    loff_t offset, loff_t len, u64 physical)
 {
 	struct inode *inode = file_inode(file);
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	loff_t new_size = 0;
 	unsigned int max_blocks;
 	int ret = 0;
 	int flags;
+	ext4_fsblk_t pblk;
 	ext4_lblk_t lblk;
 	unsigned int blkbits = inode->i_blkbits;
 
@@ -4862,7 +4876,8 @@ long ext4_fallocate(struct file *file, int mode,
 		     FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
-	if (physical != (u64)-1)
+	if (((mode & ~FALLOC_FL_KEEP_SIZE) || sbi->s_cluster_ratio > 1) &&
+	    physical != (u64)-1)
 		return -EOPNOTSUPP;
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
@@ -4883,6 +4898,7 @@ long ext4_fallocate(struct file *file, int mode,
 
 	trace_ext4_fallocate_enter(inode, offset, len, mode);
 	lblk = offset >> blkbits;
+	pblk = physical == (u64)-1 ? (ext4_fsblk_t)-1 : physical >> blkbits;
 
 	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
 	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
@@ -4911,7 +4927,8 @@ long ext4_fallocate(struct file *file, int mode,
 	/* Wait all existing dio workers, newcomers will block on i_mutex */
 	inode_dio_wait(inode);
 
-	ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size, flags);
+	ret = ext4_alloc_file_blocks(file, lblk, max_blocks, pblk,
+				     new_size, flags);
 	if (ret)
 		goto out;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fa0ff78dc033..1054ba65cc1b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -580,6 +580,10 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			return ret;
 	}
 
+	if (retval > 0 && flags & EXT4_GET_BLOCKS_FROM_GOAL &&
+	    map->m_pblk != map->m_goal_pblk)
+		return -EEXIST;
+
 	/* If it is only a block(s) look up */
 	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0)
 		return retval;
@@ -672,6 +676,16 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 			}
 		}
 
+		/*
+		 * Concurrent thread could allocate extent with other m_pblk,
+		 * and we got it during second call of ext4_ext_map_blocks().
+		 */
+		if (retval > 0 && flags & EXT4_GET_BLOCKS_FROM_GOAL &&
+		    map->m_pblk != map->m_goal_pblk) {
+			retval = -EEXIST;
+			goto out_sem;
+		}
+
 		/*
 		 * If the extent has been zeroed out, we don't need to update
 		 * extent status tree.
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b1b3c5526d1a..ed25f47748a0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3426,6 +3426,8 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	struct ext4_prealloc_space *pa, *cpa = NULL;
 	ext4_fsblk_t goal_block;
 
+	goal_block = ext4_grp_offs_to_block(ac->ac_sb, &ac->ac_g_ex);
+
 	/* only data can be preallocated */
 	if (!(ac->ac_flags & EXT4_MB_HINT_DATA))
 		return 0;
@@ -3436,7 +3438,11 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 
 		/* all fields in this condition don't change,
 		 * so we can skip locking for them */
-		if (ac->ac_o_ex.fe_logical < pa->pa_lstart ||
+		if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY) &&
+		    (goal_block < pa->pa_pstart ||
+		     goal_block >= pa->pa_pstart + pa->pa_len))
+			continue;
+		else if (ac->ac_o_ex.fe_logical < pa->pa_lstart ||
 		    ac->ac_o_ex.fe_logical >= (pa->pa_lstart +
 					       EXT4_C2B(sbi, pa->pa_len)))
 			continue;
@@ -3465,6 +3471,9 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	if (!(ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC))
 		return 0;
 
+	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
+		return 0;
+
 	/* inode may have no locality group for some reason */
 	lg = ac->ac_lg;
 	if (lg == NULL)
@@ -3474,7 +3483,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		/* The max size of hash table is PREALLOC_TB_SIZE */
 		order = PREALLOC_TB_SIZE - 1;
 
-	goal_block = ext4_grp_offs_to_block(ac->ac_sb, &ac->ac_g_ex);
 	/*
 	 * search for the prealloc space that is having
 	 * minimal distance from the goal block.
@@ -4261,8 +4269,11 @@ ext4_mb_initialize_context(struct ext4_allocation_context *ac,
 	/* start searching from the goal */
 	goal = ar->goal;
 	if (goal < le32_to_cpu(es->s_first_data_block) ||
-			goal >= ext4_blocks_count(es))
+			goal >= ext4_blocks_count(es)) {
+		if (ar->flags & EXT4_MB_HINT_GOAL_ONLY)
+			return -EINVAL;
 		goal = le32_to_cpu(es->s_first_data_block);
+	}
 	ext4_get_group_no_and_offset(sb, goal, &group, &block);
 
 	/* set up allocation goals */


