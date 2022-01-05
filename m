Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2D8485275
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 13:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiAEMat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 07:30:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230194AbiAEMas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 07:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641385848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VgG4KK5XY7QuLFhMaH2G4gMvFu7AUMJFT8YUBr9jjwA=;
        b=a254q8fig8gXHKzxxOecQoRowU4o/Qv2B+yjYpVHjKT9/ggZA4MN4EOGXBcHjUugu1J0Zr
        jNaMLMUAOuIzvmTfrOKtuKsHWRfwVqCnFUUYBKJHQf+p5YDAX/Y5++iHe5Knk1pUiNnZ20
        8D+r3AO9B7/+vvSJMwwxq8rAEJyq5uM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-ajgBxIj1OrOiGWdzsrK-PA-1; Wed, 05 Jan 2022 07:30:47 -0500
X-MC-Unique: ajgBxIj1OrOiGWdzsrK-PA-1
Received: by mail-ed1-f70.google.com with SMTP id z3-20020a05640240c300b003f9154816ffso18653262edb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jan 2022 04:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgG4KK5XY7QuLFhMaH2G4gMvFu7AUMJFT8YUBr9jjwA=;
        b=PH/39ssjRNg0Uw5g6LPAsBkZpfanAP5TwQPjS/T2D2rAKDMFExr6UKkeB3cbGQRN+7
         tjAjq93KC+08SKz4vq2JQ9ycvKCiWqNjhMXi7MnDcIfDRoR0R6LIJp6tIsfQFvvh9KA3
         h0Prr8YfXOHZaOUm0nfCE4DCoqjxVmk0Z5Gj2bt1o+sToyp0ktXdBF7IVevtUwH/z537
         vTP2mD664Hcn/dCd6aXZp9fYX5hQOynzItpn1lCTQwvgeMOxaFYaWZn0p4caDxESbatL
         0S90Xh0qy/bFebFQ0hgg8ENfKoVha1swOn8OCkJ/BxFfkjUiEyt50z2A1fyl26qju0sY
         siqA==
X-Gm-Message-State: AOAM532HS32qIZ9AZ+otkeG6OgNXKtJNDt95Od9gGbpbQQ8cwrn13dhD
        ty0iI0QonzS24DjbJpBBzVTOrJ+65RFOgWzqAbxjwoU92EaMJb47IrhSK7eot0wutj6XM9KBjju
        biD3axme/LkbFma4Niym4Dux3FS6NbGrWP43aN5D4XQ==
X-Received: by 2002:aa7:dc14:: with SMTP id b20mr51495141edu.133.1641385845679;
        Wed, 05 Jan 2022 04:30:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxn5wSYRg5Hc12Tj64aOJqnCZak+k9m9EDAOK1D9iUwQAE8yNA3zYNOXHxCp/L/Dw+sRnf2Rc0DEXU9s4wPSbE=
X-Received: by 2002:aa7:dc14:: with SMTP id b20mr51495123edu.133.1641385845382;
 Wed, 05 Jan 2022 04:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20211228170910.623156-1-wander@redhat.com> <87ilv0mput.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ilv0mput.fsf@email.froward.int.ebiederm.org>
From:   Wander Costa <wcosta@redhat.com>
Date:   Wed, 5 Jan 2022 09:30:33 -0300
Message-ID: <CAAq0SUmw3fGtwDifbBMrD7jgPBGQb7uC0K9hJetVTRQO7boPtA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/4] coredump: mitigate privilege escalation of
 process coredump
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Rolf Eike Beer <eb@emlix.com>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 3, 2022 at 7:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Wander Lairson Costa <wander@redhat.com> writes:
>
> Have you seen the discussion at:
> https://lkml.kernel.org/r/20211221021744.864115-1-longman@redhat.com
> ?
>

No, I wasn't aware of this, thanks.

