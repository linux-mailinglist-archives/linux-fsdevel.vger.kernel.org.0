Return-Path: <linux-fsdevel+bounces-4096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F69D7FC9B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 23:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72A7282CF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 22:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E225024C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhEH56cU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1681FDF
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 13:34:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a0b7f793b8aso488841466b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 13:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701207275; x=1701812075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NXFzGfhAzOfJO06Gf5RsXFoYKrXmtsSvTLzk7MbcCk=;
        b=MhEH56cUgeYVrXUDfslmi4RJuwodrwS8+9YvwSqfWrEThOZvoUtvlDSVQpBSgwjQOW
         KQXPypmhj/Tsc4s2STMcNHypwkApqjhiC4loLMebrlT1wZD6GSwYks2cgficn/lxJ1/u
         aHggR40HTITk1MS1FeVRp4CVHHTgdQkTwwfT06aP3UXwypQ6Wd0+qeEKvITwX61G/SSs
         RlDDIyMGwItn+9Nc3JYZZNmvoTdneH1EzrQT2ziIdTv7wfGxBNv3w0uVwzAQZj5tNI8x
         dGXG3O6iIAgTPA2ROHC+6nYYzb0VRZ7BOqZL0dQ0utSrDvXyMi75nwcMx0u1/SDtl1cq
         TPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701207275; x=1701812075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NXFzGfhAzOfJO06Gf5RsXFoYKrXmtsSvTLzk7MbcCk=;
        b=VV1jvhZQJbuSMIQbKLE2Eut9wSiKHcgxJcQKZcH6efw6c/jY7OAQ9Axt7bKmfRD0LE
         9/HQb7tsoCMaoAJxK5zap6WUfUQ4X7bUxuYczmPKzlfyH701bClW2kwnUsu5GK4dGv2j
         xerGy8sH8CQv6XoJKEt1AipffXnD1xJtU06TG+UoTe0IlcbhrUHSruLGbB2hXoIj7nJS
         devQgKpHXHdxSA/h7TsxtcErKkhC/9foyg8IXIiO6uyoMOzrdTKKm9Cx2VLx1H13wpIO
         RO4lxESTqmeuElIYjhqKoI7IJT+gZ67isIENsiSKkbGcga4+VkfC2AjT35920BSQJXHI
         D7Cw==
X-Gm-Message-State: AOJu0Yx4JER7xNIkghGJ9qItMSSZlzJ0gtDWaSakkeL4Lf9IRXZglw+S
	hFPA9Ck3zs1v2Ay36f8icAmv6ZTdDjoI8W9ddEfOCA==
X-Google-Smtp-Source: AGHT+IFrrdaJl+8CDzGqIseL+lJ7M7KDt9GszVwJUOFBD/DHsSLfgFwP8+NKKfkfsTtyJyGUtnD8OJJylXlFpNkSb5g=
X-Received: by 2002:a17:906:b248:b0:a04:cc0e:ff3b with SMTP id
 ce8-20020a170906b24800b00a04cc0eff3bmr12465188ejb.27.1701207274446; Tue, 28
 Nov 2023 13:34:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
In-Reply-To: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 28 Nov 2023 13:33:55 -0800
Message-ID: <CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] IOMMU memory observability
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com, 
	jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com, joro@8bytes.org, 
	kevin.tian@intel.com, krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, mst@redhat.com, m.szyprowski@samsung.com, 
	netdev@vger.kernel.org, paulmck@kernel.org, rdunlap@infradead.org, 
	robin.murphy@arm.com, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, virtualization@lists.linux.dev, 
	wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 12:49=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> From: Pasha Tatashin <tatashin@google.com>
>
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
>
> Per-node observability:
> /sys/devices/system/node/nodeN/meminfo
> Node N SecPageTables:    422204 kB
>
> Contains IOMMU and KVM memory memory in the given NUMA node.
>
> Per-node IOMMU only observability:
> /sys/devices/system/node/nodeN/vmstat
> nr_iommu_pages 105555
>
> Contains number of pages IOMMU allocated in the given node.

Does it make sense to have a KVM-only entry there as well?

