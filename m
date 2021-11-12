Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC3D44E356
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 09:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhKLIjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 03:39:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36710 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhKLIjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:39:36 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9FDCA1FDC2;
        Fri, 12 Nov 2021 08:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636706205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=utWjZFWtK1d8B6B0EoCAYEXXutvfJ9zlQXA/BhmjEOU=;
        b=roV1gIkupTl65lmeA+0dTiqvL2CHFYBKx+8Bfm+Azp+LNfosPF7BvXq/Nf2Jcsf/n9LhB5
        0tjT57G1qy/6xYGK1EpK75lJOJwpa4mUq/n1KQ/PL2Bq3QQkySYtDfY08Z7sJtK9ELqw9d
        0J5uBpWSd7h3uFOH/v010RJpfomWbIM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 19965A3B81;
        Fri, 12 Nov 2021 08:36:45 +0000 (UTC)
Date:   Fri, 12 Nov 2021 09:36:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm/oom: handle remote ooms
Message-ID: <YY4nm9Kvkt2FJPph@dhcp22.suse.cz>
References: <20211111234203.1824138-1-almasrymina@google.com>
 <20211111234203.1824138-3-almasrymina@google.com>
 <YY4dHPu/bcVdoJ4R@dhcp22.suse.cz>
 <CAHS8izNMTcctY7NLL9+qQN8+WVztJod2TfBHp85NqOCvHsjFwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izNMTcctY7NLL9+qQN8+WVztJod2TfBHp85NqOCvHsjFwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 12-11-21 00:12:52, Mina Almasry wrote:
> On Thu, Nov 11, 2021 at 11:52 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 11-11-21 15:42:01, Mina Almasry wrote:
> > > On remote ooms (OOMs due to remote charging), the oom-killer will attempt
> > > to find a task to kill in the memcg under oom, if the oom-killer
> > > is unable to find one, the oom-killer should simply return ENOMEM to the
> > > allocating process.
> >
> > This really begs for some justification.
> >
> 
> I'm thinking (and I can add to the commit message in v4) that we have
> 2 reasonable options when the oom-killer gets invoked and finds
> nothing to kill: (1) return ENOMEM, (2) kill the allocating task. I'm
> thinking returning ENOMEM allows the application to gracefully handle
> the failure to remote charge and continue operation.
> 
> For example, in the network service use case that I mentioned in the
> RFC proposal, it's beneficial for the network service to get an ENOMEM
> and continue to service network requests for other clients running on
> the machine, rather than get oom-killed when hitting the remote memcg
> limit. But, this is not a hard requirement, the network service could
> fork a process that does the remote charging to guard against the
> remote charge bringing down the entire process.

This all belongs to the changelog so that we can discuss all potential
implication and do not rely on any implicit assumptions. E.g. why does
it even make sense to kill a task in the origin cgroup?

> > > If we're in pagefault path and we're unable to return ENOMEM to the
> > > allocating process, we instead kill the allocating process.
> >
> > Why do you handle those differently?
> >
> 
> I'm thinking (possibly incorrectly) it's beneficial to return ENOMEM
> to the allocating task rather than killing it. I would love to return
> ENOMEM in both these cases, but I can't return ENOMEM in the fault
> path. The behavior I see is that the oom-killer gets invoked over and
> over again looking to find something to kill and continually failing
> to find something to kill and the pagefault never gets handled.

Just one remark. Until just very recently VM_FAULT_OOM (a result of
ENOMEM) would trigger the global OOM killer. This has changed by
60e2793d440a ("mm, oom: do not trigger out_of_memory from the #PF").
But you are right that you might just end up looping in the page fault
for ever. Is that bad though? The situation is fundamentaly
unresolveable at this stage. On the other hand the task is still
killable so the userspace can decide to terminate and break out of the
loop.

What is the best approach I am not quite sure. As I've said earlier this
is very likely going to open a can of worms and so it should be
evaluated very carefuly. For that, please make sure to describe your
thinking in details.
 
> I could, however, kill the allocating task whether it's in the
> pagefault path or not; it's not a hard requirement that I return
> ENOMEM. If this is what you'd like to see in v4, please let me know,
> but I do see some value in allowing some callers to gracefully handle
> the ENOMEM.
> 
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Theodore Ts'o <tytso@mit.edu>
> > > Cc: Greg Thelen <gthelen@google.com>
> > > Cc: Shakeel Butt <shakeelb@google.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > CC: Roman Gushchin <guro@fb.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > > Cc: Muchun Song <songmuchun@bytedance.com>
> > > Cc: riel@surriel.com
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: cgroups@vger.kernel.org
> > --
> > Michal Hocko
> > SUSE Labs

-- 
Michal Hocko
SUSE Labs
