Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99131FAE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfEOTa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfEOT1d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1999230001DA;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA71B1001DE1;
        Wed, 15 May 2019 19:27:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B7996225481; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 13/30] dax: Pass dax_dev to dax_writeback_mapping_range()
Date:   Wed, 15 May 2019 15:26:58 -0400
Message-Id: <20190515192715.18000-14-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 15 May 2019 19:27:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now dax_writeback_mapping_range() is passed a bdev and dax_dev
is searched from that bdev name.

virtio-fs does not have a bdev. So pass in dax_dev also to
dax_writeback_mapping_range(). If dax_dev is passed in, bdev is not
used otherwise dax_dev is searched using bdev.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c            | 16 ++++++++++------
 fs/ext2/inode.c     |  2 +-
 fs/ext4/inode.c     |  2 +-
 fs/xfs/xfs_aops.c   |  2 +-
 include/linux/dax.h |  6 ++++--
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 815bc32fd967..c944c1efc78f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -932,12 +932,12 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
  * on persistent storage prior to completion of the operation.
  */
 int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc)
+		struct block_device *bdev, struct dax_device *dax_dev,
+		struct writeback_control *wbc)
 {
 	XA_STATE(xas, &mapping->i_pages, wbc->range_start >> PAGE_SHIFT);
 	struct inode *inode = mapping->host;
 	pgoff_t end_index = wbc->range_end >> PAGE_SHIFT;
-	struct dax_device *dax_dev;
 	void *entry;
 	int ret = 0;
 	unsigned int scanned = 0;
@@ -948,9 +948,12 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 	if (!mapping->nrexceptional || wbc->sync_mode != WB_SYNC_ALL)
 		return 0;
 
-	dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
-	if (!dax_dev)
-		return -EIO;
+	if (bdev) {
+		WARN_ON(dax_dev);
+		dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
+		if (!dax_dev)
+			return -EIO;
+	}
 
 	trace_dax_writeback_range(inode, xas.xa_index, end_index);
 
@@ -972,7 +975,8 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 		xas_lock_irq(&xas);
 	}
 	xas_unlock_irq(&xas);
-	put_dax(dax_dev);
+	if (bdev)
+		put_dax(dax_dev);
 	trace_dax_writeback_range_done(inode, xas.xa_index, end_index);
 	return ret;
 }
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index c27c27300d95..9b0131c53429 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -956,7 +956,7 @@ static int
 ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	return dax_writeback_mapping_range(mapping,
-			mapping->host->i_sb->s_bdev, wbc);
+			mapping->host->i_sb->s_bdev, NULL, wbc);
 }
 
 const struct address_space_operations ext2_aops = {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b32a57bc5d5d..cb8cf5eddd9b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2972,7 +2972,7 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	percpu_down_read(&sbi->s_journal_flag_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
-	ret = dax_writeback_mapping_range(mapping, inode->i_sb->s_bdev, wbc);
+	ret = dax_writeback_mapping_range(mapping, inode->i_sb->s_bdev, NULL, wbc);
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
 	percpu_up_read(&sbi->s_journal_flag_rwsem);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 3619e9e8d359..27f71ff55096 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -994,7 +994,7 @@ xfs_dax_writepages(
 {
 	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
 	return dax_writeback_mapping_range(mapping,
-			xfs_find_bdev_for_inode(mapping->host), wbc);
+			xfs_find_bdev_for_inode(mapping->host), NULL, wbc);
 }
 
 STATIC int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 0dd316a74a29..bf3b00b5f0bf 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -87,7 +87,8 @@ static inline void fs_put_dax(struct dax_device *dax_dev)
 
 struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
 int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc);
+		struct block_device *bdev, struct dax_device *dax_dev,
+		struct writeback_control *wbc);
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
 dax_entry_t dax_lock_page(struct page *page);
@@ -119,7 +120,8 @@ static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 }
 
 static inline int dax_writeback_mapping_range(struct address_space *mapping,
-		struct block_device *bdev, struct writeback_control *wbc)
+		struct block_device *bdev, struct dax_device *dax_dev,
+		struct writeback_control *wbc)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.20.1

