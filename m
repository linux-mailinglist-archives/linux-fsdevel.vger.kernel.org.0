Return-Path: <linux-fsdevel+bounces-63608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F8DBC605E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 18:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3763B0898
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE218F49;
	Wed,  8 Oct 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Oqy7ySvB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FF129B8E5
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940885; cv=none; b=WR4XcddWwJF8rEJCoMvAUxvCJgF2nLXzqAMq4ig775/gcOUDdAvfeHM4PfpxyukMmQzTa8vMWtfyhKY8HTtGR3+5LWQDcbMxWgfqjidcTALT5NARk5UXE5GcXyde7EgCfDaTujUsCB6msvRqjshTkDqn/CbOGFRRNj31ipLR7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940885; c=relaxed/simple;
	bh=m6uUvqSqb8LfKXllguL5/0G50xrdlHHc0hOb1sIeJEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDGkD8hl3BVkWfOqvKV8zyPiq+LhwFlXN3aF4OPNhozqPqFpVfEXDSJoIaI7a1Ko5aEdZho1GA5WEJtAYj8aSMTYaO8Ze5RyKSxYkthIojDpEc6ceOWYPH7ywDqScxExAgmzmFuySjQGD7dLeT1hEkY6OVI3d8Y6V2eSnoyAdWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Oqy7ySvB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3d50882cc2so47041766b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759940880; x=1760545680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ig2GLHE8hlKLEgmzJH4+emiSgZo32NUB86/I21OU+Y0=;
        b=Oqy7ySvBmOpdLTOhNBH+0Bi/Ej31uJvNQtTKmYq5FZCJx4zzUKk37t8I8fourVPfw3
         v33Ke0db9TpYLwe/0zGAwZfCFG6zAtbJFj0jajTgDw6M+qMvH/uR6I5ShWw7UcCBoAe3
         HisH3/AkYlhukZZ9w9GWYBvj6mcjY43T1C3+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940880; x=1760545680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ig2GLHE8hlKLEgmzJH4+emiSgZo32NUB86/I21OU+Y0=;
        b=ole44MzweOSJk/VzqoZiA0AENtFk5RMunGNWeXewe7RucdLQak1yVxdIoaMCPw23Nd
         OQqrTk9nVvMQaEsx96tcn0kUYpv/Rp/xdselBQnCrbGGAzEhuObSMFDBGxsxfZ86TJfJ
         95Ta0OZqewFv9pwoyKP9sJOEac3DTA43p9EgfwK8ZmJQkxdtF8NL7Itui0t3MVfF966e
         fYO008+pAyPr/jV8AbawD5GlIx9gx5EGzG/L6J08MpNfahjoSlopeHhv18YKQ3kDZwyX
         m/qaXDGUZkHDpCgwQm6ktml2k/cEPm+5usbE8+9umPNtLquo84mus9kug2jZ7ABBcQIC
         2e6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpouAAUQGnkzEaBlZM502DffPB7XiGaOxDNCM6XiHCcS22dUwLLQYYdvgvmhpxu/CZ4tILj36qNHDYXM+c@vger.kernel.org
X-Gm-Message-State: AOJu0YyIXRFk+f5FrLHjxKhMIFW237I54THX/bXDkeK+/+6GpkYUgJ3w
	Mj2DSRuwY5Q3Ts8K7dxGO4kGufgRvIj9ylT/fWz1MSvQRyQu1Jscp6sRzIW9FV87PbMdp/lHl90
	SGkAAHRI=
X-Gm-Gg: ASbGncvnoF+7Lp3rJ560mRqaEQX1WL4nzophFos6ViaMVtBYxmeapXqY8zGpEHWFk0S
	qtDm1U7RVaZz/MfCmLhWvf4DMbFiJFTkNp36BL8FZDG64tYy0o59WxHeyL//cD2sSQgxzjDJIeL
	umMC1gdxRFzK+pi4FY722ve+wra5+tkFQB0RorDBEcSruJJ2fYb7xoh78uiUTHb1m9I0kB47roL
	BIiBrvrUHaxzqDifKrnb3VAWZLlfUjzdgbtvNwq6rENqTPD3QZ/rpxYhP3BvYBYIPVj0kOroq1i
	xR/nUAjOatjWfCWGD+o6Hbif5BMcsmBwohGaC0jhZe3Zr8xkYjhSRa7hDRsm9FAmAA4Zyors6Nd
	7b+fbho93RWG0q1gGo7/GdEDbOY44aq05Su0rMCjuEvp1AW+rnYNktrQ30DAbA0NgzNyIT1KYdm
	+o7IwHs+txlBxBfDf7lD+F
X-Google-Smtp-Source: AGHT+IEt6pt5aohwZYX0SILpnz2yAA57z/0ehZtV4u6/1WABoEtfY68dYXK92EQcx8niGYKDsiWVTg==
X-Received: by 2002:a17:907:843:b0:b40:98b1:7457 with SMTP id a640c23a62f3a-b50ac5d0901mr417660566b.47.1759940880414;
        Wed, 08 Oct 2025 09:28:00 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa04bsm1693248266b.6.2025.10.08.09.27.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 09:27:55 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so11631873a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 09:27:54 -0700 (PDT)
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

