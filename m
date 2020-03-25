Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED041927A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 13:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgCYMC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 08:02:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgCYMCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=547A7ZAoUu2JDJ2ptSJ8vxecAwOtjI/NDzIFsvFTzXo=; b=QvbtCWiIh5Xi5+8xr7F3LHchs/
        /enb5Ja0xjCQg6d/l+MMlIiwXqB1vmDvW34OsfyaSVHmfQx5kxyhZIn0FH5/13KsLe0hUWrGWbB2g
        sxNran2m7QzQfFcu/qurUajS+kK4kEiY6Nojd22Yoyfhsr09GRoJw/fKvlcE/cgG6L+etNC0U3vkq
        0DIgu/p6cickFzYi2VQqX4rMn0g6k0JEQQFCQ8RoqdCtQshCfS8K0j4G2044VrBkohrju2ToJ8dze
        6LtjdH/dgtWCSE8hybN/l8eLj9N52oB+rKd+z7jbkSCM2Y9hSv9O3RaK4nV1mItf8R8C4rGnL9moV
        mHDZZ7Cg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH4kI-0002HH-Er; Wed, 25 Mar 2020 12:02:54 +0000
Date:   Wed, 25 Mar 2020 05:02:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v10 24/25] fuse: Convert from readpages to readahead
Message-ID: <20200325120254.GA22483@bombadil.infradead.org>
References: <20200323202259.13363-1-willy@infradead.org>
 <20200323202259.13363-25-willy@infradead.org>
 <CAJfpegu7EFcWrg3bP+-2BX_kb52RrzBCo_U3QKYzUkZfe4EjDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu7EFcWrg3bP+-2BX_kb52RrzBCo_U3QKYzUkZfe4EjDA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:42:56AM +0100, Miklos Szeredi wrote:
> > +       while ((page = readahead_page(rac))) {
> > +               if (fuse_readpages_fill(&data, page) != 0)
> 
> Shouldn't this unlock + put page on error?

We're certainly inconsistent between the two error exits from
fuse_readpages_fill().  But I think we can simplify the whole thing
... how does this look to you?

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5749505bcff6..57ea9a364e62 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -915,76 +915,32 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 	fuse_readpages_end(fc, &ap->args, err);
 }
 
-struct fuse_fill_data {
-	struct fuse_io_args *ia;
-	struct file *file;
-	struct inode *inode;
-	unsigned int nr_pages;
-	unsigned int max_pages;
-};
-
-static int fuse_readpages_fill(struct fuse_fill_data *data, struct page *page)
-{
-	struct fuse_io_args *ia = data->ia;
-	struct fuse_args_pages *ap = &ia->ap;
-	struct inode *inode = data->inode;
-	struct fuse_conn *fc = get_fuse_conn(inode);
-
-	fuse_wait_on_page_writeback(inode, page->index);
-
-	if (ap->num_pages &&
-	    (ap->num_pages == fc->max_pages ||
-	     (ap->num_pages + 1) * PAGE_SIZE > fc->max_read ||
-	     ap->pages[ap->num_pages - 1]->index + 1 != page->index)) {
-		data->max_pages = min_t(unsigned int, data->nr_pages,
-					fc->max_pages);
-		fuse_send_readpages(ia, data->file);
-		data->ia = ia = fuse_io_alloc(NULL, data->max_pages);
-		if (!ia)
-			return -ENOMEM;
-		ap = &ia->ap;
-	}
-
-	if (WARN_ON(ap->num_pages >= data->max_pages)) {
-		unlock_page(page);
-		fuse_io_free(ia);
-		return -EIO;
-	}
-
-	ap->pages[ap->num_pages] = page;
-	ap->descs[ap->num_pages].length = PAGE_SIZE;
-	ap->num_pages++;
-	data->nr_pages--;
-	return 0;
-}
-
 static void fuse_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_fill_data data;
-	struct page *page;
 
 	if (is_bad_inode(inode))
 		return;
 
-	data.file = rac->file;
-	data.inode = inode;
-	data.nr_pages = readahead_count(rac);
-	data.max_pages = min_t(unsigned int, data.nr_pages, fc->max_pages);
-	data.ia = fuse_io_alloc(NULL, data.max_pages);
-	if (!data.ia)
-		return;
+	while (readahead_count(rac)) {
+		struct fuse_io_args *ia;
+		struct fuse_args_pages *ap;
+		unsigned int i, nr_pages;
 
-	while ((page = readahead_page(rac))) {
-		if (fuse_readpages_fill(&data, page) != 0)
+		nr_pages = min(readahead_count(rac), fc->max_pages);
+		ia = fuse_io_alloc(NULL, nr_pages);
+		if (!ia)
 			return;
+		ap = &ia->ap;
+		__readahead_batch(rac, ap->pages, nr_pages);
+		for (i = 0; i < nr_pages; i++) {
+			fuse_wait_on_page_writeback(inode, ap->pages[i]->index);
+			ap->descs[i].length = PAGE_SIZE;
+		}
+		ap->num_pages = nr_pages;
+		fuse_send_readpages(ia, rac->file);
 	}
-
-	if (data.ia->ap.num_pages)
-		fuse_send_readpages(data.ia, rac->file);
-	else
-		fuse_io_free(data.ia);
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
