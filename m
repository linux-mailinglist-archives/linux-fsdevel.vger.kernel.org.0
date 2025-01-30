Return-Path: <linux-fsdevel+bounces-40368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6CA22B21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 11:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5988A3A7ABB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 10:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080B91BD9CD;
	Thu, 30 Jan 2025 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5O74LWe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BEF1B85F6;
	Thu, 30 Jan 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231276; cv=none; b=Q/hLBYJe0oO9yqWId980z57M+Ix+sXVQo1ISKiCUUQ1bi+xa1qwLJ4vmOrGEDSTqWbFxXHABiY4RkOsvtkWkmj425nFr027R31C/LJKdRcrmRJhZst1kblszszF5+WiEWrXzRT6y9zZHeu9sA7xDhMMgyKy2rvAO8APUtFzYJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231276; c=relaxed/simple;
	bh=TeTRrafXWXo8OYB1YltM6X/TOJfCtsW9VeKHwtoHqu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3MZfaZRrsFS5bQnJWiKRa4mNQ+yllybmGVNmoeXf4nWeI+/NqRJgQTK9U9QomTjxMeDf7rFD5tKJ6TVRQa+HwMfZZ+D5iObLJGtz0is0mC2R4B2BD9DIGxaJdvwnGGjkObcZVHsifdpGT9r/Oe9LYtiqSSIV9UI38PohtKKz24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5O74LWe; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738231275; x=1769767275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TeTRrafXWXo8OYB1YltM6X/TOJfCtsW9VeKHwtoHqu0=;
  b=H5O74LWeV2pMjcAeBrfHshism7dkWnEIf7nYnYrUjn10bIQFTtbIPQp6
   nEp1121TKnEpgjnKHqkLb0navkFtjTCpFnUpLeK4DBDdjtoZG4q5gXsV2
   Oog4T1P8LoKABS/1wD97X5b2DvScLUyCFVGLatPq29EBhMGmL2O4LBXBI
   ak5I26wruq4wdbIilEaH19tW/lrNYnwWL2sy5vrCAoGFsdtbAl0zhI5Kx
   tadmagtV6rUySCUfwZA/MlKdWrQdSkuBSA/L0Di9J1QNtdCAq679vGvM8
   B0g97x5n0mG2ii41Q0N5etKPTQF+RV+jY5XzDZkAH6zAWxVe4HxrGKwnD
   w==;
X-CSE-ConnectionGUID: 9Fqned7kTr+6bFVj7FXFzg==
X-CSE-MsgGUID: YXDySL1eQOWh3fQqsdcUEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="61239629"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="61239629"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 02:01:12 -0800
X-CSE-ConnectionGUID: 06AmdIhLRoWLXSGTQo0ftQ==
X-CSE-MsgGUID: VHYjk4kqSbWJHv+236BOBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110191864"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 30 Jan 2025 02:01:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BBDB1111; Thu, 30 Jan 2025 12:01:01 +0200 (EET)
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
Subject: [PATCHv3 03/11] drm/i915/gem: Use PG_dropbehind instead of PG_reclaim
Date: Thu, 30 Jan 2025 12:00:41 +0200
Message-ID: <20250130100050.1868208-4-kirill.shutemov@linux.intel.com>
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
2.47.2


