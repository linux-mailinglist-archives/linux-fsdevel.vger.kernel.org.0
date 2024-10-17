Return-Path: <linux-fsdevel+bounces-32254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4CD9A2C18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 20:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C003628110D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 18:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9809C1E0093;
	Thu, 17 Oct 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfAmsqyw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289061DEFE1;
	Thu, 17 Oct 2024 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189410; cv=none; b=VhiGM68nnVqjxGHQdBIXA406eHaEoi4lHHQnBsClzobQ0vfjqvR4jRUHtWA7CDX5GC4Pmtwa1ADyvXmQWNznh+HpP2TDJMREvjeLHlRCr/fl/BGv7izNWaL+o0CUONS0HVtVWfXEUaWRW1t/q6+22VB5yWrwPOds4x8OqR3rDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189410; c=relaxed/simple;
	bh=18l6RZ54DUWULih3W9Ca6LERwzckD1ZjIf1FGrOlYPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFLrisAkz0bP2blv4CQ/ry1O5VmaP7MBnBMvNydAmUNetqZOTfBbhCU+1XA5Sj4z2AtOkb+ebaJ2uCvUAffgANQJs3Mi2hZRsukb88jlKSjOeE3jeC3QcnGGeUXAfyVLyfCiCsXkDPu64j4H7s6SMbYBPXpCIlCo0WWr6QHvJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfAmsqyw; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea16c7759cso907942a12.1;
        Thu, 17 Oct 2024 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729189404; x=1729794204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOLEZHZduSKOnLcE2CedxVx0uFaoQesmwlY7QEN4e9I=;
        b=GfAmsqyww2YwPxKYC9gULr2w9tqriExoCJQLc9ANOpg0zEsRxlbLP+OwFrqARda9tR
         7Hh8MxYxIZhSrjijPNqcTi3aq9ExLwsCVApHPjihn+vMqaSSrxpwYSyBl/31neliNg7D
         os8nouO6VvYP0Tr24akFbdWtt6TQCluS9hKbsx1/i+IbkiOq8sAjMeUJ4bWs6YxFsgIx
         GOBiySzdooLaCBAyn+yUdARqiQftTnf1V2R5c0xzC+FnRIXb7BBCo0F5eamM8jzO+FAY
         9WKIihQGG3d7zmB0Jm9ncNk3gURQMgjnDupggKwDSZSQNBJqAt+eMwNvMNaAVGzhosSj
         VGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729189404; x=1729794204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOLEZHZduSKOnLcE2CedxVx0uFaoQesmwlY7QEN4e9I=;
        b=ej42c24oeNVKufIgwPG8A9YMDH7NloHnB7JUCnVT91iWKKqNkfpe4q2PfFogvSk/+f
         hD5lkXGmLLpePISYmBHkrBV7EoXeaRTZPFvvwm0/+PMCxA/Qpt7caJkamGT1ZcZ0OKx0
         wP52qoLItcQYIj5W77I/monaKGMTpAYg0Vibde4yS+2hye7pZHsnEvUF6uPXy1xNW+2a
         68U7Q49x23NcNwke8ibsrVEGLizv56KJJ2sUAgwtHX4AneHa+Isln0xpBI2lQregavhW
         wXb3WTW9gR5OughL6n7Tar+JPODenDoRlknmIdkhE7dXO0LW//6+EV1GOd0klKnP0RDd
         dFdg==
X-Forwarded-Encrypted: i=1; AJvYcCUlkie5+FgLznAulwzoD7fr6CrHAM/0YeF3F/Q0eAr9MAHjjBa+tmNh4/rrN1jC3nSDClQ=@vger.kernel.org, AJvYcCVUkCyOR3zkSh0q135VaPU1AfGM4u+LssR9/AbUmqaqQZamOMUy2ISd/0FM7c1sJTyyZc/V1/ppSuPusM4PmQ==@vger.kernel.org, AJvYcCWN5Jo4xaZu5hqqKCU+NPLsqd9fzZosiuvvf7ASpH/B2gGSkM02CcPryfmuEP3HdLJMmx+Uz9LE3xOijDHlRECMNw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh8RUmxk+l0JnNlR1N4hJVtETwUxY3Qcf+FCEQ5Qv1QZe5VJJi
	MKdN4b5Q4oyCzCCV89NLPjnWxoHjrzLRaunl6ib5v2mDC9DHudBJJbaaWK4u2HlxloB32QnbiVC
	JzaTPxEJRr/burS7ib13cvEmtMuQ=
X-Google-Smtp-Source: AGHT+IH9EGbXN7YrhF+S7KBlnxL2vv1fwsesbBtazSwdMNdt5xBU/sgel2PbdCKNRRSQsZWpaNjUqdWfOZc+ovBGWaM=
X-Received: by 2002:a05:6a21:e8a:b0:1d9:181f:e6d8 with SMTP id
 adf61e73a8af0-1d9181fe778mr5813230637.31.1729189404306; Thu, 17 Oct 2024
 11:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016221629.1043883-1-andrii@kernel.org> <a1501f7a-80b3-4623-ab7b-5f5e0c3f7008@redhat.com>
 <oeoujpsqousyabzgnnavwoinq6lrojbdejvblxdwtav7o5wamw@6dyfuoc7725j>
 <CAEf4BzZzctRsxQ7n42AJrm8XTyxhN+-ceE7Oz5jokz4ALqDekQ@mail.gmail.com> <20241017175431.6183-A-hca@linux.ibm.com>
