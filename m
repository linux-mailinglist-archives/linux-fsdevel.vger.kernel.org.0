Return-Path: <linux-fsdevel+bounces-24918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A16DD94697D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 13:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6E528188A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 11:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7530D13A261;
	Sat,  3 Aug 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgzIU1TF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC421ABEB3;
	Sat,  3 Aug 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722684727; cv=none; b=ANgbjQR/aUDEBAQif2IE2AfytAsOtsAV/2dKPwMNkjJ3XZNY9isbHk7T2KCyAN1iKm3kaqlr7OPX5U00QKt+QeeGLUo26cYSKIhWIijKv0FF4Vn4NrX1psrO35L8npRFik2btTMl4RDwuh+oN1CDkRtplD8yKVHG39a90/FhqKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722684727; c=relaxed/simple;
	bh=0AMTquq9Xea5DRZpSjsYKcOJ2j4qoROHOdHLrMv9W2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jguENqQCa3qlZfi8Ks6wyP+LXtigcBfPvbtYRmFieloQ07Au/hHx7vKsmZO0fQX0SQ3HuQ+3VUrlLuzmKWfu9ij6WY6Wpye0RMxpArj+tu6LNud92KOV9R7hK5xXqTf84t6aullsLWxCa5II/oKvH83AbXLZFGE/P9pfO1fhhlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgzIU1TF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D2CC116B1;
	Sat,  3 Aug 2024 11:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722684727;
	bh=0AMTquq9Xea5DRZpSjsYKcOJ2j4qoROHOdHLrMv9W2w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FgzIU1TFTDzLWm2tSNQnQyWfFlHF5/YGN3bd3OKnTZr6mnjJlhQ+6uHYKIz6eCj3G
	 /960QOrMkdAJKPAlSW1coZecEa+aJDvp89sBGCHhxS8B2Zd/4bcYFu5EZ8FW7Urpzd
	 HypmIIPvDWcBph7Yv3n1NuCvW1gUcRzkg/3C+JKWRZ5EyrxkespNrFzC2bP8MeF0pH
	 ttrl2K7FBZ3UmBiav+W7Q5FCfO2lmo+RBi7q5TANYqxS/eFgx+hVwfdmRFyJqgWM/I
	 T6oqL5z+5tESxdbIFT4P8ytZpYg27uBp0HF3j0Uum2itM8O9O/LIWDAIuw20ZMb33N
	 GCkMtzIMNCQUA==
Message-ID: <808181ffe87d83f8cb36ebb4afbf6cd90778c763.camel@kernel.org>
Subject: Re: [PATCH RFC 3/4] lockref: rework CMPXCHG_LOOP to handle
 contention better
From: Jeff Layton <jlayton@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrew Morton
	 <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 03 Aug 2024 07:32:05 -0400
In-Reply-To: <CAGudoHFn5Fu2JMJSnqrtEERQhbYmFLB7xR58iXeGJ9_n7oxw8Q@mail.gmail.com>
References: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
	 <20240802-openfast-v1-3-a1cff2a33063@kernel.org>
	 <r6gyrzb265f5w6sev6he3ctfjjh7wfhktzwxyylwwkeopkzkpj@fo3yp2lkgp7l>
	 <CAGudoHHLcKoG6Y2Zzm34gLrtaXmtuMc=CPcVpVQUaJ1Ysz8EDQ@mail.gmail.com>
	 <7ff040d4a0fb1634d3dc9282da014165a347dbb2.camel@kernel.org>
	 <CAGudoHFn5Fu2JMJSnqrtEERQhbYmFLB7xR58iXeGJ9_n7oxw8Q@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-08-03 at 13:21 +0200, Mateusz Guzik wrote:
> On Sat, Aug 3, 2024 at 12:59=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Sat, 2024-08-03 at 11:09 +0200, Mateusz Guzik wrote:
> > > On Sat, Aug 3, 2024 at 6:44=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.c=
om> wrote:
> > > >=20
> > > > On Fri, Aug 02, 2024 at 05:45:04PM -0400, Jeff Layton wrote:
> > > > > In a later patch, we want to change the open(..., O_CREAT) codepa=
th to
> > > > > avoid taking the inode->i_rwsem for write when the dentry already=
 exists.
