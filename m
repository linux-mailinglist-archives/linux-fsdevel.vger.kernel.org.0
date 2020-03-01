Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0B9174EED
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 19:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCASVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 13:21:31 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41732 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCASVa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 13:21:30 -0500
Received: by mail-ot1-f67.google.com with SMTP id v19so7478032ote.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2020 10:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vl+p/47GQAMvlM1on1gMGR7KlW+3+hbOHuckhCOrwj8=;
        b=bX0rE7/Kbt+xy/GSs67GMlp7VaEG4nm8/Urc8KQQABYyaPFqpHwWxlJXGJfWtklvZc
         K4GWxp0lyiEPXaEiIICPIVAdueUja2k/3XpMJW5cpWctmz2HKNCQ7rdD51729m6QPyem
         +85M/LvlHc5U93Uv0pE0P56swR582muuOw8IotQrUp8TAFpkt+Xs6+kdDJp0TO/40xM4
         7Oh2sappSmX8it1XfO+o7tYZ5PY70aijZzD2RvZLBlILFMGxEqZf4SK3BZJskUxfcsjB
         Q0mDqlgPfTEVyaumTAB4RSMPcMhonT4qZ1aUpFQuHM0WHk+Y03k/cX9oR825i7llamx1
         8T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vl+p/47GQAMvlM1on1gMGR7KlW+3+hbOHuckhCOrwj8=;
        b=Y6Tn4TCLsGVhkt+6xuXlwamVVbhTEI6cUvwZKm6K1FFFdygeDaxw7G6TBNx1CqfPLz
         EgIQ9uGMxcZ0JjAX2ge5ATLSgdtTTY+EsMBydzbJWJ+DjGi4Nh472YMXgIc7KHC2s69L
         ideZ7bqDXOloqbKTIsqw9XU+fGp0SFJBqRIbulIVgsnqXBHvWczbszurKE9LBPrvVFAt
         WbzG411AGjMj5sRT52cvuSDupltQv44zwa0LI4lMWwhmIw6Ah9/BTxv41RNeVmEKO6yN
         u3HjJeTnRr3jykCe5ByMX3XbUU37WpzDJtZ8KLySdfy46NsYvDOSUgRBrAfm9XkkoCmD
         75lg==
X-Gm-Message-State: APjAAAXv6ly08mtYF6rFeh6ESUayOK4gBgO+qVq9UFKpvTet4TjxDJE9
        j+4zDYZSF9K/lxb6CTTKwehqdioPj/RVcMFX/2mNpg==
X-Google-Smtp-Source: APXvYqw6D45LqFPVIa5UnAzmqeAgyvkzqYARvALZry1klV1ny8N/BcDkUfrvPSLaIdAoHd8oI1tIwV03Dfkn7rQ5H54=
X-Received: by 2002:a9d:5e8b:: with SMTP id f11mr10758287otl.110.1583086889943;
 Sun, 01 Mar 2020 10:21:29 -0800 (PST)
MIME-Version: 1.0
References: <AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 1 Mar 2020 19:21:03 +0100
Message-ID: <CAG48ez3QHVpMJ9Rb_Q4LEE6uAqQJeS1Myu82U=fgvUfoeiscgw@mail.gmail.com>
Subject: Re: [PATCH] exec: Fix a deadlock in ptrace
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        Christian Brauner <christian.brauner@ubuntu.com>,
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

On Sun, Mar 1, 2020 at 12:27 PM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
> The proposed solution is to have a second mutex that is
> used in mm_access, so it is allowed to continue while the
> dying threads are not yet terminated.

Just for context: When I proposed something similar back in 2016,
https://lore.kernel.org/linux-fsdevel/20161102181806.GB1112@redhat.com/
was the resulting discussion thread. At least back then, I looked
through the various existing users of cred_guard_mutex, and the only
places that couldn't be converted to the new second mutex were
PTRACE_ATTACH and SECCOMP_FILTER_FLAG_TSYNC.


The ideal solution would IMO be something like this: Decide what the
new task's credentials should be *before* reaching de_thread(),
install them into a second cred* on the task (together with the new
dumpability), drop the cred_guard_mutex, and let ptrace_may_access()
check against both. After that, some further restructuring might even
allow the cred_guard_mutex to not be held across all of the VFS
operations that happen early on in execve, which may block
indefinitely. But that would be pretty complicated, so I think your
proposed solution makes sense for now, given that nobody has managed
to implement anything better in the last few years.
