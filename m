Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 329F8123C52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 02:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfLRBRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 20:17:48 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43210 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRBRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:17:48 -0500
Received: by mail-il1-f195.google.com with SMTP id v69so214365ili.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 17:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oA/yf12U/Kxc1zDI4JzibNhsgFIEwCoLpFPoyClVoyc=;
        b=V2GockHvWu/kJZOrb/Fjb++aDcjeKE9nF1tswj9bcP56aSDm1mWkF0Bb1o8cWasTMB
         onk1Pi1FvBXa+vhd+b0Obx9GOTwPMp3xVPlF9+aeD/O/muLWemx0dYrrcskjt7fcz7ed
         YJ3a3xm+t9W+PakO/2LygdAkHcJtGQ7fd4kPyFchZHO64KRO5RUjSpRp4nRuy42Q6MGg
         vuq2f2bUqwEBet+aAJTxBMF38hSVlZfSYG6KSHFU607Xu0EK+OdCvN1A0bc9vnJbvaZQ
         qkk9xGzcITv5dXkMmgkNlqCXAbcKGRPklfR70XYeUPtneoTWBkR8RTNfOKEdYXCyn3Ur
         vLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oA/yf12U/Kxc1zDI4JzibNhsgFIEwCoLpFPoyClVoyc=;
        b=dE/watVvPCooQ1VVrl+1gEIqOdlUODnKyIcPVCZB3x3TFCNvLqWJYQbqRNQ6aMuhOT
         9QAYpyPAUzaRmKdt0UKBtI82rIiF4qMdXv5HvMz7FyQH8FLjCsuPe9oDYizsgbRlNuwU
         Fj43H2i2AFBQOxC3Py/0mzZk3HuGpnhuw6fUhq+WHB7fzsavZ7D14iFpIVmywB8btWvG
         57GYmlsQeIC2Cv1xurTEEZGHt1fIxc6p+TnEyVJXgT2OghI5tcvRxSTLSrHKl6zbMWIz
         4iz5mpKc/0M5hDbxpPLdWUPaxTibSkh0WMbaNxjHYaxgx8nooK86GXiKrKpGVnUVAxaf
         qVjQ==
X-Gm-Message-State: APjAAAXP9wUkbeQkWnWOXDJKWZ57mIgeq4V7amq3kOoqTLrCQKpUpOSV
        LqlYg1RKmPM5QGywrEQkGLzNdIfHnW//qThe2yk=
X-Google-Smtp-Source: APXvYqyNOT9j7j2T8jDNq965KC84cLs7ROS0VaTwM3kqpxYEC2cEax272aefDu09HlYAEi/5zKrQh2uydZFCZnTGRic=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr342478ilg.137.1576631867378;
 Tue, 17 Dec 2019 17:17:47 -0800 (PST)
MIME-Version: 1.0
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <20191217115603.GA10016@dhcp22.suse.cz> <CALOAHbBQ+XkQk6HN53O4e1=qfFiow2kvQO3ajDj=fwQEhcZ3uw@mail.gmail.com>
 <20191217165422.GA213613@cmpxchg.org>
In-Reply-To: <20191217165422.GA213613@cmpxchg.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 18 Dec 2019 09:17:11 +0800
Message-ID: <CALOAHbBqX6=Q6zymFR7T7bPqv62VTf8FM76W5JTkGSTf2e9tMA@mail.gmail.com>
Subject: Re: [PATCH 0/4] memcg, inode: protect page cache from freeing inode
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 12:54 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> CCing Dave
>
> On Tue, Dec 17, 2019 at 08:19:08PM +0800, Yafang Shao wrote:
> > On Tue, Dec 17, 2019 at 7:56 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > What do you mean by this exactly. Are those inodes reclaimed by the
> > > regular memory reclaim or by other means? Because shrink_node does
> > > exclude shrinking slab for protected memcgs.
> >
> > By the regular memory reclaim, kswapd, direct reclaimer or memcg reclaimer.
> > IOW, the current->reclaim_state it set.
> >
> > Take an example for you.
> >
> > kswapd
> >     balance_pgdat
> >         shrink_node_memcgs
> >             switch (mem_cgroup_protected)  <<<< memory.current= 1024M
> > memory.min = 512M a file has 800M page caches
> >                 case MEMCG_PROT_NONE:  <<<< hard limit is not reached.
> >                       beak;
> >             shrink_lruvec
> >             shrink_slab <<< it may free the inode and the free all its
> > page caches (800M)
>
> This problem exists independent of cgroup protection.
>
> The inode shrinker may take down an inode that's still holding a ton
> of (potentially active) page cache pages when the inode hasn't been
> referenced recently.
>
> IMO we shouldn't be dropping data that the VM still considers hot
> compared to other data, just because the inode object hasn't been used
> as recently as other inode objects (e.g. drowned in a stream of
> one-off inode accesses).
>
> I've carried the below patch in my private tree for testing cache
> aging decisions that the shrinker interfered with. (It would be nicer
> if page cache pages could pin the inode of course, but reclaim cannot
> easily participate in the inode refcounting scheme.)
>
> Thoughts?
>

I have already though about this solution.
But I found there is a similar revert by Dave - see 69056ee6a8a3
("Revert "mm: don't reclaim inodes with many attached pages"").
That's why I CCed Dave in patch-4.
So I only fix it for memcg protection because that will not impact too much.

> diff --git a/fs/inode.c b/fs/inode.c
> index fef457a42882..bfcaaaf6314f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -753,7 +753,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>                 return LRU_ROTATE;
>         }
>
> -       if (inode_has_buffers(inode) || inode->i_data.nrpages) {
> +       /* Leave the pages to page reclaim */
> +       if (inode->i_data.nrpages) {
> +               spin_unlock(&inode->i_lock);
> +               return LRU_ROTATE;
> +       }
> +
> +       if (inode_has_buffers(inode)) {
>                 __iget(inode);
>                 spin_unlock(&inode->i_lock);
>                 spin_unlock(lru_lock);
