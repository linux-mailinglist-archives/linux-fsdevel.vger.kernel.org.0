Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED47A2BAA4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 13:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgKTMje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 07:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKTMje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:39:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2694C0613CF;
        Fri, 20 Nov 2020 04:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ciE5aBA53xTPaf+5Nm3ffgv4TXhSHOyh/nrWlpGzLOA=; b=oj+SDrsUGxmA4qgYqUnqKlay7/
        9ffY3cwPRHaFZmCQxEetGBrbPrUY/anZVNnjJNTEBqjvIZUeTxwYLBkFoP+vVpcEvsXnqd0ZXwUDI
        o93nMllkSF2SI/4zVtYCUPHbM5FwU26281cRmgrmBhuIQXZwUClr+0zW/EhSE2LOsffY8mNEFCivz
        8twPo7EbMICBmXg2duDZCWp9VecrbmoVeYO8Nv6MgYDSXPGfSzC5CoAOM9ICYgx4OoA8iMURPvWz2
        boi0Jt60q9KZWE5H+Wve9lslOmFqFp9BXQMoHU3XAjbwIooHwjb3Li3rKiqMLhbDhh2ZeEUXw6CoR
        NGpbCDrw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg5hL-00006I-6z; Fri, 20 Nov 2020 12:39:31 +0000
Date:   Fri, 20 Nov 2020 12:39:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iov_iter: optimise iov_iter_npages for bvec
Message-ID: <20201120123931.GN29991@casper.infradead.org>
References: <cover.1605827965.git.asml.silence@gmail.com>
 <ab04202d0f8c1424da47251085657c436d762785.1605827965.git.asml.silence@gmail.com>
 <20201120012017.GJ29991@casper.infradead.org>
 <35d5db17-f6f6-ec32-944e-5ecddcbcb0f1@gmail.com>
 <20201120022200.GB333150@T590>
 <e70a3c05-a968-7802-df81-0529eaa7f7b4@gmail.com>
 <20201120025457.GM29991@casper.infradead.org>
 <20201120081429.GA30801@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120081429.GA30801@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 08:14:29AM +0000, Christoph Hellwig wrote:
> On Fri, Nov 20, 2020 at 02:54:57AM +0000, Matthew Wilcox wrote:
> > On Fri, Nov 20, 2020 at 02:25:08AM +0000, Pavel Begunkov wrote:
> > > On 20/11/2020 02:22, Ming Lei wrote:
> > > > iov_iter_npages(bvec) still can be improved a bit by the following way:
> > > 
> > > Yep, was doing exactly that, +a couple of other places that are in my way.
> > 
> > Are you optimising the right thing here?  Assuming you're looking at
> > the one in do_blockdev_direct_IO(), wouldn't we be better off figuring
> > out how to copy the bvecs directly from the iov_iter into the bio
> > rather than calling dio_bio_add_page() for each page?
> 
> Which is most effectively done by stopping to to use *blockdev_direct_IO
> and switching to iomap instead :)

But iomap still calls iov_iter_npages().  So maybe we need something like
this ...

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5bec..1c5a802a45d9 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -250,7 +250,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	orig_count = iov_iter_count(dio->submit.iter);
 	iov_iter_truncate(dio->submit.iter, length);
 
-	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
+	nr_pages = bio_iov_iter_npages(dio->submit.iter);
 	if (nr_pages <= 0) {
 		ret = nr_pages;
 		goto out;
@@ -308,7 +308,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		dio->size += n;
 		copied += n;
 
-		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
+		nr_pages = bio_iov_iter_npages(dio->submit.iter);
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
 	} while (nr_pages);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c6d765382926..86cc74f84b30 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -10,6 +10,7 @@
 #include <linux/ioprio.h>
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
+#include <linux/uio.h>
 
 #define BIO_DEBUG
 
@@ -447,6 +448,16 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
+
+static inline int bio_iov_iter_npages(const struct iov_iter *i)
+{
+	if (!iov_iter_count(i))
+		return 0;
+	if (iov_iter_is_bvec(i))
+		return 1;
+	return iov_iter_npages(i, BIO_MAX_PAGES);
+}
+
 void bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
