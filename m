Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB45431533
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 12:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhJRKPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 06:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhJRKOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:14:43 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E5EC06176C;
        Mon, 18 Oct 2021 03:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=osxw+vfeTnGlEsqH7zjz3v2g+MYYgjLX6YEKTd2gUSw=; b=dlkKT5CDwYhKpw3HO05O5ueVEs
        tPF01dQcBxy6UOjZkARq5q410PLnD4OYyHYK26f8HCUTvw+qev6XG1teUbqOBTY3oiPoD7wGKgyaZ
        I1poZwCw62UaIuseuiYbfCGvJwOXSEcTdw11lvi2V84/tFWY4B2iATcJCg8n3GApD/2OdVVVqqKWC
        KEAEFArDSd767/i9m0mkrvP73sRApUHo+Vt9+L0oYPQESq91baIa/kJK5OID9vPZ6yuhsMz748Oeg
        FQzopBTaYIpkPGNfHvVDwIxlbbNHyFzq6EtUcTUkpWI7l8X3IgHB+q/z0jl0JOzWQd2/Ugu4sb2+T
        eTx5yDtA==;
Received: from [2001:4bb8:199:73c5:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcPcz-00EuUT-EY; Mon, 18 Oct 2021 10:12:21 +0000
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
Subject: [PATCH 18/30] nfs/blocklayout: use bdev_nr_bytes instead of open coding it
Date:   Mon, 18 Oct 2021 12:11:18 +0200
Message-Id: <20211018101130.1838532-19-hch@lst.de>
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
 fs/nfs/blocklayout/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index acb1d22907daf..5e56da748b2ab 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -252,7 +252,7 @@ bl_parse_simple(struct nfs_server *server, struct pnfs_block_dev *d,
 	d->bdev = bdev;
 
 
-	d->len = i_size_read(d->bdev->bd_inode);
+	d->len = bdev_nr_bytes(d->bdev);
 	d->map = bl_map_simple;
 
 	printk(KERN_INFO "pNFS: using block device %s\n",
@@ -367,7 +367,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		return PTR_ERR(bdev);
 	d->bdev = bdev;
 
-	d->len = i_size_read(d->bdev->bd_inode);
+	d->len = bdev_nr_bytes(d->bdev);
 	d->map = bl_map_simple;
 	d->pr_key = v->scsi.pr_key;
 
-- 
2.30.2

