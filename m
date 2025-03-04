Return-Path: <linux-fsdevel+bounces-43115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD9A4E294
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 16:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C2B189AA90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8755F27EC82;
	Tue,  4 Mar 2025 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Ygxssq9+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33027EC93
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100582; cv=none; b=LY0ak4eL0O9O61EPgT80OyZusP357TyBL5lCqioy8YUyFWgZ3/HHi8egxxTg2K6cjHfZ3J95GNYxqZz9PDyFKnSi1xqcO4WGYSacpOt6Pd7so0+WJ3cROI/7qI5bbFtzTvVtukFVK2cfVhu2hSbLXC6u/D8ydDKGR0tN2l4U2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100582; c=relaxed/simple;
	bh=L6jAEF4sY1Bcpf3hEZRl8hQKUmxE5fq2itytxDLUSBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nf/Q8nz+OElHnucALCRZSPnFoYVbpe4xu/GShtCTrMeya6m4esydNtPTQ/xH2E0OpZXSgzFO6XTR2Wzpu52p02cFaLPVjHsyTrjyDJcF+lcnBtzUb+x7Nov74O3Xpwc14NgqdH/je3kuqoqet7mZfWGnQI/HtsrZ6NBB6pp3TBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Ygxssq9+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e897847086so42496386d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 07:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1741100580; x=1741705380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xZXyPtz/VNuuwigmCfbDk5hUVqKpgA3/6AOvemq/IQ=;
        b=Ygxssq9+8cccbAjeytH/ctqVELITfd7wONIYD6mDoCbdslPJ6M/uKHS1Wu69SIlww+
         tZun3qSE+hQNnLZZixIlGY5BvGBYWooE0sgEfivqce1BvU5cd0TTVreB0rcODIEcJe9Y
         ZaEjctKypg3HDMz2vPN14brUzsgNlYmYrRCemdyVoXLO6uMkFdE94CzdGRzk2yP+h8FF
         ogRBppstz/HI4Wr+tLwOY7j8V1qBtC1+ZY6pgWF0CFadEALEGBlLPDCOTGVpXYufdQHx
         iq5X4hSHtQ2vrr9wdtFkbqW0lrj/H2Z4qnE9yQr0l/8/jS2/1z8zV1ToXFVd9slGwSc8
         BYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100580; x=1741705380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xZXyPtz/VNuuwigmCfbDk5hUVqKpgA3/6AOvemq/IQ=;
        b=IL+RgQsCLVFH/WDSum3dbzzYMbkKxT6FmLfuSNFZJ9zBGU0zcTE+0Hgd0rt1vIe0/Q
         SglFjfOpVUdKdQ4VE9CmwClvyqXRmeR3in/nuukoiQw8b6s2nwJhJe+PIqzCDERHwwdv
         +Hf3/asNE8/TGgjBN6PwZcQ/ogRG67aSAUnuJTRvqHtCLT5iB0RSLA2372msjlhtVz3d
         Ooxe2J7M7zAqIqSKOHb1ypEU8RWEH1eTUEaUBSFLT+j8OYdUBKcITEeMWZsi3jSIrr8j
         2bsjVd/mSc5BHzXjBiOce47JxfHHwvjay0WfTX34xlRXUNa5BATeGyeVu3fw58pre8w9
         SNUw==
X-Gm-Message-State: AOJu0YxL6JxyD1I576CWb7pBa1V/wN7bzRKzj/X18zJt9hbh1+FT26wi
	9ZYWxuaXsPtTpgtZwR0Quju55gGQW/EZVTkJD0uYfW62z3A/ydoCQiEyXjfV0P4=
X-Gm-Gg: ASbGnctqm8sYjuKGKbEsfZ/es7ZULAr3NbQMKK3P1FGHETIQmIQttBxGm1cCSpODQiX
	L2hbkecwkQEn3BwU5JGxBEQBi91J24hIEkOvht7AYuUqXvEU9Cfqx5qF7byxAlUKEisfzG9B036
	CQLuvAwqISmp8fSWpmwWflpl2WEDfFnpB2v/f5hwft2gRwfbWlyHQkfNGv6T7DwgGa8poeRLjHn
	AUcC62HvxkwIesceV/21aLJpidDXC68bG8DiQlfC6/0UvcjBBQ4pzeTMXhy44nNgBuW/Phg1VEF
	3Lyg2/yvftMZHEs4mUJJ3NuUPpNtu/9KEZHqUwtr0G0dJSVwQwY1xlGTlRD4+4CI5s4z9iAe/NC
	hgjX6iA==
X-Google-Smtp-Source: AGHT+IGUchWVahNn+RIRkEEpXVgHHpPATFFFUVPUbsexoZkAtrtLv9WS2oqWbDioOOGE8qqoFj65JA==
X-Received: by 2002:a05:6214:21e7:b0:6e8:952a:240 with SMTP id 6a1803df08f44-6e8a0d85c81mr250879126d6.32.1741100579359;
        Tue, 04 Mar 2025 07:02:59 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897651074sm67848746d6.29.2025.03.04.07.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:02:58 -0800 (PST)
