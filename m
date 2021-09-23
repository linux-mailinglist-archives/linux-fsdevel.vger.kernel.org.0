Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE57415501
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 03:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbhIWBKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 21:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237852AbhIWBKq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:10:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF19C6109E;
        Thu, 23 Sep 2021 01:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632359356;
        bh=iZahWkK6AgIBtkoqokByR0E1+eyKtejBXJCDZTfg70U=;
        h=Date:From:To:Cc:Subject:From;
        b=btY1Bdc3iKmT2lK7y9xS1uoL0VxIJONnSOfkpehkXqPFPUznCrj258Rm2lBl0qVKB
         TRQUBY4tps+TSFfV9SrxzfuG6/Yv+HbU6FIUSCihuIsy1frzFrCvfR7W6HpjkHPyOP
         h2A2pQNNgEGRzt4+lW7BOABBOPKDcKllUXYABfnf98rJpGyIHuKdyJ/e+OJzLd9Okz
         C234Cp/HciJjGOW49J/JzjUQuIuSDjmp/xiFWTg0qgMrvAkSlt6KdAbb7f+TjzFfmF
         aY56agwhdUBuHPL5b/X/oM6u/wazVuaTZlVpNEYGuOMtNPlidHlDDtXL5h5xaGT18f
         t/+ncHhKyufeA==
Date:   Wed, 22 Sep 2021 18:09:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH] dax: remove silly single-page limitation in
 dax_zero_page_range
Message-ID: <20210923010915.GQ570615@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

It's totally silly that the dax zero_page_range implementations are
required to accept a page count, but one of the four implementations
silently ignores the page count and the wrapper itself errors out if you
try to do more than one page.

Fix the nvdimm implementation to loop over the page count and remove the
artificial limitation.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 drivers/dax/super.c   |    7 -------
 drivers/nvdimm/pmem.c |   14 +++++++++++---
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index fc89e91beea7..ca61a01f9ccd 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -353,13 +353,6 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 {
 	if (!dax_alive(dax_dev))
 		return -ENXIO;
-	/*
-	 * There are no callers that want to zero more than one page as of now.
-	 * Once users are there, this check can be removed after the
-	 * device mapper code has been updated to split ranges across targets.
-	 */
-	if (nr_pages != 1)
-		return -EIO;
 
 	return dax_dev->ops->zero_page_range(dax_dev, pgoff, nr_pages);
 }
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 72de88ff0d30..3ef40bf74168 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -288,10 +288,18 @@ static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 				    size_t nr_pages)
 {
 	struct pmem_device *pmem = dax_get_private(dax_dev);
+	int ret = 0;
 
-	return blk_status_to_errno(pmem_do_write(pmem, ZERO_PAGE(0), 0,
-				   PFN_PHYS(pgoff) >> SECTOR_SHIFT,
-				   PAGE_SIZE));
+	for (; nr_pages > 0 && ret == 0; pgoff++, nr_pages--) {
+		blk_status_t status;
+
+		status = pmem_do_write(pmem, ZERO_PAGE(0), 0,
+				       PFN_PHYS(pgoff) >> SECTOR_SHIFT,
+				       PAGE_SIZE);
+		ret = blk_status_to_errno(status);
+	}
+
+	return ret;
 }
 
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
