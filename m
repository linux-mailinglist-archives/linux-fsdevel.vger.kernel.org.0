Return-Path: <linux-fsdevel+bounces-67368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C5EC3D3BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 20:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D46414E2749
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 19:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82913351FAB;
	Thu,  6 Nov 2025 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCkS6zvL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB20350A18
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457211; cv=none; b=KdtwKONCvl3+TQXBdKeLHAwPKAhWd2t90gYz5BYa0KaLCupTfTLZIAsdoPLJZvnxzfI5LegV7uHsbZtB9ngRDPx9yxGvmLLSARb5X4Sly5pPkfGmcIk8QotExLPWaATwJGDyX33NtmoF3W93Hm4F73yOzkjHqwAozj47b48B4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457211; c=relaxed/simple;
	bh=zhh/X5ttMMoRznprN3Pz/B2WPFekQliTvZqswOSYzbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=je7bIYsGGdkkNQ/CFM5aD9xI8MTK+JeXb7AwbgHciT+6G5+Ao421RGNUU2JuSrRJ0MAo3iR5iVRNyliRby820e9JhGkV37gSVCohmoMpj/HgJ21mLunSmuy+HnXGrkQf4rrVMrqWWPr433kJl//qxCN7vr5KcnfT3LSvLthpuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCkS6zvL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47112a73785so9069535e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762457208; x=1763062008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwyTwhLa5pqI0LdPc0d68jU8z9uOUnUkIeBJpd4iCgA=;
        b=fCkS6zvLozMKxaICvOFxpBjGqvR+qapBL8rc1tWbACPmZSgHktpSBnolXRtnnXQo40
         /KypNPPMRtXhJJk4rXmphRs9XYQffye5DyU82FK/Gfpq5WhJewbSlw3Mz50hbioAJT2L
         l2KdrlFt/q4Rlsx3tgY40N1lLNmkzeLXTYIM3e91rB+tJUr/kQ6uhjBV0JGL1cT/ZOL0
         cMPzI0WFTfo/R8xD8CFRWaDrNZb5l6RWlcxN4Yv/8ze+FySzzqslWNo4Y0PT/J+o/IUO
         jS6/O682u/dA75+Bb0jsuQ1Wx9mZo3tW+I947hgl3J39ebBgNWaCVaOq3W2yqTC5ADga
         NL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457208; x=1763062008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DwyTwhLa5pqI0LdPc0d68jU8z9uOUnUkIeBJpd4iCgA=;
        b=R8Hv8q7QQzcjQ9R+NWRoViUkxZqD4Y2UO8D4CXAMM1TpjBqJYxIuhK+8GiuWE5Rqg0
         8YwnK7K85dgPBExJ/YHyUpZB8/j88u97bQsaXeh9XqTmHNIqp8/Ja3A8eGU6Veuvswb2
         IPXueG0Wymic3aBrEu6pS1LfSZMakq4nDl0i9Z5sKtgZUj9cAfoAIPPuH+c5o2jek2ed
         AWitXuRX/drx3RO1Urgacn2ELRSfbGJiH/VUYGVzAl2DPb0yDmN9ZckMP6wisU7p1thS
         IdLqvNgOi75MAZQLDNl8RlrrYSPtdxPvoQwGLlxrlPj0Ye9wo9bIs6hdcoiNZs06DCdg
         mAjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGKYnGkPg+laxxGIVSBzlJDgv1r4RYpsZUvM5FUxmJotVVWI7EQqoNEZ/9oTbIgPSs5UlCxQhDUECd3vs8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/+JCowBYDYlE2WKXgf1oK8qJCZMrZmBGCOD9aaeYqPhO7lP9a
	RiuiQDMTr8k8Gaqh0DOna+03R32NUMQ1gRcC7PJC/sOvnOO+VAuq6N9Y
