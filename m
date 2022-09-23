Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5833E5E72D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 06:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiIWEWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 00:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIWEWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:22:34 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741B711D60C;
        Thu, 22 Sep 2022 21:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+/f7rQqEMYVFzSTEHMH7lncMBYm3L3Qg9syncr2dQT4=; b=jSbZR1B9zaw3IUb4LnQOM9P7W9
        LWABTG8h+HtJQW6NV9vx5y/twluuZRVUmrCCh7vfod5xUnH84BVWs3C53GmfJdKih08M3KET39+OV
        /DiwEDkwJYzJ9OFj5CRG/i10mcWEy2Dsxq5VdNfJas7JLzHoMtlNNj5Z7Bn0xYwAypvZmx1V6kU9/
        TYTUGLCLztQVdWXDEkeoLoB/T7psEB/BVae2Ro8rnO1vWb+4MO3iEITxpiFWCwjJGZNYhJpiYo6Dg
        71aOuNRb/D4sTZm3Odz8kSPVcikla0nUG3tCH7dRS5kfySFrrRtCGJ8TvsiqtlJKtx/CiIo4RWlI4
        P6BRgcFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1obaCf-002fhY-2m;
        Fri, 23 Sep 2022 04:22:17 +0000
Date:   Fri, 23 Sep 2022 05:22:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <Yy00eSjyxvUIp7D5@ZenIV>
References: <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyvG+Oih2A37Grcf@ZenIV>
 <YyxzYTlyGhbb2MOu@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyxzYTlyGhbb2MOu@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 22, 2022 at 07:38:25AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 22, 2022 at 03:22:48AM +0100, Al Viro wrote:
> > What I'd like to have is the understanding of the places where we drop
> > the references acquired by iov_iter_get_pages().  How do we decide
> > whether to unpin?
> 
> Add a iov_iter_unpin_pages that does the right thing based on the
> type.  (block will need a modified copy of it as it doesn't keep
> the pages array around, but logic will be the same).

Huh?  You want to keep the type (+ direction) of iov_iter in any structure
a page reference coming from iov_iter_get_pages might end up in?  IDGI...

BTW, speaking of lifetime rules - am I right assuming that fd_execute_rw()
does IO on pages of the scatterlist passed to it?  Where are they getting
dropped and what guarantees that IO is complete by that point?

The reason I'm asking is that here you have an ITER_BVEC possibly fed to
__blkdev_direct_IO_async(), with its
        if (iov_iter_is_bvec(iter)) {
                /*
                 * Users don't rely on the iterator being in any particular
                 * state for async I/O returning -EIOCBQUEUED, hence we can
                 * avoid expensive iov_iter_advance(). Bypass
                 * bio_iov_iter_get_pages() and set the bvec directly.
                 */
                bio_iov_bvec_set(bio, iter);
which does *not* grab the page referneces.  Sure, bio_release_pages() knows
to leave those alone and doesn't drop anything.  However, what is the
mechanism preventing the pages getting freed before the IO completion
in this case?
