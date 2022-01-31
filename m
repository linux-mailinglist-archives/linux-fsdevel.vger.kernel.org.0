Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27CC4A476F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 13:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiAaMpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 07:45:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34540 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiAaMpR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:45:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A95DAB82A57
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 12:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5E3C340E8;
        Mon, 31 Jan 2022 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643633115;
        bh=w8YfKm3NN4MkgL1pblKws9APgTiVMOTMAbctuYCMgmo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UeGAtG5HnotxCAnwl7l1cCQY5wMaR6RF5sYoO+4q3cC3diLRHLQ8tb6OiwkypvOS9
         SW7VXyL3ofzuL1eHw879kWJpJs+T6OYw4JesGSOhFFjjuwdjEjsCkXtLEVwIeacd9I
         sQJaBzumBs+dq/uqrAAE+btULQ2gspaYDvbYYbdAyE3YbW7A9hIzX3xqeJpt7wUCi5
         hVjGYCeiQJM/CFyCo/b782yfIOBjwbXJInaedmZT+6IWPDgIWwdyhBoSIuvaSGWsQc
         dGpWrOLwuMqAKR+U+eshy9Erbk7U4XHJeRnwzWGEnOZTlKRQsmlNnSkTbv1gIMDFYy
         3j+Z6wqHX5bOQ==
Message-ID: <053a252018504705d11df27eef3e8a42a24381a1.camel@kernel.org>
Subject: Re: Fwd: Bug: lockf returns false-positive EDEADLK in multiprocess
 multithreaded environment
From:   Jeff Layton <jlayton@kernel.org>
To:     Ivan Zuboff <anotherdiskmag@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 31 Jan 2022 07:45:13 -0500
In-Reply-To: <CAL-cVejy_pDAthiE1DEsDHwfj2mTYK42BoFVPE6ZsA3YNC+a4w@mail.gmail.com>
References: <CAL-cVeifoTfbYRfOcb0YeYor+sCtPWo_2__49taprONhR+tncw@mail.gmail.com>
         <CAL-cVeiHF3+1bq9+RLsdZU-kzfMNYxD0CJBGVeKOrrEpBAyt4Q@mail.gmail.com>
         <ad60a99826063822d4a9fbe12ebb20f285a20410.camel@kernel.org>
         <CAL-cVejy_pDAthiE1DEsDHwfj2mTYK42BoFVPE6ZsA3YNC+a4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-01-31 at 15:06 +0300, Ivan Zuboff wrote:
