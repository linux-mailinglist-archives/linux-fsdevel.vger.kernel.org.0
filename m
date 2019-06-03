Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A7F326E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 05:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfFCDZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jun 2019 23:25:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57894 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbfFCDZ2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jun 2019 23:25:28 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 250799F7CEDF8A6B2FA7;
        Mon,  3 Jun 2019 11:25:23 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 3 Jun 2019
 11:25:16 +0800
From:   sunqiuyang <sunqiuyang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <jaegeuk@kernel.org>, <yuchao0@huawei.com>, <sunqiuyang@huawei.com>
Subject: [PATCH v7 1/1] f2fs: ioctl for removing a range from F2FS
Date:   Mon, 3 Jun 2019 11:42:53 +0800
Message-ID: <20190603034253.30196-1-sunqiuyang@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Qiuyang Sun <sunqiuyang@huawei.com>

This ioctl shrinks a given length (aligned to sections) from end of the
main area. Any cursegs and valid blocks will be moved out before
invalidating the range.

This feature can be used for adjusting partition sizes online.
--
Changlog v1 ==> v2:

Sahitya Tummala:
 - Add this ioctl for f2fs_compat_ioctl() as well.
 - Fix debugfs status to reflect the online resize changes.
 - Fix potential race between online resize path and allocate new data
   block path or gc path.

Others:
 - Rename some identifiers.
 - Add some error handling branches.
 - Clear sbi->next_victim_seg[BG_GC/FG_GC] in shrinking range.
--
Changelog v2 ==> v3:
Implement this interface as ext4's, and change the parameter from shrunk
bytes to new block count of F2FS.
--
Changelog v3 ==> v4:
 - During resizing, force to empty sit_journal and forbid adding new
   entries to it, in order to avoid invalid segno in journal after resize.
 - Reduce sbi->user_block_count before resize starts.
 - Commit the updated superblock first, and then update in-memory metadata
   only when the former succeeds.
 - Target block count must align to sections.
--
Changelog v4 ==> v5:
Write checkpoint before and after committing the new superblock, w/o
CP_FSCK_FLAG respectively, so that the FS can be fixed by fsck even if
resize fails after the new superblock is committed.
--
Changelog v5 ==> v6:
 - In free_segment_range(), reduce granularity of gc_mutex.
 - Add protection on curseg migration.
--
Changelog v6 ==> v7:
 - Add freeze_bdev() and thaw_bdev() for resize fs.
 - Remove CUR_MAIN_SECS and use MAIN_SECS directly for allocation.
 - Recover super_block and FS metadata when resize fails.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/checkpoint.c |   5 +-
 fs/f2fs/debug.c      |   7 ++
 fs/f2fs/f2fs.h       |   6 ++
 fs/f2fs/file.c       |  23 ++++++
 fs/f2fs/gc.c         | 208 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/segment.c    |  39 +++++++++-
 fs/f2fs/super.c      |   3 +
 7 files changed, 286 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ed70b68..4706d0a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1313,8 +1313,11 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	else
 		__clear_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG);
 
-	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
+	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
+		is_sbi_flag_set(sbi, SBI_IS_RESIZEFS))
 		__set_ckpt_flags(ckpt, CP_FSCK_FLAG);
+	else
+		__clear_ckpt_flags(ckpt, CP_FSCK_FLAG);
 
 	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
 		__set_ckpt_flags(ckpt, CP_DISABLED_FLAG);
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 99e9a5c..7706049 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -27,8 +27,15 @@
 static void update_general_status(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_stat_info *si = F2FS_STAT(sbi);
+	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	int i;
 
+	/* these will be changed if online resize is done */
+	si->main_area_segs = le32_to_cpu(raw_super->segment_count_main);
+	si->main_area_sections = le32_to_cpu(raw_super->section_count);
+	si->main_area_zones = si->main_area_sections /
+				le32_to_cpu(raw_super->secs_per_zone);
+
 	/* validation check of the segment numbers */
 	si->hit_largest = atomic64_read(&sbi->read_hit_largest);
 	si->hit_cached = atomic64_read(&sbi->read_hit_cached);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a205d4d..387ec9a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -423,6 +423,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
 #define F2FS_IOC_GET_PIN_FILE		_IOR(F2FS_IOCTL_MAGIC, 14, __u32)
 #define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
+#define F2FS_IOC_RESIZE_FS		_IOW(F2FS_IOCTL_MAGIC, 16, __u64)
 
 #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
 #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
@@ -1130,6 +1131,7 @@ enum {
 	SBI_QUOTA_NEED_FLUSH,			/* need to flush quota info in CP */
 	SBI_QUOTA_SKIP_FLUSH,			/* skip flushing quota in current CP */
 	SBI_QUOTA_NEED_REPAIR,			/* quota file may be corrupted */
+	SBI_IS_RESIZEFS,			/* resizefs is in process */
 };
 
 enum {
@@ -1309,6 +1311,7 @@ struct f2fs_sb_info {
 	unsigned int segs_per_sec;		/* segments per section */
 	unsigned int secs_per_zone;		/* sections per zone */
 	unsigned int total_sections;		/* total section count */
+	struct mutex resize_mutex;		/* for resize exclusion */
 	unsigned int total_node_count;		/* total node block count */
 	unsigned int total_valid_node_count;	/* valid node block count */
 	loff_t max_file_blocks;			/* max block index of file */
@@ -3175,6 +3178,8 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable);
 void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
 int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
+void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+					unsigned int start, unsigned int end);
 void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
 bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
@@ -3318,6 +3323,7 @@ int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background,
 			unsigned int segno);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
