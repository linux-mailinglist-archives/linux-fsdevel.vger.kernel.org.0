Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E54F15CFA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 03:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgBNCCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 21:02:42 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35624 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgBNCCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:02:41 -0500
Received: by mail-io1-f68.google.com with SMTP id h8so8860177iob.2;
        Thu, 13 Feb 2020 18:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yWoUBz+C7vm0A7bAhVVGXf9KuwG1nz4uADeDv9msL44=;
        b=sIP6gtVCerCIVpXLAoh50FbLG8VrPOSk/ScVTqjURLSSRW3frQUPSxY4R2mh+84mZl
         ig1XEQT6dIy3NXDMHrF0YZ4fimDlVaHEvCFjyOE0/DIHrMb99k8S6e+RoJyTBIso5Ql8
         dDeyickdIRmtWR7boXdp+0eqi1LXl0EMKvCJ7K04AtJPgP08lPS22w1VJFQAf8MJHaq4
         7ucv73YRCGmkEQg3CcjLQp/aA6FdRZXKCdgYyBnQL6zbvXyg2Fg6qZJBPOFzcz/ncLDI
         vXkd2Uj23tpEW7DsXmEBtnbGQ6m1mJGnKKAODnt45fRssk3gp9KGs1o9w0FtXUQ21PF0
         x+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWoUBz+C7vm0A7bAhVVGXf9KuwG1nz4uADeDv9msL44=;
        b=J2Wnz/Ji1XZT/4CvKkDd190YRfwq0abUmcEN9v5mZBe1bJR+0Uz6SUcyrfbd2Ndym1
         iGUhs/AhrWTpgsrwq8qDOmIVc1vE3cvC0fQ11+LB9XfB/iKIoieyZKMyij5Qy8tis6MB
         VdFZ6WseWqICD4f5RMsJbyk4Qqc+d1zCm34Z4ot2PgRiuxR5O/xMaEQIBVGa/hq4Bi70
         NJFVtqhWY8qXUoktW9yRsTQ55Mxk2GwoXUysgprQM/N3COKGjSi4hxtBsx9yULaaOXV8
         2J3jqTP8diS3wTQ0RZ++dp4rzd31neyzIUlKgoHOa6OwfnO66etrHf7hWXfLAUS0vUsP
         FhwQ==
X-Gm-Message-State: APjAAAXqyvLEgYQ0//0vzOHpS2MWDmhYQ9EKyXEvQB5UMjXdz6lWUMxD
        MfodvkjX1zusvfNgPeLcV5TXmWOZ+mj66gfs5JKRcA==
X-Google-Smtp-Source: APXvYqyXqlharYXwxORkT7JzKk16r7h+7iSeiE0668V+RrlfSMv6jmg5byz682eRCj8akm4FqF3Kg8rxuMx0y/zcLgU=
X-Received: by 2002:a6b:f214:: with SMTP id q20mr447063ioh.137.1581645760858;
 Thu, 13 Feb 2020 18:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20200211175507.178100-1-hannes@cmpxchg.org> <CALOAHbC3Bx3E7fwt35zuiHfuC8YyhVWA1tDh2KP+gQJoMtED3w@mail.gmail.com>
 <20200212164235.GB180867@cmpxchg.org> <CALOAHbCiBqdZzZVC7_c3Um_vDUu9ECsDYUebOL4+=MP9owA_Og@mail.gmail.com>
 <20200213134627.GB208501@cmpxchg.org>
