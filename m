Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFA139D237
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 01:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFFXb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 19:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFFXbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:31:55 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552DAC061766;
        Sun,  6 Jun 2021 16:30:05 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lq2DP-005CsL-Rc; Sun, 06 Jun 2021 23:29:59 +0000
Date:   Sun, 6 Jun 2021 23:29:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
Message-ID: <YL1ad7+I30xnCto8@zeniv-ca.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 06, 2021 at 03:05:49PM -0700, Linus Torvalds wrote:

> The end result certainly looks cleaner than before, although I can't
> say that it's pretty. It's still haitry and grotty, but at least
> _some_ of the hairiness has been removed (yay for
> _copy_from_iter_full() being *much* simpler now, and
> iterate_all_kinds() being gone).
> 
> I also have to admit to despising what iov_iter_init() ends up looking
> like. Not because I think that using those initializer assignments to
> set it is wrong, but simply because the initializers are basically
> identical except for "iter_type".

TBH, I wonder if we still need that these days.  That is to say,
do we even call iov_iter_init() when uaccess_kernel() is true?
We certainly used to do that, but...  We have

* copy_from_kernel_nofault(); calls __copy_from_user_inatomic() under
KERNEL_DS and pagefault_disable(), and that would better *not* fuck with
iov_iter inside.

* copy_to_kernel_nofault(); similar, with s/_from_/_to_/.

* strncpy_from_kernel_nofault(); ditto, with __get_user() instead of
__copy_..._user_inatomic().

* unaligned trap handling in kernel mode on sh and itanic

* arm dumping insns in oops handler

* 3 turds in arm oabi compat: sys_semtimedop_time32(), sys_epoll_wait()
and sys_fcntl64() (for [GS]ETLK... fcntls) called under KERNEL_DS.
The last one should simply call fcntl_[gs]etlk() and be done with
that, not that it was going to play with any iov_iter anyway.
epoll_wait() is currently not using iov_iter (it does use __put_user()
and not in a pretty way, but that's a separate story).  And
for semtimedop_time32(), we do not have any iov_iter in sight *and*
I would rather get rid of KERNEL_DS there completely - all it takes
is a variant of do_semtimedop() with tsops already copied into the
kernel.  In any case, none of those do iov_iter_init().

	I have *not* checked if any kernel threads might be playing
with iov_iter_init() outside of kthread_use_mm(); some might, but
IMO any such place would be a good candidate for conversion to
explicit iov_iter_kvec()...

	BTW, speaking of initializers...  Pavel, could you check if
the following breaks anything?  Unless I'm misreading __io_import_fixed(),
looks like that's what it's trying to do...

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f46acbbeed57..9bd2da9a4c3d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2773,57 +2773,14 @@ static int __io_import_fixed(struct io_kiocb *req, int rw, struct iov_iter *iter
 {
 	size_t len = req->rw.len;
 	u64 buf_end, buf_addr = req->rw.addr;
-	size_t offset;
 
 	if (unlikely(check_add_overflow(buf_addr, (u64)len, &buf_end)))
 		return -EFAULT;
 	/* not inside the mapped region */
 	if (unlikely(buf_addr < imu->ubuf || buf_end > imu->ubuf_end))
 		return -EFAULT;
-
-	/*
-	 * May not be a start of buffer, set size appropriately
-	 * and advance us to the beginning.
-	 */
-	offset = buf_addr - imu->ubuf;
-	iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs, offset + len);
-
-	if (offset) {
-		/*
-		 * Don't use iov_iter_advance() here, as it's really slow for
-		 * using the latter parts of a big fixed buffer - it iterates
-		 * over each segment manually. We can cheat a bit here, because
-		 * we know that:
-		 *
-		 * 1) it's a BVEC iter, we set it up
-		 * 2) all bvecs are PAGE_SIZE in size, except potentially the
-		 *    first and last bvec
-		 *
-		 * So just find our index, and adjust the iterator afterwards.
-		 * If the offset is within the first bvec (or the whole first
-		 * bvec, just use iov_iter_advance(). This makes it easier
-		 * since we can just skip the first segment, which may not
-		 * be PAGE_SIZE aligned.
-		 */
-		const struct bio_vec *bvec = imu->bvec;
-
-		if (offset <= bvec->bv_len) {
-			iov_iter_advance(iter, offset);
-		} else {
-			unsigned long seg_skip;
-
-			/* skip first vec */
-			offset -= bvec->bv_len;
-			seg_skip = 1 + (offset >> PAGE_SHIFT);
-
-			iter->bvec = bvec + seg_skip;
-			iter->nr_segs -= seg_skip;
-			iter->count -= bvec->bv_len + offset;
-			iter->iov_offset = offset & ~PAGE_MASK;
-		}
-	}
-
-	return 0;
+	return import_pagevec(rw, buf_addr, len, imu->ubuf,
+			      imu->nr_bvecs, imu->bvec, iter);
 }
 
 static int io_import_fixed(struct io_kiocb *req, int rw, struct iov_iter *iter)
diff --git a/include/linux/uio.h b/include/linux/uio.h
index fd88d9911dad..f6291e981d07 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -299,5 +299,8 @@ ssize_t __import_iovec(int type, const struct iovec __user *uvec,
 		 struct iov_iter *i, bool compat);
 int import_single_range(int type, void __user *buf, size_t len,
 		 struct iovec *iov, struct iov_iter *i);
+int import_pagevec(int rw, unsigned long from, size_t len,
+		unsigned long base, unsigned nr_pages,
+		struct bio_vec *bvec, struct iov_iter *i);
 
 #endif
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 11b39bd1d1ab..4a771fcb529b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1982,3 +1982,21 @@ int import_single_range(int rw, void __user *buf, size_t len,
 	return 0;
 }
 EXPORT_SYMBOL(import_single_range);
+
+int import_pagevec(int rw, unsigned long from, size_t len,
+		unsigned long base, unsigned nr_pages,
+		struct bio_vec *bvec, struct iov_iter *i)
+
+{
+	unsigned long skip_pages = (from >> PAGE_SHIFT) - (base >> PAGE_SHIFT);
+
+	*i = (struct iov_iter){
+		.iter_type = ITER_BVEC,
+		.data_source = rw,
+		.bvec = bvec + skip_pages,
+		.nr_segs = nr_pages - skip_pages,
+		.iov_offset = skip_pages ? from & ~PAGE_MASK : from - base,
+		.count = len
+	};
+	return 0;
+}
-- 
2.11.0

