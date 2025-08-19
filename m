Return-Path: <linux-fsdevel+bounces-58341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9CCB2CE95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 23:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE0167CCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 21:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A54D346A00;
	Tue, 19 Aug 2025 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et868i9o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4350C3469FD;
	Tue, 19 Aug 2025 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755639208; cv=none; b=X3M5HAm4o8nN/O8mYQl8U/FQQTnQKpTUcpK+yWzjQrgYHSbAaxNSNrR7GJOcIrXLWt+USdT6iikobpTotrhUOwXySUbQv+K+udnk661iMNKQpXcknweUZQFpI7plOYEDMNrX3gn5nbu3NYKy6Z6QhzAZe7za0egQIlyyGcWeE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755639208; c=relaxed/simple;
	bh=GU354q1ZBG72+J0Uii5taNooUFiqttuME/2kNXHqznI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDjACkDwBy2yURLSoikw5EBt6DDSXkz4qPR4XeXYuM4vYKX2uZo9VqqwClwT0u5FIz36AfwOVwTovA0C0neUve2npPnnJ4Ns0jJI+zPAUXub9RV50P76rwo9ib8BDJDSXiZkrjP47p2cjpNkxjO/cPJgjzIOLT1VNjqQDW5c6kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et868i9o; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b001f55so27346415e9.0;
        Tue, 19 Aug 2025 14:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755639204; x=1756244004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80crH1qcBdVhpG4y3gBnYxFazFUWcOiHS8/MQf37Hrs=;
        b=et868i9oCjQvPkbIzOPo0+JhZD+OitLMgXs+3WoJMzKhxFkB/279xv1uyL/0XdG9nU
         rSFhLnF9/Wx5R3XRvxk26vf8uiM5+glbZI7KzuHDWeogiP3vN+s3HiKJ3GRQnIp8yKpp
         f2XFhTY+uQF07YrCzo1FaQJRWwxPL+rgxZ2q0znUHHPKIJmPS47TjTlgKr9GqpR8A7ys
         LRrjSvvbiBESojw2ZfZzMFWUG9/j1lBFeDJGdC3ee9PGm/GpTcVIF7CCDXz5oe/EoYUT
         me9MlPu8QPF3pl0C8sW+rAoQLMYXKTvIewaQfhLI8Kcer5EW4PTon19rboVepW59SFkc
         gkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755639205; x=1756244005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80crH1qcBdVhpG4y3gBnYxFazFUWcOiHS8/MQf37Hrs=;
        b=lsibUeavS6u9WR0rnjlqVX9dib5M0BQfSg8MiGSRbbXdl90lrSVR6fkMU2X/AvvGHn
         Un1Y0ZqUauLOcrjEKFcb0fYd2kjisf8dAvSJ5uZ1HOCSJci6THami7qYa4mqVaSVfBQr
         gU+lrpgSGcEfbwIqSNd6jYczYm+08gn++8cLXxv7SWBfKI7/NNayMGP31Blxmji9A7lj
         WGzWlQeMTxFXyyE51WHZqtO7QLrn52H/xEHMqEx5YlGPSOeigT8jypDZGG88eQp6Gh8f
         VcLZvgAZoFFfsa14+ibdRr7p9eaKdZ1cweiK54CinfquLgv4ZcTd2Ie51Wk9a6ha/aMY
         vRJA==
X-Forwarded-Encrypted: i=1; AJvYcCW4G4hAKMY3X16nlz92iRAav9B4OdD47tig45nsMyy20Tvu0+OJv50wFIoOvMbytXlRZaVEbiLDzFqms+MX@vger.kernel.org, AJvYcCX058BGfBRoXH2AiOML7kzKYc93cxgu+2F65e6GdEHNoTtfVfiuuRZUtMtTAS/068rqeKQfalWjUjrCLWg3@vger.kernel.org
X-Gm-Message-State: AOJu0YxKi0k1w2K+IIRaWvvP1RCsfRGOdzv9EI+73VUFUWu7n6bi9Ot1
	Ei63OQkWf3LNazCJnnl9CinZ6altr5sh0x9ky3ayQA4yl75ry7TkpCVLL4PSwA==
