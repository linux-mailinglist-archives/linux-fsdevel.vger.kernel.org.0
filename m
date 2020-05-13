Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04271D1D41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 20:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390116AbgEMSRg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 14:17:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57594 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733175AbgEMSRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 14:17:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DICON4089454;
        Wed, 13 May 2020 18:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=UVbLeTrxCATosRQoulTtxJK/NFnJccgVdg4GJjqTM3k=;
 b=qEcNQal7av79dEUMraBDvSw6kcv3/m6+HoYIBO5C6pEEOTiTGnhLTjZkz3sl7HjeGoHh
 2BbnC1ExUOUbYEEKaDmnHUy9/C2cxuOVkF9BoPDa8G1TcEcy0jHSwwH5J5xZHkMKEnTn
 p08p0zF9rsgtQp9rFQ/e3sbRFplwS/gdFrgEU8kz33CxCgo2tA3tsbT8sI1pXvAMdJon
 H54TQPHef2jvzDn8JEkYo4NVLyr+KfAD7X35bMih1Mg2U5L3KSFTMKV0ChmmSFz5sxTz
 Ar2Iau6qOmvHmUUBbrLBiccPHdT/0UEKJ8gbS9YltD24bZHYhFDBAC+IIyzCt0NuPwLa 9g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3100yfwunw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 18:17:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DI7vs4102092;
        Wed, 13 May 2020 18:17:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3100yb1dav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 18:17:22 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04DIHJ4D007022;
        Wed, 13 May 2020 18:17:19 GMT
