Return-Path: <linux-fsdevel+bounces-15220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A99688A91E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C8D380903
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 16:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A64A143868;
	Mon, 25 Mar 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e03OdyVN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1750E80632
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376904; cv=none; b=eLIwjtyzjsHDm3mBxa6PajvSTkTxXP7gbzaX2CUKh7MppnTUO/UlvbZnMrPQ/m0QGXIhM5lcrzoEuOY3h5TuPAAB6zarn1EhddSJsFE0mWz7iGFrz8etOFGJqbcmHUTTOUxHRD6ID410i16nHqmXMU8F6f14qa0YcBcDQ9R5t8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376904; c=relaxed/simple;
	bh=aT9L4s68iwSf86wxyvTDWmw0CpDA+2Zmc3akSVJlkp0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FoGcd4VTVzqwuYk3HJoMhG24qzew9sC28KQJVB2KiCjmgBPP9WftTWN0QjgDYz0N74qdUkpXmbbRhDYj2dxVD55AY1JBGn3xkRn47UnhfZ++LeNTbPbwfc4D4QcrHznZT2MfX9dNVdGHgjGW/zV1ChXEgeMPqhVzaF7irgtS0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e03OdyVN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a03635590so88237997b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711376902; x=1711981702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zm3sG16QJNbWH1s2j0TGqj22cMhqH+vJ/EV7YKBbovg=;
        b=e03OdyVN9NZ3PYjCq5OB6WQm7PqbPRXWKRjVnq+2m+aI0vJSm3ZkAUdoR0wPfT4RdR
         7AeeFDSPlsgBC56jIeIqcLBwFF8H+xbabD/eWTYuLFUv+5NdcLrQCnXX9zHwT0j87v3K
         E8zfwmPyaWI1nuBCa0il/lPnq7xQlaY1evS0KZnMqIptVP9LbFpHQjikPjdG9/xZmGhr
         pmuAL6LtW4qy6qaEP+cPPTyhlkAfHTKYXliFlg77R+OS6r08rYxZEwLY4OWNv0uwNRYR
         +yIuiPR3HSAOwRpiNx/9Mm8gI5gSUJSZrVPmnKJ6gesMckUhIF5Se5GEmSQwYCMHE0xW
         uyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711376902; x=1711981702;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zm3sG16QJNbWH1s2j0TGqj22cMhqH+vJ/EV7YKBbovg=;
        b=IrxmkxwXnekzfOsEZGWessUJqn9nVekR0lIGr3x4K9rdQdNYmbzZcFGaH10poXlEAE
         k45tPJxNdEiab8c+rCExmwI3pD/AQIeGM8fwwXv7QCm1xvKPs56e4dobkuY/zsqjQ3nA
         ypybPCXiLwCcvXJ0EoC6MAPI6hlfBvKc9/uc1WKLgWtl+z7CX9fcb1hqMGCcQwzl1ZV7
         h6lcH2A5Onlduj7UY1ckwihlVTkZ7xyUa+zH//BBnwW/BBMhG3i7oCes6uhLnMOiwfkc
         LuFwfeOjGzyY3mDJT8QzJJCxuKaQOGqWVhpovdAcSvIyqepi4Bp/T6T9U8cIwn95XFQV
         NMaw==
X-Forwarded-Encrypted: i=1; AJvYcCWpk0iNvwe6E4icbudkijbonPq8/SHM9uqC8gWS/rSSM9a1mjdjjZtXG3y8XeSePON7vIG15SsVF3DPIQjznhEv1OI+/J74t3a2Tv7nAw==
X-Gm-Message-State: AOJu0YyvXWkzd1EVfGel2Wz2T5ZmCIc4BNNwTgwHbrJnFPI3dyizEm9n
	8TyndLVsAwRtNTL10vML2uKz5YEtY84Pr/pgHwno1/ZZPB1WmI42/DgPLU250PAdgbUVjrGqq/B
	/eA==
X-Google-Smtp-Source: AGHT+IFFIFlaGCUmEPhF867dqzxn4ErHTmd7pxZqWvXRYn3djCZ9hoUd4E+q7VHL1UI7QjcRlP5Mz94QgH4=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:6d09:b0:611:9268:b63a with SMTP id
 iv9-20020a05690c6d0900b006119268b63amr474258ywb.9.1711376902084; Mon, 25 Mar
 2024 07:28:22 -0700 (PDT)
Date: Mon, 25 Mar 2024 15:28:19 +0100
In-Reply-To: <20240325134004.4074874-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325134004.4074874-1-gnoack@google.com> <20240325134004.4074874-2-gnoack@google.com>
Message-ID: <ZgGKA4b3MxsmLTE0@google.com>
Subject: Re: [PATCH v12 1/9] security: Introduce ENOFILEOPS return value for
 IOCTL hooks
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 01:39:56PM +0000, G=C3=BCnther Noack wrote:
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d0eb20f90b26..b769dc888d07 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -248,6 +248,12 @@ static const char * const kernel_load_data_str[] =3D=
 {
>  	__kernel_read_file_id(__data_id_stringify)
>  };
> =20
> +/*
> + * Returned by security_file_ioctl and security_file_ioctl_compat to ind=
icate
> + * that the IOCTL request may not be dispatched to the file's f_ops IOCT=
L impl.
> + */
> +#define ENOFILEOPS 532

FYI, the thinking here was:

* I could not find an existing error code that seemed to have a similar mea=
ning,
  which we could reuse.
* At the same time, the meaning of this error code is so special that the a=
pproach
  of adding it to kernel-private codes in include/linux/errno.h also seemed=
 wrong.
* The number 532 is just one higher than the highest code in include/linux/=
errno.h

Suggestions welcome :)

=E2=80=94G=C3=BCnther

