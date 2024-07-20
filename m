Return-Path: <linux-fsdevel+bounces-24040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC269381A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 16:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0FA2812FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23012F581;
	Sat, 20 Jul 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcI5PRq7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF511803D;
	Sat, 20 Jul 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721485363; cv=none; b=exdVqj3Dr4C6Eb1uWtDTxdDmA1ErL5NUk2e8YDfTT3VQiD0bQ5nayfwcQIAWCD2K04YVIR96SvIhdfVAZUsPScBlaRsrL8LddfkAxkvIhZjCu+KOk13v4NOOOaksxspUSYtYteBYeoGiHkHtUg8or6PwpdYKMgvSVOrvTMNoanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721485363; c=relaxed/simple;
	bh=GEuFJYrJmfemuiN66s3JBd2h6xdt9JYlsMWU8bKymxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4sDrygUOZLDU+bwiw9M/iI2j2B6X1Z+2iFQD4tesm8MB2o37M6Otr9/25Hj11Z7zHlp9jnrJzSaQ4Xd08EpjLH11hIfNSn4BVIntPVM4E8H4bPjlVgh6fMGp5NZqXXXpxfitRRTqCqPoW2MB4AfH+QlJ76obGOl5wfCgH1egDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcI5PRq7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso1243732f8f.1;
        Sat, 20 Jul 2024 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721485360; x=1722090160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlwhLGoXMRrfdZQAkxdZajfwEHhGebnvpcGXSKSVCSM=;
        b=bcI5PRq7ao7JGyX7CJNe8hjJqA3Iof3nQIsDlxSRkKXGcY7h2KFFgVBRbL4kDv4aEZ
         M5asmgnU/I7oO6aG6VBCQruSE9qSrD68R21izmjtBqUDJlGZ9bG7qS93UpQ+ReEH1i2b
         Kn28K0dPZ/dXzdVJ6NVB10qXChjTakpTduL+ZRaZDMeVl+SeBVIRWz349eqPLWWO4m2H
         m8ufJgnXbcsL/7JvwpS2GPyUL85c/6xqfuNgGILXqYYr9rIafyX/XPxoy9vhXRbR+GsI
         sZBaCkZsGJ0ZmAq+UEf2eRL0AngvvMiC8FyjP/RjUnn1OqHVPI9vf71IRsUEQ7I7Y7po
         FT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721485360; x=1722090160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlwhLGoXMRrfdZQAkxdZajfwEHhGebnvpcGXSKSVCSM=;
        b=mfg2v3qV/YdQQGZdokj8q0CX4DQkGof8Tv/3cHKs1M2w6S0XR5lVO6wyddkqI/KCOE
         izJB+1rrIs9SrZUoaigQ1RLit0oKRWAXt8Zv9vtx55rgbMiIyjgOudz1N9uBQ1VIp+Qz
         acrR0KbX5sRbOOgWoWSMdd5m2GXoh3uZqoVhXt7Jk7c8EG+mhas5uXfYdkEluDCji2rP
         QLqZUSekKt2fU/EWX770eaqbavoDXA7GjOMKVMRr7Gvtzin8itTtdVhAqJexWQ9DKzI3
         iafxAYcY3b6FVsUMpLma4GxvjJVN/hW310wiSlFpXur+PbUvnUYufxg//Hh3gU2piq6V
         yG6A==
X-Forwarded-Encrypted: i=1; AJvYcCVa/e3BCTlmzdaWaUf/TJqaktFyTq2oXG+3awzWXZHdMp8WPB6MUPp3FN/+64pStF/GJj7NMIzJja82wyPSQ/VaM4iIp0lOJsF50969b5au8tEGtixu2HwItJL7TkjM3l2njnURTNIUO+dbGQ==
X-Gm-Message-State: AOJu0YxYLKjR/fekXV6m0BB2euMTSHM+G6O05egsgoJeuIL7ACbrDVwN
	giuOVpgG8fbvnDSllyUuuWMnWJQEpltO16pKhvgUb9j6Aa0XgRfpPACqRha4mqVtNiRQ0kKtUCf
	0d4ZU2KSGawpZoZL2ZTKehjqReJg=
X-Google-Smtp-Source: AGHT+IH+aA7myg45AHgdzlVEabeSdItEvQYf5tM9D3qjznL5cMhs+vwvd1ZfMUd/pZ7QhyxRAiDsTSwuI6Ji++UmJSU=
X-Received: by 2002:adf:ed0a:0:b0:368:5a8c:580b with SMTP id
 ffacd0b85a97d-369bbbbdcd5mr816352f8f.19.1721485359917; Sat, 20 Jul 2024
 07:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614163416.728752-1-yu.ma@intel.com> <20240717145018.3972922-1-yu.ma@intel.com>
 <20240717145018.3972922-4-yu.ma@intel.com> <CAGudoHHQSjbeuSevyL=W=fhjOOo=bCjq4ixHfEMN_XdRLLdPbQ@mail.gmail.com>
 <2365dcaf-95d4-462b-9614-83ee9f7c12f6@intel.com>
