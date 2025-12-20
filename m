Return-Path: <linux-fsdevel+bounces-71795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E2CD2BB7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 10:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6554D30124C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF68E2FC874;
	Sat, 20 Dec 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4d0fBRY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C92FB630
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Dec 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766221650; cv=none; b=DzSeY5aeE5WPo2l72els5dIREyt4rifVyOYv+62/yG5Q1XjZZLNolIfgAGJrhZLPFB7qLSPzsn8IGFurqIAJM4oDBBqy4eVDiHMUtL+oasEe83LOH5aUPkVGFoBFQgBTU5whp23aPJ2wegu3hUls22A8/s73rL48Mgaq2axF5ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766221650; c=relaxed/simple;
	bh=jzaT1Evj9PB3u10+mUA91p95FTlOJnj7+s7L3FQZBek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O95PvXz6zq72TUHtMPWqqW3qq3YzSXq3JLdpjq7HakizTp/+fPUll5hqtGDXwld79INSoWJKJsW+0IZoxwNyxcCwtElzbpWcgfQDEgS8LDTt6chXVWM7BZ22XoW1pkKuIOM4Xtvy82xh80SsAc/6X2uJNclm5mMlEQ4YzQKu1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4d0fBRY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so2998087a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Dec 2025 01:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766221647; x=1766826447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzaT1Evj9PB3u10+mUA91p95FTlOJnj7+s7L3FQZBek=;
        b=l4d0fBRYiBChV96juQt8k0NTqQgXdbQnefowfEFOVY79Oj1o0c9XbgbXCIH9Y7D4bM
         CpmU+SXxQaetMlSpI7qUsAMyI7MqRfVQpM4g55KoXOx6WNOOHl5noYJOqSiFqA+/mjhn
         UephKsSQCHjpuCaGYdCDiAcEgWM66VghbsBvMwwH69macedXzf/ZtqKy/eqn5vWozcIt
         o7znKphRNfwIRWMkmOWlXDnEcgEC5GKC3Bl770FnE1IEx8yhII6lnv8MmtS/bmmsQFF/
         jbw6DxVl1nXFNQbJU4qE26qc6t6C9MSGkkOemYM5lAGlrqxr6On/tmhDKcqGAfQwdnJT
         pkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766221647; x=1766826447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jzaT1Evj9PB3u10+mUA91p95FTlOJnj7+s7L3FQZBek=;
        b=xUOg6mSaLUklf+7qxdMp3Ur2/rXzYJoZ0R8Phhse4ap2vWZkKsVz9lkB9paYn25Kdz
         IZC11SfgCCmy2543C2hlJJXTqN5Qk5Oujv6AvwKopIut97FuhMMuxP0Iztnoua+hLqyP
         BZ6Ukk5oxnPCYSRNoi+7xUmjZhv32qENc5BrIGCud7gmJQ1UKzNXtkwBoeqtDrwO7P9H
         lJSIdR/XpM+RCE6KfO5UKGIzinhfqUt1zr6jKyqceeD8ekUVdRGiJcE71c99gPgnjpLP
         s5Duthje0dM94N2LteFsMDGpDzv0cg655hj18Y5/MlBj2pev40XY5GrMQG+u/DzCPjj4
         CNJA==
X-Forwarded-Encrypted: i=1; AJvYcCUFBeIFq8wiLyYlP/+NO589u4p3+5ti9L8ECW7SGHiPs+VK8b2TSqepf0IJaBYRns5RY258VN1Uasy+avsA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxh0DU0hF9OFhLhWA26vOs7ZMd+K9Fi3Bvy1ASzQ7eMbt2lxqD
	neh88swE94XyP3aFlxgpRi4eJ6e7qOkgTsjY8/5iZNQomjGVpNYKU+JJGn33kxca/ozPzNSCmyN
	tlEG7AtUfrRTkRVnhSIEIip0WQ69J8r4=
X-Gm-Gg: AY/fxX60nrKPmfyM6+fHrtL3/8lyzp9HzzrhHthht85h7bgh3YuRVsJ5ym8NdM8eYDB
	zMs5YwEzeP4DiEuG6AQkKp70rTCZLBcPtmm+v5K9bXyNg+JgIfExDizlTzs59TN+B9vqUMroXLn
	x9XP3jx6Nplgi6kzLnf/z+7B/4/0m29Gd5Z+tWEKVo+VLIVLCQ8ym5W/fIplDn1fKSC6hcpT2eY
	tpkqAKWSWms3d2FXVhDH0LGGeDKUoRwl07rbhgcbO6LJHmCvTJY0YnHc8qG0nl4XvuE9LdLItTE
	akBVcGR9NArFlMpbPCt1d2m/mw==
X-Google-Smtp-Source: AGHT+IEmigXYd5BulX1O26u2BMAXvqbVZdxOYvuP/o+WRzzJsmdr/Ygo0x3GXuA1kAzvj+HRjh2ycfBcywwwyvqxWx8=
X-Received: by 2002:a17:907:97cf:b0:b7d:1cbb:5dfb with SMTP id
 a640c23a62f3a-b8036ecbd11mr541689166b.7.1766221646513; Sat, 20 Dec 2025
 01:07:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220054023.142134-1-mjguzik@gmail.com> <20251220085826.GB1712166@ZenIV>
In-Reply-To: <20251220085826.GB1712166@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 20 Dec 2025 10:07:14 +0100
X-Gm-Features: AQt7F2p0fTm2wGdtCyetb9Y9vBtXPcBMEruBcptFCbK4jZ1oEvw0SHKfFj5SDN8
Message-ID: <CAGudoHEJaT070_rM-zp3LGLz4paomD02mp_8sDrUoDbF_wtXOA@mail.gmail.com>
Subject: Re: [PATCH v3] fs: make sure to fail try_to_unlazy() and
 try_to_unlazy() for LOOKUP_CACHED
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 9:57=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sat, Dec 20, 2025 at 06:40:22AM +0100, Mateusz Guzik wrote:
> > Otherwise the slowpath can be taken by the caller, defeating the flag.
> >
> > This regressed after calls to legitimize_links() started being
> > conditionally elided and stems from the routine always failing
> > after seeing the flag, regardless if there were any links.
> >
> > In order to address both the bug and the weird semantics make it illega=
l
> > to call legitimize_links() with LOOKUP_CACHED and handle the problem at
> > the two callsites.
>
> I still don't get what's weird about the semantics involved, but
> the only question I've got is the location of this VFS_BUG_ON().
> A way to ensure that we don't forget to check LOOKUP_CACHED early,
> in both (seriously similar) callers?
>

For my taste routines should document their assumptions with asserts.
Note this is dependent on CONFIG_DEBUG_VFS, so there is no code
emitted for production kernels.

As for whether the current behavior is weird, I'm from $elsewhere and
in that land this would be odd. If this is fine on linux, then i fit
even less than i thought

