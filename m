Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE131A6C7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 21:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbgDMTaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 15:30:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:1619 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728291AbgDMTaM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:30:12 -0400
IronPort-SDR: 286oIun30BGMf8BEttGaW4EX38hDPfV/LmIUtzOxJv9pFU/TmRmUgLx4cdGfn2UQSOHDetd8mX
 ZVon1wcdcfrw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 12:28:12 -0700
IronPort-SDR: Loglpq7aF2CK7g5lon1QpB2lgXi+lpHfvkyrveMp5eD18Th7RS80UtW520OINb8y3tn0W4P7oK
 ML2GF8/CaN3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="scan'208";a="241750198"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga007.jf.intel.com with ESMTP; 13 Apr 2020 12:28:11 -0700
Date:   Mon, 13 Apr 2020 12:28:11 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 4/9] fs/xfs: Make DAX mount option a tri-state
Message-ID: <20200413192810.GB1649878@iweiny-DESK2.sc.intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-5-ira.weiny@intel.com>
 <20200413154619.GT6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413154619.GT6742@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 08:46:19AM -0700, Darrick J. Wong wrote:
> On Sun, Apr 12, 2020 at 10:40:41PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > As agreed upon[1].  We make the dax mount option a tri-state.  '-o dax'
> > continues to operate the same.  We add 'always', 'never', and 'inode'
> > (default).
> > 
> > [1] https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from v6:
> > 	Use 2 flag bits rather than a field.
> > 	change iflag to inode
> > 
> > Changes from v5:
> > 	New Patch
> > ---
> >  fs/xfs/xfs_mount.h |  3 ++-
> >  fs/xfs/xfs_super.c | 44 ++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 42 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> > index 88ab09ed29e7..d581b990e59a 100644
> > --- a/fs/xfs/xfs_mount.h
> > +++ b/fs/xfs/xfs_mount.h
> > @@ -233,7 +233,8 @@ typedef struct xfs_mount {
> >  						   allocator */
> >  #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
> >  
> > -#define XFS_MOUNT_DAX		(1ULL << 62)	/* TEST ONLY! */
> > +#define XFS_MOUNT_DAX		(1ULL << 62)
> > +#define XFS_MOUNT_NODAX		(1ULL << 63)
> >  
> >  /*
> >   * Max and min values for mount-option defined I/O
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 2094386af8ac..d7bd8f5e00c9 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -47,6 +47,32 @@ static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
> >  static struct xfs_kobj xfs_dbg_kobj;	/* global debug sysfs attrs */
> >  #endif
> >  
> > +enum {
> > +	XFS_DAX_INODE = 0,
> > +	XFS_DAX_ALWAYS = 1,
> > +	XFS_DAX_NEVER = 2,
> > +};
> > +
> > +static void xfs_mount_set_dax_mode(struct xfs_mount *mp, u32 val)
> > +{
> > +	if (val == XFS_DAX_INODE) {
> > +		mp->m_flags &= ~(XFS_MOUNT_DAX | XFS_MOUNT_NODAX);
> > +	} else if (val == XFS_DAX_ALWAYS) {
> > +		mp->m_flags &= ~XFS_MOUNT_NODAX;
> > +		mp->m_flags |= XFS_MOUNT_DAX;
> > +	} else if (val == XFS_DAX_NEVER) {
> > +		mp->m_flags &= ~XFS_MOUNT_DAX;
> > +		mp->m_flags |= XFS_MOUNT_NODAX;
> > +	}
> > +}
> > +
> > +static const struct constant_table dax_param_enums[] = {
> > +	{"inode",	XFS_DAX_INODE },
> > +	{"always",	XFS_DAX_ALWAYS },
> > +	{"never",	XFS_DAX_NEVER },
> > +	{}
> 
> I think that the dax_param_enums table (and the unnamed enum defining
> XFS_DAX_*) probably ought to be part of the VFS so that you don't have
> to duplicate these two pieces whenever it's time to bring ext4 in line
> with XFS.
> 
> That probably doesn't need to be done right away, though...

Ext4 has a very different param parsing mechanism which I've barely learned.
I'm not really seeing how to use the enum strategy so I've just used a string
option.  But I'm open to being corrected.

I am close to having the series working and hope to have that set (which builds
on this one) out for review soon (today?).

> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks,
Ira

> 
> --D
> 
> 
> > +};
> > +
> >  /*
> >   * Table driven mount option parser.
> >   */
> > @@ -59,7 +85,7 @@ enum {
> >  	Opt_filestreams, Opt_quota, Opt_noquota, Opt_usrquota, Opt_grpquota,
> >  	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
> >  	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
> > -	Opt_discard, Opt_nodiscard, Opt_dax,
> > +	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum,
> >  };
> >  
> >  static const struct fs_parameter_spec xfs_fs_parameters[] = {
> > @@ -103,6 +129,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
> >  	fsparam_flag("discard",		Opt_discard),
> >  	fsparam_flag("nodiscard",	Opt_nodiscard),
> >  	fsparam_flag("dax",		Opt_dax),
> > +	fsparam_enum("dax",		Opt_dax_enum, dax_param_enums),
> >  	{}
> >  };
> >  
> > @@ -129,7 +156,6 @@ xfs_fs_show_options(
> >  		{ XFS_MOUNT_GRPID,		",grpid" },
> >  		{ XFS_MOUNT_DISCARD,		",discard" },
> >  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> > -		{ XFS_MOUNT_DAX,		",dax" },
> >  		{ 0, NULL }
> >  	};
> >  	struct xfs_mount	*mp = XFS_M(root->d_sb);
> > @@ -185,6 +211,13 @@ xfs_fs_show_options(
> >  	if (!(mp->m_qflags & XFS_ALL_QUOTA_ACCT))
> >  		seq_puts(m, ",noquota");
> >  
> > +	if (mp->m_flags & XFS_MOUNT_DAX)
> > +		seq_puts(m, ",dax=always");
> > +	else if (mp->m_flags & XFS_MOUNT_NODAX)
> > +		seq_puts(m, ",dax=never");
> > +	else
> > +		seq_puts(m, ",dax=inode");
> > +
> >  	return 0;
> >  }
> >  
> > @@ -1244,7 +1277,10 @@ xfs_fc_parse_param(
> >  		return 0;
> >  #ifdef CONFIG_FS_DAX
> >  	case Opt_dax:
> > -		mp->m_flags |= XFS_MOUNT_DAX;
> > +		xfs_mount_set_dax_mode(mp, XFS_DAX_ALWAYS);
> > +		return 0;
> > +	case Opt_dax_enum:
> > +		xfs_mount_set_dax_mode(mp, result.uint_32);
> >  		return 0;
> >  #endif
> >  	default:
> > @@ -1451,7 +1487,7 @@ xfs_fc_fill_super(
> >  		if (!rtdev_is_dax && !datadev_is_dax) {
> >  			xfs_alert(mp,
> >  			"DAX unsupported by block device. Turning off DAX.");
> > -			mp->m_flags &= ~XFS_MOUNT_DAX;
> > +			xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
> >  		}
> >  		if (xfs_sb_version_hasreflink(&mp->m_sb)) {
> >  			xfs_alert(mp,
> > -- 
> > 2.25.1
> > 
