Return-Path: <linux-fsdevel+bounces-32244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5553D9A2B0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1051F218DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08261DFD8B;
	Thu, 17 Oct 2024 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa/1LoRr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459BE53E15;
	Thu, 17 Oct 2024 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186545; cv=none; b=uln7rurhFxVIOhnFmROILU7rme1wonaKqXJxI0uSxpcltYiHZH5tCvy8oQrXGwB5kjEAslvHaqhB6NBYz+VeTV0si2G0x1CSIgZ3B23+0iNyJvXfEu8G5qRmXqMHGl0mJn2MeyyyRyCUblO160fv8tyurBdF08xDfKEbqo0RgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186545; c=relaxed/simple;
	bh=MTL4uuULKkspe9V/zXAKr5oYrIGIOz3pQs6/71KqyuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZoOZDdsA/9qOhAxstB75CW3HdPLs3nHoReQjZfSN0tOePFJ1Ek97Mr3tJHmfhkbaSbzixL10cHMBDlrfznd+McQFOU/OJfAKjyBN3RFDN3JCfWe1Iw5AZZDqBVYNnlcfLuQSmWMf6jcvLnmxhmouzdg8rNXyzLtiGOiaEbvTqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fa/1LoRr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e5ae69880so965518b3a.2;
        Thu, 17 Oct 2024 10:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729186539; x=1729791339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cRq+JMgpIcPa51fjgQPc9Xd4RyxDQLcY0GP4aMUeu0=;
        b=fa/1LoRrFQGdHJj2gGCbvopR2TbYRRgyG/v+l8ZZwWbVFNHtDHrYZTHrM5GzZXwlHC
         J8YANl8RFF4buNtEeLozwwUQA/5WZFAZbElSa1N9MZY8Y+GlDm77QTAe5Gv2dakD1qDJ
         NSVJfdnMa5Dn4YUEGVjTWIimM08aA6zfigR+BnJJJOq6n7RLWu6Kjx+ulK8RK2bnpxDP
         yC86hdzSJRfXNNFicHwjL7QKv+pKw1ifXK3Bq3o4DJYEUPE0xb0JTh5MNH5OU0ldrmIw
         /iqhyxD4/XIPDSPvgGn5Z68/93XAef66KtNu4/8hvDSfcVEGWQHpBuacdiHTNC6ystNM
         6Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729186539; x=1729791339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cRq+JMgpIcPa51fjgQPc9Xd4RyxDQLcY0GP4aMUeu0=;
        b=j6Vdph6snwBe55DGau4NDO9E1ykBrmuiuJquqOv8QBl8zTnoLIuGFahf/F5Kw/IaIS
         NxCD0BdK+G8xdw58g4EzOhjoWeyFOEh/aBu3MEiidESREFL84WucIHQFnd8vMVf9eJFo
         oG5jQmnoeHma4oj2ZJfiLp7PNF+H7suvNBHWLe7fIDn1AyENHaQAYIbzksg5kbOvIMha
         6I2J24Cm31osAXn8HWbWqYabD728BT//5WZG0G1eL0Ckms72WPg+E/G1pqZKF2lHqCFI
         YGt2PioBH65RkDVgmUOusD3xcTCcoSMV5FVBAyY0Faaij26oz2eQ7IPLlGdNZabpuh34
         9TnA==
X-Forwarded-Encrypted: i=1; AJvYcCUVQEHAYqSkDTCsoKKjuxy+Kvdq1/oQisnpZGy9ydgyUyIkLqOSqT8WK5J+ae3AlSlRVSM=@vger.kernel.org, AJvYcCWiqzt+ZULrXSw8xz8OP+yLjFigkB5JW8usExrsguJ/qiikjOFAISk7Xf6fmBXcPzEBFzg1Gwksv9gUUBSS+g==@vger.kernel.org, AJvYcCWq3QvzUv1p6Uo78Kg/0nRubYtVsQ6sK5hu8DXVwv/M5N2TOONrIvQn76lvMp6itV4sgQaHv4sfFCjOM3jvtm9wPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCE+iJZ5cmYmcLZehHMmGHkLpZw/ncahfae+lTIIY2u1zOjI6u
	1XB1QZr1OiqfS6GcH7IeFeJsBmM8OY8CsJlW3CX81noOrwCb7IoFK+Xs28teeFkyoJJ0APapp0h
	zbmnXqGslC6krGadMfFolPecFAU4=
