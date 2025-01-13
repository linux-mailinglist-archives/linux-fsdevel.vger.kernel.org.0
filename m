Return-Path: <linux-fsdevel+bounces-39039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAB2A0B8EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457967A0F53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9F34315E;
	Mon, 13 Jan 2025 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="BZ9TjYCo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C6C8C5
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776832; cv=none; b=o2vvFpfgOsiRyRqGOaGoFCLjzD8W2vOnEDNvFXpJcEAMHg9DHzr9njEErYNIfekIkpub1unPYNhgL1mVyNYMK9IxrKCm2Xu5KnRYgWMmF9T0OWREDvrvBoD+VcNLV2DRtXhNs5gDdwBogRo1VsF8cLcqu0EuJnS6Iim5Y32CBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776832; c=relaxed/simple;
	bh=HCXCLSRJ4EWzxPdtQ66q47NEva7/bUZUVM4oB2O3Osc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOmf1kduSf7ooYKfE1wKWruedLsyljmGM521AUiI8ScBmRSIBT5rbMu4SRnTJj5hs69lZxR/C004grDUycDcriI6HVKL7D7dtglLoR8iU695b6Wxv6MCekC+T1D+7TalndiPF8rdZQeXtPR3HA6b12BuU5t9wZiK9aFZDkIirCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=BZ9TjYCo; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-229.bstnma.fios.verizon.net [173.48.82.229])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50DE0HBq031568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 09:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736776819; bh=H6kpABhrU/SmhSl+upIqMH180TtoypHJJNULAlIGorQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=BZ9TjYCoJtUdob9zvg3BqQWwGvfp8YCiXhYBvZjCGG7czPUeYId3o0ak+nwyTbLnB
	 TODOEdTxD4lzfpafwhFyfiCyQJdjkD9sYc6DhNeEr00/XiJwsDPz26spFEs8xQ9PFi
	 QYlSIT2etC4TPdoIQo3fx4+WmJtTHaOrAJ4IlJnRlhQMi2xufCnO09HAGEUQgfTLAH
	 KWqiCJW7QHnCV+CFCxIgTmo7/dHR35UIkA3h12LrGKrP0ukdOA32bxGzMfm2uTckXT
	 54a/AQqW23whErKIXWuzEckSudmadwElHQBH5XpsHELI/aLI2j19EzTyljgT0+dycI
	 WwkNjmxv9X6cg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A94EA15C0135; Mon, 13 Jan 2025 09:00:17 -0500 (EST)
Date: Mon, 13 Jan 2025 09:00:17 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Spooling large metadata updates / Proposal for a new API/feature
 in the Linux Kernel (VFS/Filesystems):
Message-ID: <20250113140017.GC1514771@mit.edu>
References: <ba4f3df5-027b-405e-8e6e-a3630f7eef93@gmx.com>
 <20250112052743.GH1323402@mit.edu>
 <8a395f69-ce4a-418a-b4a9-30ed83e0fbef@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a395f69-ce4a-418a-b4a9-30ed83e0fbef@gmx.com>

On Mon, Jan 13, 2025 at 07:41:53AM +0000, Artem S. Tashkinov wrote:
> Let's say you chmod two files sequentially:
> 
> What's happening:
> 
> 1) the kernel looks up an inode
> 2) the kernel then updates the metadata (at the very least one logical
> block is being written, that's 4K bytes)
> 
> ditto for the second file.
> 
> Now let's say we are updating 10000 files.
> 
> Does this mean that at least 40MB of data will be written, when probably
> less than 500KB needs to be written to disk?

No, for pretty much all file systems, we don't force the data to be
written when you do a chmod.  This is true for both journalled and
non-journalled file systems.  For a non-journalled file system, we
will modify the in-memory inode structure, and we will wait until the
buffer cache writeback (typically 30 seconds after the block was first
dirtied) before the metadata block is written back.  So if you modify
the same block 32 times for 32 inodes, it won't get written until 30
seconds go by.  So as long as you actually complete the chmod -R
operation within 30 seconds, you'll be fine.

For non-journalled file system, the disk writes won't take place until
the transaction close time takes place, which is 5 seconds (by
default) before the transaction closes.

> == Issue number two ==
> 
> At least when you write data to the disk, the kernel doesn't flush it
> immediately and your system remains responsive due to the use of dirty
> buffers.
> 
> For operations involving metadata updates, the kernel may not have this
> luxury, because the system must be in a consistent state even if it's
> accidentally or intentionally powered off.
> 
> So, metadata updates must be carried out immediately, and they can bring
> the system to a halt while flushing the above 40MB of data, as opposed
> to the 500KB that needs to be updated in terms of what is actually being
> updated on disk.

Nope; POSIX does not require this.  As described above, there will be
a certain amount of file system updates that won't be completed if
someone kicks the power plug out of the wall and the system has an
unclean shutdown.

> So, the feature I'm looking for would be to say to the kernel: hey I'm
> about to batch 10000 operations, please be considerate, do your thing in
> one fell swoop while optimizing intermediate operations or writes to the
> disk, and there's no rush, so you may as well postpone the whole thing
> as much as you want.

This is what the kernel *always* does.  It's what all system has done
for decades, including in legacy Unix systems, and it's what people
have always expected and programmers who want something better (e.g.,
databases providing ACID guarantees) will use fsync(2) and explicitly
tell the kernel that reliability is more important than performance or
flash durability (all of the extra writes means extra write cycles,
leading to more write cycles and decreasing the lifespan of SSD's and
newer HDD's with HAMR or MAMR where the laser or masers built in the
HDD heads can wear out --- this is why newer HDD's have write limits
in their warantees.  Fortunately, this is what storage specialists at
hyperscaler cloud companies worry about so you don't have to.)

You can force metadata to be written out by using the sync(2),
fsync(2) or syncfs(2) system calls, but we don't optimize for the
uncommon case where someone might yank the power out or the kernel
crashes unexpectedly.

Cheers,

	       		       	   - Ted

