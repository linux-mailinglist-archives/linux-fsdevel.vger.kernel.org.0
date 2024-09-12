Return-Path: <linux-fsdevel+bounces-29211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D08977293
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 22:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BF31F23DC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3AB1C173B;
	Thu, 12 Sep 2024 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9jtY1yO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB518BBBA
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726171907; cv=none; b=ERUYBzC/M4Nz6yHaqUPhT/vcxuoALvuJLU5fX97+qNbKakZvT2X3uPq5R3JRO7i0jC+4zhLa+oAkFITuGCOCFh2R1e/DdyJfOaLjv6sGQdr1tU72D6AeyFYqYZVnrEQZpWBDpBkdTvsk3awR0l8pRkdj+anklHfaVxJ19Pq1oJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726171907; c=relaxed/simple;
	bh=UJqNS1sQlDFx7uFfVyI2YODeieASNHMm3BFxoDZQvXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc/FmAibFF0tXRggoP31VIHN7FbEj4G3PbuxlVLewpug2YA335deUEBQaLUPPEC6Oe3FNwZwGznhMzIa51wj/NzLDzfcBzI2mLMrzzp46xUdBBZO5q5s8VTmDg8nYaKcrUR8/CpGnagumEqCH5a7Rl7hvvnvehITBBzSPFlveX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9jtY1yO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365a9574b6so372768e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726171904; x=1726776704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghtPS207NvckaCt/apvapTKHq1IN7cyfERE9Mcp7DmM=;
        b=I9jtY1yOFA+SX1Ww/QhBD0Fo4H3UJvFCwivDmoQct/Y4Oiw1nzNnRiVbi7k9g8lBix
         6gSsmAe65em8X49ycRTJQQDIWQGSE/bTHMFZLxWD/6i80n6qxSUUc209QXNBOq+eLt7u
         Aa6BLxRCODOmltjeGnuF4s1T211GJkLCJlbV1dynEbg7SS2xkhAKwTXEIBZ8jXLV6kFO
         tntP9KpxrPyRAsTXO/sZx5ijyutEzyrfXfWMwqRYIpiU1t9GB6cWdk334gjxjNsZbSlv
         puCOvP+qURAzwCte/e21Duj/g4KsmNigILXKoUYW9EX2N2THHrRfg2NvZZeFzbY9Xm3k
         Xuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726171904; x=1726776704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghtPS207NvckaCt/apvapTKHq1IN7cyfERE9Mcp7DmM=;
        b=wvHxWQqaco26Q6PXXsexawEFFaXZWYWJGpPX1K+hBHWhdvmpY5XiC162JvVOiM0u6T
         MV4tzktKhwNQq/i+/XpuXuXBuVXqVjmWUJVKhfs9btlBN/TepDOOx4GSRC63i6ehej8N
         Dfx1v0aJc4Itn2I41u0UZqM1h8dYkniKe1947wFvBVskziEKvy+Owc0i4ZRqG12nVKVi
         edW92lGOEN7WqhtdYqdBUH4jpfI03nrkgA6FqlaZu2Rr3WAfoYog633zwwveqP1+5RmO
         0N5XB3VLcPL/KvmudlSyJSSL+jnGqH/LoXpxdHmCcThoKsp1PqZDP9IwkFTfNTCR6ffR
         cvvg==
X-Forwarded-Encrypted: i=1; AJvYcCVpAKWKb+VFyaohqcTcyZfR7n2+xney04BmyaocMT1fLQ6XO9TZ9QX4fXaa+R4Gnpb107MCG+CvZW+9L8f/@vger.kernel.org
X-Gm-Message-State: AOJu0YwmbYGQAXsXds1jGHg3Nwyqo9L5015k6Vn0lbX5Nv5PxQKCF6jG
	YlVNp12R/G+1FE2EyW5G7nqGXFJ8Gd7zU3JFithUZa0dAB5Q9I1KYfB33isqMxAWk1h0S2Z6bkg
	oJlGLQu6oSMDecaPACkFCfcXBk1zK3zOCzL0=
