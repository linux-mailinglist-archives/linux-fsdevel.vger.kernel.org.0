Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7590E794137
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbjIFQKl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbjIFQKk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:10:40 -0400
Received: from out-220.mta0.migadu.com (out-220.mta0.migadu.com [91.218.175.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808291BCF;
        Wed,  6 Sep 2023 09:10:08 -0700 (PDT)
Date:   Wed, 6 Sep 2023 12:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694016606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1EALNeItIzFfx3mxa/QV2x2Sw2QpVyNa7EcoJAOGVM=;
        b=KIiyRKTMZngVdZODrrqFbK5sAmW4rt0Ea5oHDtkXH0BT+d/+oRQ6eiwGRW0123e1WfWXP5
        syXFLYiGnQFVdRdfZtIIlrlGsdJRxffXqD9Ft6HgTqgEmXRf4uJJa2KCY9BAIPOuFye+9D
        Z+Eoba8lTG2nHrvU/X2pbqt41jJUJNQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230906161002.2ztelmyzgy3pbmcd@moria.home.lan>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <ZPcsHyWOHGJid82J@infradead.org>
 <20230906000007.ry5rmk35vt57kppx@moria.home.lan>
 <ZPfKsp9/LVHbk4Px@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPfKsp9/LVHbk4Px@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 01:41:22AM +0100, Matthew Wilcox wrote:
> On Tue, Sep 05, 2023 at 08:00:07PM -0400, Kent Overstreet wrote:
> > On Tue, Sep 05, 2023 at 06:24:47AM -0700, Christoph Hellwig wrote:
> > > Hi Kent,
> > > 
> > > I thought you'd follow Christians proposal to actually work with
> > > people to try to use common APIs (i.e. to use iomap once it's been
> > > even more iter-like, for which I'm still waiting for suggestions),
> > > and make your new APIs used more widely if they are a good idea
> > > (which also requires explaining them better) and aim for 6.7 once
> > > that is done.
> > 
> > Christoph, I get that iomap is your pet project and you want to make it
> > better and see it more widely used.
> > 
> > But the reasons bcachefs doesn't use iomap have been discussed at
> > length, and I've posted and talked about the bcachefs equivalents of
> > that code. You were AWOL on those discussions; you consistently say
> > "bcachefs should use iomap" and then walk away, so those discussions
> > haven't moved forwards.
> > 
> > To recap, besides being more iterator like (passing data structures
> > around with iterators, vs. indirect function calls into the filesystem),
> > bcachefs also hangs a bit more state off the pagecache, due to being
> > multi device and also using the same data structure for tracking disk
> > reservations (because why make the buffered write paths look that up
> > separately?).
> 
> I /thought/ the proposal was to use iomap for bcachefs DIO and leave
> buffered writes for a different day.  I agree the iomap buffered write
> path is inappropriate for bcachefs today.  I'd like that to change,
> but there's a lot of functionality that it would need to support.

No, I'm not going to convert the bcachefs DIO path to iomap; not as it
exitss now.

Right now I've got a clean separation between the VFS level DIO code,
and the lower level bcachefs code that walks the extents btree and
issues IOs. I have to consider the iomap approach where the
loop-up-mappings-and-issue loop is in iomap code but calling into
filesystem code pretty gross.

I was talking about this /years/ ago when I did the work to make it
possible to efficiently split bios - iomap could have taken the approach
bcachefs did, the prereqs were in place when iomap was started, but it
didn't happen - iomap ended up being a more conservative approach, a
cleaned up version of buffer heads and fs/direct-IO.c.

That's fine, iomap is certainly an improvement over what it was
replacing, but it would not be an improvement for bcachefs.

I think it might be more fruitful to look at consolidating the buffered
IO code in bcachefs and iomap. The conceptual models are a bit closer,
bcachefs's buffered IO code is just a bit more fully-featured in that it
does the dirty block tracking in a unified way. That was a project that
turned out pretty nicely.
