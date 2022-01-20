Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422C34951F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 17:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376846AbiATQDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 11:03:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243632AbiATQDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642694624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lWK6mOLVuSBAqdv9PppVl2SL9//AaFHm4Tq1BXMZidw=;
        b=JVS2q02m6HyxXkkbmwU1ngX7KOogdvUD9tnzsa92wVmak+fS2DQKdM1IDpdeTOdGMYYf9p
        CShPUiyipnYN6W44Ms8PQQRXW/Uj/4B8k24oS5JPD+S9j/MGu73giztlkUxpW8AuVOVz99
        7tmmjbnEsL26mP4FA6WtecxJ9ciI2JM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-6SMluKK0MGmpZRQ-UC6Gqg-1; Thu, 20 Jan 2022 11:03:43 -0500
X-MC-Unique: 6SMluKK0MGmpZRQ-UC6Gqg-1
Received: by mail-qt1-f200.google.com with SMTP id bb10-20020a05622a1b0a00b002cae750b213so4216647qtb.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 08:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lWK6mOLVuSBAqdv9PppVl2SL9//AaFHm4Tq1BXMZidw=;
        b=C8zwp//hOKb9cdu1aIMzz3KdfCwNKKAlmITOGM3dBWhcg4VODVdibWzzr/5D3lcdZo
         VHY+1jotzGRjRiFM7R/Pe/NSEt2FiG30MaTVB+/aoFx3z1WXk4mtt5cbDhvvHMdck3SI
         C5NmdoBabaF1KRQaBornJGsYelbFFHN3YQq97DswXkfpebvd4X1ivcBHc4NamGq8wXHv
         hwCM01eunZSnEDiCETisUn1mcw/1gSE8UCAK1z7EbZnbKptEsPPSgh92RTs+fXvn/Mk3
         CsdtdYg0KJtgq4bR8LXszRYqHEQ0A68r7hrdyZQsEOdAFsJy/+NWmgD6oqVHDkZtlZSi
         mtXQ==
X-Gm-Message-State: AOAM533o1RSC40O4lu1WcvdZLnJCM3UBhehiDBl5a5YVT7RpOgbxbhgM
        xEuG3UeSxM9PrFRAD5CKvAGgzgs1iTVOsiivLZLmlqLVOhWhg3UKf2mxdv3wEgGLMmFx4ojLYyQ
        EohI7b124KNCHchY7WvOmN86mZw==
X-Received: by 2002:a05:620a:24cf:: with SMTP id m15mr8241848qkn.242.1642694611528;
        Thu, 20 Jan 2022 08:03:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPGDUIi+QpPfPSg35xmqUAoY8i3/Af3ku6LwYOSnIcQSfjV7gJC9etLCLOD6jF4MI9m5tO5A==
X-Received: by 2002:a05:620a:24cf:: with SMTP id m15mr8241813qkn.242.1642694611092;
        Thu, 20 Jan 2022 08:03:31 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id h189sm1652470qkc.35.2022.01.20.08.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 08:03:30 -0800 (PST)
Date:   Thu, 20 Jan 2022 11:03:28 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <YemH0LML9ZVUnrEX@bfoster>
References: <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <20220118030041.GB59729@dread.disaster.area>
 <YeYxOadA0HgYfBjt@zeniv-ca.linux.org.uk>
 <20220118041253.GC59729@dread.disaster.area>
 <YeZW9s7x2uCBfNJD@zeniv-ca.linux.org.uk>
 <20220118232547.GD59729@dread.disaster.area>
 <YegbVhxSNtQFlSCr@bfoster>
 <20220119220747.GF59729@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119220747.GF59729@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 09:07:47AM +1100, Dave Chinner wrote:
