Return-Path: <linux-fsdevel+bounces-66982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28895C32D34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 20:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 465BC4F714A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E248B1F4188;
	Tue,  4 Nov 2025 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HPnS5BKB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56E1D7E5C
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284884; cv=none; b=q8mIJ8TOF0h8O2JZNLc0NNohH/lOz+L4L6rjMWS0xh5yem4dHk13hG6CFLso+5c+cQ83RBnE9hzn0IyHHBKGZmhFs0egW7TGReBegBndA6UlhYOglLCGEo8pCh3wakMnT9D+PNpnv4cd2/3tTsD3uM/lvKqy7QYGycXHzTzXeWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284884; c=relaxed/simple;
	bh=+0KQLznGWai2QqA3COF+wfMOTBGaiIT1pBvD3XbGrNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucdc+43ZiyRUmgZtueNXntj4Aw9Ih2Yis8RlKKgeEBiUmbMOdNtJ8qxpqXRw1DEPXy7R83VAayHwB6IQJ2Yy5s2J6k2o7fCnUWp/yxkExVzJsGDrw6bIHbNaOYDXhqehyMikeVQrGHLx2ksA/09DkUx+OjbkGR0im6mGKd0TTTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HPnS5BKB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7200568b13so284292966b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 11:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762284879; x=1762889679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kJTDMIYCy2+6jR/hKcOnnxfENzi0WCsvGq1H0Tr1Gd8=;
        b=HPnS5BKBRcxqsb8e4Buf6IWUihN39vf5859/97uZ0DvG/+WlD/6jrkHhrF4MuPbEJh
         Y0TQ/OrXMxJFvbAYmXUAKGxJ0jKKIx0Xt3DFbiX90X0I5UHISo51Mcb3cCnbRy7EhV2B
         Nyj7/dDqEsDD2T0jQiETuFNI5a2BJ4FvlvUfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284879; x=1762889679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJTDMIYCy2+6jR/hKcOnnxfENzi0WCsvGq1H0Tr1Gd8=;
        b=fFJXhBwll3WeXhFn5Ws9EXXgmzpiOEdg4K3sg/Ha0KqmtK0vegwGrbGZv+MwyrTK44
         ZdT0YOdmL/XrXHt0ArutgkDOwKxofiGA0TDysUMzingEmjNPWTJjyK8zpSakmAoWPipm
         kSb/paLROC7Jv06NJBH4q2nSghPDsZD9SUZpxR8NCElfwgSdyJVtSfS38JnPETmMhQZF
         hM/mUUq1ncUtLzexDR6DudsCzVcOoZNPHJQDBn/xfy9rTFhQRe8r9hlJohXLWIzqfNhA
         YpTKNQyYL6Zd1KqM55q5M9DJodcouvDEFzufdoLf3ZjWgxqaN1SyG0XtfutoQQkNHQpk
         t7eA==
X-Forwarded-Encrypted: i=1; AJvYcCXRnk/2ayofdUaoApWoH75c8zAjnt1JuikLP6aBqEq3jfP+usr44+Dq26gHH9HB61abiqvc5NEBJMrFeFOY@vger.kernel.org
X-Gm-Message-State: AOJu0YzFVGW+hPRMxPIB55bzZMlg8th8U+agv9XYxsXdRb43LEVRmIcY
	d7Kuy3gPEW2estsxq4pHC2UzfMvFXvFHRfk+ohJReVxYH2iANe9aUIpHRmI9T/gAYOhfa7D9dS2
	hXX729ZB+kg==
X-Gm-Gg: ASbGncv4halu6tiOGxFvjplqH1LJFtVGOwX5Hr8g9epX8CZskAixcLak6qXWo9e1bIT
	V6JwR9MCPxDCPoTQpZGjdDze3b98OdGEaiEeyj6rKWpMklcAVgiT6waXfqFeymJXM0BHZ2YNnbo
	On+CyDbZJH+hwZHXI8ChGMVPU26FJOfrEC+GTGxYTFUOX7vaVDbO7NlyTYn0CRjrMRkm65U+G86
	5WIRgmOKXAUyHBBXAkJCSsp0qYCxZ2qJ+98F7ZR4w1qdGwW40LWg/FsXgG8U6UDRlaVsu1xuBLs
	qMv2Szqv9+KHolY29QrarF0LFo9Ujoht0DOmDn9mMtvNOlNhZm9fc3tXdZyPQP0TgOuHdoJ14Ic
	5pFt/7vKPCNrkxiphWldmAYf3icW8XcxaDwEMo7rr79iyFBPhJn5iEXLLId0MwrF4ZAcDHgrTTd
	1wQa8R0qDabx1qMWL7TmKCU1gDM5mcDnZfMwhnF/N3lmjC95bsCQ==
X-Google-Smtp-Source: AGHT+IEabRsf2jIv90QQRfett2ZDdQPsEncGzA+4bTBnyeInQj2EXNK0++NIoKMZdQaXHYCa3F11Bg==
X-Received: by 2002:a17:907:3d44:b0:b72:5a54:1720 with SMTP id a640c23a62f3a-b7265682b6bmr26359666b.57.1762284879204;
        Tue, 04 Nov 2025 11:34:39 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a336asm294300366b.7.2025.11.04.11.34.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 11:34:38 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7260435287so75497566b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 11:34:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWUQJaA+xd+myLHmE1uCPyuUT8GMRE6sQWv47UsBTDsG0qMxLZ0CWN9NKDh2c1HDNdH7mAngWasvQbUOF6@vger.kernel.org
X-Received: by 2002:a17:907:1c0a:b0:b45:1063:fb65 with SMTP id
 a640c23a62f3a-b7265587595mr27576366b.39.1762284878155; Tue, 04 Nov 2025
 11:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <aQozS2ZHX4x1APvb@google.com> <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Nov 2025 04:34:20 +0900
X-Gmail-Original-Message-ID: <CAHk-=wgYPbj1yQu3=wvMvfX2knKEmaeCoaG9wkPXmM1LoVxRuQ@mail.gmail.com>
X-Gm-Features: AWmQ_blVf2isOH-EeyNpLShBliAIq3Vx5qa1nvwuHS5khsUBXtzT-rTUMVRjBpY
Message-ID: <CAHk-=wgYPbj1yQu3=wvMvfX2knKEmaeCoaG9wkPXmM1LoVxRuQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Sean Christopherson <seanjc@google.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, "the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 04:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Sadly, no. We've wanted to do that many times for various other
> reasons, and we really should, but because of historical semantics,
> some horrendous users still use "__get_user()" for addresses that
> might be user space or might be kernel space depending on use-case.
>
> Maybe we should bite the bullet and just break any remaining cases of
> that horrendous historical pattern. [...]

What I think is probably the right approach is to just take the normal
__get_user() calls - the ones that are obviously to user space, and
have an access_ok() - and just replace them with get_user().

That should all be very simple and straightforward for any half-way
normal code, and you won't see any downsides.

And in the unlikely case that you can measure any performance impact
because you had one single access_ok() and many __get_user() calls,
and *if* you really really care, that kind of code should be using
"user_read_access_begin()" and friends anyway, because unlike the
range checking, the *real* performance issue is almost certainly going
to be the cost of the CLAC/STAC instructions.

Put another way: __get_user() is simply always wrong these days.
Either it's wrong because it's a bad historical optimization that
isn't an optimization any more, or it's wrong because it's mis-using
the old semantics to play tricks with kernel-vs-user memory.

So we shouldn't try to "fix" __get_user(). We should aim to get rid of it.

             LInus

