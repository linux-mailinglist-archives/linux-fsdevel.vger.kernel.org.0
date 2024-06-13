Return-Path: <linux-fsdevel+bounces-21598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D559063C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 08:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F309DB21BF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 06:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7D51369B0;
	Thu, 13 Jun 2024 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9rQksKe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6137C;
	Thu, 13 Jun 2024 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259012; cv=none; b=UbkShhuoF5+KB9BAcd6xOgrokbDZSgEycn+wbecfkVFFfKfVhcBhmE2IXiKD1XJB9mr/BzRnNITvD4xvTtP7l4JnoGQdu4pC3oh0r62SwA7cqXyjnHhnZJt+5KTgQZ1O2ON5La3uSlKsYf29pO6LB2SbZAIu3QCGFcDbxPUYtjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259012; c=relaxed/simple;
	bh=1ExmQjbJI13xSDtMVPtRIrUCgSubm+bChzK3Ga+6AD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD1oN7t18c/2U9/mzHAuCDym2u1pzPgb3TbrNRfSwXPIs/MKTzXEIhb8oz51ubrURqWGzxhpxHC9KEPxhGnfcpK3eqZDjh58WFgpsnSpspElMQUTfGhg4zl9AM6dG/N0WJCyCvVmw4mAMgC82yn6wA/3lau5am3Xm1gkvtCnDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9rQksKe; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52c8ddc2b29so757039e87.3;
        Wed, 12 Jun 2024 23:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718259008; x=1718863808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdN1kjijVwtGMORrXmsLXoepez5UVCrcKY+bNf7CBOE=;
        b=U9rQksKevx1H5Wum7zssVOYCjkrRlFaxxRpwC4+hh8DS2Dsmx67Nkto1daWEPrPEzA
         SzNeYzD/qlwTWA2EP0e5X0cPOeFmlA2aRpctHyPpVpX5kraWcRSa06u3zcIuesp44GqW
         M6+FF8iHHWdJ39seJTlRHp7XizRZb6hrVtb2L0a9hlQOvE0SiCt9+U3SzShnroaikDrf
         gGksbCsbioSlMv583WGyEjd7LuHuA/mt2pKMXFEvjXYorNDY1nHdSh5YX70LPGUTZjjH
         MIsB64VEGt6L8O9FOO2f7XNY3tbhLbonIIcJn6i2QCZc7BO2W5CFPRR6fFUiYuuwNU9x
         NCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718259008; x=1718863808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdN1kjijVwtGMORrXmsLXoepez5UVCrcKY+bNf7CBOE=;
        b=W5hMSum8I4FdYWr9zqsbN1NGdNmx2J4HkMWEzL9/v40LKoX/1DQIJZ6AnkRBZPTErN
         R6fZsJl0WyFrkfXWG/caFCdjPc9ZzJbeKLGa3HWJ58QtTYW99F+p605aAIiBEhKTNttw
         e8oVDzs6ieD1CNk0QL4zwHzQW40pZlwefK2XXi8JHrxM9s4Btf1OHsXpMjbgbbeZ0d38
         gr801uKZXbQuOUAJZrtdb/h3D8EXVSZWd3Lqpb7Hlfkm7qWu37ZqnHBOS1syr1enydyi
         K1zBP/knsDzk92K8VakPbNSOMGOdArIDR4wzBA47SASlkdylyl0dBtlUkt6+26YiPrU0
         Nulw==
X-Forwarded-Encrypted: i=1; AJvYcCUWhPsIYk3Fx9ao8+mtGlZ/FbCJpQqOHV58+t4abJ7CoJIMVRKCi5LiZYx+GQSgd9kjwqfKT51zlrjlPzYZ2YI4WliasPWTDMdHPp0CPS1ELz5vtBKQFFfXfN5t8ZGWsPhGss9JjH87rgpBeQ==
X-Gm-Message-State: AOJu0Ywa5Ky0VInZFbDuZkK/mFaVejspnDaehRjRsK6W0nxJH98BJ9Zv
	OO07pukk9u/MgghfST+792zAWOI7Gr6UmjpgTTFihPbQUI55lJsT/MNZiA==
