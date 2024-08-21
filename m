Return-Path: <linux-fsdevel+bounces-26448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6276895951E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5B6284711
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08BE185B78;
	Wed, 21 Aug 2024 06:52:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4302185B71
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223124; cv=none; b=ssJQl1Iu4X6QQM9QCQ1Lbea6CuCw//eFzMWvGqgRibiycSTl6mLpR5/JBjML4M99M74cM9g1Hoxh5H718yuLtQkb4t/Uo9MFR+8sGsS0Nb/gCAbLHvy6uASrRKGHKFBJCCEaRw2Gp6/byRz8V2u+rpFvplicAevlOg5Vhhs2mps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223124; c=relaxed/simple;
	bh=5mLEtsI17v7q8253a/h5PjlzyzdGj72nAReJQXa0qHA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NLAuiS7Alux/gjURKeEbTq65boaXXtjCnlUxAZubcA+XmKBofo/ralOXp8RLNjZ34i+XGbkstf2D4PBXqU7w4rSQgWr1k8hbHpBWhOpC8liD4u+13pNoQBw7PBRqyxXWTCgEqEsP7WSyKNb7WlyXLvijsP+F7Ly3IKt+gk6VHM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WpcSt0c9Kz1j6ck;
	Wed, 21 Aug 2024 14:51:58 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 04E221401F3;
	Wed, 21 Aug 2024 14:52:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 14:51:59 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <willy@infradead.org>
CC: <lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH -next] radix tree test suite: Remove usage of the deprecated ida_simple_xx() API
Date: Wed, 21 Aug 2024 14:59:27 +0800
Message-ID: <20240821065927.2298383-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but
the one of ida_alloc_max() is inclusive. So a -1 has been added
when needed.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 tools/testing/radix-tree/idr-test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 84b8c3c92c79..06ad10b5719c 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -499,18 +499,18 @@ void ida_check_random(void)
 		goto repeat;
 }
 
-void ida_simple_get_remove_test(void)
+void ida_alloc_free_test(void)
 {
 	DEFINE_IDA(ida);
 	unsigned long i;
 
 	for (i = 0; i < 10000; i++) {
-		assert(ida_simple_get(&ida, 0, 20000, GFP_KERNEL) == i);
+		assert(ida_alloc_max(&ida, 0, 19999, GFP_KERNEL) == i);
 	}
-	assert(ida_simple_get(&ida, 5, 30, GFP_KERNEL) < 0);
+	assert(ida_alloc_max(&ida, 5, 29, GFP_KERNEL) < 0);
 
 	for (i = 0; i < 10000; i++) {
-		ida_simple_remove(&ida, i);
+		ida_free(&ida, i);
 	}
 	assert(ida_is_empty(&ida));
 
@@ -524,7 +524,7 @@ void user_ida_checks(void)
 	ida_check_nomem();
 	ida_check_conv_user();
 	ida_check_random();
-	ida_simple_get_remove_test();
+	ida_alloc_free_test();
 
 	radix_tree_cpu_dead(1);
 }
-- 
2.34.1


