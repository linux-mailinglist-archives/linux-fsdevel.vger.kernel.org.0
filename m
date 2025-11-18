Return-Path: <linux-fsdevel+bounces-68879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF56C67877
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA37D365A18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72F32D592D;
	Tue, 18 Nov 2025 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vuu2NY7a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5A2D543D
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 05:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763443084; cv=none; b=ff4fZ0352Cb+acDL9ceOUpY8ERALviYsuRQvr0J5T1fuO6WVNpCc6jGuDaA6QuBPA7dNHQXYCKBSkBxgRxbaqJofdliSGP7Vmxamg1cc4ht7+nN96VRzuT/GOc4MPSrI+xJLVOTxvPDxZSpdXmVydSbKmNSsWxQO4RpiwRv0D8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763443084; c=relaxed/simple;
	bh=/UWeCO4kEVujMkhGeVLQy9xHUmjlUbkI89n/+3oIS8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYzE7wzUSXmM1dW0Xtn36p/WlmjA01eDUQANjWQIh3eiI2EwKOFrpBpee6Nh89a+G51BWDLa2o4DeY0j6stWpMS4dlydcBImYFgqRi8JXkRTjM4qvrO749w2mXFsBciN8lcFrm+VdpwCYL0eeAycjcn/hAV7X99em8hvjtRxC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vuu2NY7a; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779a4fc916so29435e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 21:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763443080; x=1764047880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twkjfa30fRHD9BgmJwt1gQHo+WH/GMWfHY9pWcyj3jw=;
        b=vuu2NY7ak+X5k1mYCxgbYw8s3ezIvg4MuR8Pq7sSv/PNwfjPpI5blHj0RgfpatZu8s
         mf+y3a52n03EBOyq/gsldGZRTpGRN4suG3ZGWxomJGnRsWOIWUswbAqkVCLlboPD+qIV
         UAaDb83gjrVHfvOw3HkqOaMJPhqNFIduap/+dC4w97Fqe9lqbVVFGb9GAhytQUUquDdb
         7TzT9Fr/s0hbJmdaL/EAQZuLO6pf7grk1kOuipqYq/d6EWdI3z8RbMvIi3rdIt6hBbLL
         XeEQEm+XdJLoUcPQcIDApbulFpUM0ghIlok53jH8vYEhFfoAKBsU0hPfFmlEgPI9J0rW
         ih7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763443080; x=1764047880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=twkjfa30fRHD9BgmJwt1gQHo+WH/GMWfHY9pWcyj3jw=;
        b=XkgU1q5FOHQ2IvOqYlp+eFMkhF6uGsskP4fZx9c2LK+locm20TaDAAEQ8tV+Yk68uq
         +3Yr1gtz6AJ7YKI4C5tajztyWI6T1F5BvBp3TP2CWV0hBsar4ZWueNVkeWVSA4FXVRyV
         rWO/B6dJeEKHY+nrLfBbI4WxQznJBO0fvXQYJaUgeYrBIC8oUtLw1/SEkd+3Kgfp5y4w
         CbGGSR6NVR0LGDIV8qC6UO5cPx/p2nf858uoCvZvKGn6DdsO73cgflaSo+Ry46hqzSoZ
         OLMedUqY3f63c3tnMqAqHJ8KIEmgxCxCwN5WcUo8pWohAikuC5nVemwcS7guGtx3r4AL
         AsoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTCWS2+G3iKT789xZK/UxNzyUC4YTGzIuEMITrs8D/Z7oCwGJHLIl6Kz3OnzjsDQWAm7m1sIs1cUflnpYF@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPDpf2SYhi/FKEYvgLXl6PHNmDR6IskTCttP6RdFDp7zukHhs
	P3+2ZyhsXNodcRyLSzi4j/DeATMahA0/du2twQOdHFTxQujGbL1quBe4jOJi9CeIE89z5PRd0nR
	b8KqCjpEotOChPdEPPiHtUyHTg9tfGNYaTaP4Prdx
