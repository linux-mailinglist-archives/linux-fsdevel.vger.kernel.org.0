Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EA3241BFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgHKOC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 10:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbgHKOC0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:02:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122E2C06174A;
        Tue, 11 Aug 2020 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5rQ5dY74xtq7tFdjS2KoPSsnFzw7cy9K3d3kbAwfqoI=; b=eVOXFZGTb4S65kl2EyHtA0JBK5
        bgr8ijcvRiK7aiP7g5WnQk0cTWdwGgzw9q4XrrFEl8DqvjlqAjPUsmEepQhRq/y68VWi+QDIUtP21
        +IZC/aY3ijRtUDmWEo+EWCS/N4/wJBwsODAR9Y1SMHbB3OUAt8eG3S9AL2S7y/5x4rMGCL68ZVPEW
        NRaHToy51WdE1+l6tz/iPd4zzzRJ2bblwtT4nXdXTDiAStxtwIFAb8062CFjQjb6voRgo0BADPtaD
        c8l9fhcKj/rtg3Gql938sVm06wFUm+0Na5ugLcYYvERnDeSlwgWgLQz9hhXDUy3cBZQddwYil8Nb4
        k3FJa4dQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5Uqp-0000P7-Qy; Tue, 11 Aug 2020 14:02:03 +0000
Date:   Tue, 11 Aug 2020 15:02:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 0/7] Add support for O_MAYEXEC
Message-ID: <20200811140203.GQ17456@casper.infradead.org>
References: <20200723171227.446711-1-mic@digikod.net>
 <202007241205.751EBE7@keescook>
 <0733fbed-cc73-027b-13c7-c368c2d67fb3@digikod.net>
 <20200810202123.GC1236603@ZenIV.linux.org.uk>
 <917bb071-8b1a-3ba4-dc16-f8d7b4cc849f@digikod.net>
 <CAG48ez0NAV5gPgmbDaSjo=zzE=FgnYz=-OHuXwu0Vts=B5gesA@mail.gmail.com>
 <0cc94c91-afd3-27cd-b831-8ea16ca8ca93@digikod.net>
 <5db0ef9cb5e7e1569a5a1f7a0594937023f7290b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5db0ef9cb5e7e1569a5a1f7a0594937023f7290b.camel@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 09:56:50AM -0400, Mimi Zohar wrote:
> On Tue, 2020-08-11 at 10:48 +0200, Mickaël Salaün wrote:
> > On 11/08/2020 01:03, Jann Horn wrote:
> > > On Tue, Aug 11, 2020 at 12:43 AM Mickaël Salaün <mic@digikod.net> wrote:
> > > > On 10/08/2020 22:21, Al Viro wrote:
> > > > > On Mon, Aug 10, 2020 at 10:11:53PM +0200, Mickaël Salaün wrote:
> > > > > > It seems that there is no more complains nor questions. Do you want me
> > > > > > to send another series to fix the order of the S-o-b in patch 7?
> > > > > 
> > > > > There is a major question regarding the API design and the choice of
> > > > > hooking that stuff on open().  And I have not heard anything resembling
> > > > > a coherent answer.
> > > > 
> > > > Hooking on open is a simple design that enables processes to check files
> > > > they intend to open, before they open them. From an API point of view,
> > > > this series extends openat2(2) with one simple flag: O_MAYEXEC. The
> > > > enforcement is then subject to the system policy (e.g. mount points,
> > > > file access rights, IMA, etc.).
> > > > 
> > > > Checking on open enables to not open a file if it does not meet some
> > > > requirements, the same way as if the path doesn't exist or (for whatever
> > > > reasons, including execution permission) if access is denied.
> > > 
> > > You can do exactly the same thing if you do the check in a separate
> > > syscall though.
> > > 
> > > And it provides a greater degree of flexibility; for example, you can
> > > use it in combination with fopen() without having to modify the
> > > internals of fopen() or having to use fdopen().
> > > 
> > > > It is a
> > > > good practice to check as soon as possible such properties, and it may
> > > > enables to avoid (user space) time-of-check to time-of-use (TOCTOU)
> > > > attacks (i.e. misuse of already open resources).
> > > 
> > > The assumption that security checks should happen as early as possible
> > > can actually cause security problems. For example, because seccomp was
> > > designed to do its checks as early as possible, including before
> > > ptrace, we had an issue for a long time where the ptrace API could be
> > > abused to bypass seccomp filters.
> > > 
> > > Please don't decide that a check must be ordered first _just_ because
> > > it is a security check. While that can be good for limiting attack
> > > surface, it can also create issues when the idea is applied too
> > > broadly.
> > 
> > I'd be interested with such security issue examples.
> > 
> > I hope that delaying checks will not be an issue for mechanisms such as
> > IMA or IPE:
> > https://lore.kernel.org/lkml/1544699060.6703.11.camel@linux.ibm.com/
> > 
> > Any though Mimi, Deven, Chrome OS folks?
> 
> One of the major gaps, defining a system wide policy requiring all code
> being executed to be signed, is interpreters.  The kernel has no
> context for the interpreter's opening the file.  From an IMA
> perspective, this information needs to be conveyed to the kernel prior
> to ima_file_check(), which would allow IMA policy rules to be defined
> in terms of O_MAYEXEC.

This is kind of evading the point -- Mickaël is proposing a new flag
to open() to tell IMA to measure the file being opened before the fd
is returned to userspace, and Al is suggesting a new syscall to allow
a previously-obtained fd to be measured.

I think what you're saying is that you don't see any reason to prefer
one over the other.
