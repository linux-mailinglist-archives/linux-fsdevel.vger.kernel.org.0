Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4FD431540
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 12:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhJRKP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 06:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhJRKOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:14:53 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E05BC061765;
        Mon, 18 Oct 2021 03:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OtkCPV+Fhjutx3CncSj5AK/1XKnCr941YaNIR+S0yec=; b=Bng/VPZF7A2X7e+l/odmdmFVsR
        uZaNxs+4xbvAT0ZVHiP9vMKeWRfl0OhUA97nondabmgiu+HAT0cluWpFQMyhLwSu6BHF3zxAV3ADa
        bgB+rkBNn/fQgFa2DeznsvEBkxundC7d4+sOqSI9j9lA10fztmCiObDmHpn6DJCe7XrF63hbEkZhS
        nlBbH+GPx81ZxZHCJrsdlFlO8XJO5vSC7DwxB5/uxxFym2IIjZOaDMvif0g+DzHjX7UoTW9daOw0P
        HVQPKAp4ObdoMgVdu+JOZ5a1JHX1Vothqq5X0qhQF3UTM2wdCr+Cm0lynMlc3lB7wgbEKD5aDah/C
        IPQ0uCDg==;
Received: from [2001:4bb8:199:73c5:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcPd7-00EufA-9w; Mon, 18 Oct 2021 10:12:29 +0000
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
Date:   Mon, 18 Oct 2021 12:11:21 +0200
Message-Id: <20211018101130.1838532-22-hch@lst.de>
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
Acked-by: Kees Cook <keescook@chromium.org>
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