> Adding a few people from that conversation.
>
> > v2
> > ==
> >
> > Patch 02 conflicted with commit 92307383082d("coredump:  Don't perform
> > any cleanups before dumping core") which I didn't have in my tree. V2
> > just changes the hunk
> >
> > +#define PF_SUID   0x00000008
> >
> > To
> >
> > +#define PF_SUID   0x01000000
> >
> > To merge cleanly. Other than that, it is the same patch as v1.
> >
> > v1
> > ==
> >
> > A set-uid executable might be a vector to privilege escalation if the
> > system configures the coredump file name pattern as a relative
> > directory destiny. The full description of the vulnerability and
> > a demonstration of how we can exploit it can be found at [1].
> >
> > This patch series adds a PF_SUID flag to the process in execve if it is
> > set-[ug]id binary and elevates the new image's privileges.
> >
> > In the do_coredump function, we check if:
> >
> > 1) We have the SUID_FLAG set
> > 2) We have CAP_SYS_ADMIN (the process might have decreased its
> >    privileges)
> > 3) The current directory is owned by root (the current code already
> >    checks for core_pattern being a relative path).
> > 4) non-privileged users don't have permission to write to the current
> >    directory.
>
> Which is a slightly different approach than we have discussed
> previously.
>
> Something persistent to mark the processes descended from the suid exec
> is something commonly agreed upon.
>
> How we can dump core after that (with the least disruption is the
> remaining question).
>
> You would always allow coredumps unless the target directory is
> problematic.  I remember it being suggested that even dumping to a pipe
> might not be safe in practice.  Can someone remember why?
>
> The other approach we have discussed is simply not allowing coredumps
> unless the target process takes appropriate action to reenable them.
>
> Willy posted a patch to that effect.
>
>
> From a proof of concept perspective PF_SUID and your directory checks look
> like fine.  From a production implementation standpoint I think we would
> want to make them a bit more general.  PF_SUID because it is more than
> uid changes that can grant privilege during exec.  We especially want to
> watch out for setcap executables.  The directory checks similarly look
> very inflexible.  I think what we want is to test if the process before
> the privilege change of the exec could write to the directory.
>
> Even with your directory test approach you are going to run into
> the semi-common idio of becomming root and then starting a daemon
> in debugging mode so you can get a core dump.
>
> > If all four conditions match, we set the need_suid_safe flag.
> >
> > An alternative implementation (and more elegant IMO) would be saving
> > the fsuid and fsgid of the process in the task_struct before loading the
> > new image to the memory. But this approach would add eight bytes to all
> > task_struct instances where only a tiny fraction of the processes need
> > it and under a configuration that not all (most?) distributions don't
> > adopt by default.
>
> One possibility is to save a struct cred on the mm_struct.  If done
> carefully I think that would allow commit_creds to avoid the need
> for dumpability changes (there would always be enough information to
> directly compute it).
>
> I can see that working for detecting dropped privileges.  I don't know
> if that would work for raised privileges.
>
> Definitely focusing in on the mm_struct for where to save the needed
> information seems preferable, as in general it is an mm property not a
> per task property.
>

After reading the other thread and your comments, I came up with the
following idea:

- Create fields coredump_uid and coredump_gid in the mm_struct
- At fork time, copy the euid and egid to coredump_uid and coredump_gid.
- Only change coredump_uid/coredump_gid when the process changes its euid/egid.
- The do_coredump function already creates a local creds struct.
Change the code to set
its fsuid and fsgid to coredump_uid and coredump_gid.

This solution still has the inconvenience that a suid daemon probably
won't have the permission to
core dump by default. We can fix this by changing the setsid system
call to assign coredump_uid and coredump_gid
to euid and egid.

If it sounds reasonable, I can give this idea a try.


> Eric
>
>
>
> > Wander Lairson Costa (4):
> >   exec: add a flag indicating if an exec file is a suid/sgid
> >   process: add the PF_SUID flag
> >   coredump: mitigate privilege escalation of process coredump
> >   exec: only set the suid flag if the current proc isn't root
> >
> >  fs/coredump.c           | 15 +++++++++++++++
> >  fs/exec.c               | 10 ++++++++++
> >  include/linux/binfmts.h |  6 +++++-
> >  include/linux/sched.h   |  1 +
> >  kernel/fork.c           |  2 ++
> >  5 files changed, 33 insertions(+), 1 deletion(-)
>