> > > > > When we tested that initially, the performance devolved significa=
ntly
> > > > > due to contention for the parent's d_lockref spinlock.
> > > > >=20
> > > > > There are two problems with lockrefs today: First, once any concu=
rrent
> > > > > task takes the spinlock, they all end up taking the spinlock, whi=
ch is
> > > > > much more costly than a single cmpxchg operation. The second prob=
lem is
> > > > > that once any task fails to cmpxchg 100 times, it falls back to t=
he
> > > > > spinlock. The upshot there is that even moderate contention can c=
ause a
> > > > > fallback to serialized spinlocking, which worsens performance.
> > > > >=20
> > > > > This patch changes CMPXCHG_LOOP in 2 ways:
> > > > >=20
> > > > > First, change the loop to spin instead of falling back to a locke=
d
> > > > > codepath when the spinlock is held. Once the lock is released, al=
low the
> > > > > task to continue trying its cmpxchg loop as before instead of tak=
ing the
> > > > > lock. Second, don't allow the cmpxchg loop to give up after 100 r=
etries.
> > > > > Just continue infinitely.
> > > > >=20
> > > > > This greatly reduces contention on the lockref when there are lar=
ge
> > > > > numbers of concurrent increments and decrements occurring.
> > > > >=20
> > > >=20
> > > > This was already tried by me and it unfortunately can reduce perfor=
mance.
> > > >=20
> > >=20
> > > Oh wait I misread the patch based on what I tried there. Spinning
> > > indefinitely waiting for the lock to be free is a no-go as it loses
> > > the forward progress guarantee (and it is possible to get the lock
> > > being continuously held). Only spinning up to an arbitrary point wins
> > > some in some tests and loses in others.
> > >=20
> >=20
> > I'm a little confused about the forward progress guarantee here. Does
> > that exist today at all? ISTM that falling back to spin_lock() after a
> > certain number of retries doesn't guarantee any forward progress. You
> > can still just end up spinning on the lock forever once that happens,
> > no?
> >=20
>=20
> There is the implicit assumption that everyone holds locks for a
> finite time. I agree there are no guarantees otherwise if that's what
> you meant.
>=20
> In this case, since spinlocks are queued, a constant stream of lock
> holders will make the lock appear taken indefinitely even if they all
> hold it for a short period.
>=20
> Stock lockref will give up atomics immediately and make sure to change
> the ref thanks to queueing up.
>=20
> Lockref as proposed in this patch wont be able to do anything as long
> as the lock trading is taking place.
>=20

Got it, thanks. This spinning is very simplistic, so I could see that
you could have one task continually getting shuffled to the end of the
queue.

> > > Either way, as described below, chances are decent that:
> > > 1. there is an easy way to not lockref_get/put on the parent if the
> > > file is already there, dodging the problem
> > > .. and even if that's not true
> > > 2. lockref can be ditched in favor of atomics. apart from some minor
> > > refactoring this all looks perfectly doable and I have a wip. I will
> > > try to find the time next week to sort it out
> > >=20
> >=20
> > Like I said in the earlier mail, I don't think we can stay in RCU mode
> > because of the audit_inode call. I'm definitely interested in your WIP
> > though!
> >=20
>=20
> well audit may be hackable so that it works in rcu most of the time,
> but that's not something i'm interested in

Audit not my favorite area of the kernel to work in either. I don't see
a good way to make it rcu-friendly, but I haven't looked too hard yet
either. It would be nice to be able to do some of the auditing under
rcu or spinlock.

>
> sorting out the lockref situation would definitely help other stuff
> (notably opening the same file RO).
>=20

Indeed. It's clear that the current implementation is a real
scalability problem in a lot of situations.

> anyhow one idea is to temporarily disable atomic ops with a flag in
> the counter, a fallback plan is to loosen lockref so that it can do
> transitions other than 0->1->2 with atomics, even if the lock is held.
>=20
> I have not looked at this in over a month, I'm going to need to
> refresh my memory on the details, I do remember there was some stuff
> to massage first.
>=20
> Anyhow, I expect a working WIP some time in the upcoming week.
>=20

Great, I'll stay tuned.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>

