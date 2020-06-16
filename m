Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D541FABDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 11:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgFPJGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 05:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgFPJGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:06:04 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F2C05BD43;
        Tue, 16 Jun 2020 02:06:02 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r77so21085094ior.3;
        Tue, 16 Jun 2020 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SIrAy6Ll/BSdyPHR1xKeq//+v/R1eYwZGTdPQnVwoDk=;
        b=eBvHFmzkkSeEq7LpcZu5qT/XFlAbzVvgn6UmZ8QwBqeivsa/P2uznKV1/1YJxwJngV
         sh6eL7vn5wu+U2PospGKeR8TXfSsMfGRMIkzc+B18kFnxnPxjoI0PFApdyKtEYMcx5m3
         rsQvDW1tiUvNt0oNyeQgZ2Q7WMdrGn9DsdHusKxRUHRNrS2jUdaXZhdp8vYvefTZVtBD
         ZNZwzkT1Jg5dH1j7VSRXO3x9ESsTMroLRSpkMBT0FiCUUEPH1m6k4YHu8pIG95Uc79tp
         49lZEw5TxDGeQGyKSZoZurwp7Y/lIhsP39SQmKir1PDS22ex4xcX83I8TbrzoJ/aghNY
         4zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SIrAy6Ll/BSdyPHR1xKeq//+v/R1eYwZGTdPQnVwoDk=;
        b=cAkl1s5yaGW+cg4mo9DXCOVblYLCfYSDUAXU74e8JHxr3PLYf3AYStmCcwTrXhDSbK
         iaEPNdMRkFbbF0ESXaaaOIP6inWk1DKJ0FJ+7i9rBnb47mNMjx89Mi+qYYE/WcporcVR
         0eFHBlZ7kcIzW+YCRHr2g6+OkM/tfhzCSI/aFgWmnRTeWSZdbZtb8grVIAxBqHSO5lnc
         3Gc4bDjsOVkYqH0l9oLhQB59oRSjB6C6wi72rEn7bPve/+ftNJS15oHhbqqOuMd2Hkz6
         2Pk47nAvxW9qpKE4GlBJWIMgZgPrFi9dpaadDtSRME2V+Whvo9PbX1lpxtI1g9VehtMX
         aK3g==
X-Gm-Message-State: AOAM533AVTODObZU94BIMpzS4CyssUGAEnxDzKBa02IdOtkvnZhemBby
        9We5iCY2MyKgHrvgxlNvdw8ImYyxoOaylcIo45gkvbvF9FS7Wg==
X-Google-Smtp-Source: ABdhPJxIeU3ACgLnuhzNdsOrH8YubRqvW7gdBnY6VxaF/1QZOx89eAPEgJIJPj9V1+Fp/wCFbqajVjcd+M8qZyK3bFs=
X-Received: by 2002:a02:c004:: with SMTP id y4mr24754760jai.81.1592298362019;
 Tue, 16 Jun 2020 02:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com> <20200616081628.GC9499@dhcp22.suse.cz>
