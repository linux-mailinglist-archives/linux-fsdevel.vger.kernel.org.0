Return-Path: <linux-fsdevel+bounces-12330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A20485E7F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8291C2418D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61458148FEE;
	Wed, 21 Feb 2024 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="it0ATj7b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774051474A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544496; cv=none; b=rT9w22aKP7I8A7cWVwc223glutCj/qFvZ7NUMn2i0KaPAbvi8XFmQrW5AGraxqHM1qSV6FJ0TiA1FE54YAe/dpUUCCCF3qPpYj/FkcMDZ/cYCL+McJfk7yAQT/3RH5TvyEyp8aiTjRAl/kgT/HwDuJCwRtMA2Hd0UCMy9v/xOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544496; c=relaxed/simple;
	bh=fNIyv82dg3NNs2e3sdnU1M0ynlvHhStL1/HZRgkNZNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aXv9BbYl8GwxhmuxZn34Ze96IAPKVw/bLBK7ASbM6bBCIr6ahl8K4SA4FMnVrN2xXhFI5MZURclCW5XX6LYlcsSJ15az5jGAV+JQrfvgU5qSD+P3f3aAc29JgpgMRNjhemrkY/cfcBU9kvv6BsYqtVMRcEhQAjZYfwrvadn5P3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=it0ATj7b; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6088fa18619so9940317b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544493; x=1709149293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ICmwOELDDa5gDiXJ0QfSPYNwNSjuLTkQBKISvcVpvE=;
        b=it0ATj7bJpRScWMfQUTw52oUX2GzZ8l8IR9aOUrZNVUp8F+X6baltzcqKgx/3xTwdc
         y1T3h8zJN2aKOy8P65juN21D7IiL6edj5ZVgWPeIPHZmEmcuMhnoTA78Z7s+Mtxk0g0f
         ijHiISJbn7VBtBd/kuL+U4IOpQVXHOJFm10uD2pWI+xeufXP8GoBwbKnjkFUz5v53CLk
         bkzw8Z+f7q0ElPWaM0K2ndQkGq6cZ/sa/3Ly6ApunXtGTR4u70MjvV2hDthn5xCLdG0F
         hDT8tzedM3oUU3xcl0F8yeZRWC+oupY+n4PSjY6O6pGNClsJs1p8f0kQDOujcRHbKMuZ
         rmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544493; x=1709149293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ICmwOELDDa5gDiXJ0QfSPYNwNSjuLTkQBKISvcVpvE=;
        b=Rj+6ZytNb2AeMPg4pgk97ElVW2Mc3YX4aM42f0JBNkJuPPKd+0MskR2dkQATd6OlPT
         hdAhMns7tMr18/9NDnuzrOLaYAXG7h1umgL5btdjQNUxOY1XnWoTWH5XLkPc8MS1adYr
         C8hpMN+9ysvK40k8ai3/ndRrUmiROLRaYolX6XWPJ91nVStWzI+At3jUGOIHzdAywDD1
         DlxlfW1C1+BtBsLzzkUdfNdUpANOiXedFq5BhrWoAhBrl9HsF0XWHfVKBWqYVk+K2GOR
         MlLh7cMUuoxQ/V+CZ8ITnAv3fHuNIZqJDehmns/HFKRLRPrQt+a7Pf4QA+1cc/Lzx+1j
         7Syw==
X-Forwarded-Encrypted: i=1; AJvYcCWQxUp9jeH1yDojHT4MzY019MlVGfd3GcLdt2bXNCFiW1HgK9T/r7WuWNAxDH6jBSfwU9ka1VOQ8xMUfQ+2ZMFyI73xg7wmRzhTDd0nMQ==
X-Gm-Message-State: AOJu0Yytp1Bxyzf/NmTTvFfJF58pB/p4GRtIzb2FSDGX1hrjyPDO27cP
	o34L8FNWMA1ZB/ucmZQhELnMBheSbHfmVow/W/+zs5oBTUcLzOTWhvIlQU4RiBVmwNyJDNUtHgP
	/Qw==
