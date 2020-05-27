Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C2E1E51FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 01:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgE0XuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 19:50:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:54853 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgE0XuD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 19:50:03 -0400
IronPort-SDR: cU4XEzySn+9XOrwsXp8MbGUsU53rRepLM5LrjKAKe1LSOK29Y7lQT6A7aeVtbb5BJ5CkS7O/j+
 XiccI3R5VZ1A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 16:50:03 -0700
IronPort-SDR: HtdcQ1lrFa717b7sYPNohKWgeTCLDj2OKc5kVkjlw04jtr5o9+mgwONWKO+0FbsyNFmk/rRQvG
 n9NT/Dm2CO+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; 
   d="scan'208";a="270647096"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 27 May 2020 16:50:02 -0700
Date:   Wed, 27 May 2020 16:50:02 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 6/8] fs/ext4: Make DAX mount option a tri-state
Message-ID: <20200527235002.GA725853@iweiny-DESK2.sc.intel.com>
References: <20200521191313.261929-1-ira.weiny@intel.com>
 <20200521191313.261929-7-ira.weiny@intel.com>
 <5ECE00AE.3010802@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ECE00AE.3010802@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 27, 2020 at 01:54:54PM +0800, Xiao Yang wrote:
> On 2020/5/22 3:13, ira.weiny@intel.com wrote:
> > From: Ira Weiny<ira.weiny@intel.com>
> > 
> > We add 'always', 'never', and 'inode' (default).  '-o dax' continues to
> > operate the same which is equivalent to 'always'.  This new
> > functionality is limited to ext4 only.
> > 
> > Specifically we introduce a 2nd DAX mount flag EXT4_MOUNT2_DAX_NEVER and set
> > it and EXT4_MOUNT_DAX_ALWAYS appropriately for the mode.
> > 
> > We also force EXT4_MOUNT2_DAX_NEVER if !CONFIG_FS_DAX.
> > 
> > Finally, EXT4_MOUNT2_DAX_INODE is used solely to detect if the user
> > specified that option for printing.
> Hi Ira,
> 
> I have two questions when reviewing this patch:
> 1) After doing mount with the same dax=inode option, ext4/xfs shows
> differnt output(i.e. xfs doesn't print 'dax=inode'):
> ---------------------------------------------------
> # mount -o dax=inode /dev/pmem0 /mnt/xfstests/test/
> # mount | grep pmem0
> /dev/pmem0 on /mnt/xfstests/test type ext4 (rw,relatime,seclabel,dax=inode)
> 
> # mount -odax=inode /dev/pmem1 /mnt/xfstests/scratch/
> # mount | grep pmem1
> /dev/pmem1 on /mnt/xfstests/scratch type xfs
> (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> ----------------------------------------------------
> Is this expected output? why don't unify the output?

Correct. dax=inode is the default.  xfs treats that default the same whether
you specify it on the command line or not.

For ext4 Jan specifically asked that if the user specified dax=inode on the
command line that it be printed on the mount options.  If you don't specify
anything then dax=inode is in effect but ext4 will not print anything.

I had the behavior the same as XFS originally but Jan wanted it this way.  The
XFS behavior is IMO better and is what the new mount infrastructure gives by
default.

> 
> 2) Do mount without dax and mount with -odax=inode have the same behavior?

Yes.

> ---------------------------------------------------
> # mount /dev/pmem0 /mnt/xfstests/test/
> # mount | grep pmem0
> /dev/pmem0 on /mnt/xfstests/test type ext4 (rw,relatime,seclabel)
> # umount /mnt/xfstests/test
> # mount -odax=inode /dev/pmem0 /mnt/xfstests/test/
> # mount | grep pmem0
> /dev/pmem0 on /mnt/xfstests/test type ext4 (rw,relatime,seclabel,dax=inode
> ---------------------------------------------------

These are the same behavior.  But because you specified the option it was
echoed in the second output.

> 
> BTW: I focus on the support of per-file/directory DAX operations recently.
> 
> > 
> > Reviewed-by: Jan Kara<jack@suse.cz>
> > Signed-off-by: Ira Weiny<ira.weiny@intel.com>
> > 
> > ---
> > Changes from V1:
> > 	Fix up mounting options to only show an option if specified
> > 	Fix remount to prevent dax changes
> > 	Isolate behavior to ext4 only
> > 
> > Changes from RFC:
> > 	Combine remount check for DAX_NEVER with DAX_ALWAYS
> > 	Update ext4_should_enable_dax()
> > ---
> >   fs/ext4/ext4.h  |  2 ++
> >   fs/ext4/inode.c |  2 ++
> >   fs/ext4/super.c | 67 +++++++++++++++++++++++++++++++++++++++++--------
> >   3 files changed, 61 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index f5291693ce6e..65ffb831b2b9 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1168,6 +1168,8 @@ struct ext4_inode_info {
> >   						      blocks */
> >   #define EXT4_MOUNT2_HURD_COMPAT		0x00000004 /* Support HURD-castrated
> >   						      file systems */
> > +#define EXT4_MOUNT2_DAX_NEVER		0x00000008 /* Do not allow Direct Access */
> > +#define EXT4_MOUNT2_DAX_INODE		0x00000010 /* For printing options only */
> > 
> >   #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User explicitly
> >   						specified journal checksum */
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 01636cf5f322..68fac9289109 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -4402,6 +4402,8 @@ static bool ext4_should_enable_dax(struct inode *inode)
> >   {
> >   	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> > 
> > +	if (test_opt2(inode->i_sb, DAX_NEVER))
> > +		return false;
> >   	if (!S_ISREG(inode->i_mode))
> >   		return false;
> >   	if (ext4_should_journal_data(inode))
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 80eb814c47eb..5e056aa20ce9 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1512,7 +1512,8 @@ enum {
> >   	Opt_usrjquota, Opt_grpjquota, Opt_offusrjquota, Opt_offgrpjquota,
> >   	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quota,
> >   	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
> > -	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version, Opt_dax,
> > +	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version,
> > +	Opt_dax, Opt_dax_always, Opt_dax_inode, Opt_dax_never,
> >   	Opt_stripe, Opt_delalloc, Opt_nodelalloc, Opt_warn_on_error,
> >   	Opt_nowarn_on_error, Opt_mblk_io_submit,
> >   	Opt_lazytime, Opt_nolazytime, Opt_debug_want_extra_isize,
> > @@ -1579,6 +1580,9 @@ static const match_table_t tokens = {
> >   	{Opt_nobarrier, "nobarrier"},
> >   	{Opt_i_version, "i_version"},
> >   	{Opt_dax, "dax"},
> > +	{Opt_dax_always, "dax=always"},
> > +	{Opt_dax_inode, "dax=inode"},
> > +	{Opt_dax_never, "dax=never"},
> >   	{Opt_stripe, "stripe=%u"},
> >   	{Opt_delalloc, "delalloc"},
> >   	{Opt_warn_on_error, "warn_on_error"},
> > @@ -1726,6 +1730,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
> >   #define MOPT_NO_EXT3	0x0200
> >   #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
> >   #define MOPT_STRING	0x0400
> > +#define MOPT_SKIP	0x0800
> > 
> >   static const struct mount_opts {
> >   	int	token;
> > @@ -1775,7 +1780,13 @@ static const struct mount_opts {
> >   	{Opt_min_batch_time, 0, MOPT_GTE0},
> >   	{Opt_inode_readahead_blks, 0, MOPT_GTE0},
> >   	{Opt_init_itable, 0, MOPT_GTE0},
> > -	{Opt_dax, EXT4_MOUNT_DAX_ALWAYS, MOPT_SET},
> > +	{Opt_dax, EXT4_MOUNT_DAX_ALWAYS, MOPT_SET | MOPT_SKIP},
> > +	{Opt_dax_always, EXT4_MOUNT_DAX_ALWAYS,
> > +		MOPT_EXT4_ONLY | MOPT_SET | MOPT_SKIP},
> > +	{Opt_dax_inode, EXT4_MOUNT2_DAX_INODE,
> > +		MOPT_EXT4_ONLY | MOPT_SET | MOPT_SKIP},
> > +	{Opt_dax_never, EXT4_MOUNT2_DAX_NEVER,
> > +		MOPT_EXT4_ONLY | MOPT_SET | MOPT_SKIP},
> >   	{Opt_stripe, 0, MOPT_GTE0},
> >   	{Opt_resuid, 0, MOPT_GTE0},
> >   	{Opt_resgid, 0, MOPT_GTE0},
> > @@ -2084,13 +2095,32 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
> >   		}
> >   		sbi->s_jquota_fmt = m->mount_opt;
> >   #endif
> > -	} else if (token == Opt_dax) {
> > +	} else if (token == Opt_dax || token == Opt_dax_always ||
> > +		   token == Opt_dax_inode || token == Opt_dax_never) {
> >   #ifdef CONFIG_FS_DAX
> > -		ext4_msg(sb, KERN_WARNING,
> > -		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> > -		sbi->s_mount_opt |= m->mount_opt;
> > +		switch (token) {
> > +		case Opt_dax:
> > +		case Opt_dax_always:
> > +			ext4_msg(sb, KERN_WARNING,
> > +				"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> > +			sbi->s_mount_opt |= EXT4_MOUNT_DAX_ALWAYS;
> > +			sbi->s_mount_opt2&= ~EXT4_MOUNT2_DAX_NEVER;
> > +			break;
> > +		case Opt_dax_never:
> > +			sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_NEVER;
> > +			sbi->s_mount_opt&= ~EXT4_MOUNT_DAX_ALWAYS;
> > +			break;
> > +		case Opt_dax_inode:
> > +			sbi->s_mount_opt&= ~EXT4_MOUNT_DAX_ALWAYS;
> > +			sbi->s_mount_opt2&= ~EXT4_MOUNT2_DAX_NEVER;
> > +			/* Strictly for printing options */
> > +			sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_INODE;
> > +			break;
> > +		}
> >   #else
> >   		ext4_msg(sb, KERN_INFO, "dax option not supported");
> > +		sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_NEVER;
> > +		sbi->s_mount_opt&= ~EXT4_MOUNT_DAX_ALWAYS;
> >   		return -1;
> >   #endif
> 
> For s_mount_opt/s_mount_opt2, could we make the code more readable by
> using set_opt()/set_opt2()/clear_opt()/clear_opt2() macros?

I could but it seems like there is a mixture of styles in that function/file...

For me it is really a toss up which is more readable.  I'm inclined to keep it
since it's been reviewed multiple times.  I was about to send V5 but I'll hold
off a bit.  If you feel strongly about it I can change it.

Thanks for the review!
Ira

> 
> Thanks,
> Xiao Yang
> >   	} else if (token == Opt_data_err_abort) {
> > @@ -2254,7 +2284,7 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
> >   	for (m = ext4_mount_opts; m->token != Opt_err; m++) {
> >   		int want_set = m->flags&  MOPT_SET;
> >   		if (((m->flags&  (MOPT_SET|MOPT_CLEAR)) == 0) ||
> > -		    (m->flags&  MOPT_CLEAR_ERR))
> > +		    (m->flags&  MOPT_CLEAR_ERR) || m->flags&  MOPT_SKIP)
> >   			continue;
> >   		if (!nodefs&&  !(m->mount_opt&  (sbi->s_mount_opt ^ def_mount_opt)))
> >   			continue; /* skip if same as the default */
> > @@ -2314,6 +2344,17 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
> >   	if (DUMMY_ENCRYPTION_ENABLED(sbi))
> >   		SEQ_OPTS_PUTS("test_dummy_encryption");
> > 
> > +	if (test_opt(sb, DAX_ALWAYS)) {
> > +		if (IS_EXT2_SB(sb))
> > +			SEQ_OPTS_PUTS("dax");
> > +		else
> > +			SEQ_OPTS_PUTS("dax=always");
> > +	} else if (test_opt2(sb, DAX_NEVER)) {
> > +		SEQ_OPTS_PUTS("dax=never");
> > +	} else if (test_opt2(sb, DAX_INODE)) {
> > +		SEQ_OPTS_PUTS("dax=inode");
> > +	}
> > +
> >   	ext4_show_quota_options(seq, sb);
> >   	return 0;
> >   }
> > @@ -5436,10 +5477,16 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
> >   		goto restore_opts;
> >   	}
> > 
> > -	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt)&  EXT4_MOUNT_DAX_ALWAYS) {
> > +	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt)&  EXT4_MOUNT_DAX_ALWAYS ||
> > +	    (sbi->s_mount_opt2 ^ old_opts.s_mount_opt2)&  EXT4_MOUNT2_DAX_NEVER ||
> > +	    (sbi->s_mount_opt2 ^ old_opts.s_mount_opt2)&  EXT4_MOUNT2_DAX_INODE) {
> >   		ext4_msg(sb, KERN_WARNING, "warning: refusing change of "
> > -			"dax flag with busy inodes while remounting");
> > -		sbi->s_mount_opt ^= EXT4_MOUNT_DAX_ALWAYS;
> > +			"dax mount option with busy inodes while remounting");
> > +		sbi->s_mount_opt&= ~EXT4_MOUNT_DAX_ALWAYS;
> > +		sbi->s_mount_opt |= old_opts.s_mount_opt&  EXT4_MOUNT_DAX_ALWAYS;
> > +		sbi->s_mount_opt2&= ~(EXT4_MOUNT2_DAX_NEVER | EXT4_MOUNT2_DAX_INODE);
> > +		sbi->s_mount_opt2 |= old_opts.s_mount_opt2&
> > +				     (EXT4_MOUNT2_DAX_NEVER | EXT4_MOUNT2_DAX_INODE);
> >   	}
> > 
> >   	if (sbi->s_mount_flags&  EXT4_MF_FS_ABORTED)
> 
> 
> 
