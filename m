Return-Path: <linux-fsdevel+bounces-31406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D04995BD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 01:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2729B1F24B80
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 23:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9A5218D6A;
	Tue,  8 Oct 2024 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="t7frXyRq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD32218D6E
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 23:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728431059; cv=none; b=caME4JHG2qGUZtEszclueL3v+MO4e1V9Pxkc1is7dm4WZ4t+PB8pkZRtV7QoyITYzCMFGEa7gOlcd4PA2fYkT1KaWLJaNpP3EejTb0ygT21y6kuhM/MmRR8NhrJsWtTYT7+kTPI632q6Iq8irMKMx8kHYTAoUYd99fno32px0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728431059; c=relaxed/simple;
	bh=gr6FKS/fgp3Bt3UvUPqDQm3Fvij7K+mg5ynIoHd60HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKKGFOljulfs4HWdMTi/GjawJdI4MoZktVbI6tTeRExvHDsm3UMa7CyA5bgY1wAB8GVR/47wozbsRgWNVDRgM0m66/hMEsrWAoyQhnwGmzzMRmRAL36A6cNGzu9Nz6qSebie0qhv+5I4mYPXFmQ7dltB0EGKF7sEoCTVtDCqaWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=t7frXyRq; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7db238d07b3so5226880a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 16:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1728431056; x=1729035856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GiMT3+ioX4OJkgsUPnWfwXeHQkRJoDKEHMA1xTybSY0=;
        b=t7frXyRq8Q4QfuwRNNVeSK3wkYjm+JEw2uWUsdYZkfDDea627JcYe580In6pH0RsVv
         idwpJqvkIBtdKsdy79OUyE5bBcY8McdBqBL5VVu3AASxi+LXAvmZkU9P+xscmj2wb1iz
         t9vxJyimjq3r4TfZTSMncaEgMNb3StGL9ceX0k5MY9XbJmy2smdfzKhiZFWSqtqjBp19
         IHJfOZyb20NFe4jxvnLJhzCNyLoX9wnunt/v2d4iQmTr0hMbzOsfiyEoWfhIcVpwGyAu
         aU89fiNPnmWaDP3xwpdnEGy7a2Bzu2ZxIKMeC+O+jgpQdYejv6wXYS2xG4+ixDdu/1tY
         fLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728431056; x=1729035856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GiMT3+ioX4OJkgsUPnWfwXeHQkRJoDKEHMA1xTybSY0=;
        b=pa7quiPq1If/+ljGXyguAqEpwWpbf8R5s6jWJbVWLhIhtG/G9GIjQLq5pfSMexUsU0
         Tn9e3CHMM1FRVP5gH5Zplxcvu7TYKskDs4ZBvcmxjI7lzmmCptTKpaU2C69Q0ckf3PNR
         Dbzbw89OGhJFpY2dMXbXoqZZYzuxlWJarrE6pDkQlcdPpnm98SJQfz/nGTMMfOpVbHgu
         jQvfJyeyis9DCvbNfag/ZE3bZxkbbyYj38YoyOUokfWAO6+uiu4DRMxscpGR90BLIe1w
         ATFVL3sQBqN9pHrmQ/o3v9BOwS3PbFnsol3tmaKELuKOGn8pfOQsm4hdyc10hXz6mN0b
         Kn7g==
X-Forwarded-Encrypted: i=1; AJvYcCVWZe036IcxQnwJ9TLq08GO0FOikiUS/8//svotrNzjlsl2Bk5jbc7BDfkSpMPWhPAq4NiGGvgykypFfa/+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf2auyo7AVEXLDDS/nMMgEcTT4hNyWRLTuxALQ1idlc5HyVZZx
	1467G2wuFVvM+wOCRsSOzjUCVRaxDSuPzTTNhzHSCVyQ5z5gnnPE8PEvSMFPUH8=
X-Google-Smtp-Source: AGHT+IErL9DtnYrhJ81B8yQlr3pV9QWY0/ePlDYtB4l7BqgVYVn5E3S2vZ4yVD+4U/rbsNo6DJMwvg==
X-Received: by 2002:a17:90a:d50e:b0:2cd:4593:2a8e with SMTP id 98e67ed59e1d1-2e2a2335d1cmr706669a91.15.1728431056406;
        Tue, 08 Oct 2024 16:44:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5a7a7e3sm167059a91.52.2024.10.08.16.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 16:44:15 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1syJsC-00Fnhp-04;
	Wed, 09 Oct 2024 10:44:12 +1100
Date: Wed, 9 Oct 2024 10:44:12 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <ZwXDzKGj6Bp28kYe@dread.disaster.area>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area>
 <CAOQ4uxgzPM4e=Wc=UVe=rpuug=yaWwu5zEtLJmukJf6d7MUJow@mail.gmail.com>
 <20241008112344.mzi2qjpaszrkrsxg@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008112344.mzi2qjpaszrkrsxg@quack3>

