Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727EF332B43
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 16:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhCIP50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 10:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhCIP44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:56:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF2AC061762;
        Tue,  9 Mar 2021 07:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IFk47HqYrcljU8sgV3Szm3kSO/BjefEBgYu1y49MYsE=; b=WHyxP41MA1s5vmF0W/htokhaBx
        JJRExXLLcZF4nmAarls1d3HuzNwpxmbC2mhuQ2AjlEBa/HE9uab75LwxnBHvSlkMbCIWybzSODn2N
        nI1H1JvK6Iir6AOGJrydVaRgu6VKcvBTzTMpXy9rIa7WbTAufbU1gTxOWVjZCYgJMpuoZTM/mo4PI
        uRhHJt00wwUBMfOwTrEx++Btjp1eJXNPixwQbRg7gtFznHkapP3JdMEA9Bcm9iGgeFNorbolw8FTk
        j7Z0M3Q+So7C7evvGwEeGHmpDkMRkIYZTYMWqzUeucdgD9LBE/o0m4JdRWf9Xk52M7m+GAD4SKJAt
        L4oOHUZw==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJehy-000lWp-8R; Tue, 09 Mar 2021 15:55:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 8/9] z3fold: remove the z3fold file system
Date:   Tue,  9 Mar 2021 16:53:47 +0100
Message-Id: <20210309155348.974875-9-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309155348.974875-1-hch@lst.de>
References: <20210309155348.974875-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just use the generic anon_inode file system.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/z3fold.c | 38 ++------------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index e7cd9298b221f5..e0749a3d8987de 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -23,6 +23,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/anon_inodes.h>
 #include <linux/atomic.h>
 #include <linux/sched.h>
 #include <linux/cpumask.h>
@@ -345,38 +346,10 @@ static inline void free_handle(unsigned long handle, struct z3fold_header *zhdr)
 	}
 }
 
-static int z3fold_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, Z3FOLD_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type z3fold_fs = {
-	.name		= "z3fold",
-	.init_fs_context = z3fold_init_fs_context,
-	.kill_sb	= kill_anon_super,
-};
-
-static struct vfsmount *z3fold_mnt;
-static int z3fold_mount(void)
-{
-	int ret = 0;
-
-	z3fold_mnt = kern_mount(&z3fold_fs);
-	if (IS_ERR(z3fold_mnt))
-		ret = PTR_ERR(z3fold_mnt);
-
-	return ret;
-}
-
-static void z3fold_unmount(void)
-{
-	kern_unmount(z3fold_mnt);
-}
-
 static const struct address_space_operations z3fold_aops;
 static int z3fold_register_migration(struct z3fold_pool *pool)
 {
-	pool->inode = alloc_anon_inode_sb(z3fold_mnt->mnt_sb);
+	pool->inode = alloc_anon_inode();
 	if (IS_ERR(pool->inode)) {
 		pool->inode = NULL;
 		return 1;
@@ -1787,22 +1760,15 @@ MODULE_ALIAS("zpool-z3fold");
 
 static int __init init_z3fold(void)
 {
-	int ret;
-
 	/* Make sure the z3fold header is not larger than the page size */
 	BUILD_BUG_ON(ZHDR_SIZE_ALIGNED > PAGE_SIZE);
-	ret = z3fold_mount();
-	if (ret)
-		return ret;
 
 	zpool_register_driver(&z3fold_zpool_driver);
-
 	return 0;
 }
 
 static void __exit exit_z3fold(void)
 {
-	z3fold_unmount();
 	zpool_unregister_driver(&z3fold_zpool_driver);
 }
 
-- 
2.30.1

