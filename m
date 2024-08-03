Return-Path: <linux-fsdevel+bounces-24916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF9F94694E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 13:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96BC1F20FF3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 11:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAED14EC43;
	Sat,  3 Aug 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg358cku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962A14E2F1;
	Sat,  3 Aug 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722682766; cv=none; b=EbSyBb8r7OA57zJ/2qm9804Ub/eur78j+WafgpoE6ctnV0Ge39/S5vj9ilno9O5vG481HbLz51QwGePvxMRi9kzmMc3ha1NnhcbGOpSIgh3HzliYw6gbpojwmzcGZx7yADPqfKE9CpW22//1T2gXzMSH5hP5lqX2WY3G+1e+CHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722682766; c=relaxed/simple;
	bh=wXJibRRZdKerw8MBnL8BT75mXojPWhhoJOnbQymsNj0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e1aq4+TGaMymri9s+vxKZDNZc4hRswKkIIevR6e0VsZ6+2ea1LPpoeMIoWjoVCpSkMnkWIzM81kloFg5kvlSLECsPY+uGu403/n4SS/Jo6NQ9EGfBxiFYJK6ip6Zgu7G/20zjGmIpcGaMMLZfneSBEzHUiGKuw22m/A7/tmqqoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg358cku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A2BC4AF0A;
	Sat,  3 Aug 2024 10:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722682766;
	bh=wXJibRRZdKerw8MBnL8BT75mXojPWhhoJOnbQymsNj0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sg358ckufK+k2XFwJr6mNo76SJseGXXq+48T6xjlyWPDxe9Cz/ZO9vamfQ2nUfrMt
	 Fa8HOF+JgsVF67w5hmesBkcIVUbgNUWbcu5awi/QMMCdo/YhjABsW7vrr/FmJ5RYn+
	 muClUkE+muPBsKVfEpjoxbz1UuKeI3e4W8gKZr69hV4ypvCsuS76s1vZa64T2IJ06b
	 eF+qW8DiqvW0XemCxqy4luQjv6FzzBqSK9gBg8cNqHwwNjzldeZnuvyuMSdaeHF8bN
	 51/nG8FVmF5Sc7DvIo1sQgSUwaIQ+96ale2TSn2XZNKiOkrOSk4ZYAnqInQl3LYPrN
	 raArjW4e/c3Gw==
Message-ID: <7ff040d4a0fb1634d3dc9282da014165a347dbb2.camel@kernel.org>
Subject: Re: [PATCH RFC 3/4] lockref: rework CMPXCHG_LOOP to handle
 contention better
From: Jeff Layton <jlayton@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrew Morton
	 <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 03 Aug 2024 06:59:24 -0400
In-Reply-To: <CAGudoHHLcKoG6Y2Zzm34gLrtaXmtuMc=CPcVpVQUaJ1Ysz8EDQ@mail.gmail.com>
References: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
	 <20240802-openfast-v1-3-a1cff2a33063@kernel.org>
	 <r6gyrzb265f5w6sev6he3ctfjjh7wfhktzwxyylwwkeopkzkpj@fo3yp2lkgp7l>
	 <CAGudoHHLcKoG6Y2Zzm34gLrtaXmtuMc=CPcVpVQUaJ1Ysz8EDQ@mail.gmail.com>
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

On Sat, 2024-08-03 at 11:09 +0200, Mateusz Guzik wrote:
> On Sat, Aug 3, 2024 at 6:44=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> >=20
> > On Fri, Aug 02, 2024 at 05:45:04PM -0400, Jeff Layton wrote:
> > > In a later patch, we want to change the open(..., O_CREAT) codepath t=
o
> > > avoid taking the inode->i_rwsem for write when the dentry already exi=
sts.
> > > When we tested that initially, the performance devolved significantly
> > > due to contention for the parent's d_lockref spinlock.
> > >=20
> > > There are two problems with lockrefs today: First, once any concurren=
t
> > > task takes the spinlock, they all end up taking the spinlock, which i=
s
> > > much more costly than a single cmpxchg operation. The second problem =
is
> > > that once any task fails to cmpxchg 100 times, it falls back to the
> > > spinlock. The upshot there is that even moderate contention can cause=
 a
