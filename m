Return-Path: <linux-fsdevel+bounces-39248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459D7A11E00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FB4188D635
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23F52416AF;
	Wed, 15 Jan 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTl6YzUT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5BB35966;
	Wed, 15 Jan 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933523; cv=none; b=WKRvtKoDr3Qtpe1K14hez2ZyM2UhHmqgCIQO7Egxm49Iu0M56qNR342Q/zIGO/UOqWhDZI0Xu/PUl6B13s7J8XlAcMCsYZn56EQR3THSocnjB7vaXlr8QQMEpObC6Dem9fl3CGQDfebsI69Yal7IXL+PbEDrmyIM5/6Wxfrh1E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933523; c=relaxed/simple;
	bh=wdId850dbutGu/Dl/qOd5q3uP9vz/Pw94pmHcv++11Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQydWu7XBs1itjk0iotakoiFY8MPWtaqHKsR8wQYQcIe7+ceXVI9LcxRvkbqfVYpbWRQD1yuIIN6pEu0bausE8ckqSPf8qmIhHmcgZX1brq8dMR+FbcN6zIOTo//VUQuaYH9UwSWJp+phbLy478P6Z9NztMLOW4zvb4syKhCnc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTl6YzUT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736933521; x=1768469521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wdId850dbutGu/Dl/qOd5q3uP9vz/Pw94pmHcv++11Y=;
  b=VTl6YzUTpSwYAZsk29hiQq8viCVSJ5RLraME9+ejxv2VL2V6Er6c/RQy
   7iXQOkKPZ6FQGzKkTdbeXEpIoYNMNDH9jzqWFQNvOuFivM+vsHPBGf19K
   wRMaH8+RFXh/U6bUjikvhEpPJ5PzdlqbpmXp7kpxegPf68aAuLInDjxim
   vddafyMsWkcZF9IC54gnudV/+8dov8/yHryt9+ImHZHrTgFyZbDmaHuq4
   BqZyqrZMXQLa1k9fmvUbACbkfhUYamTrnsdi2c0SU1MsTocgPL5ztNMtJ
   PkthPF+LYFGvSCMiGftpxF75KjTW5ExGscmd4lxVqiVnEkBTAdOqTvMr6
   Q==;
X-CSE-ConnectionGUID: wDUSZ2n7TGOLUdflb9pSlg==
X-CSE-MsgGUID: ZnKb7J2nSmqSgqDGb9NgRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="41195127"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="41195127"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 01:32:00 -0800
X-CSE-ConnectionGUID: pRIEDaOSTYmO9MYn2OMq0g==
X-CSE-MsgGUID: 5prHjalDTIyibN9ckH5OgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109700879"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 15 Jan 2025 01:31:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BFF03765; Wed, 15 Jan 2025 11:31:42 +0200 (EET)
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
Subject: [PATCHv2 10/11] mm/vmscan: Do not demote PG_dropbehind folios
Date: Wed, 15 Jan 2025 11:31:34 +0200
Message-ID: <20250115093135.3288234-11-kirill.shutemov@linux.intel.com>
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

PG_dropbehind flag indicates that the folio need to be freed immediately.
No point in demoting it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e61e88e63511..0b8a6e0f384c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1235,7 +1235,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * Before reclaiming the folio, try to relocate
 		 * its contents to another node.
 		 */
-		if (do_demote_pass &&
+		if (do_demote_pass && !folio_test_dropbehind(folio) &&
 		    (thp_migration_supported() || !folio_test_large(folio))) {
 			list_add(&folio->lru, &demote_folios);
 			folio_unlock(folio);
-- 
2.45.2


