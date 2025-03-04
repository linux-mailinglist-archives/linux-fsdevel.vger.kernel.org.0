Return-Path: <linux-fsdevel+bounces-43050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BCCA4D5B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5625188C6CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 08:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9AF1F9F75;
	Tue,  4 Mar 2025 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="uB1yGnYt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91F18CBF2
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075496; cv=none; b=m4NDpTQKvrIuC/StLPLpbSdqNB1AMMtoUCUx/fHG3F2roOuw2HswwYyhJmEdH5fpRdmt4g6Lv6X3kALiJLm36MHKw54seJ3QTQWFnkoFjSpBVRKXgl+XmfMOi0Nqi6RlmUOtz5mOaOAIT2fiF9oVRxt7nMF0TMHtqjndJuawVUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075496; c=relaxed/simple;
	bh=6HuYx6X3R8qzk2JTR80aGmGUknBafNmDTxNoMFtwc/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taiZt0WYzofxUOwlVkOP4SMfummFz0JohLjyUMG2hc4Bts+/fazFgClVLl+aSGADZuaL50Q0M9aH54Z4Zpjd6WzSLPmM5tKiPJkFkuxcD9FyByJCaKF/DZedginjgyx4errz6IlSeDw+WroFKV34H6wD2mIN2k8gzgLY5NJRrGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=uB1yGnYt; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff04f36fd2so3081817a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 00:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741075493; x=1741680293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2IWM03uCc5JYKWNNYJj96+IBy7sBv7xRRZzd1A9ps0w=;
        b=uB1yGnYt3nM97Qr1NVwAK7ZcahUEGxHFKkn3EE8IhtowluWByz3o2SWuT7G9bepUHx
         F2Ci1Tbt0Ie+ZWDbJTe5sBn74/hI79f0DL5xBIIOCskZwqL6bpwtJHpNzGv7B9gcWVtY
         qQHrgUQhbk93H/cpPTehnKwO9n9DsoafDJH+OrcyU1qjPnMr1nBbLqwwx5Xm3mkJINHP
         XJ9TESVfOWQhlaKhm5ZpB7aDUZxzdUh+n5VqaZDOd0+21aV1oFBxR/1Q9j6oCDudiaXB
         w7Pl581uQZt9eRHvTD3Y95xFhq8al9SVIjpAJJLfnM27dNPgovgo/jJDTIHQVU/N2ljo
         +BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075493; x=1741680293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IWM03uCc5JYKWNNYJj96+IBy7sBv7xRRZzd1A9ps0w=;
        b=MJxloU2XX1YDX15yRxSqhdNz6l+1wSsEVOa/O8RJkkn8hL3IK3KM/t3DrkCyW3UtPG
         XUxGri+zg0z90II/QuuzFugwDwC91XiguUD3RUfTaj3d2Tccod0uqjA/u5Wh9YtN8tqZ
         kcL1StDo+fmmPbExy7AVjodANoOdNARjgIdxzwF9/cdeVQU68okkxSqGynmlKJrRZU/w
         kSwuHOxSDSx49v5Hqbo8DN/LercAWlgkdq6BNL1CRUFSZoWmEH6PgVzBNvrpfBmSQJQQ
         uF/myGHqSvTThP0iRPfcm6TOU3yuAl8BCMeTaEBoJcrBJavDSDoteAxhU5v7BCro7KYY
         mSZQ==
X-Gm-Message-State: AOJu0Yz3L7xl5WjS6CMLmju1Sy57LQbF5xz7XIk7nsv7h62G37/OO/86
	WRinDyblJF7MP5b7kKS60dlViBpOxpo5bWmDGWig9m9nbYB2hkCzjQYhtP1M7JpJYq1xRu8GZ84
	3
X-Gm-Gg: ASbGncvGwO+PJoa+nNZZ60Tw4T+JAJ7LrOjovXLP8jkUXTyrY8LlXR9C4IIbXCMw0W1
	YvobMb9xosZ+gTYDw96Jp8jJt47xKjrkbqGCxRLliY0Du8zEi7zWvcXmDOdS72QEz+mUUNmzjHS
	JREnGlHFEEn0DXUShX8UuTALIb20KjE7ZdoMiFPa01PB5lsp5+AjZ9g3PV+92BcWIArqlWFbS/N
	lMhyKfI+kT3aFigg6BnMvvB9N0ufxMQaGmOqCWRjet8rplkHv9Mls1NSo872dsmIS/eTgt36F5O
	mUpCRxuFS/E9XD2SgE5+OIgWU3rwaQuFaILljfIXEEYVcKZ2LiItSg/CY7F/Mf2VetnjrxA/xn6
	8nCWB/tlFZ4L8OyXYH8pa
