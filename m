Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E681E26E45D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 20:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgIQSqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 14:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgIQSqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:46:05 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F05C06174A;
        Thu, 17 Sep 2020 11:46:04 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIyus-000Z2Y-8K; Thu, 17 Sep 2020 18:45:58 +0000
Date:   Thu, 17 Sep 2020 19:45:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@redhat.com>
Cc:     torvalds@linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: slab-out-of-bounds in iov_iter_revert()
Message-ID: <20200917184558.GX3421308@ZenIV.linux.org.uk>
References: <20200911215903.GA16973@lca.pw>
 <20200911235511.GB3421308@ZenIV.linux.org.uk>
 <87ded87d232d9cf87c9c64495bf9190be0e0b6e8.camel@redhat.com>
 <20200917020440.GQ3421308@ZenIV.linux.org.uk>
 <20200917021439.GA31009@ZenIV.linux.org.uk>
 <e815399a4a123aa7cc096a55055f103874db1e75.camel@redhat.com>
 <20200917164432.GU3421308@ZenIV.linux.org.uk>
 <c68eb9de3579cb56b8c6559a1e610ade631a9d60.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c68eb9de3579cb56b8c6559a1e610ade631a9d60.camel@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 01:42:44PM -0400, Qian Cai wrote:
> > 
> > 	How much IO does it take to trigger that on your reproducer?
> 
> That is something I don't know for sure because it is always reproducible by
> running the trinity fuzzer for a few seconds (32 threads). I did another run
> below (still with your patch applied) and then tried to capture some logs here:
> 
> http://people.redhat.com/qcai/iov_iter_revert/

FWIW, there were several bugs in that patch:
	* 'shortened' possibly left uninitialized
	* possible error returns with reexpand not done

Could you try this instead?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6611ef3269a8..43c165e796da 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3091,11 +3091,10 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	ssize_t ret = 0;
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
-	bool async_dio = ff->fc->async_dio;
 	loff_t pos = 0;
 	struct inode *inode;
 	loff_t i_size;
-	size_t count = iov_iter_count(iter);
+	size_t count = iov_iter_count(iter), shortened = 0;
 	loff_t offset = iocb->ki_pos;
 	struct fuse_io_priv *io;
 
@@ -3103,17 +3102,9 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	inode = file->f_mapping->host;
 	i_size = i_size_read(inode);
 
-	if ((iov_iter_rw(iter) == READ) && (offset > i_size))
+	if ((iov_iter_rw(iter) == READ) && (offset >= i_size))
 		return 0;
 
-	/* optimization for short read */
-	if (async_dio && iov_iter_rw(iter) != WRITE && offset + count > i_size) {
-		if (offset >= i_size)
-			return 0;
-		iov_iter_truncate(iter, fuse_round_up(ff->fc, i_size - offset));
-		count = iov_iter_count(iter);
-	}
-
 	io = kmalloc(sizeof(struct fuse_io_priv), GFP_KERNEL);
 	if (!io)
 		return -ENOMEM;
@@ -3129,15 +3120,22 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * By default, we want to optimize all I/Os with async request
 	 * submission to the client filesystem if supported.
 	 */
-	io->async = async_dio;
+	io->async = ff->fc->async_dio;
 	io->iocb = iocb;
 	io->blocking = is_sync_kiocb(iocb);
 
+	/* optimization for short read */
+	if (io->async && !io->write && offset + count > i_size) {
+		iov_iter_truncate(iter, fuse_round_up(ff->fc, i_size - offset));
+		shortened = count - iov_iter_count(iter);
+		count -= shortened;
+	}
+
 	/*
 	 * We cannot asynchronously extend the size of a file.
 	 * In such case the aio will behave exactly like sync io.
 	 */
-	if ((offset + count > i_size) && iov_iter_rw(iter) == WRITE)
+	if ((offset + count > i_size) && io->write)
 		io->blocking = true;
 
 	if (io->async && io->blocking) {
@@ -3155,6 +3153,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	} else {
 		ret = __fuse_direct_read(io, iter, &pos);
 	}
+	iov_iter_reexpand(iter, iov_iter_count(iter) + shortened);
 
 	if (io->async) {
 		bool blocking = io->blocking;
