Return-Path: <linux-fsdevel+bounces-39752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 999C2A1759C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 02:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77CFD7A1A72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 01:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A94F20328;
	Tue, 21 Jan 2025 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="li71IxbC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0030681720
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737422429; cv=none; b=PiLek4rKYBI7RXhmPE9nWOVLsny1eBWllnePYgEeEPooxbTY6nmxuS8ac2YzyjZgxJuD/usoH6zXQkTho6zrkNun8C31Gm5L7ozK4GBjuCsxIBe/8gaLpDA1uwOkEJQTnoOBrCiPiplBXU+PNcxtQoLO+GdVkg+ySpGq8JONe5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737422429; c=relaxed/simple;
	bh=eMs1XR2aYJpBvgtaU/Q8w7i4/0/0KAkiUbBrWVTBRLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJ1e1dqhZEZpJOkSHC+XYusEcq6B8xQmc7VmHBNMwClTY2TDg4llbeTK6ir9PivKGhrwKV8xWjSYqCkHvLJlT/SEmXAyJ7GG118pXun3UbPHZeZyATAGkKpWKlelSMEW3NWvmZUHq3X2ywZ8qY2wtzHAfFclRNOU3iHJQ3l/mqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=li71IxbC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so6938071a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 17:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737422427; x=1738027227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pySU+UaLycNt2Mnc9d/1arFANwTD8nZiZk8SBrDSfas=;
        b=li71IxbCNZyGqJihs8uyKjZNYneISREH0JAetHjxdoM/SBOdOsYl2Y7xARO3jTYHXd
         gY8QG/hEZIySY7Zqqj09ikQzOfMC5w2+6KloKWHQe1O05n1xJCE8tC8TQMckwGHWrlTJ
         7KVYB+skL+i4IrSU7I2gTBoAGxLfn2888mwBl8sOn7PF6mWA3QYVnzPyzEKm+PhKEPce
         QgY1/vXouAm19CWFlaRaJbP599Zvl4ermBXexB2JRarL140+aRqghPTUvbcBvai8TYop
         lyKwn6mxhTPTztZeRAMupCOIemlc/ibizjmliYkt3BoWpTIS3uHjHXQJRjqnMliqgX/Z
         u8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737422427; x=1738027227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pySU+UaLycNt2Mnc9d/1arFANwTD8nZiZk8SBrDSfas=;
        b=XGMC7A2/x4iW4EFOv2CHBIYKq478NUmBkTpBUkrmZviqkvdUoQNseg/V7iPFx19GgD
         0WmvnqBfSGCpbMfxXvvwSK6s+TyFNATVo38J1iKqXWhv8kI1JAs7DBalGrnVNcgh9lXR
         BOjStG2HooAqB+O3V0LFvS8UhPgY3D2Guh3GZaRrt1fH9m1rWOps/64CZmnnm6Z4TkFt
         M9HiYAF+wwvJCP6ov7qImSaK4rGWri0yESNkGbNXLSkQvx09//d3w8yGmfwamQ8Wn893
         KRqq0G5T1FKj1FTxmacgC+NhYq31QtHHTYQd1DwbgIG4bfJqzaCf2tt18QJbYsEmjEK7
         9Q7w==
X-Forwarded-Encrypted: i=1; AJvYcCWAUPWL/914ELNEZDP/CjE1MxfHSmDEvYU5XJo597lkLL8qgMohQkTyh3s7SWOwV24DIlN5MweqwqhADVco@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5hLejafWaVE+mp1VLpZSD4X1ReMgDfkwROtxy1VJsiXs7b8AD
	jq+B/f04lFm0ssoS9nLnXGke4qvmlCSnPJKYDjFaKYx29NWxaXKy62HXuGkeMR8=
X-Gm-Gg: ASbGncvF/iV5aiGeQ1JBs/EXpi0jP8qCax7QVWbFZSyUmiBuEED2FeDb4Ff/Op3XJDK
	BWpB1lBb2+rZb/HSBPRiO3oXCKHSqMhmnttwixxvt0rb9t5GD09nE53LZ/YOdYB+uXdoQ9gIgwG
	r3Cu1Zo3b3tJI6YsmGOcS5fe4L/2ViiBjih1+5AYSCPn3u0oT+T3NFt6FSUO9aIYd7+Xbn/yNhB
	uUDkh8F5aCYkC/tiFzflEwPWRD64dGXolbe7SwwfO5GEf6vz5MgqXqWJ0tCLU4NeWTP9tfd1eUS
	RyNv+gpuHY6KNC2nm3JPwM3onDvynurNosutV+NqU0IrOw==
X-Google-Smtp-Source: AGHT+IEdBGu/0/k4U5s63BnQhlq32zTJkGXSwTBdNLTg/0XWbTsLvr9v7sw3E1OMTa7Le6tOBENH1g==
X-Received: by 2002:a05:6a00:4085:b0:72d:8d98:c256 with SMTP id d2e1a72fcca58-72daf945d6dmr21452387b3a.6.1737422425693;
        Mon, 20 Jan 2025 17:20:25 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba4ebf3sm7653322b3a.124.2025.01.20.17.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:20:25 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1ta2wI-00000008TAc-04vH;
	Tue, 21 Jan 2025 12:20:22 +1100
