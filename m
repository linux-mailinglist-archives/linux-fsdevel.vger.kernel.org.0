Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F547634B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 13:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjGZLWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 07:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjGZLWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:22:20 -0400
X-Greylist: delayed 1301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 04:22:16 PDT
Received: from ida.iewc.co.za (ida.iewc.co.za [154.73.34.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBFEFD
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 04:22:16 -0700 (PDT)
Received: from [154.73.32.4] (helo=plastiekpoot)
        by ida.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jkroon@uls.co.za>)
        id 1qOcFo-0007AC-D8; Wed, 26 Jul 2023 13:00:28 +0200
Received: from jkroon by plastiekpoot with local (Exim 4.96)
        (envelope-from <jkroon@uls.co.za>)
        id 1qOcFm-0000jk-0m;
        Wed, 26 Jul 2023 13:00:26 +0200
From:   Jaco Kroon <jaco@uls.co.za>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jaco Kroon <jaco@uls.co.za>
Subject: [PATCH] fuse: enable larger read buffers for readdir.
Date:   Wed, 26 Jul 2023 12:59:37 +0200
Message-ID: <20230726105953.843-1-jaco@uls.co.za>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jaco Kroon <jaco@uls.co.za>
---
 fs/fuse/Kconfig   | 16 ++++++++++++++++
 fs/fuse/readdir.c | 42 ++++++++++++++++++++++++------------------
 2 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 038ed0b9aaa5..0783f9ee5cd3 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -18,6 +18,22 @@ config FUSE_FS
 	  If you want to develop a userspace FS, or if you want to use
 	  a filesystem based on FUSE, answer Y or M.
 
+config FUSE_READDIR_ORDER
+	int
+	range 0 5
+	default 5
+	help
+		readdir performance varies greatly depending on the size of the read.
+		Larger buffers results in larger reads, thus fewer reads and higher
+		performance in return.
+
+		You may want to reduce this value on seriously constrained memory
+		systems where 128KiB (assuming 4KiB pages) cache pages is not ideal.
+
+		This value reprents the order of the number of pages to allocate (ie,
+		the shift value).  A value of 0 is thus 1 page (4KiB) where 5 is 32
+		pages (128KiB).
+
 config CUSE
 	tristate "Character device in Userspace support"
 	depends on FUSE_FS
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index dc603479b30e..98c62b623240 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -13,6 +13,12 @@
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 
+#define READDIR_PAGES_ORDER		CONFIG_FUSE_READDIR_ORDER
+#define READDIR_PAGES			(1 << READDIR_PAGES_ORDER)
+#define READDIR_PAGES_SIZE		(PAGE_SIZE << READDIR_PAGES_ORDER)
+#define READDIR_PAGES_MASK		(READDIR_PAGES_SIZE - 1)
+#define READDIR_PAGES_SHIFT		(PAGE_SHIFT + READDIR_PAGES_ORDER)
+
 static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 {
 	struct fuse_conn *fc = get_fuse_conn(dir);
@@ -52,10 +58,10 @@ static void fuse_add_dirent_to_cache(struct file *file,
 	}
 	version = fi->rdc.version;
 	size = fi->rdc.size;
-	offset = size & ~PAGE_MASK;
-	index = size >> PAGE_SHIFT;
+	offset = size & ~READDIR_PAGES_MASK;
+	index = size >> READDIR_PAGES_SHIFT;
 	/* Dirent doesn't fit in current page?  Jump to next page. */
-	if (offset + reclen > PAGE_SIZE) {
+	if (offset + reclen > READDIR_PAGES_SIZE) {
 		index++;
 		offset = 0;
 	}
@@ -83,7 +89,7 @@ static void fuse_add_dirent_to_cache(struct file *file,
 	}
 	memcpy(addr + offset, dirent, reclen);
 	kunmap_local(addr);
-	fi->rdc.size = (index << PAGE_SHIFT) + offset + reclen;
+	fi->rdc.size = (index << READDIR_PAGES_SHIFT) + offset + reclen;
 	fi->rdc.pos = dirent->off;
 unlock:
 	spin_unlock(&fi->rdc.lock);
@@ -104,7 +110,7 @@ static void fuse_readdir_cache_end(struct file *file, loff_t pos)
 	}
 
 	fi->rdc.cached = true;
-	end = ALIGN(fi->rdc.size, PAGE_SIZE);
+	end = ALIGN(fi->rdc.size, READDIR_PAGES_SIZE);
 	spin_unlock(&fi->rdc.lock);
 
 	/* truncate unused tail of cache */
@@ -328,25 +334,25 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_io_args ia = {};
 	struct fuse_args_pages *ap = &ia.ap;
-	struct fuse_page_desc desc = { .length = PAGE_SIZE };
+	struct fuse_page_desc desc = { .length = READDIR_PAGES_SIZE };
 	u64 attr_version = 0;
 	bool locked;
 
-	page = alloc_page(GFP_KERNEL);
+	page = alloc_pages(GFP_KERNEL, READDIR_PAGES_ORDER);
 	if (!page)
 		return -ENOMEM;
 
 	plus = fuse_use_readdirplus(inode, ctx);
 	ap->args.out_pages = true;
-	ap->num_pages = 1;
+	ap->num_pages = READDIR_PAGES;
 	ap->pages = &page;
 	ap->descs = &desc;
 	if (plus) {
 		attr_version = fuse_get_attr_version(fm->fc);
-		fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
+		fuse_read_args_fill(&ia, file, ctx->pos, READDIR_PAGES_SIZE,
 				    FUSE_READDIRPLUS);
 	} else {
-		fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
+		fuse_read_args_fill(&ia, file, ctx->pos, READDIR_PAGES_SIZE,
 				    FUSE_READDIR);
 	}
 	locked = fuse_lock_inode(inode);
@@ -383,7 +389,7 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
 					       void *addr, unsigned int size,
 					       struct dir_context *ctx)
 {
-	unsigned int offset = ff->readdir.cache_off & ~PAGE_MASK;
+	unsigned int offset = ff->readdir.cache_off & ~READDIR_PAGES_MASK;
 	enum fuse_parse_result res = FOUND_NONE;
 
 	WARN_ON(offset >= size);
@@ -504,16 +510,16 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 
 	WARN_ON(fi->rdc.size < ff->readdir.cache_off);
 
-	index = ff->readdir.cache_off >> PAGE_SHIFT;
+	index = ff->readdir.cache_off >> READDIR_PAGES_SHIFT;
 
-	if (index == (fi->rdc.size >> PAGE_SHIFT))
-		size = fi->rdc.size & ~PAGE_MASK;
+	if (index == (fi->rdc.size >> READDIR_PAGES_SHIFT))
+		size = fi->rdc.size & ~READDIR_PAGES_MASK;
 	else
-		size = PAGE_SIZE;
+		size = READDIR_PAGES_SIZE;
 	spin_unlock(&fi->rdc.lock);
 
 	/* EOF? */
-	if ((ff->readdir.cache_off & ~PAGE_MASK) == size)
+	if ((ff->readdir.cache_off & ~READDIR_PAGES_MASK) == size)
 		return 0;
 
 	page = find_get_page_flags(file->f_mapping, index,
@@ -559,9 +565,9 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 	if (res == FOUND_ALL)
 		return 0;
 
-	if (size == PAGE_SIZE) {
+	if (size == READDIR_PAGES_SIZE) {
 		/* We hit end of page: skip to next page. */
-		ff->readdir.cache_off = ALIGN(ff->readdir.cache_off, PAGE_SIZE);
+		ff->readdir.cache_off = ALIGN(ff->readdir.cache_off, READDIR_PAGES_SIZE);
 		goto retry;
 	}
 
-- 
2.41.0

