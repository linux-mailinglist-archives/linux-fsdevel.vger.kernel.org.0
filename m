Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABF363F8E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 21:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiLAUSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 15:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiLAUSr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:18:47 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B63CBEC78
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 12:18:46 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id d185so2784789vsd.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Dec 2022 12:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wKwMHNRDEyrqfNNtqjeN2AckKw8W+9jAhp6b0tHJzAg=;
        b=QGBpRqlAhom0bP5ghs++SQ0kVKw7xKay94rq3h+eTb0N0vxtK7JKHE1ro5HyTbIp+h
         +/r6zZIobiB3m2dIWO5sz5Me+B0IMVDB4f9c+dN+wiU4SXzO10PkjgvSOapu/LOK0YP+
         OCifArNT1zm6fCtnRyZ2nQrzjmpRWhCeP3wqH2XaqCU8dmNbynWRkf/8+IjxqWMIk5Jr
         1vNfXYnATqYbFCt+w0gmSfhEYH3oB7whUysg2oU7JbaXz+Qa/as8WVgs/rpKSFtOgDex
         SoH5IisPZjKW+Mnp8h/ETnV867Ez9oUpm1teUOTCw3dg/TprMb/0VY/gXUqrW4+xaiVM
         t8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKwMHNRDEyrqfNNtqjeN2AckKw8W+9jAhp6b0tHJzAg=;
        b=mqaU7Du+ex+PJ3S4B/MPY8zTQV1kVuenJE4K9oO5NpHw7bqp3j+yNevqjLnfxEikv8
         z9cB1/2R+18aorZqiRaZszmhfoq5T9DkbBvbMV7ezhB35Ntq60gTmUhxM1yHRe8XgF2g
         nzrFXc4YsInRY5B8OqRL7ZjkzhlAvjk6BbCEpP2ZjkolzyRn253owwatJCIMTiVgnRSA
         ZHyXb4xcvh7yTLAsbYas89FL0DPKm7bYVoveFHca/uBIEC0zzGGtCloM/tL/bKHF8gnx
         AvLz7xGWOqLulJc6/A9v18SAkQLa8fDp7iEdY46NSYrZzffgyY2hLJZcTIBOFQCvBZqu
         06jw==
X-Gm-Message-State: ANoB5pkNxJtH3vrGg0oKEs0SBPgKQ6p38CAdYbhfXptd+h5TmSYPEWa8
        9varXufLq4JDo4MwUGCmsoPAop40U2b5RX7iw0JSlA==
X-Google-Smtp-Source: AA0mqf7lzC6HDmJ36ZEfupvHktoyf8OOlp8FVnaZCzxKkjEB1ctoWbC+2lFW3z+tLBPC6ewQWqfSTXfe+yikfF4shL0=
X-Received: by 2002:a67:ea04:0:b0:3a7:d7bc:c2e9 with SMTP id
 g4-20020a67ea04000000b003a7d7bcc2e9mr29491950vso.61.1669925925058; Thu, 01
 Dec 2022 12:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20221130070158.44221-1-chengkaitao@didiglobal.com> <Y4fnRyIp17NXpti9@P9FQF9L96D.corp.robot.car>
In-Reply-To: <Y4fnRyIp17NXpti9@P9FQF9L96D.corp.robot.car>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 1 Dec 2022 12:18:33 -0800
Message-ID: <CAHS8izN3ej1mqUpnNQ8c-1Bx5EeO7q5NOkh0qrY_4PLqc8rkHA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     chengkaitao <pilgrimtao@gmail.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        mhocko@kernel.org, shakeelb@google.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, cgel.zte@gmail.com,
        ran.xiaokai@zte.com.cn, viro@zeniv.linux.org.uk,
        zhengqi.arch@bytedance.com, ebiederm@xmission.com,
        Liam.Howlett@oracle.com, chengzhihao1@huawei.com,
        haolee.swjtu@gmail.com, yuzhao@google.com, willy@infradead.org,
        vasily.averin@linux.dev, vbabka@suse.cz, surenb@google.com,
        sfr@canb.auug.org.au, mcgrof@kernel.org, sujiaxun@uniontech.com,
        feng.tang@intel.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 30, 2022 at 3:29 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Wed, Nov 30, 2022 at 03:01:58PM +0800, chengkaitao wrote:
> > From: chengkaitao <pilgrimtao@gmail.com>
> >
> > We created a new interface <memory.oom.protect> for memory, If there is
> > the OOM killer under parent memory cgroup, and the memory usage of a
> > child cgroup is within its effective oom.protect boundary, the cgroup's
> > tasks won't be OOM killed unless there is no unprotected tasks in other
> > children cgroups. It draws on the logic of <memory.min/low> in the
> > inheritance relationship.
> >
> > It has the following advantages,
> > 1. We have the ability to protect more important processes, when there
> > is a memcg's OOM killer. The oom.protect only takes effect local memcg,
> > and does not affect the OOM killer of the host.
> > 2. Historically, we can often use oom_score_adj to control a group of
> > processes, It requires that all processes in the cgroup must have a
> > common parent processes, we have to set the common parent process's
> > oom_score_adj, before it forks all children processes. So that it is
> > very difficult to apply it in other situations. Now oom.protect has no
> > such restrictions, we can protect a cgroup of processes more easily. The
> > cgroup can keep some memory, even if the OOM killer has to be called.
>
> It reminds me our attempts to provide a more sophisticated cgroup-aware oom
> killer. The problem is that the decision which process(es) to kill or preserve
> is individual to a specific workload (and can be even time-dependent
> for a given workload). So it's really hard to come up with an in-kernel
> mechanism which is at the same time flexible enough to work for the majority
> of users and reliable enough to serve as the last oom resort measure (which
> is the basic goal of the kernel oom killer).
>
> Previously the consensus was to keep the in-kernel oom killer dumb and reliable
> and implement complex policies in userspace (e.g. systemd-oomd etc).
>
> Is there a reason why such approach can't work in your case?
>

FWIW we run into similar issues and the systemd-oomd approach doesn't
work reliably enough for us to disable the kernel oom-killer. The
issue as I understand is when the machine is under heavy memory
pressure our userspace oom-killer fails to run quickly enough to save
the machine from getting completely stuck. Why our oom-killer fails to
run is more nuanced. There are cases where it seems stuck to itself to
acquire memory to do the oom-killing or stuck on some lock that needs
to be released by a process that itself is stuck trying to acquire
memory to release the lock, etc.

When the kernel oom-killer does run we would like to shield the
important jobs from it and kill the batch jobs or restartable
processes instead. So we have a similar feature to what is proposed
here internally. Our design is a bit different. For us we enable the
userspace to completely override the oom_badness score pretty much:

1. Every process has /proc/pid/oom_score_badness which overrides the
kernel's calculation if set.
2. Every memcg has a memory.oom_score_badness which indicates this
memcg's oom importance.

On global oom the kernel pretty much kills the baddest process in the
badesset memcg, so we can 'protect' the important jobs from
oom-killing that way.

I haven't tried upstreaming this because I assume there would be
little appetite for it in a general use case, but if the general use
case is interesting for some it would be good to collaborate on some
way for folks that enable the kernel oom-killer to shield certain jobs
that are important.

> Thanks!
>
