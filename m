Return-Path: <linux-fsdevel+bounces-50699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF0CACE84B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 04:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B5A3A9478
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 02:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2B21C84BD;
	Thu,  5 Jun 2025 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xRjqf4K5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2987184E1C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749089911; cv=none; b=fYvLWWrbmBa1kmdNE8jjPJd6Dq4YjhHzyEcePj++3b8wYrUfsqnZ+2ki3oMVYvz5zjDKKXjW+UmigXCX3jLgZ5/R2qFtT2ltebDKzzTFXDvgmV3uL7ZhumUfekRqJQB+iSMlE2mSiVtIYWQS9b1ZRTibxXNtRAkzbFcEYWDdJ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749089911; c=relaxed/simple;
	bh=oKLrq3LkMGcUPUQ8HC2KeoIJNZflHohKWLTvfPKkYOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+7wZl88XOPaGVymHEXkMBLe3gxFwn/KVw75QtIqM4iKYypKS7MfyKBbHAhUTMLvQ506x4kBgu+twZBqSq1O988loU6apAjy9q+Izl1xSNmAknbTxJhhvkuwyr7RZmKi3dOrI4TH2xb/qWU+UePC6PaNtqvsc6W1jAIgfNdSAug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xRjqf4K5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso497551a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 19:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1749089908; x=1749694708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GIlo+91JgceZh066zSfkz/j92F4Jjfj0Sae05ZH3rsE=;
        b=xRjqf4K5R2bvFrmkj7lp++z3ctVwZvyLEEkTCB1zv+111solXY5zp8ADLUaT0FWDAo
         XacsrhX+udEUcYnHfrZe9O5CXEF761TJAutXtv7zejtjGQ6uiMU6IyHAFOYSR/dcgHJz
         eywXJ2GXmz//VlhusIYleTSP8NOBdjVcGBk7HMQVCUIEBgvKTNxJb15Fq5DmakDdYvaE
         tk/dsz1FxczXsi2x+nWq4+Fuu/QgRg9ZmRQTz+YVakh8QCOXuJTT2P6jlsCeL1ftly1u
         gz29VnMGRzldt5QnAKTV8WBRMSZJhiMzGq806wAFZf5OpVONppbLEjEv3IykIczQsuJ5
         pKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749089908; x=1749694708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIlo+91JgceZh066zSfkz/j92F4Jjfj0Sae05ZH3rsE=;
        b=HbCACgfVlDJFKl34bx7sRaHrJNeo0E+GFcfmBDsIxzJMhQoAgU6lcHcEMDtju5c1HF
         6knu2jTZ9IUTaB8hJ1uNbc0jURdzanSOEG1d4VJT+I3l8yVnA3BohhpBd24W/jxiYxZ3
         keT8g1sCPN05xxBoOhDuBjORTmxac1HlxYo/AgJ7j4aGMJX7sGfSZjNA4FQqnEJTkoZw
         AHwPQYPp0+JKDhdePiVwA1RRJlhhMKh0y33uJmXoFVEfDw10/p+DUHf+nJaz1ornw5QE
         ZUDOgLcSrQvXVR3reInh8+aS54z5yV6g+I2AQngts9ypS6gAZaGdhVrS0irIhDG8WN5F
         go8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXz72cF/YI+dlpz00Pkq84dKuOkKvAA8BnCEbkmj8NSH+699xFCg1X3Y4pV11VxrJDjUTXQFNoD2q5mWDJZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwxmkkqCM6K/tHc976OpOjM24I2KwJWBmO/F6rQVQPG4DbECAmP
	DNfNhhm6OwzalcM5o0nYxvHwMoXb1d4unve86aAUHJXFGvYJF9tD6nbB0iw6MDCjKSw=