On Tue, Oct 08, 2024 at 01:23:44PM +0200, Jan Kara wrote:
> On Tue 08-10-24 10:57:22, Amir Goldstein wrote:
> > On Tue, Oct 8, 2024 at 1:33 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Mon, Oct 07, 2024 at 01:37:19PM -0700, Linus Torvalds wrote:
> > > > On Thu, 3 Oct 2024 at 04:57, Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > Fair enough. If we go with the iterator variant I've suggested to Dave in
> > > > > [1], we could combine the evict_inodes(), fsnotify_unmount_inodes() and
> > > > > Landlocks hook_sb_delete() into a single iteration relatively easily. But
> > > > > I'd wait with that convertion until this series lands.
> > > >
> > > > Honza, I looked at this a bit more, particularly with an eye of "what
> > > > happens if we just end up making the inode lifetimes subject to the
> > > > dentry lifetimes" as suggested by Dave elsewhere.
> > >
> > > ....
> > >
> > > > which makes the fsnotify_inode_delete() happen when the inode is
> > > > removed from the dentry.
> > >
> > > There may be other inode references being held that make
> > > the inode live longer than the dentry cache. When should the
> > > fsnotify marks be removed from the inode in that case? Do they need
> > > to remain until, e.g, writeback completes?
> > >
> > 
> > fsnotify inode marks remain until explicitly removed or until sb
> > is unmounted (*), so other inode references are irrelevant to
> > inode mark removal.
> > 
> > (*) fanotify has "evictable" inode marks, which do not hold inode
> > reference and go away on inode evict, but those mark evictions
> > do not generate any event (i.e. there is no FAN_UNMOUNT).
> 
> Yes. Amir beat me with the response so let me just add that FS_UMOUNT event
> is for inotify which guarantees that either you get an event about somebody
> unlinking the inode (e.g. IN_DELETE_SELF) or event about filesystem being
> unmounted (IN_UMOUNT) if you place mark on some inode. I also don't see how
> we would maintain this behavior with what Linus proposes.

Thanks. I didn't respond last night when I read Amir's decription
because I wanted to think it over. Knowing where the unmount event
requirement certainly helps.

I am probably missing something important, but it really seems to me
that the object reference counting model is the back to
front.  Currently the mark is being attached to the inode and then
the inode pinned by a reference count to make the mark attached
to the inode persistent until unmount. This then requires the inodes
to be swept by unmount because fsnotify has effectively leaked them
as it isn't tracking such inodes itself.

[ Keep in mind that I'm not saying this was a bad or wrong thing to
do because the s_inodes list was there to be able to do this sort of
lazy cleanup. But now that we want to remove the s_inodes list if at
all possible, it is a problem we need to solve differently. ]

AFAICT, inotify does not appear to require the inode to send events
- it only requires access to the inode mark itself. Hence it does
not the inode in cache to generate IN_UNMOUNT events, it just
needs the mark itself to be findable at unmount.  Do any of the
other backends that require unmount notifications that require
special access to the inode itself?

If not, and the fsnotify sb info is tracking these persistent marks,
then we don't need to iterate inodes at unmount. This means we don't
need to pin inodes when they have marks attached, and so the
dependency on the s_inodes list goes away.

With this inverted model, we need the first fsnotify event callout
after the inode is instantiated to look for a persistent mark for
the inode. We know how to do this efficiently - it's exactly the
same caching model we use for ACLs. On the first lookup, we check
the inode for ACL data and set the ACL pointer appropriately to
indicate that a lookup has been done and there are no ACLs
associated with the inode.

At this point, the fsnotify inode marks can all be removed from the
inode when it is being evicted and there's no need for fsnotify to
pin inodes at all.

> > > > Then at umount time, the dentry shrinking will deal with all live
> > > > dentries, and at most the fsnotify layer would send the FS_UNMOUNT to
> > > > just the root dentry inodes?
> > >
> > > I don't think even that is necessary, because
> > > shrink_dcache_for_umount() drops the sb->s_root dentry after
> > > trimming the dentry tree. Hence the dcache drop would cleanup all
> > > inode references, roots included.
> > >
> > > > Wouldn't that make things much cleaner, and remove at least *one* odd
> > > > use of the nasty s_inodes list?
> > >
> > > Yes, it would, but someone who knows exactly when the fsnotify
> > > marks can be removed needs to chime in here...
> 
> So fsnotify needs a list of inodes for the superblock which have marks
> attached and for which we hold inode reference. We can keep it inside
> fsnotify code although it would practically mean another list_head for the
> inode for this list (probably in our fsnotify_connector structure which
> connects list of notification marks to the inode).

