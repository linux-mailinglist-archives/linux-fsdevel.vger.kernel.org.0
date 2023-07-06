Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBFC74A7EE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 01:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGFXyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 19:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGFXyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:54:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F37D1BE9;
        Thu,  6 Jul 2023 16:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cplWTIsako/UYV5ff7LNoJ9hwOtvPBMphsgshNUOk1A=; b=LW7yBqPFndq6QvVIShBqI+la0r
        MqdzIsEHV4B5T7Jw2rgrmknfaszMZ/Du1kW+2fXv8LhoUlTXErNFvkRPO1uY1egVU8O+j2avKhlS2
        TXT5RvxjxN/GGt0mo33APy44c1u52/ooHqGA0JZ4Q579Hdf2JyQP7zhrg2SDsuLzJQ72DwoZ4sQFR
        xkXXHdB9N5m0+HlnfTWqWGsc82h1qOmVEerqiT1DB8EBaQm5fU+yHJl2kK3GpFfDka64VTbWLr5OD
        EcsCMK0tg4a07AD2DAhz2SspMpxdtrd0DOyGIy+twmfAq1hXOv41QFia7p8CmZLvPDNaafsRIf72B
        DEeTOA6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHYnv-00BWIJ-Iu; Thu, 06 Jul 2023 23:54:31 +0000
Date:   Fri, 7 Jul 2023 00:54:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv11 8/8] iomap: Add per-block dirty state tracking to
 improve performance
Message-ID: <ZKdUN7ALMSCKPBV/@casper.infradead.org>
References: <bb0c58bf80dcdec96d7387bc439925fb14a5a496.1688188958.git.ritesh.list@gmail.com>
 <87jzvdjdxu.fsf@doe.com>
 <ZKb9DAKIE13XSrVf@casper.infradead.org>
 <ZKc9MUXq6dKkQvSP@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKc9MUXq6dKkQvSP@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 07, 2023 at 08:16:17AM +1000, Dave Chinner wrote:
> On Thu, Jul 06, 2023 at 06:42:36PM +0100, Matthew Wilcox wrote:
> > On Thu, Jul 06, 2023 at 08:16:05PM +0530, Ritesh Harjani wrote:
> > > > @@ -1645,6 +1766,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> > > >  	int error = 0, count = 0, i;
> > > >  	LIST_HEAD(submit_list);
> > > >  
> > > > +	if (!ifs && nblocks > 1) {
> > > > +		ifs = ifs_alloc(inode, folio, 0);
> > > > +		iomap_set_range_dirty(folio, 0, folio_size(folio));
> > > > +	}
> > > > +
> > > >  	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) != 0);
> > > >  
> > > >  	/*
> > > > @@ -1653,7 +1779,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> > > >  	 * invalid, grab a new one.
> > > >  	 */
> > > >  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> > > > -		if (ifs && !ifs_block_is_uptodate(ifs, i))
> > > > +		if (ifs && !ifs_block_is_dirty(folio, ifs, i))
> > > >  			continue;
> > > >  
> > > >  		error = wpc->ops->map_blocks(wpc, inode, pos);
> > > > @@ -1697,6 +1823,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> > > >  		}
> > > >  	}
> > > >  
> > > > +	iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
> > > >  	folio_start_writeback(folio);
> > > >  	folio_unlock(folio);
> > > >  
> > > 
> > > I think we should fold below change with this patch. 
> > > end_pos is calculated in iomap_do_writepage() such that it is either
> > > folio_pos(folio) + folio_size(folio), or if this value becomes more then
> > > isize, than end_pos is made isize.
> > > 
> > > The current patch does not have a functional problem I guess. But in
> > > some cases where truncate races with writeback, it will end up marking
> > > more bits & later doesn't clear those. Hence I think we should correct
> > > it using below diff.
> > 
> > I don't think this is the only place where we'll set dirty bits beyond
> > EOF.  For example, if we mmap the last partial folio in a file,
> > page_mkwrite will dirty the entire folio, but we won't write back
> > blocks past EOF.  I think we'd be better off clearing all the dirty
> > bits in the folio, even the ones past EOF.  What do you think?
> 
> Clear the dirty bits beyond EOF where we zero the data range beyond
> EOF in iomap_do_writepage() via folio_zero_segment()?

That would work, but I think it's simpler to change:

-	iomap_clear_range_dirty(folio, 0, end_pos - folio_pos(folio));
+	iomap_clear_range_dirty(folio, 0, folio_size(folio));

