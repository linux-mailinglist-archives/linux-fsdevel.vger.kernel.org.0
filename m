Return-Path: <linux-fsdevel+bounces-17541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEE48AF63E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 20:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47130294371
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 18:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595EC13E885;
	Tue, 23 Apr 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qOzyjcNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE813DDA5;
	Tue, 23 Apr 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895519; cv=none; b=VDOP0+SP0MIQNeBaTDcd8bppPJuBcQBLLD4NWTf7yZ5ioVVU8CAJy6p6kSVINI/2Q376z3iICEwSGXKWMv/pr3DHnivYRs9Z4CovhCoyjN+jgTbKqudw278ftkfWb3jOk7gymin19Ig5kQXHMfUq49xvBO4vvwXR303F0/5+pok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895519; c=relaxed/simple;
	bh=xLEeNea2Swz811EqhOtx3ywS1B3A9qNV3biB+04Js0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4D2WcKTukcDKd3hQojSV3LK0rGUeQcDu3NgePDsJ7CkTu2ZVHgaH8sZAAL/ywSdlM+RLS1qttdNj9deiuiPv36j4kxBc9WMRUCmVYe9YO3NP9M3DBEuBWSEQ1ydxix1cBIIV9t2aigJ7I9RZe1S/5QevHUrz5XnxLFh1lz6R+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qOzyjcNR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ucWCcqpK+RgxRkCoiBrn6yK6YGAtyibZy8sxqOnryEM=; b=qOzyjcNRdSbxBDuZsbyVrfEg6C
	hz4XiG/TqH/YQrqkTW+XVNZOm3RAdD2IHy+TkB73mS4ryfWsUEc3AMbKuap4Mhvk8pemd8Z2pdCYC
	fPQjbCsUO2woGCj5zNZzEqelEXcBV644WZ5FVRslbTCHknlhPln2EB0s9+itnNSo8LAzWUv842VYn
	mBy3Yx6OQWjiAasKbIH3rseys+VjISPqNkZs4M6wkMdWDX09ifLMI9DmgSYvdksNEjLw1749B8PhT
	2bOrSpivC4PVkNUgYQWEtub8W+5itQGQdvT30QWfQU4AQ6TTluNSnhr1n4BbAbLvkaUQ2bnU4KNWB
	7/8pkewg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzKW5-000000014oc-2SlA;
	Tue, 23 Apr 2024 18:05:17 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	Liam.Howlett@oracle.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	david@fromorbit.com,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 2/2] lib/test_xarray.c: fix error assumptions on check_xa_multi_store_adv_add()
Date: Tue, 23 Apr 2024 11:05:16 -0700
Message-ID: <20240423180517.256812-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423180517.256812-1-mcgrof@kernel.org>
References: <20240423180517.256812-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

While testing lib/test_xarray in userspace I've noticed we can fail with:

make -C tools/testing/radix-tree
./tools/testing/radix-tree/xarray

BUG at check_xa_multi_store_adv_add:749
xarray: 0x55905fb21a00x head 0x55905fa1d8e0x flags 0 marks 0 0 0
0: 0x55905fa1d8e0x
xarray: ../../../lib/test_xarray.c:749: check_xa_multi_store_adv_add: Assertion `0' failed.
Aborted

We get a failure with a BUG_ON(), and that is because we actually can
fail due to -ENOMEM, the check in xas_nomem() will fix this for us so
it makes no sense to expect no failure inside the loop. So modify the
check and since this is also useful for instructional purposes clarify
the situation.

The check for XA_BUG_ON(xa, xa_load(xa, index) != p) is already done
at the end of the loop so just remove the bogus on inside the loop.

With this we now pass the test in both kernel and userspace:

In userspace:

./tools/testing/radix-tree/xarray
XArray: 149092856 of 149092856 tests passed

In kernel space:

XArray: 148257077 of 148257077 tests passed

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/test_xarray.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index ebe2af2e072d..5ab35190aae3 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -744,15 +744,20 @@ static noinline void check_xa_multi_store_adv_add(struct xarray *xa,
 
 	do {
 		xas_lock_irq(&xas);
-
 		xas_store(&xas, p);
-		XA_BUG_ON(xa, xas_error(&xas));
-		XA_BUG_ON(xa, xa_load(xa, index) != p);
-
 		xas_unlock_irq(&xas);
+		/*
+		 * In our selftest case the only failure we can expect is for
+		 * there not to be enough memory as we're not mimicking the
+		 * entire page cache, so verify that's the only error we can run
+		 * into here. The xas_nomem() which follows will ensure to fix
+		 * that condition for us so to chug on on the loop.
+		 */
+		XA_BUG_ON(xa, xas_error(&xas) && xas_error(&xas) != -ENOMEM);
 	} while (xas_nomem(&xas, GFP_KERNEL));
 
 	XA_BUG_ON(xa, xas_error(&xas));
+	XA_BUG_ON(xa, xa_load(xa, index) != p);
 }
 
 /* mimics page_cache_delete() */
-- 
2.43.0


