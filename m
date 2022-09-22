Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7425E588A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 04:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiIVCXN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 22:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiIVCXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:23:11 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277F070E5B;
        Wed, 21 Sep 2022 19:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZiPBxKPeBhyg1ydjp9NE+T7YJ8ZxnXylq6Qe68BttcM=; b=X5nKHSb5zMgYZl+FhXsP6DCn72
        bEglB3uwj1u2ckoCMYriAyG5kPjUhImLESuKJd2vtNNiLCcrYBHeBdt3F6cQh6Wm3StOrkOcjQeJu
        4qrCsHH5WIU26q176+DcvQKvcrbj0BY9yaqWeThAwanr0qzriUoC+LqfYejfH/Fnsff8pbPPZ71Qb
        NjRsD6GZMQI/wiIBI5colWhci+DcZ9INZTqBN7Niz8E0f9Fh+HHg3qeHhqTiWGfHStzVjtBSLeI0K
        W8V4q7B54U3lalSJFlSdAHcj1YZ49zmVV2ju998nI+9rCL2JEeqKV0rTw/xbrhrKpjGLwJQMEI0p/
        suiYbjiA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1obBrU-002FEi-1w;
        Thu, 22 Sep 2022 02:22:48 +0000
Date:   Thu, 22 Sep 2022 03:22:48 +0100
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
Message-ID: <YyvG+Oih2A37Grcf@ZenIV>
References: <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915081625.6a72nza6yq4l5etp@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 10:16:25AM +0200, Jan Kara wrote:

> > How would that work?  What protects the area where you want to avoid running
> > into pinned pages from previously acceptable page getting pinned?  If "they
> > must have been successfully unmapped" is a part of what you are planning, we
> > really do have a problem...
> 
> But this is a very good question. So far the idea was that we lock the
> page, unmap (or writeprotect) the page, and then check pincount == 0 and
> that is a reliable method for making sure page data is stable (until we
> unlock the page & release other locks blocking page faults and writes). But
> once suddently ordinary page references can be used to create pins this
> does not work anymore. Hrm.
> 
> Just brainstorming ideas now: So we'd either need to obtain the pins early
> when we still have the virtual address (but I guess that is often not
> practical but should work e.g. for normal direct IO path) or we need some
> way to "simulate" the page fault when pinning the page, just don't map it
> into page tables in the end. This simulated page fault could be perhaps
> avoided if rmap walk shows that the page is already mapped somewhere with
> suitable permissions.

OK.  As far as I can see, the rules are along the lines of
	* creator of ITER_BVEC/ITER_XARRAY is responsible for pages being safe.
	  That includes
		* page known to be locked by caller
		* page being privately allocated and not visible to anyone else
		* iterator being data source
		* page coming from pin_user_pages(), possibly as the result of
		  iov_iter_pin_pages() on ITER_IOVEC/ITER_UBUF.
	* ITER_PIPE pages are always safe
	* pages found in ITER_BVEC/ITER_XARRAY are safe, since the iterator
	  had been created with such.
My preference would be to have iov_iter_get_pages() and friends pin if and
only if we have data-destination iov_iter that is user-backed.  For
data-source user-backed we only need FOLL_GET, and for all other flavours
(ITER_BVEC, etc.) we only do get_page(), if we need to grab any references
at all.

What I'd like to have is the understanding of the places where we drop
the references acquired by iov_iter_get_pages().  How do we decide
whether to unpin?  E.g. pipe_buffer carries a reference to page and no
way to tell whether it's a pinned one; results of iov_iter_get_pages()
on ITER_IOVEC *can* end up there, but thankfully only from data-source
(== WRITE, aka.  ITER_SOURCE) iov_iter.  So for those we don't care.
Then there's nfs_request; AFAICS, we do need to pin the references in
those if they are coming from nfs_direct_read_schedule_iovec(), but
not if they come from readpage_async_filler().  How do we deal with
coalescence, etc.?  It's been a long time since I really looked at
that code...  Christoph, could you give any comments on that one?

Note, BTW, that nfs_request coming from readpage_async_filler() have
pages locked by caller; the ones from nfs_direct_read_schedule_iovec()
do not, and that's where we want them pinned.  Resulting page references
end up (after quite a trip through data structures) stuffed into struct
rpc_rqst ->rc_recv_buf.pages[] and when a response arrives from server,
they get picked by xs_read_bvec() and fed to iov_iter_bvec().  In one
case it's safe since the pages are locked; in another - since they would
come from pin_user_pages().  The call chain at the time they are used
has nothing to do with the originator - sunrpc is looking at the arrived
response to READ that matches an rpc_rqst that had been created by sender
of that request and safety is the sender's responsibility.
