Return-Path: <linux-fsdevel+bounces-33372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C66ED9B8569
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 22:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B3C1C216E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 21:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43791CCB36;
	Thu, 31 Oct 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScDkG2Dc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1727C13C9B8;
	Thu, 31 Oct 2024 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410602; cv=none; b=l239bj9t0QC1/0lEoCLQNJ94JxGe0IVm58j1LJgGONkS58J7ZWlVU2iegCwBZVFZKyI1dOC7qqwKgMMUt1XlY2/S0qPDCG8S6tHs+3CqWVDtvRmeO6fcjnwCz9JpolEBBzQafT+LeMxVLlypLInhAVKSFB6vygvqwkPej5/9j6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410602; c=relaxed/simple;
	bh=Hhb9PnYKWfCqNVzkuy+HjAehT9iVXkzZwdZ2m8mSnGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4AOG5TB0TuVt1QOoCeuNuLCtMPPSyKBn9eFgIdYkj3TWJzXou7hi6xzQZ3wlMGdCkK81btUV5yWwBRzeaH3DtI0+/u72XyfSXdvbbb4vO4h3huQ03HfOLZKqt4P+sEwGjEVysHQFusPX0biZCsJ+94wFWXwerAmvTH8ObEtyaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScDkG2Dc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E77C4CECF;
	Thu, 31 Oct 2024 21:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730410601;
	bh=Hhb9PnYKWfCqNVzkuy+HjAehT9iVXkzZwdZ2m8mSnGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ScDkG2Dcn+IFkpGqZrISI4vjpzidzUmvQMjHXjdmAMU37l2safHHLNV9uRN/QpgoG
	 zbU4AGyXJAzy/1BFHlIlsLjZvy6sqNYhHZF5sM+2NNeiRJzdZXuy2FjiBGILdc2Yhj
	 Zgk4Wf/zipgEc4EP6RxQrKyb0gGlFMkhsWuUrAQo5PNokq5yH754lpbbIsSOCmxO8b
	 0NxbTpE6Xlm9dypJHvk4PVUxBZTl1EUe9NH/j2uA7M+HxTiIcY20nWC32hJf8CZZs9
	 ajYVC/9BHSr8RbtPEq7s0WxK1JBb3Lfuwf/8dy8K3MYf52DRzqREyNSCQDMtCRw8NA
	 wwbNc84QW0T1Q==
Date: Thu, 31 Oct 2024 14:36:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, John Garry <john.g.garry@oracle.com>,
	linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
Message-ID: <20241031213640.GB21832@frogsfrogsfrogs>
References: <fc6fddee-2707-4cca-b0b7-983c8dd17e16@oracle.com>
 <87v7xgmpwo.fsf@gmail.com>
 <7e322989-c6e0-424a-94bd-3ad6ce5ffee9@oracle.com>
 <87ttd0mnuo.fsf@gmail.com>
 <7aea00d4-3914-414d-a18f-586a303868c1@oracle.com>
 <87r084mkat.fsf@gmail.com>
 <509180f3-4cc1-4cc2-9d43-5a1e728fb718@oracle.com>
 <87plnomfsy.fsf@gmail.com>
 <20241025182858.GM2386201@frogsfrogsfrogs>
 <87jzdvmqfz.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzdvmqfz.fsf@gmail.com>

