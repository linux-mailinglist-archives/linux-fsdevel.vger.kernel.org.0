Return-Path: <linux-fsdevel+bounces-55847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112DEB0F5EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0210AA34D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEAB2FA623;
	Wed, 23 Jul 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="K9o/+lpe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC122FA629
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282033; cv=none; b=SN1D3q1Kh5sy4w3IZ8aUb6RZYhFKFXBxx8nAwAHzxUY2UcZKSqhdrdQVzFdsjQ0X4xmRalevRp9hp1ZLwuWQgc2yyxP1A2t82eSbTUMneLLpI8IKLfnBIPQOlhRGLY4Z+BrheQyWneaiPodUXMnph9+mL+SmM8g0BzE6v8+kOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282033; c=relaxed/simple;
	bh=vSU0slshkk55HBCY79+hFfFYEDsYssJQsWxVN1trIM0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoOxFvo31lZPxFXANYZm9zp36jRfRcbl4aJ5xD25H1S8OmDga8dxkIiOnAHcKob2cYnCZe2+odQrX/ID3+FSMB+oGApTVSeQ/7dOWB4ZRN5vGDpeWA2EBG4ysdkRj+3n+KoUZmswrxPuVohdPLGrRsbBJYKqFrBWmSUfuqhPC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=K9o/+lpe; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e3c6b88dbso47206917b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282028; x=1753886828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUhylTCjCy3uyYdpO2FGhnRAf1jyGBpF/+3Er3S6ctA=;
        b=K9o/+lpeE85nh0EYGvui6/NDTaWSTdbYCtCRTAk0CPgCFfEQrYpAqgePC6ig2jrVy7
         8Vg9ZD6sD3zcsrnnpDm9xyKJk1AJQeDJ1FWsmmzTdbSjnaxSVzlxEURUEzjxsr5pu/nG
         GeNNJFC3yAdHfOTO3xEvCx6ZYJQUvEMngcBqHhwVyeClk8WLDc/wW41nPMLUumNOCXx8
         mRQpqVxEjA0mELUduN706Z7UOVlURPagyA+sVyHzzMm6gBVqEnlAjjUUS4UQXzJZX8T8
         cQssajnQA5CpDU1NYT9wwX63/psAiChTjsW9kCoy1uDhgqdH+oo9RjrMR2CG4hOXjLP0
         XWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282028; x=1753886828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUhylTCjCy3uyYdpO2FGhnRAf1jyGBpF/+3Er3S6ctA=;
        b=JM4n+pFSmMQ0jKOZe2Jb2DTV8y+7xbRVn6UKdXEA67tIwKe9P0DsvlM2JO4lQBrlUm
         MXbf6qUFbEdOo22MjTAvNhv6+HqBQMv8YqRVSrhSZGUH+5ECCDk3FuzX2DsuShMe+O9/
         a2Ie0QRCUfS7BVnHdKrpYtK+KBeUpu5pRZ2/p/ymFnz/lwkHGq9JXmg8DXxtBq5M4k5s
         7O0DMi03PH41iFx1cIQV3V7Om3tS+QGCpk6lbtsXJjwxhbw/sU36DcqKWibcUU0/H8+j
         XEdAXhL2CUOPErSHrpDvbWj1pbdKEMKTv8JrRPzQq16QoWBoO4VGd1WUhKGUg0C6PsRA
         kXWw==
X-Forwarded-Encrypted: i=1; AJvYcCUIjuL2+5Wvf3La0mrazE1fDhqVgaDDOeRO1JR5hH2eAcQLpXB3HtpFZuRbXYj6YSeK81hOhFjkLZrn1d5k@vger.kernel.org
X-Gm-Message-State: AOJu0YxIMCXaIgxQFJkx8kh2dXkDvtk66B+2NysPNgqF2lJ6+7Sh7dNO
	06eea5w5ZTbgxalakJ1JMi505bcD10QyfxB4oEsDuBVnAVjwfsLpOTKWSTE3RWSC9y0=
X-Gm-Gg: ASbGnctG8e6ipT/+xLthm5AB/L8CCSQvHFBfn23WT42k/0+A41zrRLfPJ0yukJM/r/U
	eX81SMAAPJF8bK2/HDnSGhcq0ylfUrG0jAVkrzbLaqrjhpWGZGX+2N5Swleqn27oFkBMZ73+pQI
	cs7PA4uLupYgUafgjBWldsBlaNTH2huEBhIvua/Sx6ldQEz3Gxu6F+RiXifHJ0hMrglWWtCJn7e
	1j41hiiTDB2q0XXwZhIw9sqvTvCb14THuX8/iPn99Rn+hAOYfHbFqkRNusuX/ya5UKBOTHIjKiD
	bije5bmboNaGGmIkop4LPoPxi87c75dTBDFCxxZ5ON8vTV+mvdmUdNdowLWdaY6fbhqYZEUwe0M
	BTEM47ZApFanaQ20RBJypPLEKLuwSG+V0d2plCvJQdzItEYzWnHqh3XtxiGqwXYjtHmvG7dkevm
	2lc8ZTJHtRZEvHjJn0PSxWlLZj
