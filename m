Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2EC9264F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfEVNrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 09:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbfEVNrj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 09:47:39 -0400
Received: from [192.168.0.101] (unknown [49.77.233.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA76520863;
        Wed, 22 May 2019 13:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558532858;
        bh=nM+cvcJJkN4LMGTVNWZvQBoWV8/6PHUf94O5/qu+D9I=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=p1RsKjZ/XqnDVQrGI+juU17Ffp76dex4AYm8D/2tmp5JNDSte4CRDeP2Q0YiPC+1R
         Wd6rbgLl6Vntdh3dR1YTReesQtBGKlIksrU95FETru0dKy3VyTmhz7FmNp+eiMgUGl
         eQGF8eXXQvj7y/OXyRkKP+/LqyHyXwhkqdF1eAp0=
Subject: Re: [f2fs-dev] [PATCH v4 1/1] f2fs: ioctl for removing a range from
 F2FS
To:     sunqiuyang <sunqiuyang@huawei.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20190522040530.37886-1-sunqiuyang@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <95c46c14-175c-339e-eaa3-bb940e4f5517@kernel.org>
Date:   Wed, 22 May 2019 21:47:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190522040530.37886-1-sunqiuyang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-5-22 12:05, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> This ioctl shrinks a given length (aligned to sections) from end of the
> main area. Any cursegs and valid blocks will be moved out before
> invalidating the range.
> 
> This feature can be used for adjusting partition sizes online.
> --
> Changlog v1 ==> v2:
> 
> Sahitya Tummala:
>  - Add this ioctl for f2fs_compat_ioctl() as well.
>  - Fix debugfs status to reflect the online resize changes.
>  - Fix potential race between online resize path and allocate new data
>    block path or gc path.
> 
> Others:
>  - Rename some identifiers.
>  - Add some error handling branches.
>  - Clear sbi->next_victim_seg[BG_GC/FG_GC] in shrinking range.
> --
> Changelog v2 ==> v3:
> Implement this interface as ext4's, and change the parameter from shrunk
> bytes to new block count of F2FS.
> --
> Changelog v3 ==> v4:
>  - During resizing, force to empty sit_journal and forbid adding new
>    entries to it, in order to avoid invalid segno in journal after resize.
>  - Reduce sbi->user_block_count before resize starts.
>  - Commit the updated superblock first, and then update in-memory metadata
>    only when the former succeeds.
>  - Target block count must align to sections.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/debug.c   |   7 +++
>  fs/f2fs/f2fs.h    |   6 +++
>  fs/f2fs/file.c    |  28 +++++++++++
>  fs/f2fs/gc.c      | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  fs/f2fs/segment.c |  43 +++++++++++++----
>  fs/f2fs/segment.h |   1 +
>  fs/f2fs/super.c   |   3 ++
>  7 files changed, 214 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index 99e9a5c..7706049 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -27,8 +27,15 @@
>  static void update_general_status(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_stat_info *si = F2FS_STAT(sbi);
> +	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>  	int i;
>  
> +	/* these will be changed if online resize is done */
> +	si->main_area_segs = le32_to_cpu(raw_super->segment_count_main);
> +	si->main_area_sections = le32_to_cpu(raw_super->section_count);
> +	si->main_area_zones = si->main_area_sections /
> +				le32_to_cpu(raw_super->secs_per_zone);
> +
>  	/* validation check of the segment numbers */
>  	si->hit_largest = atomic64_read(&sbi->read_hit_largest);
>  	si->hit_cached = atomic64_read(&sbi->read_hit_cached);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index a205d4d..fc53d37 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -423,6 +423,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>  #define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
>  #define F2FS_IOC_GET_PIN_FILE		_IOR(F2FS_IOCTL_MAGIC, 14, __u32)
>  #define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
> +#define F2FS_IOC_RESIZE_FS		_IOW(F2FS_IOCTL_MAGIC, 16, __u64)
>  
>  #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
>  #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
> @@ -1309,6 +1310,9 @@ struct f2fs_sb_info {
>  	unsigned int segs_per_sec;		/* segments per section */
>  	unsigned int secs_per_zone;		/* sections per zone */
>  	unsigned int total_sections;		/* total section count */
> +	unsigned int current_total_sections;	/* for shrink resize */
> +	bool resizing;

How about adding a new SBI_* status:

SBI_IS_RESIZEFS,			/* resizefs is in process */

> +	struct mutex resize_mutex;

/* for resize exclusion */

>  	unsigned int total_node_count;		/* total node block count */
>  	unsigned int total_valid_node_count;	/* valid node block count */
>  	loff_t max_file_blocks;			/* max block index of file */
> @@ -3175,6 +3179,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>  int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable);
>  void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
>  int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
> +void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type);
>  void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
>  int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
>  bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
> @@ -3318,6 +3323,7 @@ int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
>  int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background,
>  			unsigned int segno);
>  void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
> +int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
>  
>  /*
>   * recovery.c
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index d05ac21..a37a0d4 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3013,6 +3013,31 @@ static int f2fs_ioc_precache_extents(struct file *filp, unsigned long arg)
>  	return f2fs_precache_extents(file_inode(filp));
>  }
>  
> +static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
> +	__u64 block_count;
> +	int ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (f2fs_readonly(sbi->sb))
> +		return -EROFS;
> +
> +	if (copy_from_user(&block_count, (__u64 __user *)arg, sizeof(__u64)))
> +		return -EFAULT;
> +
> +	ret = mnt_want_write_file(filp);
> +	if (ret)
> +		return ret;
> +
> +	ret = f2fs_resize_fs(sbi, block_count);
> +	mnt_drop_write_file(filp);
> +
> +	return ret;
> +}
> +
>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> @@ -3069,6 +3094,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return f2fs_ioc_set_pin_file(filp, arg);
>  	case F2FS_IOC_PRECACHE_EXTENTS:
>  		return f2fs_ioc_precache_extents(filp, arg);
> +	case F2FS_IOC_RESIZE_FS:
> +		return f2fs_ioc_resize_fs(filp, arg);
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -3182,6 +3209,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	case F2FS_IOC_GET_PIN_FILE:
>  	case F2FS_IOC_SET_PIN_FILE:
>  	case F2FS_IOC_PRECACHE_EXTENTS:
> +	case F2FS_IOC_RESIZE_FS:
>  		break;
>  	default:
>  		return -ENOIOCTLCMD;
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 963fb45..273ca08 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -311,10 +311,11 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  	struct sit_info *sm = SIT_I(sbi);
>  	struct victim_sel_policy p;
>  	unsigned int secno, last_victim;
> -	unsigned int last_segment = MAIN_SEGS(sbi);
> +	unsigned int last_segment;
>  	unsigned int nsearched = 0;
>  
>  	mutex_lock(&dirty_i->seglist_lock);
> +	last_segment = CUR_MAIN_SECS(sbi) * sbi->segs_per_sec;
>  
>  	p.alloc_mode = alloc_mode;
>  	select_policy(sbi, gc_type, type, &p);
> @@ -404,7 +405,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  				sm->last_victim[p.gc_mode] = last_victim + 1;
>  			else
>  				sm->last_victim[p.gc_mode] = segno + 1;
> -			sm->last_victim[p.gc_mode] %= MAIN_SEGS(sbi);
> +			sm->last_victim[p.gc_mode] %=
> +				(CUR_MAIN_SECS(sbi) * sbi->segs_per_sec);
>  			break;
>  		}
>  	}
> @@ -1360,3 +1362,134 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
>  		SIT_I(sbi)->last_victim[ALLOC_NEXT] =
>  				GET_SEGNO(sbi, FDEV(0).end_blk) + 1;
>  }
> +
> +static int free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
> +							unsigned int end)
> +{
> +	int type;
> +	unsigned int segno, next_inuse;
> +	struct gc_inode_list gc_list = {
> +		.ilist = LIST_HEAD_INIT(gc_list.ilist),
> +		.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
> +	};
> +	int err = 0;
> +
> +	/* Move out cursegs from the target range */
> +	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
> +		segno = CURSEG_I(sbi, type)->segno;
> +		if (segno >= start && segno <= end)
> +			allocate_segment_for_resize(sbi, type);
> +	}
> +
> +	/* do GC to move out valid blocks in the range */
> +	mutex_lock(&sbi->gc_mutex);
> +	for (segno = start; segno <= end; segno += sbi->segs_per_sec) {
> +		do_garbage_collect(sbi, segno, &gc_list, FG_GC);
> +		if (get_valid_blocks(sbi, segno, true)) {
> +			err = -EAGAIN;
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&sbi->gc_mutex);
> +	put_gc_inode(&gc_list);
> +
> +	if (err)
> +		return err;
> +
> +	err = f2fs_sync_fs(sbi->sb, 1);
> +	if (err)
> +		return err;
> +
> +	next_inuse = find_next_inuse(FREE_I(sbi), end + 1, start);
> +	if (next_inuse <= end) {
> +		f2fs_msg(sbi->sb, KERN_ERR,
> +			"segno %u should be free but still inuse!", next_inuse);
> +		f2fs_bug_on(sbi, 1);
> +	}
> +	return err;
> +}
> +
> +int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
> +{
> +	__u64 old_block_count, shrunk_blocks;
> +	unsigned int secs;
> +	int gc_mode, gc_type;
> +	int err = 0;
> +
> +	old_block_count = le64_to_cpu(F2FS_RAW_SUPER(sbi)->block_count);
> +	if (block_count > old_block_count)
> +		return -EINVAL;
> +
> +	/* new fs size should align to section size */
> +	if (block_count % BLKS_PER_SEC(sbi))
> +		return -EINVAL;
> +
> +	if (block_count == old_block_count)
> +		return 0;
> +
> +	shrunk_blocks = old_block_count - block_count;
> +	secs = shrunk_blocks / BLKS_PER_SEC(sbi);
> +	spin_lock(&sbi->stat_lock);
> +	if (shrunk_blocks + valid_user_blocks(sbi) +
> +		sbi->current_reserved_blocks + sbi->unusable_block_count +
> +		F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)
> +		err = -ENOSPC;
> +	else
> +		sbi->user_block_count -= shrunk_blocks;
> +	spin_unlock(&sbi->stat_lock);
> +	if (err)
> +		return err;
> +
> +	mutex_lock(&sbi->resize_mutex);
> +	sbi->resizing = true;
> +	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
> +	CUR_MAIN_SECS(sbi) = MAIN_SECS(sbi) - secs;
> +	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
> +		if (SIT_I(sbi)->last_victim[gc_mode] >=
> +					CUR_MAIN_SECS(sbi) * sbi->segs_per_sec)
> +			SIT_I(sbi)->last_victim[gc_mode] = 0;
> +	for (gc_type = BG_GC; gc_type <= FG_GC; gc_type++)
> +		if (sbi->next_victim_seg[gc_type] >=
> +					CUR_MAIN_SECS(sbi) * sbi->segs_per_sec)
> +			sbi->next_victim_seg[gc_type] = NULL_SEGNO;
> +	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
> +
> +	err = free_segment_range(sbi, CUR_MAIN_SECS(sbi) * sbi->segs_per_sec,
> +			MAIN_SEGS(sbi) - 1);
> +	if (err) {
> +		CUR_MAIN_SECS(sbi) = MAIN_SECS(sbi);
> +		sbi->user_block_count += shrunk_blocks;

How about moving error handling behind out lable. Meanwhile we need cover
.uesr_block_count with sbi->stat_lock.

> +		goto out;
> +	}
> +
> +	/* Update superblock */
> +	F2FS_RAW_SUPER(sbi)->section_count = cpu_to_le32(CUR_MAIN_SECS(sbi));
> +	F2FS_RAW_SUPER(sbi)->segment_count = cpu_to_le32(le32_to_cpu(
> +		F2FS_RAW_SUPER(sbi)->segment_count) - secs * sbi->segs_per_sec);
> +	F2FS_RAW_SUPER(sbi)->segment_count_main = cpu_to_le32(
> +					CUR_MAIN_SECS(sbi) * sbi->segs_per_sec);
> +	F2FS_RAW_SUPER(sbi)->block_count =
> +				cpu_to_le64(old_block_count - shrunk_blocks);
> +	mutex_lock(&sbi->gc_mutex);
> +	err = f2fs_commit_super(sbi, false);

It looks if we shutdown fs here after commit_super() successfully, superblock
and checkpoint are inconsistent at this point, since .free_segment_count hasn't
updated yet.

Let's discuss about this later.

> +	mutex_unlock(&sbi->gc_mutex);
> +	if (err) {
> +		CUR_MAIN_SECS(sbi) = MAIN_SECS(sbi);
> +		sbi->user_block_count += shrunk_blocks;
> +		goto out;
> +	}
> +
> +	/* Update FS metadata */
> +	SM_I(sbi)->segment_count -= secs * sbi->segs_per_sec;
> +	MAIN_SECS(sbi) = CUR_MAIN_SECS(sbi);
> +	MAIN_SEGS(sbi) = MAIN_SECS(sbi) * sbi->segs_per_sec;
> +	F2FS_CKPT(sbi)->user_block_count = cpu_to_le64(sbi->user_block_count);
> +	FREE_I(sbi)->free_sections -= secs;
> +	FREE_I(sbi)->free_segments -= secs * sbi->segs_per_sec;
> +
> +out:

	if (err) {
		CUR_MAIN_SECS(sbi) = MAIN_SECS(sbi);
		lock();
		sbi->user_block_count += shrunk_blocks;
		unlock();
	}

Thanks,

> +	sbi->resizing = false;
> +	mutex_unlock(&sbi->resize_mutex);
> +	return err;
> +}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 07e9235..2857465 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2360,7 +2360,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  {
>  	struct free_segmap_info *free_i = FREE_I(sbi);
>  	unsigned int segno, secno, zoneno;
> -	unsigned int total_zones = MAIN_SECS(sbi) / sbi->secs_per_zone;
> +	unsigned int total_zones = CUR_MAIN_SECS(sbi) / sbi->secs_per_zone;
>  	unsigned int hint = GET_SEC_FROM_SEG(sbi, *newseg);
>  	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
>  	unsigned int left_start = hint;
> @@ -2377,12 +2377,13 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  			goto got_it;
>  	}
>  find_other_zone:
> -	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
> -	if (secno >= MAIN_SECS(sbi)) {
> +	secno = find_next_zero_bit(free_i->free_secmap, CUR_MAIN_SECS(sbi),
> +									hint);
> +	if (secno >= CUR_MAIN_SECS(sbi)) {
>  		if (dir == ALLOC_RIGHT) {
>  			secno = find_next_zero_bit(free_i->free_secmap,
> -							MAIN_SECS(sbi), 0);
> -			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
> +							CUR_MAIN_SECS(sbi), 0);
> +			f2fs_bug_on(sbi, secno >= CUR_MAIN_SECS(sbi));
>  		} else {
>  			go_left = 1;
>  			left_start = hint - 1;
> @@ -2397,8 +2398,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  			continue;
>  		}
>  		left_start = find_next_zero_bit(free_i->free_secmap,
> -							MAIN_SECS(sbi), 0);
> -		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
> +							CUR_MAIN_SECS(sbi), 0);
> +		f2fs_bug_on(sbi, left_start >= CUR_MAIN_SECS(sbi));
>  		break;
>  	}
>  	secno = left_start;
> @@ -2651,6 +2652,29 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
>  	stat_inc_seg_type(sbi, curseg);
>  }
>  
> +void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type)
> +{
> +	struct curseg_info *curseg = CURSEG_I(sbi, type);
> +	unsigned int old_segno = curseg->segno;
> +
> +	down_read(&SM_I(sbi)->curseg_lock);
> +	mutex_lock(&curseg->curseg_mutex);
> +	if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type))
> +		change_curseg(sbi, type);
> +	else
> +		new_curseg(sbi, type, true);
> +
> +	stat_inc_seg_type(sbi, curseg);
> +	mutex_unlock(&curseg->curseg_mutex);
> +	up_read(&SM_I(sbi)->curseg_lock);
> +
> +	if (get_valid_blocks(sbi, old_segno, false) == 0)
> +		__set_test_and_free(sbi, old_segno);
> +	f2fs_msg(sbi->sb, KERN_NOTICE,
> +		"For resize: curseg of type %d: %u ==> %u",
> +		type, old_segno, curseg->segno);
> +}
> +
>  void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
>  {
>  	struct curseg_info *curseg;
> @@ -3774,7 +3798,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	struct f2fs_journal *journal = curseg->journal;
>  	struct sit_entry_set *ses, *tmp;
>  	struct list_head *head = &SM_I(sbi)->sit_entry_set;
> -	bool to_journal = true;
> +	bool to_journal = !sbi->resizing;
>  	struct seg_entry *se;
>  
>  	down_write(&sit_i->sentry_lock);
> @@ -3793,7 +3817,8 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	 * entries, remove all entries from journal and add and account
>  	 * them in sit entry set.
>  	 */
> -	if (!__has_cursum_space(journal, sit_i->dirty_sentries, SIT_JOURNAL))
> +	if (!__has_cursum_space(journal, sit_i->dirty_sentries, SIT_JOURNAL) ||
> +								sbi->resizing)
>  		remove_sits_in_journal(sbi);
>  
>  	/*
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 429007b..eaa9782 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -59,6 +59,7 @@
>  
>  #define MAIN_SEGS(sbi)	(SM_I(sbi)->main_segments)
>  #define MAIN_SECS(sbi)	((sbi)->total_sections)
> +#define CUR_MAIN_SECS(sbi)	((sbi)->current_total_sections)
>  
>  #define TOTAL_SEGS(sbi)							\
>  	(SM_I(sbi) ? SM_I(sbi)->segment_count : 				\
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1f581f0..c6201f0 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2843,6 +2843,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  	sbi->segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
>  	sbi->secs_per_zone = le32_to_cpu(raw_super->secs_per_zone);
>  	sbi->total_sections = le32_to_cpu(raw_super->section_count);
> +	sbi->current_total_sections = sbi->total_sections;
> +	sbi->resizing = false;
>  	sbi->total_node_count =
>  		(le32_to_cpu(raw_super->segment_count_nat) / 2)
>  			* sbi->blocks_per_seg * NAT_ENTRY_PER_BLOCK;
> @@ -3296,6 +3298,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	mutex_init(&sbi->gc_mutex);
>  	mutex_init(&sbi->writepages);
>  	mutex_init(&sbi->cp_mutex);
> +	mutex_init(&sbi->resize_mutex);
>  	init_rwsem(&sbi->node_write);
>  	init_rwsem(&sbi->node_change);
>  
> 
