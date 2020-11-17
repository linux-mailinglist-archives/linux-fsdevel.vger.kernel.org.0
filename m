Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2D92B6E3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 20:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgKQTPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 14:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKQTPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:15:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72523C0613CF;
        Tue, 17 Nov 2020 11:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Dne8YxxZ+UZ+gUfc95yml5E+g5UBAiFsJ5t1wmEAgs=; b=jEy97SbHADXPO0/Br5+8qbEPfV
        OUt23vE+BESRCLVH9qeI5X12M5UhmGxk8Pp1ufNONB8ORkACbxWvni7DVLtU4PYeuj+uDN5sfRTGq
        iyrxa++V6G36bwF6+O0GcpGuZ8IYmbbKT4u7NTU8dHwXasUEZfAISjLN96rz6dZsE61qfHW3f3OmL
        OcjMzk0TICcVJgCQnAnvtTTS+cLt+Q5ukYN/Lb1OQrIi+yudhR9LkYZY+j9JLhEeEALVSCwpwSjKM
        eSX0AklZJ7sXuSZvP1RMV2odutXGwjvasBO4yk8qRETJ5MvKqPJoaDSDkvFYf3bX4qk5gjP0ihG/g
        qz02+TQA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf6Re-0004jg-07; Tue, 17 Nov 2020 19:15:14 +0000
Date:   Tue, 17 Nov 2020 19:15:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
Message-ID: <20201117191513.GV29991@casper.infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
 <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
 <20201117153947.GL29991@casper.infradead.org>
 <alpine.LSU.2.11.2011170820030.1014@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2011170820030.1014@eggly.anvils>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 08:26:03AM -0800, Hugh Dickins wrote:
