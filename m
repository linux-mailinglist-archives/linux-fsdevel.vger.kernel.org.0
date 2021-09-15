Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E715840C3D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 12:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbhIOKrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 06:47:12 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56868 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237427AbhIOKrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 06:47:11 -0400
IronPort-Data: =?us-ascii?q?A9a23=3ASqpd16KqD3wymFlMFE+RqpQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC80Gx302BRyTNOC2yHMv/fZGqgcop2atjn9EkPvZXXyoNqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+BzvuRGuK59yAkhPjVHuGU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToy+UltZq2ZNDs4esY?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQfpOKecCDi7qR/yGWDKRMA2c5GAEgoPIEw9PxwBGZ?=
 =?us-ascii?q?U//0EbjsKa3irmOOyxKOTS+9inM0vIcDneoQFtRlIwTjfS/RgXpHHR6TD4MRw3?=
 =?us-ascii?q?TEsi8QIFvHbD+IVayVoahvoYBBVPFoTTpUkk4+AgGfzcjhdgFaUvrYspWzSyhF?=
 =?us-ascii?q?hlrTgLrL9eteKbcFOggCUqwru5Wv+Bh0FJdq30iee/zSgi4fnmSL9RZJXGqa0+?=
 =?us-ascii?q?+BnhHWNyWEJTh4bT122pb++kEHWc9ZeLVEEvykjt64/8GS1QdTnGR61uniJulg?=
 =?us-ascii?q?bQdU4O+k77hydj7ra+C6HCWUeCD1MctorsIkxXzNC/kGIhdTBFzFpsaPTTXOb6?=
 =?us-ascii?q?6fSqim9fzUWRVLuzwdsoRAtuoGl+d9syEmUCIsLLUJ8tfWtcRmY/txAhHZWa20?=
 =?us-ascii?q?vsPM2?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ATzlyma9jaiH3t+1P/xFuk+C9I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCY0TiX2ra2TdZggvyMc6wxxZJhDo7+90cC7KBu2yXcc2/hzAV7IZmXbUQ?=
 =?us-ascii?q?WTQr1f0Q=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.85,295,1624291200"; 
   d="scan'208";a="114519057"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Sep 2021 18:45:51 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 9464D4D0DC6E;
        Wed, 15 Sep 2021 18:45:45 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 15 Sep 2021 18:45:35 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 15 Sep 2021 18:45:33 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <djwong@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>
Subject: [PATCH v9 4/8] fsdax: Convert dax_iomap_zero to iter model
Date:   Wed, 15 Sep 2021 18:44:57 +0800
Message-ID: <20210915104501.4146910-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 9464D4D0DC6E.A1441
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let dax_iomap_zero() support iter model.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c               | 3 ++-
 fs/iomap/buffered-io.c | 3 +--
 include/linux/dax.h    | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 41c93929f20b..4f346e25e488 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1209,8 +1209,9 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 }
 #endif /* CONFIG_FS_DAX_PMD */
 
-s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
+s64 dax_iomap_zero(struct iomap_iter *iter, loff_t pos, u64 length)
 {
+	const struct iomap *iomap = &iter->iomap;
 	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff;
 	long rc, id;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9cc5798423d1..84a861d3b3e0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -889,7 +889,6 @@ static s64 __iomap_zero_iter(struct iomap_iter *iter, loff_t pos, u64 length)
 
 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 {
-	struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
@@ -903,7 +902,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		s64 bytes;
 
 		if (IS_DAX(iter->inode))
-			bytes = dax_iomap_zero(pos, length, iomap);
+			bytes = dax_iomap_zero(iter, pos, length);
 		else
 			bytes = __iomap_zero_iter(iter, pos, length);
 		if (bytes < 0)
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 2619d94c308d..642de7ef1a10 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -13,6 +13,7 @@ typedef unsigned long dax_entry_t;
 
 struct iomap_ops;
 struct iomap;
+struct iomap_iter;
 struct dax_device;
 struct dax_operations {
 	/*
@@ -210,7 +211,7 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
-s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap);
+s64 dax_iomap_zero(struct iomap_iter *iter, loff_t pos, u64 length);
 static inline bool dax_mapping(struct address_space *mapping)
 {
 	return mapping->host && IS_DAX(mapping->host);
-- 
2.33.0



