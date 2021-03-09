Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015FA332B2E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 16:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhCIP4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 10:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhCIP4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:56:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FCBC06174A;
        Tue,  9 Mar 2021 07:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3M8hBLIawJHMtUGgys5VeJcEPDN2yS9O0RGnqufBgKI=; b=U2dY1YoxC/q1JkvxYuErcUmM7G
        yNLzZEFPUD/PpwSMC0sxlmTrm15YRnKHKJAt+fMXoP9qEB/cTAxoI5Pm6jwZZk+bXrHectQuAsiFC
        rX1aVSPbDujtJRpARm7H+EDSahwdvGZgm8tKkGQEqHEF57ViiLlCwMAkXxyCyYQO/nmP1hGHolJS5
        aHHrsNWOUhNj6riEwaOc9ADfSNG2qUcuWpHQnzqa0IYvDrRP3H7eJdz57HO8orK9CyOiPihYKpRWJ
        lwcNNXwHH8HGXZTyH602DtYjkOGdhM7VkOAiZZgjli5xWKnsO06znGdhAsbUh5UFfx9JQ9Ikwrkbz
        Eeiwq1jA==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJehA-000lO8-7a; Tue, 09 Mar 2021 15:54:54 +0000
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
Subject: [PATCH 5/9] vmw_balloon: remove the balloon-vmware file system
Date:   Tue,  9 Mar 2021 16:53:44 +0100
Message-Id: <20210309155348.974875-6-hch@lst.de>
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
 drivers/misc/vmw_balloon.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 5d057a05ddbee8..be4be32f858253 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -16,6 +16,7 @@
 //#define DEBUG
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/anon_inodes.h>
 #include <linux/types.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -1735,20 +1736,6 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
 
 
 #ifdef CONFIG_BALLOON_COMPACTION
-
-static int vmballoon_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, BALLOON_VMW_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type vmballoon_fs = {
-	.name           	= "balloon-vmware",
-	.init_fs_context	= vmballoon_init_fs_context,
-	.kill_sb        	= kill_anon_super,
-};
-
-static struct vfsmount *vmballoon_mnt;
-
 /**
  * vmballoon_migratepage() - migrates a balloon page.
  * @b_dev_info: balloon device information descriptor.
@@ -1878,8 +1865,6 @@ static void vmballoon_compaction_deinit(struct vmballoon *b)
 		iput(b->b_dev_info.inode);
 
 	b->b_dev_info.inode = NULL;
-	kern_unmount(vmballoon_mnt);
-	vmballoon_mnt = NULL;
 }
 
 /**
@@ -1895,13 +1880,8 @@ static void vmballoon_compaction_deinit(struct vmballoon *b)
  */
 static __init int vmballoon_compaction_init(struct vmballoon *b)
 {
-	vmballoon_mnt = kern_mount(&vmballoon_fs);
-	if (IS_ERR(vmballoon_mnt))
-		return PTR_ERR(vmballoon_mnt);
-
 	b->b_dev_info.migratepage = vmballoon_migratepage;
-	b->b_dev_info.inode = alloc_anon_inode_sb(vmballoon_mnt->mnt_sb);
-
+	b->b_dev_info.inode = alloc_anon_inode();
 	if (IS_ERR(b->b_dev_info.inode))
 		return PTR_ERR(b->b_dev_info.inode);
 
-- 
2.30.1

