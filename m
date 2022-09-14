Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E425B8D4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiINQnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 12:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiINQnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:43:03 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF956E8B5;
        Wed, 14 Sep 2022 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=drGd84Y88D87DtABnnd7yh6bhIO3nFxVGZfiNKSay/w=; b=NJ6SAfFns58rMbVH+azyEAlIBe
        P6n1bn9OXiF4fmUEUpqXGV/bE106qYmZbX/MwFVbHxtW6ssgk2PCE8UfNTQg1aWm+yynxcJ9j7g08
        8/tgQ5onCzhF8MKSQaEQ6zA3aarCv+3D7yqjX8P1okh4bYNOq1WFHE1a4IQDf5KHdx5u5zA+Wymlc
        S+7i9ko/VpxQnZRAsQ62an08GtRr8DVSaNW3j49A/qLEWP1M+neWYX1OVsjvTIT7LfH477m66cmRa
        Nyt7CbCvmVkXs5Lmdv1xX0vhwGMMyYK/hJL+vP9XhDhzkKBGXkATkAHo1w7IXkb8b+clGQVzjQxRV
        f5T3UCDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oYVTE-00GF4L-1R;
        Wed, 14 Sep 2022 16:42:40 +0000
Date:   Wed, 14 Sep 2022 17:42:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <YyIEgD8ksSZTsUdJ@ZenIV>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914145233.cyeljaku4egeu4x2@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 14, 2022 at 04:52:33PM +0200, Jan Kara wrote:
> > =================================================================================
> > CASE 5: Pinning in order to write to the data within the page
> > -------------------------------------------------------------
> > Even though neither DMA nor Direct IO is involved, just a simple case of "pin,
> > write to a page's data, unpin" can cause a problem. Case 5 may be considered a
> > superset of Case 1, plus Case 2, plus anything that invokes that pattern. In
> > other words, if the code is neither Case 1 nor Case 2, it may still require
> > FOLL_PIN, for patterns like this:
> > 
> > Correct (uses FOLL_PIN calls):
> >     pin_user_pages()
> >     write to the data within the pages
> >     unpin_user_pages()
> > 
> > INCORRECT (uses FOLL_GET calls):
> >     get_user_pages()
> >     write to the data within the pages
> >     put_page()
> > =================================================================================
> 
> Yes, that was my point.

The thing is, at which point do we pin those pages?  pin_user_pages() works by
userland address; by the time we get to any of those we have struct page
references and no idea whether they are still mapped anywhere.

How would that work?  What protects the area where you want to avoid running
into pinned pages from previously acceptable page getting pinned?  If "they
must have been successfully unmapped" is a part of what you are planning, we
really do have a problem...
