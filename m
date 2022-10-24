Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA6960B965
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 22:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiJXUJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 16:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiJXUJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:09:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD0196200;
        Mon, 24 Oct 2022 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fcx3UsJT/EiGxEWc981H0B6QDQpyfmAuT8tUP7W5Bog=; b=KW9TUI6gkHypoxaCi6CgHc414r
        EcrGhdTngXbD6oLuuLfYGwiK/T7jSvFBwexevni+2ywKAypeipXCrpUUe1qeLGgwfQ2mhUN4U8m78
        hvz1IrtTPG4GexHAM3pCHxpyimTGhpYaNG6PoJoF9jw+mL5HfraXrih3zeOlBxMOrOUftje5TaEjv
        TyUdpNW2FFN1zr9X3iVFCxokhRMQqvy8EOeFgUIFb6e3TzqAGCErefPeHw45D/cts6wMqgNlmvDMX
        GmzzkXdqMCT5MY6oFaSxAzHJVvglksH9/uJRnOHPbKbyXyfSTEvYa0swHHmH0+xRR8zb5WfidFDkC
        srU6F4jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omytI-0020ka-J7; Mon, 24 Oct 2022 14:57:24 +0000
Date:   Mon, 24 Oct 2022 07:57:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: How to convert I/O iterators to iterators, sglists and RDMA lists
Message-ID: <Y1an1NFcowiSS9ms@infradead.org>
References: <Y01VjOE2RrLVA2T6@infradead.org>
 <1762414.1665761217@warthog.procyon.org.uk>
 <1415915.1666274636@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415915.1666274636@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 20, 2022 at 03:03:56PM +0100, David Howells wrote:
> > What block file systems do is to take the pages from the iter and some flags
> > on what is pinned.  We can generalize this to store all extra state in a
> > flags word, or byte the bullet and allow cloning of the iter in one form or
> > another.
> 
> Yeah, I know.  A list of pages is not an ideal solution.  It can only handle
> contiguous runs of pages, possibly with a partial page at either end.  A bvec
> iterator would be of more use as it can handle a series of partial pages.
> 
> Note also that I would need to turn the pages *back* into an iterator in order
> to commune with sendmsg() in the nether reaches of some network filesystems.

Yes.  So I think the right thing here is to make sure we can send
the iter through the whole stack without a convesion.

> It would be nice to be able to pass an iterator to the crypto layer.  I'm not
> sure what the crypto people think of that.

Let's ask them..

> On the other hand, if you think the RDMA API should be taking scatterlists
> rather than sge lists, that would be fine.  Even better if I can just pass an
> iterator in directly - though neither scatterlist nor iterator has a place to
> put the RDMA local_dma_key - though I wonder if that's actually necessary for
> each sge element, or whether it could be handed through as part of the request
> as a hole.

Well, in the long run it should not take scatterlists either, as they
are a bad data structure.  But what should happen in the long run is
that the DMA mapping is only done in the hardware drivers, not the ULPs,
which is a really nasty layering violation.  This requires the strange
ib_dma_* stubs to disable DMA mapping for the software drivers, and it
also does complete unneeded DMA mappings for sends that are inline in
the SQE as supported by some Mellanox / Nvidia hardware.

> That's fine in principle.  However, I have some extraction code that can
> convert an iterator to another iterator, an sglist or an rdma sge list, using
> a common core of code to do all three.

So I think the iterator to iterator is a really bad idea and we should
not have it at all.  It just works around the issue about not being
able to easily keeping state after an iter based get_user_pages, but
that is beeing addressed at the moment.  The iter to ib_sge/scatterlist
are very much RDMA specific at the moment, so I guess that might be a
good place to keep them.  In fact I suspect the scatterlist conversion
should not be a public API at all, but hidden in rw.c and only be used
internally for the DMA mapping.
