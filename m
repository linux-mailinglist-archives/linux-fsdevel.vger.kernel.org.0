Return-Path: <linux-fsdevel+bounces-25387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4159C94B536
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 04:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA961C20E55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 02:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A91286A8;
	Thu,  8 Aug 2024 02:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="iPKbu2/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C219479
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085502; cv=none; b=FCDzfX4/4Vd7gvESQQU/ZFtiqrSrNqT89pW6xLrWobXDj8Xt7F4psfNylwoH/tzMYkQcifRQOERhiYHRcX1OkXudfDNw7+nQ0lw8UPG0EBYsYdMpf2GFMNjwfrq226c3Em/3ZqrcWV2Msv3XXUhMjnZhsWv3D9vqbBbDmda1mXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085502; c=relaxed/simple;
	bh=pqLnDKmjmdkzqLgMc7COLcyIleQFA8U2LLJvydwurYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqeKRPz3Q6HDznWWc+fPjqLiS5dLuO4tLN4od9KHpLtMVo1RgEzAN6MWBSipQT8DEuK5erzTr3bxeX3sUd/kEXjRi2iMk/XA2UPixaeIuHqbK8O5BW3YWLne7Cwlo8mMCXJogTeG6dFc+wO0GxXokuHDscF1ZVVW9YCGiVNwbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=iPKbu2/Q; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cf213128a1so440025a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 19:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723085500; x=1723690300; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4kJorMNkq3HFdOsbMyrTRWEciqUHJLMmLx1oCs6yIkM=;
        b=iPKbu2/QEOT18CjmGVSg0FKY9ISoKQRYT1fe4rFqiPEYAnroaxUDRJHPnlcZQha3tq
         QMDlwpa2aNeIrIFXfViZbSXTIJsTxfxl2KJLYU14vNfhCeL+ZXbCnu6RYddWJgIR64lt
         OVMXXFN1dDUJaXvttfXFLkuqYgyOKFnAW8AYmj9tQ62YqFVhirxvePeydRupZV3wIfKo
         B6MNIznOeFt1uDmp5KWsYFiXZsEi45GDWNdrhcQen6JYtNqgaBLLUQYvPZWL6u+Porv4
         wwbX9mz1lwh8Uv7DatoATMbwDbyxvAqSyaazkuX5aLYnJURq/PKfXUF9xCjhAOprey1u
         gbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723085500; x=1723690300;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kJorMNkq3HFdOsbMyrTRWEciqUHJLMmLx1oCs6yIkM=;
        b=d84ESRrW6LZPuR6eVQkZS22TuYncLiyvVBpMOcgEfvRAlathbSJxgjAW5gZ+G5vBUe
         b83L4vOY1scpDpfh1S0W2vy/qif6gyRSffcobTKemzsq61w+LeG4P3oGxo3XnMp2aZw3
         sdwJow9Q4+UDBNguzubtA0xYwgZFt5jVO/JayXQpLtWiuVlOfZwmPQUZdPJHOqlKNnWR
         u6y7cPssWCyTG2M/QZi0U4I6AXVNUu69ynVe9y+pcdCqlz36BP27l98hystpNMnfUU7d
         5TLxMjwdmA5w2L+xqdQIEL0eqMUvQFvWWbzuIOlgcD1mazqfX4zjxqMiG9ssS/5YCacH
         sLyg==
X-Forwarded-Encrypted: i=1; AJvYcCXmnR1tdffuhKDON1ECepBfVBDxxESEATUCy+DN8odwbEf0+Zji2OtPc5c71FSzbvptwk5w56VF99sKR/+GuMU49gqqIwRSpKwpCEPqMA==
X-Gm-Message-State: AOJu0YxiTyGBMQMmnrWenkSfUQq2Lst9jZPV4K8AWF4sYDxXHktYHpab
	MAFP9wuqxKmrXrfWaQhvbFPnX3Q/WTzT6fpu1J7uvxIiMpTJs9efsoZj08DCN+I=
X-Google-Smtp-Source: AGHT+IE77SOAL8TX2oPvvS55MjRwYTGrEaObAs1ahVg2KggO4o8DYoILJJN6qlDA0pnDpldZ64292A==
X-Received: by 2002:a17:90b:390c:b0:2ca:8684:401a with SMTP id 98e67ed59e1d1-2d1c3461395mr613796a91.32.1723085499965;
        Wed, 07 Aug 2024 19:51:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3ab3d55sm2367493a91.17.2024.08.07.19.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 19:51:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sbtFY-009FaH-2W;
	Thu, 08 Aug 2024 12:51:36 +1000
