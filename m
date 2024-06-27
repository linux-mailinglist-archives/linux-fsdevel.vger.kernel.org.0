Return-Path: <linux-fsdevel+bounces-22594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30086919E0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 06:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F3B223A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 04:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDB818B1A;
	Thu, 27 Jun 2024 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geJVSRib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DBA17722;
	Thu, 27 Jun 2024 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719461440; cv=none; b=Alv2TpwJ1S0MAEm2LANtI+5WjsvQfgSggqgIdgc4sSYXKXHRomTVDMGX9GvzyYY0dAFQ2U7Hn5j/AbkuNoYQII1kRESXlCrlVROQWcB5CKMDYjYgvurUzsoC1OpJ33Ig60XysaJT9wGd3b4u0r5zA8Vg6kkwolLt5fPXYZ/mNbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719461440; c=relaxed/simple;
	bh=CKv1BGQlGCFVLvOVKWpNiKGwYCGjD+/PCEgX8Jk6DiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9IrlbTOIQ/F72IuinHxPU6Ad+T7ulztgWB/36gdQltGOpCDNCnkeXpMCSxGH16otc+E/FuzmmBHWaXEsBnLCvO6jBuSaeflgWgEF5NWTi+KMWtxGiL4r9/Qmh5w5HaydSCNRkITZtN+SuDJCNPUIHBTuxvqrwZp2npLEED1VWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geJVSRib; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-80fbfeecca1so530215241.1;
        Wed, 26 Jun 2024 21:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719461438; x=1720066238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKv1BGQlGCFVLvOVKWpNiKGwYCGjD+/PCEgX8Jk6DiE=;
        b=geJVSRibs2EoErxaM7q0TM65Tsa8UtooRVDM4UsFhfCbqeaGZJ+G515jftXtwa/+u+
         lvUWsxyRlx/oJQalpjD5kF8QwPCMC+4mA/Ncyo0cN3DhLBoAoef93R254qFvZOK/dLpH
         FapaJ4RK7+YxgNPHsu2Cz6rPwzLU0F5vol6e0I4jTp9ntKZUwR96QU+Mr149aOwqnsID
         WGlVXqtUeway4w9izO4cil+h/uqkBYvvQNQ1XoncSWL3EiRzf0TwqJgPB9PKctQ80Led
         Mal1bnHwVeUy64+K3tXqK2OoJXMqQyfLQ7gx7VkkDJ1rJtj48DeFvPyvgCUMclZXte3W
         4aUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719461438; x=1720066238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKv1BGQlGCFVLvOVKWpNiKGwYCGjD+/PCEgX8Jk6DiE=;
        b=NtAiW6Q6n+A8hNJIUIMmtH7eOfV8Eq5Q2t8RQV+iYeCSm09iuC+FEYFaVXS/J0tzti
         Hdmx9moOODsD50XpvkjRLZJ/f3/0NAdoj5tVL+1FEc7yI2pkBVR01Lik0XcqTowdl1uV
         ClznVdjhX2Iej7VRJiNmkxxRnmPilE/n9Y5I6kuqSVhISBunHx0ov2kUZkBFhAhlQnAm
         9Pv0wtnSCMIkpA2kYWI6jd38XT++7kijmFafC7EbJ5/22dQSvlGjlBYenOLPbjaER//6
         GYYZFgOtggPkJibH3sR19npunMt9wbj5aQR1pRywKltZUkGIs2xInrU2z7Mw4N0cLAN3
         xtkA==
X-Forwarded-Encrypted: i=1; AJvYcCUxGIaqLmN6IH50OhnFlas5Th6/tGmagBDmcont47d8XT1oALSMkdHtCZQe7VyDKwlAJ2pBFQUKOk+BjH6e24GW1mtHsQW8B4avp8W6BwLbOzsGJNVcoXy0gueuwILsnfARKAMkd1bInAe8Tw==
X-Gm-Message-State: AOJu0Yzdgx4QTrKa1HszNyibKUuKrX6PIVgQ/BGc5CZxJ/adUlxYbZ5/
	aiaZh1L9u0BemM1NUdX1gck6jEWYBQeUSoE3smjidfwmIP0llRJPrRjHKI+voZHpahYyi91E0GT
	IK2LZ3XASgAr1WWDVMIfIWOJitQ0=
X-Google-Smtp-Source: AGHT+IFfDa0ktIOys1TJVi0P9n6zh5dH5AKUYvUR9DtrBG4sqPeS33t4v0IsNlc0T9/CdRCN55Qh60RRnXX/dZ6KYyI=
X-Received: by 2002:a67:bb03:0:b0:48f:8c83:dce9 with SMTP id
 ada2fe7eead31-48f8c83de6bmr929007137.29.1719461438197; Wed, 26 Jun 2024
 21:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
 <20240626024924.1155558-3-ranxiaokai627@163.com> <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
 <1907a8c0-9860-4ca0-be59-bec0e772332b@arm.com> <D2A0ZD1AOJDA.3OLNZCHJAXRK8@nvidia.com>
In-Reply-To: <D2A0ZD1AOJDA.3OLNZCHJAXRK8@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 27 Jun 2024 16:10:26 +1200
Message-ID: <CAGsJ_4wCymN=YQt7cDBZ-xB8Kr4C7hSnDaWNevnhiNC76pXd-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
To: Zi Yan <ziy@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, ran xiaokai <ranxiaokai627@163.com>, 
	akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz, 
	svetly.todorov@memverge.com, ran.xiaokai@zte.com.cn, peterx@redhat.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Lance Yang <ioworker0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:40=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On Wed Jun 26, 2024 at 7:07 AM EDT, Ryan Roberts wrote:
> > On 26/06/2024 04:06, Zi Yan wrote:
> > > On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
> > >> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > >>
> > >> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
> > >> pages, which means of any order, but KPF_THP should only be set
> > >> when the folio is a 2M pmd mappable THP.
> >
> > Why should KPF_THP only be set on 2M THP? What problem does it cause as=
 it is
> > currently configured?
> >
> > I would argue that mTHP is still THP so should still have the flag. And=
 since
> > these smaller mTHP sizes are disabled by default, only mTHP-aware user =
space
> > will be enabling them, so I'll naively state that it should not cause c=
ompat
> > issues as is.
> >
> > Also, the script at tools/mm/thpmaps relies on KPF_THP being set for al=
l mTHP
> > sizes to function correctly. So that would need to be reworked if makin=
g this
> > change.
>
> + more folks working on mTHP
>
> I agree that mTHP is still THP, but we might want different
> stats/counters for it, since people might want to keep the old THP counte=
rs
> consistent. See recent commits on adding mTHP counters:
> ec33687c6749 ("mm: add per-order mTHP anon_fault_alloc and anon_fault_fal=
lback
> counters"), 1f97fd042f38 ("mm: shmem: add mTHP counters for anonymous shm=
em")
>
> and changes to make THP counter to only count PMD THP:
> 835c3a25aa37 ("mm: huge_memory: add the missing folio_test_pmd_mappable()=
 for
> THP split statistics")
>
> In this case, I wonder if we want a new KPF_MTHP bit for mTHP and some
> adjustment on tools/mm/thpmaps.

It seems we have to do this though I think keeping KPF_THP and adding a
separate bit like KPF_PMD_MAPPED makes more sense. but those tools
relying on KPF_THP need to realize this and check the new bit , which is
not done now.
whether the mTHP's name is mTHP or THP will make no difference for
this case:-)

>
>
> --
> Best Regards,
> Yan, Zi
>

Thanks
Barry

