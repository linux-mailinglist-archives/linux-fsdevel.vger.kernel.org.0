Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01DD44EC4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhKLSC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 13:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhKLSCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 13:02:25 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C296C061767
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 09:59:34 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i12so9748545ila.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6FWsJvUFWayhY8ePzqwxfqSm+uqimRoHquPyN3bod4=;
        b=pOcgdEtKmvGA71hjumZT/MxPEHC50zxapDrdz8scR0Apuzc4LR7SZuiOSj/l+GJBCW
         oa5fA0BUm8gzn/Dhve/36mdUZQTznyp2QiiczqGB5uGPeujGMWC/UfflN6lSlhJn59dM
         gBFPmsqSOLPospqb/Y5RdFPfM93wKxcS7+12lcMs3N6PjJIHVXWvslcRh0jMnF53kQ4C
         msEUYivdrNqlWciPxKuhAnidDrA4KJeeJQSNQvfJib2dLbi5v4+A1fpbt0qU5Y7DQYuK
         ZnUkuTKV1EJiIAyF2FFqkfiPO1+HdR3+n51PwiTEK+NHLbpe8atAG3WPRFBkN/+YbKLz
         4hMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6FWsJvUFWayhY8ePzqwxfqSm+uqimRoHquPyN3bod4=;
        b=b+D7D3Q2li1li9BgEWBbPGX84Vt+Z06q6jOnfzaQ3kKI6RhbhHbiTbwKmWZL6o5gxH
         apu+Sy5znl2gzTiHIlxWp5Bok2b1puMH+oCnjuZMh1ccdDZ+rnk2dmGC1KVPRoMsaQuz
         o5P7vFgs91XHVat0IDgwWbsAwZHkKcIS69wyxm8w0T5Mm4/z+X2v74w230qBuxLMHahB
         jr0pAwrJ50octttIsq2XtOKxe+12+l4oWhOCzSic5eje7TIMUkguhL74dqpZBNbkCgxN
         DW+ITLvKCitoDtVLwX9QRFZdG2rm6FKG/BQMCBn2iS6hrXPArBcKE5DgLzwMTHgt8It/
         NqbA==
X-Gm-Message-State: AOAM533VfbKfEX2CqQfS1hSdsr9q1GmELF++YGFsUoh6SlMgRS3qD1qt
        vdbRtxPhGG0f1W+SzH+KPC84tix8m12mumajUmYBlw==
X-Google-Smtp-Source: ABdhPJzkglqW8kbM2LBUcT8ykUOgMV6rZfr5KnfWpvGG3jELu7LMZ4EfWMI+dS7aKG1Mft/eiJWzhEfnZ+AvRLWiFn0=
X-Received: by 2002:a05:6e02:1561:: with SMTP id k1mr10229268ilu.135.1636739973506;
 Fri, 12 Nov 2021 09:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20211111234203.1824138-1-almasrymina@google.com>
 <20211111234203.1824138-3-almasrymina@google.com> <YY4dHPu/bcVdoJ4R@dhcp22.suse.cz>
 <CAHS8izNMTcctY7NLL9+qQN8+WVztJod2TfBHp85NqOCvHsjFwQ@mail.gmail.com> <YY4nm9Kvkt2FJPph@dhcp22.suse.cz>
In-Reply-To: <YY4nm9Kvkt2FJPph@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 12 Nov 2021 09:59:22 -0800
Message-ID: <CAHS8izMjfwgiNEoJWGSub6iqgPKyyoMZK5ONrMV2=MeMJsM5sg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/oom: handle remote ooms
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 12, 2021 at 12:36 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 12-11-21 00:12:52, Mina Almasry wrote:
> > On Thu, Nov 11, 2021 at 11:52 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 11-11-21 15:42:01, Mina Almasry wrote:
> > > > On remote ooms (OOMs due to remote charging), the oom-killer will attempt
> > > > to find a task to kill in the memcg under oom, if the oom-killer
> > > > is unable to find one, the oom-killer should simply return ENOMEM to the
> > > > allocating process.
> > >
> > > This really begs for some justification.
> > >
> >
> > I'm thinking (and I can add to the commit message in v4) that we have
> > 2 reasonable options when the oom-killer gets invoked and finds
> > nothing to kill: (1) return ENOMEM, (2) kill the allocating task. I'm
> > thinking returning ENOMEM allows the application to gracefully handle
> > the failure to remote charge and continue operation.
> >
> > For example, in the network service use case that I mentioned in the
> > RFC proposal, it's beneficial for the network service to get an ENOMEM
> > and continue to service network requests for other clients running on
> > the machine, rather than get oom-killed when hitting the remote memcg
> > limit. But, this is not a hard requirement, the network service could
> > fork a process that does the remote charging to guard against the
> > remote charge bringing down the entire process.
>
> This all belongs to the changelog so that we can discuss all potential
> implication and do not rely on any implicit assumptions.