+int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
 
 /*
  * recovery.c
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d05ac21..4a7ee7a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3013,6 +3013,26 @@ static int f2fs_ioc_precache_extents(struct file *filp, unsigned long arg)
 	return f2fs_precache_extents(file_inode(filp));
 }
 
+static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
+	__u64 block_count;
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (f2fs_readonly(sbi->sb))
+		return -EROFS;
+
+	if (get_user(block_count, (__u64 __user *)arg))
+		return -EFAULT;
+
+	ret = f2fs_resize_fs(sbi, block_count);
+
+	return ret;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -3069,6 +3089,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_set_pin_file(filp, arg);
 	case F2FS_IOC_PRECACHE_EXTENTS:
 		return f2fs_ioc_precache_extents(filp, arg);
+	case F2FS_IOC_RESIZE_FS:
+		return f2fs_ioc_resize_fs(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -3182,6 +3204,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GET_PIN_FILE:
 	case F2FS_IOC_SET_PIN_FILE:
 	case F2FS_IOC_PRECACHE_EXTENTS:
+	case F2FS_IOC_RESIZE_FS:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 963fb45..c9282bc 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -311,10 +311,11 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	struct sit_info *sm = SIT_I(sbi);
 	struct victim_sel_policy p;
 	unsigned int secno, last_victim;
-	unsigned int last_segment = MAIN_SEGS(sbi);
+	unsigned int last_segment;
 	unsigned int nsearched = 0;
 
 	mutex_lock(&dirty_i->seglist_lock);
+	last_segment = MAIN_SECS(sbi) * sbi->segs_per_sec;
 
 	p.alloc_mode = alloc_mode;
 	select_policy(sbi, gc_type, type, &p);
@@ -404,7 +405,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 				sm->last_victim[p.gc_mode] = last_victim + 1;
 			else
 				sm->last_victim[p.gc_mode] = segno + 1;
-			sm->last_victim[p.gc_mode] %= MAIN_SEGS(sbi);
+			sm->last_victim[p.gc_mode] %=
+				(MAIN_SECS(sbi) * sbi->segs_per_sec);
 			break;
 		}
 	}
@@ -1360,3 +1362,205 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 		SIT_I(sbi)->last_victim[ALLOC_NEXT] =
 				GET_SEGNO(sbi, FDEV(0).end_blk) + 1;
 }
+
+static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
+							unsigned int end)
+{
+	int type;
+	unsigned int segno, next_inuse;
+	int err = 0;
+
+	/* Move out cursegs from the target range */
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++)
+		allocate_segment_for_resize(sbi, type, start, end);
+
+	/* do GC to move out valid blocks in the range */
+	for (segno = start; segno <= end; segno += sbi->segs_per_sec) {
+		struct gc_inode_list gc_list = {
+			.ilist = LIST_HEAD_INIT(gc_list.ilist),
+			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
+		};
+
+		mutex_lock(&sbi->gc_mutex);
+		do_garbage_collect(sbi, segno, &gc_list, FG_GC);
+		mutex_unlock(&sbi->gc_mutex);
+		put_gc_inode(&gc_list);
+
+		if (get_valid_blocks(sbi, segno, true))
+			return -EAGAIN;
+	}
+
+	err = f2fs_sync_fs(sbi->sb, 1);
+	if (err)
+		return err;
+
+	next_inuse = find_next_inuse(FREE_I(sbi), end + 1, start);
+	if (next_inuse <= end) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"segno %u should be free but still inuse!", next_inuse);
+		f2fs_bug_on(sbi, 1);
+	}
+	return err;
+}
+
+static void update_raw_super_inc(struct f2fs_sb_info *sbi, unsigned int secs)
+{
+	struct f2fs_super_block *raw_sb = F2FS_RAW_SUPER(sbi);
+	u32 section_count = le32_to_cpu(raw_sb->section_count);
+	u32 segment_count = le32_to_cpu(raw_sb->segment_count);
+	u32 segment_count_main = le32_to_cpu(raw_sb->segment_count_main);
+	u64 block_count = le64_to_cpu(raw_sb->block_count);
+	unsigned int segs = secs * sbi->segs_per_sec;
+
+	raw_sb->section_count = cpu_to_le32(section_count + secs);
+	raw_sb->segment_count = cpu_to_le32(segment_count + segs);
+	raw_sb->segment_count_main = cpu_to_le32(segment_count_main + segs);
+	raw_sb->block_count = cpu_to_le64(block_count +
+						segs * sbi->blocks_per_seg);
+}
+
+static void update_raw_super_dec(struct f2fs_sb_info *sbi, unsigned int secs)
+{
+	struct f2fs_super_block *raw_sb = F2FS_RAW_SUPER(sbi);
+	u32 section_count = le32_to_cpu(raw_sb->section_count);
+	u32 segment_count = le32_to_cpu(raw_sb->segment_count);
+	u32 segment_count_main = le32_to_cpu(raw_sb->segment_count_main);
+	u64 block_count = le64_to_cpu(raw_sb->block_count);
+	unsigned int segs = secs * sbi->segs_per_sec;
+
+	raw_sb->section_count = cpu_to_le32(section_count - secs);
+	raw_sb->segment_count = cpu_to_le32(segment_count - segs);
+	raw_sb->segment_count_main = cpu_to_le32(segment_count_main - segs);
+	raw_sb->block_count = cpu_to_le64(block_count -
+						segs * sbi->blocks_per_seg);
+}
+
+static void update_fs_metadata_inc(struct f2fs_sb_info *sbi, unsigned int secs)
+{
+	unsigned int segs = secs * sbi->segs_per_sec;
+	u64 user_block_count = le64_to_cpu(F2FS_CKPT(sbi)->user_block_count);
+
+	SM_I(sbi)->segment_count += segs;
+	MAIN_SEGS(sbi) += segs;
+	FREE_I(sbi)->free_sections += secs;
+	FREE_I(sbi)->free_segments += segs;
+	F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count +
+						segs * sbi->blocks_per_seg);
+}
+
+static void update_fs_metadata_dec(struct f2fs_sb_info *sbi, unsigned int secs)
+{
+	unsigned int segs = secs * sbi->segs_per_sec;
+	u64 user_block_count = le64_to_cpu(F2FS_CKPT(sbi)->user_block_count);
+
+	SM_I(sbi)->segment_count -= segs;
+	MAIN_SEGS(sbi) -= segs;
+	FREE_I(sbi)->free_sections -= secs;
+	FREE_I(sbi)->free_segments -= segs;
+	F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(user_block_count -
+						segs * sbi->blocks_per_seg);
+}
+
+int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
+{
+	__u64 old_block_count, shrunk_blocks;
+	unsigned int secs;
+	int gc_mode, gc_type;
+	int err = 0;
+
+	old_block_count = le64_to_cpu(F2FS_RAW_SUPER(sbi)->block_count);
+	if (block_count > old_block_count)
+		return -EINVAL;
+
+	/* new fs size should align to section size */
+	if (block_count % BLKS_PER_SEC(sbi))
+		return -EINVAL;
+
+	if (block_count == old_block_count)
+		return 0;
+
+	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"Should run fsck to repair first.");
+		return -EINVAL;
+	}
+
+	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"Checkpoint should be enabled.");
+		return -EINVAL;
+	}
+
+	freeze_bdev(sbi->sb->s_bdev);
+
+	shrunk_blocks = old_block_count - block_count;
+	secs = shrunk_blocks / BLKS_PER_SEC(sbi);
+	spin_lock(&sbi->stat_lock);
+	if (shrunk_blocks + valid_user_blocks(sbi) +
+		sbi->current_reserved_blocks + sbi->unusable_block_count +
+		F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)
+		err = -ENOSPC;
+	else
+		sbi->user_block_count -= shrunk_blocks;
+	spin_unlock(&sbi->stat_lock);
+	if (err) {
+		thaw_bdev(sbi->sb->s_bdev, sbi->sb);
+		return err;
+	}
+
+	mutex_lock(&sbi->resize_mutex);
+	set_sbi_flag(sbi, SBI_IS_RESIZEFS);
+
+	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
+
+	MAIN_SECS(sbi) -= secs;
+
+	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
+		if (SIT_I(sbi)->last_victim[gc_mode] >=
+					MAIN_SECS(sbi) * sbi->segs_per_sec)
+			SIT_I(sbi)->last_victim[gc_mode] = 0;
+
+	for (gc_type = BG_GC; gc_type <= FG_GC; gc_type++)
+		if (sbi->next_victim_seg[gc_type] >=
+					MAIN_SECS(sbi) * sbi->segs_per_sec)
+			sbi->next_victim_seg[gc_type] = NULL_SEGNO;
+
+	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
+
+	err = free_segment_range(sbi, MAIN_SECS(sbi) * sbi->segs_per_sec,
+			MAIN_SEGS(sbi) - 1);
+	if (err)
+		goto out;
+
+	update_raw_super_dec(sbi, secs);
+	err = f2fs_commit_super(sbi, false);
+	if (err) {
+		update_raw_super_inc(sbi, secs);
+		goto out;
+	}
+
+	update_fs_metadata_dec(sbi, secs);
+
+	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
+	err = f2fs_sync_fs(sbi->sb, 1);
+	if (err) {
+		update_fs_metadata_inc(sbi, secs);
+		update_raw_super_inc(sbi, secs);
+		f2fs_commit_super(sbi, false);
+	}
+out:
+	if (err) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_msg(sbi->sb, KERN_ERR,
+				"resize_fs failed, should run fsck to repair!");
+
+		MAIN_SECS(sbi) += secs;
+		spin_lock(&sbi->stat_lock);
+		sbi->user_block_count += shrunk_blocks;
+		spin_unlock(&sbi->stat_lock);
+	}
+	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
+	mutex_unlock(&sbi->resize_mutex);
+	thaw_bdev(sbi->sb->s_bdev, sbi->sb);
+	return err;
+}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 07e9235..00a3572 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2651,6 +2651,40 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 	stat_inc_seg_type(sbi, curseg);
 }
 
