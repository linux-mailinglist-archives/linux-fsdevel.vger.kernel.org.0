Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA7E7932F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 02:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbjIFAld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 20:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjIFAlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:41:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D599E;
        Tue,  5 Sep 2023 17:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E7pBRBhK3Jt0eDT1MWkzf/iGRarf5P4om5PK0eit8tA=; b=v/SxE1mymw+1Ba9X0SsuWFk/rh
        2PWTEigtMD5GHa7tGO4uIuEEwacTpFK6EHtBFtm12bCOEJoC+H4FMyRdZTrNA96QxjQ+bugm9w6h5
        Ve5UbKhE5TceQYcHN2cUi4JAgXs3gEAp2a+uItmHRxVAAyVE9WMk8dsWRbEsKnj4ExKeYFwER8K7z
        qeBext4m+1sw1osqtEsNkNlSRgU/7aScaXvUwT8WbodHAFcioN2GGV7pBABmsbh2km9tZP9ipBuSC
        2UQQ9BhwnXpZp1bsgfBblVVZ+Kx6Cfi1J9GGn4a0RD7npBMsvSn4Nwl6Dzlyt46b9mCqz+ezyP8Ol
        vwvOyqBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdgbi-00F1eQ-8L; Wed, 06 Sep 2023 00:41:22 +0000
Date:   Wed, 6 Sep 2023 01:41:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZPfKsp9/LVHbk4Px@casper.infradead.org>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <ZPcsHyWOHGJid82J@infradead.org>
 <20230906000007.ry5rmk35vt57kppx@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906000007.ry5rmk35vt57kppx@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:00:07PM -0400, Kent Overstreet wrote:
> On Tue, Sep 05, 2023 at 06:24:47AM -0700, Christoph Hellwig wrote:
> > Hi Kent,
> > 
> > I thought you'd follow Christians proposal to actually work with
> > people to try to use common APIs (i.e. to use iomap once it's been
> > even more iter-like, for which I'm still waiting for suggestions),
> > and make your new APIs used more widely if they are a good idea
> > (which also requires explaining them better) and aim for 6.7 once
> > that is done.
> 
> Christoph, I get that iomap is your pet project and you want to make it
> better and see it more widely used.
> 
> But the reasons bcachefs doesn't use iomap have been discussed at
> length, and I've posted and talked about the bcachefs equivalents of
> that code. You were AWOL on those discussions; you consistently say
> "bcachefs should use iomap" and then walk away, so those discussions
> haven't moved forwards.
> 
> To recap, besides being more iterator like (passing data structures
> around with iterators, vs. indirect function calls into the filesystem),
> bcachefs also hangs a bit more state off the pagecache, due to being
> multi device and also using the same data structure for tracking disk
> reservations (because why make the buffered write paths look that up
> separately?).

I /thought/ the proposal was to use iomap for bcachefs DIO and leave
buffered writes for a different day.  I agree the iomap buffered write
path is inappropriate for bcachefs today.  I'd like that to change,
but there's a lot of functionality that it would need to support.

I don't see the point in keeping bcachefs out of tree for another cycle.
Yes, more use of iomap would be great, but I don't think that it being
in-tree is going to hinder anything.  It's not like it uses bufferheads.
