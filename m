Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F056A683A71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 00:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjAaXYy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 18:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjAaXYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:24:47 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5B37AA0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 15:24:18 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so215087pjb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 15:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=veKwbiqwQbTE2WhUVNMZXy9QNxaEb0+ID1xNOyVwQQ8=;
        b=IQDPExZIH4xYJeD7b6dlo5K30Qc1TTpbRkzvEcODnwqgrpbrOL2b+YZvJbbq2kqD2R
         EdR3aPUrLDY0nPqu/K/Rrv9pCzhQTEpoMhi8qTHfAfe1Ar0OQVIlTGsNZfCrCGMzrvnZ
         VvCHOHoAfajpxeRSCB8HXOiYP2J36xIr5hjzdA+0ir75TzyGlnsqMf5b8kAyzSPcl23f
         9cj3ntADnlD+hygV5dM5bAKlnc46KPKhhoIPIOgM6+lfciJK6lXxVboG65UCPGzwfZ8M
         14jMzOs0RwPMQ6yUpwZPg3QuOjtl+9bMXNBc9E1wnyh2LbCDrwRhUVCOYmdx4MqVyug5
         o0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veKwbiqwQbTE2WhUVNMZXy9QNxaEb0+ID1xNOyVwQQ8=;
        b=A8vL7GgapI4riStI96UFBT2hv9wTCdAP6dsaFXmh+Q8cwoKF0KyomwozOFAq997gZj
         9I1bTzsOKMXDA0SPLSnNFCFkGVleZCHhpXzlE44kw4pUjttECilnbG9ksxIRM8P3Vt/d
         wiTvZC6NHhRDgrrGzL05MmmVaArHWRgASN8dUvA3qDTABhVWBrGhYLy0sc9Olue6q2bF
         TZ8DndZ8w3/FQYOh1HeymRvGW5pRlRuXE3GXyZhs6eCsHBy2CE/hP+nkcddOAHDEaP8Z
         IIMJU8WgsOsS6oPhn7RF4zdSfeScRwYNmMonrw7o5s2thGLmHo93QVeGKRIEYUI3KOOa
         iYBA==
X-Gm-Message-State: AO0yUKX4N5Z406/+qbRAsncy35S+x/ih4MJqvirYU+dHpEfhEPoEll6K
        zuumEpCa2xgliLvlICYHCCikWliQRh0N16wy
X-Google-Smtp-Source: AK7set+AQpiE5xkWxDryUscyflwAZhZF/OrKkvLFagRdMHzt1fpDNRAWVEMzxIlqA/TjCQRgN076Vw==
X-Received: by 2002:a17:902:db0a:b0:196:11b1:101d with SMTP id m10-20020a170902db0a00b0019611b1101dmr923455plx.28.1675207443949;
        Tue, 31 Jan 2023 15:24:03 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902821100b001963c423400sm10309136pln.240.2023.01.31.15.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 15:24:02 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pMzyo-009rTT-8F; Wed, 01 Feb 2023 10:23:58 +1100
Date:   Wed, 1 Feb 2023 10:23:58 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: replacement i_version counter for xfs
Message-ID: <20230131232358.GQ360264@dread.disaster.area>
References: <57c413ed362c0beab06b5d83b7fc4b930c7662c4.camel@kernel.org>
 <20230125000227.GM360264@dread.disaster.area>
 <86f993a69a5be276164c4d3fc1951ff4bde881be.camel@kernel.org>
 <20230130015413.GN360264@dread.disaster.area>
 <2d8e60ea6eb5f8b79e22c0a15d9266a24b4f7995.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8e60ea6eb5f8b79e22c0a15d9266a24b4f7995.camel@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 06:55:41AM -0500, Jeff Layton wrote:
