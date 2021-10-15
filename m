Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D869742F328
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 15:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbhJONcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 09:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbhJONbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:31:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D775C0613E4;
        Fri, 15 Oct 2021 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iTkNgdZQfGbb+9lDXMsfvC3u93+ih5z1kRRb3JEnPvg=; b=yDKo1RdywItRfhYIz9Nb0Th3N0
        jyskvffRONUfYov3ps7NIN2bcYrSY1kVH/rMET0h4mckC5F6Z5dfoDXMuqQR+1A380T69k8/rna8o
        Sz61wZWc0EMZkOEU0JBxwh/JPH5CogU8brK2JCYi07o9TNH4HLWgRfvZBsQZwDca4qiE6DToo/jRG
        yEUlxHbhBZjStVK+nmtwj2d+uPVZtVn41SqpXrQ0/faySnYSYItmWfQqRwLSCQyxx5DdPJ3StERqv
        +1OLTYHNUGVkssS83FORyRn/BoLOKKiLwQ3LHaPXG4WMNyyy/wyjDz8K+PX8AcqkGxM2lnKfOVXAB
        9IL+N9+A==;
Received: from [2001:4bb8:199:73c5:ddfe:9587:819b:83b0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbNFM-007DUf-Fs; Fri, 15 Oct 2021 13:27:40 +0000
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
Subject: [PATCH 21/30] pstore/blk: use bdev_nr_bytes instead of open coding it
Date:   Fri, 15 Oct 2021 15:26:34 +0200
Message-Id: <20211015132643.1621913-22-hch@lst.de>
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
---
 fs/pstore/blk.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 04ce58c939a0b..5d1fbaffd66a1 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -205,7 +205,6 @@ static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
 static int __register_pstore_blk(struct pstore_device_info *dev,
 				 const char *devpath)
 {
-	struct inode *inode;
 	int ret = -ENODEV;
 
 	lockdep_assert_held(&pstore_blk_lock);
@@ -217,14 +216,13 @@ static int __register_pstore_blk(struct pstore_device_info *dev,
 		goto err;
 	}
 
-	inode = file_inode(psblk_file);
-	if (!S_ISBLK(inode->i_mode)) {
+	if (!S_ISBLK(file_inode(psblk_file)->i_mode)) {
 		pr_err("'%s' is not block device!\n", devpath);
 		goto err_fput;
 	}
 
-	inode = I_BDEV(psblk_file->f_mapping->host)->bd_inode;
-	dev->zone.total_size = i_size_read(inode);
+	dev->zone.total_size =
+		bdev_nr_bytes(I_BDEV(psblk_file->f_mapping->host));
 
 	ret = __register_pstore_device(dev);
 	if (ret)
-- 
2.30.2

