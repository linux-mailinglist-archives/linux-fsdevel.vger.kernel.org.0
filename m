Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB41B1754CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 08:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCBHs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 02:48:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47552 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBHs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:48:28 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8fns-0001Sk-QB; Mon, 02 Mar 2020 07:47:52 +0000
Date:   Mon, 2 Mar 2020 08:47:51 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] exec: Fix a deadlock in ptrace
Message-ID: <20200302074751.evhnq3b5zvtbaqu4@wittgenstein>
References: <AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAG48ez3QHVpMJ9Rb_Q4LEE6uAqQJeS1Myu82U=fgvUfoeiscgw@mail.gmail.com>
 <20200301185244.zkofjus6xtgkx4s3@wittgenstein>
 <CAG48ez3mnYc84iFCA25-rbJdSBi3jh9hkp569XZTbFc_9WYbZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez3mnYc84iFCA25-rbJdSBi3jh9hkp569XZTbFc_9WYbZw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 01, 2020 at 09:00:22PM +0100, Jann Horn wrote:
> On Sun, Mar 1, 2020 at 7:52 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > On Sun, Mar 01, 2020 at 07:21:03PM +0100, Jann Horn wrote:
> > > On Sun, Mar 1, 2020 at 12:27 PM Bernd Edlinger
> > > <bernd.edlinger@hotmail.de> wrote:
> > > > The proposed solution is to have a second mutex that is
> > > > used in mm_access, so it is allowed to continue while the
> > > > dying threads are not yet terminated.
> > >
> > > Just for context: When I proposed something similar back in 2016,
> > > https://lore.kernel.org/linux-fsdevel/20161102181806.GB1112@redhat.com/
> > > was the resulting discussion thread. At least back then, I looked
> > > through the various existing users of cred_guard_mutex, and the only
> > > places that couldn't be converted to the new second mutex were
> > > PTRACE_ATTACH and SECCOMP_FILTER_FLAG_TSYNC.
> > >
> > >
> > > The ideal solution would IMO be something like this: Decide what the
> > > new task's credentials should be *before* reaching de_thread(),
> > > install them into a second cred* on the task (together with the new
> > > dumpability), drop the cred_guard_mutex, and let ptrace_may_access()
> > > check against both. After that, some further restructuring might even
> >
> > Hm, so essentially a private ptrace_access_cred member in task_struct?
> 
> And a second dumpability field, because that changes together with the
> creds during execve. (Btw, currently the dumpability is in the
> mm_struct, but that's kinda wrong. The mm_struct is removed from a
> task on exit while access checks can still be performed against it, and
> currently ptrace_may_access() just lets the access go through in that
> case, which weakens the protection offered by PR_SET_DUMPABLE when
> used for security purposes. I think it ought to be moved over into the
> task_struct.)
> 
> > That would presumably also involve altering various LSM hooks to look at
> > ptrace_access_cred.
> 
> When I tried to implement this in the past, I changed the LSM hook to
> take the target task's cred* as an argument, and then called the LSM
> hook twice from ptrace_may_access(). IIRC having the target task's
> creds as an argument works for almost all the LSMs, with the exception
> of Yama, which doesn't really care about the target task's creds, so
> you have to pass in both the task_struct* and the cred*.

It seems we should try PoCing this.

Christian
