Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C267F72EC33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 21:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbjFMTpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 15:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjFMTpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:45:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3EC12A;
        Tue, 13 Jun 2023 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MA1u6hfUSr4FyJu2OJC57pk3YK5M+oEDp0ZuNl44zUw=; b=YmvpMCDIKTYvvOMaeqj6ZOeJvo
        mTjj8tUZgXQlJ+xuvZddI77gYLeZ1ND488EGVdZdCE6zQ0prAr2j88wZ4cxliYSUKa6aijo4r63Ju
        r7j/DixekYbG5vyRxRKxEz5XmR+x3URnFghzhYir44+NsqmXqcZSnReT33XbJMg5MeYlge7fG7mVJ
        8WKTAO8y+gVi8FvmFZALfkTx6MYrFwz3CWZDKL5q1IjX6/y/eIwD1edo8m4kQyoqSbuW2bEerAHY5
        B4/GMEl2uvaoHZvPd1b0o6fcBwNkBKL9vgh2V/s5KfuGPht+cmegb/kHxKyVvR+SZe/WFM+t75tkV
        J+lzUmHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q99wx-004GAi-EN; Tue, 13 Jun 2023 19:45:07 +0000
Date:   Tue, 13 Jun 2023 20:45:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv2 2/5] ext4: Remove PAGE_SIZE assumption of folio from
 mpage_submit_folio
Message-ID: <ZIjHQ5Nea7eRLjzF@casper.infradead.org>
References: <20230613095917.trpqw2iv2f7kutaz@quack3>
 <87o7ljw3qo.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7ljw3qo.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 01:09:59AM +0530, Ritesh Harjani wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > On Tue 13-06-23 09:27:38, Ritesh Harjani wrote:
