Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6A344DDD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 23:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhKKWWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 17:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhKKWWB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 17:22:01 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEBFC061766
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 14:19:12 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id u60so18662560ybi.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 14:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xz1ThyRle14L/Lmu+C/rhxFwY5LWljceUheD/q+puoE=;
        b=Am2XuTAzsmHJU6jH2Ugx6f+JRtomhYuDf4Tn0XdgybvJPHA75M2TbU9DGnDXysF9I2
         FUxWSULyN0r2+38FP7HiWkOEBLf6mDvIHNMtyDYXNKZbCboxWatEmfeWO4gfAEHbci3m
         J8veGGOdBjOh6zDzyhW74nml17z5rFZFnK50PRcrPbBMIZeLqzL432VWXlOxVvGCvDb/
         OIBuxSOr1+6X/yCvAYSZxCdXczB+qV5xMiU/5x+RiyFxY6EriK//6vFG/p/Q9ebex/ai
         FuJYn8SqefaAbZgmIqIf793HF0C6i5OY+OLuzPNL/OsTo9p21tWYLshWg2pq8RzYvg2p
         IAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xz1ThyRle14L/Lmu+C/rhxFwY5LWljceUheD/q+puoE=;
        b=NGRm0+ZFb3L5rLnEFXku+GZHYab2KveH708VvYXqeDaV9SFfF5HR5GKsQu/u7e17VX
         /QkPPJSs+7zZQELonG/vbHuYNnU5/qxhO0tTeZfajckDprpQRtyNQAshjSBgRoP8w1oh
         0Mm3ctkNkBeMWJ1ZWyiV+SsTDczfRRrL+nCNVfqV1f5JQxA8UqmjzQJx1qQg6kQTHAm7
         /QMZas1qofGeYKsfNoQXwclAfTVzwH2hbojCgV2VgSPrcU6XzwinMdR4Pt+jjc95JxYf
         c6/sNYu+nWcWp9ATo02EnTAWHBovsaS3/UZ5sWSE+WUXIxnmD1qVaz+hvwT4t/E0pgzq
         T5Xw==
X-Gm-Message-State: AOAM530+HKnn5bZcw1PElDn7OzIPDGgi8bDYeafMsyDTewXfi1vlI2BI
        IqtJsHjTek9EfzJZc6UkY2HwJehWxdIsS4gmxXCKeGXXm1w=
X-Google-Smtp-Source: ABdhPJx7uuT8LA2rJhscYPcAfoTO3UV+lhPmoVvl10SzmZy/wDiEwXQ1p/gzWpl52lOH1VnYicM4YsBZoUkfmDgaXRY=
X-Received: by 2002:a25:b0a8:: with SMTP id f40mr10974815ybj.125.1636669151090;
 Thu, 11 Nov 2021 14:19:11 -0800 (PST)
MIME-Version: 1.0
References: <CAAmZXrsGg2xsP1CK+cbuEMumtrqdvD-NKnWzhNcvn71RV3c1yw@mail.gmail.com>
 <CAJfpeguXW=Xz-sRUjwOhwinRKpEo8tyxfe_ofhhRPsZreBoQSw@mail.gmail.com>
 <CAAmZXrtiJcmLzf6eb90RKdCs3Q=mFNCqAD86nZQJmVwr6YwEmA@mail.gmail.com> <YXqu/7zeuiDO5xRL@miu.piliscsaba.redhat.com>
