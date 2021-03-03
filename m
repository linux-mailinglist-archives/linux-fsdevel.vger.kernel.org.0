Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D73732C53D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448394AbhCDATv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380716AbhCCN3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:29:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3891C0611C2
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Mar 2021 05:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=32MD767myNxvn9bHKsHcwBgHYLDFcRhZ0rCpPRw4Ra8=; b=BhP68xAilhWiK7R/dkLMd9fPs8
        An4r1F6Ws3fWzyklofh2Cgajs6SLjTk2CDnN9gQ2TGmS3WHY40r0t7/xa21vDKQUB/Qpy8uf0p2Bz
        sf7lR+n62GkooeI5XNGuXox/CaF6yaN573Fax4AU2dBZFVS+xhMXmIwQvAkQlWzl2Gj2K1625uvxy
        SZGOJuRoIcPO4ILZ81fJCcQfLzvspWjsRy5eNj/iCXSoCWWQ2/b3jCWw1VZVYIyfvC2VXKYXjO1bS
        gtIlsUyY0A3bVXRmMSoNiZJAoU1rSvWiu/AhIvzhMYwbOgAO9Wosso+StAOIy1kg9M60Gt/Q9fg4G
        OhEshHDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lHRWS-002lMl-Vo; Wed, 03 Mar 2021 13:26:44 +0000
Date:   Wed, 3 Mar 2021 13:26:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm/filemap: Use filemap_read_page in filemap_fault
Message-ID: <20210303132640.GB2723601@casper.infradead.org>
References: <20210226140011.2883498-1-willy@infradead.org>
 <20210302173039.4625f403846abd20413f6dad@linux-foundation.org>
 <20210303013313.GZ2723601@casper.infradead.org>
 <20210302220735.1f150f28323f676d2955ab49@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302220735.1f150f28323f676d2955ab49@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 02, 2021 at 10:07:35PM -0800, Andrew Morton wrote:
> > > We also handle AOP_TRUNCATED_PAGE which the present code fails to do. 
> > > Should this be in the changelog?
> > 
> > No, the present code does handle AOP_TRUNCATED_PAGE.  It's perhaps not
> > the clearest in the diff, but it's there.  Here's git show -U5:
> > 
> > -       ClearPageError(page);
> >         fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> > -       error = mapping->a_ops->readpage(file, page);
> > -       if (!error) {
> > -               wait_on_page_locked(page);
> > -               if (!PageUptodate(page))
> > -                       error = -EIO;
> > -       }
> > +       error = filemap_read_page(file, mapping, page);
> >         if (fpin)
> >                 goto out_retry;
> >         put_page(page);
> >  
> >         if (!error || error == AOP_TRUNCATED_PAGE)
> >                 goto retry_find;
> >  
> > -       shrink_readahead_size_eio(ra);
> >         return VM_FAULT_SIGBUS;
> 
> But ->readpage() doesn't check for !mapping (does it?).  So the
> ->readpage() cannot return AOP_TRUNCATED_PAGE.

Filesystems can return AOP_TRUNCATED_PAGE from ->readpage.  I think
ocfs2 is the only one to do so currently.

> However filemap_read_page() does check for !mapping.  So current -linus
> doesn't check for !mapping, and post-willy does do this?

Oh!  I see what you mean now.  I can't come up with a sequence of events
where this check is going to do anything useful.  It may be left over from
earlier times.  Here's an earlier version of generic_file_buffered_read()
before Kent refactored it:

                /* Start the actual read. The read will unlock the page. */
                error = mapping->a_ops->readpage(filp, page);
[...]
                if (!PageUptodate(page)) {
                        error = lock_page_killable(page);
                        if (unlikely(error))
                                goto readpage_error;
                        if (!PageUptodate(page)) {
                                if (page->mapping == NULL) {
                                        /*
                                         * invalidate_mapping_pages got it
                                         */
                                        unlock_page(page);
                                        put_page(page);


But here's the thing ... invalidate_mapping_pages() doesn't
ClearPageUptodate.  The only places where we ClearPageUptodate is on an
I/O error.

So ... as far as I can tell, the only way to hit this is:

 - Get an I/O error during the wait
 - Have another thread cause the page to be removed from the page cache
   (eg do direct I/O to the file) before this thread is run.

and the consequence to this change is that we have another attempt to
read the page instead of returning an error immediately.  I'm OK with
that unintentional change, although I think the previous behaviour was
also perfectly acceptable (after all, there was an I/O error while trying
to read this page).

Delving into the linux-fullhistory tree, this code was introduced by ...

commit 56f0d5fe6851037214a041a5cb4fc66199256544
Author: Andrew Morton <akpm@osdl.org>
Date:   Fri Jan 7 22:03:01 2005 -0800

    [PATCH] readpage-vs-invalidate fix

    A while ago we merged a patch which tried to solve a problem wherein a
    concurrent read() and invalidate_inode_pages() would cause the read() to
    return -EIO because invalidate cleared PageUptodate() at the wrong time.

We no longer clear PageUptodate, so I think this is stale code?  Perhaps
you could check with the original author ...
