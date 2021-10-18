Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1CD431FC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhJROeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhJROeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:34:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EC2C06161C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 07:32:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so81014pjd.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WWm9aJ7sj7+jdCgWihvW1SzD+d69W9pL0SQGXhJXr1I=;
        b=ogglsAG7CbcRaju3WkexVJzz6WoLN3CLqMlRm2JJxq+J1mrxRRTdmxvBuRyrBoykut
         ZURmztVXiPiT2Wi09hNULghIBjvTmSXlewYdsfnlQojO0kfPFDwTG1HYu6GOrrTCZ5nW
         rFdrUBIsmhuXrcFHI5xzG0VyWX7J/AaNk8d4Zb1gaP85lTtaMWtnDJB52R2m02c7ClKQ
         VP3tpivoSabcFg7uBNd9ovNGMvCoLJb5D4qWJP5Be5++qlpbJQzuwWffzPC0XrSJRdZj
         ZBCxlmsdFyWsMXEpPWegjiUeAgMOPpWRKzENgouEg6t/yyFEUYlvGnWHGMWeJiDN0KoP
         Pm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WWm9aJ7sj7+jdCgWihvW1SzD+d69W9pL0SQGXhJXr1I=;
        b=jPDKWXvsgG2pVszjMLeDfE9BVq13WiK4wmqQp7qIJIB/VY0NTEmpeglRWxBLKr4JqQ
         CqXQrmCwV00sChGIOvEn+2P4/fnLu0U7Q3s+Tks04RCUnp7FuHKny9YT/MQphs5lybT6
         Q9IfxbrP/uvvSK4dXzdM2WDvi6+oKOuPeQFKCIPRKpzQSI9Dl1VMk4fw0N+2AYbwoBiZ
         hzziHFPdYq5l7cQuTUWIthpM6e0Lw08Y02KWlcXFvSXXNE0E/mCmqeVxBI5XGgRnrK03
         nkj3FG0i03ycoINeVtjlnRfVUrh9iA08Phaiw2wLy46fT6hGnsGh6EeycC1LE8OvQ9ax
         Cocg==
X-Gm-Message-State: AOAM532elCuIm959lIizi4bfp3dHr5xig2nF5mlSkmBJKgL/krrT0/Ip
        gS0Jc+JFjtwwmaGRTfY43PYRZODg8h9f7qd2MzKcLA==
X-Google-Smtp-Source: ABdhPJywDUyRc0wYjspci/5L7PV7QtxjrEYac/ynHQpCgatgArKWjxzReSm0gwjUhsH76Hi+yRjMruhu0P1YmiZUY9g=
X-Received: by 2002:a17:90a:62ca:: with SMTP id k10mr33711933pjs.38.1634567529712;
 Mon, 18 Oct 2021 07:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHS8izMpzTvd5=x_xMhDJy1toV-eT3AS=GXM2ObkJoCmbDtz6w@mail.gmail.com>
 <YW13pS716ajeSgXj@dhcp22.suse.cz>
In-Reply-To: <YW13pS716ajeSgXj@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 18 Oct 2021 07:31:58 -0700
Message-ID: <CAHS8izMnkiHtNLEzJXL64zNinbEp0oU96dPCJYfqJqk4AEQW2A@mail.gmail.com>
Subject: Re: [RFC Proposal] Deterministic memcg charging for shared memory
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>, cgroups@vger.kernel.org,
        riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 6:33 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 13-10-21 12:23:19, Mina Almasry wrote:
> > Below is a proposal for deterministic charging of shared memory.
> > Please take a look and let me know if there are any major concerns:
> >
> > Problem:
> > Currently shared memory is charged to the memcg of the allocating
> > process. This makes memory usage of processes accessing shared memory
> > a bit unpredictable since whichever process accesses the memory first
> > will get charged. We have a number of use cases where our userspace
> > would like deterministic charging of shared memory:
> >
> > 1. System services allocating memory for client jobs:
> > We have services (namely a network access service[1]) that provide
> > functionality for clients running on the machine and allocate memory
> > to carry out these services. The memory usage of these services
> > depends on the number of jobs running on the machine and the nature of
> > the requests made to the service, which makes the memory usage of
> > these services hard to predict and thus hard to limit via memory.max.
> > These system services would like a way to allocate memory and instruct
> > the kernel to charge this memory to the client=E2=80=99s memcg.
> >
> > 2. Shared filesystem between subtasks of a large job
> > Our infrastructure has large meta jobs such as kubernetes which spawn
> > multiple subtasks which share a tmpfs mount. These jobs and its
> > subtasks use that tmpfs mount for various purposes such as data
> > sharing or persistent data between the subtask restarts. In kubernetes
> > terminology, the meta job is similar to pods and subtasks are
> > containers under pods. We want the shared memory to be
> > deterministically charged to the kubernetes's pod and independent to
> > the lifetime of containers under the pod.
> >
> > 3. Shared libraries and language runtimes shared between independent jo=
bs.
> > We=E2=80=99d like to optimize memory usage on the machine by sharing li=
braries
> > and language runtimes of many of the processes running on our machines
> > in separate memcgs. This produces a side effect that one job may be
> > unlucky to be the first to access many of the libraries and may get
> > oom killed as all the cached files get charged to it.
> >
> > Design:
> > My rough proposal to solve this problem is to simply add a
> > =E2=80=98memcg=3D/path/to/memcg=E2=80=99 mount option for filesystems (=
namely tmpfs):
> > directing all the memory of the file system to be =E2=80=98remote charg=
ed=E2=80=99 to
> > cgroup provided by that memcg=3D option.
>
> Could you be more specific about how this matches the above mentioned
> usecases?
>

