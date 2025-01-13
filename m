Return-Path: <linux-fsdevel+bounces-39013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D449A0B340
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 10:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1148169F0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 09:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CF82451F3;
	Mon, 13 Jan 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPNwuoTf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9523ED6A;
	Mon, 13 Jan 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760915; cv=none; b=XNVjueOw7NljiDaWUXl8uGMqcdyY1CVFdvcHftHKqjmWW2bGxrxGw1ceKjEwC3+y0n01smdTBADTG5WXhCwjNQ4mZSDQNUkh0BPPKwGBVyN4d68bLd79a74NRLBEPlfWDkJEAitzPOAFdQPTVa4oO9r9JrKwf5uXQ1K/a/A/6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760915; c=relaxed/simple;
	bh=KROqC9a9RBT0tRKvqTEojI0FO2hQo9eIFMH92Ay8miY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/jiXGgcsZ8MfXcGuhJ2s/zyLDYIwka9nhqDZN9SMXYSwzTYuvI0FTCR4BVoBZpKFGgM0R9A8kZ3qHSAxyaRpXkJu5XBPtPvJCe4BFkndg0TlFXonf4DcRMnVS4kumzJieQIeyZskm7FrZO41yb4aa9tEsUvnUn0LB68Gg3nC+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPNwuoTf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736760914; x=1768296914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KROqC9a9RBT0tRKvqTEojI0FO2hQo9eIFMH92Ay8miY=;
  b=cPNwuoTf78Eq3VUJYyp9+NGlFBOa3AWye/eURFw+y2B2d6DQqae3ICiC
   7ZY5bsvrjFKxfSiUanmOaERly8C7Yi7v7+/sDkjufI9TQdQuP+soJeK/f
   yzMgZXJ1wZsEBRZV8/lNvVThOjfVp3donSEJIc7g8JCYOw0KuyHrppBWp
   jPFzHH2A4dor9WmyTZLR0HNuV6X9qA+JvbMtvDSgWE6jWJu8CC5Ux1dgx
   mRDVmtop/zuOIo/5UqqNnqQztNyrS4L9wHx4hhFeBWP2hQ44SszHzH6mf
   2i+blXeEn/TA/RymNcPtynkKvN6dfLLYY2XeBysd70Jpl+mELS7oBQDCx
   w==;
X-CSE-ConnectionGUID: /CyT16yxSr682KiMRAYAWQ==
X-CSE-MsgGUID: LBAYi8NaS9aR0shScsHIFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40948930"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40948930"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:35:12 -0800
X-CSE-ConnectionGUID: hqmEiuR7TbCAMrvg4TzodQ==
X-CSE-MsgGUID: TTYeZiVeTT668CUnK8hRKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104586344"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 13 Jan 2025 01:35:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 05BF5329; Mon, 13 Jan 2025 11:35:03 +0200 (EET)
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
Subject: [PATCH 1/8] drm/i915/gem: Convert __shmem_writeback() to folios
Date: Mon, 13 Jan 2025 11:34:46 +0200
Message-ID: <20250113093453.1932083-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
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


