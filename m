Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694C26AFEBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 07:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjCHGL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 01:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHGLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 01:11:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B1C9966E;
        Tue,  7 Mar 2023 22:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kFiWdSXsDRyUdkfb3HjCmx1t0YC4hjoPY9eR9uAa6+Q=; b=NvDaIkAj1wtFy37ee/EzZw1Iix
        deZ8dUCepTujFUFcOhuGL+TvdXdEhsYnbweuuMB4KvgcMnOIMHtQFjKIcJm2a2Js1gPfXiH1Q6cMq
        ima7B+Lu9Wm9ECTZqzfcbQvsvjPnHgnlRdLRVTJSg5nqxwGCUx4LmUDxaY0HrzBo8v0dKnORAWTCS
        3PiNhaoxQEZ+KqAvcc9CuUYGaijhhKUqJcAYiXADdm7F7E1O9FDHry3+HEy28XXidXYOGqe+hWqtv
        K4R+JtOHhKGbosbtnocNbhZEiecfBfjwfhtFTkWcD+U8iY/tN43+GBTzB63rtwjYqcSRyLtgxDqaz
        TUkzk/DA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZn1b-003fPd-Df; Wed, 08 Mar 2023 06:11:43 +0000
Date:   Tue, 7 Mar 2023 22:11:43 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAgnHzUYkpQB+Uzi@bombadil.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <f68905c5785b355b621847974d620fb59f021a41.camel@HansenPartnership.com>
 <ZAL0ifa66TfMinCh@casper.infradead.org>
 <2600732b9ed0ddabfda5831aff22fd7e4270e3be.camel@HansenPartnership.com>
 <ZAN0JkklyCRIXVo6@casper.infradead.org>
 <ZAQXduwAcAtIZHkB@bombadil.infradead.org>
 <ZAQicyYR0kZgrzIr@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAQicyYR0kZgrzIr@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 05, 2023 at 05:02:43AM +0000, Matthew Wilcox wrote:
> On Sat, Mar 04, 2023 at 08:15:50PM -0800, Luis Chamberlain wrote:
> > On Sat, Mar 04, 2023 at 04:39:02PM +0000, Matthew Wilcox wrote:
> > > XFS already works with arbitrary-order folios. 
> > 
> > But block sizes > PAGE_SIZE is work which is still not merged. It
> > *can* be with time. That would allow one to muck with larger block
> > sizes than 4k on x86-64 for instance. Without this, you can't play
> > ball.
> 
> Do you mean that XFS is checking that fs block size <= PAGE_SIZE and
> that check needs to be dropped?  If so, I don't see where that happens.

None of that. Back in 2018 Chinner had prototyped XFS support with
larger block size > PAGE_SIZE:

https://lwn.net/ml/linux-fsdevel/20181107063127.3902-1-david@fromorbit.com/

I just did a quick attempt to rebased it and most of the left over work
is actually on IOMAP for writeback and zero / writes requiring a new
zero-around functionality. All bugs on the rebase are my own, only compile
tested so far, and not happy with some of the changes I had to make so
likely could use tons more love:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230307-larger-bs-then-ps-xfs

But it should give you an idea of what type of things filesystems need to do.

And so, each fs would need to decide if they want to support this sort
of work. It is important from a support perspective, otherwise its hard
to procure > 4 PAGE_SIZE systems.

  Luis
