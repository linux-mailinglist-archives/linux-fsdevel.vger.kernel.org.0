Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98146741CB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 02:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjF2ACH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 20:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjF2ACE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:02:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0801EA3;
        Wed, 28 Jun 2023 17:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EesjQ1CwpnFXfNGbq1/L/h6YQv0U8+XJ4R+B/3hRf58=; b=b9KvWHJryQHvFPg9e871YaYOGm
        mOHNYZR1oSDs4lZ0b6yeUJAn5qeh4RixIgKOSGIVwzGOcVc1XFqLywfdJ0+GBr7X0ivN+NNYeW+ql
        i9qYgXsyy2/b4QRf/c6W5Nw5VyoVqrntD0jLwB7lsm9CBQtazTshb9SwcE8cbeF4z11ieWi8aFxS4
        EUyoaSTcBrlaNjeVYuio8vOURpSeH2X24hvzCkMRxSo3UEQOxc2UFkRnRiwvnAOxrRRw+4ACnByTj
        kmZ4/iyB90ugEP2lMVb3KHICvfHY4wTTiWulaL1VCGvSkb/kha9hSdF73dDRXoR7KfnWWlqFlzLcb
        7PqLDyPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEf6l-004L0A-Tr; Thu, 29 Jun 2023 00:01:59 +0000
Date:   Thu, 29 Jun 2023 01:01:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] writeback: Account the number of pages written back
Message-ID: <ZJzJ9/HhKup+FKey@casper.infradead.org>
References: <20230628185548.981888-1-willy@infradead.org>
 <ZJyr6GyVyvHxOpNB@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJyr6GyVyvHxOpNB@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 07:53:44AM +1000, Dave Chinner wrote:
> On Wed, Jun 28, 2023 at 07:55:48PM +0100, Matthew Wilcox (Oracle) wrote:
> > nr_to_write is a count of pages, so we need to decrease it by the number
> > of pages in the folio we just wrote, not by 1.  Most callers specify
> > either LONG_MAX or 1, so are unaffected, but writeback_sb_inodes()
> > might end up writing 512x as many pages as it asked for.
> > 
> > Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  mm/page-writeback.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index 1d17fb1ec863..d3f42009bb70 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -2434,6 +2434,7 @@ int write_cache_pages(struct address_space *mapping,
> >  
> >  		for (i = 0; i < nr_folios; i++) {
> >  			struct folio *folio = fbatch.folios[i];
> > +			unsigned long nr;
> >  
> >  			done_index = folio->index;
> >  
> > @@ -2471,6 +2472,7 @@ int write_cache_pages(struct address_space *mapping,
> >  
> >  			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> >  			error = writepage(folio, wbc, data);
> > +			nr = folio_nr_pages(folio);
> 
> This should really be done before writepage() is called, right? By
> the time the writepage() returns, the folio can be unlocked, the
> entire write completed and the folio partially invalidated which may
> try to split the folio...
> 
> Even if this can't happen (folio refcount is elevated, right?), it
> makes much more sense to me to sample the size of the folio while it
> is obviously locked and not going to change...

It can't change because of the refcount we hold (that's put in the call
to folio_batch_release()).  I didn't want to call it before the call to
writepage() because that makes the compiler stick it on the stack instead
of a local variable.  Also, when we transform this into an iterator (see
patches posted yesterday), we'd have to stash it away in the iterator.
