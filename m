Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9199E6F8CBB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 01:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjEEXSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 19:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjEEXSa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 19:18:30 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2192961AD
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 16:18:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6436e004954so2577959b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 16:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683328701; x=1685920701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6JdJ+eJduMN09JUXLpWhXffqEZ6RtqFZDIQ4YphdDr4=;
        b=fN52VrQ7ZpWuHFVHFUJ+eHUlTeN451tAxBJKGDPuPWHlQiXQ6bFkaqMh0YponY6aMM
         GsZnl2jCdzQAv2GeosJZ3YCJ0q5rKkATrphsTfuH4hULmkNEs8JtD6cPfa9XQwwMUJVz
         jIYwJCvUXu9EdsjkgeBXpvMq5p+qTQy+Pkl1oYGD5j+WBtTkk8GIQfubg7y5siG7o+Jq
         LSUL4ee/Okp4cx2ZT20NBTNqMiqU0tpxG/Ag7GQEBTeAWDF1JiRhz2yVxGKyo8WeKPHl
         AnLIQGaCj62addwpyPiPEn8Phjx3YB3KMT6bXxTvkmgP3RcL3r0GdvtX8NFGZxU3zmZs
         yIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683328701; x=1685920701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JdJ+eJduMN09JUXLpWhXffqEZ6RtqFZDIQ4YphdDr4=;
        b=Dxji85LjHeyWLy4emUiTsZqkf0CiwZ1eNSKpXw3oBKLCDQXtRx+qval0C92Zj8MvZV
         IfOeRfn5p5NyJlclZX8o/woCcdigAQq4WvvgaxwOH/6ZxrDh6EiT/aOxQu9TbEc2BRhB
         q4wLA1lBJjnXUiD8ysnI/mAuouNoB+AJst+92EsDaGoUEev8Yo0jkwLT99KedCwO5CFd
         OeXycLUgnh5/u2ZGren1qRX46ZSgkTkNrmwpcXm7J0SouXMHYa3xYhjLrD6aYyvKzuyn
         Ze9oF4vKDA2nsQLbtRiugIKbvbBqyedTmUSc5UT8L0uKTAacOPo2m7Ab6nsKb80g+uF6
         WtGA==
X-Gm-Message-State: AC+VfDwV3FDWZp79oEs2hkaC46gVESGeXjMQez6/0ng1doyLxVv0nxdC
        kKo3Y/nEuEfoHwoifRXBLro25g==
X-Google-Smtp-Source: ACHHUZ5wbQm6mg5RSVdxnCns5sa7KBO03F5e0cxzleqTCq4VGTZursfFF89+nfp5HQV/kBQ+XaN29g==
X-Received: by 2002:a05:6a00:ccb:b0:63d:315f:560f with SMTP id b11-20020a056a000ccb00b0063d315f560fmr4928040pfv.13.1683328701343;
        Fri, 05 May 2023 16:18:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id c11-20020aa78c0b000000b0063b86aff031sm2099823pfd.108.2023.05.05.16.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 16:18:20 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pv4gq-00BoxF-NI; Sat, 06 May 2023 09:18:16 +1000
Date:   Sat, 6 May 2023 09:18:16 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <20230505231816.GM3223426@dread.disaster.area>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-2-john.g.garry@oracle.com>
 <20230503213925.GD3223426@dread.disaster.area>
 <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
 <20230504222623.GI3223426@dread.disaster.area>
 <90522281-863f-58bf-9b26-675374c72cc7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90522281-863f-58bf-9b26-675374c72cc7@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 08:54:12AM +0100, John Garry wrote:
> On 04/05/2023 23:26, Dave Chinner wrote:
> 
> Hi Dave,
> 
> > > atomic_write_unit_max is largest application block size which we can
> > > support, while atomic_write_max_bytes is the max size of an atomic operation
> > > which the HW supports.
> > Why are these different? If the hardware supports 128kB atomic
> > writes, why limit applications to something smaller?
> 
> Two reasons:
> a. If you see patch 6/16, we need to apply a limit on atomic_write_unit_max
> from what is guaranteed we can fit in a bio without it being required to be
> split when submitted.

Yes, that's obvious behaviour for an atomic IO.

> Consider iomap generates an atomic write bio for a single userspace block
> and submits to the block layer - if the block layer needs to split due to
> block driver request_queue limits, like max_segments, then we're in trouble.
> So we need to limit atomic_write_unit_max such that this will not occur.
> That same limit should not apply to atomic_write_max_bytes.

Except the block layer doesn't provide any mechanism to do
REQ_ATOMIC IOs larger than atomic_write_unit_max. So in what case
will atomic_write_max_bytes > atomic_write_unit_max ever be
relevant to anyone?

