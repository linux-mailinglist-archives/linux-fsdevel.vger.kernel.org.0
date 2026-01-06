Return-Path: <linux-fsdevel+bounces-72538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E863ECFA7B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 20:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EA7A300D412
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 19:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A2359FBE;
	Tue,  6 Jan 2026 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTAW00IT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1F359FA5
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725002; cv=none; b=cgg2HUXLLlTUAC2AxF8Nb1aHuPcPv4xTrEEYZf1XjwMgDfXAf1qHGFKgIMoFcYJuVRqZ9x/Rk/c7uyKEDwQwgmrH470vkMpkDDw8tyW1w2vwRNsiVaBSHG0de/hZ2r+jTh2vlS/dU9tnOgtYao6qH6uyJFUvqPLll77OWt7G0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725002; c=relaxed/simple;
	bh=+hgXtvwaG0Luhj+7jS4/1WIg+U754WDTLyVGK0ofmHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n+naF6tBF6T99mh4Hlewx0o8Ab7SnfY02xQrfmRXzp+1xUSUOEctjx22h2oJf3Yubux8lCtxazBgJRGQUolT0ExYN0cRgFt7f3AWniKR9sIQnjqTerHWkvV/UvEI4p+j4px/Y2ayMSp0WKtpasscqyRA1dLRNiJMzZYV9x/8k+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTAW00IT; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43065ad16a8so688625f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 10:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767724999; x=1768329799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q9kRQb6TCp9mLA5G8uSGQS65VbTtuKHR0kMxDo1y8mc=;
        b=DTAW00ITyLnbQBDYcYCXFcRZynF4aeOlu+aqSYI1ZlSN8pbLHPgWhxDG8x8+EsDmMa
         tPLgi8Dr32r6zqGhu9e2reA9E15x3hoIPZ+36dqdkLW0qqhFRN9tN8fbA9/hImJHN/lB
         CcUsBxWb9LGttwhgctmyJojNxCOnh9cbmriPxOU/r1SXEAxgtftYweLor07za++DCiLE
         h6H/sOICzWwklw2vJlipcY6oq2OgW+SYWpogwTrM4yC2D4sNxP5QTmOl85PyC4u0yEQ4
         AuU8fwSYYv9FpGa5CHSPGZ1uJRw8UmeButZnD31CP9XmwUuR3+41a+B8pmneGY0flVhi
         vKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767724999; x=1768329799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9kRQb6TCp9mLA5G8uSGQS65VbTtuKHR0kMxDo1y8mc=;
        b=Mb8bo03JLlWf9yW7511cH7xYTvvnPQPVxcoJBYdnrrYLSYESjYKHIatLXViZTyOyNq
         D5FAWJT5UntwCxBG3kr3Tw6/0lZ2SBPOetPwVBKY5tu9FxE4YZs8AXByiuCQOsw4dfUf
         D6rE0kvxqtgKJhJOTg2ILjYdey+1Hn4LfDV3feJ7FUFVMqEbeSgL+9+nV8TdLjNXyUuP
         XB2Z+MVhEedgP3do/X2aM3vnhGORRTlsOEuk+AqfstBRNSw9qxyKm3eOnVGWa++EudFj
         5BYvtaCGzGDDfr8DPXURdB/yFYdH+An6W7sqZBeAaFMlbfJjeA7cdICXy/7QnMIfRo76
         47IA==
X-Forwarded-Encrypted: i=1; AJvYcCUgAhoX10fAsK/58P+vo2Z4Ujhk6mRyhWAfRaj+XoR2EJhmvcDC0hU0sAgqke4qAaeKNpGbiH/X+r6UvmAi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9TnVrVzz6iyp2xprSw9ktHZfZrmggkbIrRDl3dio8gc4dfX1J
	Z6F5EKUtclXk+kZKNDI2Pia9ZNQ5ytD/WAGu+M6AQyec7RJopzHRFKhpyz/Df8fE0LTo+28o+Tb
	ozv3AOJm7baL4QtamCA==
X-Google-Smtp-Source: AGHT+IGVcCDObMivGZ6ItRLBNbRjswIjQ3SNYuJmmzi0+OqW9p2tg/ybCzvxMsorncSHo3wGn72koB3zTO666Zo=
X-Received: from wrbgv17.prod.google.com ([2002:a05:6000:4611:b0:430:f5d7:f015])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c0e:b0:431:752:671e with SMTP id ffacd0b85a97d-432c363280fmr199767f8f.15.1767724998951;
 Tue, 06 Jan 2026 10:43:18 -0800 (PST)
Date: Tue, 6 Jan 2026 18:43:17 +0000
In-Reply-To: <20260106152300.7fec3847.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251231-rwonce-v1-0-702a10b85278@google.com> <20251231-rwonce-v1-4-702a10b85278@google.com>
 <20260101.111123.1233018024195968460.fujita.tomonori@gmail.com>
 <L2dmGLLYJbusZn9axfRubM0hIOSTuny2cW3uyUhOVGvck7lQxTzDe0Xxf8Hw2cLxICT8kdmNAE74e-LV7YrReg==@protonmail.internalid>
 <20260101.130012.2122315449079707392.fujita.tomonori@gmail.com>
 <87ikdej4s1.fsf@t14s.mail-host-address-is-not-set> <20260106152300.7fec3847.gary@garyguo.net>
Message-ID: <aV1XxWbXwkdM_AdA@google.com>
Subject: Re: [PATCH 4/5] rust: hrtimer: use READ_ONCE instead of read_volatile
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, lyude@redhat.com, 
	boqun.feng@gmail.com, will@kernel.org, peterz@infradead.org, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	catalin.marinas@arm.com, ojeda@kernel.org, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, tmgross@umich.edu, dakr@kernel.org, mark.rutland@arm.com, 
	frederic@kernel.org, tglx@linutronix.de, anna-maria@linutronix.de, 
	jstultz@google.com, sboyd@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jan 06, 2026 at 03:23:00PM +0000, Gary Guo wrote:
> On Tue, 06 Jan 2026 13:37:34 +0100
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
> 
> > "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
> > >
> > > Sorry, of course this should be:
> > >
> > > +__rust_helper ktime_t rust_helper_hrtimer_get_expires(const struct hrtimer *timer)
> > > +{
> > > +	return hrtimer_get_expires(timer);
> > > +}
> > >  
> > 
> > This is a potentially racy read. As far as I recall, we determined that
> > using read_once is the proper way to handle the situation.
> > 
> > I do not think it makes a difference that the read is done by C code.
> 
> If that's the case I think the C code should be fixed by inserting the
> READ_ONCE?

I maintain my position that if this is what you recommend C code does,
it's confusing to not make the same recommendation for Rust abstractions
to the same thing.

After all, nothing is stopping you from calling atomic_read() in C too.

Alice

