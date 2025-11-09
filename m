Return-Path: <linux-fsdevel+bounces-67604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59446C44686
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 20:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE7A188CB26
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 19:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F1C20A5E5;
	Sun,  9 Nov 2025 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3xv8v/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C05224220
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762718156; cv=none; b=f2BtSIL8FPu3P7cZ6n34Kkwwh8kJ/2bSSTCxRmRI5RDem5NR2VDQPMh99fniZwj57QKgQ22vC4n2vvDCQmFvCe2L0eo7QdSzmywwmeaPl8Pbzk4p8IHtweGNKN8AQdIH/dP8bXJbTm99yEAiiXtC7qcgp0Og4O2hnSVKGs0Zpps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762718156; c=relaxed/simple;
	bh=Ji6DwMlMN8CaxkUNYoWO0yeIXZAwhuvFRKjf56mogUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EECwfngjEMpaQxdUgGpyaQnkPo2URLYDmHQ6jbgvyjbikMcQp4xxnPN+1XkKFcmy2UrBYQeWyVO4CJf+q20IPw8otFJcznN/KIepMM+J56PRUvECqLtsopEwGJqOi8dey4NnKsvyGkg18l1/rUYm9qpSdj/adwEmT7vo0Jvguic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3xv8v/B; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b72134a5125so337103266b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 11:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762718153; x=1763322953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcyRvQ5BWmuhxa99TkWLL6vqD6kswgiu0T8eLECURAo=;
        b=h3xv8v/BAeisJeh4XxXkOR45HsuscxT/YlpsLIyj4jSXGA0xZlWY5qLfUYb8+K31tL
         LjDs+pFpiRIR2hPrrFZeXGKd5A5XBzgHDom/Po5KjNbCPEK7E8dNL2eBh0bPvyHXEbxt
         +jexPIhXiDNgtN1Hs8DuIFRwLkPP9aW+sfK9hApf2BIs8wvlvp1zhM6gBlY++e8I5rPh
         qNxmX3huDRJum0c4rQBwRKpzMqtETmuKWHlrJKf5kHZoJ88PNl1WRkVB2/stkRT/c4/l
         DlX4rVYMPwL4YX8tbkxpA2h3P7nw5SWiZNrwD9NfMPxC3XaynVdyWBRlEWpQ3RkDXfd4
         mI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762718153; x=1763322953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcyRvQ5BWmuhxa99TkWLL6vqD6kswgiu0T8eLECURAo=;
        b=Ryr8hCwabUsTOk/sq4KnZbCsWTRIUjwMwltB+fS57sfo+4qB7+tuIb+6hwUaKjkc6a
         6fG/+BmfnL2RTIyQP/Yy+sd10pV+jA3puEiy7w13tY/zq5/a7ZAA8YteykBpkTgm7lex
         tCgm/3L9E3NI50nKMEgLREzTE34OMC7XcjLUBKNfV+1LCInCecHwkLcP3GHDn8WW+xax
         OfJQOWJVwmFMVSW4Xv2H+0otORpLVf37HaWNlqOzw39urMOpHeCjb/rFJwFL2q5gUDjy
         4VZ+SbZDTz53kqy/D/4Re4oZW4RwhsKAhlTx28/YnwK8TjKqHyRnCo55UfjnZjp5HfcB
         UmwA==
X-Forwarded-Encrypted: i=1; AJvYcCVPYtBtTIn+gNFN0PYYmOq7ZBZKFyzm8GXR+Jt8IsHuGkfg4qNvrfSLboUJB2Wbvlv6R4/hnHiHlOSEFyZH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Az7jYvB6o1ZeDRYStPjTe3LhuydJ+15ZwaEvAJuKhF2cWY6r
	a6XWq3wDP2D5pQ9OMqfuSOL7AOAHipZDzUK1cNYn8K4Acaguol0Gms+dtS+DVx5wINjxsr58Th5
	iMxL2H8OCn2aaXGhIHBoTpsK3ZcVGoCk=
X-Gm-Gg: ASbGncvnsE3s0KA+e5e3rVVX3Ye1a6LRAI36G2MKOQc4LnOsjHTxii8g1LY4OUhU5Eo
	xRdVvdQoqhwGZpUzAo1wnbtezYLsVX7ecsazZCwnn1/cfKiPWRNde1mEYcr91vHj9iqbqiDLEWS
	bAbNABdtS3H1j2Usc7TzAGGJLI7s2UXc8x+DGhwmwWp+QzrdaWRXIK2FZ6VSPw2PLYeowJ/cSgQ
	KJVA1qhrH1CgBQn+dUmk3axjC3IrNmLe36BuZxOShbEDSU0NbLBYPSnctglfdd4m7VqoiIJRB0B
	1LsaSJ602+zOSG6yj/Sie8DHcg==
X-Google-Smtp-Source: AGHT+IEJCgiSucxtulit9BfgtiUFhXxGXU3X/Af+a3d5W7s6ZwCxLSq9hCronQnPafiuMWNaswfyJjDhfpl/FqcUENI=
X-Received: by 2002:a17:907:94d1:b0:b72:1b8b:cc3 with SMTP id
 a640c23a62f3a-b72e05626c9mr673442466b.33.1762718153194; Sun, 09 Nov 2025
 11:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
In-Reply-To: <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 9 Nov 2025 20:55:41 +0100
X-Gm-Features: AWmQ_bliPSq7XXfs20U05pA0IPp_kEb85lD9jJkcNmzDbC2EW1Ybr__mANNaRXU
Message-ID: <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 8:18=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 8 Nov 2025 at 22:38, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > These days we have very few places that import filename more than once
> > (9 functions total) and it's easy to massage them so we get rid of all
> > re-imports.  With that done, we don't need audit_reusename() anymore.
> > There's no need to memorize userland pointer either.
>
> Lovely. Ack on the whole series.
>
> I do wonder if we could go one step further, and try to make the
> "struct filename" allocation rather much smaller, so that we could fit
> it on the stack,m and avoid the whole __getname() call *entirely* for
> shorter pathnames.
>
> That __getname() allocation is fairly costly, and 99% of the time we
> really don't need it because audit doesn't even get a ref to it so
> it's all entirely thread-local.
>

I looked into this in the past, 64 definitely does not cut it. For
example take a look at these paths from gcc:
/usr/lib/gcc/x86_64-linux-gnu/12/../../../../x86_64-linux-gnu/lib/x86_64-li=
nux-gnu/Scrt1.o
/usr/lib/gcc/x86_64-linux-gnu/12/../../../../x86_64-linux-gnu/lib/../lib/Sc=
rt1.o
/usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/12/Scrt1.o
/usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/Scrt1.o

Anyhow, given that the intent is to damage-control allocation cost, I
have to point out there is a patchset to replace the current kmem
alloc/free code with sheaves for everyone which promises better
performance:
https://lore.kernel.org/linux-mm/20251023-sheaves-for-all-v1-0-6ffa2c9941c0=
@suse.cz/

I tried it and there is some improvement, but the allocator still
remains as a problem. Best case scenario sheaves code just gets better
and everyone benefits.

However, so happens I was looking at this very issue recently and I
suspect the way forward is to handroll a small per-cpu cache from
kmalloced memory. Items would be put there and removed protected by
preemption only, so it should be rather cheap without any of the
allocator boiler-plate. The bufs could be -- say -- 512 bytes in size
and would still be perfectly legal to hand off to audit as they come.
The question is how many paths need to be cached to avoid going to the
real allocator in practice -- too many would invalidate the idea.

