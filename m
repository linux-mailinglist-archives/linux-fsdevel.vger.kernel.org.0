Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205D46EC585
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 07:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjDXFvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 01:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjDXFvh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:51:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE29E44AE;
        Sun, 23 Apr 2023 22:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FmYSiKdP5y3EH7nBXTpf8bIFKknqbI4piiyOLlTcqUc=; b=4lxlR6BuJRIME1qgT/FLWEjLGd
        zZ93UA0UiVTZRciYnVz7BcBGh4qOlXvmDz+gYSX0gVpNssgkTRzVJ1F6XLACSvE58gCznare4IwV8
        ONhbJNRO+Rb7AwP4E4aB6azTfv6WnFdtXg9Bd7cQuw7++D8vMUNKfCzGFlYk6+3rORK1s3nJno0oL
        32gJ5Q9kRf7XT69Y0ns9Rw6WyLZWY36yGHyPSBD2vfFBjEti+pSoqjjyDRWgXT9qasHTXvq32XIhk
        aJhmCTOwekv9gG2uQmpUAPoElchnnj2w2DJgfRMI4gQ/+nTFeSLo60MajiM9lIGCzDORORrebRpsQ
        vbf3q+Zg==;
Received: from [2001:4bb8:189:a74f:e8a5:5f73:6d2:23b8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqp5U-00FP8b-21;
        Mon, 24 Apr 2023 05:50:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] block: don't plug in blkdev_write_iter
Date:   Mon, 24 Apr 2023 07:49:22 +0200
Message-Id: <20230424054926.26927-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424054926.26927-1-hch@lst.de>
References: <20230424054926.26927-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the no needed plug in blkdev_write_iter.  For direct I/O that
issues more than a single I/O, the plug is already done in
__blkdev_direct_IO, and for synchronous buffered writes, the plug
is done in writeback_inodes_wb / wb_writeback, while for the other
cases a plug doesn't make sense.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index c194939b851cfb..b670aa7c5bb745 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -520,7 +520,6 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct block_device *bdev = iocb->ki_filp->private_data;
 	struct inode *bd_inode = bdev->bd_inode;
 	loff_t size = bdev_nr_bytes(bdev);
-	struct blk_plug plug;
 	size_t shorted = 0;
 	ssize_t ret;
 
@@ -545,12 +544,10 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iov_iter_truncate(from, size);
 	}
 
-	blk_start_plug(&plug);
 	ret = __generic_file_write_iter(iocb, from);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
 	iov_iter_reexpand(from, iov_iter_count(from) + shorted);
-	blk_finish_plug(&plug);
 	return ret;
 }
 
-- 
2.39.2

