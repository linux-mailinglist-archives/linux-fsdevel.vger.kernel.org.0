Return-Path: <linux-fsdevel+bounces-32140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC719A130E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 22:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16ABB22B17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 20:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D668D215F5C;
	Wed, 16 Oct 2024 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ADUoIMa2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB82144D3
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108795; cv=none; b=X2SmmrV3Jw7B7W1haitKYgdc5p7SPIuC1+hp77C0jF/nBCRx5NtAzYhvJ4LoWKM5lcCxiKr4Td2Y/MEfSe44UvnQWnNOliT1RyTkBTxGm/K2P9p2SlLq7AFjq78b0KHW5aRXkGzIWSu2HLmLLu/MofvQvX8xCuH2OyfALdkKon8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108795; c=relaxed/simple;
	bh=/ZtkV779/ytLCI0J/cbkxqqXWmY0bXLd/xN+SO3bDw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdoBANkHwKWiXOoM5cFFbnN0NhwKVp2DrZRfVY5v1+t7XIhNGgApohzU2RBernfSufKM2R0dG9x3wg4twQkUGySU0anK/vDNm1b4ZlxjezKGNf5YdouwIT3onBFGKDamAajmNp4PDkXJu0wsW9GWDQDuN4amQnrJsVI/yMxYP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ADUoIMa2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a156513a1so26301566b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 12:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729108792; x=1729713592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+lPf3FNOmE8pMU/2Iycp1XnYxIydARXrVQNA1uL0No=;
        b=ADUoIMa2s+9DQ2EaNc3U00HPIBmyZ/dqzWJMR/kUt4DqIP7kmBNylM5/QFVQXGGdpg
         IREOqLlR0FwQzeJOLuDDoCPzvlve0VsUOVPecl1g2rYx30d9Fxls0ka09Yl+AQ9T+3u9
         y6cmnc7OZKXVxVlz/J9HWJ6TyBzfbPjQ/MkLc1KI57qDiG3+goIiB35KH6mLhOpObZ0f
         UNce0sZrpwsvrs3Vf18bnu/gOboa1fwO2clAbtyF6AIdzgoyKfJ0+Qi6tbBbMWOkv6mI
         1f53l0l3vPaxqlRr9uootXR8YQUHWNL7VVO3/P/RHyFx6Tb1DyirgFL4cmZ+qlKx5pea
         OIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729108792; x=1729713592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+lPf3FNOmE8pMU/2Iycp1XnYxIydARXrVQNA1uL0No=;
        b=UwSe5NrjJfdY+UJ6IBGeuZ8fMrMEtVIe5Ary5AH6hCE603tNlixEDPH5ihoMFJBepO
         b286WT1gbFU+VlaH4FK/GLKt/I2QHmJMwfx4Q1DCROg+PlDFfVdFaC6EZ1niNTlqhlqG
         WIs5JI8Mxs4LY/L8XHxf2VOnP3ycLWYnqJAFesxBi1+S8qdCTTQH5WgcQFX7g7fOfkAI
         BikDdJcDM8qtNlI/KF+z8SdLaYohebDEfHUWxKqV6bfdalqk0g1bLl9IP7m9Qfaux+4v
         axKkFELIoqdRZMzsR/ufWYZhjEoy1btT3MZmzEvi1qx+xfKiR5x0+AkEBnFo9zyaJwNV
         OEig==
X-Forwarded-Encrypted: i=1; AJvYcCWlnCdA81W1DSE+6LhNMyPSzHzqNWBMOPdOm0RK21rSdVfbcxvyQUx4q6ONIMqPF9hScEwkaSlQlBjxwk2t@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8ATD24gbI/M+IAKcyUwQR8Yguf68r9BpDwChz9kneELNWznh
	V3ZZMOPHr/CQ4yaY4tA3XLdMwLAMBjABKhkFPXnHcyvd+TiZQYweznkyWJmsz9FLdXzNX08yZoj
	1aDqJ7ZEM7jz1u9vKE/BWtbRivvlr/G0MzOKg