> On Tue, 17 Nov 2020, Matthew Wilcox wrote:
> > On Mon, Nov 16, 2020 at 02:34:34AM -0800, Hugh Dickins wrote:
> > > Fix to [PATCH v4 15/16] mm/truncate,shmem: Handle truncates that split THPs.
> > > One machine ran fine, swapping and building in ext4 on loop0 on huge tmpfs;
> > > one machine got occasional pages of zeros in its .os; one machine couldn't
> > > get started because of ext4_find_dest_de errors on the newly mkfs'ed fs.
> > > The partial_end case was decided by PAGE_SIZE, when there might be a THP
> > > there.  The below patch has run well (for not very long), but I could
> > > easily have got it slightly wrong, off-by-one or whatever; and I have
> > > not looked into the similar code in mm/truncate.c, maybe that will need
> > > a similar fix or maybe not.
> > 
> > Thank you for the explanation in your later email!  There is indeed an
> > off-by-one, although in the safe direction.
> > 
> > > --- 5103w/mm/shmem.c	2020-11-12 15:46:21.075254036 -0800
> > > +++ 5103wh/mm/shmem.c	2020-11-16 01:09:35.431677308 -0800
> > > @@ -874,7 +874,7 @@ static void shmem_undo_range(struct inod
> > >  	long nr_swaps_freed = 0;
> > >  	pgoff_t index;
> > >  	int i;
> > > -	bool partial_end;
> > > +	bool same_page;
> > >  
> > >  	if (lend == -1)
> > >  		end = -1;	/* unsigned, so actually very big */
> > > @@ -907,16 +907,12 @@ static void shmem_undo_range(struct inod
> > >  		index++;
> > >  	}
> > >  
> > > -	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
> > > +	same_page = (lstart >> PAGE_SHIFT) == end;
> > 
> > 'end' is exclusive, so this is always false.  Maybe something "obvious":
> > 
> > 	same_page = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
> > 
> > (lend is inclusive, so lend in 0-4095 are all on the same page)
> 
> My brain is not yet in gear this morning, so I haven't given this the
> necessary thought: but I do have to question what you say there, and
> throw it back to you for the further thought -
> 
> the first shmem_getpage(inode, lstart >> PAGE_SHIFT, &page, SGP_READ);
> the second shmem_getpage(inode, end, &page, SGP_READ).
> So same_page = (lstart >> PAGE_SHIFT) == end
> had seemed right to me.

I find both of these functions exceptionally confusing.  Does this
make it easier to understand?

@@ -859,22 +859,47 @@ static void shmem_undo_range(struct inode *inode, loff_t l
start, loff_t lend,
 {
        struct address_space *mapping = inode->i_mapping;
        struct shmem_inode_info *info = SHMEM_I(inode);
-       pgoff_t start = (lstart + PAGE_SIZE - 1) >> PAGE_SHIFT;
-       pgoff_t end = (lend + 1) >> PAGE_SHIFT;
+       pgoff_t start = lstart >> PAGE_SHIFT;
+       pgoff_t end = lend >> PAGE_SHIFT;
        struct pagevec pvec;
        pgoff_t indices[PAGEVEC_SIZE];
        struct page *page;
        long nr_swaps_freed = 0;
        pgoff_t index;
        int i;
-       bool same_page;
+       bool same_page = (start == end);
 
-       if (lend == -1)
-               end = -1;       /* unsigned, so actually very big */
+       page = NULL;
+       shmem_getpage(inode, start, &page, SGP_READ);
+       if (page) {
+               page = thp_head(page);
+               same_page = lend < page_offset(page) + thp_size(page);
+               set_page_dirty(page);
+               if (truncate_inode_partial_page(page, lstart, lend))
+                       start++;
+               else
+                       start = page->index + thp_nr_pages(page);
+               unlock_page(page);
+               put_page(page);
+               page = NULL;
+       }
+
+       if (!same_page)
+               shmem_getpage(inode, end, &page, SGP_READ);
+       if (page) {
+               page = thp_head(page);
+               set_page_dirty(page);
+               if (truncate_inode_partial_page(page, lstart, lend))
+                       end--;
+               else
+                       end = page->index - 1;
+               unlock_page(page);
+               put_page(page);
+       }
 
        pagevec_init(&pvec);
        index = start;
-       while (index < end && find_lock_entries(mapping, index, end - 1,
+       while (index <= end && find_lock_entries(mapping, index, end,
                        &pvec, indices)) {
                for (i = 0; i < pagevec_count(&pvec); i++) {
                        page = pvec.pages[i];
@@ -900,40 +925,11 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
                index++;
        }
 
-       same_page = (lend >> PAGE_SHIFT) == (lstart >> PAGE_SHIFT);
-       page = NULL;
-       shmem_getpage(inode, lstart >> PAGE_SHIFT, &page, SGP_READ);
-       if (page) {
-               page = thp_head(page);
-               same_page = lend < page_offset(page) + thp_size(page);
-               set_page_dirty(page);
-               if (!truncate_inode_partial_page(page, lstart, lend)) {
-                       start = page->index + thp_nr_pages(page);
-                       if (same_page)
-                               end = page->index;
-               }
-               unlock_page(page);
-               put_page(page);
-               page = NULL;
-       }
-
-       if (!same_page)
-               shmem_getpage(inode, end, &page, SGP_READ);
-       if (page) {
-               page = thp_head(page);
-               set_page_dirty(page);
-               if (!truncate_inode_partial_page(page, lstart, lend))
-                       end = page->index;
-               unlock_page(page);
-               put_page(page);
-       }
-
        index = start;
-       while (index < end) {
+       while (index <= end) {
                cond_resched();
 
-               if (!find_get_entries(mapping, index, end - 1, &pvec,
-                               indices)) {
+               if (!find_get_entries(mapping, index, end, &pvec, indices)) {
                        /* If all gone or hole-punch or unfalloc, we're done */
                        if (index == start || end != -1)
                                break;

That is, we change the definitions of start and end to be the more natural
"index of page which contains the first/last byte".  Then we deal with
the start and end of the range, and adjust the start & end appropriately.

I almost managed to get rid of 'same_page' until I thought about the case
where start was a compound page, and split succeeded.  In this case, we
already dealt with the tail and don't want to deal with it again.
