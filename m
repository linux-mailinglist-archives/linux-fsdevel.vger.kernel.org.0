Return-Path: <linux-fsdevel+bounces-31799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E7199B217
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 10:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616E8283A0F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 08:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2BF145B27;
	Sat, 12 Oct 2024 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfuB1ZjN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5303213E8AE;
	Sat, 12 Oct 2024 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728721551; cv=none; b=Aq2CmCgSTN0o5UMqjfu2PaC6N+5qRh1aS5Py+9jWPlEZGVipZ3PXeqpoeRAVjX2Uzqnan39SaQwm57hV/rn4AXrG5ktzEVMeaD1T2/JWBvS9yt5x880ohTZcIq0MWy8KAskiHornzgFM1iGPaQIRb8c+9M3r4sMo17usS9e9m/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728721551; c=relaxed/simple;
	bh=Uqtgv825Ui6lPA/PApKlIy3gdFd1MxksJKPZBC08z7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhxhfBb8RzeeVfmsJF1ec6tbjeAMR6XvQUaPoRkBtHgzd/uBOEiZS0/ijLQl1fAR3g6uFVo8IiG6sApBhXTjmeDNyMyNgZR4O2W6sVYSSZ/5c+mRh9vE1ClkUohcdxI/8YZBY7tKkA05vKKapl+JJvSYV9KK3oZ8k+T6cXjz4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfuB1ZjN; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b10f298052so136335385a.1;
        Sat, 12 Oct 2024 01:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728721549; x=1729326349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCudyxXeifWUeK+v0Li6+olOqmfustgi7IrDgG7NJP0=;
        b=MfuB1ZjN1gsMn3aExbOo0lrZcY/YcR/pr1+7QmKnC5xSUVx6YYHnVAKW0DeEyf/8B4
         8Tf14PRfbrmwUgK6Alav+hxydaB4+vCXVF+tohibZlRP3fJ43HgNn5KS+JGQGEivRwCr
         oeauxbPVl/XhBcMyboeXntgYjIMBUwe3CSfbVVyZhDi0PD8kNDR0uKqrZJuc+XsHbG+A
         PkSe+DjwVU/9B8/G2plFj7mD/aU/zQor9dfGf3cwKDLBT+rZDGOdsLR6hWVl0v0Z5iFv
         ywzLUdcJPZuqhnV9DWNEwYP1KXWsLIc3gOgY3ezYycDu4NOHbJBf6A8wyeqyhdy1XBxp
         wRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728721549; x=1729326349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCudyxXeifWUeK+v0Li6+olOqmfustgi7IrDgG7NJP0=;
        b=jchExq9wsMJyPIjhenLlWICD7CywXbDEtlBziAm+d8ub5E3oRK+9GklKZPfpWP2Qn4
         3b7U4E0k9rN8SgQbfkj6/i8Qcdfie0Yb+XShguqJASyASHfGfPv7O42FRc5ZXUFd2iIq
         Sj5ZbTrEjLah+H8TJBmd7w0MzaYasavfTyuR2nK+ndoWs3cPx/Tt8BMCDD6BUJK3rOCX
         zlS+II0PqJUnx7f6AGwnpJMI793hVBCmTTbeqtBFYvuSLWS2I8/x7223LRB8Qjj5co2d
         +wJsqh1C1be/vMrbFEzNUDaF8gnBCcpWCG/KbVKQpPF9a6TB32EdHHxsfRmURuRIciLF
         Zknw==
X-Forwarded-Encrypted: i=1; AJvYcCUCOq6Le/Q98MQCbysHT79bZyJgCK6vCrjkjJdF2DicvSKHin6aqyfiPUT/f1ITHaOlJg39qx+/IMbKdMWJSg==@vger.kernel.org, AJvYcCXp3kyNZ/SCf/OhMmtRw0TSQjdhTqjxRwd7C31FnL9p7suMmAkezh7LAlNOKrb0zZjR8jXPIuTtWnXWi5nB@vger.kernel.org
X-Gm-Message-State: AOJu0YyyN9zv4tRsynsoXgfUHQQtRGarlzc9ojYewfZmI/LuVPTofdMg
	Qn3fEkoaVv8uHNiGmH5OLbCR8L+ZVTVaQthXxei0W5yU6unceANwPbnXOiZcG82egjzu17TPW/E
	YWsCaEjZ8d2cvOw4SMujnRij3r1I=
X-Google-Smtp-Source: AGHT+IHxVbejksjkiJ4bu5X2Ujh1lTVoUGRd+56TnkwW6xTiLkIucqmZ/ltp7xCCNHFuo2XUINNMW+1Qag84iz0XD6Y=
X-Received: by 2002:a05:620a:46a6:b0:7ac:b1b1:e730 with SMTP id
 af79cd13be357-7b11a3b8e7dmr864974785a.61.1728721549070; Sat, 12 Oct 2024
 01:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org> <20241011-work-overlayfs-v2-2-1b43328c5a31@kernel.org>
In-Reply-To: <20241011-work-overlayfs-v2-2-1b43328c5a31@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 12 Oct 2024 10:25:38 +0200
Message-ID: <CAOQ4uxhhReggva_knvfTfCW4VzgiBo7w3wLMEsp7eLy36cPcfQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/4] ovl: specify layers via file descriptors
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:46=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>

nit: if you can avoid using the exact same title for the cover letter and
a patch that would be nice (gmail client collapses them together).

> Currently overlayfs only allows specifying layers through path names.
> This is inconvenient for users such as systemd that want to assemble an
> overlayfs mount purely based on file descriptors.
>
> This enables user to specify both:
>
>     fsconfig(fd_overlay, FSCONFIG_SET_FD, "upperdir+", NULL, fd_upper);
>     fsconfig(fd_overlay, FSCONFIG_SET_FD, "workdir+",  NULL, fd_work);
>     fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower1);
>     fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower2);
>
> in addition to:
>
>     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "upperdir+", "/upper",  0);
>     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "workdir+",  "/work",   0);
>     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower1", 0);
>     fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower2", 0);
>

Please add a minimal example with FSCONFIG_SET_FD to overlayfs.rst.
I am not looking for a user manual, just one example to complement the
FSCONFIG_SET_STRING examples.

I don't mind adding config types on a per need basis, but out of curiosity
do you think the need will arise to support FSCONFIG_SET_PATH{,_EMPTY}
in the future? It is going to be any more challenging than just adding
support for
just FSCONFIG_SET_FD?

Again, not asking you to do extra work for a feature that no user asked for=
.

Other than that, it looks very nice and useful.

Thanks,
Amir.

