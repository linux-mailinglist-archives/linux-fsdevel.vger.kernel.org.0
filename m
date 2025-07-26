Return-Path: <linux-fsdevel+bounces-56085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA84DB12B97
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 19:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D303B993D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 17:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF78B2882B9;
	Sat, 26 Jul 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLSncaKe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5024466D;
	Sat, 26 Jul 2025 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753549968; cv=none; b=M83oOvdYPSRNfor0WUOYngVRqpeZhpQh1hPu1mgC0/M8NSgpZZfvMgvQLrAxaUU7J7HvLkox89LFeUwY++ahgkN9VZQCOGIplhK4Z8QK8r86jLnYsWIYKDJ8YABZc8nVRVyZx4POR492gmpaDYssPTHWvc2ZjigQXxul5ydtntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753549968; c=relaxed/simple;
	bh=vUPvBTBvCOcvFHnkL1DyIZFj/QCKhHpnbFMILB/cZtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHbILmrmagRvbOuRC7OTpXsmia5t8SgFQfieIR8ZRLJP3Ouo2l+PUf4hVNn1Rmn10IfHib6vkP/pDZbgy9SHVgvJit67YoZLWHp3je9tRPopDxwdEY902hTfWyXmtTHYGPZMuoPl0yLMyQlOVl9YLUOQdYqQWKAr2sNS553N/Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLSncaKe; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-615da180061so1613336eaf.2;
        Sat, 26 Jul 2025 10:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753549966; x=1754154766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUPvBTBvCOcvFHnkL1DyIZFj/QCKhHpnbFMILB/cZtU=;
        b=aLSncaKeaYH6FW41I5N2f+0DUQs5cYjtvaz8j/mxnVytZfIKBIAsJz5VPX/Al3DyxU
         Ihj1U/biKsjkgAZTFr/nWEIl2nHmsmFf3iiFgYPCadLROVh+q3GSFxmGWhfgeB4GyPT1
         PkiMpMycfg34ZWc8vv41yXhw1eInUMGAshyN6rBOf1vQWHEjW7pboBgK6cu7cDG+2Yeu
         bA5VdynNTaMuT//ND8Xota6qaKGi5qiA0gtJ1Qff9m+KRFsr5ME5UHRlwElWEhChuNwd
         PvlXqFv9c30t6Ets0ZvVPpzwUI+zuc463di/CpABMgIa3N3dvk8TLeDm1alEytPe1/zD
         TaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753549966; x=1754154766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUPvBTBvCOcvFHnkL1DyIZFj/QCKhHpnbFMILB/cZtU=;
        b=VYHV7Cmq8WtHdEFaZo/SEjH/FNXsX/rCRH1Snuplanux/O2x7zUDRxZcOTI/Gvhrk9
         2DSATvkaIgkAkptBzOP5aM3+oiAlCnuE21URvoI6xQW5XRlciEaHtMPeyVuss5oI1qD3
         4OY69f6G9nKTS9SEVfykgGL32H1Plau5cFAEgpCILHp/B0c7K2tV1I0v3swQxMMQQJQk
         1T9HECeKpWUu2sRviB+y3MEqs58Ic0ygoWsN7J2oQoXSGHjuKzfGA82CCV0R0vCNP8Mm
         k60PGydVopmloIJVdbotQeOFZZmWuYPJR9LAtnPqtSAfaBKDOCoFI47r+gl1X6U29fUq
         o2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcKlcyYPZhVGyfEjsR36+9wavX3iW/kQFZfqLiU9ODvMeN2LSoS5dqSc/b1lVWQS9kWlC5OZk92gg=@vger.kernel.org, AJvYcCVrzhIKT1c4wJTL0FGSeh4J2LrYw58cgN6GZTqdqQEOnwFGvIxh0BN9lstQwxetQzNvUFkk49VEJT+g9zTgAQ==@vger.kernel.org, AJvYcCWg4mezTkzESgMj9mwkuVZaGFlvXoHUIFpB/UJOh62GxOIaO0U4B2+WKwLqRztdY6azDNg5fv4lkjGbh/IP@vger.kernel.org, AJvYcCXsgir/JcQaKKyWZ2v++rZJeViX2wNVg73/Ok58gsSnbIpNLPvxwy75Sa4iVOBPOb4OsAOY/YdI@vger.kernel.org
