Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7771E718
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 05:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEODWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 23:22:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3010 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbfEODWa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 23:22:30 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 4A5B075BAE43DBE82259;
        Wed, 15 May 2019 11:22:27 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 May 2019 11:22:27 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 15 May 2019 11:22:26 +0800
Subject: Re: [RFC PATCH 1/1] f2fs-dev: ioctl for removing a range from F2FS
To:     sunqiuyang <sunqiuyang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <miaoxie@huawei.com>, <fangwei1@huawei.com>
References: <20190221051517.48644-1-sunqiuyang@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8ea8a66d-0ce6-cf7b-acce-5b4a39b2d0c9@huawei.com>
Date:   Wed, 15 May 2019 11:22:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190221051517.48644-1-sunqiuyang@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry for the long delay. :P

On 2019/2/21 13:15, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> This ioctl shrinks a given length (aligned to sections) from end of the
> main area. Any cursegs and valid blocks will be moved out before
> invalidating the range.
> 
> This feature can be used for adjusting partition sizes online.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
> ---
>  fs/f2fs/f2fs.h    |  9 ++++++
>  fs/f2fs/file.c    | 28 +++++++++++++++++++
>  fs/f2fs/gc.c      | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/f2fs/segment.c | 47 +++++++++++++++++++++++--------
>  fs/f2fs/segment.h |  1 +
>  fs/f2fs/super.c   |  1 +
>  6 files changed, 156 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8c69e12..fd7f3ba 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -406,6 +406,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>  #define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
>  #define F2FS_IOC_GET_PIN_FILE		_IOR(F2FS_IOCTL_MAGIC, 14, __u32)
>  #define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)
> +#define F2FS_IOC_RESIZE_FROM_END	_IOWR(F2FS_IOCTL_MAGIC, 16,	\

F2FS_IOC_SHRINK_RESIZE

_IOW()

> +						struct f2fs_resize_from_end)
>  
>  #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
>  #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
> @@ -457,6 +459,10 @@ struct f2fs_flush_device {
>  	u32 segments;		/* # of segments to flush */
>  };
>  
> +struct f2fs_resize_from_end {

f2fs_resize_context or f2fs_resize_param?

> +	u64 len;		/* bytes to shrink */
> +};
> +
>  /* for inline stuff */
>  #define DEF_INLINE_RESERVED_SIZE	1
>  static inline int get_extra_isize(struct inode *inode);
> @@ -1226,6 +1232,7 @@ struct f2fs_sb_info {
>  	unsigned int segs_per_sec;		/* segments per section */
>  	unsigned int secs_per_zone;		/* sections per zone */
>  	unsigned int total_sections;		/* total section count */
> +	unsigned int new_total_sections;	/* for resize from end */

Maybe

unsigned int current_total_sections;	/* for shrink resize */

or last_total_sections.

>  	unsigned int total_node_count;		/* total node block count */
>  	unsigned int total_valid_node_count;	/* valid node block count */
>  	loff_t max_file_blocks;			/* max block index of file */
> @@ -3008,6 +3015,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>  int f2fs_disable_cp_again(struct f2fs_sb_info *sbi);
>  void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
>  int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
> +void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type);
>  void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
>  int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
>  bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
> @@ -3146,6 +3154,7 @@ int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
>  int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background,
>  			unsigned int segno);
>  void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
> +int f2fs_resize_from_end(struct f2fs_sb_info *sbi, size_t resize_len);

f2fs_shrink_resize()