> On Wed, Jan 19, 2022 at 09:08:22AM -0500, Brian Foster wrote:
> > On Wed, Jan 19, 2022 at 10:25:47AM +1100, Dave Chinner wrote:
> > > On Tue, Jan 18, 2022 at 05:58:14AM +0000, Al Viro wrote:
> > > > On Tue, Jan 18, 2022 at 03:12:53PM +1100, Dave Chinner wrote:
> > > Unfortunately, the simple fix of adding syncronize_rcu() to
> > > xfs_iget_recycle() causes significant performance regressions
> > > because we hit this path quite frequently when workloads use lots of
> > > temporary files - the on-disk inode allocator policy tends towards
> > > aggressive re-use of inodes for small sets of temporary files.
> > > 
> > > The problem XFS is trying to address is that the VFS inode lifecycle
> > > does not cater for filesystems that need to both dirty and then
> > > clean unlinked inodes between iput_final() and ->destroy_inode. It's
> > > too late to be able to put the inode back on the LRU once we've
> > > decided to drop the inode if we need to dirty it again. ANd because
> > > evict() is part of the non-blocking memory reclaim, we aren't
> > > supposed to block for arbitrarily long periods of time or create
> > > unbound memory demand processing inode eviction (both of which XFS
> > > can do in inactivation).
> > > 
> > > IOWs, XFS can't free the inode until it's journal releases the
> > > internal reference on the dirty inode. ext4 doesn't track inodes in
> > > it's journal - it only tracks inode buffers that contain the changes
> > > made to the inode, so once the transaction is committed in
> > > ext4_evict_inode() the inode can be immediately freed via either
> > > ->destroy_inode or ->free_inode. That option does not exist for XFS
> > > because we have to wait for the journal to finish with the inode
> > > before it can be freed. Hence all the background reclaim stuff.
> > > 
> > > We've recently solved several of the problems we need to solve to
> > > reduce the mismatch; avoiding blocking on inode writeback in reclaim
> > > and background inactivation are two of the major pieces of work we
> > > needed done before we could even consider more closely aligning XFS
> > > to the VFS inode cache life cycle model.
> > > 
> > 
> > The background inactivation work facilitates an incremental improvement
> > by nature because destroyed inodes go directly to a queue instead of
> > being processed synchronously. My most recent test to stamp the grace
> > period info at inode destroy time and conditionally sync at reuse time
> > shows pretty much no major cost because the common case is that a grace
> > period has already expired by the time the queue populates, is processed
> > and said inodes become reclaimable and reallocated.
> 
> Yup. Remember that I suggested these conditional variants in the
> first place - I do understand what this code does...
> 
> > To go beyond just
> > the performance result, if I open code the conditional sync for tracking
> > purposes I only see something like 10-15 rcu waits out of the 36k
> > allocation cycles. If I increase the background workload 4x, the
> > allocation rate drops to ~33k cycles (which is still pretty much in line
> > with baseline) and the rcu sync count increases to 70, which again is
> > relatively nominal over tens of thousands of cycles.
> 
> Yup. But that doesn't mean that the calls that trigger are free from
> impact. The cost and latency of waiting for an RCU grace period to
> expire goes up as the CPU count goes up. e.g. it requires every CPU
> running a task goes through a context switch before it returns.
> Hence if we end up with situations like, say, the ioend completion
> scheduling holdoffs, then that will prevent the RCU sync from
> returning for seconds.
> 

Sure... this is part of the reason the tests I've run so far have all
tried to incorporate background rcuwalk activity, run on a higher cpu
count box, etc. And from the XFS side of the coin, the iget code can
invoke xfs_inodegc_queue_all() in the needs_inactive case before
reclaimable state is a possibility, which queues a work on every cpu
with pending inactive inodes. That is probably unlikely in the
free/alloc case (since needs_inactive inodes are not yet free on disk),
but the broader points are that the inactive processing work has to
complete one way or another before reclaimable state is possible and
that we can probably accommodate a synchronization point here if it's
reasonably filtered. Otherwise...

> IOWs, we're effectively adding unpredictable and non-deterministic
> latency into the recycle path that is visible to userspace
> applications, and those latencies can be caused by subsystem
> functionality not related to XFS. Hence we need to carefully
> consider unexpected side-effects of adding a kernel global
> synchronisation point into a XFS icache lookup fast path, and these
> issues may not be immediately obvious from testing...
> 

... agreed. I think at this point we've also discussed various potential
ways to shift or minimize latency/cost further, so there's probably
still room for refinement if such unexpected things crop up before...

> > This all requires some more thorough testing, but I'm sure it won't be
> > absolutely free for every possible workload or environment. But given
> > that we know this infrastructure is fundamentally broken (by subtle
> > compatibilities between XFS and the VFS that have evolved over time),
> > will require some thought and time to fix properly in the filesystem,
> > that users are running into problems very closely related to it, why not
> > try to address the fundamental breakage if we can do so with an isolated
> > change with minimal (but probably not zero) performance impact?
> > 
> > I agree that the unconditional synchronize_rcu() on reuse approach is
> > just not viable, but so far tests using cond_synchronize_rcu() seem
> > fairly reasonable. Is there some other problem or concern with such an
> > approach?
> 
> Just that the impact of adding RCU sync points means that bad
> behaviour outside XFS have a new point where they can adversely
> impact on applications doing filesystem operations.
> 
> As a temporary mitigation strategy I think it will probably be fine,
> but I'd much prefer we get rid of the need for such an RCU sync
> point rather than try to maintain a mitigation like this in fast
> path code forever.
> 

... we end up here. All in all, this is intended to be a
practical/temporary step toward functional correctness that minimizes
performance impact and disruption (i.e. just as easy to remove when made
unnecessary).

Al,

The caveat to this is I think the practicality of a conditional sync in
the iget recycle code sort of depends on the queueing/batching nature of
inactive inode processing in XFS. If you look at xfs_fs_destroy_inode()
for example, you'll see this is all fairly recent feature/infrastructure
code and that historically we completed most of this transition to
reclaimable state before ->destroy_inode() returns. Therefore, the
concern I have is that on older/stable kernels (where users are hitting
this NULL ->get_link() BUG) the reuse code is far more likely to stall
and slow down here with this change alone (see my earlier numbers on the
unconditional sync_rcu() test for prospective worst case). For that
reason, I'm not sure this is really a backportable solution.

So getting back to your concern around Ian's patch being a
stopgap/bandaid type solution, would you be willing to pull something
like Ian's patch to the vfs if upstream XFS adopts this conditional rcu
sync in the iget reuse code? I think that would ensure that no further
bandaid fixes will be required in the vfs due to XFS inode reuse, but
would also provide an isolated variant of the fix in the VFS that is
more easily backported to stable kernels. Thoughts?

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