On Sat, Oct 26, 2024 at 10:05:44AM +0530, Ritesh Harjani wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > On Fri, Oct 25, 2024 at 07:43:17PM +0530, Ritesh Harjani wrote:
> >> John Garry <john.g.garry@oracle.com> writes:
> >> 
> >> > On 25/10/2024 13:36, Ritesh Harjani (IBM) wrote:
> >> >>>> So user will anyway will have to be made aware of not to
> >> >>>> attempt writes of fashion which can cause them such penalties.
> >> >>>>
> >> >>>> As patch-6 mentions this is a base support for bs = ps systems for
> >> >>>> enabling atomic writes using bigalloc. For now we return -EINVAL when we
> >> >>>> can't allocate a continuous user requested mapping which means it won't
> >> >>>> support operations of types 8k followed by 16k.
> >> >>>>
> >> >>> That's my least-preferred option.
> >> >>>
> >> >>> I think better would be reject atomic writes that cover unwritten
> >> >>> extents always - but that boat is about to sail...
> >> >> That's what this patch does.
> >> >
> >> > Not really.
> >> >
> >> > Currently we have 2x iomap restrictions:
> >> > a. mapping length must equal fs block size
> >> > b. bio created must equal total write size
> >> >
> >> > This patch just says that the mapping length must equal total write size 
> >> > (instead of a.). So quite similar to b.
> >> >
> >> >> For whatever reason if we couldn't allocate
> >> >> a single contiguous region of requested size for atomic write, then we
> >> >> reject the request always, isn't it. Or maybe I didn't understand your comment.
> >> >
> >> > As the simplest example, for an atomic write to an empty file, there 
> >> > should only be a single mapping returned to iomap_dio_bio_iter() and 
> >> > that would be of IOMAP_UNWRITTEN type. And we don't reject that.
> >> >
> >> 
> >> Ok. Maybe this is what I am missing. Could you please help me understand
> >> why should such writes be rejected? 
> >> 
> >> For e.g. 
> >> If FS could allocate a single contiguous IOMAP_UNWRITTEN extent of
> >> atomic write request size, that means - 
> >> 1. FS will allocate an unwritten extent.
> >> 2. will do writes (using submit_bio) to the unwritten extent. 
> >> 3. will do unwritten to written conversion. 
> >> 
> >> It is ok if either of the above operations fail right? If (3) fails
> >> then the region will still be marked unwritten that means it will read
> >> zero (old contents). (2) can anyway fail and will not result into
> >> partial writes. (1) will anyway not result into any write whatsoever.
> >> 
> >> So we can never have a situation where there is partial writes leading
> >> to mix of old and new write contents right for such cases? Which is what the
> >> requirement of atomic/untorn write also is?
> >> 
> >> Sorry am I missing something here?
> >
> > I must be missing something; to perform an untorn write, two things must
> > happen --
> >
> > 1. The kernel writes the data to the storage device, and the storage
> > device either persists all of it, or throws back an error having
> > persisted none of it.
> >
> > 2. If (1) completes successfully, all file mapping updates for the range
> > written must be persisted, or an error is thrown back and none of them
> > are persisted.
> >
> > iomap doesn't have to know how the filesystem satisfies (2); it just has
> > to create a single bio containing all data pages or it rejects the
> > write.
> >
> > Currently, it's an implementation detail that the XFS directio write
> > ioend code processes the file mapping updates for the range written by
> > walking every extent mapping for that range and issuing separate
> > transactions for each mapping update.  There's nothing that can restart
> > the walk if it is interrupted.  That's why XFS cannot support multi
> > fsblock untorn writes to blocks with different status.
> >
> > As I've said before, the most general solution to this would be to add a
> > new log intent item that would track the "update all mappings in this
> > file range" operation so that recovery could restart the walk.  This is
> > the most technically challenging, so we decided not to implement it
> > until there is demand.
> >
> > Having set aside the idea of redesigning ioend, the second-most general
> > solution is pre-zeroing unwritten extents and holes so that
> > ->iomap_begin implementations can present a single mapping to the bio
> > constructor.  Technically if there's only one unwritten extent or hole
> > or cow, xfs can actually satisfy (2) because it only creates one
> > transaction.
> >
> > This gets me to the third and much less general solution -- only allow
> > untorn writes if we know that the ioend only ever has to run a single
> > transaction.  That's why untorn writes are limited to a single fsblock
> > for now -- it's a simple solution so that we can get our downstream
> > customers to kick the tires and start on the next iteration instead of
> > spending years on waterfalling.
> >
> > Did you notice that in all of these cases, the capabilities of the
> > filesystem's ioend processing determines the restrictions on the number
> > and type of mappings that ->iomap_begin can give to iomap?
> >
> > Now that we have a second system trying to hook up to the iomap support,
> > it's clear to me that the restrictions on mappings are specific to each
> > filesystem.  Therefore, the iomap directio code should not impose
> > restrictions on the mappings it receives unless they would prevent the
> > creation of the single aligned bio.
> >
> > Instead, xfs_direct_write_iomap_begin and ext4_iomap_begin should return
> > EINVAL or something if they look at the file mappings and discover that
> > they cannot perform the ioend without risking torn mapping updates.  In
> > the long run, ->iomap_begin is where this iomap->len <= iter->len check
> > really belongs, but hold that thought.
> >
> > For the multi fsblock case, the ->iomap_begin functions would have to
> > check that only one metadata update would be necessary in the ioend.
> > That's where things get murky, since ext4/xfs drop their mapping locks
> > between calls to ->iomap_begin.  So you'd have to check all the mappings
> > for unsupported mixed state every time.  Yuck.
> >
> 
> Thanks Darrick for taking time summarizing what all has been done
> and your thoughts here.
> 
> > It might be less gross to retain the restriction that iomap accepts only
> > one mapping for the entire file range, like Ritesh has here.
> 
> less gross :) sure. 
> 
> I would like to think of this as, being less restrictive (compared to
> only allowing a single fsblock) by adding a constraint on the atomic
> write I/O request i.e.  
> 
> "Atomic write I/O request to a region in a file is only allowed if that
> region has no partially allocated extents. Otherwise, the file system
> can fail the I/O operation by returning -EINVAL."
> 
> Essentially by adding this constraint to the I/O request, we are
> helping the user to prevent atomic writes from accidentally getting
> torned and also allowing multi-fsblock writes. So I still think that
> might be the right thing to do here or at least a better start. FS can
> later work on adding such support where we don't even need above
> such constraint on a given atomic write I/O request.

