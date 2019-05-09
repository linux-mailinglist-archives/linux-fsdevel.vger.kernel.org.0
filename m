Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19A218412
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 05:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfEIDUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 23:20:49 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:44559 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbfEIDUt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 23:20:49 -0400
Received: from dread.disaster.area (pa49-181-171-240.pa.nsw.optusnet.com.au [49.181.171.240])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 801B2438D3B;
        Thu,  9 May 2019 13:20:45 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hOZbw-0007CE-7S; Thu, 09 May 2019 13:20:44 +1000
Date:   Thu, 9 May 2019 13:20:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Ric Wheeler <ricwheeler@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
Subject: Re: Testing devices for discard support properly
Message-ID: <20190509032044.GW1454@dread.disaster.area>
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507220449.GP1454@dread.disaster.area>
 <a409b3d1-960b-84a4-1b8d-1822c305ea18@gmail.com>
 <20190508011407.GQ1454@dread.disaster.area>
 <13b63de0-18bc-eb24-63b4-3c69c6a007b3@gmail.com>
 <yq1a7fwlvzb.fsf@oracle.com>
 <0a16285c-545a-e94a-c733-bcc3d4556557@gmail.com>
 <20190508215832.GR1454@dread.disaster.area>
 <yq1lfzgicn6.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1lfzgicn6.fsf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=LhzQONXuMOhFZtk4TmSJIw==:117 a=LhzQONXuMOhFZtk4TmSJIw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=7-415B0cAAAA:8 a=ZpXykw6QandueLHp6qYA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 08, 2019 at 10:29:17PM -0400, Martin K. Petersen wrote:
> 
> Dave,
> 
> >> > WRITE SAME also has an ANCHOR flag which provides a use case we
> >> > currently don't have fallocate plumbing for: Allocating blocks without
> >> > caring about their contents. I.e. the blocks described by the I/O are
> >> > locked down to prevent ENOSPC for future writes.
> >
> > So WRITE_SAME (0) with an ANCHOR flag does not return zeroes on
> > subsequent reads? i.e. it is effectively
> > fallocate(FALLOC_FL_NO_HIDE_STALE) preallocation semantics?
> 
> The answer is that it depends. It can return zeroes or a device-specific
> initialization pattern (oh joy).

So they ignore the "write zeroes" part of the command?

And the standards allow that?

> > For many use cases cases we actually want zeroed space to be
> > guaranteed so we don't expose stale data from previous device use into
> > the new user's visibility - can that be done with WRITE_SAME and the
> > ANCHOR flag?
> 
> That's just a regular zeroout.
> 
> We have:
> 
>    Allocate and zero:	FALLOC_FL_ZERO_RANGE
>    Deallocate and zero:	FALLOC_FL_PUNCH_HOLE
>    Deallocate:		FALLOC_FL_PUNCH_HOLE | FALLOC_FL_NO_HIDE_STALE
> but are missing:
> 
>    Allocate:		FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE

So we've defined the fallocate flags to have /completely/ different
behaviour on block devices to filesystems.

<sigh>

We excel at screwing up APIs, don't we?

I give up, we've piled the shit too high on this one to dig it out
now....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
