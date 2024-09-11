Return-Path: <linux-fsdevel+bounces-29128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBBF975B9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 22:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349AD1C22640
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9D71BBBD1;
	Wed, 11 Sep 2024 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO7A9v5L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4534F1BB686;
	Wed, 11 Sep 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085966; cv=none; b=d1Rn1GzBK0eCqXJuE0ts/WjbHmmPMDxHdarsUncrPYOmLeI8sN12LAmhzaHn3i/xXaRYGcEQMFmt44lMBr4k0/LMxaWMqxaDGXGSp8TZuvFAUgsDTg5skaYhdUOJf4GdpQq6RojyNImLUYHvc8Tl8PyrqHOuj+wKhRnMoMauumU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085966; c=relaxed/simple;
	bh=0Ux8q/k/QdWu5oVWHH+EnbylLiwL4RmQm4L57OVzB/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yi0fnWJrY2OTYEehFEvTaxwEvYXYQWPjGnqdEBlwgBhJGmzoWWbRdnQ93+eydh+fOxKIgeZhH5cjr9nxrSsIhxtf+rmqAgbu6kG0gQFJ7VY3WaffYLxGz3moMYhCHq63RGpo6K0dNOZue3HmvfpXeFQ+7B4XNQdcX9K32Y3S0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO7A9v5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFD1C4CEC0;
	Wed, 11 Sep 2024 20:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085965;
	bh=0Ux8q/k/QdWu5oVWHH+EnbylLiwL4RmQm4L57OVzB/8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dO7A9v5LnXSBVtSjWkMWuVclPFZbPCHtzVtmHs/au0+6wlfhBMz4aNYvq+LHRV5q2
	 gv6KtecQaOhkfJULGMz2+FDZv7VFYUKI5FZ7Zohw3eyHTOSgfYOajOo1zeQg1YCeNJ
	 T6NPM3G0b14qJRD9zyims+nZnorL+VT42Ods+ugd7rDnac4vBkhEnSKwAbET3unygU
	 3aG59ZcAJjtSsTCZ0yp4kA4fo/YeRQFvXKhs+sv5nWyk2YbZpr9U9tXZsqAXSLz+kR
	 eZswZ/Ir2GO5iCwWPEz6oLC6JMoZDGciwyqQ3S++9pp3BayIGL5b2GJOlXbYyhnifP
	 8BV+Owrpj3JfQ==
Message-ID: <88c8b17b1fe7db8215ec4a7aebc4893d8c15574b.camel@kernel.org>
Subject: Re: [PATCH] timekeeping: move multigrain ctime floor handling into
 timekeeper
From: Jeff Layton <jlayton@kernel.org>
To: John Stultz <jstultz@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner
 <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann
 <arnd@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  kernel test robot <oliver.sang@intel.com>
Date: Wed, 11 Sep 2024 16:19:23 -0400
In-Reply-To: <CANDhNCpmZO1LTCDXzi-GZ6XkvD5w3ci6aCj61-yP6FJZgXj2RA@mail.gmail.com>
References: <20240911-mgtime-v1-1-e4aedf1d0d15@kernel.org>
	 <CANDhNCpmZO1LTCDXzi-GZ6XkvD5w3ci6aCj61-yP6FJZgXj2RA@mail.gmail.com>
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

On Wed, 2024-09-11 at 12:55 -0700, John Stultz wrote:
> On Wed, Sep 11, 2024 at 5:57=E2=80=AFAM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > The kernel test robot reported a performance regression in some
> > will-it-scale tests due to the multigrain timestamp patches. The data
> > showed that coarse_ctime() was slowing down current_time(), which is
> > called frequently in the I/O path.
>=20
> Maybe add a link to/sha for multigrain timestamp patches?
>=20

Sure. This is the latest posting:

https://lore.kernel.org/linux-fsdevel/20240715-mgtime-v6-0-48e5d34bd2ba@ker=
nel.org/

The patches are in the vfs.mgtime branch of Christian's public tree as
well.

> It might be helpful as well to further explain the overhead you're
> seeing in detail?
>=20

I changed current_time() to call a new coarse_ctime() function. That
function just calls ktime_* functions, but it makes 2 trips through
seqcount loops. Each of those implies a smp_mb() call.

This patch gets that down to a single seqcount loop.

> > Add ktime_get_coarse_real_ts64_with_floor(), which returns either the
> > coarse time or the floor as a realtime value. This avoids some of the
> > conversion overhead of coarse_ctime(), and recovers some of the
> > performance in these tests.
> >=20
> > The will-it-scale pipe1_threads microbenchmark shows these averages on
> > my test rig:
> >=20
> >         v6.11-rc7:                      83830660 (baseline)
> >         v6.11-rc7 + mgtime series:      77631748 (93% of baseline)
> >         v6.11-rc7 + mgtime + this:      81620228 (97% of baseline)
> >=20
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202409091303.31b2b713-oliver.san=
g@intel.com
>=20
> Fixes: ?

Sure. But as I said, this is not in mainline yet:

    Fixes: a037d5e7f81b ("fs: add infrastructure for multigrain timestamps"=
)

