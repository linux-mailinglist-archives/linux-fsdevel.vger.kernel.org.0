Return-Path: <linux-fsdevel+bounces-16091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9D8897D37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 02:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F7028BF09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 00:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5439450;
	Thu,  4 Apr 2024 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="F6fuBFB3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0495C99;
	Thu,  4 Apr 2024 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712192378; cv=none; b=A17lMm1L7KN1LIjiIqvlfk+L/3YHFHeM4DlPmRjZc8GJ/PaWuA/yoeiwKfvHM+oYGgxZ0PhSkOUzUPsgcVW1P2rRTJ76+TNSyK7CYhDUyeq161l5n0naTrGTnJKdJ1oAeXc4kE8S25NhfVKSeP1fCeamzQzbrAN2fpihGzVtzJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712192378; c=relaxed/simple;
	bh=6QUBr595slcroOCfdcb8UZF1fOlVIaKWwWcSFJGekL0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPoCsjBfk8zcdXOIrHe1gJlna+T8e8fxZN4Tbbil5jUwCn7Hd5GjvZmVzalk7fSCUMxHbJ64nI/bbyUR02qVVKrYuzriU5LFfADJblil2eCc7urIPm0OUnWS+Qd20irQH9RfdGe8q/5Eo5ykkscV6uMtiDY3doyDG/CnfJjat6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=F6fuBFB3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433KwHmY025088;
	Wed, 3 Apr 2024 17:58:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pfpt0220;
	 bh=mEz3A0cFZLO3onQWAKZpQFFgP9D767dhafoyZkTOCQ4=; b=F6fuBFB3hkdU
	hSnUatMqU08RjlunuB1Kmkz7laPp8UHNL8cMK1rvQZzjFByFH/yxRwlI9VqKVAA+
	as18etdXEOgRSaY2hWPuywuYrPhNItb1W5K4l8cXB08gUeyF1rrDkyl9/qmaYHCE
	uJW1gQ/YbPkxVpA7iE1A5GWX3PgbOlrYjCBPTR5KwINBDECmFAcTzgkilXE0yBCd
	iBvx8O/PqnHc7W0TsZm288RAc+XSp66lbZ6f1qQwLbeK+nNF6bJs7iYy9RsvuyWM
	3YbFbFoSV4S+rHef2lnTdmLfwRTt6PC5A5M471i5yfhDoLGdga+g/JAQuK2yE86s
	BZnYSW8Gqg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x9em4gk88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 17:58:19 -0700 (PDT)
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 4340wINl007682;
	Wed, 3 Apr 2024 17:58:18 -0700
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x9em4gk83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 17:58:18 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 17:58:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 3 Apr 2024 17:58:17 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with ESMTP id DC6583F706F;
	Wed,  3 Apr 2024 17:58:04 -0700 (PDT)
Date: Thu, 4 Apr 2024 06:28:03 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
CC: <akpm@linux-foundation.org>, <alim.akhtar@samsung.com>,
        <alyssa@rosenzweig.io>, <asahi@lists.linux.dev>,
        <baolu.lu@linux.intel.com>, <bhelgaas@google.com>,
        <cgroups@vger.kernel.org>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw2@infradead.org>, <hannes@cmpxchg.org>, <heiko@sntech.de>,
        <iommu@lists.linux.dev>, <jernej.skrabec@gmail.com>,
        <jonathanh@nvidia.com>, <joro@8bytes.org>,
        <krzysztof.kozlowski@linaro.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-rockchip@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
        <linux-tegra@vger.kernel.org>, <lizefan.x@bytedance.com>,
        <marcan@marcan.st>, <mhiramat@kernel.org>, <m.szyprowski@samsung.com>,
        <paulmck@kernel.org>, <rdunlap@infradead.org>, <robin.murphy@arm.com>,
        <samuel@sholland.org>, <suravee.suthikulpanit@amd.com>,
        <sven@svenpeter.dev>, <thierry.reding@gmail.com>, <tj@kernel.org>,
        <tomas.mudrunka@gmail.com>, <vdumpa@nvidia.com>, <wens@csie.org>,
        <will@kernel.org>, <yu-cheng.yu@intel.com>, <rientjes@google.com>,
        <bagasdotme@gmail.com>, <mkoutny@suse.com>
