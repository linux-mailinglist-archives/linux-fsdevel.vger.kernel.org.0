Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D548E1D17B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 16:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388996AbgEMOf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 10:35:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:55680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388800AbgEMOf3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 10:35:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EBB36AEE2;
        Wed, 13 May 2020 14:35:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4E99B1E12AE; Wed, 13 May 2020 16:35:26 +0200 (CEST)
Date:   Wed, 13 May 2020 16:35:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] fs/ext4: Make DAX mount option a tri-state
Message-ID: <20200513143526.GG27709@quack2.suse.cz>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513054324.2138483-8-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 12-05-20 22:43:22, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> We add 'always', 'never', and 'inode' (default).  '-o dax' continue to
> operate the same.
> 
> Specifically we introduce a 2nd DAX mount flag EXT4_MOUNT2_DAX_NEVER and set
> it and EXT4_MOUNT_DAX_ALWAYS appropriately.
> 
> We also force EXT4_MOUNT2_DAX_NEVER if !CONFIG_FS_DAX.
> 
> https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from RFC:
> 	Combine remount check for DAX_NEVER with DAX_ALWAYS
> 	Update ext4_should_enable_dax()
> ---
>  fs/ext4/ext4.h  |  1 +
>  fs/ext4/inode.c |  2 ++
>  fs/ext4/super.c | 43 +++++++++++++++++++++++++++++++++++++------
>  3 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 86a0994332ce..01d1de838896 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1168,6 +1168,7 @@ struct ext4_inode_info {
>  						      blocks */
>  #define EXT4_MOUNT2_HURD_COMPAT		0x00000004 /* Support HURD-castrated
>  						      file systems */
> +#define EXT4_MOUNT2_DAX_NEVER		0x00000008 /* Do not allow Direct Access */
>  
>  #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User explicitly
>  						specified journal checksum */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 23e42a223235..140b1930e2f4 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4400,6 +4400,8 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
>  
>  static bool ext4_should_enable_dax(struct inode *inode)
>  {
> +	if (test_opt2(inode->i_sb, DAX_NEVER))
> +		return false;
>  	if (!S_ISREG(inode->i_mode))
>  		return false;
>  	if (ext4_should_journal_data(inode))
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 5ec900fdf73c..e01a040a58a9 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1505,6 +1505,7 @@ enum {
>  	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quota,
>  	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
>  	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version, Opt_dax,
> +	Opt_dax_str,
>  	Opt_stripe, Opt_delalloc, Opt_nodelalloc, Opt_warn_on_error,
>  	Opt_nowarn_on_error, Opt_mblk_io_submit,
>  	Opt_lazytime, Opt_nolazytime, Opt_debug_want_extra_isize,
> @@ -1570,6 +1571,7 @@ static const match_table_t tokens = {
>  	{Opt_barrier, "barrier"},
>  	{Opt_nobarrier, "nobarrier"},
>  	{Opt_i_version, "i_version"},
> +	{Opt_dax_str, "dax=%s"},

Hum, maybe it would be easier to handle this like we do with e.g. 'data='
mount option? I.e. like:

	{Opt_dax_always, "dax=always"},
	{Opt_dax_never, "dax=never"},
	{Opt_dax_inode, "dax=inode"),

and then handle these three tokens... Not that it would be a big difference
but that's why we usually handle mount options with small "enums" in ext4.

								Honza

>  	{Opt_dax, "dax"},
>  	{Opt_stripe, "stripe=%u"},
>  	{Opt_delalloc, "delalloc"},
> @@ -1767,6 +1769,7 @@ static const struct mount_opts {
>  	{Opt_min_batch_time, 0, MOPT_GTE0},
>  	{Opt_inode_readahead_blks, 0, MOPT_GTE0},
>  	{Opt_init_itable, 0, MOPT_GTE0},
> +	{Opt_dax_str, 0, MOPT_STRING},
>  	{Opt_dax, EXT4_MOUNT_DAX_ALWAYS, MOPT_SET},
>  	{Opt_stripe, 0, MOPT_GTE0},
>  	{Opt_resuid, 0, MOPT_GTE0},
> @@ -2076,13 +2079,32 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
>  		}
>  		sbi->s_jquota_fmt = m->mount_opt;
>  #endif
> -	} else if (token == Opt_dax) {
> +	} else if (token == Opt_dax || token == Opt_dax_str) {
>  #ifdef CONFIG_FS_DAX
> -		ext4_msg(sb, KERN_WARNING,
> -		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> -		sbi->s_mount_opt |= m->mount_opt;
> +		char *tmp = match_strdup(&args[0]);
> +
> +		if (!tmp || !strcmp(tmp, "always")) {
> +			ext4_msg(sb, KERN_WARNING,
> +				"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> +			sbi->s_mount_opt |= EXT4_MOUNT_DAX_ALWAYS;
> +			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
> +		} else if (!strcmp(tmp, "never")) {
> +			sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_NEVER;
> +			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
> +		} else if (!strcmp(tmp, "inode")) {
> +			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
> +			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
> +		} else {
> +			ext4_msg(sb, KERN_WARNING, "DAX invalid option.");
> +			kfree(tmp);
> +			return -1;
> +		}
> +
> +		kfree(tmp);
>  #else
>  		ext4_msg(sb, KERN_INFO, "dax option not supported");
> +		sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_NEVER;
> +		sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
>  		return -1;
>  #endif
>  	} else if (token == Opt_data_err_abort) {
> @@ -2306,6 +2328,13 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  	if (DUMMY_ENCRYPTION_ENABLED(sbi))
>  		SEQ_OPTS_PUTS("test_dummy_encryption");
>  
> +	if (test_opt2(sb, DAX_NEVER))
> +		SEQ_OPTS_PUTS("dax=never");
> +	else if (test_opt(sb, DAX_ALWAYS))
> +		SEQ_OPTS_PUTS("dax=always");
> +	else
> +		SEQ_OPTS_PUTS("dax=inode");
> +
>  	ext4_show_quota_options(seq, sb);
>  	return 0;
>  }
> @@ -5425,10 +5454,12 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  		goto restore_opts;
>  	}
>  
> -	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_DAX_ALWAYS) {
> +	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_DAX_ALWAYS ||
> +	    (sbi->s_mount_opt2 ^ old_opts.s_mount_opt2) & EXT4_MOUNT2_DAX_NEVER) {
>  		ext4_msg(sb, KERN_WARNING, "warning: refusing change of "
> -			"dax flag with busy inodes while remounting");
> +			"dax mount option with busy inodes while remounting");
>  		sbi->s_mount_opt ^= EXT4_MOUNT_DAX_ALWAYS;
> +		sbi->s_mount_opt2 ^= EXT4_MOUNT2_DAX_NEVER;
>  	}
>  
>  	if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
