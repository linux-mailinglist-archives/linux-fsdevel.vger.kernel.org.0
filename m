Return-Path: <linux-fsdevel+bounces-17638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 411DA8B0BBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 15:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF32F28CDFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD47315E20A;
	Wed, 24 Apr 2024 13:59:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC0615AAB6
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967181; cv=none; b=UPIHAZkX23wtKw1UjrLluiIBAQoybfVRjhO9Wy2Ehnr/omo36rln0zGehdpga4AXxAzdEQTcozsOwUYDoA3x9WKOIpUyCqe5v0sHiXRdROeRAlY03dflRvPEVFXikOgR7W8UmzWl8KTlFqbL4wlojPUuaUs+RChCFYRS2PZSUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967181; c=relaxed/simple;
	bh=MGBN0oQU5bNQMJ00CB2GYFvNOHU5lHFIZ3bklXRIbiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2nWAOwYBdIpu6jq62ZoE9Teuxd88xCcGtAnCDjBETY7lIXXd23jf456Nc28cQC3ksj6SL5aYySoETjqr2pcx/wSETJtdORJ37jEV8lEfXz9qntGeLUQI/pB+thbj3p5dp6LxIq/8U9RQPQMyCKlT9wb2XAb+RMffdxXQoASg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VPgYx5036zShf3;
	Wed, 24 Apr 2024 21:58:29 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 58825180080;
	Wed, 24 Apr 2024 21:59:34 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:59:33 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Miaohe Lin <linmiaohe@huawei.com>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>,
	Benjamin LaHaise <bcrl@kvack.org>, <jglisse@redhat.com>,
	<linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>, Zi Yan
	<ziy@nvidia.com>, Jiaqi Yan <jiaqiyan@google.com>, Hugh Dickins
	<hughd@google.com>, Vishal Moola <vishal.moola@gmail.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH v2 01/10] mm: migrate: simplify __buffer_migrate_folio()
Date: Wed, 24 Apr 2024 21:59:20 +0800
Message-ID: <20240424135929.2847185-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240424135929.2847185-1-wangkefeng.wang@huawei.com>
References: <20240424135929.2847185-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Use filemap_migrate_folio() helper to simplify __buffer_migrate_folio().

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4fbc7ff39da3..9cc5a3e1d97c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -803,24 +803,16 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 		}
 	}
 
-	rc = folio_migrate_mapping(mapping, dst, src, 0);
+	rc = filemap_migrate_folio(mapping, dst, src, mode);
 	if (rc != MIGRATEPAGE_SUCCESS)
 		goto unlock_buffers;
 
-	folio_attach_private(dst, folio_detach_private(src));
-
 	bh = head;
 	do {
 		folio_set_bh(bh, dst, bh_offset(bh));
 		bh = bh->b_this_page;
 	} while (bh != head);
 
-	if (mode != MIGRATE_SYNC_NO_COPY)
-		folio_migrate_copy(dst, src);
-	else
-		folio_migrate_flags(dst, src);
-
-	rc = MIGRATEPAGE_SUCCESS;
 unlock_buffers:
 	if (check_refs)
 		spin_unlock(&mapping->i_private_lock);
-- 
2.27.0


