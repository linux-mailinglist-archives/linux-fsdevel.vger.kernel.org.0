Return-Path: <linux-fsdevel+bounces-62961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D03FBA7AB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765947ABD4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DC020F08C;
	Mon, 29 Sep 2025 01:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HFMXSoS4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B11F12E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107820; cv=none; b=BW+Ol65ZzdVArpE5gX+1D+OY141Nq2+uGbEEn5BWbsjCR7DyA6I1otYGbHUKVnaNy9RpwxOZmSNSpBWNOoKwowotJC2tWwTs4nuYnlKk7d7njoUlHbFTh6YApyQxFJF6QJrNaVrTH8tzn9bsRO3tS2sjCHbRUhlUeGRQZ2oVv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107820; c=relaxed/simple;
	bh=Y/Ivo5zgLtU+RH6gb+3c1+9ZNDdvFIGCYZipUGkL+4w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcm8ew7+GK1eNkbmwOjezleUDnXqh7qbwzCvChh6j0vzwVwfdYuIftWYKsMVPxCrokd4T7ZzpkO7ihXqpyfig4zS2+iW/Z7G8kxKBM60CxIzKsI8LdpC2tA/jZZAa4TUp9YTUuCkal72CUYxg9AO/bMt11trwTkSpIJaFpOzkTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=HFMXSoS4; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8275237837fso467973585a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107817; x=1759712617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezlL3LcjIf2ht7RpS8bynkMbzZtMKTbogv0OCRBHCJM=;
        b=HFMXSoS4PQuaDTMFFqb7ZmjXNAegr54JYRE+RyQYVFaQ/yuGeomYzk10Iq6SDbWjI7
         goGuisDvG07tJdh38tIEAnc1gRzEwSRJLEtOHwgtSDu3y51QMp18kGAmjGVWJCR0h5NW
         3/umAhto3EsVdZjEUtW2rM+X1rt5Ivxrk2+ZB7OypK+OtRDGzgNzPbpXh5/k0UCOehWA
         u/yMslRAx3pVNLrfCVoEATFhEGV9JGqVR+j3xcFZrerfe7xyKdc6z3ZkKzxncAiXE30i
         zmD4Q5yqJ8Zhtz2bsVE9sB3v20j8kc0nKJMrPXN8z4fU6gavDpqpjKsofaP75834L7t5
         gO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107817; x=1759712617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezlL3LcjIf2ht7RpS8bynkMbzZtMKTbogv0OCRBHCJM=;
        b=ooegfMJNVO+AakALG8lA+NN2jYZOz2hSUSLEApqqmA1y3RavYWNFg2DcobVRHlCT43
         iecNPWBcvChTaooGeDttZPJ4e+d8eGDzwzbvoRTetzxk8fIbcRAKHfqMfxeqyjMcyJO6
         CTwZju6E2jb6RRov/AJXlZfOLUkMUAfD4EDowPUCkTGxYo4iOSf+3Z6go+xcexnuwVkH
         aDUrD9aWDkOEzdB+SA5hGL6ouCbwDepJNptLcQPIL4poAZFYBuZN8K5MnPke6qohP4l7
         ZNBYu954KqjBk39t3pfQYdUKiNa5NzjQoghNtqI1BHk/ZU+LOd6Rk+U4hfJlAoVFyWaI
         nBnA==
X-Forwarded-Encrypted: i=1; AJvYcCWYby1hQ8OAZmx+dnjtDoZtICv+q9lcXsRZCDDBCnBtYmyPCXMzhYorHyPCcZ7t+epVa5pbbkAIIWg9Inw6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8SN//pa5Zz9m+iyP5fYRMLoyOEM2Fk0djr98Kx63hR4fdDLqo
	ej2fTN8Suz11Px9hWzV27E0/EtvgVMIqFq1vbbHVnlKw9qqxnTkuOc/GBL92j9V7JFA=
