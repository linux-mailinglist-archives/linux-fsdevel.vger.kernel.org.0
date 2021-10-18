Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B77431C08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 15:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhJRNhr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 09:37:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34954 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhJRNfm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 09:35:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 258F21FD6D;
        Mon, 18 Oct 2021 13:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634564010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YoCaAIU3gS5Go5DLCN1kv6dXHZiM0iQ6w6RrFGGICso=;
        b=XmgPTBlbQwJY3r+TZtpbKUocEfQeYD958gxtDPq6oJ1jojMVSpnjhZulUshuSUa25saqEP
        redaJ3+UFAYoa8FwoqWco0w/CkkO92hkKFZE8UtdZxPTx1LUvS1UkorkJ4jmDW3wvD3xrP
        MUYOayUfMVAdj3iQs/U9nXSIRCmILGY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 751B1A3BC8;
        Mon, 18 Oct 2021 13:33:29 +0000 (UTC)
Date:   Mon, 18 Oct 2021 15:33:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Roman Gushchin <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>, cgroups@vger.kernel.org,
        riel@surriel.com
Subject: Re: [RFC Proposal] Deterministic memcg charging for shared memory
Message-ID: <YW13pS716ajeSgXj@dhcp22.suse.cz>
References: <CAHS8izMpzTvd5=x_xMhDJy1toV-eT3AS=GXM2ObkJoCmbDtz6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMpzTvd5=x_xMhDJy1toV-eT3AS=GXM2ObkJoCmbDtz6w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-10-21 12:23:19, Mina Almasry wrote:
> Below is a proposal for deterministic charging of shared memory.
> Please take a look and let me know if there are any major concerns:
> 
> Problem:
> Currently shared memory is charged to the memcg of the allocating
> process. This makes memory usage of processes accessing shared memory
> a bit unpredictable since whichever process accesses the memory first
> will get charged. We have a number of use cases where our userspace
> would like deterministic charging of shared memory:
> 
> 1. System services allocating memory for client jobs:
> We have services (namely a network access service[1]) that provide
> functionality for clients running on the machine and allocate memory
> to carry out these services. The memory usage of these services
> depends on the number of jobs running on the machine and the nature of
> the requests made to the service, which makes the memory usage of
> these services hard to predict and thus hard to limit via memory.max.
> These system services would like a way to allocate memory and instruct
> the kernel to charge this memory to the client’s memcg.
> 
> 2. Shared filesystem between subtasks of a large job
> Our infrastructure has large meta jobs such as kubernetes which spawn
> multiple subtasks which share a tmpfs mount. These jobs and its
> subtasks use that tmpfs mount for various purposes such as data
> sharing or persistent data between the subtask restarts. In kubernetes
> terminology, the meta job is similar to pods and subtasks are
> containers under pods. We want the shared memory to be
> deterministically charged to the kubernetes's pod and independent to
> the lifetime of containers under the pod.
> 
> 3. Shared libraries and language runtimes shared between independent jobs.
> We’d like to optimize memory usage on the machine by sharing libraries
> and language runtimes of many of the processes running on our machines
> in separate memcgs. This produces a side effect that one job may be
> unlucky to be the first to access many of the libraries and may get
> oom killed as all the cached files get charged to it.
> 
> Design:
> My rough proposal to solve this problem is to simply add a
> ‘memcg=/path/to/memcg’ mount option for filesystems (namely tmpfs):
> directing all the memory of the file system to be ‘remote charged’ to
> cgroup provided by that memcg= option.

Could you be more specific about how this matches the above mentioned
usecases?

What would/should happen if the target memcg doesn't or stop existing
under remote charger feet?

> Caveats:
> 1. One complication to address is the behavior when the target memcg
> hits its memory.max limit because of remote charging. In this case the
> oom-killer will be invoked, but the oom-killer may not find anything
> to kill in the target memcg being charged. In this case, I propose
> simply failing the remote charge which will cause the process
> executing the remote charge to get an ENOMEM This will be documented
> behavior of remote charging.

Say you are in a page fault (#PF) path. If you just return ENOMEM then
you will get a system wide OOM killer via pagefault_out_of_memory. This
is very likely not something you want, right? Even if we remove this
behavior, which is another story, then the #PF wouldn't have other ways
than keep retrying which doesn't really look great either.

The only "reasonable" way I can see right now is kill the remote
charging task. That might result in some other problems though.

> 2. I would like to provide an initial implementation that adds this
> support for tmpfs, while leaving the implementation generic enough for
> myself or others to extend to more filesystems where they find the
> feature useful.

How do you envision other filesystems would implement that? Should the
information be persisted in some way?

I didn't have time to give this a lot of thought and more questions will
likely come. My initial reaction is that this will open a lot of
interesting corner cases which will be hard to deal with.
-- 
Michal Hocko
SUSE Labs