For the use cases I've listed respectively:
1. Our network service would mount a tmpfs with 'memcg=3D<path to
client's memcg>'. Any memory the service is allocating on behalf of
the client, the service will allocate inside of this tmpfs mount, thus
charging it to the client's memcg without risk of hitting the
service's limit.
2. The large job (kubernetes pod) would mount a tmpfs with
'memcg=3D<path to large job's memcg>. It will then share this tmpfs
mount with the subtasks (containers in the pod). The subtasks can then
allocate memory in the tmpfs, having it charged to the kubernetes job,
without risk of hitting the container's limit.
3. We would need to extend this functionality to other file systems of
persistent disk, then mount that file system with 'memcg=3D<dedicated
shared library memcg>'. Jobs can then use the shared library and any
memory allocated due to loading the shared library is charged to a
dedicated memcg, and not charged to the job using the shared library.

> What would/should happen if the target memcg doesn't or stop existing
> under remote charger feet?
>

My thinking is that the tmpfs acts as a charge target to the memcg and
blocks the memcg from being removed until the tmpfs mount is
unmounted, similarly to when a user tries to rmdir a memcg with some
processes still attached to it. But I don't feel strongly about this,
and I'm happy to go with another approach if you have a strong opinion
about this.

> > Caveats:
> > 1. One complication to address is the behavior when the target memcg
> > hits its memory.max limit because of remote charging. In this case the
> > oom-killer will be invoked, but the oom-killer may not find anything
> > to kill in the target memcg being charged. In this case, I propose
> > simply failing the remote charge which will cause the process
> > executing the remote charge to get an ENOMEM This will be documented
> > behavior of remote charging.
>
> Say you are in a page fault (#PF) path. If you just return ENOMEM then
> you will get a system wide OOM killer via pagefault_out_of_memory. This
> is very likely not something you want, right? Even if we remove this
> behavior, which is another story, then the #PF wouldn't have other ways
> than keep retrying which doesn't really look great either.
>
> The only "reasonable" way I can see right now is kill the remote
> charging task. That might result in some other problems though.
>

Yes! That's exactly what I was thinking, and from discussions with
userspace folks interested in this it doesn't seem like a problem.
We'd kill the remote charging task and make it clear in the
documentation that this is the behavior and the userspace is
responsible for working around that.

Worthy of mention is that if processes A and B are sharing memory via
a tmpfs, they can set memcg=3D<common ancestor memcg of A and B>. Thus
the memory is charged to a common ancestor of memcgs A and B and if
the common ancestor hits its limit the oom-killer will get invoked and
should always find something to kill. This will also be documented and
the userspace can choose to go this route if they don't want to risk
being killed on pagefault.

> > 2. I would like to provide an initial implementation that adds this
> > support for tmpfs, while leaving the implementation generic enough for
> > myself or others to extend to more filesystems where they find the
> > feature useful.
>
> How do you envision other filesystems would implement that? Should the
> information be persisted in some way?
>

Yes my initial implementation has a struct memcg* hanging off the
super block that is the memcg to charge, but I can move it if there is
somewhere else you feel is appropriate once I send out the patches.

> I didn't have time to give this a lot of thought and more questions will
> likely come. My initial reaction is that this will open a lot of
> interesting corner cases which will be hard to deal with.

Thank you very much for your review so far and please let me know if
you think of any more issues. My feeling is that hitting the remote
memcg limit and the oom-killing behavior surrounding that is by far
the most contentious issue. You don't seem completely revolted by what
I'm proposing there so I'm somewhat optimistic we can deal with the
rest of the corner cases :-)

> --
> Michal Hocko
> SUSE Labs
