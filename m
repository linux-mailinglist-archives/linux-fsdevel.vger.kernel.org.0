Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B644517AB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 01:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiEBX0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 19:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiEBXYM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 19:24:12 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41BEE63CB;
        Mon,  2 May 2022 16:20:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 71A01534701;
        Tue,  3 May 2022 09:20:38 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nlfLH-007IoG-TM; Tue, 03 May 2022 09:20:35 +1000
Date:   Tue, 3 May 2022 09:20:35 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        nitheshshetty@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Message-ID: <20220502232035.GE1360180@dread.disaster.area>
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
 <20220502040951.GC1360180@dread.disaster.area>
 <46e95412-9a79-51f8-3d52-caed4875d41f@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46e95412-9a79-51f8-3d52-caed4875d41f@opensource.wdc.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62706747
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=kuBEN3JhnRn9nEiEWMwA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 02, 2022 at 09:54:55PM +0900, Damien Le Moal wrote:
> On 2022/05/02 13:09, Dave Chinner wrote:
> > On Wed, Apr 27, 2022 at 06:19:51PM +0530, Nitesh Shetty wrote:
> >> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
> >>> On 4/26/22 19:12, Nitesh Shetty wrote:
> >>>> The patch series covers the points discussed in November 2021 virtual call
> >>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> >>>> We have covered the Initial agreed requirements in this patchset.
> >>>> Patchset borrows Mikulas's token based approach for 2 bdev
> >>>> implementation.
> >>>>
> >>>> Overall series supports –
> >>>>
> >>>> 1. Driver
> >>>> - NVMe Copy command (single NS), including support in nvme-target (for
> >>>>     block and file backend)
> >>>
> >>> It would also be nice to have copy offload emulation in null_blk for testing.
> >>>
> >>
> >> We can plan this in next phase of copy support, once this series settles down.
> > 
> > Why not just hook the loopback driver up to copy_file_range() so
> > that the backend filesystem can just reflink copy the ranges being
> > passed? That would enable testing on btrfs, XFS and NFSv4.2 hosted
> > image files without needing any special block device setup at all...
> 
> That is a very good idea ! But that will cover only the non-zoned case. For copy
> offload on zoned devices, adding support in null_blk is probably the simplest
> thing to do.

Sure, but that's a zone device implementation issue, not a "how do
applications use this offload" issue.

i.e. zonefs support is not necessary to test the bio/block layer
interfaces at all. All we need is a block device that can decode the
bio-encoded offload packet and execute it to do full block layer
testing. We can build dm devices on top of loop devices, etc, so we
can test that the oflload support is plumbed, sliced, diced, and
regurgitated correctly that way. We don't need actual low level
device drivers to test this.

And, unlike the nullblk device, using the loopback device w/
copy_file_range() will also allow data integrity testing if a
generic copy_file_range() offload implementation is added. That is,
we test a non-reflink capable filesystem on the loop device with the
image file hosted on a reflink-capable filesystem. The upper
filesystem copy then gets offloaded to reflinks in the lower
filesystem. We already have copy_file_range() support in fsx, so all
the data integrity fsx tests in fstests will exercise this offload
path and find all the data corruptions the initial block layer bugs
expose...

Further, fsstress also has copy_file_range() support, and so all the
fstests that generate stress tests or use fstress as load for
failure testing will also exercise it.

Indeed, this then gives us fine-grained error injection capability
within fstests via devices like dm-flakey. What happens when
dm-flakey kills the device IO mid-offload? Does everything recover
correctly? Do we end up with data corruption? Are partial offload
completions when errors occur signalled correctly? Is there -any-
test coverage (or even capability for testing) of user driven copy
offload failure situations like this in any of the other test
suites?

I mean, once the loop device has cfr offload, we can use dm-flakey
to kill IO in the image file or even do a force shutdown of the
image host filesystem. Hence we can actually trash the copy offload
operation in mid-flight, not just error it out on full completion.
This is trivial to do with the fstests infrastructure - it just
relies on having generic copy_file_range() block offload support and
a loopback device offload of hardware copy bios back to
copy_file_range()....

This is what I mean about copy offload being designed the wrong way.
We have the high level hooks needed to implement it right though the
filesystems and block layer without any specific hardware support,
and we can test the whole stack without needing specific hardware
support. We already have filesystem level copy offload acceleration,
so the last thing we want to see is a block layer offload
implementation that is incompatible with the semantics we've already
exposed to userspace for copy offloads.

As I said:

> > i.e. I think you're doing this compeltely backwards by trying to
> > target non-existent hardware first....

Rather than tie the block layer offload function/implementation to
the specific quirks of a specific target hardware, we should be
adding generic support in the block layer for the copy offload
semantics we've already exposed to userspace. We already have test
coverage and infrastructure for this interface and is already in use
by applications.

Transparent hardware acceleration of data copies when the hardware
supports it is exactly where copy offloads are useful - implementing
support based around hardware made of unobtainium and then adding
high level user facing API support as an afterthought is putting the
cart before the horse. We need to make sure the high level
functionality is robust and handles errors correctly before we even
worry about what quirks the hardware might bring to the table.

Build a reference model first with the loop device and
copy-file-range, test it, validate it, make sure it all works. Then
hook up the hardware, and fix all the hardware bugs that are exposed
before the hardware is released to the general public....

Why haven't we learnt this lesson yet from all the problems we've
had with, say, broken discard/trim, zeroing, erase, etc in hardware
implementations, incompatible hardware protocol implementations of
equivalent functionality, etc? i.e. We haven't defined the OS
required behaviour that hardware must support and instead just tried
to make whatever has come from the hardware vendor's
"standarisation" process work ok?

In this case, we already have a functioning model, syscalls and user
applications making use of copy offloads at the OS level. Now we
need to implement those exact semantics at the block layer to build
a validated reference model for the block layer offload behaviour
that hardware must comply with. Then hardware offloads in actual
hardware can be compared and validated against the reference model
behaviour, and any hardware that doesn't match can be
quirked/blacklisted until the manufacturer fixes their firmware...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
