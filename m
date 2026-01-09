Return-Path: <linux-fsdevel+bounces-73019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C11D0804E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 09:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92964304699F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 08:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9A43557FF;
	Fri,  9 Jan 2026 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxlU6kkY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5735505D;
	Fri,  9 Jan 2026 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949010; cv=none; b=IGD/qXYMJlD2GVPOg1o4tPPfKaC4wsjm2A3zm3npn8qh5TKDVyRPz1Ai9dKy351J1CNPdu98rh16LC3atR3MZo2mS/mVmoV9sHF8+RPBth3cmetJBMGwLNUQPwvts8D7VgPEMBOKUJR/0nzj9yLPp4jXchq5Mu+zcNlAs26r3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949010; c=relaxed/simple;
	bh=C/wgMdLsD2tb2QyXAAXoSur5L4DO3Kxja0XkyIF7z5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1l8iO4TIRchv/6B6VWhWF5qAoRKA5lhsvsHWyxKPUw+tfMMjo3HDy9nIwgq0nHvaP7FO3ayVkdvLMCmA41VnJWIlzgA9/a2iVHe9m62/V6Gota4OvtZrRnCIogFwh8jXX418X4LycmOSEx3dWjO9fncST98oL7IUw1rwRQKUmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxlU6kkY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767949003; x=1799485003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C/wgMdLsD2tb2QyXAAXoSur5L4DO3Kxja0XkyIF7z5I=;
  b=YxlU6kkYoNdb/HjhWY5Iktf/ryC5C9ynOEqyWFn5CPSATJejchSdMlMl
   CYMEzrEpEFFJRZm4ESzcfYWukGUzyWLScteTRfOd3MhK1MRxsqrO0OsnQ
   F2R1Sxlr+1MOq7yCu/ADLSDZxfLmnubYsnxFkg2nmfvNCHZQoq7cFjl8d
   lwX0kTHEW2KocnCnX/YYC+BDYaxAErhIG94xAeJ/zPFL6CBOyrXGFXNl/
   YwM/3QZy0Q+fz3/5GbJspLiQyXiWxvTV42Ba+XcDqtu+ixZPj8mKiw2l6
   uaONXzrTS9fdN0yJY+d6wtPv4iWINWIR9Jjl8FO3nnuTXs6cBqra7ofZV
   g==;
X-CSE-ConnectionGUID: bdYBbS7fThGF/1TOkqo0BQ==
X-CSE-MsgGUID: +s0BPXz5RKidqDbri6LW0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="79625982"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="79625982"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 00:56:37 -0800
X-CSE-ConnectionGUID: 8PUErSNTSXWuxfOhJ4T+jw==
X-CSE-MsgGUID: Y+RkkjyNTbKjIVGeE7szXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="202538604"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fdugast-desk.intel.com) ([10.245.244.83])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 00:56:34 -0800
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Matthew Brost <matthew.brost@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alistair Popple <apopple@nvidia.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v3 2/7] fs/dax: Use folio_split_unref helper
Date: Fri,  9 Jan 2026 09:54:22 +0100
Message-ID: <20260109085605.443316-3-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109085605.443316-1-francois.dugast@intel.com>
References: <20260109085605.443316-1-francois.dugast@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

Use folio_split_unref helper to split a folio into individual upon final
put of a fsdax page.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: nvdimm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Suggested-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Francois Dugast <francois.dugast@intel.com>
---
 fs/dax.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 289e6254aa30..90ec68785f40 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -381,7 +381,6 @@ static void dax_folio_make_shared(struct folio *folio)
 static inline unsigned long dax_folio_put(struct folio *folio)
 {
 	unsigned long ref;
-	int order, i;
 
 	if (!dax_folio_is_shared(folio))
 		ref = 0;
@@ -391,29 +390,7 @@ static inline unsigned long dax_folio_put(struct folio *folio)
 	if (ref)
 		return ref;
 
-	folio->mapping = NULL;
-	order = folio_order(folio);
-	if (!order)
-		return 0;
-	folio_reset_order(folio);
-
-	for (i = 0; i < (1UL << order); i++) {
-		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
-		struct page *page = folio_page(folio, i);
-		struct folio *new_folio = (struct folio *)page;
-
-		ClearPageHead(page);
-		clear_compound_head(page);
-
-		new_folio->mapping = NULL;
-		/*
-		 * Reset pgmap which was over-written by
-		 * prep_compound_page().
-		 */
-		new_folio->pgmap = pgmap;
-		new_folio->share = 0;
-		WARN_ON_ONCE(folio_ref_count(new_folio));
-	}
+	folio_split_unref(folio);
 
 	return ref;
 }
-- 
2.43.0


