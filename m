Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D1B44A8EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbhKIIgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244192AbhKIIgi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D378AC0613F5;
        Tue,  9 Nov 2021 00:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SW8Zo8xNPpf5PRQj/yoxD2eK+vSZCdgKjxBBcNAut5E=; b=IAd2z0n4+rSaZjOAQAcHkUiG7e
        AHKwIW3QT0BU34bqCQuvoimP884y7lMTrSi4ev67fFNWoK1dDvk5amFAb1n/57yJ+Cb+3n1zj4Gbe
        YQPgAi5L5rz7YsX4eE0j3hCuAMWPdWSq6kU6krKBw+bSRtv/zYPnHKCRNminIPWP6laGvD1ySu1/T
        onyeNMCfFyCWBxzeP2yuXUxNRqQg/kDKSkylEst+HmEWCXAPXsfje13JJ/FKQNbF/0EmnJ+G2P9v1
        SSDU4goh3tuk4pjnxSDpwGrNlqzT2hYG7o05V7aC4jrXohtehEvjw1MAGEkXVzVVTQXeoF3k/MQXg
        T5uHRctQ==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZb-000s5r-P1; Tue, 09 Nov 2021 08:33:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 17/29] fsdax: factor out a dax_memzero helper
Date:   Tue,  9 Nov 2021 09:32:57 +0100
Message-Id: <20211109083309.584081-18-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out a helper for the "manual" zeroing of a DAX range to clean
up dax_iomap_zero a lot.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index d7a923d152240..dc9ebeff850ab 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1121,34 +1121,36 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 }
 #endif /* CONFIG_FS_DAX_PMD */
 
+static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
+		unsigned int offset, size_t size)
+{
+	void *kaddr;
+	long rc;
+
+	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+	if (rc >= 0) {
+		memset(kaddr + offset, 0, size);
+		dax_flush(dax_dev, kaddr + offset, size);
+	}
+	return rc;
+}
+
 s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 {
 	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 	long rc, id;
-	void *kaddr;
-	bool page_aligned = false;
 	unsigned offset = offset_in_page(pos);
 	unsigned size = min_t(u64, PAGE_SIZE - offset, length);
 
-	if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
-		page_aligned = true;
-
 	id = dax_read_lock();
-
-	if (page_aligned)
+	if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
 		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
 	else
-		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
-	if (rc < 0) {
-		dax_read_unlock(id);
-		return rc;
-	}
-
-	if (!page_aligned) {
-		memset(kaddr + offset, 0, size);
-		dax_flush(iomap->dax_dev, kaddr + offset, size);
-	}
+		rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
 	dax_read_unlock(id);
+
+	if (rc < 0)
+		return rc;
 	return size;
 }
 
-- 
2.30.2

