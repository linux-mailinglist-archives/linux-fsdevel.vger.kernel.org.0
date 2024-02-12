Return-Path: <linux-fsdevel+bounces-11073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562D9850D3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 05:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6171C2287D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 04:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786406AB9;
	Mon, 12 Feb 2024 04:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="taIBhDXq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD655235
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707712538; cv=none; b=pxoidzOvtR6XTOC3hzcTzu4xz2f48yLnbszEZUvjfm4O2er7h+ND4LoI2oHGBTXa8T7YUC39h9mqEFs0DSy59QeXRXU3RlNJImr7+MtrTBi0wEbj6+T/SVLX6j1i+16IuXXiACt6Rtm3xYTKBnHi9JiBzll7lWwoiYY0c3FWxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707712538; c=relaxed/simple;
	bh=TmCFHRamG9bIem3APIjEszxfMDDLTOOzCRTG6KQcqiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlJcWVQc2XDX1ZFpvrkUxZi4jELxkyhG32jjPtIs2uxkxiz758QeWaSrNuAU2i8Re7oyXnH6kiYfAUO7TQSzTGLsGyymtBN8Zk7umJlWrYBS1iJP7GL8of6U4FBOpZVlaIh45JmlSAIH3PCGDPIW0Qs0Vaezjngvv3L/yaRC/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=taIBhDXq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso22791705ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 20:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707712536; x=1708317336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXkXLwVNWLT3J3oeKK9tqqTL6F+hQb3SLALc77jiL0g=;
        b=taIBhDXqG4bgg7rjPpr/awo6VIKloeG9oXFfQcdno+9dhFUWUxbw6o0znxW1iu2Bq2
         HvF1rkj+xM6bAG73DJOqZilrftG5yyCMStRnEETuRJnQze/SfgKMXIjd8HwQIExsTzxL
         DnPGQwUtkYeRyrADvxdDbjaeWPKfTtda36LwlLMr409hyxTvJSbudiHy4cxnyzXaBYAI
         rTg+mK2Vaos0rWHSVW56N0MT2S6nhbFVTrNjH1mUx5zQ1dNXC5PZZDW9XlDnU8rs9gki
         fJj3IlHiK2vcL1XD5oWteLZ2DigfH3ifLbb7lSXCYsdHiIwGQyvXd9Rc04lxqUkKTwYY
         MrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707712536; x=1708317336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXkXLwVNWLT3J3oeKK9tqqTL6F+hQb3SLALc77jiL0g=;
        b=a8/LThCg9c/fxzeVQisOAU9I0i2EwuE9JiJdL5YsEzm/dc7JGvIBBrjOlD38ux39r2
         Uyy/JZSpzTjaeF/dgSiNHGVaG/YICr+YcTtYsmSZr22jaIAONz1w2ZUTi+HqVZ1hQ9Jt
         9vQd/x+sDEuvNFo91FSGkPGzUkCV7btxpA67/HDdea/+QbckXk2sPZ8BareO9AnQY24j
         LyakSRyo6u8bG6tLszEv9C1KN9hbD8U5UdNzGsVcMj4enOgTF+IzBK6usFraUhpGH8Jz
         ONpK29mcTlQjuF57yG7N2KwMvOzquIkjtaalYW319AHe9dYkL8V05/S1LlBmlwGSGG3f
         Gi4A==
X-Gm-Message-State: AOJu0Yyl7X5Mnk4gU20n74AihlVsp7wpAjZHptLC3WDVU0FOaA6cOj5C
	vNZPCwMICbpveDLRjZcByTIZNPAKPJ8EQBx/RF1EjqJ86GEzt+/Om0rGL74q3D0=
