Return-Path: <linux-fsdevel+bounces-11503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7F185403C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 00:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9550A1C2636C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7D6312D;
	Tue, 13 Feb 2024 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0s9N0syX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A663105
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867688; cv=none; b=UhsH7BQNh/Arg6p6VqL6tfihPKs6gqBHS4J1aGPKxecjOG7vMD4IyjHyfW5PJMSewFAYkXsm6c3AvjIxeCVdM3yCZLKvA0Fmz6IYIJTzeDht+X2SIp9QbBurZ+5nNrYW5a8OwYCbcYroZ9FjoPs4yikDwlXv8cKniKapMxK2whE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867688; c=relaxed/simple;
	bh=WI2GnT+vC0KiVMhZ9Ar84tFqH3guao33O9rqHzUIswI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJwQX2AEjcDhz7U378hd58GFfIckyJqkUmytTIkAud91jLLEwasF1mdJPMVvkoNcH48tqtWqwRkYU4HbiQ7DsxSkx0DLv5AD8/4DRU2s4hHW3WMqRZJZzIUi5uLX5POsO6R+BQi3DuBaIuIR0/9y5tnSGm4WFcUpQJa1fl5Ubwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=0s9N0syX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1db5212e2f6so1914915ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 15:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707867686; x=1708472486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtKSMEnFoPA+nA84WrGrOflFWRO7/iUydiSxZxN5LOQ=;
        b=0s9N0syX8WY1wxpuMTj9j8uB7NUODmTwOXp+wddKfknO/3kVjTrlA2JIJMGYc+BXnX
         FbLqHIM0LCyFYcbEYQcTs69nBLf8u8wsByq23vcH4yME7f0GoFjUxci4JB7z/2oWvtJi
         8Y+HntbNzHBWSb/5zb5zuoAHUs6Z+Dw2IQoyie2L6V1w2NbPA0/FJL5ctxjT8CMEBm7P
         ed4rDbE+j8pI8dLJL1QVpQkVs9sYiyk6MZ9KAMm0hArmwOsZKnJIajXXBCmHpTpJQS0E
         8IQ6/tCaa53ZAxFHjvq6nl8lWINZNd1BTciBm74tUNfI67ZzzKa09Mlj5pU+RLSaAb2q
         K0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707867686; x=1708472486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtKSMEnFoPA+nA84WrGrOflFWRO7/iUydiSxZxN5LOQ=;
        b=GTuRR3ekCpOu4VidIvHwUe+C0iIqjrvss/xx0Cao6Egu2vB0YvlyeGrcMuyEkU9vBu
         h8nThpX46Cl0t1fXC8J+2RP4JZCdNGXPqagTyCkMkhlLXWL44SFW1LrKDw5Jaz8XNzI9
         g92Ilp1p67h5he3YpjHr6yCLFQ5xcrf3o6jE1rvTOozLwuDj0NImB8uVbeSnNoUGoKAD
         LdzVz+u9ICPphc65tk8GAjo07bOTP+sojUZOBDPcx03DqKt2H9CQAdYzLetsde15boGG
         jEP9nXeHF8IxVCnv9vpG05hxHGZpIeZikamLD2YBcwGop40vwtdmnrHKrzgJtOhEuCph
         mTMg==
X-Forwarded-Encrypted: i=1; AJvYcCWw2cCFOagT+X64nl35QMGgMvLhqKE2Ium3C/58lTKu0GEve0atmi8chxWHm95NeHdhclnBRy2MPl6JsuEAwN0IXlux5jiBz9Tw4jVbZA==
X-Gm-Message-State: AOJu0YzliQ0Fq1jEeZrGlJ3GlUTIo5EzZyAElAEOePNtMDqyW9aie2aQ
	LSM/GZlgKtrfdekHv05b3THoHzGcbakSFrkvaV8txG2USI1mgau9PYGH3uH9LdQ=
