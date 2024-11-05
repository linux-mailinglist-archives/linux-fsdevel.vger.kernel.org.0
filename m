Return-Path: <linux-fsdevel+bounces-33642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A29BC1D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 01:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D48C8B21461
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 00:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E8DDDC;
	Tue,  5 Nov 2024 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhJE3Fnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61627A95C;
	Tue,  5 Nov 2024 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730765397; cv=none; b=nr93RficSJe+5EtsWOobVK8jY90xOndOUqQsU5dSB8T7kRXjKY3G057p7u7pzzmnO4LWIaB6NzylS84W+dfbkyfWM0sNqGrs2s4mGNHo2lReYvDz/gwuv+tppVAjbzLM88uu/2D/3X4GzS4fnm+9xtqY+VyVslWaUFwYUUEDoFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730765397; c=relaxed/simple;
	bh=5SMbRoqtUQVxiBaWYqe7JPubf3gdBEC5Rp9xzsEkQBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnImv3Wged7YhpqdbH9RRVwKdBLo/CpJK3zMBLztUEncU/RYBitJg8Y11+iSIc8HVto0+1+YcaG0P66u7jB/fpaB5H4yp8w8+hyEc8SeRRfXBWtB0H7C/ninNRMljNdSgE/9DfqKKeUlxQr2VAs/EaRRtqyf66fC4hoXk7f0Omc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhJE3Fnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADFEC4CECE;
	Tue,  5 Nov 2024 00:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730765396;
	bh=5SMbRoqtUQVxiBaWYqe7JPubf3gdBEC5Rp9xzsEkQBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhJE3FnlD42iycAX4PXmPBOthNKuOIhE7JsPDqNnV149eJ2o8kmL5mI+vOCmThMw7
	 T75bO1lKqxjXSYa14GiUdZp/kSa9ElnCjBUvpviNk0AxgoJ0QmAqu/Mi45Zhf+k6Qw
	 7TOvDZbWBxA8FZ6fdkWpQOLKJswph/2ryE+XEx0A5Yj3f2Yq+qecBM3S7KXXFnj4xB
	 QwXmEQvuqQorkVOIFAfQOgVkMCKDUWUuWoN0/CG8gy1Nh3gObOR4x88R9VepSEGv1S
	 reGacUWpNmOlPj8DdnZxwdZ/ydnwAs0JKw54N7HA4pzJZa9BAF6foTpvuWZH4L+hSC
	 6E5B0j5RTIw4Q==
Date: Mon, 4 Nov 2024 16:09:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
	John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
Message-ID: <20241105000956.GJ21832@frogsfrogsfrogs>
References: <7e322989-c6e0-424a-94bd-3ad6ce5ffee9@oracle.com>
 <87ttd0mnuo.fsf@gmail.com>
 <7aea00d4-3914-414d-a18f-586a303868c1@oracle.com>
 <87r084mkat.fsf@gmail.com>
 <509180f3-4cc1-4cc2-9d43-5a1e728fb718@oracle.com>
 <87plnomfsy.fsf@gmail.com>
 <20241025182858.GM2386201@frogsfrogsfrogs>
 <87jzdvmqfz.fsf@gmail.com>
 <20241031213640.GB21832@frogsfrogsfrogs>
 <Zygo6nqOJMoJxYrm@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zygo6nqOJMoJxYrm@dread.disaster.area>

