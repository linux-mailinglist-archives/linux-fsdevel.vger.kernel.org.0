Return-Path: <linux-fsdevel+bounces-64145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6136BDAABC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 18:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC973AC399
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60883019CF;
	Tue, 14 Oct 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FTF5z4wF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80A2676DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460101; cv=none; b=eYKXOaIx/fM4qW5wIX/Gxe6xjMRPUnKqAWEAgw0cQnOTaPzisG5ZX/At6TbQliNB/yVSiKkSetEmPGJ2ZuZE2jpX6nQgJ2dyYlSbilV0YETiEG22wuedVmEcYgvo9ae845twY57rGbEmDi1NBD3/j2ZNV55tBN0hSVdOalbC2FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460101; c=relaxed/simple;
	bh=BmFOD/P5ahpKb/OrWMG1pZr49BaGZDtavZjItlAu5oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXaKgmpnnHEnKXQ0EuFUp6gLAWHUlChSDFl7uWH763cy9e7VbToSM8g4R89F3pFLaQPof4QFGAbk57JHCZEZOWqgiaScU7qkyWlphNO6jVlvvqotZmVeeAxAl/zn24UZpTtRrOsjMW15mdksGP9kFS6hhAwc75hb19M6TA+PErk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FTF5z4wF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso892311566b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760460097; x=1761064897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TfIjTfdF2e53St+2VVBPM1O6zAI6tUF3QFF7DgeTNmM=;
        b=FTF5z4wFvbiBHGB3AV8Ag2GReoqxoN0eEFAwNDy0aiibk9zXwV6Hw+Nx9da2UQB6yH
         weeYSdPk3lZ8+wpGNX7O9kC5MQByNQIg11yv/EKShQPXWGJtPUKwWV9e/D7aYyuGLILr
         uHsEjVZjL1D+i7Ujq0WT9doNNKlYuCnMAOPkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760460097; x=1761064897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfIjTfdF2e53St+2VVBPM1O6zAI6tUF3QFF7DgeTNmM=;
        b=iXGTmeN1XOV8f1I5USxDAbPDinRrBteuuUeT8z3IPAzRusaa+M9y/KAgZbKZT8V6V0
         ALfWoSRZYeqZgIuVZZ+735xhuqmFb+gKg1uxkGj+pzqz5cWCdeKkNdiksQ5WzQdIV+P8
         Fhh1BdQW/Ob1PRXCKicFXD+czUF3AYFs5IwwlaSjE0hPZZauHVAwKFZtoVEUTEBle1um
         NOJhr0wxMYKddfc56Feu6mpz9y6GLQ1V9BNcjeLs4b3TgrwuF1ckyGD+S7AaXnzCJ1FU
         HbjwLYeyXfbk6+fAyIcQrvow6y5kRYROVhiLUCvdk0Cr3B3TagL6FXriIxyEB4Y1hx2d
         yCkw==
X-Forwarded-Encrypted: i=1; AJvYcCVwgMJDFtfLAMBe0XRWgYM0oZzcs48sjh7tcG9AOPlnQ7q/vYd36xCKtihIQQTRplFYJukfQh9gefz5QDix@vger.kernel.org
X-Gm-Message-State: AOJu0YzqLWQ+E7Ef9Yd9E1NECRCy4Poa6kzLX2AkTtRCVC34eiSTOLQT
	mf3L+4SIcBJuES6AqZSCXIhuQ+HHNq5/2FG6lxvTl73PcZ44KlAQXXPo5y+xmsT+phU1r8sNFaO
	5HTaCyBs=
X-Gm-Gg: ASbGncvQwXGoSHNU7DrnxuV9sannKm4aTkiz6cPmk5Wwqy/Xa8gwNGGFCXG4ft3f/3h
	gg+/IoI7x+DmV5tuAxgzGQwX4WlHvoTZ5EDwrsCDfv2ucx7cDmzZwpHSm/surVVZ0rJvMKhLAxi
	8fvzLmZ4HwURxq2PG3rzF/dcB/TrJEfJq3xhRyqi7Hk4aXqd2EISUOQuppJNBOMYDmHVzO1nd91
	qv+5HVnpQ6JELjwSVDS3VVKZmtnBAot4eD/SZ90+RWdEPFogbvFw61iu0pS2K5L8P1tgCm/CK5A
	MIokYR1GK0XgjhA6Wh9gpIIpws0D2FIaN7w/D+NjQrUyyC1kxeZe4NuXwhCXhXQbKCbilKn1ZF9
	Nu83Tr/+aT/lhlYWTkQhUBFyepvKrEmVCNqUR8DftBqMHahNF750a/aU0tYquoNDZ1jJDuEy5Dr
	mOCalBI2+wPE1i6WjrkgL0dE5k9Famo0XV4nh5
