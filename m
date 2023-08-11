Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9ED778AEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbjHKKJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbjHKKJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:09:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A1C30E2;
        Fri, 11 Aug 2023 03:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=K/QBcOv4fTIU7nBesYdEWMXMlgsg7gJvNa3bCA3VzKs=; b=K2FtvqOc6v9BOz4kx+Q9nAQX35
        JA+FvvCyWF1N2GvLJ+tzYrLvjKzUxvBrw0YbLQK4cyDETzmkA8nS2pYTbU1l2LDHA1seMmpnhxYis
        YTGlfc/QmhyMJzSXTpMlFoJZxbLcohrsqte1tENFcJHDIdg/Eh8vxiqgyRCy65u6iSRu4I/8vsdh+
        UM28ssSRN4XuB2Z9kkibHdnWbS23rWBTtFmdjpz5b1exGl4liCAFQRwqSG3mQEYCE1RtbyhadZcI0
        sz0iQIkvuy1iVgGEABv0nHkoZk6vTKBqO441yl7JkYvaIcyHDPfvvYh2L5CvVqdFAzcJyEB5E1Zr3
        aAA80+RQ==;
Received: from [88.128.92.63] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUP4R-00A5aJ-1t;
        Fri, 11 Aug 2023 10:08:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/17] btrfs: call btrfs_close_devices from ->kill_sb
Date:   Fri, 11 Aug 2023 12:08:14 +0200
Message-Id: <20230811100828.1897174-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
References: <20230811100828.1897174-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

blkdev_put must not be called under sb->s_umount to avoid a lock order
reversal with disk->open_mutex once call backs from block devices to
the file system using the holder ops are supported.  Move the call
to btrfs_close_devices into btrfs_free_fs_info so that it is closed
from ->kill_sb (which is also called from the mount failure handling
path unlike ->put_super) as well as when an fs_info is freed because
an existing superblock already exists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c | 4 ++--
 fs/btrfs/super.c   | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7513388b0567be..3788b55638392e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1243,6 +1243,8 @@ static void free_global_roots(struct btrfs_fs_info *fs_info)
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
+	if (fs_info->fs_devices)
+		btrfs_close_devices(fs_info->fs_devices);
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
 	percpu_counter_destroy(&fs_info->ordered_bytes);
@@ -3554,7 +3556,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	iput(fs_info->btree_inode);
 fail:
-	btrfs_close_devices(fs_info->fs_devices);
 	ASSERT(ret < 0);
 	return ret;
 }
@@ -4408,7 +4409,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 #endif
 
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
-	btrfs_close_devices(fs_info->fs_devices);
 }
 
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b318bddefd5236..2bbc041ac2e2c5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1494,7 +1494,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 
 	if (!(flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
 		error = -EACCES;
-		goto error_close_devices;
+		goto error_fs_info;
 	}
 
 	bdev = fs_devices->latest_dev->bdev;
@@ -1502,11 +1502,10 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		 fs_info);
 	if (IS_ERR(s)) {
 		error = PTR_ERR(s);
-		goto error_close_devices;
+		goto error_fs_info;
 	}
 
 	if (s->s_root) {
-		btrfs_close_devices(fs_devices);
 		btrfs_free_fs_info(fs_info);
 		if ((flags ^ s->s_flags) & SB_RDONLY)
 			error = -EBUSY;
@@ -1527,8 +1526,6 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 
 	return dget(s->s_root);
 
-error_close_devices:
-	btrfs_close_devices(fs_devices);
 error_fs_info:
 	btrfs_free_fs_info(fs_info);
 error_sec_opts:
-- 
2.39.2

