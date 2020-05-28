Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025EA1E6AC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 21:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406531AbgE1TZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 15:25:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:41628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406316AbgE1TVI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 15:21:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 35992AE8C;
        Thu, 28 May 2020 19:21:06 +0000 (UTC)
Date:   Thu, 28 May 2020 14:21:03 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        hch@infradead.org, dsterba@suse.cz, darrick.wong@oracle.com,
        fdmanana@gmail.com
Subject: [PATCH] iomap: Return zero in case of unsuccessful pagecache
 invalidation before DIO
Message-ID: <20200528192103.xm45qoxqmkw7i5yl@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Filesystems such as btrfs are unable to guarantee page invalidation
because pages could be locked as a part of the extent. Return zero
in case a page cache invalidation is unsuccessful so filesystems can
fallback to buffered I/O. This is similar to
generic_file_direct_write().

This takes care of the following invalidation warning during btrfs
mixed buffered and direct I/O using iomap_dio_rw():

Page cache invalidation failure on direct I/O.  Possible data
corruption due to collision with buffered I/O!

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index e4addfc58107..215315be6233 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	 */
 	ret = invalidate_inode_pages2_range(mapping,
 			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
-	if (ret)
-		dio_warn_stale_pagecache(iocb->ki_filp);
-	ret = 0;
+	/*
+	 * If a page can not be invalidated, return 0 to fall back
+	 * to buffered write.
+	 */
+	if (ret) {
+		if (ret == -EBUSY)
+			ret = 0;
+		goto out_free_dio;
+	}
 
 	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
 	    !inode->i_sb->s_dio_done_wq) {

-- 
Goldwyn