X-Google-Smtp-Source: AGHT+IGQORl9B6NmmFwdjFwrO0WitZvjOZ5J2Hc4+6EYadGp1VRjKpDhFyx/XgDsp30vpQnXCvQK1A==
X-Received: by 2002:a17:907:608c:b0:b3c:364d:b884 with SMTP id a640c23a62f3a-b50ac4d284amr2777175066b.63.1760460096975;
        Tue, 14 Oct 2025 09:41:36 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb49cfsm16895866b.49.2025.10.14.09.41.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 09:41:36 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3e44f22f15so798985466b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 09:41:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBKtl/Ja84xK/yNLKLtMze49sy97m39zaR4If6Z/YSaMtaWxSEWRmBXZX6wNFV0WvZ4gx6rwOiDGohAr92@vger.kernel.org
X-Received: by 2002:a17:907:3daa:b0:b45:60ad:daf9 with SMTP id
 a640c23a62f3a-b50a9a6cb4fmr2924764166b.3.1760460095576; Tue, 14 Oct 2025
 09:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
 <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
 <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>
 <nhrb37zzltn5hi3h5phwprtmkj2z2wb4gchvp725bwcnsgvjyf@eohezc2gouwr>
 <CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com>
 <qasdw5uxymstppbxvqrfs5nquf2rqczmzu5yhbvn6brqm5w6sw@ax6o4q2xkh3t>
 <CAHk-=wg0r_xsB0RQ+35WPHwPb9b9drJEfGL-hByBZRmPbSy0rQ@mail.gmail.com>
 <jzpbwmoygmjsltnqfdgnq4p75tg74bdamq3hne7t32mof4m5xo@lcw3afbr4daf>
 <dz7pcqi5ytmb35r6kojuetdipjp7xdjlnyzcu5qb6d4cdo6vq5@3b62gfzcxszo>
 <CAHk-=wgrZL7pLPW9GjUagoGOoOeDAVnyGJCn+6J5x-9+Dtbx-A@mail.gmail.com> <wfneq47jscotsqb2hhwpjfp2hqz4d7yyw643yagqnqvh74opvx@5fnmgowterq5>
In-Reply-To: <wfneq47jscotsqb2hhwpjfp2hqz4d7yyw643yagqnqvh74opvx@5fnmgowterq5>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 Oct 2025 09:41:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8KLDrL7ApM76cJTSXbZ0uxktexBaN9pMYO+hsiW-KxA@mail.gmail.com>
X-Gm-Features: AS18NWDqj066zW2Fdpipv6VXjg2cDmYzFXBwfjyGrNNP2eC0z2mKKWvE1qATHFI
Message-ID: <CAHk-=wj8KLDrL7ApM76cJTSXbZ0uxktexBaN9pMYO+hsiW-KxA@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Oct 2025 at 05:58, Kiryl Shutsemau <kirill@shutemov.name> wrote:
>
> clang-19 actually does pretty good job re-using stack space without
> additional function call.

Hmm. That certainly didn't always use to be the case. We've had lots
of issues with things like ioctl's that have multiple entirely
independent structures for different cases - so obviously no lifetime
overlap - and it has caused lots of extra stack use.

We do use -fconserve-stack these days and maybe that fixed the
problems we used to have with duplicate stack slots.

Or maybe it's just "different compiler versions".

But the case I was worried about wasn't so much the "re-use stack
space" as simply "lots of stack space for one case that wants it, deep
call chain for the other case".

But it appears we're ok:

> And if we increase buffer size to 1k Clang uninlines it:
>
> ../mm/filemap.c:2870:9:filemap_read     32      static
> ../mm/filemap.c:2714:13:filemap_read_fast       1168    static
> ../mm/filemap.c:2750:16:filemap_read_slow       384     static
>
> gcc-14, on other hand, doesn't want to inline these functions, even with
> 'inline' specified. And '__always_inline' doesn't look good.

That looks good. I'm still 100% sure we absolutely have had issues in
this area, but again, it might be -fconserve-stack that ends up making
the compilers do the right thing. Because that sets some stack frame
growth boundaries.

           Linus

