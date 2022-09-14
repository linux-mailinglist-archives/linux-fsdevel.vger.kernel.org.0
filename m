Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453D35B7FC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 05:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiINDvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 23:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiINDvl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:51:41 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430606F26F;
        Tue, 13 Sep 2022 20:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TsvPRmshdxnvSY7tVAecRy6+/ce+5hAWcS0J6w4JVyE=; b=utEF1SOCThG3gcFxitxIjq3WGs
        IHfq+Z1KW6tA+eL0Sb+cwipStWaYLjhRhDVZ8GZwNeZmjvBd05BRjtyauZaHH7ZZsrmJ5jQ9m7NYH
        t5YnppvGuDY68g9HYjVC2w5Z2W2ZRP72TY/rLYf5gK5zcB6xl2TQzc8waMQW+L4/KmLbLr+tX1SHf
        wva/bWAZqkuKFcKia9aZdCn5gJ0/PD4X1KzRVwCHXE2T9wrl7lomyCDzaAAQRhl9Ob3eHi4ibY6gS
        2A/E8y+stzUFsaCfnKU1fUsoMPrEmJ9V+q/Xc7gYpbpZ/qBuLSMLG/JKoH2axtiXJ3qbsfdU1SaT+
        ODK9JccA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oYJQj-00G2aP-2o;
        Wed, 14 Sep 2022 03:51:17 +0000
Date:   Wed, 14 Sep 2022 04:51:17 +0100
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
Message-ID: <YyFPtTtxYozCuXvu@ZenIV>
References: <20220831041843.973026-1-jhubbard@nvidia.com>
 <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxhaJktqtHw3QTSG@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 07, 2022 at 01:45:26AM -0700, Christoph Hellwig wrote:
> On Tue, Sep 06, 2022 at 12:21:06PM +0200, Jan Kara wrote:
> > > For FOLL_PIN callers, never pin bvec and kvec pages:  For file systems
> > > not acquiring a reference is obviously safe, and the other callers will
> > > need an audit, but I can't think of why it woul  ever be unsafe.
> > 
> > Are you sure about "For file systems not acquiring a reference is obviously
> > safe"? I can see places e.g. in orangefs, afs, etc. which create bvec iters
> > from pagecache pages. And then we have iter_file_splice_write() which
> > creates bvec from pipe pages (which can also be pagecache pages if
> > vmsplice() is used). So perhaps there are no lifetime issues even without
> > acquiring a reference (but looking at the code I would not say it is
> > obvious) but I definitely don't see how it would be safe to not get a pin
> > to signal to filesystem backing the pagecache page that there is DMA
> > happening to/from the page.
> 
> I mean in the context of iov_iter_get_pages callers, that is direct
> I/O.  Direct callers of iov_iter_bvec which then pass that iov to
> ->read_iter / ->write_iter will need to hold references (those are
> the references that the callers of iov_iter_get_pages rely on!).

Unless I'm misreading Jan, the question is whether they should get or
pin.  AFAICS, anyone who passes the sucker to ->read_iter() (or ->recvmsg(),
or does direct copy_to_iter()/zero_iter(), etc.) is falling under
=================================================================================
CASE 5: Pinning in order to write to the data within the page
-------------------------------------------------------------
Even though neither DMA nor Direct IO is involved, just a simple case of "pin,
write to a page's data, unpin" can cause a problem. Case 5 may be considered a
superset of Case 1, plus Case 2, plus anything that invokes that pattern. In
other words, if the code is neither Case 1 nor Case 2, it may still require
FOLL_PIN, for patterns like this:

Correct (uses FOLL_PIN calls):
    pin_user_pages()
    write to the data within the pages
    unpin_user_pages()

INCORRECT (uses FOLL_GET calls):
    get_user_pages()
    write to the data within the pages
    put_page()
=================================================================================

Regarding iter_file_splice_write() case, do we need to pin pages
when we are not going to modify the data in those?

The same goes for afs, AFAICS; I started to type "... and everything that passes
WRITE to iov_iter_bvec()", but...
drivers/vhost/vringh.c:1165:            iov_iter_bvec(&iter, READ, iov, ret, translated);
drivers/vhost/vringh.c:1198:            iov_iter_bvec(&iter, WRITE, iov, ret, translated);
is backwards - READ is for data destinations, comes with copy_to_iter(); WRITE is
for data sources and it comes with copy_from_iter()...
I'm really tempted to slap
	if (WARN_ON(i->data_source))
		return 0;
into copy_to_iter() et.al., along with its opposite for copy_from_iter().
And see who comes screaming...  Things like
        if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
                WARN_ON(1);
                return 0;
        }
in e.g. csum_and_copy_from_iter() would be replaced by that, and become
easier to understand...
These two are also getting it wrong, BTW:
drivers/target/target_core_file.c:340:  iov_iter_bvec(&iter, READ, bvec, sgl_nents, len);
drivers/target/target_core_file.c:476:  iov_iter_bvec(&iter, READ, bvec, nolb, len);

