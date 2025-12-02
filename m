Return-Path: <linux-fsdevel+bounces-70428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A3CC9A0D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 06:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 025DF345BAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 05:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189012F657E;
	Tue,  2 Dec 2025 05:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR614oB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0521CD2C
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764652251; cv=none; b=a1u0lJXtcFt0RleWKK/hNcVSJLuuxhkFZFRzlogo38iK9byYhs6NmU6ix1CNM3JZI4D9sNk7wC81gifpg5tSpgns8zEs0q/Lx64wp3/sIzvInMa+Qw9fVy3QwmzB07gytaam4vZIvRXRl0LNQiHfcpNCaTPFItLP2KF/+nRgff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764652251; c=relaxed/simple;
	bh=OOlnvxB//PY3/7GxBCPDOr4QsfmO+6hoKnoz5Dw6ifg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFMYwW6+f7o6LIR0V5KmspWlSDimnYVw7/3LCOKDaGe9V6tdqmQdWJye1X03blRgiOAWXTwCkiJs+QMkDJH7iHd2DkKZL18KLM0s/MocpYemXbQ6O2MtzDR7v0wLh7N7FyIbNO43AJsTDKmc4hBh9ElOM7wm1HacB4Zo35lOYW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR614oB+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so8910421a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 21:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764652248; x=1765257048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uBhanQ8KpJxSAW+O7JHC3+b6tU/9VSLrPWBsWn5J9M=;
        b=OR614oB+nzGd7I/9sZ3F2Du3qDrtKK2qy6j2Qg8mJYSV3aOlIt4diH7XgklJEKBU6b
         USrLpH8c1KyH2bhNQf0GtN5iQk8IsUUIwbvtAWqF6/kuSEroERv5eWxjGdp5CaRDCGg2
         Bv3RS6MXTxX2QLAhVc6KoiNRicTCPIc6rQCwYs21YfqQ0WGX4gb7LZHBg6vv8T4xD3le
         dtCiWMpBA+dwfdHtbcaYQ1m424JGmq6/zpa8n88Iua3gzpH50Tf5rtAKvniUjea44yRo
         8tRyaAvRr0IfYyqrzwj3nbwvHCZ7rchIXB5tUDZKVflDW193d3QPdRmXF/nNB3NWWod+
         mOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764652248; x=1765257048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2uBhanQ8KpJxSAW+O7JHC3+b6tU/9VSLrPWBsWn5J9M=;
        b=IQ4se6v8msChGWYStfYpLtzTTAi7k7Nng9872B8Qx3MgbkKQPqUDjI/OGk1108ifQl
         KIzsEeBlTVCVZRijnr12MouqHvZuSxYwYuOAfDymt9dG66AUCBbRblM/+QobWH1N1Jc9
         gq2SFvnpUT2qY2iWMr67/zNodwq38RyA2CEvcrElhw9wq3kJNrJwLyDeHT1sNQ39vXHr
         mjoINOz3GVvILoZb5txhzsjwystZGK8waACnRflNY1AEafQQEc7V/S9I2NyerG3cutdJ
         +wJgHnrbZO4yfqwEhavkryaXbbCs0pDXz3DnC+9haXlBBQIaA1KKRMpAIAplo+Ohs7oJ
         TUYw==
X-Forwarded-Encrypted: i=1; AJvYcCVBxUCjHtOx6eEWtbNyu/r/z276dYgO6icjLtUtcU+AhTOP3UJw2YfuIO35O+kWcU04HBBsEvfsymWE/aN4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8JzSoZo/ykNQVSCkFTbGkt6jVUANra24Jx2IgHdlMD5sa6bl
	8x1cQRV+3PPmzdkUMVzwxLnYFVqz5zBtETbF9D7w3OSQe91Ao0YWGHB94b3ksvPbDBZldbNpYQU
	AIyXJN1MlGCKEpS//2hxjGRriRGYnOls=
