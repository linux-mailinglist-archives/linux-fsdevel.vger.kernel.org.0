Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F418232A513
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442923AbhCBLq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:46:58 -0500
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:50141 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1577057AbhCBFjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:39:21 -0500
Received: from dread.disaster.area (pa49-179-130-210.pa.nsw.optusnet.com.au [49.179.130.210])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 6C9E4FA8629;
        Tue,  2 Mar 2021 16:38:30 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lGxjo-00AzkM-R6; Tue, 02 Mar 2021 16:38:28 +1100
Date:   Tue, 2 Mar 2021 16:38:28 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
Message-ID: <20210302053828.GI4662@dread.disaster.area>
References: <20210226212748.GY4662@dread.disaster.area>
 <CAPcyv4jryJ32R5vOwwEdoU3V8C0B7zu_pCt=7f6A3Gk-9h6Dfg@mail.gmail.com>
 <20210227223611.GZ4662@dread.disaster.area>
 <CAPcyv4h7XA3Jorcy_J+t9scw0A4KdT2WEwAhE-Nbjc=C2qmkMw@mail.gmail.com>
 <20210228223846.GA4662@dread.disaster.area>
 <CAPcyv4jzV2RUij2BEvDJLLiK_67Nf1v3M6-jRLKf32x4iOzqng@mail.gmail.com>
 <20210301224640.GG4662@dread.disaster.area>
 <CAPcyv4iTqDJApZY0o_Q0GKn93==d2Gta2NM5x=upf=3JtTia7Q@mail.gmail.com>
 <20210302024227.GH4662@dread.disaster.area>
 <CAPcyv4ja8gnTR1E-Ge5etm+y69cHwdWN6Bg79wPPF4M=C-w79A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ja8gnTR1E-Ge5etm+y69cHwdWN6Bg79wPPF4M=C-w79A@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=JD06eNgDs9tuHP7JIKoLzw==:117 a=JD06eNgDs9tuHP7JIKoLzw==:17
        a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=7-415B0cAAAA:8
        a=OJFMFRqHYWYmYpl_lvQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 07:33:28PM -0800, Dan Williams wrote:
> On Mon, Mar 1, 2021 at 6:42 PM Dave Chinner <david@fromorbit.com> wrote:
> [..]
> > We do not need a DAX specific mechanism to tell us "DAX device
> > gone", we need a generic block device interface that tells us "range
> > of block device is gone".
> 
> This is the crux of the disagreement. The block_device is going away
> *and* the dax_device is going away.

No, that is not the disagreement I have with what you are saying.
You still haven't understand that it's even more basic and generic
than devices going away. At the simplest form, all the filesystem
wants is to be notified of is when *unrecoverable media errors*
occur in the persistent storage that underlies the filesystem.

The filesystem does not care what that media is build from - PMEM,
flash, corroded spinning disks, MRAM, or any other persistent media
you can think off. It just doesn't matter.

What we care about is that the contents of a *specific LBA range* no
longer contain *valid data*. IOWs, the data in that range of the
block device has been lost, cannot be retreived and/or cannot be
written to any more.

PMEM taking a MCE because ECC tripped is a media error because data
is lost and inaccessible until recovery actions are taken.

MD RAID failing a scrub is a media error and data is lost and
unrecoverable at that layer.

A device disappearing is a media error because the storage media is
now permanently inaccessible to the higher layers.

This "media error" categorisation is a fundamental property of
persistent storage and, as such, is a property of the block devices
used to access said persistent storage.

That's the disagreement here - that you and Christoph are saying
->corrupted_range is not a block device property because only a
pmem/DAX device currently generates it.

You both seem to be NACKing a generic interface because it's only
implemented for the first subsystem that needs it. AFAICT, you
either don't understand or are completely ignoring the architectural
need for it to be provided across the rest of the storage stack that
*block device based filesystems depend on*.

Sure, there might be dax device based fielsystems around the corner.
They just require a different pmem device ->corrupted_range callout
to implement the notification - one that directs to the dax device
rather than the block device. That's simple and trivial to
implement, but such functionaity for DAX devices  does not replace
the need for the same generic functionality to be provided across a
*range of different block devices* as required by *block device
based filesystems*.

And that's fundamentally the problem. XFS is block device based, not
DAX device based. We require errors to be reported through block
device mechanisms. fs-dax does not change this - it is based on pmem
being presented as a primarily as a block device to the block device
based filesystems and only secondarily as a dax device. Hence if it
can be trivially implemented as a block device interface, that's
where it should go, because then all the other block devices that
the filesytem runs on can provide the same functionality for similar
media error events....

> The dax_device removal implies one
> set of actions (direct accessed pfns invalid) the block device removal
> implies another (block layer sector access offline).

There you go again, saying DAX requires an action, while the block
device notification is a -state change- (i.e. goes offline).

This is exactly what I said was wrong in my last email.

> corrupted_range
> is blurring the notification for 2 different failure domains. Look at
> the nascent idea to mount a filesystem on dax sans a block device.
> Look at the existing plumbing for DM to map dax_operations through a
> device stack.

Ummm, it just maps the direct_access call to the underlying device
and calls it's ->direct_access method. All it's doing is LBA
mapping. That's all it needs to do for ->corrupted_range, too.
I have no clue why you think this is a problem for error
notification...

> Look at the pushback Ruan got for adding a new
> block_device operation for corrupted_range().

one person said "no". That's hardly pushback. Especially as I think
Christoph's objection about this being dax specific functionality
is simply wrong, as per above.

> > This is why we need to communicate what error occurred, not what
> > action a device driver thinks needs to be taken.
> 
> The driver is only an event producer in this model, whatever the
> consumer does at the other end is not its concern. There may be a
> generic consumer and a filesystem specific consumer.

<sigh>

That's why these are all ops functions that can provide multiple
implementations to different device types. So that when we get a new
use case, the ops function structure can be replaced with one that
directs the notification to the new user instead of to the existing
one. It's a design pattern we use all over the kernel code.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
