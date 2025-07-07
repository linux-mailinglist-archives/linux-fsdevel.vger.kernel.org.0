Return-Path: <linux-fsdevel+bounces-54159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8401AFBA60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABAC4A503E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C90263F5B;
	Mon,  7 Jul 2025 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e041tUKA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32C21B4F09
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911780; cv=none; b=uv6k6tDdI7vuMxXaFEkszXhOqyqUXs4oX2pTqUdHuR/TLvzX2g1N2RCByWMy5tvuHIkPlPUGu4RTKPPGD4AbIGx4UTf3GSGcHgg+BbQqfpL2gJEL42R+X9OUFFZog0fLDfAvzJ3iEP/3JgDrxjaQiC4bLSiAT6pRWbYTpknpshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911780; c=relaxed/simple;
	bh=PXvVCyvgHb0eHBfQ0bThDfdbXMaikQlhmHXanhLrTdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAXoIHOL37UmlYADu7195WdhAzuaobPr974Gegx0FBCSEzo+XMCWsiLTYeF3V4dprVu/xRLKEaqOag28x6oK079zVW3wC0j8H0Y8PSx8k3BIUadGyZ0OTjbTRY66QpQtyQglBY1c27haKbH4dS0gKePxHP042Ip7Z8V1oWNjxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e041tUKA; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e81749142b3so2780646276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751911777; x=1752516577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXvVCyvgHb0eHBfQ0bThDfdbXMaikQlhmHXanhLrTdw=;
        b=e041tUKA2RUHgU1A/PX4XENmCCATfpqbwVkWm5XRnZrNUQer4xIieucZloUvC3yi3A
         66c0RhmtEP1awHOlmIF4N/bdUm/Qz+lPEHL17Wrc6JLDnr+p6ZGR8ID1TwV5JqvS/krG
         FKSn7LUMkBvY3kUMdciO59x/1JjG6Tk4KJji+Y2z0lzFu5K93LTbzBfU9IecKiT0UGOJ
         C6kzP4haB/GassxPnZQVNqlOqc2PVE4SExdpFdM4iMZbDCymhfxERzB+koaMivXipUNM
         PsIQryNkN+T3PA2V0rlaFpe0NIOP146z+bIZrR68DDeUAfY0htR3YnLX5zcDu2t1bVqH
         ovoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751911777; x=1752516577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXvVCyvgHb0eHBfQ0bThDfdbXMaikQlhmHXanhLrTdw=;
        b=bul9s3NdSX5Zq7g+TwApC42kJJupKnfV7pBDNBFf011b7FbmRBH0+kzA2RJbvEoIBd
         ir4A+R1s6QcMhdFssWqAalBlfx1ET2gNqZrmKsr+Q1fZslNU0YUbd9r+ISoF7YJXpJE0
         HmAhHo1GhUtpsBZV2IlrnRDniOPJYvd7jt7yJzDOEVIKTIzcXkc07xz3kFrAL7n3KlHJ
         GooryhJcmfFesumpIGtvFUz/0wmvLSf8MqLinIyU4v8n4I1zzIGRRz6eWHzxO/VrmCYL
         nxk60mHuW3fpwITO2TB0IcuJIe6jg5Yl+6nADhB1unu+KmNJKNUSMvC86oxtYfYZQJvC
         7oRg==
X-Forwarded-Encrypted: i=1; AJvYcCXaCengT63fD+LgNxyGaN6TN5ptSRYANyWaBTcy7jKiJdWsow/t3doKS58GHwKLn2vjC45YHF2druT+Ra0p@vger.kernel.org
X-Gm-Message-State: AOJu0YxmIPCqx4QMMyT/+n1EeKuXj6MMN4LAksLKNlggOlSKpbKf43JB
	erojF7x6rPFR7vFcoo5Y7RmVtla6Y7wc90rDNWphlTz44EEbR6wqY4nPydzacpDxD9AHXNMFdTt
	PswneJDR919gGcvveUXsfuXgyOo5tWhaPM/uhdvM1
X-Gm-Gg: ASbGnctGANmaSarEpgYeKbSVpWTtU4TAwSO5awkwzhdSiqw3lqNOEWAcpP7TxfyGMsG
	22eLKswXiAuFX+B4l+x5faBMn6IDfKleR460u9yayHhtmMKMUWAv+0eKk6qH7RGp1OtLGyttFdd
	/3P/5Zbshgpsnvq/hYbXlz6R1P3Dia64kvOWohjfnkyqZHgpkSHsBMkhHR+o/FUWRNJYJLiFg3m
	A==
X-Google-Smtp-Source: AGHT+IHw3HaZiyB/1y8CtGslDwQWQzV0+e50NJs7lEmDy5dHXsDu2ggjTmBQ1yT/1DSW6T5pgUsirP3gLE9OKHg0VWE=
X-Received: by 2002:a05:690c:941c:b0:714:583:6d05 with SMTP id
 00721157ae682-7179e42c376mr6996117b3.32.1751911777302; Mon, 07 Jul 2025
 11:09:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <782bb82a0d2d62b616daebb77dc3d9e345fb76fa.1747264138.git.ackerleytng@google.com>
In-Reply-To: <782bb82a0d2d62b616daebb77dc3d9e345fb76fa.1747264138.git.ackerleytng@google.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 7 Jul 2025 11:08:59 -0700
X-Gm-Features: Ac12FXwKcvqRRUd0nsd7X92g5DnBajTeAMgxLisNdzU_VSoAb0b8Kq03tT52h7g
Message-ID: <CADrL8HW-vMqkocOxWURRB5vdi+Amx5QE6sNQOJx4hpD5L2rp5w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 18/51] mm: hugetlb: Cleanup interpretation of
 map_chg_state within alloc_hugetlb_folio()
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
	jhubbard@nvidia.com, jroedel@suse.de, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, kirill.shutemov@intel.com, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net, 
	michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
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
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 4:43=E2=80=AFPM Ackerley Tng <ackerleytng@google.co=
m> wrote:
>
> Interpreting map_chg_state inline, within alloc_hugetlb_folio(),
> improves readability.
>
> Instead of having cow_from_owner and the result of
> vma_needs_reservation() compute a map_chg_state, and then interpreting
> map_chg_state within alloc_hugetlb_folio() to determine whether to
>
> + Get a page from the subpool or
> + Charge cgroup reservations or
> + Commit vma reservations or
> + Clean up reservations
>
> This refactoring makes those decisions just based on whether a
> vma_reservation_exists. If a vma_reservation_exists, the subpool had
> already been debited and the cgroup had been charged, hence
> alloc_hugetlb_folio() should not double-debit or double-charge. If the
> vma reservation can't be used (as in cow_from_owner), then the vma
> reservation effectively does not exist and vma_reservation_exists is
> set to false.
>
> The conditions for committing reservations or cleaning are also
> updated to be paired with the corresponding conditions guarding
> reservation creation.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Change-Id: I22d72a2cae61fb64dc78e0a870b254811a06a31e

Hi Ackerley,

Can you help me better understand how useful the refactors in this and
the preceding patch are for the series as a whole?

It seems like you and Peter had two different, but mostly equivalent,
directions with how this code should be refactored[1]. Do you gain
much by replacing Peter's refactoring strategy? If it's mostly a
stylistic thing, maybe it would be better to remove these patches just
to get the number of patches to review down.

The logic in these two patches looks good to me, and I think I do
slightly prefer your approach. But if we could drop these patches
(i.e., mail them separately), that's probably better.

[1]: https://lore.kernel.org/linux-mm/20250107204002.2683356-5-peterx@redha=
t.com/

