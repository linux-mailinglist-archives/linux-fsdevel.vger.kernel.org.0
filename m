Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4093547C873
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 21:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhLUU4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 15:56:43 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49881 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235188AbhLUU4m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:56:42 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 1BLKuZvK030434;
        Tue, 21 Dec 2021 21:56:35 +0100
Date:   Tue, 21 Dec 2021 21:56:35 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Waiman Long <longman@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] exec: Make suid_dumpable apply to SUID/SGID binaries
 irrespective of invoking users
Message-ID: <20211221205635.GB30289@1wt.eu>
References: <20211221021744.864115-1-longman@redhat.com>
 <87lf0e7y0k.fsf@email.froward.int.ebiederm.org>
 <4f67dc4c-7038-7dde-cad9-4feeaa6bc71b@redhat.com>
 <87czlp7tdu.fsf@email.froward.int.ebiederm.org>
 <e78085e4-74cd-52e1-bc0e-4709fac4458a@redhat.com>
 <CAHk-=wg+qpNvqcROndhRidOE1i7bQm93xM=jmre98-X4qkVkMw@mail.gmail.com>
 <7f0f8e71-cf62-4c0b-5f13-a41919c6cd9b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f0f8e71-cf62-4c0b-5f13-a41919c6cd9b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 02:27:47PM -0500, Waiman Long wrote:
> On 12/21/21 13:19, Linus Torvalds wrote:
> > On Tue, Dec 21, 2021 at 10:01 AM Waiman Long <longman@redhat.com> wrote:
> > > Default RLIMIT_CORE to 0 will likely mitigate this vulnerability.
> > > However, there are still some userspace impacts as existing behavior
> > > will be modified. For instance, we may need to modify su to restore a
> > > proper value for RLIMIT_CORE after successful authentication.
> > We had a "clever" idea for this that I thought people were ok with.
> > 
> > It's been some time since this came up, but iirc the notion was to
> > instead of setting the rlimit to zero (which makes it really hard to
> > restore afterwards, because you don't know what the restored value
> > would be, so you are dependent on user space doing it), we just never
> > reset set_dumpable() when we execve.
> > 
> > So any suid exec will do set_dumpable() to suid_dumpable, and exec'ing
> > something else does nothing at all - it stays non-dumpable (obviously
> > "non-dumpable" here depends on the actual value for "suid_dumpable" -
> > you can enable suid dump debugging manually).
> > 
> > And instead, we say that operations like "setsid()" that start a new
> > session - *those* are the ones that enable core dumping again. Or
> > doing things like a "ulimit(RLIMIT_CORE)" (which clearly implies "I
> > want core-dumps").
> > 
> > Those will all very naturally make "login" and friends work correctly,
> > while keeping core-dumps disabled for some suid situation that doesn't
> > explicitly set up a new context.
> > 
> > I think the basic problem with the traditional UNIX model of "suid
> > exec doesn't core dump" is that the "enter non-core-dump" is a nice
> > clear "your privileges changed".
> > 
> > But then the "exit non-core-dump" thing is an exec that *doesn't*
> > change privileges. That's the odd and crazy part: you just disabled
> > core-dumps because there was a privilege level change, and then you
> > enable core-dumps again because there *wasn't* a privilege change -
> > even if you're still at those elevated privileges.
> > 
> > Now, this is clearly not a Linux issue - we're just doing what others
> > have been doing too. But I think we should just admit that "what
> > others have been doing" is simply broken.
> > 
> > And yes, some odd situation migth be broken by this kind of change,
> > but I think this kind of "the old model was broken" may simply require
> > that. I suspect we can find a solution that fixes all the regular
> > cases.
> > 
> > Hmm?
> 
> I think this is a pretty clever idea. At least it is better than resetting
> RLIMIT_CORE to 0.

Another problem that was raised when discussing RLIMIT_CORE to zero was
the loss of the old value.

> As it is all done within the kernel, there is no need to
> change any userspace code. We may need to add a flag bit in the task
> structure to indicate using the suid_dumpable setting so that it can be
> inherited across fork/exec.

Depending on what we change there can be some subtly visible changes.
In one of my servers I explicitly re-enable dumpable before setsid()
when a core dump is desired for debugging. But other deamons could do
the exact opposite. If setsid() systematically restores suid_dumpable,
a process that explicitly disables it before calling setsid() would
see it come back. But if we have a special "suid_in_progress" flag
to mask suid_dumpable and that's reset by setsid() and possibly
prctl(PR_SET_DUMPABLE) then I think it could even cover that unlikely
case.

Just my two cents,
Willy
