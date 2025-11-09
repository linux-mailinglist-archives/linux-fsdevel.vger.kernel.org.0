Return-Path: <linux-fsdevel+bounces-67605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D352DC446BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 21:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 35E5A345FD5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 20:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F3C1D5146;
	Sun,  9 Nov 2025 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="euAEvstC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19718C008
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762719753; cv=none; b=VyCkCv2gvCI4UU7/ZYO8KY5DuNI54JCi0C+qe6O66x1FebDT9qRAnPfI+sFbwrWiEhqrmEvaN0hPzEJdO+YwxLkdHfHJGVz8HsZzp1MqBl0klNTfg4hltYbMKJiMAUjHDcSKEY6NtVwJfilpdcWp8Ipqx3f9z6pE3zPKII6TFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762719753; c=relaxed/simple;
	bh=gMM3i9EQws9r0erlhwqEHGf1p4xwZQaG6fRH9k5nI/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWut79ZMsnIid2zymauHjyQx0N2boQKJBpEoYvtEGH8OgJiBzMbiwM3/xGdnpIT1DcXaXxlWjwJGvl5N8+vr0ERngqKXltF/BrftjdfPe7Y0ydhiM2BfMC4uD0UuTBmuOTKKSzo3F38ZHlbmYTY2zghCYOixYqATtX/Ttmcm+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=euAEvstC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b729a941e35so277918166b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 12:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762719750; x=1763324550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb0PYNykYCL7Bou9jPgLMIeh7nnGaWAzoWBWhkWIpmo=;
        b=euAEvstCThowZ5cg7UPyK9sDwn11PFtcX5ZBQTpizq2KoKuI0/7Rxc3+oHLJR7DLQH
         YH/PZpFlGI3CGtKEn1/kXNWvW0eCr5BmYV7HTV+S/ri2boLdRdJCPCkwYBqcHZ+Lv6cm
         ylJ1yi1NQ8Yyv7kQv7Vz1P1in+bQGOWl8caLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762719750; x=1763324550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb0PYNykYCL7Bou9jPgLMIeh7nnGaWAzoWBWhkWIpmo=;
        b=RbOf18bexyd2koRwUMfuWSXWMwnLOIoYeOTHbuSUuh5+UY46oP+ERGtTLi1T6MMsLH
         vu0DqM6E7JD9aEZWJH/1IQ7u5+1O601rnBRkIsr41NxsIOtO17SJKkROWEuLDoC+ttq7
         b1tddgljHrLXupst856/8H5F5fWFqiBVQP6R967rNDLnjvGzDP+H7Mebw3YjGu8C+jQO
         mt+8w2IA6waREhb/41/SiCoyZ8opCvaF+N13HRrflD7Na/Tl7OnRg/9ClvIMdet1Ma+s
         yP2JNPAh+gBBY/1Bk0pk2cnS2v0hM++Jmd8R5VySkKfE4Dt1v4T6FS8fjdaHOSSKhUsq
         RH8A==
X-Forwarded-Encrypted: i=1; AJvYcCU6ecv3SFWtA+/1umYQWCWtmna+x7e65ZH+DJk7kxUwPnMEtZzHAKUStkG8PhLPlIlWwm1QRIILMMauZQ3H@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlc8XxzO04ypc0usCtphOzv7xPbDrFzFKNsxR4HvTefWUZXyCJ
	damNZMPb/A+MI6bTGwj1qUjNQScJMK39/RKJN6e7jlV9pRwG+dyByyB1X3UWaRSZEEsFYNmigpp
	Sz5O/5Z0=
X-Gm-Gg: ASbGncuWilaGAQ7dp8lOHv50CUDg1Su01Y/C4wZhTh9Y8UbxrMFZ+7vyYCmUf+ymjZV
	HllbzOnJkzLwvVNfSIrBPbv/qGC5pVlwElavKll7bOZ8DN53vI7+e6YbAh+eBlnn77aKsARteA4
	yvGqsM7bAbQDGQClYZoYyFplFUMPiXlEb3agIelPvMXqw8EYdtaEIUjtfZXWSPtlHe9gSgQo+Kk
	XmZHwDi5HjZwbB5rmEhtS4aB7hrh7cvne8on2l+oov/yLHMuSoTQGwYtE+flKdv1OdMlylWIWEz
	omLFqm8pATt70+5k0k5jVCeAAhqfouSQaopRPrqsmyGXUx/Tj/0OBruY132jol85ICDNkztvMGn
	N0Llx7XRwsr4AHowRC/tz7pKkBgz9L+k29/Q/Tfz+3fNCd7bxUojXZIZhDNyTPp4y170PdhO6Nu
	DshlzrbkTHjHBkcH2tmRSZyZT8OPO/4cMqjwZitaF7zkFygajwzQ==
X-Google-Smtp-Source: AGHT+IFaBU6QtsMigFg2rFE3Qrx+pYOvsxmxIn9kYjPY6sR0vp8q0jgNZ9VCrHh6CJtYvwE3qYL08w==
X-Received: by 2002:a17:907:5cc:b0:b70:b3e8:a363 with SMTP id a640c23a62f3a-b72e0492480mr604262166b.48.1762719749560;
        Sun, 09 Nov 2025 12:22:29 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f37csm882279766b.64.2025.11.09.12.22.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 12:22:28 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so3578896a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 12:22:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWW6Fh288B/kuiGxKemu0e4ekHJOvR05tlz+YD5sqCGsiMRKQrCnFuf8tgraXXVsMzjhka7QPqZA0x0ardQ@vger.kernel.org
X-Received: by 2002:a17:907:60cf:b0:b6d:51f1:beee with SMTP id
 a640c23a62f3a-b72e001b360mr489809966b.0.1762719748467; Sun, 09 Nov 2025
 12:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
In-Reply-To: <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Nov 2025 12:22:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com>
X-Gm-Features: AWmQ_bkC_Y91-ng6JwGWrLQYnTWxwwp_oTGnNI2FkdTnLtXofrxPbxBR3HUVCm8
Message-ID: <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 11:55, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I looked into this in the past, 64 definitely does not cut it.

We could easily make it be 128 bytes, I just picked 64 at random.

> Anyhow, given that the intent is to damage-control allocation cost, I
> have to point out there is a patchset to replace the current kmem
> alloc/free code with sheaves for everyone which promises better
> performance:

Oh, I'm sure sheaves will improve on the allocation path, but it's not
going to be even remotely near what a simple stack allocation will be.
Not just from an allocation cost standpoint, but just from D$ density.

But numbers talk, BS walks.

That said, I partly like my patch just because the current code in
getname_flags() is simply disgusting for all those historical reasons.
So even if we kept the allocation big - and didn't put it on the stack
- I think actually using a proper 'struct filename' allocation would
be a good change.

(That patch also avoids the double strncpy_from_user() for the long
path case, because once you don't play those odd allocation games with
"sometimes it's a 'struct filename', sometimes it's just the path
string", it's just simpler to do a fixed-size memcpy followed by a
"copy the rest of the filename from user space". Admittedly you can do
that with an overlapping 'memmove()' even with the current code, but
the code is just conceptually unnecessarily complicated for those
legacy reasons).

           Linus