X-Google-Smtp-Source: AGHT+IHeHGSJGST3y7pnbjWTe7yANkgiRQ1Q+ewN/4YgOGby4P6amBbfCGy33IqgOgmGsE0A8OhBdeVemB3UzdU3xTM=
X-Received: by 2002:a17:907:9815:b0:a99:5d4c:7177 with SMTP id
 a640c23a62f3a-a9a34c80793mr404655566b.6.1729108791587; Wed, 16 Oct 2024
 12:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014235631.1229438-1-andrii@kernel.org> <2rweiiittlxcio6kknwy45wez742mlgjnfdg3tq3xdkmyoq5nn@g7bfoqy4vdwt>
In-Reply-To: <2rweiiittlxcio6kknwy45wez742mlgjnfdg3tq3xdkmyoq5nn@g7bfoqy4vdwt>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 16 Oct 2024 12:59:13 -0700
Message-ID: <CAJD7tkbpEMx-eC4A-z8Jm1ikrY_KJVjWO+mhhz1_fni4x+COKw@mail.gmail.com>
Subject: Re: [PATCH bpf] lib/buildid: handle memfd_secret() files in build_id_parse()
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Yi Lai <yi1.lai@intel.com>, pbonzini@redhat.com, seanjc@google.com, 
	tabba@google.com, david@redhat.com, jackmanb@google.com, jannh@google.com, 
	rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 11:39=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> Ccing couple more folks who are doing similar work (ASI, guest_memfd)
>
> Folks, what is the generic way to check if a given mapping has folios
> unmapped from kernel address space?

I suppose you mean specifically if a folio is not mapped in the direct
map, because a folio can also be mapped in other regions of the kernel
address space (e.g. vmalloc).

From my perspective of working on ASI on the x86 side, I think
lookup_address() is
the right API to use. It returns a PTE and you can check if it is
present.

Based on that, I would say that the generic way is perhaps
kernel_page_present(), which does the above on x86, not sure about
other architectures. It seems like kernel_page_present() always
returns true with !CONFIG_ARCH_HAS_SET_DIRECT_MAP, which assumes that
unmapping folios from the direct map uses set_direct_map_*().

For secretmem, it seems like set_direct_map_*() is indeed the method
used to unmap folios. I am not sure if the same stands for
guest_memfd, but I don't see why not.

ASI does not use set_direct_map_*(), but it doesn't matter in this
context, read below if you care about the reasoning.

ASI does not unmap folios from the direct map in the kernel address
space, but it creates a new "restricted" address space that has the
folios unmapped from the direct map by default. However, I don't think
this is relevant here. IIUC, the purpose of this patch is to check if
the folio is accessible by the kernel, which should be true even in
the ASI restricted address space, because ASI will just transparently
switch to the unrestricted kernel address space where the folio is
mapped if needed.

I hope this helps.


>
> On Mon, Oct 14, 2024 at 04:56:31PM GMT, Andrii Nakryiko wrote:
> > From memfd_secret(2) manpage:
> >
> >   The memory areas backing the file created with memfd_secret(2) are
> >   visible only to the processes that have access to the file descriptor=
.
> >   The memory region is removed from the kernel page tables and only the
> >   page tables of the processes holding the file descriptor map the
> >   corresponding physical memory. (Thus, the pages in the region can't b=
e
> >   accessed by the kernel itself, so that, for example, pointers to the
> >   region can't be passed to system calls.)
> >
> > We need to handle this special case gracefully in build ID fetching
> > code. Return -EACCESS whenever secretmem file is passed to build_id_par=
se()
> > family of APIs. Original report and repro can be found in [0].
> >
> >   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> >
> > Reported-by: Yi Lai <yi1.lai@intel.com>
> > Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader a=
bstraction")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  lib/buildid.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/lib/buildid.c b/lib/buildid.c
> > index 290641d92ac1..f0e6facf61c5 100644
> > --- a/lib/buildid.c
> > +++ b/lib/buildid.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/elf.h>
> >  #include <linux/kernel.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/secretmem.h>
> >
> >  #define BUILD_ID 3
> >
> > @@ -64,6 +65,10 @@ static int freader_get_folio(struct freader *r, loff=
_t file_off)
> >
> >       freader_put_folio(r);
> >
> > +     /* reject secretmem folios created with memfd_secret() */
> > +     if (secretmem_mapping(r->file->f_mapping))
> > +             return -EACCES;
> > +
> >       r->folio =3D filemap_get_folio(r->file->f_mapping, file_off >> PA=
GE_SHIFT);
> >
> >       /* if sleeping is allowed, wait for the page, if necessary */
> > --
> > 2.43.5
> >