+void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+					unsigned int start, unsigned int end)
+{
+	struct curseg_info *curseg = CURSEG_I(sbi, type);
+	unsigned int segno;
+
+	down_read(&SM_I(sbi)->curseg_lock);
+	mutex_lock(&curseg->curseg_mutex);
+	down_write(&SIT_I(sbi)->sentry_lock);
+
+	segno = CURSEG_I(sbi, type)->segno;
+	if (segno < start || segno > end)
+		goto unlock;
+
+	if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type))
+		change_curseg(sbi, type);
+	else
+		new_curseg(sbi, type, true);
+
+	stat_inc_seg_type(sbi, curseg);
+
+	locate_dirty_segment(sbi, segno);
+unlock:
+	up_write(&SIT_I(sbi)->sentry_lock);
+
+	if (segno != curseg->segno)
+		f2fs_msg(sbi->sb, KERN_NOTICE,
+			"For resize: curseg of type %d: %u ==> %u",
+			type, segno, curseg->segno);
+
+	mutex_unlock(&curseg->curseg_mutex);
+	up_read(&SM_I(sbi)->curseg_lock);
+}
+
 void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *curseg;
@@ -3774,7 +3808,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct f2fs_journal *journal = curseg->journal;
 	struct sit_entry_set *ses, *tmp;
 	struct list_head *head = &SM_I(sbi)->sit_entry_set;
