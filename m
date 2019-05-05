Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAD513CD2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2019 04:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfEECkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 May 2019 22:40:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2949 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726390AbfEECkd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 May 2019 22:40:33 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id D39F9BD03AA5E0DEE649;
        Sun,  5 May 2019 10:40:29 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 5 May 2019 10:40:29 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sun, 5 May 2019 10:40:28 +0800
Subject: Re: [PATCH v2] f2fs: Add option to limit required GC for
 checkpoint=disable
To:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <kernel-team@android.com>
References: <20190502014216.225568-1-drosen@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <239b4c93-c719-434d-1017-b566506175cb@huawei.com>
Date:   Sun, 5 May 2019 10:40:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190502014216.225568-1-drosen@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/5/2 9:42, Daniel Rosenberg wrote:
> This extends the checkpoint option to allow checkpoint=disable:%u
> This allows you to specify what percent of the drive you are willing
> to lose access to while mounting with checkpoint=disable. If the amount
> lost would be higher, the mount will return -EAGAIN.
> Currently, we need to run garbage collection until the amount of holes
> is smaller than the OVP space. With the new option, f2fs can mark
> space as unusable up front instead of requiring that
> the space be freed up with garbage collection.
> 
> Change-Id: Ib8c3cb46085bf4aac3cdc06d4b64d6a20db87028
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
> 
>> If we allow a high unusable blocks, I doubt in inc_valid_{node,block}_count(),
>> we may overflow in below calculation:
>>
>>         if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>>                 valid_block_count += sbi->unusable_block_count;
>>
>>         if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>>                 avail_user_block_count -= sbi->unusable_block_count;
> The starting value of unusable_block_count is limited.
> Considering the case where the disk is full, we have
> total blocks = used + OVP
> OVP = reserved + holes
> So, the holes must be less than OVP, and unusable = 0
> 
> In general, total = used + available + OVP
> total-used-OVP=avail
> 
> (free being blocks from free segments,
> available being blocks available to the user)
> reserved + holes + free = OVP + available
> holes - OVP = available - reserved - free
> 
> unusable = max(data_holes, node_holes)-OVP
> unusable <= holes-OVP
> 
> unusable <= available-reserved - free segs
> unusable <= available
> 
> similarly,
> total = used + available + OVP
> reserved + holes + free = OVP + available
> available = reserved + holes + free - OVP
> total = used + reserved + holes + free - OVP
> unusable<=holes-OVP
> total >= used + reserved + unusable + free
> total >= used + unusable

Thanks for your detailed explanation. :)

> 
> So the unusable block count is lower than the available block count when we
> first mount with checkpoint=disable, and we only grow unusable when we grow
> available blocks. We also have an upper bound on used+unusable which is less
> the total block count. So unless I've missed something elsewhere, we should
> not be able to underflow or overflow these values.

Look into the code again, I guess with additional sbi->current_reserved_blocks,
we may overflow? as current_reserved_blocks may has included the hole space, right?

	valid_block_count = sbi->total_valid_block_count +
					sbi->current_reserved_blocks + 1;

	if (!__allow_reserved_blocks(sbi, inode, false))
		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
		valid_block_count += sbi->unusable_block_count;

Thanks,