> b. For NVMe, atomic_write_unit_max and atomic_write_max_bytes which the host
> reports will be the same (ignoring a.).
> 
> However for SCSI they may be different. SCSI has its own concept of boundary
> and it is relevant here. This is confusing as it is very different from NVMe
> boundary. NVMe is a media boundary really. For SCSI, a boundary is a
> sub-segment which the device may split an atomic write operation. For a SCSI
> device which only supports this boundary mode of operation, we limit
> atomic_write_unit_max to the max boundary segment size (such that we don't
> get splitting of an atomic write by the device) and then limit
> atomic_write_max_bytes to what is known in the spec as "maximum atomic
> transfer length with boundary". So in this device mode of operation,
> atomic_write_max_bytes and atomic_write_unit_max should be different.

But if the application is limited to atomic_write_unit_max sized
IOs, and that is always less than or equal to the size of the atomic
write boundary, why does the block layer even need to care about
this whacky quirk of the SCSI protocol implementation?

The block layer shouldn't even need to be aware that SCSI can split
"atomic" IOs into smaller individual IOs that result in the larger
requested IO being non-atomic. the SCSI layer should just expose 
"write with boundary" as the max atomic IO size it supports to the
block layer. 

At this point, both atomic_write_max_bytes and atomic write
boundary size are completely irrelevant to anything in the block
layer or above. If usrespace is limited to atomic_write_unit_max IO
sizes and it is enforced at the ->write_iter() layer, then the block
layer will never need to split REQ_ATOMIC bios because the entire
stack has already stated that it guarantees atomic_write_unit_max
bios will not get split....

In what cases does hardware that supports atomic_write_max_bytes >
atomic_write_unit_max actually be useful? I can see one situation,
and one situation only: merging adjacent small REQ_ATOMIC write
requests into single larger IOs before issuing them to the hardware.

This is exactly the sort of optimisation the block layers should be
doing - it fits perfectly with the SCSI "write with boundary"
behaviour - the merged bios can be split by the hardware at the
point where they were merged by the block layer, and everything is
fine because the are independent IOs, not a single RWF_ATOMIC IO
from userspace. And for NVMe, it allows IOs from small atomic write
limits (because, say, 16kB RAID stripe unit) to be merged into
larger atomic IOs with no penalty...


> > >  From your review on the iomap patch, I assume that now you realise that we
> > > are proposing a write which may include multiple application data blocks
> > > (each limited in size to atomic_write_unit_max), and the limit in total size
> > > of that write is atomic_write_max_bytes.
> > I still don't get it - you haven't explained why/what an application
> > atomic block write might be, nor why the block device should be
> > determining the size of application data blocks, etc.  If the block
> > device can do 128kB atomic writes, why wouldn't the device allow the
> > application to do 128kB atomic writes if they've aligned the atomic
> > write correctly?
> 
> An application block needs to be:
> - sized at a power-of-two
> - sized between atomic_write_unit_min and atomic_write_unit_max, inclusive
> - naturally aligned
> 
> Please consider that the application does not explicitly tell the kernel the
> size of its data blocks, it's implied from the size of the write and file
> offset. So, assuming that userspace follows the rules properly when issuing
> a write, the kernel may deduce the application block size and ensure only
> that each individual user data block is not split.

That's just *gross*. The kernel has no business assuming anything
about the data layout inside an IO request. The kernel cannot assume
that the application uses a single IO size for atomic writes when it
expicitly provides a range of IO sizes that the application can use.

e.g. min unit = 4kB, max unit = 128kB allows IO sizes of 4kB, 8kiB,
16kiB, 32kB, 64kB and 128kB. How does the kernel infer what that
application data block size is based on a 32kB atomic write vs a
128kB atomic write?

The kernel can't use file offset alignment to infer application
block size, either. e.g. a 16kB write at 128kB could be a single
16kB data block, it could be 2x8kB data blocks, or it could be 4x4kB
data blocks - they all follow the rules you set above. So how does
the kernel know that for two of these cases it is safe to split the
IO at 8kB, and for one it isn't safe at all?

AFAICS, there is no way the kernel can accurately derive this sort
of information, so any assumptions that the "kernel can infer the
application data layout" to split IOs correctly simply won't work.
And that very important because we are talking about operations that
provide data persistence guarantees....

> If userspace wants a guarantee of no splitting of all in its write, then it
> may issue a write for a single userspace data block, e.g. userspace block
> size is 16KB, then write at a file offset aligned to 16KB and a total write
> size of 16KB will be guaranteed to be written atomically by the device.

Exactly what has "userspace block size" got to do with the kernel
providing a guarantee that a RWF_ATOMIC write of a 16kB buffer at
offset 16kB will be written atomically?

