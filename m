Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FC943153B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 12:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhJRKPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 06:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbhJRKOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:14:52 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42923C061777;
        Mon, 18 Oct 2021 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7vy0+8EI8WhVCxcCPpT3E3xZPAv/h7863mIj0HITKC4=; b=dSgrFBalcG5IC5gy8leFi0/QUI
        8jbCvHeQvsAMp2Vc8XaJNgaFomPjUZxHYyC0Lr8ip+cEGSd3e9dOsE9BLDAOXLiIxKskzuJNVL/fJ
        9/vz7wC6aJeWCOa866cMrDClVUyh/nPJwEgGnkT7aSULX7H/Rx0e6fz/pzjosefYz2bVFgXRlecrl
        OK92p3ALP6pCTMlkZ3qBMnoKoRHEVAF7nq96GJlCV7bX4ForSv41tAleJNCMrpQJckjzxO/kA47Wn
        OAc86dc6jd8RmrmIqLhJBcqnOCCDYnNAaZzrQ6Qs4EG0Do8+0MqgT7yVBLcb6ir4m1vlBzJoKJsMs
        +PeH0mvg==;
Received: from [2001:4bb8:199:73c5:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcPd4-00Eubv-MF; Mon, 18 Oct 2021 10:12:27 +0000
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
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Subject: [PATCH 20/30] ntfs3: use bdev_nr_bytes instead of open coding it
Date:   Mon, 18 Oct 2021 12:11:20 +0200
Message-Id: <20211018101130.1838532-21-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018101130.1838532-1-hch@lst.de>
References: <20211018101130.1838532-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the proper helper to read the block device size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ntfs3/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 55bbc9200a10e..7ed2cb5e8b1d9 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -918,7 +918,6 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	int err;
 	struct ntfs_sb_info *sbi;
 	struct block_device *bdev = sb->s_bdev;
-	struct inode *bd_inode = bdev->bd_inode;
 	struct request_queue *rq = bdev_get_queue(bdev);
 	struct inode *inode = NULL;
 	struct ntfs_inode *ni;
@@ -967,7 +966,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	/* Parse boot. */
 	err = ntfs_init_from_boot(sb, rq ? queue_logical_block_size(rq) : 512,
-				  bd_inode->i_size);
+				  bdev_nr_bytes(bdev));
 	if (err)
 		goto out;
 
-- 
2.30.2

