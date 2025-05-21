Return-Path: <linux-fsdevel+bounces-49590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64BBABFC9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 20:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E0B4E7FC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071D028981B;
	Wed, 21 May 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTZOwT1q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09984231839
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747850748; cv=none; b=LotnUOvH53zn9DiBNaWLcf4WSBz7mgroqX7/3Ob7Q//+vZ9nHwyyNsrwRl0FLJ5eAVNpaf4N9kRlhbGcXs6RoiRl88hkKlugTxwWXB4wXzA9jt6z8s6ywyfAn0XB3HtIXKxFhybOrz44v+JgZtVHKC3aOhwu17X15bzOqh8bMFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747850748; c=relaxed/simple;
	bh=/kBCkQlxjXnin3hiwXC845Y7K1IJf3aW28/KCZJ7/Bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j37S8QTbDvIgQPpA3Jj5M9BdwDmCzxhwS7IT1Z/PxD2wd8bx0Y9ItmBPeXZCl8FIpjmdJmabdtkI0zI7a9DXRNbI4bZ+dVxXuD82OPZdyP+HjjbtJ+yOqgMQ5hc1R3656BFpeqbFFJNKHnPDe2FC7VGWtvmdMcG1sAwnYNgbE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTZOwT1q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231f61dc510so1110665ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747850746; x=1748455546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubZduvx/cYHhuXsc0YXgIW6eAhMzKqsU08W4pEGJ/Pc=;
        b=mTZOwT1qMPpFi469dgS9oR82Aj2A+a1WAI2JMt9OUhtT32dbbz2jocD2GmJx72uKjB
         eB/ztFfnWDMZpXyYBoJbskw5htRJKUYP9YzgjlJ4Kira6exmWiHocqb2bKUZMFiCdBFJ
         UNgGYO8pD+CQ6nSC0jwdQSD1zN+ZDxJJVXu/CIv9Z7ZixX2kpzfxYTH6en2j4GMe/B4V
         T56CZ84nRCjhxQnr/qGxuteDNqpy2+oqjcYV9ql/WnWmVPDmf45UXSLvsYSsKbjoktGm
         LI2MvTW/zccZP2ZiPaOxlgmbjTA6igzbdrQYy8fI+S69nBDthOasTBH6nCusp/ffSwi8
         PS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747850746; x=1748455546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubZduvx/cYHhuXsc0YXgIW6eAhMzKqsU08W4pEGJ/Pc=;
        b=BIeCI2AADf1YDJEIHRTe3JqPpQEP4KXzw1/sDkylHGDHSK3b7PVKegpktVmluZLYOe
         /1n+17UqGNCClZMZ5gwaE34vM3Raw81RkJK/xyRbPVTsHvDxJEXkdGinHgETuLDE0V0B
         BvURT/pyZ5lQ6X1psAd+I+OLYRr2KE9uZtsO5TYAJgJ5O7SxUQjqMzsGsvok0TJiOPHm
         WkKbypPhHr8SPhFOfvwiJWcNfrfnw0lTmxk2DEoSYQCbvXrxZP3VRlN/JAlTsTQSQuwi
         NJqD8v3RnaFIL1qJg3UCv+5DnIWxn06IUiW2KZ+yjxJ5lfVGtpzwkO5E7FkEAP7RXya/
         sRrw==
X-Forwarded-Encrypted: i=1; AJvYcCU6yuWW++9LDj81KLnN6l1fHy9YW19y6Qf4eKylsJ9BmVL6PjpvULfD1+2BAWwTpkhObclxD9LyrRLR2fms@vger.kernel.org
X-Gm-Message-State: AOJu0YxXxcOwzfd2lZD0oUn89fuAJLv2JwJCKi18hTkQUEqkCc7Cm3UT
	QfAa5lhwdM78nX1IdUI38DyP52dA4H7mfqSduqXtWSWH4W2dpgwfNCSRt7I66rtcQtF90DHyDtX
	2rc03vnuvuxZS5iUEKyt4TJHzONmvpUd8YbFmP47A
X-Gm-Gg: ASbGncvZTW0kcloV4RrHcVF5xWtauOBIKycJR5NV0Qf052PJOr911IwjPR/I9aIN9xq
	dYuzsN+xuT04q//NkMrsY0oFpiqqVwS4RNCkN6VKGXVN9dF12FBq/t3F7phI+g77PaYRKrCPsUt
	FL+AIJHjNfeV1lNJ88YKVrinWJLyKbMFgfTsU1iV7qzK4h0c3BNNN2yELZFWgDpED59QyPGJ+Rr
	Q==
X-Google-Smtp-Source: AGHT+IHmVPisOoELNyl8TlIo/1z2Gy2JQdvRF1i2iTDr537dKpeYFIvLF3liBXDQzvSnoGIzUR4n3Bcy350EhBXDWOw=
X-Received: by 2002:a17:902:f545:b0:231:e0d0:bf65 with SMTP id
 d9443c01a7336-23204143657mr12533785ad.7.1747850745624; Wed, 21 May 2025
 11:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <e9aaf20d31281d00861b1805404dbed40024f824.1747264138.git.ackerleytng@google.com>
In-Reply-To: <e9aaf20d31281d00861b1805404dbed40024f824.1747264138.git.ackerleytng@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 21 May 2025 11:05:32 -0700
X-Gm-Features: AX0GCFvVdSODjor7OXlVRx2yQTS_EDakZDYyd8FkQ0_ENzjc8DIITkJ6cFhT2Qk
Message-ID: <CAGtprH-G6hA6dfFrRtFh+gazmr+27mvpoV-MNphbvKzm3WS4Rg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 33/51] KVM: guest_memfd: Allocate and truncate from
 custom allocator
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 4:43=E2=80=AFPM Ackerley Tng <ackerleytng@google.co=
m> wrote:
> ...
> +/**
> + * kvm_gmem_zero_range() - Zeroes all sub-pages in range [@start, @end).
> + *
> + * @mapping: the filemap to remove this range from.
> + * @start: index in filemap for start of range (inclusive).
> + * @end: index in filemap for end of range (exclusive).
> + *
> + * The pages in range may be split. truncate_inode_pages_range() isn't t=
he right
> + * function because it removes pages from the page cache; this function =
only
> + * zeroes the pages.
> + */
> +static void kvm_gmem_zero_range(struct address_space *mapping,
> +                               pgoff_t start, pgoff_t end)
> +{
> +       struct folio_batch fbatch;
> +
> +       folio_batch_init(&fbatch);
> +       while (filemap_get_folios(mapping, &start, end - 1, &fbatch)) {
> +               unsigned int i;
> +
> +               for (i =3D 0; i < folio_batch_count(&fbatch); ++i) {
> +                       struct folio *f;
> +                       size_t nr_bytes;
> +
> +                       f =3D fbatch.folios[i];
> +                       nr_bytes =3D offset_in_folio(f, end << PAGE_SHIFT=
);
> +                       if (nr_bytes =3D=3D 0)
> +                               nr_bytes =3D folio_size(f);
> +
> +                       folio_zero_segment(f, 0, nr_bytes);

folio_zero_segment takes byte offset and number of bytes within the
folio. This invocation needs to operate on the folio range that is
overlapping with [Start, end) and instead it's always starting from 0
and ending at an unaligned offset within the folio. This will result
in zeroing more than requested or lesser than requested or both
depending on the request and folio size.

> +               }
> +
> +               folio_batch_release(&fbatch);
> +               cond_resched();
> +       }
> +}
> +

