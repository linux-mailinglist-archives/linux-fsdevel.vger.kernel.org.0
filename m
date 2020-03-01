Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCDB174F02
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 19:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgCASxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 13:53:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57692 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCASxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 13:53:24 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j8Thm-0000Kp-An; Sun, 01 Mar 2020 18:52:46 +0000
Date:   Sun, 1 Mar 2020 19:52:44 +0100
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
Message-ID: <20200301185244.zkofjus6xtgkx4s3@wittgenstein>
References: <AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAG48ez3QHVpMJ9Rb_Q4LEE6uAqQJeS1Myu82U=fgvUfoeiscgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez3QHVpMJ9Rb_Q4LEE6uAqQJeS1Myu82U=fgvUfoeiscgw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 01, 2020 at 07:21:03PM +0100, Jann Horn wrote:
> On Sun, Mar 1, 2020 at 12:27 PM Bernd Edlinger
> <bernd.edlinger@hotmail.de> wrote:
> > The proposed solution is to have a second mutex that is
> > used in mm_access, so it is allowed to continue while the
> > dying threads are not yet terminated.
> 
> Just for context: When I proposed something similar back in 2016,
> https://lore.kernel.org/linux-fsdevel/20161102181806.GB1112@redhat.com/
> was the resulting discussion thread. At least back then, I looked
> through the various existing users of cred_guard_mutex, and the only
> places that couldn't be converted to the new second mutex were
> PTRACE_ATTACH and SECCOMP_FILTER_FLAG_TSYNC.
> 
> 
> The ideal solution would IMO be something like this: Decide what the
> new task's credentials should be *before* reaching de_thread(),
> install them into a second cred* on the task (together with the new
> dumpability), drop the cred_guard_mutex, and let ptrace_may_access()
> check against both. After that, some further restructuring might even

Hm, so essentially a private ptrace_access_cred member in task_struct?
That would presumably also involve altering various LSM hooks to look at
ptrace_access_cred.

(Minor side-note, de_thread() takes a struct task_struct argument but
 only ever is passed current.)

> allow the cred_guard_mutex to not be held across all of the VFS
> operations that happen early on in execve, which may block
> indefinitely. But that would be pretty complicated, so I think your
> proposed solution makes sense for now, given that nobody has managed
> to implement anything better in the last few years.

Reading through the old threads and how often this issue came up, I tend
to agree.