>  
>  /*
>   * recovery.c
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b8f5d12..29e70fd 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2968,6 +2968,32 @@ static int f2fs_ioc_precache_extents(struct file *filp, unsigned long arg)
>  	return f2fs_precache_extents(file_inode(filp));
>  }
>  
> +static int f2fs_ioc_resize_from_end(struct file *filp, unsigned long arg)

f2fs_ioc_shrink_resize()

> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
> +	struct f2fs_resize_from_end param;
> +	int ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (f2fs_readonly(sbi->sb))
> +		return -EROFS;
> +
> +	if (copy_from_user(&param, (struct f2fs_resize_from_end __user *)arg,
> +				sizeof(param)))
> +		return -EFAULT;
> +
> +	ret = mnt_want_write_file(filp);
> +	if (ret)
> +		return ret;
> +
> +	ret = f2fs_resize_from_end(sbi, param.len);
> +	mnt_drop_write_file(filp);
> +
> +	return ret;
> +}
> +
>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> @@ -3024,6 +3050,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return f2fs_ioc_set_pin_file(filp, arg);
>  	case F2FS_IOC_PRECACHE_EXTENTS:
>  		return f2fs_ioc_precache_extents(filp, arg);
> +	case F2FS_IOC_RESIZE_FROM_END:
> +		return f2fs_ioc_resize_from_end(filp, arg);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 195cf0f..3877e99 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -311,7 +311,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  	struct sit_info *sm = SIT_I(sbi);
>  	struct victim_sel_policy p;
>  	unsigned int secno, last_victim;
> -	unsigned int last_segment = MAIN_SEGS(sbi);
> +	unsigned int last_segment = NEW_MAIN_SECS(sbi) * sbi->segs_per_sec;
>  	unsigned int nsearched = 0;
>  
>  	mutex_lock(&dirty_i->seglist_lock);
> @@ -404,7 +404,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  				sm->last_victim[p.gc_mode] = last_victim + 1;
>  			else
>  				sm->last_victim[p.gc_mode] = segno + 1;
> -			sm->last_victim[p.gc_mode] %= MAIN_SEGS(sbi);
> +			sm->last_victim[p.gc_mode] %=
> +				(NEW_MAIN_SECS(sbi) * sbi->segs_per_sec);
>  			break;
>  		}
>  	}
> @@ -1350,3 +1351,81 @@ void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
>  		SIT_I(sbi)->last_victim[ALLOC_NEXT] =
>  				GET_SEGNO(sbi, FDEV(0).end_blk) + 1;
>  }
> +
> +static void free_segment_range(struct f2fs_sb_info *sbi, unsigned int start,
> +							unsigned int end)
> +{
> +	int type;
> +	unsigned int segno, next_inuse;
> +	struct gc_inode_list gc_list = {
> +		.ilist = LIST_HEAD_INIT(gc_list.ilist),
> +		.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
> +	};
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
> +	for (segno = start; segno <= end; segno += sbi->segs_per_sec)
> +		do_garbage_collect(sbi, segno, &gc_list, FG_GC);

Should consider error handling here.

> +
> +	mutex_unlock(&sbi->gc_mutex);
> +	put_gc_inode(&gc_list);
> +
> +	f2fs_sync_fs(sbi->sb, 1);

Ditto.

> +
> +	next_inuse = find_next_inuse(FREE_I(sbi), end + 1, start);
> +	if (next_inuse <= end) {
> +		f2fs_msg(sbi->sb, KERN_ERR,
> +			"segno %u should be free but still inuse!", next_inuse);
> +		f2fs_bug_on(sbi, 1);
> +	}
> +}
> +
> +int f2fs_resize_from_end(struct f2fs_sb_info *sbi, size_t resize_len)
> +{
> +	unsigned int section_size = F2FS_BLKSIZE * BLKS_PER_SEC(sbi);
> +	unsigned int secs = (resize_len + section_size - 1) / section_size;
> +	int gc_mode;
> +
> +	if (secs * BLKS_PER_SEC(sbi) + valid_user_blocks(sbi) +
> +		sbi->current_reserved_blocks + sbi->unusable_block_count +
> +		F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)

Will the calculation overflow if secs is too large?

> +		return -ENOSPC;
> +
> +	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
> +	NEW_MAIN_SECS(sbi) = MAIN_SECS(sbi) - secs;
> +	for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
> +		if (SIT_I(sbi)->last_victim[gc_mode] >=
> +					NEW_MAIN_SECS(sbi) * sbi->segs_per_sec)
> +			SIT_I(sbi)->last_victim[gc_mode] = 0;
> +	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
> +
> +	free_segment_range(sbi, NEW_MAIN_SECS(sbi) * sbi->segs_per_sec,
> +			MAIN_SEGS(sbi) - 1);

Error handling here.

> +
> +	/* Update FS metadata */
> +	SM_I(sbi)->segment_count -= secs * sbi->segs_per_sec;
> +	MAIN_SECS(sbi) = NEW_MAIN_SECS(sbi);
> +	MAIN_SEGS(sbi) = MAIN_SECS(sbi) * sbi->segs_per_sec;
> +	sbi->user_block_count -= secs * BLKS_PER_SEC(sbi);
> +	sbi->ckpt->user_block_count = cpu_to_le64(sbi->user_block_count);
> +	FREE_I(sbi)->free_sections -= secs;
> +	FREE_I(sbi)->free_segments -= secs * sbi->segs_per_sec;
> +
> +	/* Update superblock */
> +	F2FS_RAW_SUPER(sbi)->section_count = cpu_to_le32(MAIN_SECS(sbi));
> +	F2FS_RAW_SUPER(sbi)->segment_count = cpu_to_le32(le32_to_cpu(
> +		F2FS_RAW_SUPER(sbi)->segment_count) - secs * sbi->segs_per_sec);
> +	F2FS_RAW_SUPER(sbi)->segment_count_main = cpu_to_le32(MAIN_SEGS(sbi));
> +	F2FS_RAW_SUPER(sbi)->block_count = cpu_to_le32(le32_to_cpu(
> +		F2FS_RAW_SUPER(sbi)->block_count) - secs * BLKS_PER_SEC(sbi));
> +	f2fs_commit_super(sbi, false);

