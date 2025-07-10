Return-Path: <linux-fsdevel+bounces-54426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E05AFF946
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31271565EE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 06:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B176287510;
	Thu, 10 Jul 2025 06:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CbfmcoO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA004287274;
	Thu, 10 Jul 2025 06:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127574; cv=none; b=Y1em3OO5juUIcdJIIHOahXE0vNXqX4Fy0XYmeKvks3UNCA+brfXqGyBJALgJLUiimfRIlPyB6wdVqAAckfAMmUXLpsiRapK0IKkcdhJl/UIuvxE8AjcdG2qYUWWfA7x9NFwUK6lUrObioatIf5iVELbro6u1GwnHseIsAbGRb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127574; c=relaxed/simple;
	bh=ivGeA2wXiSpFCTtX1rZotUWLlXU9zm0gSGx7++mcOjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7cSPg5wWauYUKuHyVO8pTqefpepGRRZEjWXCVvkY5emZNco0+Zdz/hCzGoV2hre15VbrlTM0o/tE6x+5/tGBxd93T4PBpSdKuOWYPbPA/UJieMlPSmsgnYpubro6ay5BKP5PBuhWYPBnoVrqHxtJNuXBrg5fOetGh8c4+Pgupg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CbfmcoO8; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lr
	MM3cDnKSKULOozBPNkIM/PzkKRLmxdEg7VouXUW9Y=; b=CbfmcoO8iJ7Bm9QZQi
	0/8C7bpRBVIYfDq469vFWlCBndpI7NlewCmDJ5943h6GUmbANkwTVtWWCxxOLgTi
	v9jElDU7xl3KVxT0lMdd0gQLsULiRAuM9saNKkj95fwqx7O5E1ux8axo4uKuUmvf
	fEiYpI6A4sfQo0jd7Tf/MY9U0=
Received: from chi-Redmi-Book.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXH5khWG9oysB5Dw--.23816S2;
	Thu, 10 Jul 2025 14:05:22 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH] readahead: Use folio_nr_pages() instead of shift operation
Date: Thu, 10 Jul 2025 14:04:51 +0800
Message-ID: <20250710060451.3535957-1-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXH5khWG9oysB5Dw--.23816S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF47ZrWUXFyUCw47Jry5Arb_yoW3Xwc_WF
	W0kw4qgF18GF4Sga1Y9ayfGFW0g398CryUXF4DZF9rtay8Was7Xa4Yqr10vr1DXr1YkF43
	JwsIqF98urn8GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8co7tUUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiFBCGnWhvTwjKEgAAsH

From: Chi Zhiling <chizhiling@kylinos.cn>

folio_nr_pages() is faster helper function to get the number of pages
when NR_PAGES_IN_LARGE_FOLIO is enabled.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 mm/readahead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 95a24f12d1e7..406756d34309 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -649,7 +649,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	 * Ramp up sizes, and push forward the readahead window.
 	 */
 	expected = round_down(ra->start + ra->size - ra->async_size,
-			1UL << folio_order(folio));
+			folio_nr_pages(folio));
 	if (index == expected) {
 		ra->start += ra->size;
 		/*
-- 
2.43.0