> >> Matthew Wilcox <willy@infradead.org> writes:
> >> > On Mon, Jun 12, 2023 at 11:55:55PM +0530, Ritesh Harjani wrote:
> >> >> Matthew Wilcox <willy@infradead.org> writes:
> >> >> I couldn't respond to your change because I still had some confusion
> >> >> around this suggestion -
> >> >>
> >> >> > So do we care if we write a random fragment of a page after a truncate?
> >> >> > If so, we should add:
> >> >> >
> >> >> >         if (folio_pos(folio) >= size)
> >> >> >                 return 0; /* Do we need to account nr_to_write? */
> >> >>
> >> >> I was not sure whether if go with above case then whether it will
> >> >> work with collapse_range. I initially thought that collapse_range will
> >> >> truncate the pages between start and end of the file and then
> >> >> it can also reduce the inode->i_size. That means writeback can find an
> >> >> inode->i_size smaller than folio_pos(folio) which it is writing to.
> >> >> But in this case we can't skip the write in writeback case like above
> >> >> because that write is still required (a spurious write) even though
> >> >> i_size is reduced as it's corresponding FS blocks are not truncated.
> >> >>
> >> >> But just now looking at ext4_collapse_range() code it doesn't look like
> >> >> it is the problem because it waits for any dirty data to be written
> >> >> before truncate. So no matter which folio_pos(folio) the writeback is
> >> >> writing, there should not be an issue if we simply return 0 like how
> >> >> you suggested above.
> >> >>
> >> >>     static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
> >> >>
> >> >>     <...>
> >> >>         ioffset = round_down(offset, PAGE_SIZE);
> >> >>         /*
> >> >>         * Write tail of the last page before removed range since it will get
> >> >>         * removed from the page cache below.
> >> >>         */
> >> >>
> >> >>         ret = filemap_write_and_wait_range(mapping, ioffset, offset);
> >> >>         if (ret)
> >> >>             goto out_mmap;
> >> >>         /*
> >> >>         * Write data that will be shifted to preserve them when discarding
> >> >>         * page cache below. We are also protected from pages becoming dirty
> >> >>         * by i_rwsem and invalidate_lock.
> >> >>         */
> >> >>         ret = filemap_write_and_wait_range(mapping, offset + len,
> >> >>                         LLONG_MAX);
> >> >>         truncate_pagecache(inode, ioffset);
> >> >>
> >> >>         <... within i_data_sem>
> >> >>         i_size_write(inode, new_size);
> >> >>
> >> >>     <...>
> >> >>
> >> >>
> >> >> However to avoid problems like this I felt, I will do some more code
> >> >> reading. And then I was mostly considering your second suggestion which
> >> >> is this. This will ensure we keep the current behavior as is and not
> >> >> change that.
> >> >>
> >> >> > If we simply don't care that we're doing a spurious write, then we can
> >> >> > do something like:
> >> >> >
> >> >> > -               len = size & ~PAGE_MASK;
> >> >> > +               len = size & (len - 1);
> >> >
> >> > For all I know, I've found a bug here.  I don't know enough about ext4; if
> >> > we have truncated a file, and then writeback a page that is past i_size,
> >> > will the block its writing to have been freed?
> >> 
> >> I don't think so. If we look at truncate code, it first reduces i_size,
> >> then call truncate_pagecache(inode, newsize) and then we will call
> >> ext4_truncate() which will free the corresponding blocks.
> >> Since writeback happens with folio lock held until completion, hence I
> >> think truncate_pagecache() should block on that folio until it's lock
> >> has been released.
> >> 
> >> - IIUC, if truncate would have completed then the folio won't be in the
> >> foliocache for writeback to happen. Foliocache is kept consistent
> >> via
> >>     - first truncate the folio in the foliocache and then remove/free
> >>     the blocks on device.
> >
> > Yes, correct.
> >
> >> - Also the reason we update i_size "before" calling truncate_pagecache()
> >>   is to synchronize with mmap/pagefault.
> >
> > Yes, but these days mapping->invalidate_lock works for that instead for
> > ext4.
> >
> >> > Is this potentially a silent data corruptor?
> >> 
> >> - Let's consider a case when folio_pos > i_size but both still belongs
> >> to the last block. i.e. it's a straddle write case.
> >> In such case we require writeback to write the data of this last folio
> >> straddling i_size. Because truncate will not remove/free this last folio
> >> straddling i_size & neither the last block will be freed. And I think
> >> writeback is supposed to write this last folio to the disk to keep the
> >> cache and disk data consistent. Because truncate will only zero out
> >> the rest of the folio in the foliocache. But I don't think it will go and
> >> write that folio out (It's not required because i_size means that the
> >> rest of the folio beyond i_size should remain zero).
> >> 
> >> So, IMO writeback is supposed to write this last folio to the disk. And,
> >> if we skip this writeout, then I think it may cause silent data corruption.
> >> 
> >> But I am not sure about the rest of the write beyond the last block of
> >> i_size. I think those could just be spurious writes which won't cause
> >> any harm because truncate will eventually first remove this folio from
> >> file mapping and then will release the corresponding disk blocks.
> >> So writing those out should does no harm
> >
> > Correct. The block straddling i_size must be written out, the blocks fully
> > beyond new i_size (but below old i_size) may or may not be written out. As
> > you say these extra racing writes to blocks that will get truncated cause
> > no harm.
> >
> 
> Thanks Jan for confirming. So, I think we should make below change.
> (note the code which was doing "size - folio_pos(folio)" in
> mpage_submit_folio() is dropped by Ted in the latest tree).
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 43be684dabcb..006eba9be5e6 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1859,9 +1859,9 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
>          */
>         size = i_size_read(mpd->inode);
>         len = folio_size(folio);
> -       if (folio_pos(folio) + len > size &&
> +       if ((folio_pos(folio) >= size || (folio_pos(folio) + len > size)) &&
>             !ext4_verity_in_progress(mpd->inode))
> -               len = size & ~PAGE_MASK;
> +               len = size & (len - 1);
>         err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
>         if (!err)
>                 mpd->wbc->nr_to_write--;
> @@ -2329,9 +2329,9 @@ static int mpage_journal_page_buffers(handle_t *handle,
>         folio_clear_checked(folio);
>         mpd->wbc->nr_to_write--;
> 
> -       if (folio_pos(folio) + len > size &&
> +       if ((folio_pos(folio) >= size || (folio_pos(folio) + len > size)) &&
>             !ext4_verity_in_progress(inode))
> -               len = size - folio_pos(folio);
> +               len = size & (len - 1);
> 
>         return ext4_journal_folio_buffers(handle, folio, len);
>  }
> 
> 
> I will give it some more thoughts and testing.

Why should ext4 be different from other filesystems which simply do:

	if (folio_pos(folio) >= size)
		return 0;