X-Google-Smtp-Source: AGHT+IFe9Zc3h+PzOt2/R1Zum8oHpKhYLPC1O8wnL1CQkIAKtJtH+3obvn1mD+VkjcAd8E1tgDoKIw==
X-Received: by 2002:a17:90b:3b8d:b0:2ee:c91a:ad05 with SMTP id 98e67ed59e1d1-2febab2f8a2mr23927574a91.3.1741075493343;
        Tue, 04 Mar 2025 00:04:53 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d5584sm89381025ad.2.2025.03.04.00.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:04:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tpNGj-00000008fJK-0g4q;
	Tue, 04 Mar 2025 19:04:49 +1100
Date: Tue, 4 Mar 2025 19:04:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Changing reference counting rules for inodes
Message-ID: <Z8a0IeCpX8ypKfTy@dread.disaster.area>
References: <20250303170029.GA3964340@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303170029.GA3964340@perftesting>

On Mon, Mar 03, 2025 at 12:00:29PM -0500, Josef Bacik wrote:
> Hello,
> 
> I've recently gotten annoyed with the current reference counting rules that
> exist in the file system arena, specifically this pattern of having 0 referenced
> objects that indicate that they're ready to be reclaimed.

Which means you are now talking about inode life cycle issues :)

There is some recent relevant discussion here:

https://lore.kernel.org/linux-fsdevel/ZvNWqhnUgqk5BlS4@dread.disaster.area/

And here:

https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.com/

> This pattern consistently bites us in the ass, is error prone, gives us a lot of
> complicated logic around when an object is actually allowed to be touched versus
> when it is not.
> 
> We do this everywhere, with inodes, dentries, and folios, but I specifically
> went to change inodes recently thinking it would be the easiest, and I've run
> into a few big questions.  Currently I've got about ~30 patches, and that is
> mostly just modifying the existing file systems for a new inode_operation.
> Before I devote more time to this silly path, I figured it'd be good to bring it
> up to the group to get some input on what possible better solutions there would
> be.

I want to get rid of the inode cache (i.e. the unreferenced inodes
on the LRU) altogether. To do that, everything that needs the inode
to stay in memory (e.g. writeback) needs to hold an active reference
to the inode.

As you've noticed, there are lots of hacks in code that tries to
hang subsystem state/objects off the inode without taking an inode
reference.

> I'll try to make this as easy to follow as possible, but I spent a full day and
> a half writing code and thinking about this and it's kind of complicated.  I'll
> break this up into sections to try and make it easier to digest.
> 
> WHAT DO I WANT
> 
> I want to have refcount 0 == we're freeing the object.  This will give us clear
> "I'm using this object, thus I have a reference count on it" rules, and we can
> (hopefully) eliminate a lot of the complicated freeing logic (I_FREEING |
> I_WILL_FREE).

Yes. IMO, when iput_final() is called, the VFS inode should be kaput
never to be found again. Nothing in the VFS should be accessing it,
nor should any VFS level code be allowed to take a new reference to
it at that point in time.

> HOW DO I WANT TO DO THIS
> 
> Well obviously we keep a reference count always whenever we are using the inode,
> and we hold a reference when it is on a list.  This means the i_io_list holds a
> reference to the inode, that means the LRU list holds a reference to the inode.

Add to that list:

- fsnotify objects that are currently sweep from superblock teardown
  via an inode cache walk.
- LSM modules (e.g. landlock) that sweep state from superblock
  teardown via an inode cache walk.
- dquots
- writeback
- mapping tree containing folios (*)
- anything else that stores non-core state or private objects
  in/on the VFS inode.

(*) this is why __inode_add_lru() is such a mess and why I NACKed it
being used in the mm subsystem in the first place. The mm subsystem
uses this to prevent unreferenced inodes that have page cache
attached to them from being added to the LRU. Instead, the mm
subsystem has been allows to prevent unreferenced inodes from being
tracked by the VFS whilst the mm subsystem tracks and ages out mm
owned objects attached to the inodes.

The whole reason this was done  is to prevent the inode cache
shrinker from tossing inodes with cached pages before the workingset
aging mechanism decides the page cache needs to be tossed. But to do
this, games had to be played with the LRU because the places where
the mm wanted to mark the inode as "can be reclaimed" are places
where it is not safe to call iput()....

IOWs, any "all inode usage needs to be reference counted" is going
to have to solve this .... mess in some way....

