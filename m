Return-Path: <linux-fsdevel+bounces-15442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739FE88E7F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 16:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD5E1F376D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27F7138495;
	Wed, 27 Mar 2024 14:33:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF25D2E62C
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549985; cv=none; b=MJPreGVFunN9oyQDd56zBOrT3n+o3cuA88oAV+jmnd3EEiTvN71T4078yXcxTiXt8li5v0mEmKgjyTS5VHdtcs1o21DcF8XAUUrmq3uQeWL2LMw7nv7fXT1AR8c0sgxAnAiTYEVKcOC1y6PRnVhZbWqx20YDBXjEmCTbkiBWe64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549985; c=relaxed/simple;
	bh=mbAcfd4WiOYflAu8Aae6TJT4AtCFOLzjh5Bg8ZV20Yg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WOb1PQmfls2jHxFiqYlqh7FdmLOUcAv1Z2yxMRJRDtVx/OlXBMSv1zQeW4v6WiKm23xhCDyh+F7BSQodbohrqtmN02GAvQqVksu+D2NcH7udt5KMuq08YtEcVdH04DkcROf+mZk9m18CeHoHxwl/Fg7h9pnXggy18C6vTX0haPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V4Tdk6JRWz1wnLT;
	Wed, 27 Mar 2024 22:32:10 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4752F1400C8;
	Wed, 27 Mar 2024 22:33:00 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 22:32:59 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: remove __set_page_dirty_nobuffers()
Date: Wed, 27 Mar 2024 22:30:08 +0800
Message-ID: <20240327143008.3739435-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
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

There are no more callers of __set_page_dirty_nobuffers(), remove it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/pagemap.h | 1 -
 mm/folio-compat.c       | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 35636e67e2e1..9e988f6f0bb0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1163,7 +1163,6 @@ static inline void folio_cancel_dirty(struct folio *folio)
 bool folio_clear_dirty_for_io(struct folio *folio);
 bool clear_page_dirty_for_io(struct page *page);
 void folio_invalidate(struct folio *folio, size_t offset, size_t length);
-int __set_page_dirty_nobuffers(struct page *page);
 bool noop_dirty_folio(struct address_space *mapping, struct folio *folio);
 
 #ifdef CONFIG_MIGRATION
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 50412014f16f..f31e0ce65b11 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -58,12 +58,6 @@ bool set_page_dirty(struct page *page)
 }
 EXPORT_SYMBOL(set_page_dirty);
 
-int __set_page_dirty_nobuffers(struct page *page)
-{
-	return filemap_dirty_folio(page_mapping(page), page_folio(page));
-}
-EXPORT_SYMBOL(__set_page_dirty_nobuffers);
-
 bool clear_page_dirty_for_io(struct page *page)
 {
 	return folio_clear_dirty_for_io(page_folio(page));
-- 
2.41.0


