Return-Path: <linux-fsdevel+bounces-39251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A131A11E13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027463AB328
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D54B242253;
	Wed, 15 Jan 2025 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQMTQ7qi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C662416B2;
	Wed, 15 Jan 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933525; cv=none; b=adOtVoVqsbzy2NBs22aZ8YsmbQygMMME8ggTLIIzXDw4TRubq5HliQH32M53fp2NZ6UyYx8knq38RhltZ3Mp55HKmlhgh2Fg05Bd/mGnLSH33GF5dcV8YMLrLzrNFioUGGnr7syfyxgGtGyJ5RabEEh3c90vzP/G5L8aPjXZ4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933525; c=relaxed/simple;
	bh=9vbzxe10nrH/pHYnBj/bfEL4jLmf+9HKx83uuAIPxtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjxUQm2ATiLMrO2lcERNiQIWCL7sahITe3Sg9qfy0cH5PLh6Pjwgg0YNbEXhSZgdd3J5mITLJk+8ztrMUK9e/pGoBIp9uN4gFQajt7t3IfkGsY8RaEBaO3gl2Bu3yYL3Fr+wNStW7QwOUol6IzP8NJ1Qt7P2Ljod+9FTfcjp/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQMTQ7qi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736933524; x=1768469524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9vbzxe10nrH/pHYnBj/bfEL4jLmf+9HKx83uuAIPxtQ=;
  b=XQMTQ7qim483Kz088DgHyPZCh/panAubb61iOXDXMWRFU/YpekxRRNm6
   HZyQnfTh65wFNIEfojyM/Wadgv9OLLS7Xv8Yici25v9CIDUcOu44NQD20
   Fi96LOMPU6Wp15YeX3XN8ywp4jOWCoWUcs4lHV5kIGzdUqoBqi/XYstzA
   XAyLJyGU5Ftom9xQ0rm1LFJYfbfN5VkItrDIIX3TwNwa02EVLlk/hVXh3
   vAj8BdAs9pL7HHPXYfv4LbPK9psjQtFHIlCj279i71eVmNi332PfOrY5R
   kWME2RVAr1A3Y8lFZUBueQsmhcPQh9+DGoHoBZCPTdE2/I4iL4DXG2H6R
   Q==;
X-CSE-ConnectionGUID: MSX0bq1ZS9ias2hMrj4VpQ==
X-CSE-MsgGUID: c9utA+d9To22zQ+IGiny1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36540299"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="36540299"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 01:32:01 -0800
X-CSE-ConnectionGUID: p3NKY2bRSTOG1/Tde53fKw==
X-CSE-MsgGUID: uqQL2m/wTq227tGiusyjyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="105153456"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 15 Jan 2025 01:31:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A0EE2712; Wed, 15 Jan 2025 11:31:42 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Airlie <airlied@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Hao Ge <gehao@kylinos.cn>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Nhat Pham <nphamcs@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosryahmed@google.com>,
	Yu Zhao <yuzhao@google.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 08/11] mm/mglru: Check PG_dropbehind instead of PG_reclaim in lru_gen_folio_seq()
Date: Wed, 15 Jan 2025 11:31:32 +0200
Message-ID: <20250115093135.3288234-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com>
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel sets PG_dropcache instead of PG_reclaim everywhere. Check
PG_dropcache in lru_gen_folio_seq().

No need to check for dirty and writeback as there's no conflict with
PG_readahead anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_inline.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f9157a0c42a5..f353d3c610ac 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -241,8 +241,7 @@ static inline unsigned long lru_gen_folio_seq(struct lruvec *lruvec, struct foli
 	else if (reclaiming)
 		gen = MAX_NR_GENS;
 	else if ((!folio_is_file_lru(folio) && !folio_test_swapcache(folio)) ||
-		 (folio_test_reclaim(folio) &&
-		  (folio_test_dirty(folio) || folio_test_writeback(folio))))
+		 folio_test_dropbehind(folio))
 		gen = MIN_NR_GENS;
 	else
 		gen = MAX_NR_GENS - folio_test_workingset(folio);
-- 
2.45.2


