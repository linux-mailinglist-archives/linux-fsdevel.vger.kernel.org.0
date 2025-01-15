Return-Path: <linux-fsdevel+bounces-39242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED54A11DFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FABE3A7F41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC711E7C31;
	Wed, 15 Jan 2025 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEISfs1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BA248177;
	Wed, 15 Jan 2025 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933514; cv=none; b=jXzxun2eOzDAX7fBSbsWmVAKFCEoxdGsOD4PzvW155vL3OdhVy3Z+T2kmGxrFH2IveU5bjV7zKWc1DhV1NO+dbesZ161daJzqfxCRW3Ass9BRCMrVBAg+tRHA+H3w6xQegvXT+q++8f6YAZq+Q/vTaWcFYwTI9B8/pb9K80SEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933514; c=relaxed/simple;
	bh=nRzbgXuQyXrlvnkDG9Mh1SQu4X/gBOf94amjJ8YtZCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFbrR3LJP2lhnYA9r4W8ZNThlSKiEtEeEQn/LBxa36snb7p1hyJVBDurNpBHl5/EA80xjhwI5G8LFe39RlsZnSI/Lyy37lXo+480nnV6N+o/IpbSE5XJc0c55C1fpbFzCaAAZS1Fv3TPbx7Te3udsdq+4ABl8SlN4Yz+xV4OZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEISfs1e; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736933512; x=1768469512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nRzbgXuQyXrlvnkDG9Mh1SQu4X/gBOf94amjJ8YtZCI=;
  b=NEISfs1e/kmVZBxnrEjgyFwltVUU8iDGifsbg8UykE2J1le/Whe+fSso
   spAE0/5PqmrNYug61rKnMaLkq7Z0of83BWpgKyilQcI0aAUZFBntxCApc
   Z1fwZMlQBg5h+7RD07AbhlB1JoFedsoqTC8JIZiSR/+mXWkTmr3JY1GE8
   zx6AwhvQygcZa+KhrkxGy+ZBWqkLrRVQIJuAZbtMSgxQkgB2LWn8G1veL
   5sWP1UYtdPX2DGxEDuO8ljSAB2XQUUEodmmzvs3akOp+W/7KHSHnhlfcX
   fXH3H4EzLn943NuNUpYkHJqFq0FJsOT7yV4MQvWakoxenwW6GV6SYSav8
   A==;
X-CSE-ConnectionGUID: DO9TP4DdS2SZxA2n/RmrSw==
X-CSE-MsgGUID: wJusA8VKRoCPB6j689HwCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="41195003"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="41195003"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 01:31:51 -0800
X-CSE-ConnectionGUID: AIiWRNDGRCO+nTKGleEiUw==
X-CSE-MsgGUID: ICetDwloSsuj4G/eQ0fcsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109700828"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 15 Jan 2025 01:31:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4A033478; Wed, 15 Jan 2025 11:31:42 +0200 (EET)
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
Subject: [PATCHv2 02/11] drm/i915/gem: Convert __shmem_writeback() to folios
Date: Wed, 15 Jan 2025 11:31:26 +0200
Message-ID: <20250115093135.3288234-3-kirill.shutemov@linux.intel.com>
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

Use folios instead of pages.

This is preparation for removing PG_reclaim.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index fe69f2c8527d..9016832b20fc 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -320,25 +320,25 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
 
 	/* Begin writeback on each dirty page */
 	for (i = 0; i < size >> PAGE_SHIFT; i++) {
-		struct page *page;
+		struct folio *folio;
 
-		page = find_lock_page(mapping, i);
-		if (!page)
+		folio = filemap_lock_folio(mapping, i);
+		if (!folio)
 			continue;
 
-		if (!page_mapped(page) && clear_page_dirty_for_io(page)) {
+		if (!folio_mapped(folio) && folio_clear_dirty_for_io(folio)) {
 			int ret;
 
-			SetPageReclaim(page);
-			ret = mapping->a_ops->writepage(page, &wbc);
+			folio_set_reclaim(folio);
+			ret = mapping->a_ops->writepage(&folio->page, &wbc);
 			if (!PageWriteback(page))
-				ClearPageReclaim(page);
+				folio_clear_reclaim(folio);
 			if (!ret)
 				goto put;
 		}
-		unlock_page(page);
+		folio_unlock(folio);
 put:
-		put_page(page);
+		folio_put(folio);
 	}
 }
 
-- 
2.45.2