X-Gm-Gg: ASbGncutGPgkEDCz27CYMFJE2DXulk5q1k8/mr5myTKP3Ke6gTnB1m/g3wjupCKakTs
	4UkTK6kJzM52nUESp14JVaDJaZ+nnAnip5LBA2GzcO56Ypr2IQodXvoxw0592ARMwC6B6srIySI
	ghUOMqmOgY7fmXxmtju0qe7pcub7P2HNxpDxqpC9LTFZQDfomLpmRji71xjz5nPWWgRFniJdbht
	CPkHALq9xt3DmnKTlHn1R34CVkNRLngSN1qUXP5xT44Tn43Dfpx8ly3zed2q82HD76uJZgCkF8r
	6W37Dxn4s0q4eKg8k5/FR91mofZAtydsbkW0
X-Google-Smtp-Source: AGHT+IFIf/Xj7rTWnWb+mhm0a3WMxYvrfX4MiJJiQvNY5K6hMBZniy2gIErDtqROizNqqtGWjObepk8eEYTZLq0rRgc=
X-Received: by 2002:a05:6402:2708:b0:63c:334c:fbc7 with SMTP id
 4fb4d7f45d1cf-64554675419mr38455771a12.19.1764652247901; Mon, 01 Dec 2025
 21:10:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201083226.268846-1-mjguzik@gmail.com> <20251201085117.GB3538@ZenIV>
 <20251202023147.GA1712166@ZenIV>
In-Reply-To: <20251202023147.GA1712166@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 2 Dec 2025 06:10:36 +0100
X-Gm-Features: AWmQ_bkAD47ivpXrQznnvskPa4o2COXEmT2mlE9Rv9PpEuw-MLOU4Z_GIqB-RTI
Message-ID: <CAGudoHGbYvSAq=eJySxsf-AqkQ+ne_1gzuaojidA-GH+znw2hw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: hide names_cache behind runtime const machinery
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 3:31=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>         FWIW, I wonder if we would be better off with the following trick=
:
> add
>         struct kmem_cache *preallocated;
> to struct kmem_cache_args.  Semantics: if the value is non-NULL, it must
> point to an unitialized object of type struct kmem_cache; in that case
> __kmem_cache_create_args() will use that object (and return its address
> on success) instead of allocating one from kmem_cache.  kmem_cache_destro=
y()
> should not be called for it.
>
> It's very easy to do, AFAICS:
>         1) non-NULL =3D> have __kmem_cache_create_args() skip the __kmem_=
cache_alias()
> path.
>         2) non-NULL =3D> have create_cache() zero what it points to and u=
se that pointer
> instead of calling kmem_cache_zalloc()
>         3) non-NULL =3D> skip kmem_cache_free() at create_cache() out_fre=
e_cache:
>
> "Don't do kmem_cache_destroy() to those" might or might not be worth rela=
xing -
> I hadn't looked into the lifetime issues for kmem_cache instances, no ide=
a
> how painful would that be; for core kernel caches it's not an issue, obvi=
ously.
> For modules it is, but then runtime_constant machinery is not an option t=
here
> either.

So IIUC whatever APIs aside, the crux of this idea is to have
kmem_cache objs defined instead of having pointers to them, as in:
-struct kmem_cache *names_cachep __ro_after_init;
+struct kmem_cache names_cachep __ro_after_init;

I thought about doing it that way prior to runtime const machinery,
but given that said machinery exists I don't know if that's
justifiable.

To elaborate, while it apparently was created as a hack and does not
work for modules, it does not have to be that way and I would argue it
should be patched up to a fully-fleshed out solution.

Everything marked __ro_after_init is eligible for being patched up to
avoid being accessed, including numerous kmem caches.

Apart from those an example frequently read var is
percpu_counter_batch, which for vfs comes into play very time a new
file obj is allocated. The thing is also used by some of the
filesystems.

So if one was to pretend for a minute runtime-const *does* work for
modules and there are no header mess issues and usage is popping up
everywhere, is there a reason to handle kmem differently?

Both with your idea and the runtime thing extra changes would be
needed. in your case the thing at hand is no longer a pointer and all
consumers of a given cache need to get adjusted. If instead one went
the runtime route, some macros could be added for syntactic sugar to
provide the relevant accessor + init, which should be very easy to do
by wrapping existing code.

So I would vote against your idea, but it's the call of the mm folk.

