Return-Path: <linux-fsdevel+bounces-54818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95B2B0391F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48583B5A28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBC723D285;
	Mon, 14 Jul 2025 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="flZG0Dqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-71.smtpout.orange.fr [80.12.242.71])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53123A9BB
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481092; cv=none; b=CTQN0B3Ikmt4SIY39TikjP5A+NZNC7q8bFDfse1R1XRWh7Ifead6NITGOZ0LSG1PnL4/QBu8OrrfB8sKrjxJ7Mn0FVbqhvoI6CgwmPrUqiid7ZXdTFZGedV/iTX6JXUKlGxrgDkn9/ZKHV/CSc4on5E93XYJPyDFuI6EEllGnO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481092; c=relaxed/simple;
	bh=M+ykS1ah2gx3vm6JEaRazq13yqhSwvtDFXJ1WEiwQ3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQ+t3LTAuUwH9uit2RQ5bhOAcH21y+z3bbQrgfrw4FW8gDR3xgn0AEXpl1KmkY8x6dxTDa5L4GmbJQpK0UiuCAECG6hDeysQRSQSQWd/YL8sj4cGWujN/ux+x9oih5jtqqObsHHBqlIedHmVJSadyIJxKhGySXMV76iCNEs9kao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=flZG0Dqm; arc=none smtp.client-ip=80.12.242.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id bENfuHN2LILtwbEO1uVIhr; Mon, 14 Jul 2025 10:18:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752481089;
	bh=SRoyxxc9lckftvVfA80h43wgqXVemUdnuvpgTZAWo7o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=flZG0DqmobXXkShk7UcxXMb3kQSinB+K3lKz0wJrw2KzzTmM1zsf6MNEQV50Ci2yn
	 AKPNTAR5/w/tk/yN9MAyPrzFBZu+J6KDo6mchBxET2D8YI9fHhRoBrovtdza+ouWVc
	 AfgrNdUVAzPRmfzePpThV7XFtaFgZSCWAtx4QPsZHi+fWKDZs/lkS+sLLYzuHBrCoy
	 sF4DXpaz0lG1TMiMUw/TTD5OzZSY+16MbxRY1sgFfqMOxEYR88mWIOb6MU+asBKHmW
	 1PpivOYli+YwZhoqzgdb5HhHnvknhLDr0ZClu0qtGUmMDgJ8WZPZYu5k21haMcPp6G
	 +jYsK+rsnsqZQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 14 Jul 2025 10:18:09 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: willy@infradead.org,
	srini@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v3 1/3] idr test suite: Remove usage of the deprecated ida_simple_xx() API
Date: Mon, 14 Jul 2025 10:17:08 +0200
Message-ID: <2904fa2006e4fe58eea63aef87fa7f832c7804a1.1752480043.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752480043.git.christophe.jaillet@wanadoo.fr>
References: <cover.1752480043.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range()/ida_alloc_max() is inclusive. But because of the ranges
used for the tests, there is no need to adjust them.

While at it remove some useless {}.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
Changes in v3:
  - No changes

v2: https://lore.kernel.org/all/715cff763aa4b2c174cc649750e14e404db6e65b.1722853349.git.christophe.jaillet@wanadoo.fr/

Changes in v2:
  - This patch was already proposed see [1]. This one also rename the
    functions used for the test:
    s/ida_simple_get_remove_test/ida_alloc_free_test/.
    I've kept the A-b tag given at that time.

v1: https://lore.kernel.org/all/81f44a41b7ccceb26a802af473f931799445821a.1705683269.git.christophe.jaillet@wanadoo.fr/
---
 tools/testing/radix-tree/idr-test.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 84b8c3c92c79..2f830ff8396c 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -499,19 +499,17 @@ void ida_check_random(void)
 		goto repeat;
 }
 
-void ida_simple_get_remove_test(void)
+void ida_alloc_free_test(void)
 {
 	DEFINE_IDA(ida);
 	unsigned long i;
 
-	for (i = 0; i < 10000; i++) {
-		assert(ida_simple_get(&ida, 0, 20000, GFP_KERNEL) == i);
-	}
-	assert(ida_simple_get(&ida, 5, 30, GFP_KERNEL) < 0);
+	for (i = 0; i < 10000; i++)
+		assert(ida_alloc_max(&ida, 20000, GFP_KERNEL) == i);
+	assert(ida_alloc_range(&ida, 5, 30, GFP_KERNEL) < 0);
 
-	for (i = 0; i < 10000; i++) {
-		ida_simple_remove(&ida, i);
-	}
+	for (i = 0; i < 10000; i++)
+		ida_free(&ida, i);
 	assert(ida_is_empty(&ida));
 
 	ida_destroy(&ida);
@@ -524,7 +522,7 @@ void user_ida_checks(void)
 	ida_check_nomem();
 	ida_check_conv_user();
 	ida_check_random();
-	ida_simple_get_remove_test();
+	ida_alloc_free_test();
 
 	radix_tree_cpu_dead(1);
 }
-- 
2.50.1