X-Gm-Gg: ASbGncv62qQKQnpZ5yoz9AodXAGWdGVK47Q79663WiIw265Xj5jwtjIxqNxfPEWT3Q0
	zKmioha//in+RTSqEBbWfpoMkJz0FMckmabnabkBy8q4G2TlcHiNc8oNBhTDMaH0N6ZhCW/74zl
	Mcw1MnrWD0XRnb5td5mhPn1dot324z/iVa86cofPy8CYpdyiqeQhihp4YJc/dnNZo1yv47/XX2/
	xeiepsUcj9REH7tJcaxqWFTHpJWIEBbKlpi5rO+wgxFxlQdYLqz0OxaPH6BmvPbCSx/u0XUT4nM
	LAlV19pMXe3s7RUAo3ts63I1CI//2XHICt2JGO05L8UuYKSPBCk1EXy8z7BebnC+2ilH3pS7Oyr
	NFQHesof+061TrhSq05CXlFA1pwegml664xfJmw==
X-Google-Smtp-Source: AGHT+IH6bHhYTyPwUJqdduYKJe/Xp4OLknT5tmMTMfHrH618snfAXJgfJeQ23BBEFxD4c+6G1Fl4xA==
X-Received: by 2002:a17:90b:28c7:b0:311:e8cc:4248 with SMTP id 98e67ed59e1d1-3130cdfd3fcmr8349271a91.33.1749089908192;
        Wed, 04 Jun 2025 19:18:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313319d4576sm117035a91.28.2025.06.04.19.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 19:18:27 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uN0BU-0000000CNbj-0W27;
	Thu, 05 Jun 2025 12:18:24 +1000
Date: Thu, 5 Jun 2025 12:18:24 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aED-cKvPKMsDlS0T@dread.disaster.area>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aDfkTiTNH1UPKvC7@dread.disaster.area>
 <aD04v9dczhgGxS3K@infradead.org>
 <aD4xboH2mM1ONhB-@dread.disaster.area>
 <aD5-_OOsKyX0rDDO@infradead.org>
 <aD9xj8cwfY9ZmQ2B@dread.disaster.area>
 <aD_oobAbOs7m8PFN@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD_oobAbOs7m8PFN@infradead.org>

On Tue, Jun 03, 2025 at 11:33:05PM -0700, Christoph Hellwig wrote:
> On Wed, Jun 04, 2025 at 08:05:03AM +1000, Dave Chinner wrote:
> > > 
> > > Everything.  ENOSPC means there is no space.  There might be space in
> > > the non-determinant future, but if the layer just needs to GC it must
> > > not report the error.
> > 
> > GC of thin pools requires the filesystem to be mounted so fstrim can
> > be run to tell the thinp device where all the free LBA regions it
> > can reclaim are located. If we shut down the filesystem instantly
> > when the pool goes ENOSPC on a metadata write, then *we can't run
> > fstrim* to free up unused space and hence allow that metadata write
> > to succeed in the future.
> > 
> > It should be obvious at this point that a filesystem shutdown on an
> > ENOSPC error from the block device on anything other than journal IO
> > is exactly the wrong thing to be doing.
> 
> How high are the chances that you hit exactly the rate metadata
> writeback I/O and not journal or data I/O for this odd condition
> that requires user interaction?

100%.

We'll hit it with both data IO and metadata IO at the same time,
but in the vast majority of cases we won't hit ENOSPC on journal IO.

Why? Because mkfs.xfs zeros the entire log via either
FALLOC_FL_ZERO_RANGE or writing physical zeros. Hence a thin device
always has a fully allocated log before the filesystem is first
mounted and so ENOSPC to journal IO should never happen unless a
device level snapshot is taken.

i.e. the only time the journal is not fully allocated in the block device
is immediately after a block device snapshot is taken. The log needs
to be written entirely once before it is fully allocated again, and
this is the only point in time we will see ENOSPC on a thinp device
for journal IO.

Because the log IO is sequential, and the log is circular, there is
no write or allocation amplification here and once the log has been
written once further writes are simply overwriting allocated LBA
space. Hence after a short period of time of activity after a
snapshot, ENOSPC from journal IO is no longer a possibility. This
case is the exception rather than common behaviour.

Metadata writeback is a different story altogether.