X-Google-Smtp-Source: AGHT+IFRKkAzXFrqX8FMuNNkdeozK6lGgluj6VzXaaQV6asduSfbKwLn9SW2CaQIMM08vePlCmcgUKW9cG4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a81:ab4c:0:b0:608:2137:27f6 with SMTP id
 d12-20020a81ab4c000000b00608213727f6mr2122409ywk.5.1708544493446; Wed, 21 Feb
 2024 11:41:33 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:30 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-18-surenb@google.com>
Subject: [PATCH v4 17/36] change alloc_pages name in dma_map_ops to avoid name conflicts
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After redefining alloc_pages, all uses of that name are being replaced.
Change the conflicting names to prevent preprocessor from replacing them
when it's not intended.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/alpha/kernel/pci_iommu.c           | 2 +-
 arch/mips/jazz/jazzdma.c                | 2 +-
 arch/powerpc/kernel/dma-iommu.c         | 2 +-
 arch/powerpc/platforms/ps3/system-bus.c | 4 ++--
 arch/powerpc/platforms/pseries/vio.c    | 2 +-
 arch/x86/kernel/amd_gart_64.c           | 2 +-
 drivers/iommu/dma-iommu.c               | 2 +-
 drivers/parisc/ccio-dma.c               | 2 +-
 drivers/parisc/sba_iommu.c              | 2 +-
 drivers/xen/grant-dma-ops.c             | 2 +-
 drivers/xen/swiotlb-xen.c               | 2 +-
 include/linux/dma-map-ops.h             | 2 +-
 kernel/dma/mapping.c                    | 4 ++--
 13 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index c81183935e97..7fcf3e9b7103 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -929,7 +929,7 @@ const struct dma_map_ops alpha_pci_ops = {
 	.dma_supported		= alpha_pci_supported,
 	.mmap			= dma_common_mmap,
 	.get_sgtable		= dma_common_get_sgtable,
-	.alloc_pages		= dma_common_alloc_pages,
+	.alloc_pages_op		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
 };
 EXPORT_SYMBOL(alpha_pci_ops);
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index eabddb89d221..c97b089b9902 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -617,7 +617,7 @@ const struct dma_map_ops jazz_dma_ops = {
 	.sync_sg_for_device	= jazz_dma_sync_sg_for_device,
 	.mmap			= dma_common_mmap,
 	.get_sgtable		= dma_common_get_sgtable,
-	.alloc_pages		= dma_common_alloc_pages,
+	.alloc_pages_op		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
 };
 EXPORT_SYMBOL(jazz_dma_ops);
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 8920862ffd79..f0ae39e77e37 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -216,6 +216,6 @@ const struct dma_map_ops dma_iommu_ops = {
 	.get_required_mask	= dma_iommu_get_required_mask,
 	.mmap			= dma_common_mmap,
 	.get_sgtable		= dma_common_get_sgtable,
-	.alloc_pages		= dma_common_alloc_pages,
+	.alloc_pages_op		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
 };
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index d6b5f5ecd515..56dc6b29a3e7 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -695,7 +695,7 @@ static const struct dma_map_ops ps3_sb_dma_ops = {
 	.unmap_page = ps3_unmap_page,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
-	.alloc_pages = dma_common_alloc_pages,
+	.alloc_pages_op = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 };
 
