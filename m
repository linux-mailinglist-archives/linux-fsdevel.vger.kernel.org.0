Return-Path: <linux-fsdevel+bounces-29213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F469772A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 22:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6572D1C2383B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 20:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6DA1C173B;
	Thu, 12 Sep 2024 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwM6lTEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDFD6F2E8;
	Thu, 12 Sep 2024 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726172326; cv=none; b=SjqO/XagaqZ+goXHCKWyqyiGat0Lr+UTgMz/KBqmrdLnd+08EQil3FLstvlr35pyji/ou7Bg+X5pugepvX80pW3XGY+qI32yhP75UujqSuxyE8CGIKgFoso6VvQDxhv9/PteS1n4G3mRsgf80ub7qTNA46WpnFo2bjrzMb04ZT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726172326; c=relaxed/simple;
	bh=HTEWn8xAj3rJy2FUXtz5csfl5vK7avmJrmLXt1tp31Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O5vMfsjt2dAdjNGTRjgIjwCwscLs7z/w90jHRLVMmSwygGxPXsAAFyiH0xFG+6ACufwDJ1cpm2d+3OnZOOQWwDONwfx6hpyXIDsME/Tklin4t0S5fF2JTAMiemyURJUXq/grQm8rwF1vCJ/leUpG/WlYG12qCzeihed49WnH4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwM6lTEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28895C4CEC3;
	Thu, 12 Sep 2024 20:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726172326;
	bh=HTEWn8xAj3rJy2FUXtz5csfl5vK7avmJrmLXt1tp31Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UwM6lTEwqZKF1a2IX2ZFs9ZCnF7Ov5/klGP5quBhCcSc7EvKkCUBND1sCMSetq/Bn
	 oCQ0UClnrilmNqBdz9LNHDkcU5TsRwr/uv0QRD34iUmYhqcmr69x2lNYQuoTrBIUOn
	 TKLLN+hJG2EMGiCORNscbX6Xglk6XPl+PZZPE/hRxPGWNulAdFLJJjMgVWZ//TnzTv
	 QYlt4TewIUe11ncZ8hEyUTxGIprIHK+9e/4RlmeVWG1s/itwj+zZ3y9c1sRP0reG0G
	 BBehitHaZn0U6tqPDFEfKGwxa33tjiqS1RY5N+bKfRbjPmRVyKmDWH+nS6R1G4DEFd
	 DcGiittwJv8kQ==
Message-ID: <80f8f49da3f7208101e497a130a8abe106b298ad.camel@kernel.org>
Subject: Re: [PATCH v2] timekeeping: move multigrain timestamp floor
 handling into timekeeper
From: Jeff Layton <jlayton@kernel.org>
To: John Stultz <jstultz@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner
 <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann
 <arnd@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test
 robot <oliver.sang@intel.com>
Date: Thu, 12 Sep 2024 16:18:43 -0400
In-Reply-To: <CANDhNCrpkTfe6BRVNf1ihhGALbPBBhOs1PCPxA4MDHa1+=sEbQ@mail.gmail.com>
References: <20240912-mgtime-v2-1-54db84afb7a7@kernel.org>
	 <CANDhNCrpkTfe6BRVNf1ihhGALbPBBhOs1PCPxA4MDHa1+=sEbQ@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-12 at 13:11 -0700, John Stultz wrote:
