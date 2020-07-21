Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D1C228845
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 20:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgGUScK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 14:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGUScG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 14:32:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F38AC061794;
        Tue, 21 Jul 2020 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GzIGQ/IDPs3sg9v+Bc2PW8SnyaJxpRjXtcrdrPZplIY=; b=PERTZ1JddArB5VG4b0YQjzt4lr
        8BelUcw5MkPn9bek4/d71H7MarPZx++gJib+u66HHTa5NXAnp6oMXxumuklzs9lxfep1jMLcJEjBL
        q4BJI7w1ETZotvQFdJVhnd2oE8inbZd+qyfm1aHkoTKLMtAEdxDX08vz3Q+n7n1hSyvIsbtG+4Ygg
        wHcpoY8a+m1K85ixBP+LS4YTX8p8R1+eEFzRxdG0VdRJ781HCCqujBWi0U+9tIMzM72Uacfkr5A8x
        HneYl0O2yosFjGAaXX2+z6Z6VJpyEiBh72eXzRQvvJBG+0+sW8GttAzQj99w3+VJZtXmqgGoAYKId
        ss3ZaZrw==;
Received: from [2001:4bb8:18c:2acc:5b1c:6483:bd6d:e406] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxx3Y-00062O-Pa; Tue, 21 Jul 2020 18:32:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 1/3] xfs: use ENOTBLK for direct I/O to buffered I/O fallback
Date:   Tue, 21 Jul 2020 20:31:55 +0200
Message-Id: <20200721183157.202276-2-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721183157.202276-1-hch@lst.de>
References: <20200721183157.202276-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is what the classic fs/direct-io.c implementation and thuse other
file systems use.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 00db81eac80d6c..a6ef90457abf97 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -505,7 +505,7 @@ xfs_file_dio_aio_write(
 		 */
 		if (xfs_is_cow_inode(ip)) {
 			trace_xfs_reflink_bounce_dio_write(ip, iocb->ki_pos, count);
-			return -EREMCHG;
+			return -ENOTBLK;
 		}
 		iolock = XFS_IOLOCK_EXCL;
 	} else {
@@ -714,7 +714,7 @@ xfs_file_write_iter(
 		 * allow an operation to fall back to buffered mode.
 		 */
 		ret = xfs_file_dio_aio_write(iocb, from);
-		if (ret != -EREMCHG)
+		if (ret != -ENOTBLK)
 			return ret;
 	}
 
-- 
2.27.0

