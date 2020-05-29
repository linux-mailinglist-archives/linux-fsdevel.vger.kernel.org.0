Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C4F1E7365
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407175AbgE2DEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391608AbgE2C6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDBBC08C5C8;
        Thu, 28 May 2020 19:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=u7IT7tEQ9OU7NHthlnWpFkUPruHmC6FNxN+rcFcDJFY=; b=LoffLE5SCQ+OWaYhdzhjsEVrht
        6PMlkAvp7p3FiEYgJtsQpUc3qx08WJziVexttyF2hVk08PkNWQdLNddX6+pEoYPBvpaNqYn9ceWmQ
        GWrQ5TSWFyRcsYw1VCZDwOGc98CMTKlYQkPFwfG2toKQvmNwiOWl5gAVbI98DQzZeJvKALTbWRL7y
        Nox/aEzgi+NJK59xKl1XuxuxUzu0AVxbDbtI8z3Ho9Obi8Kydc6taJ1OXNgtYCJZDnb77oHq4oxJC
        GQtxUzjqE/Kkf375uXRHKfM5OU+olx5MnUhJZkWUPVBcV+KPIoscIPCqLdwWBnGP8fkig87PXPbUx
        DelGTjwA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE2-0008QN-SL; Fri, 29 May 2020 02:58:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/39] fs: Do not update nr_thps for large page mappings
Date:   Thu, 28 May 2020 19:57:53 -0700
Message-Id: <20200529025824.32296-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The nr_thps counter is to support large pages in the page cache
when the filesystem does not support writing large pages.  Eventually
it will be removed, but we should still support filesystems which
do not understand large pages yet.  Move the nr_thp manipulation
functions to filemap.h since they're page-cache specific.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h      | 27 ---------------------------
 include/linux/pagemap.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 777783c8760b..1ab65898bd96 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2830,33 +2830,6 @@ static inline errseq_t filemap_sample_wb_err(struct address_space *mapping)
 	return errseq_sample(&mapping->wb_err);
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
index ea869a7fda7a..e40527e53620 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -122,6 +122,35 @@ static inline bool mapping_large_pages(struct address_space *mapping)
 	return test_bit(AS_LARGE_PAGES, &mapping->flags);
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
+	if (!mapping_large_pages(mapping))
+		atomic_inc(&mapping->nr_thps);
+#else
+	WARN_ON_ONCE(1);
+#endif
+}
+
+static inline void filemap_nr_thps_dec(struct address_space *mapping)
+{
+#ifdef CONFIG_READ_ONLY_THP_FOR_FS
+	if (!mapping_large_pages(mapping))
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