X-Google-Smtp-Source: AGHT+IENVDkz/7KIUkI7OXotV7catU6i63fOrtlb2lZJQVaIC6sDKnurb1zN4PhDJQDsy6Vbd3Dl9A==
X-Received: by 2002:a17:902:dac1:b0:1d7:55b1:4a3 with SMTP id q1-20020a170902dac100b001d755b104a3mr575392plx.11.1707867686175;
        Tue, 13 Feb 2024 15:41:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9pZDsl9PLEQcD0xZoKZH3APRkV3ymaTfKZ5iPyi2rNsSs2R/DKLSK44/NPHk0FuS2PduCnaeb/i2V7SajcJIMtxfyWad4W0KYUi/0fwpddOTmfI7AjGf3/CAkBIFzXy8u2YRsm8IYJyMuVCNlKWwo2adIIteFvo+cUtIXFhHHe/3rW2XC0Jt6vhLX8n0w0bozVNQHBnvlsKClcnB/KotfmhiHst4Df3wcuKuAtnKQRsz9NVXF07y8vpeGojYb2KAyiH52RLta7JHKtY8Pk6KcWiYxL8aD6DLab7zxeOifizGLFr0Xju2XSAmTaIah+Zo3JrGtBG+MUp1QeoN1Di8BD8ecfpafZ0k2Go1oiSMkELy2v02Ld1i0Ws3NbPcHkhu52R/KXWv3H9+O+249cstC5DvG5cLBErWCAovH5elE4S/c1xKlQ9wFe0m0yBhETjpW
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id 77-20020a630150000000b005dab535fac2sm2914669pgb.90.2024.02.13.15.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:41:25 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ra2Ow-0069Tr-34;
	Wed, 14 Feb 2024 10:41:22 +1100
Date: Wed, 14 Feb 2024 10:41:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, chandan.babu@oracle.com, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH RFC 5/6] fs: xfs: iomap atomic write support
Message-ID: <Zcv+IlxgNlc04doJ@dread.disaster.area>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-6-john.g.garry@oracle.com>
 <20240202184758.GA6226@frogsfrogsfrogs>
 <e61cf382-66bd-4091-b49c-afbb5ce67d8f@oracle.com>
 <ZcGIPlNCkL6EDx3Z@dread.disaster.area>
 <434c570e-39b2-4f1c-9b49-ac5241d310ca@oracle.com>
 <ZcLJgVu9A3MsWBI0@dread.disaster.area>
 <a20b3c07-605e-44c2-b562-e98269d37558@oracle.com>
 <ZcWCeU0n7zKEPHk5@dread.disaster.area>
 <20836bd6-7b17-4432-a2b9-085e27014384@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20836bd6-7b17-4432-a2b9-085e27014384@oracle.com>

On Fri, Feb 09, 2024 at 12:47:38PM +0000, John Garry wrote:
> > > > Why should we jump through crazy hoops to try to make filesystems
> > > > optimised for large IOs with mismatched, overlapping small atomic
> > > > writes?
> > > 
> > > As mentioned, typically the atomic writes will be the same size, but we may
> > > have other writes of smaller size.
> > 
> > Then we need the tiny write to allocate and zero according to the
> > maximum sized atomic write bounds. Then we just don't care about
> > large atomic IO overlapping small IO, because the extent on disk
> > aligned to the large atomic IO is then always guaranteed to be the
> > correct size and shape.
> 
> I think it's worth mentioning that there is currently a separation between
> how we configure the FS extent size for atomic writes and what the bdev can
> actually support in terms of atomic writes.

And that's part of what is causing all the issues here - we're
trying to jump though hoops at the fs level to handle cases that
they device doesn't support and vice versa.

> Setting the rtvol extsize at mkfs time or enabling atomic writes
> FS_XFLAG_ATOMICWRITES doesn't check for what the underlying bdev can do in
> terms of atomic writes.

Which is wrong. mkfs.xfs gets physical information about the volume
from the kernel and makes the filesystem accounting to that
information. That's how we do stripe alignment, sector sizing, etc.
Atomic write support and setting up alignment constraints should be
no different.

