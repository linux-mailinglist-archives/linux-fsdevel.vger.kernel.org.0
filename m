Return-Path: <linux-fsdevel+bounces-7415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEF48248F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 20:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6F728297F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 19:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514192C1B2;
	Thu,  4 Jan 2024 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDfn5vH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464EF2C681;
	Thu,  4 Jan 2024 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e766937ddso992942e87.3;
        Thu, 04 Jan 2024 11:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704396222; x=1705001022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PngtyanlhICbee0KDi7iQcNT635NIWO7h/ak7+PfeDI=;
        b=WDfn5vH0dCPxT+yHZPZRDI8TeRvTVuB8Q8agL3+kLUfzwyaj+4KJYgQPbVbQa0PPTT
         du0i4R9Pe4sIVEte5zDHJxPoxakjAy5WZ5cVk8MAKgg9SlFIANu+DIwSuOoQNm84wSQ+
         t9CXQbVDrbCLqX7OZm0Zzb79uAunUwVCk1qtLCxGgYnQhvrBHqkVyRLiBgNQcSGfc82F
         MsfL91I0rOYGJT33v7zOF7BIGk4u+VanQLt3Y/SDY80QypE9p9pZT2oUoeYzWCWe9WKH
         gMLzDlrkVnvxgn5LORQGS41Wesln08/NgCD4XFnWptacThrSuQwi+a5knoVPG38wmkV7
         GTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396222; x=1705001022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PngtyanlhICbee0KDi7iQcNT635NIWO7h/ak7+PfeDI=;
        b=UvpLNdN+fE1/lmQRxMm7fyZv2YZFPJ+Vby8JMhMmM6ShEnTTngX6HwmUZyJXquyJk3
         1K1Uh5Fc5rmmH1zzeInbwjF1jLpefo9pb7bwd4GEwGnZWPPGLuP6dYJjqfBzhEuykgpH
         ehLYpAuN2fssiURVwP7uEx9kCTgK+Zz7ykhgL/iP//FCF6I4Ovhvl6PsHbBatOk+Szl7
         GmmeC4OTo5AgmOCLCoq/bnuexklhg/CzBmdCLpNKXWd38Z2u7AVxUdXv1zRKO9OHgWAN
         VnyIwD1nXzr0fbEJ/H156kS524LkO36Pfv6pMQfLePgXgzUM3zgAGaB/sfbFDQYlFT2l
         OWKQ==
X-Gm-Message-State: AOJu0Yz3B8BOjTZAIIYB0NRuU7ACCN0AFakv9HDL7PaqJRRBEOt+32X1
	8lEIXapsYN/kh9ph0dKFdVtjgqbdjP3rjrtaEOo=
X-Google-Smtp-Source: AGHT+IG9T0FiiGPu67lzYqzONX+bAfLTPv2+2J1Ro6tvLQzWP52DQMpQdQrscwBC6Mh60CduZkVGLdcqkX7/FVHUKQo=
X-Received: by 2002:a05:6512:14b:b0:50e:71d4:a37f with SMTP id
 m11-20020a056512014b00b0050e71d4a37fmr556963lfo.55.1704396221935; Thu, 04 Jan
 2024 11:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-14-andrii@kernel.org>
 <CAHk-=whDxm+nqu0=7TNJ9XJq=hNuO5QsV7+=PTYt+Ykvz51yQg@mail.gmail.com>
In-Reply-To: <CAHk-=whDxm+nqu0=7TNJ9XJq=hNuO5QsV7+=PTYt+Ykvz51yQg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Jan 2024 11:23:30 -0800
Message-ID: <CAEf4BzY6gx+kYmKju+EOtz2MgDa_Ryv+_DSmhtJQRoYvp=DtfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 13/29] libbpf: add BPF token support to
 bpf_map_create() API
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 11:04=E2=80=AFAM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Wed, 3 Jan 2024 at 14:24, Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Add ability to provide token_fd for BPF_MAP_CREATE command through
> > bpf_map_create() API.
>
> I'll try to look through the series later, but this email was marked
> as spam for me.

Great, thanks for taking a look!

>
> And it seems to be due to all your emails failing DMARC, even though
> the others came through:
>
>        dmarc=3Dfail (p=3DNONE sp=3DNONE dis=3DNONE) header.from=3Dkernel.=
org
>
> there's no DKIM signature at all, looks like you never went through
> the kernel.org smtp servers.

Yep, thanks for flagging, I guess I'll need to go read Konstantin's
instructions and adjust my git send-email workflow.

>
>              Linus