> > What happens we we get hardware that can do atomic writes at any
> > alignment, of any size up to atomic_write_max_bytes? Because this
> > interface defines atomic writes as "must be a multiple of 2 of
> > atomic_write_unit_min" then hardware that can do atomic writes of
> > any size can not be effectively utilised by this interface....
> > 
> > > user applications should only pay attention to what we return from statx,
> > > that being atomic_write_unit_min and atomic_write_unit_max.
> > > 
> > > atomic_write_max_bytes and atomic_write_boundary is only relevant to the
> > > block layer.
> > If applications can issue an multi-atomic_write_unit_max-block
> > writes as a single, non-atomic, multi-bio RWF_ATOMIC pwritev2() IO
> > and such IO is constrainted to atomic_write_max_bytes, then
> > atomic_write_max_bytes is most definitely relevant to user
> > applications.
> 
> But we still do not guarantee that multi-atomic_write_unit_max-block writes
> as a single, non-atomic, multi-bio RWF_ATOMIC pwritev2() IO and such IO is
> constrained to atomic_write_max_bytes will be written atomically by the
> device.
>
> Three things may happen in the kernel:
> - we may need to split due to atomic boundary

Block layer rejects the IO - cannot be performed atomically.

> - we may need to split due to the write spanning discontig extents

Filesystem rejects the IO - cannot be performed atomically.

> - atomic_write_max_bytes may be much larger than what we could fit in a bio,
> so may need multiple bios

Filesystem/blockdev rejects the IO - cannot be performed atomically.

> And maybe more which does not come to mind.

Relevant layer rejects the IO - cannot be performed atomically.

> So I am not sure what value there is in reporting atomic_write_max_bytes to
> the user. The description would need to be something like "we guarantee that
> if the total write length is greater than atomic_write_max_bytes, then all
> data will never be submitted to the device atomically. Otherwise it might
> be".

Exactly my point - there's a change of guarantee that the kernel
provides userspace at that point, and hence application developers
need to know it exists and, likely, be able to discover that
threshold programatically.

But this, to me, is a just another symptom of what I see as the
wider issue here: trying to allow RWF_ATOMIC IO to do more than a
*single atomic IO*.

This reeks of premature API optimisation. We should be make
RWF_ATOMIC do one thing, and one thing only: guaranteed single
atomic IO submission.

It doesn't matter what data userspace is trying to write atomically;
it only matters that the kernel submits the write as a single atomic
unit to the hardware which then guarantees that it completes the
whole IO as a single atomic unit.

What functionality the hardware can provide is largely irrelevant
here; it's the IO semantics that we guarantee userspace that matter.
The kernel interface needs to have simple, well defined behaviour
and provide clear data persistence guarantees.

Once we have that, we can optimise both the applications and the
kernel implementation around that behaviour and guarantees. e.g.
adjacent IO merging (either in the application or in the block
layer), using AIO/io_uring with completion to submission ordering,
etc.

There are many well known IO optimisation techniques that do not
require the kernel to infer or assume the format of the data in the
user buffers as this current API does. May the API simple and hard
to get wrong first, then optimise from there....



> > We already have direct IO alignment and size constraints in statx(),
> > so why wouldn't we just reuse those variables when the user requests
> > atomic limits for DIO?
> > 
> > i.e. if STATX_DIOALIGN is set, we return normal DIO alignment
> > constraints. If STATX_DIOALIGN_ATOMIC is set, we return the atomic
> > DIO alignment requirements in those variables.....
> > 
> > Yes, we probably need the dio max size to be added to statx for
> > this. Historically speaking, I wanted statx to support this in the
> > first place because that's what we were already giving userspace
> > with XFS_IOC_DIOINFO and we already knew that atomic IO when it came
> > along would require a bound maximum IO size much smaller than normal
> > DIO limits.  i.e.:
> > 
> > struct dioattr {
> >          __u32           d_mem;          /* data buffer memory alignment */
> >          __u32           d_miniosz;      /* min xfer size                */
> >          __u32           d_maxiosz;      /* max xfer size                */
> > };
> > 
> > where d_miniosz defined the alignment and size constraints for DIOs.
> > 
> > If we simply document that STATX_DIOALIGN_ATOMIC returns minimum
> > (unit) atomic IO size and alignment in statx->dio_offset_align (as
> > per STATX_DIOALIGN) and the maximum atomic IO size in
> > statx->dio_max_iosize, then we don't burn up anywhere near as much
> > space in the statx structure....
> 
> ok, so you are saying to unionize them, right? That would seem reasonable to
> me.

No, I don't recommend unionising them. RWF_ATOMIC only applies to
direct IO, so if the application ask for ATOMIC DIO limits, we put
the atomic dio limits in the dio limits variables rather than the
looser non-atomic dio limits......

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
