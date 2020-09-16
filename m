Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15B26BA9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 05:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIPD1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 23:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPD1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:27:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C1FC06174A;
        Tue, 15 Sep 2020 20:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xRxCldwEuRUJwoa1c4VDIZ+Y60r+0QMgqYqxkRKDiDg=; b=mYKSdznuCXuyragItJE9R8hVvc
        /cK74JOotJ4ZKQvQaEqkbocI/JviSHZ0bTbSlYJtl3hk6zvrxmfbtb/QdEMhlYWgkPetTkxKjJWme
        6VVSnJi2hmkYNJ1IGFP1DUEDI2+zocz2wAXccx9kkag63S6EhNlQvzirv9KjFCDdt815b7FnoWDU7
        DsA4CFBmHG18DFoHs81GzbCsS04d/Gi35f9r6fJcnIItgdc5AcZ1DtXdedCEDGLm9JJHubMmgqb9S
        HO2tFHr6EP81D3fLvccyU10x5pNVQJCOrJqQBMRxOjGfiWxrVb4NnXBB3Sc86kQbQHd4onqOrR0FV
        72I/XgRw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIO6J-0005yP-BT; Wed, 16 Sep 2020 03:27:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 2/2] fs: Do not update nr_thps for mappings which support THPs
Date:   Wed, 16 Sep 2020 04:27:17 +0100
Message-Id: <20200916032717.22917-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200916032717.22917-1-willy@infradead.org>
References: <20200916032717.22917-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
index f10190b22d5a..83d8f3ba17a5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2701,33 +2701,6 @@ static inline errseq_t file_sample_sb_err(struct file *file)
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
index ecb03e1b3555..2b637960be3a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -130,6 +130,35 @@ static inline bool mapping_thp_support(struct address_space *mapping)
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
2.28.0

