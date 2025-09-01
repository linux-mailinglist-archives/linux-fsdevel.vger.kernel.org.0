Return-Path: <linux-fsdevel+bounces-59881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8958FB3EA84
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5CF2C0793
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D295E34DCF0;
	Mon,  1 Sep 2025 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SXm4rzcS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D383320A2F
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739598; cv=none; b=EFDrXyOxrSU9KQffA+BxHw6LULxwuexaNN81sa9aDBeBLgwQhRGxbCERKL0lK3/uisC+7iw2l65U5wFVPNitwv0/7U02u4e2EsaMgVI0F61GCyM/qP5YW40N3qMKdfr19YzfkbGa3/ptTpTi0yd07lVKw5b2A9kuqiDIpCD2u8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739598; c=relaxed/simple;
	bh=A08kBdKHaoJbHo5ouUdZLXPFTzEYHeueCSYh810eJqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrzJyE9720x+Z+tBgh8KE0IYQNTWbNdsI95SZj2c0xCw8BPUomBYJT/DngTNJLMijLta0sveZe0ICfSJeAr4S10EPs3/421u/FubOYQt5avlO3rGLl11VJ/77Ww8d1a4fNLyqvZZovB3bt4/4j+tPqvT3fDb9kEm4SqhBBftfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SXm4rzcS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afebb6d4093so742150266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756739595; x=1757344395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A08kBdKHaoJbHo5ouUdZLXPFTzEYHeueCSYh810eJqo=;
        b=SXm4rzcSkElIrHAf74IwHZTwm3FD/jW0Rry2Hy3ZnofA3LcZ5YfG7EUE5ZaLYl1izT
         sAeIU1jl6BNZIel9dnOj2qhiqVbdz94xU5p7IW5a6bVoylsbVQNfxFtWZZsTXbvy+2d2
         KGc5NdZxdsxW6cZV1LhpjmCKLn+Ox2y87ijntCCLJpWgntXemVKJFLjpIYjrKMiw2vzt
         ncOTZsAJHJ0baJ2iOUCm3Boelfk97KMxTv9brRLaq+dcSeB0pHmFpuzKNbYhMxrlUtV4
         pGh0ny+ycO7Iam2MWVGbiGEUGMcNwqR5GSaFEQoZwJYxCOTazl6RcO3m2cRvQmiilLuS
         xU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739595; x=1757344395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A08kBdKHaoJbHo5ouUdZLXPFTzEYHeueCSYh810eJqo=;
        b=LDMpfsuMtUaW3IRtC8jeevsuUZzFL2TPsNYxY4zrPB4LSiGrhcNDMspWcyucdMIh7c
         faSGB/M3LHIyTIciuFe4DWSOpX3fEn2lF6yHn7RnaqiTBmInonQbR0L3vuNnFusON5/j
         xfad3QEb2teDSn+KCKHakLl3HoCQ5y84F0DjMMkIZVHWrLMZnjlYXxpZwSJ7kDbrYfBi
         fFGtxtMESj1FWwGIx0RhDriWpvXxgGEHcukLPI8Dz8vsvpgvUJ7GltKILCBwX8VJejsw
         mJy99nB4AO15SOlFXJf3H9BgvWsjPyqAypBvhvZZD+PuG+e1intxCFaf5hqTUcb8HMAi
         acqw==
X-Forwarded-Encrypted: i=1; AJvYcCW6Elz6iissXX0HHBAehRaBVhl5pXVdAU7mU2+/kz0JiJVNAsaoNsTIn/+Cy20mKEsQ82RmyGSPEtLGzTGC@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvchdY2xVx2rsl+7DBQMl6VJxx+6i9k5KnLkChVaEK392LWhX
	TcTY8KybStm2g3tiIh/CPlG5lBXrqoXdy3+mR/DRuNs9UbXk6tyv7cMLP7W3+5mcwPPMbEHz7Ym
	DwF1o6MVnqI/BiXCmEn1bViWm49jhpQCLsD/hStSnfA==
X-Gm-Gg: ASbGnct4whCDo58ssgHlZf2Yw5nPE5UfYXWTHWd38pGb6jvUElEdEgLyBOUNhICLMAe
	31SKvoqob7Mr1lOXeU06NMdDqW5CV5Ja21fgGhYtVN6Vrcbj5jfGNxn6FRODmqY76b0OhunAGXQ
	XUhrleFtlp2knAwMvx5wWKS/PY5xE3xu5ePuB7EsjtsQeVVTpaa36VgthUZt8YTQ9LLZ/DxdrdA
	8kSCp2T+YKcCk9fluUv+pD3YlWOD8mNx8pXZGsEsxoY8g==
X-Google-Smtp-Source: AGHT+IEFPWeGuNqM2+QiOgw6fHvRg/b0a6N13KZkb/trfYqooePyXBS3syenI4NwqPjQnySBBQHmRMnR+cpdOfOLUuA=
X-Received: by 2002:a17:906:9f85:b0:afc:cbf4:ca7d with SMTP id
 a640c23a62f3a-b01d979fe6emr930093166b.54.1756739594447; Mon, 01 Sep 2025
 08:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-11-max.kellermann@ionos.com> <5ff7c9bc-1722-4d8a-ad2e-8d567216a4e4@redhat.com>
In-Reply-To: <5ff7c9bc-1722-4d8a-ad2e-8d567216a4e4@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:13:03 +0200
X-Gm-Features: Ac12FXzpx0s0QI5qZl1CeOcQ-w6EceVXiGl7R5sUJVErAX6WQ0b3KxehR5HEiuA
Message-ID: <CAKPOu+-zBstZVw4LjKz7ZQyTh_PKEJXaWYsgF0-E0+shAaTvwA@mail.gmail.com>
Subject: Re: [PATCH v5 10/12] mm: constify various inline test functions for
 improved const-correctness
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:00=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> Also some getters hiding (and functions that actually implement logic --
> folio_migrate_refs())

Indeed; I mentioned that one in the message body, and I thought this
was good enough, but I dropped the word "test" from the subject line
to avoid confusion.

> > -static inline int folio_lru_gen(struct folio *folio)
> > +static inline int folio_lru_gen(const struct folio *folio)
>
> *const ?

Right. Added for next revision.