> > > fallback to serialized spinlocking, which worsens performance.
> > >=20
> > > This patch changes CMPXCHG_LOOP in 2 ways:
> > >=20
> > > First, change the loop to spin instead of falling back to a locked
> > > codepath when the spinlock is held. Once the lock is released, allow =
the
> > > task to continue trying its cmpxchg loop as before instead of taking =
the
> > > lock. Second, don't allow the cmpxchg loop to give up after 100 retri=
es.
> > > Just continue infinitely.
> > >=20
> > > This greatly reduces contention on the lockref when there are large
> > > numbers of concurrent increments and decrements occurring.
> > >=20
> >=20
> > This was already tried by me and it unfortunately can reduce performanc=
e.
> >=20
>=20
> Oh wait I misread the patch based on what I tried there. Spinning
> indefinitely waiting for the lock to be free is a no-go as it loses
> the forward progress guarantee (and it is possible to get the lock
> being continuously held). Only spinning up to an arbitrary point wins
> some in some tests and loses in others.
>=20

I'm a little confused about the forward progress guarantee here. Does
that exist today at all? ISTM that falling back to spin_lock() after a
certain number of retries doesn't guarantee any forward progress. You
can still just end up spinning on the lock forever once that happens,
no?

> Either way, as described below, chances are decent that:
> 1. there is an easy way to not lockref_get/put on the parent if the
> file is already there, dodging the problem
> .. and even if that's not true
> 2. lockref can be ditched in favor of atomics. apart from some minor
> refactoring this all looks perfectly doable and I have a wip. I will
> try to find the time next week to sort it out
>=20

Like I said in the earlier mail, I don't think we can stay in RCU mode
because of the audit_inode call. I'm definitely interested in your WIP
though!

> > Key problem is that in some corner cases the lock can be continuously
> > held and be queued on, making the fast path always fail and making all
> > the spins actively waste time (and notably pull on the cacheline).
> >=20
> > See this for more details:
> > https://lore.kernel.org/oe-lkp/lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2m=
faqbkvv4ke@hzxat7utjnvx/
> >=20
> > However, I *suspect* in the case you are optimizing here (open + O_CREA=
T
> > of an existing file) lockref on the parent can be avoided altogether
> > with some hackery and that's what should be done here.
> >=20
> > When it comes to lockref in vfs in general, most uses can be elided wit=
h
> > some hackery (see the above thread) which is in early WIP (the LSMs are
> > a massive headache).
> >=20
> > For open calls which *do* need to take a real ref the hackery does not
> > help of course.
> >=20
> > This is where I think decoupling ref from the lock is the best way
> > forward. For that to work the dentry must hang around after the last
> > unref (already done thanks to RCU and dput even explicitly handles that
> > already!) and there needs to be a way to block new refs atomically --
> > can be done with cmpxchg from a 0-ref state to a flag blocking new refs
> > coming in. I have that as a WIP as well.
> >=20
> >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  lib/lockref.c | 85 ++++++++++++++++++++++---------------------------=
----------
> > >  1 file changed, 32 insertions(+), 53 deletions(-)
> > >=20
> > > diff --git a/lib/lockref.c b/lib/lockref.c
> > > index 2afe4c5d8919..b76941043fe9 100644
> > > --- a/lib/lockref.c
> > > +++ b/lib/lockref.c
> > > @@ -8,22 +8,25 @@
> > >   * Note that the "cmpxchg()" reloads the "old" value for the
> > >   * failure case.
> > >   */
> > > -#define CMPXCHG_LOOP(CODE, SUCCESS) do {                            =
         \
> > > -     int retry =3D 100;                                             =
           \
> > > -     struct lockref old;                                            =
         \
> > > -     BUILD_BUG_ON(sizeof(old) !=3D 8);                              =
           \
> > > -     old.lock_count =3D READ_ONCE(lockref->lock_count);             =
           \
> > > -     while (likely(arch_spin_value_unlocked(old.lock.rlock.raw_lock)=
)) {     \
> > > -             struct lockref new =3D old;                            =
           \
> > > -             CODE                                                   =
         \
> > > -             if (likely(try_cmpxchg64_relaxed(&lockref->lock_count, =
         \
> > > -                                              &old.lock_count,      =
         \
> > > -                                              new.lock_count))) {   =
         \
> > > -                     SUCCESS;                                       =
         \
> > > -             }                                                      =
         \
> > > -             if (!--retry)                                          =
         \
> > > -                     break;                                         =
         \
> > > -     }                                                              =
         \
> > > +#define CMPXCHG_LOOP(CODE, SUCCESS) do {                            =
                 \
> > > +     struct lockref old;                                            =
                 \
> > > +     BUILD_BUG_ON(sizeof(old) !=3D 8);                              =
                   \
> > > +     old.lock_count =3D READ_ONCE(lockref->lock_count);             =
                   \
