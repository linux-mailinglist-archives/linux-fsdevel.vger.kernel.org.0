Return-Path: <linux-fsdevel+bounces-9729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 999BE844B4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDD71C25720
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 22:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F93C3B295;
	Wed, 31 Jan 2024 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NmXI91H0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1327D3AC12;
	Wed, 31 Jan 2024 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741492; cv=none; b=SR4EDmi8X5zLfzJS8XSJJFRmBVyppwQhotDg6WXzz2eDM+wNYVYF/L9ItoTtXrA54DIbIR/JdTS3jqeF9VKabIdtjSqPZI7ETHNU1aQ2bZIGuXJ7UTr5uZSVtGrKeFq3CmxAmjouy+RB+NCnXRkY9cbOHt5709pl/RxrDLGLXcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741492; c=relaxed/simple;
	bh=6LSbqfJqIW9HaFLfqQwA40AtdNrMLdIoKVFrdRBtKF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbEt38WkYCgnKbL0WLOLuoJXNj0yDnVbDQB1RkDjU6FSuFqof85YELbSt4uiywlZZdu6ypFDfS4fgPYHMfOP17T8qcNCyr6Lao/2cEgBEwVFwxQZlNDsQgJA5YkePqvRh09hcC5QcifZOkH2iIGZsVo/4s6cwsFtrqEmHWdVPGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NmXI91H0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VZT786wUdytPkTuVNcY7ycnwPOjLKqn3LYNeNzmf2tQ=; b=NmXI91H0BewXk5PAb2p7VcWRBJ
	Er4y9xuUWXKmfOmg1A5hRZJL/GmdGaqZyt+Wy3JEmc6Ch65MSW365/US2qyMPeCVsjyvaDwsKYuqY
	ALhJ4zco7qdbHL+dfbdDyuw/njFd0vBGVNfwNTpuv6PUhBfHEfiE3g/2Qym5nt3q98RU0UgMdXLPQ
	/n37ZsZkxZbqI1Z9aLclAYD9pPeE7nUg6d7Q8YXokCInsbtdBWK8dl4HsEkWMqkjiXiMVrEbL8Uie
	z4QSZ66rSqzh9k5Jz84Qn3nBy45BSnHkxfqsyn5XzHO/YyWMd3FQN4S1X8WBB4alKipfR8xlhC2uK
	Sf7w58ZA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJQW-00000005kZE-49GO;
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
Subject: [PATCH v2 2/2] XArray: add cmpxchg order test
Date: Wed, 31 Jan 2024 14:51:25 -0800
Message-ID: <20240131225125.1370598-3-mcgrof@kernel.org>
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

From: Daniel Gomez <da.gomez@samsung.com>

XArray multi-index entries do not keep track of the order stored once
the entry is being marked as used with cmpxchg (conditionally replaced
with NULL). Add a test to check the order is actually lost. The test
also verifies the order and entries for all the tied indexes before and
after the NULL replacement with xa_cmpxchg.

Add another entry at 1 << order that keeps the node around and the order
information for the NULL-entry after xa_cmpxchg.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/test_xarray.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 8b23481f0e8f..d4e55b4867dc 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -423,6 +423,59 @@ static noinline void check_cmpxchg(struct xarray *xa)
 	XA_BUG_ON(xa, !xa_empty(xa));
 }
 
+static noinline void check_cmpxchg_order(struct xarray *xa)
+{
+#ifdef CONFIG_XARRAY_MULTI
+	void *FIVE = xa_mk_value(5);
+	unsigned int i, order = 3;
+
+	XA_BUG_ON(xa, xa_store_order(xa, 0, order, FIVE, GFP_KERNEL));
+
+	/* Check entry FIVE has the order saved */
+	XA_BUG_ON(xa, xa_get_order(xa, xa_to_value(FIVE)) != order);
+
+	/* Check all the tied indexes have the same entry and order */
+	for (i = 0; i < (1 << order); i++) {
+		XA_BUG_ON(xa, xa_load(xa, i) != FIVE);
+		XA_BUG_ON(xa, xa_get_order(xa, i) != order);
+	}
+
+	/* Ensure that nothing is stored at index '1 << order' */
+	XA_BUG_ON(xa, xa_load(xa, 1 << order) != NULL);
+
+	/*
+	 * Additionally, keep the node information and the order at
+	 * '1 << order'
+	 */
+	XA_BUG_ON(xa, xa_store_order(xa, 1 << order, order, FIVE, GFP_KERNEL));
+	for (i = (1 << order); i < (1 << order) + (1 << order) - 1; i++) {
+		XA_BUG_ON(xa, xa_load(xa, i) != FIVE);
+		XA_BUG_ON(xa, xa_get_order(xa, i) != order);
+	}
+
+	/* Conditionally replace FIVE entry at index '0' with NULL */
+	XA_BUG_ON(xa, xa_cmpxchg(xa, 0, FIVE, NULL, GFP_KERNEL) != FIVE);
+
+	/* Verify the order is lost at FIVE (and old) entries */
+	XA_BUG_ON(xa, xa_get_order(xa, xa_to_value(FIVE)) != 0);
+
+	/* Verify the order and entries are lost in all the tied indexes */
+	for (i = 0; i < (1 << order); i++) {
+		XA_BUG_ON(xa, xa_load(xa, i) != NULL);
+		XA_BUG_ON(xa, xa_get_order(xa, i) != 0);
+	}
+
+	/* Verify node and order are kept at '1 << order' */
+	for (i = (1 << order); i < (1 << order) + (1 << order) - 1; i++) {
+		XA_BUG_ON(xa, xa_load(xa, i) != FIVE);
+		XA_BUG_ON(xa, xa_get_order(xa, i) != order);
+	}
+
+	xa_store_order(xa, 0, BITS_PER_LONG - 1, NULL, GFP_KERNEL);
+	XA_BUG_ON(xa, !xa_empty(xa));
+#endif
+}
+
 static noinline void check_reserve(struct xarray *xa)
 {
 	void *entry;
@@ -1964,6 +2017,7 @@ static int xarray_checks(void)
 	check_xas_erase(&array);
 	check_insert(&array);
 	check_cmpxchg(&array);
+	check_cmpxchg_order(&array);
 	check_reserve(&array);
 	check_reserve(&xa0);
 	check_multi_store(&array);
-- 
2.43.0


