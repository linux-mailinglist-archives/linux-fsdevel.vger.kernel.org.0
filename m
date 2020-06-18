Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9747B1FE93A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 05:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgFRDGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 23:06:14 -0400
Received: from [211.29.132.246] ([211.29.132.246]:57138 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726952AbgFRDGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 23:06:13 -0400
Received: from dread.disaster.area (unknown [49.180.124.177])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B8369821885;
        Thu, 18 Jun 2020 13:05:47 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jlkrz-0002Nn-SF; Thu, 18 Jun 2020 13:05:39 +1000
Date:   Thu, 18 Jun 2020 13:05:39 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200618030539.GH2005@dread.disaster.area>
References: <20200616202123.12656-1-msys.mizuma@gmail.com>
 <20200617080314.GA7147@infradead.org>
 <20200617155836.GD13815@fieldses.org>
 <24692989-2ee0-3dcc-16d8-aa436114f5fb@sandeen.net>
 <20200617172456.GP11245@magnolia>
 <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
 <20200617181816.GA18315@fieldses.org>
 <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
 <20200617184507.GB18315@fieldses.org>
 <20200618013026.ewnhvf64nb62k2yx@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618013026.ewnhvf64nb62k2yx@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8
        a=yHdZGDY2jtx0MHS2ggIA:9 a=aBMfwiDfj0bUOVTI:21 a=1xHCqXNt3GIuuEAb:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 09:30:26PM -0400, Masayoshi Mizuma wrote:
> On Wed, Jun 17, 2020 at 02:45:07PM -0400, J. Bruce Fields wrote:
> > On Wed, Jun 17, 2020 at 01:28:11PM -0500, Eric Sandeen wrote:
> > > but mount(8) has already exposed this interface:
> > > 
> > >        iversion
> > >               Every time the inode is modified, the i_version field will be incremented.
> > > 
> > >        noiversion
> > >               Do not increment the i_version inode field.
> > > 
> > > so now what?
> > 
> > It's not like anyone's actually depending on i_version *not* being
> > incremented.  (Can you even observe it from userspace other than over
> > NFS?)
> > 
> > So, just silently turn on the "iversion" behavior and ignore noiversion,
> > and I doubt you're going to break any real application.
> 
> I suppose it's probably good to remain the options for user compatibility,
> however, it seems that iversion and noiversiont are useful for
> only ext4.
> How about moving iversion and noiversion description on mount(8)
> to ext4 specific option?
> 
> And fixing the remount issue for XFS (maybe btrfs has the same
> issue as well)?
> For XFS like as:
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 379cbff438bc..2ddd634cfb0b 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1748,6 +1748,9 @@ xfs_fc_reconfigure(
>                         return error;
>         }
> 
> +       if (XFS_SB_VERSION_NUM(&mp->m_sb) == XFS_SB_VERSION_5)
> +               mp->m_super->s_flags |= SB_I_VERSION;
> +
>         return 0;
>  }

no this doesn't work, because the sueprblock flags are modified
after ->reconfigure is called.

i.e. reconfigure_super() does this:

	if (fc->ops->reconfigure) {
		retval = fc->ops->reconfigure(fc);
		if (retval) {
			if (!force)
				goto cancel_readonly;
			/* If forced remount, go ahead despite any errors */
			WARN(1, "forced remount of a %s fs returned %i\n",
			     sb->s_type->name, retval);
		}
	}

	WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
				 (fc->sb_flags & fc->sb_flags_mask)));

And it's the WRITE_ONCE() line that clears SB_I_VERSION out of
sb->s_flags. Hence adding it in ->reconfigure doesn't help.

What we actually want to do here in xfs_fc_reconfigure() is this:

	if (XFS_SB_VERSION_NUM(&mp->m_sb) == XFS_SB_VERSION_5)
		fc->sb_flags_mask |= SB_I_VERSION;

So that the SB_I_VERSION is not cleared from sb->s_flags.

I'll also note that btrfs will need the same fix, because it also
sets SB_I_VERSION unconditionally, as will any other filesystem that
does this, too.

Really, this is just indicative of the mess that the mount
flags vs superblock feature flags are. Filesystems can choose to
unconditionally support various superblock features, and no mount
option futzing from userspace should -ever- be able to change that
feature. Filesystems really do need to be able to override mount
options that were parsed in userspace and turned into a binary
flag...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