Date: Thu, 8 Aug 2024 12:51:36 +1000
From: Dave Chinner <david@fromorbit.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
Message-ID: <ZrQyuBQJ35i+SB/6@dread.disaster.area>
References: <20240804080251.21239-1-laoar.shao@gmail.com>
 <20240805134034.mf3ljesorgupe6e7@quack3>
 <CALOAHbCor0VoCNLACydSytV7sB8NK-TU2tkfJAej+sAvVsVDwA@mail.gmail.com>
 <20240806132432.jtdlv5trklgxwez4@quack3>
 <CALOAHbASNdPPRXVAxcjVWW7ucLG_DOM+6dpoonqAPpgBS00b7w@mail.gmail.com>
 <ZrKbGuKFsZsqnrfg@dread.disaster.area>
 <CALOAHbDqqvtvMMN3ebPwie-qtEakRvjuiVe9Px8YXWnqv+Mxqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDqqvtvMMN3ebPwie-qtEakRvjuiVe9Px8YXWnqv+Mxqg@mail.gmail.com>

On Wed, Aug 07, 2024 at 11:01:36AM +0800, Yafang Shao wrote:
> On Wed, Aug 7, 2024 at 5:52 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Tue, Aug 06, 2024 at 10:05:50PM +0800, Yafang Shao wrote:
> > > On Tue, Aug 6, 2024 at 9:24 PM Jan Kara <jack@suse.cz> wrote:
> > > > On Tue 06-08-24 19:54:58, Yafang Shao wrote:
> > > > > Its guarantee is clear:
> > > > >
> > > > >   : I/O is intended to be atomic to ordinary files and pipes and FIFOs.
> > > > >   : Atomic means that all the bytes from a single operation that started
> > > > >   : out together end up together, without interleaving from other I/O
> > > > >   : operations.
> > > >
> > > > Oh, I understand why XFS does locking this way and I'm well aware this is
> > > > a requirement in POSIX. However, as you have experienced, it has a
> > > > significant performance cost for certain workloads (at least with simple
> > > > locking protocol we have now) and history shows users rather want the extra
> > > > performance at the cost of being a bit more careful in userspace. So I
> > > > don't see any filesystem switching to XFS behavior until we have a
> > > > performant range locking primitive.
> > > >
> > > > > What this flag does is avoid waiting for this type of lock if it
> > > > > exists. Maybe we should consider a more descriptive name like
> > > > > RWF_NOATOMICWAIT, RWF_NOFSLOCK, or RWF_NOPOSIXWAIT? Naming is always
> > > > > challenging.
> > > >
> > > > Aha, OK. So you want the flag to mean "I don't care about POSIX read-write
> > > > exclusion". I'm still not convinced the flag is a great idea but
> > > > RWF_NOWRITEEXCLUSION could perhaps better describe the intent of the flag.
> > >
> > > That's better. Should we proceed with implementing this new flag? It
> > > provides users with an option to avoid this type of issue.
> >
> > No. If we are going to add a flag like that, the fix to XFS isn't to
> > use IOCB_NOWAIT on reads, it's to use shared locking for buffered
> > writes just like we do for direct IO.
> >
> > IOWs, this flag would be needed on -writes-, not reads, and at that
> > point we may as well just change XFS to do shared buffered writes
> > for -everyone- so it is consistent with all other Linux filesystems.
> >
> > Indeed, last time Amir brought this up, I suggested that shared
> > buffered write locking in XFS was the simplest way forward. Given
> > that we use large folios now, small IOs get mapped to a single folio
> > and so will still have the same write vs overlapping write exclusion
> > behaviour most all the time.
> >
> > However, since then we've moved to using shared IO locking for
> > cloning files. A clone does not modify data, so read IO is allowed
> > during the clone. If we move writes to use shared locking, this
> > breaks file cloning. We would have to move cloning back to to using
> > exclusive locking, and that's going to cause performance and IO
> > latency regressions for applications using clones with concurrent IO
> > (e.g. VM image snapshots in cloud infrastruction).
> >
> > Hence the only viable solution to all these different competing "we
> > need exclusive access to a range of the file whilst allowing other
> > concurrent IO" issues is to move to range locking for IO
> > exclusion....
> 
> The initial post you mentioned about range locking dates back to 2019,
> five years ago. Now, five years have passed, and nothing has happened.
> 
> In 2029, five years later, someone else might encounter this issue
> again, and the response will be the same: "let's try range locking."
> 
> And then another five years will pass...
> 
> So, "range locking == Do nothing."

How long do you think it would take you to understand the entire
serialisation model for a complex subsystem, understand where it is
deficient and then design a novel, scalable serialisation technique
that addresses that problem with only limited IO performance
regressions?

Some context:

It took me 6 years to work out how to do delayed logging in XFS once
I first learnt of the idea back in 2004. It took me 4 -from scratch-
design and implementation efforts before I found a solution that
didn't have a subtle, fatal architectural issue in it. Once I solved
the deadlock issues in early 2010, it took about 4 months from first
code to being merged in 2.6.35.

It took me 7 years to go from my initial "self describing metadata"
idea (2006) ideas to actually having it implemented and fully merged
in 2013. I described reverse mapping at the same time, and that took
another couple of years to realise.

