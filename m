Return-Path: <linux-fsdevel+bounces-21424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3319039C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00B91C22254
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA4317A930;
	Tue, 11 Jun 2024 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSFaFRfc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8FC46525;
	Tue, 11 Jun 2024 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104409; cv=none; b=gpO6lLjak5ZuG3wCX/BzObxqq/s8PWl3As1w9egNUOjL9nA4L37ViE3KUkJOuXlhRjJGFOGsz1d26SqI3TtKG4Cc1n15AA9ailvBWQ9NsG3Z4QM6T/EF40iH9VgQvfn1TiILxzNdjaU2cTII45khI+xFhCcisZmh6ErCBVA1+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104409; c=relaxed/simple;
	bh=uGB5GUqDbU3shTYJyUbSitl55+MFpoGvmfgJsPwSyzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJMsG5HPwRiESOVuXfZX6d2IFq66tPmU8Q5JYfVvjsN1IOhkTIz0FxrfdJRFWNBjFQoP+0IfIovEXg8BlJE1iDXq+vvHQ96/ZZxy4WRkXG1Lu7lCIK+vZUEsc7UKFRIowQZ/jTUND8KzMEaQN/hE9pUvcp0NjfnIiUX2LOGXVtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSFaFRfc; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f1c490c13so2959707f8f.3;
        Tue, 11 Jun 2024 04:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718104406; x=1718709206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcyzKAO/IuM07Iw8vOtrpHPcZD7TewKdhTyFnYxXKuQ=;
        b=aSFaFRfcV1rsOCzdoaj9LPtTnSGHqMzX3RS8D+YKf/tJJGEMe8NdjrIycCcqhnYLGi
         CyCR+mU7gk2xNmKe7BWnMgPjr+7N6h3KGkcsf4L1dU+cfDWBK2qxqpiTs2l+KbAnk03m
         C3yM4ay0NQRLhUEaGw2yWoGhVtydYdQl7Yr0wRm72PBMs0/6NTcrRAn66Cd1KQ5ijWZY
         S3SYKU72l+zvapfnwT2XgUrcnbZmjO+2/djm+uMbC5x5/XAXOih2e4WUTIPDZ8g8+uNi
         rhzbs59SaXRyys5jQm8FbqTlzjI7MG0b1+9+b9sJZD8x15bXo5Yr9D1Ei9SvJ6uBdRdB
         pPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718104406; x=1718709206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcyzKAO/IuM07Iw8vOtrpHPcZD7TewKdhTyFnYxXKuQ=;
        b=huGEcNHRQfLufqSs/CPec71cUaltV5dGqN9SGCQxcuRc2N4qO+Nqb3sdEGuD5qyUx3
         2tx/CRlDB2ScCI4JsnSwORhhSYKqThAbnNLVAsolkN6nSHP20KizSsXc+yC8XTjAvROY
         mG1wFti/hyfC5yKdigWu0uZiWWmks8eMAX94rhDs+YBxteWC5AhR6cQw31/HQz3o+QnL
         5b3zrwYEEO8p5qWKf+bDcq9kt79YkzRzX3dYWpQjuz60dzr327IsKFmKt1oQzgP1NK9f
         Wy/MO04UA5biAD/zU/RUtJmFINIuOGVgrmjblutmbTEeNBgNtrwo3vWQHIS3NV8gSYS7
         YgWA==
X-Forwarded-Encrypted: i=1; AJvYcCWZu0tCDSZkDxUdsvxZmdJXfoaZlBNURXerFbrU/6PchzatnIt1iRH89+1C00w47l0s7uBcd5hVWnCNi0hyvQGLt0oEfVQk7d684+0639YpSACzgs7ZkBeB1PZudoi5Hz6IDNS8ev/QFwIq4A==
X-Gm-Message-State: AOJu0YxK7FjMqliSQ9zwZjCh1+SSWjcBXbtlEOrZZaWrpUBRBd0SdZs5
	SrfyACEDBLldww4dvDIhndLNFSXpdRcIHrhOkao0YbJ/OwMVNMHW4NwEhg==
X-Google-Smtp-Source: AGHT+IGqDyIFNOXzPPzcxX0qjnr2dc3NM6/CmEQWBh5IJiaKCPUwZQMSI8/6pKtLZClNwJRvUVrZqQ==
X-Received: by 2002:a5d:5f96:0:b0:351:b56e:8bc3 with SMTP id ffacd0b85a97d-35efedd7dcamr11584415f8f.53.1718104405501;
        Tue, 11 Jun 2024 04:13:25 -0700 (PDT)
