Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A619F85CD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 10:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfHHI2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 04:28:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731844AbfHHI2J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:28:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37BA330B8223;
        Thu,  8 Aug 2019 08:28:09 +0000 (UTC)
Received: from pegasus.maiolino.com (ovpn-204-236.brq.redhat.com [10.40.204.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDA935C231;
        Thu,  8 Aug 2019 08:28:06 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, jaegeuk@kernel.org,
        darrick.wong@oracle.com, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 6/9] iomap: Remove length and start fields from iomap_fiemap
Date:   Thu,  8 Aug 2019 10:27:41 +0200
Message-Id: <20190808082744.31405-7-cmaiolino@redhat.com>
In-Reply-To: <20190808082744.31405-1-cmaiolino@redhat.com>
References: <20190808082744.31405-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 08 Aug 2019 08:28:09 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fiemap_extent_info now embeds start and length parameters, users of
iomap_fiemap() doesn't need to pass it individually anymore.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

---
Changelog:
	V5:
		- Rebased against 5.3
		- Fix small conflict with previous patch
		  due indentation in xfs_vn_fiemap

 fs/gfs2/inode.c       | 4 +---
 fs/iomap/fiemap.c     | 4 +++-
 fs/xfs/xfs_iops.c     | 8 ++------
 include/linux/iomap.h | 2 +-
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index c8310b823f1d..dc192dfd8941 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2003,8 +2003,6 @@ static int gfs2_getattr(const struct path *path, struct kstat *stat,
 
 static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
 {
-	u64 start = fieinfo->fi_start;
-	u64 len = fieinfo->fi_len;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	int ret;
@@ -2015,7 +2013,7 @@ static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
 	if (ret)
 		goto out;
 
-	ret = iomap_fiemap(inode, fieinfo, start, len, &gfs2_iomap_ops);
+	ret = iomap_fiemap(inode, fieinfo, &gfs2_iomap_ops);
 
 	gfs2_glock_dq_uninit(&gh);
 
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index f26fdd36e383..03f214f5df94 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -65,9 +65,11 @@ iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 }
 
 int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
-		loff_t start, loff_t len, const struct iomap_ops *ops)
+		const struct iomap_ops *ops)
 {
 	struct fiemap_ctx ctx;
+	loff_t start = fi->fi_start;
+	loff_t len = fi->fi_len;
 	loff_t ret;
 
 	memset(&ctx, 0, sizeof(ctx));
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 89982271ffce..514c4620a9e8 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1102,18 +1102,14 @@ xfs_vn_fiemap(
 	struct inode			*inode,
 	struct fiemap_extent_info	*fieinfo)
 {
-	u64				start = fieinfo->fi_start;
-	u64				length = fieinfo->fi_len;
 	int				error;
 
 	xfs_ilock(XFS_I(inode), XFS_IOLOCK_SHARED);
 	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
-		error = iomap_fiemap(inode, fieinfo, start, length,
-				&xfs_xattr_iomap_ops);
+		error = iomap_fiemap(inode, fieinfo, &xfs_xattr_iomap_ops);
 	} else {
-		error = iomap_fiemap(inode, fieinfo, start, length,
-				&xfs_iomap_ops);
+		error = iomap_fiemap(inode, fieinfo, &xfs_iomap_ops);
 	}
 	xfs_iunlock(XFS_I(inode), XFS_IOLOCK_SHARED);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index bc499ceae392..2d4671aae397 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -175,7 +175,7 @@ int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
 			const struct iomap_ops *ops);
 int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-		loff_t start, loff_t len, const struct iomap_ops *ops);
+		const struct iomap_ops *ops);
 loff_t iomap_seek_hole(struct inode *inode, loff_t offset,
 		const struct iomap_ops *ops);
 loff_t iomap_seek_data(struct inode *inode, loff_t offset,
-- 
2.20.1