X-Google-Smtp-Source: AGHT+IE0g9pILN6JNTa4rYDhmz1UMSQyASnBYwEoC5a6WnlJcA/809n641w5RmtLn7xXUJFmVPvn3+uADZc1oT6ddC8=
X-Received: by 2002:ac2:4bc9:0:b0:536:5509:8857 with SMTP id
 2adb3069b0e04-5367fecbfb1mr396114e87.21.1726171902952; Thu, 12 Sep 2024
 13:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-mgtime-v2-1-54db84afb7a7@kernel.org>
In-Reply-To: <20240912-mgtime-v2-1-54db84afb7a7@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Sep 2024 13:11:31 -0700
Message-ID: <CANDhNCrpkTfe6BRVNf1ihhGALbPBBhOs1PCPxA4MDHa1+=sEbQ@mail.gmail.com>
Subject: Re: [PATCH v2] timekeeping: move multigrain timestamp floor handling
 into timekeeper
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:02=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> The kernel test robot reported a performance hit in some will-it-scale
> tests due to the multigrain timestamp patches.  My own testing showed
> about a 7% drop in performance on the pipe1_threads test, and the data
> showed that coarse_ctime() was slowing down current_time().

So, you provided some useful detail about why coarse_ctime() was slow
in your reply earlier, but it would be good to preserve that in the
commit message here.


> Move the multigrain timestamp floor tracking word into timekeeper.c. Add
> two new public interfaces: The first fills a timespec64 with the later
> of the coarse-grained clock and the floor time, and the second gets a
> fine-grained time and tries to swap it into the floor and fills a
> timespec64 with the result.
>
> The first function returns an opaque cookie that is suitable for passing
> to the second, which will use it as the "old" value in the cmpxchg.

The cookie usage isn't totally clear to me right off.  It feels a bit
more subtle then I'd expect.


> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 5391e4167d60..bb039c9d525e 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -114,6 +114,13 @@ static struct tk_fast tk_fast_raw  ____cacheline_ali=
gned =3D {
>         .base[1] =3D FAST_TK_INIT,
>  };
>
> +/*
> + * This represents the latest fine-grained time that we have handed out =
as a
> + * timestamp on the system. Tracked as a monotonic ktime_t, and converte=
d to the
> + * realtime clock on an as-needed basis.
> + */
> +static __cacheline_aligned_in_smp atomic64_t mg_floor;
> +

So I do really like this general approach of having an internal floor
value combined with special coarse/fine grained assessors that work
with the floor, so we're not impacting the normal hotpath logic
(basically I was writing up a suggestion to this effect to the thread
with Arnd when I realized you had follow up patch in my inbox).


