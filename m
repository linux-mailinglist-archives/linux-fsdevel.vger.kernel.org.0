Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB867E8ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfD2R11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:27:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:58202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728928AbfD2R1X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:27:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2A3BAADD7;
        Mon, 29 Apr 2019 17:27:22 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     kilobyte@angband.pl, linux-fsdevel@vger.kernel.org, jack@suse.cz,
        david@fromorbit.com, willy@infradead.org, hch@lst.de,
        darrick.wong@oracle.com, dsterba@suse.cz, nborisov@suse.com,
        linux-nvdimm@lists.01.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 08/18] dax: memcpy page in case of IOMAP_DAX_COW for mmap faults
Date:   Mon, 29 Apr 2019 12:26:39 -0500
Message-Id: <20190429172649.8288-9-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190429172649.8288-1-rgoldwyn@suse.de>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Change dax_iomap_pfn to return the address as well in order to
use it for performing a memcpy in case the type is IOMAP_DAX_COW.
We don't handle PMD because btrfs does not support hugepages.

Question:
The sequence of bdev_dax_pgoff() and dax_direct_access() is
used multiple times to calculate address and pfn's. Would it make
sense to call it while calculating address as well to reduce code?

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/dax.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 610bfa861a28..718b1632a39d 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -984,7 +984,7 @@ static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
 }
 
 static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
-			 pfn_t *pfnp)
+			 pfn_t *pfnp, void **addr)
 {
 	const sector_t sector = dax_iomap_sector(iomap, pos);
 	pgoff_t pgoff;
@@ -996,7 +996,7 @@ static int dax_iomap_pfn(struct iomap *iomap, loff_t pos, size_t size,
 		return rc;
 	id = dax_read_lock();
 	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
-				   NULL, pfnp);
+				   addr, pfnp);
 	if (length < 0) {
 		rc = length;
 		goto out;
@@ -1286,6 +1286,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
 	struct inode *inode = mapping->host;
 	unsigned long vaddr = vmf->address;
+	void *addr;
 	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
 	struct iomap iomap = { 0 };
 	unsigned flags = IOMAP_FAULT;
@@ -1375,16 +1376,26 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	sync = dax_fault_is_synchronous(flags, vma, &iomap);
 
 	switch (iomap.type) {
+	case IOMAP_DAX_COW:
 	case IOMAP_MAPPED:
 		if (iomap.flags & IOMAP_F_NEW) {
 			count_vm_event(PGMAJFAULT);
 			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
 			major = VM_FAULT_MAJOR;
 		}
-		error = dax_iomap_pfn(&iomap, pos, PAGE_SIZE, &pfn);
+		error = dax_iomap_pfn(&iomap, pos, PAGE_SIZE, &pfn, &addr);
 		if (error < 0)
 			goto error_finish_iomap;
 
+		if (iomap.type == IOMAP_DAX_COW) {
+			if (iomap.inline_data) {
+				error = memcpy_mcsafe(addr, iomap.inline_data,
+					      PAGE_SIZE);
+				if (error < 0)
+					goto error_finish_iomap;
+			} else
+				memset(addr, 0, PAGE_SIZE);
+		}
 		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
 						 0, write && !sync);
 
@@ -1597,7 +1608,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 	switch (iomap.type) {
 	case IOMAP_MAPPED:
-		error = dax_iomap_pfn(&iomap, pos, PMD_SIZE, &pfn);
+		error = dax_iomap_pfn(&iomap, pos, PMD_SIZE, &pfn, NULL);
 		if (error < 0)
 			goto finish_iomap;
 
-- 
2.16.4

