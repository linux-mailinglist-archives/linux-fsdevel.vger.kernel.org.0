Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2905F18247
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 00:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfEHWcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 18:32:01 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:36866 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbfEHWcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 18:32:01 -0400
Received: from dread.disaster.area (pa49-181-171-240.pa.nsw.optusnet.com.au [49.181.171.240])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B1B2243A37B;
        Thu,  9 May 2019 08:31:58 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hOV6T-0005Ym-2J; Thu, 09 May 2019 08:31:57 +1000
Date:   Thu, 9 May 2019 08:31:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Ric Wheeler <ricwheeler@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
Subject: Re: Testing devices for discard support properly
Message-ID: <20190508223157.GS1454@dread.disaster.area>
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507220449.GP1454@dread.disaster.area>
 <yq1ef58ly5j.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1ef58ly5j.fsf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=LhzQONXuMOhFZtk4TmSJIw==:117 a=LhzQONXuMOhFZtk4TmSJIw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=7-415B0cAAAA:8 a=3ZI2Ntb0NxUUy2vjhPgA:9 a=P0u-9IdFAXDTa2Fe:21
        a=AIsqQvJzzN8EsQi8:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 08, 2019 at 12:16:24PM -0400, Martin K. Petersen wrote:
> 
> Hi Dave,
> 
> > My big question here is this:
> >
> > - is "discard" even relevant for future devices?
> 
> It's hard to make predictions. Especially about the future. But discard
> is definitely relevant on a bunch of current drives across the entire
> spectrum from junk to enterprise. Depending on workload,
> over-provisioning, media type, etc.
> 
> Plus, as Ric pointed out, thin provisioning is also relevant. Different
> use case but exactly the same plumbing.
> 
> > IMO, trying to "optimise discard" is completely the wrong direction
> > to take. We should be getting rid of "discard" and it's interfaces
> > operations - deprecate the ioctls, fix all other kernel callers of
> > blkdev_issue_discard() to call blkdev_fallocate()
> 
> blkdev_fallocate() is implemented using blkdev_issue_discard().

Only when told to do PUNCH_HOLE|NO_HIDE_STALE which means "we don't
care what the device does" as this fallcoate command provides no
guarantees for the data returned by subsequent reads. It is,
esssentially, a get out of gaol free mechanism for indeterminate
device capabilities.

> > and ensure that drive vendors understand that they need to make
> > FALLOC_FL_ZERO_RANGE and FALLOC_FL_PUNCH_HOLE work, and that
> > FALLOC_FL_PUNCH_HOLE | FALLOC_FL_NO_HIDE_STALE is deprecated (like
> > discard) and will be going away.
> 
> Fast, cheap, easy. Pick any two.
> 
> The issue is that -- from the device perspective -- guaranteeing zeroes
> requires substantially more effort than deallocating blocks. To the

People used to make that assertion about filesystems, too. It took
linux filesystem developers years to realise that unwritten extents
are actually very simple and require very little extra code and no
extra space in metadata to implement. If you are already tracking
allocated blocks/space, then you're 99% of the way to efficient
management of logically zeroed disk space.

> point where several vendors have given up making it work altogether and
> either report no discard support or silently ignore discard requests
> causing you to waste queue slots for no good reason.

I call bullshit.

> So while instant zeroing of a 100TB drive would be nice, I don't think
> it's a realistic goal given the architectural limitations of many of
> these devices. Conceptually, you'd think it would be as easy as
> unlinking an inode.

Unlinking an inode is one of the most complex things a filesystem
has to do. Marking allocated space as "contains zeros" is trivial in
comparison.

> But in practice the devices keep much more (and
> different) state around in their FTLs than a filesystem does in its
> metadata.
> 
> Wrt. device command processing performance:
> 
> 1. Our expectation is that REQ_DISCARD (FL_PUNCH_HOLE |
>    FL_NO_HIDE_STALE), which gets translated into ATA DSM TRIM, NVMe
>    DEALLOCATE, SCSI UNMAP, executes in O(1) regardless of the number of
>    blocks operated on.
> 
>    Due to the ambiguity of ATA DSM TRIM and early SCSI we ended up in a
>    situation where the industry applied additional semantics
>    (deterministic zeroing) to that particular operation. And that has
>    caused grief because devices often end up in the O(n-or-worse) bucket
>    when determinism is a requirement.

Which is why I want us to deprecate the use of REQ_DISCARD.


> 2. Our expectation for the allocating REQ_ZEROOUT (FL_ZERO_RANGE), which
>    gets translated into NVMe WRITE ZEROES, SCSI WRITE SAME, is that the
>    command executes in O(n) but that it is faster -- or at least not
>    worse -- than doing a regular WRITE to the same block range.

You're missing the important requirement of fallocate(ZERO_RANGE):
that the space is also allocated and ENOSPC will never be returned
for subsequent writes to that range. i.e. it is allocated but
"unwritten" space that contains zeros.

> 3. Our expectation for the deallocating REQ_ZEROOUT (FL_PUNCH_HOLE),
>    which gets translated into ATA DSM TRIM w/ whitelist, NVMe WRITE
>    ZEROES w/ DEAC, SCSI WRITE SAME w/ UNMAP, is that the command will
>    execute in O(1) for any portion of the block range described by the

FL_PUNCH_HOLE has no O(1) requirement - it has a "all possible space
must be freed" requirement. The larger the range, to longer it will
take.

For example, punching out a range that contains a single extent
might take a couple of hundred microseconds on XFS, but punching out
a range that contains 50 million extents in a single operation (yes,
we see sparse vm image files with that sort of extreme fragmentation
in production systems) can take 5-10 minutes to run.

That is acceptable behaviour for a space deallocation operation.
Expecting space deallocation will always run on O(1) time is ...
insanity. If I were a device vendor being asked to do this, I'd be
saying no, too, because it's simply an unrealistic expectation.

If you're going to suggest any sort of performance guideline, then
O(log N) is the best we can expect for deallocation operations
(where N is the size of the range to be deallocated). This is
possible to implement without significant complexity or requiring
background cleanup and future IO latency impact.....

>    I/O that is aligned to and a multiple of the internal device
>    granularity. With an additional small O(n_head_LBs) + O(n_tail_LBs)
>    overhead for zeroing any LBs at the beginning and end of the block
>    range described by the I/O that do not comprise a full block wrt. the
>    internal device granularity.

That's expected, and exaclty what filesystems do for sub-block punch
and zeroing ranges.

> Does that description make sense?
> 
> The problem is that most vendors implement (3) using (1). But can't make
> it work well because (3) was -- and still is for ATA -- outside the
> scope of what the protocols can express.
> 
> And I agree with you that if (3) was implemented correctly in all
> devices, we wouldn't need (1) at all. At least not for devices with an
> internal granularity << total capacity.

What I'm saying is that we should be pushing standards to ensure (3)
is correctly standardise, certified and implemented because that is
what the "Linux OS" requires from future hardware.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