> On Mon, Jan 31, 2022 at 2:21 PM Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > On Mon, 2022-01-31 at 12:37 +0300, Ivan Zuboff wrote:
> > > Hello, Jeff!
> > > 
> > > Several weeks ago I mailed linux-fsdevel about some weird behavior
> > > I've found. To me, it looks like a bug. Unfortunately, I've got no
> > > response, so I decided to forward this message to you directly.
> > > 
> > > Sorry for the interruption and for my bad English -- it's not my
> > > native language.
> > > 
> > > Hope to hear your opinion on this!
> > > 
> > > Best regards,
> > > Ivan
> > > 
> > 
> > Sorry I missed your message. Re-cc'ing linux-fsdevel, so others can join
> > in on the discussion:
> > 
> > > ---------- Forwarded message ---------
> > > From: Ivan Zuboff <anotherdiskmag@gmail.com>
> > > Date: Mon, Jan 10, 2022 at 1:46 PM
> > > Subject: Bug: lockf returns false-positive EDEADLK in multiprocess
> > > multithreaded environment
> > > To: <linux-fsdevel@vger.kernel.org>
> > > 
> > > 
> > > As an application-level developer, I found a counter-intuitive
> > > behavior in lockf function provided by glibc and Linux kernel that is
> > > likely a bug.
> > > 
> > > In glibc, lockf function is implemented on top of fcntl system call:
> > > https://github.com/lattera/glibc/blob/master/io/lockf.c
> > > man page says that lockf can sometimes detect deadlock:
> > > http://manpages.ubuntu.com/manpages/xenial/man3/lockf.3.html
> > > Same with fcntl(F_SETLKW), on top of which lockf is implemented:
> > > http://manpages.ubuntu.com/manpages/hirsute/en/man3/fcntl.3posix.html
> > > 
> > > Deadlock detection algorithm in the Linux kernel
> > > (https://github.com/torvalds/linux/blob/master/fs/locks.c) seems buggy
> > > because it can easily give false positives. Suppose we have two
> > > processes A and B, process A has threads 1 and 2, process B has
> > > threads 3 and 4. When this processes execute concurrently, following
> > > sequence of actions is possible:
> > > 1. processA thread1 gets lockI
> > > 2. processB thread2 gets lockII
> > > 3. processA thread3 tries to get lockII, starts to wait
> > > 4. processB thread4 tries to get lockI, kernel detects deadlock,
> > > EDEADLK is returned from lockf function
> > > 
> > > Steps to reproduce this scenario (see attached file):
> > > 1. gcc -o edeadlk ./edeadlk.c -lpthread
> > > 2. Launch "./edeadlk a b" in the first terminal window.
> > > 3. Launch "./edeadlk a b" in the second terminal window.
> > > 
> > > What I expected to happen: two instances of the program are steadily working.
> > > 
> > > What happened instead:
> > > Assertion failed: (lockf(fd, 1, 1)) != -1 file: ./edeadlk.c, line:25,
> > > errno:35 . Error:: Resource deadlock avoided
> > > Aborted (core dumped)
> > > 
> > > Surely, this behavior is kind of "right". lockf file locks belongs to
> > > process, so on the process level it seems that deadlock is just about
> > > to happen: process A holds lockI and waits for lockII, process B holds
> > > lockII and is going to wait for lockI. However, the algorithm in the
> > > kernel doesn't take threads into account. In fact, a deadlock is not
> > > going to happen here if the thread scheduler will give control to some
> > > thread holding a lock.
> > > 
> > > I think there's a problem with the deadlock detection algorithm
> > > because it's overly pessimistic, which in turn creates problems --
> > > lockf errors in applications. I had to patch my application to use
> > > flock instead because flock doesn't have this overly-pessimistic
> > > behavior.
> > > 
> > > 
> > 
> > The POSIX locking API predates the concept of threading, and so it was
> > written with some unfortunate concepts around processes. Because you're
> > doing all of your lock acquisition from different threads, obviously
> > nothing should deadlock, but all of the locks are owned by the process
> > so the deadlock detection algorithm can't tell that.
> > 
> > If you have need to do something like this, then you may want to
> > consider using OFD locks, which were designed to allow proper file
> > locking in threaded programs. Here's an older article that predates the
> > name, but it gives a good overview:
> > 
> >     https://lwn.net/Articles/586904/
> > 
> > --
> > Jeff Layton <jlayton@kernel.org>
> 
> Thank you very much for your reply.
> 
> Yes, I've considered OFD locks and flock for my specific task, and
> flock seemed the more reasonable solution because of its portability
> (which is valuable for my task). So my specific problem is indeed
> solved, I just wanted to warn kernel developers about such kind of
> unexpectable behavior deep under the hood. I thought that maybe if the
> algorithm in locks.c can't detect deadlock without such false
> positives then maybe it shouldn't try to do it at all?
> 

Heh, I once made this argument as well, but it does work in some
traditional cases so we decided to keep it around. It is onerous to
track though.

OFD and flock locks specifically do not do any sort of deadlock
detection (thank goodness).


> I have no
> specific stance on this question, I just wanted to inform the people
> who may care about it and maybe would want to do something about it.
> 
> At least there will be messages in mailing list archives explaining
> the situation for people who will face the same problem -- not bad in
> itself!
> 

I think the moral of the story is that you don't really want to use
classic POSIX locks in anything that involves locking between different
threads, as their design just doesn't mesh well with that model.

We did try to convey that in the fcntl manpage in the lead-in to OFD
locks section:

       *  The threads in a process share locks.  In other words, a multi‐
          threaded  program  can't  use  record  locking  to  ensure that
          threads don't simultaneously access the same region of a file.

Maybe we need to revise that to be more clear? Or possibly add something
that points out that this can also manifest as false-positives in
deadlock detection?

-- 
Jeff Layton <jlayton@kernel.org>
