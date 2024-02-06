Return-Path: <linux-fsdevel+bounces-10450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C60884B35E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD10B2203F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5C912EBF0;
	Tue,  6 Feb 2024 11:21:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74112B14E
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218513; cv=none; b=WLQ1qEgFkjsAgVCurEJX54R0TTbdn9k5ZBeW4ixLWhJ+ZHNur7CAwto16AAAUV0rpmV7hBW1uRdqFBNeB7jCtB/vK6TkTmtzxlwsTR719frWGQwBJ14JV/FO80C1uPt8dH99GoLqV+U0u5BoJ/WUCDEYZUw6zqPTuSNRDzbqVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218513; c=relaxed/simple;
	bh=n1A+mzCBNMb80PHB/cvvTN9Ru3rYHX7Es02qW9IK6RI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okvQCcMI6g0+joxf0+6ON5FGD7ctQy/kQFfUJE97DGG6hfw6rvDvhxnE+KtIqx3Ly+dVjUASTHvO1frGsflbV9Y8z1ul5AlehPEjBFyzkytA8M3ws5MsAoIj1lbNybLxD8Xz7oj/FNOKlPLBwpMMemJstpd5fFHahPrXAQPCF5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TTgkx3LWHz1Q8qj;
	Tue,  6 Feb 2024 19:19:53 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A3ED140412;
	Tue,  6 Feb 2024 19:21:49 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 19:21:48 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfcv2 11/11] fs: aio: add explicit check for large folio in aio_migrate_folio()
Date: Tue, 6 Feb 2024 19:21:34 +0800
Message-ID: <20240206112134.1479464-12-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240206112134.1479464-1-wangkefeng.wang@huawei.com>
References: <20240206112134.1479464-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Since large folio copy could spend lots of time and it is involved with
a cond_resched(), the aio couldn't support migrate large folio as it takes
a spin lock when folio copy, add explicit check for large folio and return
err directly.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/aio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index 631e83eee5a1..372f22b85b11 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -411,6 +411,10 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
 	pgoff_t idx;
 	int rc = 0;
 
+	/* Large folios aren't supported */
+	if (folio_test_large(src))
+		return -EINVAL;
+
 	/* mapping->i_private_lock here protects against the kioctx teardown.  */
 	spin_lock(&mapping->i_private_lock);
 	ctx = mapping->i_private_data;
-- 
2.27.0


