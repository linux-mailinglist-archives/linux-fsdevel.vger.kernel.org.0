Return-Path: <linux-fsdevel+bounces-41295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03213A2D817
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 19:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2EC166126
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 18:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D405718CBFC;
	Sat,  8 Feb 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OJzbz1wl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701024112E
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Feb 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739040840; cv=none; b=EstCfHL0UYlGP6EB95T+M+4eRczKFKhuSMo25H9h7qUbVXAcKytExb7JJq9Eshqi+vs41MtRH9wcG2m8Ni0jLhnxzmqyVus9jzyMOUJoACiiJYQoWQSE6uvpy0xTyGle5CRfIeSEsrbV9Fs0MBwlIJYMr3RmdEcS3efFUMPsX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739040840; c=relaxed/simple;
	bh=Ubo4wxDjAMDx2uw+LaC/zE4ZJCENcZS8vDOY0CHooS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyNDoTYf0QJg4TqfQALySyfu+aMOq12gogWz9oZgcicHVrJVPvfI7kdc85aq9e+GjnourJLQyYG6Ev/Shi9/IVX8PlvbK6w0+6/IMXoawm9mKxSjrd8E6dAzuZ05+TF3l7IS1t2vZfu00XCl/GgyYobYKfRPYSHoRPPlc3H6NyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OJzbz1wl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de5a8a96abso1426029a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Feb 2025 10:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739040836; x=1739645636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmbr0H9srSRz+vgiAYrxGsuDDOFMLeKavVCcXEyEunw=;
        b=OJzbz1wlfkKRrmL7FmW/PPixwsORpxWnBd47Q5OWGl+10TqPHtRNJM29C38j3YeDlR
         J2FujCq8IoIksBD/68JEMBoDOYGmDGexkVDzPNBZDMamMUJBF21N2MjVS4wYQrHrUnHb
         60ABnvNAJPorSYAyq2V4afPXDzbqZEM4ilKiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739040836; x=1739645636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kmbr0H9srSRz+vgiAYrxGsuDDOFMLeKavVCcXEyEunw=;
        b=BjSxT01vmEGVqtKfEd49SZxwlJv6ZkXuymKvvCEfM7C5H10MAxfsKVcGssoeNYz27M
         ULILvchx21XE9lSxsdoDxqYBikZisuMxAIwwj7GlzmwenouullVwPmXuK2Vdxj0rqc3I
         L7CGgOepdQOki7WdBoObWwLnsXTOiJk2NMpgzT6twgOIwDmJDdqFg+MZOkGF+6rj2Mt0
         fHI9Sk/IQOSxdu+1c6Mfmr7kcBJYK572pmsPBEMCDfRfnY3ooN11snjFxNPZNAfo5qpa
         KrZFD2hD33fLum1kgkt40i+moBhk6KEgZOzJrcbrTzusiUfUuiTrG3j7CI+VjfgN2pW+
         TkGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfYGZFTpRM7RYWLDqK/tfrcApVhmgJ9HrIxHxtwADSa/pPCpvD7ShOs+rVvUI2f0X8fjIGCJF7R6/d76qI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk3aX5pD6zblIiRNtd7rmFSJCJ7uNazy7Kcoij+4+uAX45iua6
	+nF7GdOc5n1Aijm+liR4T+tH+vfPrdA/1A7pPSj3p4qzXvk3efMs1kAWbzAbE3+PgzibeiYiYL/
	hVW/0gg==
X-Gm-Gg: ASbGnctfq1V+OesPXrg8z80IJyEizb4V99DU7fQJRoWkJCoQk+3GqahOv9VyRsXo2v7
	ymJ/NrSbhBx9yuge2ptnP9eemDacWIs+SXw2vw3pr3pHZmeG+odUm4Gl0jZZe/9rzWqvooXh6nW
	ZbE3k2mLyOTKQJZSJ3dNVvOUJu8rtT41+d1yPkSa82Jxs1z9Y63ngBAT/T+Zd66F81fNKHRhLxg
	tIac0joam/Na3nlTcGe+CDnzVgNQO5TFzwqiO/BRost/7iTVtmc/OZVjPo5c+VsMgjYbInYAikr
	NG2ej7v5ULgZnkdHqijiegkHegPP3m4jUdDTISaPjTDbZvamVF8l68Mspvd061nWaA==
X-Google-Smtp-Source: AGHT+IEKLQNFf79Mi8orSdUg5BorwXB2T5bTG129eVInmn988aM8zi6pdL3RKNyLmyXW0HcZ7OL5+g==
X-Received: by 2002:a05:6402:194b:b0:5dc:7374:261d with SMTP id 4fb4d7f45d1cf-5de44fe941dmr21676877a12.7.1739040836060;
        Sat, 08 Feb 2025 10:53:56 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f89318sm521613666b.70.2025.02.08.10.53.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 10:53:55 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dce4a5d8a0so5145484a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Feb 2025 10:53:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOo9Y2Imz7WZ/LaDDN7mimELYy0OQGVqNkDxBcVcXKQx3JbTBdOu8005cLqDugesmSgckmao2eub5xXi8D@vger.kernel.org
X-Received: by 2002:a05:6402:358f:b0:5dc:8f03:bb5b with SMTP id
 4fb4d7f45d1cf-5de44fe944emr19692649a12.5.1739040834771; Sat, 08 Feb 2025
 10:53:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208151347.89708-1-david.laight.linux@gmail.com>
In-Reply-To: <20250208151347.89708-1-david.laight.linux@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 8 Feb 2025 10:53:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wicUO4WaEE6b010icQPpq+Gk_ZK5V2hF2iBQe-FqmBc3Q@mail.gmail.com>
X-Gm-Features: AWEUYZkQ-gaQUcuQDLlGCQM-u1tFXVw0-fJVfL4CHFsbbrdrsyXbEEev_pRAdtQ
Message-ID: <CAHk-=wicUO4WaEE6b010icQPpq+Gk_ZK5V2hF2iBQe-FqmBc3Q@mail.gmail.com>
Subject: Re: [PATCH next 1/1] fs: Mark get_sigset_argpack() __always_inline
To: David Laight <david.laight.linux@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Feb 2025 at 07:14, David Laight <david.laight.linux@gmail.com> wrote:
>
> Since the function is 'hot enough' to worry about avoiding the
> overhead of copy_from_user() it must be worth forcing it to be
> inlined.

Hmm. gcc certainly inlines this one for me regardless.

So it's either a gcc version issue (I have gcc-14.2.1), or it's some
build configuration thing that makes the function big enough in your
case that gcc decides not to inline things. Do you perhaps have some
debugging options enabled? At that point, inlining is the least of all
problems.

> I'd guess that gcc is counting up the number of lines in the asm again.

If that's the case, then we should probably make sure that the
relevant inline asms are marked 'inline', which makes gcc estimate it
to be minimal:

    https://gcc.gnu.org/onlinedocs/gcc/Size-of-an-asm.html

but it turns out that with the compiler bug workarounds we have that
wrapper macro for this case:

   #define asm_goto_output(x...) asm volatile goto(x)

which I guess we could just add the inline to.

Bah. I think we should fix those things, but in the meantime your
patch certainly isn't wrong either. So ack.

And while looking at this, I note that I made get_sigset_argpack() do
the masked user access thing, but didn't do the same pattern for
get_compat_sigset_argpack()

          Linus