In-Reply-To: <20241017175431.6183-A-hca@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Oct 2024 11:23:11 -0700
Message-ID: <CAEf4BzaPAJ_wHKRR5PVxt=pb+Y+rmk-MQYpf1Hyph_Z0vLu8jg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] lib/buildid: handle memfd_secret() files in build_id_parse()
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@redhat.com>, g@linux.dev, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	rppt@kernel.org, yosryahmed@google.com, Yi Lai <yi1.lai@intel.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 10:54=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com>=
 wrote:
>
> On Thu, Oct 17, 2024 at 10:35:27AM -0700, Andrii Nakryiko wrote:
> > On Thu, Oct 17, 2024 at 9:35=E2=80=AFAM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > > On Thu, Oct 17, 2024 at 11:18:34AM GMT, David Hildenbrand wrote:
> > > > As replied elsewhere, can't we take a look at the mapping?
> > > >
> > > > We do the same thing in gup_fast_folio_allowed() where we check
> > > > secretmem_mapping().
> > >
> > > Responded on the v1 but I think we can go with v1 of this work as
> > > whoever will be working on unmapping folios from direct map will need=
 to
> > > fix gup_fast_folio_allowed(), they can fix this code as well. Also it
> > > seems like some arch don't have kernel_page_present() and builds are
> > > failing.
> > >
> >
> > Yeah, we are lucky that BPF CI tested s390x and caught this issue.
> >
> > > Andrii, let's move forward with the v1 patch.
> >
> > Let me post v3 based on v1 (checking for secretmem_mapping()), but
> > I'll change return code to -EFAULT, so in the future this can be
> > rolled into generic error handling code path with no change in error
> > code.
>
> Ok, I've seen that you don't need kernel_page_present() anymore, just
> after I implemented it for s390. I guess I'll send the patch below
> (with a different commit message) upstream anyway, just in case
> somebody else comes up with a similar use case.

Please do send a patch, yes. It's good to have complete implementation
of this API regardless. We can then switch to either
kernel_page_present() or an alternative approach mentioned in [0] by
David Hildenbrand, in the next release cycle, for instance. Thanks.

  [0] https://lore.kernel.org/all/c87a4ba0-b9c4-4044-b0c3-c1112601494f@redh=
at.com/

>
> From b625edc35de64293b728b030c62f7aaa65c8627e Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Thu, 17 Oct 2024 19:41:07 +0200
> Subject: [PATCH] s390/pageattr: Implement missing kernel_page_present()
>
> kernel_page_present() was intentionally not implemented when adding
> ARCH_HAS_SET_DIRECT_MAP support, since it was only used for suspend/resum=
e
> which is not supported anymore on s390.
>
> However a new bpf use case now leads to a compile error specific to
> s390. Implement kernel_page_present() to fix this.
>
> Reported-by: Daniel Borkmann <daniel@iogearbox.net>
> Closes: https://lore.kernel.org/all/045de961-ac69-40cc-b141-ab70ec9377ec@=
iogearbox.net
> Fixes: 0490d6d7ba0a ("s390/mm: enable ARCH_HAS_SET_DIRECT_MAP")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/set_memory.h |  1 +
>  arch/s390/mm/pageattr.c            | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/s=
et_memory.h
> index 06fbabe2f66c..cb4cc0f59012 100644
> --- a/arch/s390/include/asm/set_memory.h
> +++ b/arch/s390/include/asm/set_memory.h
> @@ -62,5 +62,6 @@ __SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)
>
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
> +bool kernel_page_present(struct page *page);
>
>  #endif
> diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
> index 5f805ad42d4c..aec9eb16b6f7 100644
> --- a/arch/s390/mm/pageattr.c
> +++ b/arch/s390/mm/pageattr.c
> @@ -406,6 +406,21 @@ int set_direct_map_default_noflush(struct page *page=
)
>         return __set_memory((unsigned long)page_to_virt(page), 1, SET_MEM=
ORY_DEF);
>  }
>
> +bool kernel_page_present(struct page *page)
> +{
> +       unsigned long addr;
> +       unsigned int cc;
> +
> +       addr =3D (unsigned long)page_address(page);
> +       asm volatile(
> +               "       lra     %[addr],0(%[addr])\n"
> +               "       ipm     %[cc]\n"
> +               : [cc] "=3Dd" (cc), [addr] "+a" (addr)
> +               :
> +               : "cc");
> +       return (cc >> 28) =3D=3D 0;
> +}
> +
>  #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
>
>  static void ipte_range(pte_t *pte, unsigned long address, int nr)
> --
> 2.45.2
>

