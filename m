Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61B046782E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 14:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357914AbhLCNa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 08:30:58 -0500
Received: from shark2.inbox.lv ([194.152.32.82]:60866 "EHLO shark2.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242067AbhLCNa5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:30:57 -0500
Received: from shark2.inbox.lv (localhost [127.0.0.1])
        by shark2-out.inbox.lv (Postfix) with ESMTP id 3BF9FC00E7;
        Fri,  3 Dec 2021 15:27:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1638538051; bh=YfvuJWhcGETYf4OTNXR5X6hUT0nORdfU2wn3p7utGEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=poc5ql6NScHuyUgCLMmqYjcbw/NDCkcOzgttJY5lM1n9AaEV8soOUcwlNl36xC8ey
         1btbJMj76K9ajA78knN3aPalbYlOyMl/LXpolFMYjo+rFwdgD0ZfuSFbpJTZvxjK4i
         +iXRODvuns4ll236gmHGgOvUo4n7OlhMLkd4q69c=
Received: from localhost (localhost [127.0.0.1])
        by shark2-in.inbox.lv (Postfix) with ESMTP id 25D51C0129;
        Fri,  3 Dec 2021 15:27:31 +0200 (EET)
Received: from shark2.inbox.lv ([127.0.0.1])
        by localhost (shark2.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id UTsJVqqtlOz2; Fri,  3 Dec 2021 15:27:30 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark2-in.inbox.lv (Postfix) with ESMTP id 8BC96C0084;
        Fri,  3 Dec 2021 15:27:30 +0200 (EET)
Date:   Fri, 3 Dec 2021 22:27:10 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        ValdikSS <iam@valdikss.org.ru>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        oleksandr@natalenko.name, kernel@xanmod.org, aros@gmx.com,
        hakavlad@gmail.com, Yu Zhao <yuzhao@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working
 set
Message-ID: <20211203222710.3f0ba239@mail.inbox.lv>
In-Reply-To: <cca17e9f-0d4f-f23a-2bc4-b36e834f7ef8@suse.cz>
References: <20211130201652.2218636d@mail.inbox.lv>
        <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
        <20211202135824.33d2421bf5116801cfa2040d@linux-foundation.org>
        <cca17e9f-0d4f-f23a-2bc4-b36e834f7ef8@suse.cz>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: AJqEQ3EB+w1Luca/KI1r7+Xnw8rAJVdB2DuDrrA34GxYtrbfsttzbmyRB/eRFELmMn8=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>I'd also like to know where that malfunction happens in this case.

User-space processes need to always access shared libraries to work.
It can be tens or hundreds of megabytes, depending on the type of workload. 
This is a hot cache, which is pushed out and then read leads to thrashing. 
There is no way in the kernel to forbid evicting the minimum file cache. 
This is the problem that the patch solves. And the malfunction is exactly
that - the inability of the kernel to hold the minimum amount of the
hottest cache in memory.

Anothe explanation:

> in normal operation you will have nearly all of your executables nad 
> libraries sitting in good ol' physical RAM. But when RAM runs low, but 
> not low enough for the out-of-memory killer to be run, these pages are 
> evicted from RAM. So you end up with a situation where pages are 
> evicted -- at first, no problem, because they are evicted 
> least-recently-used first and it kicks out pages you aren't using 
> anyway. But then, it kicks out the ones you are using, just to have 
> to page them right back in moments later. Thrash city.
-- [0]

Just look at prelockd [1]. This is the process that mlocks mmapped
libraries/binaries of existing processes. The result of it's work:
it's impossible to invoke thrashing under memory pressure, at least 
with noswap. And OOM killer comes *instantly* when it runs.
Please see the demo [2]. The same effect we can get when set
vm.clean_min_kbytes=250000, for example.

>something PSI should be able to help with

PSI acts post-factum: on the basis of PSI we react when memory 
pressure is already high. PSI annot help *prevent* thrashing.

Using vm.clean_min_kbytes knob allows you to get OOM *before*
memory/io pressure gets high and keep the system manageable instead
of getting livelock indefinitely.

Demo [3]: playing supertux under stress, fs on HDD,
vm.clean_low_kbytes=250000, no thrashing, no freeze,
io pressure closed to 0.

Yet another demo [4]: no stalls with the case that was reported [5] by
Artem S. Tashkinov in 2019. Interesting that in that thread ndrw
suggested [6] the right solution:

> Would it be possible to reserve a fixed (configurable) amount of RAM 
> for caches, and trigger OOM killer earlier, before most UI code is 
> evicted from memory? In my use case, I am happy sacrificing e.g. 0.5GB 
> and kill runaway tasks _before_ the system freezes. Potentially OOM 
> killer would also work better in such conditions. I almost never work 
> at close to full memory capacity, it's always a single task that goes 
> wrong and brings the system down.

> The problem with PSI sensing is that it works after the fact (after 
> the freeze has already occurred). It is not very different from issuing 
> SysRq-f manually on a frozen system, although it would still be a 
> handy feature for batched tasks and remote access. 

but Michal Hocko immediately criticized [7] the proposal unfairly. 
This patch just implements ndrw's suggestion.

[0] https://serverfault.com/a/319818
[1] https://github.com/hakavlad/prelockd

[2] https://www.youtube.com/watch?v=vykUrP1UvcI
    On this video: running fast memory hog in a loop on Debian 10 GNOME, 
    4 GiB MemTotal without swap space. FS is ext4 on *HDD*.
    - 1. prelockd enabled: about 500 MiB mlocked. Starting 
        `while true; do tail /dev/zero; done`: no freezes. 
        The OOM killer comes quickly, the system recovers quickly.
    - 2. prelockd disabled: system hangs.

[3] https://www.youtube.com/watch?v=g9GCmp-7WXw
[4] https://www.youtube.com/watch?v=iU3ikgNgp3M
[5] Let's talk about the elephant in the room - the Linux kernel's 
    inability to gracefully handle low memory pressure
    https://lore.kernel.org/all/d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com/
[6] https://lore.kernel.org/all/806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk/
[7] https://lore.kernel.org/all/20190808163228.GE18351@dhcp22.suse.cz/

