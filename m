Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C203741C03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 00:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjF1Wzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 18:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjF1Wzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:55:43 -0400
Received: from out-15.mta0.migadu.com (out-15.mta0.migadu.com [91.218.175.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269A7273B
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 15:55:28 -0700 (PDT)
Date:   Wed, 28 Jun 2023 18:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687992926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NC7io3hJiGazy/1nLRyLYY/aZGU1OCwphLLIBbRfFVc=;
        b=u44xIlYolPHdvyZbmi/QCzn6vZPbW5FX79/HnVCpNxVXIKZiP2IR1cDolNo/S9hCb9fpLo
        g3uwlLoc3p7WAk/kI+JJj3gOL9BJVGuHBBfLks+T8IxjbiXUKVfH8na30X+R+dwPSSx5za
        viuWG+OpYuc9LGzRgkPkz9lUHGnKIVM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230628225514.n3xtlgmjkgapgnrd@moria.home.lan>
References: <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
 <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
 <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
 <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
 <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
 <d697ec27-8008-2eb6-0950-f612a602dcf5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d697ec27-8008-2eb6-0950-f612a602dcf5@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 04:33:55PM -0600, Jens Axboe wrote:
> On 6/28/23 4:13?PM, Kent Overstreet wrote:
> > On Wed, Jun 28, 2023 at 03:17:43PM -0600, Jens Axboe wrote:
> >> Case in point, just changed my reproducer to use aio instead of
> >> io_uring. Here's the full script:
> >>
> >> #!/bin/bash
> >>
> >> DEV=/dev/nvme1n1
> >> MNT=/data
> >> ITER=0
> >>
> >> while true; do
> >> 	echo loop $ITER
> >> 	sudo mount $DEV $MNT
> >> 	fio --name=test --ioengine=aio --iodepth=2 --filename=$MNT/foo --size=1g --buffered=1 --overwrite=0 --numjobs=12 --minimal --rw=randread --output=/dev/null &
> >> 	Y=$(($RANDOM % 3))
> >> 	X=$(($RANDOM % 10))
> >> 	VAL="$Y.$X"
> >> 	sleep $VAL
> >> 	ps -e | grep fio > /dev/null 2>&1
> >> 	while [ $? -eq 0 ]; do
> >> 		killall -9 fio > /dev/null 2>&1
> >> 		echo will wait
> >> 		wait > /dev/null 2>&1
> >> 		echo done waiting
> >> 		ps -e | grep "fio " > /dev/null 2>&1
> >> 	done
> >> 	sudo umount /data
> >> 	if [ $? -ne 0 ]; then
> >> 		break
> >> 	fi
> >> 	((ITER++))
> >> done
> >>
> >> and if I run that, fails on the first umount attempt in that loop:
> >>
> >> axboe@m1max-kvm ~> bash test2.sh
> >> loop 0
> >> will wait
> >> done waiting
> >> umount: /data: target is busy.
> >>
> >> So yeah, this is _nothing_ new. I really don't think trying to address
> >> this in the kernel is the right approach, it'd be a lot saner to harden
> >> the xfstest side to deal with the umount a bit more sanely. There are
> >> obviously tons of other ways that a mount could get pinned, which isn't
> >> too relevant here since the bdev and mount point are basically exclusive
> >> to the test being run. But the kill and delayed fput is enough to make
> >> that case imho.
> > 
> > Uh, count me very much not in favor of hacking around bugs elsewhere.
> > 
> > Al, do you know if this has been considered before? We've got fput()
> > being called from aio completion, which often runs out of a worqueue (if
> > not a workqueue, a bottom half of some sort - what happens then, I
> > wonder) - so the effect is that it goes on the global list, not the task
> > work list.
> > 
> > hence, kill -9ing a process doing aio (or io_uring io, for extra
> > reasons) causes umount to fail with -EBUSY.
> > 
> > and since there's no mechanism for userspace to deal with this besides
> > sleep and retry, this seems pretty gross.
> 
> But there is, as Christian outlined. I would not call it pretty or
> intuitive, but you can in fact make it work just fine and not just for
> the deferred fput() case but also in the presence of other kinds of
> pins. Of which there are of course many.

No, because as I explained that just defers the race until when you next
try to use the device, since with lazy umount the device will still be
use when umount returns.

What you'd want is a lazy, synchronous umount, and AFAIK that doesn't
exist.

> > I'd be willing to tackle this for aio since I know that code...
> 
> But it's not aio (or io_uring or whatever), it's simply the fact that
> doing an fput() from an exiting task (for example) will end up being
> done async. And hence waiting for task exits is NOT enough to ensure
> that all file references have been released.
> 
> Since there are a variety of other reasons why a mount may be pinned and
> fail to umount, perhaps it's worth considering that changing this
> behavior won't buy us that much. Especially since it's been around for
> more than 10 years:

Because it seems that before io_uring the race was quite a bit harder to
hit - I only started seeing it when things started switching over to
io_uring. generic/388 used to pass reliably for me (pre backpointers),
now it doesn't.

> commit 4a9d4b024a3102fc083c925c242d98ac27b1c5f6
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Sun Jun 24 09:56:45 2012 +0400
> 
>     switch fput to task_work_add
> 
> though that commit message goes on to read:
> 
>     We are guaranteed that __fput() will be done before we return
>     to userland (or exit).  Note that for fput() from a kernel
>     thread we get an async behaviour; it's almost always OK, but
>     sometimes you might need to have __fput() completed before
>     you do anything else.  There are two mechanisms for that -
>     a general barrier (flush_delayed_fput()) and explicit
>     __fput_sync().  Both should be used with care (as was the
>     case for fput() from kernel threads all along).  See comments
>     in fs/file_table.c for details.
> 
> where that first sentence isn't true if the task is indeed exiting. I
> guess you can say that it is as it doesn't return to userland, but
> splitting hairs. Though the commit in question doesn't seem to handle
> that case, but assuming that came in with a later fixup.
> 
> It is true if the task_work gets added, as that will get run before
> returning to userspace.

Yes, AIO seems to very much be the exceptional case that wasn't
originally considered.

> If a case were to be made that we also guarantee that fput has been done
> by the time to task returns to userspace, or exits,

And that does seem to be the intent of the original code, no?

> then we'd probably want to move that deferred fput list to the
> task_struct and ensure that it gets run if the task exits rather than
> have a global deferred list. Currently we have:
>
> 
> 1) If kthread or in interrupt
> 	1a) add to global fput list
> 2) task_work_add if not. If that fails, goto 1a.
> 
> which would then become:
> 
> 1) If kthread or in interrupt
> 	1a) add to global fput list
> 2) task_work_add if not. If that fails, we know task is existing. add to
>    per-task defer list to be run at a convenient time before task has
>    exited.

no, it becomes:
 if we're running in a user task, or if we're doing an operation on
 behalf of a user task, add to the user task's deferred list: otherwise
 add to global deferred list.