X-Google-Smtp-Source: AGHT+IGZ9Bv9q7KwM+e5SZ4p5HtmWokaa1yTavfU4ti4TiXgkGO4Jv4+Imx8qhXiY7NKxrpPJpXoKw==
X-Received: by 2002:a05:690c:93:b0:710:f46d:cec0 with SMTP id 00721157ae682-719b41459e7mr40440567b3.1.1753282028495;
        Wed, 23 Jul 2025 07:47:08 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:07 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v2 07/32] kho: add interfaces to unpreserve folios and physical memory ranges
Date: Wed, 23 Jul 2025 14:46:20 +0000
Message-ID: <20250723144649.1696299-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Changyuan Lyu <changyuanl@google.com>

Allow users of KHO to cancel the previous preservation by adding the
necessary interfaces to unpreserve folio.

Signed-off-by: Changyuan Lyu <changyuanl@google.com>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kexec_handover.h | 12 +++++
 kernel/kexec_handover.c        | 90 +++++++++++++++++++++++++++++-----
 2 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index cabdff5f50a2..383e9460edb9 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -33,7 +33,9 @@ struct folio;
 bool kho_is_enabled(void);
 
 int kho_preserve_folio(struct folio *folio);
+int kho_unpreserve_folio(struct folio *folio);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
+int kho_unpreserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
 int kho_add_subtree(const char *name, void *fdt);
 void kho_remove_subtree(void *fdt);
@@ -58,11 +60,21 @@ static inline int kho_preserve_folio(struct folio *folio)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_folio(struct folio *folio)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int kho_preserve_phys(phys_addr_t phys, size_t size)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_phys(phys_addr_t phys, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct folio *kho_restore_folio(phys_addr_t phys)
 {
 	return NULL;
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 30d673f7f68a..26ad926912a7 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -136,26 +136,33 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 	return elm;
 }
 
-static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
-			     unsigned long end_pfn)
+static void __kho_unpreserve_order(struct kho_mem_track *track, unsigned long pfn,
+				   unsigned int order)
 {
 	struct kho_mem_phys_bits *bits;
 	struct kho_mem_phys *physxa;
+	const unsigned long pfn_high = pfn >> order;
 
-	while (pfn < end_pfn) {
-		const unsigned int order =
-			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-		const unsigned long pfn_high = pfn >> order;
+	physxa = xa_load(&track->orders, order);
+	if (!physxa)
+		return;
 
-		physxa = xa_load(&track->orders, order);
-		if (!physxa)
-			continue;
+	bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
+	if (!bits)
+		return;
 
-		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
-		if (!bits)
-			continue;
+	clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+}
 
-		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
+			     unsigned long end_pfn)
+{
+	unsigned int order;
+
+	while (pfn < end_pfn) {
+		order = min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
+
+		__kho_unpreserve_order(track, pfn, order);
 
 		pfn += 1 << order;
 	}
@@ -667,6 +674,30 @@ int kho_preserve_folio(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
 
+/**
+ * kho_unpreserve_folio - unpreserve a folio.
+ * @folio: folio to unpreserve.
+ *
+ * Instructs KHO to unpreserve a folio that was preserved by
+ * kho_preserve_folio() before. The provided @folio (pfn and order)
+ * must exactly match a previously preserved folio.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_unpreserve_folio(struct folio *folio)
+{
+	const unsigned long pfn = folio_pfn(folio);
+	const unsigned int order = folio_order(folio);
+	struct kho_mem_track *track = &kho_out.track;
+
+	if (kho_out.finalized)
+		return -EBUSY;
+
+	__kho_unpreserve_order(track, pfn, order);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
+
 /**
  * kho_preserve_phys - preserve a physically contiguous range across kexec.
  * @phys: physical address of the range.
@@ -712,6 +743,39 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_phys);
 
+/**
+ * kho_unpreserve_phys - unpreserve a physically contiguous range.
+ * @phys: physical address of the range.
+ * @size: size of the range.
+ *
+ * Instructs KHO to unpreserve the memory range from @phys to @phys + @size.
+ * The @phys address must be aligned to @size, and @size must be a
+ * power-of-2 multiple of PAGE_SIZE.
+ * This call must exactly match a granularity at which memory was originally
+ * preserved (either by a `kho_preserve_phys` call with the same `phys` and
+ * `size`). Unpreserving arbitrary sub-ranges of larger preserved blocks is not
+ * supported.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_unpreserve_phys(phys_addr_t phys, size_t size)
+{
+	struct kho_mem_track *track = &kho_out.track;
+	unsigned long pfn = PHYS_PFN(phys);
+	unsigned long end_pfn = PHYS_PFN(phys + size);
+
+	if (kho_out.finalized)
+		return -EBUSY;
+
+	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
+		return -EINVAL;
+
+	__kho_unpreserve(track, pfn, end_pfn);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_phys);
+
 static int __kho_abort(void)
 {
 	int err = 0;
-- 
2.50.0.727.gbf7dc18ff4-goog


