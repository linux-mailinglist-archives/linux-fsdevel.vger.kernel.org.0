Return-Path: <linux-fsdevel+bounces-58091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE468B29365
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 16:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A9D1967E18
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D7729ACFA;
	Sun, 17 Aug 2025 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YRl1HZr8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F542A9E
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Aug 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755439242; cv=none; b=sqmBwoyeqOuCioZWkn1xNsBA5YP2S9cANmuGhP5A2GBGCwExLKsDV579j7sDF8lGmXFpYSifW22u5TKklIQmn72ArxduLvdEoqveZ9lul7Kni7DIjFVzCqXrKWmfJoYbtBco/0utzbKS7m3eCmfcrPrZ/cu/fB+69osP7S1qWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755439242; c=relaxed/simple;
	bh=XENsuQCumYua7MioNEYzZmc2Ath362rqsq1uzx8nt/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaicSsmCQxEPWqvHXoNIoCJp+vuwIyqebz2E00/RTyKeRwVPYvDQ45w/jVeSZnagrdrvj1t4TmiBLUQj+sn47QdsLUc7AJi2721urEVSVbAnq8IV5Yjf6tHcOm8WKWcUmaDTVHWJnHWdKPAqopUpaBAOEQhB1mwtA2edH8oJLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YRl1HZr8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7ae31caso587965566b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Aug 2025 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755439237; x=1756044037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0qIavE41IlhgiieuE7QXFih894kngFLTq8gzLMbLAlE=;
        b=YRl1HZr8WhqM0BUhK2c8R6a5zZyXDhXeJAs5MckqaXH76lF0AyT9QWtFsYy7qeXHUd
         b3w3YBltKGNHyepqRntBWnt+1i8vp8fngqnqA4HIMjYKMXwJeMLMz9z8Y7q0BV4lk3ba
         t/u2mwZhGKSm/MFIqCzBAPgJ+kwdmkPZBD48E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755439237; x=1756044037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qIavE41IlhgiieuE7QXFih894kngFLTq8gzLMbLAlE=;
        b=wJP7PwB6tMpYlxUiq9+AwlQGd7PtryrWzZuaVlABlBvxxGAOno2wgPjBlnAr0r7e7W
         K5nJgks3mPYow0qHGQSDEIr2NhO/vdOoB4FpYvgzvfPGt9qBgOYa16jaH3tfVSWt9m09
         P5RIaDlik9NgFJLzquzx+3olDAeIWkrlrsBCB2Ml0ISUXIB3caxdg+LubAfmuxxyVCWZ
         9wsW9AAqhGk0bS7OJbP5qRwAmmpHlWl5LELX5qVQ6MJrsLU+urdDldrZepD0geis8WGf
         9bGtZFY/8ahnNtkTavXBxJPtxUe502T2cQkQkjvLmc71T4VPWntGbWj46fIjkCghvOee
         na+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMRubg3SOC/VBNXpTj/Gt8YVyRQzh34lemWMQjuoNGmpixzQMeqsC8Sw+bbjSFvZV1oqAkz3wujpL4z6Mq@vger.kernel.org
X-Gm-Message-State: AOJu0YzyKYit4wIGpM+I6Gcqt0dux8mVPi+d4G2HWh/4zRV70OxD+iAj
	7dlyW8FwgAK7It2FYNilkOs1tnyBObgFzP/RU6iiK/vPOYDsoZuM1x1+YcKc5D/56qHov35HUQd
	ijfh8lEA=
X-Gm-Gg: ASbGncvhXWSIL3/ydwV/HrXftogblrqo/nNKtzNZMRVfHVQUm48wKjTSPpjZVQ+ACyA
	/MKoG21sOm+QeWnqosN6Ibjbt69FVOtCPm/6B6hrU3tEH4iRDZI8r/Xg2d6byre5U7X6qQHyQl0
	rfXJm9YbRfJUjNSHPVcNKVTkmMwfsrIZZ3Zf6KNVME02MElgxy0RrjIrF/cy1KWdj2zkyPYc7WE
	Xu+y8LvEPkzQCK2/w43Jlc7vYJddsJ8xizsCRcmClU3XH62VQV9Bv1ZJ41x2YqoiXdr8iN8/xE7
	HC20748x56AWEyfQaeKbcYq+yk79YxvIVjkvs93kCb1HjJVBLxsCW5JL0P5etgyIOrFMfxvmDPJ
	tnMMaAZ9E9lYUOXerZS1sXtWed6XZMmtubmDtti39cXM+cs6KB8VnvXb48w1/ZY/ZsBiPQpsG
X-Google-Smtp-Source: AGHT+IENxjXtbzE2PqKt3ob0NR8APMaw33F+bcHE37ClhSzmo4Z4BvQ4hIFsy9RlhpWEIYHOy2oJCA==
X-Received: by 2002:a17:906:c10b:b0:af9:7333:3624 with SMTP id a640c23a62f3a-afceaca933fmr598168066b.4.1755439237004;
        Sun, 17 Aug 2025 07:00:37 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce72da1sm601019366b.51.2025.08.17.07.00.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 07:00:34 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-618b62dba21so2340853a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Aug 2025 07:00:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUR/Qb0blCDI4SHDGWLWAfhXSVydz3TFFHYAZWbDGVDy22M1p7tTHHvbk1YIocmNtvNI7cfm32BE3RYV04d@vger.kernel.org
X-Received: by 2002:a05:6402:518d:b0:618:36a6:69f7 with SMTP id
 4fb4d7f45d1cf-619b6f685dcmr4528758a12.4.1755439233322; Sun, 17 Aug 2025
 07:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813150610.521355442@linutronix.de> <20250817144943.76b9ee62@pumpkin>
In-Reply-To: <20250817144943.76b9ee62@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Aug 2025 07:00:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsACUbLM-dAikbHzHBy6RFqyB1TdpHOMAJiGyNYM+FHA@mail.gmail.com>
X-Gm-Features: Ac12FXzplb0gROZKOoqhHCUXLWMWF2cOyr2ccwN697kEaYKsDdwVzkAFtgsaAf4
Message-ID: <CAHk-=wjsACUbLM-dAikbHzHBy6RFqyB1TdpHOMAJiGyNYM+FHA@mail.gmail.com>
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked access
To: David Laight <david.laight.linux@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, x86@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Aug 2025 at 06:50, David Laight <david.laight.linux@gmail.com> wrote:
>
> Linus didn't like it, but I've forgotten why.

I think the reason I didn't love it is that it has a bit subtle
semantics, and I think you just proved my point:

> I'm also not convinced of the name.
> There isn't any 'masking' involved, so it shouldn't be propagated.

Sure there is. Look closer at that patch:

+       if (can_do_masked_user_access())                                \
+               src = masked_user_access_begin(src);                    \

IOW, that macro changes the argument and masks it.

So it's actually really easy to use, but it's also really easy to miss
that it does that.

We've done this before, and I have done it myself. The classic example
is the whole "do_div()" macro that everybody hated because it did
exactly the same thing (we also have "save_flags()" etc that have this
behavior).

So I don't love it - but I can't claim I've not done the same thing,
and honestly, it does make it very easy to use, so when Thomas sent
this series out I didn't speak out against it.

           Linus

