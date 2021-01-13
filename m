Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5E2F5435
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 21:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbhAMUiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 15:38:54 -0500
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:45703 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728631AbhAMUiy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:38:54 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 7AE9E110928D;
        Thu, 14 Jan 2021 07:38:10 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kzmu9-0069HN-MI; Thu, 14 Jan 2021 07:38:09 +1100
Date:   Thu, 14 Jan 2021 07:38:09 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Avi Kivity <avi@scylladb.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        andres@anarazel.de
Subject: Re: [RFC] xfs: reduce sub-block DIO serialisation
Message-ID: <20210113203809.GF331610@dread.disaster.area>
References: <20210112010746.1154363-1-david@fromorbit.com>
 <32f99253-fe56-9198-e47c-7eb0e24fdf73@scylladb.com>
 <20210112221324.GU331610@dread.disaster.area>
 <0f0706f9-92ab-6b38-f3ab-b91aaf4343d1@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f0706f9-92ab-6b38-f3ab-b91aaf4343d1@scylladb.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=VwQbUJbxAAAA:8 a=Eg5pMCMCAAAA:8
        a=7-415B0cAAAA:8 a=E4BDoXWkl17D8lVzZUIA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=0UDKrKjV3BTaI6JRjsAj:22
        a=biEYGPWJfzWAr4FL6Ov7:22 a=pHzHmUro8NiASowvMSCR:22
        a=n87TN5wuljxrRezIQYnT:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 13, 2021 at 10:00:37AM +0200, Avi Kivity wrote:
> On 1/13/21 12:13 AM, Dave Chinner wrote:
> > On Tue, Jan 12, 2021 at 10:01:35AM +0200, Avi Kivity wrote:
> > > On 1/12/21 3:07 AM, Dave Chinner wrote:
> > > > Hi folks,
> > > > 
> > > > This is the XFS implementation on the sub-block DIO optimisations
> > > > for written extents that I've mentioned on #xfs and a couple of
> > > > times now on the XFS mailing list.
> > > > 
> > > > It takes the approach of using the IOMAP_NOWAIT non-blocking
> > > > IO submission infrastructure to optimistically dispatch sub-block
> > > > DIO without exclusive locking. If the extent mapping callback
> > > > decides that it can't do the unaligned IO without extent
> > > > manipulation, sub-block zeroing, blocking or splitting the IO into
> > > > multiple parts, it aborts the IO with -EAGAIN. This allows the high
> > > > level filesystem code to then take exclusive locks and resubmit the
> > > > IO once it has guaranteed no other IO is in progress on the inode
> > > > (the current implementation).
> > > 
> > > Can you expand on the no-splitting requirement? Does it involve only
> > > splitting by XFS (IO spans >1 extents) or lower layers (RAID)?
> > XFS only.
> 
> 
> Ok, that is somewhat under control as I can provide an extent hint, and wish
> really hard that the filesystem isn't fragmented.
> 
> 
> > > The reason I'm concerned is that it's the constraint that the application
> > > has least control over. I guess I could use RWF_NOWAIT to avoid blocking my
> > > main thread (but last time I tried I'd get occasional EIOs that frightened
> > > me off that).
> > Spurious EIO from RWF_NOWAIT is a bug that needs to be fixed. DO you
> > have any details?
> > 
> 
> I reported it in [1]. It's long since gone since I disabled RWF_NOWAIT. It
> was relatively rare, sometimes happening in continuous integration runs that
> take hours, and sometimes not.
> 
> 
> I expect it's fixed by now since io_uring relies on it. Maybe I should turn
> it on for kernels > some_random_version.
> 
> 
> [1] https://lore.kernel.org/lkml/9bab0f40-5748-f147-efeb-5aac4fd44533@scylladb.com/t/#u

Yeah, as I thought. Usage of REQ_NOWAIT with filesystem based IO is
simply broken - it causes spurious IO failures to be reported to IO
completion callbacks and so are very difficult to track and/or
retry. iomap does not use REQ_NOWAIT at all, so you should not ever
see this from XFS or ext4 DIO anymore...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