X-Google-Smtp-Source: AGHT+IHQUoZhnogXJAX13obwm/gOawCMf/+LHs9I2RDbdpYNB4OLdVH40cmtyfUUWa7FrU2hH54mtw==
X-Received: by 2002:a05:6512:31c6:b0:52c:8a9b:17f4 with SMTP id 2adb3069b0e04-52c9a3df0e7mr3508033e87.37.1718259008222;
        Wed, 12 Jun 2024 23:10:08 -0700 (PDT)
Received: from f (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9eesm49034065e9.9.2024.06.12.23.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 23:10:07 -0700 (PDT)
Date: Thu, 13 Jun 2024 08:09:57 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
Message-ID: <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
References: <20240613001215.648829-1-mjguzik@gmail.com>
 <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>

On Wed, Jun 12, 2024 at 06:23:18PM -0700, Linus Torvalds wrote:
> So I have no problem with your patch 2/2 - moving the lockref data
> structure away from everything else that can be shared read-only makes
> a ton of sense independently of anything else.
> 
> Except you also randomly increased a retry count in there, which makes no sense.
> 

Cmon man, that's a change which unintentionally crept into the patch and
I failed to notice.

> But this patch 1/2 makes me go "Eww, hacky hacky".
> 
> We already *have* the retry loop, it's just that currently it only
> covers the cmpxchg failures.
> 
> The natural thing to do is to just make the "wait for unlocked" be
> part of the same loop.
> 

I was playing with a bpftrace probe reporting how many spins were
performed waiting for the lock. For my intentional usage with ls it was
always < 30 or so. The random-ass intruder which messes with my bench on
occasion needed over 100.

The bump is something I must have fat-fingered into the wrong patch.

Ultimately even if *some* iterations will still take the lock, they
should be able to avoid it next time around, so the permanent
degradation problem is still solved.

> Mind testing this approach instead?
> 

So I'm not going to argue about the fix.

I tested your code and confirm it fixes the problem, nothing blows up
either and I fwiw I don't see any bugs in it.

When writing the commit message feel free to use mine in whatever capacity
(including none) you want. 

On Wed, Jun 12, 2024 at 06:49:00PM -0700, Linus Torvalds wrote:

> On Wed, 12 Jun 2024 at 18:23, Linus Torvalds
> One of the ideas behind the reflux was that locking should be an
> exceptional thing when something special happens. So things like final
> dput() and friends.
> 
> What I *think* is going on - judging by your description of how you
> triggered this - is that sadly our libfs 'readdir()' thing is pretty
> nasty.
> 
> It does use d_lock a lot for the cursor handling, and things like
> scan_positives() in particular.
> 
> I understand *why* it does that, and maybe it's practically unfixable,
> but I do think the most likely deeper reason for that "go into slow
> mode" is the cursor on the directory causing issues.
> 
> Put another way: while I think doing the retry loop will help
> benchmarks, it would be lovely if you were to look at that arguably
> deeper issue of the 'd_sib' list.
> 

I think lockref claiming to be a general locking facility means it
should not be suffering the degradation problem to begin with, so that
would be the real problem as far as lockref goes.

For vfs as a whole I do agree that the d_lock usage in various spots is
probably avoidable and if so would be nice to get patched out, readdir
included. So Someone(tm) should certainly look into it.

As for me at the moment I have other stuff on my todo list, so I am not
going to do it for the time being.

Regardless, patching up lockref to dodge the lock is a step forward in
the right direction AFAICS.

=====

All that aside, you did not indicate how do you want to move forward
regarding patch submission.

As indicated in my cover letter the vfs change (if it is to land) needs
to be placed *after* the lockref issue is addressed, otherwise it may
result in bogus regression reports. Thus I think it makes most sense to
just ship them together.

So maybe you can send me a patch and I send a v2 of the patchset with
that, alternatively perhaps you can edit out the unintional retry
adjustment from my dentry patch and handle the rest yourself.

Or maybe you have some other idea.

The thing that matters to me is not landing in a state where d_lockref
is moved around, but the lockref corner case is not patched (even it is
patched *after*). I really don't want to investigate a regression report
only to find it's caused by the above.