On today's ext4 call, Ted and Ritesh and I realized that there's a bit
more to it than this -- it's not possible to support untorn writes to a
mix of written/(cow,unwritten) mappings even if they all point to the
same physical space.  If the system fails after the storage device
commits the write but before any of the ioend processing is scheduled, a
subsequent read of the previously written blocks will produce the new
data, but reads to the other areas will produce the old contents (or
zeroes, or whatever).  That's a torn write.

Therefore, iomap ought to stick to requiring that ->iomap_begin returns
a single iomap to cover the entire file range for the untorn write.  For
an unwritten extent, the post-recovery read will see either zeroes or
the new contents; for a single-mapping COW it'll see old or new contents
but not both.

(Obviously this still requires that the fs can perform the mapping
updates without tearing too.)

--D

> > Users
> > might be ok with us saying that you can't do a 16k atomic write to a
> > region where you previously did an 8k write until you write the other
> > 8k, even if someone has to write zeroes.  Users might be ok with the
> > kernel allowing multi-fsblock writes but only if the stars align.
> 
> > But
> > to learn the answers to those questions, we have to put /something/ in
> > the hands of our users.
> 
> On this point, I think ext4 might already has those users who might be
> using atomic write characteristics of devices to do untorn writes. e.g. 
> 
> In [1], Ted has talked about using bigalloc with ext4 for torn write
> prevention. [2] talks about using ext4 with bigalloc to prevent torn
> writes on aws cloud.
> 
> [1]: https://www.youtube.com/watch?v=gIeuiGg-_iw
> [2]: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configure-twp.html
> 
> My point being - Looks like the class of users who are using untorn
> writes to improve their database performances are already doing so even
> w/o any such interfaces being exposed to them (with ext4 bigalloc).
> 
> The current feature support of allowing atomic writes to only single
> fsblock might not be helpful to these users who can provide that
> feedback, who are using ext4 on bs = ps systems with bigalloc. But maybe
> let's wait and hear from them whether it is ok if -   
> 
> "Atomic write I/O request to a region in a file is only allowed if that
> region has no partially allocated extents. Otherwise, the file system
> can fail the I/O operation by returning -EINVAL."
> 
> >
> > For now (because we're already at -rc5), let's have xfs/ext4's
> > ->write_iter implementations restrict atomic writes to a single fsblock,
> > and get both merged into the kernel.
> 
> Yes, I agree with the approach. I agree that we should get a consensus
> on this from folks.
> 
> Let me split this series up and address the review comments on patch
> [1-4]. Patch-5 & 6 can be worked once we have conclusion on this and can
> be eyed for 6.14.
> 
> > Let's defer the multi fsblock work
> > to 6.14, though I think we could take this patch.
> 
> It's ok to consider this patch along with multi-fsblock work then i.e.
> for 6.14.
> 
> >
> > Does that sound cool?
> >
> > --D
> 
> Thanks Darrick :)
> 
> -ritesh
> 
> >> >> 
> >> >> If others prefer - we can maybe add such a check (e.g. ext4_dio_atomic_write_checks())
> >> >> for atomic writes in ext4_dio_write_checks(), similar to how we detect
> >> >> overwrites case to decide whether we need a read v/s write semaphore.
> >> >> So this can check if the user has a partially allocated extent for the
> >> >> user requested region and if yes, we can return -EINVAL from
> >> >> ext4_dio_write_iter() itself.
> >> >  > > I think this maybe better option than waiting until ->iomap_begin().
> >> >> This might also bring all atomic write constraints to be checked in one
> >> >> place i.e. during ext4_file_write_iter() itself.
> >> >
> >> > Something like this can be done once we decide how atomic writing to 
> >> > regions which cover mixed unwritten and written extents is to be handled.
> >> 
> >> Mixed extent regions (written + unwritten) is a different case all
> >> together (which can lead to mix of old and new contents).
> >> 
> >> 
> >> But here what I am suggesting is to add following constraint in case of
> >> ext4 with bigalloc - 
> >> 
> >> "Writes to a region which already has partially allocated extent is not supported."
> >> 
> >> That means we will return -EINVAL if we detect above case in
> >> ext4_file_write_iter() and sure we can document this behavior.
> >> 
> >> In retrospect, I am not sure why we cannot add a constraint for atomic
> >> writes (e.g. for ext4 bigalloc) and reject such writes outright,
> >> instead of silently incurring a performance penalty by zeroing out the
> >> partial regions by allowing such write request.
> >> 
> >> -ritesh
> >> 
> 

