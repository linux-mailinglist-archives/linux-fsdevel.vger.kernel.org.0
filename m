Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45965680399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 02:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjA3ByV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 20:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjA3ByU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:54:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6B31C305
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jan 2023 17:54:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso12489878pju.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jan 2023 17:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCVY9EpbGq1ePfpjU8+pOp23kgenMgxuQFS1Bk1JUmk=;
        b=V1UkGSiYmqHWhjbLWNfCmiJOjxRvJVWx6bD4zW5u3SwGLVIn0HB4b9f5GdgOk6oQbB
         3IKXdj6TdpALaS23jzRKapdEpmpVoI4KuBRUB2S7BaiMSZClibq8DLt7VBzvTHIpJVfn
         NmHUVZCIOmO9/ZAato0DnCdDYIGAmqwkZcU5hmkJOEwiScdLXPqtxHjdjqX3v3Oimdo4
         SjJW04K6cSdpDWpQwuMKkA1Vy6JZSG4V2mnwR6e5o9dksONwMSplV5pFScTgnvH4TDAo
         av2pGr2Pyu1rTqjRe1BOPPa3fsGb304nselC0EzJAUIKRBVKE/c6v2Yr+NS0RvP/Gz0z
         Qsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCVY9EpbGq1ePfpjU8+pOp23kgenMgxuQFS1Bk1JUmk=;
        b=GFW9aYOEpIJMwHz/87g8LWX52LlK7NcKLaAbybrjJL4Gm+NhTDHSxuHZoMHZm5Ss4V
         SEoYz+xVWSOG4nltmiXbx2o4pMl0demx+gSsVCRv49ATYhSDKskASSwGsS4oDnhErY0z
         Sn20kcruw36W+dWsgju0aCX9rHt3KJw+MJaeF61OcQjzG9ETwBgxbKOAJ1DfgkLAxXm1
         quzWLlmU6szVLoCbY42dNhchaxKEhcGvM8uDBuvFiEMdVB3qcdXbktnSm+H2Kjgp2fTi
         KKlg3yX798LK/snX8uMwnA0TP1JTTLtgbITrsM6O0fKo7KroxyDRBbRzjCMfDmYF7lUY
         t+7g==
X-Gm-Message-State: AO0yUKUkcScEePRjEX+JL+m7Eo5SEnj8N8HqXsn8Rw+2MTKSuQS5A8GJ
        6RsN2QQQGCXF/nK7dRIOTnFdyw==
X-Google-Smtp-Source: AK7set/EhtwZVrwVYoZQ9BXI0aCuCAKC6RYGu31Lt8A0hR5tVBKz7RKxd+mFDS42OgGVJmK+F4f2ug==
X-Received: by 2002:a17:90b:3a91:b0:22c:94f6:47af with SMTP id om17-20020a17090b3a9100b0022c94f647afmr3110693pjb.2.1675043658317;
        Sun, 29 Jan 2023 17:54:18 -0800 (PST)
Received: from dread.disaster.area (pa49-181-52-44.pa.nsw.optusnet.com.au. [49.181.52.44])
        by smtp.gmail.com with ESMTPSA id x9-20020a17090a6b4900b00228c8aa7916sm8330769pjl.38.2023.01.29.17.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 17:54:17 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pMJN7-0096ph-3x; Mon, 30 Jan 2023 12:54:13 +1100
Date:   Mon, 30 Jan 2023 12:54:13 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: replacement i_version counter for xfs
Message-ID: <20230130015413.GN360264@dread.disaster.area>
References: <57c413ed362c0beab06b5d83b7fc4b930c7662c4.camel@kernel.org>
 <20230125000227.GM360264@dread.disaster.area>
 <86f993a69a5be276164c4d3fc1951ff4bde881be.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f993a69a5be276164c4d3fc1951ff4bde881be.camel@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 06:47:12AM -0500, Jeff Layton wrote:
> On Wed, 2023-01-25 at 11:02 +1100, Dave Chinner wrote:
> > IIUC the rest of the justification for i_version is that ctime might
> > lack the timestamp granularity to disambiguate sub-timestamp
> > granularity changes, so i_version is needed to bridge that gap.
> > 
> > Given that XFS has nanosecond timestamp resolution in the on-disk
> > format, both i_version and ctime changes are journalled, and
> > ctime/i_version will always change at exactly the same time in the
> > same transactions, there are no inherent sub-timestamp granularity
> > problems with ctime within XFS. Any deficiency in ctime resolution
> > comes solely from the granularity of the VFS inode timestamp
> > functions.
> > 
> > And so if current_time() was to provide fine-grained nanosecond
> > timestamp resolution for exported XFS filesystems (i.e. use
> > ktime_get_real_ts64() conditionally), then it seems to me that the
> > nfsd i_version function becomes completely redundant.
> > 
> > i.e. we are pretty much guaranteed that ctime on exported
> > filesystems will always be different for explicit modifications to
> > the same inode, and hence we can just use ctime as the version
> > change identifier without needing any on-disk format changes at all.
> > 
> > And we can optimise away that overhead when the filesystem is not
> > exported by just using the coarse timestamps because there is no
> > need for sub-timer-tick disambiguation of single file
> > modifications....
> > 
> 
> Ok, so conditional on (maybe) a per fstype flag, and whether the
> filesystem is exported?

Not sure why a per-fstype flag is necessary?

> 
> It's not trivial to tell whether something is exported though. We
> typically only do that sort of checking within nfsd. That involves an
> upcall into mountd, at a minimum.
> 
> I don't think you want to be plumbing calls to exportfs into xfs for
> this. It may be simpler to just add a new on-disk counter and be done
> with it.

I didn't ever expect for XFS to have to be aware of the fact that a
user has exported the filesystem. If "filesystem has been exported"
tracking is required, then we add a flag/counter to the superblock,
and the NFSd subsystem updates the counter/flag when it is informed
that part of the filesystem has been exported/unexported.

The NFSd/export subsystem is pinning filesystems in memory when they
are exported. This is evident by the fact we cannot unmount an
exported filesystem - it has to be unexported before it can be
unmounted. I suspect that it's the ex_path that is stored in the
svc_export structure, because stuff like this is done in the
filehandle code:

static bool is_root_export(struct svc_export *exp)
{
        return exp->ex_path.dentry == exp->ex_path.dentry->d_sb->s_root;
}

static struct super_block *exp_sb(struct svc_export *exp)
{
        return exp->ex_path.dentry->d_sb;
}

i.e. the file handle code assumes the existence of a pinned path
that is the root of the exported directory tree. This points to the
superblock behind the export so that it can do stuff like pull the
device numbers, check sb->s_type->fs_flags fields (e.g
FS_REQUIRES_DEV), etc as needed to encode/decode/verify filehandles.

Somewhere in the code this path must be pinned to the svc_export for
the life of the svc_export (svc_export_init()?), and at that point
the svc_export code could update the struct super_block state
appropriately....

> > Hence it appears to me that with the new i_version specification
> > that there's an avenue out of this problem entirely that is "nfsd
> > needs to use ctime, not i_version". This solution seems generic
> > enough that filesystems with existing on-disk nanosecond timestamp
> > granularity would no longer need explicit on-disk support for the
> > nfsd i_version functionality, yes?
> > 
> 
> Pretty much.
> 
> My understanding has always been that it's not the on-disk format that's
> the limiting factor, but the resolution of in-kernel timestamp sources.
> If ktime_get_real_ts64 has real ns granularity, then that should be
> sufficient (at least for the moment). I'm unclear on the performance
> implications with such a change though.

It's indicated in the documentation:

"These are only useful when called in a fast path and one still
expects better than second accuracy, but can't easily use 'jiffies',
e.g. for inode timestamps.  Skipping the hardware clock access saves
around 100 CPU cycles on most modern machines with a reliable cycle
counter, but up to several microseconds on older hardware with an
external clocksource."

For a modern, high performance machine, 100 CPU cycles for the cycle
counter read is less costly than a pipeline stall due to a single
cacheline miss. For older, slower hardware, the transaction overhead
of a ctime update is already in the order of microseconds, so this
amount of overhead still isn't a show stopper.

As it is, optimising the timestamp read similar to the the iversion
bump only after it has been queried (i.e. equivalent of
inode_maybe_inc_iversion()) would remove most of the additional
overhead for non-NFSd operations. It could be done simply using
an inode state flag rather than hiding the state bit in the
i_version value...

