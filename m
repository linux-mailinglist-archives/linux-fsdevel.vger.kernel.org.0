Return-Path: <linux-fsdevel+bounces-21633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD61A906A70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 12:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F8C1C23EA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 10:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4EC1428EE;
	Thu, 13 Jun 2024 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Suh0MZp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B433142631;
	Thu, 13 Jun 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275848; cv=none; b=V1k6sAotTYnRP2i7c8x98m1nnkSI+UextxQIm/oSp6kIg7gYC3Du8OV/sCrOgrfyjriTAkFt+fv9qKl6JBYtvDBCw3rpM3rDBSWlTSkrfz8+qlhjD7iIZz2KvUmxQvlHb04GS6dYDT1GBMO4oK4rEXyz6i1Kliq377oaWHdKpRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275848; c=relaxed/simple;
	bh=5PRbk3AfRxbmJsHY0erLSVKn/uDgUayeXpe4gOIVmlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIvGN64D/Mo6K1X2HtTjk6vf2BwmLBy3CSZrIespwsZKsZYkgAP5n60Zr433haHwYXBDc8NH/yKKZRLIqRGBY21n7DP2je1cLEzyAR8aSJVJYwRd+WqIKYkO3LyQGrDunFky0vT2TBJe3qXS6OqJeShwfr1c1I15g3OMROg7N4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Suh0MZp8; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52c89d6b4adso863037e87.3;
        Thu, 13 Jun 2024 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718275844; x=1718880644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fUOHZLqPwwXewI3YyWEmg6L7w15o022jE/kig0+VapA=;
        b=Suh0MZp8YF4qHrKXVTrCOdV8n9EPWY7fM2h4RzPB/Gckxu/0f9/RsgSs6k/CXA0Jyb
         sFX+x3Wc/EYc9qMl1VB3oN6GuFtflBVzhPnBoZIBrGLeFwL0JruSqVN2SyVL0boKWPws
         fvHoEAmbsepM2PmVOGE2P83PPBvvuxpZnA85++heeXiPztUsyDokSmLbCPzAqeZkyCX6
         ACtFplHHb38yA413WjLGPWWaN0gBLQnxDJ5FjgoMDHzPzpA+e5EvaWxvanIh7x0W6FrQ
         GVlLE17z+CByZu4+W9gMnziA6Trnp/uWaK+e2KTWJePI4TPdfwP4udlXU9of6YhRa8Ev
         WWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718275844; x=1718880644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUOHZLqPwwXewI3YyWEmg6L7w15o022jE/kig0+VapA=;
        b=VQDoaYVhzUITmCDZMPKZXb2xpxPMaZb2+yUxf29VdsOYzikXbxb7YySVxb85cFMfXf
         Yz6d3P1DKa5otS3/UIKwKEJB5cyzoPR7UGN/85OcdlpB1Gs1bPs8qQKiW7wyp2l1PT/C
         I5p/0qstw6Xw2GQ8klcIRHqYr3YN/Hk7Erq329C3HA0XeKH/725HPeapi+w/zL2ZqpUT
         Zg7Md7GihogsKDLGZrLQkrHv9ShOlTWxTVR+ORPzjQkoi20Lus8ulve1HMNEk0TAoXay
         Q8yw5ApyqY2BwRrgy6MYNzdZ5CHpFzUNuGJtrWamlaB7mjM4cqYBCkYc3MUbDI2qeXrh
         R4dw==
X-Forwarded-Encrypted: i=1; AJvYcCWFHxWFtPh4LbYJ0cF81yKk4oVD07u4cmm1kqAX9/flP+Bv9dQDwcPmaPV/XnZZDz59/EXBKp+dZpSITch+1BN3zE/6Lb3vwMFhJGquNmLxjFhRn/lcBXJ1kGlHGXmCV0ZbUBZKWhSq3L4Kaw==
X-Gm-Message-State: AOJu0Yxw4tSWyDpxFwWwjevQfnkDmvWQI6+g6irwFyOgmd0uJAPdMepQ
	HHwKgEy62jD9JgTG9uR0pAfwkX1PobY+wZmvEpSysFOl9eiIa9qR
