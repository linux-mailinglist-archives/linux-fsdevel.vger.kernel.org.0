Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B7C174F61
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 21:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgCAUAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 15:00:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32899 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAUAu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 15:00:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id w6so7657649otk.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2020 12:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSJCogFW+5WEfqSVoqYuW5WPipQ09ya4rXn8XpVI9lk=;
        b=geEqLlC1SOE3TSZPMu4eY2C7kEQ3iAEu8+MjDZth1yJJEz3aYIl8RZzNGqXKo+fdBK
         L3piqmGBZ+R6u2jb71FG+otXTb5dexaFNTIMqfdFtBwyUv8J83uWWiWpJL700olDe1KU
         jdQ95KSTEviW1p++P8rmN10buW8MUjs1Ce5bxgvibleP8FVy2pIqdkf+iVbKv0OxIfep
         R3lnoXwspaouzFJKvOL2TU0Ri+Z9X4sJEOZJahs/nnjs5Uj7mCy6y8dFFjwiRQtUui/3
         PYeYJCJjLDd5jpik81hu7laW8Arud8MEejgRzp/E94E5OSXDgeoA9nO6m2RJMQ1ob9wA
         F/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSJCogFW+5WEfqSVoqYuW5WPipQ09ya4rXn8XpVI9lk=;
        b=Emm83qppG5InQwjBFCmNCptItTK8QRV/3sWEYhIyR5xa0K1NIfrgcQIc1+rDDYgNkj
         fFgDnmjwXbTKfo9rAZha7yJc17ADgQLTAn7EfCTjGcTye0zSYFJKmFM0l6POiT09hJtp
         z6tCBLvIdC8u2jWj6ML+q8fvS8kXz4B8PSHL1j0dWnkCfsrb9l9s5xW/jZg5lKvL77AS
         Py8VB8XJKWd9V0UXACpAnpWqfM/erMkbTNs1lhy6k0Fz5taZMPqw868tD3t4H1vd/wWd
         v1XT+S6L7RKlK/qXn7VPekOWXi6FteTQqSiir338n6J/Hwbq6J+DdRqOftLMtdWIm6EU
         83HQ==
X-Gm-Message-State: APjAAAWpR//O087Wfv/44JBVIwtVWalK/h/N28HVhFm0k3/1nAKI+9Vm
        lrmXhOLyrUGuX9c7qlBrsfJQnQUeUICH5WixSvHdQA==
X-Google-Smtp-Source: APXvYqxlPmGGj6lqZ/+U20/sqfXaMGOTkoLMW6nyRqaPvY8us5RwnrwLaHiGmuMsLhOUI/kEd8nfooddFe4/2Iz0+l8=
X-Received: by 2002:a9d:5e8b:: with SMTP id f11mr10976903otl.110.1583092849244;
 Sun, 01 Mar 2020 12:00:49 -0800 (PST)
MIME-Version: 1.0
References: <AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAG48ez3QHVpMJ9Rb_Q4LEE6uAqQJeS1Myu82U=fgvUfoeiscgw@mail.gmail.com> <20200301185244.zkofjus6xtgkx4s3@wittgenstein>
In-Reply-To: <20200301185244.zkofjus6xtgkx4s3@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 1 Mar 2020 21:00:22 +0100
Message-ID: <CAG48ez3mnYc84iFCA25-rbJdSBi3jh9hkp569XZTbFc_9WYbZw@mail.gmail.com>
Subject: Re: [PATCH] exec: Fix a deadlock in ptrace
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 1, 2020 at 7:52 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Sun, Mar 01, 2020 at 07:21:03PM +0100, Jann Horn wrote:
> > On Sun, Mar 1, 2020 at 12:27 PM Bernd Edlinger
> > <bernd.edlinger@hotmail.de> wrote:
> > > The proposed solution is to have a second mutex that is
> > > used in mm_access, so it is allowed to continue while the
> > > dying threads are not yet terminated.
> >
> > Just for context: When I proposed something similar back in 2016,
> > https://lore.kernel.org/linux-fsdevel/20161102181806.GB1112@redhat.com/
> > was the resulting discussion thread. At least back then, I looked
> > through the various existing users of cred_guard_mutex, and the only
> > places that couldn't be converted to the new second mutex were
> > PTRACE_ATTACH and SECCOMP_FILTER_FLAG_TSYNC.
> >
> >
> > The ideal solution would IMO be something like this: Decide what the
> > new task's credentials should be *before* reaching de_thread(),
> > install them into a second cred* on the task (together with the new
> > dumpability), drop the cred_guard_mutex, and let ptrace_may_access()
> > check against both. After that, some further restructuring might even
>
> Hm, so essentially a private ptrace_access_cred member in task_struct?

And a second dumpability field, because that changes together with the
creds during execve. (Btw, currently the dumpability is in the
mm_struct, but that's kinda wrong. The mm_struct is removed from a
task on exit while access checks can still be performed against it, and
currently ptrace_may_access() just lets the access go through in that
case, which weakens the protection offered by PR_SET_DUMPABLE when
used for security purposes. I think it ought to be moved over into the
task_struct.)

> That would presumably also involve altering various LSM hooks to look at
> ptrace_access_cred.

When I tried to implement this in the past, I changed the LSM hook to
take the target task's cred* as an argument, and then called the LSM
hook twice from ptrace_may_access(). IIRC having the target task's
creds as an argument works for almost all the LSMs, with the exception
of Yama, which doesn't really care about the target task's creds, so
you have to pass in both the task_struct* and the cred*.
