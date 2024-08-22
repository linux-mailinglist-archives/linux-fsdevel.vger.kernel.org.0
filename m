Return-Path: <linux-fsdevel+bounces-26846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E88C95C12A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 00:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CF91F25028
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 22:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6041D1F75;
	Thu, 22 Aug 2024 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEiL6sz3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F712B72;
	Thu, 22 Aug 2024 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724367371; cv=none; b=lfFArweHlBLk6Xy5i9Q8VaSPqobqbmY2u49K6xuigDhC8Ko2IEAAMW7i8unXXfv9ta+6tEbtZPc9msrTiIV90mqLAiWL246EP/79+XfAyHy5DEohzfLSfmPoDRxH3KCm5BYQQs2G1s/pIpbiFzHnHj8Mn95jXsAPEd5uzqtLYxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724367371; c=relaxed/simple;
	bh=jp6hdv0x0pGPk/8d6Dw0e7HOMQD0zELnWGbtxaT+wDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfrS2cu8Id/UFujbKEq8asYxLJg5aYtLJi67f4OjCOLWDm/IykcbUdBR4BDYqa0WcRI9OAvmjz0uQS7a+j/HEj9D9lReAsclk9pYJ6W9HvA4EByAHY7RZGslnoLb49F/srqx86FzeGoMftxWIioyS3Xr3jktWytW/qnLohQN/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEiL6sz3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3ce556df9so1031203a91.0;
        Thu, 22 Aug 2024 15:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724367369; x=1724972169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjfM1tDPtzJW0CXat37/s7Shi6wDy4arWqqG5/O7u7Q=;
        b=cEiL6sz37oqZM3oTGkILTTAhbzxwYLCg6Q/ihE1n1rdfIYcGW3lOl6pI8WJY0hRFnB
         n/C2tSnHvbYnFfuTMianRDFUCG2Av3cpgzJkcCgCn0z7eol6eBBj7bboF+xBAkhrjKlW
         QVHFbXD3pQ8tJ9+nRM6+qIh7ELEua5aXdJUW8ED5sVa2eEQF3+mkqXOfLWbE+cYtvmTj
         W5C65NRXysGNeXurdVUIIoo24gU1KnQhVy8a97Ch140QcsObcs6qs30hWou0R9/+xQm1
         RGyo8twPnpHpXiN49oDTtPL88xyZhfQrjYbhTT/Jt8bVfWZJXnyxiNWwD0Hv6DZdz2Zw
         +fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724367369; x=1724972169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjfM1tDPtzJW0CXat37/s7Shi6wDy4arWqqG5/O7u7Q=;
        b=Gdm0pOqVrNo8Oy/5tMaV9JXcM4iLm87EQEQQHBKWSOyib5iZOHzP0XGlK56enrCSrP
         WBzlUHQl48QnsCGxBd5/7bmuB7u5moigFRWdjuUkm8sFPfBa7+Mv76vImOgcFyiH1jzn
         Gz9a+Zb1qhLKKx2mySPLIrx3PJTjZTQWHsLStVt7A6HoQZsItlAwKCdAUkJI9kc3dm9e
         WUmmFIUPDO7WpMCddJIruL3pPUXQHkZvLrGUXauqrs4XKfpNQXQjblrdXoQ7MR/Hsq08
         ii9z7NPlXJFAEAIbYJ75C4+oq8FcSFqyorA6efXeyCw1qo7bzMdzxD1IK/OMM8DPDmUY
         8LdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFrGeL24GWPz0jz8AcNzUajAwnuW7uTp6L4eTOsdpDnWS6+CPQsqjdNCSiraoxTYwRLC4=@vger.kernel.org, AJvYcCXbbX5rEaRqUgw2/WgxIJikVj7cJy/thS4OOyl/ZIb1mNef90jPdhVOaPSKkh2ysnvLdDpguUgG3prRVr8hWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJP+78T72giwgCjOxK7RDagqIBagXrs+9iodMEmzAzPWiZ5xh
	v3GX6wbnLXls4b27BZKPLQlWlht/NAoAeognRY269Xyz9n8PXydStVi8N/LYZ6bEYjAKRnD1J1P
	UlDc0SoRM77L94RqGHf4CQd0Za/c=
X-Google-Smtp-Source: AGHT+IE7BQzGG9IQdWyZ7CNB4himy3Vyu7t/fW6gQnY84i3UivtF8Mh5TAs94EbgeLdTO8xhY2RCyRCtGztl+0q9NHw=
X-Received: by 2002:a17:90b:3549:b0:2c9:58dd:e01d with SMTP id
 98e67ed59e1d1-2d646bc6dafmr228008a91.14.1724367369019; Thu, 22 Aug 2024
 15:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814185417.1171430-1-andrii@kernel.org> <20240814185417.1171430-11-andrii@kernel.org>
 <e973f93d1dc2ebf54de285a7d83833ea6c47f2a2.camel@gmail.com>
