Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC2B4A44FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 12:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343933AbiAaLf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 06:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380030AbiAaLav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:30:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3C4C06137D
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 03:21:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBBD1B82A69
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 11:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60609C340E8;
        Mon, 31 Jan 2022 11:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643628096;
        bh=Dwx4+4W+82LjXG7OLEFUsAVqQXavlPJglLSb2bdVG6c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fmkHSB1W5iY9Pd6NWNrZYx0e1ajn1o+Cxjo11BTCguLZBOh7WrMOznpD9vrf+WXom
         McqDGVJDNw+apdom7wTYjNjKH6k1t/wvrAcmXaNnNA8TzjzqnP7clrBYvPIHHXWi0Q
         t8Z+c043tcPef+eDe/zQWIBnHlpfpJ+iN6RpGy9/IGIUcIzy44i2KOI0mI6mE5KyDL
         yUkDy+/6Mvj2KxR6YZvbJgZoeRlXTRZtUDT/6PWVNADoOTtpDfFppL3il9yzhZs1Af
         1M4OM6NUeF0IoMbYPWrkpem2dkW/xYnj2Kj5EKE4F2OiUzZQG+ts7e1FfUtpSRBc4z
         eCRw7WI4SXkbw==
Message-ID: <ad60a99826063822d4a9fbe12ebb20f285a20410.camel@kernel.org>
Subject: Re: Fwd: Bug: lockf returns false-positive EDEADLK in multiprocess
 multithreaded environment
From:   Jeff Layton <jlayton@kernel.org>
To:     Ivan Zuboff <anotherdiskmag@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 31 Jan 2022 06:21:35 -0500
In-Reply-To: <CAL-cVeiHF3+1bq9+RLsdZU-kzfMNYxD0CJBGVeKOrrEpBAyt4Q@mail.gmail.com>
References: <CAL-cVeifoTfbYRfOcb0YeYor+sCtPWo_2__49taprONhR+tncw@mail.gmail.com>
         <CAL-cVeiHF3+1bq9+RLsdZU-kzfMNYxD0CJBGVeKOrrEpBAyt4Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-01-31 at 12:37 +0300, Ivan Zuboff wrote:
> Hello, Jeff!
> 
> Several weeks ago I mailed linux-fsdevel about some weird behavior
> I've found. To me, it looks like a bug. Unfortunately, I've got no
> response, so I decided to forward this message to you directly.
> 
> Sorry for the interruption and for my bad English -- it's not my
> native language.
> 
> Hope to hear your opinion on this!
> 
> Best regards,
> Ivan
> 

Sorry I missed your message. Re-cc'ing linux-fsdevel, so others can join
in on the discussion:

> ---------- Forwarded message ---------
> From: Ivan Zuboff <anotherdiskmag@gmail.com>
> Date: Mon, Jan 10, 2022 at 1:46 PM
> Subject: Bug: lockf returns false-positive EDEADLK in multiprocess
> multithreaded environment
> To: <linux-fsdevel@vger.kernel.org>
> 
> 
> As an application-level developer, I found a counter-intuitive
> behavior in lockf function provided by glibc and Linux kernel that is
> likely a bug.
> 
> In glibc, lockf function is implemented on top of fcntl system call:
> https://github.com/lattera/glibc/blob/master/io/lockf.c
> man page says that lockf can sometimes detect deadlock:
> http://manpages.ubuntu.com/manpages/xenial/man3/lockf.3.html
> Same with fcntl(F_SETLKW), on top of which lockf is implemented:
> http://manpages.ubuntu.com/manpages/hirsute/en/man3/fcntl.3posix.html
> 
> Deadlock detection algorithm in the Linux kernel
> (https://github.com/torvalds/linux/blob/master/fs/locks.c) seems buggy
> because it can easily give false positives. Suppose we have two
> processes A and B, process A has threads 1 and 2, process B has
> threads 3 and 4. When this processes execute concurrently, following
> sequence of actions is possible:
> 1. processA thread1 gets lockI
> 2. processB thread2 gets lockII
> 3. processA thread3 tries to get lockII, starts to wait
> 4. processB thread4 tries to get lockI, kernel detects deadlock,
> EDEADLK is returned from lockf function
> 
> Steps to reproduce this scenario (see attached file):
> 1. gcc -o edeadlk ./edeadlk.c -lpthread
> 2. Launch "./edeadlk a b" in the first terminal window.
> 3. Launch "./edeadlk a b" in the second terminal window.
> 
> What I expected to happen: two instances of the program are steadily working.
> 
> What happened instead:
> Assertion failed: (lockf(fd, 1, 1)) != -1 file: ./edeadlk.c, line:25,
> errno:35 . Error:: Resource deadlock avoided
> Aborted (core dumped)
> 
> Surely, this behavior is kind of "right". lockf file locks belongs to
> process, so on the process level it seems that deadlock is just about
> to happen: process A holds lockI and waits for lockII, process B holds
> lockII and is going to wait for lockI. However, the algorithm in the
> kernel doesn't take threads into account. In fact, a deadlock is not
> going to happen here if the thread scheduler will give control to some
> thread holding a lock.
> 
> I think there's a problem with the deadlock detection algorithm
> because it's overly pessimistic, which in turn creates problems --
> lockf errors in applications. I had to patch my application to use
> flock instead because flock doesn't have this overly-pessimistic
> behavior.
> 
> 

The POSIX locking API predates the concept of threading, and so it was
written with some unfortunate concepts around processes. Because you're
doing all of your lock acquisition from different threads, obviously
nothing should deadlock, but all of the locks are owned by the process
so the deadlock detection algorithm can't tell that.

If you have need to do something like this, then you may want to
consider using OFD locks, which were designed to allow proper file
locking in threaded programs. Here's an older article that predates the
name, but it gives a good overview:

    https://lwn.net/Articles/586904/

-- 
Jeff Layton <jlayton@kernel.org>