X-Gm-Message-State: AOJu0YxBdAOMnvlVNdIOML4QOU4aIM+Vil00JBj96yFW5moM6EdoZ5YP
	Vfpkmn+KWZQeo+VAotCGutYbb+h7Iy317njXGGy/FzVnKYH58ilWewPF9dh3OopKJ5uvC+B2X8j
	tk+Yf03/pzgMosHUchJG9j6nMfI7DcTvzX58R
X-Gm-Gg: ASbGncs02OPJu55j7pSpOhYCUARKf4ZURYc6su/Tl8S7Ort9/Cp+PLcj5BDscSlKFeA
	7cd1QqnqaA0O6Hk5IdongYdmmdZLZ7Zs56yACzhBojn5uLMf+z546y9/84ZL8NEOuxE/QIl7C9P
	LeCH/dTiZ7WV0vd5zjWJsIURkI6aV1QoOuVUWCloUfx5tScD80yDW+xXrL9hf/NjGRvdyvQb8pv
	KFKsdCaCDFiis0OAu0=
X-Google-Smtp-Source: AGHT+IEHe3I87VoENsAmINVPG4Xg6ymZb3G1FkkvBLGuKgXBu6uqEsfIPFFhzbYIPFMhxNeGdiHQQeTbADKs01jAk4I=
X-Received: by 2002:a05:6871:bb0f:b0:2d5:ba2d:80e4 with SMTP id
 586e51a60fabf-307021d75aemr4090571fac.24.1753549965643; Sat, 26 Jul 2025
 10:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV>
In-Reply-To: <20250724230052.GW2580412@ZenIV>
From: Andrei Vagin <avagin@gmail.com>
Date: Sat, 26 Jul 2025 10:12:34 -0700
X-Gm-Features: Ac12FXzwEJEUha36n2XPTKyGUflSEYv-O8_CoFpgDNEYuoG7-LzlXSJbmYvVg3s
Message-ID: <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev, 
	Linux API <linux-api@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 4:00=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Thu, Jul 24, 2025 at 01:02:48PM -0700, Andrei Vagin wrote:
> > Hi Al and Christian,
> >
> > The commit 12f147ddd6de ("do_change_type(): refuse to operate on
> > unmounted/not ours mounts") introduced an ABI backward compatibility
> > break. CRIU depends on the previous behavior, and users are now
> > reporting criu restore failures following the kernel update. This chang=
e
> > has been propagated to stable kernels. Is this check strictly required?
>
> Yes.
>
> > Would it be possible to check only if the current process has
> > CAP_SYS_ADMIN within the mount user namespace?
>
> Not enough, both in terms of permissions *and* in terms of "thou
> shalt not bugger the kernel data structures - nobody's priveleged
> enough for that".

Al,

I am still thinking in terms of "Thou shalt not break userspace"...

Seriously though, this original behavior has been in the kernel for 20
years, and it hasn't triggered any corruptions in all that time. I
understand this change might be necessary in its current form, and
that some collateral damage could be unavoidable. But if that's the
case, I'd expect a detailed explanation of why it had to be so and why
userspace breakage is unavoidable.

The original change was merged two decades ago. We need to
consider that some applications might rely on that behavior. I'm not
questioning the security aspect - that must be addressed. But for
anything else, we need to minimize the impact on user applications that
don't violate security.

We can consider a cleaner fix for the upstream kernel, but when we are
talking about stable kernels, the user-space backward compatibility
aspect should be even more critical.

Thanks,
Andrei

