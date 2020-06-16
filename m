Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E971FAC57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 11:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFPJ1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 05:27:38 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:41787 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPJ1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:27:37 -0400
Received: by mail-ej1-f68.google.com with SMTP id dp18so2527669ejc.8;
        Tue, 16 Jun 2020 02:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HQVEwzF61pJG67w4VVFyK6E5C1QP2FoVP3jQ17g95ks=;
        b=ianh7nndYQ13TLPF27DjLebiRUzx3SH6EsOTRsAMNeQLOdIYdu05SWftW3E27crnmB
         Jtnn/UzJA5SCMNO3hxPYHS+doIdFEF7MavvBOvqNgumKcYYXjuwDHYKY4kH858C4/pPo
         wr/8ok0tJ++lrux3807YQwRk/EtGHgpHqCo/DNiqZRYteNVnZF6fViiq8t+ICIi/2/Vi
         aIjqVm+bVZdzlyghtiCRzzukPL57CBzWga2y0ralYxl9CxezoKq91JLsW+t3IB/9nya5
         w6D4/A76pRCzz7cYKklrYRo8hKfVx5XI40Gg2PPf6QwtG1ZhLJMBsbggc95I/DopSpmU
         MyqQ==
X-Gm-Message-State: AOAM533yI6O+7zBHchUMz6x0a73T4edKb8e1qHYY3hNtvIX37NJ+Fg7D
        XqtdfZ4Ow7Fqw+XJ4CgkOk0=
X-Google-Smtp-Source: ABdhPJzgkkE5RAtuOPXtr3stKyyC1FyTvZ9fNK0/KUpTftRx6B56W2cpdvndiDarNtDvhPe+zX8URQ==
X-Received: by 2002:a17:906:ca54:: with SMTP id jx20mr2010240ejb.549.1592299655323;
        Tue, 16 Jun 2020 02:27:35 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
        by smtp.gmail.com with ESMTPSA id a7sm9803383edx.3.2020.06.16.02.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 02:27:34 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:27:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v3] xfs: avoid deadlock when trigger memory reclaim in
 ->writepages
Message-ID: <20200616092727.GD9499@dhcp22.suse.cz>
References: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com>
 <20200616081628.GC9499@dhcp22.suse.cz>
 <CALOAHbDsCB1yZE6m96xiX1KiUWJW-8Hn0eqGcuEipkf9R6_L2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbDsCB1yZE6m96xiX1KiUWJW-8Hn0eqGcuEipkf9R6_L2A@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-06-20 17:05:25, Yafang Shao wrote:
> On Tue, Jun 16, 2020 at 4:16 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 15-06-20 07:56:21, Yafang Shao wrote:
> > > Recently there is a XFS deadlock on our server with an old kernel.
> > > This deadlock is caused by allocating memory in xfs_map_blocks() while
> > > doing writeback on behalf of memroy reclaim. Although this deadlock happens
> > > on an old kernel, I think it could happen on the upstream as well. This
> > > issue only happens once and can't be reproduced, so I haven't tried to
> > > reproduce it on upsteam kernel.
> > >
> > > Bellow is the call trace of this deadlock.
> > > [480594.790087] INFO: task redis-server:16212 blocked for more than 120 seconds.
> > > [480594.790087] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [480594.790088] redis-server    D ffffffff8168bd60     0 16212  14347 0x00000004
> > > [480594.790090]  ffff880da128f070 0000000000000082 ffff880f94a2eeb0 ffff880da128ffd8
> > > [480594.790092]  ffff880da128ffd8 ffff880da128ffd8 ffff880f94a2eeb0 ffff88103f9d6c40
> > > [480594.790094]  0000000000000000 7fffffffffffffff ffff88207ffc0ee8 ffffffff8168bd60
> > > [480594.790096] Call Trace:
> > > [480594.790101]  [<ffffffff8168dce9>] schedule+0x29/0x70
> > > [480594.790103]  [<ffffffff8168b749>] schedule_timeout+0x239/0x2c0
> > > [480594.790111]  [<ffffffff8168d28e>] io_schedule_timeout+0xae/0x130
> > > [480594.790114]  [<ffffffff8168d328>] io_schedule+0x18/0x20
> > > [480594.790116]  [<ffffffff8168bd71>] bit_wait_io+0x11/0x50
> > > [480594.790118]  [<ffffffff8168b895>] __wait_on_bit+0x65/0x90
> > > [480594.790121]  [<ffffffff811814e1>] wait_on_page_bit+0x81/0xa0
> > > [480594.790125]  [<ffffffff81196ad2>] shrink_page_list+0x6d2/0xaf0
> > > [480594.790130]  [<ffffffff811975a3>] shrink_inactive_list+0x223/0x710
> > > [480594.790135]  [<ffffffff81198225>] shrink_lruvec+0x3b5/0x810
> > > [480594.790139]  [<ffffffff8119873a>] shrink_zone+0xba/0x1e0
> > > [480594.790141]  [<ffffffff81198c20>] do_try_to_free_pages+0x100/0x510
> > > [480594.790143]  [<ffffffff8119928d>] try_to_free_mem_cgroup_pages+0xdd/0x170
> > > [480594.790145]  [<ffffffff811f32de>] mem_cgroup_reclaim+0x4e/0x120
> > > [480594.790147]  [<ffffffff811f37cc>] __mem_cgroup_try_charge+0x41c/0x670
> > > [480594.790153]  [<ffffffff811f5cb6>] __memcg_kmem_newpage_charge+0xf6/0x180
> > > [480594.790157]  [<ffffffff8118c72d>] __alloc_pages_nodemask+0x22d/0x420
> > > [480594.790162]  [<ffffffff811d0c7a>] alloc_pages_current+0xaa/0x170
> > > [480594.790165]  [<ffffffff811db8fc>] new_slab+0x30c/0x320
> > > [480594.790168]  [<ffffffff811dd17c>] ___slab_alloc+0x3ac/0x4f0
> > > [480594.790204]  [<ffffffff81685656>] __slab_alloc+0x40/0x5c
> > > [480594.790206]  [<ffffffff811dfc43>] kmem_cache_alloc+0x193/0x1e0
> > > [480594.790233]  [<ffffffffa04fab67>] kmem_zone_alloc+0x97/0x130 [xfs]
> > > [480594.790247]  [<ffffffffa04f90ba>] _xfs_trans_alloc+0x3a/0xa0 [xfs]
> > > [480594.790261]  [<ffffffffa04f915c>] xfs_trans_alloc+0x3c/0x50 [xfs]
> >
> > Now with a more explanation from Dave I have got back to the original
> > backtrace. Not sure which kernel version you are using but this path
> > should have passed xfs_trans_reserve which sets PF_MEMALLOC_NOFS and
> > this in turn should have made __alloc_pages_nodemask to use __GFP_NOFS
> > and the memcg reclaim shouldn't ever wait_on_page_writeback (pressumably
> > this is what the io_schedule is coming from).
> 
> Hi Michal,
> 
> The page is allocated before calling xfs_trans_reserve, so the
> PF_MEMALLOC_NOFS hasn't been set yet.
> See bellow,
> 
> xfs_trans_alloc
>     kmem_zone_zalloc() <<< GPF_NOFS hasn't been set yet, but it may
> trigger memory reclaim
>     xfs_trans_reserve() <<<< GPF_NOFS is set here (for the kernel
> prior to commit 9070733b4efac, it is PF_FSTRANS)

You are right, I have misread the actual allocation side. 8683edb7755b8
has added KM_NOFS and 73d30d48749f8 has removed it. I cannot really
judge the correctness here.

-- 
Michal Hocko
SUSE Labs
