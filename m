Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1E15246F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 02:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgBEBU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 20:20:27 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:41866 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbgBEBU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 20:20:27 -0500
Received: by mail-il1-f194.google.com with SMTP id f10so443999ils.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2020 17:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0yQGDZerCMtKY6Kjdt1L600+y/8MQHS81Frdz0g8rg=;
        b=WXovHO8ACtYwJ2he/KBeBhjgslIBnRQ5EwS2/+jmVYGvp08DAoecZKFkcolCZOklhJ
         zRCGnGNeXTeFQRky6rEv2nL5lQ847Rp1NQD6rM11ILYYezYv3/gSPbfUu64BrJeeMXsP
         aeiW4beetWmQl8+wf1LJ7WkMJMu37njsSF98eHDzP6EQk0tS5yP3bKTpZCqg69FOh/4a
         oMUV4U3dA3/8SqkX/QS2iM98s2jiOebndlKVFkwDijzOPMLy2QGSq8OMNgQxe+auPbE/
         73w1KIBRJkO2WjK/sRNDWfBe/noie8TRLJjn5bCG2c0kSzyJO1BOiLO/bmI4WHwFPSmW
         AX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0yQGDZerCMtKY6Kjdt1L600+y/8MQHS81Frdz0g8rg=;
        b=sbkmeQd35eLDGGVTfOT7giyhkIwG25+Assz8HZT6rJee2gfHfSCytXjmCWYrzvkyiw
         BVSuha8wVJkvnQmX6DrGjah7N65VrObmYZjx7pnG/dANI2sJVgHhp+p2aJ66fjNN1MoG
         u64inAFkIw/HRqkQHtmn7UKLuS2TQRtXMN72MocMktVCrOoHLyyMgvmUZ0sPNZjkGyo9
         DR4tbCV0uK3mH+qsDPhsTg2bnAuPRB8su2LjKy91iWdOx0Z/hNvJtP72On2PuRvLWZW+
         nmuzGcAH/7T2OtuvifZwYaoed6vl/MvFhkTRcMIur761GlmD9t14FWSAlzmRHja4jZd/
         QCSg==
X-Gm-Message-State: APjAAAXfUEKjrn1es+RKETAmbKZlNrpdzoPtMe0X9K27M7gjzv4Hq+nS
        +pSDDlWcqqy+lFWqhkdyoxKyVCRBMRGhqUAt4GlcKtnq
X-Google-Smtp-Source: APXvYqyCkFN6Hg1ip9U3BPP5zZB50t/FjZK5mzZsLcv0aqT45pq5jorxFjaRGlfzw47qNmTCz1O2t8U4z7MHpgVlsS0=
X-Received: by 2002:a92:c848:: with SMTP id b8mr31751810ilq.168.1580865626631;
 Tue, 04 Feb 2020 17:20:26 -0800 (PST)
MIME-Version: 1.0
References: <1578499437-1664-1-git-send-email-laoar.shao@gmail.com>
 <CALOAHbAs7d7UhO6cd5_6vTm0cgcdTiwNNMSfFX4D0hdMc+CaEg@mail.gmail.com> <20200204211954.GA20584@dread.disaster.area>
In-Reply-To: <20200204211954.GA20584@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 5 Feb 2020 09:19:50 +0800
Message-ID: <CALOAHbChK=JNA5q-3QqyNVG34RZxmZdUOR2HvtNWHCz+EAQAaQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] protect page cache from freeing inode
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 5, 2020 at 5:20 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Jan 22, 2020 at 09:46:57PM +0800, Yafang Shao wrote:
> > On Thu, Jan 9, 2020 at 12:04 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > On my server there're some running MEMCGs protected by memory.{min, low},
> > > but I found the usage of these MEMCGs abruptly became very small, which
> > > were far less than the protect limit. It confused me and finally I
> > > found that was because of inode stealing.
> > > Once an inode is freed, all its belonging page caches will be dropped as
> > > well, no matter how may page caches it has. So if we intend to protect the
> > > page caches in a memcg, we must protect their host (the inode) first.
> > > Otherwise the memcg protection can be easily bypassed with freeing inode,
> > > especially if there're big files in this memcg.
> > > The inherent mismatch between memcg and inode is a trouble. One inode can
> > > be shared by different MEMCGs, but it is a very rare case. If an inode is
> > > shared, its belonging page caches may be charged to different MEMCGs.
> > > Currently there's no perfect solution to fix this kind of issue, but the
> > > inode majority-writer ownership switching can help it more or less.
> > >
> > > - Changes against v2:
> > >     1. Seperates memcg patches from this patchset, suggested by Roman.
> > >        A separate patch is alreay ACKed by Roman, please the MEMCG
> > >        maintianers help take a look at it[1].
> > >     2. Improves code around the usage of for_each_mem_cgroup(), suggested
> > >        by Dave
> > >     3. Use memcg_low_reclaim passed from scan_control, instead of
> > >        introducing a new member in struct mem_cgroup.
> > >     4. Some other code improvement suggested by Dave.
> > >
> > >
> > > - Changes against v1:
> > > Use the memcg passed from the shrink_control, instead of getting it from
> > > inode itself, suggested by Dave. That could make the laying better.
> > >
> > > [1]
> > > https://lore.kernel.org/linux-mm/CALOAHbBhPgh3WEuLu2B6e2vj1J8K=gGOyCKzb8tKWmDqFs-rfQ@mail.gmail.com/
> > >
> > > Yafang Shao (3):
> > >   mm, list_lru: make memcg visible to lru walker isolation function
> > >   mm, shrinker: make memcg low reclaim visible to lru walker isolation
> > >     function
> > >   memcg, inode: protect page cache from freeing inode
> > >
> > >  fs/inode.c                 | 78 ++++++++++++++++++++++++++++++++++++++++++++--
> > >  include/linux/memcontrol.h | 21 +++++++++++++
> > >  include/linux/shrinker.h   |  3 ++
> > >  mm/list_lru.c              | 47 +++++++++++++++++-----------
> > >  mm/memcontrol.c            | 15 ---------
> > >  mm/vmscan.c                | 27 +++++++++-------
> > >  6 files changed, 143 insertions(+), 48 deletions(-)
> > >
> >
> > Dave,  Johannes,
> >
> > Any comments on this new version ?
>
> Sorry, I lost track of this amongst travel and conferences mid
> january. Can you update and post it again once -rc1 is out?
>

Sure, I will do it.
Thanks for your reply.

Thanks
Yafang
