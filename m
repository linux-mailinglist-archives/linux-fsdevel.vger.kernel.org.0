Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67AD735C70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 18:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjFSQyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 12:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFSQyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:54:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475609E;
        Mon, 19 Jun 2023 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rkYNKnrhTV49GKhecrZ/toeYCiPeQ9FmihHzLHvk8WU=; b=p6lW4XZgDoMzv7aRSJ87SrvZW/
        3rads7FjljASm3tOI+lm7D33I6Z9COgTOHfSjOhNWeiBejFAc51RXF26a9S1acka7HoNAcrsWopiK
        i+caOlVAk5MbKS++psOXVsl8yO41TRSgMnQs3oAko7cd9oYsnzLk1kpgRWjEIf6/oxEvnRNvh39ZY
        9JFUfUJtpo+Da6ZKCG/xx/0B6NTydOcBHHWieWt4HfKR4+VB8DzfrX/tQnBmTCu47qXIAeAL9JieQ
        bEP4XyTstd6tYI+ceMI9l0DZvEFejnWhoYLMXPm7x304lTUhClyjL7tPtdhVkOtC6tu4PqPEuD0Rk
        dSQE4/KQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBI8q-00C561-Uy; Mon, 19 Jun 2023 16:54:12 +0000
Date:   Mon, 19 Jun 2023 17:54:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv10 8/8] iomap: Add per-block dirty state tracking to
 improve performance
Message-ID: <ZJCINLpHGifRHewa@casper.infradead.org>
References: <ZJBli4JznbJkyF0U@casper.infradead.org>
 <87o7lbmnam.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7lbmnam.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 09:55:53PM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Mon, Jun 19, 2023 at 07:58:51AM +0530, Ritesh Harjani (IBM) wrote:
> >> +static void ifs_calc_range(struct folio *folio, size_t off, size_t len,
> >> +		enum iomap_block_state state, unsigned int *first_blkp,
> >> +		unsigned int *nr_blksp)
> >> +{
> >> +	struct inode *inode = folio->mapping->host;
> >> +	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> >> +	unsigned int first = off >> inode->i_blkbits;
> >> +	unsigned int last = (off + len - 1) >> inode->i_blkbits;
> >> +
> >> +	*first_blkp = first + (state * blks_per_folio);
> >> +	*nr_blksp = last - first + 1;
> >> +}
> >
> > As I said, this is not 'first_blkp'.  It's first_bitp.  I think this
> > misunderstanding is related to Andreas' complaint, but it's not quite
> > the same.
> >
> 
> We represent each FS block as a bit in the bitmap. So first_blkp or
> first_bitp or first_blkbitp essentially means the same. 
> I went with first_blk, first_blkp in the first place based on your
> suggestion itself [1].

No, it's not the same!  If you have 1kB blocks in a 64kB page, they're
numbered 0-63.  If you 'calc_range' for any of the dirty bits, you get
back a number in the range 64-127.  That's not a block number!  It's
the number of the bit you want to refer to.  Calling it blkp is going
to lead to confusion -- as you yourself seem to be confused.

> [1]: https://lore.kernel.org/linux-xfs/Y%2FvxlVUJ31PZYaRa@casper.infradead.org/

Those _were_ block numbers!  off >> inode->i_blkbits calculates a block
number.  (off >> inode->i_blkbits) + blocks_per_folio() does not calculate
a block number, it calculates a bit number.

> >> -	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
> >> +	return bitmap_full(ifs->state, nr_blks);
> >
> > I think we have a gap in our bitmap APIs.  We don't have a
> > 'bitmap_range_full(src, pos, nbits)'.  We could use find_next_zero_bit(),
> > but that's going to do more work than necessary.
> >
> > Given this lack, perhaps it's time to say that you're making all of
> > this too hard by using an enum, and pretending that we can switch the
> > positions of 'uptodate' and 'dirty' in the bitmap just by changing
> > the enum.
> 
> Actually I never wanted to use the the enum this way. That's why I was
> not fond of the idea behind using enum in all the bitmap state
> manipulation APIs (test/set/).
> 
> It was only intended to be passed as a state argument to ifs_calc_range()
> function to keep all the first_blkp and nr_blksp calculation at one
> place. And just use it's IOMAP_ST_MAX value while allocating state bitmap.
> It was never intended to be used like this.
> 
> We can even now go back to this original idea and keep the use of the
> enum limited to what I just mentioned above i.e. for ifs_calc_range().
> 
> And maybe just use this in ifs_alloc()?
> BUILD_BUG_ON(IOMAP_ST_UPTODATE == 0);
> BUILD_BUG_ON(IOMAP_ST_DIRTY == 1);
> 
> > Define the uptodate bits to be the first ones in the bitmap,
> > document it (and why), and leave it at that.
> 
> Do you think we can go with above suggestion, or do you still think we
> need to drop it?
> 
> In case if we drop it, then should we open code the calculations for
> first_blk, last_blk? These calculations are done in exact same fashion
> at 3 places ifs_set_range_uptodate(), ifs_clear_range_dirty() and
> ifs_set_range_dirty().
> Thoughts?

I disliked the enum from the moment I saw it, but didn't care enough to
say so.

Look, an abstraction should have a _purpose_.  The enum doesn't.  I'd
ditch this calc_range function entirely; it's just not worth it.
