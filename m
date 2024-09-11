Return-Path: <linux-fsdevel+bounces-29127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B108975B28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 21:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D45DB212AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 19:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740FB1BAEFA;
	Wed, 11 Sep 2024 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4NYJVo3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5F1885A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084553; cv=none; b=ZOeEkpBWIay9N8koKYhG4urViY4DSbKah2C3nxE9Gu2ssAZn7zvJfUWOevE8Z/Xxp2Q9xIBOqST9ku9AcRsmObFZHdpZ+Y6BBNzvmQjWILc/Ab9dX/iH0mLwVfGAovK2asovXe//JOhlSrpDvgUhs3KrmE3ZFCRxl0oNViUarG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084553; c=relaxed/simple;
	bh=AtS/vtUDqa8BrO/44xGel2VzOkOFsDwl48up/vKJGSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qn/ZyqMZwyLzi1xdkOM3HWeNR93a7w/dBfmu0jd6aaAgG4yPoOUHZd0HBGDB8g6ZJsLZCGEDojnj7R8UrlzYp+07mftg41CD9xT93uRypb+YkNOY84MUIkbGiWZG/qAf2QIuhbKrFptgxtLR5ik1CBP47ElfhRZB/Dia8yIBKo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k4NYJVo3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c2561e8041so192786a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726084550; x=1726689350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPRyDxECFyr4nN2D4Ol4thDDsE/Tz2t9ujsW1DgfZ4Y=;
        b=k4NYJVo3ur1pvuc66N1sVJEtFW6My1mxcFTPoZ3Ga2g/IH+GCi2l48V8LsxHR7uOU8
         jZLCGqGrY1cQ0YGddcm+rdK52hBWHtIqQeWTYD9DydgD/uAB+9XYecQ1UGETlt/STQnO
         U+2qATkC1BaSdIF9NADmERoWxDrsQflRhndBEaO7KYmHsz+hgc2hefvBoCYI5LfpGTyX
         dpSPBZBx7A1j8dB6u1491PlzNQMVnKzXs6kuSHAvHBoE3rHQN9zN0CM+2JAqotYe6y+C
         sdWbk60E7UTDOg0LFx0Rp1z7nufCAW6+rjik7pQ/GpwRvJYRaOJwDHYsVxT0sl0JQ0u8
         etKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726084550; x=1726689350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPRyDxECFyr4nN2D4Ol4thDDsE/Tz2t9ujsW1DgfZ4Y=;
        b=Rzly01M0bu8wYXW5Lm3E5Pg4QOtHu4FSTKMIeQb3ZppH/b9aLYQTFLAHrvCSE6PAo1
         jIuxMX+H/AqKWPUDu0aZI3wR9Sd3pUAcuni1sn8CZw4CsNezjbIb5dRlrwKqqCbIM3nx
         HQZBP4E/NB6bPi7BkATetRTAEq+vxhJwB1hIbuaMFjjGYmJi2DtZJLGgz3RLRm5oqddG
         1xMNb1a/cU+lCtaWGFirgOGlNO3Y+1J8d7knF3sApKwBCa/8ebQjjzFEABIeU9vpCTdb
         rBy8raadIz/V4szvxAWxxsFQ8tE0vSq5MvV1F5eyS7R24x8cEAcAYCPt2shU2UAV/9Vj
         milA==
X-Forwarded-Encrypted: i=1; AJvYcCWaE2Ikw3bBMq1THZxagGjv4tuobu6ZoMQYiJsopaoBB6J3iXftMvql3FQRDNe+Gw0q2ShEFz+1vpM6+Bfd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx7cdZs72EFbFY1zNRx9ojDp5V3CZWD1JmHr0cOzkNNwmhfQB0
	NBPij28cx3f27arY7YjJPprvHFL8RHI8lpR5hsJYOIfRcLVqbQV4QT+tcLK8lBqnnsuR9CXADM9
	RqgHU3xLlrIrnBa2uiuDNhu/+jCVgRlJLzzg=
X-Google-Smtp-Source: AGHT+IGZVpGPeptGjKVux42xghEzMZfNtBgZVhNGpLa8uu5pmrsNw565ugx6vrNjThWUoZG1YOMHwgiD/b8fdXMhwYQ=
X-Received: by 2002:a17:907:9729:b0:a8d:1774:eb59 with SMTP id
 a640c23a62f3a-a9029634ed5mr47631266b.54.1726084548875; Wed, 11 Sep 2024
 12:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-mgtime-v1-1-e4aedf1d0d15@kernel.org>
