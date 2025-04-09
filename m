Return-Path: <linux-fsdevel+bounces-46135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E5A833E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 00:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9936419E88AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 22:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B3E219A7E;
	Wed,  9 Apr 2025 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGPiFEx/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ED4213E90;
	Wed,  9 Apr 2025 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744236304; cv=none; b=hhkuuoHQMYedoSUlK4u72rQqHAvxujMTYMMIqHhqPwIodZGFICpA46MVQ/2AhqouC8EXoeQs91IKHahBNJjOhbIl4iPZy61wdxWKDfDjvVYJzzryebHJ7BwWdHo5ZSWJw0rXc7c1PMwvYl3l9LVNx9LPFzTwjIs52++soEYmraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744236304; c=relaxed/simple;
	bh=7zBL4EiN4oMCy+hMBduo4gCBqPFTDM0ZMlWUF6+YM/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVOtdLf9i2TTY2ne2HPfdJjM6NQuK7GQYwPguUhThIEXkdOgCPl7Q3T6WtDu6CYzX741NQFC6TUV8CpELBVHl66305ABtJvkiqJAiup5qwuWgQzAYEmDOz73LFv9CcWMX9qwV1U0lG60Uj9WhW8dUSIr/vbV3rsWqAIxId43DDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGPiFEx/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so31420866b.2;
        Wed, 09 Apr 2025 15:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744236301; x=1744841101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+zqP9zDBhLh6JdO0nY0cgfS5d6YYC1biboNeqTxu5k=;
        b=lGPiFEx/7bH2qFhT8/CDnwikXifvh1WHzGwQAl68z4hJn3YneHkZJNZC3P94Y8DA2H
         h3dHUfn/BWiIfqwnt6nVpPQtW4e8UpS8KwykwtqZQAPzYqjj/KLKelgmtKYTOlQQu2iK
         qgIBQqhAKcCIE32D7HFTJ6a+kMx5O+A7PgmTdzD3xRhTOEKnPpkFpJQMXq8czpO9R0bf
         0oJODNNCWwc5S9oUNGHLs+kYNyM4DnlnNiO3RBb/ogwdVfmvkZT+9QOI/5L32BdTfUbf
         wu0D4alGE/AtGg4LFzazNWODbRKDfHrUOIz8X/OU7VC20chJsptovzHSwBC8ZvfX/C0g
         ofXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744236301; x=1744841101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+zqP9zDBhLh6JdO0nY0cgfS5d6YYC1biboNeqTxu5k=;
        b=qyZzqwky64ZJPmfcf/kz9pBBJqT7AUUuSFAvCFW7rE4+IejhGfjaq136IGDT3u+FV3
         h/+Vz/tY3yg2+nB1w19B+L2mj+L4luzbOBvYo/V/N+dtijxHcHL5TYkPeWSufkq7z7ip
         8hbcIQ5YByeXxZHOtqW67eUqEE7H6p5aRZIwPBQiQW3sv243wa8CCPvI/ppqRl8UKKyL
         GAsrd46u50v3TmfCFhRe/YqH4Wlt+GuC3RLFPGumRWG2f2FlTfpENk7lT8S4HlFm8USb
         DZiNDh+4tuK0o7+VMKIavHDb+eKoknVIigpZyExOcXzofTlQ+qNeVXEMXazFfT/fGoRF
         8qHg==
X-Forwarded-Encrypted: i=1; AJvYcCVdoGEZvPSSG9PZE8plCMLy3C/wYOUARIc/AKuFV3kQ2suAogNpkuv6p7/r0gt3hFQsDzQ51ePIVV026On2@vger.kernel.org, AJvYcCWcDQ1JZzrQU6663BW4i8YmjfuGMVaIJFeFhyWIaMiQDWP7yq10mrRqLgodJ9BfMR+qnzOcdyCifT48/wgJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyHg1rWDnlx2bPAS2iXgUneXuo1X98Ukq780O9OcHYIJMguprWL
	HccJeYOjmXfDDJsthsYnin4tSMjz6xlDBPr1coKRFsHWq4EG1XGvKnmXiRX/rH6IiE9yWfIKstL
	+kYL+qsmvK0IwxuMNfriwHoO98iY=
X-Gm-Gg: ASbGnctXcDRhyYlDkCq/SBKm+mReSSp/9AbnvY/IAwbL/7enBSAe1U/ugo2jri+JaFH
	vhpPYNRjyDb+4xRIA4SsoHfaR9FrHveP1u0f+4Bbpe0mcEStAOY9jN5mBBLlTbwuiqMJHG3IhAW
	1NSmpCjYy5LijcSCPgPrWf
X-Google-Smtp-Source: AGHT+IHVxvh91aGQ8fYMq/JMI4/+vZnjC5gkaP0vTBAv9nCkj0b7hlztelXn056fBBVlMAT51aW1y3VmgJQgFPVMZNc=
X-Received: by 2002:a17:907:daa:b0:abf:73ba:fd60 with SMTP id
 a640c23a62f3a-acabd20a1admr28872166b.29.1744236300891; Wed, 09 Apr 2025
 15:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c58291cd-0775-4c90-8443-ba71897b5cbb@p183> <20250409143546.b3fecd04485b104657b8af25@linux-foundation.org>
In-Reply-To: <20250409143546.b3fecd04485b104657b8af25@linux-foundation.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 10 Apr 2025 00:04:47 +0200
X-Gm-Features: ATxdqUHZEciK7eUmVrDfxz-OhozHQYoqNC-ywPIFecqU3bnTHn1-jCyl2KcpeGo
Message-ID: <CAGudoHG7TpQ+Mauj5f2f4oM-sSVWGr0MxMeab7wzuPw1k-nt_g@mail.gmail.com>
Subject: Re: [PATCH] proc: allow to mark /proc files permanent outside of fs/proc/
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, brauner@kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 11:35=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 9 Apr 2025 22:20:13 +0300 Alexey Dobriyan <adobriyan@gmail.com> w=
rote:
>
> > >From 06e2ff406942fef65b9c397a7f44478dd4b61451 Mon Sep 17 00:00:00 2001
> > From: Alexey Dobriyan <adobriyan@gmail.com>
> > Date: Sat, 5 Apr 2025 14:50:10 +0300
> > Subject: [PATCH 1/1] proc: allow to mark /proc files permanent outside =
of
> >  fs/proc/
> >
> > From: Mateusz Guzik <mjguzik@gmail.com>
> >
> > Add proc_make_permanent() function to mark PDE as permanent to speed up
> > open/read/close (one alloc/free and lock/unlock less).
>
> When proposing a speedup it is preferable to provide some benchmarking
> results to help others understand the magnitude of that speedup.
>

It's all in the original submission:
https://lore.kernel.org/linux-fsdevel/20250329192821.822253-3-mjguzik@gmail=
.com/

--=20
Mateusz Guzik <mjguzik gmail.com>

