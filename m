Return-Path: <linux-fsdevel+bounces-69494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9666C7D918
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDA1D34F11F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79942E0412;
	Sat, 22 Nov 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HScPZ3NE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C832DEA73
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850263; cv=none; b=RDtH1xLYnzUbSdfenrLSG6jEUpftqeigJyvAbC5PD7rQUFxLmU9GcRo1Cn1muVONdevqNXe1XhNnCDahZX/8OHphqvdEIVWqzwugdCJAeVaJ9DhCID72JE/x2iLOtMyIBymI9vdMoB8UhpOp7kLMINb7eUL7L05RXDd2jH8iGuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850263; c=relaxed/simple;
	bh=cV6ayUY0cd5cthn+5O2DyMdENfG+D5eByWYgHRliMyA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouyk8yHUGoboXSsNvRsuojieNM/QAQnCG6gdIaoLAzYPb+aSUfFsLSWJuobxpF6ieNVPld8QFrquRIRukwMdHpmlXJzee6MYY/RCqz6gaCihnsCPy0GGV/rEeuZfmDM0KldltFMLei61q062i0L30U21EbnZarA7ImrJxqfcLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=HScPZ3NE; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7866bca6765so27781807b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850261; x=1764455061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+3x59DbFWdBPdmdih5ENuDC3ZjNMKrWdUeGoJeNo7E=;
        b=HScPZ3NEKZwt7blLAousjMuqCBILyYAhjd7MiMhHJgDzj1HcFn/1KoEHw8jqBuPHYY
         Bl0XBqTl6iLCVqc7OQZoFuAR9O3rUa8aIhWzSR7Gxd/3k4SmnbvChslsJZrwXV92YnRX
         OxKY33rox5nPfmVMvDhstWwTW7SK8BpGAOzaWThOctNUDRl+0a9rQwL+ZO3EO8ABfZyl
         EbAgutSOFlvto3g7icuAEdFEs6d3f4Aralf7CZHf2a2qB2FpxsVC1uQpDGZ47qHiaOtS
         Khz3ogqv+mHOAQUPQe+bInIjdoPl8bIaO/kADbyRcU0giU+CxqbH39NbEDbAO7ZgNBry
         yyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850261; x=1764455061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+3x59DbFWdBPdmdih5ENuDC3ZjNMKrWdUeGoJeNo7E=;
        b=Un7PU4f+x6TDOz8OKuD0rJtN/ltegQyWl9fKLr7is8DTcrC8focLRWh9mFr1wJiMFi
         bdM5CgXVU4Cztk0MVLvadBwMRMU2bzpQyF/RORsBdElKh0zq6GgrtxcR2od9GYJzkHD0
         PHmYuZ1hWWKhJbxxWaiHGrZgxXq/xG8dIG3n7zLNAtpoWia0pYtWBagFKBp2q4avxJhK
         N3cbua2QJbajzEcIjwz4UTGpI5/qze0Q4jEajBVwqThQvWRi5CFsSSH/K6GKdQ+SfgjZ
         5uNgbUBeFScuIIHJFv3CEVxYvG8mHE6ltyDxRY4ThCIqjyrPOtNOVJOvvdPcK3cEqeXf
         mu3g==
X-Forwarded-Encrypted: i=1; AJvYcCWJe2tk4AAxN5v/W6zQQFuHvCCl9ess5qc6hg/omYeRGRy+Ik5V7FrG/JPnZBWdYa9gYjJQaPveIsc3f/v+@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEwC5Aw5TIOlIheeQrwTMPkeJfPeU4xvpnDUzEYZ3cSK2ae4/
	kgNC7PLxr7p+uAoHnw3x8ACxlbDFQiy8d7i30uTGU/CQMQd9eQbohEGH9AZOSTdtmbE=
X-Gm-Gg: ASbGnctpVJKGVCgYiztR6+e2ShdAznIz1vPGRM2BdGSf4pMfMxtSRMsynKoyS1/DLLY
	OhSo/opcWEJLGKKGnk5CAAGfm4HORVrh/KRLoPeFW8Jc7/rBxhu2L0ANWMrTBbkweKIugXpEIFQ
	QYKhdZyh4QXTTwo5LDV86ol44It6Gs0ayhSXnN0uKZuhOeFrznPFfc98ICE1aJFAaYbhIRiXRHw
	HEw3GznV5PJ8BA92h9fQJUrOUHkBOk0wXDqf/qNFMzsFXBAVEN9VoORAm+DXFQRNBPU6uDu8ku5
	OrSB+oRRrqGZFDVxZpGRzMvoUtWFCQByGMymIpKBseLgyDFqObr/jzYfE0rE9j2LRqYrMgEx0z5
	HilAaopC27Gi5cDKYU9T/MDp+44d1dtIoG0r37il69UDIpRiUyclVEMFh3lu1jXsACmxLvSKJZx
	ariKzop3IPstTVrqxKC5qlO4wy/lw+rlRGYCZ0elN2+IVKg1LiA1We3Pv1YkrDS/XlZV01T+nEY
	Xu1kZ8=
X-Google-Smtp-Source: AGHT+IHLBVEUSrsRTAR569f2nmbBoHdToiAZD4CXjMMgQTOgrYNyCyqBuS6WcJxB+UmOJcCfJHKxnQ==
X-Received: by 2002:a53:acd3:0:10b0:63f:55de:63cc with SMTP id 956f58d0204a3-64302ab185bmr3797706d50.31.1763850260775;
        Sat, 22 Nov 2025 14:24:20 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:20 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
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
	chrisl@kernel.org
Subject: [PATCH v7 12/22] mm: shmem: export some functions to internal.h
Date: Sat, 22 Nov 2025 17:23:39 -0500
Message-ID: <20251122222351.1059049-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
In-Reply-To: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

shmem_inode_acct_blocks(), shmem_recalc_inode(), and
shmem_add_to_page_cache() are used by shmem_alloc_and_add_folio(). This
functionality will be used by memfd LUO integration.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/internal.h |  6 ++++++
 mm/shmem.c    | 10 +++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1561fc2ff5b8..4ba155524f80 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1562,6 +1562,12 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid);
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
+int shmem_add_to_page_cache(struct folio *folio,
+			    struct address_space *mapping,
+			    pgoff_t index, void *expected, gfp_t gfp);
+int shmem_inode_acct_blocks(struct inode *inode, long pages);
+bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped);
+
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
 			struct shrinker *shrinker, const char *fmt, va_list ap)
diff --git a/mm/shmem.c b/mm/shmem.c
index cb74a5d202ac..b9cd7f8d50fa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -219,7 +219,7 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
 		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
 }
 
-static int shmem_inode_acct_blocks(struct inode *inode, long pages)
+int shmem_inode_acct_blocks(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
@@ -435,7 +435,7 @@ static void shmem_free_inode(struct super_block *sb, size_t freed_ispace)
  *
  * Return: true if swapped was incremented from 0, for shmem_writeout().
  */
-static bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
+bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	bool first_swapped = false;
@@ -861,9 +861,9 @@ static void shmem_update_stats(struct folio *folio, int nr_pages)
 /*
  * Somewhat like filemap_add_folio, but error if expected item has gone.
  */
-static int shmem_add_to_page_cache(struct folio *folio,
-				   struct address_space *mapping,
-				   pgoff_t index, void *expected, gfp_t gfp)
+int shmem_add_to_page_cache(struct folio *folio,
+			    struct address_space *mapping,
+			    pgoff_t index, void *expected, gfp_t gfp)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
 	unsigned long nr = folio_nr_pages(folio);
-- 
2.52.0.rc2.455.g230fcf2819-goog


