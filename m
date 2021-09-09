Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A49404399
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 04:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhIICgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 22:36:17 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:56805 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231898AbhIICgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 22:36:16 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 3D13E8754F;
        Thu,  9 Sep 2021 12:35:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mO9ty-00AKHu-Pn; Thu, 09 Sep 2021 12:34:58 +1000
Date:   Thu, 9 Sep 2021 12:34:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Allison Henderson <allison.henderson@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [TOPIC LPC] Filesystem Shrink
Message-ID: <20210909023458.GG1756565@dread.disaster.area>
References: <3bffa6b2-981f-9a64-9fed-f211bfe501cd@oracle.com>
 <CAOQ4uxhAdLBFRXjJOA8G_7KYGv=mm5dWOpYX7-=TdahUwya26A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhAdLBFRXjJOA8G_7KYGv=mm5dWOpYX7-=TdahUwya26A@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=yPCof4ZbAAAA:8 a=7-415B0cAAAA:8
        a=8R0lDqu1h6eZj12aPt8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 08, 2021 at 08:31:24PM +0300, Amir Goldstein wrote:
> On Wed, Sep 8, 2021 at 10:51 AM Allison Henderson
> <allison.henderson@oracle.com> wrote:
> >
> > Hi All,
> >
> > Earlier this month I had sent out a lpc micro conference proposal for
> > file system shrink.  It sounds like the talk is of interest, but folks
> > recommended I forward the discussion to fsdevel for more feed back.
> > Below is the abstract for the talk:
> >
> >
> > File system shrink allows a file system to be reduced in size by some
> > specified size blocks as long as the file system has enough unallocated
> > space to do so.  This operation is currently unsupported in xfs.  Though
> > a file system can be backed up and recreated in smaller sizes, this is
> > not functionally the same as an in place resize.  Implementing this
> > feature is costly in terms of developer time and resources, so it is
> > important to consider the motivations to implement this feature.  This
> > talk would aim to discuss any user stories for this feature.  What are
> > the possible cases for a user needing to shrink the file system after
> > creation, and by how much?  Can these requirements be satisfied with a
> > simpler mkfs option to backup an existing file system into a new but
> > smaller filesystem?

That has been the traditional answer - create a new block device,
mkfs, xfsdump/xfs_restore and off you go. It has the benefit of only
needing to read/write data once, but has the downside that it does
not keep extent sharing information (reflink/dedupe) intact.

The problem I hear about most regularly these days is management of
cloudy stuff, where there aren't new block devices and/or storage
space available so this mechanism is not really available for use.
The ideal solution for these environments is sparse storage and
fstrim to free storage space that is unused by the filesystem and
that does not require shrink, but that seems difficult because
cloudy management interfaces don't seem to have a concept of
storage consumption vs assigned filesystem capacity....

> > In the cases of creating a rootfs, will a protofile
> > suffice?  If the shrink feature is needed, we should further discuss the
> > APIs that users would need.
> >
> > Beyond the user stories, it is also worth discussing implementation
> > challenges.  Reflink and parent pointers can assist in facilitating

"Reflink, reverse mapping and parent pointers"....

> > shrink operations, but is it reasonable to make them requirements for
> > shrink?

If the filesystem metadata is larger than what can be cached in
memory, then the only way of doing a performant shrink operation is
to have rmap (for GETFSMAP queries) and parent pointers (for path
name reconstruction).

Indeed, GETFSMAP is the only way we can find owners of all the
metadata in the AG that needs to be moved as some per-inode metadata
can be otherwise invisible to userspace (e.g. BMBT blocks).  Finding
such metadata without rmapbt support requires GETFSMAP to implement
a brute-force in-kernel used space scanner to identify such blocks
to report their owners. That's a lot of new code just to replicate
what rmapbt already does...

Really, though, userspace should just rely on having GETFSMAP tell
it everything that needs to move. Support for filesystems
that don't support rmapbt and require dumb, brute force searches to
provide the information can be added in future as they aren't
actually required to implement a working shrink algorithm.

As for reflink, it's been the default for a few years now, so making
shrink require it so that it can do atomic data movement in
userspace without any additional kernel support requirements doesn't
seem particularly bothersome to me...

