Return-Path: <linux-fsdevel+bounces-69617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8144DC7EE16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 04:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 801EC34570C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 03:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113CB29994B;
	Mon, 24 Nov 2025 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="R4zZTJYQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DE2AE99
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 03:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763954060; cv=none; b=i10WLck9XEhLLxPZEgw49hEXuv3wNiXVLrQ+75Lf/YJAXmiXLcqaB1yQDwilsrJMPKrC7RLUVqImqzCM8pQLO5f/6qrP1ShDhbdslyRg0QKc6mrkS8auT4Kea/0Kj13gqTcTQgaTqNcBvsPlkcBu8vtAWyWF4ejr7yGC+POpQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763954060; c=relaxed/simple;
	bh=m7otrMWhBJM9ta+y1m0Kw4P0enGP7S7+XlIcKLt3qIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgwr1Xe+DR0l3IhjERSe3FkXQ89I1CHQVpMmLIGGrSiZqRUh5Sfj9dbycucFim72nZ/YC160X9voaVasH2S1Ujnm2SK46RL1/LW802ewljemfdHCPIcVUzNRQLSwW5BIJMf+NvdUpF83aO9YbpwXFIToWAlTwMhBkHsuQXru7PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=R4zZTJYQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso5777660a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 19:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763954056; x=1764558856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxWYYzGvXb7lNtyybtYmnOldPsxEU1v86JbAWbqU92g=;
        b=R4zZTJYQ8Edmu3CjI8FZOt/tfdZatJjJcfAnV6s4bUjJ7ZvQ2Rhh8ANNQwYJ3gEhFW
         aKrU1gfMUEmN5dFsBaoNhUY755lzg+dfdtvUy2lzSsa5I3le9CcVjjWNZYiD8ltWAgke
         bBxvhn2XQY8NoS6KDwNBSmHkjfLKlXQawhVpmJ+cshiKRMt+t1RX3g5gVgsbex1YmWIT
         Tyn5wnvLUs83XXipjPoRo1I/+Tq95WlZV/B6j04eTpcQPONgVJJZzo2oEg1W4p5gDEmH
         vEM1vIVb4NhurLHBy/CRhdm3dOTdI/nYXzd0TrZl4OJRdMa8+W//S9b43wGhiec6HwLv
         EqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763954056; x=1764558856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxWYYzGvXb7lNtyybtYmnOldPsxEU1v86JbAWbqU92g=;
        b=JIfy6+JRfr3bpEqfNl0TB4B1MUU6ljx+/+kB2rAGfR79x6TnOd+UJc57R6QxCFbhcB
         JDgnSh/n/Ig8eGCzyvVhwlvL0wBlvkLPYA0RKrCPZO5HcgPyITmhlncCaghfZUYmLc9U
         GfLWiA8eV2BndF2fZMz/eyX3CMH7DLDlGrHPvocaisiHfG7/GlarRMcgJrfOTKKJnSdx
         6Fo94uwkPke7FqYKV6ennctCRD/PqyRyLQ8DUhOYmYeE0d9/uJ7KIYqy/wapVhAbkT+/
         vCwtDxcIPf/0D04BPzoYfxrmWKXc/16bij2JIIS0na89Rir9LHwkvkuvp+eUKXhQiuH3
         KF6A==
X-Forwarded-Encrypted: i=1; AJvYcCVxpx+jmUqpLVZh8stkUhWru/bthpFKKo5+fUJK9ULRJKQqM+JRGBbGBXVjOuaP5PdbLy01NUsqb77k7oWZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu7xVQdHNQ9B83GFfiJMgpWAEgcjRtLcssIeLhvF4Gj2A4ekQ7
	aOe8hixj4sPATVTNt3izebXK3QOUkpK8aoCKYylKiraJhZM2JiBl2f4I4zyLGp4iPKrdRkw+4At
	i4pawmQaurIdv9qaDq+i92LCA16TG5OxoFW+0uzFUzg==
X-Gm-Gg: ASbGncvAblKyLhcb58KMyq6/ui5hWaeg1Fb+EyDw3mzhjwkYS/KP8fPvOwEoENTdIZe
	qfIHExewfJ84W+8FdhQak1ti+SyPnwS3mF1WVSrIRjgnyyEBXd87J6EkYLgeMccpkF+97O4B9Ts
	kdIrUJ44sN1ItWwcej3SDk75s40MHmu2PXEwm0S8swW5tuh99UGRAb5FV1lu9LKmRxS26dknY9h
	nl/88ZUtL0uAkMBwrn63/fB3szNmo9PN/A/oyC1ryGM//OfbYjm0TfUME0gLBDEwr/E
X-Google-Smtp-Source: AGHT+IH67JP1UaR3gpoqZ3MrgHkQzMQhpp66V9UPwtAjbwPOvJT5SkZilFWd08WjSbu3wTcfKGr6KSLWlhGvqm+wzqg=
X-Received: by 2002:a05:6402:40c5:b0:640:ebca:e66f with SMTP id
 4fb4d7f45d1cf-6455469272fmr8497105a12.34.1763954055610; Sun, 23 Nov 2025
 19:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
 <20251122222351.1059049-15-pasha.tatashin@soleen.com> <aSMsqD5mB2mHHH9v@kernel.org>
In-Reply-To: <aSMsqD5mB2mHHH9v@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 23 Nov 2025 22:13:39 -0500
X-Gm-Features: AWmQ_bn9jKi7Ktx8U1VC5NBm-L4AbZd5N5WS8ORgDcSjrzKv7tbGyIW2qlGBRlc
Message-ID: <CA+CK2bCrNC0uYdXbC+JK_bvk8BYFPSL=ZbTZ_T6LMHtoum+Z8Q@mail.gmail.com>
Subject: Re: [PATCH v7 14/22] mm: memfd_luo: allow preserving memfd
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +unlock_folio:
> > +     folio_unlock(folio);
> > +     folio_put(folio);
> > +     i++;
>
> I'd add a counter and use it int the below for loop.

Done.

>
> > +put_folios:
> > +     /*
> > +      * Note: don't free the folios already added to the file. They will be
> > +      * freed when the file is freed. Free the ones not added yet here.
> > +      */
> > +     for (; i < nr_folios; i++) {
> > +             const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
> > +
> > +             folio = kho_restore_folio(pfolio->pfn);
> > +             if (folio)
> > +                     folio_put(folio);
> > +     }
> > +
> > +     return err;
> > +}
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks!

Pasha

>
> --
> Sincerely yours,
> Mike.

