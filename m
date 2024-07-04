Return-Path: <linux-fsdevel+bounces-23149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87865927C76
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 19:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2AEB24D38
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86E64D112;
	Thu,  4 Jul 2024 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1Uf2aDr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1334962A;
	Thu,  4 Jul 2024 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115067; cv=none; b=iXFEQ44KXHHIah2m92LKlxyQAl7IdOUe1fPoNhDNf6BdRQ64+LcXeI0ufOG/vkGsIBAOzPVU21S7ANieubAW0F6O15yJQXisn5Nch+MLHYEj8tmqYSM9EIYsZMPR7gV0N4SfvNxZS8yKOq5OPmMaQ60sSEnVrQFnx1KKBmaWCKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115067; c=relaxed/simple;
	bh=9OEohVoOHp7ONwqat1DbjfbKll05SHnUm4vHkbNilOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDpdOUGay2T8gkqOr2+DdYkhDrqUUj4uZgCYJUc/lUw5mWRHKNr5px0AsACSBCqWnbrvUqGKq+nI8FoXR/BWrVbuWIvBZnYjM3RFfO+jLLuMWIlIuALgXfoagv6YhwPuN9kia4jR4/x2MB5f9T2ODQ770p23IVIl07OJnPKfCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1Uf2aDr; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so1061980a12.3;
        Thu, 04 Jul 2024 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115064; x=1720719864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/ICCxXD8DFSBJSvnIefNzr4Mlp1WXZIIEXOl9gBP5Q=;
        b=H1Uf2aDr/h+TCokntzQJQGt/3TgUnHe56M2RLn38MOiwUE4IWH5vbn+2cJNJVItK+s
         1a54Fiy29UOiKGNs7z53Vxd2nXl5zryh6BFOzYHBjfhHMmB9frBEsHrsqIQOxjIA23s8
         dC/lQnnlFtZJmRlzUX1c8EBeGCykQk7Wy8YgzS1aA7fPY3ecjWWNRtWwLFj1Lo64C7xf
         PJpVH+waXlNKkkGbJISka2qNEJuE4P+k2PO8E1jjCaSyxS5yi7NQrSpMnY6qMVDm5+s3
         RgOK7aPTgRRk6y6kBtS/t5y6hGiYlBh3lXDRStu7qmmQW6gbVsee5kcD5cjaEgz4FTiH
         RHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115064; x=1720719864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/ICCxXD8DFSBJSvnIefNzr4Mlp1WXZIIEXOl9gBP5Q=;
        b=LuUdszaDKj4aZu7apYtRhQMbUeO2quE2bNMHCDWNNVyHC0l2dMySSRuR+Z3SUWSn1F
         Wb4N3olvrmbVJkPpWwlHt5ZAkWiYxVWiOKiiVzgZHKgbm0i2Zu9tGia0Gu7q4dRoHwvU
         avRZ9xGotsQdcJHmIueqEs1hYz1+1c8OaYG8d1rNCGs1L0kH+X+Zfn/TqEmN91dCZZvR
         9cVGqjw6nFN/kfxP8AiCkhZgKlMrohyoTHvvFOt1PHzKLmtRqozJ6Lqc3WiVHOyem4iQ
         RjAXXwwWCqTBLHpR2iZtX175yWMAIDmxzxVceSeE+u9gVT5WJ7omuTXzv7hdvZgIQlA6
         2Njw==
X-Forwarded-Encrypted: i=1; AJvYcCWhfIlrsKbKLCwLjXmxtHhHRp0IKaVSShRAba/dCWmt1M5LKlklCeDvtwuGWJh9IkInabcn5QhPWZISD5QD405uGm8ll9aKJKGzqOqkNw1fPlCfq+0gBsE7/6By7DXpzskOiaeq4WLY1PB2xA==
X-Gm-Message-State: AOJu0Yz9+NBtp2C+psSpunTcX3JPfqkLv+S6fFHwXx+h+KkrIrR8+sgl
	2yR/dJ602pomt3l5fd7x7CY+xZ9nfHfAbRGN0asQ4MdcsbHchMHaON0HZhtDHA7rt720taSFHok
	W7lSeBDnwVAn7LeIL5btIX1YYSPaTMXQELik=
