Return-Path: <linux-fsdevel+bounces-9728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E7A844B49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1981C24B52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 22:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1093AC30;
	Wed, 31 Jan 2024 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RRFaCJ4U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1E83AC14;
	Wed, 31 Jan 2024 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741491; cv=none; b=ryCQbNzfQakr5R9cfKKsCsCjyqwcM/sUPJUffjTNEbPTlFWTr/6aBUK6ogWV3u3g9hFN+YYWGdnhzWDoU3E+UENQaLitvptMsKI2RpYNsVEHumQfn2Zp+CzaJngXv8SwCNm/9Lc1ChQ+0RKYxXJOudrNTnmlRCbdtXazo6mpCOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741491; c=relaxed/simple;
	bh=nUkzR12xy1p2FiXOVo6YSxE3TENbyX/bzQKcNKNH2Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5bMEdkPx0AUhNGzLVGp8Hk7sZh3aB7/P7YqPkD3wg5cguTPFAx7kTDBlF6k5sfUfuSYLIUoYPwQPmwxUu1aGhiY8ba4uBc6bBxAm9/khmAlmhygCJFXUHHAScl9mI9IRTTTPF9k9LUVcRAWS6/Nii5bc48h8ixG6gbqe2N0AtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RRFaCJ4U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VHDS8XfeqrJJCoN72ANJz9/5fJVypoPtMt3FLrR4fJQ=; b=RRFaCJ4USpY0kDnPaF2Gol/eCH
	uSXwm4FGSYKqQL6L2LaiKlthJCk+UXmcoNd1huvU87/ebEx4N9F6NuJ6Xr6wmSsYva88XNpFNk6Jl
	8VonDVWqHqa3NtjMQblemeLe2bJBWdLZIn/YwiXRHJ2yXZehrKiXuK6Cl8FowK0RCaEFrzF9medG7
	8PgaWqykDIabwdxryzoDPb7BtJQOZ2Xwd6zmtJ5tKsvE5DoyhNEu2vzdTaWxcNJlubQV+gJFxTmtz
	5bW2px9kQeGRUnIKNiFdPrrD3gER30HYudTQofdG5jkhHiqrNHXq3m6LCOzlu+ap8tr+BzqIVixew
	i3855xlQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJQW-00000005kZC-3y0I;
	Wed, 31 Jan 2024 22:51:28 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	hare@suse.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	djwong@kernel.org,
	david@fromorbit.com,
	mcgrof@kernel.org
Subject: [PATCH v2 1/2] test_xarray: add tests for advanced multi-index use
Date: Wed, 31 Jan 2024 14:51:24 -0800
Message-ID: <20240131225125.1370598-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131225125.1370598-1-mcgrof@kernel.org>
References: <20240131225125.1370598-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

The multi index selftests are great but they don't replicate
how we deal with the page cache exactly, which makes it a bit
hard to follow as the page cache uses the advanced API.

Add tests which use the advanced API, mimicking what we do in the
page cache, while at it, extend the example to do what is needed for
min order support.

Tested-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/test_xarray.c | 164 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index e77d4856442c..8b23481f0e8f 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -674,6 +674,169 @@ static noinline void check_multi_store(struct xarray *xa)
 #endif
 }
 
