Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB7469321
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 10:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbhLFKD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 05:03:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53544 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbhLFKD0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:03:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C3FE91FD54;
        Mon,  6 Dec 2021 09:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638784796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g+rBjrrMeHrk3S90LlHYvnkvKqRseUV/4f1UETmJm8I=;
        b=cvxqwYynAEPWgkWrI95Y8T9D1d5RksttaMtTQkpDZvUky02/l+Fe2w/wceQehYiRPyTBSj
        ZJrDqezjlpBRlQb5lwaq9VIbAGOjy7uxffmxPLhzJzkk3/yJtcdbkNDzAi9nwc6ovpH3Ex
        RLlT4NSX6FnbONaljMiINXWyZ2FliXI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D41CCA3B8B;
        Mon,  6 Dec 2021 09:59:55 +0000 (UTC)
Date:   Mon, 6 Dec 2021 10:59:55 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Alexey Avramov <hakavlad@inbox.lv>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        ValdikSS <iam@valdikss.org.ru>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        oleksandr@natalenko.name, kernel@xanmod.org, aros@gmx.com,
        hakavlad@gmail.com, Yu Zhao <yuzhao@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working
 set
Message-ID: <Ya3fG2rp+860Yb+t@dhcp22.suse.cz>
References: <20211130201652.2218636d@mail.inbox.lv>
 <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
 <20211202135824.33d2421bf5116801cfa2040d@linux-foundation.org>
 <cca17e9f-0d4f-f23a-2bc4-b36e834f7ef8@suse.cz>
 <20211203222710.3f0ba239@mail.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203222710.3f0ba239@mail.inbox.lv>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 03-12-21 22:27:10, Alexey Avramov wrote:
> >I'd also like to know where that malfunction happens in this case.
> 
> User-space processes need to always access shared libraries to work.
> It can be tens or hundreds of megabytes, depending on the type of workload. 
> This is a hot cache, which is pushed out and then read leads to thrashing. 
> There is no way in the kernel to forbid evicting the minimum file cache. 
> This is the problem that the patch solves. And the malfunction is exactly
> that - the inability of the kernel to hold the minimum amount of the
> hottest cache in memory.

Executable pages are a protected resource already page_check_references.
Shared libraries have more page tables pointing to them so they are more
likely to be referenced and thus kept around. What is the other memory
demand to push those away and cause a trashing?

I do agree with Vlastimil that we should be addressing these problems
rather than papering them over by limits nobody will know how to set
up properly and so we will have to deal all sorts of misconfigured
systems. I have a first hand experience with that in a form of page
cache limit that we used to have in older SLES kernels.

[...]
> > The problem with PSI sensing is that it works after the fact (after 
> > the freeze has already occurred). It is not very different from issuing 
> > SysRq-f manually on a frozen system, although it would still be a 
> > handy feature for batched tasks and remote access. 
> 
> but Michal Hocko immediately criticized [7] the proposal unfairly. 
> This patch just implements ndrw's suggestion.

It would be more productive if you were more specific what you consider
an unfair criticism. Thrashing is a real problem and we all recognize
that. We have much better tools in our tool box these days (refault data
for both page cache and swapped back memory). The kernel itself is
rather conservative when using that data for OOM situations because
historically users were more concerned about pre-mature oom killer
invocations because that is a disruptive action.
For those who prefer very agile oom policy there are userspace tools
which can implement more advanced policies.
I am open to any idea to improve the kernel side of things as well.

As mentioned above I am against global knobs to special case the global
memory reclaim because that leads to inconsistencies with the memcg
reclaim, add future maintenance burden and most importantly it
outsources reponsibility to admins who will have hard time to know the
proper value for those knobs effectivelly pushing them towards all sorts
of cargo cult.

> [0] https://serverfault.com/a/319818
> [1] https://github.com/hakavlad/prelockd
> 
> [2] https://www.youtube.com/watch?v=vykUrP1UvcI
>     On this video: running fast memory hog in a loop on Debian 10 GNOME, 
>     4 GiB MemTotal without swap space. FS is ext4 on *HDD*.
>     - 1. prelockd enabled: about 500 MiB mlocked. Starting 
>         `while true; do tail /dev/zero; done`: no freezes. 
>         The OOM killer comes quickly, the system recovers quickly.
>     - 2. prelockd disabled: system hangs.
> 
> [3] https://www.youtube.com/watch?v=g9GCmp-7WXw
> [4] https://www.youtube.com/watch?v=iU3ikgNgp3M
> [5] Let's talk about the elephant in the room - the Linux kernel's 
>     inability to gracefully handle low memory pressure
>     https://lore.kernel.org/all/d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com/
> [6] https://lore.kernel.org/all/806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk/
> [7] https://lore.kernel.org/all/20190808163228.GE18351@dhcp22.suse.cz/

-- 
Michal Hocko
SUSE Labs
