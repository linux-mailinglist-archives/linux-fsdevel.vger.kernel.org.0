Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E61431443
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 12:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhJRKOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 06:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhJRKOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:14:05 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1757C061714;
        Mon, 18 Oct 2021 03:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DmM3dWgdZg1sq+ld1mvVd1MY5RYF5XMOWvyajjuiGc4=; b=PmnNvw3VvBc4L+hdpo82yv+pwn
        2bva6WBAzlf3lxZwbZ65fxJurjtF2FHUc/o7+eu0WeMMMycW8UJrUOSUhB6em8WlJxz8RsgI3Iz/w
        NAVEe7CnHQCibc65uTbK0Cb1nPXyyPWDnuWb8BkOpIkPcovHGByb7gf0Q1VunfYwWA9JxZC+JWVKr
        6AG9KCDviM7N1Jazu0gY220bd6G086TImfuaEgNUA0zzx2NZVKSm1h7m12Ntsxbfon8rOihIY+i8B
        ATNREvUzjY4uz+wSlmJwNw36zDMS8aVW9yjBhrjVlf2tCyWfRPi768uHtYkgAdTlTBXRY46tlhK5q
        05vZat2Q==;
Received: from [2001:4bb8:199:73c5:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcPcF-00Etyg-Rf; Mon, 18 Oct 2021 10:11:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 01/30] block: move the SECTOR_SIZE related definitions to blk_types.h
Date:   Mon, 18 Oct 2021 12:11:01 +0200
Message-Id: <20211018101130.1838532-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018101130.1838532-1-hch@lst.de>
References: <20211018101130.1838532-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure these are always available for inlines in the various block layer
headers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 include/linux/blk_types.h | 17 +++++++++++++++++
 include/linux/blkdev.h    | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3b967053e9f5a..dc8da0c7fa09b 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -20,6 +20,23 @@ struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
 struct bio_crypt_ctx;
 
+/*
+ * The basic unit of block I/O is a sector. It is used in a number of contexts
+ * in Linux (blk, bio, genhd). The size of one sector is 512 = 2**9
+ * bytes. Variables of type sector_t represent an offset or size that is a
+ * multiple of 512 bytes. Hence these two constants.
+ */
+#ifndef SECTOR_SHIFT
+#define SECTOR_SHIFT 9
+#endif
+#ifndef SECTOR_SIZE
+#define SECTOR_SIZE (1 << SECTOR_SHIFT)
+#endif
+
+#define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
+#define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
+#define SECTOR_MASK		(PAGE_SECTORS - 1)
+
 struct block_device {
 	sector_t		bd_start_sect;
 	struct disk_stats __percpu *bd_stats;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 17705c970d7e1..161496d1aced0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -571,23 +571,6 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 	return bdev->bd_disk->queue;	/* this is never NULL */
 }
 
-/*
- * The basic unit of block I/O is a sector. It is used in a number of contexts
- * in Linux (blk, bio, genhd). The size of one sector is 512 = 2**9
- * bytes. Variables of type sector_t represent an offset or size that is a
- * multiple of 512 bytes. Hence these two constants.
- */
-#ifndef SECTOR_SHIFT
-#define SECTOR_SHIFT 9
-#endif
-#ifndef SECTOR_SIZE
-#define SECTOR_SIZE (1 << SECTOR_SHIFT)
-#endif
-
-#define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
-#define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
-#define SECTOR_MASK		(PAGE_SECTORS - 1)
-
 #ifdef CONFIG_BLK_DEV_ZONED
 
 /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
-- 
2.30.2

