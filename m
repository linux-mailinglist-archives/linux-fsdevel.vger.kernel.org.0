Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C8F42B5B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 07:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbhJMFlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 01:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbhJMFla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 01:41:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B9AC061570;
        Tue, 12 Oct 2021 22:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=neY9ZJPH9MOzXmChpQoZ9vtfCPorKJutFa1ekdF3DV4=; b=PfsnohEdvhV/ruqSbu6iivGJd0
        Zo3djyN81Xn383MmVLbTJS1kEa9ZCXS2mDK7N5D8NmAUj88uBINNyCVjbt3Hz2fQVnR03Zhjiq14G
        7zKHh2mUo689xTR7fXEhFyPZxgwKxVIRy1j43hJzInRINaWAIzmG5d6Ld0VmrNJ+Kq8r9BVg4Cbci
        R/3myVb4K7ohrxlSfIhxqYAmYvFKTO+S1ZDDBa/9e8IX/lkJ4nmXRD2lGIKarWEbMdpJEKTQye58o
        teu82AOgZQfEvAkdOov+/Ln7EN2g7QtqcBdIkCnPq14ddL0H7JCQgOHyHVTLPqcDo9HQcK5qlrTAA
        FSxta/Cg==;
Received: from 089144212063.atnat0021.highway.a1.net ([89.144.212.63] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maWui-0077oT-Pz; Wed, 13 Oct 2021 05:35:26 +0000
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
Subject: [PATCH 21/29] reiserfs: use bdev_nr_sectors instead of open coding it
Date:   Wed, 13 Oct 2021 07:10:34 +0200
Message-Id: <20211013051042.1065752-22-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013051042.1065752-1-hch@lst.de>
References: <20211013051042.1065752-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the proper helper to read the block device size and remove two
cargo culted checks that can't be false.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/reiserfs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 58481f8d63d5b..6c9681e2809f0 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1986,8 +1986,7 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
 	 * smaller than the filesystem. If the check fails then abort and
 	 * scream, because bad stuff will happen otherwise.
 	 */
-	if (s->s_bdev && s->s_bdev->bd_inode
-	    && i_size_read(s->s_bdev->bd_inode) <
+	if ((bdev_nr_sectors(s->s_bdev) << SECTOR_SHIFT) <
 	    sb_block_count(rs) * sb_blocksize(rs)) {
 		SWARN(silent, s, "", "Filesystem cannot be "
 		      "mounted because it is bigger than the device");
-- 
2.30.2

