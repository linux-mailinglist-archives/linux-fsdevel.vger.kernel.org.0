Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FBE44A8F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244270AbhKIIgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244183AbhKIIgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8C2C061766;
        Tue,  9 Nov 2021 00:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YI5KXoTh/4gwEroExLHzFhWVvpPDf4+n7V/Xox3B544=; b=AwTyippiAZmoz/Kfz0zWZ1oNbr
        14RYnWC4s144kGri6OGi6exkkFBSqXwsho6c5f58x7DkOWCziZlBcyrUBi0QtIxOaDq2vKDf1d8YP
        QIs1cRsfc41v4e2hm2QP8vJ8qUMo2N7E0VFZyqxdRM1HDHGVuG9ysNhgE/yQ2HVlrziFbBvbO07yG
        IEkg0Krp6lFZS8nvD3l+q+d4Ysr9e+ItusH0opTuwyg+K08Lh0ajLUgazLtXCSCXwVdQ8mNqY/QTl
        i1oSVCDOOm9vyKUN93Mc59w3ssrysrc1Dr1bAqP2f+VDYnz3fWP1WlP4ea/Yz4ZJwC90/CTYuqv9E
        6K+f+qYQ==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZj-000s8n-3T; Tue, 09 Nov 2021 08:33:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 22/29] iomap: add a IOMAP_DAX flag
Date:   Tue,  9 Nov 2021 09:33:02 +0100
Message-Id: <20211109083309.584081-23-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a flag so that the file system can easily detect DAX operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c              | 7 ++++---
 include/linux/iomap.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5b52b878124ac..0bd6cdcbacfc4 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1180,7 +1180,7 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		.inode		= inode,
 		.pos		= pos,
 		.len		= len,
-		.flags		= IOMAP_ZERO,
+		.flags		= IOMAP_DAX | IOMAP_ZERO,
 	};
 	int ret;
 
@@ -1308,6 +1308,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		.inode		= iocb->ki_filp->f_mapping->host,
 		.pos		= iocb->ki_pos,
 		.len		= iov_iter_count(iter),
+		.flags		= IOMAP_DAX,
 	};
 	loff_t done = 0;
 	int ret;
@@ -1461,7 +1462,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		.inode		= mapping->host,
 		.pos		= (loff_t)vmf->pgoff << PAGE_SHIFT,
 		.len		= PAGE_SIZE,
-		.flags		= IOMAP_FAULT,
+		.flags		= IOMAP_DAX | IOMAP_FAULT,
 	};
 	vm_fault_t ret = 0;
 	void *entry;
@@ -1570,7 +1571,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	struct iomap_iter iter = {
 		.inode		= mapping->host,
 		.len		= PMD_SIZE,
-		.flags		= IOMAP_FAULT,
+		.flags		= IOMAP_DAX | IOMAP_FAULT,
 	};
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 	pgoff_t max_pgoff;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6d1b08d0ae930..146a7e3e3ea11 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -141,6 +141,7 @@ struct iomap_page_ops {
 #define IOMAP_NOWAIT		(1 << 5) /* do not block */
 #define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
 #define IOMAP_UNSHARE		(1 << 7) /* unshare_file_range */
+#define IOMAP_DAX		(1 << 8) /* DAX mapping */
 
 struct iomap_ops {
 	/*
-- 
2.30.2

