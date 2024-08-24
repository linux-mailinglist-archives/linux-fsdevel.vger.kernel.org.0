Return-Path: <linux-fsdevel+bounces-27006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D095DA56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 03:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8FE1F234A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 01:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB958494;
	Sat, 24 Aug 2024 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KDtEMk6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D2161
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724462602; cv=none; b=LukxPWOEzrhHLGJ8e+iig6mSoIYvQQEWpSyU8ucoig3PNE6dzq77K43ZB5ahgC9NshpA3EtA4zalcb7ESuZZbJNHlGF3HkFEcE6s5Bgp2l5POUXGiYjn+3EXirDpYsezrrpGbTfB+Zgvwu+gBw+RtMC/rqgjTKghwo3lCSdpOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724462602; c=relaxed/simple;
	bh=pFBmn1b8HGmxiNAzjHuI1t8iCFvWlQvq1ax4yTVhtWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCmH31xjGkgsFAyqI5gjburJEx3Ifg65wWCGwNHR7qLqi0hLsEPU1r5j8r42b2fPsILgD0B+u147OycniKg30wPd4YXAtoxDo7YOVlVuC28YbYTuUk0t1OqQvdYBu/T7E862wbyTv/HmiiFSQXUXmprFHwNOEEqj0nW9nvXQLCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KDtEMk6n; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso20193255e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 18:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724462599; x=1725067399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hS0PlIghB31D9UEMBMHujKkEVm4tXs1uqCiHkuDkoqU=;
        b=KDtEMk6nuI2F12uxqL2oxrKKtfpPaoT5FBEU6JIi99X+0H5aisnt2AYeFAgqiU5okV
         ASgMgLDDoRY9gUWzwRru0rCrTmRan0oq10Kj/kl2T9f/5JXlWccyfZwMvc4sLHxEuC1W
         vHnHM0INEQX4y9oLxyGy37u8OC7HRN1pqr7AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724462599; x=1725067399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hS0PlIghB31D9UEMBMHujKkEVm4tXs1uqCiHkuDkoqU=;
        b=vYWFuelqjhkDA1uuiUFzZib9gb/dVx8XHgokugzstac53FRjnvNYQcYgY2bW0bcV0N
         zKgTz3WPNNegRqLne/1ZUZuIn79CmbQnhRm9/bfZ0SaNPb/GJpgH0UAXpYmO2XN/XPX8
         TsC8jMhIzTc3s0vvjuofQjA9cTGFb3CusPuAVWvf7cmHo2bQVXMO1nKtvEMnSBd2c6gs
         0LbsaQulVMhYPsjTDiEL0+c91hTHxAWAYxSuHWSxNxZkiPsB2iQa4eLcLlIJxQtn/paA
         MhScNdUiuFiEJCruaogtmrTT7f055QyTL0Srg+TzWxI3VWRCFYIwwmaHXI6XY+Gt83go
         GlxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQIPkb8TJ9aYCe4OxAUIffa9G3dKRKThN8Mx4dpluaQz1py7XO3ITzQdonyMKMcTx6Go7MOY3A1rI48lCP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4S38ruukZ1jnXO/yyGRaCRUwspJdtjBLrGvairQow19H1uECC
	wP4v0vV+6XVGrbgOAcfQtXSQwv4s6m9QIgmAvWnpUO+Xz8shImjJizoFEwhyOe2CE368frnu6bM
	KjASJEw==
X-Google-Smtp-Source: AGHT+IELOj26j0RY76soWwzHNqZgwH64CnjbtPmggLwhAW5blRhpGi11HsK6ez25bhsDPpv4oM8o4w==
X-Received: by 2002:a05:6000:2c7:b0:367:9881:7d5e with SMTP id ffacd0b85a97d-37311841ae6mr2729774f8f.8.1724462598776;
        Fri, 23 Aug 2024 18:23:18 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868ee6b390sm330962666b.0.2024.08.23.18.23.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 18:23:17 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so2926297a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 18:23:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLNtm9KiMc8jj2+v8z2sfX0dL/WJIj2FD9HHg7DxrQfn4pYS5KH8o9ggx6qWKK54Nn5fuRXoGttJQv44JS@vger.kernel.org
X-Received: by 2002:a05:6402:430c:b0:58b:585b:42a2 with SMTP id
 4fb4d7f45d1cf-5c0891a92a6mr2273293a12.38.1724462597330; Fri, 23 Aug 2024
 18:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
In-Reply-To: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 09:23:00 +0800
X-Gmail-Original-Message-ID: <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
Message-ID: <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 02:54, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Hi Linus, big one this time...

Yeah, no, enough is enough. The last pull was already big.

This is too big, it touches non-bcachefs stuff, and it's not even
remotely some kind of regression.

At some point "fix something" just turns into development, and this is
that point.

Nobody sane uses bcachefs and expects it to be stable, so every single
user is an experimental site.

The bcachefs patches have become these kinds of "lots of development
during the release cycles rather than before it", to the point where
I'm starting to regret merging bcachefs.

If bcachefs can't work sanely within the normal upstream kernel
release schedule, maybe it shouldn't *be* in the normal upstream
kernel.

This is getting beyond ridiculous.

               Linus

