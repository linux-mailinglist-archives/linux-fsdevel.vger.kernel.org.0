Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DDA741C9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 01:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjF1Xu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 19:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjF1Xu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:50:27 -0400
Received: from out-40.mta0.migadu.com (out-40.mta0.migadu.com [IPv6:2001:41d0:1004:224b::28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C31183
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 16:50:25 -0700 (PDT)
Date:   Wed, 28 Jun 2023 19:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687996221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QYqVEAA9OEPYN6MmQsZpr/+iIRJqLTbm33DiQIkPrP4=;
        b=wln8/z/hUYd0U1TJSregv80KC19E7kXjHsLWHmjjzP8FtaFm67909l/sjNoWokzUT8oocy
        1+95cZXTSNaSaiN3oAiqz54JPHKO1YcxDe7tPA+/dGUgbFdC65H8rzF51vl4n+CAtfqPpO
        RIIfKswBYt9TRnkKabEqOqS5SyCrUio=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230628235018.ttvtzpfe42fri4yq@moria.home.lan>
References: <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
 <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
 <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
 <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
 <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
 <d697ec27-8008-2eb6-0950-f612a602dcf5@kernel.dk>
 <20230628225514.n3xtlgmjkgapgnrd@moria.home.lan>
 <1e2134f1-f48b-1459-a38e-eac9597cd64a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e2134f1-f48b-1459-a38e-eac9597cd64a@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:14:09PM -0600, Jens Axboe wrote:
> On 6/28/23 4:55?PM, Kent Overstreet wrote:
> >> But it's not aio (or io_uring or whatever), it's simply the fact that
> >> doing an fput() from an exiting task (for example) will end up being
> >> done async. And hence waiting for task exits is NOT enough to ensure
> >> that all file references have been released.
> >>
> >> Since there are a variety of other reasons why a mount may be pinned and
> >> fail to umount, perhaps it's worth considering that changing this
> >> behavior won't buy us that much. Especially since it's been around for
> >> more than 10 years:
> > 
> > Because it seems that before io_uring the race was quite a bit harder to
> > hit - I only started seeing it when things started switching over to
> > io_uring. generic/388 used to pass reliably for me (pre backpointers),
> > now it doesn't.
> 
> I literally just pasted a script that hits it in one second with aio. So
> maybe generic/388 doesn't hit it as easily, but it's surely TRIVIAL to
> hit with aio. As demonstrated. The io_uring is not hard to bring into
> parity on that front, here's one I posted earlier today for 6.5:
> 
> https://lore.kernel.org/io-uring/20230628170953.952923-4-axboe@kernel.dk/
> 
> Doesn't change the fact that you can easily hit this with io_uring or
> aio, and probably more things too (didn't look any further). Is it a
> realistic thing outside of funky tests? Probably not really, or at least
> if those guys hit it they'd probably have the work-around hack in place
> in their script already.
> 
> But the fact is that it's been around for a decade. It's somehow a lot
> easier to hit with bcachefs than XFS, which may just be because the
> former has a bunch of workers and this may be deferring the delayed fput
> work more. Just hand waving.

Not sure what you're arguing here...?

We've had a long standing bug, it's recently become much easier to hit
(for multiple reasons); we seem to be in agreement on all that. All I'm
saying is that the existence of that bug previously is not reason to fix
it now.

> >> then we'd probably want to move that deferred fput list to the
> >> task_struct and ensure that it gets run if the task exits rather than
> >> have a global deferred list. Currently we have:
> >>
> >>
> >> 1) If kthread or in interrupt
> >> 	1a) add to global fput list
> >> 2) task_work_add if not. If that fails, goto 1a.
> >>
> >> which would then become:
> >>
> >> 1) If kthread or in interrupt
> >> 	1a) add to global fput list
> >> 2) task_work_add if not. If that fails, we know task is existing. add to
> >>    per-task defer list to be run at a convenient time before task has
> >>    exited.
> > 
> > no, it becomes:
> >  if we're running in a user task, or if we're doing an operation on
> >  behalf of a user task, add to the user task's deferred list: otherwise
> >  add to global deferred list.
> 
> And how would the "on behalf of a user task" work in terms of being
> in_interrupt()?

I don't see any relation to in_interrupt?

We'd have to add a version of fput() that takes an additional
task_struct argument, and plumb that through the aio code - kioctx
lifetime is tied to mm_struct, not task_struct, so we'd have to add a
ref to the task_struct to kiocb.

Which would probably be a good thing tbh, it'd let us e.g. account cpu
time back to the original task when kiocb completion has to run out of a
workqueue.
