Return-Path: <linux-fsdevel+bounces-22007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAD6910E6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 19:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC1C1C212FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FF51B3F38;
	Thu, 20 Jun 2024 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ITKLiDfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732931B3F0E
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904356; cv=none; b=fefkDdOOqJwMw++p2QED279KgM4Coc4e414Ji9r+zjuqSCux3ysKMALRTyfhF/x9fQeU9ngMPiz8wmsD/jka+PsAQGsBn2UHesum5idF9p+MncI+EAvyxTO1d4ymmIVEv9NGUoR1EQN/4Ks3A80Nk3wAD5xdaoLfNqLfFaEhgc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904356; c=relaxed/simple;
	bh=8dccsjcVOV2fX5Uk3UXiobDORTq2f/wq5FQct7x7GkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPef2y84P9lBV+C5kUPhIyPxUtOT5fGV8cMdhz7nQWJrmidrse1g2/iCw3s44pVbpLbk9ERqaynebr91Hyc0jerEXRDM8/kPty5GZ80qYY6YpP2V3MU+kDLxZaV4XIP2FNu/+BvlIc1sKDOz0ILV/7CeUOl9I/Tjk3uhxTHdj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ITKLiDfh; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cc10b5978so1219240e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718904352; x=1719509152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4lNL9JASXnLGdYr/1kKgzyo4AtEHujMDElp9Dkk/0Lc=;
        b=ITKLiDfhXqIzeYfcbvbJcUQReIfY/rex/a6/OYxkl+yeZHeCEH+sBv9wCHRmuujsKx
         HDCm+hioM3Sk35u8fPjGj2jaV+CXwIVAwHad/OlLq/Q/wyYQLkbUnBnV/vUguqxb/txi
         uchRFT2y88wqSshDC1y7fug0x15JrjFpdbn+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718904352; x=1719509152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lNL9JASXnLGdYr/1kKgzyo4AtEHujMDElp9Dkk/0Lc=;
        b=dHKHXEkOtr4pX82wYfi3CX8QWHFXoSAlm7TIXe8u4O9d5cFUMBZyBb8+2psLmkbfVJ
         S669wCbHvk/5DLZYQwskob6UHvB60SUpG4wsBm2Y3XS++QvIetRgGTdDg0k7TIKAlPmn
         boa8+Ywj3WBsFyiGEqpXocLLiF+qtqCdxnK+ozI68w2frJ1TFheir3YzBlSDT3xM4xu2
         H/tP+aHWiIiks0Wb7b1GL+ESOeLt29ejfkHzlhQoLpw0jj7e5LTYbTwClK7r6XC4Ukpi
         7v+A/ssdAVM6SiJApg/uleWqGH/Lz6iQEsl+f32vbR5gld9qp7NRbzo0x/wfiL1tCX1c
         w02Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPI8UHtKmZtAn7tD2UUgoM4KWMl5DCSUzvujNAjYzR4fY1zlVxiY9IVYYa7ee7e2CfZbTNiQt7Tzz/EzJya9Nd5+3jTq2OfkEnwi4VKQ==
X-Gm-Message-State: AOJu0YyqbyiQqQ5wlfKjMPt5i+NQuJeqWC2sdHap3iKryo5vUdM1oEsD
	pbaTJuofRXxGcAfm8QLOj1hqSx6MtIYJIuGHcNUVNOP0nOm9WvAuOxFUjAXnQQAm0nQArTRTsYE
	C9G+4JA==
X-Google-Smtp-Source: AGHT+IGulg2y70MR45pKxGpe1RMOScpSEiomgFkrnkZs3OM8c0Sh4U3cz5LMUndYvMJspe+C03IziQ==
X-Received: by 2002:a05:6512:3995:b0:52c:8591:1f7b with SMTP id 2adb3069b0e04-52ccaa5ac6fmr4277416e87.24.1718904352296;
        Thu, 20 Jun 2024 10:25:52 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdcf0sm784933566b.111.2024.06.20.10.25.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 10:25:51 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso1377031a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 10:25:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxPcAbvXPgGmRDDbTS/67Efv+jvPfHDSVrlFu1iYj6tuPtdGaBoBT/GOM3RmdggZe4yAI+L+/SBheCFUptamx1pmA3ywXT1b2hn+/7Nw==
X-Received: by 2002:a17:907:a80a:b0:a6f:6659:a54 with SMTP id
 a640c23a62f3a-a6fab607137mr441965166b.6.1718904351308; Thu, 20 Jun 2024
 10:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
 <90b46873-f60f-4ece-bef6-b8eed3b68ac1@app.fastmail.com>
In-Reply-To: <90b46873-f60f-4ece-bef6-b8eed3b68ac1@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 10:25:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6OHJKArnC2SMY-GEcMfncer0A6ELM4ZAnaRdbi12kdw@mail.gmail.com>
Message-ID: <CAHk-=wg6OHJKArnC2SMY-GEcMfncer0A6ELM4ZAnaRdbi12kdw@mail.gmail.com>
Subject: Re: FYI: path walking optimizations pending for 6.11
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 00:53, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I don't mind making the bit that makes the untagging
> unconditional, and I can see how this improves code
> generation. I've tried comparing your version against
> the more conventional
>
> static inline int access_ok(const void __user *p, unsigned long size)
> {
>         return likely(__access_ok(untagged_addr(p), size));
> }

Oh, I'd be ok with that.

That "access_ok()" thing was actually the first thing I did, before
doing all the asm goto fixes and making the arm64 "unsafe" user access
functions work. I may have gone a bit overboard when compensating for
all the other crap the generated code had.

That said, the size check really is of dubious value, and the bit
games did make the code nice and efficient.

But yeah, maybe I made it a bit *too* subtle in the process.

> On a related note, I see that there is one caller of
> __access_ok() in common code, and this was added in
> d319f344561d ("mm: Fix copy_from_user_nofault().").

Hmm. That _is_ ugly. But I do think that the untagging is very much a
per-thread state (well, it *should* be per-VM, but that is a whole
other discussion), and so the rationale for _why_ that code doesn't do
untagging is still very very true.

Yes, the x86 code no longer has a WARN for that case, but the arm64
code really *would* be horrible broken if the code just untagged based
on random thread data.

Of course, in the end that's just one more reason to consider the
current arm64 tagging model completely broken.

But my point is: copy_from_user_nofault() can be called from random
contexts, and as long as that is the case - and as long as we still
make the untagging some per-thread thing - that code must not do
untagging because it's in the wrong context to actually do that
correctly.

And no, the way the arm64 hardware setup works, none of this matters.
The arm64 untagging really *is* unconditional on a hw setup level,
which took me by surprise.

              Linus