On Mon, Nov 04, 2024 at 12:52:42PM +1100, Dave Chinner wrote:
> On Thu, Oct 31, 2024 at 02:36:40PM -0700, Darrick J. Wong wrote:
> > On Sat, Oct 26, 2024 at 10:05:44AM +0530, Ritesh Harjani wrote:
> > > > This gets me to the third and much less general solution -- only allow
> > > > untorn writes if we know that the ioend only ever has to run a single
> > > > transaction.  That's why untorn writes are limited to a single fsblock
> > > > for now -- it's a simple solution so that we can get our downstream
> > > > customers to kick the tires and start on the next iteration instead of
> > > > spending years on waterfalling.
> > > >
> > > > Did you notice that in all of these cases, the capabilities of the
> > > > filesystem's ioend processing determines the restrictions on the number
> > > > and type of mappings that ->iomap_begin can give to iomap?
> > > >
> > > > Now that we have a second system trying to hook up to the iomap support,
> > > > it's clear to me that the restrictions on mappings are specific to each
> > > > filesystem.  Therefore, the iomap directio code should not impose
> > > > restrictions on the mappings it receives unless they would prevent the
> > > > creation of the single aligned bio.
> > > >
> > > > Instead, xfs_direct_write_iomap_begin and ext4_iomap_begin should return
> > > > EINVAL or something if they look at the file mappings and discover that
> > > > they cannot perform the ioend without risking torn mapping updates.  In
> > > > the long run, ->iomap_begin is where this iomap->len <= iter->len check
> > > > really belongs, but hold that thought.
> > > >
> > > > For the multi fsblock case, the ->iomap_begin functions would have to
> > > > check that only one metadata update would be necessary in the ioend.
> > > > That's where things get murky, since ext4/xfs drop their mapping locks
> > > > between calls to ->iomap_begin.  So you'd have to check all the mappings
> > > > for unsupported mixed state every time.  Yuck.
> > > >
> > > 
> > > Thanks Darrick for taking time summarizing what all has been done
> > > and your thoughts here.
> > > 
> > > > It might be less gross to retain the restriction that iomap accepts only
> > > > one mapping for the entire file range, like Ritesh has here.
> > > 
> > > less gross :) sure. 
> > > 
> > > I would like to think of this as, being less restrictive (compared to
> > > only allowing a single fsblock) by adding a constraint on the atomic
> > > write I/O request i.e.  
> > > 
> > > "Atomic write I/O request to a region in a file is only allowed if that
> > > region has no partially allocated extents. Otherwise, the file system
> > > can fail the I/O operation by returning -EINVAL."
> > > 
> > > Essentially by adding this constraint to the I/O request, we are
> > > helping the user to prevent atomic writes from accidentally getting
> > > torned and also allowing multi-fsblock writes. So I still think that
> > > might be the right thing to do here or at least a better start. FS can
> > > later work on adding such support where we don't even need above
> > > such constraint on a given atomic write I/O request.
> > 
> > On today's ext4 call, Ted and Ritesh and I realized that there's a bit
> > more to it than this -- it's not possible to support untorn writes to a
> > mix of written/(cow,unwritten) mappings even if they all point to the
> > same physical space.  If the system fails after the storage device
> > commits the write but before any of the ioend processing is scheduled, a
> > subsequent read of the previously written blocks will produce the new
> > data, but reads to the other areas will produce the old contents (or
> > zeroes, or whatever).  That's a torn write.
> 
> I'm *really* surprised that people are only realising that IO
> completion processing for atomic writes *must be atomic*.

I've been saying for a while; it's just that I didn't realize until last
week that there were more rules than "can't do an untorn write if you
need to do more than 1 mapping update":

Untorn writes are not possible if:
1. More than 1 mapping update is needed
2. 1 mapping update is needed but there's a written block

(1) can be worked around with a log intent item for ioend processing,
but I don't think (2) can at all.  That's why I went back to saying that
untorn writes require that there can only be one mapping.

> This was the foundational constraint that the forced alignment
> proposal for XFS was intended to address. i.e. to prevent fs
> operations from violating atomic write IO constraints (e.g. punching
> sub-atomic write size holes in the file) so that the physical IO can
> be done without tearing and the IO completion processing that
> exposes the new data can be done atomically.
> 
> > Therefore, iomap ought to stick to requiring that ->iomap_begin returns
> > a single iomap to cover the entire file range for the untorn write.  For
> > an unwritten extent, the post-recovery read will see either zeroes or
> > the new contents; for a single-mapping COW it'll see old or new contents
> > but not both.
> 
> I'm pretty sure we enforced that in the XFS mapping implemention for
> atomic writes using forced alignment. i.e.  we have to return a
> correctly aligned, contiguous mapping to iomap or we have to return
> -EINVAL to indicate atomic write mapping failed.

I think you guys did, it's just the ext4 bigalloc thing that started
this back up again. :/

> Yes, we can check this in iomap, but it's really the filesystem that
> has to implement and enforce it...

I think we ought to keep the "1 mapping per untorn write" check in iomap
until someone decides that it's worth the trouble to make a filesystem
handle mixed states correctly.  Mostly as a guard against the
implementations.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

