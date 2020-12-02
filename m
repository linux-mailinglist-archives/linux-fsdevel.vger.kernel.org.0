Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DCA2CC63E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 20:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbgLBTJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 14:09:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:61679 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387903AbgLBTJE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:09:04 -0500
IronPort-SDR: dM0aalbomC9lGso5ntFj/HhyJzzmC65AYAdW5PXY9aMARhkwnsxcjmF8jFAaJcUKpNFUtLglyb
 mNLwDl5NE+Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="152896828"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="152896828"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 11:08:24 -0800
IronPort-SDR: Pn7PR1q2vyNNtb1xcBo84dZUOJATQ6hphYnIzz9KfetaopaxKskSh0JNaV0ixDi6BBEu5awPIP
 1MHWwYSK21Rw==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="539809156"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 11:08:23 -0800
Date:   Wed, 2 Dec 2020 11:08:23 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fstests@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Sandeen <sandeen@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [RFC PATCH] common/rc: Fix _check_s_dax() for kernel 5.10
Message-ID: <20201202190823.GV1161629@iweiny-DESK2.sc.intel.com>
References: <20201202160701.1458658-1-ira.weiny@intel.com>
 <b131a2a6-f02f-9a91-4de1-01a77b76577a@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b131a2a6-f02f-9a91-4de1-01a77b76577a@sandeen.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 11:10:50AM -0600, Eric Sandeen wrote:
> On 12/2/20 10:07 AM, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > There is a conflict with the user visible statx bits 'mount root' and
> > 'dax'.  The kernel is shifting the dax bit.[1]
> > 
> > Adjust _check_s_dax() to use the new bit.
> > 
> > [1] https://lore.kernel.org/lkml/3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com/
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > 
> > I'm not seeing an easy way to check for kernel version.  It seems like that is
> > the right thing to do.  So do I need to do that by hand or is that something
> > xfstests does not worry about?
> 
> xfstests gets used on distro kernels too, so relying on kernel version isn't
> really something we can use to make determinations like this, unfortunately.
> 
> Probably the best we can do is hope that the change makes it to stable and
> distro kernels quickly, and the old flag fades into obscurity.
> 
> Maybe worth a comment in the test mentioning the SNAFU, though, for anyone
> investigating it when it fails on older kernels?

Good idea.

> 
> > Ira
> > 
> > ---
> >  common/rc | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index b5a504e0dcb4..3d45e233954f 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3222,9 +3222,9 @@ _check_s_dax()
> >  
> >  	local attributes=$($XFS_IO_PROG -c 'statx -r' $target | awk '/stat.attributes / { print $3 }')
> >  	if [ $exp_s_dax -eq 0 ]; then
> > -		(( attributes & 0x2000 )) && echo "$target has unexpected S_DAX flag"
> > +		(( attributes & 0x00200000 )) && echo "$target has unexpected S_DAX flag"
> >  	else
> > -		(( attributes & 0x2000 )) || echo "$target doesn't have expected S_DAX flag"
> > +		(( attributes & 0x00200000 )) || echo "$target doesn't have expected S_DAX flag"
> 
> I suppose you could add a test for 0x2000 in this failure case, and echo "Is your kernel missing
> commit xxxxxx?" as another hint.

Yea, I think that is ok since the test should not be running on any root mount
points.

V2 will come after the patch is merged.

Ira
