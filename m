Return-Path: <linux-fsdevel+bounces-39243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C9DA11DFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7253A846B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199E81EEA3D;
	Wed, 15 Jan 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2/CFTP/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD024818C;
	Wed, 15 Jan 2025 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933514; cv=none; b=S+e+Tg3IrUszEtYa9o0+O2itLFu9yAO8f1xbFddY1B17bTBHrGQdpOWbfGoV9RdwG1C63n6SCV+CZ2do1aurRymS1e/srZ5zBxi6zDfxddqNoAIHXmY5dd/wb4uO0IceLv8eddCBN+RR5XIa6u0uGrPGSwbuILaxJanhhr8YftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933514; c=relaxed/simple;
	bh=yFaq4+y3L3aBB+QzbnekiDGuxensl38YhIVnwEC4MWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdylJOc5I1XoFWjZ39mX3GD8MmytPcfdJswDu8ARV7KHOYuxZbT/U3Oxu8ejJCKLHoYmRHAtQvAbLuk+ygVkYM9PEoap5/Hu2h+n4D3gOdU3r71GKx9hrzhUQ7d4xqo3c7rCOGRPkwQqzFmMtQ6Jb82KTn2UZvwYhrl18LyzpnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2/CFTP/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736933513; x=1768469513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yFaq4+y3L3aBB+QzbnekiDGuxensl38YhIVnwEC4MWs=;
  b=W2/CFTP/YGn1x/oyewYajuqS6B13wfhG1G4qiLxCnhxHGY8L2He0n6f/
   zogJ6+n8RpJiNl7xzPRc5vgdYNTll4FRrsxqIAie2WAKvDZLRIc37UCDC
   31aMUa2EGmE3+1bUjqgbiwXfPIIo4jOJ1FHRgReKTPbehS7ltmAIuDxi0
   zNlbyBZLFxELpypIJltZ0mumHJpE6pDViay5Ut6ReA5bXeY2h9nKmXWRp
   2EjqIfRdcPsSZmn7nUJM63ThWysHp+oCXpX7qQM12RBz4MIYBIm6ZYLQM
   0WgFbyiK3JaQkhg0a74E5mHhBou7im1z0OKeXogn/ctt5dDr5UKSxmaA5
   g==;
X-CSE-ConnectionGUID: aqe80r6nTJS1E1eq3zQarA==
X-CSE-MsgGUID: KSgL6LwrQimqZzByZSrbOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37371815"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37371815"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 01:31:52 -0800
X-CSE-ConnectionGUID: SRJjdY82STKzm2J5zuHSUw==
X-CSE-MsgGUID: pixpA6aySyq+BTEWCXFN3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="110066760"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 15 Jan 2025 01:31:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3267839C; Wed, 15 Jan 2025 11:31:42 +0200 (EET)
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
Subject: [PATCHv2 01/11] mm/migrate: Transfer PG_dropbehind to the new folio
Date: Wed, 15 Jan 2025 11:31:25 +0200
Message-ID: <20250115093135.3288234-2-kirill.shutemov@linux.intel.com>
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

Do not lose the flag on page migration.

Ideally, these folios should be freed instead of migration. But it
requires to find right spot do this and proper testing.

Transfer the flag for now.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/migrate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index caadbe393aa2..690efa064bee 100644
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
2.45.2


