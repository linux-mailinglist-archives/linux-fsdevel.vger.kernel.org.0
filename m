Return-Path: <linux-fsdevel+bounces-11622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E008556D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 00:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D6F1C20F91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 23:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4285F14199D;
	Wed, 14 Feb 2024 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="al1ZpZ9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D35128388
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 23:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951815; cv=none; b=LIm8wBmn6/PN0fPlckk6TwWC52WbRMQpNHh/jQOW6UtgtMURVYe+3WYa1U4Iqfq+OhA+EwG/opV5PleEuvtrrx0vPUzr0kQAYVFy6OLCF4a1fp1ywh05oOmNTkVmE8EJMErfU8rRtFVNLgOqlmfSx3EWrcMOEfmS1y4oOMUiQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951815; c=relaxed/simple;
	bh=hkIhdjfXIgftG4bwS/WYVE0/bTZu2KHsr/6h+ezlZ0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOpAedW8rwFcp8qvKAd27MKhw+qpI/ofWOGdAMOQDVhSVaIJZIa7Iqd/MkG5Tle/pd5HxtNxxJ67Xn3TuwOTARJzqxMM40cgtef9FJES+mU7eJOKBrNJ75kN2mUBjMa+ZwIYqNUcGj6KZXPmpwoy1YgSTv5HlNdkms0KjdxasgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=al1ZpZ9U; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7232dcb3eso2020375ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 15:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707951813; x=1708556613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEIyP+FXcM2AjGZuw682H1p4S8m/iedC1Mk612Iwk9w=;
        b=al1ZpZ9UPLI38jacIPIrvNNUjcOF7H3YepvT8/0Or34KhBdMK7i162wizhnP8LJFbK
         DmYc8XtIUjpO9QVh3GTi7BsQgsZAfIOERf+YSrZSgNplGl+FZhIo7N7/IIruZu9QuYqG
         sXPM4ZxESMj0AtQETYVV2JO5JmSrWK5uHHDBBkmzdXhCKoL7OtLm7o57Tbe3Z6sNiPcQ
         KI2pjaJ6ALj2fEvNiN1i9nNOVdP4CLxk7+x/LgrvptFo0HwUYPhCMnafWPY/Go9lBX4+
         cBk6oJBy3FMo0VEzNFJAkI3b7O/jM9AoOHz+cACHsjVhQ3zMABlcEE1YCG6HJzWQtvXO
         jjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707951813; x=1708556613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEIyP+FXcM2AjGZuw682H1p4S8m/iedC1Mk612Iwk9w=;
        b=NchOkX93jeg+3XZ1kGQVhksBLp2mGjrhXlqaLJuHbEVW6mVaI6YkCc/UtBy9ndxbom
         hl+Qh6IfhQoGd/N+SWveSefsq7D8SBAT78ykUrU4p2u/cdFI5CoBhxT1HvVP74MR8rsC
         rFiHVDpGqgNk13AXVfbtJHn5zw++/FKs47Be4WmbmlWkgG3g9ze9LYlWOhgfxsL6g/sx
         8got5/BTwVtChlEWaaQprYMZTf80Q4BYqSDpOjA5or0iTe1nY1tBe8p6Qd43S+F0HoTr
         C/GowWLLAoyJOHRaK19tZzrcrwKJhz0lvgc9+bv+oe2ZRjn9WcrDQ5jbJH209bLRaBnv
         nQLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2OSV1c2ifmwVX+fz/tmEqiVAq1FwNMhT0ibYyKDzlt3VxJTfBEo30P+LP/PdQGI8qp7QS9foKY+BAStNXht5CzPY4cbUaN7oddJ0nKw==
X-Gm-Message-State: AOJu0YwWnfXBH4dvP7n/aHklKQvv4Dr7sJqQZxlFmU39DA3OlrIzMBjp
	Ak/durFBH1b1DKmVGGk+JBvaj8SMlmqKdsknVa7pFG7Lb3JaH2Ot7FISCIKlno8=
X-Google-Smtp-Source: AGHT+IGMKdvjEXk343KBUsc9jMU2KISf+vpJ+RZTPGS4lg+U3Jvq3G4ExOW8y8iGngj60UCPQkxO4w==
X-Received: by 2002:a17:903:595:b0:1db:3ea8:ce10 with SMTP id jv21-20020a170903059500b001db3ea8ce10mr37493plb.7.1707951812887;
        Wed, 14 Feb 2024 15:03:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuS8gN6AUX6mYO9O1IWUTiJJQImV6ZY9WZiDkBr0ogZFdGAdVmdtOSYzmOGkwbtfcY/ZvvaPKjm2TeW9YtRzCRaeMnGyWXvHwyfpwQ6wwAza6vzGzcCLzM6sJ4SEMrxIHXBVpY3TbP3HqX+gpm77SRDaab6W0w6CgglZrjxJg9qb/Gcb1eeFeM1PnXXpWGAET6VJeySHs/fhccUfUEYPpyHXXWgmBUw5G/KRH+2w+suxgUyHEEjAxiqoADjaiH1aiFsAcOJXQwFiXTp24+Jmv3UK8szt+SEQ7dfmdrwDhc+BitmQdsqxpeIIFx1bvdBObAgSwHzGJl3Fm0LIup4RdLPqtOhZDeQ/AFNRO0loT2x0y3ahOtFV8PpYrOWRxF9H3z14V54A+1/r8CWrYyQQpilA/lLj0pSjKMFr6JU6YvrSby7kbCOL6bllMWci/z1foU
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id e25-20020a633719000000b005d5445349edsm4829423pga.19.2024.02.14.15.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 15:03:32 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1raOHo-006aQk-21;
	Thu, 15 Feb 2024 10:03:28 +1100