X-Gm-Gg: ASbGncvNMECG+cY0vpGrNuBMw/IdH0Pmi5r18844kHTMdZV3pQFZOFs54Ci7NEeM4pJ
	AxvFONSBnppgO4VPGp04Tcbh35f+TiFSg11vjjW7VjhIlosVIpDGzSWeiQvxaTs8/Z233U1ej04
	R7QD1/k6e1WGSI9HWZ+PO+6wvgp4ffJUno5IwpmDYaYNq/9apHF6IAb9KRzdzm2DVjy4WJ7PMJz
	1bhr4sXuDk3UyFlJ8iJ0COVSqInOCR05T+BXqlhP+EaX4F/syw6pM8IwKlTdQ+UAewdjNf7qZD4
	GpXbhriScpGPIikoG5LnMhdUJgagfI+m3VwIB4WiyAWA3360vNlsubaQmWXAOy7g9aoKiDEI5Ct
	4RFTExR2OZOkIO21EJQEuINk5WbZqAErAOGTsJeH7e8UTVhLxqhxfbuFoUzga
X-Google-Smtp-Source: AGHT+IE9kfEXkxy3UApT6dr6qaBy55BbmWLGiqW9bfYWYRifG1Jor2p3xApDPaln/O7Q9ZwACtOmAg==
X-Received: by 2002:a05:600c:4f8c:b0:458:a7b6:c683 with SMTP id 5b1f17b1804b1-45b479a5eb1mr2433455e9.1.1755639204291;
        Tue, 19 Aug 2025 14:33:24 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b43e13eafsm19770115e9.9.2025.08.19.14.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 14:33:23 -0700 (PDT)
Date: Tue, 19 Aug 2025 22:33:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked
 access
Message-ID: <20250819223320.5ea67bea@pumpkin>
In-Reply-To: <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
References: <20250813150610.521355442@linutronix.de>
	<20250817144943.76b9ee62@pumpkin>
	<20250818222106.714629ee@pumpkin>
	<CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 14:36:31 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 18 Aug 2025 at 14:21, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > Would something like this work (to avoid the hidden update)?  
> 
> It would certainly work, but I despise code inside macro arguments
> even more than I dislike the hidden update.
> 
> If we want something like this, we should just make that last argument
> be a label, the same way unsafe_{get,put}_user() already works.

A 'goto label' is probably a bit more readable that just 'label'.
But there will be similar code in the same function.
But it can't use the same label - one needs the 'user_access_end()'.

I wanted to allow an immediate 'return -EFAULT' as well as a goto.
But not really expect anything more than 'rval = -EFAULT; goto label'.

I do agree than some of the 'condvar wait' macros are a PITA when
a chunk of code is executed repeatedly in a loop.
There are also the iover iter ones, did they get better?

> That would not only match existing user access exception handling, it
> might allow for architecture-specific asm code that uses synchronous
> trap instructions (ie the label might turn into an exception entry)

Unlikely to be a trap in this case, but I guess you might want jump
directly from asm.
OTOH the real aim of this code has to be for all architectures to
have a guard/invalid page that kernel addresses get converted to.
So eventually the conditional jump disappears.

> 
> It's basically "manual exception handling", whether it then uses
> actual exceptions (like user accesses do) or ends up being some
> software implementation with just a "goto label" for the error case.
> 
> I realize some people have grown up being told that "goto is bad". Or
> have been told that exception handling should be baked into the
> language and be asynchronous. Both of those ideas are complete and
> utter garbage, and the result of minds that cannot comprehend reality.

Test: which language has a 'whenever' statement?
IIRC the use is (effectively) 'whenever variable == value goto label'.
(I hope my brain does remember that correctly, the implementation of
that language I used didn't support it.)

> Asynchronous exceptions are horrific and tend to cause huge
> performance problems (think setjmp()).

The original setjmp was trivial, no callee saved registers,
so just saved the program counter and stack pointer.
The original SYSV kernel used setjmp/longjmp to exit the kernel
on error (after writing the errno value to u.u_error).

The real killer is having to follow the stack to execute all the
destructors.

> The Linux kernel exception
> model with explicit exception points is not only "that's how you have
> to do it in C", it's also technically superior.

Indeed.

I've seen C++ code that did 'new buffer', called into some deep code
that would normally save the pointer, but had a try/catch block that
always freed it.
The code had no way of knowing whether the exception happened before
or after the pointer was saved.
And it is pretty impossible to check all the places that might 'throw'.

> 
> And "goto" is fine, as long as you have legible syntax and don't use
> it to generate spaghetti code. Being able to write bad code with goto
> doesn't make 'goto' bad - you can write bad code with *anything*.

I fixed some 'dayjob' code that tried not to use goto, break or return.
The error paths were just all wrong.

	David

> 
>             Linus


