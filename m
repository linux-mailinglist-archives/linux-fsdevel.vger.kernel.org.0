Return-Path: <linux-fsdevel+bounces-69926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A22C8BFBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 22:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 487214E24FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 21:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83916298CDE;
	Wed, 26 Nov 2025 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fs5lw9CZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402145BE3
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764191581; cv=none; b=HGWVsskNWCL7nDMANXVy3VfrKR4reh7HhJn8FjQ9iNc+6qo1zA3fSi0plJMPiO/vbDWPY0vYimYuTNnyb8fZmvxEMjYfpdzzqre0X+XbO2JUaFEJvzqGwkK3iHYRE2mj5u4IoD58DlEnAtbUB1nLOZu5mTEvBvqjgfxnvsi3ROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764191581; c=relaxed/simple;
	bh=Q10QKezS6ud1U3pJNqkOEt0Radj10IBNvlm30dq8bgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGUhP0Dl7xrnnvW3qdLJulNcWNCiyMH3Y5bC9cpSzxDE36cuiS/jzMZD9Hawz3sOx7yAxvDdVZJNnZmICY02pJyYFwWtb71DGBbS7wQt7USvwFLVmNQI/hcUc5Kgjj925EC92KnO/CxwkGzeriGGWel+BULsUpUQi4/4xI/wyRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fs5lw9CZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b737c6c13e1so38514066b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 13:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764191578; x=1764796378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hrjCGTokKrR0BnJSuEojRuEu2dsqESmm8qkZ4/vDpA=;
        b=fs5lw9CZqSEoUPKMLW31Ct0O+VqXJEx5rHsp9+nVVHwjUzpfjEOVqTXE39JtliQZao
         7w+W1fRhc1cs6AHxnVqJrBXw6yXJJ/kJDbzSiCgAN07w/NR1v0fKOD9mf4DSpQKtLEOA
         RCOumBJHA5pdSUZff2nR3PWN8zMuYpf4kXLhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764191578; x=1764796378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8hrjCGTokKrR0BnJSuEojRuEu2dsqESmm8qkZ4/vDpA=;
        b=wK1O3tjqbtOHHGtQBFWFXkXTa19qcxA2KWwgZvb+5jXQoxmI6gsMMOo6b84b3zswId
         q6SNC3WUfzLIw4wha1mJHHW2sE+Fxjm6E+S2IxIAaVUlqUwZ0s53UmRVWjBGSTohYRed
         vKbL42mluwbL8jIrgzBzN2VumRIVo/V3mxPnQhUDIjAPNMlsR+X33oU+xcYCcLCSNKl/
         57L2UAQ8RoNRkam/xcrWtKkq3ncaSNi3mqSWGctuE5NmqSY9d1c5uvn+6I3/HBILDZ1P
         VDmaYmmwv+VTMY1uOd7uEr+5j8FbMRVzIy/DTNOWBi48Hfa1XvhARsUCG8gMJMyCAIpE
         YCTA==
X-Forwarded-Encrypted: i=1; AJvYcCXzbXDoOPZEx2A6BWJT+aLgzotAmebWuDlnkqIVlN4tCoE1kuouUmXSMKIcqjYJSPjUje94XG7Odh//RUTg@vger.kernel.org
X-Gm-Message-State: AOJu0YyHApwCeMIJXqKW6cQ98ZG2gRDkvCEhSEaAcFaHJ8Es6Ceei1Qm
	zcN4GoXbM9Ps9ncpJZtrkE7qVnp7Zsmg/QkGKFBLO0pc4csL5e7lVn6F9IqHN/SYDr9WWJw6+u3
	/uJGP3pc46A==
X-Gm-Gg: ASbGncsFRyAN2cUa7yJ2j2LIKUztecs1ZcbsFAhVZTzky2X4eAKk4dbQJwqIyZH4ycH
	//s+mbRDy1tiXpIPcsudE7RMeBH7a1fK185z7E44R1/dTQAD2gvfUtTMLXbi7oyD0U4bMiiZfuR
	FQZWIxWSmS5eIzOdd7QpK5xPBf0t+mn2otbX2e7RW/HSD0HpYmUFXrGyjTtKwTW8viK4C7cglJe
	UyO2Vy4r3WtJFBDKlsji1i2POes5PnEtD+e1UhOy19Z5SlKEK3spmKFci/3YBWXsPfe5oOpQvu/
	OnQxH5Scceqvw4NiPhRmr5YWbDvaoPyPvZpxJ2wq1qFprX7bCSji+AEUtQB6/cX/kytejU5FrRY
	lHNJ9RDu5uFAOBnmXiULIzMp+eJWL8RTgdg0aj2ky8gtWQCQ2ijcpjCj3F8UseLJMqrpeQydCsv
	LZwBR2e5pVNAzHUz3eb+VStTw64UW1dgh4TgQCNrRbYGB/So2WIYKJCZah9FV7
