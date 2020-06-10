Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C82E1F5CE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgFJURl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730532AbgFJUNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4933C08C5C9;
        Wed, 10 Jun 2020 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=S5644RWSmzLKClPw4/cvpdrJ3oC3Vx5GXky4qEg0/Sw=; b=t387Iyw8XBmw/PCNwgPA8fTWvX
        FDCT5sqoJc6buh0Ea9yw6B2Mwdne1kqZXmXFEiSPqzIShANQmCPWpqt8kJbRyg6u1hd57zpjigSLB
        Bo2UINMBdXnjnmijOgZeH4p5NAJgF/j2o0QZDy7v7ELE1rVt7PJR8xLH2BJlaIVxyK3QlN1h+a/Dd
        1G+Ivtl/Khg2942dOxVmkbayq7S0bA59/afBuDV5ELg3XHIOwlzCJHJbHnKOsCkZAFLS7ejdVfWBz
        HbrUUIkv2/0kRFQFAn/aryEP/3L9xA4lNXei1WUa035YzAg4Fhhs09+aWElbFTkrguFtEvMCUlpmW
        c/yW5gJQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003UO-Qp; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 15/51] fs: Do not update nr_thps for mappings which support THPs
Date:   Wed, 10 Jun 2020 13:13:09 -0700
Message-Id: <20200610201345.13273-16-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The nr_thps counter is to support THPs in the page cache when the
filesystem doesn't understand THPs.  Eventually it will be removed, but
we should still support filesystems which do not understand THPs yet.
Move the nr_thp manipulation functions to filemap.h since they're
page-cache specific.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h      | 27 ---------------------------
 include/linux/pagemap.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ac411a08f83c..e11929152103 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2839,33 +2839,6 @@ static inline errseq_t file_sample_sb_err(struct file *file)
 	return errseq_sample(&file->f_path.dentry->d_sb->s_wb_err);
 }
 
-static inline int filemap_nr_thps(struct address_space *mapping)
-{
-#ifdef CONFIG_READ_ONLY_THP_FOR_FS
-	return atomic_read(&mapping->nr_thps);
-#else
-	return 0;
-#endif
-}
-
-static inline void filemap_nr_thps_inc(struct address_space *mapping)
-{
-#ifdef CONFIG_READ_ONLY_THP_FOR_FS
-	atomic_inc(&mapping->nr_thps);
-#else
-	WARN_ON_ONCE(1);
-#endif
-}
-
-static inline void filemap_nr_thps_dec(struct address_space *mapping)
-{
-#ifdef CONFIG_READ_ONLY_THP_FOR_FS
-	atomic_dec(&mapping->nr_thps);
-#else
-	WARN_ON_ONCE(1);
-#endif
-}
-
 extern int vfs_fsync_range(struct file *file, loff_t start, loff_t end,
 			   int datasync);
 extern int vfs_fsync(struct file *file, int datasync);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8a45b572bcf1..644caff3e78b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -125,6 +125,35 @@ static inline bool mapping_thp_support(struct address_space *mapping)
 	return test_bit(AS_THP_SUPPORT, &mapping->flags);
 }
 
+static inline int filemap_nr_thps(struct address_space *mapping)
+{
+#ifdef CONFIG_READ_ONLY_THP_FOR_FS
+	return atomic_read(&mapping->nr_thps);
+#else
+	return 0;
+#endif
+}
+
+static inline void filemap_nr_thps_inc(struct address_space *mapping)
+{
+#ifdef CONFIG_READ_ONLY_THP_FOR_FS
+	if (!mapping_thp_support(mapping))
+		atomic_inc(&mapping->nr_thps);
+#else
+	WARN_ON_ONCE(1);
+#endif
+}
+
+static inline void filemap_nr_thps_dec(struct address_space *mapping)
+{
+#ifdef CONFIG_READ_ONLY_THP_FOR_FS
+	if (!mapping_thp_support(mapping))
+		atomic_dec(&mapping->nr_thps);
+#else
+	WARN_ON_ONCE(1);
+#endif
+}
+
 void release_pages(struct page **pages, int nr);
 
 /*
-- 
2.26.2