Date: Tue, 4 Mar 2025 10:02:57 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Changing reference counting rules for inodes
Message-ID: <20250304150257.GB4043425@perftesting>
References: <20250303170029.GA3964340@perftesting>
 <Z8a0IeCpX8ypKfTy@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8a0IeCpX8ypKfTy@dread.disaster.area>

On Tue, Mar 04, 2025 at 07:04:49PM +1100, Dave Chinner wrote:
> On Mon, Mar 03, 2025 at 12:00:29PM -0500, Josef Bacik wrote:
> > Hello,
> > 
> > I've recently gotten annoyed with the current reference counting rules that
> > exist in the file system arena, specifically this pattern of having 0 referenced
> > objects that indicate that they're ready to be reclaimed.
> 
> Which means you are now talking about inode life cycle issues :)
> 
> There is some recent relevant discussion here:
> 
> https://lore.kernel.org/linux-fsdevel/ZvNWqhnUgqk5BlS4@dread.disaster.area/
> 
> And here:
> 
> https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.com/
> 
> > This pattern consistently bites us in the ass, is error prone, gives us a lot of
> > complicated logic around when an object is actually allowed to be touched versus
> > when it is not.
> > 
> > We do this everywhere, with inodes, dentries, and folios, but I specifically
> > went to change inodes recently thinking it would be the easiest, and I've run
> > into a few big questions.  Currently I've got about ~30 patches, and that is
> > mostly just modifying the existing file systems for a new inode_operation.
> > Before I devote more time to this silly path, I figured it'd be good to bring it
> > up to the group to get some input on what possible better solutions there would
> > be.
> 
> I want to get rid of the inode cache (i.e. the unreferenced inodes
> on the LRU) altogether. To do that, everything that needs the inode
> to stay in memory (e.g. writeback) needs to hold an active reference
> to the inode.
> 
> As you've noticed, there are lots of hacks in code that tries to
> hang subsystem state/objects off the inode without taking an inode
> reference.
> 
> > I'll try to make this as easy to follow as possible, but I spent a full day and
> > a half writing code and thinking about this and it's kind of complicated.  I'll
> > break this up into sections to try and make it easier to digest.
> > 
> > WHAT DO I WANT
> > 
> > I want to have refcount 0 == we're freeing the object.  This will give us clear
> > "I'm using this object, thus I have a reference count on it" rules, and we can
> > (hopefully) eliminate a lot of the complicated freeing logic (I_FREEING |
> > I_WILL_FREE).
> 
> Yes. IMO, when iput_final() is called, the VFS inode should be kaput
> never to be found again. Nothing in the VFS should be accessing it,
> nor should any VFS level code be allowed to take a new reference to
> it at that point in time.
> 
> > HOW DO I WANT TO DO THIS
> > 
> > Well obviously we keep a reference count always whenever we are using the inode,
> > and we hold a reference when it is on a list.  This means the i_io_list holds a
> > reference to the inode, that means the LRU list holds a reference to the inode.
> 
> Add to that list:
> 
> - fsnotify objects that are currently sweep from superblock teardown
>   via an inode cache walk.
> - LSM modules (e.g. landlock) that sweep state from superblock
>   teardown via an inode cache walk.
> - dquots
> - writeback
> - mapping tree containing folios (*)
> - anything else that stores non-core state or private objects
>   in/on the VFS inode.
> 
> (*) this is why __inode_add_lru() is such a mess and why I NACKed it
> being used in the mm subsystem in the first place. The mm subsystem
> uses this to prevent unreferenced inodes that have page cache
> attached to them from being added to the LRU. Instead, the mm
> subsystem has been allows to prevent unreferenced inodes from being
> tracked by the VFS whilst the mm subsystem tracks and ages out mm
> owned objects attached to the inodes.
> 
> The whole reason this was done  is to prevent the inode cache
> shrinker from tossing inodes with cached pages before the workingset
> aging mechanism decides the page cache needs to be tossed. But to do
> this, games had to be played with the LRU because the places where
> the mm wanted to mark the inode as "can be reclaimed" are places
> where it is not safe to call iput()....
> 
> IOWs, any "all inode usage needs to be reference counted" is going
> to have to solve this .... mess in some way....
> 
> > This makes LRU handling easier, we just walk the objects and drop our reference
> > to the object. If it was truly the last reference then we free it, otherwise it
> > will get added back onto the LRU list when the next guy does an iput().
> > 
> > POTENTIAL PROBLEM #1
> > 
> > Now we're actively checking to see if this inode is on the LRU list and
> > potentially taking the lru list lock more often.  I don't think this will be the
> > case, as we would check the inode flags before we take the lock, so we would
> > martinally increase the lock contention on the LRU lock.
> 
> > We could mitigate this
> > by doing the LRU list add at lookup time, where we already have to grab some of
> > these locks, but I don't want to get into premature optimization territory here.
> > I'm just surfacing it as a potential problem.
> 
> The inode cache (and the LRU) needs to go away. Reference count
> everything so page cache residency doesn't trigger inode reclaim,
> and otherwise the dentry cache LRU keeps the hot working set on
> inodes in cache. There is no reason for maintaining a separately
> aged inode cache these days....
> 
> > POTENTIAL PROBLEM #2
> > 
> > We have a fair bit of logic in writeback around when we can just skip writeback,
> > which amounts to we're currently doing the final truncate on an inode with
> > ->i_nlink set.  This is kind of a big problem actually, as we could no
> > potentially end up with a large dirty inode that has an nlink of 0, and no
> > current users, but would now be written back because it has a reference on it
> > from writeback.  Before we could get into the iput() and clean everything up
> > before writeback would occur.  Now writeback would occur, and then we'd clean up
> > the inode.
> 
> Yup, an active/passive reference pattern.
> 
> > SOLUTION FOR POTENTIAL PROBLEM #1
> > 
> > I think we ignore this for now, get the patches written, do some benchmarking
> > and see if this actually shows up in benchmarks.  If it does then we come up
> > with strategies to resolve this at that point.
> 
> Oh, I pretty much guarantee moving away from lazy LRU management
> will show up in any benchmark that stresses cold cache behaviour :/
> 
> > SOLUTION FOR POTENTIAL PROBLEM #2 <--- I would like input here
> > 
> > My initial thought was to just move the final unlink logic outside of evict, and
> 
> That's what XFS does - we don't actually process the final unlink
> stage until after ->destroy_inode has been called. We defer that
> processing to background inodegc workers (i.e. processed after
> unlink() returns to userspace), and it all happens without the VFS
> knowing anything about it.
> 
> > create a new reference count that represents the actual use of the inode.  Then
> > when the actual use went to 0 we would do the final unlink, de-coupling the
> > cleanup of the on-disk inode (in the case of local file systems) from the
> > freeing of the memory.
> 
> Can we defer the final filesystem unlink processing like
> XFS does? The filesystem effectively controls freeing of the inode
> object, so it can live as long as the filesystem wants once the
> VFS is actively done with it.
> 
> > This is a nice to have because the other thing that bites us occasionally is an
> > iput() in a place where we don't necessarily want to be/is safe to do the final
> > truncate on the inode.  This would allow us to do the final truncate at a time
> > when it is safe to do so.
> 
> Yes, this is one of the reasons why XFS has traditionally done this
> final unlink stage outside the VFS inode life cycle. We also do
> cleanup of speculative prealloc outside the VFS inode life cycle via
> the same code paths, too.
> 
> > However this means adding a different reference count to the inode.  I started
> > to do this work, but it runs into some ugliness around ->tmpfile and file
> > systems that don't use the normal inode caching things (bcachefs, xfs).  I do
> > like this solution, but I'm not sure if it's worth the complexity.
> 
> We should be able to make it work just fine with XFS if it allows
> decoupled cleanup. i.e. it is run via a new cleanup method that
> would be called instead of ->destroy_inode, leaving the filesystem
> to call destroy_inode() when it is done?
> 
> > The other solution here is to just say screw it, we'll just always writeback
> > dirty inodes, and if they were unlinked then they get unlinked like always.  I
> > think this is also a fine solution, because generally speaking if you've got
> > memory pressure on the system and the file is dirty and still open, you'll be
> > writing it back normally anyway.  But I don't know how people feel about this.
> > 
> > CONCLUSION
> > 
> > I'd love some feedback on my potential problems and solutions, as well as any
> > other problems people may see.  If we can get some discussion beforehand I can
> > finish up these patches and get some testing in before LSFMMBPF and we can have
> > a proper in-person discussion about the realities of the patchset.  Thanks,
> 
> I think there's several overlapping issues here:
> 
> 1. everything that stores state on/in the VFS inode needs to take a
>    reference to the inode.
> 2. Hacks like "walk the superblock inode list to visit every cached
>    inode without holding references to them" need to go away
> 3. inode eviction needs to be reworked to allow decoupled processing
>    of the inode once all VFS references go away.
> 4. The inode LRU (i.e. unreferenced inode caching) needs to go away
> 
> Anything else I missed? :)

Nope that's all what I've got on my list.  I want to run my plan for decoupling
the inode eviction by you before I send my patches out to see if you have a
better idea.  I know XFS has all this delaying stuff, but a lot of file systems
don't have that infrastructure, and I don't want to go around adding it to
everybody, so I still want to have a VFS hook way to do the final truncate.  The
question is where to put it, and will it at the very least not mess you guys up,
or in the best case be useful.

We're agreed on the active/passive refcount, so the active refcount will be the
arbiter of when we can do the final truncate.  My current patchset adds a new
->final_unlink() method to the inode_operations, and if it's set we call it when
the active refcount goes to 0.  Obviously a passive refcount is still held on
the inode while this operation is occurring.

I just want to spell it out, because some of what you've indicated is you want
the file system to control when the final unlink happens, even outside of the
VFS. I'm not sure if you intend to say that it happens without a struct inode,
or you just mean that we'll delay it for whenever the file system wants to do
it, and we'll be holding the struct inode for that entire time. I'm assuming
it's the latter, but I just want to be sure I understand what you're saying
before I send patches and do something different and then you think I'm ignoring
you.  Thanks,

Josef

