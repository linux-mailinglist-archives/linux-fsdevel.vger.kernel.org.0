Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C1547CCFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Dec 2021 07:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbhLVG3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Dec 2021 01:29:12 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49905 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233176AbhLVG3L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:29:11 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 1BM6T3g0001806;
        Wed, 22 Dec 2021 07:29:03 +0100
Date:   Wed, 22 Dec 2021 07:29:03 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] exec: Make suid_dumpable apply to SUID/SGID binaries
 irrespective of invoking users
Message-ID: <20211222062903.GA1720@1wt.eu>
References: <20211221021744.864115-1-longman@redhat.com>
 <87lf0e7y0k.fsf@email.froward.int.ebiederm.org>
 <4f67dc4c-7038-7dde-cad9-4feeaa6bc71b@redhat.com>
 <87czlp7tdu.fsf@email.froward.int.ebiederm.org>
 <e78085e4-74cd-52e1-bc0e-4709fac4458a@redhat.com>
 <CAHk-=wg+qpNvqcROndhRidOE1i7bQm93xM=jmre98-X4qkVkMw@mail.gmail.com>
 <7f0f8e71-cf62-4c0b-5f13-a41919c6cd9b@redhat.com>
 <20211221205635.GB30289@1wt.eu>
 <20211221221336.GC30289@1wt.eu>
 <87o8594jlq.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8594jlq.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 05:35:29PM -0600, Eric W. Biederman wrote:
> > Would there be any interest in pursuing attempts like the untested patch
> > below ? The intent is to set a new MMF_NOT_DUMPABLE on exec on setuid or
> > setgid bit, but clear it on setrlimit(RLIMIT_CORE), prctl(SET_DUMPABLE),
> > and setsid(). This flag makes get_dumpable() return SUID_DUMP_DISABLED
> > when set. I think that in the spirit it could maintain the info that a
> > suidexec happened and was not reset, without losing any tuning made by
> > the application. I never feel at ease touching all this and I certainly
> > did some mistakes but for now it's mostly to have a base to discuss
> > around, so do not hesitate to suggest or criticize.
> 
> 
> Yes.  This looks like a good place to start the conversation.

OK thanks.

> We need to do something like you are doing to separate dumpability
> changes due to privilege gains during exec and dumpability changes due
> to privilege shuffling with setresuid.
> 
> As long as we only impact processes descending from a binary that has
> gained privileges during exec (like this patch) I think we have a lot
> of latitude in how we make this happen.

Yes that's the idea. I think that fundamentally we ought to mark
that a chain of processes are potentially unsafe for dumps until the
application has shown that it could regain control of the code paths,
and hence is expected to deal properly with errors that might appear
so as not to dump a core anywhere with random permissions.

> Basically we only need to
> test su and sudo and verify that whatever we do works reasonably
> well for them.
> 
> On the one hand I believe of gaining privileges during exec while
> letting the caller control some aspect of our environment is a dangerous
> design flaw and I would love to remove gaining privileges during exec
> entirely.

You would like to postpone this ? It's not very clear to me how to do
that nor if it could reliably address this shortcoming.

> On the other hand we need to introduces as few regressions as possible
> and make gaining privileges during exec as safe as possible.

Yep I think so. Also code that is designed to run under setuid (like sudo)
is usally well tested, and quite portable thanks to various OS-specific
tweaks that we definitely don't want to break.

> I do agree that RLIMIT_CORE and prctl(SET_DUMPABLE) are good places
> to clear the flag.

There are probably other ones, but ideally we ought to avoid stuff
that could happen early in the dynamic linker.

> I don't know if setsid is the proper key to re-enabling dumpability.

It was a supposition emitted by Linus, which deserved being checked
at least given that it's part of the usual sequence when starting a
deamon.

> I ran a quick test and simply doing "su" and then running a shell
> as root does not change the session, nor does "su -" (which creates
> a login shell).  Also "sudo -s" does not create a new session.
> 
> So session creation does not happen naturally.

OK, so it will not help them. For them we could use setuid()/setreuid()
and setresuid() as good indicators that the application has taken control
of its fate. Sadly we cannot do that in set_user() because this one is
not called when the uid doesn't change.

> Still setsid is part of the standard formula for starting a daemon,
> so I don't think system services that run as daemons will be affected.
> 
> 
> I don't think anything we do matters for systemd.  As I understand
> it "systemctl start ..." causes pid 1 to fork and exec services,
> which will ensure the started processes are not descendants of
> the binary the gained privileges during exec.

Good point, I hadn't thought about that, but I agree with you.

Willy