I don't think that is necessary. We need to get rid of the inode
reference, not move where we track inode references. The persistent
object is the fsnotify mark, not the cached inode. It's the mark
that needs to be persistent, and that's what the fsnotify code
should be tracking.

The fsnotify marks are much smaller than inodes, and there going to
be fewer cached marks than inodes, especially once inode pinning is
removed. Hence I think this will result in a net reduction in memory
footprint for "marked-until-unmount" configurations as we won't pin
nearly as many inodes in cache...

> If we actually get rid
> of i_sb_list in struct inode, this will be a win for the overall system,
> otherwise it is a net loss IMHO. So if we can figure out how to change
> other s_inodes owners we can certainly do this fsnotify change.

Yes, I am exploring what it would take to get rid of i_sb_list
altogether right now. That, I don't think this is a concern given
the difference in memory footprint of the same number of persistent
marks. i.e. "persistent mark, reclaimable inode" will always have a
significantly lower memory footprint than "persistent inode and
mark" under memory pressure....

> > > > And I wonder if the quota code (which uses the s_inodes list
> > > > to enable quotas on already mounted filesystems) could for
> > > > all the same reasons just walk the dentry tree instead (and
> > > > remove_dquot_ref similarly could just remove it at
> > > > dentry_unlink_inode() time)?
> > >
> > > I don't think that will work because we have to be able to
> > > modify quota in evict() processing. This is especially true
> > > for unlinked inodes being evicted from cache, but also the
> > > dquots need to stay attached until writeback completes.
> > >
> > > Hence I don't think we can remove the quota refs from the
> > > inode before we call iput_final(), and so I think quotaoff (at
> > > least) still needs to iterate inodes...
> 
> Yeah, I'm not sure how to get rid of the s_inodes use in quota
> code. One of the things we need s_inodes list for is during
> quotaoff on a mounted filesystem when we need to iterate all
> inodes which are referencing quota structures and free them.  In
> theory we could keep a list of inodes referencing quota structures
> but that would require adding list_head to inode structure for
> filesystems that support quotas.

I don't think that's quite true. Quota is not modular, so we can
lazily free quota objects even when quota is turned off. All we need
to ensure is that code checks whether quota is enabled, not for the
existence of quota objects attached to the inode.

Hence quota-off simply turns off all the quota operations in memory,
and normal inode eviction cleans up the stale quota objects
naturally.

My main question is why the quota-on add_dquot_ref() pass is
required. AFAICT all of the filesystem operations that will modify
quota call dquot_initialize() directly to attach the required dquots
to the inode before the operation is started. If that's true, then
why does quota-on need to do this for all the inodes that are
already in cache?

i.e. I'm not sure I understand why we need quota to do these
iterations at all...

> Now for the sake of
> full context I'll also say that enabling / disabling quotas on a mounted
> filesystem is a legacy feature because it is quite easy that quota
> accounting goes wrong with it. So ext4 and f2fs support for quite a few
> years a mode where quota tracking is enabled on mount and disabled on
> unmount (if appropriate fs feature is enabled) and you can only enable /
> disable enforcement of quota limits during runtime.

Sure, this is how XFS works, too. But I think this behaviour is
largely irrelevant because there are still filesystems out there
that do stuff the old way...

> So I could see us
> deprecating this functionality altogether although jfs never adapted to
> this new way we do quotas so we'd have to deal with that somehow.  But one
> way or another it would take a significant amount of time before we can
> completely remove this so it is out of question for this series.

I'm not sure that matters, though it adds to the reasons why we
should be removing old, unmaintained filesystems from the tree
and old, outdated formats from maintained filesystems....

> I see one problem with the idea "whoever has a need to iterate inodes needs
> to keep track of inodes it needs to iterate through". It is fine
> conceptually but with s_inodes list we pay the cost only once and multiple
> users benefit. With each subsystem tracking inodes we pay the cost for each
> user (both in terms of memory and CPU). So if you don't use any of the
> subsystems that need iteration, you win, but if you use two or more of
> these subsystems, in particular those which need to track significant
> portion of all inodes, you are losing.

AFAICT, most of the subsystems don't need to track inodes directly.

We don't need s_inodes for evict_inodes() - we have the inode LRU
tracking all unreferenced inodes on the superblock. The GFS2 use
case can probably walk the inode LRU directly, too.

It looks to me that we can avoid needing unmount iteration for
fsnotify, and I suspect landlock can likely use the same persistence
inversion as fsnotify (same persistent ruleset model).

The bdev superblock can implement it's own internal list using
inode->i_devices as this list_head is only used by chardev
inodes.

All that then remains is the page cache dropping code, and that's
not really critical to have exacting behaviour. We certainly
shouldn't be taking a runtime penalty just to optimise the rare
case of dropping caches..

IOWs, there aren't that many users, and I think there are ways to
make all these iterations go away without adding new per-inode
list heads to track inodes.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