In-Reply-To: <YXqu/7zeuiDO5xRL@miu.piliscsaba.redhat.com>
From:   Frank Dinoff <fdinoff@google.com>
Date:   Thu, 11 Nov 2021 17:18:54 -0500
Message-ID: <CAAmZXrvj3gGmK2AVH671+USc=jJksu+F7rHErmmE=Rp1_XBOkw@mail.gmail.com>
Subject: Re: fuse: kernel panic while using splice (lru corruption)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:09 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Oct 20, 2021 at 05:26:59PM -0400, Frank Dinoff wrote:
> > On Thu, Oct 7, 2021 at 8:54 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > Adding linux-mm/Johannes to Cc.
> > >
> > > On Wed, 6 Oct 2021 at 21:13, Frank Dinoff <fdinoff@google.com> wrote:
> > > >
> > > > I'm experiencing a kernel panic while using fuse related to SPLICE_F_MOVE.
> > > >
> > > > Some stack traces
> > > >
> > > > [   52.864466] CPU: 1 PID: 10619 Comm: cp Not tainted 5.15.0-upstream-DEV #7
> > > > [   52.879137] Hardware name: Google Google Compute Engine/Google
> > > > Compute Engine, BIOS Google 01/01/2011
> > > > [   52.888490] RIP: 0010:__list_del_entry_valid+0x69/0x80
> > > > [   52.893907] Code: 7f 12 84 31 c0 e8 2d 42 55 00 0f 0b 48 c7 c7 37
> > > > 8e 10 84 31 c0 e8 1d 42 55 00 0f 0b 48 c7 c7 19 52 19 84 31 c0 e8 0d
> > > > 42 55 00 <0f> 0b 48 c7 c7 8e e7 15 84 31 c0 e8 fd 41 55 00 0f 0b 00 00
> > > > 00 cc
> > > > [   52.980251] RSP: 0018:ffff8938ea093978 EFLAGS: 00010046
> > > > [   52.994508] RAX: 0000000000000054 RBX: ffffd8d7c5914ec0 RCX: 45fe15c1d0642d00
> > > > [   53.001774] RDX: ffff893939d230b8 RSI: ffff893939d17510 RDI: ffff893939d17510
> > > > [   53.009039] RBP: ffff8938ea093978 R08: 0000000000000000 R09: ffffffff8492dbf0
> > > > [   53.016312] R10: 00000000ffff7fff R11: 0000000000000000 R12: ffff8938ea093a98
> > > > [   53.023575] R13: ffff8938ced23400 R14: 000000000000000d R15: ffff8938ced23400
> > > > [   53.030843] FS:  00007f8bd4b1d740(0000) GS:ffff893939d00000(0000)
> > > > knlGS:0000000000000000
> > > > [   53.039064] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [   53.044939] CR2: 000000000020c86e CR3: 0000000164572003 CR4: 00000000003706e0
> > > > [   53.087945] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > [   53.105377] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > [   53.119206] Call Trace:
> > > > [   53.121786]  release_pages+0x1d0/0x490
> > > > [   53.125856]  __pagevec_release+0x4f/0x60
> > > > [   53.129914]  invalidate_inode_pages2_range+0x5c4/0x600
> > > > [   53.135186]  ? kmem_cache_free+0x7c/0x100
> > > > [   53.139330]  invalidate_inode_pages2+0x17/0x20
> > > > [   53.143907]  fuse_finish_open+0x75/0x150
> > > > [   53.147976]  fuse_open_common+0x113/0x120
> > > > [   53.152117]  fuse_open+0x10/0x20
> > > > [   53.155487]  do_dentry_open+0x263/0x360
> > > > [   53.167370]  vfs_open+0x2d/0x30
> > > > [   53.173633]  path_openat+0xa0f/0xd90
> > > > [   53.177353]  ? mntput+0x23/0x40
> > > > [   53.180635]  ? path_put+0x1e/0x30
> > > > [   53.184104]  do_filp_open+0xc7/0x170
> > > > [   53.187933]  do_sys_openat2+0x91/0x170
> > > > [   53.195012]  __x64_sys_openat+0x7e/0xa0
> > > > [   53.198989]  do_syscall_64+0x44/0xa0
> > > > [   53.202714]  ? exc_page_fault+0x71/0x160
> > > > [   53.211294]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > [   53.219256] RIP: 0033:0x7f8bd4c4bec2
> > > > [   53.231375] Code: 8d 48 08 48 89 4d d8 8b 18 48 8b 05 90 8d 07 00
> > > > 83 38 00 75 30 b8 01 01 00 00 41 89 da bf 9c ff ff ff 4c 89 f6 44 89
> > > > fa 0f 05 <48> 89 c3 48 3d 00 f0 ff ff 77 42 89 d8 48 81 c4 c8 00 00 00
> > > > 5b 41
> > > > [   53.261026] RSP: 002b:00007ffd4ae55570 EFLAGS: 00000246 ORIG_RAX:
> > > > 0000000000000101
> > > > [   53.268738] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8bd4c4bec2
> > > > [   53.284714] RDX: 0000000000000000 RSI: 00007ffd4ae57bbc RDI: 00000000ffffff9c
> > > > [   53.305198] RBP: 00007ffd4ae55650 R08: 0000000000000000 R09: 00007ffd4ae55baf
> > > > [   53.312469] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > > [   53.319736] R13: 00000000000081a4 R14: 00007ffd4ae57bbc R15: 0000000000000000
> > > > [   53.327003] Modules linked in: 9p 9pnet_virtio 9pnet vfat fat
> > > > virtio_net net_failover failover
> > > > [   53.335755] ---[ end trace 086000a6a6747ea3 ]---
> > > >
> > > > With CONFIG_DEBUG_VM it looks like we are trying to add a page to the lru that
> > > > is already on the lru.
> > >
> > > Code in question is in fs/fuse/dev.c:fuse_try_move_page() after the
> > > call to replace_page_cache_page().
> > >
> > > Looks like PIPE_BUF_FLAG_LRU isn't reliable., which means it's
> > > completely useless.
> > >
> > > Johannes, any idea how to fix this?
> >
> > Ping, any thoughts on how to fix this?
>
> Turns out to be a bad interaction between anon pipe bufs and the way fuse clones
> and steals pipe buffers.
>
> Here's a patch that should fix it (survives your reproducer).
>
> Thanks,
> Miklos
> ---

