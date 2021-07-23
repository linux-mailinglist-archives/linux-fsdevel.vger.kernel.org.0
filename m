Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225A93D33DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 07:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGWEUG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 00:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhGWEUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 00:20:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A6FC061575;
        Thu, 22 Jul 2021 22:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4qd4HWfR62CNOrkSwzE6Doa+rbZvUu2MnV3xCDp5M6Y=; b=orkv4g04AUQYr+HMgYoF/k5xSF
        wIdA3/lfQnnkeZqpQRN75Xh2QRWa0OHn2w5cMNuhefHq2T7eT6wphEyIpPkm8ftUuhv6ygSb2R1nu
        bTMqM/sH5ZEWpdDuXPcgLLCbgsntwtmLFQMWWoTp/P4XgG2tgfE/Q75+yuHf/NVtSuo8EB8QXHC52
        q9xKUGz4TBsm/bxZSshhcrfalVECQxd+P7M5la3+x9/Be4KYvOQxdEpzwa65DFJiSZgUM3o+DXzrQ
        B59eYqiOYgmSVhuHk0X8G55Dc6Pbre/XuAwcW5teQg9aT6V2PleCQHnDUsIBuCt+mL8Cw6LdMX2tC
        tzKVwQBA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6nI3-00B0JI-MH; Fri, 23 Jul 2021 05:00:10 +0000
Date:   Fri, 23 Jul 2021 06:00:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 6/9] f2fs: implement iomap operations
Message-ID: <YPpM09DLTB28obqQ@infradead.org>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-7-ebiggers@kernel.org>
 <YPU+3inGclUtcSpJ@infradead.org>
 <YPog4SDY3nNC78sK@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPog4SDY3nNC78sK@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 06:52:33PM -0700, Eric Biggers wrote:
> I am trying to do this, but unfortunately I don't see a way to make it work
> correctly in all cases.
> 
> The main problem is that when iomap_dio_rw() returns an error (other than
> -EIOCBQUEUED), there is no way to know whether ->end_io() has been called or
> not.  This is because iomap_dio_rw() can fail either early, before "starting"
> the I/O (in which case ->end_io() won't have been called), or later, after
> "starting" the I/O (in which case ->end_io() will have been called).  Note that
> this can't be worked around by checking whether the iov_iter has been advanced
> or not, since a failure could occur between "starting" the I/O and the iov_iter
> being advanced for the first time.
> 
> Would you be receptive to adding a ->begin_io() callback to struct iomap_dio_ops
> in order to allow filesystems to maintain counters like this?

I think we can triviall fix this by using the slightly lower level
__iomap_dio_rw API.  Incremental patch to my previous one below:

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4fed90cc1462..11844bd0cb7a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4243,6 +4243,7 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	const loff_t pos = iocb->ki_pos;
 	const size_t count = iov_iter_count(to);
+	struct iomap_dio *dio;
 	ssize_t ret;
 
 	if (count == 0)
@@ -4260,8 +4261,13 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	}
 
 	inc_page_count(F2FS_I_SB(inode), F2FS_DIO_READ);
-	ret = iomap_dio_rw(iocb, to, &f2fs_iomap_ops, &f2fs_iomap_dio_ops, 0);
-
+	dio = __iomap_dio_rw(iocb, to, &f2fs_iomap_ops, &f2fs_iomap_dio_ops, 0);
+	if (IS_ERR_OR_NULL(dio)) {
+		dec_page_count(F2FS_I_SB(inode), F2FS_DIO_READ);
+		ret = PTR_ERR_OR_ZERO(dio);
+	} else {
+		ret = iomap_dio_complete(dio);
+	}
 	up_read(&fi->i_gc_rwsem[READ]);
 
 	file_accessed(file);
@@ -4271,8 +4277,6 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	else if (ret == -EIOCBQUEUED)
 		f2fs_update_iostat(F2FS_I_SB(inode), APP_DIRECT_READ_IO,
 				   count - iov_iter_count(to));
-	else
-		dec_page_count(F2FS_I_SB(inode), F2FS_DIO_READ);
 out:
 	trace_f2fs_direct_IO_exit(inode, pos, count, READ, ret);
 	return ret;
