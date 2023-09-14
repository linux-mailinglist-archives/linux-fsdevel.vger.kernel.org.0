Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7827A071D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbjINOT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239858AbjINOT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:19:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEC9E3;
        Thu, 14 Sep 2023 07:19:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43B9F1F74A;
        Thu, 14 Sep 2023 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694701161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0XziXhzqdYQ6jkJJUPx6KRcnpVr4slvI7DzjxLfnJ4=;
        b=ZNAUKpXRuqmziqG4SSaJOBvkH3B29oZW/WP0HBGX/vDK3SFKa/FNSoKOIPYrZDkwXD8SZ1
        BldxTHF5uEDapriix1rPSrGIzfSycXLq6yc0G4gcgXjFX3juKTq/YgGiODw7DqDndQn49m
        FQU/pGbiI04nc51MTo6P9hu7JB8V41g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694701161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0XziXhzqdYQ6jkJJUPx6KRcnpVr4slvI7DzjxLfnJ4=;
        b=DfsFE8BCIQdhc7qRhJReJJCmyFHzZOr32YOU/6wJ++QBKImFR7lme0Ls8tiiVajS6U8/d6
        1jsn8txbVcFV/YDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33C91139DB;
        Thu, 14 Sep 2023 14:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zkScDGkWA2U1bwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 14 Sep 2023 14:19:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B72DAA07C2; Thu, 14 Sep 2023 16:19:20 +0200 (CEST)
Date:   Thu, 14 Sep 2023 16:19:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] ext4: Mark buffer new if it is unwritten to avoid
 stale data exposure
Message-ID: <20230914141920.lw2nlpzhcxwuz2y6@quack3>
References: <cover.1693909504.git.ojaswin@linux.ibm.com>
 <c307579df7e109eb4eedaaf07ebdc98b15d8b7ff.1693909504.git.ojaswin@linux.ibm.com>
 <20230905135629.wdjl2b6s3pzh7idg@quack3>
 <ZQL0jETgd8sA9rkI@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQL0jETgd8sA9rkI@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Ojaswin,

On Thu 14-09-23 17:24:52, Ojaswin Mujoo wrote:
> On Tue, Sep 05, 2023 at 03:56:29PM +0200, Jan Kara wrote:
> > On Tue 05-09-23 15:58:01, Ojaswin Mujoo wrote:
> > > ** Short Version **
> > > 
> > > In ext4 with dioread_nolock, we could have a scenario where the bh returned by
> > > get_blocks (ext4_get_block_unwritten()) in __block_write_begin_int() has
> > > UNWRITTEN and MAPPED flag set. Since such a bh does not have NEW flag set we
> > > never zero out the range of bh that is not under write, causing whatever stale
> > > data is present in the folio at that time to be written out to disk. To fix this
> > > mark the buffer as new in _ext4_get_block(), in case it is unwritten.
> > > 
> > > -----
> > > ** Long Version **
> > > 
> > > The issue mentioned above was resulting in two different bugs:
> > > 
> > > 1. On block size < page size case in ext4, generic/269 was reliably
> > > failing with dioread_nolock. The state of the write was as follows:
> > > 
> > >   * The write was extending i_size.
> > >   * The last block of the file was fallocated and had an unwritten extent
> > >   * We were near ENOSPC and hence we were switching to non-delayed alloc
> > >     allocation.
> > > 
> > > In this case, the back trace that triggers the bug is as follows:
> > > 
> > >   ext4_da_write_begin()
> > >     /* switch to nodelalloc due to low space */
> > >     ext4_write_begin()
> > >       ext4_should_dioread_nolock() // true since mount flags still have delalloc
> > >       __block_write_begin(..., ext4_get_block_unwritten)
> > >         __block_write_begin_int()
> > >           for(each buffer head in page) {
> > >             /* first iteration, this is bh1 which contains i_size */
> > >             if (!buffer_mapped)
> > >               get_block() /* returns bh with only UNWRITTEN and MAPPED */
> > >             /* second iteration, bh2 */
> > >               if (!buffer_mapped)
> > >                 get_block() /* we fail here, could be ENOSPC */
> > >           }
> > >           if (err)
> > >             /*
> > >              * this would zero out all new buffers and mark them uptodate.
> > >              * Since bh1 was never marked new, we skip it here which causes
> > >              * the bug later.
> > >              */
> > >             folio_zero_new_buffers();
> > >       /* ext4_wrte_begin() error handling */
> > >       ext4_truncate_failed_write()
> > >         ext4_truncate()
> > >           ext4_block_truncate_page()
> > >             __ext4_block_zero_page_range()
> > 	>               if(!buffer_uptodate())
> > >                 ext4_read_bh_lock()
> > >                   ext4_read_bh() -> ... ext4_submit_bh_wbc()
> > >                     BUG_ON(buffer_unwritten(bh)); /* !!! */
> > > 
> > > 2. The second issue is stale data exposure with page size >= blocksize
> > > with dioread_nolock. The conditions needed for it to happen are same as
> > > the previous issue ie dioread_nolock around ENOSPC condition. The issue
> > > is also similar where in __block_write_begin_int() when we call
> > > ext4_get_block_unwritten() on the buffer_head and the underlying extent
> > > is unwritten, we get an unwritten and mapped buffer head. Since it is
> > > not new, we never zero out the partial range which is not under write,
> > > thus writing stale data to disk. This can be easily observed with the
> > > following reporducer:
> > > 
> > >  fallocate -l 4k testfile
> > >  xfs_io -c "pwrite 2k 2k" testfile
> > >  # hexdump output will have stale data in from byte 0 to 2k in testfile
> > >  hexdump -C testfile
> > > 
> > > NOTE: To trigger this, we need dioread_nolock enabled and write
> > > happening via ext4_write_begin(), which is usually used when we have -o
> > > nodealloc. Since dioread_nolock is disabled with nodelalloc, the only
> > > alternate way to call ext4_write_begin() is to fill make sure dellayed
> > > alloc switches to nodelalloc (ext4_da_write_begin() calls
> > > ext4_write_begin()).  This will usually happen when FS is almost full
> > > like the way generic/269 was triggering it in Issue 1 above. This might
> > > make this issue harder to replicate hence for reliable replicate, I used
> > > the below patch to temporarily allow dioread_nolock with nodelalloc and
> > > then mount the disk with -o nodealloc,dioread_nolock. With this you can
> > > hit the stale data issue 100% of times:
> > > 
> > > @@ -508,8 +508,8 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
> > >   if (ext4_should_journal_data(inode))
> > >     return 0;
> > >   /* temporary fix to prevent generic/422 test failures */
> > > - if (!test_opt(inode->i_sb, DELALLOC))
> > > -   return 0;
> > > + // if (!test_opt(inode->i_sb, DELALLOC))
> > > + //  return 0;
> > >   return 1;
> > >  }
> > > 
> > > -------
> > > 
> > > After applying this patch to mark buffer as NEW, both the above issues are
> > > fixed.
> > > 
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > 
> > Good catch! But I'm wondering whether this is really the right fix. For
> > example in ext4_block_truncate_page() shouldn't we rather be checking
> > whether the buffer isn't unwritten and if yes then bail because there's
> > nothing to zero out in the block? That would seem like a more logical
> > and robust solution of the first problem to me.
> 
> So I was looking into this to understand the code paths and it seems
> like ext4_truncate doesn't really impose that a unwritten buffer does
> not have any data in its corresponding folio, which might sometimes be
> the case. 
> 
> For example, imagine a case where we get the last block of a file via
> ext4_da_get_block_prep() which returns a bh that is unwritten, mapped
> and new. During the write, we'll copy data in this folio and then 
> adjust i_size in write_end, release the folio lock and ultimately the
> inode_lock().
> 
> In this intermediate state, before writeback happens, the buffer is
> unwritten but has data which will be written. At this point, if we call
> ext4_block_truncate_page() and have the logic to exit early for bh_unwritten, the
> we will never actually zero out the folio which might cause stale data to be
> written during writeback (?)

