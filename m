Return-Path: <linux-fsdevel+bounces-63609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 364FFBC6059
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 18:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BD164E9AD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5429E2BDC32;
	Wed,  8 Oct 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qlt2EHEo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B8B29B8E5
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940888; cv=none; b=kz0C+pHcqoqvwLabJb8KZzUnYjvBdSaqro0Wp+XDATttiED6xL8RMpRBt36aaxeC3mCBgpuT5RctxqE5jlJBd1BuHFpHw6LfsvRP7bZmGaC7109a+iOVALOInXHAh05/q/FrqIHNMLr8nedGGMxeIN4PaL0k/U0ZgDsxJmCX+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940888; c=relaxed/simple;
	bh=m6uUvqSqb8LfKXllguL5/0G50xrdlHHc0hOb1sIeJEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noR5L9Ez2ZVMlM/s8jO2u3gEw/7HpuFX2XfSyti8xsrQojXpoFv6JgUb8llFaFJMJ3fgI2EkRViICfo21AZd+rr9zaXE/EWlXF4v0/VdInC96FOBW6PZo5m7BkcD8phzDCpqAWoWk8c/LL9ZikBMQnby+l/wv062Jdcc7Zq7K10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qlt2EHEo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so13362a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759940884; x=1760545684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ig2GLHE8hlKLEgmzJH4+emiSgZo32NUB86/I21OU+Y0=;
        b=Qlt2EHEoBkJPvWeCMosjoo1bEtQWMoicy7OuY+Akgkeq7wsSzJlpwurUOAKHSZKYiF
         1q1nEW7oEbYEGYBLLQoTw977kctAcletbcz5F+JJT1ea8+UxPdagVG7V1+jUj4D/UfX/
         fCNY3iHnfI0NbIvy4GIuzERj2M7ot5eUo1vwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940884; x=1760545684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ig2GLHE8hlKLEgmzJH4+emiSgZo32NUB86/I21OU+Y0=;
        b=Fh2Pgi3Sxf+/JPW3ytTbqQ5zB4m09K9VkTskVbtijrtWl6A9DPGH+hSSWWTqTZRP+N
         1w7w3qFePj0WLG7SJmFU8KpyNKTnlAwOzxfnZcHVPBW/lkMd87Xi+NAe+X4sfnm9E8Rc
         09A/ZX/JrFAr8HLDzXC8sGnQmiCC2WiZnGx5fOF2DvmgE8donl4+3AkHtcwE5grlGmAf
         Z0U92n6LEm9sa15YufZs8DttqOUQ8jmzgAW4SRzZwA8lhfBVnPYmY0zJmtgmHEShkhAK
         BZBva5DDHxhDET3qoGdbi6qt45XyVhCVvcrtxAxlG2yQDdvkieTi+g7AC5+94lpb3rdz
         NhnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpo+ktoE0MhoZoLuydO0OQFmCT9Tj0JF/pRrKUjYLMF7zENX10E+yiDrljbPhHlLNpXTnadtYmEgwxUMdg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xXaJ+hWpMFbzkEfXCR8xjjhxp/+/ZRid+7mfEwXVQGl/Z+Nv
	eamX6n6JHXfo4azlwjnfojo0KokiezqwxyahzOSpC9tOw/dpFrNqFHlEVCGMC8FfVEsllrzH0tc
	BZ4fpUZk=