In-Reply-To: <20240911-mgtime-v1-1-e4aedf1d0d15@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 12:55:36 -0700
Message-ID: <CANDhNCpmZO1LTCDXzi-GZ6XkvD5w3ci6aCj61-yP6FJZgXj2RA@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: move multigrain ctime floor handling into timekeeper
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 5:57=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> The kernel test robot reported a performance regression in some
> will-it-scale tests due to the multigrain timestamp patches. The data
> showed that coarse_ctime() was slowing down current_time(), which is
> called frequently in the I/O path.

Maybe add a link to/sha for multigrain timestamp patches?

It might be helpful as well to further explain the overhead you're
seeing in detail?

> Add ktime_get_coarse_real_ts64_with_floor(), which returns either the
> coarse time or the floor as a realtime value. This avoids some of the
> conversion overhead of coarse_ctime(), and recovers some of the
> performance in these tests.
>
> The will-it-scale pipe1_threads microbenchmark shows these averages on
> my test rig:
>
>         v6.11-rc7:                      83830660 (baseline)
>         v6.11-rc7 + mgtime series:      77631748 (93% of baseline)
>         v6.11-rc7 + mgtime + this:      81620228 (97% of baseline)
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409091303.31b2b713-oliver.sang@=
intel.com

Fixes: ?

> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Arnd suggested moving this into the timekeeper when reviewing an earlier
> version of this series, and that turns out to be better for performance.
>
> I'm not sure how this should go in (if acceptable). The multigrain
> timestamp patches that this would affect are in Christian's tree, so
> that may be best if the timekeeper maintainers are OK with this
> approach.
> ---
>  fs/inode.c                  | 35 +++++++++--------------------------
>  include/linux/timekeeping.h |  2 ++
>  kernel/time/timekeeping.c   | 29 +++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 26 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 01f7df1973bd..47679a054472 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2255,25 +2255,6 @@ int file_remove_privs(struct file *file)
>  }
>  EXPORT_SYMBOL(file_remove_privs);
>
> -/**
> - * coarse_ctime - return the current coarse-grained time
> - * @floor: current (monotonic) ctime_floor value
> - *
> - * Get the coarse-grained time, and then determine whether to
> - * return it or the current floor value. Returns the later of the
> - * floor and coarse grained timestamps, converted to realtime
> - * clock value.
> - */
> -static ktime_t coarse_ctime(ktime_t floor)
> -{
> -       ktime_t coarse =3D ktime_get_coarse();
> -
> -       /* If coarse time is already newer, return that */
> -       if (!ktime_after(floor, coarse))
> -               return ktime_get_coarse_real();
> -       return ktime_mono_to_real(floor);
> -}

I'm guessing this is part of the patch set being worked on, but this
is a very unintuitive function.

You give it a CLOCK_MONOTONIC floor value, but it returns
CLOCK_REALTIME based time?

It looks like it's asking to be misused.

...
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 5391e4167d60..56b979471c6a 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -2394,6 +2394,35 @@ void ktime_get_coarse_real_ts64(struct timespec64 =
*ts)
>  }
>  EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
>
> +/**
> + * ktime_get_coarse_real_ts64_with_floor - get later of coarse grained t=
ime or floor
> + * @ts: timespec64 to be filled
> + * @floor: monotonic floor value
> + *
> + * Adjust @floor to realtime and compare that to the coarse time. Fill
> + * @ts with the later of the two.
> + */
> +void ktime_get_coarse_real_ts64_with_floor(struct timespec64 *ts, ktime_=
t floor)

Maybe name 'floor' 'mono_floor' so it's very clear?

> +{
> +       struct timekeeper *tk =3D &tk_core.timekeeper;
> +       unsigned int seq;
> +       ktime_t f_real, offset, coarse;
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


I am still very wary of the function taking a CLOCK_MONOTONIC
comparator and returning a REALTIME value.
But I think I understand why you might want it: You want a ratchet to
filter inconsistencies from mixing fine and coarse (which very quickly
return the time in the recent past) grained timestamps, but you want
to avoid having a one way ratchet getting stuck if settimeofday() get
called.
So you implemented the ratchet against CLOCK_MONOTONIC, so
settimeofday offsets are ignored.

Is that close?

My confusion comes from the fact it seems like that would mean you
have to do all your timestamping with CLOCK_MONOTONIC (so you have a
useful floor value that you're keeping), so I'm not sure I understand
the utility of returning CLOCK_REALTIME values. I guess I don't quite
see the logic where the floor value is updated here, so I'm guessing.

Further, while this change from the earlier method avoids having to
make two calls taking the timekeeping seqlock, this still is going
from timespec->ktime->timespec still seems a little less than optimal
if this is a performance hotpath (the coarse clocks are based on
CLOCK_REALTIME timespecs because that was the legacy hotpath being
optimized for, so if we have to internalize this odd-seeming reatime
against monotonic usage model, we probably should better optimise
through the stack there).

thanks
-john

