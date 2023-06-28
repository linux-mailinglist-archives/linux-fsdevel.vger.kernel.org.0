Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAB5740A72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjF1IGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjF1IBt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:01:49 -0400
Received: from out-39.mta0.migadu.com (out-39.mta0.migadu.com [IPv6:2001:41d0:1004:224b::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628933AB5
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 00:59:36 -0700 (PDT)
Date:   Wed, 28 Jun 2023 00:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687924878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3MLw7YcFyHXR1rN5vXFnw1a8aCPs+A9s2/LGEzLo8qM=;
        b=aj6TIes7oOUyqpykYgyoMBDptalfUM0KTr/OPLio/mbmnynZwD8KXLCDn3MRznzt7sygDX
        8EIv/2H4MHtchcfITbpjvVtcZZWgjp75sSBSIkI2n989zgtnTcO/7yz86m60ocjM6j2y+a
        Bc8yv9wy54HOUpQ3+APVfZYcFyI0vYU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 09:16:31PM -0600, Jens Axboe wrote:
> On 6/27/23 2:15?PM, Kent Overstreet wrote:
> >> to ktest/tests/xfstests/ and run it with -bcachefs, otherwise it kept
> >> failing because it assumed it was XFS.
> >>
> >> I suspected this was just a timing issue, and it looks like that's
> >> exactly what it is. Looking at the test case, it'll randomly kill -9
> >> fsstress, and if that happens while we have io_uring IO pending, then we
> >> process completions inline (for a PF_EXITING current). This means they
> >> get pushed to fallback work, which runs out of line. If we hit that case
> >> AND the timing is such that it hasn't been processed yet, we'll still be
> >> holding a file reference under the mount point and umount will -EBUSY
> >> fail.
> >>
> >> As far as I can tell, this can happen with aio as well, it's just harder
> >> to hit. If the fput happens while the task is exiting, then fput will
> >> end up being delayed through a workqueue as well. The test case assumes
> >> that once it's reaped the exit of the killed task that all files are
> >> released, which isn't necessarily true if they are done out-of-line.
> > 
> > Yeah, I traced it through to the delayed fput code as well.
> > 
> > I'm not sure delayed fput is responsible here; what I learned when I was
> > tracking this down has mostly fell out of my brain, so take anything I
> > say with a large grain of salt. But I believe I tested with delayed_fput
> > completely disabled, and found another thing in io_uring with the same
> > effect as delayed_fput that wasn't being flushed.
> 
> I'm not saying it's delayed_fput(), I'm saying it's the delayed putting
> io_uring can end up doing. But yes, delayed_fput() is another candidate.

Sorry - was just working through my recollections/initial thought
process out loud

> >> For io_uring specifically, it may make sense to wait on the fallback
> >> work. The below patch does this, and should fix the issue. But I'm not
> >> fully convinced that this is really needed, as I do think this can
> >> happen without io_uring as well. It just doesn't right now as the test
> >> does buffered IO, and aio will be fully sync with buffered IO. That
> >> means there's either no gap where aio will hit it without O_DIRECT, or
> >> it's just small enough that it hasn't been hit.
> > 
> > I just tried your patch and I still have generic/388 failing - it
> > might've taken a bit longer to pop this time.
> 
> Yep see the same here. Didn't have time to look into it after sending
> that email today, just took a quick stab at writing a reproducer and
> ended up crashing bcachefs:

You must have hit an error before we finished initializing the
filesystem, the list head never got initialized. Patch for that will be
in the testing branch momentarily.

> > I wonder if there might be a better way of solving this though? For aio,
> > when a process is exiting we just synchronously tear down the ioctx,
> > including waiting for outstanding iocbs.
> 
> aio is pretty trivial, because the only async it supports is O_DIRECT
> on regular files which always completes in finite time. io_uring has to
> cancel etc, so we need to do a lot more.

ahh yes, buffered IO would complicate things

> But the concept of my patch should be fine, but I think we must be
> missing a case. Which is why I started writing a small reproducer
> instead. I'll pick it up again tomorrow and see what is going on here.

Ok. Soon as you've got a patch I'll throw it at my CI, or I can point my
CI at your branch if you have one.