-	bool to_journal = true;
+	bool to_journal = !is_sbi_flag_set(sbi, SBI_IS_RESIZEFS);
 	struct seg_entry *se;
 
 	down_write(&sit_i->sentry_lock);
@@ -3793,7 +3827,8 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * entries, remove all entries from journal and add and account
 	 * them in sit entry set.
 	 */
-	if (!__has_cursum_space(journal, sit_i->dirty_sentries, SIT_JOURNAL))
+	if (!__has_cursum_space(journal, sit_i->dirty_sentries, SIT_JOURNAL) ||
+								!to_journal)
 		remove_sits_in_journal(sbi);
 
 	/*
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1f581f0..5609774 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3296,6 +3296,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	mutex_init(&sbi->gc_mutex);
 	mutex_init(&sbi->writepages);
 	mutex_init(&sbi->cp_mutex);
+	mutex_init(&sbi->resize_mutex);
 	init_rwsem(&sbi->node_write);
 	init_rwsem(&sbi->node_change);
 
@@ -3367,6 +3368,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		set_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
 		sbi->interval_time[DISABLE_TIME] = DEF_DISABLE_QUICK_INTERVAL;
 	}
+	if (__is_set_ckpt_flags(F2FS_CKPT(sbi), CP_FSCK_FLAG))
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
 
 	/* Initialize device list */
 	err = f2fs_scan_devices(sbi);
-- 
1.8.3.1

