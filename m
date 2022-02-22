Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1074C0258
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiBVTtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiBVTs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F211B91F8
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0j3aewoiCwB+N/d7IlTyLKlZYix9RSVjL31g7CmsdD0=; b=btjuwhwUiG1wGilBaEiADbIIq4
        hA4yA96OehjLzm3AKsMZrJ/Su993Sxk718UhctjjbRPHvfofuBkH1SuPrXAMHMpX6vAntV/U017mW
        0fLn9Ayx0hRjDxxQ8duTof8hSff2Z258Gs0AM6kQO3K7L+gRkbnPUjk2lVUxZRVI6vMsE6e9oHR3P
        TZE1CLRDGSwE42L4FOwz0i1oS33gp485TYOg5UbROHLZm0ydd++TSuyXU4HB6b8gUdP39RPHrEOrO
        3O2uSuFk412wA9esCJRPtKFE9zv4+BiVJLsvrj73t87wF/o/YP6lDGGphd9lCXYroyud7eb62Iv4q
        2ijXvHGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb96-00360U-Jz; Tue, 22 Feb 2022 19:48:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 14/22] fs: Remove aop flags argument from pagecache_write_begin()
Date:   Tue, 22 Feb 2022 19:48:12 +0000
Message-Id: <20220222194820.737755-15-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220222194820.737755-1-willy@infradead.org>
References: <20220222194820.737755-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With no more AOP_FLAG definitions left, remove this parameter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 6 ++----
 fs/buffer.c                               | 6 +++---
 fs/ext4/verity.c                          | 2 +-
 fs/f2fs/verity.c                          | 2 +-
 fs/hfs/extent.c                           | 2 +-
 fs/hfsplus/extents.c                      | 2 +-
 fs/namei.c                                | 3 +--
 fs/ntfs3/file.c                           | 2 +-
 include/linux/pagemap.h                   | 4 ++--
 9 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index cc9fe258fba7..5a27b0225850 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -448,8 +448,7 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 			return err;
 
 		err = pagecache_write_begin(obj->base.filp, mapping,
-					    offset, len, 0,
-					    &page, &data);
+					    offset, len, &page, &data);
 		if (err < 0)
 			return err;
 
@@ -622,8 +621,7 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *dev_priv,
 		void *pgdata, *vaddr;
 
 		err = pagecache_write_begin(file, file->f_mapping,
-					    offset, len, 0,
-					    &page, &pgdata);
+					    offset, len, &page, &pgdata);
 		if (err < 0)
 			goto fail;
 
diff --git a/fs/buffer.c b/fs/buffer.c
index c33e681fdeba..440979592c05 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2352,7 +2352,7 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
 	if (err)
 		goto out;
 
-	err = pagecache_write_begin(NULL, mapping, size, 0, 0, &page, &fsdata);
+	err = pagecache_write_begin(NULL, mapping, size, 0, &page, &fsdata);
 	if (err)
 		goto out;
 
@@ -2387,7 +2387,7 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 		}
 		len = PAGE_SIZE - zerofrom;
 
-		err = pagecache_write_begin(file, mapping, curpos, len, 0,
+		err = pagecache_write_begin(file, mapping, curpos, len,
 					    &page, &fsdata);
 		if (err)
 			goto out;
@@ -2420,7 +2420,7 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 		}
 		len = offset - zerofrom;
 
-		err = pagecache_write_begin(file, mapping, curpos, len, 0,
+		err = pagecache_write_begin(file, mapping, curpos, len,
 					    &page, &fsdata);
 		if (err)
 			goto out;
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index eacbd489e3bf..ed7bcf699348 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -79,7 +79,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		void *fsdata;
 		int res;
 
-		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n, 0,
+		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n,
 					    &page, &fsdata);
 		if (res)
 			return res;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index fe5acdccaae1..e38fef7652ee 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -85,7 +85,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		void *addr;
 		int res;
 
-		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n, 0,
+		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n,
 					    &page, &fsdata);
 		if (res)
 			return res;
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 263d5028d9d1..7ac7c74255be 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -491,7 +491,7 @@ void hfs_file_truncate(struct inode *inode)
 
 		/* XXX: Can use generic_cont_expand? */
 		size = inode->i_size - 1;
-		res = pagecache_write_begin(NULL, mapping, size+1, 0, 0,
+		res = pagecache_write_begin(NULL, mapping, size+1, 0,
 					    &page, &fsdata);
 		if (!res) {
 			res = pagecache_write_end(NULL, mapping, size+1, 0, 0,
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 7054a542689f..6b37dbec9f0b 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -557,7 +557,7 @@ void hfsplus_file_truncate(struct inode *inode)
 		void *fsdata;
 		loff_t size = inode->i_size;
 
-		res = pagecache_write_begin(NULL, mapping, size, 0, 0,
+		res = pagecache_write_begin(NULL, mapping, size, 0,
 					    &page, &fsdata);
 		if (res)
 			return;
diff --git a/fs/namei.c b/fs/namei.c
index 4f5c07d5579f..48498737ee5c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5016,8 +5016,7 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 retry:
 	if (nofs)
 		flags = memalloc_nofs_save();
-	err = pagecache_write_begin(NULL, mapping, 0, len-1,
-				0, &page, &fsdata);
+	err = pagecache_write_begin(NULL, mapping, 0, len - 1, &page, &fsdata);
 	if (nofs)
 		memalloc_nofs_restore(flags);
 	if (err)
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 787b53b984ee..516efea57bfc 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -157,7 +157,7 @@ static int ntfs_extend_initialized_size(struct file *file,
 		if (pos + len > new_valid)
 			len = new_valid - pos;
 
-		err = pagecache_write_begin(file, mapping, pos, len, 0, &page,
+		err = pagecache_write_begin(file, mapping, pos, len, &page,
 					    &fsdata);
 		if (err)
 			goto out;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 76b0ddfef5ba..2e0a82a01564 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -535,9 +535,9 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
  */
 static inline int pagecache_write_begin(struct file *file,
 		struct address_space *mapping, loff_t pos, unsigned len,
-		unsigned flags, struct page **pagep, void **fsdata)
+		struct page **pagep, void **fsdata)
 {
-	return mapping->a_ops->write_begin(file, mapping, pos, len, flags,
+	return mapping->a_ops->write_begin(file, mapping, pos, len, 0,
 						pagep, fsdata);
 }
 
-- 
2.34.1

