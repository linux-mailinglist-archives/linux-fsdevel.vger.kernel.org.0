Return-Path: <linux-fsdevel+bounces-12772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05CD867027
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCEC1C268E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C005167C5C;
	Mon, 26 Feb 2024 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="k+/Se9RL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B93065BD6;
	Mon, 26 Feb 2024 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941003; cv=none; b=UoH7m6rIihYMropx1FClloLL4Nx7rf3NALAa1Rw+/BAP0Ypwng2uptMjlUez9Cp5FcEl2BtTk/ZjD9OaU8v3n1PuJbWy0j1g9Rf+9+QeiYC0n/ygEhuReLSkcCB7A/pBEZe83nC4VhLC9wIoMq0pwk/8C6RFYEbT/aYnN0LiCfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941003; c=relaxed/simple;
	bh=B8LAjeHNvIxjm7OqhHXSoxFDHydjeXl3PmY9Dn+JxsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCqtdarlm5M+mocXYz6pkCGgopws+0eJSK8oXGpl8s+LXuL98xoOwGE+YXeUEvLRUgJPTIGz4YL8ECiI/tjzZYxWjGGaDmGJkbIaO4JE+59I0bTwOHre3+2V0t68BUO00m/FPcYAW79ZTqT/2B05y/tzu5fcKE9VSWlKCtWVR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=k+/Se9RL; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Tjwny230Zz9sd7;
	Mon, 26 Feb 2024 10:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1708940998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxmi9nVYwim1cNNfe2Xlh2MStfm/gxTJRd9QPZsgFwc=;
	b=k+/Se9RLgvLTB8sb1uVay3Y3/zq/KKPrHWmX8ufvZwefrZwIlUZfRJ0xhs2kSLt6KkAjZ0
	9MhFKa3OZzoGhJhjkXWfmOyOmF6woVxT8c4RkkyYzVoI+NsAWx9L+rFJyTV/+HVlrL7F7J
	Syh0kvGX8dYH758lZpESl95+fW81cGnQCMLeqVuZ5ygto6rxyq+UTXhfeGE8R8KTkQyjIg
	mJAkC9sTnrgntU6ZIPmJk5y6f+LDnq6nvSS1raDz9Jbn5PyL/vN7dzypafSByUv5sFm/tl
	4mvQEppUs15HBHAzDg/EKxrm8u1fJ2KPfgzmxH28w64LHM1jHLhVdQWK6O39yg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	mcgrof@kernel.org,
	ziy@nvidia.com,
	hare@suse.de,
	djwong@kernel.org,
	gost.dev@samsung.com,
	linux-mm@kvack.org,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 04/13] filemap: use mapping_min_order while allocating folios
Date: Mon, 26 Feb 2024 10:49:27 +0100
Message-ID: <20240226094936.2677493-5-kernel@pankajraghav.com>
In-Reply-To: <20240226094936.2677493-1-kernel@pankajraghav.com>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Tjwny230Zz9sd7

From: Pankaj Raghav <p.raghav@samsung.com>

filemap_create_folio() and do_read_cache_folio() were always allocating
folio of order 0. __filemap_get_folio was trying to allocate higher
order folios when fgp_flags had higher order hint set but it will default
to order 0 folio if higher order memory allocation fails.

As we bring the notion of mapping_min_order, make sure these functions
allocate at least folio of mapping_min_order as we need to guarantee it
in the page cache.

Add some additional VM_BUG_ON() in page_cache_delete[batch] and
__filemap_add_folio to catch errors where we delete or add folios that
has order less than min_order.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 mm/filemap.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index bdf4f65f597c..4b144479c4cb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -135,6 +135,8 @@ static void page_cache_delete(struct address_space *mapping,
 	xas_set_order(&xas, folio->index, folio_order(folio));
 	nr = folio_nr_pages(folio);
 
+	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
+			folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	xas_store(&xas, shadow);
@@ -305,6 +307,8 @@ static void page_cache_delete_batch(struct address_space *mapping,
 
 		WARN_ON_ONCE(!folio_test_locked(folio));
 
+		VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
+				folio);
 		folio->mapping = NULL;
 		/* Leave folio->index set: truncation lookup relies on it */
 
@@ -896,6 +900,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 			}
 		}
 
+		VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
+				folio);
 		xas_store(&xas, folio);
 		if (xas_error(&xas))
 			goto unlock;
@@ -1847,6 +1853,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp)
 {
 	struct folio *folio;
+	unsigned int min_order = mapping_min_folio_order(mapping);
+
+	index = mapping_align_start_index(mapping, index);
 
 repeat:
 	folio = filemap_get_entry(mapping, index);
@@ -1886,7 +1895,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_wait_stable(folio);
 no_page:
 	if (!folio && (fgp_flags & FGP_CREAT)) {
-		unsigned order = FGF_GET_ORDER(fgp_flags);
+		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
 		int err;
 
 		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
@@ -1912,8 +1921,13 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp_t alloc_gfp = gfp;
 
 			err = -ENOMEM;
+			if (order < min_order)
+				order = min_order;
 			if (order > 0)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
+
+			VM_BUG_ON(index & ((1UL << order) - 1));
+
 			folio = filemap_alloc_folio(alloc_gfp, order);
 			if (!folio)
 				continue;
@@ -1927,7 +1941,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 				break;
 			folio_put(folio);
 			folio = NULL;
-		} while (order-- > 0);
+		} while (order-- > min_order);
 
 		if (err == -EEXIST)
 			goto repeat;
@@ -2422,7 +2436,8 @@ static int filemap_create_folio(struct file *file,
 	struct folio *folio;
 	int error;
 
-	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
+				    mapping_min_folio_order(mapping));
 	if (!folio)
 		return -ENOMEM;
 
@@ -3666,7 +3681,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
-		folio = filemap_alloc_folio(gfp, 0);
+		folio = filemap_alloc_folio(gfp,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		err = filemap_add_folio(mapping, folio, index, gfp);
-- 
2.43.0


