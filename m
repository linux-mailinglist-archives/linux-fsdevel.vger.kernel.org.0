Return-Path: <linux-fsdevel+bounces-1449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB30C7DA099
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F5F6B21518
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7588B3D961;
	Fri, 27 Oct 2023 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMKhNzgH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B103D3B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC3AC433C8;
	Fri, 27 Oct 2023 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698431797;
	bh=+KCiqcUxhGzJk+V3uKLhq3+C5BdyzVXPbI2bbWul+qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IMKhNzgHmvIFPnWw1Oj9ftPpTFIBtViMuPxR0m1P9FvW5JBwQExMqHwosZMROkd8D
	 EsEc9Osf2Q6VpdNnDrQPtKp0oSf0bvEbh2ygddlSAo2SoX17kCiiOtlpu/9IEEfX+l
	 sE9CdDoKEJ5OdfUmCd4Ow0hnSwLWyb2WmBrAIq8cvX3eEFb/R/W2K3Oc6oLdpsE1JP
	 mhBHTeHzk8O0atk4gYpFBODSTYXxFz/4SNpR2ghM+m9ZKfuKPRRZdwVx3CbmprnUhs
	 Gjm3AX6OXDZ5Uy7fyLAWwT5aa2eVUyz2eYydrLT9KrAqoVPW+pgoAQvLQo/Hex7AyJ
	 NTlFZt3FqFexw==
Date: Fri, 27 Oct 2023 11:36:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <20231027183636.GA11382@frogsfrogsfrogs>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev>
 <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
 <20231019153040.lj3anuescvdprcq7@f>
 <20231019155958.7ek7oyljs6y44ah7@f>
 <ZTJmnsAxGDnks2aj@dread.disaster.area>
 <CAGudoHHqpk+1b6KqeFr6ptnm-578A_72Ng3H848WZP0GoyUQbw@mail.gmail.com>
 <ZTYAUyiTYsX43O9F@dread.disaster.area>
 <CAGudoHGzX2H4pUuDNYzYOf8s-HaZuAi7Dttpg_SqtXAgTw8tiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHGzX2H4pUuDNYzYOf8s-HaZuAi7Dttpg_SqtXAgTw8tiw@mail.gmail.com>