>=20
> > Suggested-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Arnd suggested moving this into the timekeeper when reviewing an earlie=
r
> > version of this series, and that turns out to be better for performance=
.
> >=20
> > I'm not sure how this should go in (if acceptable). The multigrain
> > timestamp patches that this would affect are in Christian's tree, so
> > that may be best if the timekeeper maintainers are OK with this
> > approach.
> > ---
> >  fs/inode.c                  | 35 +++++++++--------------------------
> >  include/linux/timekeeping.h |  2 ++
> >  kernel/time/timekeeping.c   | 29 +++++++++++++++++++++++++++++
> >  3 files changed, 40 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 01f7df1973bd..47679a054472 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -2255,25 +2255,6 @@ int file_remove_privs(struct file *file)
> >  }
> >  EXPORT_SYMBOL(file_remove_privs);
> >=20
> > -/**
> > - * coarse_ctime - return the current coarse-grained time
> > - * @floor: current (monotonic) ctime_floor value
> > - *
> > - * Get the coarse-grained time, and then determine whether to
> > - * return it or the current floor value. Returns the later of the
> > - * floor and coarse grained timestamps, converted to realtime
> > - * clock value.
> > - */
> > -static ktime_t coarse_ctime(ktime_t floor)
> > -{
> > -       ktime_t coarse =3D ktime_get_coarse();
> > -
> > -       /* If coarse time is already newer, return that */
> > -       if (!ktime_after(floor, coarse))
> > -               return ktime_get_coarse_real();
> > -       return ktime_mono_to_real(floor);
> > -}
>=20
> I'm guessing this is part of the patch set being worked on, but this
> is a very unintuitive function.
>=20
> You give it a CLOCK_MONOTONIC floor value, but it returns
> CLOCK_REALTIME based time?
>=20
> It looks like it's asking to be misused.
>=20

I get your point, but I think it's unavoidable here, unfortunately.

> ...
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index 5391e4167d60..56b979471c6a 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -2394,6 +2394,35 @@ void ktime_get_coarse_real_ts64(struct timespec6=
4 *ts)
> >  }
> >  EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
> >=20
> > +/**
> > + * ktime_get_coarse_real_ts64_with_floor - get later of coarse grained=
 time or floor
> > + * @ts: timespec64 to be filled
> > + * @floor: monotonic floor value
> > + *
> > + * Adjust @floor to realtime and compare that to the coarse time. Fill
> > + * @ts with the later of the two.
> > + */
> > +void ktime_get_coarse_real_ts64_with_floor(struct timespec64 *ts, ktim=
e_t floor)
>=20
> Maybe name 'floor' 'mono_floor' so it's very clear?
>=20

Sure. Will do.

> > +{
> > +       struct timekeeper *tk =3D &tk_core.timekeeper;
> > +       unsigned int seq;
> > +       ktime_t f_real, offset, coarse;
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
>=20
>=20
> I am still very wary of the function taking a CLOCK_MONOTONIC
> comparator and returning a REALTIME value.
> But I think I understand why you might want it: You want a ratchet to
> filter inconsistencies from mixing fine and coarse (which very quickly
> return the time in the recent past) grained timestamps, but you want
> to avoid having a one way ratchet getting stuck if settimeofday() get
> called.
> So you implemented the ratchet against CLOCK_MONOTONIC, so
> settimeofday offsets are ignored.
>=20
> Is that close?
>=20

Bingo.

> My confusion comes from the fact it seems like that would mean you
> have to do all your timestamping with CLOCK_MONOTONIC (so you have a
> useful floor value that you're keeping), so I'm not sure I understand
> the utility of returning CLOCK_REALTIME values. I guess I don't quite
> see the logic where the floor value is updated here, so I'm guessing.
>=20

The floor value is updated in inode_set_ctime_current() in the
multigrain series. The comments over that hopefully describe how it
works, but basically, once we determine that we need a fine-grained
timestamp, we fetch a new fine-grained value and try to swap it into
ctime_floor. After that, we convert it to a realtime value and try to
swap the nsec field into the inode's ctime.

The conversion is a bit expensive, but the multigrain series takes
great pains to only update the ctime_floor as a last resort. It's a
global value, so we _really_ don't want to write to it any more than
necessary.

> Further, while this change from the earlier method avoids having to
> make two calls taking the timekeeping seqlock, this still is going
> from timespec->ktime->timespec still seems a little less than optimal
> if this is a performance hotpath (the coarse clocks are based on
> CLOCK_REALTIME timespecs because that was the legacy hotpath being
> optimized for, so if we have to internalize this odd-seeming reatime
> against monotonic usage model, we probably should better optimise
> through the stack there).
>=20

The floor is tracked as a ktime_t, as we need to be able to swap it
into place with a cmpxchg() operation. I did originally try to use
timespec64's for everything, but it was too hard to keep everything
consistent without resorting to locking.

That said, I'm open to suggestions to make this better. I did (briefly)
look at whether moving the floor tracking into the timekeeper wholesale
would be better, but it didn't seem to be.

Thanks for taking a look!
--=20
Jeff Layton <jlayton@kernel.org>

