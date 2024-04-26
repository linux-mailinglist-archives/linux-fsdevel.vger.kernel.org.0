Return-Path: <linux-fsdevel+bounces-17885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF93F8B363F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 13:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14F01C21A0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 11:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E076E144D12;
	Fri, 26 Apr 2024 11:04:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D731448C0
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129442; cv=none; b=g5ouAg/Y9E5Lb0ouGscsrlo3OalJ4LIJG3ADSF/oAFi8G12+6GMKGLew6Af2muad+JMmDLwAcdfelzcZcapcffmHmvuo9tny1m8cZHi7/8OT8ZCu+TY12Yf9G/4GhFqspU4bwftxAga+QhoLdzTZLEPYw3U9WPZtXW87JHcKaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129442; c=relaxed/simple;
	bh=tzR3XdCEfmS2ZkWPhvbHV8Jec/WfmOU0PJhTLTgblx4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fP/dbVVA9quKoSOtBANGVyY55FhWJP24K67JPY9OkLZPHpuwc7yeYAjnyUwEgUkbKOL8Ck725hrO300UQ1deC8/ILbAMI4RV0KVbJw9FSdgfQ1tvfuIHZOuZD2cGEjew1Zg52MOfSpPg22Fg2Smw9bAuEez3QXa3BQmespEFOcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VQqX150ZMzvPrN;
	Fri, 26 Apr 2024 19:00:49 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 085E418005C;
	Fri, 26 Apr 2024 19:03:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 19:03:53 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	zhangyi <yi.zhang@huawei.com>
Subject: [PATCH] mm: use memalloc_nofs_save() in page_cache_ra_order()
Date: Fri, 26 Apr 2024 19:29:38 +0800
Message-ID: <20240426112938.124740-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
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

See commit f2c817bed58d ("mm: use memalloc_nofs_save in readahead
path"), ensure that page_cache_ra_order() do not attempt to reclaim
file-backed pages too, or it leads to a deadlock, found issue when
test ext4 large folio.

 INFO: task DataXceiver for:7494 blocked for more than 120 seconds.
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:DataXceiver for state:D stack:0     pid:7494  ppid:1      flags:0x00000200
 Call trace:
  __switch_to+0x14c/0x240
  __schedule+0x82c/0xdd0
  schedule+0x58/0xf0
  io_schedule+0x24/0xa0
  __folio_lock+0x130/0x300
  migrate_pages_batch+0x378/0x918
  migrate_pages+0x350/0x700
  compact_zone+0x63c/0xb38
  compact_zone_order+0xc0/0x118
  try_to_compact_pages+0xb0/0x280
  __alloc_pages_direct_compact+0x98/0x248
  __alloc_pages+0x510/0x1110
  alloc_pages+0x9c/0x130
  folio_alloc+0x20/0x78
  filemap_alloc_folio+0x8c/0x1b0
  page_cache_ra_order+0x174/0x308
  ondemand_readahead+0x1c8/0x2b8
  page_cache_async_ra+0x68/0xb8
  filemap_readahead.isra.0+0x64/0xa8
  filemap_get_pages+0x3fc/0x5b0
  filemap_splice_read+0xf4/0x280
  ext4_file_splice_read+0x2c/0x48 [ext4]
  vfs_splice_read.part.0+0xa8/0x118
  splice_direct_to_actor+0xbc/0x288
  do_splice_direct+0x9c/0x108
  do_sendfile+0x328/0x468
  __arm64_sys_sendfile64+0x8c/0x148
  invoke_syscall+0x4c/0x118
  el0_svc_common.constprop.0+0xc8/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x4c/0x1f8
  el0t_64_sync_handler+0xc0/0xc8
  el0t_64_sync+0x188/0x190

Cc: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/readahead.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/readahead.c b/mm/readahead.c
index 63d6000103f0..c1b23989d9ca 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -494,6 +494,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	pgoff_t index = readahead_index(ractl);
 	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark = index + ra->size - ra->async_size;
+	unsigned int nofs;
 	int err = 0;
 	gfp_t gfp = readahead_gfp_mask(mapping);
 
@@ -508,6 +509,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
 	}
 
+	/* See comment in page_cache_ra_unbounded() */
+	nofs = memalloc_nofs_save();
 	filemap_invalidate_lock_shared(mapping);
 	while (index <= limit) {
 		unsigned int order = new_order;
@@ -531,6 +534,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 
 	read_pages(ractl);
 	filemap_invalidate_unlock_shared(mapping);
+	memalloc_nofs_restore(nofs);
 
 	/*
 	 * If there were already pages in the page cache, then we may have
-- 
2.41.0