> On Mon, 2023-01-30 at 12:54 +1100, Dave Chinner wrote:
> > On Wed, Jan 25, 2023 at 06:47:12AM -0500, Jeff Layton wrote:
> > > On Wed, 2023-01-25 at 11:02 +1100, Dave Chinner wrote:
> > > > IIUC the rest of the justification for i_version is that ctime might
> > > > lack the timestamp granularity to disambiguate sub-timestamp
> > > > granularity changes, so i_version is needed to bridge that gap.
> > > > 
> > > > Given that XFS has nanosecond timestamp resolution in the on-disk
> > > > format, both i_version and ctime changes are journalled, and
> > > > ctime/i_version will always change at exactly the same time in the
> > > > same transactions, there are no inherent sub-timestamp granularity
> > > > problems with ctime within XFS. Any deficiency in ctime resolution
> > > > comes solely from the granularity of the VFS inode timestamp
> > > > functions.
> > > > 
> > > > And so if current_time() was to provide fine-grained nanosecond
> > > > timestamp resolution for exported XFS filesystems (i.e. use
> > > > ktime_get_real_ts64() conditionally), then it seems to me that the
> > > > nfsd i_version function becomes completely redundant.
> > > > 
> > > > i.e. we are pretty much guaranteed that ctime on exported
> > > > filesystems will always be different for explicit modifications to
> > > > the same inode, and hence we can just use ctime as the version
> > > > change identifier without needing any on-disk format changes at all.
> > > > 
> > > > And we can optimise away that overhead when the filesystem is not
> > > > exported by just using the coarse timestamps because there is no
> > > > need for sub-timer-tick disambiguation of single file
> > > > modifications....
> > > > 
> > > 
> > > Ok, so conditional on (maybe) a per fstype flag, and whether the
> > > filesystem is exported?
> > 
> > Not sure why a per-fstype flag is necessary?
> > 
> 
> I was thinking most filesystems wouldn't need these high-res timestamps,
> so we could limit it to those that opt in via a fstype flag.

We'd only need high-res timestamps when NFS is in use, not all the
time. We already have timestamp granularity information in the
superblock, so if the filesystem is exported and the sb indicates
that it has sub-jiffie timestamp resolution, we can then use
high-res timestamps for ctime and the need for i_version goes away
completely....

> > > It's not trivial to tell whether something is exported though. We
> > > typically only do that sort of checking within nfsd. That involves an
> > > upcall into mountd, at a minimum.
> > > 
> > > I don't think you want to be plumbing calls to exportfs into xfs for
> > > this. It may be simpler to just add a new on-disk counter and be done
> > > with it.
> > 
> > I didn't ever expect for XFS to have to be aware of the fact that a
> > user has exported the filesystem. If "filesystem has been exported"
> > tracking is required, then we add a flag/counter to the superblock,
> > and the NFSd subsystem updates the counter/flag when it is informed
> > that part of the filesystem has been exported/unexported.
> > 
> > The NFSd/export subsystem is pinning filesystems in memory when they
> > are exported. This is evident by the fact we cannot unmount an
> > exported filesystem - it has to be unexported before it can be
> > unmounted. I suspect that it's the ex_path that is stored in the
> > svc_export structure, because stuff like this is done in the
> > filehandle code:
> > 
> > static bool is_root_export(struct svc_export *exp)
> > {
> >         return exp->ex_path.dentry == exp->ex_path.dentry->d_sb->s_root;
> > }
> > 
> > static struct super_block *exp_sb(struct svc_export *exp)
> > {
> >         return exp->ex_path.dentry->d_sb;
> > }
> > 
> > i.e. the file handle code assumes the existence of a pinned path
> > that is the root of the exported directory tree. This points to the
> > superblock behind the export so that it can do stuff like pull the
> > device numbers, check sb->s_type->fs_flags fields (e.g
> > FS_REQUIRES_DEV), etc as needed to encode/decode/verify filehandles.
> > 
> > Somewhere in the code this path must be pinned to the svc_export for
> > the life of the svc_export (svc_export_init()?), and at that point
> > the svc_export code could update the struct super_block state
> > appropriately....
> > 
> 
> No, it doesn't quite work like that. The exports table is loaded on-
> demand by nfsd via an upcall to mountd.
> 
> If you set up a filesystem to be exported by nfsd, but don't do any nfs
> activity against it, you'll still be able to unmount the filesystem
> because the export entry won't have been loaded by the kernel yet. Once
> a client talks to nfsd and touches the export, the kernel will upcall
> and that's when the dentry gets pinned.

