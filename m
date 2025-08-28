Return-Path: <linux-fsdevel+bounces-59481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45755B39B1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 13:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5922C5E42D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973530E0EE;
	Thu, 28 Aug 2025 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQI3fiaC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225430DED4;
	Thu, 28 Aug 2025 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379400; cv=none; b=Ij8Zsrk296rxVcnudF/Zq8U5o2qefFRm/wX9UUOvJ/s5q27ZDpXWnKJsnKpb9Wk3h9sFZz6WhqqdnvInlm1MpzQrNREgdXrIiuRnEPMk2VX1+Ei6wtcVgZ/7/Gdg0VVPnAfx9xnYiJrFY+hR2TosaPQaPJs9Xuu7Uk2fDI4Hzug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379400; c=relaxed/simple;
	bh=KbadNcxP5osgPNJ916tqsjhiCeuLdKnOXZ/DZcCPh6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=filfBRXE6qzflOZOnWVWgWx3Fcv8F50HCKyPA3OluTcHIFo/c7+dOPblPNlMGXOHp3eYkUEqA/Kldn1s57kmgJXR3UJ2FNFNeuRaWX1F889baxUc0jlilv+ztfdIUFFUUqUDVAz8n0HYeWEIHWd8PIjmuQn9qLIPQp97QoRp6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQI3fiaC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b5b113eso1167109a12.0;
        Thu, 28 Aug 2025 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756379397; x=1756984197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTJn82fGv97R6pKuJB3qgm/cCb3gKGUlBejozlfzof0=;
        b=iQI3fiaCw0ShUH0xAnHe0yUzlfwSOyBYhZVMC62iY8elKSk1vAZK4DIu+Oih/0RMqe
         7HzTFyHmOMCsniqWDZLhytoLznwhj+W8aAf22ok9AkQKSX6lhHymF64CVaOCbCdo97u2
         aVIQUuCRW6tjgUoUueRan+FTVxPlZLe1esjDp+o5JvxVfwX0wP/zPM6kTYhB/LVQnJhm
         eJGkD40laATNjdF0eyyZhQ5H7zQ2BiQJui3+5KPg3c2q+jvDn0z8u0El8qBrlGTwEgpt
         Quiu513hHfxrQtNd6H3zNT+l+CM7M/UNQIB2x4NM+ft2gQHIvKpB2uFzOjs3HyZZpcu0
         Exhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756379397; x=1756984197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTJn82fGv97R6pKuJB3qgm/cCb3gKGUlBejozlfzof0=;
        b=UgEU0cyVpliMNip1+qaBUqNI5G6Ej1/fZNKEMb/+JSsMl8N0uuFsmwLpq9EwnHhhrW
         V6DDCQfxJLYs8cJTWW24FHIt/1fkmKhLMy8TnjOm+9oFTrBEWHvQ2Zx3ktWZ8PcdPaGE
         Dg+V3MPtl5k+sA+ouoM6Xemil5nBTYmhEpo2cjYbmlux74yJPVkkH6nn4kwLxmFuozr0
         5Xw6ZabP67H3N4ibMLcT9fANYAbM6KUfwqaUpNIZm3oXFY4Lag0htcULiXWD7xYXilXz
         WRVfY+5w5xdGoJbufNLBzNdi0NJWwyscmvbMHMwXSOSFOc5s3Ge99pDgS7W/huQQaLsB
         7vcg==
X-Forwarded-Encrypted: i=1; AJvYcCVCjUA+6DgTwrRkh0poCuSNaLU5/zuuiYCxUc98YQGLq53vBrQoqnX70JIlXmIKrnpb0F9aA7GK3cy7n6HKOw==@vger.kernel.org, AJvYcCWD15gpruivpCYfx3kPqk4KJ+OaPYpBkSNKCyMl/MxkVDuVzq8X9EI0IJWay5y44duM3p0nUerNigcc8DbG@vger.kernel.org, AJvYcCX8qF645b8r1gOPjQmBVOQYyUFMJ3NDbLzZbWsBbWwwKf7QDwmOPnBtxV5Wj4vmBGSey6Fwfy3p2hRU0Kjp@vger.kernel.org
X-Gm-Message-State: AOJu0YyLNExor0XWjkw7bK7gvZRylyIKM0uef+N8mU8gS5MR9kvgbi6z
	xsf9Vcly4rbH7BV7KD9vzM+RpSqLkyITGGNKRCjfrsKvsszjJuaLUUqWK1dpJo8byLDU2FtqQE8
	iKatATNN+a5WaXtvp9gjREfuNRuoWELI=
