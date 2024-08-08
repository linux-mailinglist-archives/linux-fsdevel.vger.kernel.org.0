Return-Path: <linux-fsdevel+bounces-25417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176AA94BE56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 15:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE19428D425
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 13:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D776C18DF65;
	Thu,  8 Aug 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfl+X6hd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105913BC3F
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123006; cv=none; b=jAznfcBbW+f4QtcKWT8JcaTtwveOG1++k5fpqhlRd1uv/McetNcZ5uTI9gUvHMmq9uf7PnB/7qP+91taZTooGgbfAnhnA0Mo83+rGOQaplTgGwNegn7NSXF5bDcIalacU29i62RzetaAOVemfkzjSH9cC6YaBsi1CaPlfzht9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123006; c=relaxed/simple;
	bh=fnLtVxfPQxTFgsBZ1EAAwtd0pbt6+5q8TOpoTK1IyIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0SjKUEH8OV6CVxlKkgg8nLewUYHfBbk1eOx/UFcf1qggn2xF5CZymetHHiC2FvbD3SDZsVm2lx00KP5tE22Gd88746rw/bQUx7u62bVE+zOWVwO212pyEAA8Ptk7lVPYVOjtXlpCFpAAMMC0R7bwg+OvcuMLI5Hd/Llx8k7vO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfl+X6hd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cd5e3c27c5so780323a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 06:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723123004; x=1723727804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDUmkZZjYykmqfB6ZwvtEcEw34Q4RXb59z6SLou8wPg=;
        b=jfl+X6hdWuBlRItDiQRYBsa4EdaYG6p684taZYH3tDn+nOkVO5CY7GKxzirul26KCS
         pf2tcWLxcuIHRLJpZIsUcPFnWDa6OCrQZ7v8sZOc1IJhk3glY/nwXv/nlhFjnEizlfaa
         JERfAP9yS4lDNtQqZ4lMDwxOpuEKYc/UsPkiJ9miiLeOSJkLxjX0DcrR9xkTUBCE4f0V
         e5vMl6BNHmN7xr2eAhgRh2AE1v/TmQI2Jqy7rCSENOdisELoRqKISzDb6g4Q+HpAUYky
         xh9zaKU6fM5R6/LtGJ6ax/u3xO8bH6arlWnZw3GvmItztiVFmST5RYz6S8OVvTyZynGH
         CXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723123004; x=1723727804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDUmkZZjYykmqfB6ZwvtEcEw34Q4RXb59z6SLou8wPg=;
        b=CyBZSZT3GjXgepH+3AHlTV0VFcYWGnff28FEj06vgKm9o5su8f+xPUGH9OPC7vFsmX
         K5W3vrY3vk+k55ePyPv8i+Dn4hLioyLt8a0dOapLcp/c195eOIOUHQJCwExgoWtYvnSX
         l5D/syXsdut2r5qL+A/ZnYihhkS1FHVgLkmS+hfHrBdN+47mscZr78aWTYjQ98t4Dbb8
         pMa2jRuUR3+yBs6Fb7hhnexqEUZbJcjG4QK8CSJ2elJi/Od96Q5WPhJFWwj9WNIqRwuM
         Cuey1y0ed1vASU6p6755GLsd0/M/yBoKLR4aV4kBdZXiil3T8eEk8bztPbjjZenohIQn
         ZfQw==
X-Forwarded-Encrypted: i=1; AJvYcCXai4phhXz9+DAgxHNruGE/WBiDpvBw1F1ltTU1Hww1vmwyoARcIxVIrTEv4x9e+jogBVR/QQ4wTBv4ar4Jl8dfe9sLV7edp/L7afQpGw==
X-Gm-Message-State: AOJu0Yz138eLJQzH/r/YEhxHHY+4aONBihFi+GEez0VBVdRwI8D6+j/b
	rrfiArlJV/k84rdeTbbBY9xdHD8pIm50JCHITHijWiSR6GJZJeCiKZwlYtIldIV0XLUGGFX2jpc
	PDydZXfBGgv/sTFbktt6MSNaLBTU=