Actually we will. truncate_inode_pages_range() ends up calling
truncate_inode_partial_folio() which zeros out the tail of the partial
page. I think you are confusing two different things. One is zeroing of
partial page cache pages - that is generally handled by the generic
truncate code - and another one is zeroing of on-disk partial blocks - that
is handled by the filesystem itself. The contents on on-disk blocks does
not matter as long as they are marked as unwritten in the extent tree
(their contents is random anyway) and therefore __ext4_block_zero_page_range()
has nothing to do in that case.

> Now, most of the calls to ext4_block_truncate_page() happen via ext4_truncate ( like via ext4_setattr,
> ext4_truncate_failed_write() etc) call truncate_inode_pages() which
> seems to handle zeroing the partial folio beyond i_size. However, if we
> add the logic to skip unwritten blocks in this function then:
> 
> 1. We create an implicit dependency in ext4_block_truncate_page() that
> the folio needs to not have any data if its unwritten ie some other
> function has taken care of by some other function called before it.

Yes, this dependency already exists today because when blocksize < pagesize
the zeroing happening in __ext4_block_zero_page_range() may be a subset of
what gets zeroed by truncate_inode_partial_folio(). Still we zero the page
in __ext4_block_zero_page_range() for the case when the page was not cached
at all and we've just loaded it from the disk.

> 2. Additionally, that other function will also need to mark the relevant
> buffer dirty, which is done in this function.

AFAICT there's no need to mark the buffer dirty - the whole point is we
don't need to touch the on-disk contents if the block is unwritten...

> 3. There are some other paths that call ext4_block_truncate_page()
> without turncating the pagecache like ext4_zero_range(). Im not sure if
> this will cause any issues as I've not gone through the function
> completely though but yes, other functions that later call truncate
> in future might need to keep this implicit dependency in mind.

Indeed, this is a good catch. So we either need to make both sites calling
ext4_zero_partial_blocks() to use truncate_pagecache_range() for the whole
range including partial blocks or we need to zero out the page cache
(without bringing the page uptodate or marking it dirty) in
ext4_zero_partial_blocks() even if the buffer is unwritten. I don't have a
strong preference either way.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
