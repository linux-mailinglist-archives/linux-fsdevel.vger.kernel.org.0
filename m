Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCFF332B3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 16:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCIP4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 10:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhCIP4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:56:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DC9C06174A;
        Tue,  9 Mar 2021 07:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=H2ld+QgidDGzgxm+N1lJ7nVSOxHC57yc0v6xTacIbY4=; b=iK2JlFyhSt2fAxdUtndJ31jjUd
        hNycyMaLROgr5IP/6Vd9G0ejFwt4PjtbUOIllT6lpcyNO5JSrh2jzNp2gMWO+ruzsynjop/tobJfY
        Ktw36wP3bjGaJFUqad8boRQbzSj/WVqC2vdDF1erI4/UR8j/TiljW5ZWLiSLDSKyNVvtr+fZ51EBV
        pCBrYUDXEQT4MqRPo4dXzQFXnfTWXGQxciUvtoMiNYfJ8YId0Jxl0+zNdyZ/Wd4dtmXuU6KZ77azt
        BWf2kqMD8H4xw36e5pyhM+5SVtwMNqv43fs7ARRc/rD1HyYU5hEmwq8fHIT4tm/rith+FefXPeIqW
        /gsKX6iQ==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJehM-000lUZ-SR; Tue, 09 Mar 2021 15:55:09 +0000
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
Subject: [PATCH 7/9] iomem: remove the iomem file system
Date:   Tue,  9 Mar 2021 16:53:46 +0100
Message-Id: <20210309155348.974875-8-hch@lst.de>
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
 kernel/resource.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 0fd091a3f2fc66..12560553c26796 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <linux/mount.h>
 #include <linux/resource_ext.h>
+#include <linux/anon_inodes.h>
 #include <uapi/linux/magic.h>
 #include <asm/io.h>
 
@@ -1838,37 +1839,14 @@ static int __init strict_iomem(char *str)
 	return 1;
 }
 
-static int iomem_fs_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, DEVMEM_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type iomem_fs_type = {
-	.name		= "iomem",
-	.owner		= THIS_MODULE,
-	.init_fs_context = iomem_fs_init_fs_context,
-	.kill_sb	= kill_anon_super,
-};
-
 static int __init iomem_init_inode(void)
 {
-	static struct vfsmount *iomem_vfs_mount;
-	static int iomem_fs_cnt;
 	struct inode *inode;
-	int rc;
-
-	rc = simple_pin_fs(&iomem_fs_type, &iomem_vfs_mount, &iomem_fs_cnt);
-	if (rc < 0) {
-		pr_err("Cannot mount iomem pseudo filesystem: %d\n", rc);
-		return rc;
-	}
 
-	inode = alloc_anon_inode_sb(iomem_vfs_mount->mnt_sb);
+	inode = alloc_anon_inode();
 	if (IS_ERR(inode)) {
-		rc = PTR_ERR(inode);
-		pr_err("Cannot allocate inode for iomem: %d\n", rc);
-		simple_release_fs(&iomem_vfs_mount, &iomem_fs_cnt);
-		return rc;
+		pr_err("Cannot allocate inode for iomem: %zd\n", PTR_ERR(inode));
+		return PTR_ERR(inode);
 	}
 
 	/*
-- 
2.30.1

