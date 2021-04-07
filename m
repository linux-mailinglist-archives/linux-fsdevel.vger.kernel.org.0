Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713003563FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 08:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345757AbhDGGdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 02:33:00 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15974 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345707AbhDGGc5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:32:57 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AuPhIqq/2r5rmj5npc+luk+A4I+orLtY04lQ7?=
 =?us-ascii?q?vn1ZYxpTb8CeioSSjO0WvCWE7Ao5dVMBvZS7OKeGSW7B7pId2+QsFJqrQQWOgg?=
 =?us-ascii?q?WVBa5v4YboyzfjXw3Sn9Q26Y5OaK57YeeQMXFfreLXpDa1CMwhxt7vytHMuc77?=
 =?us-ascii?q?w212RQ9nL4FMhj0JaTqzKUF9SAlYCZdRLvP1ifZvnSaqengcc62Adxs4dtXEzu?=
 =?us-ascii?q?eqqLvWJTYCBzMCrDKFlC6U7tfBeCSw71MzVCxuzN4ZnVT4rw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,201,1613404800"; 
   d="scan'208";a="106725748"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Apr 2021 14:32:46 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 1FA064D0B8A5;
        Wed,  7 Apr 2021 14:32:41 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 7 Apr 2021 14:32:30 +0800
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 7 Apr 2021 14:32:29 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 7 Apr 2021 14:32:29 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <david@fromorbit.com>, <hch@lst.de>,
        <rgoldwyn@suse.de>, Ritesh Harjani <riteshh@gmail.com>
Subject: [PATCH 3/3] fsdax: Output address in dax_iomap_pfn() and rename it
Date:   Wed, 7 Apr 2021 14:32:07 +0800
Message-ID: <20210407063207.676753-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210407063207.676753-1-ruansy.fnst@fujitsu.com>
References: <20210407063207.676753-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1FA064D0B8A5.A1FAE
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
Reviewed-by: Ritesh Harjani <riteshh@gmail.com>
---
 fs/dax.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 19fa22ab50fa..ec66207a3199 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -998,8 +998,8 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
 }
 
-static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
-			 pfn_t *pfnp)
+static int dax_iomap_direct_access(struct iomap *iomap, loff_t pos, size_t size,
+		void **kaddr, pfn_t *pfnp)
 {
 	const sector_t sector = dax_iomap_sector(iomap, pos);
 	pgoff_t pgoff;
@@ -1011,11 +1011,13 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
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
@@ -1025,6 +1027,12 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
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
@@ -1388,7 +1396,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
 		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
 	}
 
-	err = dax_iomap_pfn(iomap, pos, size, &pfn);
+	err = dax_iomap_direct_access(iomap, pos, size, NULL, &pfn);
 	if (err)
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 
-- 
2.31.0



