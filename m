Return-Path: <linux-fsdevel+bounces-21403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51319038B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 12:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C41EB27223
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FDA14F9F5;
	Tue, 11 Jun 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="HlteUoJ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3BB14D2A4
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101042; cv=none; b=Id6ry3V0XWXViwhZ5PHjPfwBkzJv1e7F9W7rM2GcjuVb6LWO1Is047WSTb+vxneQrOkn9MtSWWTlMItwp75dTw6kvSLvnFnPxeHYJz3oJ+KL3XgqMm3Z/Wmt+ZSXXXXqhtEqGU+wtctBsSxm89EaB/QaqeLMAHt48kh0mY6MPr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101042; c=relaxed/simple;
	bh=k3/Xfch+8JRLfzst3r5TstYfBgevM+EiUGucl7lOnRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Flmga6qQzEOUN8cU1xOVwpU5kKeEoEN3iRv7a4PizieVMh8wCcs7cKpW5NiiEgr2zE/woWIALEO0uWPsFJ8mDCRen0FDil/Wdi4VCk2eplRCa31GBKy4u1ZI5xgtdLzWAQK04oirS+a1acvaZGYKMog+7XNepDrzHGiN6YeLaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=HlteUoJ5; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3758fbc25f3so12526635ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1718101040; x=1718705840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4LuA/lhIOUGu97DVKfnfxIsZ/80sojqdo/2YGHirbU=;
        b=HlteUoJ5jYT55Fo+1mBXgOv2jxL7mfOz8WCqc7FPH5Bio/wIYJhD2y01uKc3gP2kku
         hUiRBjfcQvcSGcc3B7E50nOewdO0Lc8L1JIIDTUlBrmK4o3R8VAx203fhoCrg9HDT8li
         DYpCSPeddcUaZnD9EVDP+g5kFcVDzW8PQKNz2QfXcrsKQrxNT9rXMlqwwBV5NSyqn/oO
         FxlZ5aumeCzhyCIYWRGmURrtkrYjih/QAd0g1S9YX7GUdVzgHf6DO5EOlZWMF9V/W4WO
         q+j5VPbBWDd5JXeSZRxHluTz650wFpK6izDlXCX1nyTZStUH6Iykg0egWq2STchZ/w0D
         toKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718101040; x=1718705840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4LuA/lhIOUGu97DVKfnfxIsZ/80sojqdo/2YGHirbU=;
        b=dic0zDzDp5zpifE22TjO/u4JKHQWvfBrPJ/zLA0Rccvc9eVFo0M35EDZSK7iulBgNA
         6XFeXqLQBRp7Hf5ZG4TwlSzTmprWmojkY1rzSOAYI40xYAiRjc56vwV8js89dhENv7vt
         vkS7s5BnkumWkFPBAime4/o6jsZVd92iC6u7PFBSPQVMH6Wzz9OErWkqVttmMvWQw5Fr
         Nys3KdR2iSehJqjOOYVPG4gcFZ5+a8Z1jAG3vWPcxeEU/tpFjKFslsS+AcKcAEEonLNJ
         qFlS7aITm2TaU/itZArFFO9n36j07x41pFR3+kFqCL6bAXXd/h2ZCH+dr+KOFK3lma2I
         lKGg==
X-Forwarded-Encrypted: i=1; AJvYcCUPWAYAOnH6vfwjAR6qUKaGsLeHf6deHc4J/QIuorL6BiXO3QE5YpLt6IuRSF99+Otgur4FfV1v6r+wX9MFvUNsZLR+Pq6GcB5L2bXPdg==
X-Gm-Message-State: AOJu0Yw/vZ6viFMxLEB+N3IF3owW8XhKJhxamyku1uaMYkTVkbXxxgNP
	DCgCRbBwntxlqloLqOvUFYGa/HTtzu1WzLAh+bvztp0i07M6pY0XXhAKGmCUKcc=
X-Google-Smtp-Source: AGHT+IGY0IadXfqerv0+OKl3gobPvnHsnmmpFsJTebOzIVe3wgFPCeUh8EY90kLowEveWUptqmn4Xw==
X-Received: by 2002:a05:6e02:2166:b0:374:93d5:e37e with SMTP id e9e14a558f8ab-3758031ede4mr145832495ab.17.1718101039747;
        Tue, 11 Jun 2024 03:17:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de200849b7sm7411675a12.18.2024.06.11.03.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:17:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sGyZ2-00C3lj-1n;
	Tue, 11 Jun 2024 20:17:16 +1000
Date: Tue, 11 Jun 2024 20:17:16 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add rcu-based find_inode variants for iget ops
Message-ID: <ZmgkLHa6LoV8yzab@dread.disaster.area>
References: <20240606140515.216424-1-mjguzik@gmail.com>
 <ZmJqyrgPXXjY2Iem@dread.disaster.area>
 <bujynmx7n32tzl2xro7vz6zddt5p7lf5ultnaljaz2p2ler64c@acr7jih3wad7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bujynmx7n32tzl2xro7vz6zddt5p7lf5ultnaljaz2p2ler64c@acr7jih3wad7>