I think you've missed the forest for the trees. Yes, the pinning
mechanism works slightly differently to what I described, but the
key take-away is that there is a *reliable mechanism* that tracks
when a filesystem is effectively exported by the NFSd and high res
timestamps would be required.

Hence it's still trivial for those triggers to mark the sb with
"export pinned" state (e.g. a simple counter) for other code to vary
their algorithms based on whether the filesystem is being actively
accessed by remote NFS clients or not.

> > > If this is what you choose to do for xfs, then the question becomes: who
> > > is going to do that timestamp rework?
> > 
> > Depends on what ends up needing to be changed, I'm guessing...
> > 
> > > Note that there are two other lingering issues with i_version. Neither
> > > of these are xfs-specific, but they may inform the changes you want to
> > > make there:
> > > 
> > > 1/ the ctime and i_version can roll backward on a crash.
> > 
> > Yup, because async transaction engines allow metadata to appear
> > changed in memory before it is stable on disk. No difference between
> > i_version or ctime here at all.
> > 
> 
> There is a little difference. The big danger here is that the i_version
> could roll backward after being seen by a client, and then on a
> subsequent change, we'd end up with a duplicate i_version that reflects
> a different state of the file from what the client has observed.
> 
> ctime is probably more resilient here, as to get the same effect you'd
> need to crash and roll back, _and_ have the clock roll backward too.
> 
> > > 2/ the ctime and i_version are both currently updated before write data
> > > is copied to the pagecache. It would be ideal if that were done
> > > afterward instead. (FWIW, I have some draft patches for btrfs and ext4
> > > for this, but they need a lot more testing.)
> > 
> > AFAICT, changing the i_version after the page cache has been written
> > to does not fix the visibility and/or crash ordering issue.  The new
> > data is published for third party access when the folio the data is
> > written into is unlocked, not when the entire write operation
> > completes.  Hence we can start writeback on data that is part of a
> > write operation before the write operation has completed and updated
> > i_version.
> > 
> > If we then crash before the write into the page cache completes and
> > updates i_version, we can now have changed data on disk without a
> > i_version update in the metadata to even recover from the journal.
> > Hence with a post-write i_version update, none of the clients will
> > see that their caches are stale because i_version/ctime hasn't
> > changed despite the data on disk having changed.
> > 
> > As such, I don't really see what "update i_version after page cache
> > write completion" actually achieves by itself.  Even "update
> > i_version before and after write" doesn't entirely close down the
> > crash hole in i_version, either - it narrows it down, but it does
> > not remove it...
> > 
> 
> This issue is not about crash resilience.
> 
> The worry we have is that a client could see a change attribute change
> and do a read of the data before the writer has copied the data to the
> pagecache. If it does that and the i_version doesn't change again, then
> the client will be stuck with stale data in its cache.

That can't happen with XFS. Buffered reads cannot run concurrently
with buffered writes because we serialise entire write IO requests
against entire read IO requests via the i_rwsem. i.e. buffered reads
use shared locking, buffered writes use exclusive locking.

As a result, the kiocb_modified() call to change i_version/ctime in
the write path is done while we hold the i_rwsem exclusively. i.e.
the version change is done while concurrent readers are blocked
waiting for the write to complete the data copy into the page cache.
Hence there is no transient state between the i_version/ctime update
and the data copy-in completion that buffered readers can observe.

Yes, this is another aspect where XFS is different to every other
Linux filesystem - none of the other filesystems have this "atomic"
buffered write IO path. Instead, they use folio locks to serialise
page cache access and so reads can run concurrently with write
operations as long as they aren't trying to access the same folio at
the same time. Hence you can get concurrent overlapping reads and
writes and this is the root cause of all the i_version/ctime update
problems you are talking about.

> By bumping the times and/or version after the change, we ensure that
> this doesn't happen. The client might briefly associate the wrong data
> with a particular change attr, but that situation should be short-lived.

Unless the server crashes mid-write....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
