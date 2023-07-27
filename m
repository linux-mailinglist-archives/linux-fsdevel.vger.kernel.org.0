Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33980764CC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjG0I0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjG0I0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:26:13 -0400
Received: from ida.iewc.co.za (ida.iewc.co.za [154.73.34.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398F24EE4;
        Thu, 27 Jul 2023 01:13:59 -0700 (PDT)
Received: from [165.16.200.159] (helo=plastiekpoot)
        by ida.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jkroon@uls.co.za>)
        id 1qOw7C-0000fk-Mj; Thu, 27 Jul 2023 10:12:54 +0200
Received: from jkroon by plastiekpoot with local (Exim 4.96)
        (envelope-from <jkroon@uls.co.za>)
        id 1qOw7A-0004la-0s;
        Thu, 27 Jul 2023 10:12:52 +0200
From:   Jaco Kroon <jaco@uls.co.za>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        Antonio SJ Musumeci <trapexit@spawn.link>
Cc:     Jaco Kroon <jaco@uls.co.za>
Subject: [PATCH] fuse: enable larger read buffers for readdir [v2].
Date:   Thu, 27 Jul 2023 10:12:18 +0200
Message-ID: <20230727081237.18217-1-jaco@uls.co.za>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726105953.843-1-jaco@uls.co.za>
References: <20230726105953.843-1-jaco@uls.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch does not mess with the caching infrastructure like the
previous one, which we believe caused excessive CPU and broke directory
listings in some cases.

This version only affects the uncached read, which then during parse adds an
entry at a time to the cached structures by way of copying, and as such,
we believe this should be sufficient.

We're still seeing cases where getdents64 takes ~10s (this was the case
in any case without this patch, the difference now that we get ~500
entries for that time rather than the 14-18 previously).  We believe
that that latency is introduced on glusterfs side and is under separate
discussion with the glusterfs developers.

This is still a compile-time option, but a working one compared to
previous patch.  For now this works, but it's not recommended for merge
(as per email discussion).

This still uses alloc_pages rather than kvmalloc/kvfree.

Signed-off-by: Jaco Kroon <jaco@uls.co.za>
---
 fs/fuse/Kconfig   | 16 ++++++++++++++++
 fs/fuse/readdir.c | 18 ++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

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
index dc603479b30e..47cea4d91228 100644
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
@@ -367,7 +373,7 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 		}
 	}
 
-	__free_page(page);
+	__free_pages(page, READDIR_PAGES_ORDER);
 	fuse_invalidate_atime(inode);
 	return res;
 }
-- 
2.41.0

