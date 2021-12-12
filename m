Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B436B471CE0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Dec 2021 21:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhLLUPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 15:15:39 -0500
Received: from shark3.inbox.lv ([194.152.32.83]:49078 "EHLO shark3.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhLLUPi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 15:15:38 -0500
Received: from shark3.inbox.lv (localhost [127.0.0.1])
        by shark3-out.inbox.lv (Postfix) with ESMTP id 27DF52800F0;
        Sun, 12 Dec 2021 22:15:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1639340136; bh=7gKTvcysovQVgk9V+5/n54cyo5QdEOaCKyAFlk9k3V8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=PehT60PVrl9GnTqBvLHhoM7LRt+8apblAJd7e1bOrejqH/WGmgsVoJGulY5DMsk0u
         /H3GEo9Sd+K0SLWR9dR1bCPy7KGdGhDfwbRxnjC/dAQVy828DDFhBophAfPC9XqaNB
         nqfuxoelfOeHrdT6b+LBuWGD6fXzX3g5C2KcjRcE=
Received: from localhost (localhost [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id 1EF072800E5;
        Sun, 12 Dec 2021 22:15:36 +0200 (EET)
Received: from shark3.inbox.lv ([127.0.0.1])
        by localhost (shark3.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id I5nx0h2I_Hc3; Sun, 12 Dec 2021 22:15:35 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id 6164A2800C4;
        Sun, 12 Dec 2021 22:15:35 +0200 (EET)
Date:   Mon, 13 Dec 2021 05:15:21 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ValdikSS <iam@valdikss.org.ru>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        oleksandr@natalenko.name, kernel@xanmod.org, aros@gmx.com,
        hakavlad@gmail.com, Yu Zhao <yuzhao@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, hannes@cmpxchg.org,
        hdanton@sina.com, riel@surriel.com,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working
 set
Message-ID: <20211213051521.21f02dd2@mail.inbox.lv>
In-Reply-To: <20211202135824.33d2421bf5116801cfa2040d@linux-foundation.org>
References: <20211130201652.2218636d@mail.inbox.lv>
        <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
        <20211202135824.33d2421bf5116801cfa2040d@linux-foundation.org>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: EZeEAiZdhQo1taLbN/0M6uTt2NezU0QhuTn4zqFSmn9bsq+jx9N0dm6WEoPnHwG8bg==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I don't think that the limits should be "N bytes on the current node". 

It's not a problem to add a _ratio knobs. How the tunables should look and 
what their default values should be can still be discussed. Now my task is 
to prove that the problem exists and the solution I have proposed is 
effective and correct.

> the various zones have different size as well.

I'll just point out the precedent: sc->file_is_tiny works the same way 
(per node) as suggested sc->clean_below_min etc.

> We do already have a lot of sysctls for controlling these sort of
> things.  

There are many of them, but there are no most important ones for solving 
the problem - those that are proposed in the patch. 

> Was much work put into attempting to utilize the existing
> sysctls to overcome these issues?

Oh yes! This is all I have been doing for the last 4 years. At the end of 
2017, I was forced to write my own userspace OOM killer [1] to resist 
freezes (I didn't know then that earlyoom already existed).

In 2018, Facebook came on the scene with its oomd [2]:

> The traditional Linux OOM killer works fine in some cases, but in others 
> it kicks in too late, resulting in the system entering a livelock for an 
> indeterminate period.

Here we can assume that Facebook's engineers haven't found the kernel 
sysctl tunables that would satisfy them.

In 2019 LKML people could not offer Artem S. Tashkinov a simple solution to 
the problem he described [3]. In addition to discussing user-space 
solutions, 2 kernel-side solutions are proposed:

- PSI-based solution was proposed by Johannes Weiner [4].
- Reserve a fixed (configurable) amount of RAM for caches, and trigger OOM 
  killer earlier, before most UI code is evicted from memory was suggested 
  by ndrw [5]. This is what I propose to accept in the mainline. It is the 
  right way to go.

None of the suggestions posted in that thread were accepted in the 
mainline.

In 2019, at the same time, Fedora Workstation group discussed [6]
Issue #98 Better interactivity in low-memory situations.
As a result, it was decided to enable earlyoom by default for Fedora 
Workstation 32. No existing sysctl was found to be of much help.
It was also suggested to use a swap on zram and to enable the cgroup-based 
uresourced daemon to protect the user session.

So, the problem described by Artem S. Tashkinov in 2019 is still easily 
reproduced in 2021. The assurances of the maintainers that they consider 
the thrashing and near-OOM stalls to be a serious problems are difficult to 
take seriously while they ignore the obvious solution: if reclaiming file 
caches leads to thrashing, then you just need to prohibit deleting the file 
cache. And allow the user to control its minimum amount.
By the way, the implementation of such an idea has been known [7] since 
2010 and was even used in Chrome OS.

Bonus: demo: https://youtu.be/ZrLqUWRodh4
Debian 11 on VM, Linux 5.14 with the patch, no swap space, 
playing SuperTux while 1000 `tail /dev/zero` started simultaneously:
1. No freezes with vm.clean_min_kbytes=300000, I/O pressure was closed to 
   zero, memory pressure was moderate (70-80 some, 12-17 full), all tail 
   processes has been killed in 2 minutes (0:06 - 2:14), it's about 
   8 processes reaped by oom_reaper per second;
2. Complete UI freeze without the working set protection (since 3:40).

[1] https://github.com/hakavlad/nohang
[2] https://engineering.fb.com/2018/07/19/production-engineering/oomd/
[3] https://lore.kernel.org/lkml/d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com/
[4] https://lore.kernel.org/lkml/20190807205138.GA24222@cmpxchg.org/
[5] https://lore.kernel.org/lkml/806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk/
[6] https://pagure.io/fedora-workstation/issue/98
[7] https://lore.kernel.org/lkml/20101028191523.GA14972@google.com/