X-Google-Smtp-Source: AGHT+IHyIjaV+V+nB7BUzXacM0rnzK9SpbECx9OdyfCMc+E7XrOtwCkzXMCLeDVLyYST//WSExTobNFtnSPyXYsx+JY=
X-Received: by 2002:a17:90a:d901:b0:2c8:64a:5f77 with SMTP id
 98e67ed59e1d1-2d1c3472025mr1945533a91.37.1723123003582; Thu, 08 Aug 2024
 06:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804080251.21239-1-laoar.shao@gmail.com> <20240805134034.mf3ljesorgupe6e7@quack3>
 <CALOAHbCor0VoCNLACydSytV7sB8NK-TU2tkfJAej+sAvVsVDwA@mail.gmail.com>
 <20240806132432.jtdlv5trklgxwez4@quack3> <CALOAHbASNdPPRXVAxcjVWW7ucLG_DOM+6dpoonqAPpgBS00b7w@mail.gmail.com>
 <ZrKbGuKFsZsqnrfg@dread.disaster.area> <CALOAHbDqqvtvMMN3ebPwie-qtEakRvjuiVe9Px8YXWnqv+Mxqg@mail.gmail.com>
 <ZrQyuBQJ35i+SB/6@dread.disaster.area>
In-Reply-To: <ZrQyuBQJ35i+SB/6@dread.disaster.area>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 8 Aug 2024 21:16:04 +0800
Message-ID: <CALOAHbAMh30W-bKZfLFyqQRuz1RyRzi7UAPUWH2DdKCAauk5kg@mail.gmail.com>
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 10:51=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Wed, Aug 07, 2024 at 11:01:36AM +0800, Yafang Shao wrote:
> > On Wed, Aug 7, 2024 at 5:52=E2=80=AFAM Dave Chinner <david@fromorbit.co=
m> wrote:
> > >
> > > On Tue, Aug 06, 2024 at 10:05:50PM +0800, Yafang Shao wrote:
> > > > On Tue, Aug 6, 2024 at 9:24=E2=80=AFPM Jan Kara <jack@suse.cz> wrot=
e:
> > > > > On Tue 06-08-24 19:54:58, Yafang Shao wrote:
> > > > > > Its guarantee is clear:
> > > > > >
> > > > > >   : I/O is intended to be atomic to ordinary files and pipes an=
d FIFOs.
> > > > > >   : Atomic means that all the bytes from a single operation tha=
t started
> > > > > >   : out together end up together, without interleaving from oth=
er I/O
> > > > > >   : operations.
> > > > >
> > > > > Oh, I understand why XFS does locking this way and I'm well aware=
 this is
> > > > > a requirement in POSIX. However, as you have experienced, it has =
a
> > > > > significant performance cost for certain workloads (at least with=
 simple
> > > > > locking protocol we have now) and history shows users rather want=
 the extra
> > > > > performance at the cost of being a bit more careful in userspace.=
 So I
