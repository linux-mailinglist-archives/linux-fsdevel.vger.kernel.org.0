Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B820AFDE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 15:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfIKNnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 09:43:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64717 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbfIKNnc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:43:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F878A371B6;
        Wed, 11 Sep 2019 13:43:32 +0000 (UTC)
Received: from pegasus.maiolino.com (ovpn-204-18.brq.redhat.com [10.40.204.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAFE610016EB;
        Wed, 11 Sep 2019 13:43:30 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 6/9] iomap: Remove length and start fields from iomap_fiemap
Date:   Wed, 11 Sep 2019 15:43:12 +0200
Message-Id: <20190911134315.27380-7-cmaiolino@redhat.com>
In-Reply-To: <20190911134315.27380-1-cmaiolino@redhat.com>
References: <20190911134315.27380-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 11 Sep 2019 13:43:32 +0000 (UTC)
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
index a02a52cbbec4..38e202ed1685 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2028,8 +2028,6 @@ static int gfs2_getattr(const struct path *path, struct kstat *stat,
 
 static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
 {
-	u64 start = fieinfo->fi_start;
-	u64 len = fieinfo->fi_len;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	int ret;
@@ -2040,7 +2038,7 @@ static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
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
index 8d14d733a0e6..6ba59762c17c 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1103,18 +1103,14 @@ xfs_vn_fiemap(
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
index 834d3923e2f2..dfd4b193f1c0 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -177,7 +177,7 @@ int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
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

