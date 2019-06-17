Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF484956F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 00:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfFQWsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 18:48:19 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:42742 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbfFQWsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:48:19 -0400
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au [49.195.189.25])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 769BE3DC8C8;
        Tue, 18 Jun 2019 08:48:12 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hd0PC-0005cY-Ew; Tue, 18 Jun 2019 08:47:14 +1000
Date:   Tue, 18 Jun 2019 08:47:14 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: pagecache locking (was: bcachefs status update) merged)
Message-ID: <20190617224714.GR14363@dread.disaster.area>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel>
 <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel>
 <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel>
 <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
 <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=Z4Rwk6OoAAAA:8 a=7-415B0cAAAA:8 a=yB7Y4sE8DmJNDpec8TgA:9
        a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 14, 2019 at 06:01:07PM -1000, Linus Torvalds wrote:
> On Thu, Jun 13, 2019 at 5:08 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I do not believe that posix itself actually requires that at all,
> > although extended standards may.
> 
> So I tried to see if I could find what this perhaps alludes to.
> 
> And I suspect it's not in the read/write thing, but the pthreads side
> talks about atomicity.
>
> Interesting, but I doubt if that's actually really intentional, since
> the non-thread read/write behavior specifically seems to avoid the
> whole concurrency issue.

The wording of posix changes every time they release a new version
of the standard, and it's _never_ obvious what behaviour the
standard is actually meant to define. They are always written with
sufficient ambiguity and wiggle room that they could mean
_anything_. The POSIX 2017.1 standard you quoted is quite different
to older versions, but it's no less ambiguous...

> The pthreads atomicity thing seems to be about not splitting up IO and
> doing it in chunks when you have m:n threading models, but can be
> (mis-)construed to have threads given higher atomicity guarantees than
> processes.

Right, but regardless of the spec we have to consider that the
behaviour of XFS comes from it's Irix heritage (actually from EFS,
the predecessor of XFS from the late 1980s). i.e. the IO exclusion
model dates to long before POSIX had anything to say about pthreads,
and it's wording about atomicity could only refer to to
multi-process interactions.

These days, however, is the unfortunate reality of a long tail of
applications developed on other Unix systems under older POSIX
specifications that are still being ported to and deployed on Linux.
Hence the completely ambiguous behaviours defined in the older specs
are still just as important these days as the completely ambiguous
behaviours defined in the new specifications. :/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