In-Reply-To: <20200616081628.GC9499@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 16 Jun 2020 17:05:25 +0800
Message-ID: <CALOAHbDsCB1yZE6m96xiX1KiUWJW-8Hn0eqGcuEipkf9R6_L2A@mail.gmail.com>
Subject: Re: [PATCH v3] xfs: avoid deadlock when trigger memory reclaim in ->writepages
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 4:16 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 15-06-20 07:56:21, Yafang Shao wrote:
> > Recently there is a XFS deadlock on our server with an old kernel.
> > This deadlock is caused by allocating memory in xfs_map_blocks() while
> > doing writeback on behalf of memroy reclaim. Although this deadlock happens
> > on an old kernel, I think it could happen on the upstream as well. This
> > issue only happens once and can't be reproduced, so I haven't tried to
> > reproduce it on upsteam kernel.
> >
> > Bellow is the call trace of this deadlock.
> > [480594.790087] INFO: task redis-server:16212 blocked for more than 120 seconds.
> > [480594.790087] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [480594.790088] redis-server    D ffffffff8168bd60     0 16212  14347 0x00000004
> > [480594.790090]  ffff880da128f070 0000000000000082 ffff880f94a2eeb0 ffff880da128ffd8
> > [480594.790092]  ffff880da128ffd8 ffff880da128ffd8 ffff880f94a2eeb0 ffff88103f9d6c40
> > [480594.790094]  0000000000000000 7fffffffffffffff ffff88207ffc0ee8 ffffffff8168bd60
> > [480594.790096] Call Trace:
> > [480594.790101]  [<ffffffff8168dce9>] schedule+0x29/0x70
> > [480594.790103]  [<ffffffff8168b749>] schedule_timeout+0x239/0x2c0
> > [480594.790111]  [<ffffffff8168d28e>] io_schedule_timeout+0xae/0x130
> > [480594.790114]  [<ffffffff8168d328>] io_schedule+0x18/0x20
> > [480594.790116]  [<ffffffff8168bd71>] bit_wait_io+0x11/0x50
> > [480594.790118]  [<ffffffff8168b895>] __wait_on_bit+0x65/0x90
> > [480594.790121]  [<ffffffff811814e1>] wait_on_page_bit+0x81/0xa0
> > [480594.790125]  [<ffffffff81196ad2>] shrink_page_list+0x6d2/0xaf0
> > [480594.790130]  [<ffffffff811975a3>] shrink_inactive_list+0x223/0x710
> > [480594.790135]  [<ffffffff81198225>] shrink_lruvec+0x3b5/0x810
> > [480594.790139]  [<ffffffff8119873a>] shrink_zone+0xba/0x1e0
> > [480594.790141]  [<ffffffff81198c20>] do_try_to_free_pages+0x100/0x510
> > [480594.790143]  [<ffffffff8119928d>] try_to_free_mem_cgroup_pages+0xdd/0x170
> > [480594.790145]  [<ffffffff811f32de>] mem_cgroup_reclaim+0x4e/0x120
> > [480594.790147]  [<ffffffff811f37cc>] __mem_cgroup_try_charge+0x41c/0x670
> > [480594.790153]  [<ffffffff811f5cb6>] __memcg_kmem_newpage_charge+0xf6/0x180
> > [480594.790157]  [<ffffffff8118c72d>] __alloc_pages_nodemask+0x22d/0x420
> > [480594.790162]  [<ffffffff811d0c7a>] alloc_pages_current+0xaa/0x170
> > [480594.790165]  [<ffffffff811db8fc>] new_slab+0x30c/0x320
> > [480594.790168]  [<ffffffff811dd17c>] ___slab_alloc+0x3ac/0x4f0
> > [480594.790204]  [<ffffffff81685656>] __slab_alloc+0x40/0x5c
> > [480594.790206]  [<ffffffff811dfc43>] kmem_cache_alloc+0x193/0x1e0
> > [480594.790233]  [<ffffffffa04fab67>] kmem_zone_alloc+0x97/0x130 [xfs]
> > [480594.790247]  [<ffffffffa04f90ba>] _xfs_trans_alloc+0x3a/0xa0 [xfs]
> > [480594.790261]  [<ffffffffa04f915c>] xfs_trans_alloc+0x3c/0x50 [xfs]
>
> Now with a more explanation from Dave I have got back to the original
> backtrace. Not sure which kernel version you are using but this path
> should have passed xfs_trans_reserve which sets PF_MEMALLOC_NOFS and
> this in turn should have made __alloc_pages_nodemask to use __GFP_NOFS
> and the memcg reclaim shouldn't ever wait_on_page_writeback (pressumably
> this is what the io_schedule is coming from).

Hi Michal,

The page is allocated before calling xfs_trans_reserve, so the
PF_MEMALLOC_NOFS hasn't been set yet.
See bellow,

xfs_trans_alloc
    kmem_zone_zalloc() <<< GPF_NOFS hasn't been set yet, but it may
trigger memory reclaim
    xfs_trans_reserve() <<<< GPF_NOFS is set here (for the kernel
prior to commit 9070733b4efac, it is PF_FSTRANS)


>  Does your kernel have
> ecf5fc6e9654c?

Yes, we have backported this commit to our in-house kernel.

-- 
Thanks
Yafang
