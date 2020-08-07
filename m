Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2EF23EDF0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 15:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHGNO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 09:14:29 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:4478 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726198AbgHGNOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:14:12 -0400
X-IronPort-AV: E=Sophos;i="5.75,445,1589212800"; 
   d="scan'208";a="97774934"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Aug 2020 21:13:54 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id BF32F4CE34EE;
        Fri,  7 Aug 2020 21:13:51 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 7 Aug 2020 21:13:40 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 7 Aug 2020 21:13:39 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH 4/8] fsdax: copy data before write
Date:   Fri, 7 Aug 2020 21:13:32 +0800
Message-ID: <20200807131336.318774-5-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: BF32F4CE34EE.AFF39
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add dax_copy_edges() into each dax actor functions to perform CoW.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/dax.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 308678c58d4d..65553e3f7602 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1208,7 +1208,8 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			return iov_iter_zero(min(length, end - pos), iter);
 	}
 
-	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
+	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
+			!(iomap->flags & IOMAP_F_SHARED)))
 		return -EIO;
 
 	/*
@@ -1247,6 +1248,12 @@ dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			break;
 		}
 
+		if (iomap != srcmap) {
+			ret = dax_copy_edges(pos, length, srcmap, kaddr, false);
+			if (ret)
+				break;
+		}
+
 		map_len = PFN_PHYS(map_len);
 		kaddr += offset;
 		map_len -= offset;
@@ -1358,6 +1365,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	vm_fault_t ret = 0;
 	void *entry;
 	pfn_t pfn;
+	void *kaddr;
 
 	trace_dax_pte_fault(inode, vmf, ret);
 	/*
@@ -1439,19 +1447,27 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 	switch (iomap.type) {
 	case IOMAP_MAPPED:
+cow:
 		if (iomap.flags & IOMAP_F_NEW) {
 			count_vm_event(PGMAJFAULT);
 			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
 			major = VM_FAULT_MAJOR;
 		}
 		error = dax_iomap_direct_access(&iomap, pos, PAGE_SIZE, &pfn,
-						NULL);
+						&kaddr);
 		if (error < 0)
 			goto error_finish_iomap;
 
 		entry = dax_insert_entry(&xas, mapping, vmf, iomap.addr, entry,
 					 pfn, 0, write && !sync);
 
+		if (srcmap.type != IOMAP_HOLE) {
+			error = dax_copy_edges(pos, PAGE_SIZE, &srcmap, kaddr,
+					       false);
+			if (error)
+				goto error_finish_iomap;
+		}
+
 		/*
 		 * If we are doing synchronous page fault and inode needs fsync,
 		 * we can insert PTE into page tables only after that happens.
@@ -1475,12 +1491,15 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 		goto finish_iomap;
 	case IOMAP_UNWRITTEN:
+		if (write && iomap.flags & IOMAP_F_SHARED)
+			goto cow;
+		fallthrough;
 	case IOMAP_HOLE:
 		if (!write) {
 			ret = dax_load_hole(&xas, mapping, &entry, vmf);
 			goto finish_iomap;
 		}
-		/*FALLTHRU*/
+		fallthrough;
 	default:
 		WARN_ON_ONCE(1);
 		error = -EIO;
@@ -1582,6 +1601,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	loff_t pos;
 	int error;
 	pfn_t pfn;
+	void *kaddr;
 
 	/*
 	 * Check whether offset isn't beyond end of file now. Caller is
@@ -1663,14 +1683,22 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 	switch (iomap.type) {
 	case IOMAP_MAPPED:
+cow:
 		error = dax_iomap_direct_access(&iomap, pos, PMD_SIZE, &pfn,
-						NULL);
+						&kaddr);
 		if (error < 0)
 			goto finish_iomap;
 
 		entry = dax_insert_entry(&xas, mapping, vmf, iomap.addr, entry,
 					 pfn, DAX_PMD, write && !sync);
 
+		if (srcmap.type != IOMAP_HOLE) {
+			error = dax_copy_edges(pos, PMD_SIZE, &srcmap, kaddr,
+					       true);
+			if (error)
+				goto unlock_entry;
+		}
+
 		/*
 		 * If we are doing synchronous page fault and inode needs fsync,
 		 * we can insert PMD into page tables only after that happens.
@@ -1689,6 +1717,9 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		result = vmf_insert_pfn_pmd(vmf, pfn, write);
 		break;
 	case IOMAP_UNWRITTEN:
+		if (write && iomap.flags & IOMAP_F_SHARED)
+			goto cow;
+		fallthrough;
 	case IOMAP_HOLE:
 		if (WARN_ON_ONCE(write))
 			break;
-- 
2.27.0



