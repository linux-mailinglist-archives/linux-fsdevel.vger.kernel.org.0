Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A02F958F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jan 2021 22:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbhAQVe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jan 2021 16:34:58 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45155 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728859AbhAQVev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jan 2021 16:34:51 -0500
Received: from dread.disaster.area (pa49-181-54-82.pa.nsw.optusnet.com.au [49.181.54.82])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D0ACC3C3002;
        Mon, 18 Jan 2021 08:34:02 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l1FgP-0011iI-QW; Mon, 18 Jan 2021 08:34:01 +1100
Date:   Mon, 18 Jan 2021 08:34:01 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Avi Kivity <avi@scylladb.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        andres@anarazel.de
Subject: Re: [RFC] xfs: reduce sub-block DIO serialisation
Message-ID: <20210117213401.GB78941@dread.disaster.area>
References: <20210112010746.1154363-1-david@fromorbit.com>
 <32f99253-fe56-9198-e47c-7eb0e24fdf73@scylladb.com>
 <20210112221324.GU331610@dread.disaster.area>
 <0f0706f9-92ab-6b38-f3ab-b91aaf4343d1@scylladb.com>
 <20210113203809.GF331610@dread.disaster.area>
 <50362fc8-3d5e-cd93-4e55-f3ecddc21780@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50362fc8-3d5e-cd93-4e55-f3ecddc21780@scylladb.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=NAd5MxazP4FGoF8nXO8esw==:117 a=NAd5MxazP4FGoF8nXO8esw==:17
        a=8nJEP1OIZ-IA:10 a=EmqxpYm9HcoA:10 a=VwQbUJbxAAAA:8 a=Eg5pMCMCAAAA:8
        a=7-415B0cAAAA:8 a=b_iBPZYbKWB04z0B_q8A:9 a=wPNLvfGTeEIA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=0UDKrKjV3BTaI6JRjsAj:22
        a=biEYGPWJfzWAr4FL6Ov7:22 a=pHzHmUro8NiASowvMSCR:22
        a=n87TN5wuljxrRezIQYnT:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 14, 2021 at 08:48:36AM +0200, Avi Kivity wrote:
> On 1/13/21 10:38 PM, Dave Chinner wrote:
> > On Wed, Jan 13, 2021 at 10:00:37AM +0200, Avi Kivity wrote:
> > > On 1/13/21 12:13 AM, Dave Chinner wrote:
> > > > On Tue, Jan 12, 2021 at 10:01:35AM +0200, Avi Kivity wrote:
> > > > > On 1/12/21 3:07 AM, Dave Chinner wrote:
> > > > > > Hi folks,
> > > > > > 
> > > > > > This is the XFS implementation on the sub-block DIO optimisations
> > > > > > for written extents that I've mentioned on #xfs and a couple of
> > > > > > times now on the XFS mailing list.
> > > > > > 
> > > > > > It takes the approach of using the IOMAP_NOWAIT non-blocking
> > > > > > IO submission infrastructure to optimistically dispatch sub-block
> > > > > > DIO without exclusive locking. If the extent mapping callback
> > > > > > decides that it can't do the unaligned IO without extent
> > > > > > manipulation, sub-block zeroing, blocking or splitting the IO into
> > > > > > multiple parts, it aborts the IO with -EAGAIN. This allows the high
> > > > > > level filesystem code to then take exclusive locks and resubmit the
> > > > > > IO once it has guaranteed no other IO is in progress on the inode
> > > > > > (the current implementation).
> > > > > Can you expand on the no-splitting requirement? Does it involve only
> > > > > splitting by XFS (IO spans >1 extents) or lower layers (RAID)?
> > > > XFS only.
> > > 
> > > Ok, that is somewhat under control as I can provide an extent hint, and wish
> > > really hard that the filesystem isn't fragmented.
> > > 
> > > 
> > > > > The reason I'm concerned is that it's the constraint that the application
> > > > > has least control over. I guess I could use RWF_NOWAIT to avoid blocking my
> > > > > main thread (but last time I tried I'd get occasional EIOs that frightened
> > > > > me off that).
> > > > Spurious EIO from RWF_NOWAIT is a bug that needs to be fixed. DO you
> > > > have any details?
> > > > 
> > > I reported it in [1]. It's long since gone since I disabled RWF_NOWAIT. It
> > > was relatively rare, sometimes happening in continuous integration runs that
> > > take hours, and sometimes not.
> > > 
> > > 
> > > I expect it's fixed by now since io_uring relies on it. Maybe I should turn
> > > it on for kernels > some_random_version.
> > > 
> > > 
> > > [1] https://lore.kernel.org/lkml/9bab0f40-5748-f147-efeb-5aac4fd44533@scylladb.com/t/#u
> > Yeah, as I thought. Usage of REQ_NOWAIT with filesystem based IO is
> > simply broken - it causes spurious IO failures to be reported to IO
> > completion callbacks and so are very difficult to track and/or
> > retry. iomap does not use REQ_NOWAIT at all, so you should not ever
> > see this from XFS or ext4 DIO anymore...
> 
> What kernel version would be good?

For ext4? >= 5.5 was when it was converted to the iomap DIO path
should be safe.  Before taht it would use the old DIO path which
sets REQ_NOWAIT when IOCB_NOWAIT (i.e. RWF_NOWAIT) was set for the
IO.

Btrfs is an even more recent convert to iomap-based dio (5.9?).

The REQ_NOWAIT behaviour was introduced into the old DIO path back
in 4.13 by commit 03a07c92a9ed ("block: return on congested block
device") and was intended to support RWF_NOWAIT on raw block
devices.  Hence it was not added to the iomap path as block devices
don't use that path.

Other examples of how REQ_NOWAIT breaks filesystems was a io_uring
hack to force REQ_NOWAIT IO behaviour through filesystems via
"nowait block plugs" resulted in XFS filesystem shutdowns because
of unexpected IO errors during journal writes:

https://lore.kernel.org/linux-xfs/20200915113327.GA1554921@bfoster/

There have been patches proposed to add REQ_NOWAIT to the iomap DIO
code proporsed, but they've all been NACKed because of the fact it
will break filesystem-based RWF_NOWAIT DIO.

So, long story short: On XFS you are fine on all kernels. On all
other block based filesystems you need <4.13, except for ext4 where
>= 5.5 and btrfs where >=5.9 will work correctly.

> commit 4503b7676a2e0abe69c2f2c0d8b03aec53f2f048
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Mon Jun 1 10:00:27 2020 -0600
> 
>     io_uring: catch -EIO from buffered issue request failure
> 
>     -EIO bubbles up like -EAGAIN if we fail to allocate a request at the
>     lower level. Play it safe and treat it like -EAGAIN in terms of sync
>     retry, to avoid passing back an errant -EIO.
> 
>     Catch some of these early for block based file, as non-mq devices
>     generally do not support NOWAIT. That saves us some overhead by
>     not first trying, then retrying from async context. We can go straight
>     to async punt instead.
> 
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> but this looks to be io_uring specific fix (somewhat frightening too), not
> removal of REQ_NOWAIT.

That looks like a similar case to the one I mention above where
io_uring and REQ_NOWAIT aren't playing well with others....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
