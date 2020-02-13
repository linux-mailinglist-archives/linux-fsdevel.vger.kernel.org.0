Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 959A915B6D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 02:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgBMBsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 20:48:06 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45755 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbgBMBsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:48:06 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so4576630ioi.12;
        Wed, 12 Feb 2020 17:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcupujMoNZ+lhM7+9GoPlR+Ij7mhzM+rhSEsy6lC7Ik=;
        b=Ss6Lnwurj/uXI0dVZEJyGvlmTQz36Vl5AU9orRG34T+RQ/yrm8Sa/Pyjqc03UKVRiZ
         NwZsF052DjppBJaKpAY2JiyDZWKz1nKX0olUFwP2ddsxBW+iK0U4vTunmy1rxO7c6v1B
         qRzLV/Rlct/AbvpVx4BhaSqsOmcy9UhqRwQqtID7p5gaKk9qHQfASNQYzuLCn8RZrvW9
         lBUkoPPdBwahHCL3uIYZW4EeIxT62fsE4iFR5R8gbjhT028SJFzGLdoXuHFdRMfJofuD
         tdS/o6Y37PwBdAOXm1ZfnXxwL0inuKGDQoIpET6WWcooE0xDu9SaHh3BSzP9B/PN/+Ab
         0zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcupujMoNZ+lhM7+9GoPlR+Ij7mhzM+rhSEsy6lC7Ik=;
        b=FOPMwRGNJ/ISWzBGdM/Atnl3xLaMLWdpuwsQ/FEkveBvg5JrnWosDEFKyE1RtQG/mG
         rwPciRyXj8NsQs7oBx2jYlTWhJI5lETT2uY9bSMnY778FSjHj0POqIbjcNA8KwSFq64L
         M1wJoW0DiKJwS/IDZSevWEtGBumzfT83+vYpnjgwUCJCVaSkm+CXVbeCssYmtrXul3mT
         ZfhwvrvOBUU9F3YOaJ50DfMijXrNPPBY+u4usuCHhLLhFZtfhek6sILmluAr6V3N8ved
         9AxMNggbBhDmPt+w4zKhQUhEhkGQ2JIb5+Gwv4p3ixPjofxuCz5A4/4FoQ6DIeFTTx90
         hckQ==
X-Gm-Message-State: APjAAAWh6TvJo+oi1TuAIQi2KEBBGrAd8Bb44JzuQS4Aaj86K7X3XReH
        jz6AFwj3RZPcv5brWwqolTjZlJ01eXr4ktslMbU=
X-Google-Smtp-Source: APXvYqxb42gp94oWdM1n869TeR04MYPvf28xXFK13g9YzcEdKofl2Cxbd8zU9kffQASjNIdmEHHyaF4qdiijGBOLbuk=
X-Received: by 2002:a5d:8146:: with SMTP id f6mr19522873ioo.93.1581558485520;
 Wed, 12 Feb 2020 17:48:05 -0800 (PST)
MIME-Version: 1.0
References: <20200211175507.178100-1-hannes@cmpxchg.org> <CALOAHbC3Bx3E7fwt35zuiHfuC8YyhVWA1tDh2KP+gQJoMtED3w@mail.gmail.com>
 <20200212164235.GB180867@cmpxchg.org>
In-Reply-To: <20200212164235.GB180867@cmpxchg.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 13 Feb 2020 09:47:29 +0800
Message-ID: <CALOAHbCiBqdZzZVC7_c3Um_vDUu9ECsDYUebOL4+=MP9owA_Og@mail.gmail.com>
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

On Thu, Feb 13, 2020 at 12:42 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Feb 12, 2020 at 08:25:45PM +0800, Yafang Shao wrote:
> > On Wed, Feb 12, 2020 at 1:55 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > Another variant of this problem was recently observed, where the
> > > kernel violates cgroups' memory.low protection settings and reclaims
> > > page cache way beyond the configured thresholds. It was followed by a
> > > proposal of a modified form of the reverted commit above, that
> > > implements memory.low-sensitive shrinker skipping over populated
> > > inodes on the LRU [1]. However, this proposal continues to run the
> > > risk of attracting disproportionate reclaim pressure to a pool of
> > > still-used inodes,
> >
> > Hi Johannes,
> >
> > If you really think that is a risk, what about bellow additional patch
> > to fix this risk ?
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 80dddbc..61862d9 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -760,7 +760,7 @@ static bool memcg_can_reclaim_inode(struct inode *inode,
> >                 goto out;
> >
> >         cgroup_size = mem_cgroup_size(memcg);
> > -       if (inode->i_data.nrpages + protection >= cgroup_size)
> > +       if (inode->i_data.nrpages)
> >                 reclaimable = false;
> >
> >  out:
> >
> > With this additional patch, we skip all inodes in this memcg until all
> > its page cache pages are reclaimed.
>
> Well that's something we've tried and had to revert because it caused
> issues in slab reclaim. See the History part of my changelog.
>

You misuderstood it.
The reverted patch skips all inodes in the system, while this patch
only works when you turn on memcg.{min, low} protection.
IOW, that is not a default behavior, while it only works when you want
it and only effect your targeted memcg rather than the whole system.

> > > while not addressing the more generic reclaim
> > > inversion problem outside of a very specific cgroup application.
> > >
> >
> > But I have a different understanding.  This method works like a
> > knob. If you really care about your workingset (data), you should
> > turn it on (i.e. by using memcg protection to protect them), while
> > if you don't care about your workingset (data) then you'd better
> > turn it off. That would be more flexible.  Regaring your case in the
> > commit log, why not protect your linux git tree with memcg
> > protection ?
>
> I can't imagine a scenario where I *wouldn't* care about my
> workingset, though. Why should it be opt-in, not the default?

Because the default behavior has caused the XFS performace hit.
(I haven't  checked your patch carefully, so I don't know whehter your
patch fix it yet.)


Thanks

Yafang
