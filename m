Return-Path: <linux-fsdevel+bounces-47795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C077AA59E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 05:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB5E9E0A75
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 03:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6F022FF5E;
	Thu,  1 May 2025 03:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gK3uiB6I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2226679C0
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 May 2025 03:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746069163; cv=none; b=XyjU5jiqQbdhCgT31YkuPbZz1ssC99amJMJxX+OiDPCSWbNuzQMKDN5XSOGZTLEd1/OTbpFcJ+CdweCHtQoKwWYW5b58R7GDCahZGTljKNMEevb/WKVCWhwh1to4Jgyn+zlXtTQMnSLnjXbGjL4wwtV9eQ5Ga9mbD0WoosuOCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746069163; c=relaxed/simple;
	bh=3Qs+LMUQu4ZZ9m3bGStlH/F2gPjLzRKPh3ITFdqZ4EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqftmgZjF/gLP+Mf0XmijRwWw9B1ij1sFnIgy8TiQri8qzJms9nmaHd/lpCXbYmVAHiIVGjrVERnLsIF6WkIM/2RIZm9UGIqb9cj7mWWFmX/qt093hLWidFGPT5+CsxJF3nuOSOUeRiggVjxV9FWotcoC8j3x49XIRp7PGIAvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gK3uiB6I; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso92535366b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 20:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1746069158; x=1746673958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OC1oQVKn70KzlSasLkTsE0MQR+OTmhnwfBz3Xe1R3C4=;
        b=gK3uiB6IFVH/cuJbJC0hd92ySGq9b4ZqaiyGwn6gCWkHS2cxGeHUaU4I4HPjqDejM0
         zNMrb2VuZ06MletLOpYWr1JXXOslyiBG/x2c9HF9gNK+vOMIZzYTl6gLsh+Y8ecPCJ9u
         jVJIQ1BqvHPYkK8bdgqR1OY27Wp03BmgRkoOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746069158; x=1746673958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OC1oQVKn70KzlSasLkTsE0MQR+OTmhnwfBz3Xe1R3C4=;
        b=VuZK6xP8IBOw7tDJj5bFY0PsmK5WFVlgM8N9gU6e16KrYgF9Qs/E2zJAZe9fIDmnz8
         qMF/zTEtjFYmsQexK/tym20ridOWBcxRPd6Yl6fb8zHneEwoyl+p3WeRbgPJTd8l7dpk
         gMII32cdSgMT7N+g5oovrBLZUghWkzFWsW907dULiUWy4ih4YImz7ATvqvCCxMAdxDhT
         RQGZDO5DCPJr0iETslumigo7PDP0eyKmSbKVLT92dCkbejZS7haQGRc3Yl8i8mliP/UF
         R7r8kLsrpsxKoBr6N6fVBqzFYoK1vUVYaYQTeOJgmCNYo6aYzeX2+LzR44RNEnQ+7IXw
         Sk8A==
X-Forwarded-Encrypted: i=1; AJvYcCXmuhcOGS4P7TZeweYgBMWlupc6dpo6wCB5LGSWWEU+7pVJ4Z+N0JBA9PCiCw9IOVenKKknV8QhO1TOQYMh@vger.kernel.org
X-Gm-Message-State: AOJu0YxJKIO7xXKbWpKZzLd7sR6mLzkGCdkUCU4SL8wZXlGwQKg3hgRL
	lIKRWQlsOUoyR9zgiF6CnR4PL2b12Ci+AW4h5AEEF4t/lp+SU2dou7GcYomVjtSqBH1qEXF9QQe
	QXQg=
X-Gm-Gg: ASbGncs2AcDIDUrrJVQYZqUwsM6NHsLTxZWCNf70rMOhed4r6C4mimvrmz8AT95Mlbb
	lVTVXWiw2ml+7D+dIUoFpfr/iaWRTZCQf3EO8T+YjDOL5vTIzPtWa3M2wmu3AllpFUmDhvn6hZu
	nD1LTpR09N3SY2AefvZdehdWKdXLy+GAVEGIMTKoY431I6RkzcTo+3TVWqKqcuLua4jcxJxf3OB
	AFxHK2SX4Atn77OIV8oo3Eei75jWn1/3PrOQ7lueYNjnED/1HRaPVNs3U+voDVydEoc6e0FreOZ
	7lNRelS00KbmrzGk5gMrL2quSFfnRyk0Q7RbT4YLDkCEIQMuxuL7wKOmTWA7YFpz3FVFv4ssmjU
	UL3bbZOL5CmAUxTmc4pqvo81Kvg==
X-Google-Smtp-Source: AGHT+IEzYkcTZVR1iPaWxgDHTYR/Q+TYdIuGGodtYSxfbNpGiFXDPQE8HfushSkkRb6f5LMvjWgfnQ==
X-Received: by 2002:a17:907:3f8d:b0:acb:aea9:5ab0 with SMTP id a640c23a62f3a-aceff52ea3bmr61063866b.39.1746069157841;
        Wed, 30 Apr 2025 20:12:37 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec668dd9csm354160666b.96.2025.04.30.20.12.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 20:12:37 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso92533666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 20:12:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRfUfmwnP2WPTFWmBDPqq4ct3ho4CWsU0T7ZEZaOqJqGS6PIzcKpXJaNtrSjP+TvSJtGzkDlVkMLu2QNO/@vger.kernel.org
X-Received: by 2002:a17:907:968a:b0:ace:d650:853e with SMTP id
 a640c23a62f3a-aceff41a4d7mr74472666b.15.1746069156852; Wed, 30 Apr 2025
 20:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <20250425195910.GA1018738@mit.edu> <d87f7b76-8a53-4023-81e2-5d257c90acc2@zytor.com>
In-Reply-To: <d87f7b76-8a53-4023-81e2-5d257c90acc2@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Apr 2025 20:12:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwuu5Yp0Y-t_U6MoeKmDbJ-Y+0e+MoQi7pkGw2Eu9BzQ@mail.gmail.com>
X-Gm-Features: ATxdqUHanefpUI8GyxvaKB734S5zjy2OepCny55RpmWEo-qYF6q5WHIuuXBquxk
Message-ID: <CAHk-=wgwuu5Yp0Y-t_U6MoeKmDbJ-Y+0e+MoQi7pkGw2Eu9BzQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2025 at 19:48, H. Peter Anvin <hpa@zytor.com> wrote:
>
> It is worth noting that Microsoft has basically declared their
> "recommended" case folding (upcase) table to be permanently frozen (for
> new filesystem instances in the case where they use an on-disk
> translation table created at format time.)  As far as I know they have
> never supported anything other than 1:1 conversion of BMP code points,
> nor normalization.

So no crazy '=C3=9F' matches 'ss' kind of thing? (And yes, afaik that's
technically wrong even in German, but afaik at least sorts the same in
some locales).

Because yes, if MS basically does a 1:1 unicode translation with a
fixed table, that is not only "simpler", I think it's what we should
strive for.

Because I think the *only* valid reason for case insensitive
filesystems is "backwards compatibility", and given that, it's
_particularly_ stupid to then do anything more complicated and broken
than the thing you're trying to be compatible with.

I hope to everything holy that nobody ever wants to be compatible with
the absolute garbage that is the OSX HFS model.

Because the whole "let's actively corrupt names into something that is
almost, but not exactly, NFD" stuff is just some next-level evil
stuff.

            Linus