> > > > > don't see any filesystem switching to XFS behavior until we have =
a
> > > > > performant range locking primitive.
> > > > >
> > > > > > What this flag does is avoid waiting for this type of lock if i=
t
> > > > > > exists. Maybe we should consider a more descriptive name like
> > > > > > RWF_NOATOMICWAIT, RWF_NOFSLOCK, or RWF_NOPOSIXWAIT? Naming is a=
lways
> > > > > > challenging.
> > > > >
> > > > > Aha, OK. So you want the flag to mean "I don't care about POSIX r=
ead-write
> > > > > exclusion". I'm still not convinced the flag is a great idea but
> > > > > RWF_NOWRITEEXCLUSION could perhaps better describe the intent of =
the flag.
> > > >
> > > > That's better. Should we proceed with implementing this new flag? I=
t
> > > > provides users with an option to avoid this type of issue.
> > >
> > > No. If we are going to add a flag like that, the fix to XFS isn't to
> > > use IOCB_NOWAIT on reads, it's to use shared locking for buffered
> > > writes just like we do for direct IO.
> > >
> > > IOWs, this flag would be needed on -writes-, not reads, and at that
> > > point we may as well just change XFS to do shared buffered writes
> > > for -everyone- so it is consistent with all other Linux filesystems.
> > >
> > > Indeed, last time Amir brought this up, I suggested that shared
> > > buffered write locking in XFS was the simplest way forward. Given
> > > that we use large folios now, small IOs get mapped to a single folio
> > > and so will still have the same write vs overlapping write exclusion
> > > behaviour most all the time.
> > >
> > > However, since then we've moved to using shared IO locking for
> > > cloning files. A clone does not modify data, so read IO is allowed
> > > during the clone. If we move writes to use shared locking, this
> > > breaks file cloning. We would have to move cloning back to to using
> > > exclusive locking, and that's going to cause performance and IO
> > > latency regressions for applications using clones with concurrent IO
> > > (e.g. VM image snapshots in cloud infrastruction).
> > >
> > > Hence the only viable solution to all these different competing "we
> > > need exclusive access to a range of the file whilst allowing other
> > > concurrent IO" issues is to move to range locking for IO
> > > exclusion....
> >
> > The initial post you mentioned about range locking dates back to 2019,
> > five years ago. Now, five years have passed, and nothing has happened.
> >
> > In 2029, five years later, someone else might encounter this issue
> > again, and the response will be the same: "let's try range locking."
> >
> > And then another five years will pass...
> >
> > So, "range locking =3D=3D Do nothing."
>
> How long do you think it would take you to understand the entire
> serialisation model for a complex subsystem, understand where it is
> deficient and then design a novel, scalable serialisation technique
> that addresses that problem with only limited IO performance
> regressions?
>
> Some context:
>
> It took me 6 years to work out how to do delayed logging in XFS once
> I first learnt of the idea back in 2004. It took me 4 -from scratch-
> design and implementation efforts before I found a solution that
> didn't have a subtle, fatal architectural issue in it. Once I solved
> the deadlock issues in early 2010, it took about 4 months from first
> code to being merged in 2.6.35.
>
> It took me 7 years to go from my initial "self describing metadata"
> idea (2006) ideas to actually having it implemented and fully merged
> in 2013. I described reverse mapping at the same time, and that took
> another couple of years to realise.
>
> It took me close to 10 years and 6 or 7 separate attemps to solve
> the "XFS needs blocking RMW IO in the inode reclaim shrinker to
> prevent OOM" problem. This caused memory allocation latency problems
> for many production environments over the course of a decade, and
> the problem was around that long because it took me an awful long
> time to work out how to pin inode cluster buffers in memory without
> deadlocking inode modification or inode cluster writeback.
>
> These sorts of complex problems are *hard to solve* and it often
> takes several attempts that fail to learn what -doesn't work- before
> a successful architecture, design and implementation is realised.

Thank you for all your hard work and contributions to XFS. The entire
XFS community has greatly benefited from your efforts.

>
> Often, there is no prior art out there that we can use to help solve
> the problem. Sure, for range locking there's heaps of academic
> papers out there about scaling concurrency in database key
> operations (SIX, MGL, ARIES/KVL, multi-dimension key-range lock
> separation, intention locking, speculative lock inheritance,
> lightweight intent locks, etc), but none of the underlying
> algorithms have any significant relevance to the problem we need to
> solve.
>
> There's also papers aout there about how to scale concurrent btree
> modifications. Latching, lock coupling, optimistic lock coupling,
> etc. The problem with these papers is that they often gloss over or
> ignore important details such as how they deal with node contention,
> how concurrent unlocked traversal and modification to the same node
> are safely handled (i.e. NX concurrency algorithms), how a top-down
> traversal algorithm that doesn't guarantee temporal path stability
> is used for bottom up key update propagation (OLC-based algorithms),
> etc.D...
>
> They also tend to focus on huge static data sets where concurrent
> random operations are guaranteed to have unique paths and minimal
> contention. Hence the researchers are able to demonstrate how much
> better their new algorithm scales than the previous state of the
> art.  However, they rarely demonstrate how the algorithm scales
> down, and that's something we really care about for range locks. A
> couple of the scalable range indexing algorithms I prototyped simply
> didn't work for small data sets - they performed far worse than just
> using a single tree-wide mutex.
>
> Hence we are in a situation where I can't find an algorithm in
> existing computer science literature that will work for our problem
> case.  Hence we need to come up with a novel algorithm that solves
> the problem ourselves. This is an iterative process where we learn
> by failing and then understanding why what we did failed.
>
> Davidlohr Bueso attempted to solve mmap_sem issues with an interval
> tree based range lock. From that implementation, I learnt that the
> cost of per-range cacheline misses walking the rb-tree under the
> tree-wide spin lock was the major performance limitation of that
> range lock.
>
> I took that observation, and attempted to adapt that code to a btree
> (based on the XFS iext btree). That performed a little better, but
> removing the cacheline miss penalty from the search algorithm simply
> moved the bottleneck to the spin lock. i.e. I learnt that we can't
> use a global scope spin lock for protecting the range lock tree -
> the total number of range lock/unlock operations is bound entirely
> by how many we can process on a single CPU because they are all done
> under a single spinlock.
>
> Further, per-inode IO concurrency is unbound, but a single
> inode-wide serialisation primitive will not scale beyond a 3-4 CPUs
> doing IO at the same time. This taught me IO path usage of per-IO,
> per-inode exclusive cachelines needs to be avoided if at all
> possible.
>
> I made another attempt a year or so later after doing a lot of
> reading about scalable btree structures. The second attempt expanded
> the original btree I used with an OLC based architecture. I called
> in an RCU-pathwalk btree because it used RCU and sequence numbers in
> a very similar way to the dentry cache RCU pathwalk algorithm. This
> provided range locks with a high concurrency range tracking
> structure.
>
> In some situations it scaled out to millions of lock/unlock
> operations per second (far exceeding perf/scalability requirements),
> but in others performance was miserably and was 10x slower than
> plain exclusive locking. IOWs, another failure.
>
> Again, I learn a lot about what not to do from that attempt. I've
> spent a good deal of time in the past two years reading through
> decades of database key range locking optimisation papers in an
> effort to understand how I might address the issues I came across.
> I have also had time to understand why several implementation issues
> existed and how to avoid/mitigate them in the new design I'm
> currently working on.

