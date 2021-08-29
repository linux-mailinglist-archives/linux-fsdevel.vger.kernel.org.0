Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BF73FAB55
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhH2M03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 08:26:29 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:57118 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235255AbhH2M00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:26:26 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ApYVjQ69v+m6hu8mGYMhuk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,361,1620662400"; 
   d="scan'208";a="113656444"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Aug 2021 20:25:31 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 2221E4D0D9D0;
        Sun, 29 Aug 2021 20:25:29 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 29 Aug 2021 20:25:28 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 29 Aug 2021 20:25:30 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 29 Aug 2021 20:25:27 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <djwong@kernel.org>, <hch@lst.de>, <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH v8 1/7] fsdax: Output address in dax_iomap_pfn() and rename it
Date:   Sun, 29 Aug 2021 20:25:11 +0800
Message-ID: <20210829122517.1648171-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com>
References: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 2221E4D0D9D0.A0D76
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add address output in dax_iomap_pfn() in order to perform a memcpy() in
CoW case.  Since this function both output address and pfn, rename it to
dax_iomap_direct_access().

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 118c9e2923f5..9fb6218f42be 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1010,8 +1010,8 @@ static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
 	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
 }
 
-static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
-			 pfn_t *pfnp)
+static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
+		size_t size, void **kaddr, pfn_t *pfnp)
 {
 	const sector_t sector = dax_iomap_sector(iomap, pos);
 	pgoff_t pgoff;
@@ -1023,11 +1023,13 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
 		return rc;
 	id = dax_read_lock();
 	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
-				   NULL, pfnp);
+				   kaddr, pfnp);
 	if (length < 0) {
 		rc = length;
 		goto out;
 	}
+	if (!pfnp)
+		goto out_check_addr;
 	rc = -EINVAL;
 	if (PFN_PHYS(length) < size)
 		goto out;
@@ -1037,6 +1039,12 @@ static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
 	if (length > 1 && !pfn_t_devmap(*pfnp))
 		goto out;
 	rc = 0;
+
+out_check_addr:
+	if (!kaddr)
+		goto out;
+	if (!*kaddr)
+		rc = -EFAULT;
 out:
 	dax_read_unlock(id);
 	return rc;
@@ -1401,7 +1409,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
 	}
 
-	err = dax_iomap_pfn(&iter->iomap, pos, size, &pfn);
+	err = dax_iomap_direct_access(&iter->iomap, pos, size, NULL, &pfn);
 	if (err)
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 
-- 
2.32.0



