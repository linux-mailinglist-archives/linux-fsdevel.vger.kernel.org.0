Return-Path: <linux-fsdevel+bounces-31500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DED99785C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 00:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E6E1C210E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A90F1E32C2;
	Wed,  9 Oct 2024 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwm5Ycp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7F17A584;
	Wed,  9 Oct 2024 22:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728512230; cv=none; b=NKxysIBc3NdvQ4J/bXBCNpzuwObNHTnC7Xpv4bdSSNqPMckVlFOjGTzRK8J6Mh3F117gqeqlWO8tm3FHBar0Bb1m8zvWVwPL282qGvgBZoBGt5aPlLrfmIInlsqIQ6M7WkcsdZ+f0nhQVwhC1QbhRKKdFig3jgXRpIl2fBmh9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728512230; c=relaxed/simple;
	bh=Qz18RXphvenXEN9nRI5napXnTtwj4lI2pWTe5c1vSKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SC3QmclvFoYBKobG9hXZG5ev/3NZ0jgb7v8FzFRJ22EtlW188YdCnk11jw7a70bv7hoQh1ZxJTURILtJVIhkoulGqT/bR1hiIbUXgyrvAJ59NRragFYig2DNY8jmojHxPmFVZ++qTQTCfXKaZ7vC80mAPGya+O39y15qnR+d1VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwm5Ycp9; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fad8337aa4so3137401fa.0;
        Wed, 09 Oct 2024 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728512227; x=1729117027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vJOR5Pe5cnpO/MtL9k0byjEiB3fJceAvrtHENukwyA=;
        b=cwm5Ycp9Eu4AA3rv/QVfdZWpU4ok6TKZW7aYAcND3CrPKQHe0YmmgMIaOmmjoOeQMQ
         dXq4NL6BE3TmDFnTItyMp+pPbpDQHCitDEVMCDj3zqzwnDDuWOEJZQjwWeFlzGR/92O7
         FJuOT5MPHbXKnigrCT8iR5BGHZVdeUc/xwL9OuaIGa0zdIOv7yvfRtFWnFlHvoDWmErx
         N/454RG5iyOabFNGT3vka67+eX1nCO3ouy0P3mHHGaylMvBqXWdtHhQN9nVKgJZKlh1g
         edWOydhpPOdM+hf0LG3EZEiM8H8BpWmuVaq2u7Qn3t+8WXXLEb4GLzrXUup4mjUV8n7T
         3rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728512227; x=1729117027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vJOR5Pe5cnpO/MtL9k0byjEiB3fJceAvrtHENukwyA=;
        b=ADOQHGqbON+bxkCx3SzpzdF8LI2T+CPYsO92UVCy5YxbYesKzvsErnri4jcWrDU73v
         lxfMcp81BXRbnuruufHzsm7UZCm6NcZa5QdAOU33lFOs+EZw48l4Fh2PLfHh4srE1Hd/
         ZwW6UEGlavpb5DIRXGySQI6PRZMqBDcW8MGihwJdQEKvLPcZhRxgZHn9KAEou73WZSWA
         fNVz2AVXAHBmJTM1FzqF6vUrvuHiISW0ggQzm7sjO4N6wuF1gHvb6s9X/DFIclc/1n29
         nCh3jc3lYFlVpNgsNx3bUcnzZ+SrWl7Ax3Hm60cOleWL2dXt9pJpBRYhB3rPD4mUUu1N
         eJZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPUNWnA+/GvtyGVg/zLTr6kf0G78dcimRY2wD1t7+HDxPdsDQIylFkCgCSY8EUp+kcrYzUmWWPuXJjwXdiQg==@vger.kernel.org, AJvYcCWS8ffLD2ElVIgmwagPqcl8ycSqXErEMtnO0erNk1bCpV3jyMuPj4GLzxq+vGmzNjPGL17sydpnk/c=@vger.kernel.org, AJvYcCWloOXQ6R/RmLfm5iiz1/RGAO8a8hpvYc5WYLzwdeI/UVNL/F25NpCvaq2b0HiefDzi66vdQrc9eAkUPOhm@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2n9Gm0TuTZsAHkh8NTShV7t9BWgF0l7vM990TNkf64MqwRea
	hHH5DpvX9whLmr4uGMWPGGIv9pk5CUNTvitG2GWZHQrg6acGiH2nj9+EhZhqrdDn8vWDU0UJSG3
	gWv5L21iUZraVjVIuQxfrKmH3y9kLMPFe
X-Google-Smtp-Source: AGHT+IFzQKnqDZgRef9bfo33+6pfeW7KfLapHRRW52/zyYe98ZvvG58H6JkACElKHZrqP0fDYAevwfrbxbh8hmixIA8=
X-Received: by 2002:a2e:a58b:0:b0:2ef:2555:e52f with SMTP id
 38308e7fff4ca-2fb187bf0a2mr25469781fa.35.1728512227009; Wed, 09 Oct 2024
 15:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-ks9kiAH5MYmMvHxwH9JfBdhLGA_mP+ezmZ8wJOzDY1p7o5w@mail.gmail.com>
 <20241009205237.48881-2-tamird@gmail.com> <875xq19bus.fsf@trenco.lwn.net>
In-Reply-To: <875xq19bus.fsf@trenco.lwn.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 9 Oct 2024 18:16:29 -0400
Message-ID: <CAJ-ks9md9bCrwyCNp3jR=1pF-xpieu8oW4jPqw5w=kCL9bpeBg@mail.gmail.com>
Subject: Re: [PATCH v2] XArray: minor documentation improvements
To: Jonathan Corbet <corbet@lwn.net>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:59=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wro=
te:
>
> I'm not convinced that this is better.  This is programmer
> documentation, and "storing NULL" says exactly what is going on.
> "Erasing" is, IMO, less clear.

Both are verbs that appear in function names:
"storing NULL" is to `xa_store(NULL)` as "erasing" is to `xa_erase()`.

Cheers.
Tamir