X-Gm-Gg: ASbGnctCarCGHeIPDIidMynsGvTufPq9RlNigUk/pZr4hQFsTLO1yuKuHzZOh0eM3Tg
	/qElEXL7FpVa7uQ7w5I7ckge2yTcOKjJHTMqjicaoGmx+AhlLas/ZZy8avulPJw225OD7iLHkAJ
	eJRR6UnxK41bPirtX+UY9LMch9N08sNrl0AdRTYZxxzPUruHh0CarmmPd8JThT4JqaGS2V9P51z
	OSA3OQGAWJuEfjT1fGONQ5MN5xe3Wlp1H4suzeZhC6h/H6ZlI033l9PsTe0DCf3QA2PpyQGAcKq
	ji8TxZ/eW3r1Dvqe3PTC5ahY8z0cEH76H51K5jlb7aS6i5Vo4RQvvHsptkqzcemiD1krofa0D2H
	rIzbn/etAq8mck4+k2hF+AiSv8PbXzKyEA+jteB2t9BRmGsIwdVw61Zjd3C+/9/I3fUZ3higaet
	vdOA8V4Z5NdK5t83CWITbCkxeo9cQXA7PYwF5RrPXEBnCjwV6sH2IQbYJV0hgJ078=
X-Google-Smtp-Source: AGHT+IGTla4CePH0L3Rk9O7fjkJCLGeVLWduj8m7JXKWo79RsNtzdF/PeL5Glnk4Exnt93SYvgt/zA==
X-Received: by 2002:a7b:cc91:0:b0:477:1622:7f78 with SMTP id 5b1f17b1804b1-4776bd0e80emr3032665e9.40.1762457207689;
        Thu, 06 Nov 2025 11:26:47 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477640fb6besm22490075e9.9.2025.11.06.11.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:26:47 -0800 (PST)
Date: Thu, 6 Nov 2025 19:26:45 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, "the arch/x86 maintainers"
 <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 tglx@linutronix.de, pfalcato@suse.de
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
Message-ID: <20251106192645.4108a505@pumpkin>
In-Reply-To: <CAGudoHG1P61Nd7gMriCSF=g=gHxESPBPNmhHjtOQvG8HhpW0rg@mail.gmail.com>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
	<20251031174220.43458-1-mjguzik@gmail.com>
	<20251031174220.43458-2-mjguzik@gmail.com>
	<CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
	<20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local>
	<20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
	<CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com>
	<20251106111429.GCaQyDFWjbN8PjqxUW@fat_crate.local>
	<CAGudoHGWL6gLjmo3m6uCt9ueHL9rGCdw_jz9FLvgu_3=3A-BrA@mail.gmail.com>
	<20251106131030.GDaQyeRiAVoIh_23mg@fat_crate.local>
	<CAGudoHG1P61Nd7gMriCSF=g=gHxESPBPNmhHjtOQvG8HhpW0rg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Nov 2025 14:19:06 +0100
Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Thu, Nov 6, 2025 at 2:10=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
> >
> > On Thu, Nov 06, 2025 at 01:06:06PM +0100, Mateusz Guzik wrote: =20
> > > I don't know what are you trying to say here.
> > >
> > > Are you protesting the notion that reducing cache footprint of the
> > > memory allocator is a good idea, or perhaps are you claiming these
> > > vars are too problematic to warrant the effort, or something else? =20
> >
> > I'm saying all work which does not change the code in a trivial way sho=
uld
> > have numbers to back it up. As in: "this change X shows this perf impro=
vement
> > Y with the benchmark Z."
> >
> > Because code uglification better have a fair justification.
> >
> > Not just random "oh yeah, it would be better to have this." If the chan=
ges are
> > trivial, sure. But the runtime const thing was added for a very narrow =
case,
> > AFAIR, and it wasn't supposed to have a widespread use. And it ain't th=
at
> > trivial, codewise.
> >
> > IOW, no non-trivial changes which become a burden to maintainers without
> > a really good reason for them. This has been the guiding principle for
> > non-trivial perf optimizations in Linux. AFAIR at least.
> >
> > But hey, what do I know... =20
>=20
> Then, as I pointed out, you should be protesting the patching of
> USER_PTR_MAX as it came with no benchmarks and also resulted in a
> regression.
>=20

IIRC it was a definite performance improvement for a specific workload
(compiling kernels) on a system where the relatively small d-cache
caused significant overhead reading the value from memory.

Look at the patch author for more info.

	David