> This makes LRU handling easier, we just walk the objects and drop our reference
> to the object. If it was truly the last reference then we free it, otherwise it
> will get added back onto the LRU list when the next guy does an iput().
> 
> POTENTIAL PROBLEM #1
> 
> Now we're actively checking to see if this inode is on the LRU list and
> potentially taking the lru list lock more often.  I don't think this will be the
> case, as we would check the inode flags before we take the lock, so we would
> martinally increase the lock contention on the LRU lock.

> We could mitigate this
> by doing the LRU list add at lookup time, where we already have to grab some of
> these locks, but I don't want to get into premature optimization territory here.
> I'm just surfacing it as a potential problem.

The inode cache (and the LRU) needs to go away. Reference count
everything so page cache residency doesn't trigger inode reclaim,
and otherwise the dentry cache LRU keeps the hot working set on
inodes in cache. There is no reason for maintaining a separately
aged inode cache these days....

> POTENTIAL PROBLEM #2
> 
> We have a fair bit of logic in writeback around when we can just skip writeback,
> which amounts to we're currently doing the final truncate on an inode with
> ->i_nlink set.  This is kind of a big problem actually, as we could no
> potentially end up with a large dirty inode that has an nlink of 0, and no
> current users, but would now be written back because it has a reference on it
> from writeback.  Before we could get into the iput() and clean everything up
> before writeback would occur.  Now writeback would occur, and then we'd clean up
> the inode.

Yup, an active/passive reference pattern.

> SOLUTION FOR POTENTIAL PROBLEM #1
> 
> I think we ignore this for now, get the patches written, do some benchmarking
> and see if this actually shows up in benchmarks.  If it does then we come up
> with strategies to resolve this at that point.

Oh, I pretty much guarantee moving away from lazy LRU management
will show up in any benchmark that stresses cold cache behaviour :/

> SOLUTION FOR POTENTIAL PROBLEM #2 <--- I would like input here
> 
> My initial thought was to just move the final unlink logic outside of evict, and

That's what XFS does - we don't actually process the final unlink
stage until after ->destroy_inode has been called. We defer that
processing to background inodegc workers (i.e. processed after
unlink() returns to userspace), and it all happens without the VFS
knowing anything about it.

> create a new reference count that represents the actual use of the inode.  Then
> when the actual use went to 0 we would do the final unlink, de-coupling the
> cleanup of the on-disk inode (in the case of local file systems) from the
> freeing of the memory.

Can we defer the final filesystem unlink processing like
XFS does? The filesystem effectively controls freeing of the inode
object, so it can live as long as the filesystem wants once the
VFS is actively done with it.

> This is a nice to have because the other thing that bites us occasionally is an
> iput() in a place where we don't necessarily want to be/is safe to do the final
> truncate on the inode.  This would allow us to do the final truncate at a time
> when it is safe to do so.

Yes, this is one of the reasons why XFS has traditionally done this
final unlink stage outside the VFS inode life cycle. We also do
cleanup of speculative prealloc outside the VFS inode life cycle via
the same code paths, too.

> However this means adding a different reference count to the inode.  I started
> to do this work, but it runs into some ugliness around ->tmpfile and file
> systems that don't use the normal inode caching things (bcachefs, xfs).  I do
> like this solution, but I'm not sure if it's worth the complexity.

We should be able to make it work just fine with XFS if it allows
decoupled cleanup. i.e. it is run via a new cleanup method that
would be called instead of ->destroy_inode, leaving the filesystem
to call destroy_inode() when it is done?

> The other solution here is to just say screw it, we'll just always writeback
> dirty inodes, and if they were unlinked then they get unlinked like always.  I
> think this is also a fine solution, because generally speaking if you've got
> memory pressure on the system and the file is dirty and still open, you'll be
> writing it back normally anyway.  But I don't know how people feel about this.
> 
> CONCLUSION
> 
> I'd love some feedback on my potential problems and solutions, as well as any
> other problems people may see.  If we can get some discussion beforehand I can
> finish up these patches and get some testing in before LSFMMBPF and we can have
> a proper in-person discussion about the realities of the patchset.  Thanks,

I think there's several overlapping issues here:

1. everything that stores state on/in the VFS inode needs to take a
   reference to the inode.
2. Hacks like "walk the superblock inode list to visit every cached
   inode without holding references to them" need to go away
3. inode eviction needs to be reworked to allow decoupled processing
   of the inode once all VFS references go away.
4. The inode LRU (i.e. unreferenced inode caching) needs to go away

Anything else I missed? :)

-Dave.
-- 
Dave Chinner
david@fromorbit.com