Date: Tue, 21 Jan 2025 12:20:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, lsf-pc@lists.linuxfoundation.org,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] allowing parallel directory modifications at
 the VFS layer
Message-ID: <Z472VjIvT78DskGv@dread.disaster.area>
References: <>
 <Z41z9gKyyVMiRZnB@dread.disaster.area>
 <173732553757.22054.12851849131700067664@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173732553757.22054.12851849131700067664@noble.neil.brown.name>

On Mon, Jan 20, 2025 at 09:25:37AM +1100, NeilBrown wrote:
> On Mon, 20 Jan 2025, Dave Chinner wrote:
> > On Sat, Jan 18, 2025 at 12:06:30PM +1100, NeilBrown wrote:
> > > 
> > > My question to fs-devel is: is anyone willing to convert their fs (or
> > > advice me on converting?) to use the new interface and do some testing
> > > and be open to exploring any bugs that appear?
> > 
> > tl;dr: You're asking for people to put in a *lot* of time to convert
> > complex filesystems to concurrent directory modifications without
> > clear indication that it will improve performance. Hence I wouldn't
> > expect widespread enthusiasm to suddenly implement it...
> 
> Thanks Dave!
> Your point as detailed below seems to be that, for xfs at least, it may
> be better to reduce hold times for exclusive locks rather than allow
> concurrent locks.  That seems entirely credible for a local fs but
> doesn't apply for NFS as we cannot get a success status before the
> operation is complete.

How is that different from a local filesystem? A local filesystem
can't return from open(O_CREAT) with a struct file referencing a
newly allocated inode until the VFS inode is fully instantiated (or
failed), either...

i.e. this sounds like you want concurrent share-locked dirent ops so
that synchronously processed operations can be issued concurrently.

Could the NFS client implement asynchronous directory ops, keeping
track of the operations in flight without needing to hold the parent
i_rwsem across each individual operation? This basically what I've
been describing for XFS to minimise parent dir lock hold times.

What would VFS support for that look like? Is that of similar
complexity to implementing shared locking support so that concurrent
blocking directory operations can be issued? Is async processing a
better model to move the directory ops towards so we can tie
userspace directly into it via io_uring?

> So it seems likely that different filesystems
> will want different approaches.  No surprise.
> 
> There is some evidence that ext4 can be converted to concurrent
> modification without a lot of work, and with measurable benefits.  I
> guess I should focus there for local filesystems.
> 
> But I don't want to assume what is best for each file system which is
> why I asked for input from developers of the various filesystems.
> 
> But even for xfs, I think that to provide a successful return from mkdir
> would require waiting for some IO to complete, and that other operations

I don't see where IO enters the picture, to be honest. File creation
does not typically require foreground IO on XFS at all (ignoring
dirsync mode). How did you think we scale XFS to near a million file
creates a second? :) 

In the case of mkdir, it does not take a direct reference to the
inode being created so it potentially doesn't even need to wait for
the completion of the operation. i.e. to use the new subdir it has
to be open()d; that means going through the ->lookup path and which
will block on I_NEW until the background creation is completed...

That said, open(O_CREAT) would need to call wait_on_inode()
somewhere to wait for I_NEW to clear so operations on the inode can
proceed immediately via the persistent struct file reference it
creates.  With the right support, that waiting can be done without
holding the parent directory locked, as any new lookup on that
dirent/inode pair will block until I_NEW is cleared...

Hence my question above about what does VFS support for
async dirops actually looks like, and whether something like this:

> might benefit from starting before that IO completes.
> So maybe an xfs implementation of mkdir_shared would be:
>  - take internal exclusive lock on directory
>  - run fast foreground part of mkdir
>  - drop the lock
>  - wait for background stuff, which could affect error return, to
>   complete
>  - return appropriate error, or success

as natively supported functionality might be a better solution to
the problem....

From the XFs perspective, we already have internal exclusive locking
for dirent mods, but that is needed for serialising the physical
directory mods against other (shared access) readers (e.g. lookup
and readdir).  We would not want to be sharing such an internal lock
across the unbound fast path concurrency of lookup, create, unlink,
readdir -and- multiple background processing threads.

Logging a modification intent against an inode wouldn't require a
new internal inode lock; AFAICT all it requires is exclusivity
against lookup so that lookup can find new/unlinked dirents that
have been logged but not yet added to or removed from the physical
directory blocks.

We can do that by inserting the VFS inode into cache in the
foreground operation and leaving I_NEW set on create.  We can do a
similar thing with unlink (I_WILL_FREE?) to make the VFS inode
invisible to new lookups before the unlink has actually been
processed. In this way, we can push the actual processing into
background work queues without actually changing how the namespace
behaves from a user perspective...

We -might- be able to do all these operations under a shared VFS
lock, but it is not necessary to have a shared VFS lock to enable
such a async processing model. If the performance gains for the NFS
client come from allowing concurrent processing of individual
synchronous operations, then we really need to consider if there are
other methods of hiding synchronous operation latency that might
be more applicable to more filesystems and high performance user
interfaces...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

