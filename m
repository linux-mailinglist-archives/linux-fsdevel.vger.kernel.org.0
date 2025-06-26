Return-Path: <linux-fsdevel+bounces-53121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83316AEAA76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 01:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F027A30E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 23:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DCD223322;
	Thu, 26 Jun 2025 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfseSFfi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520541DED7B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979994; cv=none; b=W2NO5DEVxhSYqWeRz+QFj11XWQ/OeAh54BRYDKCX9kyzxqkSLND57TAh6nLSxNVZAV/vB0eQyOlKV3Nlvgm235E+RSWnYWPeyEfX25OyHWyWio3OUrWCVtRjERM1Cu6yfPTnhb0G0+WXWkKei4XaFvxmeZq+IxMZFV/BX8/wSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979994; c=relaxed/simple;
	bh=8oJqu7vh1nKhO7zqxOlFH5GbqzDZRsYHZ4hsK1zb2tg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BOMu6RzpEe1nPJGdPGOvPRlDjInPmzPz/7vM6kgXdoTI8W1JhZtnRN/LZ5a6Ku7sM7EeZPf3YmXOy3dmyMpSAi07GWuBNcp5mMUvbU9TpkPl3EF6jivItaatX0veidUfi0HvPpvjx581EyUb7irICBLzeLvNcGP/3Y/iLmehdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfseSFfi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138f5e8ff5so1548265a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 16:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750979992; x=1751584792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VCztHCMZgaWSxSkof1MA9Ntkv2jeWGBUS2MVA37PA/U=;
        b=vfseSFfir3wQ8mXax2Zac7nN/foVcJ8Ls6FmMKkokjrWYavVvTml8no+F8g8msvH71
         IV/GHxlRiyFqvFicMzcbJtB4y0KGvHSK07X0UEscWoTVhMuPLbCM/Sq9a3V/s0kupUkv
         tw61ojGKyXfT+8sbyyNWJ6chfsYf2JeqzQ2u+WYTUFGXSWdqZusmYePYdyD0GQkMiCTp
         G6+nC6j+u7IzzGfkuA+SOc+SLvdLixyqbEMYmkWXTULGKHx/Xdguw46EXl1JIkUtW2Ou
         UiUBuSQ15Zbl+ViIiCyBkgnp6E1wQR37VvtSCGUUw+FsjkTJMMj8IFcIxjdRe80u7Gcr
         UIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979992; x=1751584792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCztHCMZgaWSxSkof1MA9Ntkv2jeWGBUS2MVA37PA/U=;
        b=KAsW3xMTrG0HcU/7LoCZ0qz53o4qfN3NxJkYEL03sLYpBj0CwAIJ02b7Mf9dHxo9Vs
         cDFqp7x/ltgJoMESljU66lLkMXduIAMetlMI77wq1YvSlS6e/BjH0x2W2IBKBwh/gCMh
         eAiJa991v53U+caOIbY4sT21cC810eEFZqLIwJeP6C/Whm4LWK7Ev/UuyT0sqcMlCIiJ
         97BA9FF7awKfCuDbwEwQmVomaSKlEpRLG2rFJa7yhgoDyWAyp/RKBep0tP0p1Czxp21/
         2RHaO8IN9KNL+A85b65rhxWTrhP9gWdvPvn3FSlCiYbrlzuopWDNFUccoI8vgWxGw3cm
         mcFw==
X-Forwarded-Encrypted: i=1; AJvYcCUl4w3ftM2kxXrQWghAP8MgSIa/uvMJ4KJaX4SWCXCdlaqizjsP68aTq3e/QNSTkYWpq3c24wTVl38/lFXU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg4aR078HB7az4MOsiio8Q/8AyQesjORkUTOMCuub9r619sl21
	gcgqMHOvvTTj04EAKHMRHvHudonUHw2C7CiA4rqVODdnwYWTyRXzFofTEclfp1Zh56Y9a6HSaJi
	v+1pVnwMa5Gkm9fLsnm7R+PTiNQ==