> > > +     for (;;) {                                                     =
                 \
> > > +             struct lockref new =3D old;                            =
                   \
> > > +                                                                    =
                 \
> > > +             if (likely(arch_spin_value_unlocked(old.lock.rlock.raw_=
lock))) {        \
> > > +                     CODE                                           =
                 \
> > > +                     if (likely(try_cmpxchg64_relaxed(&lockref->lock=
_count,          \
> > > +                                                      &old.lock_coun=
t,               \
> > > +                                                      new.lock_count=
))) {            \
> > > +                             SUCCESS;                               =
                 \
> > > +                     }                                              =
                 \
> > > +             } else {                                               =
                 \
> > > +                     cpu_relax();                                   =
                 \
> > > +                     old.lock_count =3D READ_ONCE(lockref->lock_coun=
t);                \
> > > +             }                                                      =
                 \
> > > +     }                                                              =
                 \
> > >  } while (0)
> > >=20
> > >  #else
> > > @@ -46,10 +49,8 @@ void lockref_get(struct lockref *lockref)
> > >       ,
> > >               return;
> > >       );
> > > -
> > > -     spin_lock(&lockref->lock);
> > > -     lockref->count++;
> > > -     spin_unlock(&lockref->lock);
> > > +     /* should never get here */
> > > +     WARN_ON_ONCE(1);
> > >  }
> > >  EXPORT_SYMBOL(lockref_get);
> > >=20
> > > @@ -60,8 +61,6 @@ EXPORT_SYMBOL(lockref_get);
> > >   */
> > >  int lockref_get_not_zero(struct lockref *lockref)
> > >  {
> > > -     int retval;
> > > -
> > >       CMPXCHG_LOOP(
> > >               new.count++;
> > >               if (old.count <=3D 0)
> > > @@ -69,15 +68,9 @@ int lockref_get_not_zero(struct lockref *lockref)
> > >       ,
> > >               return 1;
> > >       );
> > > -
> > > -     spin_lock(&lockref->lock);
> > > -     retval =3D 0;
> > > -     if (lockref->count > 0) {
> > > -             lockref->count++;
> > > -             retval =3D 1;
> > > -     }
> > > -     spin_unlock(&lockref->lock);
> > > -     return retval;
> > > +     /* should never get here */
> > > +     WARN_ON_ONCE(1);
> > > +     return -1;
> > >  }
> > >  EXPORT_SYMBOL(lockref_get_not_zero);
> > >=20
> > > @@ -88,8 +81,6 @@ EXPORT_SYMBOL(lockref_get_not_zero);
> > >   */
> > >  int lockref_put_not_zero(struct lockref *lockref)
> > >  {
> > > -     int retval;
> > > -
> > >       CMPXCHG_LOOP(
> > >               new.count--;
> > >               if (old.count <=3D 1)
> > > @@ -97,15 +88,9 @@ int lockref_put_not_zero(struct lockref *lockref)
> > >       ,
> > >               return 1;
> > >       );
> > > -
> > > -     spin_lock(&lockref->lock);
> > > -     retval =3D 0;
> > > -     if (lockref->count > 1) {
> > > -             lockref->count--;
> > > -             retval =3D 1;
> > > -     }
> > > -     spin_unlock(&lockref->lock);
> > > -     return retval;
> > > +     /* should never get here */
> > > +     WARN_ON_ONCE(1);
> > > +     return -1;
> > >  }
> > >  EXPORT_SYMBOL(lockref_put_not_zero);
> > >=20
> > > @@ -125,6 +110,8 @@ int lockref_put_return(struct lockref *lockref)
> > >       ,
> > >               return new.count;
> > >       );
> > > +     /* should never get here */
> > > +     WARN_ON_ONCE(1);
> > >       return -1;
> > >  }
> > >  EXPORT_SYMBOL(lockref_put_return);
> > > @@ -171,8 +158,6 @@ EXPORT_SYMBOL(lockref_mark_dead);
> > >   */
> > >  int lockref_get_not_dead(struct lockref *lockref)
> > >  {
> > > -     int retval;
> > > -
> > >       CMPXCHG_LOOP(
> > >               new.count++;
> > >               if (old.count < 0)
> > > @@ -180,14 +165,8 @@ int lockref_get_not_dead(struct lockref *lockref=
)
> > >       ,
> > >               return 1;
> > >       );
> > > -
> > > -     spin_lock(&lockref->lock);
> > > -     retval =3D 0;
> > > -     if (lockref->count >=3D 0) {
> > > -             lockref->count++;
> > > -             retval =3D 1;
> > > -     }
> > > -     spin_unlock(&lockref->lock);
> > > -     return retval;
> > > +     /* should never get here */
> > > +     WARN_ON_ONCE(1);
> > > +     return -1;
> > >  }
> > >  EXPORT_SYMBOL(lockref_get_not_dead);
> > >=20
> > > --
> > > 2.45.2
> > >=20
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

