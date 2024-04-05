Return-Path: <linux-fsdevel+bounces-16242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A9089A647
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 23:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE081F22AA9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B864172BCE;
	Fri,  5 Apr 2024 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lta3KyJR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918DF1DA32
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353463; cv=none; b=C4Mcfp4ahmLx5ZRCp0MKiKNTSg52sC3gfWYrFKS4oE9Faxze12wAGr4qw4hX1XKw8jjMno8LZey6NtXEOS3FRutYo37boAK4+kPFQP8fFVxKgsTcNITNgftnZtfDrbU9nbPDkqOqYwf1jn0vLSqCrLXDiKQfakCB/eTnSXG8zAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353463; c=relaxed/simple;
	bh=oS5bb4M0EfmMnIH33JNisqjMupGydeXQcZNLxrbbly4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PB4D0UFeXLzXb8T9N2QOsQ7IYvjB9AivRe2T/s5WHNDeEf7Udk43290/1RuX2MvsvXfj2tgjVOLEM4x3xRNm4DfG+cJOmAiu45SCf7Fhs0EIBSTLHcoB5PFWDBwZUAIRNO/J/ZnnABD5m3/oHm3UyIoDAlCh/ZTJG0yKgEwFgxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lta3KyJR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61506d6d667so44888587b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353460; x=1712958260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R124BriDa1gEiwbB6nVdKLf97X/einRvmCdS2X++C+E=;
        b=lta3KyJRCaEi3KaSYPNvt5VXP70HcVqIVRdMI917C4v59hLgryD1ncSlJbRoKJGlRK
         ZZRvgoHpWScryB9d14/257kqnVG4xUNVsoeqSvVE/ximhL1DHP6BLZnQh6aleJMLiBy+
         pYLG0XQWpgfW//5ye4DVI4t0KPREEQcAlunlJgPPOf68Ca2L4tvJ5lGBI39Hz6elbfa4
         AFzjhVQyyvNsRdSA7gWI6pDblvHYoHpN99PAvKXgHadt0ZuT4ssYRF1ff00b4SBMtZSp
         s2HjcAKKAJKcUKimeSY31M/IvSYk5uoNUAm6IFX6ljTI/Bh9fI9Z39HG2PvMujBsDv/7
         gCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353460; x=1712958260;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R124BriDa1gEiwbB6nVdKLf97X/einRvmCdS2X++C+E=;
        b=qDMkTGB/sGetRyszhK5hkdIZWYLSo59zOmR+U2cujeLYH46Yf7iFYdtKK5SY95S4Pr
         w1RIe5TWPNKQ6/McmocVKU8YZCHZN35gM0SNUOnuHGyyH1JejVVjAmJMAtKUxfXwDOmI
         ZWfqyt1gwuXpz3BKxGzbeX9wR4vz12hhiXC/8Xj61xGwpbzXNr5VQ/ouN2Ie37EPCfMN
         AN5K+6dNjLRkX3yd/WfZwA2vODJI6bdw3cRjs4oqFhAVsX+IdiazMOoO8GdJ741xkS/Q
         h1UVSi0JOuS3R3ijlBlH489zS1TP7lrQng4yHRq+nvYkjqzzMMfszZAojeE9A0X5geEC
         3qWg==
X-Forwarded-Encrypted: i=1; AJvYcCVaXgYR9/GRIHtnt09X5oE3j95md0HF68oz4gAdOgDSDePPFh6aB+w3wz2ZbWpase8e7VyKaEIfedLn6tQGtLV5Kb6p08SdcmHrUtcbhA==
X-Gm-Message-State: AOJu0Yw0T/T5vESMEYiNbBVmxZoAlmFQqevy7mbdzQNMtlI7+fF0eBnf
	vCeWlddmXpINzfErY0MeFCKCH4KJFe90MlQi64WuFD4mkzvayBzcA6KuWBSL+13iJRc4wYPn9rx
	wnA==
X-Google-Smtp-Source: AGHT+IFY2apVZYCCOCia8mgnRYQHU6ofGDWpHC6UnO9fTT3+bl9y11zuY3q57PhPxvNesxXfwVOFIHqY+Ao=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a81:4ec8:0:b0:615:4805:4aaf with SMTP id
 c191-20020a814ec8000000b0061548054aafmr567604ywb.5.1712353460550; Fri, 05 Apr
 2024 14:44:20 -0700 (PDT)
Date: Fri, 5 Apr 2024 23:44:18 +0200
In-Reply-To: <cnwpkeovzbumhprco7q2c2y6zxzmxfpwpwe3tyy6c3gg2szgqd@vfzjaw5v5imr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com> <20240327131040.158777-2-gnoack@google.com>
 <20240327.eibaiNgu6lou@digikod.net> <ZgxOYauBXowTIgx-@google.com>
 <20240403.In2aiweBeir2@digikod.net> <ZhAkDW2u3GItsody@google.com>
 <ZhAlXB3PWC4yyU8F@google.com> <cnwpkeovzbumhprco7q2c2y6zxzmxfpwpwe3tyy6c3gg2szgqd@vfzjaw5v5imr>
Message-ID: <ZhBwstt0zakE4uN2@google.com>
Subject: Re: [PATCH v13 01/10] landlock: Add IOCTL access right for character
 and block devices
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-security-module@vger.kernel.org, 
	Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 02:17:29PM -0400, Kent Overstreet wrote:
> On Fri, Apr 05, 2024 at 06:22:52PM +0200, G=C3=BCnther Noack wrote:
> > Kent, Amir:
> >=20
> > Is it intentional that the new FS_IOC_GETUUID and FS_IOC_GETFSSYSFSPATH=
 IOCTLs
> > can fall back to a IOCTL implementation in struct file_operations?  I f=
ound this
> > remark by Amir which sounded vaguely like it might have been on purpose=
?  Did I
> > understand that correctly?
> >=20
> > https://lore.kernel.org/lkml/CAOQ4uxjvEL4P4vV5SKpHVS5DtOwKpxAn4n4+Kfqaw=
cu+H-MC5g@mail.gmail.com/
> >=20
> > Otherwise, I am happy to send a patch to make it non-extensible (the im=
pls in
> > fs/ioctl.c would need to return -ENOTTY).  This would let us reason bet=
ter about
> > the safety of these IOCTLs for IOCTL security policies enforced by the =
Landlock
> > LSM. (Some of these file_operations IOCTL implementations do stuff befo=
re
> > looking at the cmd number.)
>=20
> They're not supposed to be extensible - the generic implementations are
> all we need.

Thank you for confirming, Kent -- I sent you a small patch as part of the n=
ext
version of the Landlock patch series:
https://lore.kernel.org/all/20240405214040.101396-2-gnoack@google.com/

=E2=80=94G=C3=BCnther

