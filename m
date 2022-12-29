Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027B2658ECA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 17:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiL2QLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 11:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiL2QLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:11:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2CB1111;
        Thu, 29 Dec 2022 08:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=x4y/4KuqfNuPAflIAi82X++2iXzPIgIv4Sol4IXfpIE=; b=hCkiJn6NwipyF95xZ/GfQjLDmb
        Si4sdlVrqYhOzIyOHDvE4X1IaWOLKGwwB/WyfjcmVjqFBn391Tx3NsE4ImwHez5KUQC/YOtFnd3mB
        r0I/7KTgno8i5rUd8vWxs5M/4cUs5R7OBibrzqx9/lV/aVXxlt4uKk9q1q5ScZ1TEx6FqrKHPk9Ow
        3MypnruGXVZJgQEhTyB8WJmJjakTwGYd+3QT1gdqttF5scQ2eSbdXz50yJDorlrrXTwZmCZInLwjR
        YllxS++9Um0yVvQk5aqOUb7TRQl9yf2UWXnv73HmIV5RLJGI6TFAVilzX/ndLItpgvO2wMHJZDKsO
        xGCE/zIA==;
Received: from rrcs-67-53-201-206.west.biz.rr.com ([67.53.201.206] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAvUQ-00HKPY-BW; Thu, 29 Dec 2022 16:10:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        linux-mm@kvack.org
Subject: [PATCH 6/6] mm: remove generic_writepages
Date:   Thu, 29 Dec 2022 06:10:31 -1000
Message-Id: <20221229161031.391878-7-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221229161031.391878-1-hch@lst.de>
References: <20221229161031.391878-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all external callers are gone, just fold it into do_writepages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/writeback.h |  2 --
 mm/page-writeback.c       | 53 +++++++++++----------------------------
 2 files changed, 15 insertions(+), 40 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 06f9291b6fd512..2554b71765e9d0 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -369,8 +369,6 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb);
 typedef int (*writepage_t)(struct page *page, struct writeback_control *wbc,
 				void *data);
 
-int generic_writepages(struct address_space *mapping,
-		       struct writeback_control *wbc);
 void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end);
 int write_cache_pages(struct address_space *mapping,
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ad608ef2a24365..dfeeceebba0ae0 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2526,12 +2526,8 @@ int write_cache_pages(struct address_space *mapping,
 }
 EXPORT_SYMBOL(write_cache_pages);
 
-/*
- * Function used by generic_writepages to call the real writepage
- * function and set the mapping flags on error
- */
-static int __writepage(struct page *page, struct writeback_control *wbc,
-		       void *data)
+static int writepage_cb(struct page *page, struct writeback_control *wbc,
+		void *data)
 {
 	struct address_space *mapping = data;
 	int ret = mapping->a_ops->writepage(page, wbc);
@@ -2539,34 +2535,6 @@ static int __writepage(struct page *page, struct writeback_control *wbc,
 	return ret;
 }
 
-/**
- * generic_writepages - walk the list of dirty pages of the given address space and writepage() all of them.
- * @mapping: address space structure to write
- * @wbc: subtract the number of written pages from *@wbc->nr_to_write
- *
- * This is a library function, which implements the writepages()
- * address_space_operation.
- *
- * Return: %0 on success, negative error code otherwise
- */
-int generic_writepages(struct address_space *mapping,
-		       struct writeback_control *wbc)
-{
-	struct blk_plug plug;
-	int ret;
-
-	/* deal with chardevs and other special file */
-	if (!mapping->a_ops->writepage)
-		return 0;
-
-	blk_start_plug(&plug);
-	ret = write_cache_pages(mapping, wbc, __writepage, mapping);
-	blk_finish_plug(&plug);
-	return ret;
-}
-
-EXPORT_SYMBOL(generic_writepages);
-
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	int ret;
@@ -2577,11 +2545,20 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 	wb = inode_to_wb_wbc(mapping->host, wbc);
 	wb_bandwidth_estimate_start(wb);
 	while (1) {
-		if (mapping->a_ops->writepages)
+		if (mapping->a_ops->writepages) {
 			ret = mapping->a_ops->writepages(mapping, wbc);
-		else
-			ret = generic_writepages(mapping, wbc);
-		if ((ret != -ENOMEM) || (wbc->sync_mode != WB_SYNC_ALL))
+		} else if (mapping->a_ops->writepage) {
+			struct blk_plug plug;
+
+			blk_start_plug(&plug);
+			ret = write_cache_pages(mapping, wbc, writepage_cb,
+						mapping);
+			blk_finish_plug(&plug);
+		} else {
+			/* deal with chardevs and other special files */
+			ret = 0;
+		}
+		if (ret != -ENOMEM || wbc->sync_mode != WB_SYNC_ALL)
 			break;
 
 		/*
-- 
2.35.1

