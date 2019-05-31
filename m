Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 084EC31750
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2019 00:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEaWp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 18:45:56 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:51380 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbfEaWp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 18:45:56 -0400
Received: from dread.disaster.area (pa49-180-144-61.pa.nsw.optusnet.com.au [49.180.144.61])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id C77533DCAFB;
        Sat,  1 Jun 2019 08:45:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hWqHV-0000lu-7s; Sat, 01 Jun 2019 08:45:49 +1000
Date:   Sat, 1 Jun 2019 08:45:49 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC][PATCH] link.2: AT_ATOMIC_DATA and AT_ATOMIC_METADATA
Message-ID: <20190531224549.GF29573@dread.disaster.area>
References: <20190527172655.9287-1-amir73il@gmail.com>
 <20190528202659.GA12412@mit.edu>
 <CAOQ4uxgo5jmwQbLAKQre9=7pLQw=CwMgDaWPaJxi-5NGnPEVPQ@mail.gmail.com>
 <CAOQ4uxgj94WR82iHE4PDGSD0UDxG5sCtr+Sv+t1sOHHmnXFYzQ@mail.gmail.com>
 <20190531164136.GA3066@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531164136.GA3066@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=8RU0RCro9O0HS2ezTvitPg==:117 a=8RU0RCro9O0HS2ezTvitPg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=zFZ6myeN1Ekg2b9OktAA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 31, 2019 at 12:41:36PM -0400, Theodore Ts'o wrote:
> On Fri, May 31, 2019 at 06:21:45PM +0300, Amir Goldstein wrote:
> > What do you think of:
> > 
> > "AT_ATOMIC_DATA (since Linux 5.x)
> > A filesystem which accepts this flag will guarantee that if the linked file
> > name exists after a system crash, then all of the data written to the file
> > and all of the file's metadata at the time of the linkat(2) call will be
> > visible.
> 
> ".... will be visible after the the file system is remounted".  (Never
> hurts to be explicit.)
> 
> > The way to achieve this guarantee on old kernels is to call fsync (2)
> > before linking the file, but doing so will also results in flushing of
> > volatile disk caches.
> >
> > A filesystem which accepts this flag does NOT
> > guarantee that any of the file hardlinks will exist after a system crash,
> > nor that the last observed value of st_nlink (see stat (2)) will persist."
> > 
> 
> This is I think more precise:
> 
>     This guarantee can be achieved by calling fsync(2) before linking
>     the file, but there may be more performant ways to provide these
>     semantics.  In particular, note that the use of the AT_ATOMIC_DATA
>     flag does *not* guarantee that the new link created by linkat(2)
>     will be persisted after a crash.

So here's the *implementation* problem I see with this definition of
AT_ATOMIC_DATA. After linkat(dirfd, name, AT_ATOMIC_DATA), there is
no guarantee that the data is on disk or that the link is present.

However:

	linkat(dirfd, name, AT_ATOMIC_DATA);
	fsync(dirfd);

Suddenly changes all that.

i.e. when we fsync(dirfd) we guarantee that "name" is present in the
directory and because we used AT_ATOMIC_DATA it implies that the
data pointed to by "name" must be present on disk. IOWs, what was
once a pure directory sync operation now *must* fsync all the child
inodes that have been linkat(AT_ATOMIC_DATA) since the last time the
direct has been made stable. 

IOWs, the described AT_ATOMIC_DATA "we don't have to write the data
during linkat() go-fast-get-out-of-gaol-free" behaviour isn't worth
the pixels it is written on - it just moves all the complexity to
directory fsync, and that's /already/ a behavioural minefield.

IMO, the "work-around" of forcing filesystems to write back
destination inodes during a link() operation is just nasty and will
just end up with really weird performance anomalies occurring in
production systems. That's not really a solution, either, especially
as it is far, far faster for applications to use AIO_FSYNC and then
on the completion callback run a normal linkat() operation...

Hence, if I've understood these correctly, then I'll be recommending
that XFS follows this:

> We should also document that a file system which does not implement
> this flag MUST return EINVAL if it is passed this flag to linkat(2).

and returns -EINVAL to these flags because we do not have the change
tracking infrastructure to handle these directory fsync semantics.
I also suspect that, even if we could track this efficiently, we
can't do the flushing atomically because of locking order
constraints between directories, regular files, pages in the page
cache, etc.

Given that we can already use AIO to provide this sort of ordering,
and AIO is vastly faster than synchronous IO, I don't see any point
in adding complex barrier interfaces that can be /easily implemented
in userspace/ using existing AIO primitives. You should start
thinking about expanding libaio with stuff like
"link_after_fdatasync()" and suddenly the whole problem of
filesystem data vs metadata ordering goes away because the
application directly controls all ordering without blocking and
doesn't need to care what the filesystem under it does....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