X-Gm-Gg: ASbGncuGObsNpNKzrT+Z1u9TC63VnUrTjQNdyGEiAq795g3WecO7kHD6IubpSkXYMge
	Cs1zmBTpWL6iFUiv1zym3GGHVNglrdeobtyWyqRrQHUKnyJL77uuSaDTPPNN+yVZ5OKPlaq12Y4
	yWUW29WtY01Vb0JQO2tYTa82pFFp9kR4F+nfTuFrITA4xTFj8Un4yCH1N+XVadFVUMSdh8Bsqd/
	nAm4cmbQoZfryJdXMxWB+bzNyx3xdQ=
X-Google-Smtp-Source: AGHT+IGAlOpb/TgboDVnZGRXFaH8l0WVR3/ATIyywFOq6U6FrHIdPrYHpZq+YOedqYOCse3cERNtiDScweWHEygiz94=
X-Received: by 2002:a05:6402:354c:b0:61c:9a23:fe9e with SMTP id
 4fb4d7f45d1cf-61c9a23feabmr6503581a12.14.1756379396745; Thu, 28 Aug 2025
 04:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com> <875xeb64ks.fsf@mailhost.krisman.be>
 <CAOQ4uxiHQx=_d_22RBUvr9FSbtF-+DJMnoRi0QnODXRR=c47gA@mail.gmail.com>
 <CAOQ4uxgaefXzkjpHgjL0AZrOn_ZMP=b1TKp-KDh53q-4borUZw@mail.gmail.com>
 <871poz4983.fsf@mailhost.krisman.be> <87plci3lxw.fsf@mailhost.krisman.be>
 <CAOQ4uxhw26Tf6LMP1fkH=bTD_LXEkUJ1soWwW+BrgoePsuzVww@mail.gmail.com> <37e714a7-ee0e-42e0-af7e-34c6b6503cfa@igalia.com>
In-Reply-To: <37e714a7-ee0e-42e0-af7e-34c6b6503cfa@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 Aug 2025 13:09:44 +0200
X-Gm-Features: Ac12FXz-qeQDguVhS2q0tMsaSTObyaEmZEDwWkPjgJBDVblrGLRoNoUyVCv9NMU
Message-ID: <CAOQ4uxgtoJk4CWfVEpXQ7p7Qoh6E_XCammcDP2F_vjgDVit0ZA@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded strncmp()
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 10:45=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
> Em 26/08/2025 04:19, Amir Goldstein escreveu:
> >
> > Andre,
> >
> > Just noticed this is a bug, should have been if (*dst), but anyway foll=
owing
> > Gabriel's comments I have made this change in my tree (pending more
> > strict related changes):
> >
> > static int ovl_casefold(struct ovl_readdir_data *rdd, const char *str, =
int len,
> >                          char **dst)
> > {
> >          const struct qstr qstr =3D { .name =3D str, .len =3D len };
> >          char *cf_name;
> >          int cf_len;
> >
> >          if (!IS_ENABLED(CONFIG_UNICODE) || !rdd->map || is_dot_dotdot(=
str, len))
> >                  return 0;
> >
> >          cf_name =3D kmalloc(NAME_MAX, GFP_KERNEL);
> >          if (!cf_name) {
> >                  rdd->err =3D -ENOMEM;
> >                  return -ENOMEM;
> >          }
> >
> >          cf_len =3D utf8_casefold(rdd->map, &qstr, *dst, NAME_MAX);
>
> The third argument here should be cf_name, not *dst anymore.

oops. fixed in my tree.

Thanks,
Amir.

