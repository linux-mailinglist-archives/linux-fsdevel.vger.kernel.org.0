Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46DA2181D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfEHV6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 17:58:37 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:42200 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726837AbfEHV6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 17:58:37 -0400
Received: from dread.disaster.area (pa49-181-171-240.pa.nsw.optusnet.com.au [49.181.171.240])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id F37BBC927;
        Thu,  9 May 2019 07:58:32 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hOUa8-0005Mv-Ex; Thu, 09 May 2019 07:58:32 +1000
Date:   Thu, 9 May 2019 07:58:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ric Wheeler <ricwheeler@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
Subject: Re: Testing devices for discard support properly
Message-ID: <20190508215832.GR1454@dread.disaster.area>
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507220449.GP1454@dread.disaster.area>
 <a409b3d1-960b-84a4-1b8d-1822c305ea18@gmail.com>
 <20190508011407.GQ1454@dread.disaster.area>
 <13b63de0-18bc-eb24-63b4-3c69c6a007b3@gmail.com>
 <yq1a7fwlvzb.fsf@oracle.com>
 <0a16285c-545a-e94a-c733-bcc3d4556557@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a16285c-545a-e94a-c733-bcc3d4556557@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=LhzQONXuMOhFZtk4TmSJIw==:117 a=LhzQONXuMOhFZtk4TmSJIw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=7-415B0cAAAA:8 a=P-JoTcFpvW-QmwlPBo0A:9 a=Hlrat0HlZ4lAMFzh:21
        a=eYFAa6E9YxbT3pTG:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 08, 2019 at 01:09:03PM -0400, Ric Wheeler wrote:
> 
> On 5/8/19 1:03 PM, Martin K. Petersen wrote:
> > Ric,
> > 
> > > That all makes sense, but I think it is orthogonal in large part to
> > > the need to get a good way to measure performance.
> > There are two parts to the performance puzzle:
> > 
> >   1. How does mixing discards/zeroouts with regular reads and writes
> >      affect system performance?
> > 
> >   2. How does issuing discards affect the tail latency of the device for
> >      a given workload? Is it worth it?
> > 
> > Providing tooling for (1) is feasible whereas (2) is highly
> > workload-specific. So unless we can make the cost of (1) negligible,
> > we'll have to defer (2) to the user.
> 
> Agree, but I think that there is also a base level performance question -
> how does the discard/zero perform by itself.
> 
> Specifically, we have had to punt the discard of a whole block device before
> mkfs (back at RH) since it tripped up a significant number of devices.
> Similar pain for small discards (say one fs page) - is it too slow to do?

Small discards are already skipped is the device indicates it has
a minumum discard granularity. This is another reason why the "-o
discard" mount option isn't sufficient by itself and fstrim is still
required - filesystems often only free small isolated chunks of
space at a time and hence never may send discards to the device.

> > > For SCSI, I think the "WRITE_SAME" command *might* do discard
> > > internally or just might end up re-writing large regions of slow,
> > > spinning drives so I think it is less interesting.
> > WRITE SAME has an UNMAP flag that tells the device to deallocate, if
> > possible. The results are deterministic (unlike the UNMAP command).

That's kinda what I'm getting at here - we need to define the
behaviour the OS provides users, and then ensure that the behaviour
is standardised correctly so that devices behave correctly. i.e.  we
want devices to support WRITE_SAME w/ UNMAP flag well (because
that's an exact representation of FALLOC_FL_PUNCH_HOLE
requirements), and don't really care about the UNMAP command.

> > WRITE SAME also has an ANCHOR flag which provides a use case we
> > currently don't have fallocate plumbing for: Allocating blocks without
> > caring about their contents. I.e. the blocks described by the I/O are
> > locked down to prevent ENOSPC for future writes.

So WRITE_SAME (0) with an ANCHOR flag does not return zeroes on
subsequent reads? i.e. it is effectively
fallocate(FALLOC_FL_NO_HIDE_STALE) preallocation semantics?

For many use cases cases we actually want zeroed space to be
guaranteed so we don't expose stale data from previous device use
into the new user's visibility - can that be done with WRITE_SAME
and the ANCHOR flag?

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