It took me close to 10 years and 6 or 7 separate attemps to solve
the "XFS needs blocking RMW IO in the inode reclaim shrinker to
prevent OOM" problem. This caused memory allocation latency problems
for many production environments over the course of a decade, and
the problem was around that long because it took me an awful long
time to work out how to pin inode cluster buffers in memory without
deadlocking inode modification or inode cluster writeback.

These sorts of complex problems are *hard to solve* and it often
takes several attempts that fail to learn what -doesn't work- before
a successful architecture, design and implementation is realised.

Often, there is no prior art out there that we can use to help solve
the problem. Sure, for range locking there's heaps of academic
papers out there about scaling concurrency in database key
operations (SIX, MGL, ARIES/KVL, multi-dimension key-range lock
separation, intention locking, speculative lock inheritance,
lightweight intent locks, etc), but none of the underlying
algorithms have any significant relevance to the problem we need to
solve.

There's also papers aout there about how to scale concurrent btree
modifications. Latching, lock coupling, optimistic lock coupling,
etc. The problem with these papers is that they often gloss over or
ignore important details such as how they deal with node contention,
how concurrent unlocked traversal and modification to the same node
are safely handled (i.e. NX concurrency algorithms), how a top-down
traversal algorithm that doesn't guarantee temporal path stability
is used for bottom up key update propagation (OLC-based algorithms),
etc.D...

They also tend to focus on huge static data sets where concurrent
random operations are guaranteed to have unique paths and minimal
contention. Hence the researchers are able to demonstrate how much
better their new algorithm scales than the previous state of the
art.  However, they rarely demonstrate how the algorithm scales
down, and that's something we really care about for range locks. A
couple of the scalable range indexing algorithms I prototyped simply
didn't work for small data sets - they performed far worse than just
using a single tree-wide mutex.

Hence we are in a situation where I can't find an algorithm in
existing computer science literature that will work for our problem
case.  Hence we need to come up with a novel algorithm that solves
the problem ourselves. This is an iterative process where we learn
by failing and then understanding why what we did failed.

Davidlohr Bueso attempted to solve mmap_sem issues with an interval
tree based range lock. From that implementation, I learnt that the
cost of per-range cacheline misses walking the rb-tree under the
tree-wide spin lock was the major performance limitation of that
range lock.

I took that observation, and attempted to adapt that code to a btree
(based on the XFS iext btree). That performed a little better, but
removing the cacheline miss penalty from the search algorithm simply
moved the bottleneck to the spin lock. i.e. I learnt that we can't
use a global scope spin lock for protecting the range lock tree -
the total number of range lock/unlock operations is bound entirely
by how many we can process on a single CPU because they are all done
under a single spinlock.

Further, per-inode IO concurrency is unbound, but a single
inode-wide serialisation primitive will not scale beyond a 3-4 CPUs
doing IO at the same time. This taught me IO path usage of per-IO,
per-inode exclusive cachelines needs to be avoided if at all
possible.

I made another attempt a year or so later after doing a lot of
reading about scalable btree structures. The second attempt expanded
the original btree I used with an OLC based architecture. I called
in an RCU-pathwalk btree because it used RCU and sequence numbers in
a very similar way to the dentry cache RCU pathwalk algorithm. This
provided range locks with a high concurrency range tracking
structure.

In some situations it scaled out to millions of lock/unlock
operations per second (far exceeding perf/scalability requirements),
but in others performance was miserably and was 10x slower than
plain exclusive locking. IOWs, another failure.

Again, I learn a lot about what not to do from that attempt. I've
spent a good deal of time in the past two years reading through
decades of database key range locking optimisation papers in an
effort to understand how I might address the issues I came across.
I have also had time to understand why several implementation issues
existed and how to avoid/mitigate them in the new design I'm
currently working on.

So, yeah, I haven't written any rangelock code in the past couple of
years, but:

$ wc -l Documentation/filesystems/xfs-IO-rangelocks.rst
749 Documentation/filesystems/xfs-IO-rangelocks.rst
$

I've been writing up a design doc as I've been doing this analysis
and research to document the problems and the solutions. I think I'm
close to the point where I can start implementing this new
design.

Clearly, I've been busy doing a lot of nothing on rangelocks, thank
you very much.

> I'm not saying it's your
> responsibility to implement range locking, but it seems no one else is
> capable of implementing this complex feature except you.

*cough*

There's lots of people better qualified than me to solve a problem
like this. It's a computer science problem, and I'm not a computer
scientist. I'm an engineer - I take stuff that scientists have
discovered and documented and build tools, infrastructure and
objects based on that knowledge.

What I'm not good at is coming up with novel new algorithms to solve
mathematical problems. A range lock is the latter, not the former,
and there are plenty of people who would be better suited to this
work than me.  i.e. I'm good at putting knowledge to practical use,
not creating new knowledge.

However, I'm spending time on it because nobody else is going to
solve the problem for me.  CPU and IO concurrency is only going up
and shared/exclusive IO locking behaviour only gets more restrictive
as concurrency requirements go up and we use extent sharing to
avoid data copying more extensively. This problem isn't going
away...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

