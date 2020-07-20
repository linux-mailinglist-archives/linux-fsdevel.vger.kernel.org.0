Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F49422593A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 09:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGTHwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 03:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgGTHwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:52:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8065AC0619D4;
        Mon, 20 Jul 2020 00:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XQ9NddP3W3DiCYXLjgfasDBRt1T9rVqwnp2Rc31xuYM=; b=JpwZDKUEHtv6g3jgi0QIKUoqt/
        lWrsBvyz6CbD1Xn03Hw7sRtpUjO8RindjU7lOeMXsygKFCqKDrxCyGD59XSAHsOcIEccjbUrncN4C
        dZrUeO6jEaCTFGIwOgUZZX6D89lZtICY0P6kLpJt5372kybAu2tiOnu2E+hkB4DCsfiv71IQw8qjR
        cA5y+aHBP61BvuiXMQtHR3tpify4rk28riuu/ogn219+y9MgJFdEoYuCkTm3fJOcUXstJYx9+bCEI
        Grd07UIGTeUBeEYU1CyVYB0hrKUtv0RP7XtwHDSQl/QpqGluhNmLtEhJZ4zr6OgUd+W+lhd1ddj4L
        /JHTFtUw==;
Received: from [2001:4bb8:105:4a81:5185:88fc:94bb:f8bf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxQaa-00040V-RL; Mon, 20 Jul 2020 07:51:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: [PATCH 04/14] bdi: initialize ->ra_pages in bdi_init
Date:   Mon, 20 Jul 2020 09:51:38 +0200
Message-Id: <20200720075148.172156-5-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720075148.172156-1-hch@lst.de>
References: <20200720075148.172156-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Set up a readahead size by default.  This changes behavior for mtd,
ubifs, and vboxsf to actually enabled readahead, the lack of which
very much looks like an oversight.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c   | 1 -
 fs/9p/vfs_super.c  | 4 ++--
 fs/afs/super.c     | 1 -
 fs/btrfs/disk-io.c | 1 -
 fs/fuse/inode.c    | 1 -
 fs/nfs/super.c     | 9 +--------
 mm/backing-dev.c   | 1 +
 7 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 93104c7470e8ac..ea1665de7a2079 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -538,7 +538,6 @@ struct request_queue *blk_alloc_queue(int node_id)
 	if (!q->stats)
 		goto fail_stats;
 
-	q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
 	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
 	q->node = node_id;
 
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 74df32be4c6a52..a338eb979cadf9 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -80,8 +80,8 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 	if (ret)
 		return ret;
 
-	if (v9ses->cache)
-		sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
+	if (!v9ses->cache)
+		sb->s_bdi->ra_pages = 0;
 
 	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
 	if (!v9ses->cache)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index b552357b1d1379..3a40ee752c1e3f 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -456,7 +456,6 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	ret = super_setup_bdi(sb);
 	if (ret)
 		return ret;
-	sb->s_bdi->ra_pages	= VM_READAHEAD_PAGES;
 
 	/* allocate the root inode and dentry */
 	if (as->dyn_root) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index eb5f2506cede72..67677207d1647d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3031,7 +3031,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 
 	sb->s_bdi->capabilities |= BDI_CAP_CGROUP_WRITEBACK;
-	sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
 	sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
 	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5b4aebf5821fea..84fe187eb64385 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1037,7 +1037,6 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 	if (err)
 		return err;
 
-	sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
 	/* fuse does it's own writeback accounting */
 	sb->s_bdi->capabilities = BDI_CAP_NO_ACCT_WB | BDI_CAP_STRICTLIMIT;
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 7a70287f21a2c1..f943e37853fa25 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1200,13 +1200,6 @@ static void nfs_get_cache_cookie(struct super_block *sb,
 }
 #endif
 
-static void nfs_set_readahead(struct backing_dev_info *bdi,
-			      unsigned long iomax_pages)
-{
-	bdi->ra_pages = VM_READAHEAD_PAGES;
-	bdi->io_pages = iomax_pages;
-}
-
 int nfs_get_tree_common(struct fs_context *fc)
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
@@ -1251,7 +1244,7 @@ int nfs_get_tree_common(struct fs_context *fc)
 					     MINOR(server->s_dev));
 		if (error)
 			goto error_splat_super;
-		nfs_set_readahead(s->s_bdi, server->rpages);
+		s->s_bdi->io_pages = server->rpages;
 		server->super = s;
 	}
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 8e8b00627bb2d8..3e441e0ff1bc88 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -746,6 +746,7 @@ struct backing_dev_info *bdi_alloc(int node_id)
 		kfree(bdi);
 		return NULL;
 	}
+	bdi->ra_pages = VM_READAHEAD_PAGES;
 	return bdi;
 }
 EXPORT_SYMBOL(bdi_alloc);
-- 
2.27.0

