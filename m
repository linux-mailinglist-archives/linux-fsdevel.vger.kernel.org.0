Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3709D26B20F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgIOWki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbgIOQKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:10:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5240CC06121E;
        Tue, 15 Sep 2020 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0GTh7/oz6MJJ/leTjv6ZPfgdSyXwNjIPMnPsQbVzJYc=; b=gzAWZQBXfwu/NBHz5XlfXhr1mc
        McOuGCZUAkjTQhGXXdmUEvWiDHXiQArl6u2Z0N39fj6edcjTJV4+teowK4jjzJ4n9wXMeyhTmmekG
        hZje9bhyAx8R9ZFjK3QWK+MDJOU5n+rk1gqTY9RAWZz7whVbDbMLCp9GyjqrZ9OsGMD2BxwAPqCws
        z3PPoLlJ3DlqkWH/0nkPQpfz98GYa+OX97F3dXae61ZZ/yHbaEG9SaEhpkDtIXcUOFrgOsplf2qyV
        fLiSE/tOiyj98OWUcMZjdiT3ZWheSU7nIL2c4hbODSYrSJ4nG6Gj2DDSjNcOAlxTt4jHKEkko26P8
        QDACDuNA==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kICzx-00023R-8x; Tue, 15 Sep 2020 15:36:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/12] bdi: remove BDI_CAP_CGROUP_WRITEBACK
Date:   Tue, 15 Sep 2020 17:18:24 +0200
Message-Id: <20200915151829.1767176-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915151829.1767176-1-hch@lst.de>
References: <20200915151829.1767176-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just checking SB_I_CGROUPWB for cgroup writeback support is enough.
Either the file system allocates its own bdi (e.g. btrfs), in which case
it is known to support cgroup writeback, or the bdi comes from the block
layer, which always supports cgroup writeback.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-core.c            | 1 -
 fs/btrfs/disk-io.c          | 1 -
 include/linux/backing-dev.h | 8 +++-----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 865d39e5be2b28..1cc4fa6bc7fe1f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -538,7 +538,6 @@ struct request_queue *blk_alloc_queue(int node_id)
 	if (!q->stats)
 		goto fail_stats;
 
-	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
 	q->node = node_id;
 
 	atomic_set(&q->nr_active_requests_shared_sbitmap, 0);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 047934cea25efa..e24927bddd5829 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3091,7 +3091,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sb_buffer;
 	}
 
-	sb->s_bdi->capabilities |= BDI_CAP_CGROUP_WRITEBACK;
 	sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
 	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
 
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 0b06b2d26c9aa3..52583b6f2ea05d 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -123,7 +123,6 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
  * BDI_CAP_NO_ACCT_WB:     Don't automatically account writeback pages
  * BDI_CAP_STRICTLIMIT:    Keep number of dirty pages below bdi threshold.
  *
- * BDI_CAP_CGROUP_WRITEBACK: Supports cgroup-aware writeback.
  * BDI_CAP_SYNCHRONOUS_IO: Device is so fast that asynchronous IO would be
  *			   inefficient.
  */
@@ -233,9 +232,9 @@ int inode_congested(struct inode *inode, int cong_bits);
  * inode_cgwb_enabled - test whether cgroup writeback is enabled on an inode
  * @inode: inode of interest
  *
- * cgroup writeback requires support from both the bdi and filesystem.
- * Also, both memcg and iocg have to be on the default hierarchy.  Test
- * whether all conditions are met.
+ * Cgroup writeback requires support from the filesystem.  Also, both memcg and
+ * iocg have to be on the default hierarchy.  Test whether all conditions are
+ * met.
  *
  * Note that the test result may change dynamically on the same inode
  * depending on how memcg and iocg are configured.
@@ -247,7 +246,6 @@ static inline bool inode_cgwb_enabled(struct inode *inode)
 	return cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
 		cgroup_subsys_on_dfl(io_cgrp_subsys) &&
 		bdi_cap_account_dirty(bdi) &&
-		(bdi->capabilities & BDI_CAP_CGROUP_WRITEBACK) &&
 		(inode->i_sb->s_iflags & SB_I_CGROUPWB);
 }
 
-- 
2.28.0

