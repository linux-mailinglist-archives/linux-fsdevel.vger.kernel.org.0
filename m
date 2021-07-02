Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32A93B9E25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 11:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhGBJ1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 05:27:21 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2133 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231301AbhGBJ1P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:27:15 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A14p3oa3VLAJhMaZWsNxtmwqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.83,316,1616428800"; 
   d="scan'208";a="110542369"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Jul 2021 17:24:42 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 79CBF4C36A19;
        Fri,  2 Jul 2021 17:24:39 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 2 Jul 2021 17:24:34 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 2 Jul 2021 17:24:33 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <hch@lst.de>, <riteshh@linux.ibm.com>
Subject: [RESEND PATCH v3 3/3] fsdax: Output address in dax_iomap_pfn() and rename it
Date:   Fri, 2 Jul 2021 17:23:57 +0800
Message-ID: <20210702092357.262744-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702092357.262744-1-ruansy.fnst@fujitsu.com>
References: <20210702092357.262744-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 79CBF4C36A19.A3639
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index acc548875fd4..f661227b49cd 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1009,8 +1009,8 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
 }
 
-static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
-			 pfn_t *pfnp)
+static int dax_iomap_direct_access(struct iomap *iomap, loff_t pos, size_t size,
+		void **kaddr, pfn_t *pfnp)
 {
 	const sector_t sector = dax_iomap_sector(iomap, pos);
 	pgoff_t pgoff;
@@ -1022,11 +1022,13 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
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
@@ -1036,6 +1038,12 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
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
@@ -1400,7 +1408,7 @@ static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
 		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
 	}
 
-	err = dax_iomap_pfn(iomap, pos, size, &pfn);
+	err = dax_iomap_direct_access(iomap, pos, size, NULL, &pfn);
 	if (err)
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 
-- 
2.32.0



