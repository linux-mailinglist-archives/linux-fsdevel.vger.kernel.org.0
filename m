Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4B06BA070
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 21:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjCNUJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 16:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCNUJV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:09:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF83D22013;
        Tue, 14 Mar 2023 13:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=IaZ/Ro/ijOLAt3RzYQfBauDHIMb1QN04KckKloToQhQ=; b=H/OzrV4ZZOdQ766rINvqXhx3Uz
        DE5Ya4WI3WaejSgHW4GSEdlGfwC0K4ktwYnNkBk4L+TDz5TruL3iXen7Xmt1UDAFY7rF0xZ418wzN
        cql632ZS1KbI0zaDvhisw6wF200LC2ayvUqscm3z8DxN6yRCRSz4iuMeoBctga4b74Dg2+NrhMnSJ
        s7zZdegBZ6tpHLq6CKItzi9PlmTsIzltgYbuE0vzrn2PAm0Urtp7bkugiePcGDG0XOfSDbT3BlKDY
        ghLxTQg2eVkNAQYj9wF5Lbl7X3Fs3Iu7AtMARyxsIlkJswSTnVSoc1/tbtEZvBO+dt/Qk4EfaBvS6
        4x5cqx7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcAwy-00DCLc-6R; Tue, 14 Mar 2023 20:08:48 +0000
Date:   Tue, 14 Mar 2023 20:08:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
Message-ID: <ZBDUUAGO9HbZG8EW@casper.infradead.org>
References: <20230308165251.2078898-1-dhowells@redhat.com>
 <20230308165251.2078898-4-dhowells@redhat.com>
 <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
 <ZBCkDvveAIJENA0G@casper.infradead.org>
 <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:02:40AM -0700, Linus Torvalds wrote:
> On Tue, Mar 14, 2023 at 9:43 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > The problem is that we might have swapped out the shmem folio.  So we
> > don't want to clear the page, but ask swap to fill the page.
> 
> Doesn't shmem_swapin_folio() already basically do all that work?
> 
> The real oddity with shmem - compared to other filesystems - is that
> the xarray has a value entry instead of being a real folio. And yes,
> the current filemap code will then just ignore such entries as
> "doesn't exist", and so the regular read iterators will all fail on
> it.
> 
> But while filemap_get_read_batch() will stop at a value-folio, I feel
> like filemap_create_folio() should be able to turn a value page into a
> "real" page. Right now it already allocates said page, but then I
> think filemap_add_folio() will return -EEXIST when said entry exists
> as a value.
> 
> But *if* instead of -EEXIST we could just replace the value with the
> (already locked) page, and have some sane way to pass that value
> (which is the swap entry data) to readpage(), I think that should just
> do it all.

This was basically what I had in mind:

I don't think this will handle a case like:

Alloc order-0 folio at index 4
Alloc order-0 folio at index 7
Swap out both folios
Alloc order-9 folio at indices 0-511

But I don't see where shmem currently handles that either.  Maybe it
falls back to order-0 folios instead of the crude BUG_ON I put in.
Hugh?

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 82c1262f396f..30f2502314de 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -114,12 +114,6 @@ int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
 struct folio *shmem_read_folio_gfp(struct address_space *mapping,
 		pgoff_t index, gfp_t gfp);
 
-static inline struct folio *shmem_read_folio(struct address_space *mapping,
-		pgoff_t index)
-{
-	return shmem_read_folio_gfp(mapping, index, mapping_gfp_mask(mapping));
-}
-
 static inline struct page *shmem_read_mapping_page(
 				struct address_space *mapping, pgoff_t index)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 57c1b154fb5a..8e4f95c5b65a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -877,6 +877,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 					order, gfp);
 		xas_lock_irq(&xas);
 		xas_for_each_conflict(&xas, entry) {
+			if (old)
+				BUG_ON(shmem_mapping(mapping));
 			old = entry;
 			if (!xa_is_value(entry)) {
 				xas_set_err(&xas, -EEXIST);
@@ -885,7 +887,12 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		}
 
 		if (old) {
-			if (shadowp)
+			if (shmem_mapping(mapping)) {
+				folio_set_swap_entry(folio,
+						radix_to_swp_entry(old));
+				folio_set_swapcache(folio);
+				folio_set_swapbacked(folio);
+			} else if (shadowp)
 				*shadowp = old;
 			/* entry may have been split before we acquired lock */
 			order = xa_get_order(xas.xa, xas.xa_index);
diff --git a/mm/shmem.c b/mm/shmem.c
index 8e60826e4246..ea75c7dcf5ec 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2059,6 +2059,18 @@ int shmem_get_folio(struct inode *inode, pgoff_t index, struct folio **foliop,
 			mapping_gfp_mask(inode->i_mapping), NULL, NULL, NULL);
 }
 
+static int shmem_read_folio(struct file *file, struct folio *folio)
+{
+	if (folio_test_swapcache(folio)) {
+		swap_readpage(&folio->page, true, NULL);
+	} else {
+		folio_zero_segment(folio, 0, folio_size(folio));
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
+	}
+	return 0;
+}
+
 /*
  * This is like autoremove_wake_function, but it removes the wait queue
  * entry unconditionally - even if something else had already woken the
@@ -2396,7 +2408,8 @@ static int shmem_fadvise_willneed(struct address_space *mapping,
 	xa_for_each_range(&mapping->i_pages, index, folio, start, end) {
 		if (!xa_is_value(folio))
 			continue;
-		folio = shmem_read_folio(mapping, index);
+		folio = shmem_read_folio_gfp(mapping, index,
+						mapping_gfp_mask(mapping));
 		if (!IS_ERR(folio))
 			folio_put(folio);
 	}
@@ -4037,6 +4050,7 @@ static int shmem_error_remove_page(struct address_space *mapping,
 }
 
 const struct address_space_operations shmem_aops = {
+	.read_folio	= shmem_read_folio,
 	.writepage	= shmem_writepage,
 	.dirty_folio	= noop_dirty_folio,
 #ifdef CONFIG_TMPFS
