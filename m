Return-Path: <linux-fsdevel+bounces-10643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5551484D009
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 18:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9871F2130C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 17:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0748593E;
	Wed,  7 Feb 2024 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="CxNbiLhy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865EE85642
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327679; cv=none; b=l6DtGbLvsGJHkQy5gga7d/TN0nlXn5w2ZWBKPDBhD5VX7wkMoqlSj7WZ/J0I0dV/MjPwIPeIFLUi4NZj4UHDHtbyK2IK/JnEQVWJW1o+UKsXMnFkfg329qPN8CWXWOiFxlD+7dmeVq32eqEniqtT3IgiWJnxat4OGbMtn7LtV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327679; c=relaxed/simple;
	bh=3XNcUNnDyPwz5y38tg9cKv20ES1kICICpaqblVBPZxg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AirXl/XbeyYo5i9SHui5VMC/3+saom8J2VVNJpY5uKEJX3QULzd7V0nbcAkrZQNPgcFy8XhQtmTj8asC2f1o3efwM2LGyZm5U8rqexlE0GMMlq8B0QVu+Eg8aiPD39jf5DecYwLKpUvg2KzgUL4r9OWD6YZ9TqAOGq865chL+Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=CxNbiLhy reason="key not found in DNS"; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7853fcc314bso56440785a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 09:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707327675; x=1707932475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xz6G05O4wA+60kCmvmgiGx9JBrU5EV4e3uvGda8jyEo=;
        b=CxNbiLhyyrf1CVys6flRbuSdMq8VkMEquLXFaMSJEW9NaGgSBg/344NSewcfr4a/wx
         XXW6grOMSjqUqZ895RyHsB/KvGh438z2HeR3e43fTLgW0sEzBH91zI9g/s024CJF0Zio
         Xnv/kyzP+rds1z9I1lYTWRUNxQpSAAN80Pn3PLQ3jGL3GbazVN8Wd9wt1lSG17CNjRlE
         3Pe6DdzcfEHqUDjoIHkcU1gCTtrn74LTybtG94aSjsG50yetYjHm1hNJ6dljKZxEHXq+
         amPUBiEzTp61r0zV4Q3FHfZLl1SCmJ7QOXoNMd6wgji4+zu82h+l6VkQotqrXDB0GjyW
         suFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707327675; x=1707932475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xz6G05O4wA+60kCmvmgiGx9JBrU5EV4e3uvGda8jyEo=;
        b=DcfUEPVCnm+rFivvYhPA74tvhJ++wqLktFp0oG8QIAynWUGY1KHZPOkXUXvggF3XL5
         ItsleFeSY7nzJ+unj3EfiMnSXnfTwWS+LqYREAdsrPefHK+tjj1p93m13XpKK+MYffyo
         MRVNjQ89l5SbjtqaVeyROGrsvTC42/z5kTDK+BsnoFPW1LUqvJzHPTiMYtLc3X1GszmO
         jw+6wfsoEBBIDjK6JRk+ylNIRbDyFZ8N6KpVzxqWvWT19eV8ChxrnDFQCxvkLqJVlzvF
         dd/0dEQHrX+YGnFgSBLbhOJ5it/1J2tt2ivjKXsYFk5p7lWBzsnf2vuJLBsx1EjKod56
         Fh0g==
X-Forwarded-Encrypted: i=1; AJvYcCX+Vce1EDUtVOxz//KU/kO5hBWaNAmH7Jrj4IeqUo3ZPYqwibfash5QTVCU/87pNYCWaBh6ANa17n7biX04rHRtD8ImqYFhRCVRI8FFtQ==
X-Gm-Message-State: AOJu0Yw4xNp1b0OYytgu46tyUodQlwrnJh78noJ8ZcBf9sV61yXoEk3Z
	geeHjmJ3lG9NHdwKZx/UGORXWlenXVhV5u+bSCeTdQJINzPDGBvppOjCKvviJec=
