Return-Path: <linux-fsdevel+bounces-58221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886BB2B447
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 01:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F581BA1418
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 23:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE8714AD0D;
	Mon, 18 Aug 2025 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VXIqH0J6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7821D3D2
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558072; cv=none; b=l7J0guMP2jdEgbZhluax6YcFruUfJq+K8i9/9LIzmC/nI1SJsSCmh5IYfgxraYzJCBP4N/yLcmTTmvI8xzASSE1cKkJzEsJjtUw/BoFun4wX4KIpCsybL2yX0k9/95kqqxaTR11LuglYOfnUmxiSjaQXKyfSulbGWr95KLkOvMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558072; c=relaxed/simple;
	bh=HRNJeJuGb/XA8OYTD6hs1ZiVROyyrC798bMA5h1n050=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agLyj0jhfEtciF/Pzblx+0OgnUJtuGOyFx1CnjGvXWVLeC95o9nD3Ao8Q4k2qaa3DE6lPA0Oc3UYzQIQxtoNfa7UAIYuaDKd16ary499I3XqR3OFVcYy3C3Z2kMWyjKC0832s86+6HAi/XGhkdAQA70JKi/kkSG9d4x/fnuaTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VXIqH0J6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-618b62dbb21so6159472a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 16:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755558068; x=1756162868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=17llHjHP+b+V2SJCZ0PRBv0FMcxdkNEYJQnyUnS6msU=;
        b=VXIqH0J6aKKYIRg9x6Ht74qidtTNIk0AMn8VQnu5PqE4EGvgo2HDudsJWmpIU4nYoA
         kr2bQ8cM6fGCsBzEStykQ62izmabu3q9CM+zE6Ol/K03AZRI3P/9tnR3cGMXhxROaepA
         CyZ4Plkdf1fW88KSP5QsujWc8suh8DHU+dzfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755558068; x=1756162868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17llHjHP+b+V2SJCZ0PRBv0FMcxdkNEYJQnyUnS6msU=;
        b=ezD1gDPXK5a8P5Xg71OQ7mkO2vAwRdCl7jAZTArovQInbUQlmOz/RwN6PWH+0ZwbaH
         6fxlD5kXr4bzUICWAQoXpj6tcL0ktdjRaKStTFMStw6CjXgnL/2S5YjEH9uHqcQQUI4j
         7cFZZ7xoV2nuPxDCamOKLGYA/ooLPiBV6O5GaVFIQqTUcqS+IgGjkyKzdjshMiNsoYjq
         gyfiMpW/wYX8IlVg9K9/0r+ZNh2TyZXj4duGwjN3uQ3mEHuKoz0rOmNbeMYOVe8VnO5q
         9CCrMX6w7iSnTHtzLY2OExHErrRDH6rLky6INFtF7grwbexeXDFCpLf/2hEF4RW19gFf
         O3gQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6vR9fqYC4/ylj2ljLJPsniCrgEW7lilWD7pAYu1uMS89UsoqISgAcEN31uTNHRdirnIjt1QvB3so5nm5J@vger.kernel.org
X-Gm-Message-State: AOJu0YzG8p0+6aS2xD7k264OfFb8IpZN1kuA5osr2nKT1xX2+H2cejP3
	yXIpM8HYNYttEr/vPxFaCWuDPVjQMcrp6Nk+fnMhe2wixXUj/GoDjsQCuHiwkoyDVqPCQ6KYcU7
	u9XU2ndE=
X-Gm-Gg: ASbGnct6Mow0kuM521Pv7IScShSMKWPNzTvRvZTF5dE0Qih81Vur2xAAsV3flYhqTEz
	DyLo3ekFb05IMcmwumsQSI2DdZyGVApfg1NPocrjWCon/TX1BBBQ7eedjJHu0mz5wWqW83xhmWu
	TiF2NJQYOKTaySRam/izp/egI0xdNRqswlxpt4o6HrnyWQSkz1kaoypTNSKR4AuAcNeuBn68J1F
	i3I7UwurA+DzzMz6e3KPrY6Zz0hu4lbj/FqlSMzs6uGB+TZu4T4/taPuoh5fz2VJUTRg2Ps3DeX
	R6uLFXOY8ZOJPq/HGYXl/CJ0H8GeSnsTGXX2X7jgOSGb5iDJKJ/KaiQE1yRUEWswV2l2c2ZQN48
	35VEfYnWu0KOlZUdKrzAyC9SGlM0NFK0dTPTqtkiGx7VkU5M/1GSftSUSm34zXELQJcKEs6vHOi
	REN5RE7oo=
X-Google-Smtp-Source: AGHT+IFa5LY3c5rOz80mDUaKbqDPSFv1g/F7Vk/wQSl7zesXY/I5bbcR8NpTSXXqfHpVdPrLqbXhxw==
X-Received: by 2002:a05:6402:52c8:b0:618:37e6:a489 with SMTP id 4fb4d7f45d1cf-61a7e70c2f4mr221748a12.16.1755558067628;
        Mon, 18 Aug 2025 16:01:07 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757936easm599691a12.38.2025.08.18.16.01.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 16:01:06 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-618b62dbb21so6159254a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 16:01:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW65mLsAin1RaoJV0SCN7+FpF97NvJp1zQXt/X9xmryX7aXZjVQOyFfEC8f+3+80gVFfHImpbGsaLc22S6p@vger.kernel.org
X-Received: by 2002:a05:6402:210d:b0:618:3a9d:53df with SMTP id
 4fb4d7f45d1cf-61a7e747c19mr213830a12.17.1755558061328; Mon, 18 Aug 2025
 16:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813150610.521355442@linutronix.de> <20250817144943.76b9ee62@pumpkin>
 <20250818222106.714629ee@pumpkin> <CAHk-=wibAE=yDhWdY7jQ7xvCtbmW5Tjtt_zMJcEzey3xfL=ViA@mail.gmail.com>
 <20250818222111.GE222315@ZenIV>
In-Reply-To: <20250818222111.GE222315@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Aug 2025 16:00:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvSAi1+fr=YSXU=Ax204V1TP-1c_3Y3p2TjznxSo=_3Q@mail.gmail.com>
X-Gm-Features: Ac12FXxULL4QK8KXBA50iu4xiKeMFDhhLCw9cvXUyNBQ0OP1pxsh2LoxfQt5QCI
Message-ID: <CAHk-=whvSAi1+fr=YSXU=Ax204V1TP-1c_3Y3p2TjznxSo=_3Q@mail.gmail.com>
Subject: Re: [patch 0/4] uaccess: Provide and use helpers for user masked access
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, x86@kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 15:21, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I suspect that folks with "goto is a Bad Word(tm)" hardon had been told
> that goto was always avoidable, but had never bothered to read the proof...

I think it's just a combination of compiler people historically
finding purely structured loops easier to analyze (back before modern
things like SSA).

Together with language people who wanted to point out that "modern"
languages had structures loop constructs.

Both issues go back to the 1960s, and both are entirely irrelevant
today - and have been for decades. It's not like you need to actively
teach people to use for-loops instead of 'goto' these days.

Now, I don't advocate 'goto' as a general programming model, but for
exception handling it's superior to any alternative I know of.

Exceptions simply DO NOT NEST, and 'try-catch-finally' is an insane
model for exceptions that has only made things worse both for
compilers and for programmers.

So I do think using labels (without any crazy attempt nesting syntax)
is objectively the superior model.

And the 'finally' mess is much better handled by compilers dealing
with cleanup - again without any pointless artificial nesting
structures.  I think most of our <linux/cleanup.h> models have been
quite successful.

                Linus