When we allocate and write back metadata for the first time (either
after mkfs, fstrim or a device snapshot) or overwrite existing
metadata after a snapshot, the metadata writeback IO will
always require device side space allocation.

Unlike the neat sequential journal IO, metadata writeback is
effectively random small write IO. This triggers worse case
allocation amplification on thinp devices, as well as worst case
write amplification in the case of COW after a snapshot. metadata
writeback - especially overwrite after snapshot + modification - is
the worst possible write pattern for thinp devices.

It is not unusual to see dm-thin devices with a 64kB block size have
allocation and write amplification factors of 15-16 on 4kB block
size filesystems after a snapshot as every single random metadata
overwrite will now trigger a 64kB COW in the dm-thin device to break
blocks shared between snapshots.

So, yes, metadata writeback is extremely prone to triggering ENOSPC
from thin devices, whilst journal IO almost never triggers it.

> Where is this weird model where a
> storage device returns an out of space error and manual user interaction
> using manual and not online trim is going to fix even documented?

I explicitly said that the filesystem needs to remain online when
the thin pool goes ENOSPC so that fstrim (the online filesystem trim
utility) can be run to inform the thin pool exactly where all the
free LBA address space is so it can efficiently free up pool space.

This is a standard procedure that people automate through things
like udev scripts that capture the dm-thin pool low/no space
events.

You seem to be trying to create a strawman here....

> > > Normally it means your checksum was wrong.  If you have bit errors
> > > in the cable they will show up again, maybe not on the next I/O
> > > but soon.
> > 
> > But it's unlikely to be hit by another cosmic ray anytime soon, and
> > so bit errors caused by completely random environmental events
> > should -absolutely- be retried as the subsequent write retry will
> > succeed.
> >
> > If there is a dodgy cable causing the problems, the error will
> > re-occur on random IOs and we'll emit write errors to the log that
> > monitoring software will pick up. If we are repeatedly isssuing write
> > errors due to EILSEQ errors, then that's a sign the hardware needs
> > replacing.
> 
> Umm, all the storage protocols do have pretty good checksums.

The strength of the checksum is irrelevant. It's what we do when
it detects a bit error that is being discussed.

> A cosmic
> ray isn't going to fail them it is something more fundamental like
> broken hardware or connections. In other words you are going to see
> this again and again pretty frequently.

I've seen plenty of one-off, unexplainable, unreproducable IO
errors because of random bit errors over the past 20+ years.

But what causes them is irrelevant - the fact is that they do occur,
and we cannot know if it transient or persistent from a single IO
context. Hence the only decision that can be made from IO completion
context is "retry or fail this IO". We default to "retry" for
metadata writeback because that automatically handles transient
errors correctly.

IOWs, if it is actually broken hardware, then the fact we may retry
individual failed IOs in a non-critical path is irrelevant. If the
errors persistent and/or are widespread, then we will get an error
in a critical path and shut down at that point. 

This means the architecture is naturally resilient against transient
write errors, regardless of their cause.  We want XFS to resilient;
we do not want it to be brittle or fragile in environments that are
slightly less than perfect, unless that is the way the admin wants
it to behave. We just the admin the option to choose how their
filesystems respond to such errors, but we default to the most
resilient settings for everyone else.

> > There is no risk to filesystem integrity if write retries
> > succeed, and that gives the admin time to schedule downtime to
> > replace the dodgy hardware. That's much better behaviour than
> > unexpected production system failure in the middle of the night...
> > 
> > It is because we have robust and resilient error handling in the
> > filesystem that the system is able to operate correctly in these
> > marginal situations. Operating in marginal conditions or as hardware
> > is beginning to fail is a necessary to keep production systems
> > running until corrective action can be taken by the administrators.
> 
> I'd really like to see a format writeup of your theory of robust error
> handling where that robustness is centered around the fairly rare
> case of metadata writeback and applications dealing with I/O errors,
> while journal write errors and read error lead to shutdown.

.... and there's the strawman argument, and a demand for formal
proofs as the only way to defend against your argument.

> Maybe
> I'm missing something important, but the theory does not sound valid,
> and we don't have any testing framework that actually verifies it.

