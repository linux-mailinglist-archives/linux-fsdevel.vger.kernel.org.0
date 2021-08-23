Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB503F4ACC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhHWMi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 08:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhHWMi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:38:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E9FC061575;
        Mon, 23 Aug 2021 05:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=f3QJCBRd5Xz9qi8mLbjeRflIBAzELswnsTz5cWwLWds=; b=MzfL0plYSboJkQt4xy1RavWFuk
        re0Opwe6lVXzwF8hDf5n/7ovBDqnVotdSreSwY2kR7fc1ZnLlGwNNlTjqEebzRfqXeLXt85TIz4KJ
        N6i/yVOaz9ikycHzfys5oM3hnPhB0NyPio3vZpjF5GdxAIIesgrEUChQe2SZOu4WBjJQ12LjC/C9X
        jHvZQP7XdpdFloX9fbh1Uox953x9rkDLI5ZvkXbj2WUN0M9pvxjmEARWFcCthnzwWWM7GXZdvegxa
        lomgQNmECMlvw7cnFYUdc41pyQBh8c6JdNLRQTnJu+v4SWLofgQiKYKm0gsbn1R9yyyoLoUZs7IYH
        L3cA+ErQ==;
Received: from [2001:4bb8:193:fd10:c6e8:3c08:6f8b:cbf0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI9Bl-009j2C-Je; Mon, 23 Aug 2021 12:36:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 2/9] dax: stop using bdevname
Date:   Mon, 23 Aug 2021 14:35:09 +0200
Message-Id: <20210823123516.969486-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210823123516.969486-1-hch@lst.de>
References: <20210823123516.969486-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just use the %pg format specifier instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/super.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 44736cbd446e..3e6d7e9ee34f 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -73,7 +73,6 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 {
 	bool dax_enabled = false;
 	pgoff_t pgoff, pgoff_end;
-	char buf[BDEVNAME_SIZE];
 	void *kaddr, *end_kaddr;
 	pfn_t pfn, end_pfn;
 	sector_t last_page;
@@ -81,29 +80,25 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	int err, id;
 
 	if (blocksize != PAGE_SIZE) {
-		pr_info("%s: error: unsupported blocksize for dax\n",
-				bdevname(bdev, buf));
+		pr_info("%pg: error: unsupported blocksize for dax\n", bdev);
 		return false;
 	}
 
 	if (!dax_dev) {
-		pr_debug("%s: error: dax unsupported by block device\n",
-				bdevname(bdev, buf));
+		pr_debug("%pg: error: dax unsupported by block device\n", bdev);
 		return false;
 	}
 
 	err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
 	if (err) {
-		pr_info("%s: error: unaligned partition for dax\n",
-				bdevname(bdev, buf));
+		pr_info("%pg: error: unaligned partition for dax\n", bdev);
 		return false;
 	}
 
 	last_page = PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
 	err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
 	if (err) {
-		pr_info("%s: error: unaligned partition for dax\n",
-				bdevname(bdev, buf));
+		pr_info("%pg: error: unaligned partition for dax\n", bdev);
 		return false;
 	}
 
@@ -112,8 +107,8 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
 
 	if (len < 1 || len2 < 1) {
-		pr_info("%s: error: dax access failed (%ld)\n",
-				bdevname(bdev, buf), len < 1 ? len : len2);
+		pr_info("%pg: error: dax access failed (%ld)\n",
+				bdev, len < 1 ? len : len2);
 		dax_read_unlock(id);
 		return false;
 	}
@@ -147,8 +142,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	dax_read_unlock(id);
 
 	if (!dax_enabled) {
-		pr_info("%s: error: dax support not enabled\n",
-				bdevname(bdev, buf));
+		pr_info("%pg: error: dax support not enabled\n", bdev);
 		return false;
 	}
 	return true;
-- 
2.30.2