X-Google-Smtp-Source: AGHT+IH93LYEQhVEqIb57xnnF/55QOQGdtPtYnsX4yJPnd4maXAVHK2AIf1PLyUJrGR3305p67PJKA==
X-Received: by 2002:a05:6512:34cd:b0:52c:9c33:986b with SMTP id 2adb3069b0e04-52c9c339b6dmr2319972e87.8.1718275843953;
        Thu, 13 Jun 2024 03:50:43 -0700 (PDT)
Received: from f (cst-prg-88-61.cust.vodafone.cz. [46.135.88.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422869d4f2esm57976275e9.0.2024.06.13.03.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 03:50:43 -0700 (PDT)
Date: Thu, 13 Jun 2024 12:50:35 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add rcu-based find_inode variants for iget ops
Message-ID: <ly3nx2r4cbnvhlwcficugq7zj62xij54mzuyjowcwaucbvkwns@nuxskfzj6lvc>
References: <20240606140515.216424-1-mjguzik@gmail.com>
 <ZmJqyrgPXXjY2Iem@dread.disaster.area>
 <bujynmx7n32tzl2xro7vz6zddt5p7lf5ultnaljaz2p2ler64c@acr7jih3wad7>
 <ZmgkLHa6LoV8yzab@dread.disaster.area>
 <20240611112846.qesh7qhhuk3qp4dy@quack3>
 <ZmjJCpWKFNZC2YAQ@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmjJCpWKFNZC2YAQ@dread.disaster.area>

On Wed, Jun 12, 2024 at 08:00:42AM +1000, Dave Chinner wrote:
> On Tue, Jun 11, 2024 at 01:28:46PM +0200, Jan Kara wrote:
> > On Tue 11-06-24 20:17:16, Dave Chinner wrote:
> > > Your patch, however, just converts *some* of the lookup API
> > > operations to use RCU. It adds complexity for things like inserts
> > > which are going to need inode hash locking if the RCU lookup fails,
> > > anyway.
> > > 
> > > Hence your patch optimises the case where the inode is in cache but
> > > the dentry isn't, but we'll still get massive contention on lookup
> > > when the RCU lookup on the inode cache and inserts are always going
> > > to be required.
> > > 
> > > IOWs, even RCU lookups are not going to prevent inode hash lock
> > > contention for parallel cold cache lookups. Hence, with RCU,
> > > applications are going to see unpredictable contention behaviour
> > > dependent on the memory footprint of the caches at the time of the
> > > lookup. Users will have no way of predicting when the behaviour will
> > > change, let alone have any way of mitigating it. Unpredictable
> > > variable behaviour is the thing we want to avoid the most with core
> > > OS caches.
> > 
> > I don't believe this is what Mateusz's patches do (but maybe I've terribly
> > misread them). iget_locked() does:
> > 
> > 	spin_lock(&inode_hash_lock);
> > 	inode = find_inode_fast(...);
> > 	spin_unlock(&inode_hash_lock);
> > 	if (inode)
> > 		we are happy and return
> > 	inode = alloc_inode(sb);
> > 	spin_lock(&inode_hash_lock);
> > 	old = find_inode_fast(...)
> > 	the rest of insert code
> > 	spin_unlock(&inode_hash_lock);
> > 
> > And Mateusz got rid of the first lock-unlock pair by teaching
> > find_inode_fast() to *also* operate under RCU. The second lookup &
> > insertion stays under inode_hash_lock as it is now.
> 
> Yes, I understand that. I also understand what that does to
> performance characteristics when memory pressure causes the working
> set cache footprint to change. This will result in currently 
> workloads that hit the fast path falling off the fast path and
> hitting contention and performing no better than they do today.
> 
> Remember, the inode has lock is taken when inode are evicted from
> memory, too, so contention on the inode hash lock will be much worse
> when we are cycling inodes through the cache compared to when we are
> just doing hot cache lookups.
> 
> > So his optimization is
> > orthogonal to your hash bit lock improvements AFAICT.
> 
> Not really. RCU for lookups is not necessary when hash-bl is used.
> The new apis and conditional locking changes needed for RCU to work
> are not needed with hash-bl. hash-bl scales and performs the same
> regardless of whether the workload is cache hot or cache-cold.
> 
> And the work is almost all done already - it just needs someone with
> time to polish it for merge.
> 
> > Sure his optimization
> > just ~halves the lock hold time for uncached cases (for cached it
> > completely eliminates the lock acquisition but I agree these are not that
> > interesting) so it is not a fundamental scalability improvement but still
> > it is a nice win for a contended lock AFAICT.
> 
> Yes, but my point is that it doesn't get rid of the scalability
> problem - it just kicks it down the road for small machines and
> people with big machines will continue to suffer from the global
> lock contention cycling inodes through the inode cache causes...
> 
> That's kinda my point - adding RCU doesn't fix the scalability
> problem, it simply hides a specific symptom of the problem *in some
> environments* for *some worklaods*. hash-bl works for everyone,
> everywhere and for all workloads, doesn't require new APIs or
> conditional locking changes, and th work is mostly done. Why take a
> poor solution when the same amount of verification effort would
> finish off a complete solution?
> 
> The hash-bl patchset is out there - I don't have time to finish it,
> so anyone who has time to work on inode hash lock scalability issues
> is free to take it and work on it. I may have written it, but I
> don't care who gets credit for getting it merged. Again: why take
> a poor solution just because the person who wants the scalability
> problem fixed won't pick up the almost finished work that has all
> ready been done?
> 

My patch submission explicitly states that it does not fix the
scalability problem but merely reduces it, so we are in agreement on
this bit. My primary point being that absent full solutions the
benefit/effort ratio is pretty good, but people are free to disagree
with it.

This conversation is going in circles, so how about this as a way
forward:

1. you could isolate the hash-bl parts from your original patchset (+
rebase) and write a quick rundown what needs to be done for this to be
committable
2. if you think you can find the time to do the work yourself in the
foreseeable future you could state the rough timeline (the thing will
probably want to miss this merge cycle anyway so there is plenty of
time)
3. if you can't commit to the work yourself you can look for someone to
do it for you. while you suggested that on the list there were no takers
(for example someone else could have stepped in after I said I'm not
going to do it, but that did not happen). perhaps you can prod people at
your dayjob and whatever non-list spots.

If you can't do the work in the foreseeable future (understandable) and
there are no takers (realistically I suspect there wont be) then you are
going to have stop opposing my patch on the grounds that hash-bl exists.

I don't know how much work is needed to sort it out, it is definitely
much more than what was needed for my thing, which is in part why I did
not go for hash-bl myself.

Of course there may be reasons to not include my patch regardless of the
state of hash-bl. If you have any then I suggest you state them for the
vfs folk to consider. If you intend to write it should not go in on the
because it does not fully fix the problem, then I note the commit
message both concedes there is a limitation and provides a justification
for inclusion despite of it. Merely stating there is still a scalability
ceiling does not address it. Claiming it adds too much complexity for
the reported benefit is imo not legit, but again it is a judgment call
to make by the vfs folk.

Right now the v4 landed in a vfs.inode.rcu branch. It really does not
have to reach master if someone gets hash-bl to a state where the vfs
cabal is happy with it. I don't know if Christian intends to submit it
to master in the upcomming merge cycle, it is perfectly fine with me if
it does not happen. Perhaps it even should not happen if the hash-bl
gets a sensible timeline. Even so, should my patch land in master and
hash-bl get work done at a much later date, there is no difficulty added
to it stemming from my thing -- at worst some trivial editing to resolve
a merge conflict.

And with this message I'm done with the entire ordeal, with 2 exceptions:
- if there is a bug reported against my patch i'm going to investigate
- if my patch is stalled in the vfs.inode.rcu branch for weeks and there
  is no replacement in sight (hash-bl, rhashtable, ${whatever_else}), I'm
  going to prod about it

Cheers.