In that case, if SecPageTables in /proc/meminfo is found to be
suspiciously high, it should be easy to tell which component is
contributing most usage through vmstat. I understand that users can do
the subtraction, but we wouldn't want userspace depending on that, in
case a third class of "secondary" page tables emerges that we want to
add to SecPageTables. The in-kernel implementation can do the
subtraction for now if it makes sense though.

>
> Accountability: using sec_pagetables cgroup-v2 memory.stat entry.
>
> With the change, iova_stress[1] stops as limit is reached:
>
> # ./iova_stress
> iova space:     0T      free memory:   497G
> iova space:     1T      free memory:   495G
> iova space:     2T      free memory:   493G
> iova space:     3T      free memory:   491G
>
> stops as limit is reached.
>
> This series encorporates suggestions that came from the discussion
> at LPC [2].
>
> [1] https://github.com/soleen/iova_stress
> [2] https://lpc.events/event/17/contributions/1466
>
> Pasha Tatashin (16):
>   iommu/vt-d: add wrapper functions for page allocations
>   iommu/amd: use page allocation function provided by iommu-pages.h
>   iommu/io-pgtable-arm: use page allocation function provided by
>     iommu-pages.h
>   iommu/io-pgtable-dart: use page allocation function provided by
>     iommu-pages.h
>   iommu/io-pgtable-arm-v7s: use page allocation function provided by
>     iommu-pages.h
>   iommu/dma: use page allocation function provided by iommu-pages.h
>   iommu/exynos: use page allocation function provided by iommu-pages.h
>   iommu/fsl: use page allocation function provided by iommu-pages.h
>   iommu/iommufd: use page allocation function provided by iommu-pages.h
>   iommu/rockchip: use page allocation function provided by iommu-pages.h
>   iommu/sun50i: use page allocation function provided by iommu-pages.h
>   iommu/tegra-smmu: use page allocation function provided by
>     iommu-pages.h
>   iommu: observability of the IOMMU allocations
>   iommu: account IOMMU allocated memory
>   vhost-vdpa: account iommu allocations
>   vfio: account iommu allocations
>
>  Documentation/admin-guide/cgroup-v2.rst |   2 +-
>  Documentation/filesystems/proc.rst      |   4 +-
>  drivers/iommu/amd/amd_iommu.h           |   8 -
>  drivers/iommu/amd/init.c                |  91 +++++-----
>  drivers/iommu/amd/io_pgtable.c          |  13 +-
>  drivers/iommu/amd/io_pgtable_v2.c       |  20 +-
>  drivers/iommu/amd/iommu.c               |  13 +-
>  drivers/iommu/dma-iommu.c               |   8 +-
>  drivers/iommu/exynos-iommu.c            |  14 +-
>  drivers/iommu/fsl_pamu.c                |   5 +-
>  drivers/iommu/intel/dmar.c              |  10 +-
>  drivers/iommu/intel/iommu.c             |  47 ++---
>  drivers/iommu/intel/iommu.h             |   2 -
>  drivers/iommu/intel/irq_remapping.c     |  10 +-
>  drivers/iommu/intel/pasid.c             |  12 +-
>  drivers/iommu/intel/svm.c               |   7 +-
>  drivers/iommu/io-pgtable-arm-v7s.c      |   9 +-
>  drivers/iommu/io-pgtable-arm.c          |   7 +-
>  drivers/iommu/io-pgtable-dart.c         |  37 ++--
>  drivers/iommu/iommu-pages.h             | 231 ++++++++++++++++++++++++
>  drivers/iommu/iommufd/iova_bitmap.c     |   6 +-
>  drivers/iommu/rockchip-iommu.c          |  14 +-
>  drivers/iommu/sun50i-iommu.c            |   7 +-
>  drivers/iommu/tegra-smmu.c              |  18 +-
>  drivers/vfio/vfio_iommu_type1.c         |   8 +-
>  drivers/vhost/vdpa.c                    |   3 +-
>  include/linux/mmzone.h                  |   5 +-
>  mm/vmstat.c                             |   3 +
>  28 files changed, 415 insertions(+), 199 deletions(-)
>  create mode 100644 drivers/iommu/iommu-pages.h
>
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
>

