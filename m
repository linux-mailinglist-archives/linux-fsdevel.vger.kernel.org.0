Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F626F4F78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 06:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjECEbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 00:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjECEbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 00:31:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27501FF9
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 21:31:28 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3434VBbH031305
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 00:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683088274; bh=OyzzkX00Si5zQ8rjIBhSHLYd6Gnjk4yTOAc/gsVfj3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=oA8dwALaznt852Bh7ske9NAf7AaLxlXhJcpjCjtv6VKO9/XcocdWlhVicrN7rjpVI
         stFGrCOHtMH3a5KuQYmpO9pD7tLnVBhkNkMeYE+WscLx/zPkvFqeuW4irVpQBG/yHb
         05sfIuUMFYqegu6F/KZlNR6jXiUzPY2F79/KgVbCex8LO/MslQqYWQ0+WuhSZm6gt5
         6vw6QphWz1ASqJEwUuawCUd//qYOkn3U0OUJXSj0n5plgHGyEM6C9y4Lc1+nB8lQHJ
         RW4LMkC3aZHGWbxVisQm8JtAntnQKrCnWTKqPl+HmDhXHqn0OOeoQj3SYs6mdMnGqD
         tJNs6aDadUOwA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6522B15C02E2; Wed,  3 May 2023 00:31:11 -0400 (EDT)
Date:   Wed, 3 May 2023 00:31:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com>,
        hch@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [sysv?] [vfs?] WARNING in invalidate_bh_lru
Message-ID: <20230503043111.GA674745@mit.edu>
References: <000000000000eccdc505f061d47f@google.com>
 <ZE4NVo6rTOeGQdK+@mit.edu>
 <CANp29Y7dG3Z11Bt99rS0y8epdXfaKk+HJfXt=ePbm29vYF88Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp29Y7dG3Z11Bt99rS0y8epdXfaKk+HJfXt=ePbm29vYF88Gg@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 01, 2023 at 11:18:28AM +0200, Aleksandr Nogikh wrote:
> >
> > There are two reproducers, one that mounts a sysv file system, and the
> > other which mounts a udf file system.  There is no mention of ext4 in
> > the stack trace, and yet syzbot has assigned this to the ext4
> > subsystem for some unknown reason.
> 
> In this particular case, there were two ext4-related crashes as well:
> 
> https://syzkaller.appspot.com/text?tag=CrashReport&x=14c7dd1b480000
> https://syzkaller.appspot.com/text?tag=CrashReport&x=1153a07f480000
> 
> I think syzbot picked a too generic frame as a bug title and it just
> got confused by crashes belonging to different filesystems.
> Maybe we need to display subsystems for individual crashes as well, so
> that it's easier for a human to understand what's going on..

Hmm.... the the two ext4-related crashes have very different stack
traces.  In the first, there was some ext4 functions on the stack
trace, but those are not relevant, since we take an interrupt, and it
was apparently an arm64 IPI, which then results in the call to
invalidate_bh_lrus(), which then triggers the warning.  So this
*might* be related to ext4, but it could be any other file system that
could have been mounted at the same time, since syzbot runs multiple
streams of system calls in parallel.

In the second stack trace, we were in the middle of unmounting the
file system, and ext4_but_super() called invalidate_bdev(), which in
turn called invalidate_bh_lrus(), and that's when the buffer head
layer finds a buffer head whose refcount is zero, and that triggers
the:

VFS: brelse: Trying to free free buffer

... which then leads to the WARNING in invalidate_bh_lru().

So yes, the problem is that syzbot chose generic description based on
the warning.  An analogy might be a medical examiner in a police
procedural TV show[1] having seen a dozen corpses that were shot in
the torso, leading to them bleeding out and dying, erroneously
concluding that all six homocides *must* be related.  In fact, the
size of the bullet might be different, and who might have been holding
the gun might be very different.

[1] https://www.youtube.com/watch?v=lMalvNeJFLk

Worse, even if we did a better job disambiguating based on the stack
trace, without a reliable reproducer, the stack trace is of very
limited utility for trying to track down this kind of bug.  Going back
to the crime scene analogy, the stack trace basically tells us where
the body was found.  It doesn't tell us much about who might have been
fired the bullet.  That is, we need to know who called brelse() or
put_bh() on the buffer_head one too many times, leading to the report
that there was an attempt to free a free buffer.

(Fortunately, such bugs a relatively rare, although as this syzbot
report demonstrates, some still exist --- if I had to guess, the bugs
are on some error handling path which is very rarely hit.)

Perhaps syzbot could special case handling for those objects (like
struct buffer_head) which have a refcount and where the refcount can
go negative, and treat functions that manipulate such objects much
like how syzbot handles KASAN errors?  The tricky bit is the immediate
caller of the invalidate_bh_lrus() is not necessarily the best one to
use.  For example, invalidate_bdev() calls invalidate_bh_lrus(), and
it's the caller of invalidate_bdev() which is interesting in this case
--- e.g., ext4_put_super().

In the first stack trace, nothing in the stack trace is helpful, so
there may not much we can do debug this unless we can get a reproducer
that reproduces this particular stack trace.

In general, though, syzbot should disregard any functions after the
functions indicating that an interrupt had taken place, since which
code was interrupted when the IRQ came in is just an innocent victim.

For now, given that we *do* have a two reproducers, one involving sysv
and the other udf file systems, it's probably best that we try to let
the maintainers of those file systems try to figure out what be going
on.

     	 	     	      	       	  - Ted