Yes, mkfs allows the user to override the hardware configsi it
probes, but it also warns when the override is doing something
sub-optimal (like aligning all AG headers to the same disk in a
stripe).

IOWs, mkfs should be pulling this atomic write info from the
hardware and configuring the filesysetm around that information.
That's the target we should be aiming the kernel implementation at
and optimising for - a filesystem that is correctly configured
according to published hardware capability.

Everything else is in the "make it behave correctly, but we don't
care if it's slow" category.

> This check is not done as it is not fixed what the bdev can do in terms of
> atomic writes - or, more specifically, what they request_queue reports is
> not be fixed. There are things which can change this. For example, a FW
> update could change all the atomic write capabilities of a disk. Or even if
> we swapped a SCSI disk into another host the atomic write limits may change,
> as the atomic write unit max depends on the SCSI HBA DMA limits. Changing
> BIO_MAX_VECS - which could come from a kernel update - could also change
> what we report as atomic write limit in the request queue.

If that sort of thing happens, then that's too bad. We already have
these sorts of "do not do if you care about performance"
constraints. e.g. don't do a RAID restripe that changes the
alignment/size of the RAID device (e.g. add a single disk and make
the stripe width wider) because the physical filesystem structure
will no longer be aligned to the underlying hardware. instead, you
have to grow striped volumes with compatible stripes in compatible
sizes to ensure the filesystem remains aligned to the storage...

We don't try to cater for every single possible permutation of
storage hardware configurations - that way lies madness. Design and
optimise for the common case of correctly configured and well
behaved storage, and everything else we just don't care about beyond
"don't corrupt or lose data".

> > > > And therein lies the problem.
> > > > 
> > > > If you are doing sub-rtextent IO at all, then you are forcing the
> > > > filesystem down the path of explicitly using unwritten extents and
> > > > requiring O_DSYNC direct IO to do journal flushes in IO completion
> > > > context and then performance just goes down hill from them.
> > > > 
> > > > The requirement for unwritten extents to track sub-rtextsize written
> > > > regions is what you're trying to work around with XFS_BMAPI_ZERO so
> > > > that atomic writes will always see "atomic write aligned" allocated
> > > > regions.
> > > > 
> > > > Do you see the problem here? You've explicitly told the filesystem
> > > > that allocation is aligned to 64kB chunks, then because the
> > > > filesystem block size is 4kB, it's allowed to track unwritten
> > > > regions at 4kB boundaries. Then you do 4kB aligned file IO, which
> > > > then changes unwritten extents at 4kB boundaries. Then you do a
> > > > overlapping 16kB IO that*requires*  16kB allocation alignment, and
> > > > things go BOOM.
> > > > 
> > > > Yes, they should go BOOM.
> > > > 
> > > > This is a horrible configuration - it is incomaptible with 16kB
> > > > aligned and sized atomic IO.
> > > 
> > > Just because the DB may do 16KB atomic writes most of the time should not
> > > disallow it from any other form of writes.
> > 
> > That's not what I said. I said the using sub-rtextsize atomic writes
> > with single FSB unwritten extent tracking is horrible and
> > incompatible with doing 16kB atomic writes.
> > 
> > This setup will not work at all well with your patches and should go
> > BOOM. Using XFS_BMAPI_ZERO is hacking around the fact that the setup
> > has uncoordinated extent allocation and unwritten conversion
> > granularity.
> > 
> > That's the fundamental design problem with your approach - it allows
> > unwritten conversion at *minimum IO sizes* and that does not work
> > with atomic IOs with larger alignment requirements.
> > 
> > The fundamental design principle is this: for maximally sized atomic
> > writes to always succeed we require every allocation, zeroing and
> > unwritten conversion operation to use alignments and sizes that are
> > compatible with the maximum atomic write sizes being used.
> > 
> 
> That sounds fine.
> 
> My question then is how we determine this max atomic write size granularity.
> 
> We don't explicitly tell the FS what atomic write size we want for a file.
> Rather we mkfs with some extsize value which should match our atomic write
> maximal value and then tell the FS we want to do atomic writes on a file,
> and if this is accepted then we can query the atomic write min and max unit
> size, and this would be [FS block size, min(bdev atomic write limit,
> rtexsize)].
> 
> If rtextsize is 16KB, then we have a good idea that we want 16KB atomic
> writes support. So then we could use rtextsize as this max atomic write
> size.

