Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9CABE0D68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 22:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfJVUny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 16:43:54 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:47925 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727582AbfJVUny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:43:54 -0400
Received: from dread.disaster.area (pa49-180-40-48.pa.nsw.optusnet.com.au [49.180.40.48])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id AA85A363351;
        Wed, 23 Oct 2019 07:43:46 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iN10K-000666-K1; Wed, 23 Oct 2019 07:43:44 +1100
Date:   Wed, 23 Oct 2019 07:43:44 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Christie <mchristi@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        martin@urbackup.org, Damien.LeMoal@wdc.com
Subject: Re: [PATCH] Add prctl support for controlling PF_MEMALLOC V2
Message-ID: <20191022204344.GB2044@dread.disaster.area>
References: <20191021214137.8172-1-mchristi@redhat.com>
 <20191022112446.GA8213@dhcp22.suse.cz>
 <5DAF2AA0.5030500@redhat.com>
 <20191022163310.GS9379@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022163310.GS9379@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=y881pOMu+B+mZdf5UrsJdA==:117 a=y881pOMu+B+mZdf5UrsJdA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=5awdTYTMrUjDONYjdkwA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 06:33:10PM +0200, Michal Hocko wrote:
> On Tue 22-10-19 11:13:20, Mike Christie wrote:
> > On 10/22/2019 06:24 AM, Michal Hocko wrote:
> > > On Mon 21-10-19 16:41:37, Mike Christie wrote:
> > >> There are several storage drivers like dm-multipath, iscsi, tcmu-runner,
> > >> amd nbd that have userspace components that can run in the IO path. For
> > >> example, iscsi and nbd's userspace deamons may need to recreate a socket
> > >> and/or send IO on it, and dm-multipath's daemon multipathd may need to
> > >> send IO to figure out the state of paths and re-set them up.
> > >>
> > >> In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the
> > >> memalloc_*_save/restore functions to control the allocation behavior,
> > >> but for userspace we would end up hitting a allocation that ended up
> > >> writing data back to the same device we are trying to allocate for.
> > > 
> > > Which code paths are we talking about here? Any ioctl or is this a
> > > general syscall path? Can we mark the process in a more generic way?
> > 
> > It depends on the daemon. The common one for example are iscsi and nbd
> > need network related calls like sendmsg, recvmsg, socket, etc.
> > tcmu-runner could need the network ones and also read and write when it
> > does IO to a FS or device. dm-multipath needs the sg io ioctls.
> 
> OK, so there is not a clear kernel entry point that could be explicitly
> annotated. This would imply a per task context. This is an important
> information. And I am wondering how those usecases ever worked in the
> first place. This is not a minor detail.

They don't work, and we've known it for many years. It's just that
most of the time they are not run with really low memory. :)

e.g. loopback devices have long been known to deadlock like this
buts it's only very recently we gave it PF_MEMALLOC_NOIO protection
for it's kernel internal read() and write() calls.

> > > E.g. we have PF_LESS_THROTTLE (used by nfsd). It doesn't affect the
> > > reclaim recursion but it shows a pattern that doesn't really exhibit
> > > too many internals. Maybe we need PF_IO_FLUSHER or similar?
> > 
> > I am not familiar with PF_IO_FLUSHER. If it prevents the recursion
> > problem then please send me details and I will look into it for the next
> > posting.
> 
> PF_IO_FLUSHER doesn't exist. I just wanted to point out that similarly
> to PF_LESS_THROTTLE it should be a more high level per task flag rather
> than something as low level as a direct control of gfp allocation
> context. PF_LESS_THROTTLE simply tells that the task is a part of the
> reclaim process and therefore it shouldn't be a subject of a normal
> throttling - whatever that means.

PF_LESS_THROTTLE doesn't do that at all - it really only changes
limits slightly and doesn't prevent reclaim recursion deadlocks in
any way.

What PF_LESS_THROTTLE was largely intended for is give the process a
small amount of extra overhead on dirty page throttle limits so that
if it's a stacked device it won't get throttled before the upper
filesystem gets throttled.

i.e. the idea is that it's got a -little- bit  more wiggle room
before things like balance_dirty_pages() stops incoming writes,
hence allowing writes to the upper filesystems to be throttled first
before the underlying device that may be cleaning pages.

NFS uses this in the case of a loopback mount - both the client and
the server are on the same node, and so the data is double-cached.
FOr the client to clean it's page, the server has to be able to
write() the dirty data through balance_dirty_pages, and if we are at
the dirty page limit then it will block and we effectively deadlock
the writeback because we can't write the server side page that will
clean the client side page. So the NFS server is given a higher
dirty throttle limit by PF_LESS_THROTTLE so it can write when the
client is throttled.

The same problem exists for the loopback block device, and it also
sets PF_LESS_THROTTLE. But because it's a stacked block device
(unlike the NFS setup) it has actual filesystem memory reclaim
recursion problems (i.e. lower fs context allocation cleaning upper
fs pages recursing into upper fs to reclaim pages) and so it also
sets PF_MEMALLOC_NOIO to prevent these reclaim deadlocks.

IOWs, the situation with these userspace processes is akin to the
loopback device, not the "NFS client/NFS server on same host"
situation. We have lots of evidence of reclaim recursion hangs, but
very little evidence of balance_dirty_pages() throttling hangs....

> PF_IO_FLUSHER would mean that the user
> context is a part of the IO path and therefore there are certain reclaim
> recursion restrictions.

If PF_IO_FLUSHER just maps to PF_LESS_THROTTLE|PF_MEMALLOC_NOIO,
then I'm not sure we need a new definition. Maybe that's the ptrace
flag name, but in the kernel we don't need a PF_IO_FLUSHER process
flag...

> > >> This patch allows the userspace deamon to set the PF_MEMALLOC* flags
> > >> with prctl during their initialization so later allocations cannot
> > >> calling back into them.
> > > 
> > > TBH I am not really happy to export these to the userspace. They are
> > > an internal implementation detail and the userspace shouldn't really
> > 
> > They care in these cases, because block/fs drivers must be able to make
> > forward progress during writes. To meet this guarantee kernel block
> > drivers use mempools and memalloc/GFP flags.
> > 
> > For these userspace components of the block/fs drivers they already do
> > things normal daemons do not to meet that guarantee like mlock their
> > memory, disable oom killer, and preallocate resources they have control
> > over. They have no control over reclaim like the kernel drivers do so
> > its easy for us to deadlock when memory gets low.
> 
> OK, fair enough. How much of a control do they really need though. Is a
> single PF_IO_FLUSHER as explained above (essentially imply GPF_NOIO
> context) sufficient?

I think some of these usrspace processes work at the filesystem
level and so really only need GFP_NOFS allocation (fuse), while
others work at the block device level (iscsi, nbd) so need GFP_NOIO
allocation. So there's definitely an argument for providing both...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
