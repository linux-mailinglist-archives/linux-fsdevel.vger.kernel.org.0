Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5106E1A191D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 02:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgDHAJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 20:09:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:43254 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgDHAJF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:09:05 -0400
IronPort-SDR: 5TrRDCu5gmAdlzNBlNGJeVP34XQSF4MS3++VFLab0wEgGDuWjB0v1EeSeIeFWwSJf4BGOOavBJ
 fovi2QYh/kbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 17:09:04 -0700
IronPort-SDR: Dm82K9xaedvdXBWmxdpveMkuMdvUNszY5csmU/bEr3i+L72s9VRLSxZPfg6bdIan7q2+FH8cxR
 BoOrxeA47b6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="451413605"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2020 17:09:04 -0700
Date:   Tue, 7 Apr 2020 17:09:04 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 4/8] fs/xfs: Make DAX mount option a tri-state
Message-ID: <20200408000903.GA569068@iweiny-DESK2.sc.intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-5-ira.weiny@intel.com>
 <20200407235909.GF24067@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407235909.GF24067@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 09:59:09AM +1000, Dave Chinner wrote:
> On Tue, Apr 07, 2020 at 11:29:54AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > As agreed upon[1].  We make the dax mount option a tri-state.  '-o dax'
> > continues to operate the same.  We add 'always', 'never', and 'iflag'
> > (default).
> > 
> > [1] https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from v5:
> > 	New Patch
> > ---
> >  fs/xfs/xfs_iops.c  |  2 +-
> >  fs/xfs/xfs_mount.h | 26 +++++++++++++++++++++++++-
> >  fs/xfs/xfs_super.c | 34 +++++++++++++++++++++++++++++-----
> >  3 files changed, 55 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index 81f2f93caec0..1ec4a36917bd 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -1248,7 +1248,7 @@ xfs_inode_supports_dax(
> >  		return false;
> >  
> >  	/* DAX mount option or DAX iflag must be set. */
> > -	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
> > +	if (xfs_mount_dax_mode(mp) != XFS_DAX_ALWAYS &&
> >  	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
> >  		return false;
> >  
> > diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> > index 88ab09ed29e7..ce027ee06692 100644
> > --- a/fs/xfs/xfs_mount.h
> > +++ b/fs/xfs/xfs_mount.h
> > @@ -233,7 +233,31 @@ typedef struct xfs_mount {
> >  						   allocator */
> >  #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
> >  
> > -#define XFS_MOUNT_DAX		(1ULL << 62)	/* TEST ONLY! */
> > +/* DAX flag is a 2 bit field representing a tri-state for dax
> > + *      iflag, always, never
> > + * We reserve/document the 2 bits using dax field/field2
> > + */
> > +#define XFS_DAX_FIELD_MASK 0x3ULL
> > +#define XFS_DAX_FIELD_SHIFT 62
> > +#define XFS_MOUNT_DAX_FIELD	(1ULL << 62)
> > +#define XFS_MOUNT_DAX_FIELD2	(1ULL << 63)
> > +
> > +enum {
> > +	XFS_DAX_IFLAG = 0,
> > +	XFS_DAX_ALWAYS = 1,
> > +	XFS_DAX_NEVER = 2,
> > +};
> > +
> > +static inline void xfs_mount_set_dax(struct xfs_mount *mp, u32 val)
> > +{
> > +	mp->m_flags &= ~(XFS_DAX_FIELD_MASK << XFS_DAX_FIELD_SHIFT);
> > +	mp->m_flags |= ((val & XFS_DAX_FIELD_MASK) << XFS_DAX_FIELD_SHIFT);
> > +}
> > +
> > +static inline u32 xfs_mount_dax_mode(struct xfs_mount *mp)
> > +{
> > +	return (mp->m_flags >> XFS_DAX_FIELD_SHIFT) & XFS_DAX_FIELD_MASK;
> > +}
> 
> This is overly complex. Just use 2 flags:

LOL...  I was afraid someone would say that.  At first I used 2 flags with
fsparam_string, but then I realized Darrick suggested fsparam_enum:

	"It would be handy if we could have a single fsparam_enum for figuring
	out the dax mount options."

	-- https://lore.kernel.org/lkml/20200403183746.GQ80283@magnolia/

So I changed it...

Darrick?

Ira

> 
> #define XFS_MOUNT_DAX_ALWAYS	(1ULL << 26)
> #define XFS_MOUNT_DAX_NEVER	(1ULL << 27)
> 
> and if no mount flag is set, we use the inode flag....
> 
> > @@ -59,7 +66,7 @@ enum {
> >  	Opt_filestreams, Opt_quota, Opt_noquota, Opt_usrquota, Opt_grpquota,
> >  	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
> >  	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
> > -	Opt_discard, Opt_nodiscard, Opt_dax,
> > +	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum,
> >  };
> >  
> >  static const struct fs_parameter_spec xfs_fs_parameters[] = {
> > @@ -103,6 +110,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
> >  	fsparam_flag("discard",		Opt_discard),
> >  	fsparam_flag("nodiscard",	Opt_nodiscard),
> >  	fsparam_flag("dax",		Opt_dax),
> > +	fsparam_enum("dax",		Opt_dax_enum, dax_param_enums),
> >  	{}
> >  };
> >  
> > @@ -129,7 +137,6 @@ xfs_fs_show_options(
> >  		{ XFS_MOUNT_GRPID,		",grpid" },
> >  		{ XFS_MOUNT_DISCARD,		",discard" },
> >  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> > -		{ XFS_MOUNT_DAX,		",dax" },
> +		{ XFS_MOUNT_DAX_ALWAYS,		",dax=always" },
> +		{ XFS_MOUNT_DAX_NEVER,		",dax=never" },
> 
> >  		{ 0, NULL }
> >  	};
> >  	struct xfs_mount	*mp = XFS_M(root->d_sb);
> > @@ -185,6 +192,20 @@ xfs_fs_show_options(
> >  	if (!(mp->m_qflags & XFS_ALL_QUOTA_ACCT))
> >  		seq_puts(m, ",noquota");
> >  
> > +	switch (xfs_mount_dax_mode(mp)) {
> > +		case XFS_DAX_IFLAG:
> > +			seq_puts(m, ",dax=iflag");
> > +			break;
> > +		case XFS_DAX_ALWAYS:
> > +			seq_puts(m, ",dax=always");
> > +			break;
> > +		case XFS_DAX_NEVER:
> > +			seq_puts(m, ",dax=never");
> > +			break;
> > +		default:
> > +			break;
> > +	}
> 
> 	if (!(mp->m_flags & (XFS_MOUNT_DAX_ALWAYS | XFS_MOUNT_DAX_NEVER))
> 		seq_puts(m, ",dax=iflag");
> 
> > +
> >  	return 0;
> >  }
> >  
> > @@ -1244,7 +1265,10 @@ xfs_fc_parse_param(
> >  		return 0;
> >  #ifdef CONFIG_FS_DAX
> >  	case Opt_dax:
> > -		mp->m_flags |= XFS_MOUNT_DAX;
> > +		xfs_mount_set_dax(mp, XFS_DAX_ALWAYS);
> > +		return 0;
> > +	case Opt_dax_enum:
> > +		xfs_mount_set_dax(mp, result.uint_32);
> >  		return 0;
> >  #endif
> >  	default:
> > @@ -1437,7 +1461,7 @@ xfs_fc_fill_super(
> >  	if (XFS_SB_VERSION_NUM(&mp->m_sb) == XFS_SB_VERSION_5)
> >  		sb->s_flags |= SB_I_VERSION;
> >  
> > -	if (mp->m_flags & XFS_MOUNT_DAX) {
> > +	if (xfs_mount_dax_mode(mp) == XFS_DAX_ALWAYS) {
> 
> 	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS) {
> 
> >  		bool rtdev_is_dax = false, datadev_is_dax;
> >  
> >  		xfs_warn(mp,
> > @@ -1451,7 +1475,7 @@ xfs_fc_fill_super(
> >  		if (!rtdev_is_dax && !datadev_is_dax) {
> >  			xfs_alert(mp,
> >  			"DAX unsupported by block device. Turning off DAX.");
> > -			mp->m_flags &= ~XFS_MOUNT_DAX;
> > +			xfs_mount_set_dax(mp, XFS_DAX_NEVER);
> >  		}
> >  		if (xfs_sb_version_hasreflink(&mp->m_sb)) {
> >  			xfs_alert(mp,
> > -- 
> > 2.25.1
> > 
> > 
> 
> -- 
> Dave Chinner
> david@fromorbit.com
