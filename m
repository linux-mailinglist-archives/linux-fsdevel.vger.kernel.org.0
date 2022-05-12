Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFA5524183
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 02:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349664AbiELA27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 20:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349655AbiELA2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 20:28:55 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118151BC804
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 17:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vXyixc0pTwWWIzk26hKHEa2Prnr+jypWHpRsfoKsjH0=; b=Xml2R9mvSHHTIe35ZJhDfMUo/d
        rFw56k4hgoq6wGfg6MIL1nwEBaM1ujzbw0zN1ykQWx2v6n6WAdZpvqIMW06Xutd49Hs9dZMEkiuNp
        MCGgy+g9bl9E7uLZoUs8W/trzEMx9A0GxE8FgTb6NrV8/C4H+6RLuWk1CewjATESbHE44u/+ppkSB
        Xe6TG48Jr94jahtk3kF9FCrPkfe6LVBI6HTEcSTTO2JCRLTnd3bNfx4X+N/dRXVZh105xbdod0z6H
        97zv5Ey3YohTeN8lBCL3TO1lRYoi77fGAv0vtD7qsy5maO/ISaLfuOZ7B/XZtSilwX9nycNDA6KP2
        MGOF7MNA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nowhF-00E9XH-NW; Thu, 12 May 2022 00:28:49 +0000
Date:   Thu, 12 May 2022 00:28:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] vfs: move fdput() to right place in
 ksys_sync_file_range()
Message-ID: <YnxUwQve8D39zxBz@zeniv-ca.linux.org.uk>
References: <20220511154503.28365-1-cgxu519@mykernel.net>
 <YnvbhmRUxPxWU2S3@casper.infradead.org>
 <YnwIDpkIBem+MeeC@gmail.com>
 <YnwuEt2Xm1iPjW7S@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnwuEt2Xm1iPjW7S@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 09:43:46PM +0000, Al Viro wrote:

> 3) ovl_aio_put() is hard to follow (and some of the callers are poking
> where they shouldn't), no idea if it's correct.  struct fd is manually
> constructed there, anyway.

Speaking of poking in the internals:

SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
                u32, min_complete, u32, flags, const void __user *, argp,
                size_t, argsz)
{
...
        struct fd f;
...
        if (flags & IORING_ENTER_REGISTERED_RING) {
                struct io_uring_task *tctx = current->io_uring;

                if (!tctx || fd >= IO_RINGFD_REG_MAX)
                        return -EINVAL;
                fd = array_index_nospec(fd, IO_RINGFD_REG_MAX);
                f.file = tctx->registered_rings[fd];
                if (unlikely(!f.file))
                        return -EBADF;
        } else {
                f = fdget(fd);
                if (unlikely(!f.file))
                        return -EBADF;
        }
...
a bunch of accesses to f.file
...
        if (!(flags & IORING_ENTER_REGISTERED_RING))
                fdput(f);

Note that f.flags is left uninitialized in the first case; it doesn't
break since we have fdput(f) (which does look at f.flags) done only
in the case where we don't have IORING_ENTER_REGISTERED_RING in flags
and since flags remains unchanged since the first if.  But it would
be just as easy to set f.flags to 0 and use fdput() in both cases...

Jens, do you have any objections against the following?  Easier to
follow that way...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 91de361ea9ab..b61ae18ef10a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -10760,14 +10760,14 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 			return -EINVAL;
 		fd = array_index_nospec(fd, IO_RINGFD_REG_MAX);
 		f.file = tctx->registered_rings[fd];
-		if (unlikely(!f.file))
-			return -EBADF;
+		f.flags = 0;
 	} else {
 		f = fdget(fd);
-		if (unlikely(!f.file))
-			return -EBADF;
 	}
 
+	if (unlikely(!f.file))
+		return -EBADF;
+
 	ret = -EOPNOTSUPP;
 	if (unlikely(f.file->f_op != &io_uring_fops))
 		goto out_fput;
@@ -10840,8 +10840,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 out:
 	percpu_ref_put(&ctx->refs);
 out_fput:
-	if (!(flags & IORING_ENTER_REGISTERED_RING))
-		fdput(f);
+	fdput(f);
 	return submitted ? submitted : ret;
 }
 
