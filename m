Return-Path: <linux-fsdevel+bounces-10642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36BB84D001
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 18:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86331C258E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 17:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76618564B;
	Wed,  7 Feb 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="JFuH6mmR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215385277
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327677; cv=none; b=eTyDjtuQlWwAKhtkhHz+nbFzFzxN05fj9ZwmVawp8w/vbco7xbaIEv2FipbDwN/US2PjBo4AHB41O05CYQSjUV2XqLnpyPCIeeENWALXdylHreqRLvOJZsZUfB1jzgJeoEeK2lc0GJ+rALyh7JVPx6U4WrajvtrBiCyfSeE2O6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327677; c=relaxed/simple;
	bh=Rlmg9bzpRRb4Qalb1o3Wlob5Z9OBdY6QHQ/tgIXtV2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSaPTgG45bOZ/QB9IYa9gv53x1hS5TRgkgp1L2Cir7to447pDNentZGCWmZ7WaVL5qalNjSw5XTFvEDBqHDsShyiIq6C2G6M27eJI5I3HqsM1JVgMc7To4MnbROukb1GzwvxvtFT8hqxsPcXqF1WK4krD/r2A2wXOs9n7Jmkqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=JFuH6mmR reason="key not found in DNS"; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7857964f57aso34352785a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 09:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707327674; x=1707932474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRs2+3L7reOpWDJLX1eglKVbVfztnuhe5Gbs6bYq4mk=;
        b=JFuH6mmR24HTBM4vmzuRoQ/Cj0HQPrs/XBghn3pWtmPsG80IhTAWxdohKg2WQu6gph
         fK8geO5PkFhIQGRr1/aM6qhawIlqYj+Il9g3/6xz85xUSSY4kLmKfKJ9gNpXWWL49o6I
         oiP7iMo8o+TEUOYDUYLllfwiH9sF15YdDkGXBS2imBIO4uIaN30cAn+Ik/2j7YEItrMX
         1UBjWWxWh2BtZtfpl2k3kdLiTWTgu1fOErJpm+AZ2xZUlKqVOx3EETDXim4lhISGN0jH
         FjY73eevXPYnGwYferLemb4F66E8NICwZbzMtWxDZYnOblYVzkHdnDhZhDpXeHqyaw69
         Kiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707327674; x=1707932474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRs2+3L7reOpWDJLX1eglKVbVfztnuhe5Gbs6bYq4mk=;
        b=n32DnXIGx/H0mP5Ssk1oifZ+KQWeHhmtfksGmPh6NPkfFbUBCidnm4yC3eMP3OnXbj
         Yxsm5yrsX2bElka3m0v/Gl04zi9jBCOuUXV9PJAirm59N8b42F2BIMwgUpAiM02XBHOT
         6+FwyJh0Ty3/Ue6+/F2Ia0xSEtxRhtRpbqj+ronPAwzzaRAyEyZ1U4fuUeCxB+OTUAGF
         eijwHp/X8SuL1IUYgCgXsc6Zwxlv1riOJ34yaoSUshklsQ/N6j4dqZg3NF9VGHU5Vt2U
         4cqN7Rdl2yzvQ9/tZjfgKD8lMrghl2DQPFHsEE/hAMVhztbbYWCY6DT4VvjwI39YI56q
         Wiag==
X-Gm-Message-State: AOJu0Yxpwf31fe4WWG0bxw02lVNXL+tDiJxtQOvI0uX1ns5l9DBzOJ91
	riapnFyHRTPlvVhZn/Mqy15gwth8jdwJ9FOOHj2TpdwiNHRNGDyEGk3pb0eazt0=
