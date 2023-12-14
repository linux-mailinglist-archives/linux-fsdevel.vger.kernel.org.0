Return-Path: <linux-fsdevel+bounces-6134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6054813A9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150171C20EB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 19:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8195F692BB;
	Thu, 14 Dec 2023 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="M0gW0TDM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89299697AD
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-20335dcec64so1120016fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 11:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1702581566; x=1703186366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGqN9VyFA6bGzLMvanbVJ9xu/V9dzBL2qAxRA0SNydY=;
        b=M0gW0TDMZ1cOi1yrWcw1W4bE11jULEKanC+u1rXJzMgCz8em1s6uFo/o25lvEJ4Hst
         p2EnRHGV1Bac5AmfplX1dEpCP/DT287CovyVkoH/NT7Y+TV9384LgZb6/mf6n+WGgV2K
         EtV4k10/hr+ygQ2S844dJMMJK5h0ePSkXTcvwyFygPRu8S8m4nMCSVZnaLm2ubM5e51X
         ETH0IiTQiDh+z/7z2kJTLVYATE5/P8sLBJqEO9OZK2x3pO9hJRo5pnNPcFIF4mx8pZ4T
         v6Nf1i4s3v/dTT0QI8wCXtHpVJwrkMb3UOokIW6x4SDQI/6jleRCOaYJX8x0tgPLwGi9
         nPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702581566; x=1703186366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGqN9VyFA6bGzLMvanbVJ9xu/V9dzBL2qAxRA0SNydY=;
        b=aqDn2A58LfW2NmR2tqyg4OMNJCx7+wl8oRwX2WpYjlQCtEFSkZgcfH1yTB7dvcUsLh
         7UgMrNXHHA3eVHYHO+ukEgk0E/3dC9Cc2UiRjj+KSyTK+/ye5Ef+JqENX26+tihPzHpe
         7yoSPUu/oiRZfhtzhY/hjKqMD9VuqqbISSQZ0ZGYYZTK8xJ245jyYiWNfOHHLP0lqiN1
         7eBTbY2Ks+DqQP+lhZbRW+nloDbrRv1a0YyyAtTolU0Pz4Pv06I7lZN2RlzfzD8MVU8s
         jgHJD8s/+S1nskYP09zdHBYO16hgVXCPyrkXLf+n45+vISMskTR0iSYQf8RFz9LTphZG
         0z1Q==
X-Gm-Message-State: AOJu0YwwBNJoLxdrkz9XiEHMjp9/vwka1TuUNv8sx1ZJ/BL5KK5A+hf+
	HVtUmrAQkDX1tYJ2NvsSvnWdt8Gk7enuf+ixGLh7XQ==
X-Google-Smtp-Source: AGHT+IHAnrtenlddaWtCyLx9aBi69QrVuHVWG2rdYXiv2yuQ5vKdApOHPoLr5i+XPih06QNJDodZZT5+m5u6D1Em/48=
X-Received: by 2002:a05:6871:4099:b0:1ff:805:b3e6 with SMTP id
 kz25-20020a056871409900b001ff0805b3e6mr13641663oab.6.1702581566484; Thu, 14
 Dec 2023 11:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
 <20231130201504.2322355-10-pasha.tatashin@soleen.com> <88519685-abfb-e2f8-38b4-d94340b40d1d@google.com>
In-Reply-To: <88519685-abfb-e2f8-38b4-d94340b40d1d@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 14 Dec 2023 14:18:49 -0500
Message-ID: <CA+CK2bD-phEK4aWQv-xK74_uR_agRN+cmt5Wq-a8YVB1Gm_gVA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] iommu: observability of the IOMMU allocations
To: David Rientjes <rientjes@google.com>
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
	will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:59=E2=80=AFPM David Rientjes <rientjes@google.co=
m> wrote:
>
> On Thu, 30 Nov 2023, Pasha Tatashin wrote:
>
> > Add NR_IOMMU_PAGES into node_stat_item that counts number of pages
> > that are allocated by the IOMMU subsystem.
> >
> > The allocations can be view per-node via:
> > /sys/devices/system/node/nodeN/vmstat.
> >
> > For example:
> >
> > $ grep iommu /sys/devices/system/node/node*/vmstat
> > /sys/devices/system/node/node0/vmstat:nr_iommu_pages 106025
> > /sys/devices/system/node/node1/vmstat:nr_iommu_pages 3464
> >
> > The value is in page-count, therefore, in the above example
> > the iommu allocations amount to ~428M.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Acked-by: David Rientjes <rientjes@google.com>

Thank you,
Pasha