In-Reply-To: <20200213134627.GB208501@cmpxchg.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 14 Feb 2020 10:02:04 +0800
Message-ID: <CALOAHbD3FQWMN1q-O0Va+hk3Uo2gHnB1-OF870rCpiKPEk8otQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 9:46 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Feb 13, 2020 at 09:47:29AM +0800, Yafang Shao wrote:
> > On Thu, Feb 13, 2020 at 12:42 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Wed, Feb 12, 2020 at 08:25:45PM +0800, Yafang Shao wrote:
> > > > On Wed, Feb 12, 2020 at 1:55 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > Another variant of this problem was recently observed, where the
> > > > > kernel violates cgroups' memory.low protection settings and reclaims
> > > > > page cache way beyond the configured thresholds. It was followed by a
> > > > > proposal of a modified form of the reverted commit above, that
> > > > > implements memory.low-sensitive shrinker skipping over populated
> > > > > inodes on the LRU [1]. However, this proposal continues to run the
> > > > > risk of attracting disproportionate reclaim pressure to a pool of
> > > > > still-used inodes,
> > > >
> > > > Hi Johannes,
> > > >
> > > > If you really think that is a risk, what about bellow additional patch
> > > > to fix this risk ?
> > > >
> > > > diff --git a/fs/inode.c b/fs/inode.c
> > > > index 80dddbc..61862d9 100644
> > > > --- a/fs/inode.c
> > > > +++ b/fs/inode.c
> > > > @@ -760,7 +760,7 @@ static bool memcg_can_reclaim_inode(struct inode *inode,
> > > >                 goto out;
> > > >
> > > >         cgroup_size = mem_cgroup_size(memcg);
> > > > -       if (inode->i_data.nrpages + protection >= cgroup_size)
> > > > +       if (inode->i_data.nrpages)
> > > >                 reclaimable = false;
> > > >
> > > >  out:
> > > >
> > > > With this additional patch, we skip all inodes in this memcg until all
> > > > its page cache pages are reclaimed.
> > >
> > > Well that's something we've tried and had to revert because it caused
> > > issues in slab reclaim. See the History part of my changelog.
> >
> > You misuderstood it.
> > The reverted patch skips all inodes in the system, while this patch
> > only works when you turn on memcg.{min, low} protection.
> > IOW, that is not a default behavior, while it only works when you want
> > it and only effect your targeted memcg rather than the whole system.
>
> I understand perfectly well.
>
> Keeping unreclaimable inodes on the shrinker LRU causes the shrinker
> to build up excessive pressure on all VFS objects. This is a
> bug. Making it cgroup-specific doesn't make it less of a bug, it just
> means you only hit the bug when you use cgroup memory protection.
>

What I mean to fix is really a cgroup-specific issue, but this issue
may be different with what you're meaning to fix.
(I will explain it bellow)
Considering the excessive pressure the protected inodes may give to
the shrinker, the protected page cache pages will give much more
pressure on the reclaimer. If you mean to remove the protecrted inodes
from the shrinker LRU, why not removing the protected page cache pages
from the page cache LRU as well ? Well, what I really to mean is, that
is how the memcg proctection works.

> > > > > while not addressing the more generic reclaim
> > > > > inversion problem outside of a very specific cgroup application.
> > > > >
> > > >
> > > > But I have a different understanding.  This method works like a
> > > > knob. If you really care about your workingset (data), you should
> > > > turn it on (i.e. by using memcg protection to protect them), while
> > > > if you don't care about your workingset (data) then you'd better
> > > > turn it off. That would be more flexible.  Regaring your case in the
> > > > commit log, why not protect your linux git tree with memcg
> > > > protection ?
> > >
> > > I can't imagine a scenario where I *wouldn't* care about my
> > > workingset, though. Why should it be opt-in, not the default?
> >
> > Because the default behavior has caused the XFS performace hit.
>
> That means that with your proposal you cannot use cgroup memory
> protection for workloads that run on xfs.
>

Well, if you set memory.min to protect your workload inside a specific
memcg, it means that you already know these memroy can't be used by
your workload outside the memcg. That means, the performace of the
workload outside the memcg may not as good as before. Then you should
adjust your SLA or migrating this protected memcgs to other host or
just killing this protected memcg.
IOW, the result is *expected*.

> (And if I remember the bug report correctly, this wasn't just xfs. It
> also caused metadata caches on other filesystems to get trashed. xfs
> was just more pronounced because it does sync inode flushing from the
> shrinker, adding write stalls to the mix of metadata cache misses.)
>
> What I'm proposing is an implementation that protects hot page cache
> without causing excessive shrinker pressure and rotations.

That's the different between your issue and my issue.
You're trying to fix the issue around the hot  page cache, but what I
want to fix may be cold page cache and it really is a memcg protection
specific issue.
Becuase the memcg protection can protect all page cache pages, even if
the page cache pages are cold and the inodes are cold (in the tail of
the list lru) as well.  That is one of the reasons why memcg protect
exist. (I know you are the author of memcg protection, but I have to
clarify what memcg protect is.)

Regarding your issue around the hot page cache  pages, I have another
question. If the page cache pages are hot, why are the inode of these
page cahe pages cold (in the tail of the list lru) ?  Per my
understanding, if the page cache pages are hot, the inodes of them
should be hot (not in the tail of the list lur) as well. That should
be how the LRU works.

Well, that doesn't mean I object to your patch.  What I really want to
clarify is that our issues are really different.

Thanks
Yafang