X-Google-Smtp-Source: AGHT+IEiPpX2ipLt/DqNdet7IkGo1IKBe0NX+8bKLXh5WQVjqaXPj6kfmFWvz6lYLEhiD9w85rSD3g==
X-Received: by 2002:a17:903:489:b0:1d9:6fce:54f7 with SMTP id jj9-20020a170903048900b001d96fce54f7mr8875338plb.9.1707712536495;
        Sun, 11 Feb 2024 20:35:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqYigSqkzKjzntBWqHqJJRytUl2NfL/vuX6pRjrmsQiEdDZC6LOzD5N/+F3JdZ6t8/ESb6pY/jI37xatgAKqn1PqKpmR27R/KQov8SF2WTizs8/uv+tGT/BAswJfQHF7PW+f22zOBB+yG6J0VPNhEA7p359+ysXO8hFiZbbltS9UC/SW6ZCNsT9KjxGynYyLtL6ueQYbXS2vAgIq+10rKYLKNH3h98EIMCXbUK5oDEO0tzUweEBzUkl2KodVSnykYRMsiv8tDEWYDAnKkvIvE//ZH0BIftykn8uou80tWY1rJmuzsJ8tO6VjDaOCNEsyXVSciLPxV/UkzlkwXI9npFhCoYLXcNgeVAO5EKUDKQtvpAcJVXhFgucEcMzd0RIj1J0z6vfy/CPGjeBDuqt2SFcO8avI1+92di
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id kf13-20020a17090305cd00b001d8f393f3cfsm4968659plb.248.2024.02.11.20.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 20:35:36 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rZO2X-005Lcx-1m;
	Mon, 12 Feb 2024 15:35:33 +1100
Date: Mon, 12 Feb 2024 15:35:33 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZcmgFThkhh9HYsXh@dread.disaster.area>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <ZZzP6731XwZQnz0o@dread.disaster.area>
 <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
 <ZcUQfzfQ9R8X0s47@tiehlicka>
 <3aa399bb-5007-4d12-88ae-ed244e9a653f@kernel.org>
 <ZclyYBO0vcQHZ5dV@dread.disaster.area>
 <5p4zwxtfqwm3wgvzwqfg6uwy5m3lgpfypij4fzea63gu67ve4t@77to5kukmiic>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5p4zwxtfqwm3wgvzwqfg6uwy5m3lgpfypij4fzea63gu67ve4t@77to5kukmiic>

On Sun, Feb 11, 2024 at 09:06:33PM -0500, Kent Overstreet wrote:
> On Mon, Feb 12, 2024 at 12:20:32PM +1100, Dave Chinner wrote:
> > On Thu, Feb 08, 2024 at 08:55:05PM +0100, Vlastimil Babka (SUSE) wrote:
> > > On 2/8/24 18:33, Michal Hocko wrote:
> > > > On Thu 08-02-24 17:02:07, Vlastimil Babka (SUSE) wrote:
> > > >> On 1/9/24 05:47, Dave Chinner wrote:
> > > >> > On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
> > > >> 
> > > >> Your points and Kent's proposal of scoped GFP_NOWAIT [1] suggests to me this
> > > >> is no longer FS-only topic as this isn't just about converting to the scoped
> > > >> apis, but also how they should be improved.
> > > > 
> > > > Scoped GFP_NOFAIL context is slightly easier from the semantic POV than
> > > > scoped GFP_NOWAIT as it doesn't add a potentially unexpected failure
> > > > mode. It is still tricky to deal with GFP_NOWAIT requests inside the
> > > > NOFAIL scope because that makes it a non failing busy wait for an
> > > > allocation if we need to insist on scope NOFAIL semantic. 
> > > > 
> > > > On the other hand we can define the behavior similar to what you
> > > > propose with RETRY_MAYFAIL resp. NORETRY. Existing NOWAIT users should
> > > > better handle allocation failures regardless of the external allocation
> > > > scope.
> > > > 
> > > > Overriding that scoped NOFAIL semantic with RETRY_MAYFAIL or NORETRY
> > > > resembles the existing PF_MEMALLOC and GFP_NOMEMALLOC semantic and I do
> > > > not see an immediate problem with that.
> > > > 
> > > > Having more NOFAIL allocations is not great but if you need to
> > > > emulate those by implementing the nofail semantic outside of the
> > > > allocator then it is better to have those retries inside the allocator
> > > > IMO.
> > > 
> > > I see potential issues in scoping both the NOWAIT and NOFAIL
> > > 
> > > - NOFAIL - I'm assuming Dave is adding __GFP_NOFAIL to xfs allocations or
> > > adjacent layers where he knows they must not fail for his transaction. But
> > > could the scope affect also something else underneath that could fail
> > > without the failure propagating in a way that it affects xfs?
> > 
> > Memory allocaiton failures below the filesystem (i.e. in the IO
> > path) will fail the IO, and if that happens for a read IO within
> > a transaction then it will have the same effect as XFS failing a
> > memory allocation. i.e. it will shut down the filesystem.
> > 
> > The key point here is the moment we go below the filesystem we enter
> > into a new scoped allocation context with a guaranteed method of
> > returning errors: NOIO and bio errors.
> 
> Hang on, you're conflating NOIO to mean something completely different -
> NOIO means "don't recurse in reclaim", it does _not_ mean anything about
> what happens when the allocation fails,

