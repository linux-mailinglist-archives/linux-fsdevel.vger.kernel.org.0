Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A39431549
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 12:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhJRKP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 06:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhJRKOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:14:54 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA320C061768;
        Mon, 18 Oct 2021 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JMPu+LENDBo5WUsA2GqtbBEG8Jw1OQsq2zrbWWP5Nwo=; b=LQSSZHMv2uVXfonRxRFX6ja6Oh
        eGRR3MNc1mGAQBs0DNyB1vRYImhOqowRmW7fyj72Thmu4pztEMuT8Sh29JBnr+5bFD5P4IVg/pf0I
        P/8IZtD68Tkv0tkuMKJyC/vOClkagcPllgq5l50/K8TpSSATx/V1h7/rHZsD/dE9ctisbuJUZr4PX
        /tn3a6rHsJivMC/Uk5TS1tifDMdYjU88x7OQ3LcwR5/i122NQR+WSmrzpiUcIcd/t8I+lkXLk6PxB
        qnF6M1SKLWCal6TQdjpgSU8sythC3yyy5ViLBJ+ETNWQbNUzHrxG//gf79BsT7p8S4G9ZZlzrekoX
        emqLZz4w==;
Received: from [2001:4bb8:199:73c5:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcPd9-00EuiW-Vx; Mon, 18 Oct 2021 10:12:32 +0000
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
Subject: [PATCH 22/30] reiserfs: use bdev_nr_bytes instead of open coding it
Date:   Mon, 18 Oct 2021 12:11:22 +0200
Message-Id: <20211018101130.1838532-23-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018101130.1838532-1-hch@lst.de>
References: <20211018101130.1838532-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the proper helper to read the block device size and remove two
cargo culted checks that can't be false.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 fs/reiserfs/super.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 58481f8d63d5b..8647a00434ea4 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1986,9 +1986,7 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
 	 * smaller than the filesystem. If the check fails then abort and
 	 * scream, because bad stuff will happen otherwise.
 	 */
-	if (s->s_bdev && s->s_bdev->bd_inode
-	    && i_size_read(s->s_bdev->bd_inode) <
-	    sb_block_count(rs) * sb_blocksize(rs)) {
+	if (bdev_nr_bytes(s->s_bdev) < sb_block_count(rs) * sb_blocksize(rs)) {
 		SWARN(silent, s, "", "Filesystem cannot be "
 		      "mounted because it is bigger than the device");
 		SWARN(silent, s, "", "You may need to run fsck "
-- 
2.30.2