> You had also mentioned a while back that there was some desire for
> femtosecond resolution on timestamps. Does that change the calculus here
> at all? Note that the i_version is not subject to any timestamp
> granularity issues.

[ Reference from 2016 on femptosecond granularity timestamps in
statx():

https://lore.kernel.org/linux-fsdevel/20161117234047.GE28177@dastard/

where I ask:

"So what happens in ten years time when we want to support
femptosecond resolution in the timestamp interface?" ]

Timestamp granularity changes will require an on-disk format change
regardless of anything else. We have no plans to do this again in
the near future - we've just done a revision for >y2038 timestamp
support in the on disk format, and we'd have to do another to
support sub-nanosecond timestamp granularity.  Hence we know exactly
how much time, resources and testing needs to be put into changing
the on-disk timestamp format.  Given that adding a new i_version
field is of similar complexity, we don't want to do either if we can
possibly avoid it.

Looking from a slightly higher perspective, in XFS timestamp updates
are done under exclusive inode locks and so the entire transaction
will need to be done in sub-nanosecond time before we need to worry
about timestamp granularity. It's going to be a long, long time into
the future before that ever happens (if ever!), so I don't think we
need to change the on-disk timestamp granularity to disambiguate
individual inode metadata/data changes any time soon.

> If you want nfsd to start using the ctime for i_version with xfs, then
> you can just turn off the SB_I_IVERSION flag. You will need to do some
> work though to keep your "special" i_version that also counts atime
> updates working once you turn that off. You'll probably want to do that
> anyway though since the semantics for xfs's version counter are
> different from everyone else's.

XFS already uses ->update_time because it is different to other
filesystems in that pure timestamp updates are always updated
transactionally rather than just updating the inode in memory. I'm
not sure there's anything we need to change there right now.

Other things would need to change if we don't set SB_I_IVERSION -
we'd unconditionally bump i_version in xfs_trans_log_inode() rather
than forcing it through inode_maybe_inc_iversion() because we no
longer want the VFS or applications to modify i_version.

But we do still want to tell external parties that i_version is a
usable counter that can be used for data and metadata change
detection, and that stands regardless of the fact that the NFSd
application doesn't want fine-grained change detection anymore.
Hence I think whatever gets done needs to be more nuanced than
"SB_I_VERSION really only means NFSD_CAN_USE_I_VERSION". Perhaps
a second flag that says "SB_I_VERSION_NFSD_COMPATIBLE" to
differentiate between the two cases?

[ Reflection on terminology: how denigrating does it appear when
something is called "special" because it is different to others?
Such terminology would never be allowed if we were talking about
differences between people. ]

> If this is what you choose to do for xfs, then the question becomes: who
> is going to do that timestamp rework?

Depends on what ends up needing to be changed, I'm guessing...

> Note that there are two other lingering issues with i_version. Neither
> of these are xfs-specific, but they may inform the changes you want to
> make there:
> 
> 1/ the ctime and i_version can roll backward on a crash.

Yup, because async transaction engines allow metadata to appear
changed in memory before it is stable on disk. No difference between
i_version or ctime here at all.

> 2/ the ctime and i_version are both currently updated before write data
> is copied to the pagecache. It would be ideal if that were done
> afterward instead. (FWIW, I have some draft patches for btrfs and ext4
> for this, but they need a lot more testing.)

AFAICT, changing the i_version after the page cache has been written
to does not fix the visibility and/or crash ordering issue.  The new
data is published for third party access when the folio the data is
written into is unlocked, not when the entire write operation
completes.  Hence we can start writeback on data that is part of a
write operation before the write operation has completed and updated
i_version.

If we then crash before the write into the page cache completes and
updates i_version, we can now have changed data on disk without a
i_version update in the metadata to even recover from the journal.
Hence with a post-write i_version update, none of the clients will
see that their caches are stale because i_version/ctime hasn't
changed despite the data on disk having changed.

As such, I don't really see what "update i_version after page cache
write completion" actually achieves by itself.  Even "update
i_version before and after write" doesn't entirely close down the
crash hole in i_version, either - it narrows it down, but it does
not remove it...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
