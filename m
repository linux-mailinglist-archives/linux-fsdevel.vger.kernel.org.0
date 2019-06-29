Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA19B5A974
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 09:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfF2Hao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 03:30:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2960 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfF2Hao (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 03:30:44 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 09ED22C58F7AE824AD79;
        Sat, 29 Jun 2019 15:30:40 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 29 Jun 2019 15:30:39 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 29 Jun 2019 15:30:39 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <hch@infradead.org>, <darrick.wong@oracle.com>
CC:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <gaoxiang25@huawei.com>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH RFC] iomap: introduce IOMAP_TAIL
Date:   Sat, 29 Jun 2019 15:30:20 +0800
Message-ID: <20190629073020.22759-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some filesystems like erofs/reiserfs have the ability to pack tail
data into metadata, however iomap framework can only support mapping
inline data with IOMAP_INLINE type, it restricts that:
- inline data should be locating at page #0.
- inline size should equal to .i_size
So we can not use IOMAP_INLINE to handle tail-packing case.

This patch introduces new mapping type IOMAP_TAIL to map tail-packed
data for further use of erofs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/iomap.c            | 22 ++++++++++++++++++++++
 include/linux/iomap.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/fs/iomap.c b/fs/iomap.c
index 12654c2e78f8..ae7777ce77d0 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -280,6 +280,23 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
 	SetPageUptodate(page);
 }
 
+static void
+iomap_read_tail_data(struct inode *inode, struct page *page,
+		struct iomap *iomap)
+{
+	size_t size = i_size_read(inode) & (PAGE_SIZE - 1);
+	void *addr;
+
+	if (PageUptodate(page))
+		return;
+
+	addr = kmap_atomic(page);
+	memcpy(addr, iomap->inline_data, size);
+	memset(addr + size, 0, PAGE_SIZE - size);
+	kunmap_atomic(addr);
+	SetPageUptodate(page);
+}
+
 static loff_t
 iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		struct iomap *iomap)
@@ -298,6 +315,11 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		return PAGE_SIZE;
 	}
 
+	if (iomap->type == IOMAP_TAIL) {
+		iomap_read_tail_data(inode, page, iomap);
+		return PAGE_SIZE;
+	}
+
 	/* zero post-eof blocks as the page may be mapped */
 	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
 	if (plen == 0)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 2103b94cb1bf..7e1ee48e3db7 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -25,6 +25,7 @@ struct vm_fault;
 #define IOMAP_MAPPED	0x03	/* blocks allocated at @addr */
 #define IOMAP_UNWRITTEN	0x04	/* blocks allocated at @addr in unwritten state */
 #define IOMAP_INLINE	0x05	/* data inline in the inode */
+#define IOMAP_TAIL	0x06	/* tail data packed in metdata */
 
 /*
  * Flags for all iomap mappings:
-- 
2.18.0.rc1