X-Google-Smtp-Source: AGHT+IFsXtX0VEbRnO7rxWSiRUOUWSiWLslvXiGCNfxSaBwLyvxmviYjiUOFZdglBCsugGtKls1pnA==
X-Received: by 2002:a17:907:720e:b0:b73:5db4:4ffc with SMTP id a640c23a62f3a-b76c5666cc8mr974219766b.54.1764191577454;
        Wed, 26 Nov 2025 13:12:57 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd43b1sm1949544966b.38.2025.11.26.13.12.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 13:12:55 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so461835a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 13:12:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQjBcpbvmSu7J/0f8Eh2FYfkpr+r5bq2EmhzcA+4ue+S+N8CBDVXkq///7NJt2TyxePqaIHnzYOwUznkXp@vger.kernel.org
X-Received: by 2002:a05:6402:5192:b0:640:d061:e6b1 with SMTP id
 4fb4d7f45d1cf-645eb23b736mr8204227a12.10.1764191575057; Wed, 26 Nov 2025
 13:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com> <33ab4aef-020e-49e7-8539-31bf78dac61a@huaweicloud.com>
In-Reply-To: <33ab4aef-020e-49e7-8539-31bf78dac61a@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Nov 2025 13:12:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com>
X-Gm-Features: AWmQ_bmijlsSBxI6qiVA8VQBddyswwSNhEs1F3E3qSXMF5yTCuTDAsS8SQqTKN0
Message-ID: <CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com>
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
To: Zizhi Wo <wozizhi@huaweicloud.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: jack@suse.com, brauner@kernel.org, hch@lst.de, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, 
	yangerkun@huawei.com, wangkefeng.wang@huawei.com, pangliyuan1@huawei.com, 
	xieyuanbin1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Nov 2025 at 02:27, Zizhi Wo <wozizhi@huaweicloud.com> wrote:
>
> =E5=9C=A8 2025/11/26 17:05, Zizhi Wo =E5=86=99=E9=81=93:
> > We're running into the following issue on an ARM32 platform with the li=
nux
> > 5.10 kernel:
> >
> > During the execution of hash_name()->load_unaligned_zeropad(), a potent=
ial
> > memory access beyond the PAGE boundary may occur.

That is correct.

However:

> >                This triggers a page fault,
> > which leads to a call to do_page_fault()->mmap_read_trylock().

That should *not* happen.  For kernel addresses, mmap_read_trylock()
should never trigger, much less the full mmap_read_lock().

See for example the x86 fault handling in  handle_page_fault():

        if (unlikely(fault_in_kernel_space(address))) {
                do_kern_addr_fault(regs, error_code, address);

and the kernel address case never triggers the mmap lock, because
while faults on kernel addresses can happen for various reasons, they
are never memory mappings.

I'm seeing similar logic in the arm tree, although the check is
different. do_translation_fault() checks for TASK_SIZE.

        if (addr < TASK_SIZE)
                return do_page_fault(addr, fsr, regs);

but it appears that there are paths to do_page_fault() that do not
have this check, ie that do_DataAbort() function does

        if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
                return;


and It's not immediately obvious, but that can call do_page_fault()
too though the fsr_info[] and ifsr_info[] arrays in
arch/arm/mm/fsr-2level.c.

The arm64 case looks like it might have similar issues, but while I'm
more familiar with arm than I _used_ to be, I do not know the
low-level exception handling code at all, so I'm just adding Russell,
Catalin and Will to the participants.

Catalin, Will - the arm64 case uses

        if (is_ttbr0_addr(addr))
                return do_page_fault(far, esr, regs);

instead, but like the 32-bit code that is only triggered for
do_translation_fault().  That may all be ok, because the other cases
seem to be "there is a TLB entry, but we lack privileges", so maybe
will never trigger for a kernel access to a kernel area because they
either do not exist, or we have permissions?

Anyway, possibly a few of those 'do_page_fault' entries should be
'do_translation_fault'? It certainly seems that way at least on 32-bit
arm.

Over to more competent people. Russell?

              Linus

