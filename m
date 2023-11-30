Return-Path: <linux-fsdevel+bounces-4507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16EB7FFCDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 21:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C97B2819EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 20:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E35A10E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GL8qFp09"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293821993
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 12:15:15 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b84402923fso804863b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 12:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701375314; x=1701980114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwZxW20NTsAI6OtU2mg3WBn7dc7VhXurLb9lJcGaB3s=;
        b=GL8qFp09V5Wiu+F/ho2KvnbNKcZG0DYvo4Pm20uRl/F7ijxpOsamWsN/VtKbUFiiSG
         tAwQGV1ZFXnCHLMaLHLpRT12zGCFjwHDAw7njRVhha6RFgXjzttE8llm4vGA+8BPDDJd
         hpPWVkqvX6auu2em1j3XvPtvqa4aMwJFN7dPoeBJgF1K6J1kp2pQIjpEfZfM6wVvBPyE
         0FU4MzQZ24fdQwX8kwH9CGCET/zXKpOxFcXIq9crY4iS7fsacaXGOuV0i8Z/sJ1cSVgM
         /OaMlYtoeju/XakvbmQx3VJV/wtcb/4/owqh78jBvvLCqynv3cfNRZ7eiuVz0/0xKvp0
         K8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375314; x=1701980114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwZxW20NTsAI6OtU2mg3WBn7dc7VhXurLb9lJcGaB3s=;
        b=F6vytxdoY59zdgT4safY7LL3DUWj2uTh5Gc6+DQZJ5nYeyR5NvAf/2kGWLGbiGpEtQ
         CUj6mP6Vt5qbDdKEEtg9BF5L8YyFFg7hXvH3i6WtWiMXbDGyjeKrWzBIonvE6PtW8ezm
         bAexm+nkR6OoNczc4C7js+PWq8feg/RtPoV/z4wmubjnbnwRESD7se9t3Pu+KolcXW9n
         XBvNLOJjYfoxsHn+7X0z3s7Eyt5ztU0UxuhUZ69M95qv+47N3fLBIblNtEGvQE77pzGd
         Toxea46Cu94oyGSxtN1UZFAGZDOQWAKlWFuLnzBQkeczew6AVRp3rGmvtbQR/1IYBOpe
         7o5A==
X-Gm-Message-State: AOJu0YyYrCdsgq5EEuvHAaOvHu8T8VQ1kivr70PAfmadVu6zdPzzqOjD
	Exb8hCfcHH+sAF8Cgv5HoHzqfg==
X-Google-Smtp-Source: AGHT+IGTxsoHsoEZ+jaTqaWghyHDgBjLPZzal0bywx3elLmQBrrmBhd0Hv9BOGHbfQGzeWmE2Kea2A==
X-Received: by 2002:a05:6871:3281:b0:1fa:5890:7840 with SMTP id mp1-20020a056871328100b001fa58907840mr16958744oac.35.1701375314449;
        Thu, 30 Nov 2023 12:15:14 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id e1-20020a0cb441000000b0067a35608186sm795252qvf.28.2023.11.30.12.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:15:14 -0800 (PST)
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
	yu-cheng.yu@intel.com
Subject: [PATCH v2 07/10] iommu/sun50i: use page allocation function provided by iommu-pages.h
Date: Thu, 30 Nov 2023 20:15:01 +0000
Message-ID: <20231130201504.2322355-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iommu/sun50i-iommu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/sun50i-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 41484a5a399b..172ddb717eb5 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -26,6 +26,8 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
+#include "iommu-pages.h"
+
 #define IOMMU_RESET_REG			0x010
 #define IOMMU_RESET_RELEASE_ALL			0xffffffff
 #define IOMMU_ENABLE_REG		0x020
@@ -679,8 +681,7 @@ sun50i_iommu_domain_alloc_paging(struct device *dev)
 	if (!sun50i_domain)
 		return NULL;
 
-	sun50i_domain->dt = (u32 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						    get_order(DT_SIZE));
+	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL, get_order(DT_SIZE));
 	if (!sun50i_domain->dt)
 		goto err_free_domain;
 
@@ -702,7 +703,7 @@ static void sun50i_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 
-	free_pages((unsigned long)sun50i_domain->dt, get_order(DT_SIZE));
+	iommu_free_pages(sun50i_domain->dt, get_order(DT_SIZE));
 	sun50i_domain->dt = NULL;
 
 	kfree(sun50i_domain);
-- 
2.43.0.rc2.451.g8631bc7472-goog


