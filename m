Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C467F78A203
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Aug 2023 23:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjH0Vpx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 17:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjH0Vpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:45:41 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6883E124;
        Sun, 27 Aug 2023 14:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kY05MXjwCqUKuXNwucsgt/McL4F7q7Pfbjm7IIALTG0=; b=rwicGoUvL4VgCd8/Qp1uGcvFJj
        2egMEWh2qIptB38yz3LkaovCgsrzYd5qWYzYVrLDB0+2cvC8Hq94M95X4EXXJUaYQexvV5ydz/PhQ
        3oSRutUhsOumwt9db2so3z+etJXEF+Wi2+NHOmG8HlbMqrIjqtB+TQ9YoLhUuiexvk8+I1LYJ/xSV
        ZlLyerq6Wcockw2BEhGC0e7r/uJgQmeAavj3yTO2QGyQwB10XYMkDDZ1Bff7wCxS6uqmy7RDsW0tE
        LxV9EZ6t5yOJ6J5Tl0xTjIsbFSoYFc5//Rfxs/6ERxlTJUc4/DLKribj0NNKKwb+gHZab/RxADkLO
        htbC578A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qaNZO-001P52-2K;
        Sun, 27 Aug 2023 21:45:18 +0000
Date:   Sun, 27 Aug 2023 22:45:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 03/12] filemap: update ki_pos in generic_perform_write
Message-ID: <20230827214518.GU3390869@ZenIV>
References: <20230601145904.1385409-1-hch@lst.de>
 <20230601145904.1385409-4-hch@lst.de>
 <20230827194122.GA325446@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827194122.GA325446@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 27, 2023 at 08:41:22PM +0100, Al Viro wrote:
> On Thu, Jun 01, 2023 at 04:58:55PM +0200, Christoph Hellwig wrote:
> > All callers of generic_perform_write need to updated ki_pos, move it into
> > common code.
> 
> > @@ -4034,7 +4037,6 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  		endbyte = pos + status - 1;
> >  		err = filemap_write_and_wait_range(mapping, pos, endbyte);
> >  		if (err == 0) {
> > -			iocb->ki_pos = endbyte + 1;
> >  			written += status;
> >  			invalidate_mapping_pages(mapping,
> >  						 pos >> PAGE_SHIFT,
> > @@ -4047,8 +4049,6 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  		}
> >  	} else {
> >  		written = generic_perform_write(iocb, from);
> > -		if (likely(written > 0))
> > -			iocb->ki_pos += written;
> >  	}
> >  out:
> >  	return written ? written : err;
> 
> [another late reply, sorry]
> 
> That part is somewhat fishy - there's a case where you return a positive value
> and advance ->ki_pos by more than that amount.  I really wonder if all callers
> of ->write_iter() are OK with that.  Consider e.g. this:
> 
> ssize_t ksys_write(unsigned int fd, const char __user *buf, size_t count)
> {
>         struct fd f = fdget_pos(fd);
>         ssize_t ret = -EBADF;
> 
>         if (f.file) {
>                 loff_t pos, *ppos = file_ppos(f.file);
>                 if (ppos) {
>                         pos = *ppos;   
>                         ppos = &pos;
>                 }
>                 ret = vfs_write(f.file, buf, count, ppos);
>                 if (ret >= 0 && ppos)
>                         f.file->f_pos = pos;
>                 fdput_pos(f);
>         }
> 
>         return ret;
> }
> 
> ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
> {
>         ssize_t ret;
> 
>         if (!(file->f_mode & FMODE_WRITE))
>                 return -EBADF;
>         if (!(file->f_mode & FMODE_CAN_WRITE))
>                 return -EINVAL;
>         if (unlikely(!access_ok(buf, count)))
>                 return -EFAULT;
> 
>         ret = rw_verify_area(WRITE, file, pos, count);
>         if (ret)
>                 return ret;
>         if (count > MAX_RW_COUNT)
>                 count =  MAX_RW_COUNT;
>         file_start_write(file);
>         if (file->f_op->write)
>                 ret = file->f_op->write(file, buf, count, pos);
>         else if (file->f_op->write_iter)
>                 ret = new_sync_write(file, buf, count, pos);
>         else   
>                 ret = -EINVAL;
>         if (ret > 0) {
>                 fsnotify_modify(file);
>                 add_wchar(current, ret);
>         }
>         inc_syscw(current);
>         file_end_write(file);
>         return ret;
> }
> 
> static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos)
> {
>         struct kiocb kiocb;
>         struct iov_iter iter;
>         ssize_t ret; 
> 
>         init_sync_kiocb(&kiocb, filp);
>         kiocb.ki_pos = (ppos ? *ppos : 0);
>         iov_iter_ubuf(&iter, ITER_SOURCE, (void __user *)buf, len);
> 
>         ret = call_write_iter(filp, &kiocb, &iter);
>         BUG_ON(ret == -EIOCBQUEUED);
>         if (ret > 0 && ppos)
>                 *ppos = kiocb.ki_pos;
>         return ret;
> } 
> 
> Suppose ->write_iter() ends up doing returning a positive value smaller than
> the increment of kiocb.ki_pos.  What do we get?  ret is positive, so
> kiocb.ki_pos gets copied into *ppos, which is ksys_write's pos and there
> we copy it into file->f_pos.
> 
> Is it really OK to have write() return 4096 and advance the file position
> by 16K?  AFAICS, userland wouldn't get any indication of something
> odd going on - just a short write to a regular file, with followup write
> of remaining 12K getting quietly written in the range 16K..28K.
> 
> I don't remember what POSIX says about that, but it would qualify as
> nasty surprise for any userland program - sure, one can check fsync()
> results before closing the sucker and see if everything looks fine,
> but the way it's usually discussed could easily lead to assumption that
> (synchronous) O_DIRECT writes would not be affected by anything of that
> sort.

IOW, I suspect that the right thing to do would be something along the lines
of

direct_write_fallback(): on error revert the ->ki_pos update from buffered write

If we fail filemap_write_and_wait_range() on the range the buffered write went
into, we only report the "number of bytes which we direct-written", to quote
the comment in there.  Which is fine, but buffered write has already advanced
iocb->ki_pos, so we need to roll that back.  Otherwise we end up with e.g.
write(2) advancing position by more than the amount it reports having written.

Fixes: 182c25e9c157 "filemap: update ki_pos in generic_perform_write"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/libfs.c b/fs/libfs.c
index 5b851315eeed..712c57828c0e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1646,6 +1646,7 @@ ssize_t direct_write_fallback(struct kiocb *iocb, struct iov_iter *iter,
 		 * We don't know how much we wrote, so just return the number of
 		 * bytes which were direct-written
 		 */
+		iocb->ki_pos -= buffered_written;
 		if (direct_written)
 			return direct_written;
 		return err;
