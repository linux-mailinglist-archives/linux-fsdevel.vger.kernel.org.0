Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A0442B5E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 07:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbhJMFqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 01:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhJMFqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 01:46:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35138C061570;
        Tue, 12 Oct 2021 22:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vUXTd2YdXfDrfy4pbV8SMX7GiwQcZZ3XnEJ9sBFT+FY=; b=H0UVWNgwlojCDOZ0ZDJEHbcabH
        /9k0Jdc+YLFDHne+zfEyDy0jv5BMEE4tSHTVSjq9pY+zz3oa4oUqe8AXLPv3nLRy41ZvHo0BFuSsA
        MaY/EKHh1Bp7Uf1udgCZNNBxreNpTwvrd/EqmRLDQBn6IJi8YRJFbqQmFZeteuySU1Cfmu1NFiTgQ
        2LgWePcSz6O2+8NDUH5I2rp85amag5Y71YZ+7TLQm1/Q0On+c4vchAxkdL8ToRCxOv8PtjjyJ+kWZ
        +hJqPyUbz5GIMW3ia1Y04II/0+/C9L7zroftL5CNXO1fs8k/zQt2HAH6gz3BjvISqqA/tFFfZj+Q+
        u0lN1M/Q==;
Received: from 089144212063.atnat0021.highway.a1.net ([89.144.212.63] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maWyt-00789s-54; Wed, 13 Oct 2021 05:39:26 +0000
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
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 24/29] block: add a sb_bdev_nr_blocks helper
Date:   Wed, 13 Oct 2021 07:10:37 +0200
Message-Id: <20211013051042.1065752-25-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013051042.1065752-1-hch@lst.de>
References: <20211013051042.1065752-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to return the size of sb->s_bdev in sb->s_blocksize_bits
based unites.  Note that SECTOR_SHIFT has to be open coded due to
include dependency issues for now, but I have a plan to sort that out
eventually.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/genhd.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 082a3e5fd8fa1..6eaef8fa78bcd 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -245,6 +245,12 @@ static inline sector_t get_capacity(struct gendisk *disk)
 	return bdev_nr_sectors(disk->part0);
 }
 
+static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
+{
+	return bdev_nr_sectors(sb->s_bdev) >>
+		(sb->s_blocksize_bits - 9 /* SECTOR_SHIFT */);
+}
+
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
 void blk_drop_partitions(struct gendisk *disk);
 
-- 
2.30.2

