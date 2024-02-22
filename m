Return-Path: <linux-fsdevel+bounces-12408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC3B85EDFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 01:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17303284DC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 00:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC6F8F5C;
	Thu, 22 Feb 2024 00:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="JnM/2ln7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A4F8C0B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561666; cv=none; b=SqAtZmRy183tbO7d5eiWQiaqM8ZfGNAEZrlBD0l18u1+PhlVW+3p/73QxACA8qLgV0MiK4NyTXY46lXCNI14uGF+wNUNmJohSC0vcBzmeQ5xB3NqVmGj1wH/2PUxp5iOIhXX1k3H5X/UaHCvFK+CUtuvVFgSry1DsM0uiBGNQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561666; c=relaxed/simple;
	bh=KFCl6fU1744flulJCJ4xzKP7ZfOs3jlFHZaEmtavvFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9Zn4bAyRzhArRWehtXrGcDCN4r6ctiafZdjIdwHVvcu3SOLlvn8K+qYRlkcAtX0Mh1MYP/J5LGMK5Z5Ck1nlXvPTskOMYBOUfn498TC0ZRDaI08Q+6ElDyTDVBmVxG3nnE08L1Bjw6CcEyE7ZLmOXeONKLl08Q78SRS5W2Tfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=JnM/2ln7; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-429f53f0b0bso53122381cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 16:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708561664; x=1709166464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ94+F18kEzvELBZYdN+dTOkgUJXZz4kfGzznQZui6Y=;
        b=JnM/2ln76gYW1tBtjZzIQkXZZJUE+c6Cm8ltv7jcJ66U77pb/zP+cWXHwHGCzYx1pj
         AoUW07ViMUJNcUIfSBYbqU+9N/4sTySG2CFoIJz3cjQDoI4lFOwp/cCl2JxT/Zx/jdoN
         G67hrawA6O4rOF772J87zhoyAole98md4lGz4PJdMY/Zla0wr2/LRzbfxI9EVnSeoa35
         YSQBFriQgFymSJWDJyienlKgiY0sRUhTQ5Jclv1q84kjHjQ6pKN8EiOYPZbGPvKKS3Nv
         3Aq9SR2KTmbbWmkc80rcQOHh4kt6eMAEv08Vgb+Dk6mCONnXwLb9b49YkPxoT7aBDTRz
         BKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708561664; x=1709166464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ94+F18kEzvELBZYdN+dTOkgUJXZz4kfGzznQZui6Y=;
        b=ZWxUhuDELiuBfKYRoZeoz72ThhTxfaM/+jrSRiogOlY5XU5BfdX1JaDYPfSjByFVbd
         LMs4UYttan2XriRYMM/cBy6Gp+ZSAX0nOMUYgGIWX16c7G1rgIBoZRbIm7a1uS1T/Fom
         7zdn6RleHGS33D+du7YX24Gijp0TUWwbtI+LbEc4K+RLwJwiVimtXrALufPXFjLsRXta
         YlnomESImwM4QLjfhrESok65aeNVXDPMmcloGfZH+eXKoAIuj+sWIq/B7ruNJbip0hgH
         rCBOxGZyEm0je3usE+glo/CvV0tgiiKJINOuQxUf7WUWVE+TaQ0t6enO0AelmHO56Cbp
         i81Q==
X-Forwarded-Encrypted: i=1; AJvYcCUh6UOSCwzBpL7WXfuPLZwI4pEXIN3x5Wm9sIZs2dyjhb4C3Wuk0idXQ4IgN1+EjYf4JoWvMYNUeXVcEXsE/iW0++XN16YC85EgfKoDFg==
X-Gm-Message-State: AOJu0YwhLLbCr/+GKo9ixpJKQqkeT46zG5cDBldKxT1/lNlYSs9CAR9f
	xdE+QljlUprAD3izwTtfZYxjpOlRFMDoBoPnI8KD5uEbBWHTPUQZCxRpzpdB9CKfAidcOSy+cfv
	3rnQxQ5Zhi2owKvxzD6Mh9gBZ2pZRCDS+1ykrzg==
X-Google-Smtp-Source: AGHT+IGOmZsSpC2Y4SyYnlcRyS9zDA76SD5RvGLDRLTwS53fSOkMzROnT7IsmFNQ2MsELKRVDDNbuO1hZG2u+Llmnq0=
X-Received: by 2002:a05:622a:1391:b0:42c:6fef:90e with SMTP id
 o17-20020a05622a139100b0042c6fef090emr25244584qtk.65.1708561663980; Wed, 21
 Feb 2024 16:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
 <20231226200205.562565-11-pasha.tatashin@soleen.com> <20240213131210.GA28926@willie-the-truck>
 <CA+CK2bB4Z+z8tocO79AdsAy+gmN_4aVHgFUsm_gYLUJ2zV1A6A@mail.gmail.com>
 <20240216175752.GB2374@willie-the-truck> <CA+CK2bDURTkZFo9uE9Bgfrz-NwgXqo4SAzLOW6Jb35M+eqUEaA@mail.gmail.com>
 <20240222002152.GG13491@ziepe.ca>
In-Reply-To: <20240222002152.GG13491@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 19:27:07 -0500
Message-ID: <CA+CK2bBGzM8Xbfq9A7HHNr40oukvAk7-1RK7AFbW3qFcNstb5g@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] iommu: account IOMMU allocated memory
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>, akpm@linux-foundation.org, alim.akhtar@samsung.com, 
	alyssa@rosenzweig.io, asahi@lists.linux.dev, baolu.lu@linux.intel.com, 
	bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net, 
	david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	yu-cheng.yu@intel.com, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"

> > > > > While I can see the value in this for IOMMU mappings managed by VFIO,
> > > > > doesn't this end up conflating that with the normal case of DMA domains?
> > > > > For systems that e.g. rely on an IOMMU for functional host DMA, it seems
> > > > > wrong to subject that to accounting constraints.
> > > >
> > > > The accounting constraints are only applicable when GFP_KERNEL_ACCOUNT
> > > > is passed to the iommu mapping functions. We do that from the vfio,
> > > > iommufd, and vhost. Without this flag, the memory useage is reported
> > > > in /proc/meminfo as part of  SecPageTables field, but not constrained
> > > > in cgroup.
> > >
> > > Thanks, Pasha, that explanation makes sense. I still find it bizarre to
> > > include IOMMU allocations from the DMA API in SecPageTables though, and
> > > I worry that it will confuse people who are using that metric as a way
> > > to get a feeling for how much memory is being used by KVM's secondary
> > > page-tables. As an extreme example, having a non-zero SecPageTables count
> > > without KVM even compiled in is pretty bizarre.
> >
> > I agree; I also prefer a new field in /proc/meminfo named
> > 'IOMMUPageTables'. This is what I proposed at LPC, but I was asked to
> > reuse the existing 'SecPageTables' field instead. The rationale was
> > that 'secondary' implies not only KVM page tables, but any other
> > non-regular page tables.
>
> Right, SeanC mentioned that the purpose of SecPageTables was to
> capture all non-mm page table radix allocations.
>
> > I would appreciate the opinion of IOMMU maintainers on this: is it
> > preferable to bundle the information with 'SecPageTables' or maintain
> > a separate field?
>
> I think you should keep them together. I don't think we should be
> introducing new counters, in general.

Thanks Jason, I will keep it as-is. I will send a new version soon
with your comments addressed.

> Detailed memory profile should come from some kind of more dynamic and
> universal scheme. Hopefully that other giant thread about profiling
> will reach some conclusion.

+1! Memory profiling is going to be a very useful addition to the kernel.

Pasha