Understood. Maybe I'll wait to collect more feedback and upload v4
with a thorough explanation of the thought process.

> E.g. why does
> it even make sense to kill a task in the origin cgroup?
>

The behavior I saw returning ENOMEM for this edge case was that the
code was forever looping the pagefault, and I was (seemingly
incorrectly) under the impression that a suggestion to forever loop
the pagefault would be completely fundamentally unacceptable.

> > > > If we're in pagefault path and we're unable to return ENOMEM to the
> > > > allocating process, we instead kill the allocating process.
> > >
> > > Why do you handle those differently?
> > >
> >
> > I'm thinking (possibly incorrectly) it's beneficial to return ENOMEM
> > to the allocating task rather than killing it. I would love to return
> > ENOMEM in both these cases, but I can't return ENOMEM in the fault
> > path. The behavior I see is that the oom-killer gets invoked over and
> > over again looking to find something to kill and continually failing
> > to find something to kill and the pagefault never gets handled.
>
> Just one remark. Until just very recently VM_FAULT_OOM (a result of
> ENOMEM) would trigger the global OOM killer. This has changed by
> 60e2793d440a ("mm, oom: do not trigger out_of_memory from the #PF").
> But you are right that you might just end up looping in the page fault
> for ever. Is that bad though? The situation is fundamentaly
> unresolveable at this stage. On the other hand the task is still
> killable so the userspace can decide to terminate and break out of the
> loop.
>

I think what you're saying here makes a lot of sense and I think is a
workable approach, and maybe is slightly preferable to killing the
task IMO (and both are workable IMO). The pagefault can loop until
memory becomes available in the remote memcg, and the userspace can
decide to always terminate the process if desired or maybe handle the
issue more gracefully by freeing memory in the remote memcg somehow;
i.e. maybe we don't need the kernel to be heavy handed here and kill
the remote allocating task immediately.

> What is the best approach I am not quite sure. As I've said earlier this
> is very likely going to open a can of worms and so it should be
> evaluated very carefuly. For that, please make sure to describe your
> thinking in details.
>

OK, thanks for reviewing and the next iteration should include a
thorough explanation of my thinking.

> > I could, however, kill the allocating task whether it's in the
> > pagefault path or not; it's not a hard requirement that I return
> > ENOMEM. If this is what you'd like to see in v4, please let me know,
> > but I do see some value in allowing some callers to gracefully handle
> > the ENOMEM.
> >
> > > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > >
> > > > Cc: Michal Hocko <mhocko@suse.com>
> > > > Cc: Theodore Ts'o <tytso@mit.edu>
> > > > Cc: Greg Thelen <gthelen@google.com>
> > > > Cc: Shakeel Butt <shakeelb@google.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Hugh Dickins <hughd@google.com>
> > > > CC: Roman Gushchin <guro@fb.com>
> > > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > > Cc: Hugh Dickins <hughd@google.com>
> > > > Cc: Tejun Heo <tj@kernel.org>
> > > > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > > > Cc: Muchun Song <songmuchun@bytedance.com>
> > > > Cc: riel@surriel.com
> > > > Cc: linux-mm@kvack.org
> > > > Cc: linux-fsdevel@vger.kernel.org
> > > > Cc: cgroups@vger.kernel.org
> > > --
> > > Michal Hocko
> > > SUSE Labs
>
> --
> Michal Hocko
> SUSE Labs
