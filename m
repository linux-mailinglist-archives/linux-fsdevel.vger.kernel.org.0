Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EBA42F34E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 15:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbhJONcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 09:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbhJONbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:31:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69950C0613EE;
        Fri, 15 Oct 2021 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kigc0P3dFD0qfhBcYu9B5JW+OSpi6OsZX3RdDiLn0fI=; b=LCt4ntrZkKIcG3YhEqxvrAUtxT
        V3gC/ilrIwuQ6rMwyBixGsZPIKmIGI5iri2yGEkJgmD9XxkMSz6NT74oEfGFEA7hQHpzJFZ+3leeE
        NwZam6HF/cTq3dB1ZAm+ZCgCIELOEB+AphB4iZlEdL5XDFyb9fn8I0d0fPTKmXapO75K2Ek2bPdgL
        pBRNjtr+q3XLSUv6GekhIoXXSJ4MQIJ/ysnnyRWzSBz6l4kL803FFSlJ++APIB5pEcUU0Nl54FD2G
        56wIKY5m+wHbLh1oZ/LykRavub0YOJ4kIFh5cTla1GyEz0I9addIH9LUh89uBVihmpBJnu4ErIk7G
        NuUPA2WQ==;
Received: from [2001:4bb8:199:73c5:ddfe:9587:819b:83b0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbNFW-007Dfi-S5; Fri, 15 Oct 2021 13:27:51 +0000
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
Subject: [PATCH 25/30] block: add a sb_bdev_nr_blocks helper
Date:   Fri, 15 Oct 2021 15:26:38 +0200
Message-Id: <20211015132643.1621913-26-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015132643.1621913-1-hch@lst.de>
References: <20211015132643.1621913-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
index f67db3c5a04b3..70b4ac47e693c 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -250,6 +250,12 @@ static inline sector_t get_capacity(struct gendisk *disk)
 	return bdev_nr_sectors(disk->part0);
 }
 
+static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
+{
+	return bdev_nr_sectors(sb->s_bdev) >>
+		(sb->s_blocksize_bits - SECTOR_SHIFT);
+}
+
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
 void blk_drop_partitions(struct gendisk *disk);
 
-- 
2.30.2

