Return-Path: <linux-fsdevel+bounces-32927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166B09B0D4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8688428585D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 18:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F2020EA48;
	Fri, 25 Oct 2024 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I90BXuWw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC818BC0E;
	Fri, 25 Oct 2024 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880939; cv=none; b=baTGtaiS5oMO148QJnLlwZkxbt5+4qnNTcqyAt04GOTcCQerTNNW8d7VRyWaCt8BQ2P9jODd9OUXZFOjqgjgDTtso/44w1W+BAV4TzJcbspi3jEptKHVcOagZsjao8RbAjCMvMoKRkbyJbE57yu49JC5mC5x7l+1QoR0QkgDM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880939; c=relaxed/simple;
	bh=4I5j/AD/SHyvVngXf3BZWdCJ3TDjPt4eufqTQIN4w4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr8qFSjFOH+6IKfIqAxgWtehbwU/J61CVDHUJp5p240su5dNkV/UwkWUdRuO+nJJL5YXLOCKdgMLV9cue4VsqDs8CPuxjvSXgniw4lNBSMe7geaWoiVysm1U+sMGxfvAdnoYCKqkqbsQkgKc9bq7cBrEiQ2IT9KCcs9au6l1BEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I90BXuWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D37EC4CEC3;
	Fri, 25 Oct 2024 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729880939;
	bh=4I5j/AD/SHyvVngXf3BZWdCJ3TDjPt4eufqTQIN4w4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I90BXuWwgNxNtrqopdGcOJ+EuLNWitTQHGhiZil9bY7xmT/9uQNuR6ZJ4KNv5Xzp0
	 /fQsBOnlVCZoi3b+QS4DKsBoEMP6tENQtN8vTSEg6Wgxo8SV2NUPphpwvgdJLHsekv
	 K2/gDtMnWqgNy+V7k/5Nzt5kF9AOXu+vivinHhFOpo+NEzADZ5KQ8WMZwpTg29fZT/
	 U5VAiqJqeb1OarCTTXePvKQbCYy3n89QaviuyyvcXAy5Rf+xZGy/3UibgHAsXFHKUn
	 4YDmc6i0qS7FmP/SEi5fBLpGe9WCoPnVcK1fm2gmzBRwGLw8KkswBAaKeaQCf97maS
	 7OFN9PXJIF0aw==
Date: Fri, 25 Oct 2024 11:28:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
Message-ID: <20241025182858.GM2386201@frogsfrogsfrogs>
References: <1efb8d6d-ba2e-499d-abc5-e4f9a1e54e89@oracle.com>
 <87zfmsmsvc.fsf@gmail.com>
 <fc6fddee-2707-4cca-b0b7-983c8dd17e16@oracle.com>
 <87v7xgmpwo.fsf@gmail.com>
 <7e322989-c6e0-424a-94bd-3ad6ce5ffee9@oracle.com>
 <87ttd0mnuo.fsf@gmail.com>
 <7aea00d4-3914-414d-a18f-586a303868c1@oracle.com>
 <87r084mkat.fsf@gmail.com>
 <509180f3-4cc1-4cc2-9d43-5a1e728fb718@oracle.com>
 <87plnomfsy.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plnomfsy.fsf@gmail.com>

On Fri, Oct 25, 2024 at 07:43:17PM +0530, Ritesh Harjani wrote:
> John Garry <john.g.garry@oracle.com> writes:
> 
> > On 25/10/2024 13:36, Ritesh Harjani (IBM) wrote:
> >>>> So user will anyway will have to be made aware of not to
> >>>> attempt writes of fashion which can cause them such penalties.
> >>>>
> >>>> As patch-6 mentions this is a base support for bs = ps systems for
> >>>> enabling atomic writes using bigalloc. For now we return -EINVAL when we
> >>>> can't allocate a continuous user requested mapping which means it won't
> >>>> support operations of types 8k followed by 16k.
> >>>>
> >>> That's my least-preferred option.
> >>>
> >>> I think better would be reject atomic writes that cover unwritten
> >>> extents always - but that boat is about to sail...
> >> That's what this patch does.
> >
> > Not really.
> >
> > Currently we have 2x iomap restrictions:
> > a. mapping length must equal fs block size
> > b. bio created must equal total write size
> >
> > This patch just says that the mapping length must equal total write size 
> > (instead of a.). So quite similar to b.
> >
> >> For whatever reason if we couldn't allocate
> >> a single contiguous region of requested size for atomic write, then we
> >> reject the request always, isn't it. Or maybe I didn't understand your comment.
> >
> > As the simplest example, for an atomic write to an empty file, there 
> > should only be a single mapping returned to iomap_dio_bio_iter() and 
> > that would be of IOMAP_UNWRITTEN type. And we don't reject that.
> >
> 
> Ok. Maybe this is what I am missing. Could you please help me understand
> why should such writes be rejected? 
> 
> For e.g. 
> If FS could allocate a single contiguous IOMAP_UNWRITTEN extent of
> atomic write request size, that means - 
> 1. FS will allocate an unwritten extent.
> 2. will do writes (using submit_bio) to the unwritten extent. 
> 3. will do unwritten to written conversion. 
> 
> It is ok if either of the above operations fail right? If (3) fails
> then the region will still be marked unwritten that means it will read
> zero (old contents). (2) can anyway fail and will not result into
> partial writes. (1) will anyway not result into any write whatsoever.
> 
> So we can never have a situation where there is partial writes leading
> to mix of old and new write contents right for such cases? Which is what the
> requirement of atomic/untorn write also is?
> 
> Sorry am I missing something here?

