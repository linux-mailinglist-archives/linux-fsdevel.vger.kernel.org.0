Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2517678351
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjAWReb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjAWReU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:34:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B0F305EA;
        Mon, 23 Jan 2023 09:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qGa0oa0srIFUIaPbA6MrlYkjEdC+L/Rmu6uGtDnQAT8=; b=a0dYcl6T1BEmwrFeFzP3vO/hcv
        Aa0adT8BaMEM7mq2t+zVpqyFN+Z9V/72arZMolZaBHMetxStYrkgdW1/iYngIe0hQXuHu1LgxKojE
        VC6JjENVSSvD3rIhDGo1k/UwL4q+l33fklUARduIR6MhJ8FQIP9WT8EAehOnQLEDJRa0b+5/Pm4ge
        +qvDHBm3Bw/C/B4b9DcBzj9pRvp7tImGSkpdE72ZCqu77UPgIASSBwo1AHMquPfgXo+a5r6q7ZDIt
        yUHUAX23Nk6LGb9Lq9/+fX0CQ/XyKnmLKm9HS2AIF0nFLi480pM7BpWxXJI8pZi/vhERftPJWBdzZ
        eVCvKheQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK0hA-004P7c-W5; Mon, 23 Jan 2023 17:33:25 +0000
Date:   Mon, 23 Jan 2023 17:33:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     David Howells <dhowells@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iov_iter: Improve page extraction (ref, pin or
 just list)
Message-ID: <Y87E5HAo7ZoHyrbE@casper.infradead.org>
References: <20230120175556.3556978-1-dhowells@redhat.com>
 <Y862ZL5umO30Vu/D@casper.infradead.org>
 <20230123164218.qaqqg3ggbymtlwjx@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123164218.qaqqg3ggbymtlwjx@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 23, 2023 at 05:42:18PM +0100, Jan Kara wrote:
> On Mon 23-01-23 16:31:32, Matthew Wilcox wrote:
> > On Fri, Jan 20, 2023 at 05:55:48PM +0000, David Howells wrote:
> > >  (3) Make the bio struct carry a pair of flags to indicate the cleanup
> > >      mode.  BIO_NO_PAGE_REF is replaced with BIO_PAGE_REFFED (equivalent to
> > >      FOLL_GET) and BIO_PAGE_PINNED (equivalent to BIO_PAGE_PINNED) is
> > >      added.
> > 
> > I think there's a simpler solution than all of this.
> > 
> > As I understand the fundamental problem here, the question is
> > when to copy a page on fork.  We have the optimisation of COW, but
> > O_DIRECT/RDMA/... breaks it.  So all this page pinning is to indicate
> > to the fork code "You can't do COW to this page".
> > 
> > Why do we want to track that information on a per-page basis?  Wouldn't it
> > be easier to have a VM_NOCOW flag in vma->vm_flags?  Set it the first
> > time somebody does an O_DIRECT read or RDMA pin.  That's it.  Pages in
> > that VMA will now never be COWed, regardless of their refcount/mapcount.
> > And the whole "did we pin or get this page" problem goes away.  Along
> > with folio->pincount.
> 
> Well, but anon COW code is not the only (planned) consumer of the pincount.
> Filesystems also need to know whether a (shared pagecache) page is pinned
> and can thus be modified behind their backs. And for that VMA tracking
> isn't really an option.

Bleh, I'd forgotten about that problem.  We really do need to keep
track of which pages are under I/O for this case, because we need to
tell the filesystem that they are now available for writeback.

That said, I don't know that we need to keep track of it in the
pages themselves.  Can't we have something similar to rmap which
keeps track of a range of pinned pages, and have it taken care of
at a higher level (ie unpin the pages in the dio_iodone_t rather
than in the BIO completion handler)?

I'm not even sure why pinned pagecache pages remain on the LRU.
They should probably go onto the unevictable list with the mlocked
pages, then on unpin get marked dirty and placed on the active list.
There's no point in writing back a pinned page since it can be
written to at any instant without any part of the kernel knowing.