> > Gathering feedback and addressing these challenges will help
> > guide future development efforts for this feature.
> >
> >
> > Comments and feedback are appreciated!
> > Thanks!
> >
> 
> Hi Allison,
> 
> That sounds like an interesting topic for discussion.
> It reminds me of a cool proposal that Dave posted a while back [1]
> about limiting the thin provisioned disk usage of xfs.

That's a different kettle of fish altogether - it allows for the
filesystem to grow and shrink logically, not physically, and has a
fundamental requirement for a sparse block device to decouple the
filesystem LBA from the physical storage LBAs. In the extreme,
the filesystem still needs a physical shrink operation if the user
requires the sparse device size to change....

> I imagine that online shrinking would involve limiting new block
> allocations to a certain blockdev offset (or AG) am I right?

Sort of.

We do need to limit new _user_ allocations (data and metadata) in
AGs that we are going to shrink away. We still need to be able
to atomically move data and metadata out of those AGs and that may
require allocation of new AG internal metadata to facilitate. e.g.
modifying freespace, rmaps, refcounts, etc can all require
allocation of new btree blocks in the offline AG.

> I wonder, how is statfs() going to present the available/free blocks
> information in that state?

No matter what we do, it will be "wrong" for someone.

In the current design, visible filesystem size does not change until
the final stage where the physical space is atomically removed via a
recoverable transaction.  There are several reasons for this, the
least of which is that turning off allocation is intended to be used
by more than just shrink. e.g AG could be offline for repair, etc.

As it is, ENOSPC can already happen when there is heaps of free
space available in the filesystem.  e.g. reflink copies can fail
ENOSPC because there isn't space in the AG for the new AG internal
refcount or rmap records to be recorded in the relevant AG btrees.

Indeed, the only way we are going to know if shrink cannot move all the
data out of the AGs we want to shrink away is to have all the other
AGs hit "AG full and no other allocation candidate" ENOSPC
conditions during data movement.

e.g. we start a shrink by checking if there's space available in the
lower AGs for all the data that needs to be moved (via
XFS_IOC_AG_GEOMETRY) so we know it should succeed. But if the user
starts consuming space after this check, there's every chance that
the shrink is going to fail because there is no longer enough space
available in the lower AGs to move all the data.

Changing what statfs() reports isn't going to fix/prevent problems
like this...

> If high blocks are presented as free then users may encounter
> surprising ENOSPC.
> If all high blocks are presented as used, then removing files
> in high space, won't free up available disk space.

Yup. And if you present them as used the userspace data movement
algorithm may not be able to make progress even when there is still
internal space available in the remaining AGs that could be used.

> There is an option to reduce total size and present the high blocks
> as over committed disk usage, but that is going to be weird...

Not to mention complex to account for and incredibly fragile to
maintain.

Of course, I haven't really even mentioned shrink failure semantics.
If the data movement fails because of a transient ENOSPC condition,
should the applications even be aware that a shrink was in progress?

> Have you spent any time considering these user visible
> implications?

An awful lot, in fact. Physically shrinking an active filesystem
cannot be done instantly, and so there are always going to be
situations where the behaviour we choose is going to be the wrong
choice for some user. Remember that the data movement part of a
physical shrink operation could take hours, days or even weeks to
complete; this is the dominating user visible implication of
physical shrinking...

The likelihood of a physical shrink failing is quite high - data
movement to empty physical space is not guaranteed to succeed.
There's all sorts of complexity around moving shared data extents
(reflink/deduped copies) that actually increase filesystem space
usage during a shrink (transient increase as well as permanent).
That can result in a shrink failing even though there's technically
enough free space in the lower AGs to complete the shrink...

So when you take into account the likelihood of failure, transient
ENOSPC conditions during a shrink, the heavy impact on performance
the data movement will have, the difficulty in doing atomic
relocation on actively modified files and directories, etc, the
answer to all these problems is "don't run shrink on production
filesystems". i.e "Online" only means the filesystem is mounted
while the shrink runs, not that it's something you run in
production...

With that in mind, worrying about how applications react to shrink
changing the allocation patterns and the amount of space available
is pretty much the least of my concerns at this point in time...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
