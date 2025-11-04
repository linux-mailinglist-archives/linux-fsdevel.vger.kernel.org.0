Return-Path: <linux-fsdevel+bounces-67012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 529F4C33675
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 00:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9407189CD0C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 23:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17233348445;
	Tue,  4 Nov 2025 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf69R+tQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C95F347BBC;
	Tue,  4 Nov 2025 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299505; cv=none; b=kA+7nTohmKNxNsqchywktUOa/w9YYReN13EVZa4qVfODEiOCl/eOXXv1YWovzlLvzd/AhNdyslGJoUjlRsMj6jrsxm9FLRfZ/rjfsCfPTSh9MahoTtMWMJMKW6sSHawblpzzXztye5rtK56Y6KvploZ4LGFHYDjlgr8X4XpIyp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299505; c=relaxed/simple;
	bh=tJcYkVr7LDCJ3MMs5R6illjOG3OtSdYUQ0177dtNWZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi1Ey9ywAnYcdKFZrEVWFT2Hulod0v7LjrEJyzPBLSm7TCZNQCGWTc7lcY90gI+t/sUgTH2ZiB6BpniUERphS/MvkWyB8nCgfUQmmtXwX7ER+Sdc742RM0aAofCK4r5WTrXaZwRsRyBfd3tJwy2zoBKjUqpEoxHFfp6e3dzMe7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf69R+tQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A562CC4CEF7;
	Tue,  4 Nov 2025 23:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762299504;
	bh=tJcYkVr7LDCJ3MMs5R6illjOG3OtSdYUQ0177dtNWZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bf69R+tQbvoJJc0RLl9XP2yy03u+QbW76n0pXCeLTt4k21stSTQLGIfFCFkPgQ8wr
	 xjByoqA7J03Ezw4oQ1gFjVlemtqgC8X3ekeY0ngiO18CkRnq0BgNr3724p7SawDRr0
	 pINZzgqhVjY6vAX/P3BQ0wl/7Wv4mqE1hkELAV28qBDh2jF4epW7BBQlUUQfoHP4St
	 CVldaiJhf4RI9Tv1aX4GuHvO+D5PYMfIKw47sXuEDYcshMVEmDtC/Tdy8fe60aAzXq
	 KxEjpkZqFI8xy2BPoIR031tGqioAaBazMmRW297lx8gZnlJJLgSqbRBK/EyrVPDmNM
	 v8cLinDTB4/Cg==
Date: Tue, 4 Nov 2025 15:38:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Keith Busch <kbusch@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <20251104233824.GO196370@frogsfrogsfrogs>
References: <20251029071537.1127397-1-hch@lst.de>
 <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
 <20251030143324.GA31550@lst.de>
 <aQPyVtkvTg4W1nyz@dread.disaster.area>
 <20251031130050.GA15719@lst.de>
 <aQTcb-0VtWLx6ghD@kbusch-mbp>
 <20251031164701.GA27481@lst.de>
 <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj>
 <20251103122111.GA17600@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103122111.GA17600@lst.de>

On Mon, Nov 03, 2025 at 01:21:11PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 03, 2025 at 12:14:06PM +0100, Jan Kara wrote:
> > > Yes, it's pretty clear that the result in non-deterministic in what you
> > > get.  But that result still does not result in corruption, because
> > > there is a clear boundary ( either the sector size, or for NVMe
> > > optionally even a larger bodunary) that designates the atomicy boundary.
> > 
> > Well, is that boundary really guaranteed? I mean if you modify the buffer
> > under IO couldn't it happen that the DMA sees part of the sector new and
> > part of the sector old? I agree the window is small but I think the real
> > guarantee is architecture dependent and likely cacheline granularity or
> > something like that.
> 
> If you actually modify it: yes.  But I think Keith' argument was just
> about regular racing reads vs writes.
> 
> > > pretty clearly not an application bug.  It's also pretty clear that
> > > at least some applications (qemu and other VMs) have been doings this
> > > for 20+ years.
> > 
> > Well, I'm mostly of the opinion that modifying IO buffers in flight is an
> > application bug (as much as most current storage stacks tolerate it) but on
> > the other hand returning IO errors later or even corrupting RAID5 on resync
> > is, in my opinion, not a sane error handling on the kernel side either so I
> > think we need to do better.
> 
> Yes.  Also if you look at the man page which is about official as it gets
> for the semantics you can't find anything requiring the buffers to be
> stable (but all kinds of other odd rants).
> 
> > I also think the performance cost of the unconditional bounce buffering is
> > so heavy that it's just a polite way of pushing the app to do proper IO
> > buffer synchronization itself (assuming it cares about IO performance but
> > given it bothered with direct IO it presumably does). 
> >
> > So the question is how to get out of this mess with the least disruption
> > possible which IMO also means providing easy way for well-behaved apps to
> > avoid the overhead.
> 
> Remember the cases where this matters is checksumming and parity, where
> we touch all the cache lines anyway and consume the DRAM bandwidth,
> although bounce buffering upgrades this from pure reads to also writes.
> So the overhead is heavy, but if we handle it the right way, that is
> doing the checksum/parity calculation while the cache line is still hot
> it should not be prohibitive.  And getting this right in the direct
> I/O code means that the low-level code could stop bounce buffering
> for buffered I/O, providing a major speedup there.
> 
> I've been thinking a bit more on how to better get the copy close to the
> checksumming at least for PI, and to avoid the extra copies for RAID5
> buffered I/O. M maybe a better way is to mark a bio as trusted/untrusted
> so that the checksumming/raid code can bounce buffer it, and I start to
> like that idea.  A complication is that PI could relax that requirement
> if we support PI passthrough from userspace (currently only for block
> device, but I plan to add file system support), where the device checks
> it, but we can't do that for parity RAID.

IIRC, a PI disk is supposed to check the supplied CRC against the
supplied data, and fail the write if there's a discrepancy, right?  In
that case, an application can't actually corrupt its own data because
hardware will catch it.

For reads, the kernel will check the supplied CRC against the data
buffer, right?  So a program can blow itself up, but that only affects
the buggy program.

I think that means the following:

A. We can allow mutant directio to non-PI devices because buggy programs
   can only screw themselves over.  Not great but we've allowed this
   forever.

B. We can also allow it to PI devices because those buggy programs will
   get hit with EIOs immediately.

C. Mutant directio reads from a RAID1/5 on non-PI devices are ok-ish
   because the broken application can decide to retry and that's just
   wasting resources.

D. Mutant directio reads from a RAID1/5 on PI devices are not good
   because the read failure will result in an unnecessary rebuild, which
   could turn really bad if the other disks are corrupt.

E. Mutant directio writes to a RAID5 are bad bad bad because you corrupt
   the stripe and now unsuspecting users on other strips lose data.

I think the btrfs corruption problems are akin to a RAID5 where you can
persist the wrong CRC to storage and you'll only see it on re-read; but
at least the blast is contained to the buggy application's file.

I wonder if that means we really need a way to convey the potential
damage of a mutant write through the block layer / address space so that
the filesystem can do the right thing?  IOWs, instead of a single
stable-pages flag, something along the lines of:

enum mutation_blast_radius {
	/* nobody will notice a thing */
	MBR_UNCHECKED,

	/* program doing the corruption will notice */
	MBR_BADAPP,

	/* everyone else's data get corrupted too */
	MBR_EVERYONE,
};

AS_STABLE_WRITES is set for MBR_BADAPP and MBR_EVERYONE, and the
directio -> dontcache flag change is done for a write to a MBR_EVERYONE
bdev.

Hm?

--D

