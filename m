Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0933E1D49A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 11:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgEOJca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 05:32:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:51732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgEOJc3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 05:32:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86733B1C1;
        Fri, 15 May 2020 09:32:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6F43D1E056A; Fri, 15 May 2020 11:32:24 +0200 (CEST)
Date:   Fri, 15 May 2020 11:32:24 +0200
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
Subject: Re: [PATCH v2 7/9] fs/ext4: Make DAX mount option a tri-state
Message-ID: <20200515093224.GI9569@quack2.suse.cz>
References: <20200515044121.2987940-1-ira.weiny@intel.com>
 <20200515044121.2987940-8-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515044121.2987940-8-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-05-20 21:41:19, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> We add 'always', 'never', and 'inode' (default).  '-o dax' continues to
> operate the same which is equivalent to 'always'.  This new
> functionality is limited to ext4 only.
> 
> Specifically we introduce a 2nd DAX mount flag EXT4_MOUNT2_DAX_NEVER and set
> it and EXT4_MOUNT_DAX_ALWAYS appropriately for the mode.
> 
> We also force EXT4_MOUNT2_DAX_NEVER if !CONFIG_FS_DAX.
> 
> Finally, EXT4_MOUNT2_DAX_INODE is used solely to detect if the user
> specified that option for printing.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Thanks. The patch looks good to me now. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes from V1:
> 	Fix up mounting options to only show an option if specified
> 	Fix remount to prevent dax changes
> 	Isolate behavior to ext4 only
> 
> Changes from RFC:
> 	Combine remount check for DAX_NEVER with DAX_ALWAYS
> 	Update ext4_should_enable_dax()
> ---
>  fs/ext4/ext4.h  |  2 ++
>  fs/ext4/inode.c |  2 ++
>  fs/ext4/super.c | 67 +++++++++++++++++++++++++++++++++++++++++--------
>  3 files changed, 61 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 86a0994332ce..6235440e4c39 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1168,6 +1168,8 @@ struct ext4_inode_info {
>  						      blocks */
>  #define EXT4_MOUNT2_HURD_COMPAT		0x00000004 /* Support HURD-castrated
>  						      file systems */
> +#define EXT4_MOUNT2_DAX_NEVER		0x00000008 /* Do not allow Direct Access */
> +#define EXT4_MOUNT2_DAX_INODE		0x00000010 /* For printing options only */
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
> index 5ec900fdf73c..4753de53b186 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1504,7 +1504,8 @@ enum {
>  	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
>  	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quota,
>  	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
> -	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version, Opt_dax,
> +	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version,
> +	Opt_dax, Opt_dax_always, Opt_dax_inode, Opt_dax_never,
>  	Opt_stripe, Opt_delalloc, Opt_nodelalloc, Opt_warn_on_error,
>  	Opt_nowarn_on_error, Opt_mblk_io_submit,
>  	Opt_lazytime, Opt_nolazytime, Opt_debug_want_extra_isize,
> @@ -1571,6 +1572,9 @@ static const match_table_t tokens = {
>  	{Opt_nobarrier, "nobarrier"},
>  	{Opt_i_version, "i_version"},
>  	{Opt_dax, "dax"},
> +	{Opt_dax_always, "dax=always"},
> +	{Opt_dax_inode, "dax=inode"},
> +	{Opt_dax_never, "dax=never"},
>  	{Opt_stripe, "stripe=%u"},
>  	{Opt_delalloc, "delalloc"},
>  	{Opt_warn_on_error, "warn_on_error"},
> @@ -1718,6 +1722,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
>  #define MOPT_NO_EXT3	0x0200
>  #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
>  #define MOPT_STRING	0x0400
> +#define MOPT_SKIP	0x0800
>  
>  static const struct mount_opts {
>  	int	token;
> @@ -1767,7 +1772,13 @@ static const struct mount_opts {
>  	{Opt_min_batch_time, 0, MOPT_GTE0},
>  	{Opt_inode_readahead_blks, 0, MOPT_GTE0},
>  	{Opt_init_itable, 0, MOPT_GTE0},
> -	{Opt_dax, EXT4_MOUNT_DAX_ALWAYS, MOPT_SET},
> +	{Opt_dax, EXT4_MOUNT_DAX_ALWAYS, MOPT_SET | MOPT_SKIP},
> +	{Opt_dax_always, EXT4_MOUNT_DAX_ALWAYS,
> +		MOPT_EXT4_ONLY | MOPT_SET | MOPT_SKIP},
> +	{Opt_dax_inode, EXT4_MOUNT2_DAX_INODE,
> +		MOPT_EXT4_ONLY | MOPT_SET | MOPT_SKIP},
> +	{Opt_dax_never, EXT4_MOUNT2_DAX_NEVER,
> +		MOPT_EXT4_ONLY | MOPT_SET | MOPT_SKIP},
>  	{Opt_stripe, 0, MOPT_GTE0},
>  	{Opt_resuid, 0, MOPT_GTE0},
>  	{Opt_resgid, 0, MOPT_GTE0},
> @@ -2076,13 +2087,32 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
>  		}
>  		sbi->s_jquota_fmt = m->mount_opt;
>  #endif
> -	} else if (token == Opt_dax) {
> +	} else if (token == Opt_dax || token == Opt_dax_always ||
> +		   token == Opt_dax_inode || token == Opt_dax_never) {
>  #ifdef CONFIG_FS_DAX
> -		ext4_msg(sb, KERN_WARNING,
> -		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> -		sbi->s_mount_opt |= m->mount_opt;
> +		switch (token) {
> +		case Opt_dax:
> +		case Opt_dax_always:
> +			ext4_msg(sb, KERN_WARNING,
> +				"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> +			sbi->s_mount_opt |= EXT4_MOUNT_DAX_ALWAYS;
> +			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
> +			break;
> +		case Opt_dax_never:
> +			sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_NEVER;
> +			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
> +			break;
> +		case Opt_dax_inode:
> +			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
> +			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
> +			/* Strictly for printing options */
> +			sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_INODE;
> +			break;
> +		}
>  #else
>  		ext4_msg(sb, KERN_INFO, "dax option not supported");
> +		sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_NEVER;
> +		sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
>  		return -1;
>  #endif
>  	} else if (token == Opt_data_err_abort) {
> @@ -2246,7 +2276,7 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  	for (m = ext4_mount_opts; m->token != Opt_err; m++) {
>  		int want_set = m->flags & MOPT_SET;
>  		if (((m->flags & (MOPT_SET|MOPT_CLEAR)) == 0) ||
> -		    (m->flags & MOPT_CLEAR_ERR))
> +		    (m->flags & MOPT_CLEAR_ERR) || m->flags & MOPT_SKIP)
>  			continue;
>  		if (!nodefs && !(m->mount_opt & (sbi->s_mount_opt ^ def_mount_opt)))
>  			continue; /* skip if same as the default */
> @@ -2306,6 +2336,17 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  	if (DUMMY_ENCRYPTION_ENABLED(sbi))
>  		SEQ_OPTS_PUTS("test_dummy_encryption");
>  
> +	if (test_opt(sb, DAX_ALWAYS)) {
> +		if (IS_EXT2_SB(sb))
> +			SEQ_OPTS_PUTS("dax");
> +		else
> +			SEQ_OPTS_PUTS("dax=always");
> +	} else if (test_opt2(sb, DAX_NEVER)) {
> +		SEQ_OPTS_PUTS("dax=never");
> +	} else if (test_opt2(sb, DAX_INODE)) {
> +		SEQ_OPTS_PUTS("dax=inode");
> +	}
> +
>  	ext4_show_quota_options(seq, sb);
>  	return 0;
>  }
> @@ -5425,10 +5466,16 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  		goto restore_opts;
>  	}
>  
> -	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_DAX_ALWAYS) {
> +	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_DAX_ALWAYS ||
> +	    (sbi->s_mount_opt2 ^ old_opts.s_mount_opt2) & EXT4_MOUNT2_DAX_NEVER ||
> +	    (sbi->s_mount_opt2 ^ old_opts.s_mount_opt2) & EXT4_MOUNT2_DAX_INODE) {
>  		ext4_msg(sb, KERN_WARNING, "warning: refusing change of "
> -			"dax flag with busy inodes while remounting");
> -		sbi->s_mount_opt ^= EXT4_MOUNT_DAX_ALWAYS;
> +			"dax mount option with busy inodes while remounting");
> +		sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
> +		sbi->s_mount_opt |= old_opts.s_mount_opt & EXT4_MOUNT_DAX_ALWAYS;
> +		sbi->s_mount_opt2 &= ~(EXT4_MOUNT2_DAX_NEVER | EXT4_MOUNT2_DAX_INODE);
> +		sbi->s_mount_opt2 |= old_opts.s_mount_opt2 &
> +				     (EXT4_MOUNT2_DAX_NEVER | EXT4_MOUNT2_DAX_INODE);
>  	}
>  
>  	if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
