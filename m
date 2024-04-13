Return-Path: <linux-fsdevel+bounces-16840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A27E8A393F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 02:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6E728499F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 00:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D441CD1B;
	Sat, 13 Apr 2024 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="QqfMTW5D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389814290
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712967937; cv=none; b=ROVsn/dRyhyvCj0Kc6cfV/Ps1UFI6eder1LSSKdl2RACsY0jPGy7RkZV8wmBelV6GFb61ap/LSdXDffS6dOGFVKVD5SqhlJqGm0auy1Vmm8JnBjwtkaB94MpzpX3dqkyYMePuiMYgobZFuh68i+xKlbd0B6lPEGqUQekaklIGkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712967937; c=relaxed/simple;
	bh=yaKp2sRaul+d8oXy8RrRaFP/wgzV01J4vQOxiwdC63U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJhBO8MGXLdoPF3uidf+jUJPzJOKB1ICThw+C339zDFZJEK3szhBa/Xuq4R9JREu8RpLoGJgFa5q+QT4UxPDuh5vUdblKjqk/J9tiwhOzAVOvboq69U/G4yrqxf8bE0HYK1R+eOJo8LTDbFCdnO+V+2ROmydLhvk2xpOLWm9fwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=QqfMTW5D; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78ecd752a7cso58093185a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 17:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712967932; x=1713572732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxsyMTKANsChLuxDrkmJaktgLM+pVsQuG3GqfblYy+c=;
        b=QqfMTW5DjFIK7MOMc/sInaxPVR7UMlXvrgGz3o5hDKCHHuVO+haKGlrGY3kuHARYxn
         daA+xJI/l1ZXCzTlDSOT9ZULkOqxtmAVdWonR25gbuNWKs0fiqI8n8d473qpfhgyekCG
         ij2+bunS+/4UAsV2hFENkxa3EmduCT/8rEzlcW6yv+XPjxkCsT9KeodKG5XBd2lY3p5e
         IbA5fdKfj5jtgrbx9F5fEmHuzfrT5PBKiLtLvon6miqmdFY8+CGIAxIOXfsfJOsOK3oD
         Dy7PQBKCxrZV89w3iEWjGVCvLJQQlA6W1tijVmKxSV/douX1SzoiFM6tqW5sNzqwN9d9
         0FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712967932; x=1713572732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxsyMTKANsChLuxDrkmJaktgLM+pVsQuG3GqfblYy+c=;
        b=B1B/TW5BMcmpNaqRu4ThzPibSB1ZNqOTRUdLqDIyQIwfva+86LJQ/eKrxGEQPhUSH2
         BOY6GtTBHLPCivIpX9T1vGLqpFb5selKNDa3ye2ohG5+OJIF+ot303+pjfab6MWCvmL/
         382jxbHIrgXgXoW+tcK8hiLaAsTUWKeRIvEJQTnp0LPQ0WJYCubSXRjUyYYQAbrHpcPB
         DTHrleEWkekWc/ntImg38M6m/eUg96it1HIzLvWneQe5xOnRF2zfIqH2m6sXzOwl/SRw
         UrU9YDLOJgFIfs5b6BNzizcIF5w84JSKqHJKc4VvYGDDWGPWL5NW+KjbPbLrP3ZXEfzS
         lhEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSPPi62xtwZGhX1R1Br48jSO05xFqzLBeYziHjfC1+4JuMGyB78c0rcowS5WdyFsNVxB637nF8sNSzjtK/PUapcL9TRYmT6+KPhdhGkg==
X-Gm-Message-State: AOJu0YyL7Z/vjPPtbXBG2tVq0/cX6WqeEcWHwPVCml2FxlFSFS90Wzlt
	5hUUnWiHNVHbM3EBZjvpqLRwzYuwKmPsODQR2v+64z6hM5gckaZICCIPgVp3Mio=
X-Google-Smtp-Source: AGHT+IEkNWXvNi+BSDc9at/eU/P3rQB2xk7v0rRabM9OChaVToo3gqnYxXYIGwdXJVnOXaB2E6eCQQ==
X-Received: by 2002:a05:620a:45a4:b0:78e:a3d3:eec1 with SMTP id bp36-20020a05620a45a400b0078ea3d3eec1mr5189213qkb.47.1712967932439;
        Fri, 12 Apr 2024 17:25:32 -0700 (PDT)
Received: from soleen.c.googlers.com.com (128.174.85.34.bc.googleusercontent.com. [34.85.174.128])
        by smtp.gmail.com with ESMTPSA id wl25-20020a05620a57d900b0078d5fece9a6sm3053490qkn.101.2024.04.12.17.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 17:25:32 -0700 (PDT)
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
Subject: [PATCH v6 07/11] iommu/rockchip: use page allocation function provided by iommu-pages.h
Date: Sat, 13 Apr 2024 00:25:18 +0000
Message-ID: <20240413002522.1101315-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240413002522.1101315-1-pasha.tatashin@soleen.com>
References: <20240413002522.1101315-1-pasha.tatashin@soleen.com>
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
index da79d9f4cf63..4b369419b32c 100644
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
2.44.0.683.g7961c838ac-goog


