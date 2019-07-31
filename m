Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD4F77C48F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 16:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfGaONX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 10:13:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbfGaONW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:13:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7085C30ADC79;
        Wed, 31 Jul 2019 14:13:22 +0000 (UTC)
Received: from pegasus.maiolino.com (unknown [10.40.205.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4DF360852;
        Wed, 31 Jul 2019 14:13:20 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, jaegeuk@kernel.org,
        darrick.wong@oracle.com, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 9/9] xfs: Get rid of ->bmap
Date:   Wed, 31 Jul 2019 16:12:45 +0200
Message-Id: <20190731141245.7230-10-cmaiolino@redhat.com>
In-Reply-To: <20190731141245.7230-1-cmaiolino@redhat.com>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 31 Jul 2019 14:13:22 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't need ->bmap anymore, only usage for it was FIBMAP, which is now
gone.

Also kill iomap_bmap() and iomap_bmap_actor once it has no users anymore.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---

Changelog:

V2:
	- Kill iomap_bmap() and iomap_bmap_actor()

 fs/iomap.c         | 34 ----------------------------------
 fs/xfs/xfs_aops.c  | 24 ------------------------
 fs/xfs/xfs_trace.h |  1 -
 3 files changed, 59 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 2b182abd18e8..12e6a575feb4 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -2153,37 +2153,3 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
 }
 EXPORT_SYMBOL_GPL(iomap_swapfile_activate);
 #endif /* CONFIG_SWAP */
-
-static loff_t
-iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap)
-{
-	sector_t *bno = data, addr;
-
-	if (iomap->type == IOMAP_MAPPED) {
-		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
-		if (addr > INT_MAX)
-			WARN(1, "would truncate bmap result\n");
-		else
-			*bno = addr;
-	}
-	return 0;
-}
-
-/* legacy ->bmap interface.  0 is the error return (!) */
-sector_t
-iomap_bmap(struct address_space *mapping, sector_t bno,
-		const struct iomap_ops *ops)
-{
-	struct inode *inode = mapping->host;
-	loff_t pos = bno << inode->i_blkbits;
-	unsigned blocksize = i_blocksize(inode);
-
-	if (filemap_write_and_wait(mapping))
-		return 0;
-
-	bno = 0;
-	iomap_apply(inode, pos, blocksize, 0, ops, &bno, iomap_bmap_actor);
-	return bno;
-}
-EXPORT_SYMBOL_GPL(iomap_bmap);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 3619e9e8d359..76ee495eba1a 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -1006,29 +1006,6 @@ xfs_vm_releasepage(
 	return iomap_releasepage(page, gfp_mask);
 }
 
-STATIC sector_t
-xfs_vm_bmap(
-	struct address_space	*mapping,
-	sector_t		block)
-{
-	struct xfs_inode	*ip = XFS_I(mapping->host);
-
-	trace_xfs_vm_bmap(ip);
-
-	/*
-	 * The swap code (ab-)uses ->bmap to get a block mapping and then
-	 * bypasses the file system for actual I/O.  We really can't allow
-	 * that on reflinks inodes, so we have to skip out here.  And yes,
-	 * 0 is the magic code for a bmap error.
-	 *
-	 * Since we don't pass back blockdev info, we can't return bmap
-	 * information for rt files either.
-	 */
-	if (xfs_is_cow_inode(ip) || XFS_IS_REALTIME_INODE(ip))
-		return 0;
-	return iomap_bmap(mapping, block, &xfs_iomap_ops);
-}
-
 STATIC int
 xfs_vm_readpage(
 	struct file		*unused,
@@ -1067,7 +1044,6 @@ const struct address_space_operations xfs_address_space_operations = {
 	.set_page_dirty		= iomap_set_page_dirty,
 	.releasepage		= xfs_vm_releasepage,
 	.invalidatepage		= xfs_vm_invalidatepage,
-	.bmap			= xfs_vm_bmap,
 	.direct_IO		= noop_direct_IO,
 	.migratepage		= iomap_migrate_page,
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 47fb07d86efd..3a45a3971dce 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -621,7 +621,6 @@ DEFINE_INODE_EVENT(xfs_readdir);
 #ifdef CONFIG_XFS_POSIX_ACL
 DEFINE_INODE_EVENT(xfs_get_acl);
 #endif
-DEFINE_INODE_EVENT(xfs_vm_bmap);
 DEFINE_INODE_EVENT(xfs_file_ioctl);
 DEFINE_INODE_EVENT(xfs_file_compat_ioctl);
 DEFINE_INODE_EVENT(xfs_ioctl_setattr);
-- 
2.20.1

