Return-Path: <linux-fsdevel+bounces-10440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53D84B354
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A736BB22F77
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E406DCF7;
	Tue,  6 Feb 2024 11:21:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD9F12DDBF
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218507; cv=none; b=RbVGYEEpmaXMYc4hCYoUIF5cGcwYd/knxkdtSZ6hepepNNTvHkXNx7kqRgW12Gzzy1c608y3pnmdfoo3Y/nz4ypww1ba3jVB2P5qz8zEQ8qmyAW8WVmjmPdMR+KtGm72q6hLKFH66g9ploHkDGVmtW4o6Ah1Yje/Zp3K5Im7w+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218507; c=relaxed/simple;
	bh=RX+s0EU1kavFHnBNw5taNO0fT2YrXjR6SoDqdDo0yng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEIMID+Yj0+DKCcCm3QBYRIRexLm2Z6Z1cBeorrNA/FnVRdHotKfuaddJSiNytK2r3MWqmpBdVaOPeLxyAGS5tmdv2EGAy3wgPYHWc0wEY7xgd9ppTgubTxJkXoFOOmAG4ryST0Zkkuub24Q7RVwol6SKCoWmgRGl9wUpK8Z4Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TTgkq3gvWz29lQy;
	Tue,  6 Feb 2024 19:19:47 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4145C140412;
	Tue,  6 Feb 2024 19:21:43 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 19:21:42 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfcv2 01/11] mm: migrate: simplify __buffer_migrate_folio()
Date: Tue, 6 Feb 2024 19:21:24 +0800
Message-ID: <20240206112134.1479464-2-wangkefeng.wang@huawei.com>
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

Use filemap_migrate_folio() helper to simplify __buffer_migrate_folio().

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index cc9f2bcd73b4..cdae25b7105f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -774,24 +774,16 @@ static int __buffer_migrate_folio(struct address_space *mapping,
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