Subject: Re: [PATCH v5 00/11] IOMMU memory observability
Message-ID: <20240404005803.GA102637@hyd1403.caveonetworks.com>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
X-Proofpoint-ORIG-GUID: kzH1frYTGGUfUioN4mjeRs5C7L-Xm_vN
X-Proofpoint-GUID: s6kXEc2yc7_K9P5CbGLReHonYF_ihsoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_26,2024-04-03_01,2023-05-22_02

On 2024-02-22 at 23:09:26, Pasha Tatashin (pasha.tatashin@soleen.com) wrote:
> ----------------------------------------------------------------------
> Changelog
> ----------------------------------------------------------------------
> v5:
> - Synced with v6.8-rc5
> - Added: Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> - Added: Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> - Addressed review comments from Robin Murphy:
>   Updated the header comment in iommu-pages.h
>   Removed __iommu_alloc_pages_node(), invoke
>   iommu_alloc_pages_node directly.
>   Removed unused: __iommu_alloc_page_node()
>   Removed __iommu_free_page()
>   Renamed: iommu_free_pages_list() -> iommu_put_pages_list()
>   Added missing iommu_put_pages_list() to dma-iommu.c in
>   iommu/dma: use iommu_put_pages_list() to releae freelist
> 
> v4:
> - Synced with v6.8-rc3
> - Updated commit log for "iommu: account IOMMU allocated memory" as
>   suggested by Michal Koutný
> - Added more Acked-bys David Rientjes and Thierry Reding
> - Added Tested-by Bagas Sanjaya.
> 
> v3:
> - Sync with v6.7-rc7
> - Addressed comments from David Rientjes: s/pages/page/, added
>   unlikely() into the branches, expanded comment for
>   iommu_free_pages_list().
> - Added Acked-bys: David Rientjes
> 
> v2:
> - Added Reviewed-by Janne Grunau
> - Sync with 6.7.0-rc3
> - Separated form the series patches:
> vhost-vdpa: account iommu allocations
> https://lore.kernel.org/all/20231130200447.2319543-1-pasha.tatashin@soleen.com
> vfio: account iommu allocations
> https://lore.kernel.org/all/20231130200900.2320829-1-pasha.tatashin@soleen.com
> as suggested by Jason Gunthorpe
> - Fixed SPARC build issue detected by kernel test robot
> - Drop the following patches as they do account iommu page tables:
> iommu/dma: use page allocation function provided by iommu-pages.h
> iommu/fsl: use page allocation function provided by iommu-pages.h
> iommu/iommufd: use page allocation function provided by iommu-pages.h
> as suggested by Robin Murphy. These patches are not related to IOMMU
> page tables. We might need to do a separate work to support DMA
> observability.
> - Remove support iommu/io-pgtable-arm-v7s as the 2nd level pages are
> under a page size, thanks Robin Murphy for pointing this out.
> 
> ----------------------------------------------------------------------
> Description
> ----------------------------------------------------------------------
> IOMMU subsystem may contain state that is in gigabytes. Majority of that
> state is iommu page tables. Yet, there is currently, no way to observe
> how much memory is actually used by the iommu subsystem.
> 
> This patch series solves this problem by adding both observability to
> all pages that are allocated by IOMMU, and also accountability, so
> admins can limit the amount if via cgroups.
> 
> The system-wide observability is using /proc/meminfo:
> SecPageTables:    438176 kB
> 
> Contains IOMMU and KVM memory.

Can you please clarify what does KVM memory refers to here ?
Does it mean the VFIO map / virtio-iommu invoked ones for a guest VM?  

