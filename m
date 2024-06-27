Return-Path: <linux-fsdevel+bounces-22589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859C3919D10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 03:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 073DCB2277F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 01:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682D863AE;
	Thu, 27 Jun 2024 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGHd+NbR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7CC1C01;
	Thu, 27 Jun 2024 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719453268; cv=none; b=MMpnjQ1lro0hmo53nTlUdl7ymji8UJujaemyjDmUhwDtOvnM+TTgqmV+tvs0MUWQiRLx85Uf9f2I139WO8GSQr0QvBq2iRo4Tkw/zYkNHYA125irvizkbIL8h4PGf8KykWV7QTNqD7Lne1o4Ox+6zGXxHoHAbn5N4MTxAxj5htE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719453268; c=relaxed/simple;
	bh=LnOVKQnUuatixtBfvg6r3SSvue5diLVW44y58Oi1qfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKWX9WW/6CKfPs7sbZgWCfU2lHERjoYzAKhxXvku2pV+JueR1ki8yedAA2XJ6e23YT0mfWSd9EpO73v0jSek77rS+hu3NjcvuEREr/5gh7vLPx83wQj+rkXAn25e88qVvMKj6AYNskuUGPFOQTttr3oi13hwrQdd2bnRtnMMp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGHd+NbR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6cb130027aso491916066b.2;
        Wed, 26 Jun 2024 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719453265; x=1720058065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnOVKQnUuatixtBfvg6r3SSvue5diLVW44y58Oi1qfE=;
        b=SGHd+NbRqoDVzc/LumFU/d10L8wsWkNbSGq9YVuuTcaJuifzIpwCUSwlOH5eiv/nK4
         0P/hU49YOxA+mkqccW1FGKBCf12k6OLpSBfHirTzR0+rE7bBclmy/ZU2eQA/zrBX3hcs
         LDMVY1BGDQt7oL31NTyY8aQiEQRri11UTrJ1nHzOxQ+b6//IOWv2szhda2tbHDucp0jZ
         BqVtXn81ARdpBV+4cvBAicQCRx4F0VQmzgQ7fSaiEt8LaPqzmZsrtirxsdepwUVy8mA0
         GqHBBfFkIheceytOFW2McgLmkkfKJmG0fltfOjWtFpk+VPtfCZlrtWesih+s5cZH0t0c
         OAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719453265; x=1720058065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnOVKQnUuatixtBfvg6r3SSvue5diLVW44y58Oi1qfE=;
        b=PghTjWjDWV/ue9A7XJf6lbD6RlUL/cyi0w402sHnBpOyXqdSRlgzppGxd+1IfwqR7t
         5ORaErgt2j7ZVWs2s1HdaY3RnrG1mR0gq5u1DYpyw6HQ9WkVI/DyvaVi8iUjRmpeB+3X
         hu8zQieIyo4pfcIt6a4L6vDGb8NlkF8aDECaHUfhD4jp7yVyqTzCFcOtIIEkY96syjvf
         OZQttEDuXrCosg4ARZ9EiXBCXZdH004jc1Z8zJs7OE0rMeu5WO2fgh/ha1dwZmAHCSbv
         M7OWaTLfVaZ/GHiCBlhByYlXd3Yw22hBD+qyZfzDfF72SknXoV/NnKCZPDEJXoB+9epi
         hSSA==
X-Forwarded-Encrypted: i=1; AJvYcCWwUQOxoGKNmxJjKGj/UGhZ11YHQHVmqTu/Nx1m35NSYSV116PrWIYkELMdzanA0KBT0QuvhxGaNEWj8MrbsvCm2LtEw7FDCo0dknQLF5N9SqbiX5Pzgf0vPzNMIJ3LileMxiR7xpCD5U/d5w==
X-Gm-Message-State: AOJu0YwkphG9Z66C3spQUrwdFONR+2FLmhQQ4A9Cq4SxMgnNc05hbtUp
	Hmt+hnqUIczTZaR6c7cA1Q766CiCtRodEeEBcjkUzg9sJS2zlgaWWFDk7B/iEI2akATxkAC7ZrW
	QBuFdCLHQryQt2PznvsuW9JFcOxE=
X-Google-Smtp-Source: AGHT+IEsfXW3R1Cse7H6mfiDFMI90Kjp8vfPO7X4KI46osmbz6ZcB+JUBYk650/ppKbgKn1x/Vgmk1wB1G4rQcVqGek=
X-Received: by 2002:a50:d7dc:0:b0:57d:26a4:2e3a with SMTP id
 4fb4d7f45d1cf-583e415035amr2150091a12.40.1719453265392; Wed, 26 Jun 2024
 18:54:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
 <20240626024924.1155558-3-ranxiaokai627@163.com> <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
 <1907a8c0-9860-4ca0-be59-bec0e772332b@arm.com> <D2A0ZD1AOJDA.3OLNZCHJAXRK8@nvidia.com>
 <e7167166-2682-4ff6-89dd-6ef2ec4621b8@arm.com>
In-Reply-To: <e7167166-2682-4ff6-89dd-6ef2ec4621b8@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 27 Jun 2024 09:54:14 +0800
Message-ID: <CAK1f24=0KYAMRnamw+NTB43m1fsFqgjMewaFwtCSjY10gtkAOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Zi Yan <ziy@nvidia.com>, ran xiaokai <ranxiaokai627@163.com>, akpm@linux-foundation.org, 
	willy@infradead.org, vbabka@suse.cz, svetly.todorov@memverge.com, 
	ran.xiaokai@zte.com.cn, baohua@kernel.org, peterx@redhat.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Barry Song <21cnbao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 10:42=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 26/06/2024 15:40, Zi Yan wrote:
> > On Wed Jun 26, 2024 at 7:07 AM EDT, Ryan Roberts wrote:
> >> On 26/06/2024 04:06, Zi Yan wrote:
> >>> On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
> >>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >>>>
> >>>> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
> >>>> pages, which means of any order, but KPF_THP should only be set
> >>>> when the folio is a 2M pmd mappable THP.
> >>
> >> Why should KPF_THP only be set on 2M THP? What problem does it cause a=
s it is
> >> currently configured?
> >>
> >> I would argue that mTHP is still THP so should still have the flag. An=
d since
> >> these smaller mTHP sizes are disabled by default, only mTHP-aware user=
 space
> >> will be enabling them, so I'll naively state that it should not cause =
compat
> >> issues as is.
> >>
> >> Also, the script at tools/mm/thpmaps relies on KPF_THP being set for a=
ll mTHP
> >> sizes to function correctly. So that would need to be reworked if maki=
ng this
> >> change.
> >
> > + more folks working on mTHP
> >
> > I agree that mTHP is still THP, but we might want different
> > stats/counters for it, since people might want to keep the old THP coun=
ters
> > consistent. See recent commits on adding mTHP counters:
> > ec33687c6749 ("mm: add per-order mTHP anon_fault_alloc and anon_fault_f=
allback
> > counters"), 1f97fd042f38 ("mm: shmem: add mTHP counters for anonymous s=
hmem")
> >
> > and changes to make THP counter to only count PMD THP:
> > 835c3a25aa37 ("mm: huge_memory: add the missing folio_test_pmd_mappable=
() for
> > THP split statistics")
> >
> > In this case, I wonder if we want a new KPF_MTHP bit for mTHP and some
> > adjustment on tools/mm/thpmaps.
>
> That would work for me, assuming we have KPF bits to spare?

+1

Let's check on that and see if we're good ;)

Thanks,
Lance
>

