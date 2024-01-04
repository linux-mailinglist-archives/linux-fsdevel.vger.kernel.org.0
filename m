Return-Path: <linux-fsdevel+bounces-7412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21D98248C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 20:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9108328327A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 19:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96DA2C1B3;
	Thu,  4 Jan 2024 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="F/ZnFVg7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC31F2C1B5
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dc1fdc19b6so521010a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jan 2024 11:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1704395583; x=1705000383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+vYEuDAPJ/iEdESxX2pInRN4g9EPXyQ5h9FSdd/4u4=;
        b=F/ZnFVg7p6RCRwo6c599coMU7gxw34TnRuIn9tv4NSDTLCFyNIcCycMnVBIoSBhUaf
         5VePqzrdqqOPRKKkraOQpG8XlgFm3zjmU3ROzjemte9baJ4kCqNNrgdAqngJeCHvlLMT
         ccN+J71GjNlNUYaCcvaMn9xh9mjC0xYx+SwN4B6qr/yTTMnZRYvNOhLp64UX+NkJd/Vy
         YSkeOW4R3gS7ZDU8/YKly32rHGE+xlyTcPg4qLxF5bOlnB3yUbFqy9azk3VRBB7HpFXx
         waNjhIskVtiY0gZZye1eBD20fLHFMqL1LxWwap0rGSneRmh7FVOv1Qc8SWhK/C/qEkoW
         tynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395583; x=1705000383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+vYEuDAPJ/iEdESxX2pInRN4g9EPXyQ5h9FSdd/4u4=;
        b=oPguuc0irJ5M+zXzjkuQSNn2PYTLFuxrfV/OGdYOUHEtTXirXsz4EnYavQUWjZZSIA
         MW6Ey65KFbEya7X5Ko7WV6TICx8c1Yka3bo6aehfbCX45PMfPqYlJPV1sWDkiMsPy0DP
         apey1y6sBIlAZM+ucrbZuCex4bmk9KEF5Q4y/dz2OusAFngu4WKg2840ugjEVSyR7LqI
         DEgwhpvt4741Lr4mWz7p1cDSIFIEP3AI7Oli5qnVnpgcPQO0CsbowWZcVBSmfscmn7Ir
         bpk+dEpLn9Rt/UC3Sw0vLCug7miEIxwaCTAuQRbchigGqCIJYlyJMYzomPaAHSTFvruU
         iPQw==
X-Gm-Message-State: AOJu0YyatwcyB/IAIFPH76XVDgqBilLhCqs4ePNQybhq3GF1yadujuHK
	BFrZ6roI6Dhuo/prIZA+9OE5LCQh/b9g/bEBXn2QHVbHpjQhiA==
X-Google-Smtp-Source: AGHT+IF/5x1qWEeEN53jwIdamLjEry3P/nE1f12xa2taaKft/YlEJdrBP6aDzExJ1bDcrqKpemuFKkiIEAFmrNQGE5k=
X-Received: by 2002:a05:6358:8828:b0:174:b7f2:51db with SMTP id
 hv40-20020a056358882800b00174b7f251dbmr1188037rwb.19.1704395582852; Thu, 04
 Jan 2024 11:13:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
 <eqkpplwwyeqqd356ka3g6isaoboe62zrii77krsb7zwzmvdusr@5i3lzfhpt2xe>
 <CA+CK2bBE1bQuqZy3cbWiv8V3vJ8YNJZRayp6Wv-j2_9i37XT4g@mail.gmail.com> <eng4vwaci5hwlicszgcld6uny55vll2bfs3vp2yjbjf3exhamg@zf6yc2uhax7w>
In-Reply-To: <eng4vwaci5hwlicszgcld6uny55vll2bfs3vp2yjbjf3exhamg@zf6yc2uhax7w>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 4 Jan 2024 14:12:26 -0500
Message-ID: <CA+CK2bCUGepLLA2Hsmq00XEhPzLWPb5CjzY_UPT0qWSKastjAQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] IOMMU memory observability
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
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
	will@kernel.org, yu-cheng.yu@intel.com, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 12:04=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Thu, Jan 04, 2024 at 11:29:43AM -0500, Pasha Tatashin <pasha.tatashin@=
soleen.com> wrote:
> > Thank you for taking a look at this. The two patches [1] [2] which add
> > GFP_KERNEL_ACCOUNT were sent separate from this series at request of
> > reviewers:
>
> Ah, I didn't catch that.
>
> Though, I mean the patch 02/10 calls iommu_alloc_pages() with GFP_KERNEL
> (and not a passed gfp from iommu_map).
> Then patch 09/10 accounts all iommu_alloc_pages() under NR_IOMMU_PAGES.
>
> I think there is a difference between what's shown NR_IOMMU_PAGES and
> what will have __GFP_ACCOUNT because of that.
>
> I.e. is it the intention that this difference is not subject to
> limiting?

Yes, we will have a difference between GFP_ACCOUNT and what
NR_IOMMU_PAGES shows. GFP_ACCOUNT is set only where it makes sense to
charge to user processes, i.e. IOMMU Page Tables, but there more IOMMU
shared data that should not really be charged to a specific process.
The charged and uncharged data will be visible via /proc/vmstat
nr_iommu_pages field.

Pasha

>
> (Note: I'm not familiar with iommu code and moreover I'm only looking at
> the two patch sets, not the complete code applied. So you may correct my
> reasoning.)
>
>
> Thanks,
> Michal

