Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC163F8990
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 15:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242788AbhHZOAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 10:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242775AbhHZOAB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:00:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46FEC061757;
        Thu, 26 Aug 2021 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Vq6Cd9IZd5dWA8aYMKxJxZUuFeTEGrN9HJ2ANuQEyvY=; b=J1a+RytWWDB9xjL9xhkug5LFeJ
        erP+qmqdAV3Rqt1p4ZS6XeVYvrwBp997FNc3wo2kbJopud+yRF2lcG6EdfCkaJYvBGa+TI8eIHIE+
        Op6q/Bzd2JcCpCXzS4wd62lSxry0uSFPeFyjNmEqDg5hUxKjxZvVIH+1aAfftscy+jhUAQOtvqUjk
        Fgjliuvvex8fgktFng/LcgjFcF+LrGz9oEuNwIu4h67jOn8JlUTaWKk1urjcwh+5hCkL0pdaogCyj
        MvJvYtEZ0xY8ZJBhV8JFWo8F6EARgl3tZUs6H7nCN/R2DxRPXTJHHX+wzMhLTFcM49D1mvrl2clpi
        wgtalFIg==;
Received: from [2001:4bb8:193:fd10:d9d9:6c15:481b:99c4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJFs7-00DM6i-NY; Thu, 26 Aug 2021 13:56:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 2/9] dax: stop using bdevname
Date:   Thu, 26 Aug 2021 15:55:03 +0200
Message-Id: <20210826135510.6293-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826135510.6293-1-hch@lst.de>
References: <20210826135510.6293-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just use the %pg format specifier instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
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

