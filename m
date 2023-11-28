Return-Path: <linux-fsdevel+bounces-4115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2590F7FCBA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E4D1C20EF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA636185E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="m3IVwR2o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1E019AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 15:52:16 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d81173a219so2632156a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 15:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701215536; x=1701820336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGeDrNEnimmhtGEyy4xADkNVo65XsrpvCKCPlUM9+8M=;
        b=m3IVwR2oyDwf9bDurHvyXgUEDv38joPWYYywCYsLXcvaCtUyChVXEsFDLqmlrj9tR9
         6SsODG8fd1f7lMOFwx/GLB+Rne1Rp1UofI867dJ+XX6AjWKu24p4qaTPmIvLhoYMR1qx
         HTwFeKWnNZ6h/t1W+3U9AOGUpypBu/RYzMePLZl2s4BMSHLiMkWvvD84lSSpQZQEoYdd
         bn+tyPDPDD1oMlRdA7u8XHP61sAIw5rqEDj/9T4sg3cc/o8t94dm84VBVMq9L+dbXkWD
         nUi/JL0VL5RaviK4pV1E3QEbDy/DmfWL+79AA+iGvWu6lAUAZG5g7uGDy/lJb/AWT/eY
         NMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701215536; x=1701820336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGeDrNEnimmhtGEyy4xADkNVo65XsrpvCKCPlUM9+8M=;
        b=fl1OO78J1sbpx096DuIMTtfo6ONW7IxWbmWRhfB0OAQ8gQWwGK81GSZw2Mxu4njA6a
         pyRgGxA4lPhjJBXK4t1/d4erQutL1T9Sg+lhPhrKshgrcCCCt5RJ0UbMpidKWQUXJ2/i
         Bs3N0gUt4LoNSXhFTbiXCdd1s3OrW/iRxkcjDFihynofkSDrmxhEAJr07/rHxdg0a2aA
         uQKEEP8oEcxA2V56a5YptHrNrdnYG9eTOiuu2lcSaLPm6vENdg9z6U44+Wa0eyADPcBs
         aYREb/JukGmK75IehKYgTpmCgZSUaXQ41KL2ycxIKQI4R3b0zSZI7Oi9UMnABhBYzJaY
         4hdg==
X-Gm-Message-State: AOJu0YwvB7roOaQ+po7kh+yD+8UlEcDvsnbE1X5DpEWtzU5tFVcFoafg
	7ShsYfPMuiioFVFZADUyT8BDNw==
X-Google-Smtp-Source: AGHT+IH9LmWzJO7y47O3QlJBfbaegvjW4JiiPSyZGlFsMKhzquzPk2K8a5k6oldvIY99Eeb+EHerAg==
X-Received: by 2002:a9d:6403:0:b0:6d6:4972:b7ae with SMTP id h3-20020a9d6403000000b006d64972b7aemr18597902otl.13.1701215536183;
        Tue, 28 Nov 2023 15:52:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id v10-20020a056830140a00b006d834fd3399sm504997otp.59.2023.11.28.15.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 15:52:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r87sE-005jI0-V5;
	Tue, 28 Nov 2023 19:52:14 -0400
Date: Tue, 28 Nov 2023 19:52:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
	alex.williamson@redhat.com, alim.akhtar@samsung.com,
	alyssa@rosenzweig.io, asahi@lists.linux.dev,
	baolu.lu@linux.intel.com, bhelgaas@google.com,
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
	iommu@lists.linux.dev, jasowang@redhat.com,
	jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
	kevin.tian@intel.com, krzysztof.kozlowski@linaro.org,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
	marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
	m.szyprowski@samsung.com, netdev@vger.kernel.org,
	paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
	samuel@sholland.org, suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com,
	virtualization@lists.linux.dev, wens@csie.org, will@kernel.org,
	yu-cheng.yu@intel.com
Subject: Re: [PATCH 00/16] IOMMU memory observability
Message-ID: <20231128235214.GD1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com>
 <CA+CK2bB3nHfu1Z6_6fqN3YTAzKXMiJ12MOWpbs8JY7rQo4Fq0g@mail.gmail.com>
 <CAJD7tkZZNhf4KGV+7N+z8NFpJrvyeNudXU-WdVeE8Rm9pobfgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZZNhf4KGV+7N+z8NFpJrvyeNudXU-WdVeE8Rm9pobfgQ@mail.gmail.com>

On Tue, Nov 28, 2023 at 03:03:30PM -0800, Yosry Ahmed wrote:
> > Yes, another counter for KVM could be added. On the other hand KVM
> > only can be computed by subtracting one from another as there are only
> > two types of secondary page tables, KVM and IOMMU:
> >
> > /sys/devices/system/node/node0/meminfo
> > Node 0 SecPageTables:    422204 kB
> >
> >  /sys/devices/system/node/nodeN/vmstat
> > nr_iommu_pages 105555
> >
> > KVM only = SecPageTables - nr_iommu_pages * PAGE_SIZE / 1024
> >
> 
> Right, but as I mention above, if userspace starts depending on this
> equation, we won't be able to add any more classes of "secondary" page
> tables to SecPageTables. I'd like to avoid that if possible. We can do
> the subtraction in the kernel.

What Sean had suggested was that SecPageTables was always intended to
account all the non-primary mmu memory used by page tables. If this is
the case we shouldn't be trying to break it apart into finer
counters. These are big picture counters, not detailed allocation by
owner counters.

Jason

