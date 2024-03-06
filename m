Return-Path: <linux-fsdevel+bounces-13832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3C68743D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 00:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFD9282C62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 23:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E279C1CA96;
	Wed,  6 Mar 2024 23:24:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B381C6B9;
	Wed,  6 Mar 2024 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767450; cv=none; b=XYEeDpsOIHdkPE0I8WL7toXygOqjyTTpUFq2TBuCS4d81lo1XJU9fwdcZ2SiLfWeuz9s6oYHe9CUnSPIzsvuqFN5XrKUHjMBceE4LXjJNlMTufXYDcSunKjbcr2PT510LfJF+KYO/TOnV8sHl2JKpFe/ilcdaRA9u4GOs+IYqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767450; c=relaxed/simple;
	bh=X0M5iZYTK6pOspHFAkHz2qSRPYjwL7LKAHtHCJ9EVhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SjJ4MBo8dAsTjNB42JgdNF+ZMPg4lztRCtoliH1p+K1Pn41KY7y+K/PYo9nN8v3LS+/bZ+lEBTxUg1jrHUcOCO3IMXDDK0nkNCsJaHjvLWj+2N1VNR6mBKuPUHWWNp9fJXKOf6yE/Csw5JVnlzGZZ9SHs2SQtgFg6eilH14CUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E696C644CE7C;
	Thu,  7 Mar 2024 00:23:59 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id t9XzC3CxY69m; Thu,  7 Mar 2024 00:23:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5DD51644CE7D;
	Thu,  7 Mar 2024 00:23:59 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FnKr8zZbO6FE; Thu,  7 Mar 2024 00:23:59 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id C92FE644CE7B;
	Thu,  7 Mar 2024 00:23:58 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	upstream+pagemap@sigma-star.at,
	adobriyan@gmail.com,
	wangkefeng.wang@huawei.com,
	ryan.roberts@arm.com,
	hughd@google.com,
	peterx@redhat.com,
	david@redhat.com,
	avagin@google.com,
	lstoakes@gmail.com,
	vbabka@suse.cz,
	akpm@linux-foundation.org,
	usama.anjum@collabora.com,
	corbet@lwn.net,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] [RFC] proc: pagemap: Expose whether a PTE is writable
Date: Thu,  7 Mar 2024 00:23:38 +0100
Message-Id: <20240306232339.29659-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Is a PTE present and writable, bit 58 will be set.
This allows detecting CoW memory mappings and other mappings
where a write access will cause a page fault.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/proc/task_mmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3f78ebbb795f..7c7e0e954c02 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1341,6 +1341,7 @@ struct pagemapread {
 #define PM_SOFT_DIRTY		BIT_ULL(55)
 #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
 #define PM_UFFD_WP		BIT_ULL(57)
+#define PM_WRITE		BIT_ULL(58)
 #define PM_FILE			BIT_ULL(61)
 #define PM_SWAP			BIT_ULL(62)
 #define PM_PRESENT		BIT_ULL(63)
@@ -1417,6 +1418,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct =
pagemapread *pm,
 			flags |=3D PM_SOFT_DIRTY;
 		if (pte_uffd_wp(pte))
 			flags |=3D PM_UFFD_WP;
+		if (pte_write(pte))
+			flags |=3D PM_WRITE;
 	} else if (is_swap_pte(pte)) {
 		swp_entry_t entry;
 		if (pte_swp_soft_dirty(pte))
@@ -1483,6 +1486,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned =
long addr, unsigned long end,
 				flags |=3D PM_SOFT_DIRTY;
 			if (pmd_uffd_wp(pmd))
 				flags |=3D PM_UFFD_WP;
+			if (pmd_write(pmd))
+				flags |=3D PM_WRITE;
 			if (pm->show_pfn)
 				frame =3D pmd_pfn(pmd) +
 					((addr & ~PMD_MASK) >> PAGE_SHIFT);
@@ -1586,6 +1591,9 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsig=
ned long hmask,
 		if (huge_pte_uffd_wp(pte))
 			flags |=3D PM_UFFD_WP;
=20
+		if (pte_write(pte))
+			flags |=3D PM_WRITE;
+
 		flags |=3D PM_PRESENT;
 		if (pm->show_pfn)
 			frame =3D pte_pfn(pte) +
--=20
2.35.3


