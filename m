Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E153A45B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 17:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhFKPwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 11:52:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52602 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhFKPwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 11:52:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A70A421A5C;
        Fri, 11 Jun 2021 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623426613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSrjCQsVLNabZ1hMe6rvpFpZGEgVvaT2objk+13fZmE=;
        b=bLUQqGJ18ZKUWdzlckEOdhmHH/B/deYdAZvctjiQJSFOiE/VJIngaa10MI3SoWX+mVX0lW
        FX1h9MJqOZHCRW2sVgFOn/8yLPNg+s9fswi7DHFb+Ul40XptaJUx2+K89ZYEavjYSQ/tci
        OiGHu1/JhhwAyy2GICm021CN41/3/5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623426613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSrjCQsVLNabZ1hMe6rvpFpZGEgVvaT2objk+13fZmE=;
        b=8uXs9wedsLlVykQ5KogNo9wPhLGAPW6Adcd085tYehZToOEgAot+pxpcI5wcxTc9Z2qscs
        OknGVrEYPgCvVFDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 982F3A3B8E;
        Fri, 11 Jun 2021 15:50:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5BA431E10FD; Fri, 11 Jun 2021 17:50:13 +0200 (CEST)
Date:   Fri, 11 Jun 2021 17:50:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     strager <strager.nds@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: slow close() for inotify fd
Message-ID: <20210611155013.GA23106@quack2.suse.cz>
References: <CAC-ggsFLmFpz5Y=-9MMLwxuO2LOS9rhpewDp_-u2hrT9J79ryg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC-ggsFLmFpz5Y=-9MMLwxuO2LOS9rhpewDp_-u2hrT9J79ryg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Tue 01-06-21 21:30:35, strager wrote:
> I noticed a weird performance behavior when closing an inotify file
> descriptor.
> 
> Here is a test C program which demonstrates the issue:
> https://gist.github.com/1fa8ae0e0d16a0618691d896315d93e8
> 
> My test C program's job is to call inotify_init1(), inotify_add_watch(), then
> close(). Each watch is for a different directory. Each inotify fd gets one
> watch. The program times how long close()ing the inotify fd takes.
> 
> When I run my test C program on my machine, I get this output:
> https://gist.github.com/b396f2379cc066e78e15938b5490cb4d
> 
> close() is very slow depending on how you call it in relation to other
> inotify fds in the process. I looked at inotify's implementation and I
> think the slowness is because of the synchronize_srcu() call in
> fsnotify_mark_destroy_workfn() (fs/notify/mark.c).

Yes, I'd expect synchronize_srcu() to be the source of the latency as well.
Basically after we remove a mark, we have to wait for SRCU period to expire
before we can free it. And notification group destruction (i.e., what
happens on close(2)) has to wait for all marks to be freed (as they are
referencing a group). There's also a roundtrip to the workqueue and back
for mark destruction which can add to the latency. Sadly I don't have much
improvements to offer to you...

> Why does close() performance matter to me? I am writing a test suite for
> a program which uses inotify. Many test cases in the test suite do the
> following:
> 
> 1. Create a temporary directory
> 2. Add files into the temporary directory
> 3. Create an inotify fd
> 4. Watch some directories and files in temporary directory
> 5. Manipulate the filesystem in interesting ways
> 6. Read the inotify fd and do application-specific logic
> 7. Assert that the application did the right thing
> 8. Close the inotify fd
> 9. Delete the temporary directory and its contents
> 
> I noticed that my test suite started becoming slow. With only a handful
> of test cases, the test suite was taking half a second. I tracked the
> problem down to close(), so I created a test C program to demonstrate the
> performance behavior of close() (linked above).
> 
> I naively expected close() for an inotify fd to be pretty fast. (I do
> understand that close() can be slow for files on NFS, though.)
> 
> I found a workaround for the slowness: at the end of each test case,
> don't close() the inotify fd. Instead, unwatch everything associated with
> that inotify fd, and every few test cases, close all the inotify fds.
> This amortizes the RCU synchronization in my test suite. This workaround
> is codified by TEST_WATCH_AND_UNWATCH_EACH_THEN_CLOSE_ALL in my test C
> program.
> 
> With this workaround, I don't need close() to be faster. I thought I'd
> bring the issue to your attention regardless.

Yeah, sadly the slowness of close is what we have to pay for the lockless
generation of notification events (which is a fast path). I don't see easy
way around that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