X-Gm-Gg: ASbGncvw7VyM4IssdFbQjQ30NxFhqOWIWC1hRGZNIfnGA26lda3ABXgDl1paO4bxgQx
	RIhYVPKUZOFuYxtT1ZFH85t/YVRPlkPifC6QQbTHWTahzRFGKnyIIfx9fefUIBFX4P9mgLgoMMZ
	Vg1QFwBQPDDlDl1DksYTbE10DFsl6kQjqBdNvqmkCc84sM+RHmrv0dRuQvF9LKx6QEQEjUYDe+z
	DuzFqGZaYg+srHuIpp2zvLUYdXLTjBDAB3J2F22R6p10jugomxv49rVIyAYgkmlq1y3QRY1ENn1
	WFBsFBUf8bpPbDfRFQyGQ3JXM/4g3HHqdMwDyDH678+9dmLoTsjiKyJqL9KPYOa80rAhVVj4zbg
	enqZ0nTMeGHT7Fg0XOzhG3RVs37ZUbT2G4iJrrVXr18MxLuV7fOhLZUtVwY6I8QjlaurjT947JW
	oSLS3Lwk4wHwEQYTDf4JfJg3ZOfI3xWUs=
X-Google-Smtp-Source: AGHT+IEFQJ0WLVVkBnG/7mECXNusIrnT1jiimWdAtzweZJxY6tRHtz954/aNcjTvIIsS1roSeKhJOg==
X-Received: by 2002:a17:907:3e1e:b0:b3a:b22e:dd35 with SMTP id a640c23a62f3a-b50aa48d854mr458749866b.2.1759940883609;
        Wed, 08 Oct 2025 09:28:03 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4fd9esm1681160766b.76.2025.10.08.09.27.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 09:28:02 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so2693393a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 09:27:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0X4JyWcX4FcsiRmYsNNJhZur8oF2YOqTWmT/eLYWyNa4gXX46ekezklTgNJkcic4fcSH2c06jcIuW32NZ@vger.kernel.org
X-Received: by 2002:a05:6402:1d52:b0:633:59dd:3566 with SMTP id
 4fb4d7f45d1cf-639d5b5d47emr4199002a12.6.1759940874133; Wed, 08 Oct 2025
 09:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whThZaXqDdum21SEWXjKQXmBcFN8E5zStX8W-EMEhAFdQ@mail.gmail.com>
 <a3nryktlvr6raisphhw56mdkvff6zr5athu2bsyiotrtkjchf3@z6rdwygtybft>
 <CAHk-=wg-eq7s8UMogFCS8OJQt9hwajwKP6kzW88avbx+4JXhcA@mail.gmail.com>
 <4bjh23pk56gtnhutt4i46magq74zx3nlkuo4ym2tkn54rv4gjl@rhxb6t6ncewp>
 <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com>
 <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
 <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com>
 <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
 <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
 <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com> <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
In-Reply-To: <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Oct 2025 09:27:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
X-Gm-Features: AS18NWDe0QCBO_xfFFVdd4_0oRQnca8OG-hxRX2CoFLKyQS13SPatIyxuAJL3zo
Message-ID: <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 07:54, Kiryl Shutsemau <kirill@shutemov.name> wrote:
>
> The best case scenario looks great. 16 threads hammering the same 4k
> with 256 bytes read:
>
> Baseline:       2892MiB/s
> Kiryl:          7751MiB/s
> Linus:          7787MiB/s

Yeah, that certainly fixes the performance problem people saw with
contention on the page count.

> But when I tried something outside of the best case, it doesn't look
> good. 16 threads read from 512k file with 4k:
>
> Baseline:       99.4GiB/s
> Kiryl:          40.0GiB/s
> Linus:          44.0GiB/s
>
> I have not profiled it yet.
>
> Disabling SMAP (clearcpuid=smap) makes it 45.7GiB/s for mine patch and
> 50.9GiB/s for yours. So it cannot be fully attributed to SMAP.

It's not just smap. It's the iov iterator overheads I mentioned.

Those iov iterators are *slow*. Well, compared to a small memcpy they
are. They are out-of-line, but they also do a lot of tests for the
different cases.

So the baseline obviously still uses the iov_iter code, but it does it
on full pages, so the overhead is much less noticeable.

This is why I said that I think the next step is to just do the
user-space case, so that the loop can not only avoid the SMAP overhead
by using the user_access_begin() model, but so that it also avoids all
the iov iter costs.

                    Linus