Slow response but thanks for the help here.


>
> From: Miklos Szeredi <mszeredi@redhat.com>
> Subject: fuse: fix page stealing
>
> It is possible to trigger a crash by splicing anon pipe bufs to the fuse
> device.
>
> The reason for this is that anon_pipe_buf_release() will reuse buf->page if
> the refcount is 1, but that page might have already been stolen and its
> flags modified (e.g. PG_lru added).
>
> This happens in the unlikely case of fuse_dev_splice_write() getting around
> to calling pipe_buf_release() after a page has been stolen, added to the
> page cache and removed from the page cache.
>
> Fix by calling pipe_buf_release() right after the page was inserted into
> the page cache.  In this case the page has an elevated refcount so any
> release function will know that the page isn't reusable.
>
> Reported-by: Frank Dinoff <fdinoff@google.com>
> Link: https://lore.kernel.org/r/CAAmZXrsGg2xsP1CK+cbuEMumtrqdvD-NKnWzhNcvn71RV3c1yw@mail.gmail.com/
> Fixes: dd3bb14f44a6 ("fuse: support splice() writing to fuse device")
> Cc: <stable@vger.kernel.org> # v2.6.35
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/dev.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -847,6 +847,12 @@ static int fuse_try_move_page(struct fus
>
>         replace_page_cache_page(oldpage, newpage);
>
> +       /*
> +        * Release while we have extra ref on stolen page.  Otherwise
> +        * anon_pipe_buf_release() might think the page can be reused.
> +        */
> +       pipe_buf_release(cs->pipe, buf);
> +
>         get_page(newpage);
>
>         if (!(buf->flags & PIPE_BUF_FLAG_LRU))
> @@ -2031,8 +2037,12 @@ static ssize_t fuse_dev_splice_write(str
>
>         pipe_lock(pipe);
>  out_free:
> -       for (idx = 0; idx < nbuf; idx++)
> -               pipe_buf_release(pipe, &bufs[idx]);
> +       for (idx = 0; idx < nbuf; idx++) {
> +               struct pipe_buffer *buf = &bufs[idx];
> +
> +               if (buf->ops)
> +                       pipe_buf_release(pipe, buf);
> +       }
>         pipe_unlock(pipe);
>
>         kvfree(bufs);
