Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F824179C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 19:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347871AbhIXRV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 13:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347854AbhIXRU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632503964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x7BpkThd4W7Otj77d326ZQ439zIBR66OsnpLRS8EUC4=;
        b=T1l07n8bWH7pYgykqlnFUvKGGYhO7Wiw4/7ewh4fVQ3Y0I8wzAafhgt+mPu8659E5mrj9b
        kkXuXKQDWhk4iekFf1MTD5xdXOGaDkihxkjB79TCSmg3ERQRZnhlHlLo39lmeM7T6ofzMl
        83vUVS1dvPAKW5G6vIyp10BEC5Yxzn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-FXe5ABoKNvWZ-0xXSP1U8g-1; Fri, 24 Sep 2021 13:19:21 -0400
X-MC-Unique: FXe5ABoKNvWZ-0xXSP1U8g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F5DC802B9F;
        Fri, 24 Sep 2021 17:19:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7B3D5F707;
        Fri, 24 Sep 2021 17:19:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 8/9] block, btrfs, ext4, xfs: Implement swap_rw
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com
Cc:     Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, dhowells@redhat.com, dhowells@redhat.com,
        darrick.wong@oracle.com, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 18:19:11 +0100
Message-ID: <163250395192.2330363.9101664122191208351.stgit@warthog.procyon.org.uk>
In-Reply-To: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement swap_rw for block devices, btrfs, ext4 and xfs.  This allows the
the page swapping code to use direct-IO rather than direct bio submission,
whilst skipping the checks going via read/write_iter would entail.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Chris Mason <clm@fb.com>
cc: Josef Bacik <josef@toxicpanda.com>
cc: David Sterba <dsterba@suse.com>
cc: "Theodore Ts'o" <tytso@mit.edu>
cc: Andreas Dilger <adilger.kernel@dilger.ca>
cc: Darrick J. Wong <djwong@kernel.org>
cc: linux-block@vger.kernel.org
cc: linux-btrfs@vger.kernel.org
cc: linux-ext4@vger.kernel.org
cc: linux-xfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

 block/fops.c      |    1 +
 fs/btrfs/inode.c  |   12 +++++-------
 fs/ext4/inode.c   |    9 +++++++++
 fs/xfs/xfs_aops.c |    9 +++++++++
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 84c64d814d0d..7ba37dfafae2 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -382,6 +382,7 @@ const struct address_space_operations def_blk_aops = {
 	.write_end	= blkdev_write_end,
 	.writepages	= blkdev_writepages,
 	.direct_IO	= blkdev_direct_IO,
+	.swap_rw	= blkdev_direct_IO,
 	.migratepage	= buffer_migrate_page_norefs,
 	.is_dirty_writeback = buffer_check_dirty_writeback,
 	.supports	= AS_SUPPORTS_DIRECT_IO,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b479c97e42fc..9ffcefecb3bb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10852,15 +10852,10 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	sis->highest_bit = bsi.nr_pages - 1;
 	return bsi.nr_extents;
 }
-#else
-static void btrfs_swap_deactivate(struct file *file)
-{
-}
 
-static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
-			       sector_t *span)
+static ssize_t btrfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 {
-	return -EOPNOTSUPP;
+	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, NULL, 0);
 }
 #endif
 
@@ -10944,8 +10939,11 @@ static const struct address_space_operations btrfs_aops = {
 #endif
 	.set_page_dirty	= btrfs_set_page_dirty,
 	.error_remove_page = generic_error_remove_page,
+#ifdef CONFIG_SWAP
 	.swap_activate	= btrfs_swap_activate,
 	.swap_deactivate = btrfs_swap_deactivate,
+	.swap_rw	= btrfs_swap_rw,
+#endif
 	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 08d3541d8daa..3c14724d58a8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3651,6 +3651,11 @@ static int ext4_iomap_swap_activate(struct swap_info_struct *sis,
 				       &ext4_iomap_report_ops);
 }
 
+static ssize_t ext4_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
+{
+	return iomap_dio_rw(iocb, iter, &ext4_iomap_ops, NULL, 0);
+}
+
 static const struct address_space_operations ext4_aops = {
 	.readpage		= ext4_readpage,
 	.readahead		= ext4_readahead,
@@ -3666,6 +3671,7 @@ static const struct address_space_operations ext4_aops = {
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.swap_activate		= ext4_iomap_swap_activate,
+	.swap_rw		= ext4_swap_rw,
 	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
@@ -3683,6 +3689,7 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.swap_activate		= ext4_iomap_swap_activate,
+	.swap_rw		= ext4_swap_rw,
 	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
@@ -3701,6 +3708,7 @@ static const struct address_space_operations ext4_da_aops = {
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.swap_activate		= ext4_iomap_swap_activate,
+	.swap_rw		= ext4_swap_rw,
 	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
@@ -3710,6 +3718,7 @@ static const struct address_space_operations ext4_dax_aops = {
 	.bmap			= ext4_bmap,
 	.invalidatepage		= noop_invalidatepage,
 	.swap_activate		= ext4_iomap_swap_activate,
+	.swap_rw		= ext4_swap_rw,
 	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 2a4570516591..23ade2cc8241 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -540,6 +540,13 @@ xfs_iomap_swapfile_activate(
 			&xfs_read_iomap_ops);
 }
 
+static ssize_t xfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
+{
+	if (iocb->ki_flags & IOCB_WRITE)
+		return iomap_dio_rw(iocb, iter, &xfs_direct_write_iomap_ops, NULL, 0);
+	return iomap_dio_rw(iocb, iter, &xfs_read_iomap_ops, NULL, 0);
+}
+
 const struct address_space_operations xfs_address_space_operations = {
 	.readpage		= xfs_vm_readpage,
 	.readahead		= xfs_vm_readahead,
@@ -552,6 +559,7 @@ const struct address_space_operations xfs_address_space_operations = {
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.swap_activate		= xfs_iomap_swapfile_activate,
+	.swap_rw		= xfs_swap_rw,
 	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
@@ -560,5 +568,6 @@ const struct address_space_operations xfs_dax_aops = {
 	.set_page_dirty		= __set_page_dirty_no_writeback,
 	.invalidatepage		= noop_invalidatepage,
 	.swap_activate		= xfs_iomap_swapfile_activate,
+	.swap_rw		= xfs_swap_rw,
 	.supports		= AS_SUPPORTS_DIRECT_IO,
 };


