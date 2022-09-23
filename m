Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FDA5E7261
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 05:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiIWDUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 23:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIWDUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 23:20:13 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30584814D1;
        Thu, 22 Sep 2022 20:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q+FM57iduMogJtSFwZB4LfTdEsChuEHae2/DVlkArcM=; b=sk/KR0xPUKPHHKWolvPzsqAt4o
        o9FlyBUe1wX2zq2RbXWaAJTiFJqpuaVPHn1hI4kFCMLxmK2i4rRcZyBQ7i8qSoGeGHFgdH3ZJ0UN5
        dLNBxE5Tu66mnNUVk9JDrYHLUSZ5tR8FUBrd6EieY3EtTeOzsSdqmQkk2T5jFMG+0yVorDIOTv6BI
        x2e9UgKUZKYh/UhIHRV8YFxRZVu+ZhV9ughRdGArDVjBkXAu9QUFk9H7Msq1b4dF/F8zWJ6sfxbPX
        1KW1gnVTo+E89ZNUi1kmPsIS+V0iIkxK6dzo7GQGwpv2V3hXCjpWSwrQMvlVc1ZMa41+fwRncsoTL
        6/jkjISg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1obZE6-002eVa-0R;
        Fri, 23 Sep 2022 03:19:42 +0000
Date:   Fri, 23 Sep 2022 04:19:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <Yy0lztxfwfGXFme4@ZenIV>
References: <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyvG+Oih2A37Grcf@ZenIV>
 <a6f95605-c2d5-6ec5-b85c-d1f3f8664646@nvidia.com>
 <20220922112935.pep45vfqfw5766gq@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922112935.pep45vfqfw5766gq@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 01:29:35PM +0200, Jan Kara wrote:

> > This rule would mostly work, as long as we can relax it in some cases, to
> > allow pinning of both source and dest pages, instead of just destination
> > pages, in some cases. In particular, bio_release_pages() has lost all
> > context about whether it was a read or a write request, as far as I can
> > tell. And bio_release_pages() is the primary place to unpin pages for
> > direct IO.
> 
> Well, we already do have BIO_NO_PAGE_REF bio flag that gets checked in
> bio_release_pages(). I think we can easily spare another bio flag to tell
> whether we need to unpin or not. So as long as all the pages in the created
> bio need the same treatment, the situation should be simple.

Yes.  Incidentally, the same condition is already checked by the creators
of those bio - see the assorted should_dirty logics.

While we are at it - how much of the rationale around bio_check_pages_dirty()
doing dirtying is still applicable with pinning pages before we stick them
into bio?  We do dirty them before submitting bio, then on completion
bio_check_pages_dirty() checks if something has marked them clean while
we'd been doing IO; if all of them are still dirty we just drop the pages
(well, unpin and drop), otherwise we arrange for dirty + unpin + drop
done in process context (via schedule_work()).  Can they be marked clean by
anyone while they are pinned?  After all, pinning is done to prevent
writeback getting done on them while we are modifying the suckers...
