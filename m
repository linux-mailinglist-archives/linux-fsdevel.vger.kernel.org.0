Return-Path: <linux-fsdevel+bounces-40367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B5BA22B1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 11:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8233A1A46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775601BC07A;
	Thu, 30 Jan 2025 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0bKsKrT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6CE1A9B32;
	Thu, 30 Jan 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231275; cv=none; b=kYpjeL6JD2uAsF08j1yRxjnXFsejPR2sBvQUk9yAtH/5poE/f/VJf4jIC9Du/FHV/SDW0h3BFsNCSZGuQgo3mY9fCewLXaCNxcGbk4qKYn7Vc4LlWx0i07aWi3yKbcTlrkxx1LO66lS1ujWKHt7XpZPa21+uiuOv95umLUsG4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231275; c=relaxed/simple;
	bh=Q/Nr0FCslCBPkatRSbZ2MtNH6BxbvkzrecnK5J+1uq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBVTj9pVVEYq1dvhaGFo1Jhpov+31YebyTk4mZNuWD8PQBlfzNnVA6OF3L3O9dJQ+fkXU+86XoTLmw+HMOj0HBjl93ZeztnciP1HlBMMQcR3FR+AQ2RBK1l9w3x6L59tzztruXcPGCsAwNu9TzIHm7NUFm643Q9aKz1a/LxeayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0bKsKrT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738231275; x=1769767275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q/Nr0FCslCBPkatRSbZ2MtNH6BxbvkzrecnK5J+1uq0=;
  b=g0bKsKrT+z6iUpyPJbRDO2B38WAR72RQmEEYIlp7aH+AOjYxRhH80Cr+
   JyL3EWEgxX5jzYV344POt+CCnTst8+IsR4zgqUcDoGGcN/+tyovw/z3Mb
   59sKK/JvddP8ak8SVCHUD1//ckEjv7J3c+uELYt1db7KA6bIaXnAgobcw
   wtYvlSvpe0UuorsCpYuR9UJLUJ0Hja2H6CTsfSjCqEgFJhXjG8YdtrCSY
   85kqCQ3cesSW/I2ynKu+gjWftZlowEiIpaoBk1kgR5BTSG2aWIl7ionYB
   1IxxKxyW9uPXRCYs1LfnzYl45IqQXqtewZfT/PSHTdsLUajjstPWkF45r
   A==;
X-CSE-ConnectionGUID: Xe9L43AGRCaq2sP3etLZbA==
X-CSE-MsgGUID: Cam8FogPSc2ImuAHDPo+wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="61239603"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="61239603"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 02:01:11 -0800
X-CSE-ConnectionGUID: RZsrIEjITd+zqO2YE5xN3Q==
X-CSE-MsgGUID: qAa5pEj3SVKLKkZqz6wWCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110191861"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 30 Jan 2025 02:01:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 94ED2DC; Thu, 30 Jan 2025 12:01:01 +0200 (EET)
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
Subject: [PATCHv3 01/11] mm/migrate: Transfer PG_dropbehind to the new folio
Date: Thu, 30 Jan 2025 12:00:39 +0200
Message-ID: <20250130100050.1868208-2-kirill.shutemov@linux.intel.com>
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

Do not lose the flag on page migration.

Ideally, these folios should be freed instead of migration. But it
requires to find right spot do this and proper testing.

Transfer the flag for now.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/migrate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index fb19a18892c8..1fb0698273f7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -682,6 +682,10 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 	if (folio_test_dirty(folio))
 		folio_set_dirty(newfolio);
 
+	/* TODO: free the folio on migration? */
+	if (folio_test_dropbehind(folio))
+		folio_set_dropbehind(newfolio);
+
 	if (folio_test_young(folio))
 		folio_set_young(newfolio);
 	if (folio_test_idle(folio))
-- 
2.47.2


