Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2598267CFE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Sep 2020 02:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgIMAlG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 20:41:06 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39566 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbgIMAlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 20:41:05 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D4C2B82494D;
        Sun, 13 Sep 2020 10:40:58 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kHG4f-00043e-2w; Sun, 13 Sep 2020 10:40:57 +1000
Date:   Sun, 13 Sep 2020 10:40:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200913004057.GR12096@dread.disaster.area>
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=IuRgj43g c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=FjA90CxpgfuD18wm4a4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 10:59:40AM -0700, Linus Torvalds wrote:

[...]

> In particular, the page locking is often used for just verifying
> simple things, with the most common example being "lock page, check
> that the mapping is still valid, insert page into page tables, unlock
> page".
> 
> The reason the apache benchmark regresses is that it basically does a
> web server test with a single file ("test.html") that gets served by
> just mmap'ing it, and sending it out that way. Using lots of threads,
> and using lots of different mappings. So they *all* fault on the read
> of that page, and they *all* do that "lock page, check that the
> mapping is valid, insert page" dance.

Hmmmm. So this is a typically a truncate race check, but this isn't
sufficient to protect the fault against all page invalidation races
as the page can be re-inserted into the same mapping at a different
page->index now within EOF.

Hence filesystems that support hole punching have to serialise the
->fault path against the page invalidations done in ->fallocate
operations because they otherwise we get data corruption from the
mm/ truncate checks failing to detect invalidated pages within EOF
correctly.

i.e. truncate/hole punch is a multi-object modification operation,
with the typical atomicity boundary of the operation defined by the
inode_lock() and/or the filesystem transaction that makes the
modification. IOWs, page_lock() based truncation/invalidation checks
aren't atomic w.r.t. the other objects being modified in the same
operation. Truncate avoids this by the ordering the file size update
vs the page cache invalidation, but no such ordering protection can
be provided for ->fallocate() operations that directly manipulate
the metadata of user data in the file.

> Anyway, I don't have a great solution. I have a few options (roughly
> ordered by "simplest to most complex"):
> 
>  (a) just revert
>  (b) add some busy-spinning
>  (c) reader-writer page lock
>  (d) try to de-emphasize the page lock

....

> Option (d) is "we already have a locking in many filesystems that give
> us exclusion between faulting in a page, and the truncate/hole punch,
> so we shouldn't use the page lock at all".
>
> I do think that the locking that filesystems do is in many ways
> inferior - it's done on a per-inode basis rather than on a per-page
> basis. But if the filesystems end up doing that *anyway*, what's the
> advantage of the finer granularity one? And *because* the common case
> is all about the reading case, the bigger granularity tends to work
> very well in practice, and basically never sees contention.

*nod*

Given that:

1) we have been doing (d) for 5 years (see commit 653c60b633a ("xfs:
introduce mmap/truncate lock")),

2) ext4 also has this same functionality,

3) DAX requires the ability for filesystems to exclude page faults

4) it is a widely deployed and tested solution

5) filesystems will still need to be able to exclude page faults
over a file range while they directly manipulate file metadata to
change the user data in the file

> So I think option (c) is potentially technically better because it has
> smaller locking granularity, but in practice (d) might be easier and
> we already effectively do it for several filesystems.

Right.  Even if we go for (c), AFAICT we still need (d) because we
still (d) largely because of reason (5) above.  There are a whole
class of "page fault vs direct storage manipulation offload"
serialisation issues that filesystems have to consider (especially
if they want to support DAX), so if we can use that same mechanism
to knock a whole bunch of page locking out of the fault paths then
that seems like a win to me....

> Any other suggestions than those (a)-(d) ones above?

Not really - I've been advocating for (d) as the general mechanism
for truncate/holepunch exclusion for quite a few years now because
it largely seems to work with no obvious/apparent issues.

Just as a FWIW: I agree that the per-inode rwsem could be an issue
here, jsut as it is for the IO path.  As a side project I'm working
on shared/exclusive range locks for the XFS inode to replace the
rwsems for the XFS_IOLOCK_{SHARED,EXCL} and the
XFS_MMAPLOCK_{SHARED,EXCL}.

That will largely alleviate any problems that "per-inode rwsem"
serialisation migh cause us here - I've got the DIO fastpath down to
2 atomic operations per lock/unlock - it's with 10% of rwsems up to
approx. half a million concurrent DIO read/writes to the same inode.
Concurrent buffered read/write are not far behind direct IO until I
run out of CPU to copy data. None of this requires changes to
anything outside fs/xfs because everythign is already correctly serialised
to "atomic" filesystem operations and range locking preserves the
atomicity of those operations including all the page cache
operations done within them.

Hence I'd much prefer to be moving the page cache in a direction
that results in the page cache not having to care at all about
serialising against racing truncates, hole punches or anythign else
that runs page invalidation. That will make the page cache code
simpler, require less locking, and likely have less invalidation
related issues over time...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
