Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C856AAE3F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 06:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjCEFDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Mar 2023 00:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEFDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Mar 2023 00:03:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99537213A;
        Sat,  4 Mar 2023 21:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MYWBC0WOMIDYRhY6uikE3pHTCOX53fIXE4SZZXI8vwI=; b=sBPaYm/n2Dc6Etsx9Ww560hGO4
        OWlFc1zCTcv8loJ8ST34qAl6MLaEJYurxh1yXvL9Jn6M5sYIcu/BDjmWOQM8k0CRNtFdWzhfITW+S
        m9YkL7yDZcajdzBZ5br+HDk43PM0+d6naiQU6/qSOz0klu4bXO/VWI779iB9PsmfZkax0iw1B8kR5
        ZX7vuT8+BXm1cIVyOXWFYtpKSxwyWjx6zf8GKQYVkkNRZnDbyRQn+ZfxnRw2rFBqcIGu0tg/hB2PW
        wHO4pDInBlylBEyRG4Gsoby04Iq43ZP5ctGumc4bwT+Zg7MYG/u2oIGrVraGMn/4AttFWJYBXrcWR
        TMX3YJCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYgWB-004FVh-Ee; Sun, 05 Mar 2023 05:02:43 +0000
Date:   Sun, 5 Mar 2023 05:02:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAQicyYR0kZgrzIr@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <f68905c5785b355b621847974d620fb59f021a41.camel@HansenPartnership.com>
 <ZAL0ifa66TfMinCh@casper.infradead.org>
 <2600732b9ed0ddabfda5831aff22fd7e4270e3be.camel@HansenPartnership.com>
 <ZAN0JkklyCRIXVo6@casper.infradead.org>
 <ZAQXduwAcAtIZHkB@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAQXduwAcAtIZHkB@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 04, 2023 at 08:15:50PM -0800, Luis Chamberlain wrote:
> On Sat, Mar 04, 2023 at 04:39:02PM +0000, Matthew Wilcox wrote:
> > I'm getting more and more
> > comfortable with the idea that "Linux doesn't support block sizes >
> > PAGE_SIZE on 32-bit machines" is an acceptable answer.
> 
> First of all filesystems would need to add support for a larger block
> sizes > PAGE_SIZE, and that takes effort. It is also a support question
> too.
> 
> I think garnering consensus from filesystem developers we don't want
> to support block sizes > PAGE_SIZE on 32-bit systems would be a good
> thing to review at LSFMM or even on this list. I hightly doubt anyone
> is interested in that support.

Agreed.

> > XFS already works with arbitrary-order folios. 
> 
> But block sizes > PAGE_SIZE is work which is still not merged. It
> *can* be with time. That would allow one to muck with larger block
> sizes than 4k on x86-64 for instance. Without this, you can't play
> ball.

Do you mean that XFS is checking that fs block size <= PAGE_SIZE and
that check needs to be dropped?  If so, I don't see where that happens.

Or do you mean that the blockdev "filesystem" needs to be enhanced to
support large folios?  That's going to be kind of a pain because it
uses buffer_heads.  And ext4 depends on it using buffer_heads.  So,
yup, more work needed than I remembered (but as I said, it's FS side,
not block layer or driver work).

Or were you referring to the NVMe PAGE_SIZE sanity check that Keith
mentioned upthread?

> > The only needed piece is
> > specifying to the VFS that there's a minimum order for this particular
> > inode, and having the VFS honour that everywhere.
> 
> Other than the above too, don't we still also need to figure out what
> fs APIs would incur larger order folios? And then what about corner cases
> with the page cache?
> 
> I was hoping some of these nooks and crannies could be explored with tmpfs.

I think we're exploring all those with XFS.  Or at least, many of
them.  A lot of the folio conversion patches you see flowing past
are pure efficiency gains -- no need to convert between pages and
folios implicitly; do the explicit conversions and save instructions.
Most of the correctness issues were found & fixed a long time ago when
PMD support was added to tmpfs.  One notable exception would be the
writeback path since tmpfs doesn't writeback, it has that special thing
it does with swap.

tmpfs is a rather special case as far as its use of the filesystem APIs
go, but I suspect I've done most of the needed work to have it work with
arbitrary order folios instead of just PTE and PMD sizes.  There's
probably some left-over assumptions that I didn't find yet.  Maybe in
the swap path, for example ;-)
