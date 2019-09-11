Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51852AFDED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 15:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfIKNnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 09:43:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbfIKNnh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:43:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D596636C;
        Wed, 11 Sep 2019 13:43:37 +0000 (UTC)
Received: from pegasus.maiolino.com (ovpn-204-18.brq.redhat.com [10.40.204.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE2FC10018F8;
        Wed, 11 Sep 2019 13:43:35 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH 9/9] xfs: Get rid of ->bmap
Date:   Wed, 11 Sep 2019 15:43:15 +0200
Message-Id: <20190911134315.27380-10-cmaiolino@redhat.com>
In-Reply-To: <20190911134315.27380-1-cmaiolino@redhat.com>
References: <20190911134315.27380-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 11 Sep 2019 13:43:37 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't need ->bmap anymore, only usage for it was FIBMAP, which is now
gone.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---

Changelog:
	V5:
		- Properly rebase against 5.3
		- iomap_{bmap(),bmap_actor()} are now used also by GFS2, so
		  don't remove them anymore
	V2:
		- Kill iomap_bmap() and iomap_bmap_actor()

 fs/xfs/xfs_aops.c  | 24 ------------------------
 fs/xfs/xfs_trace.h |  1 -
 2 files changed, 25 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 4e4a4d7df5ac..a2884537d2c2 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -1138,29 +1138,6 @@ xfs_vm_releasepage(
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
@@ -1199,7 +1176,6 @@ const struct address_space_operations xfs_address_space_operations = {
 	.set_page_dirty		= iomap_set_page_dirty,
 	.releasepage		= xfs_vm_releasepage,
 	.invalidatepage		= xfs_vm_invalidatepage,
-	.bmap			= xfs_vm_bmap,
 	.direct_IO		= noop_direct_IO,
 	.migratepage		= iomap_migrate_page,
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index eaae275ed430..c226b562f5da 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -626,7 +626,6 @@ DEFINE_INODE_EVENT(xfs_readdir);
 #ifdef CONFIG_XFS_POSIX_ACL
 DEFINE_INODE_EVENT(xfs_get_acl);
 #endif
-DEFINE_INODE_EVENT(xfs_vm_bmap);
 DEFINE_INODE_EVENT(xfs_file_ioctl);
 DEFINE_INODE_EVENT(xfs_file_compat_ioctl);
 DEFINE_INODE_EVENT(xfs_ioctl_setattr);
-- 
2.20.1

