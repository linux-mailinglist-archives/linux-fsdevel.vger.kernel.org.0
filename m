Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E26F3F40AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Aug 2021 19:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhHVRVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Aug 2021 13:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhHVRVE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Aug 2021 13:21:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C85F6124B;
        Sun, 22 Aug 2021 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629652823;
        bh=953HepCQhlZjrVqmaZ9RVa/BsY9OJ/Z54dvDmcsyMdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNKbOArThMZ52ow17srczakH4jFCRqJB11K6RF1SNaH4wSlQne0oknRKS3jNOYVmb
         ft4Gw2dThpuc09NO5Iw50MUJT+9AVXisYy3a/FQWzi5xT/vaFFOgm7z5h4UN0zHi0b
         CuCcweB6A7QYk8ge6+EJDUy2eYyDs2yj1AX8EM4dgDx5U8azjrOv/MWjTqM2ZHM/jg
         Saodg9ucd4W/HUwrUYOGb+mMoF7/hf7cf2G9K8Cxr/xo7XxgTLmZYE8gAgdeAGWM0I
         1B0u25WNzGCn4Xel4Qv81IJeobfPW3xwEfzb8Ln5QIBzAtMZctmklVff9Pu+Z56d9o
         LUS+uZpxj/b6g==
Date:   Sun, 22 Aug 2021 10:20:23 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] iomap: standardize tracepoint formatting and storage
Message-ID: <20210822172023.GZ12640@magnolia>
References: <20210822023223.GY12640@magnolia>
 <YSHE0MwgIugfkAzf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSHE0MwgIugfkAzf@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 22, 2021 at 04:30:24AM +0100, Matthew Wilcox wrote:
> On Sat, Aug 21, 2021 at 07:32:23PM -0700, Darrick J. Wong wrote:
> > @@ -58,8 +58,7 @@ DECLARE_EVENT_CLASS(iomap_range_class,
> >  		__entry->offset = off;
> >  		__entry->length = len;
> >  	),
> > -	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset %lx "
> > -		  "length %x",
> > +	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset 0x%llx length 0x%llx",
> 
> %#llx is one character shorter than 0x%llx ;-)

...and since you declined to add even a conditional review tag, this
patch will now sit in limbo for 2-3 days while I agonize over whether 1)
I should send a v2 patch with this minor stylistic thing changed and
hope that nobody objects to the v2, or worse, tells me I should go back
to v1; 2) hope that someone else won't be as picky and send a review; 3)
prepare myself for the inevitable DM that's coming about how I'm too
soft on reviewers; 4) wait the other inevitable DM about how I really
could exercise maintainer's prerogative to ignore the trivial style
complaints; and 5) brace for the other inevitable DM about how I really
shouldn't abandon the review process to ram code into the kernel just
because of stylistic complaints.

Yeah, I'm not going to abandon the established public process.
Requiring RVB even for maintainer patches is a useful check against
maintainers committing garbage to the repo.

But.  All five of these things keep happening every kernel cycle, and
it's dragging down my mental health.  To say nothing of the worldwide
disease, political unrest, and hostile weather.

**This** is the reason why I want to quit and never come back.

I enjoy every part of the process from requirements to implementation.
I enjoy discussing the design of algorithms, and I find it satisfying
even to rip things out to try other suggestions.

I don't enjoy revving patchsets repeatedly to try to find the magic
combination of printf formatting strings, comment massage, and helper
function placement golf that will get every patch through review.  This
is why I'm constantly stressed out about not being able to keep up with
all the demands being placed on me.  Experts' time should be spent on
solving tough problems, debugging the really nasty bugs, and coaching
less familiar people as they get up to speed.  Not this.

So I'm putting everyone on notice: If you care about stylistic problems
(and while I'm on my soapbox: cleaning up other parts of the codebase
that a patch touches only briefly) so strongly, then change my patch and
send it back to me.  Or change the snippets you want in the reply, and
state that you ack/review the patch on condition that the snippets are
applied.

Once I'm done with 5.15 merge patches, I would like to have a broader
discussion about xfs/iomap review policies, and have requested a session
at LPC for this purpose.

(And in case it wasn't clear: If you think a piece of code is so poorly
fitted to a problem that you want me to go back to the drawing board, I
am still completely happy to do that.)

--D
