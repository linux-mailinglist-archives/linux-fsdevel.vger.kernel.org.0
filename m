Return-Path: <linux-fsdevel+bounces-40373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B97E9A22B2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 11:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072D1167EDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 10:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC491DFE29;
	Thu, 30 Jan 2025 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVl1hh/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C11C07C8;
	Thu, 30 Jan 2025 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231284; cv=none; b=uoQDJG8TEnjidfvIrXFV9cYM9ks+zp2sXgAqZhgHCkxwDBMpMJgR+EKYf8pBncDkdfbJKaxM2omi1kFCLrZYEw6VAUbYpTOLSuKMI8QPJWafQvNwYgVRrwDGF8o4Xs/QovJT8h0pPP1ZxNE6SUv3rX20Hmn1rZgJdlfY1sm7pz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231284; c=relaxed/simple;
	bh=szEhvue7tvwHIQZ0VmyVu64vw/Pobf8bTFzicSKRI7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3f4BuooTN/p2SMRLyGRtfPnA0i/V0R85iT7n3C+Rim52FebfcKaiWMIYogj1a/AaSBbH5P3y1JX79C2IRMrmkT8D2czpOJ+INbqhmPArzcDprBC46RDgtmDjmM5lySvOsCJ6BRdAELn5ukDybhGjLm2aB4wE82HGk1kU9OM6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVl1hh/E; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738231283; x=1769767283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=szEhvue7tvwHIQZ0VmyVu64vw/Pobf8bTFzicSKRI7A=;
  b=IVl1hh/Ev9sN7u8ck83TCl/sSRxCjgQahx2LcefUf3M5QL2G1RzrjDFD
   y+my8IbC3Vti0VrTHRWStxQgQM1cIFwzU7Rl4PqPaoVDk1vhRNDzAgOu7
   zIoXnMgdrzhYJ6KYbr5OpjQfCm8oWjCGznoh0URkoSxKEwCuPcB8+h4mM
   wwjCPbr+VKyolCVpiSCsQVLsIPMeWs4lEMJf87gaC+JoJaJLvnvCryJGN
   muFyCI17Lkp0ghQBMUacowYN4yZIOcaav2/AaLvmWXF8XmxfY/ny6XQC+
   lPpje1LQKB6GOY1mo+Nq3tNBW65bzGC+pnY3qQ2l1PGQ6mms10snZx/r3
   w==;
X-CSE-ConnectionGUID: iKSfvd5pSziaviLZDTYXnw==
X-CSE-MsgGUID: aY9qBY4STwmnTA7WtFXeDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="42692534"
X-IronPort-AV: E=Sophos;i="6.13,245,1732608000"; 
   d="scan'208";a="42692534"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 02:01:20 -0800
X-CSE-ConnectionGUID: lcqnGOMgSX2cDcYWUs2yxQ==
X-CSE-MsgGUID: GkOkS/VOT7+BISgs+ghD9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="114263398"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 30 Jan 2025 02:01:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 1CC531BD; Thu, 30 Jan 2025 12:01:02 +0200 (EET)
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
Subject: [PATCHv3 10/11] mm/vmscan: Do not demote PG_dropbehind folios
Date: Thu, 30 Jan 2025 12:00:48 +0200
Message-ID: <20250130100050.1868208-11-kirill.shutemov@linux.intel.com>
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

PG_dropbehind flag indicates that the folio need to be freed immediately.
No point in demoting it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4bead1ff5cd2..4f86e020759e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1231,7 +1231,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * Before reclaiming the folio, try to relocate
 		 * its contents to another node.
 		 */
-		if (do_demote_pass &&
+		if (do_demote_pass && !folio_test_dropbehind(folio) &&
 		    (thp_migration_supported() || !folio_test_large(folio))) {
 			list_add(&folio->lru, &demote_folios);
 			folio_unlock(folio);
-- 
2.47.2