X-Google-Smtp-Source: AGHT+IFVorgdyabSVYQdv+WoEM+LSfcE2ygWrtpA1sx7rpmpEZto/8sJYdffCwq4xoaYmYhuE62OetDh63Qm/FMKct4=
X-Received: by 2002:a05:6402:2108:b0:57c:fda3:b669 with SMTP id
 4fb4d7f45d1cf-58e5abdd399mr1523307a12.17.1720115063714; Thu, 04 Jul 2024
 10:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614163416.728752-1-yu.ma@intel.com> <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-4-yu.ma@intel.com>
In-Reply-To: <20240703143311.2184454-4-yu.ma@intel.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 4 Jul 2024 19:44:10 +0200
Message-ID: <CAGudoHH_P4LGaVN1N4j8FNTH_eDm3SDL7azMc25+HY2_XgjvJQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs/file.c: add fast path in find_next_fd()
To: Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	edumazet@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com, 
	tim.c.chen@intel.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 4:07=E2=80=AFPM Yu Ma <yu.ma@intel.com> wrote:
>
> There is available fd in the lower 64 bits of open_fds bitmap for most ca=
ses
> when we look for an available fd slot. Skip 2-levels searching via
> find_next_zero_bit() for this common fast path.
>
> Look directly for an open bit in the lower 64 bits of open_fds bitmap whe=
n a
> free slot is available there, as:
> (1) The fd allocation algorithm would always allocate fd from small to la=
rge.
> Lower bits in open_fds bitmap would be used much more frequently than hig=
her
> bits.
> (2) After fdt is expanded (the bitmap size doubled for each time of expan=
sion),
> it would never be shrunk. The search size increases but there are few ope=
n fds
> available here.
> (3) There is fast path inside of find_next_zero_bit() when size<=3D64 to =
speed up
> searching.
>
> As suggested by Mateusz Guzik <mjguzik gmail.com> and Jan Kara <jack@suse=
.cz>,
> update the fast path from alloc_fd() to find_next_fd(). With which, on to=
p of
> patch 1 and 2, pts/blogbench-1.1.0 read is improved by 13% and write by 7=
% on
> Intel ICX 160 cores configuration with v6.10-rc6.
>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>
> ---
>  fs/file.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/file.c b/fs/file.c
> index a15317db3119..f25eca311f51 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -488,6 +488,11 @@ struct files_struct init_files =3D {
>
>  static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start=
)
>  {
> +       unsigned int bit;
> +       bit =3D find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, start);
> +       if (bit < BITS_PER_LONG)
> +               return bit;
> +
>         unsigned int maxfd =3D fdt->max_fds; /* always multiple of BITS_P=
ER_LONG */
>         unsigned int maxbit =3D maxfd / BITS_PER_LONG;
>         unsigned int bitbit =3D start / BITS_PER_LONG;
> --
> 2.43.0
>

I had something like this in mind:
diff --git a/fs/file.c b/fs/file.c
index a3b72aa64f11..4d3307e39db7 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -489,6 +489,16 @@ static unsigned int find_next_fd(struct fdtable
*fdt, unsigned int start)
        unsigned int maxfd =3D fdt->max_fds; /* always multiple of
BITS_PER_LONG */
        unsigned int maxbit =3D maxfd / BITS_PER_LONG;
        unsigned int bitbit =3D start / BITS_PER_LONG;
+       unsigned int bit;
+
+       /*
+        * Try to avoid looking at the second level map.
+        */
+       bit =3D find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
+                               start & (BITS_PER_LONG - 1));
+       if (bit < BITS_PER_LONG) {
+               return bit + bitbit * BITS_PER_LONG;
+       }

        bitbit =3D find_next_zero_bit(fdt->full_fds_bits, maxbit,
bitbit) * BITS_PER_LONG;
        if (bitbit >=3D maxfd)

can you please test it out. I expect it to provide a tiny improvement
over your patch.

--=20
Mateusz Guzik <mjguzik gmail.com>