Yes, I know that's what NOIO means. I'm not conflating it with
anything else.

> and in particular it definitely
> does _not_ mean that failing the allocation is going to result in an IO
> error.

Exactly. FS level NOFAIL contexts simply do not apply to NOIO
context functionality. NOIO contexts require different mechanisms to
guarantee forwards progress under memory pressure. They work
pretty well, and we don't want or need to perturb them by having
them inherit filesystem level NOFAIL semantics.

i.e. architecturally speaking, NOIO is a completely separate
allocation domain to NOFS.

> That's because in general most code in the IO path knows how to make
> effective use of biosets and mempools (which may take some work! you
> have to ensure that you're always able to make forward progress when
> memory is limited, and in particular that you don't double allocate from
> the same mempool if you're blocking the first allocation from
> completing/freeing).

Yes, I understand this, and that's my point: NOIO context tends to
be able to use mempools and other mechanisms to prevent memory
allocation failure, not NOFAIL.

The IO layers are request based and that enables one-in, one out
allocation pools that can guarantee single IO progress. That's all
the IO layers need to guarantee to the filesystems so that forwards
progress can always be made until memory pressure.

However, filesystems cannot guarantee "one in, one out" allocation
behaviour. A transaction can require a largely unbound number of
memory allocations to succeed to make progress through to
completion, and so things like mempools -cannot be used- to prevent
memory allocation failures whilst providing a forwards progress
guarantee.

Hence a NOFAIL scope if useful at the filesystem layer for
filesystem objects to ensure forwards progress under memory
pressure, but it is compeltely unnecessary once we transition to the
IO layer where forwards progress guarantees ensure memory allocation
failures don't impede progress.

IOWs, we only need NOFAIL at the NOFS layers, not at the NOIO
layers. The entry points to the block layer should transition the
task to NOIO context and restore the previous context on exit. Then
it becomes relatively trivial to apply context based filtering of
allocation behaviour....

> > i.e NOFAIL scopes are not relevant outside the subsystem that sets
> > it.  Hence we likely need helpers to clear and restore NOFAIL when
> > we cross an allocation context boundaries. e.g. as we cross from
> > filesystem to block layer in the IO stack via submit_bio(). Maybe
> > they should be doing something like:
> > 
> > 	nofail_flags = memalloc_nofail_clear();
> 
> NOFAIL is not a scoped thing at all, period; it is very much a
> _callsite_ specific thing, and it depends on whether that callsite has a
> fallback.

*cough*

As I've already stated, NOFAIL allocation has been scoped in XFS for
the past 20 years.

Every memory allocation inside a transaction *must* be NOFAIL unless
otherwise specified because memory allocation inside a dirty
transaction is a fatal error. However, that scoping has never been
passed to the NOIO contexts below the filesytsem - it's scoped
purely within the filesystem itself and doesn't pass on to other
subsystems the filesystem calls into.

> The most obvious example being, as mentioned previously, mempools.

Yes, they require one-in, one-out guarantees to avoid starvation and
ENOMEM situations. Which, as we've known since mempools were
invented, these guarantees cannot be provided by most filesystems.

> > > - NOWAIT - as said already, we need to make sure we're not turning an
> > > allocation that relied on too-small-to-fail into a null pointer exception or
> > > BUG_ON(!page).
> > 
> > Agreed. NOWAIT is removing allocation failure constraints and I
> > don't think that can be made to work reliably. Error injection
> > cannot prove the absence of errors  and so we can never be certain
> > the code will always operate correctly and not crash when an
> > unexepected allocation failure occurs.
> 
> You saying we don't know how to test code?

Yes, that's exactly what I'm saying.

I'm also saying that designing algorithms that aren't fail safe is
poor design. If you get it wrong and nothing bad can happen as a
result, then the design is fine.

But if the result of missing something accidentally is that the
system is guaranteed to crash when that is hit, then failure is
guaranteed and no amount of testing will prevent that failure from
occurring.

And we suck at testing, so we absolutely need to design fail
safe algorithms and APIs...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