Date: Thu, 15 Feb 2024 10:03:28 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, chandan.babu@oracle.com, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH RFC 5/6] fs: xfs: iomap atomic write support
Message-ID: <Zc1GwE/7QJisKZCX@dread.disaster.area>
References: <20240202184758.GA6226@frogsfrogsfrogs>
 <e61cf382-66bd-4091-b49c-afbb5ce67d8f@oracle.com>
 <ZcGIPlNCkL6EDx3Z@dread.disaster.area>
 <434c570e-39b2-4f1c-9b49-ac5241d310ca@oracle.com>
 <ZcLJgVu9A3MsWBI0@dread.disaster.area>
 <a20b3c07-605e-44c2-b562-e98269d37558@oracle.com>
 <ZcWCeU0n7zKEPHk5@dread.disaster.area>
 <20836bd6-7b17-4432-a2b9-085e27014384@oracle.com>
 <Zcv+IlxgNlc04doJ@dread.disaster.area>
 <74e13ebf-2bd7-4487-8453-d98d70ba5e68@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74e13ebf-2bd7-4487-8453-d98d70ba5e68@oracle.com>

On Wed, Feb 14, 2024 at 11:06:11AM +0000, John Garry wrote:
> 
> > 
> > > Setting the rtvol extsize at mkfs time or enabling atomic writes
> > > FS_XFLAG_ATOMICWRITES doesn't check for what the underlying bdev can do in
> > > terms of atomic writes.
> > 
> > Which is wrong. mkfs.xfs gets physical information about the volume
> > from the kernel and makes the filesystem accounting to that
> > information. That's how we do stripe alignment, sector sizing, etc.
> > Atomic write support and setting up alignment constraints should be
> > no different.
> 
> Yes, I was just looking at adding a mkfs option to format for atomic writes,
> which would check physical information about the volume and whether it suits
> rtextsize and then subsequently also set XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES.

FWIW, atomic writes need to be implemented in XFS in a way that
isn't specific to the rtdev. There is no reason they cannot be
applied to the data device (via superblock max atomic write size
field or extent size hints and the align flag) so
please don't get hung up on rtextsize as the only thing that atomic
write alignment might apply to.

> > Yes, mkfs allows the user to override the hardware configsi it
> > probes, but it also warns when the override is doing something
> > sub-optimal (like aligning all AG headers to the same disk in a
> > stripe).
> > 
> > IOWs, mkfs should be pulling this atomic write info from the
> > hardware and configuring the filesysetm around that information.
> > That's the target we should be aiming the kernel implementation at
> > and optimising for - a filesystem that is correctly configured
> > according to published hardware capability.
> 
> Right
> 
> So, for example, if the atomic writes option is set and the rtextsize set by
> the user is so much larger than what HW can support in terms of atomic
> writes, then we should let the user know about this.

Well, this is part of the problem I mention above: you're focussing
entirely on the rtdev setup and not the general "atomic writes
require BMBT extent alignment constraints".

So, maybe, yes, we might want to warn that the rtextsize is much
bigger than the atomic write size of that device, but now there's
something else we need to take into account: the rtdev could have a
different atomic write size comxpapred to the data device.

What now?

IOWs, focussing on the rtdev misses key considerations for making
the functionality generic, and we most definitely don't want to have
to rev the on disk format a second time to support atomic writes
for the data device. Hence we likely need two variables for atomic
write sizes in the superblock - one for the rtdev, and one for the
data device. And this then feeds through to Darrick's multi-rtdev
stuff - each rtdev will need to have an attribute that tracks this
information.

Actually, now that I think about it, we may require 3 sizes - I'm in
the process of writing a design doc for an new journal format, and
one of the things I want it to be able to do is use atomic writes to
enable journal writes to be decoupled from device sector sizes. If
we are using atomic writes > sector size for the journal, then we
definitely need to record somewhere in the superblock what the
minimum journal IO size is because it isn't going to be the sector
size anymore...

[...]