@@ -709,7 +709,7 @@ static const struct dma_map_ops ps3_ioc0_dma_ops = {
 	.unmap_page = ps3_unmap_page,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
-	.alloc_pages = dma_common_alloc_pages,
+	.alloc_pages_op = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 };
 
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 2dc9cbc4bcd8..0c90fc4c3796 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -611,7 +611,7 @@ static const struct dma_map_ops vio_dma_mapping_ops = {
 	.get_required_mask = dma_iommu_get_required_mask,
 	.mmap		   = dma_common_mmap,
 	.get_sgtable	   = dma_common_get_sgtable,
-	.alloc_pages	   = dma_common_alloc_pages,
+	.alloc_pages_op	   = dma_common_alloc_pages,
 	.free_pages	   = dma_common_free_pages,
 };
 
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 2ae98f754e59..c884deca839b 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -676,7 +676,7 @@ static const struct dma_map_ops gart_dma_ops = {
 	.get_sgtable			= dma_common_get_sgtable,
 	.dma_supported			= dma_direct_supported,
 	.get_required_mask		= dma_direct_get_required_mask,
-	.alloc_pages			= dma_direct_alloc_pages,
+	.alloc_pages_op			= dma_direct_alloc_pages,
 	.free_pages			= dma_direct_free_pages,
 };
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 50ccc4f1ef81..8a1f7f5d1bca 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1710,7 +1710,7 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
-	.alloc_pages		= dma_common_alloc_pages,
+	.alloc_pages_op		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
 	.alloc_noncontiguous	= iommu_dma_alloc_noncontiguous,
 	.free_noncontiguous	= iommu_dma_free_noncontiguous,
diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index 9ce0d20a6c58..feef537257d0 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -1022,7 +1022,7 @@ static const struct dma_map_ops ccio_ops = {
 	.map_sg =		ccio_map_sg,
 	.unmap_sg =		ccio_unmap_sg,
 	.get_sgtable =		dma_common_get_sgtable,
-	.alloc_pages =		dma_common_alloc_pages,
+	.alloc_pages_op =	dma_common_alloc_pages,
 	.free_pages =		dma_common_free_pages,
 };
 
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index 784037837f65..fc3863c09f83 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -1090,7 +1090,7 @@ static const struct dma_map_ops sba_ops = {
 	.map_sg =		sba_map_sg,
 	.unmap_sg =		sba_unmap_sg,
 	.get_sgtable =		dma_common_get_sgtable,
-	.alloc_pages =		dma_common_alloc_pages,
+	.alloc_pages_op =	dma_common_alloc_pages,
 	.free_pages =		dma_common_free_pages,
 };
 
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 76f6f26265a3..29257d2639db 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -282,7 +282,7 @@ static int xen_grant_dma_supported(struct device *dev, u64 mask)
 static const struct dma_map_ops xen_grant_dma_ops = {
 	.alloc = xen_grant_dma_alloc,
 	.free = xen_grant_dma_free,
-	.alloc_pages = xen_grant_dma_alloc_pages,
+	.alloc_pages_op = xen_grant_dma_alloc_pages,
 	.free_pages = xen_grant_dma_free_pages,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 0e6c6c25d154..1c4ef5111651 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -403,7 +403,7 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.dma_supported = xen_swiotlb_dma_supported,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
-	.alloc_pages = dma_common_alloc_pages,
+	.alloc_pages_op = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 	.max_mapping_size = swiotlb_max_mapping_size,
 };
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 4abc60f04209..9ee319851b5f 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -29,7 +29,7 @@ struct dma_map_ops {
 			unsigned long attrs);
 	void (*free)(struct device *dev, size_t size, void *vaddr,
 			dma_addr_t dma_handle, unsigned long attrs);
-	struct page *(*alloc_pages)(struct device *dev, size_t size,
+	struct page *(*alloc_pages_op)(struct device *dev, size_t size,
 			dma_addr_t *dma_handle, enum dma_data_direction dir,
 			gfp_t gfp);
 	void (*free_pages)(struct device *dev, size_t size, struct page *vaddr,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58db8fd70471..5e2d51e1cdf6 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -570,9 +570,9 @@ static struct page *__dma_alloc_pages(struct device *dev, size_t size,
 	size = PAGE_ALIGN(size);
 	if (dma_alloc_direct(dev, ops))
 		return dma_direct_alloc_pages(dev, size, dma_handle, dir, gfp);
-	if (!ops->alloc_pages)
+	if (!ops->alloc_pages_op)
 		return NULL;
-	return ops->alloc_pages(dev, size, dma_handle, dir, gfp);
+	return ops->alloc_pages_op(dev, size, dma_handle, dir, gfp);
 }
 
 struct page *dma_alloc_pages(struct device *dev, size_t size,
-- 
2.44.0.rc0.258.g7320e95886-goog


