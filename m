Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB0B1AB68E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 06:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391783AbgDPEP5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 00:15:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:21964 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389455AbgDPEP4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 00:15:56 -0400
IronPort-SDR: JkHxu8MxZV1GQtNUdMQaR0oByExv8mnq/kvR00Vgkz0xigTw+S8aeopdYfsEa+FlG9vyYRTkFs
 WCj4uDuNRMVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 21:15:54 -0700
IronPort-SDR: p8FGYhBhOm2nAXr672lmqH6Pbtr2jBkyK2nNKAcsCMBUi0s8SfTtnQ4OgzfrFSx6kREuNoyRzC
 62E9lrRQdhNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="299188766"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2020 21:15:54 -0700
Date:   Wed, 15 Apr 2020 21:15:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 05/11] fs/xfs: Make DAX mount option a tri-state
Message-ID: <20200416041553.GF2309605@iweiny-DESK2.sc.intel.com>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-6-ira.weiny@intel.com>
 <20200415151613.GO6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415151613.GO6742@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 08:16:13AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 14, 2020 at 11:45:17PM -0700, ira.weiny@intel.com wrote:
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
> > Changes from v7:
> > 	Change to XFS_MOUNT_DAX_NEVER
> > 
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
> > index 54bd74088936..2e88c30642e3 100644
> > --- a/fs/xfs/xfs_mount.h
> > +++ b/fs/xfs/xfs_mount.h
> > @@ -233,7 +233,8 @@ typedef struct xfs_mount {
> >  						   allocator */
> >  #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
> >  
> > -#define XFS_MOUNT_DAX_ALWAYS	(1ULL << 62)	/* TEST ONLY! */
> > +#define XFS_MOUNT_DAX_ALWAYS	(1ULL << 62)
> > +#define XFS_MOUNT_DAX_NEVER	(1ULL << 63)
> >  
> >  /*
> >   * Max and min values for mount-option defined I/O
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 3863f41757d2..142e5d03566f 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -47,6 +47,32 @@ static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
> >  static struct xfs_kobj xfs_dbg_kobj;	/* global debug sysfs attrs */
> >  #endif
> >  
> > +enum {
> 
> enum xfs_dax_mode {  for the reasons given below?
> 
> > +	XFS_DAX_INODE = 0,
> > +	XFS_DAX_ALWAYS = 1,
> > +	XFS_DAX_NEVER = 2,
> > +};
> > +
> > +static void xfs_mount_set_dax_mode(struct xfs_mount *mp, u32 val)
> 
> xfs style, please:
> 
> static void
> xfs_mount_set_dax_mode(
> 	struct xfs_mount	*mp,
> 	u32			val)

NP changed.

> 
> or if you give a name to the enum above, you can enforce some type
> safety too:
> 
> 	enum xfs_dax_mode	val)

The problem is that the option parsing returns result.uint_32 type.  Generally
I agree with using more specific types but here I'm not sure it matters.

> 
> > +{
> > +	if (val == XFS_DAX_INODE) {
> 
> and this probably could have been a "switch (val) {", in which case if
> the enum ever gets expanded then gcc will whine about missing switch
> cases.

Sure...  that does require the enum to be defined and used in the signature...

Ok I'll use the enum!  :-D

done.

Thanks,
Ira


> 
> The rest of the patch looks good.
> 
> --D
> 
> > +		mp->m_flags &= ~(XFS_MOUNT_DAX_ALWAYS | XFS_MOUNT_DAX_NEVER);
> > +	} else if (val == XFS_DAX_ALWAYS) {
> > +		mp->m_flags |= XFS_MOUNT_DAX_ALWAYS;
> > +		mp->m_flags &= ~XFS_MOUNT_DAX_NEVER;
> > +	} else if (val == XFS_DAX_NEVER) {
> > +		mp->m_flags |= XFS_MOUNT_DAX_NEVER;
> > +		mp->m_flags &= ~XFS_MOUNT_DAX_ALWAYS;
> > +	}
> > +}
> > +
> > +static const struct constant_table dax_param_enums[] = {
> > +	{"inode",	XFS_DAX_INODE },
> > +	{"always",	XFS_DAX_ALWAYS },
> > +	{"never",	XFS_DAX_NEVER },
> > +	{}
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
> > -		{ XFS_MOUNT_DAX_ALWAYS,		",dax" },
> >  		{ 0, NULL }
> >  	};
> >  	struct xfs_mount	*mp = XFS_M(root->d_sb);
> > @@ -185,6 +211,13 @@ xfs_fs_show_options(
> >  	if (!(mp->m_qflags & XFS_ALL_QUOTA_ACCT))
> >  		seq_puts(m, ",noquota");
> >  
> > +	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS)
> > +		seq_puts(m, ",dax=always");
> > +	else if (mp->m_flags & XFS_MOUNT_DAX_NEVER)
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
> > -		mp->m_flags |= XFS_MOUNT_DAX_ALWAYS;
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
> > -			mp->m_flags &= ~XFS_MOUNT_DAX_ALWAYS;
> > +			xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
> >  		}
> >  		if (xfs_sb_version_hasreflink(&mp->m_sb)) {
> >  			xfs_alert(mp,
> > -- 
> > 2.25.1
> > 
