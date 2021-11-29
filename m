Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5D246138B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377276AbhK2LNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376966AbhK2LLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:11:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6B9C0613B3;
        Mon, 29 Nov 2021 02:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XHcqPgm0fqvLtphqxdmDNoSl5+oSPu60OAGnlh9s0gw=; b=WJ8o63EsFNjjp1GQdMNazwT11E
        BfTT9E4uR8M+3tv7Gdk5oW0tQ8C5YJDHw4GvZsPXZMnLzttEuf5o8MdWEURf0bKUJE3l3tupFz3nw
        rDlE1/aIniKf+/L4SrJ7PkPlV0VLcEBfVdv0NYRIulVDlfGv38ZX2H94c+lDTkw4ksU4LMPJnVJ4n
        WPC6wAiFzJR0XbLJoPV8Z33juoA6+NpLpjkLeFzYSPGYhMDw6EQVb0dAu+CldT2SxWVIBta6mSr+8
        FGb7NRs7WMHuk4kqVtfuZLJElwegfPt0Om3fGt5SxxmcoTfG481+WNghGsqvuMpx5BpQ6ftenMSsl
        p63Ed1vg==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdo1-0073YT-9F; Mon, 29 Nov 2021 10:22:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 27/29] dax: fix up some of the block device related ifdefs
Date:   Mon, 29 Nov 2021 11:22:01 +0100
Message-Id: <20211129102203.2243509-28-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The DAX device <-> block device association is only enabled if
CONFIG_BLOCK is enabled.  Update dax.h to account for that and use
the right conditions for the fs_put_dax stub as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 include/linux/dax.h | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index f6f353382cc90..87ae4c9b1d65b 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -108,24 +108,15 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 #endif
 
 struct writeback_control;
-#if IS_ENABLED(CONFIG_FS_DAX)
+#if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
 int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
 void dax_remove_host(struct gendisk *disk);
-
+struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
+		u64 *start_off);
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
 	put_dax(dax_dev);
 }
-
-struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
-		u64 *start_off);
-int dax_writeback_mapping_range(struct address_space *mapping,
-		struct dax_device *dax_dev, struct writeback_control *wbc);
-
-struct page *dax_layout_busy_page(struct address_space *mapping);
-struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
-dax_entry_t dax_lock_page(struct page *page);
-void dax_unlock_page(struct page *page, dax_entry_t cookie);
 #else
 static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
 {
@@ -134,17 +125,25 @@ static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
 static inline void dax_remove_host(struct gendisk *disk)
 {
 }
-
-static inline void fs_put_dax(struct dax_device *dax_dev)
-{
-}
-
 static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
 		u64 *start_off)
 {
 	return NULL;
 }
+static inline void fs_put_dax(struct dax_device *dax_dev)
+{
+}
+#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
 
+#if IS_ENABLED(CONFIG_FS_DAX)
+int dax_writeback_mapping_range(struct address_space *mapping,
+		struct dax_device *dax_dev, struct writeback_control *wbc);
+
+struct page *dax_layout_busy_page(struct address_space *mapping);
+struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
+dax_entry_t dax_lock_page(struct page *page);
+void dax_unlock_page(struct page *page, dax_entry_t cookie);
+#else
 static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 {
 	return NULL;
-- 
2.30.2