Ditto.

> +
> +	return 0;
> +}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4aef183..294074c 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2348,7 +2348,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  {
>  	struct free_segmap_info *free_i = FREE_I(sbi);
>  	unsigned int segno, secno, zoneno;
> -	unsigned int total_zones = MAIN_SECS(sbi) / sbi->secs_per_zone;
> +	unsigned int total_zones = NEW_MAIN_SECS(sbi) / sbi->secs_per_zone;
>  	unsigned int hint = GET_SEC_FROM_SEG(sbi, *newseg);
>  	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
>  	unsigned int left_start = hint;
> @@ -2365,12 +2365,13 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  			goto got_it;
>  	}
>  find_other_zone:
> -	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
> -	if (secno >= MAIN_SECS(sbi)) {
> +	secno = find_next_zero_bit(free_i->free_secmap, NEW_MAIN_SECS(sbi),
> +									hint);
> +	if (secno >= NEW_MAIN_SECS(sbi)) {
>  		if (dir == ALLOC_RIGHT) {
>  			secno = find_next_zero_bit(free_i->free_secmap,
> -							MAIN_SECS(sbi), 0);
> -			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
> +							NEW_MAIN_SECS(sbi), 0);
> +			f2fs_bug_on(sbi, secno >= NEW_MAIN_SECS(sbi));
>  		} else {
>  			go_left = 1;
>  			left_start = hint - 1;
> @@ -2385,8 +2386,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  			continue;
>  		}
>  		left_start = find_next_zero_bit(free_i->free_secmap,
> -							MAIN_SECS(sbi), 0);
> -		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
> +							NEW_MAIN_SECS(sbi), 0);
> +		f2fs_bug_on(sbi, left_start >= NEW_MAIN_SECS(sbi));
>  		break;
>  	}
>  	secno = left_start;
> @@ -2639,6 +2640,25 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
>  	stat_inc_seg_type(sbi, curseg);
>  }
>  
> +void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type)
> +{
> +	struct curseg_info *curseg = CURSEG_I(sbi, type);
> +	unsigned int old_segno = curseg->segno;
> +
> +	if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type))

If section size is large, and we set migration_granularity to 1, we may select
sbi->next_victim_seg[BG_GC/FG_GC] as candidate instead of searching new one in
->get_victim().

After then, new allocated segment may still locate in shrinking range.

Thanks,

> +		change_curseg(sbi, type);
> +	else
> +		new_curseg(sbi, type, true);
> +
> +	stat_inc_seg_type(sbi, curseg);
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
> @@ -3738,6 +3758,12 @@ static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
>  		bool dirtied;
>  
>  		segno = le32_to_cpu(segno_in_journal(journal, i));
> +		if (segno >= MAIN_SEGS(sbi)) {
> +			f2fs_msg(sbi->sb, KERN_NOTICE,
> +				"Skip segno %u / %u in jnl!\n",
> +				segno, MAIN_SEGS(sbi));
> +			continue;
> +		}
>  		dirtied = __mark_sit_entry_dirty(sbi, segno);
>  
>  		if (!dirtied)
> @@ -4093,12 +4119,11 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>  
>  		start = le32_to_cpu(segno_in_journal(journal, i));
>  		if (start >= MAIN_SEGS(sbi)) {
> -			f2fs_msg(sbi->sb, KERN_ERR,
> +			/* This may happen if the FS was once resized. */
> +			f2fs_msg(sbi->sb, KERN_NOTICE,
>  					"Wrong journal entry on segno %u",
>  					start);
> -			set_sbi_flag(sbi, SBI_NEED_FSCK);
> -			err = -EINVAL;
> -			break;
> +			continue;
>  		}
>  
>  		se = &sit_i->sentries[start];
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 5c7ed04..54caf99 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -59,6 +59,7 @@
>  
>  #define MAIN_SEGS(sbi)	(SM_I(sbi)->main_segments)
>  #define MAIN_SECS(sbi)	((sbi)->total_sections)
> +#define NEW_MAIN_SECS(sbi)	((sbi)->new_total_sections)
>  
>  #define TOTAL_SEGS(sbi)							\
>  	(SM_I(sbi) ? SM_I(sbi)->segment_count : 				\
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3dc7f56..5cd2ced 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2713,6 +2713,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  	sbi->segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
>  	sbi->secs_per_zone = le32_to_cpu(raw_super->secs_per_zone);
>  	sbi->total_sections = le32_to_cpu(raw_super->section_count);
> +	sbi->new_total_sections = sbi->total_sections;
>  	sbi->total_node_count =
>  		(le32_to_cpu(raw_super->segment_count_nat) / 2)
>  			* sbi->blocks_per_seg * NAT_ENTRY_PER_BLOCK;
> 
