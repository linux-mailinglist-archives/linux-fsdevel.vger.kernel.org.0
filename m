Return-Path: <linux-fsdevel+bounces-23369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5C792B4FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 12:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFC11C22A7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726C8155C94;
	Tue,  9 Jul 2024 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUybTvkG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505051FA3;
	Tue,  9 Jul 2024 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520246; cv=none; b=QaVMNzYHF5H5GArveC1rGlywvzRVWDQ7+S9V6S9W3nbPChEe7foq0iRWaQyWfWIURiz4F63hK1eOi42U9E87wnrQs32A+TjGhdBkEHqyEgg4wxn5XtlFQJMq5JSO35+9jfxoojM6NUKFhmdlLPpRP3/YzQhBq8prigXjaOJkJEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520246; c=relaxed/simple;
	bh=lP7MS/SSQSGkVJ5jAW2+76EJviVIBFt7fQoTvHmqjJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAQCFew9lLbl05J6qmSXjePgVMkSt3gGn5eB2LjZ5ddGYGzNogRryuq9wD1fMNgrr1VJSAp/y4/IuOQfuaKXKPAdMxYVdT8NT0yhn42w+sm3ow4y9JoOexETJHbiH0gTxmXGpUQJ88Bl2EiASHN5dJycPM1cJ10G95hr1Qn8VdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUybTvkG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso6141140a12.2;
        Tue, 09 Jul 2024 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720520244; x=1721125044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUU4V5yTD3E6P/UWJvCDJ0CcvQXY96+XekGETdSHgbU=;
        b=PUybTvkGeLBizrU6VaWp6QpuQ9CB7JQHsiYgGsjhYHFpDc5easkSVTPx8MAN1BgHga
         r6k1FMD7eOfShmSIfiT8zoDf0JZyae/8q6541LxA9mVYtpiXXLv/RhvtteEjsSAHEvTL
         W3uRw9z/qFBNyBM7B+F/ZeEcY9OA26L34j6JDR2SOO536Eac94ObVTEZveRycmXgXdAe
         Z6EuzFQz0QVjhUCS5FVEy9NO+++Hp31/QeVtZvZ/3OGk/8Rt18+OZmIy/fwuHBIRGKsS
         pxwfh+aCCIWUpdNorUHvMMRWoN9qQBJFYC3GAFv8vpEf6/oE1qCh52g1QhIBS3h9GOD5
         2S/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520244; x=1721125044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUU4V5yTD3E6P/UWJvCDJ0CcvQXY96+XekGETdSHgbU=;
        b=S3JoiTN8qZIbmdplvkciOGsENfZlSEU2zryqgHcVlrAH/15v49mOh/MNenulLU6M2t
         HLSAgbJ6REX+/OBY+upjoYeUo/Ga236Bk/pHhpDsUQhWyq7ntlHJkqv/Psm9Ibqhr2Hz
         9bO3qSKgTdHH4gGwVt8I0XL+Y7Se6mTMwbbQjWg1GmHJmrtWUOZS2y2NkSGkTsuZiJ9g
         uc3Atbq96kPkcc5bqz0aLWF08FJaAW++c/2565cBGhbfe5PCcdidYtYEeEKeN5XdPE08
         sxqnNaa9BSOkjE647iFZxuyyZ3vvecC0IiJ/oKjlWQIR9zaCe8oTrRbYCdYuZYDvFkH6
         YpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2sGFSM1VxllgH7H9s0+B2MAIxnxfFjkcyDVyPhXd44A9V7X5kzEASAjv2l+e4ggNGsHrLNpjhcaOMf2bTI0YOQ5JHlGSQj5S3flM+YwkCYf3w2P8l7MRtxTzBHY/3aMP2z9qTo/X6MYNaqg==
X-Gm-Message-State: AOJu0YyoJSLPjZ1rrgH2Pgd6J6PJtO8UCseM01AoinsGH6u8432sHUQB
	9dnh7m5in954/pkD2cwkNiiDkHrL8ebJvmZ5OJgAEr68dR6864qZSYOKm8HM4gdelyGCrkebzDh
	Z4/+bl4+MtVIaZLcDg9M6ubecWEKMcA==