In-Reply-To: <e973f93d1dc2ebf54de285a7d83833ea6c47f2a2.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Aug 2024 15:55:56 -0700
Message-ID: <CAEf4BzZULffF9_6Mz4dxm=owvSkyErt3kShZpxjFnCySzGDWNw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 10/10] selftests/bpf: add build ID tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com, linux-fsdevel@vger.kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 3:30=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-08-14 at 11:54 -0700, Andrii Nakryiko wrote:
> > Add a new set of tests validating behavior of capturing stack traces
> > with build ID. We extend uprobe_multi target binary with ability to
> > trigger uprobe (so that we can capture stack traces from it), but also
> > we allow to force build ID data to be either resident or non-resident i=
n
> > memory (see also a comment about quirks of MADV_PAGEOUT).
> >
> > That way we can validate that in non-sleepable context we won't get
> > build ID (as expected), but with sleepable uprobes we will get that
> > build ID regardless of it being physically present in memory.
> >
> > Also, we add a small add-on linker script which reorders
> > .note.gnu.build-id section and puts it after (big) .text section,
> > putting build ID data outside of the very first page of ELF file. This
> > will test all the relaxations we did in build ID parsing logic in kerne=
l
> > thanks to freader abstraction.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing=
/selftests/bpf/uprobe_multi.c
> > index 7ffa563ffeba..c7828b13e5ff 100644
> > --- a/tools/testing/selftests/bpf/uprobe_multi.c
> > +++ b/tools/testing/selftests/bpf/uprobe_multi.c
>
> [...]
>
> > +int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
> > +{
> > +     int page_sz =3D sysconf(_SC_PAGESIZE);
> > +     void *addr;
> > +
> > +     /* page-align build ID start */
> > +     addr =3D (void *)((uintptr_t)&build_id_start & ~(page_sz - 1));
> > +
> > +     /* to guarantee MADV_PAGEOUT work reliably, we need to ensure tha=
t
> > +      * memory range is mapped into current process, so we uncondition=
ally
> > +      * do MADV_POPULATE_READ, and then MADV_PAGEOUT, if necessary
> > +      */
> > +     madvise(addr, page_sz, MADV_POPULATE_READ);
>
> Nit: check error code?
>

Well, even if this errors out there is no one to notice and do
anything about it, given this is in a forked process. The idea,
though, is that if this doesn't work, we'll catch it as part of the
actual selftest.

> > +     if (!build_id_resident)
> > +             madvise(addr, page_sz, MADV_PAGEOUT);
> > +
> > +     (void)uprobe();
> > +
> > +     return 0;
> > +}
> > +
>
> [...]
>
> Silly question, unrelated to the patch-set itself.
> When I do ./test_progs -vvv -t build_id/sleepable five stack frames
> are printed:
>
> FRAME #00: BUILD ID =3D 46d2568fe293274105f9dad0cc73de54a176f368 OFFSET =
=3D 2c4156
> FRAME #01: BUILD ID =3D 46d2568fe293274105f9dad0cc73de54a176f368 OFFSET =
=3D 393aef
> FRAME #02: BUILD ID =3D 8f53abaad945a669f2bdcd25f471d80e077568ef OFFSET =
=3D 2a088
> FRAME #03: BUILD ID =3D 8f53abaad945a669f2bdcd25f471d80e077568ef OFFSET =
=3D 2a14b
> FRAME #04: BUILD ID =3D 46d2568fe293274105f9dad0cc73de54a176f368 OFFSET =
=3D 2c4095

In my QEMU I only get 3:

FRAME #00: BUILD ID =3D d370860567af6d28316d45726045f1c59bbfc416 OFFSET =3D=
 2c4156
FRAME #01: BUILD ID =3D d370860567af6d28316d45726045f1c59bbfc416 OFFSET =3D=
 393ac7
FRAME #02: BUILD ID =3D 8bfe03f6bf9b6a6e2591babd0bbc266837d8f658 OFFSET =3D=
 27cd0

But see below, for my actual devserver there are 4 frames. My bet
would be that 568ef is libc. A bit confused why you get frame 04 from
uprobe_multi, but maybe that's how things work with musl or whatever?
Don't know. Check libc.so.

>
> The ...6f368 is build-id of the uprobe_multi.
> How do I check where ...568ef comes from?
> Also, why are there 5 frames when nesting level for uprobe() is 3?
>

Well, libc has some function calls before it gets to main. E.g., for
my local machine:

$ sudo bpftrace -e 'uprobe:./uprobe_multi:uprobe { print(ustack()); }'
Attaching 1 probe...

        uprobe+4
        trigger_uprobe+113
        main+176
        __libc_start_call_main+128

Note that you won't have trigger_uprobe in your stack trace until your
kernel has [0]

  [0] https://lore.kernel.org/linux-trace-kernel/20240729175223.23914-1-and=
rii@kernel.org/

