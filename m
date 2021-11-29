Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167F4460EA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 07:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbhK2GFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 01:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbhK2GDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 01:03:44 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779B4C061746
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Nov 2021 22:00:27 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b40so41562356lfv.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Nov 2021 22:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3XIPX0Sy/WFxQqRpwpMOc12u3lcYQgxcaCeM2KbawEo=;
        b=ST1yI7L6iFAjlkWb07dnLWner7Yky+AozeeHOwIeWQalCBDcPu94pXJDwyYTaG8HM4
         X6AquTaSZA2diyzOQ+KSCIN4ihojb5gfGERc9/enQXP+4i9WLUOqtvfhA2N5MxWD6tqU
         r5wNGLBfdaz73HIRF+l/8UsySGPc64Y3K1KtqCfImlNbkWQ79uQWWN6y9cA1H/Hg1uSc
         bbyu45FfYwQ2lqoFuqKbBHGkqdFR5ya0Tjs4vxDBs0tO22YFDdaN/z2jVYpLUo1wTynj
         1RVAxLVtQNg0obqbQdKvwLcnUodaf/o2JUX55Om47Td0s3n4McEnHT+NxWcSUdxTP5b6
         AW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XIPX0Sy/WFxQqRpwpMOc12u3lcYQgxcaCeM2KbawEo=;
        b=jW1+va2RsMV/sKRGjpBv4gVXt/4nc0YqLnArbCKs9um9mTTROl9HxqqF/Kpvroycw8
         DSeFlq6UpGeQLgdsOHhzjoWX42Y13bR/ZlP+ORjR5iF2AOgKwxMTyoj7qEjSja2uJiUa
         bDIyvBgyQLm3b0fCIaCbZFfapDPSLHimigw7FmKBB+3rzk7Dqul/YRoLSUwH6BmUuzdP
         NNJcLQGeUds7RHsJ/A8z1LgKamsR9+vwAKYD+z2i6d81ANbcvakfN9CylEUrVnUfGxZ7
         pmDNta1OgNXIYSNDAvTUbk2vOYhg1uh2NadHAKMf0+GL5233EqR9zPaIlcAugZeeYKx3
         i9Fw==
X-Gm-Message-State: AOAM532hCK5GSAHKLy6pSxzkt/pI6HaLY0w2gSZdH5xMnp1Q1cdDQV+B
        ih0NwXkHwelGarg3eAppZwCngc8woHAjwOSJPT5kPg==
X-Google-Smtp-Source: ABdhPJw4bqBcC/IR3yxpfJoI2ZERdlrMlXZc5FAJjoyN5VcOIZOzbqFX27L11JUytmx/SFYwI/2soaSqJ5bTIe0P3sc=
X-Received: by 2002:a05:6512:32c6:: with SMTP id f6mr45680089lfg.40.1638165624879;
 Sun, 28 Nov 2021 22:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20211120045011.3074840-1-almasrymina@google.com> <YZvppKvUPTIytM/c@cmpxchg.org>
In-Reply-To: <YZvppKvUPTIytM/c@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 28 Nov 2021 22:00:13 -0800
Message-ID: <CALvZod6ZEU8upWWdYwZ3KVbEK0eM7o0CM2GXy8Sn4SYcGo8jHQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Deterministic charging of shared memory
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Johannes,

On Mon, Nov 22, 2021 at 11:04 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
[...]
> Here is one idea:
>
> Have you considered reparenting pages that are accessed by multiple
> cgroups to the first common ancestor of those groups?
>
> Essentially, whenever there is a memory access (minor fault, buffered
> IO) to a page that doesn't belong to the accessing task's cgroup, you
> find the common ancestor between that task and the owning cgroup, and
> move the page there.
>
> With a tree like this:
>
>         root - job group - job
>                         `- job
>             `- job group - job
>                         `- job
>
> all pages accessed inside that tree will propagate to the highest
> level at which they are shared - which is the same level where you'd
> also set shared policies, like a job group memory limit or io weight.
>
> E.g. libc pages would (likely) bubble to the root, persistent tmpfs
> pages would bubble to the respective job group, private data would
> stay within each job.
>
> No further user configuration necessary. Although you still *can* use
> mount namespacing etc. to prohibit undesired sharing between cgroups.
>
> The actual user-visible accounting change would be quite small, and
> arguably much more intuitive. Remember that accounting is recursive,
> meaning that a job page today also shows up in the counters of job
> group and root. This would not change. The only thing that IS weird
> today is that when two jobs share a page, it will arbitrarily show up
> in one job's counter but not in the other's. That would change: it
> would no longer show up as either, since it's not private to either;
> it would just be a job group (and up) page.
>
> This would be a generic implementation of resource sharing semantics:
> independent of data source and filesystems, contained inside the
> cgroup interface, and reusing the existing hierarchies of accounting
> and control domains to also represent levels of common property.
>
> Thoughts?

Before commenting on your proposal, I would like to clarify that the
use-cases given are not specific to us but are more general. Though I
think you are arguing that the implementation is not general purpose
which I kind of agree with.

Let me take a stab again at describing these use-cases which I think
can be partitioned based on the relationship of the entities
sharing/accessing the memory among them. (Sorry for repeating these
because I think we should keep these in mind while discussing the
possible solutions).

1) Mutually trusted entities sharing memory for collaborative work.
One example is a file-system shared between sub-tasks of a meta-job.
(Mina's second use-case).

2) Independent entities sharing memory to reduce cost. Examples
include shared libraries, packages or tool chains. (Mina's third
use-case).

3) One entity observing or monitoring another entity. Examples include
gdb, ptrace, uprobes, VM or process migration and checkpointing.

4) Server-Client relationship. (Mina's first use-case.

Let me put (3) out of the way first as these operations have special
interfaces and the target entity is a process (not a cgroup). Remote
charging works for these and no new oom corner cases are introduced.

For (1) and (2), I think your proposal aligns pretty well with them
but one important property is still missing which we are very adamant
about i.e. 'deterministic charge'. To explain with an example, suppose
two instances of the same job are running on two different systems. On
one system, it is sharing a shared library with an unrelated job and
the second instance is using that library alone. The owner will see
different memory usage for both instances which can mess with their
resource planning.

However I think this can be solved very easily with an opt-in add-on.
The node controller knows upfront the libraries/packages which can be
shared between the jobs and is responsible for creating the cgroup
hierarchy (at least the top level) for the jobs. It can create a
common ancestor for all such jobs and let the kernel know that if any
descendant accesses these libraries, charge to this specific ancestor.
If someone out of this sub-hierarchy accesses the memory, follow the
proposal i.e. common ancestor. With this specific opt-in add-on, all
job owners will see their job usage more consistent.

[I am putting this as a brainstorming discussion] Regarding (4), for
our use-case, the server wants the cost of the memory needed to serve
a client to be paid by the corresponding client. Please note that the
memory is not necessarily accessed by the client.

Now we can argue that this use-case can be served similar to (3) i.e.
through a special interface/syscall. I think that would be challenging
particularly when the lifetime of a client 'process' is independent of
the memory needed to serve that client.

Another way is to disable the accounting of that specific memory
needed to serve the clients (I think Roman suggested a similar notion
as disabling accounting of a tmpfs). Any other ideas?

thanks,
Shakeel