X-Google-Smtp-Source: AGHT+IFP1gS3BVli/9MbbFfT+uorzh3EZH4kvMyHBWdsERzNNEba4MsHj8+B6NXGoSl6fFdb21qxBv6QIYAYLHs0xHI=
X-Received: by 2002:a05:6a00:2353:b0:71e:59d2:9c99 with SMTP id
 d2e1a72fcca58-71e59d29ef4mr25732384b3a.4.1729186539552; Thu, 17 Oct 2024
 10:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016221629.1043883-1-andrii@kernel.org> <a1501f7a-80b3-4623-ab7b-5f5e0c3f7008@redhat.com>
 <oeoujpsqousyabzgnnavwoinq6lrojbdejvblxdwtav7o5wamw@6dyfuoc7725j>
In-Reply-To: <oeoujpsqousyabzgnnavwoinq6lrojbdejvblxdwtav7o5wamw@6dyfuoc7725j>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Oct 2024 10:35:27 -0700
Message-ID: <CAEf4BzZzctRsxQ7n42AJrm8XTyxhN+-ceE7Oz5jokz4ALqDekQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] lib/buildid: handle memfd_secret() files in build_id_parse()
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, g@linux.dev, Andrii Nakryiko <andrii@kernel.org>, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rppt@kernel.org, yosryahmed@google.com, 
	Yi Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 9:35=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Oct 17, 2024 at 11:18:34AM GMT, David Hildenbrand wrote:
> > On 17.10.24 00:16, Andrii Nakryiko wrote:
> > >  From memfd_secret(2) manpage:
> > >
> > >    The memory areas backing the file created with memfd_secret(2) are
> > >    visible only to the processes that have access to the file descrip=
tor.
> > >    The memory region is removed from the kernel page tables and only =
the
> > >    page tables of the processes holding the file descriptor map the
> > >    corresponding physical memory. (Thus, the pages in the region can'=
t be
> > >    accessed by the kernel itself, so that, for example, pointers to t=
he
> > >    region can't be passed to system calls.)
> > >
> > > So folios backed by such secretmem files are not mapped into kernel
> > > address space and shouldn't be accessed, in general.
> > >
> > > To make this a bit more generic of a fix and prevent regression in th=
e
> > > future for similar special mappings, do a generic check of whether th=
e
> > > folio we got is mapped with kernel_page_present(), as suggested in [1=
].
> > > This will handle secretmem, and any future special cases that use
> > > a similar approach.
> > >
> > > Original report and repro can be found in [0].
> > >
> > >    [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> > >    [1] https://lore.kernel.org/bpf/CAJD7tkbpEMx-eC4A-z8Jm1ikrY_KJVjWO=
+mhhz1_fni4x+COKw@mail.gmail.com/
> > >
> > > Reported-by: Yi Lai <yi1.lai@intel.com>
> > > Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> > > Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader=
 abstraction")
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >   lib/buildid.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/buildid.c b/lib/buildid.c
> > > index 290641d92ac1..90df64fd64c1 100644
> > > --- a/lib/buildid.c
> > > +++ b/lib/buildid.c
> > > @@ -5,6 +5,7 @@
> > >   #include <linux/elf.h>
> > >   #include <linux/kernel.h>
> > >   #include <linux/pagemap.h>
> > > +#include <linux/set_memory.h>
> > >   #define BUILD_ID 3
> > > @@ -74,7 +75,9 @@ static int freader_get_folio(struct freader *r, lof=
f_t file_off)
> > >             filemap_invalidate_unlock_shared(r->file->f_mapping);
> > >     }
> > > -   if (IS_ERR(r->folio) || !folio_test_uptodate(r->folio)) {
> > > +   if (IS_ERR(r->folio) ||
> > > +       !kernel_page_present(&r->folio->page) ||
> > > +       !folio_test_uptodate(r->folio)) {
> > >             if (!IS_ERR(r->folio))
> > >                     folio_put(r->folio);
> > >             r->folio =3D NULL;
> >
> > As replied elsewhere, can't we take a look at the mapping?
> >
> > We do the same thing in gup_fast_folio_allowed() where we check
> > secretmem_mapping().
>
> Responded on the v1 but I think we can go with v1 of this work as
> whoever will be working on unmapping folios from direct map will need to
> fix gup_fast_folio_allowed(), they can fix this code as well. Also it
> seems like some arch don't have kernel_page_present() and builds are
> failing.
>

Yeah, we are lucky that BPF CI tested s390x and caught this issue.

> Andrii, let's move forward with the v1 patch.

Let me post v3 based on v1 (checking for secretmem_mapping()), but
I'll change return code to -EFAULT, so in the future this can be
rolled into generic error handling code path with no change in error
code.

>
> >
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

