Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485C71A7245
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 06:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405104AbgDNEHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 00:07:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:40842 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405082AbgDNEHe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:07:34 -0400
IronPort-SDR: OpTEa9mE3gUxDvsb+RRrPAIXBsyQyqR8+Shg28zPsprOCdZQTKh1nc2QBIAHsZichd4/0DXrb8
 qN9IJoqmwCrg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 21:07:33 -0700
IronPort-SDR: 2H2UV6KoSEW+hWxOqHYq8ue1kc/E0rZQvQjwl8HWKchfLetHW6mOwNtowO0uaJ/+dCNzqF6pfz
 jZpot8UeQKZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="253077731"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga003.jf.intel.com with ESMTP; 13 Apr 2020 21:07:33 -0700
Date:   Mon, 13 Apr 2020 21:07:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 6/9] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200414040732.GF1649878@iweiny-DESK2.sc.intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-7-ira.weiny@intel.com>
 <20200413160138.GV6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413160138.GV6742@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 09:01:38AM -0700, Darrick J. Wong wrote:
> On Sun, Apr 12, 2020 at 10:40:43PM -0700, ira.weiny@intel.com wrote:

[snip]

> >  
> > -STATIC void
> > +void
> >  xfs_diflags_to_iflags(
> > -	struct inode		*inode,
> > -	struct xfs_inode	*ip)
> > +	struct xfs_inode	*ip,
> > +	bool init)
> >  {
> > -	uint16_t		flags = ip->i_d.di_flags;
> > -
> > -	inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC |
> > -			    S_NOATIME | S_DAX);
> > -
> > -	if (flags & XFS_DIFLAG_IMMUTABLE)
> > -		inode->i_flags |= S_IMMUTABLE;
> > -	if (flags & XFS_DIFLAG_APPEND)
> > -		inode->i_flags |= S_APPEND;
> > -	if (flags & XFS_DIFLAG_SYNC)
> > -		inode->i_flags |= S_SYNC;
> > -	if (flags & XFS_DIFLAG_NOATIME)
> > -		inode->i_flags |= S_NOATIME;
> > -	if (xfs_inode_enable_dax(ip))
> > -		inode->i_flags |= S_DAX;
> > +	struct inode            *inode = VFS_I(ip);
> > +	unsigned int            xflags = xfs_ip2xflags(ip);
> > +	unsigned int            flags = 0;
> > +
> > +	ASSERT(!(IS_DAX(inode) && init));
> > +
> > +	if (xflags & FS_XFLAG_IMMUTABLE)
> > +		flags |= S_IMMUTABLE;
> > +	if (xflags & FS_XFLAG_APPEND)
> > +		flags |= S_APPEND;
> > +	if (xflags & FS_XFLAG_SYNC)
> > +		flags |= S_SYNC;
> > +	if (xflags & FS_XFLAG_NOATIME)
> > +		flags |= S_NOATIME;
> > +	if (init && xfs_inode_enable_dax(ip))
> > +		flags |= S_DAX;
> > +
> > +	inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME);
> 
> I noticed that S_DAX drops out of the mask out operation here, which of
> course resulted in an eyebrow-raise because the other four flags are
> always set to whatever we just computed. :)
> 
> Then I realized that yes, this is intentional since we can't change
> S_DAX on the fly, and that S_DAX is never set i_flags on an inode that's
> being initialized so we don't need to mask off S_DAX ever.
> 
> Could we add a comment here to remind the reader that S_DAX is a bit
> special?
> 
> /*
>  * S_DAX can only be set during inode initialization and is never set by
>  * the VFS, so we cannot mask off S_DAX in i_flags.
>  */
> 
> With that added,
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Added that comment.

Thanks for the review!
Ira

> 
> --D
