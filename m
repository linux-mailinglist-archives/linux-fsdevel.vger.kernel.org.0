Return-Path: <linux-fsdevel+bounces-21572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0F3905E4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 00:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED593B23E27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 22:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162CB129E94;
	Wed, 12 Jun 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0QF/wd0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0112CCB7;
	Wed, 12 Jun 2024 22:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718230530; cv=none; b=RZQ7L2Qc3EH6+y1SCcfR3mDYa7ZXUHw/8FX0le+/80sQ1A2PdiS/HqsTI1C7M5vBF5/736CUDVPx1e4L0cCTeb5yWmxnUQFGaapnbXnNVlWPNZv9zgG0A/dbQILjZxjy0/HPxQ5j3Kc3XzgBeQ1zwharf4tHBPkXmu8UHpFMzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718230530; c=relaxed/simple;
	bh=HkjRE2UD/HyNAkiUwt2idFnkUPqPqfT7itES3wF6rz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQcUgJbuq6VHDMoGAbYb3LO6LyI5XdTPOfRs4aRgXgosJapiX5OjlH5RZQAmVHZTfl9SCBLSinKWtIk0B+tbQEToVbgjX/OOGRL/3UVXepu6kZ4amWvMWPmFUSuIfaXBJ9tMQb4T1vkafObIuMyii8hSxNELXskP55cjOTvARAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0QF/wd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8C1C116B1;
	Wed, 12 Jun 2024 22:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718230529;
	bh=HkjRE2UD/HyNAkiUwt2idFnkUPqPqfT7itES3wF6rz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0QF/wd08upyH08yWyfV1j/JgrbIRWNqPMlagcHqOfEpdMnZNkIpefE2UDx1v0SfP
	 gO3I/4ezOTz+oUUMbYYXywxsWEg4HPA0WIWtTonEHjWOJ7GYcpFFfEIDF3J+ZG3KOv
	 41akmdC6AuIRxOPBkcD/KshXKnI7Gh9lKErPEGPduvgHX/Nu4nAr9NppHvJr64QQN9
	 PGBMht/B+nZliVe6lMQjDMKCEjWLdBLS066DMPTQFmdN70327lNohrizqp8kwq2sOt
	 H1UutQJZGehvBQpAh3ZlFt5vpgZdC00komvqOCcrW9QGBWemFGISNJvJnx8xPetczD
	 1OT/hioQg+CvA==
Date: Wed, 12 Jun 2024 15:15:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to
 port
Message-ID: <20240612221529.GM2764752@frogsfrogsfrogs>
References: <20240608001707.GD52973@frogsfrogsfrogs>
 <874j9zahch.fsf@gmail.com>
 <20240611234745.GD52987@frogsfrogsfrogs>
 <8734piacp7.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734piacp7.fsf@gmail.com>

On Wed, Jun 12, 2024 at 12:07:40PM +0530, Ritesh Harjani wrote:
> 
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > On Tue, Jun 11, 2024 at 04:15:02PM +0530, Ritesh Harjani wrote:
> >> 
> >> Hi Darrick,
> >> 
> >> Resuming my review from where I left off yesterday.
> >
> 
> <snip>
> >> > +Writes
> >> > +~~~~~~
> >> > +
> >> > +The ``iomap_file_buffered_write`` function writes an ``iocb`` to the
> >> > +pagecache.
> >> > +``IOMAP_WRITE`` or ``IOMAP_WRITE`` | ``IOMAP_NOWAIT`` will be passed as
> >> > +the ``flags`` argument to ``->iomap_begin``.
> >> > +Callers commonly take ``i_rwsem`` in either shared or exclusive mode.
> >> 
> >> shared(e.g. aligned overwrites) 
> >
> 
> Ok, I see we were in buffered I/O section (Sorry, I misunderstood
> thinking this was for direct-io)

Aha.  I'll change these headings to "Buffered Readahead and Reads" and
"Buffered Writes".

> > That's a matter of debate -- xfs locks out concurrent reads by taking
> > i_rwsem in exclusive mode, whereas (I think?) ext4 and most other
> > filesystems take it in shared mode and synchronizes readers and writers
> > with folio locks.
> 
> Ext4 too takes inode lock in exclusive mode in case of
> buffered-write. It's the DIO writes/overwrites in ext4 which has special
> casing for shared/exclusive mode locking.
> 
> But ext4 buffered-read does not take any inode lock (it uses
> generic_file_read_iter()). So the synchronization must happen via folio
> lock w.r.t buffered-writes.
> 
> However, I am not sure if we have any filesystem taking VFS inode lock in
> shared more for buffered-writes.

In theory you could if no other metadata needed updating, such as a dumb
filesystem with fixed size files where timestamps don't matter.

> BTW -
> I really like all of the other updates that you made w.r.t the review
> comments. All of those looks more clear to me. (so not commenting on them
> individually).
> 
> Thanks!

No, thank /you/ and everyone else for reading all the way through it.
I'll finish cleaning things up and put out a v2.

--D

> -ritesh
> 

