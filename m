Return-Path: <linux-fsdevel+bounces-23037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74A9926332
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248A61C233AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B2117C7AA;
	Wed,  3 Jul 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV5S2IWc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C6177980;
	Wed,  3 Jul 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016238; cv=none; b=pvMYySfQXhAkgo5AjGqBVJy8uObmqBjb+2mGGGtOSZxjrwWHLNYRZYthhijbrh/UI6jz6y7qko7Bn8HaToeTwFnP+AD1lOyERrfOpWPtsMFDANxkXjMZ8HFpIarMrtAlUJ29x1ORCHAAnrwd/9ivpLwKQ/AFhSLilM6XVoHDYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016238; c=relaxed/simple;
	bh=YOtEnpbAo8NExKuGIzIbRGxUNo536AZi2Dk1xY8zYZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juWF+E87pU8fH5d9EltFbmKaRwCzVSjhSU6wWRsbGJJSGDsBOpXJImAdtMekvWBAMF5eE7nMafzDCAynl5xlJ1IEfLxc4cTXVAVesSrjbkR/G50yAzU0GG05wvBdF3ahp1SBtb7pD0JyzntZgCSP2n9ZuEyuDhO8YWhfGDqxTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV5S2IWc; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so3924554a12.1;
        Wed, 03 Jul 2024 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720016235; x=1720621035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BQrfEzxPNRTRt+VVxHgrXsFxplM3fveQqZGfKVIAN0=;
        b=BV5S2IWcd+AuIsUI/kctpxCojs+10pCaQIPxaAQ5SZ02MeByEHAXiInQF29Fk/W4hc
         WrhX1Uq119CDonVwVzT0HIy+YOmy2GuN0JZJjxpvKDelTdD1z5vv/dqRl59rEDyoKhay
         BPK+sSrC1QC3MNk8TvOiOjCHm1yMP+8ljpgnkAKI94ynZ+vCTXe2M+iDToN2yJxhsbDJ
         t5pnOSEnT1nGnwHnGP1KmDZRGGWUrJ/UwcgbT/uTLGYPwZw+fkVvkLlGIsTfLu9IT+L1
         YdLKLRmuewdM+vobTIU+oXQkiNikD3lKeThQ4P9nJmHTDZaLy/PhI6N2kKtd6Tqjiy5w
         chMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720016235; x=1720621035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BQrfEzxPNRTRt+VVxHgrXsFxplM3fveQqZGfKVIAN0=;
        b=qanmwSgPxlfdysK+gZ/So4O/vKhNWJcUXHU8Zgt5QrsDMakGhCP8JJcg3NVg5MpqKx
         FDy7i95/3SNgwyNLtmeBVEpuVnQC3ELdpYDAFWguwRSZUACuQr6BxySygEWLeiE84/HL
         SNEtEL7rsc6Wr2U0xK0zhLeILpFNNTBPAbjITr54AGvmFpwyHyNHT8oTYQq0zuTDnkUj
         +99eBlL3L8W8/YDBgQI7SSoks7XWBZlsJf+8uetLAa/YQ35icVprtomkup0Pf2za1z8N
         fmL0gH8IfDuBpn7UVQAWuEVs0LlzPFH3o3/U4MEUvtwFPyfIHfqjAo8nE+AtHNE1NjNi
         lIvA==
X-Forwarded-Encrypted: i=1; AJvYcCUlS8x9J+odubBBQtLzCVtwsdtswFhxsdPvoiz0eg1HOFt9XgmQ0JzGJ/LzrnOOODE2xnce8AVvC+SlnT+IpwWQ+hzcWA/xWY9p+MWxysnAYC+t5LifbjsNkvcDpLvDrwSFJJWecVEQeY6ZxQ==
X-Gm-Message-State: AOJu0YxmrY62GpBpckYX/kBwmo+3AC/UYeYvqjr2W88h9OkeVd9nJcnZ
	synAtEoN5+x0qHiv3lFMUiHQJZfpbktKkx6EBy25Tsm1rrczvE0zrnkGD4oiRHmMGZZzwKXHjIw
	Eqo3PqCl+DWYmXwg4qYpAMI5DFdQ=
X-Google-Smtp-Source: AGHT+IEOGny2bm3IXPyTOETnvE8CxQWGikfadV7NWbNnDPwFylRSVaOUtzljKmrHgGxfWNhLBGozaWTfuk38wb+L6GQ=
X-Received: by 2002:a05:6402:5253:b0:58c:1af:bb67 with SMTP id
 4fb4d7f45d1cf-58c01afbbf6mr2548281a12.41.1720016234569; Wed, 03 Jul 2024
 07:17:14 -0700 (PDT)
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
Date: Wed, 3 Jul 2024 16:17:01 +0200
Message-ID: <CAGudoHEcb3g16O1daqGdViHoPEnEC7iJ-Z2B+ZC9JA9LucimDA@mail.gmail.com>
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

The rest of the patchset looks good on cursory read.

As for this one, the suggestion was to make it work across the entire range=
.

Today I wont have time to write and test what we proposed, but will
probably find some time tomorrow. Perhaps Jan will do the needful(tm)
in the meantime.

That said, please stay tuned for a patch. :)

>         unsigned int maxfd =3D fdt->max_fds; /* always multiple of BITS_P=
ER_LONG */
>         unsigned int maxbit =3D maxfd / BITS_PER_LONG;
>         unsigned int bitbit =3D start / BITS_PER_LONG;
> --
> 2.43.0
>


--=20
Mateusz Guzik <mjguzik gmail.com>