X-Google-Smtp-Source: AGHT+IGm7HEOEjYyU6ceEAyCJbj5ZSiZHtVoT/GGu/ljbSy4K2SHMHGE1ZU+Mc3GOvN+MGgdJxPt7Q==
X-Received: by 2002:a05:620a:458f:b0:783:c945:f774 with SMTP id bp15-20020a05620a458f00b00783c945f774mr7801189qkb.16.1707327674945;
        Wed, 07 Feb 2024 09:41:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrjHWstAmPKNKmmOZss+LrnMGoMozP5bewBJMtBvsxnSH4qAA9cpPi1oYJJyh0BUiRXx8vEuPicCaLWIj7WkRsbPVXs5pF2kWy9iUO8oTShW2B8fsnkt7jYBRZir8Fz5+c72ScE95t4q5LHZ9pZO7lVdBZaewRpE/NRTtfPSseusbUyGGDy6h+O4ovY7nXnFPIJ86SUz3Dtek5Hgc7y2J+Z+WTwUQs9aZpp8P8Z9mAsQP7dpGv5qpZgJJc+KhJ+3YbNawEbDn6BoSaBFcWYvC2iawUphmoa955poBq4d8NK0bieLstlnhd0+F4aMp03PTWFtKgeeGN5BNwOh+yuYSDzJGEgx+Q5FLBw8GUMq8ADEBNdGsxltHxrZkxkDb2Xzr59XaH5uUTXdxZtdNzyKd/WvxprwrkKL/Y0V496ab8itUl+7v63ZAXPuiao/r15D99xjNwwYyQ8MaIZMWx5oBm0W4viPnDezsxhm1S6ldjOX2GYSvbBKZjZKgO8JfaqW7YgAadHrhnWydYP7q897L26rp4R+PTyEyDm1Ttr1BvzrEkF14wY7DMd4cE9vnRmgyMpc9MIV1AS8Yeol//B7sedMHGx9YUlhHmMld6IvICVHr9cPlSBhKJhEgP95TiG37l5tWnPBTjqAnvQXaQ3/ssibX8uYPmb2YjK65W4/kv6al+yX4cpi8g1qWOJc/jWs0DVzguf/yN9hfoKE+C5iMFHsXGhQa+lvEGly3VLu8DY96oAirk3p7ee+Vr4Nq1Eem+lyudfRY8QGxu3vMiiocWWsFzPg+N0ka5b3Ss0zDaGpOtLPitRJvp9TSELiK4t5+VNOo5T7rOmnLnYkmtovz4hQgWWiD7cFKVpP8pPPeuXJf+RIb459I54+kbjtiIBSnxktVzV12pdR/i32lYdnVpfsSTS2IeyOGtJQzkFdR4D+1gKDfQFxHWHeFI5zESLmyLNW
 Ao7b6FgzEQATp9gXBFjnlk2upisqGrCNtgs4ViYBAYCn9VIpKTTVJx8QL1GCc6lwCUdWzqqZUFQlS3tf8uWIjDjC6W1SRrYk4pE1Y7e8reWeyw9aF+as40OW4Ezw8RGpi0muxi4Y1aZNhTeh56EfSELm+bOXEfcS787PLN7zzTynHNy2FN+1NnoUfBaolqV9bj4KixvnEsdzHzOZstfc5xGz2ZLCGLAhOGO7jdNWScuTX7NExkhEbv3PnLl9I73PUAjg+brm+juf8r9qQgk+jmy4lk6xDFQ7ssb2ubfZ9vQvNU2uJBgWMc4JqfaH5NW72z05Ap4JDXNghrCFVpeYufB7XyHzfwtAT+J8ApXxOu9QYjpzOWKVDxbi68ugpqpPv65NucRhhZdFJ9QHW8MZrIvjX6h2JEqzGbspJ+yissL6+wfnzJmBK8zVJlAOnxnmzfF5TCDMHoHoER7Lr1dMpSAzmj0/EAtm4Af6trtfEIkamc
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id e10-20020a37db0a000000b007854018044bsm696310qki.134.2024.02.07.09.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:41:14 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jernej.skrabec@gmail.com,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	m.szyprowski@samsung.com,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com,
	rientjes@google.com,
	bagasdotme@gmail.com,
	mkoutny@suse.com
Subject: [PATCH v4 06/10] iommu/rockchip: use page allocation function provided by iommu-pages.h
Date: Wed,  7 Feb 2024 17:40:58 +0000
Message-ID: <20240207174102.1486130-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
References: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iommu/rockchip-iommu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/rockchip-iommu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 2685861c0a12..e04f22d481d0 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -26,6 +26,8 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#include "iommu-pages.h"
+
 /** MMU register offsets */
 #define RK_MMU_DTE_ADDR		0x00	/* Directory table address */
 #define RK_MMU_STATUS		0x04
@@ -727,14 +729,14 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	if (rk_dte_is_pt_valid(dte))
 		goto done;
 
-	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | rk_ops->gfp_flags);
+	page_table = iommu_alloc_page(GFP_ATOMIC | rk_ops->gfp_flags);
 	if (!page_table)
 		return ERR_PTR(-ENOMEM);
 
 	pt_dma = dma_map_single(dma_dev, page_table, SPAGE_SIZE, DMA_TO_DEVICE);
 	if (dma_mapping_error(dma_dev, pt_dma)) {
 		dev_err(dma_dev, "DMA mapping error while allocating page table\n");
-		free_page((unsigned long)page_table);
+		iommu_free_page(page_table);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1061,7 +1063,7 @@ static struct iommu_domain *rk_iommu_domain_alloc_paging(struct device *dev)
 	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
 	 * Allocate one 4 KiB page for each table.
 	 */
-	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | rk_ops->gfp_flags);
+	rk_domain->dt = iommu_alloc_page(GFP_KERNEL | rk_ops->gfp_flags);
 	if (!rk_domain->dt)
 		goto err_free_domain;
 
@@ -1083,7 +1085,7 @@ static struct iommu_domain *rk_iommu_domain_alloc_paging(struct device *dev)
 	return &rk_domain->domain;
 
 err_free_dt:
-	free_page((unsigned long)rk_domain->dt);
+	iommu_free_page(rk_domain->dt);
 err_free_domain:
 	kfree(rk_domain);
 
@@ -1104,13 +1106,13 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 			u32 *page_table = phys_to_virt(pt_phys);
 			dma_unmap_single(dma_dev, pt_phys,
 					 SPAGE_SIZE, DMA_TO_DEVICE);
-			free_page((unsigned long)page_table);
+			iommu_free_page(page_table);
 		}
 	}
 
 	dma_unmap_single(dma_dev, rk_domain->dt_dma,
 			 SPAGE_SIZE, DMA_TO_DEVICE);
-	free_page((unsigned long)rk_domain->dt);
+	iommu_free_page(rk_domain->dt);
 
 	kfree(rk_domain);
 }
-- 
2.43.0.594.gd9cf4e227d-goog