X-Gm-Gg: ASbGncvK0Tfog49m3IC3knq3ge5T4W40NjOLQu3sv3HSv+gkw3K+feYsS9uKujG8Onu
	Wr4IRtb9qOynnVN/rnIfBQy+wuEmqe6QfTHtjIa1raoqgsvOb+U2s+nU90urW2C4WJhwwpMm4LG
	QWzT1zwc8+VNK7u9n1B0uv/sx+en7MpHCzGMMUFQCfEEuMtis9oNxomVIGDsoSiqMN8wjG4YrnF
	vR7hmCWMjV/XxE/rbY+rgy0A/Hm9WSuqJgso+vrI9q6pRxM2XZi3teaBKRlZpe0Wrt5ImlYaEvx
	eTDl7we79jKnxCKS3t3TIPG8COsY
X-Google-Smtp-Source: AGHT+IGc2iVngTxPT7o91+hFQAjlxB2KQTgYyAt0T10shwhYAGaHBuuZJNq/JBCqg3zPWok91qHXU5duI91ezWn0P2M=
X-Received: by 2002:a05:600c:6dc1:b0:477:563a:135c with SMTP id
 5b1f17b1804b1-477aca4f02amr22915e9.0.1763443080368; Mon, 17 Nov 2025 21:18:00
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116014721.1561456-1-jiaqiyan@google.com> <20251116014721.1561456-3-jiaqiyan@google.com>
 <bcfd5575-cff0-4ead-9136-dd509bf11f64@kernel.org>
In-Reply-To: <bcfd5575-cff0-4ead-9136-dd509bf11f64@kernel.org>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 17 Nov 2025 21:17:48 -0800
X-Gm-Features: AWmQ_bkYLyh7FOYFP8JKvk2EtcfX6pixH2v2kxW0ZwYd8ZeKopK5TC-BlJFWJ3U
Message-ID: <CACw3F53x=n2mNJ6QS9wBRESim8ojHCmhY+-YLAL5N_wi6x0P4Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm/memory-failure: avoid free HWPoison high-order folio
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, ziy@nvidia.com, 
	lorenzo.stoakes@oracle.com, william.roche@oracle.com, harry.yoo@oracle.com, 
	tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 9:15=E2=80=AFAM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 16.11.25 02:47, Jiaqi Yan wrote:
> > At the end of dissolve_free_hugetlb_folio, when a free HugeTLB
> > folio becomes non-HugeTLB, it is released to buddy allocator
> > as a high-order folio, e.g. a folio that contains 262144 pages
> > if the folio was a 1G HugeTLB hugepage.
> >
> > This is problematic if the HugeTLB hugepage contained HWPoison
> > subpages. In that case, since buddy allocator does not check
> > HWPoison for non-zero-order folio, the raw HWPoison page can
> > be given out with its buddy page and be re-used by either
> > kernel or userspace.
> >
> > Memory failure recovery (MFR) in kernel does attempt to take
> > raw HWPoison page off buddy allocator after
> > dissolve_free_hugetlb_folio. However, there is always a time
> > window between freed to buddy allocator and taken off from
> > buddy allocator.
> >
> > One obvious way to avoid this problem is to add page sanity
> > checks in page allocate or free path. However, it is against
> > the past efforts to reduce sanity check overhead [1,2,3].
> >
> > Introduce hugetlb_free_hwpoison_folio to solve this problem.
> > The idea is, in case a HugeTLB folio for sure contains HWPoison
> > page(s), first split the non-HugeTLB high-order folio uniformly
> > into 0-order folios, then let healthy pages join the buddy
> > allocator while reject the HWPoison ones.
> >
> > [1] https://lore.kernel.org/linux-mm/1460711275-1130-15-git-send-email-=
mgorman@techsingularity.net/
> > [2] https://lore.kernel.org/linux-mm/1460711275-1130-16-git-send-email-=
mgorman@techsingularity.net/
> > [3] https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
>
>
> [...]
>
> >   /*
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 3edebb0cda30b..e6a9deba6292a 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -2002,6 +2002,49 @@ int __get_huge_page_for_hwpoison(unsigned long p=
fn, int flags,
> >       return ret;
> >   }
> >
> > +void hugetlb_free_hwpoison_folio(struct folio *folio)
>
> What is hugetlb specific in here? :)
>
> Hint: if there is nothing, likely it should be generic infrastructure.
>
> But I would prefer if the page allocator could just take care of that
> when freeing a folio.

Ack, and if it could be taken care by page allocator, it would be
generic infrastructure

>
> --
> Cheers
>
> David

