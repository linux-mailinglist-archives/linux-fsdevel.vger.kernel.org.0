Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E171A73FFBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjF0PbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 11:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0PbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:31:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B25270C;
        Tue, 27 Jun 2023 08:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lHqSq2yg0hu/9TbZSF7IDALzpNFv9gjm5EjJ/uf/0wM=; b=gHepl+TciLMWXYtAYcyOchIQ8O
        92/OeN6/EuVk4lVItxfJ2FB0AfBIwXfT8d/+QpWWC/fpd+cdGEybTJfKOnFuDIiYi8ev/koIl0U5I
        u12r3uX+SYED69pLyAiX4AedlQ7VKmMxP0B8OsqpcHLxPwZrU18TYwrgNTzIYp0kqDMuP9vqkbnUD
        YgTk5Pe1cqhcgKi1NFiBs6Rgz4ahCvuTKFgGIyUSfDkMzc5OqdPDWRZ6JCaBYBXmEHY8bX1HYM3E2
        wGUz/xKGJUBQaxjim0VxGIm+wN247iwNXYkwMuPRD6RwbHkXvo9zUTPxIuuJx3jUe9guGzVAkxG3g
        gU/65X2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEAez-002qVu-HU; Tue, 27 Jun 2023 15:31:17 +0000
Date:   Tue, 27 Jun 2023 16:31:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 09/12] writeback: Factor writeback_iter_next() out of
 write_cache_pages()
Message-ID: <ZJsAxVRZSEvdmlfB@casper.infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-10-willy@infradead.org>
 <ZJpoCy7oWtqy2FoW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJpoCy7oWtqy2FoW@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:39:39PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 26, 2023 at 06:35:18PM +0100, Matthew Wilcox (Oracle) wrote:
> > Pull the post-processing of the writepage_t callback into a
> > separate function.  That means changing writeback_finish() to
> > return NULL, and writeback_get_next() to call writeback_finish()
> > when we naturally run out of folios.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  mm/page-writeback.c | 84 ++++++++++++++++++++++++---------------------
> >  1 file changed, 44 insertions(+), 40 deletions(-)
> > 
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index 659df2b5c7c0..ef61d7006c5e 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -2360,7 +2360,7 @@ void tag_pages_for_writeback(struct address_space *mapping,
> >  }
> >  EXPORT_SYMBOL(tag_pages_for_writeback);
> >  
> > -static int writeback_finish(struct address_space *mapping,
> > +static struct folio *writeback_finish(struct address_space *mapping,
> >  		struct writeback_control *wbc, bool done)
> >  {
> >  	folio_batch_release(&wbc->fbatch);
> > @@ -2375,7 +2375,7 @@ static int writeback_finish(struct address_space *mapping,
> >  	if (wbc->range_cyclic || (wbc->range_whole && wbc->nr_to_write > 0))
> >  		mapping->writeback_index = wbc->done_index;
> >  
> > -	return wbc->err;
> > +	return NULL;
> 
> Having a return value that is always NULL feels a bit weird vs just
> doing that return in the caller.

It makes the callers neater.  Compare:

               if (!folio)
                        return writeback_finish(mapping, wbc, false);
vs
		if (!folio) {
			writeback_finish(mapping, wbc, false);
			return NULL;
		}

Similarly for the other two callers.

> > +		if (error == AOP_WRITEPAGE_ACTIVATE) {
> > +			folio_unlock(folio);
> > +			error = 0;
> 
> Note there really shouldn't be any need for this in outside of the
> legacy >writepage case.  But it might make sense to delay the removal
> until after ->writepage is gone to avoid bugs in conversions.

ext4_journalled_writepage_callback() still returns
AOP_WRITEPAGE_ACTIVATE, and that's used by a direct call to
write_cache_pages().

> > +		} else if (wbc->sync_mode != WB_SYNC_ALL) {
> > +			wbc->err = error;
> > +			wbc->done_index = folio->index +
> > +					folio_nr_pages(folio);
> 
> Btw, I wonder if a folio_next_index helper for this might be useful
> as it's a pattern we have in a few places.

I think that's a reasonable addition to the API.
