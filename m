Return-Path: <linux-fsdevel+bounces-17549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADEC8AF73C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 21:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4042288093
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050831422BE;
	Tue, 23 Apr 2024 19:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p+WQ0DGV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2958140368;
	Tue, 23 Apr 2024 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900146; cv=none; b=PgJASjqC4NSbpFZ2fGI+s6iSGXn/2kQpKSGzl6Y1ogJVJIjq2nF/w1AI4OI64QcV3dyjGVYfA5jQhp2jUbERIS2IPtOkd74BrSOOn0bOc5zKcSipOG9xDEQMMZQr1SpKV9f8ThlNApSdjJ6bZv/UPaWquA6x58uuPqhAU0BgIn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900146; c=relaxed/simple;
	bh=AifPCum3Y5cpyN0GlKVylAcfCgrw/OwmF5XdgLkmvEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm8siU2Qh/kpTDePXZKTEZlM0Uhf3UdHzN0/hXr16jiTruIb4O6/7t+b8MxOdO/gsKdJGO9UEF+WAGc8KfpoECLu6CgD9Q8PynXxq7YUzdGnKS+HsgLFVUJrtVLs4b4JrbhL29to8DKGCVuZMB6252pGJmZCmwSsHQcG8JlkcZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p+WQ0DGV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QH8+VVHeKCvyXF+XfpPQcB3hgAUVEIgYamedVnOHyoQ=; b=p+WQ0DGVtlrOAjESqjZUK58O8k
	nisgxZqza7lnpwKkHu/cm5nXgHvuDPDUh+ETV2yigLg30aS1kNAP/2njfMQUTDyClS/xUJ4u0PfnI
	AtDL6m9exbragWOT0L9tZ5cJd/CSP9tu9X9S85K9dDMYFwkAlfkZry2fx3pvV/xnqMjBgMSRECaGo
	arQv8U4+baya92uW5jw1z9dDgR47wh3gSS3UWBpOgWsX3gtqQpqbvQfqKiC3V3NWlPdDvcDvYVqmi
	V1C1vE6m5kmnyO5PKjON0tvVNztPaXjYUo6ZyOq3lBuo1iM9DQGHi3/spFwK2piLYT76AzMlnqzkI
	8BjjovSw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzLig-00000001GKt-3E51;
	Tue, 23 Apr 2024 19:22:22 +0000
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
Subject: [PATCH v2 2/2] lib/test_xarray.c: fix error assumptions on check_xa_multi_store_adv_add()
Date: Tue, 23 Apr 2024 12:22:21 -0700
Message-ID: <20240423192221.301095-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423192221.301095-1-mcgrof@kernel.org>
References: <20240423192221.301095-1-mcgrof@kernel.org>
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

Fixes: a60cc288a1a2 ("test_xarray: add tests for advanced multi-index use")
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