X-Google-Smtp-Source: AGHT+IHUGKDAeSkKp9GM4WQ4dY21by1sO/dcn3kMOXX3QjhfD2crAARDs5/+8YBnt2MO0T7d0JodJtKs3FIlQ3siD6I=
X-Received: by 2002:a17:907:7da8:b0:a72:4320:19f3 with SMTP id
 a640c23a62f3a-a780b70088cmr193963566b.39.1720520243335; Tue, 09 Jul 2024
 03:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614163416.728752-1-yu.ma@intel.com> <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-4-yu.ma@intel.com> <CAGudoHH_P4LGaVN1N4j8FNTH_eDm3SDL7azMc25+HY2_XgjvJQ@mail.gmail.com>
 <20240704215507.mr6st2d423lvkepu@quack3> <3c7a0cd7-1dd2-4762-a2dd-67e6b6a82df7@intel.com>
 <1296ef8d-dade-46e5-8571-e7dba158f405@intel.com>
In-Reply-To: <1296ef8d-dade-46e5-8571-e7dba158f405@intel.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 9 Jul 2024 12:17:09 +0200
Message-ID: <CAGudoHGJrRi_UZ2wv2dG9U9VGasHW203O4nQHkE9KkaWJJ61WQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs/file.c: add fast path in find_next_fd()
To: "Ma, Yu" <yu.ma@intel.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	edumazet@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com, 
	tim.c.chen@intel.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Right, forgot to respond.

I suspect the different result is either because of mere variance
between reboots or blogbench using significantly less than 100 fds at
any given time -- I don't have an easy way to test at your scale at
the moment. You could probably test that by benching both approaches
while switching them at runtime with a static_branch. However, I don't
know if that effort is warranted atm.

So happens I'm busy with other stuff and it is not my call to either
block or let this in, so I'm buggering off.

On Tue, Jul 9, 2024 at 10:32=E2=80=AFAM Ma, Yu <yu.ma@intel.com> wrote:
>
>
> On 7/5/2024 3:56 PM, Ma, Yu wrote:
> > I had something like this in mind:
> >>> diff --git a/fs/file.c b/fs/file.c
> >>> index a3b72aa64f11..4d3307e39db7 100644
> >>> --- a/fs/file.c
> >>> +++ b/fs/file.c
> >>> @@ -489,6 +489,16 @@ static unsigned int find_next_fd(struct fdtable
> >>> *fdt, unsigned int start)
> >>>          unsigned int maxfd =3D fdt->max_fds; /* always multiple of
> >>> BITS_PER_LONG */
> >>>          unsigned int maxbit =3D maxfd / BITS_PER_LONG;
> >>>          unsigned int bitbit =3D start / BITS_PER_LONG;
> >>> +       unsigned int bit;
> >>> +
> >>> +       /*
> >>> +        * Try to avoid looking at the second level map.
> >>> +        */
> >>> +       bit =3D find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_L=
ONG,
> >>> +                               start & (BITS_PER_LONG - 1));
> >>> +       if (bit < BITS_PER_LONG) {
> >>> +               return bit + bitbit * BITS_PER_LONG;
> >>> +       }
> >> Drat, you're right. I missed that Ma did not add the proper offset to
> >> open_fds. *This* is what I meant :)
> >>
> >>                                 Honza
> >
> > Just tried this on v6.10-rc6, the improvement on top of patch 1 and
> > patch 2 is 7% for read and 3% for write, less than just check first wor=
d.
> >
> > Per my understanding, its performance would be better if we can find
> > free bit in the same word of next_fd with high possibility, but
> > next_fd just represents the lowest possible free bit. If fds are
> > open/close frequently and randomly, that might not always be the case,
> > next_fd may be distributed randomly, for example, 0-65 are occupied,
> > fd=3D3 is returned, next_fd will be set to 3, next time when 3 is
> > allocated, next_fd will be set to 4, while the actual first free bit
> > is 66 , when 66 is allocated, and fd=3D5 is returned, then the above
> > process would be went through again.
> >
> > Yu
> >
> Hi Guzik, Honza,
>
> Do we have any more comment or idea regarding to the fast path? Thanks
> for your time and any feedback :)
>
>
> Regards
>
> Yu
>


--=20
Mateusz Guzik <mjguzik gmail.com>