> 
> Per-node observability:
> /sys/devices/system/node/nodeN/meminfo
> Node N SecPageTables:    422204 kB
> 
> Contains IOMMU and KVM memory in the given NUMA node.
> 
> Per-node IOMMU only observability:
> /sys/devices/system/node/nodeN/vmstat
> nr_iommu_pages 105555
> 
> Contains number of pages IOMMU allocated in the given node.
> 
> Accountability: using sec_pagetables cgroup-v2 memory.stat entry.
> 
> With the change, iova_stress[1] stops as limit is reached:
> 
> $ ./iova_stress
> iova space:     0T      free memory:   497G
> iova space:     1T      free memory:   495G
> iova space:     2T      free memory:   493G
> iova space:     3T      free memory:   491G
> 
> stops as limit is reached.
> 
> This series encorporates suggestions that came from the discussion
> at LPC [2].
> ----------------------------------------------------------------------
> [1] https://github.com/soleen/iova_stress
> [2] https://lpc.events/event/17/contributions/1466
> ----------------------------------------------------------------------
> Previous versions
> v1: https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com
> v2: https://lore.kernel.org/linux-mm/20231130201504.2322355-1-pasha.tatashin@soleen.com
> v3: https://lore.kernel.org/all/20231226200205.562565-1-pasha.tatashin@soleen.com
> v4: https://lore.kernel.org/all/20240207174102.1486130-1-pasha.tatashin@soleen.com
> ----------------------------------------------------------------------
> 
> Pasha Tatashin (11):
>   iommu/vt-d: add wrapper functions for page allocations
>   iommu/dma: use iommu_put_pages_list() to releae freelist
>   iommu/amd: use page allocation function provided by iommu-pages.h
>   iommu/io-pgtable-arm: use page allocation function provided by
>     iommu-pages.h
>   iommu/io-pgtable-dart: use page allocation function provided by
>     iommu-pages.h
>   iommu/exynos: use page allocation function provided by iommu-pages.h
>   iommu/rockchip: use page allocation function provided by iommu-pages.h
>   iommu/sun50i: use page allocation function provided by iommu-pages.h
>   iommu/tegra-smmu: use page allocation function provided by
>     iommu-pages.h
>   iommu: observability of the IOMMU allocations
>   iommu: account IOMMU allocated memory
> 
>  Documentation/admin-guide/cgroup-v2.rst |   2 +-
>  Documentation/filesystems/proc.rst      |   4 +-
>  drivers/iommu/amd/amd_iommu.h           |   8 -
>  drivers/iommu/amd/init.c                |  91 ++++++------
>  drivers/iommu/amd/io_pgtable.c          |  13 +-
>  drivers/iommu/amd/io_pgtable_v2.c       |  20 +--
>  drivers/iommu/amd/iommu.c               |  13 +-
>  drivers/iommu/dma-iommu.c               |   7 +-
>  drivers/iommu/exynos-iommu.c            |  14 +-
>  drivers/iommu/intel/dmar.c              |  16 +-
>  drivers/iommu/intel/iommu.c             |  47 ++----
>  drivers/iommu/intel/iommu.h             |   2 -
>  drivers/iommu/intel/irq_remapping.c     |  16 +-
>  drivers/iommu/intel/pasid.c             |  18 +--
>  drivers/iommu/intel/svm.c               |  11 +-
>  drivers/iommu/io-pgtable-arm.c          |  15 +-
>  drivers/iommu/io-pgtable-dart.c         |  37 ++---
>  drivers/iommu/iommu-pages.h             | 186 ++++++++++++++++++++++++
>  drivers/iommu/rockchip-iommu.c          |  14 +-
>  drivers/iommu/sun50i-iommu.c            |   7 +-
>  drivers/iommu/tegra-smmu.c              |  18 ++-
>  include/linux/mmzone.h                  |   5 +-
>  mm/vmstat.c                             |   3 +
>  23 files changed, 361 insertions(+), 206 deletions(-)
>  create mode 100644 drivers/iommu/iommu-pages.h
> 
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

