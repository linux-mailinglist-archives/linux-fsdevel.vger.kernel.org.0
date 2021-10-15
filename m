Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D242F2F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbhJONbi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 09:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbhJONaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:30:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF29C06177A;
        Fri, 15 Oct 2021 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ai4Hawm9L0+YfyvXsxKoJvFRQPPtEAYUdrDSGvUezpg=; b=Fv/TNdfZ5HNAZQvGuHlus1BTgZ
        cp7/gVw0FYdafMMg8RtWpKMrpcV5QXlA2qaZ8jp/MhStUsC9Xl3q/wB9/kg7sOCDhuqjVbI63Um1D
        h4MlDBQKlR5NZNquOMxzGkd8ROXXi+oxcew3ox5zv9ddNb9kpKVe726+PvFh7RD84Hu/LCuilqO5W
        Ug5zbJhTnZrFhEpy1p922CcIjcgU0F6i4u96lUI0EBOjyS1r5xOUC1aSEVjb1WEngVGIZVIGyhL0p
        EmF9/PMsmmCzUiYhS4ifjNGVPpas9tStfxLgkilKELEFACMDHge4tuUAHJDuhXz0IUZYvYUIdjFHG
        SHJjDLOw==;
Received: from [2001:4bb8:199:73c5:ddfe:9587:819b:83b0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbNFC-007DIv-6E; Fri, 15 Oct 2021 13:27:30 +0000
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
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH 17/30] jfs: use bdev_nr_bytes instead of open coding it
Date:   Fri, 15 Oct 2021 15:26:30 +0200
Message-Id: <20211015132643.1621913-18-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015132643.1621913-1-hch@lst.de>
References: <20211015132643.1621913-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the proper helper to read the block device size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 fs/jfs/resize.c | 2 +-
 fs/jfs/super.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/resize.c b/fs/jfs/resize.c
index bde787c354fcc..a42dbb0d3d28a 100644
--- a/fs/jfs/resize.c
+++ b/fs/jfs/resize.c
@@ -199,7 +199,7 @@ int jfs_extendfs(struct super_block *sb, s64 newLVSize, int newLogSize)
 	txQuiesce(sb);
 
 	/* Reset size of direct inode */
-	sbi->direct_inode->i_size =  i_size_read(sb->s_bdev->bd_inode);
+	sbi->direct_inode->i_size = bdev_nr_bytes(sb->s_bdev);
 
 	if (sbi->mntflag & JFS_INLINELOG) {
 		/*
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 9030aeaf0f886..9241caa161163 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -551,7 +551,7 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 		ret = -ENOMEM;
 		goto out_unload;
 	}
-	inode->i_size = i_size_read(sb->s_bdev->bd_inode);
+	inode->i_size = bdev_nr_bytes(sb->s_bdev);
 	inode->i_mapping->a_ops = &jfs_metapage_aops;
 	inode_fake_hash(inode);
 	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
-- 
2.30.2

