Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9B726D0F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 04:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgIQCEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 22:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIQCEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 22:04:47 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D03C06174A;
        Wed, 16 Sep 2020 19:04:47 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIjHs-0007uR-MF; Thu, 17 Sep 2020 02:04:40 +0000
Date:   Thu, 17 Sep 2020 03:04:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@redhat.com>
Cc:     torvalds@linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: slab-out-of-bounds in iov_iter_revert()
Message-ID: <20200917020440.GQ3421308@ZenIV.linux.org.uk>
References: <20200911215903.GA16973@lca.pw>
 <20200911235511.GB3421308@ZenIV.linux.org.uk>
 <87ded87d232d9cf87c9c64495bf9190be0e0b6e8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ded87d232d9cf87c9c64495bf9190be0e0b6e8.camel@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 05:09:49PM -0400, Qian Cai wrote:
> On Sat, 2020-09-12 at 00:55 +0100, Al Viro wrote:
> > On Fri, Sep 11, 2020 at 05:59:04PM -0400, Qian Cai wrote:
> > > Super easy to reproduce on today's mainline by just fuzzing for a few
> > > minutes
> > > on virtiofs (if it ever matters). Any thoughts?
> > 
> > Usually happens when ->direct_IO() fucks up and reports the wrong amount
> > of data written/read.  We had several bugs like that in the past - see
> > e.g. 85128b2be673 (fix nfs O_DIRECT advancing iov_iter too much).
> > 
> > Had there been any recent O_DIRECT-related patches on the filesystems
> > involved?
> 
> This is only reproducible using FUSE/virtiofs so far, so I will stare at
> fuse_direct_IO() until someone can beat me to it.

What happens there is that it tries to play with iov_iter_truncate() in
->direct_IO() without a corresponding iov_iter_reexpand().  Could you
check if the following helps?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6611ef3269a8..d3eec2e11975 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3095,7 +3095,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	loff_t pos = 0;
 	struct inode *inode;
 	loff_t i_size;
-	size_t count = iov_iter_count(iter);
+	size_t count = iov_iter_count(iter), shortened;
 	loff_t offset = iocb->ki_pos;
 	struct fuse_io_priv *io;
 
@@ -3111,7 +3111,8 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		if (offset >= i_size)
 			return 0;
 		iov_iter_truncate(iter, fuse_round_up(ff->fc, i_size - offset));
-		count = iov_iter_count(iter);
+		shortened = count - iov_iter_count(iter);
+		count -= shortened;
 	}
 
 	io = kmalloc(sizeof(struct fuse_io_priv), GFP_KERNEL);
@@ -3177,6 +3178,8 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		else if (ret < 0 && offset + count > i_size)
 			fuse_do_truncate(file);
 	}
+	if (shortened)
+		iov_iter_reexpand(iter, shortened);
 
 	return ret;
 }