I think you are being intentionally obtuse, Christoph. I wrote this
for XFS back in *2008*:

https://web.archive.org/web/20140907100223/http://xfs.org/index.php/Reliable_Detection_and_Repair_of_Metadata_Corruption

The "exception handling" section is probably appropriate here,
but whilst the contents are not directly about this particular
discussion, the point is that we've always considered there to be
types of IO errors that are transient in nature. I will quote part
of that section:

"Furthermore, the storage subsystem plays a part in deciding how to
handle errors. The reason is that in many storage configurations I/O
errors can be transient. For example, in a SAN a broken fibre can
cause a failover to a redundant path, however the inflight I/O on
the failed path is usually timed out and an error returned. We don't want
to shut down the filesystem on such an error - we want to wait for
failover to a redundant path and then retry the I/O. If the failover
succeeds, then the I/O will succeed. Hence any robust method of
exception handling needs to consider that I/O exceptions may be
transient. "

The point I am making that is that the entire architecture of the
current V5 on-disk format, the verification architecture and the
scrub/online repair infrastructure was very much based on the
storage device model that *IO errors may be transient*.

> 
> > Failing to recognise that transient and "maybe-transient" errors can
> > generally be handled cleanly and successfully with future write
> > retries leads to brittle, fragile systems that fall over at the
> > first sign of anything going wrong. Filesystems that are targetted
> > at high value production systems and/or running mission critical
> > applications needs to have resilient and robust error handling.
> 
> What known transient errors do you think XFS (or any other file system)
> actually handles properly?  Where is the contract that these errors
> actually are transient.

Nope, I'm not going to play the "I demand that you prove the
behaviour that has existed in XFS for over 30 years is correct",
Christoph.

If you want to change the underlying IO error handling model that
XFS has been based on since it was first designed back in the 1990s,
then it's on you to prove to every filesystem developer that IO
errors reported from the block layer can *never be transient*.

Indeed, please provide us with the "contract" that says block
devices and storage devices are not allowed to expose transient IO
errors to higher layers.

Then you need show that ENOSPC from a dm-thin device is *forever*,
and never goes away, and justify that behaviour as being in the best
interests of users despite the ease of pool expansion to make ENOSPC
go away.....

It is on you to prove that the existing model is wrong and needs
fixing, not for us to prove to you that the existing model is
correct.

> > > And even applications that fsync won't see you fancy error code.  The
> > > only thing stored in the address_space for fsync to catch is EIO and
> > > ENOSPC.
> > 
> > The filesystem knows exactly what the IO error reported by the block
> > layer is before we run folio completions, so we control exactly what
> > we want to report as IO compeltion status.
> 
> Sure, you could invent a scheme to propagate the exaxct error.  For
> direct I/O we even return the exact error to userspace.  But that
> means we actually have a definition of what each error means, and how
> it could be handled.  None of that exists right now.  We could do
> all this, but that assumes you actually have:
> 
>  a) a clear definition of a problem
>  b) a good way to fix that problem
>  c) good testing infrastructure to actually test it, because without
>     that all good intentions will probably cause more problems than
>     they solve
> 
> > Hence the bogosities of error propagation to userspace via the
> > mapping is completely irrelevant to this discussion/feature because
> > it would be implemented below the layer that squashes the eventual
> > IO errno into the address space...
> 
> How would implement and test all this?  And for what use case?

I don't care, it's not my problem to solve, and I don't care if
nothing comes of it.

A fellow developer asked for advice, I simply suggested following an
existing model we already have infrastructure for. Now you are
demanding that I prove the existing decades old model is valid, and
then tell you how to solve the OG's problem and make it all work.

None of this is my problem, regardless of how much you try to make
it so.

Really, though, I don't know why you think that transient errors
don't exist anymore, nor why you are demanding that I prove that
they do when it is abundantly clear that ENOSPC from dm-thin can
definitely be a transient error.

Perhaps you can provide some background on why you are asserting
that there is no such thing as a transient IO error so we can all
start from a common understanding?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

