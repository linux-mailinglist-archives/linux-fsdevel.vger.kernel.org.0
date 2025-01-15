Return-Path: <linux-fsdevel+bounces-39246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBA1A11DF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03FB1625ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA1E236EBA;
	Wed, 15 Jan 2025 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hgt++E6h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E511E7C2D;
	Wed, 15 Jan 2025 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933516; cv=none; b=LXupqfHCPbh2qRcOPshU1vmHOEXxHApcpFk5iJSB/AwDf1zB7BhqdjgLmMml3tZNbVc3u0zvW0bbkPIGnXR8QCYssWeeQ1Pfry/Oi3RBjv4mEJEqu2YcPFw1DJOXMikL4wAnpctiuL4i4n7eB4J3N0G4mH6zhlalCPC1iGsIOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933516; c=relaxed/simple;
	bh=cZw61RFJNpfhkjnCxIsm2dDafA4jFfM7q4hFg1D+Ye4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBrky6utBMLV74Y7u8jjPTCquGNGotNfmC4FNJEDYyGDzRzX17vnGNz65Xecn5UQG51ueE4n9bMrgs25OR027b+8T4xmDvj231tuzUq1Izt1/WeW7HhiaMSJ3uCC7hHUbjA5Jak4oOH9h+XWgUQ33q2jepxEsRxp+6qyNCm1kPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hgt++E6h; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736933514; x=1768469514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cZw61RFJNpfhkjnCxIsm2dDafA4jFfM7q4hFg1D+Ye4=;
  b=Hgt++E6h9/kH3wlfM01FCrydVG6Z+35pI8RBmfzZYq9tK/a9ygtre/3f
   lA1/Xh73y+/yK+ahaNaVPnMNTNaJ5jSXIW+4JsmtdhBB9nno+aPBOoAXE
   z3rq3iv19NVSpFbEgZPLy85Nvx8yAtNWeaKj2IeLW1TeFE+uRE6zt5ZRm
   RkEqPShrKxX7lFJliqf2PSKARcaVMATNlwckdKEhNGkx4ky9rPYN14NZj
   XnaR7s0zIacb6PSkXfcsHd2L4v8ZlemzuzNCVD/FE45EPtfmAl+YitjwM
   vfLsc5c4ZBi8eutqEEVjJpzgzI5c2AtE74bSodLok/zOuYZi60DB7wS4G
   g==;
X-CSE-ConnectionGUID: BQNw/B7ZQm2OZKTf5hUxsw==
X-CSE-MsgGUID: 2eXkuoQGSzStVgIwrPYQgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="41195073"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="41195073"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 01:31:51 -0800
X-CSE-ConnectionGUID: BkISwSDCTmik0haa8kFKBg==
X-CSE-MsgGUID: xtPqCedzReW23mPvf81/rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109700833"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 15 Jan 2025 01:31:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 57ACF49D; Wed, 15 Jan 2025 11:31:42 +0200 (EET)
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
Subject: [PATCHv2 03/11] drm/i915/gem: Use PG_dropbehind instead of PG_reclaim
Date: Wed, 15 Jan 2025 11:31:27 +0200
Message-ID: <20250115093135.3288234-4-kirill.shutemov@linux.intel.com>
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

The recently introduced PG_dropbehind allows for freeing folios
immediately after writeback. Unlike PG_reclaim, it does not need vmscan
to be involved to get the folio freed.

Instead of using folio_set_reclaim(), use folio_set_dropbehind() in
__shmem_writeback()

It is safe to leave PG_dropbehind on the folio if, for some reason
(bug?), the folio is not in a writeback state after ->writepage().
In these cases, the kernel had to clear PG_reclaim as it shared a page
flag bit with PG_readahead.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 9016832b20fc..c1724847c001 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -329,10 +329,8 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
 		if (!folio_mapped(folio) && folio_clear_dirty_for_io(folio)) {
 			int ret;
 
-			folio_set_reclaim(folio);
+			folio_set_dropbehind(folio);
 			ret = mapping->a_ops->writepage(&folio->page, &wbc);
-			if (!PageWriteback(page))
-				folio_clear_reclaim(folio);
 			if (!ret)
 				goto put;
 		}
-- 
2.45.2


