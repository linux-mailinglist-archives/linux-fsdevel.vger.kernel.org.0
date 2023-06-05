Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6E77228D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 16:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjFEOb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 10:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjFEObZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:31:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A27E8;
        Mon,  5 Jun 2023 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6izMVQ9m9HEYT6yx5F2UmGBTPWgGa26OUk67j+agszA=; b=NoBJSmHH9oHu83+wHfrXfLoSWy
        P/IhwCMWavyo6edAdqB0Gx34lmUEFqSbKXoQ863oNFdz14OiC+1Wwy4onkAWYCkHb3U+/W63uJNWs
        Z922V1pr1wdCDeJTqbFcVtDzQoq3ZwJpadTDJDHUzHrdG52UtK9krO4PerOpBa+6CHGyyJVL8VDrr
        UI4a5BhX6PSPUUTAxdL/xVUSHCx/R3Cf6AYxR1rkVrsq6aqUHm2wabWxRm2e0bTdX8kNu+jpNnnC7
        yHPl/AAPMdsqfI9IKK/iUIm0HpcgR9beJmmic9mSzppk4M3SUfqRZ2k85mXKoLlEC6sBk36VNguPI
        F6xbLKPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6BEt-00C6SO-8g; Mon, 05 Jun 2023 14:31:19 +0000
Date:   Mon, 5 Jun 2023 15:31:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv7 3/6] iomap: Refactor some iop related accessor functions
Message-ID: <ZH3xt3npT9jeBFMG@casper.infradead.org>
References: <cover.1685962158.git.ritesh.list@gmail.com>
 <4fe4937718d44c89e0c279175c65921717d9f591.1685962158.git.ritesh.list@gmail.com>
 <CAHc6FU7xZaDAnmQ5UhO=MCnW_nGV2WNs93=PTAoVWCYuSCnrAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7xZaDAnmQ5UhO=MCnW_nGV2WNs93=PTAoVWCYuSCnrAQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 04:15:31PM +0200, Andreas Gruenbacher wrote:
> Note that to_iomap_page() does folio_test_private() followed by
> folio_get_private(), which doesn't really make sense in places where
> we know that iop is defined. Maybe we want to split that up.

The plan is to retire the folio private flag entirely.  I just haven't
got round to cleaning up iomap yet.  For folios which we know to be
file-backed, we can just test whether folio->private is NULL or not.

So I'd do this as:

-	struct iomap_page *iop = to_iomap_page(folio);
+	struct iomap_page *iop = folio->private;

and not even use folio_get_private() or to_iomap_page() any more.

> > +       unsigned int first_blk = off >> inode->i_blkbits;
> > +       unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
> > +       unsigned int nr_blks = last_blk - first_blk + 1;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&iop->state_lock, flags);
> > +       bitmap_set(iop->state, first_blk, nr_blks);
> > +       if (iop_test_full_uptodate(folio))
> > +               folio_mark_uptodate(folio);
> > +       spin_unlock_irqrestore(&iop->state_lock, flags);
> > +}
> > +
> > +static void iomap_iop_set_range_uptodate(struct inode *inode,
> > +               struct folio *folio, size_t off, size_t len)
> > +{
> > +       struct iomap_page *iop = to_iomap_page(folio);
> > +
> > +       if (iop)
> > +               iop_set_range_uptodate(inode, folio, off, len);
> > +       else
> > +               folio_mark_uptodate(folio);
> > +}
> 
> This patch passes the inode into iomap_iop_set_range_uptodate() and
> removes the iop argument. Can this be done in a separate patch,
> please?
> 
> We have a few places like the above, where we look up the iop without
> using it. Would a function like folio_has_iop() make more sense?

I think this is all a symptom of the unnecessary splitting of
iomap_iop_set_range_uptodate and iop_set_range_uptodate.

