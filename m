Return-Path: <linux-fsdevel+bounces-23642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412B493070D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 20:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720791C215D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDEA13DDC2;
	Sat, 13 Jul 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFbS5E5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE525779;
	Sat, 13 Jul 2024 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720896033; cv=none; b=ecoCJbb+Sx2lRc+J50kp2bCww+qaZXeyoVnCmgNtFQ2P5d1FRL1WEV0eQ/Uq4ulb5cYN3JFK6P0hkyHvxL9LwAKmEqoP/1N3riq0+tG7N10EfvzvyU0UvRy1WB3+nbhVtDTmOv8ZEuvrV7KKk+FAcpaAeyxw7XVZPQ+lVBIc2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720896033; c=relaxed/simple;
	bh=dJr9PzS4Pt+E8PPQtjL9nD561bxeMGGRaBv66cc1FO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orc96MqbSEKDqTJYCcqKf6/L51NlrHrrT+mqJQ4wqoMfM1Gj5O7tvEVh2CSOiGlpq6MjkON4hUlHp/Vbab/1zaNs43qI7ZlFMbqT0j2IAy2Fkb57SXeyQ99goapNfAae2Kn4XzpySkky+qTl/qxnHLBhvu11nl+VRzr0Fg9+Bu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFbS5E5d; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8100ff1cec5so1037225241.3;
        Sat, 13 Jul 2024 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720896031; x=1721500831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+j4Qv3nOgfTnp+y2zr14wW1Lo/3fyBq2HDu71iUi+w=;
        b=UFbS5E5d5JXMCqVx+/YYNMAVHvy6IXW2HkR9nVy7Gk6ElLs+ZaT4t8Zd50s+itnGXT
         h20cyDVotlwS6Y432cl93Y+0t18cIKfGt8bpbHuHAT1l2lSFaSBiQ6YRbRgSErRYgP4L
         SEomUw0ee3etqyjiRg/LKonWhpTjyUWMYw6rjucPJjLSOoUZXHvahhwOqsdvjZP8Ny2R
         OCJSmYfVJKDOpQJHciFwM3QTPkhD8cN1JQbbVGtM+gReiMVRp+nCuAYo4ugWe4Oibmyo
         WtAkfd7tnOMpT6NCUn1BtLPzv8XO8dET+i4OxjJx9Eho5Upmpyl1DezGAWsflb9qyd5A
         gyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720896031; x=1721500831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+j4Qv3nOgfTnp+y2zr14wW1Lo/3fyBq2HDu71iUi+w=;
        b=ecRS3Q8AlDae5e62Cgc5EIdM32r8DeSmJZ4gyV5JkgkRbISZBzj30TTeDQH3pSMZln
         afadTX3477p99HY3B5jSmeoqcvIw6lBbfQxjP0+IB3fOfCzN6XaAkqKEhR48VJssX9JT
         rSs4WvbD0600xaHQW5A/MKYZTLyurNgiZwPVGgyHZsXZ70cZOxgBp0yxCRBEZzsJ8Jlp
         kgzpZhnwUvej1lEqfonoKE0yUoeo3SoC+fZGZG17L43k2SRhNOO6ebvYz2h0IH8GiyJV
         +QlCPrHAus1XftsOfy/tKVVCzHsBvNbess9oDOC+yEvbWzEnupJp/8hMPMGHj1ZERPrJ
         krNA==
X-Forwarded-Encrypted: i=1; AJvYcCVaVvdLamA1N4PjRicbLQhgIOWU3+5D4oCiOEJsUvs/prK2Twwb12BfFrLx2LeDJ2sMNgJbU1Ud0ycz/bjmGLhYH3mQIIFx+A3XXz415MBD5659SX/5AeryY5gk/UWT3hmdJmIWndHIXQ==
X-Gm-Message-State: AOJu0YwK5ln1acupeTwNZB4fN1VcXAY/GpcSgwBjDXbdxj4AVVlUqb/z
	aZ/Ulwdxn16vTqqck5Jd+et1Zv/RQ426tKP4lcU/2eitfzDuZYyea8UrM0Hch68g1HwFsdQWwK2
	QvyPm0+dNKetnF5qb/1s4guPnuUQ=
X-Google-Smtp-Source: AGHT+IEO4lOu7UNQUPl0sKp330P+0bOsFE9cQmohc+yfX/5jkUnNv9ANoicDetHp9Dc+T7zuNdE/vCfRMBqGWBJRvn8=
X-Received: by 2002:a05:6102:32c1:b0:48f:e655:4327 with SMTP id
 ada2fe7eead31-4903213acd2mr17965397137.17.1720896031054; Sat, 13 Jul 2024
 11:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713181548.38002-1-cel@kernel.org> <20240713181548.38002-4-cel@kernel.org>
In-Reply-To: <20240713181548.38002-4-cel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 13 Jul 2024 21:40:20 +0300
Message-ID: <CAOQ4uxjOHz24Ph_s4DHuAwxuezsSjZhCTjUnWbUumZtxXuBbOg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fanotify(7): Document changes backported to LTS kernels
To: cel@kernel.org
Cc: alx@kernel.org, linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 9:16=E2=80=AFPM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  man/man7/fanotify.7 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/man/man7/fanotify.7 b/man/man7/fanotify.7
> index 3733543013d5..449af949c0a8 100644
> --- a/man/man7/fanotify.7
> +++ b/man/man7/fanotify.7
> @@ -825,7 +825,7 @@ See
>  .BR proc (5)
>  for details.
>  .P
> -Since Linux 5.13,
> +Since Linux 5.13 (and 5.10.220),
>  .\" commit 5b8fea65d197f408bb00b251c70d842826d6b70b
>  the following interfaces can be used to control the amount of
>  kernel resources consumed by fanotify:
> --
> 2.45.1
>

