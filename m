Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB321D0E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 09:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgGMHvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 03:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMHvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:51:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6486C061755;
        Mon, 13 Jul 2020 00:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hykAUMgpdata3SiriROHkxMEOf/Azb0hlzJQjPO3wYg=; b=A4BsM8ybPqUfXVx62Drwe/Jujf
        wqxr26Ne2OZ9n1+Y29edT9Ihi9/3yjAa3O8lsdObJCdoLIqlvoicozKagpEW+km6W1Kd5L5j4WXgb
        6JdA63PFf/vJaWt9Rzi9eMUEC7ydvOawKy3gXCZktTPjGUNVmKH6CWRMPGrL3BldlSj2hDoODaan3
        EjGsj1FftqH+P94yameCoeY9/KDKCoRQhz8r/DOFbOmM2dXEiDt+hyjOr0I+4bEm9px1etzUg8XYv
        zm/dDFoAnJcZhSHXRN7su3d2AZ/fyR0vkuheMnh1w1gDjB3+5D3KGYeuemqBz9HHAqdgHsKXg2EKj
        7XVMQB4Q==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jutEl-0001HX-SP; Mon, 13 Jul 2020 07:50:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 1/2] iomap: Only invalidate page cache pages on direct IO writes
Date:   Mon, 13 Jul 2020 09:46:32 +0200
Message-Id: <20200713074633.875946-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200713074633.875946-1-hch@lst.de>
References: <20200713074633.875946-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

The historic requirement for XFS to invalidate cached pages on
direct IO reads has been lost in the twisty pages of history - it was
inherited from Irix, which implemented page cache invalidation on
read as a method of working around problems synchronising page
cache state with uncached IO.

XFS has carried this ever since. In the initial linux ports it was
necessary to get mmap and DIO to play "ok" together and not
immediately corrupt data. This was the state of play until the linux
kernel had infrastructure to track unwritten extents and synchronise
page faults with allocations and unwritten extent conversions
(->page_mkwrite infrastructure). IOws, the page cache invalidation
on DIO read was necessary to prevent trivial data corruptions. This
didn't solve all the problems, though.

There were peformance problems if we didn't invalidate the entire
page cache over the file on read - we couldn't easily determine if
the cached pages were over the range of the IO, and invalidation
required taking a serialising lock (i_mutex) on the inode. This
serialising lock was an issue for XFS, as it was the only exclusive
lock in the direct Io read path.

Hence if there were any cached pages, we'd just invalidate the
entire file in one go so that subsequent IOs didn't need to take the
serialising lock. This was a problem that prevented ranged
invalidation from being particularly useful for avoiding the
remaining coherency issues. This was solved with the conversion of
i_mutex to i_rwsem and the conversion of the XFS inode IO lock to
use i_rwsem. Hence we could now just do ranged invalidation and the
performance problem went away.

However, page cache invalidation was still needed to serialise
sub-page/sub-block zeroing via direct IO against buffered IO because
bufferhead state attached to the cached page could get out of whack
when direct IOs were issued.  We've removed bufferheads from the
XFS code, and we don't carry any extent state on the cached pages
anymore, and so this problem has gone away, too.

IOWs, it would appear that we don't have any good reason to be
invalidating the page cache on DIO reads anymore. Hence remove the
invalidation on read because it is unnecessary overhead,
not needed to maintain coherency between mmap/buffered access and
direct IO anymore, and prevents anyone from using direct IO reads
from intentionally invalidating the page cache of a file.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ec7b78e6fecaf9..190967e87b69e4 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -475,23 +475,22 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (ret)
 		goto out_free_dio;
 
-	/*
-	 * Try to invalidate cache pages for the range we're direct
-	 * writing.  If this invalidation fails, tough, the write will
-	 * still work, but racing two incompatible write paths is a
-	 * pretty crazy thing to do, so we don't support it 100%.
-	 */
-	ret = invalidate_inode_pages2_range(mapping,
-			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
-	if (ret)
-		dio_warn_stale_pagecache(iocb->ki_filp);
-	ret = 0;
+	if (iov_iter_rw(iter) == WRITE) {
+		/*
+		 * Try to invalidate cache pages for the range we are writing.
+		 * If this invalidation fails, tough, the write will still work,
+		 * but racing two incompatible write paths is a pretty crazy
+		 * thing to do, so we don't support it 100%.
+		 */
+		if (invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
+				end >> PAGE_SHIFT))
+			dio_warn_stale_pagecache(iocb->ki_filp);
 
-	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
-	    !inode->i_sb->s_dio_done_wq) {
-		ret = sb_init_dio_done_wq(inode->i_sb);
-		if (ret < 0)
-			goto out_free_dio;
+		if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {
+			ret = sb_init_dio_done_wq(inode->i_sb);
+			if (ret < 0)
+				goto out_free_dio;
+		}
 	}
 
 	inode_dio_begin(inode);
-- 
2.26.2