Thank you for the detailed explanation of all the efforts that have
gone into this. It will help others understand why it is the way it is
if it gets accepted upstream. I appreciate the challenges you=E2=80=99re
facing, even though I may not fully grasp all the technical details.

>
> So, yeah, I haven't written any rangelock code in the past couple of
> years, but:
>
> $ wc -l Documentation/filesystems/xfs-IO-rangelocks.rst
> 749 Documentation/filesystems/xfs-IO-rangelocks.rst
> $

I couldn=E2=80=99t find any information about it online. It would be really
helpful if you could share your current progress and the roadmap
somewhere. This could help others better understand XFS range locking
and potentially contribute to the effort.

>
> I've been writing up a design doc as I've been doing this analysis
> and research to document the problems and the solutions. I think I'm
> close to the point where I can start implementing this new
> design.

Great news.

>
> Clearly, I've been busy doing a lot of nothing on rangelocks, thank
> you very much.

I=E2=80=99m not suggesting that you haven=E2=80=99t made progress on this c=
omplex
feature. What I mean is that XFS users continually express their
frustration to us when we can=E2=80=99t provide a solution to this issue, e=
ven
if it=E2=80=99s less than perfect. Now that we have a workable, though
imperfect, solution, why not try it if the user=E2=80=99s issue is urgent?
That way, when users encounter the same problem in the future, we can
offer them a choice: use the imperfect solution if it=E2=80=99s urgent, or
wait for range locking if it=E2=80=99s not. As you=E2=80=99re aware, most X=
FS users
don=E2=80=99t have the expertise needed to contribute to the development of
XFS range locking.

>
> > I'm not saying it's your
> > responsibility to implement range locking, but it seems no one else is
> > capable of implementing this complex feature except you.
>
> *cough*
>
> There's lots of people better qualified than me to solve a problem
> like this. It's a computer science problem, and I'm not a computer
> scientist. I'm an engineer - I take stuff that scientists have
> discovered and documented and build tools, infrastructure and
> objects based on that knowledge.
>
> What I'm not good at is coming up with novel new algorithms to solve
> mathematical problems. A range lock is the latter, not the former,
> and there are plenty of people who would be better suited to this
> work than me.  i.e. I'm good at putting knowledge to practical use,
> not creating new knowledge.

Most XFS users, like myself, are mainly skilled in utilizing the
features you=E2=80=99ve developed ;)

>
> However, I'm spending time on it because nobody else is going to
> solve the problem for me.  CPU and IO concurrency is only going up
> and shared/exclusive IO locking behaviour only gets more restrictive
> as concurrency requirements go up and we use extent sharing to
> avoid data copying more extensively. This problem isn't going
> away...

I understand the challenges you're facing. Thank you once again for
all your hard work.

--=20
Regards
Yafang

