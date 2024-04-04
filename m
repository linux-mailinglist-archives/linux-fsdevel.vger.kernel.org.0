Return-Path: <linux-fsdevel+bounces-16114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D866E898933
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 15:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07F21C21F06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341E21292CE;
	Thu,  4 Apr 2024 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="0z8aKuTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0813128398
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238699; cv=none; b=i93wXa3ya87z8UAl0GMneemI7tqXMPPbYV2QyBEVp9zUfqPWsrMfBIkhZcLkcis+loOFFwDCS9nXgtklnB4/VMxw5KKMyl8qXm9J2NsqSUJwZekKucywvKAg5Oyhy/KCrASQRYkYGF7NZ24bwxTVZQvpqNBLDhnMirlAcJl8G4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238699; c=relaxed/simple;
	bh=1F5VA5YE599dOlO3zQ9ZskLhNBoOk9J98W5SFXY1QOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWsBDtY85Y7F0w7/Q3O9Xu5Vu+b4kh9460rTAZXvTfqN5wyUT0rMwj+Ib1LBXw/LytJnfUN0wuf//NjFREtliBtEpqQk/vti+FQN2TOWikWYgmq9LmoNi7ERHFAniOguiygCAvP9OiMWXN0+qgU4MBRghyh992S6AlOGF2XJn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=0z8aKuTm; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4317fbb669dso4051871cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Apr 2024 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712238696; x=1712843496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GEhrf+Xnwdm4P0BoHyd6IIElLQSsz5Bym9Fr83GNG8o=;
        b=0z8aKuTmU8bYJ4grwKz4goXEXgw4EV/gwaBkD1Ip0JFP6HA2gvQvxQpDilONfxTk7r
         Bk5Q4YSjXmSj8XkFkmSaNqoxlM1zXM9bLBz1yRMoPuoLzQlUp2AA2du4eDrdRzo1/pkW
         qmfmPRSYJU4c9pdtONfd7f7awjyicktUvJfNlFXaRNVc7O09T/EqJF0KjeUW1vt0vvgS
         6BdmdBW4sZ9rMogJseh2j7LxvT0riHhmSSWH++lWMVL1rdFXU4GzrUDWJOSgBOb1bd4F
         jmeDOXaiLtYLwhNJoyr5/kWO3vn6iPtQ13u31SgaGMDQW0AFMLzJQ2WwYCqwxsMNbsze
         /oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712238696; x=1712843496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEhrf+Xnwdm4P0BoHyd6IIElLQSsz5Bym9Fr83GNG8o=;
        b=Km9m8/9gd6KCpvuCh6gsiBvmFN6dOw98nv/hJYFdxUIiM0hP1KkNWoeSI8mUaIbMzL
         qN7n896hNtluu+GNwhf9l6vXkPVgKfEUC3jd992lM299WTgTD1kQcmXEjju+TLjuxDNa
         UMHV76/SwCVniTZVUpMjgRF7bhr8c5UF8JG8Xu2Y84JzXFtIpPEzqpKF94lWucF/aSj1
         RWcGD/vAGrdwtlS9MHvG2HI5txd3Q7T32BYUNiKZTMYAFxqvHGZ/azvQEnBMUTFl6RTT
         Bw5Zh+6EZSTsk5w0Gg7OgpJxawuBAgodff5RqicXbpJlYvlK7gbl4t68mnTzP3wQkZXQ
         JEHw==
X-Forwarded-Encrypted: i=1; AJvYcCXa1vPrE3Oxr1IfgiwCzOA0UXuCHE1gkz3v28od9Ab98FxVNXP80RvtT+GGWdnOdbM5BX6ZylNWNSoZOTEfEwdloVKqq8griIRaLOzEQw==
X-Gm-Message-State: AOJu0YwXl1GcAHf2drmVjkm/pG6A/xhnQbkS+mbjFlCHciXpAXztk4J1
	sqfcrK8UijEPYIgTAPGGHttOWl16zEgs8ZteVF+rf5NBZ59tYBF0qjX9gdKjuuoJsMdB5KNI2ub
	xwI64t1x/nbTNAdYekKD4TaaJiRCCzJsnqpT2lA==
X-Google-Smtp-Source: AGHT+IG34VfsrO/bFBQm1+tAdMAMjkEMbTIL7Igt83TuV9+7PUf7aasZynC6bg9Q2hezj4QPdzlhPGGLCOEcmSFudGM=
X-Received: by 2002:a05:622a:20d:b0:431:8135:6fa9 with SMTP id
 b13-20020a05622a020d00b0043181356fa9mr2490307qtx.61.1712238696692; Thu, 04
 Apr 2024 06:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com> <20240404005803.GA102637@hyd1403.caveonetworks.com>
In-Reply-To: <20240404005803.GA102637@hyd1403.caveonetworks.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 4 Apr 2024 09:50:59 -0400
Message-ID: <CA+CK2bAiM_eC6k2EVL93uuOwB+hhV1WkDDK0YROo9-wAh=ju-w@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] IOMMU memory observability
To: Linu Cherian <lcherian@marvell.com>
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
	will@kernel.org, yu-cheng.yu@intel.com, rientjes@google.com, 
	bagasdotme@gmail.com, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"

> > Description
> > ----------------------------------------------------------------------
> > IOMMU subsystem may contain state that is in gigabytes. Majority of that
> > state is iommu page tables. Yet, there is currently, no way to observe
> > how much memory is actually used by the iommu subsystem.
> >
> > This patch series solves this problem by adding both observability to
> > all pages that are allocated by IOMMU, and also accountability, so
> > admins can limit the amount if via cgroups.
> >
> > The system-wide observability is using /proc/meminfo:
> > SecPageTables:    438176 kB
> >
> > Contains IOMMU and KVM memory.
>
> Can you please clarify what does KVM memory refers to here ?
> Does it mean the VFIO map / virtio-iommu invoked ones for a guest VM?

This means that nested page tables that are managed by KVM, and device
page tables that are managed by IOMMU are all accounted in
SecPageTables (secondary page tables). The decision to account them
both in one field of meminfo was made at LPC'23.

Pasha

