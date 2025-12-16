Return-Path: <linux-fsdevel+bounces-71445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29560CC0F6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 06:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 956EF30B7FB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 04:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B273E332EA2;
	Tue, 16 Dec 2025 04:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dnuy74tg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FAE33291A
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765859551; cv=none; b=C3qXy60W+hradZ/yM80ZG5KEmK+HEVq0w7K0AKKiGj4cTbwP5FEVODDee5grJjYZZYLg9KChKHbC5l1hJnzg/QEzKCO7sPVoYBmzb94QxMjeELNUFVMwKEm5t3NJLyMQV5S9PAat2hnwv6KwkNoABSB8fil6L8wnT8NDuxb9tgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765859551; c=relaxed/simple;
	bh=JAC7T84OH3rJpKA9s8hbP8b38NGlwWMNJLYmPCkoa0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OF/FKR4i11ZmBloY72ac15PoCv3VPVHK28QPKJLf2F7BZmiCKn8ck2luyzbrEXJNNL5bBWXu8cZj40Njf0sufdLbkkP1KCSVmfOe4LWg+Sd+V5HuodmerjFQ9gtcmwuPCycc6MQtJnFY3sD08EMH5RZX3cZFosAcM5MXH/sEJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dnuy74tg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7697e8b01aso774122166b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 20:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765859541; x=1766464341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u04lKI+ITCEhSjyN8l/3SfN1GaX76pkUdUELbvLmtVI=;
        b=dnuy74tgEdeg4sZQHPQgfnWfF65ZIaEb5VaAbZbGlMltJVDW0a5u0idlX00NVT9MKv
         aZEye1jQa/uTxf9x3WflndEYSycittJiYS4qGTFjnB2wgj5nLvrkoDLkfrTvUXZsVqJJ
         GjdJkjtJqCXh0J0oBfcOTARTHjwr6JFQic18M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765859541; x=1766464341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u04lKI+ITCEhSjyN8l/3SfN1GaX76pkUdUELbvLmtVI=;
        b=cSL93rZaNHIl56A5gl9sA2etSGageqcb/Y5SBMRHatRCuQ4WkpnRpTscscfUqu8WWN
         ualbTUVeKwivxfKTwl64ySx6ifZgcq5tuLw/lfUd7e7wLjz9s2F5BDQnuZaAj6i7o0uU
         jrX9uXSqNi8jduipzi5ale2bbB9oVekO13DR07ytfggMBICNjiLZ3m6vYKCDTHkHX3+I
         hSHVspPnhECaYfBRfvRq9gKePhb5v+RWC1/KpUlCA9A8NKWQ63xLvinWlbyWb0NAaZ+e
         7tjJcOJxf/z+3ImxcblSAeMJ/vmbDNzGLNCD1IvCT0yRJHIX1506XpU+qdagY9UegVwc
         xN+A==
X-Gm-Message-State: AOJu0YydxmdOnpN9M6cqpwie5XtL5PtWIInc9InpyiHOsg3YNK3JFv/H
	eZkXZXDrHdUIbltrJcGbPpPnmKTrQuPwWWXEKTL2LJW/V5YaylKVWwKbBP3BIhgOSy4Vf9dp//O
	tBZ+/PDXEtg==
X-Gm-Gg: AY/fxX7KKwqKahiP+yi8bAzOqfGf67h+ZIsnkxcd6hNtn470sUvhEwE2XBq1Fvwm+6N
	E9otGnDq8uOVOlYr4dft0XpjYDNT+hQcVmG6u6Ts8sCBKXwybpeTTkAx/ouvEEDVelwqTWKne33
	1xjuKMLHLd6aimnkkpm5OQuTkVe14LPSAp2UvfYWbfqIjVZGohM2rXxZrLoVsFKpDfIXrRGNeDM
	FcWvRMAyuKcJIZWnw+59ZnO9VMkSUK0xiUtEPHkE5+kSOFGegVyiaqQoDx9ey19S2mRpQ4oB43c
	lsjrZdWpCoWT4foudnFqZCa6p37J5zbqfxjFPLfXv91gNSJs8sxN0+hvzA08e9GFMa4eqLE8Nng
	JD2Ahp1rxas59wLB6HogmdU5fDDkg5xEgxB2EMFMyIPGfq2kHTt+I0ONk5zLxTD/diMCw2B9S4w
	hOmV8miD6DND6eLMr+BPlpB/hibd2NL1KuuasksNeBZywXPQCCxlvxpQYiAXSq
X-Google-Smtp-Source: AGHT+IE8zH8yXW1AbZluR/pksC6eTLfjsNgeCI1v2py18bX5pXa9zSskZMe/Bl4mT5pW/os/D39XFw==
X-Received: by 2002:a17:907:7296:b0:b79:ecb0:db74 with SMTP id a640c23a62f3a-b7d23d11086mr1207067066b.59.1765859541129;
        Mon, 15 Dec 2025 20:32:21 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7fee422729sm117504066b.9.2025.12.15.20.32.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 20:32:19 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7697e8b01aso774119866b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 20:32:19 -0800 (PST)
X-Received: by 2002:a17:907:7e8d:b0:b7a:2ba7:18c0 with SMTP id
 a640c23a62f3a-b7d23d13db8mr1509432666b.61.1765859539518; Mon, 15 Dec 2025
 20:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216035518.4037331-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20251216035518.4037331-1-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Dec 2025 16:32:03 +1200
X-Gmail-Original-Message-ID: <CAHk-=wi4j0+zDZPTr4-fyEE4qzHwNdVOwCSuPoJ4w0fpDZcDRQ@mail.gmail.com>
X-Gm-Features: AQt7F2rYyucJ8k8M5suIcIYwHZryFGRojM10TYRYQXZevxtnA0xqMtui8-ALNA8
Message-ID: <CAHk-=wi4j0+zDZPTr4-fyEE4qzHwNdVOwCSuPoJ4w0fpDZcDRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/59] struct filename work
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	mjguzik@gmail.com, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

So I like the whole series, but..

On Tue, 16 Dec 2025 at 15:56, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>   struct filename ->refcnt doesn't need to be atomic

Does ->refcnt need to exist _at_all_ if audit isn't enabled?

Are there any other users of it? Maybe I missed some?

Because I'm wondering if we could just encapsulate the thing entirely
in some #ifdef CONFIG_AUDIT check.

Now, I think absolutely everybody does enable audit, so it's not
because I'd try to save one word of memory and a few tests, it's more
of a "could we make it very explicit that all that code is purely
about the audit case"?

                    Linus