I must be missing something; to perform an untorn write, two things must
happen --

1. The kernel writes the data to the storage device, and the storage
device either persists all of it, or throws back an error having
persisted none of it.

2. If (1) completes successfully, all file mapping updates for the range
written must be persisted, or an error is thrown back and none of them
are persisted.

iomap doesn't have to know how the filesystem satisfies (2); it just has
to create a single bio containing all data pages or it rejects the
write.

Currently, it's an implementation detail that the XFS directio write
ioend code processes the file mapping updates for the range written by
walking every extent mapping for that range and issuing separate
transactions for each mapping update.  There's nothing that can restart
the walk if it is interrupted.  That's why XFS cannot support multi
fsblock untorn writes to blocks with different status.

As I've said before, the most general solution to this would be to add a
new log intent item that would track the "update all mappings in this
file range" operation so that recovery could restart the walk.  This is
the most technically challenging, so we decided not to implement it
until there is demand.

Having set aside the idea of redesigning ioend, the second-most general
solution is pre-zeroing unwritten extents and holes so that
->iomap_begin implementations can present a single mapping to the bio
constructor.  Technically if there's only one unwritten extent or hole
or cow, xfs can actually satisfy (2) because it only creates one
transaction.

This gets me to the third and much less general solution -- only allow
untorn writes if we know that the ioend only ever has to run a single
transaction.  That's why untorn writes are limited to a single fsblock
for now -- it's a simple solution so that we can get our downstream
customers to kick the tires and start on the next iteration instead of
spending years on waterfalling.

Did you notice that in all of these cases, the capabilities of the
filesystem's ioend processing determines the restrictions on the number
and type of mappings that ->iomap_begin can give to iomap?

Now that we have a second system trying to hook up to the iomap support,
it's clear to me that the restrictions on mappings are specific to each
filesystem.  Therefore, the iomap directio code should not impose
restrictions on the mappings it receives unless they would prevent the
creation of the single aligned bio.

Instead, xfs_direct_write_iomap_begin and ext4_iomap_begin should return
EINVAL or something if they look at the file mappings and discover that
they cannot perform the ioend without risking torn mapping updates.  In
the long run, ->iomap_begin is where this iomap->len <= iter->len check
really belongs, but hold that thought.

For the multi fsblock case, the ->iomap_begin functions would have to
check that only one metadata update would be necessary in the ioend.
That's where things get murky, since ext4/xfs drop their mapping locks
between calls to ->iomap_begin.  So you'd have to check all the mappings
for unsupported mixed state every time.  Yuck.

It might be less gross to retain the restriction that iomap accepts only
one mapping for the entire file range, like Ritesh has here.  Users
might be ok with us saying that you can't do a 16k atomic write to a
region where you previously did an 8k write until you write the other
8k, even if someone has to write zeroes.  Users might be ok with the
kernel allowing multi-fsblock writes but only if the stars align.  But
to learn the answers to those questions, we have to put /something/ in
the hands of our users.

For now (because we're already at -rc5), let's have xfs/ext4's
->write_iter implementations restrict atomic writes to a single fsblock,
and get both merged into the kernel.  Let's defer the multi fsblock work
to 6.14, though I think we could take this patch.

Does that sound cool?

--D

> >> 
> >> If others prefer - we can maybe add such a check (e.g. ext4_dio_atomic_write_checks())
> >> for atomic writes in ext4_dio_write_checks(), similar to how we detect
> >> overwrites case to decide whether we need a read v/s write semaphore.
> >> So this can check if the user has a partially allocated extent for the
> >> user requested region and if yes, we can return -EINVAL from
> >> ext4_dio_write_iter() itself.
> >  > > I think this maybe better option than waiting until ->iomap_begin().
> >> This might also bring all atomic write constraints to be checked in one
> >> place i.e. during ext4_file_write_iter() itself.
> >
> > Something like this can be done once we decide how atomic writing to 
> > regions which cover mixed unwritten and written extents is to be handled.
> 
> Mixed extent regions (written + unwritten) is a different case all
> together (which can lead to mix of old and new contents).
> 
> 
> But here what I am suggesting is to add following constraint in case of
> ext4 with bigalloc - 
> 
> "Writes to a region which already has partially allocated extent is not supported."
> 
> That means we will return -EINVAL if we detect above case in
> ext4_file_write_iter() and sure we can document this behavior.
> 
> In retrospect, I am not sure why we cannot add a constraint for atomic
> writes (e.g. for ext4 bigalloc) and reject such writes outright,
> instead of silently incurring a performance penalty by zeroing out the
> partial regions by allowing such write request.
> 
> -ritesh
> 

