Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80785200064
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 04:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgFSCpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 22:45:25 -0400
Received: from [211.29.132.246] ([211.29.132.246]:35947 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbgFSCpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 22:45:25 -0400
Received: from dread.disaster.area (unknown [49.180.124.177])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 55C568236D9;
        Fri, 19 Jun 2020 12:44:58 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jm71T-0002Jl-8d; Fri, 19 Jun 2020 12:44:55 +1000
Date:   Fri, 19 Jun 2020 12:44:55 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>, jlayton@redhat.com
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200619024455.GN2005@dread.disaster.area>
References: <20200617172456.GP11245@magnolia>
 <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
 <20200617181816.GA18315@fieldses.org>
 <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
 <20200617184507.GB18315@fieldses.org>
 <20200618013026.ewnhvf64nb62k2yx@gabell>
 <20200618030539.GH2005@dread.disaster.area>
 <20200618034535.h5ho7pd4eilpbj3f@gabell>
 <20200618223948.GI2005@dread.disaster.area>
 <20200619022005.GA25414@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619022005.GA25414@fieldses.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
        a=7-415B0cAAAA:8 a=Ddvq-uZmtdYEE3EvMV8A:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 10:20:05PM -0400, J. Bruce Fields wrote:
> On Fri, Jun 19, 2020 at 08:39:48AM +1000, Dave Chinner wrote:
> > On Wed, Jun 17, 2020 at 11:45:35PM -0400, Masayoshi Mizuma wrote:
> > > Thank you for pointed it out.
> > > How about following change? I believe it works both xfs and btrfs...
> > > 
> > > diff --git a/fs/super.c b/fs/super.c
> > > index b0a511bef4a0..42fc6334d384 100644
> > > --- a/fs/super.c
> > > +++ b/fs/super.c
> > > @@ -973,6 +973,9 @@ int reconfigure_super(struct fs_context *fc)
> > >                 }
> > >         }
> > > 
> > > +       if (sb->s_flags & SB_I_VERSION)
> > > +               fc->sb_flags |= MS_I_VERSION;
> > > +
> > >         WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
> > >                                  (fc->sb_flags & fc->sb_flags_mask)));
> > >         /* Needs to be ordered wrt mnt_is_readonly() */
> > 
> > This will prevent SB_I_VERSION from being turned off at all. That
> > will break existing filesystems that allow SB_I_VERSION to be turned
> > off on remount, such as ext4.
> > 
> > The manipulations here need to be in the filesystem specific code;
> > we screwed this one up so badly there is no "one size fits all"
> > behaviour that we can implement in the generic code...
> 
> My memory was that after Jeff Layton's i_version patches, there wasn't
> really a significant performance hit any more, so the ability to turn it
> off is no longer useful.

Yes, I completely agree with you here. However, with some
filesystems allowing it to be turned off, we can't just wave our
hands and force enable the option. Those filesystems - if the
maintainers chose to always enable iversion - will have to go
through a mount option deprecation period before permanently
enabling it.

> But looking back through Jeff's postings, I don't see him claiming that;
> e.g. in:
> 
> 	https://lore.kernel.org/lkml/20171222120556.7435-1-jlayton@kernel.org/
> 	https://lore.kernel.org/linux-nfs/20180109141059.25929-1-jlayton@kernel.org/
> 	https://lore.kernel.org/linux-nfs/1517228795.5965.24.camel@redhat.com/
> 
> he reports comparing old iversion behavior to new iversion behavior, but
> not new iversion behavior to new noiversion behavior.

Yeah, it's had to compare noiversion behaviour on filesystems where
it was understood that it couldn't actually be turned off. And,
realistically, the comaprison to noiversion wasn't really relevant
to the problem Jeff's patchset was addressing...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