> 
> v2:
> Changed default to 0 to be in line with current behavior.
> Adjusted description of checkpoint=disable to be more clear, since with that
> default, mounting with checkpoint=disable may return EAGAIN unless you use
> checkpoint=disable:100
> Changed description of /sys/fs/f2fs/<disk>/unusable to be clearer
> 
>  Documentation/ABI/testing/sysfs-fs-f2fs |  8 +++++
>  Documentation/filesystems/f2fs.txt      | 12 ++++++-
>  fs/f2fs/f2fs.h                          |  6 +++-
>  fs/f2fs/segment.c                       | 17 ++++++++--
>  fs/f2fs/super.c                         | 44 +++++++++++++------------
>  fs/f2fs/sysfs.c                         | 16 +++++++++
>  6 files changed, 77 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 91822ce258317..dca326e0ee3e1 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -243,3 +243,11 @@ Description:
>  		 - Del: echo '[h/c]!extension' > /sys/fs/f2fs/<disk>/extension_list
>  		 - [h] means add/del hot file extension
>  		 - [c] means add/del cold file extension
> +
> +What:		/sys/fs/f2fs/<disk>/unusable
> +Date		April 2019
> +Contact:	"Daniel Rosenberg" <drosen@google.com>
> +Description:
> +		If checkpoint=disable, it displays the number of blocks that are unusable.
> +                If checkpoint=enable it displays the enumber of blocks that would be unusable
> +                if checkpoint=disable were to be set.
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index f7b5e4ff0de3e..d49f5ac8bf9b6 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -214,11 +214,21 @@ fsync_mode=%s          Control the policy of fsync. Currently supports "posix",
>                         non-atomic files likewise "nobarrier" mount option.
>  test_dummy_encryption  Enable dummy encryption, which provides a fake fscrypt
>                         context. The fake fscrypt context is used by xfstests.
> -checkpoint=%s          Set to "disable" to turn off checkpointing. Set to "enable"
> +checkpoint=%s[:%u]     Set to "disable" to turn off checkpointing. Set to "enable"
>                         to reenable checkpointing. Is enabled by default. While
>                         disabled, any unmounting or unexpected shutdowns will cause
>                         the filesystem contents to appear as they did when the
>                         filesystem was mounted with that option.
> +                       While mounting with checkpoint=disabled, the filesystem must
> +                       run garbage collection to ensure that all available space can
> +                       be used. If this takes too much time, the mount may return
> +                       EAGAIN. You may optionally add a percentage to indicate what
> +                       percent of the disk you would be willing to temporarily give
> +                       up to avoid additional garbage collection. For instance,
> +                       checkpoint=disable:100 would always succeed, but would
> +                       potentially make the disk appear full. The actual space that
> +                       would be unsuable can be viewed at /sys/fs/f2fs/<disk>/unusable
> +                       This space is reclaimed once checkpoint=enable.
>  
>  ================================================================================
>  DEBUGFS ENTRIES
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 30acde08822ef..d0477251cec56 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -136,6 +136,9 @@ struct f2fs_mount_info {
>  	int alloc_mode;			/* segment allocation policy */
>  	int fsync_mode;			/* fsync policy */
>  	bool test_dummy_encryption;	/* test dummy encryption */
> +	block_t unusable_percent_cap;   /* Percent of space allowed to be
> +					 * unusable when disabling checkpoint
> +					 */
>  };
>  
>  #define F2FS_FEATURE_ENCRYPT		0x0001
> @@ -3049,7 +3052,8 @@ bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi);
>  void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>  					struct cp_control *cpc);
>  void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
> -int f2fs_disable_cp_again(struct f2fs_sb_info *sbi);
> +block_t f2fs_get_unusable_blocks(struct f2fs_sb_info *sbi);
> +int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable);
>  void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
>  int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
>  void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a3380d1de6000..704224f4a2866 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -869,11 +869,12 @@ void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi)
>  	mutex_unlock(&dirty_i->seglist_lock);
>  }
>  
> -int f2fs_disable_cp_again(struct f2fs_sb_info *sbi)
> +block_t f2fs_get_unusable_blocks(struct f2fs_sb_info *sbi)
>  {
> -	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>  	block_t ovp = overprovision_segments(sbi) << sbi->log_blocks_per_seg;
> +	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>  	block_t holes[2] = {0, 0};	/* DATA and NODE */
> +	block_t unusable;
>  	struct seg_entry *se;
>  	unsigned int segno;
>  
> @@ -887,7 +888,17 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sbi)
>  	}
>  	mutex_unlock(&dirty_i->seglist_lock);
>  
> -	if (holes[DATA] > ovp || holes[NODE] > ovp)
> +	unusable = holes[DATA] > holes[NODE] ? holes[DATA] : holes[NODE];
> +	if (unusable > ovp)
> +		return unusable - ovp;
> +	return 0;
> +}
> +
> +int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable)
> +{
> +	block_t max_allowed =  (sbi->user_block_count / 100) *
> +			F2FS_OPTION(sbi).unusable_percent_cap;
> +	if (unusable > max_allowed)
>  		return -EAGAIN;
>  	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED_QUICK) &&
>  		dirty_segments(sbi) > overprovision_segments(sbi))
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 0b6fa77c35f3e..640753cb3f73f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -136,7 +136,9 @@ enum {
>  	Opt_alloc,
>  	Opt_fsync,
>  	Opt_test_dummy_encryption,
> -	Opt_checkpoint,
> +	Opt_checkpoint_disable,
> +	Opt_checkpoint_disable_cap,
> +	Opt_checkpoint_enable,
>  	Opt_err,
>  };
>  
> @@ -195,7 +197,9 @@ static match_table_t f2fs_tokens = {
>  	{Opt_alloc, "alloc_mode=%s"},
>  	{Opt_fsync, "fsync_mode=%s"},
>  	{Opt_test_dummy_encryption, "test_dummy_encryption"},
> -	{Opt_checkpoint, "checkpoint=%s"},
> +	{Opt_checkpoint_disable, "checkpoint=disable"},
> +	{Opt_checkpoint_disable_cap, "checkpoint=disable:%u"},
> +	{Opt_checkpoint_enable, "checkpoint=enable"},
>  	{Opt_err, NULL},
>  };
>  
> @@ -771,22 +775,17 @@ static int parse_options(struct super_block *sb, char *options)
>  					"Test dummy encryption mount option ignored");
>  #endif
>  			break;
> -		case Opt_checkpoint:
> -			name = match_strdup(&args[0]);
> -			if (!name)
> -				return -ENOMEM;
> -
> -			if (strlen(name) == 6 &&
> -					!strncmp(name, "enable", 6)) {
> -				clear_opt(sbi, DISABLE_CHECKPOINT);
> -			} else if (strlen(name) == 7 &&
> -					!strncmp(name, "disable", 7)) {
> -				set_opt(sbi, DISABLE_CHECKPOINT);
> -			} else {
> -				kvfree(name);
> +		case Opt_checkpoint_disable_cap:
> +			if (args->from && match_int(args, &arg))
>  				return -EINVAL;
> -			}
> -			kvfree(name);
> +			if (arg < 0 || arg > 100)
> +				return -EINVAL;
> +			F2FS_OPTION(sbi).unusable_percent_cap = arg;
> +		case Opt_checkpoint_disable:
> +			set_opt(sbi, DISABLE_CHECKPOINT);
> +			break;
> +		case Opt_checkpoint_enable:
> +			clear_opt(sbi, DISABLE_CHECKPOINT);
>  			break;
>  		default:
>  			f2fs_msg(sb, KERN_ERR,
> @@ -1411,8 +1410,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_printf(seq, ",alloc_mode=%s", "reuse");
>  
>  	if (test_opt(sbi, DISABLE_CHECKPOINT))
> -		seq_puts(seq, ",checkpoint=disable");
> -
> +		seq_printf(seq, ",checkpoint=disable:%u",
> +				F2FS_OPTION(sbi).unusable_percent_cap);
>  	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
>  		seq_printf(seq, ",fsync_mode=%s", "posix");
>  	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
> @@ -1441,6 +1440,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>  	set_opt(sbi, EXTENT_CACHE);
>  	set_opt(sbi, NOHEAP);
>  	clear_opt(sbi, DISABLE_CHECKPOINT);
> +	F2FS_OPTION(sbi).unusable_percent_cap = 0;
>  	sbi->sb->s_flags |= SB_LAZYTIME;
>  	set_opt(sbi, FLUSH_MERGE);
>  	set_opt(sbi, DISCARD);
> @@ -1469,6 +1469,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  	struct cp_control cpc;
>  	int err = 0;
>  	int ret;
> +	block_t unusable;
>  
>  	if (s_flags & SB_RDONLY) {
>  		f2fs_msg(sbi->sb, KERN_ERR,
> @@ -1496,7 +1497,8 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  		goto restore_flag;
>  	}
>  
> -	if (f2fs_disable_cp_again(sbi)) {
> +	unusable = f2fs_get_unusable_blocks(sbi);
> +	if (f2fs_disable_cp_again(sbi, unusable)) {
>  		err = -EAGAIN;
>  		goto restore_flag;
>  	}
> @@ -1506,7 +1508,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  	set_sbi_flag(sbi, SBI_CP_DISABLED);
>  	f2fs_write_checkpoint(sbi, &cpc);
>  
> -	sbi->unusable_block_count = 0;
> +	sbi->unusable_block_count = unusable;
>  	mutex_unlock(&sbi->gc_mutex);
>  restore_flag:
>  	sbi->sb->s_flags = s_flags;	/* Restore MS_RDONLY status */
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 729f46a3c9ee0..fa184880cff34 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -68,6 +68,20 @@ static ssize_t dirty_segments_show(struct f2fs_attr *a,
>  		(unsigned long long)(dirty_segments(sbi)));
>  }
>  
> +static ssize_t unusable_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	block_t unusable;
> +
> +	if (test_opt(sbi, DISABLE_CHECKPOINT))
> +		unusable = sbi->unusable_block_count;
> +	else
> +		unusable = f2fs_get_unusable_blocks(sbi);
> +	return snprintf(buf, PAGE_SIZE, "%llu\n",
> +		(unsigned long long)unusable);
> +}
> +
> +
>  static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
>  		struct f2fs_sb_info *sbi, char *buf)
>  {
> @@ -440,6 +454,7 @@ F2FS_GENERAL_RO_ATTR(dirty_segments);
>  F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
>  F2FS_GENERAL_RO_ATTR(features);
>  F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
> +F2FS_GENERAL_RO_ATTR(unusable);
>  
>  #ifdef CONFIG_FS_ENCRYPTION
>  F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
> @@ -495,6 +510,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(inject_type),
>  #endif
>  	ATTR_LIST(dirty_segments),
> +	ATTR_LIST(unusable),
>  	ATTR_LIST(lifetime_write_kbytes),
>  	ATTR_LIST(features),
>  	ATTR_LIST(reserved_blocks),
> 