In-Reply-To: <2365dcaf-95d4-462b-9614-83ee9f7c12f6@intel.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 20 Jul 2024 16:22:27 +0200
Message-ID: <CAGudoHGCZZwQ9EC3aW5bS4Vur7-UHgubLvTQuZa8ct=+m8-fTg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] fs/file.c: add fast path in find_next_fd()
To: "Ma, Yu" <yu.ma@intel.com>
Cc: brauner@kernel.org, jack@suse.cz, edumazet@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com, 
	tim.c.chen@linux.intel.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think this is getting too much fluff traffic at this point, which is
partially my fault.

I'm buggering off.

Overall the patchset looks good, I don't see any technical reasons to
avoid merging it.

On Sat, Jul 20, 2024 at 2:57=E2=80=AFPM Ma, Yu <yu.ma@intel.com> wrote:
>
>
> On 7/20/2024 1:53 AM, Mateusz Guzik wrote:
> > On Wed, Jul 17, 2024 at 4:24=E2=80=AFPM Yu Ma <yu.ma@intel.com> wrote:
> >> Skip 2-levels searching via find_next_zero_bit() when there is free sl=
ot in the
> >> word contains next_fd, as:
> >> (1) next_fd indicates the lower bound for the first free fd.
> >> (2) There is fast path inside of find_next_zero_bit() when size<=3D64 =
to speed up
> >> searching.
> > this is stale -- now the fast path searches up to 64 fds in the lower b=
itmap
>
> Nope, this is still valid, as the searching size of the fast path inside
> of find_next_fd() is always 64, it will execute the fast path inside of
> find_next_zero_bit().
>
>
> >
> >> (3) After fdt is expanded (the bitmap size doubled for each time of ex=
pansion),
> >> it would never be shrunk. The search size increases but there are few =
open fds
> >> available here.
> >>
> >> This fast path is proposed by Mateusz Guzik <mjguzik@gmail.com>, and a=
greed by
> >> Jan Kara <jack@suse.cz>, which is more generic and scalable than previ=
ous
> >> versions.
> > I think this paragraph is droppable. You already got an ack from Jan
> > below, so stating he agrees with the patch is redundant. As for me I
> > don't think this warrants mentioning. Just remove it, perhaps
> > Christian will be willing to massage it by himself to avoid another
> > series posting.
>
> The idea of fast path for the word contains next_fd is from you,
> although this patch is small, I think it is reasonable to record here
> out of my respect. Appreciate for your guide and comments on this patch,
> I've learned a lot on the way of resolving problems :)
>
>
> Regards
>
> Yu
>
> >> And on top of patch 1 and 2, it improves pts/blogbench-1.1.0 read by
> >> 8% and write by 4% on Intel ICX 160 cores configuration with v6.10-rc7=
.
> >>
> >> Reviewed-by: Jan Kara <jack@suse.cz>
> >> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> >> Signed-off-by: Yu Ma <yu.ma@intel.com>
> >> ---
> >>   fs/file.c | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/fs/file.c b/fs/file.c
> >> index 1be2a5bcc7c4..729c07a4fc28 100644
> >> --- a/fs/file.c
> >> +++ b/fs/file.c
> >> @@ -491,6 +491,15 @@ static unsigned int find_next_fd(struct fdtable *=
fdt, unsigned int start)
> >>          unsigned int maxfd =3D fdt->max_fds; /* always multiple of BI=
TS_PER_LONG */
> >>          unsigned int maxbit =3D maxfd / BITS_PER_LONG;
> >>          unsigned int bitbit =3D start / BITS_PER_LONG;
> >> +       unsigned int bit;
> >> +
> >> +       /*
> >> +        * Try to avoid looking at the second level bitmap
> >> +        */
> >> +       bit =3D find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LO=
NG,
> >> +                                start & (BITS_PER_LONG - 1));
> >> +       if (bit < BITS_PER_LONG)
> >> +               return bit + bitbit * BITS_PER_LONG;
> >>
> >>          bitbit =3D find_next_zero_bit(fdt->full_fds_bits, maxbit, bit=
bit) * BITS_PER_LONG;
> >>          if (bitbit >=3D maxfd)
> >> --
> >> 2.43.0
> >>
> >



--=20
Mateusz Guzik <mjguzik gmail.com>