+#ifdef CONFIG_XARRAY_MULTI
+/* mimics page cache __filemap_add_folio() */
+static noinline void check_xa_multi_store_adv_add(struct xarray *xa,
+						  unsigned long index,
+						  unsigned int order,
+						  void *p)
+{
+	XA_STATE(xas, xa, index);
+	unsigned int nrpages = 1UL << order;
+
+	/* users are responsible for index alignemnt to the order when adding */
+	XA_BUG_ON(xa, index & (nrpages - 1));
+
+	xas_set_order(&xas, index, order);
+
+	do {
+		xas_lock_irq(&xas);
+
+		xas_store(&xas, p);
+		XA_BUG_ON(xa, xas_error(&xas));
+		XA_BUG_ON(xa, xa_load(xa, index) != p);
+
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, GFP_KERNEL));
+
+	XA_BUG_ON(xa, xas_error(&xas));
+}
+
+/* mimics page_cache_delete() */
+static noinline void check_xa_multi_store_adv_del_entry(struct xarray *xa,
+							unsigned long index,
+							unsigned int order)
+{
+	XA_STATE(xas, xa, index);
+
+	xas_set_order(&xas, index, order);
+	xas_store(&xas, NULL);
+	xas_init_marks(&xas);
+}
+
+static noinline void check_xa_multi_store_adv_delete(struct xarray *xa,
+						     unsigned long index,
+						     unsigned int order)
+{
+	xa_lock_irq(xa);
+	check_xa_multi_store_adv_del_entry(xa, index, order);
+	xa_unlock_irq(xa);
+}
+
+/* mimics page cache filemap_get_entry() */
+static noinline void *test_get_entry(struct xarray *xa, unsigned long index)
+{
+	XA_STATE(xas, xa, index);
+	void *p;
+
+	rcu_read_lock();
+repeat:
+	xas_reset(&xas);
+	p = xas_load(&xas);
+	if (xas_retry(&xas, p))
+		goto repeat;
+	rcu_read_unlock();
+
+	return p;
+}
+
+static unsigned long some_val = 0xdeadbeef;
+static unsigned long some_val_2 = 0xdeaddead;
+
+/* mimics the page cache usage */
+static noinline void check_xa_multi_store_adv(struct xarray *xa,
+					      unsigned long pos,
+					      unsigned int order)
+{
+	unsigned int nrpages = 1UL << order;
+	unsigned long index, base, next_index, next_next_index;
+	unsigned int i;
+
+	index = pos >> PAGE_SHIFT;
+	base = round_down(index, nrpages);
+	next_index = round_down(base + nrpages, nrpages);
+	next_next_index = round_down(next_index + nrpages, nrpages);
+
+	check_xa_multi_store_adv_add(xa, base, order, &some_val);
+
+	for (i = 0; i < nrpages; i++)
+		XA_BUG_ON(xa, test_get_entry(xa, base + i) != &some_val);
+
+	XA_BUG_ON(xa, test_get_entry(xa, next_index) != NULL);
+
+	/* Use order 0 for the next item */
+	check_xa_multi_store_adv_add(xa, next_index, 0, &some_val_2);
+	XA_BUG_ON(xa, test_get_entry(xa, next_index) != &some_val_2);
+
+	/* Remove the next item */
+	check_xa_multi_store_adv_delete(xa, next_index, 0);
+
+	/* Now use order for a new pointer */
+	check_xa_multi_store_adv_add(xa, next_index, order, &some_val_2);
+
+	for (i = 0; i < nrpages; i++)
+		XA_BUG_ON(xa, test_get_entry(xa, next_index + i) != &some_val_2);
+
+	check_xa_multi_store_adv_delete(xa, next_index, order);
+	check_xa_multi_store_adv_delete(xa, base, order);
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	/* starting fresh again */
+
+	/* let's test some holes now */
+
+	/* hole at base and next_next */
+	check_xa_multi_store_adv_add(xa, next_index, order, &some_val_2);
+
+	for (i = 0; i < nrpages; i++)
+		XA_BUG_ON(xa, test_get_entry(xa, base + i) != NULL);
+
+	for (i = 0; i < nrpages; i++)
+		XA_BUG_ON(xa, test_get_entry(xa, next_index + i) != &some_val_2);
+
+	for (i = 0; i < nrpages; i++)
+		XA_BUG_ON(xa, test_get_entry(xa, next_next_index + i) != NULL);
+
+	check_xa_multi_store_adv_delete(xa, next_index, order);
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	/* hole at base and next */
+
+	check_xa_multi_store_adv_add(xa, next_next_index, order, &some_val_2);
+
+	for (i = 0; i < nrpages; i++)
+		XA_BUG_ON(xa, test_get_entry(xa, base + i) != NULL);
+
+	for (i = 0; i < nrpages; i++)
+		XA_BUG_ON(xa, test_get_entry(xa, next_index + i) != NULL);
+
+	for (i = 0; i < nrpages; i++)
+		XA_BUG_ON(xa, test_get_entry(xa, next_next_index + i) != &some_val_2);
+
+	check_xa_multi_store_adv_delete(xa, next_next_index, order);
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+#endif
+
+static noinline void check_multi_store_advanced(struct xarray *xa)
+{
+#ifdef CONFIG_XARRAY_MULTI
+	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 20 : 1;
+	unsigned long end = ULONG_MAX/2;
+	unsigned long pos, i;
+
+	/*
+	 * About 117 million tests below.
+	 */
+	for (pos = 7; pos < end; pos = (pos * pos) + 564) {
+		for (i = 0; i < max_order; i++) {
+			check_xa_multi_store_adv(xa, pos, i);
+			check_xa_multi_store_adv(xa, pos + 157, i);
+		}
+	}
+#endif
+}
+
 static noinline void check_xa_alloc_1(struct xarray *xa, unsigned int base)
 {
 	int i;
@@ -1804,6 +1967,7 @@ static int xarray_checks(void)
 	check_reserve(&array);
 	check_reserve(&xa0);
 	check_multi_store(&array);
+	check_multi_store_advanced(&array);
 	check_get_order(&array);
 	check_xa_alloc();
 	check_find(&array);
-- 
2.43.0