X-Google-Smtp-Source: AGHT+IHjEFIw63ES6/svy+aJUbNe0c3qyC0BVt1dJGlizw8NcPZWt7xtHW6wZZRb5sI3CTWzt+qhwQ==
X-Received: by 2002:a05:620a:8d5:b0:785:9e66:95d8 with SMTP id z21-20020a05620a08d500b007859e6695d8mr1885336qkz.48.1707327673940;
        Wed, 07 Feb 2024 09:41:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVc5nMONWxYqW32x/6V7C+9nsKXLKoua7ZIdfEJQ9x8/76Jss63+h6JD1mwJGehXsdSfnoSE6+lpv6Sp1vmZpeaIMONknbVszHoRqTt5fTy8P12Vq+8tTBuH7Uy4QgZ6fXnpFyK380IN74Don8Zz0sp/QqAdGZSQPsBKW8sjK0Fst0EbZ95wEEG8YOmR/P2K++j2TCeaX3xfIWpaQbA4nhqcOc0acSAOLM83i2FUlU6UMphppieS3cN7iuYDfW0oEQgrLqh9GLJc0dHqVBbY9sQYR6Fdh+6ZhcEk9HvMUnkTYfVj3uRBfn3nZYgvk8J50svOXjNvbwCqE72I1PhyrfREcu8sv4mo83W7LLp26mCaaRaLhCFbCdBTVM67IPzB/v7k3n558PzJ+iSs9ZY/jx/sRmUzJgfYvnYEuUdriETHQv5iiXvKDxws/t5ycciWe07r26/gYd7DiqDZYqc54wrZakFHgVcdyHngL7pa9VuPchRKaGPU+7w9c2Hzx4I6X1pscVNNtydVeaBUks33NqUx39wSKcNdEfcvSWm2+GTDzrOAxxRWrbr/t2ufdNbl0aDfRNhzbEZyzWLVwNv7fMAHTpJ6omPUzOqVXTEyojAN9ghrOeGm7Dk7xVk3uIqvRy0DSPI8E+Ze+jwOc0pGkL++sx17P19vuN5F/WKF70+28kLiFtKPh9EEQMzE9Y+eGyK7u4jcJcdmhWeLzz9Y9xuQ429YF6B7vdicCw4DsR6QHTJ91JqRu7YmoMKTGscsZGBWVPk5I4iXH+RgowpMH0OHu8dOQT03o3NRZZ3TaDetzJRsZFy1j44IFOIQ3EV6DNJ9EjTCG//WzyV9wD2pFnbL+Of4xb/EpC9P62qIVMoWPBpO6KemXj5aQ+LEwYdUBXma3LPINQtkBPh/qWeSt2PBWoCqF0UZTeCakLLkwC4IkPycERVRKkrcA0R9qdTW+gehB
 zBIIjQzpGRxu8l7H8HwrUiovJ7fXKfCLuaCVsXH9ExLnfN/ZaGHlIleJ96WFudMmoD1G61fCa/wZ7yyJt7xQwppSTHNqYVRIuB9/1fvOhzh08uUXo5ePZgiP9OkKTN8Zy0LPuIQVUhgt4xH+BK1s6cypKWqf5wIxZBH2qjEPeOKI/sJ7D5CUKDS/PxMSV4xM4AObmMSQ6XDZY5bkJQYcGkAhwZ5RGigbS/5NgMI0Q16vYJRG5+JDv6lRT9ua8vg7jGy1zzv/ZH7GebBVJ15gy/mZW4P58ZyHkrIWYMtjRNiy4LchEOcm3vlX3jSaGGuzqY8X4RGVcrkaRZ+Siz5FY7UZaWnCoG3k4aMUGcm0IU1zwsz3RnrOR1YyhTAihG7LRMINuGCeYroByqcTuKYMaJIdQBiGr8oZuSWloHGpuOLRmJcdPTtxdEXvC1xiyJ+MEbmpS9Rrpw/f92KkqyRaC1mk94U5VPxRjV5upOa72CWOm+
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id e10-20020a37db0a000000b007854018044bsm696310qki.134.2024.02.07.09.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:41:12 -0800 (PST)
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
Subject: [PATCH v4 05/10] iommu/exynos: use page allocation function provided by iommu-pages.h
Date: Wed,  7 Feb 2024 17:40:57 +0000
Message-ID: <20240207174102.1486130-6-pasha.tatashin@soleen.com>
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

Convert iommu/exynos-iommu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 2c6e9094f1e9..3eab0ae65a4f 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -22,6 +22,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
+#include "iommu-pages.h"
+
 typedef u32 sysmmu_iova_t;
 typedef u32 sysmmu_pte_t;
 static struct iommu_domain exynos_identity_domain;
@@ -900,11 +902,11 @@ static struct iommu_domain *exynos_iommu_domain_alloc_paging(struct device *dev)
 	if (!domain)
 		return NULL;
 
-	domain->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
+	domain->pgtable = iommu_alloc_pages(GFP_KERNEL, 2);
 	if (!domain->pgtable)
 		goto err_pgtable;
 
-	domain->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
+	domain->lv2entcnt = iommu_alloc_pages(GFP_KERNEL, 1);
 	if (!domain->lv2entcnt)
 		goto err_counter;
 
@@ -930,9 +932,9 @@ static struct iommu_domain *exynos_iommu_domain_alloc_paging(struct device *dev)
 	return &domain->domain;
 
 err_lv2ent:
-	free_pages((unsigned long)domain->lv2entcnt, 1);
+	iommu_free_pages(domain->lv2entcnt, 1);
 err_counter:
-	free_pages((unsigned long)domain->pgtable, 2);
+	iommu_free_pages(domain->pgtable, 2);
 err_pgtable:
 	kfree(domain);
 	return NULL;
@@ -973,8 +975,8 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 					phys_to_virt(base));
 		}
 
-	free_pages((unsigned long)domain->pgtable, 2);
-	free_pages((unsigned long)domain->lv2entcnt, 1);
+	iommu_free_pages(domain->pgtable, 2);
+	iommu_free_pages(domain->lv2entcnt, 1);
 	kfree(domain);
 }
 
-- 
2.43.0.594.gd9cf4e227d-goog


