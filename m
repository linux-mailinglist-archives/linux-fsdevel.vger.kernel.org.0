Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7EC431526
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 12:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhJRKPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 06:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhJRKOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:14:37 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8403DC061745;
        Mon, 18 Oct 2021 03:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nOP5ubv8zHIPTFPGGp4mMR4qIBoLNo6J7j7POF84hxo=; b=WDdgm8VMUNVUMbVn2sMmo1G+5L
        eudstPeymp6AKn6+7DXE/IHIBpUIHRL7C2g7/9HaKr9js7AgajBXO15R1v7Mwdo560m7U7iACplzh
        jy3PwmC0UtvAzcUXJEnNIxVBBCYzHZzjkJk5dK9seUv679acmvHXkjRbcrjxTaxZw/rLfMTSYUYHv
        4JqtDqDw65qSiAUND+Umm6mYpaUvoYftrT4X5lq3uD4It5XDVZj0HDcaUjcWZdDaC86//yxY3AHuf
        /xT0oYxrPWo/LvowhZaAQStnvg2VsyMKOmPGUkJrk8yI7fChJyOAROyhLyWnbasGUgO9pzAoEKmAx
        /Ftuo4bw==;
Received: from [2001:4bb8:199:73c5:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcPcr-00EuNu-H4; Mon, 18 Oct 2021 10:12:13 +0000
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
Subject: [PATCH 15/30] hfs: use bdev_nr_sectors instead of open coding it
Date:   Mon, 18 Oct 2021 12:11:15 +0200
Message-Id: <20211018101130.1838532-16-hch@lst.de>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/hfs/mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index cdf0edeeb2781..5beb826524354 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -36,7 +36,7 @@ static int hfs_get_last_session(struct super_block *sb,
 
 	/* default values */
 	*start = 0;
-	*size = i_size_read(sb->s_bdev->bd_inode) >> 9;
+	*size = bdev_nr_sectors(sb->s_bdev);
 
 	if (HFS_SB(sb)->session >= 0) {
 		struct cdrom_tocentry te;
-- 
2.30.2