Maybe, but I think continuing to focus on this as 'atomic writes
requires' is wrong.

The filesystem does not carea bout atomic writes. What it cares
about is the allocation constraints that need to be implemented.
That constraint is that all BMBT extent operations need to be
aligned to a specific extent size, not filesystem blocks.

The current extent size hint (and rtextsize) only impact the
-allocation of extents-. They are not directly placing constraints
on the BMBT layout, they are placing constraints on the free space
search that the allocator runs on the BNO/CNT btrees to select an
extent that is then inserted into the BMBT.

The problem is that unwritten extent conversion, truncate, hole
punching, etc also all need to be correctly aligned for files that
are configured to support atomic writes. These operations place
constraints on how the BMBT can modify the existing extent list.

These are different constraints to what rtextsize/extszhint apply,
and that's the fundamental behavioural difference between existing
extent size hint behaviour and the behaviour needed by atomic
writes.

> But I am not 100% sure that it your idea (apologies if I am wrong - I
> am sincerely trying to follow your idea), but rather it would be
> min(rtextsize, bdev atomic write limit), e.g. if rtextsize was 1MB and bdev
> atomic write limit is 16KB, then there is no much point in dealing in 1MB
> blocks for this unwritten extent conversion alignment.

Exactly my point - there really is no relationship between rtextsize
and atomic write constraints and that it is a mistake to use
rtextsize as it stands as a placeholder for atomic write
constraints.

> If so, then my
> concern is that the bdev atomic write upper limit is not fixed. This can
> solved, but I would still like to be clear on this max atomic write size.

Right, we haven't clearly defined how XFS is supposed align BMBT
operations in a way that is compatible for atomic write operations.

What the patchset does is try to extend and infer things from
existing allocation alignment constraints, but then not apply those
constraints to critical extent state operations (pure BMBT
modifications) that atomic writes also need constrained to work
correctly and efficiently.

> > i.e. atomic writes need to use max write size granularity for all IO
> > operations, not filesystem block granularity.
> > 
> > And that also means things like rtextsize and extsize hints need to
> > match these atomic write requirements, too....
> 
> As above, I am not 100% sure if you mean these to be the atomic write
> maximal value.

Yes, they either need to be the same as the atomic write max value
or, much better, once a hint has been set, then resultant size is
then aligned up to be compatible with the atomic write constraints.

e.g. set an inode extent size hint of 960kB on a device with 128kB
atomic write capability. If the inode has the atomic write flag set,
then allocations need to round the extent size up from 960kB to 1MB
so that the BMBT extent layout and alignment is compatible with 128kB
atomic writes.

At this point, zeroing, punching, unwritten extent conversion, etc
also needs to be done on aligned 128kB ranges to be comaptible with
atomic writes, rather than filesysetm block boundaries that would
normally be used if just the extent size hint was set.

This is effectively what the original "force align" inode flag bit
did - it told the inode that all BMBT manipulations need to be
extent size hint aligned, not just allocation. It's a generic flag
that implements specific extent manipulation constraints that happen
to be compatible with atomic writes when the right extent size hint
is set.

So at this point, I'm not sure that we should have an "atomic
writes" flag in the inode. We need to tell BMBT modifications
to behave in a particular way - forced alignment - not that atomic
writes are being used in the filesystem....

At this point, the filesystem can do all the extent modification
alignment stuff that atomic writes require without caring if the
block device supports atomic writes or even if the
application is using atomic writes.

This means we can test the BMBT functionality in fstests without
requiring hardware (or emulation) that supports atomic writes - all
we need to do is set the forced align flag, an extent size hint and
go run fsx on it...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