On Fri, Jun 07, 2024 at 09:51:51AM +0200, Mateusz Guzik wrote:
> On Fri, Jun 07, 2024 at 12:04:58PM +1000, Dave Chinner wrote:
> > On Thu, Jun 06, 2024 at 04:05:15PM +0200, Mateusz Guzik wrote:
> > > Instantiating a new inode normally takes the global inode hash lock
> > > twice:
> > > 1. once to check if it happens to already be present
> > > 2. once to add it to the hash
> > > 
> > > The back-to-back lock/unlock pattern is known to degrade performance
> > > significantly, which is further exacerbated if the hash is heavily
> > > populated (long chains to walk, extending hold time). Arguably hash
> > > sizing and hashing algo need to be revisited, but that's beyond the
> > > scope of this patch.
> > > 
> > > A long term fix would introduce fine-grained locking, this was attempted
> > > in [1], but that patchset was already posted several times and appears
> > > stalled.
> > 
> > Why not just pick up those patches and drive them to completion?
> > 
> 
> Time constraints on my end aside.
> 
> From your own e-mail [1] last year problems are:
> 
> > - A lack of recent validation against ext4, btrfs and other
> > filesystems.
> > - the loss of lockdep coverage by moving to bit locks
> > - it breaks CONFIG_PREEMPT_RT=y because we nest other spinlocks
> >   inside the inode_hash_lock and we can't do that if we convert the
> >   inode hash to bit locks because RT makes spinlocks sleeping locks.
> > - There's been additions for lockless RCU inode hash lookups from
> >   AFS and ext4 in weird, uncommon corner cases and I have no idea
> >   how to validate they still work correctly with hash-bl. I suspect
> >   they should just go away with hash-bl, but....
> 
> > There's more, but these are the big ones.
> 
> I did see the lockdep and preempt_rt problem were patched up in a later
> iteration ([2]).
> 
> What we both agree on is that the patchset adds enough complexity that
> it needs solid justification. I assumed one was there on your end when
> you posted it.
> 
> For that entire patchset I don't have one. I can however justify the
> comparatively trivial thing I posted in this thread.

I didn't suggest you pick up the entire patchset, I suggested you
pull the inode cache conversion to hash-bl from it and use that
instead of hacking RCU lookups into the inode cache.

> That aside if I had to make the entire thing scale I would approach
> things differently, most notably in terms of locking granularity. Per
> your own statement things can be made to look great in microbenchmarks,
> but that does not necessarily mean they help. A lot of it is a tradeoff
> and making everything per-cpu for this particular problem may be taking
> it too far.

The hash-bl conversion doesn't make anything per-cpu, so I don't
know what you are complaining about here.

> For the inode hash it may be the old hack of having a lock array would
> do it more than well enough -- say 32 locks (or some other number
> dependent on hash size) each covering a dedicated subset.

No, that's a mid 1990s-era hack that was done because we didn't know
any better ways to scale global algorithms back then. 
It's not a scalable algorithm, it's a global algorithm that
has been sharded a few times to try to keep global scope operations
apart. The moment you have subset collisions because of a specific
workload pattern, then the scalability problem comes straight back.

We have been doing better than this for years, and it's not a viable
solution for things like core OS cache indexing. We need a construct
that is inherently scalable and has little cost to that inherent
scalability.

We have an inhernetly scalable solution already - hash-bl adds
fine-grained locking without changing locking behaviour nor
consuming extra memory. And it scales lookup, insert and remove with
a common locking scheme across all operations.

Your patch, however, just converts *some* of the lookup API
operations to use RCU. It adds complexity for things like inserts
which are going to need inode hash locking if the RCU lookup fails,
anyway.

Hence your patch optimises the case where the inode is in cache but
the dentry isn't, but we'll still get massive contention on lookup
when the RCU lookup on the inode cache and inserts are always going
to be required.

IOWs, even RCU lookups are not going to prevent inode hash lock
contention for parallel cold cache lookups. Hence, with RCU,
applications are going to see unpredictable contention behaviour
dependent on the memory footprint of the caches at the time of the
lookup. Users will have no way of predicting when the behaviour will
change, let alone have any way of mitigating it. Unpredictable
variable behaviour is the thing we want to avoid the most with core
OS caches.

In comparison, hash-bl based inode cache lookups will have the same
behaviour for both cache hits and cache misses. There will be
nearly zero contention for both types of lookups, as the insert can
be done immediately under the same lock that the is held for the
lookup. Hence performance will be predictable and largely
deterministic under a wide variety of workloads and changing memory
pressure. This is how we want the inode cache to behave.

IOWs, the hash-bl solution is superior to RCU lookups for many
reasons. RCU lookups might be fast, but it's not the best solution
to every problem that requires scalable behaviour.

> All that said, if someone(tm) wants to pick up your patchset and even
> commit it the way it is right now I'm not going to protest anything.
>
> I don't have time nor justification to do full work My Way(tm).

You *always* say this sort of thing when someone asks you to do
something different.

If you don't agree with the reviewer's comments, you make some
statement about how you "don't care enough to fix it properly" or
that you don't have time to fix it properly, or that you think the
reviewing is asking you to "fix everything" rather than just one
line in your patch so you reject all the reviewers comment, or you
say "if the maintainers want something" as a way of saying "you
don't have any authority, so I'm not going to listen to you at all",
or ....

> I did have time to hack up the initial rcu lookup, which imo does not
> require much to justify inclusion and does help the case I'm interested
> in.

I thin kit requires a lot more justification than you have given,
especially given the fact changing memory pressure, access patterns
and cache balance will have a great impact on whether the RCU path
makes any different to inode hash lock contention at all.

The hash-bl conversion is a much a better solution and the
work is mostly done. If you want your workload case to perform
better, then please pick up the inode hash lock conversion to
hash-bl.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