> On Thu, Sep 12, 2024 at 11:02=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> >=20
> > The kernel test robot reported a performance hit in some will-it-scale
> > tests due to the multigrain timestamp patches.  My own testing showed
> > about a 7% drop in performance on the pipe1_threads test, and the data
> > showed that coarse_ctime() was slowing down current_time().
>=20
> So, you provided some useful detail about why coarse_ctime() was slow
> in your reply earlier, but it would be good to preserve that in the
> commit message here.
>=20
>=20
> > Move the multigrain timestamp floor tracking word into timekeeper.c. Ad=
d
> > two new public interfaces: The first fills a timespec64 with the later
> > of the coarse-grained clock and the floor time, and the second gets a
> > fine-grained time and tries to swap it into the floor and fills a
> > timespec64 with the result.
> >=20
> > The first function returns an opaque cookie that is suitable for passin=
g
> > to the second, which will use it as the "old" value in the cmpxchg.
>=20
> The cookie usage isn't totally clear to me right off.  It feels a bit
> more subtle then I'd expect.
>=20
>=20
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index 5391e4167d60..bb039c9d525e 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -114,6 +114,13 @@ static struct tk_fast tk_fast_raw  ____cacheline_a=
ligned =3D {
> >         .base[1] =3D FAST_TK_INIT,
> >  };
> >=20
> > +/*
> > + * This represents the latest fine-grained time that we have handed ou=
t as a
> > + * timestamp on the system. Tracked as a monotonic ktime_t, and conver=
ted to the
> > + * realtime clock on an as-needed basis.
> > + */
> > +static __cacheline_aligned_in_smp atomic64_t mg_floor;
> > +
>=20
> So I do really like this general approach of having an internal floor
> value combined with special coarse/fine grained assessors that work
> with the floor, so we're not impacting the normal hotpath logic
> (basically I was writing up a suggestion to this effect to the thread
> with Arnd when I realized you had follow up patch in my inbox).
>=20
>=20
> >  static inline void tk_normalize_xtime(struct timekeeper *tk)
> >  {
> >         while (tk->tkr_mono.xtime_nsec >=3D ((u64)NSEC_PER_SEC << tk->t=
kr_mono.shift)) {
> > @@ -2394,6 +2401,76 @@ void ktime_get_coarse_real_ts64(struct timespec6=
4 *ts)
> >  }
> >  EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
> >=20
> > +/**
> > + * ktime_get_coarse_real_ts64_mg - get later of coarse grained time or=
 floor
> > + * @ts: timespec64 to be filled
> > + *
> > + * Adjust floor to realtime and compare it to the coarse time. Fill
> > + * @ts with the latest one. Returns opaque cookie suitable to pass
> > + * to ktime_get_real_ts64_mg.
> > + */
> > +u64 ktime_get_coarse_real_ts64_mg(struct timespec64 *ts)
> > +{
> > +       struct timekeeper *tk =3D &tk_core.timekeeper;
> > +       u64 floor =3D atomic64_read(&mg_floor);
> > +       ktime_t f_real, offset, coarse;
> > +       unsigned int seq;
> > +
> > +       WARN_ON(timekeeping_suspended);
> > +
> > +       do {
> > +               seq =3D read_seqcount_begin(&tk_core.seq);
> > +               *ts =3D tk_xtime(tk);
> > +               offset =3D *offsets[TK_OFFS_REAL];
> > +       } while (read_seqcount_retry(&tk_core.seq, seq));
> > +
> > +       coarse =3D timespec64_to_ktime(*ts);
> > +       f_real =3D ktime_add(floor, offset);
> > +       if (ktime_after(f_real, coarse))
> > +               *ts =3D ktime_to_timespec64(f_real);
> > +       return floor;
> > +}
> > +EXPORT_SYMBOL_GPL(ktime_get_coarse_real_ts64_mg);
>=20
> Generally this looks ok to me.
>=20
>=20
> > +/**
> > + * ktime_get_real_ts64_mg - attempt to update floor value and return r=
esult
> > + * @ts:                pointer to the timespec to be set
> > + * @cookie:    opaque cookie from earlier call to ktime_get_coarse_rea=
l_ts64_mg()
> > + *
> > + * Get a current monotonic fine-grained time value and attempt to swap
> > + * it into the floor using @cookie as the "old" value. @ts will be
> > + * filled with the resulting floor value, regardless of the outcome of
> > + * the swap.
> > + */
>=20
> Again this cookie argument usage and the behavior of this function
> isn't very clear to me.
>=20
> > +void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie)
> > +{
> > +       struct timekeeper *tk =3D &tk_core.timekeeper;
> > +       ktime_t offset, mono, old =3D (ktime_t)cookie;
> > +       unsigned int seq;
> > +       u64 nsecs;
> > +
> > +       WARN_ON(timekeeping_suspended);
> > +
> > +       do {
> > +               seq =3D read_seqcount_begin(&tk_core.seq);
> > +
> > +               ts->tv_sec =3D tk->xtime_sec;
> > +               mono =3D tk->tkr_mono.base;
> > +               nsecs =3D timekeeping_get_ns(&tk->tkr_mono);
> > +               offset =3D *offsets[TK_OFFS_REAL];
> > +       } while (read_seqcount_retry(&tk_core.seq, seq));
> > +
> > +       mono =3D ktime_add_ns(mono, nsecs);
> > +       if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
> > +               ts->tv_nsec =3D 0;
> > +               timespec64_add_ns(ts, nsecs);
> > +       } else {
> > +               *ts =3D ktime_to_timespec64(ktime_add(old, offset));
> > +       }
> > +
> > +}
> > +EXPORT_SYMBOL(ktime_get_real_ts64_mg);
>=20
>=20
> So initially I was expecting this to look something like (sorry for
> the whitespace damage here):
> {
>     do {
>         seq =3D read_seqcount_begin(&tk_core.seq);
>         ts->tv_sec =3D tk->xtime_sec;
>         mono =3D tk->tkr_mono.base;
>         nsecs =3D timekeeping_get_ns(&tk->tkr_mono);
>         offset =3D *offsets[TK_OFFS_REAL];
>     } while (read_seqcount_retry(&tk_core.seq, seq));
>=20
>     mono =3D ktime_add_ns(mono, nsecs);
>     do {
>         old =3D atomic64_read(&mg_floor);
>         if (floor >=3D mono)
>             break;
>     } while(!atomic64_try_cmpxchg(&mg_floor, old, mono);
>     ts->tv_nsec =3D 0;
>     timespec64_add_ns(ts, nsecs);
> }
>=20
> Where you read the tk data, atomically update the floor (assuming it's
> not in the future) and then return the finegrained value, not needing
> to manage a cookie value.
>=20
> But instead, it seems like if something has happened since the cookie
> value was saved (another cpu getting a fine grained timestamp), your
> ktime_get_real_ts64_mg() will fall back to returning the same coarse
> grained time saved to the cookie, as if no time had past?
>
> It seems like that could cause problems:
>=20
> cpu1                                     cpu2
> -------------------------------------------------------------------------=
-
>                                          t2a =3D ktime_get_coarse_real_ts=
64_mg
> t1a =3D ktime_get_coarse_real_ts64_mg()
> t1b =3D ktime_get_real_ts64_mg(t1a)
>=20
>                                          t2b =3D ktime_get_real_ts64_mg(t=
2a)
>=20
> Where t2b will seem to be before t1b, even though it happened afterwards.
>=20

Ahh no, the subtle thing about atomic64_try_cmpxchg is that it
overwrites "old" with the value that was currently there in the event
that the cmp fails.

So, the try_cmpxchg there will either swap the new value into place, or
if it was updated in the meantime, "old" will now refer to the value
that's currently in the floor word. Either is fine in this case, so we
don't need to retry anything.
--=20
Jeff Layton <jlayton@kernel.org>

