Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDA5414F48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 19:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhIVRkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbhIVRkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:40:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3713BC061574;
        Wed, 22 Sep 2021 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ohPa6Lwajw8vhCwLerBSIvFxJRh0fJUxeCrs38Mhz8E=; b=p7vqj/kBah76bp7Eus/YxKDd6A
        y1HfkQz1Yrzsf/lnZytkvzmzWXWkHpgpwsTBPEmdsEku2ZBkqpiFHCfOQphgwmal2vDhzCAHj8hy5
        +YiWpjpdzeCerqNyrh217vz1NQfleiDwuqsYch4tVFHv6Ubgs/juzuhcorEU9dEaig1UqJvTOBTHk
        3S+bN7RA6pUug/G93DTj03Z5FTT8ETti9kYjNBavnvXn5uMpBYPfNYuGpVwmAzVuVXkB1qG+XLh8B
        +1Fz8bZccV1omIRQtQ8AqJdtdxP2yaTiAXcRGZG0nwEgxIU0mcD19vwhhgkcCgMBIDghhTmERe5vV
        YIGssr6A==;
Received: from [2001:4bb8:184:72db:3a8e:1992:6715:6960] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT6A5-004zgD-CL; Wed, 22 Sep 2021 17:36:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 1/3] nvdimm/pmem: fix creating the dax group
Date:   Wed, 22 Sep 2021 19:34:29 +0200
Message-Id: <20210922173431.2454024-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922173431.2454024-1-hch@lst.de>
References: <20210922173431.2454024-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The recent block layer refactoring broke the way how the pmem driver
abused device_add_disk.  Fix this by properly passing the attribute groups
to device_add_disk.

Fixes: 52b85909f85d ("block: fold register_disk into device_add_disk")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pmem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 72de88ff0d30d..ef4950f808326 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -380,7 +380,6 @@ static int pmem_attach_disk(struct device *dev,
 	struct nd_pfn_sb *pfn_sb;
 	struct pmem_device *pmem;
 	struct request_queue *q;
-	struct device *gendev;
 	struct gendisk *disk;
 	void *addr;
 	int rc;
@@ -489,10 +488,8 @@ static int pmem_attach_disk(struct device *dev,
 	}
 	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
 	pmem->dax_dev = dax_dev;
-	gendev = disk_to_dev(disk);
-	gendev->groups = pmem_attribute_groups;
 
-	device_add_disk(dev, disk, NULL);
+	device_add_disk(dev, disk, pmem_attribute_groups);
 	if (devm_add_action_or_reset(dev, pmem_release_disk, pmem))
 		return -ENOMEM;
 
-- 
2.30.2