X-Gm-Gg: ASbGncv1KZsqQ9twB5wc/GBrSZ19MX+PALzMf5paR1ejNxk1raSxZ3uFfcG3VmaGs1D
	ROoDb+nl80hKFEB5s9t0fPm54xoi71GXjgkZEvq6fXF5KWQR/aG4DJe2oH/OJqsYxZQHwAxZiY3
	wnVxfs9gsSmMN8A4ZePgsOyJGbHDOCf6eaxRBRpF+vEN9+Vs43i/KEnqJXtn02pT64u2j7TiOz2
	IywdBSH0DBleLV7WT83ycBLNrWNhzDhti5FoPPpHX+SotsLdgyWUaZhsfnQ+XHcyygCIi3rCf/j
	zRjZFsDoUp+IXoIhKulK1oMPT0Lry6bsPg4m9L/K72o2Dm4tbMVhDpMOCLEibEFv03tQPVxAijp
	20AUCvw2vXBYifl6xmlJ5/vw+akV/Yk7e/9Z7MUItaIH1QtjUwBRzUylcLNm8id0h87BpnnsVHT
	AeCGlY1Vm7Xlo+I6RetqsS7rY5CbNV
X-Google-Smtp-Source: AGHT+IHaETUM84OTpHheMB0hdUMDHvd/ZJx9O8NiNJ3bWGiu/zS0OpwUNUxS2hk0EnKZS1qySrlkgw==
X-Received: by 2002:a05:620a:f0c:b0:855:cfe0:b6eb with SMTP id af79cd13be357-85ae9c6d420mr1897035985a.75.1759107817220;
        Sun, 28 Sep 2025 18:03:37 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:03:36 -0700 (PDT)
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
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 04/30] kho: add interfaces to unpreserve folios and page ranes
Date: Mon, 29 Sep 2025 01:02:55 +0000
Message-ID: <20250929010321.3462457-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow users of KHO to cancel the previous preservation by adding the
necessary interfaces to unpreserve folio and pages.

Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kexec_handover.h | 12 +++++
 kernel/kexec_handover.c        | 85 ++++++++++++++++++++++++++++------
 2 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 2faf290803ce..4ba145713838 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -43,7 +43,9 @@ bool kho_is_enabled(void);
 bool is_kho_boot(void);
 
 int kho_preserve_folio(struct folio *folio);
+int kho_unpreserve_folio(struct folio *folio);
 int kho_preserve_pages(struct page *page, unsigned int nr_pages);
+int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
 int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
 struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
@@ -76,11 +78,21 @@ static inline int kho_preserve_folio(struct folio *folio)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_folio(struct folio *folio)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int kho_preserve_vmalloc(void *ptr,
 				       struct kho_vmalloc *preservation)
 {
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index e0dc0ed565ef..26e035eb1314 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -153,26 +153,33 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
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
+
+	bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
+	if (!bits)
+		return;
 
-		physxa = xa_load(&track->orders, order);
-		if (!physxa)
-			continue;
+	clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+}
+
+static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
+			     unsigned long end_pfn)
+{
+	unsigned int order;
 
-		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
-		if (!bits)
-			continue;
+	while (pfn < end_pfn) {
+		order = min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
 
-		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+		__kho_unpreserve_order(track, pfn, order);
 
 		pfn += 1 << order;
 	}
@@ -734,6 +741,30 @@ int kho_preserve_folio(struct folio *folio)
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
  * kho_preserve_pages - preserve contiguous pages across kexec
  * @page: first page in the list.
@@ -773,6 +804,34 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_pages);
 
+/**
+ * kho_unpreserve_pages - unpreserve contiguous pages.
+ * @page: first page in the list.
+ * @nr_pages: number of pages.
+ *
+ * Instructs KHO to unpreserve @nr_pages contigious  pages starting from @page.
+ * This call must exactly match a granularity at which memory was originally
+ * preserved by kho_preserve_pages, call with the same @page and
+ * @nr_pages). Unpreserving arbitrary sub-ranges of larger preserved blocks is
+ * not supported.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
+{
+	struct kho_mem_track *track = &kho_out.track;
+	const unsigned long start_pfn = page_to_pfn(page);
+	const unsigned long end_pfn = start_pfn + nr_pages;
+
+	if (kho_out.finalized)
+		return -EBUSY;
+
+	__kho_unpreserve(track, start_pfn, end_pfn);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
+
 struct kho_vmalloc_hdr {
 	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
 };
-- 
2.51.0.536.g15c5d4f767-goog