> > > If so, then my
> > > concern is that the bdev atomic write upper limit is not fixed. This can
> > > solved, but I would still like to be clear on this max atomic write size.
> > 
> > Right, we haven't clearly defined how XFS is supposed align BMBT
> > operations in a way that is compatible for atomic write operations.
> > 
> > What the patchset does is try to extend and infer things from
> > existing allocation alignment constraints, but then not apply those
> > constraints to critical extent state operations (pure BMBT
> > modifications) that atomic writes also need constrained to work
> > correctly and efficiently.
> 
> Right. Previously I also did mention that we could explicitly request the
> atomic write size per-inode, but a drawback is that this would require an
> on-disk format change.

We're already having to change the on-disk format for this (inode
flag, superblock feature bit), so we really should be trying to make
this generic and properly featured so that it can be used for
anything that requires physical alignment of file data extents, not
just atomic writes...

> > > > i.e. atomic writes need to use max write size granularity for all IO
> > > > operations, not filesystem block granularity.
> > > > 
> > > > And that also means things like rtextsize and extsize hints need to
> > > > match these atomic write requirements, too....
> > > 
> > > As above, I am not 100% sure if you mean these to be the atomic write
> > > maximal value.
> > 
> > Yes, they either need to be the same as the atomic write max value
> > or, much better, once a hint has been set, then resultant size is
> > then aligned up to be compatible with the atomic write constraints.
> > 
> > e.g. set an inode extent size hint of 960kB on a device with 128kB
> > atomic write capability. If the inode has the atomic write flag set,
> > then allocations need to round the extent size up from 960kB to 1MB
> > so that the BMBT extent layout and alignment is compatible with 128kB
> > atomic writes.
> > 
> > At this point, zeroing, punching, unwritten extent conversion, etc
> > also needs to be done on aligned 128kB ranges to be comaptible with
> > atomic writes, rather than filesysetm block boundaries that would
> > normally be used if just the extent size hint was set.
> > 
> > This is effectively what the original "force align" inode flag bit
> > did - it told the inode that all BMBT manipulations need to be
> > extent size hint aligned, not just allocation. It's a generic flag
> > that implements specific extent manipulation constraints that happen
> > to be compatible with atomic writes when the right extent size hint
> > is set.
> > 
> > So at this point, I'm not sure that we should have an "atomic
> > writes" flag in the inode.
> 
> Another motivation for this flag is that we can explicitly enable some
> software-based atomic write support for an inode when the backing device
> does not have HW support.

That's orthogonal to the aligment issue. If the BMBT extents are
always aligned in a way that is compatible with atomic writes, we
don't need and aomtic writes flag to tell the filesystem it should
do an atomic write. That comes from userspace via the IOCB_ATOMIC
flag.

It is the IOCB_ATOMIC that triggers the software fallback when the
hardware doesn't support atomic writes, not an inode flag. All the
filesystem has to do is guarantee all extent manipulations are
correctly aligned and IOCB_ATOMIC can always be executed regardless
of whether it is hardware or software that does it.


> In addition, in this series setting FS_XFLAG_ATOMICWRITES means
> XFS_DIFLAG2_ATOMICWRITES gets set, and I would expect it to do something
> similar for other OSes, and for those other OSes it may also mean some other
> special alignment feature enabled. We want a consistent user experience.

I don't care about other OSes - they don't implement the
FS_IOC_FSSETXATTR interfaces, so we just don't care about cross-OS
compatibility for the user API.

Fundamentally, atomic writes are *not a property of the filesystem
on-disk format*. They require extent tracking constraints (i.e.
alignment), and that's the property of the filesystem on-disk format
that we need to manipulate here.

Users are not going to care if the setup ioctl for atomic writes
is to set FS_XFLAG_ALIGN_EXTENTS vs FS_XFLAG_ATOMICWRITES. They
already know they have to align their IO properly for atomic writes,
so it's not like this is something they will be completely
unfamiliar with.

Indeed, FS_XFLAG_ALIGN_EXTENTS | FS_XFLAG_EXTSIZE w/ fsx.fsx_extsize
= max_atomic_write_size as a user interface to set up the inode for 
atomic writes is pretty concise and easy to use. It also isn't
specific to atomic writes, and so this fucntionality can be used for
anything that needs aligned extent manipulation for performant
functionality.

> > to behave in a particular way - forced alignment - not that atomic
> > writes are being used in the filesystem....
> > 
> > At this point, the filesystem can do all the extent modification
> > alignment stuff that atomic writes require without caring if the
> > block device supports atomic writes or even if the
> > application is using atomic writes.
> > 
> > This means we can test the BMBT functionality in fstests without
> > requiring hardware (or emulation) that supports atomic writes - all
> > we need to do is set the forced align flag, an extent size hint and
> > go run fsx on it...
> > 
> 
> The current idea was that the forcealign feature would be required for the
> second phase for atomic write support - non-rtvol support. Darrick did send
> that series out separately over the New Year's break.

This is the wrong approach: this needs to be integrated into the
same patchset so we can review the changes for atomic writes as a
whole, not as two separate, independent on-disk format changes. The
on-disk format change that atomic writes need is aligned BMBT extent
manipulations, regardless of whether we are targeting the rtdev or
the datadev, and trying to separate them is leading you down
entirely the wrong path.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

