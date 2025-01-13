Return-Path: <linux-fsdevel+bounces-39017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B42BA0B34A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 10:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAA41653D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955FC2500BF;
	Mon, 13 Jan 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRPp32qI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389B246324;
	Mon, 13 Jan 2025 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760919; cv=none; b=rs9X97yPWtCp/J0aqYjiS85kO67D4iVydOPrriizZHHlKFqooWQ5XRlWuOtUl8pGd3t/cAHxY2GwV+F6e93CT2mMx6MbC4jYcXl/6AR35pJyqsBc3SXqQZkqhTWLDX0QdW/iXz1PcxDaGPp6hwWaOVbTMYfY+7ioxYMvP1iDpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760919; c=relaxed/simple;
	bh=mOqTZnsJFHy5ou7lSIFde6JkX4W4gvXlxc9Z4IG9Td4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qq29dvPj5USRO9bu4FcdMOF5Rk6+OnEGSSMmOyZwJNcrftB+kl3syrtT4EYeWITJu0jJhM7qlRWb7YIzryW041+pgyWMTTihSbirS1TXI49t2Dtob/k26VnHf6gCO+CqvOm/UPQyeAdBf9bxS98oGm4yt0dyapWdwbV5MGn21/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRPp32qI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736760917; x=1768296917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mOqTZnsJFHy5ou7lSIFde6JkX4W4gvXlxc9Z4IG9Td4=;
  b=XRPp32qIUNCKaFEyu9j/yw991jFgVuyktCdqakyf3Ja0USvvLiFcaNCn
   IQaatX3mhD9n5W30Eb65c9EHMLHowilNLkkHoXlZ2G/oKVvDudtQjoaJP
   ueXLkLUMAOvQmqyswAif8lUyNwR3BOneXxFCRR5RHo7cUqA4dVD9vppY/
   iWz24tuflhMJJQA63YCMfi70DbHJtshlGuTmeVssHyJbhoK4ZxSaolPoE
   3zOEOOW+J3haTXEwekwl3JOotsokDbhwFgTTliv8YiEMttEu4+pOxFFRS
   bgStbu9bGPRoaIeRQYN0E1p3tQOB3vgY+k1jyrnR48GsRWWWZg1NWza3+
   A==;
X-CSE-ConnectionGUID: hoJfx3b7S66UrumG5hpS6Q==
X-CSE-MsgGUID: CmHWKdaIQ+Wiws2dmxhTOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40949038"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40949038"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 01:35:14 -0800
X-CSE-ConnectionGUID: U5vIgKBbRveYB8YmwbxHAQ==
X-CSE-MsgGUID: sUGRVgo8QlCupflC1Poz0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104303073"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 13 Jan 2025 01:35:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 139A940B; Mon, 13 Jan 2025 11:35:04 +0200 (EET)
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
Subject: [PATCH 2/8] drm/i915/gem: Use PG_dropbehind instead of PG_reclaim
Date: Mon, 13 Jan 2025 11:34:47 +0200
Message-ID: <20250113093453.1932083-3-kirill.shutemov@linux.intel.com>
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


