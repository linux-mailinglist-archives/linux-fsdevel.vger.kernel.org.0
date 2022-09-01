Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564DC5A89DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 02:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiIAAin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 20:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiIAAil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:38:41 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DDAFE057;
        Wed, 31 Aug 2022 17:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pAUCRheD7HEjVi/ypvCmDmDlGNpLzHPc+8Ry1BLGL5Y=; b=Kkt/ouct9XIMw6tkOmsU6S4gh0
        m0aJRIol5LWmRPlMQj6EEcUbBd6CL+yJgxrzADT1Wf4exlM1w2B2Y+elhLK/xDSiNb5IXf9nRPHgD
        QjwWzunxbAmTwk68UOmqRMuAV2798RKPDIsqzqeinPmWVr0BEr8hXs4WNMYw9ptH/PlsoIgQ2VtRa
        QfsfNpmxbm5W0JGnHVtKlwXEKt33ktMGCPx2QvIKidb3ZAUk4/ImLf5Z3IP3dx7GZWeM1jAx2DZ88
        vGTWM4OPiRSVC5Pkow1cvRVGFwb/9rxFEgEAcWniGihBMrZSR6pHMtXNYHrf9fmx7BSpC/ZX1TGME
        nUdUtbPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oTYDt-00AnMP-NE;
        Thu, 01 Sep 2022 00:38:21 +0000
Date:   Thu, 1 Sep 2022 01:38:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] NFS: direct-io: convert to FOLL_PIN pages
Message-ID: <Yw/+/U9GFaNnARdk@ZenIV>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-6-jhubbard@nvidia.com>
 <YwqfWoAE2Awp4YvT@ZenIV>
 <353f18ac-0792-2cb7-6675-868d0bd41d3d@nvidia.com>
 <Ywq5ILRNxsbWvFQe@ZenIV>
 <Ywq5VrSrY341UVpL@ZenIV>
 <217b4a17-1355-06c5-291e-7980c0d3cea6@nvidia.com>
 <20220829160808.rwkkiuelipr3huxk@quack3>
 <a53b2d14-687a-16c9-2f63-4f94876f8b3c@nvidia.com>
 <20220831094349.boln4jjajkdtykx3@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831094349.boln4jjajkdtykx3@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:43:49AM +0200, Jan Kara wrote:

> So after looking into that a bit more, I think a clean approach would be to
> provide iov_iter_pin_pages2() and iov_iter_pages_alloc2(), under the hood
> in __iov_iter_get_pages_alloc() make sure we use pin_user_page() instead of
> get_page() in all the cases (using this in pipe_get_pages() and
> iter_xarray_get_pages() is easy) and then make all bio handling use the
> pinning variants for iters. I think at least iov_iter_is_pipe() case needs
> to be handled as well because as I wrote above, pipe pages can enter direct
> IO code e.g. for splice(2).
> 
> Also I think that all iov_iter_get_pages2() (or the _alloc2 variant) users
> actually do want the "pin page" semantics in the end (they are accessing
> page contents) so eventually we should convert them all to
> iov_iter_pin_pages2() and remove iov_iter_get_pages2() altogether. But this
> will take some more conversion work with networking etc. so I'd start with
> converting bios only.

Not sure, TBH...

FWIW, quite a few of the callers of iov_iter_get_pages2() do *NOT* need to
grab any references for BVEC/XARRAY/PIPE cases.  What's more, it would be
bloody useful to have a variant that doesn't grab references for
!iter->user_backed case - that could be usable for KVEC as well, simplifying
several callers.

Requirements:
	* recepients of those struct page * should have a way to make
dropping the page refs conditional (obviously); bio machinery can be told
to do so.
	* callers should *NOT* do something like
	"set an ITER_BVEC iter, with page references grabbed and stashed in
bio_vec array, call async read_iter() and drop the references in array - the
refs we grab in dio will serve"
Note that for sync IO that pattern is fine whether we grab/drop anything
inside read_iter(); for async we could take depopulating the bio_vec
array to the IO completion or downstream of that.
	* the code dealing with the references returned by iov_iter_..._pages
should *NOT* play silly buggers with refcounts - something like "I'll grab
a reference, start DMA and report success; page will stay around until I
get around to dropping the ref and callers don't need to wait for that" deep
in the bowels of infinibad stack (or something equally tasteful) is seriously
asking for trouble.

Future plans from the last cycle included iov_iter_find_pages{,_alloc}() that
would *not* grab references on anything other than IOVEC and UBUF (would advance
the iterator, same as iov_iter_get_pages2(), though). Then iov_iter_get_...()
would become a wrapper for that.  After that - look into switching the users
of ..._get_... to ..._find_....   Hadn't done much in that direction yet,
though - need to redo the analysis first.

That primitive might very well do FOLL_PIN instead of FOLL_GET for IOVEC and
UBUF...
