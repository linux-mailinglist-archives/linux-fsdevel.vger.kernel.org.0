Return-Path: <linux-fsdevel+bounces-31798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4D799B20D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 10:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E831F2225F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 08:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC7814601C;
	Sat, 12 Oct 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITQ5biE+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12313142900;
	Sat, 12 Oct 2024 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728721220; cv=none; b=IIYk6T+UiWmTeM5qq9j6HCA4p2VtwqtXfyXAhnX4CH3L3cY8AylF+bi4EYpOCLZKfW7DNPsjyuVvlua+RpY3i/O1Vt3/ytimGBYfKv3BacrF0O08BnDOIX27YecvOBTJ5vSdaxm1tGTPkyYGopHUXQM2XtjXKUdF6aZC8S8KjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728721220; c=relaxed/simple;
	bh=Ww84bv8TwvRAQqWns87DxxaJG7I4nX1LpT5WPrYsbnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aszJ40tjMKs6ZoWS5tDdOxMBLMibPs/5g2GmnDl6P4/P6Iu5HSGpDPOUdhIyMYslasXbD3rKtewAd5/ssuLF2kk2lIQMjv3eHwnnSSBUvhrnGq2tHge15KrBzs3x6oNDoYYj2s8vhJJ88Xiet7x4KhEcIFHif4K9XLs79QiPj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITQ5biE+; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b1109e80f8so200893585a.0;
        Sat, 12 Oct 2024 01:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728721216; x=1729326016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASZJRHRzd12aR30xXKPDvjFpyvj535/6nPbl6M9mdx0=;
        b=ITQ5biE+k+cL2xr2v92Fd9+GWxFy95nUxRfnSRvMjpexCIcLnrzfV+Oh0vKGlqHbn3
         A1v+UgAKREfJcejhJoxpvtXC1m40Jq5h+PtxooPWWugm4zfN2hyoZirfVhs+S7vUBq/A
         I6QLBux8E8a+DDMtEYQzt8vwgfVNCAifNDWCqtPq05BrQ/clC0IRJ78MX2gJMfXDXmK9
         tYA66GjVcj4gh+H6ipj0IcpJ8EEQzlyZDKoHbWY5zM5752w/SW1pohFkh8V36v2Tygh4
         7g5XkLCC9df4nWwqJHyP4jzM0I7w08wN5mncF+/qvxJv0FauQLP52lCIGunXEWFGeJaX
         6y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728721216; x=1729326016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASZJRHRzd12aR30xXKPDvjFpyvj535/6nPbl6M9mdx0=;
        b=LVqWAKBjinJ4b03Bs/q1lhtr6QeZ9HCmjlowXfMGiEtmRKammp0wnof5PvDgksgLjQ
         UB+AR/HpswoonRkt0G9G53SJshtGbmULLvt/GFWAs5btlwxtw2ihPEeCYpvy0NuhPmn+
         dl2gv0QF+NfzvYeBWm1aqijB86+SDK8GPkApidhCe/CPIvS0AKxXpS+nwvJgwzlvDnFr
         ZRiBTJGfY/DquIHBN/Y52QelMLHkVz1HkaNJcJ8+vNsMHfquU659/EQ9mvHzEU9IH2V9
         oVXxr3XhUMtN21sY9UHw4Y6hngDEURYQ6CJvQ+ZtHrb9U2dHexTt7Bq1gCPKwlmAylrX
         nqpA==
X-Forwarded-Encrypted: i=1; AJvYcCV+RIATRx1EwDVnqrGX8EiRj3Hvzs3d8X45+wPEKyw0aigNa19RunkaTU3tqifv34PHhdYmK/oaw5njO5G5eg==@vger.kernel.org, AJvYcCVDkuwWdfWvm1AMce70Qhp5OmPraW73OYu2eXNdpL1N6q/O8k8uZF0fS7L3HmYxN3tEvGg17zWnnE2oIPgE@vger.kernel.org
X-Gm-Message-State: AOJu0YwxO6XPy2XlNMctbHqe/BhEsUezvWXZ6J7kUakciFGzvpdvxod0
	ZibEbz0N24LG2G6L/cVTTGZAipWNav5ViEb8NKP8vL0/05Zfv7UZveV1V5uBaE3DfdbkpO5H63w
	jIeZws2XDp8pbzFa9e7A2aHGRsZ0=
X-Google-Smtp-Source: AGHT+IGfanhdNAr1SPYoWqfhlK5/UssFSi6yPJh69laXkRLonyXhrbG1BQhd63wKOPQjlnMtEBPn1u4BYL4cpRYulF8=
X-Received: by 2002:a05:620a:1aaa:b0:7a9:a744:f989 with SMTP id
 af79cd13be357-7b1210080d5mr333012185a.46.1728721215807; Sat, 12 Oct 2024
 01:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
 <20241011-work-overlayfs-v2-1-1b43328c5a31@kernel.org> <CAOQ4uxgGiXN-X1KbZZT=pnbhRbUSPNUJscVHn9J=Fii6fZs-cw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgGiXN-X1KbZZT=pnbhRbUSPNUJscVHn9J=Fii6fZs-cw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 12 Oct 2024 10:20:04 +0200
Message-ID: <CAOQ4uxi2K=RHBCv+f9B5M5=FjWkCOa1U5GKFCm8XVZpXkeP_UA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/4] fs: add helper to use mount option as path or fd
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 9:21=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, Oct 11, 2024 at 11:46=E2=80=AFPM Christian Brauner <brauner@kerne=
l.org> wrote:
> >
> > Allow filesystems to use a mount option either as a
> > path or a file descriptor.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
>
> Looks sane
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> > ---
> >  fs/fs_parser.c            | 19 +++++++++++++++++++
> >  include/linux/fs_parser.h |  5 ++++-
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> > index 24727ec34e5aa434364e87879cccf9fe1ec19d37..a017415d8d6bc91608ece5d=
42fa4bea26e47456b 100644
> > --- a/fs/fs_parser.c
> > +++ b/fs/fs_parser.c
> > @@ -308,6 +308,25 @@ int fs_param_is_fd(struct p_log *log, const struct=
 fs_parameter_spec *p,
> >  }
> >  EXPORT_SYMBOL(fs_param_is_fd);
> >
> > +int fs_param_is_fd_or_path(struct p_log *log, const struct fs_paramete=
r_spec *p,
> > +                          struct fs_parameter *param,
> > +                          struct fs_parse_result *result)
> > +{
> > +       switch (param->type) {
> > +       case fs_value_is_string:
> > +               return fs_param_is_string(log, p, param, result);
> > +       case fs_value_is_file:
> > +               result->uint_32 =3D param->dirfd;
> > +               if (result->uint_32 <=3D INT_MAX)
> > +                       return 0;
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +       return fs_param_bad_value(log, param);
> > +}
> > +EXPORT_SYMBOL(fs_param_is_fd_or_path);
> > +

I just noticed that it is a little weird that fsparam_is_fd() accepts a num=
eric
string while fsparam_is_fd_or_path() does not.
Not to mention that fsparam_is_fd_or_path does not accept type filename.

Obviously a helper name fs_param_is_file_or_string() wouldn't have
raised those questions.
I will let you decide if this is something to worry about.

Thanks,
Amir.

