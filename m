Return-Path: <linux-fsdevel+bounces-40366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FA6A22B1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 11:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED592163573
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 10:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123A11B87E3;
	Thu, 30 Jan 2025 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtCybaXU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E754179BC;
	Thu, 30 Jan 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231274; cv=none; b=NjlmNNUexJCkXbiIQQp9m84OqUk1pTrdPRN2vzCVP0UKDsSZJ3Ajii3eqpbL9CP0zbisFUJkzwLj5G/0XfSrr4zT/vPZpqVNLEEKEGVimwYHKMw2FvfLhjpX5ayjKga4QrIOdNiDRIzcsgCcUjfcU0K4JYAsjI0poK4cDcJu+Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231274; c=relaxed/simple;
	bh=8pRNuIPrVfxTldXbqeV9RRpp7y6kXHtiTaNIrlWjic8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkrLml9uRmh4VAf/CLDI+5LkTwUL124fIcupq+7yok+tOv0KTVYyi6R9rtCz2Hkmj1Nugx1sHda0mB1B08Ii3y8R12Ib08SJMsmYlOE+JHaF2sZ6YiXi5VlICKrFg6vFDz/i6DNCa1Z2gBSCzgJIwCv62mmLg/UZ8/ns4n6pYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtCybaXU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738231273; x=1769767273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8pRNuIPrVfxTldXbqeV9RRpp7y6kXHtiTaNIrlWjic8=;
  b=KtCybaXUItNBJFne6ZqrpPQ0jITEgZmfNoyro+uGLyAlVnJqRfupR/8U
   KHv2Vpu014zJIX/Ez0vxmHr57Mkef3U6arAZAcdcN0UhWDkT0F49wBapa
   Wb2bliXzcMt8DibcjGgxcN04uBBv3b+d4074aOQvuT33qW9o/R2/od0aw
   LQKiClcQhIKWL1opi4z+gBOoKTXPVW8+8TyOua3t+dk+OBRhZ4R8yog9m
   7edVXDCgOUnHBY/4SM/k8z/gDD4GmMYNpVQ6ZWuDDL9QlRy49HJXTk9xs
   fgfGDSTp6FZQSvOaxBQGmPvXImcWkiTdzvqXXYArV2S176ehthL016Nla
   A==;
X-CSE-ConnectionGUID: DE+qLiYiSVyf1QRdhcoXkQ==
X-CSE-MsgGUID: zvLe9saFSOOuAs1QUZHOAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="61239559"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="61239559"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 02:01:11 -0800
X-CSE-ConnectionGUID: F29W/Q2yTvOf48Et3LHI8g==
X-CSE-MsgGUID: kabiex6lQQaaLPmeAbkFmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110191859"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 30 Jan 2025 02:01:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AA41E10A; Thu, 30 Jan 2025 12:01:01 +0200 (EET)
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
Subject: [PATCHv3 02/11] drm/i915/gem: Convert __shmem_writeback() to folios
Date: Thu, 30 Jan 2025 12:00:40 +0200
Message-ID: <20250130100050.1868208-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
References: <20250130100050.1868208-1-kirill.shutemov@linux.intel.com>
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
2.47.2


