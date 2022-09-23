Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEC65E760F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIWIos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 04:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIWIoq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:44:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA65347B87;
        Fri, 23 Sep 2022 01:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nNv86JWq7K4SrXi9kThW3IL/MbxUCnwp29q6ItT7Jcw=; b=mZ8CmQuWblk1MMVUpDuLR6qc2s
        66kAf6IwGc9rz0v2QxusGWOBx/z7JWCpwJXwtQQfoZl02tWSFIeMLPbv6Y8FLFUcMX5RNQyuMyjNm
        2MGSOlBfZUOF3LiHToMr2YMxtlRl+e7cmeIS9x7sZKYj9mQbVlaIHExj1LBNB8vuyeJOWksc5BLvN
        nPucVivNwS7UH0z21KZ4o09dDV43l7Y1TIlsWlLIFZqIkl+lF4tXhcr6mMihC0eK0a4ng9TjYi2fy
        Re5oLmrnTKJy1TB7kLdq4LFaKHsUAY6WZuzCKzI5722zzZ/Qq6ez4BCJv73S/3i7ZgPbsi1+l4f4v
        /WaWCnfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obeIT-00327F-D2; Fri, 23 Sep 2022 08:44:33 +0000
Date:   Fri, 23 Sep 2022 01:44:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
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
Message-ID: <Yy1x8QE9YA4HHzbQ@infradead.org>
References: <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyvG+Oih2A37Grcf@ZenIV>
 <YyxzYTlyGhbb2MOu@infradead.org>
 <Yy00eSjyxvUIp7D5@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy00eSjyxvUIp7D5@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 05:22:17AM +0100, Al Viro wrote:
> > Add a iov_iter_unpin_pages that does the right thing based on the
> > type.  (block will need a modified copy of it as it doesn't keep
> > the pages array around, but logic will be the same).
> 
> Huh?  You want to keep the type (+ direction) of iov_iter in any structure
> a page reference coming from iov_iter_get_pages might end up in?  IDGI...

Why would I?  We generall do have or should have the iov_iter around.
And for the common case where we don't (bios) we can carry that
information in the bio as it needs a special unmap helper anyway.

But if you don't want to use the iov_iter for some reason, we'll just
need to condense the information to a flags variable and then pass that.

> 
> BTW, speaking of lifetime rules - am I right assuming that fd_execute_rw()
> does IO on pages of the scatterlist passed to it?

Yes.

> Where are they getting
> dropped and what guarantees that IO is complete by that point?

The exact place depens on the exact taaraget frontend of which we have
a few.  But it happens from the end_io callback that is triggered
through a call to target_complete_cmd.

> The reason I'm asking is that here you have an ITER_BVEC possibly fed to
> __blkdev_direct_IO_async(), with its
>         if (iov_iter_is_bvec(iter)) {
>                 /*
>                  * Users don't rely on the iterator being in any particular
>                  * state for async I/O returning -EIOCBQUEUED, hence we can
>                  * avoid expensive iov_iter_advance(). Bypass
>                  * bio_iov_iter_get_pages() and set the bvec directly.
>                  */
>                 bio_iov_bvec_set(bio, iter);
> which does *not* grab the page referneces.  Sure, bio_release_pages() knows
> to leave those alone and doesn't drop anything.  However, what is the
> mechanism preventing the pages getting freed before the IO completion
> in this case?

The contract that callers of bvec iters need to hold their own
references as without that doing I/O do them would be unsafe.  It they
did not hold references the pages could go away before even calling
bio_iov_iter_get_pages (or this open coded bio_iov_bvec_set).
