Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 478884C3CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 00:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfFSWjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 18:39:01 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:40621 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbfFSWjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 18:39:01 -0400
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au [49.195.189.25])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EA85710D6E8;
        Thu, 20 Jun 2019 08:38:53 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hdjDI-0006Wo-4u; Thu, 20 Jun 2019 08:37:56 +1000
Date:   Thu, 20 Jun 2019 08:37:56 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: pagecache locking (was: bcachefs status update) merged)
Message-ID: <20190619223756.GC26375@dread.disaster.area>
References: <20190612162144.GA7619@kmo-pixel>
 <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel>
 <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
 <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
 <20190617224714.GR14363@dread.disaster.area>
 <CAHk-=wiR3a7+b0cUN45hGp1dvFh=s1i1OkVhoP7CivJxKqsLFQ@mail.gmail.com>
 <CAOQ4uxjqQjrCCt=ixgdUYjBJvKLhw4R9NeMZOB_s2rrWvoDMBw@mail.gmail.com>
 <20190619103838.GB32409@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619103838.GB32409@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=HMxRdiQgvCmKICatF68A:9 a=eZ04ofshWOP32MK1:21
        a=slHfbUhONS5Q4bjw:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 19, 2019 at 12:38:38PM +0200, Jan Kara wrote:
> On Tue 18-06-19 07:21:56, Amir Goldstein wrote:
> > > > Right, but regardless of the spec we have to consider that the
> > > > behaviour of XFS comes from it's Irix heritage (actually from EFS,
> > > > the predecessor of XFS from the late 1980s)
> > >
> > > Sure. And as I mentioned, I think it's technically the nicer guarantee.
> > >
> > > That said, it's a pretty *expensive* guarantee. It's one that you
> > > yourself are not willing to give for O_DIRECT IO.
> > >
> > > And it's not a guarantee that Linux has ever had. In fact, it's not
> > > even something I've ever seen anybody ever depend on.
> > >
> > > I agree that it's possible that some app out there might depend on
> > > that kind of guarantee, but I also suspect it's much much more likely
> > > that it's the other way around: XFS is being unnecessarily strict,
> > > because everybody is testing against filesystems that don't actually
> > > give the total atomicity guarantees.
> > >
> > > Nobody develops for other unixes any more (and nobody really ever did
> > > it by reading standards papers - even if they had been very explicit).
> > >
> > > And honestly, the only people who really do threaded accesses to the same file
> > >
> > >  (a) don't want that guarantee in the first place
> > >
> > >  (b) are likely to use direct-io that apparently doesn't give that
> > > atomicity guarantee even on xfs
> > >
> > > so I do think it's moot.
> > >
> > > End result: if we had a really cheap range lock, I think it would be a
> > > good idea to use it (for the whole QoI implementation), but for
> > > practical reasons it's likely better to just stick to the current lack
> > > of serialization because it performs better and nobody really seems to
> > > want anything else anyway.
> > >
> > 
> > This is the point in the conversation where somebody usually steps in
> > and says "let the user/distro decide". Distro maintainers are in a much
> > better position to take the risk of breaking hypothetical applications.
> > 
> > I should point out that even if "strict atomic rw" behavior is desired, then
> > page cache warmup [1] significantly improves performance.
> > Having mentioned that, the discussion can now return to what is the
> > preferred way to solve the punch hole vs. page cache add race.
> > 
> > XFS may end up with special tailored range locks, which beings some
> > other benefits to XFS, but all filesystems need the solution for the punch
> > hole vs. page cache add race.
> > Jan recently took a stab at it for ext4 [2], but that didn't work out.
> 
> Yes, but I have idea how to fix it. I just need to push acquiring ext4's
> i_mmap_sem down a bit further so that only page cache filling is protected
> by it but not copying of data out to userspace. But I didn't get to coding
> it last week due to other stuff.
> 
> > So I wonder what everyone thinks about Kent's page add lock as the
> > solution to the problem.
> > Allegedly, all filesystems (XFS included) are potentially exposed to
> > stale data exposure/data corruption.
> 
> When we first realized that hole-punching vs page faults races are an issue I
> was looking into a generic solution but at that time there was a sentiment
> against adding another rwsem to struct address_space (or inode) so we ended
> up with a private lock in ext4 (i_mmap_rwsem), XFS (I_MMAPLOCK), and other
> filesystems these days. If people think that growing struct inode for
> everybody is OK, we can think about lifting private filesystem solutions
> into a generic one. I'm fine with that.

I'd prefer it doesn't get lifted to the VFS because I'm planning on
getting rid of it in XFS with range locks. i.e. the XFS_MMAPLOCK is
likely to go away in the near term because a range lock can be
taken on either side of the mmap_sem in the page fault path.

> That being said as Dave said we use those fs-private locks also for
> serializing against equivalent issues arising for DAX. So the problem is
> not only about page cache but generally about doing IO and caching
> block mapping information for a file range. So the solution should not be
> too tied to page cache.

Yup, that was the point I was trying to make when Linus started
shouting at me about how caches work and how essential they are.  I
guess the fact that DAX doesn't use the page cache isn't as widely
known as I assumed it was...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
