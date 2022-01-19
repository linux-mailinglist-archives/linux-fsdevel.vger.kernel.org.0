Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9C493BB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 15:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355040AbiASOI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 09:08:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355035AbiASOI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642601307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oeUxYkXz7//k3sdzDCq556rbZt6V8Th4mOcrHxqg5Oo=;
        b=TTS8mj0iiqjcYhYmoBihfPXCL5ZSAckahoqdJwVidCf0Lv8qxWhVIeJw9FhmrmVg5TYazy
        ErsrZolQjBULVUM3yhNG3uySzJCWgobJAcQrRBl7Jj5iE7kntOPPccAcaAV1fsP7ZOpkCN
        KxSctZVNyQ82cook6MRQ3ybEicoFu7I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-FrR6wz03PM-IeTcK60M88w-1; Wed, 19 Jan 2022 09:08:26 -0500
X-MC-Unique: FrR6wz03PM-IeTcK60M88w-1
Received: by mail-qt1-f197.google.com with SMTP id x10-20020ac8700a000000b002c3ef8fc44cso1543720qtm.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jan 2022 06:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oeUxYkXz7//k3sdzDCq556rbZt6V8Th4mOcrHxqg5Oo=;
        b=jLMUIsvyCaXvfi2GxEcHrQkbhDO68qJVzvjVFDdpSuvfcl+WD3sZCc+q0osj4gwu5+
         UipN0UXN8pDTDs33TX3WB7r1g31Zg3NAOvspafdqLofxCRAwXL0o/OY24zcr0ysTseoL
         VB63OZllyQ5fRndh4mkxuSS31BOHwHwvQsGDI/0VTaT2GnudrOIv/hIyM3ppithuyW7N
         jtw9ONauLz7osm3jIfVDFarXBTaVTAzrzyR019VoQ6nXBJT6Ho2n2hWvqLO9qP487plX
         5BmSN4AyALVOHC97zC6d6sQuN44Cu3NKXFhkz9XH/sSbMvX98fgU68+kLrWnQkYjPxLj
         JKpQ==
X-Gm-Message-State: AOAM531ahwCd4h3G2OdvXewT2hVrdqf/ow+Ke3Dv/z3dy+/0XXG8lHWe
        AOwVBAEGYkSY2XNhgVu0vl4LmbS3sWb+Xc6Rrl6C4kYbdg+0FRGe2L49TKUi4q4cH/5KL/lqFpB
        L6sHvbJ/kMYxo59hLnq3i5zYs0g==
X-Received: by 2002:a05:622a:198d:: with SMTP id u13mr24911469qtc.501.1642601305751;
        Wed, 19 Jan 2022 06:08:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCDUZcFrxlcKboINrxvjp24P8kROpVL1kDhKb3KlJN6YHkyc16GPF6kqGW7dJqO2+7nCsqyg==
X-Received: by 2002:a05:622a:198d:: with SMTP id u13mr24911435qtc.501.1642601305339;
        Wed, 19 Jan 2022 06:08:25 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id r2sm1478730qkf.49.2022.01.19.06.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:08:24 -0800 (PST)
Date:   Wed, 19 Jan 2022 09:08:22 -0500
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
Message-ID: <YegbVhxSNtQFlSCr@bfoster>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <20220118030041.GB59729@dread.disaster.area>
 <YeYxOadA0HgYfBjt@zeniv-ca.linux.org.uk>
 <20220118041253.GC59729@dread.disaster.area>
 <YeZW9s7x2uCBfNJD@zeniv-ca.linux.org.uk>
 <20220118232547.GD59729@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118232547.GD59729@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 10:25:47AM +1100, Dave Chinner wrote:
