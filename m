Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23F91700F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 15:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgBZOQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 09:16:54 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:42296 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBZOQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:16:54 -0500
Received: by mail-il1-f194.google.com with SMTP id x2so2472444ila.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 06:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKkmJsF9Hl657kgJGnJj+omKg/OfeYPnAzsoJ5sWtno=;
        b=vTrIHT4mP9ERZDSFPzK1ncQQDAj2Xv89LD56xygEoWafU31IHdaH/QBgaQDyjhMW0G
         Pr4xH8ErQcv1GxysuCdxxXz1WthNQyngsUjGHsDvMH3wF8cIWMZrl/oEUfBc/Xw7NInT
         eMju7GvzUQvV3deDDQe7gTau4PgloeyfQ2vrjMvbj6+G3lQh2TxxcFtW17h2YRgHi/Bi
         9huZoLX9/ipMHDQAspjWNZuLiDr6yz0Z1Bg+qVB4A7087VXw7iM9t4LWmV37Lu4A9pLq
         GjQQ5fd2h5ECVEJFw87datIQY87TOZjBE6y2kFllQflUb9BRJrVbK2DK34v641tBoiYw
         0tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKkmJsF9Hl657kgJGnJj+omKg/OfeYPnAzsoJ5sWtno=;
        b=PO2DWPmSHTHDw7wlc0djpiH8o3IiTyp17UPN0Uf+4SCrusbZKIt7LYisTa85FdCeH3
         KnI0S7gzsvLA6ODS8v7jKdPxOx3z+MQ7cF+8D6pW4IlQiDOGQGH6DuM8unc5IJbX/KGK
         G8iXSoXGt1ExnCeJKI5u7+zu05GidsKjpgdv6DYP2Yc6Q+3ajqaPhrc2QthfMRWtaMpN
         3LqrjOjcZALvmJP4D9nsK8pT8MJ939iEcunxtKEHz06+0N46uQvP91Es45Tiw+jBfMcK
         GpRx376jQ/KgUxQ11IPIqd5T4j2nqt3QLhnyoyZjVCcdvN25kW2TBCa7RvhydJE8qWej
         Rm7A==
X-Gm-Message-State: APjAAAWewC7sOXS8JmR2wNv89LNaqe7vJIxDORWqNHwG3/tgjjlzEA2m
        +HRCKBLdQJXhabOHkBizN6nG8HIamYrupByeA+g=
X-Google-Smtp-Source: APXvYqx455mYmZxNyLsIHHpy8E8XyXo+Di+V1pd6m1CK+p1jG77rykVphYYvILwwPZXRovho2sPh84OYxW2xiXQ3nJ8=
X-Received: by 2002:a92:84ce:: with SMTP id y75mr5055650ilk.93.1582726613296;
 Wed, 26 Feb 2020 06:16:53 -0800 (PST)
MIME-Version: 1.0
References: <1582450294-18038-1-git-send-email-laoar.shao@gmail.com> <20200223191707.0a55e949fad943b04c2b65e7@linux-foundation.org>
In-Reply-To: <20200223191707.0a55e949fad943b04c2b65e7@linux-foundation.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 26 Feb 2020 22:16:17 +0800
Message-ID: <CALOAHbDUFxggpQyDWUdtK4X=vHNC0R=uoU0yJVJiDVa75n3O=w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] protect page cache from freeing inode
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 24, 2020 at 11:17 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sun, 23 Feb 2020 04:31:31 -0500 Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > On my server there're some running MEMCGs protected by memory.{min, low},
> > but I found the usage of these MEMCGs abruptly became very small, which
> > were far less than the protect limit. It confused me and finally I
> > found that was because of inode stealing.
> > Once an inode is freed, all its belonging page caches will be dropped as
> > well, no matter how may page caches it has. So if we intend to protect the
> > page caches in a memcg, we must protect their host (the inode) first.
> > Otherwise the memcg protection can be easily bypassed with freeing inode,
> > especially if there're big files in this memcg.
> > The inherent mismatch between memcg and inode is a trouble. One inode can
> > be shared by different MEMCGs, but it is a very rare case. If an inode is
> > shared, its belonging page caches may be charged to different MEMCGs.
> > Currently there's no perfect solution to fix this kind of issue, but the
> > inode majority-writer ownership switching can help it more or less.
>
> What are the potential regression scenarios here?  Presumably a large
> number of inodes pinned by small amounts of pagecache, consuming memory
> and CPU during list scanning.  Anything else?
>

Sorry about the late response.

Yes, lots of inodes pinned by small amounts of pagecache in a memcg
protected by memory.{min, low} could be a potential regression
scenarios.  It may take extra time to skip these inodes when a
workload outside of these memcg is trying to do page reclaim.
But these extra time can almostly be ignored comparing with the time
the memory.{min, low} may take, because memory.{min, low} takes
another round to scan all the pages again.
While if the workload trying to reclaim these protected inodes is
inside of the protected memcg, then this workload will not be effected
at all because memory.{min, low} doesn't take effect under these
condition.

> Have you considered constructing test cases to evaluate the impact of
> such things?
>

I did some mmtests::pagereclaim-performance  test with lots of
protected inodes pinned by small amounts of pagecache.  The result
doesn't show any obvious difference  with this patchset. I will update
it with these test data.  Appreciate it if you could recommend some
better tests tools.

-- 
Yafang Shao
DiDi