X-Google-Smtp-Source: AGHT+IFPZByzyXdjiwV8jKmY40Cj3sanVuekYnCn7YFFgb7gotLW0eqU5EvmJr9Dd5Hb/clw6m1dn9YOJk/nOy9NWw==
X-Received: from pjbpv13.prod.google.com ([2002:a17:90b:3c8d:b0:312:1af5:98c9])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5108:b0:313:283e:e881 with SMTP id 98e67ed59e1d1-318c922f2c7mr1105843a91.11.1750979992473;
 Thu, 26 Jun 2025 16:19:52 -0700 (PDT)
Date: Thu, 26 Jun 2025 16:19:51 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
Message-ID: <diqzh602jdk8.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: aik@amd.com, ajones@ventanamicro.com, akpm@linux-foundation.org, 
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, bfoster@redhat.com, binbin.wu@linux.intel.com, 
	brauner@kernel.org, catalin.marinas@arm.com, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com, 
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, graf@amazon.com, haibo1.xu@intel.com, 
	hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
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
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> Hello,
>
> This patchset builds upon discussion at LPC 2024 and many guest_memfd
> upstream calls to provide 1G page support for guest_memfd by taking
> pages from HugeTLB.
>
> [...]

At the guest_memfd upstream call today (2025-06-26), we talked about
when to merge folios with respect to conversions.

Just want to call out that in this RFCv2, we managed to get conversions
working with merges happening as soon as possible.

"As soon as possible" means merges happen as long as shareability is all
private (or all meaningless) within an aligned hugepage range. We try to
merge after every conversion request and on truncation. On truncation,
shareability becomes meaningless.

On explicit truncation (e.g. fallocate(PUNCH_HOLE)), truncation can fail
if there are unexpected refcounts (because we can't merge with
unexpected refcounts). Explicit truncation will succeed only if
refcounts are expected, and merge is performed before finally removing
from filemap.

On truncation caused by file close or inode release, guest_memfd may not
hold the last refcount on the folio. Only in this case, we defer merging
to the folio_put() callback, and because the callback can be called from
atomic context, the merge is further deferred to be performed by a
kernel worker.

Deferment of merging is already minimized so that most of the
restructuring is synchronous with some userspace-initiated action
(conversion or explicit truncation). The only deferred merge is when the
file is closed, and in that case there's no way to reject/fail this file
close.

(There are possible optimizations here - Yan suggested [1] checking if
the folio_put() was called from interrupt context - I have not tried
implementing that yet)


I did propose an explicit guest_memfd merge ioctl, but since RFCv2
works, I was thinking to to have the merge ioctl be a separate
optimization/project/patch series if it turns out that merging
as-soon-as-possible is an inefficient strategy, or if some VM use cases
prefer to have an explicit merge ioctl.


During the call, Michael also brought up that SNP adds some constraints
with respect to guest accepting pages/levels.

Could you please expand on that? Suppose for an SNP guest,

1. Guest accepted a page at 2M level
2. Guest converts a 4K sub page to shared
3. guest_memfd requests unmapping of the guest-requested 4K range
   (the rest of the 2M remains mapped into stage 2 page tables)
4. guest_memfd splits the huge page to 4K pages (the 4K is set to
   SHAREABILITY_ALL, the rest of the 2M is still SHAREABILITY_GUEST)

Can the SNP guest continue to use the rest of the 2M page or must it
re-accept all the pages at 4K?

And for the reverse:

1. Guest accepted a 2M range at 4K
2. guest_memfd merges the full 2M range to a single 2M page

Must the SNP guest re-accept at 2M for the guest to continue
functioning, or will the SNP guest continue to work (just with poorer
performance than if the memory was accepted at 2M)?

[1] https://lore.kernel.org/all/aDfT35EsYP%2FByf7Z@yzhao56-desk.sh.intel.com/