> On Tue, Jan 18, 2022 at 05:58:14AM +0000, Al Viro wrote:
> > On Tue, Jan 18, 2022 at 03:12:53PM +1100, Dave Chinner wrote:
> > 
> > > No, that just creates a black hole where the VFS inode has been
> > > destroyed but the XFS inode cache doesn't know it's been trashed.
> > > Hence setting XFS_IRECLAIMABLE needs to remain in the during
> > > ->destroy_inode, otherwise the ->lookup side of the cache will think
> > > that are currently still in use by the VFS and hand them straight
> > > back out without going through the inode recycling code.
> > > 
> > > i.e. XFS_IRECLAIMABLE is the flag that tells xfs_iget() that the VFS
> > > part of the inode has been torn down, and that it must go back
> > > through VFS re-initialisation before it can be re-instantiated as a
> > > VFS inode.
> > 
> > OK...
> > 
> > > It would also mean that the inode will need to go through two RCU
> > > grace periods before it gets reclaimed, because XFS uses RCU
> > > protected inode cache lookups internally (e.g. for clustering dirty
> > > inode writeback) and so freeing the inode from the internal
> > > XFS inode cache requires RCU freeing...
> > 
> > Wait a minute.  Where is that RCU delay of yours, relative to
> > xfs_vn_unlink() and xfs_vn_rename() (for target)?
> 
> Both of those drop the inode on an on-disk unlinked list. When the
> last reference goes away, ->destroy_inode then runs inactivation.
> 
> Inactivation then runs transactions to free all the space attached
> to the inode and then removes the inode from the unlinked list and
> frees it. It then goes into the XFS_IRECLAIMABLE state and is dirty
> in memory. It can't be reclaimed until the inode is written to disk
> or the whole inode cluster is freed and the inode marked XFS_ISTALE
> (so won't get written back).
> 
> At that point, a background inode reclaim thread (runs every 5s)
> does a RCU protected lockless radix tree walk to find
> XFS_IRECLAIMABLE inodes (via radix tree tags). If they are clean, it
> moves them to XFS_IRECLAIM state, deletes them from the radix tree
> and frees them via a call_rcu() callback.
> 
> If memory reclaim comes along sooner than this, the
> ->free_cached_objects() superblock shrinker callback runs that RCU
> protected lockless radix tree walk to find XFS_IRECLAIMABLE inodes.
> 
> > And where does
> > it happen in case of e.g. open() + unlink() + close()?
> 
> Same thing - close() drops the last reference, the unlinked inode
> goes through inactivation, then moves into the XFS_IRECLAIMABLE
> state.
> 
> The problem is not -quite- open-unlink-close. The problem case is
> the reallocation of an on-disk inode in the case of
> unlink-close-open(O_CREATE) operations because of the on-disk inode
> allocator policy of aggressive reuse of recently freed inodes.  In
> that case the xfs_iget() lookup will reinstantiate the inode via
> xfs_iget_recycle() and the inode will change identity between VFS
> instantiations.
> 
> This is where a RCU grace period is absolutely required, and we
> don't currently have one. The bug was introduced with RCU freeing of
> inodes (what, 15 years ago now?) and it's only recently that we've
> realised this bug exists via code inspection. We really have no
> evidence that it's actually been tripped over in the wild....
> 

To be fair, we have multiple reports of the NULL ->get_link() variant
and my tests to this point to induce "unexpected" returns of that
function don't manifest in as catastrophic a side effect, so might not
be as immediately noticeable by users. I.e., returning non-string data
doesn't seem to necessarily cause a crash in the vfs and the symlink to
symlink variant is more of an unexpected redirection of a lookup.

IOW, I think it's fairly logical to assume that if users are hitting the
originally reported problem, they're likely dangerously close to the
subsequent problems that have been identified from further inspection of
the related code. I don't think this is purely a case of a "theoretical"
problem that doesn't warrant some form of prioritized fix.

> Unfortunately, the simple fix of adding syncronize_rcu() to
> xfs_iget_recycle() causes significant performance regressions
> because we hit this path quite frequently when workloads use lots of
> temporary files - the on-disk inode allocator policy tends towards
> aggressive re-use of inodes for small sets of temporary files.
> 
> The problem XFS is trying to address is that the VFS inode lifecycle
> does not cater for filesystems that need to both dirty and then
> clean unlinked inodes between iput_final() and ->destroy_inode. It's
> too late to be able to put the inode back on the LRU once we've
> decided to drop the inode if we need to dirty it again. ANd because
> evict() is part of the non-blocking memory reclaim, we aren't
> supposed to block for arbitrarily long periods of time or create
> unbound memory demand processing inode eviction (both of which XFS
> can do in inactivation).
> 
> IOWs, XFS can't free the inode until it's journal releases the
> internal reference on the dirty inode. ext4 doesn't track inodes in
> it's journal - it only tracks inode buffers that contain the changes
> made to the inode, so once the transaction is committed in
> ext4_evict_inode() the inode can be immediately freed via either
> ->destroy_inode or ->free_inode. That option does not exist for XFS
> because we have to wait for the journal to finish with the inode
> before it can be freed. Hence all the background reclaim stuff.
> 
> We've recently solved several of the problems we need to solve to
> reduce the mismatch; avoiding blocking on inode writeback in reclaim
> and background inactivation are two of the major pieces of work we
> needed done before we could even consider more closely aligning XFS
> to the VFS inode cache life cycle model.
> 

The background inactivation work facilitates an incremental improvement
by nature because destroyed inodes go directly to a queue instead of
being processed synchronously. My most recent test to stamp the grace
period info at inode destroy time and conditionally sync at reuse time
shows pretty much no major cost because the common case is that a grace
period has already expired by the time the queue populates, is processed
and said inodes become reclaimable and reallocated. To go beyond just
the performance result, if I open code the conditional sync for tracking
purposes I only see something like 10-15 rcu waits out of the 36k
allocation cycles. If I increase the background workload 4x, the
allocation rate drops to ~33k cycles (which is still pretty much in line
with baseline) and the rcu sync count increases to 70, which again is
relatively nominal over tens of thousands of cycles.

This all requires some more thorough testing, but I'm sure it won't be
absolutely free for every possible workload or environment. But given
that we know this infrastructure is fundamentally broken (by subtle
compatibilities between XFS and the VFS that have evolved over time),
will require some thought and time to fix properly in the filesystem,
that users are running into problems very closely related to it, why not
try to address the fundamental breakage if we can do so with an isolated
change with minimal (but probably not zero) performance impact?

I agree that the unconditional synchronize_rcu() on reuse approach is
just not viable, but so far tests using cond_synchronize_rcu() seem
fairly reasonable. Is there some other problem or concern with such an
approach?

Brian

> The next step is to move the background inode inactivation triggers
> up into ->drop_inode so we can catch inodes that need to be dirtied
> by the filesysetm before they have been marked for eviction by the
> VFS. This will allow us to keep the inode on the VFS LRU (probably
> marked with I_WILL_FREE so everyone else keeps away from it) whilst
> we are waiting for the background inactivation work to be done, the
> journal flushed and the metadata written back. Once clean, we can
> directly evict the inode from the VFS ourselves.
> 
> This would mean we only get clean, reclaimable inodes hitting the
> evict() path, and so at that point we can just remove the inode
> directly from the XFS inode cache from either ->destroy_inode or
> ->free_inode and RCU free it. The recycling of in-memory inodes in
> xfs_iget_cache_hit can go away entirely because no inodes will
> linger in the XFS inode cache without being visible at the VFS
> layer as they do now...
> 
> That's going to take a fair bit of work to realise, and I'm not sure
> yet exactly what mods are going to be needed to either the VFS inode
> infrastructure or the XFS inode cache. 
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