Received: from localhost (/10.159.244.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 11:17:19 -0700
Date:   Wed, 13 May 2020 11:17:17 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     ira.weiny@intel.com, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] fs/ext4: Make DAX mount option a tri-state
Message-ID: <20200513181717.GA2077014@magnolia>
References: <20200513054324.2138483-1-ira.weiny@intel.com>
 <20200513054324.2138483-8-ira.weiny@intel.com>
 <20200513143526.GG27709@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513143526.GG27709@quack2.suse.cz>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1011 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130154
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 04:35:26PM +0200, Jan Kara wrote:
> On Tue 12-05-20 22:43:22, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > We add 'always', 'never', and 'inode' (default).  '-o dax' continue to
> > operate the same.
> > 
> > Specifically we introduce a 2nd DAX mount flag EXT4_MOUNT2_DAX_NEVER and set
> > it and EXT4_MOUNT_DAX_ALWAYS appropriately.
> > 
> > We also force EXT4_MOUNT2_DAX_NEVER if !CONFIG_FS_DAX.
> > 
> > https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from RFC:
> > 	Combine remount check for DAX_NEVER with DAX_ALWAYS
> > 	Update ext4_should_enable_dax()
> > ---
> >  fs/ext4/ext4.h  |  1 +
> >  fs/ext4/inode.c |  2 ++
> >  fs/ext4/super.c | 43 +++++++++++++++++++++++++++++++++++++------
> >  3 files changed, 40 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 86a0994332ce..01d1de838896 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1168,6 +1168,7 @@ struct ext4_inode_info {
> >  						      blocks */
> >  #define EXT4_MOUNT2_HURD_COMPAT		0x00000004 /* Support HURD-castrated
> >  						      file systems */
> > +#define EXT4_MOUNT2_DAX_NEVER		0x00000008 /* Do not allow Direct Access */
> >  
> >  #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User explicitly
> >  						specified journal checksum */
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 23e42a223235..140b1930e2f4 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -4400,6 +4400,8 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
> >  
> >  static bool ext4_should_enable_dax(struct inode *inode)
> >  {
> > +	if (test_opt2(inode->i_sb, DAX_NEVER))
> > +		return false;
> >  	if (!S_ISREG(inode->i_mode))
> >  		return false;
> >  	if (ext4_should_journal_data(inode))
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 5ec900fdf73c..e01a040a58a9 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1505,6 +1505,7 @@ enum {
> >  	Opt_jqfmt_vfsold, Opt_jqfmt_vfsv0, Opt_jqfmt_vfsv1, Opt_quota,
> >  	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
> >  	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version, Opt_dax,
> > +	Opt_dax_str,
> >  	Opt_stripe, Opt_delalloc, Opt_nodelalloc, Opt_warn_on_error,
> >  	Opt_nowarn_on_error, Opt_mblk_io_submit,
> >  	Opt_lazytime, Opt_nolazytime, Opt_debug_want_extra_isize,
> > @@ -1570,6 +1571,7 @@ static const match_table_t tokens = {
> >  	{Opt_barrier, "barrier"},
> >  	{Opt_nobarrier, "nobarrier"},
> >  	{Opt_i_version, "i_version"},
> > +	{Opt_dax_str, "dax=%s"},
> 
> Hum, maybe it would be easier to handle this like we do with e.g. 'data='
> mount option? I.e. like:
> 
> 	{Opt_dax_always, "dax=always"},
> 	{Opt_dax_never, "dax=never"},
> 	{Opt_dax_inode, "dax=inode"),
> 
> and then handle these three tokens... Not that it would be a big difference
> but that's why we usually handle mount options with small "enums" in ext4.

I was hoping that we could hoist the tristate enum bits out of XFS and
simply share them across the three DAX filesystems, but I have no idea
if that will work with a filesystem that hasn't been converted to the
new mount option parsing api.  I'm betting no. :/

(FWIW see enum xfs_dax_mode and struct constant_table dax_param_enums in
fs/xfs/xfs_super.c in the for-next tree.)

Hm, otoh I don't see any recent posting of an ext4 mount parsing
conversion series, so yeah this is probably as good as can be done until
that happens.

--D

> 								Honza
> 
> >  	{Opt_dax, "dax"},
> >  	{Opt_stripe, "stripe=%u"},
> >  	{Opt_delalloc, "delalloc"},
> > @@ -1767,6 +1769,7 @@ static const struct mount_opts {
> >  	{Opt_min_batch_time, 0, MOPT_GTE0},
> >  	{Opt_inode_readahead_blks, 0, MOPT_GTE0},
> >  	{Opt_init_itable, 0, MOPT_GTE0},
> > +	{Opt_dax_str, 0, MOPT_STRING},
> >  	{Opt_dax, EXT4_MOUNT_DAX_ALWAYS, MOPT_SET},
> >  	{Opt_stripe, 0, MOPT_GTE0},
> >  	{Opt_resuid, 0, MOPT_GTE0},
> > @@ -2076,13 +2079,32 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
> >  		}
> >  		sbi->s_jquota_fmt = m->mount_opt;
> >  #endif
> > -	} else if (token == Opt_dax) {
> > +	} else if (token == Opt_dax || token == Opt_dax_str) {
> >  #ifdef CONFIG_FS_DAX
> > -		ext4_msg(sb, KERN_WARNING,
> > -		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> > -		sbi->s_mount_opt |= m->mount_opt;
> > +		char *tmp = match_strdup(&args[0]);
> > +
> > +		if (!tmp || !strcmp(tmp, "always")) {
> > +			ext4_msg(sb, KERN_WARNING,
> > +				"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> > +			sbi->s_mount_opt |= EXT4_MOUNT_DAX_ALWAYS;
> > +			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
> > +		} else if (!strcmp(tmp, "never")) {
> > +			sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_NEVER;
> > +			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
> > +		} else if (!strcmp(tmp, "inode")) {
> > +			sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
> > +			sbi->s_mount_opt2 &= ~EXT4_MOUNT2_DAX_NEVER;
> > +		} else {
> > +			ext4_msg(sb, KERN_WARNING, "DAX invalid option.");
> > +			kfree(tmp);
> > +			return -1;
> > +		}
> > +
> > +		kfree(tmp);
> >  #else
> >  		ext4_msg(sb, KERN_INFO, "dax option not supported");
> > +		sbi->s_mount_opt2 |= EXT4_MOUNT2_DAX_NEVER;
> > +		sbi->s_mount_opt &= ~EXT4_MOUNT_DAX_ALWAYS;
> >  		return -1;
> >  #endif
> >  	} else if (token == Opt_data_err_abort) {
> > @@ -2306,6 +2328,13 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
> >  	if (DUMMY_ENCRYPTION_ENABLED(sbi))
> >  		SEQ_OPTS_PUTS("test_dummy_encryption");
> >  
> > +	if (test_opt2(sb, DAX_NEVER))
> > +		SEQ_OPTS_PUTS("dax=never");
> > +	else if (test_opt(sb, DAX_ALWAYS))
> > +		SEQ_OPTS_PUTS("dax=always");
> > +	else
> > +		SEQ_OPTS_PUTS("dax=inode");
> > +
> >  	ext4_show_quota_options(seq, sb);
> >  	return 0;
> >  }
> > @@ -5425,10 +5454,12 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
> >  		goto restore_opts;
> >  	}
> >  
> > -	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_DAX_ALWAYS) {
> > +	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_DAX_ALWAYS ||
> > +	    (sbi->s_mount_opt2 ^ old_opts.s_mount_opt2) & EXT4_MOUNT2_DAX_NEVER) {
> >  		ext4_msg(sb, KERN_WARNING, "warning: refusing change of "
> > -			"dax flag with busy inodes while remounting");
> > +			"dax mount option with busy inodes while remounting");
> >  		sbi->s_mount_opt ^= EXT4_MOUNT_DAX_ALWAYS;
> > +		sbi->s_mount_opt2 ^= EXT4_MOUNT2_DAX_NEVER;
> >  	}
> >  
> >  	if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
> > -- 
> > 2.25.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