>  static inline void tk_normalize_xtime(struct timekeeper *tk)
>  {
>         while (tk->tkr_mono.xtime_nsec >=3D ((u64)NSEC_PER_SEC << tk->tkr=
_mono.shift)) {
> @@ -2394,6 +2401,76 @@ void ktime_get_coarse_real_ts64(struct timespec64 =
*ts)
>  }
>  EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
>
> +/**
> + * ktime_get_coarse_real_ts64_mg - get later of coarse grained time or f=
loor
> + * @ts: timespec64 to be filled
> + *
> + * Adjust floor to realtime and compare it to the coarse time. Fill
> + * @ts with the latest one. Returns opaque cookie suitable to pass
> + * to ktime_get_real_ts64_mg.
> + */
> +u64 ktime_get_coarse_real_ts64_mg(struct timespec64 *ts)
> +{
> +       struct timekeeper *tk =3D &tk_core.timekeeper;
> +       u64 floor =3D atomic64_read(&mg_floor);
> +       ktime_t f_real, offset, coarse;
> +       unsigned int seq;
> +
> +       WARN_ON(timekeeping_suspended);
> +
> +       do {
> +               seq =3D read_seqcount_begin(&tk_core.seq);
> +               *ts =3D tk_xtime(tk);
> +               offset =3D *offsets[TK_OFFS_REAL];
> +       } while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +       coarse =3D timespec64_to_ktime(*ts);
> +       f_real =3D ktime_add(floor, offset);
> +       if (ktime_after(f_real, coarse))
> +               *ts =3D ktime_to_timespec64(f_real);
> +       return floor;
> +}
> +EXPORT_SYMBOL_GPL(ktime_get_coarse_real_ts64_mg);

Generally this looks ok to me.


> +/**
> + * ktime_get_real_ts64_mg - attempt to update floor value and return res=
ult
> + * @ts:                pointer to the timespec to be set
> + * @cookie:    opaque cookie from earlier call to ktime_get_coarse_real_=
ts64_mg()
> + *
> + * Get a current monotonic fine-grained time value and attempt to swap
> + * it into the floor using @cookie as the "old" value. @ts will be
> + * filled with the resulting floor value, regardless of the outcome of
> + * the swap.
> + */

Again this cookie argument usage and the behavior of this function
isn't very clear to me.

> +void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie)
> +{
> +       struct timekeeper *tk =3D &tk_core.timekeeper;
> +       ktime_t offset, mono, old =3D (ktime_t)cookie;
> +       unsigned int seq;
> +       u64 nsecs;
> +
> +       WARN_ON(timekeeping_suspended);
> +
> +       do {
> +               seq =3D read_seqcount_begin(&tk_core.seq);
> +
> +               ts->tv_sec =3D tk->xtime_sec;
> +               mono =3D tk->tkr_mono.base;
> +               nsecs =3D timekeeping_get_ns(&tk->tkr_mono);
> +               offset =3D *offsets[TK_OFFS_REAL];
> +       } while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +       mono =3D ktime_add_ns(mono, nsecs);
> +       if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
> +               ts->tv_nsec =3D 0;
> +               timespec64_add_ns(ts, nsecs);
> +       } else {
> +               *ts =3D ktime_to_timespec64(ktime_add(old, offset));
> +       }
> +
> +}
> +EXPORT_SYMBOL(ktime_get_real_ts64_mg);


So initially I was expecting this to look something like (sorry for
the whitespace damage here):
{
    do {
        seq =3D read_seqcount_begin(&tk_core.seq);
        ts->tv_sec =3D tk->xtime_sec;
        mono =3D tk->tkr_mono.base;
        nsecs =3D timekeeping_get_ns(&tk->tkr_mono);
        offset =3D *offsets[TK_OFFS_REAL];
    } while (read_seqcount_retry(&tk_core.seq, seq));

    mono =3D ktime_add_ns(mono, nsecs);
    do {
        old =3D atomic64_read(&mg_floor);
        if (floor >=3D mono)
            break;
    } while(!atomic64_try_cmpxchg(&mg_floor, old, mono);
    ts->tv_nsec =3D 0;
    timespec64_add_ns(ts, nsecs);
}

Where you read the tk data, atomically update the floor (assuming it's
not in the future) and then return the finegrained value, not needing
to manage a cookie value.

But instead, it seems like if something has happened since the cookie
value was saved (another cpu getting a fine grained timestamp), your
ktime_get_real_ts64_mg() will fall back to returning the same coarse
grained time saved to the cookie, as if no time had past?

It seems like that could cause problems:

cpu1                                     cpu2
--------------------------------------------------------------------------
                                         t2a =3D ktime_get_coarse_real_ts64=
_mg
t1a =3D ktime_get_coarse_real_ts64_mg()
t1b =3D ktime_get_real_ts64_mg(t1a)

                                         t2b =3D ktime_get_real_ts64_mg(t2a=
)

Where t2b will seem to be before t1b, even though it happened afterwards.


thanks
-john