On Fri, Oct 27, 2023 at 07:13:11PM +0200, Mateusz Guzik wrote:
> On 10/23/23, Dave Chinner <david@fromorbit.com> wrote:
> > On Fri, Oct 20, 2023 at 07:49:18PM +0200, Mateusz Guzik wrote:
> >> On 10/20/23, Dave Chinner <david@fromorbit.com> wrote:
> >> > On Thu, Oct 19, 2023 at 05:59:58PM +0200, Mateusz Guzik wrote:
> >> >> > To be clear there is no urgency as far as I'm concerned, but I did
> >> >> > run
> >> >> > into something which is primarily bottlenecked by inode hash lock
> >> >> > and
> >> >> > looks like the above should sort it out.
> >> >> >
> >> >> > Looks like the patch was simply forgotten.
> >> >> >
> >> >> > tl;dr can this land in -next please
> >> >>
> >> >> In case you can't be arsed, here is something funny which may convince
> >> >> you to expedite. ;)
> >> >>
> >> >> I did some benching by running 20 processes in parallel, each doing
> >> >> stat
> >> >> on a tree of 1 million files (one tree per proc, 1000 dirs x 1000
> >> >> files,
> >> >> so 20 mln inodes in total).  Box had 24 cores and 24G RAM.
> >> >>
> >> >> Best times:
> >> >> Linux:          7.60s user 1306.90s system 1863% cpu 1:10.55 total
> >> >> FreeBSD:        3.49s user 345.12s system 1983% cpu 17.573 total
> >> >> OpenBSD:        5.01s user 6463.66s system 2000% cpu 5:23.42 total
> >> >> DragonflyBSD:   11.73s user 1316.76s system 1023% cpu 2:09.78 total
> >> >> OmniosCE:       9.17s user 516.53s system 1550% cpu 33.905 total
> >> >>
> >> >> NetBSD failed to complete the run, OOM-killing workers:
> >> >> http://mail-index.netbsd.org/tech-kern/2023/10/19/msg029242.html
> >> >> OpenBSD is shafted by a big kernel lock, so no surprise it takes a
> >> >> long
> >> >> time.
> >> >>
> >> >> So what I find funny is that Linux needed more time than OmniosCE (an
> >> >> Illumos variant, fork of Solaris).
> >> >>
> >> >> It also needed more time than FreeBSD, which is not necessarily funny
> >> >> but not that great either.
> >> >>
> >> >> All systems were mostly busy contending on locks and in particular
> >> >> Linux
> >> >> was almost exclusively busy waiting on inode hash lock.
> >> >
> >> > Did you bother to test the patch, or are you just complaining
> >> > that nobody has already done the work for you?
> >>
> >> Why are you giving me attitude?
> >
> > Look in the mirror, mate.
> >
> > Starting off with a derogatory statement like:
> >
> > "In case you can't be arsed, ..."
> >
> > is a really good way to start a fight.
> >
> > I don't think anyone working on this stuff couldn't be bothered to
> > get their lazy arses off their couches to get it merged. Though you
> > may not have intended it that way, that's exactly what "can't be
> > arsed" means.
> >
> > I have not asked for this code to be merged because I'm not ready to
> > ask for it to be merged. I'm trying to be careful and cautious about
> > changing core kernel code that every linux installation out there
> > uses because I care about this code being robust and stable. That's
> > the exact opposite of "can't be arsed"....
> >
> > Further, you have asked for code that is not ready to be merged to
> > be merged without reviewing it or even testing it to see if it
> > solved your reported problem. This is pretty basic stuff - it you
> > want it merged, then *you also need to put effort into getting it
> > merged* regardless of who wrote the code. TANSTAAFL.
> >
> > But you've done neither - you've just made demands and thrown
> > hypocritical shade implying busy people working on complex code are
> > lazy arses.
> >
> 
> So I took few days to take a look at this with a fresh eye and I see
> where the major disconnect is coming from, albeit still don't see how
> it came to be nor why it persists.
> 
> To my understanding your understanding is that I demand you carry the
> hash bl patch over the finish line and I'm rude about it as well.
> 
> That is not my position here though.
> 
> For starters my opening e-mail was to Christian, not you. You are
> CC'ed as the patch author. It is responding to an e-mail which claimed
> the patch would land in -next, which to my poking around did not
> happen (and I checked it's not in master either). Since there was no
> other traffic about it that I could find, I figured it was probably
> forgotten. You may also notice the e-mail explicitly states:
> 1. I have a case which runs into inode hash being a problem
> 2. *there is no urgency*, I'm just asking what's up with the patch not
> getting anywhere.
> 
> The follow up including a statement about "being arsed" once more was
> to Christian, not you and was rather "tongue in cheek".

I thought that was a very rude way to address Christian.

Notice how he hasn't even given you a response?

"Hello, this patch improves performance for me on _______ workload.
What needs to be done to get this ready for merging?  I'd like to
take on that work."

--D

> If you know about Illumos, it is mostly slow and any serious
> performance work stopped there when Oracle closed the codebase over a
> decade ago. Or to put it differently, one has to be doing something
> really bad to not be faster today. And there was this bad -- the inode
> hash. I found it amusing and decided to share in addition to asking
> about the patch.
> 
> So no Dave, I'm not claiming the patch is not in because anyone is lazy.
> 
> Whether the patch is ready for reviews and whatnot is your call to
> make as the author.
> 
> To repeat from my previous e-mail I note the lock causes real problems
> in a real-world setting, it's not just microbenchmarks, but I'm in no
> position to test it against the actual workload (only the part I
> carved out into a benchmark, where it does help -- gets rid of the
> nasty back-to-back lock acquire, first to search for the inode and
> then to insert a new one).
> 
> If your assessment is that more testing is needed, that makes sense
> and is again your call to make. I repeat again I can't help with this
> bit though. And if you don't think the effort is justified at the
> moment (or there are other things with higher priority), so be it.
> 
> It may be I'll stick around in general and if so it may be I'm going
> to run into you again.
> With this in mind:
> 
> > Perhaps you should consider your words more carefully in future?
> >
> 
> On that front perhaps you could refrain from assuming someone is
> trying to call you names or whatnot. But more importantly if you
> consider an e-mail to be rude, you can call it out instead of
> escalating or responding in what you consider to be the same tone.
> 
> All that said I'm bailing from this patchset.
> 
> Cheers,
> -- 
> Mateusz Guzik <mjguzik gmail.com>
> 