Received: from f (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f27600519sm4026251f8f.32.2024.06.11.04.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:13:24 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:13:17 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add rcu-based find_inode variants for iget ops
Message-ID: <bfmwwxmpmu6t2tkj2aexalhfyrcjwb6alxongp4mftqrigotcv@nhipbhchji3z>
References: <20240606140515.216424-1-mjguzik@gmail.com>
 <ZmJqyrgPXXjY2Iem@dread.disaster.area>
 <bujynmx7n32tzl2xro7vz6zddt5p7lf5ultnaljaz2p2ler64c@acr7jih3wad7>
 <ZmgkLHa6LoV8yzab@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmgkLHa6LoV8yzab@dread.disaster.area>

On Tue, Jun 11, 2024 at 08:17:16PM +1000, Dave Chinner wrote:
> On Fri, Jun 07, 2024 at 09:51:51AM +0200, Mateusz Guzik wrote:
> > On Fri, Jun 07, 2024 at 12:04:58PM +1000, Dave Chinner wrote:
> > > On Thu, Jun 06, 2024 at 04:05:15PM +0200, Mateusz Guzik wrote:
> > > > Instantiating a new inode normally takes the global inode hash lock
> > > > twice:
> > > > 1. once to check if it happens to already be present
> > > > 2. once to add it to the hash
> > > > 
> > > > The back-to-back lock/unlock pattern is known to degrade performance
> > > > significantly, which is further exacerbated if the hash is heavily
> > > > populated (long chains to walk, extending hold time). Arguably hash
> > > > sizing and hashing algo need to be revisited, but that's beyond the
> > > > scope of this patch.
> > > > 
> > > > A long term fix would introduce fine-grained locking, this was attempted
> > > > in [1], but that patchset was already posted several times and appears
> > > > stalled.
> > > 
> > > Why not just pick up those patches and drive them to completion?
> > > 
> > 
> > Time constraints on my end aside.
> > 
> > From your own e-mail [1] last year problems are:
> > 
> > > - A lack of recent validation against ext4, btrfs and other
> > > filesystems.
> > > - the loss of lockdep coverage by moving to bit locks
> > > - it breaks CONFIG_PREEMPT_RT=y because we nest other spinlocks
> > >   inside the inode_hash_lock and we can't do that if we convert the
> > >   inode hash to bit locks because RT makes spinlocks sleeping locks.
> > > - There's been additions for lockless RCU inode hash lookups from
> > >   AFS and ext4 in weird, uncommon corner cases and I have no idea
> > >   how to validate they still work correctly with hash-bl. I suspect
> > >   they should just go away with hash-bl, but....
> > 
> > > There's more, but these are the big ones.
> > 
> > I did see the lockdep and preempt_rt problem were patched up in a later
> > iteration ([2]).
> > 
> > What we both agree on is that the patchset adds enough complexity that
> > it needs solid justification. I assumed one was there on your end when
> > you posted it.
> > 
> > For that entire patchset I don't have one. I can however justify the
> > comparatively trivial thing I posted in this thread.
> 
> I didn't suggest you pick up the entire patchset, I suggested you
> pull the inode cache conversion to hash-bl from it and use that
> instead of hacking RCU lookups into the inode cache.
> 

That's still a significantly more complicated change than my proposal.

> > That aside if I had to make the entire thing scale I would approach
> > things differently, most notably in terms of locking granularity. Per
> > your own statement things can be made to look great in microbenchmarks,
> > but that does not necessarily mean they help. A lot of it is a tradeoff
> > and making everything per-cpu for this particular problem may be taking
> > it too far.
> 
> The hash-bl conversion doesn't make anything per-cpu, so I don't
> know what you are complaining about here.
> 

I crossed the wires with another patchset and wrote some garbage here,
but it is not hard to error-correct to what I meant given the context:
per-chain locking is not necessarily warranted, in which case bitlocks
and associated trouble can be avoided.

> > For the inode hash it may be the old hack of having a lock array would
> > do it more than well enough -- say 32 locks (or some other number
> > dependent on hash size) each covering a dedicated subset.
> 
> No, that's a mid 1990s-era hack that was done because we didn't know
> any better ways to scale global algorithms back then. 
> It's not a scalable algorithm, it's a global algorithm that
> has been sharded a few times to try to keep global scope operations
> apart. The moment you have subset collisions because of a specific
> workload pattern, then the scalability problem comes straight back.
> 

It is a tradeoff, as I said. Avoidance of bitlock-associated trouble is
the only reason I considered it.

> Your patch, however, just converts *some* of the lookup API
> operations to use RCU. It adds complexity for things like inserts
> which are going to need inode hash locking if the RCU lookup fails,
> anyway.
> 

You may notice the patch only trivially alters insertion code because
rcu awaraness in the hash was already present.

> Hence your patch optimises the case where the inode is in cache but
> the dentry isn't, but we'll still get massive contention on lookup
> when the RCU lookup on the inode cache and inserts are always going
> to be required.

While it is true that the particular case gets sped up, that's not the
only thing that happens and should you take a look at the synthethic
benchmark I'm running you will see it does not even test that -- it is
very heavily cache busting.

The win comes from going from back-to-back lock acquire (a well known
terribly performing pattern) to just one.

> IOWs, even RCU lookups are not going to prevent inode hash lock
> contention for parallel cold cache lookups. Hence, with RCU,
> applications are going to see unpredictable contention behaviour
> dependent on the memory footprint of the caches at the time of the
> lookup. Users will have no way of predicting when the behaviour will
> change, let alone have any way of mitigating it. Unpredictable
> variable behaviour is the thing we want to avoid the most with core
> OS caches.

Of course it's still contended, I just claim it happens less.

> 
> IOWs, the hash-bl solution is superior to RCU lookups for many
> reasons. RCU lookups might be fast, but it's not the best solution
> to every problem that requires scalable behaviour.
> 

Of course hash-bl is faster, I never claimed otherwise.

I did claim my patch is trivial and provides a nice win for little work
in exchange. See below for a continuation.

> > All that said, if someone(tm) wants to pick up your patchset and even
> > commit it the way it is right now I'm not going to protest anything.
> >
> > I don't have time nor justification to do full work My Way(tm).
> 
> You *always* say this sort of thing when someone asks you to do
> something different.
> 
> If you don't agree with the reviewer's comments, you make some
> statement about how you "don't care enough to fix it properly" or
> that you don't have time to fix it properly, or that you think the
> reviewing is asking you to "fix everything" rather than just one
> line in your patch so you reject all the reviewers comment, or you
> say "if the maintainers want something" as a way of saying "you
> don't have any authority, so I'm not going to listen to you at all",
> or ....
> 

By any chance is your idea of me claiming the reviewer is asking to "fix
everything" based on my exchange with Christopher Hellwing concerning v2
of the patch? Because I pretty clearly did not say anything of the sort,
even though he might have taken it that way.

Anyhow, you do understand I'm not getting paid to do this work?

So here how I see it: the inode hash is a problem, there is one patchset
which solves it but is stalled. Seeing how nobody is working on the
problem and that there is an easy to code speed up, I hack it up, bench
and submit.

This is where you come in suggesting I carry hash-bl across the finish
line instead, despite my submission explicitly stating limited interest
in devoting time to the area.

I write an explicit explanation why I'm not interested in doing it.

This is where you should stop instead of complaining I'm not picking up
your thing.

> > I did have time to hack up the initial rcu lookup, which imo does not
> > require much to justify inclusion and does help the case I'm interested
> > in.
> 
> I thin kit requires a lot more justification than you have given,
> especially given the fact changing memory pressure, access patterns
> and cache balance will have a great impact on whether the RCU path
> makes any different to inode hash lock contention at all.
> 

Per my explanation above the win is not from iget getting away without
taking the hash lock, but from only taking it once instead of twice. The
commit message starts with explicitly stating it.

New inodes continuously land in the hash in my benchmark.

> The hash-bl conversion is a much a better solution and the
> work is mostly done. If you want your workload case to perform
> better, then please pick up the inode hash lock conversion to
> hash-bl.
> 

It is a much faster thing, but also requiring much more work to get in.
I am not interested in putting in that work at this moment.

That aside, one mailing list over there is another person arguing the
hash in its current form needs to be eliminated altogether in favor of
rhashtables and they very well may be right. Whoever picks this up will
have probably have to argue against that too.

All that said, my wilingness to touch the ordeal for the time being is
limited to maybe one round of cosmetic fixups to post a v4 of my thing.

If the patch is not wanted, someone decides to get hash-bl in, or
rshashtable or something completely different, and my patch is whacked,
I'm going to have 0 complains. I can't stress enough how side-questy
this particular thing is at the moment.

