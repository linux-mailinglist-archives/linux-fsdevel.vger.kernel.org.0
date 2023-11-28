Return-Path: <linux-fsdevel+bounces-4108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EB37FCB9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF731F20FAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15E61850
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62CDB12C;
	Tue, 28 Nov 2023 15:08:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E29F2F4;
	Tue, 28 Nov 2023 15:08:49 -0800 (PST)
Received: from [10.57.71.132] (unknown [10.57.71.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 205E23F6C4;
	Tue, 28 Nov 2023 15:07:53 -0800 (PST)
Message-ID: <6f9ff0aa-7713-4de1-869e-4725828942e4@arm.com>
Date: Tue, 28 Nov 2023 23:07:52 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] iommu/io-pgtable-arm-v7s: use page allocation
 function provided by iommu-pages.h
Content-Language: en-GB
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com,
 alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev,
 baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org,
 corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
 heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
 jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com,
 joro@8bytes.org, kevin.tian@intel.com, krzysztof.kozlowski@linaro.org,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 lizefan.x@bytedance.com, marcan@marcan.st, mhiramat@kernel.org,
 mst@redhat.com, m.szyprowski@samsung.com, netdev@vger.kernel.org,
 paulmck@kernel.org, rdunlap@infradead.org, samuel@sholland.org,
 suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com,
 tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com,
 virtualization@lists.linux.dev, wens@csie.org, will@kernel.org,
 yu-cheng.yu@intel.com
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-6-pasha.tatashin@soleen.com>
 <8e1961c9-0359-4450-82d8-2b2fcb2c5557@arm.com>
 <CA+CK2bDFAi1+397fd4cYetUgmHxqE2hUG4fa2m9Fi3weykQdpA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CA+CK2bDFAi1+397fd4cYetUgmHxqE2hUG4fa2m9Fi3weykQdpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-28 10:55 pm, Pasha Tatashin wrote:
>>>                kmem_cache_free(data->l2_tables, table);
> 
> We only account page allocations, not subpages, however, this is
> something I was surprised about this particular architecture of why do
> we allocate l2 using kmem ? Are the second level tables on arm v7s
> really sub-page in size?

Yes, L2 tables are 1KB, so the kmem_cache could still quite easily end 
up consuming significantly more memory than the L1 table, which is 
usually 16KB (but could potentially be smaller depending on the config, 
or up to 64KB with the Mediatek hacks).

Thanks,
Robin.

