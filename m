Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B1A332B24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 16:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhCIPzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 10:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhCIPzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:55:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0425C06174A;
        Tue,  9 Mar 2021 07:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=B2QcStvhg9D54BxwbuG4jJNpXPybnK2FqQydroBhB+g=; b=oEJ8ugE1x4j/2X9l3CQfTDXGMS
        Q/n8jpu9Ywp7imVSmXif75d7xXHeM2tpMwxW924TC0hKzyzBN3JCiriBDAgPrtO08TnExSGXkYom5
        7IbMPTnUuWT0+4FIiqi7z5LJmACctZ8ew34Oddm3TWS2SIrzIvkQ2W0M5x3gWrrLvJ6qGpXUZGoOZ
        DlpO6fH34pmRLyy8a4XCFgrzNs5TMW9rbySvmlrus7F/24wWk6Mj2OPm6RbyqI73AJJjBOpDqNtte
        j+piA+rYwRzXkiyu0lStNu6yIiQ3gMwi00aj7zbkeQUeYd19n7y+DMkqw+8Akrri9KEMJ3DD2bIJZ
        /NW9ZR2g==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJegw-000lNb-Ow; Tue, 09 Mar 2021 15:54:41 +0000
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
Subject: [PATCH 4/9] drm: remove the drm file system
Date:   Tue,  9 Mar 2021 16:53:43 +0100
Message-Id: <20210309155348.974875-5-hch@lst.de>
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
 drivers/gpu/drm/drm_drv.c | 64 ++-------------------------------------
 1 file changed, 3 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 87e7214a8e3565..af293d76f979e5 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -26,6 +26,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/anon_inodes.h>
 #include <linux/debugfs.h>
 #include <linux/fs.h>
 #include <linux/module.h>
@@ -475,65 +476,6 @@ void drm_dev_unplug(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_dev_unplug);
 
-/*
- * DRM internal mount
- * We want to be able to allocate our own "struct address_space" to control
- * memory-mappings in VRAM (or stolen RAM, ...). However, core MM does not allow
- * stand-alone address_space objects, so we need an underlying inode. As there
- * is no way to allocate an independent inode easily, we need a fake internal
- * VFS mount-point.
- *
- * The drm_fs_inode_new() function allocates a new inode, drm_fs_inode_free()
- * frees it again. You are allowed to use iget() and iput() to get references to
- * the inode. But each drm_fs_inode_new() call must be paired with exactly one
- * drm_fs_inode_free() call (which does not have to be the last iput()).
- * We use drm_fs_inode_*() to manage our internal VFS mount-point and share it
- * between multiple inode-users. You could, technically, call
- * iget() + drm_fs_inode_free() directly after alloc and sometime later do an
- * iput(), but this way you'd end up with a new vfsmount for each inode.
- */
-
-static int drm_fs_cnt;
-static struct vfsmount *drm_fs_mnt;
-
-static int drm_fs_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, 0x010203ff) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type drm_fs_type = {
-	.name		= "drm",
-	.owner		= THIS_MODULE,
-	.init_fs_context = drm_fs_init_fs_context,
-	.kill_sb	= kill_anon_super,
-};
-
-static struct inode *drm_fs_inode_new(void)
-{
-	struct inode *inode;
-	int r;
-
-	r = simple_pin_fs(&drm_fs_type, &drm_fs_mnt, &drm_fs_cnt);
-	if (r < 0) {
-		DRM_ERROR("Cannot mount pseudo fs: %d\n", r);
-		return ERR_PTR(r);
-	}
-
-	inode = alloc_anon_inode_sb(drm_fs_mnt->mnt_sb);
-	if (IS_ERR(inode))
-		simple_release_fs(&drm_fs_mnt, &drm_fs_cnt);
-
-	return inode;
-}
-
-static void drm_fs_inode_free(struct inode *inode)
-{
-	if (inode) {
-		iput(inode);
-		simple_release_fs(&drm_fs_mnt, &drm_fs_cnt);
-	}
-}
-
 /**
  * DOC: component helper usage recommendations
  *
@@ -563,7 +505,7 @@ static void drm_dev_init_release(struct drm_device *dev, void *res)
 {
 	drm_legacy_ctxbitmap_cleanup(dev);
 	drm_legacy_remove_map_hash(dev);
-	drm_fs_inode_free(dev->anon_inode);
+	iput(dev->anon_inode);
 
 	put_device(dev->dev);
 	/* Prevent use-after-free in drm_managed_release when debugging is
@@ -616,7 +558,7 @@ static int drm_dev_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	dev->anon_inode = drm_fs_inode_new();
+	dev->anon_inode = alloc_anon_inode();
 	if (IS_ERR(dev->anon_inode)) {
 		ret = PTR_ERR(dev->anon_inode);
 		DRM_ERROR("Cannot allocate anonymous inode: %d\n", ret);
-- 
2.30.1

