Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69574145713
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 14:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAVNre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 08:47:34 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35641 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgAVNrd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:47:33 -0500
Received: by mail-il1-f196.google.com with SMTP id g12so5214897ild.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 05:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANDihc1i2ZoSQloc87ZbVHtTzz8YhFDhjGCFcZQK0b4=;
        b=du/EVyYIy19Pow+SxP4/cr1dEZnU1osBkzVuPMYJly8QePigYFewToY3Ve99LwnJPK
         N6irF6K/UNIfu2b8dQfe26j5f/UGRpQipQSCkfKTRcRfyl6LIM/O0vZPzt8QNOhmq9fg
         LF1NwsKhG0y/BEFa/AEYtCiNbCXku9WXC1ZQG1/j5H78lcnoivcitWqQKCnkacolAYQ+
         SOFwMfb7dKL/NwfOvPIuwZCaaT64p72l4UBeHKahQxqcuUvsN/Up7MuquxzojtA+3uAg
         z6xM5PldNqNwMzHmqjXSro/V7PKX4anc28ffxXxC3Mw+yJxKQTtuZ86/obKirgcHLWXy
         y7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANDihc1i2ZoSQloc87ZbVHtTzz8YhFDhjGCFcZQK0b4=;
        b=XBUI7kW39Z0bFkQX2F8HMb3s0Oz0pfY2DSRVcRx42zfRuVQi1JbSTYFFFP1hjuPrUQ
         5q2mJIDbmtzhR8pjslqJq5h3/rNJYLRdRyRljyFGZ9wTfhrslPMy2/xyAq0rv3FlphWo
         mFJ7URqOKkzwyLGHfp3pP0w5lArrjJkG4pcNPVcDeTBh4T+XGSTmdP4ofg64OkhL8IF2
         IZJIadnLptmkZpllcFLVSYsTczuEVcTyUe6rd/5auzcz7k8cpneg2eXz83qtm4VkeMW/
         L4iCOIReK4sUMwASk8SQ+rxlMeOSfo8dXxXj/XLDi6iKzziUJf+Z1OKdo/bx06MQSZ6S
         NXsQ==
X-Gm-Message-State: APjAAAWTzIA7L97+JWhagVE8pVo1NpgqS/JiI+2k3uGJ4iBcn9+Rp6as
        zhc564EqgOmJPYOlacTk6taPPyox4SfNMBUJvJo=
X-Google-Smtp-Source: APXvYqxrzOGOvW1vVHdwcoBLdPRdh2IufapQRRXwqnpLaNiqiM14hy1IjQRrmnQlZRXRywuxAy24HYNfKB2EuQsyzng=
X-Received: by 2002:a92:da44:: with SMTP id p4mr8521820ilq.168.1579700853182;
 Wed, 22 Jan 2020 05:47:33 -0800 (PST)
MIME-Version: 1.0
References: <1578499437-1664-1-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1578499437-1664-1-git-send-email-laoar.shao@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 22 Jan 2020 21:46:57 +0800
Message-ID: <CALOAHbAs7d7UhO6cd5_6vTm0cgcdTiwNNMSfFX4D0hdMc+CaEg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] protect page cache from freeing inode
To:     Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 9, 2020 at 12:04 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On my server there're some running MEMCGs protected by memory.{min, low},
> but I found the usage of these MEMCGs abruptly became very small, which
> were far less than the protect limit. It confused me and finally I
> found that was because of inode stealing.
> Once an inode is freed, all its belonging page caches will be dropped as
> well, no matter how may page caches it has. So if we intend to protect the
> page caches in a memcg, we must protect their host (the inode) first.
> Otherwise the memcg protection can be easily bypassed with freeing inode,
> especially if there're big files in this memcg.
> The inherent mismatch between memcg and inode is a trouble. One inode can
> be shared by different MEMCGs, but it is a very rare case. If an inode is
> shared, its belonging page caches may be charged to different MEMCGs.
> Currently there's no perfect solution to fix this kind of issue, but the
> inode majority-writer ownership switching can help it more or less.
>
> - Changes against v2:
>     1. Seperates memcg patches from this patchset, suggested by Roman.
>        A separate patch is alreay ACKed by Roman, please the MEMCG
>        maintianers help take a look at it[1].
>     2. Improves code around the usage of for_each_mem_cgroup(), suggested
>        by Dave
>     3. Use memcg_low_reclaim passed from scan_control, instead of
>        introducing a new member in struct mem_cgroup.
>     4. Some other code improvement suggested by Dave.
>
>
> - Changes against v1:
> Use the memcg passed from the shrink_control, instead of getting it from
> inode itself, suggested by Dave. That could make the laying better.
>
> [1]
> https://lore.kernel.org/linux-mm/CALOAHbBhPgh3WEuLu2B6e2vj1J8K=gGOyCKzb8tKWmDqFs-rfQ@mail.gmail.com/
>
> Yafang Shao (3):
>   mm, list_lru: make memcg visible to lru walker isolation function
>   mm, shrinker: make memcg low reclaim visible to lru walker isolation
>     function
>   memcg, inode: protect page cache from freeing inode
>
>  fs/inode.c                 | 78 ++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/memcontrol.h | 21 +++++++++++++
>  include/linux/shrinker.h   |  3 ++
>  mm/list_lru.c              | 47 +++++++++++++++++-----------
>  mm/memcontrol.c            | 15 ---------
>  mm/vmscan.c                | 27 +++++++++-------
>  6 files changed, 143 insertions(+), 48 deletions(-)
>

Dave,  Johannes,

Any comments on this new version ?

Thanks
Yafang
