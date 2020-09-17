Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D1C26DCC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgIQN0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIQNTt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:19:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED88C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 06:19:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so2036471wrn.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OJz3dROXwZ4H9FjplYiHUh7ta1dm2pPiZx++Qm+gMOk=;
        b=Ol8zdtYKra8OqwKcXQZPTIzAIAjrxl7EnGA/qptW05V0voGayUZTJ1UOmlJx84mWcm
         0r1ALbQGydxydvFM37pyuB+FPcNQJYGFXrs30Uy4uBKXsTI9vDopq0psqSt8WIVbv/3m
         SL42by4B46k89IfXDFWI+V95drUdRSPKiXLkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=OJz3dROXwZ4H9FjplYiHUh7ta1dm2pPiZx++Qm+gMOk=;
        b=km321llPycczziPIuyLWCEbTpWbG0ETYU2yRjzJyCXMe86UGSL8gNX3bTHEr0hd+kW
         JHUbKIHECPjcB2DsWcmgMX9uuaxcNd6CTe+7cKv1e5fCvei4+jTAo2li7in1ms0wQFlU
         FdHhoa2PohAFlhWz3hB6zlzPw2azdsOvvDmmG8Bi5sLUzSqviPX7x7Pu3o03eMB2eKGL
         mL9EyByv4dKCZHfYgdjvGA0jChZeHwCXJWWJW1O5yGL65bmf1bhSkkCKShBDbdhymWda
         Jyd9/qekHHyskImXAL/1B8hSUS7F+wx7rIHI6In4+IMvV5K/0sP9fDFMjEFjq3ScGpmG
         zLfA==
X-Gm-Message-State: AOAM532vz0PHleZL5zZBnhPWYD1H7I6xZ1CqxVTkwNnV+oBGRs+daHXj
        WVGuO6BhkjmI0N2oy9WjQxkJRA==
X-Google-Smtp-Source: ABdhPJwWrq6ZejmimL/ybiemi2sN/GPynbFDqZKwAC87Lkhqkhgx8buF3bHZlQuU+GRDRVJVnJpavA==
X-Received: by 2002:a5d:6b84:: with SMTP id n4mr34531077wrx.55.1600348785370;
        Thu, 17 Sep 2020 06:19:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d2sm39644798wro.34.2020.09.17.06.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 06:19:44 -0700 (PDT)
Date:   Thu, 17 Sep 2020 15:19:42 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Dave Chinner <david@fromorbit.com>, Qian Cai <cai@lca.pw>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH] dma-resv: lockdep-prime address_space->i_mmap_rwsem for
 dma-resv
Message-ID: <20200917131942.GX438822@phenom.ffwll.local>
Mail-Followup-To: Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= <thomas_os@shipmail.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
        Dave Chinner <david@fromorbit.com>, Qian Cai <cai@lca.pw>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>, Linux MM <linux-mm@kvack.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20200728135839.1035515-1-daniel.vetter@ffwll.ch>
 <38cbc4fb-3a88-47c4-2d6c-4d90f9be42e7@shipmail.org>
 <CAKMK7uFe-70DE5qOBJ6FwD8d_A0yZt+h5bCqA=e9QtYE1qwASQ@mail.gmail.com>
 <60f2b14f-8cef-f515-9cf5-bdbc02d9c63c@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60f2b14f-8cef-f515-9cf5-bdbc02d9c63c@shipmail.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 06:45:14PM +0200, Thomas Hellström (Intel) wrote:
> 
> On 7/30/20 3:17 PM, Daniel Vetter wrote:
> > On Thu, Jul 30, 2020 at 2:17 PM Thomas Hellström (Intel)
> > <thomas_os@shipmail.org> wrote:
> > > 
> > > On 7/28/20 3:58 PM, Daniel Vetter wrote:
> > > > GPU drivers need this in their shrinkers, to be able to throw out
> > > > mmap'ed buffers. Note that we also need dma_resv_lock in shrinkers,
> > > > but that loop is resolved by trylocking in shrinkers.
> > > > 
> > > > So full hierarchy is now (ignore some of the other branches we already
> > > > have primed):
> > > > 
> > > > mmap_read_lock -> dma_resv -> shrinkers -> i_mmap_lock_write
> > > > 
> > > > I hope that's not inconsistent with anything mm or fs does, adding
> > > > relevant people.
> > > > 
> > > Looks OK to me. The mapping_dirty_helpers run under the i_mmap_lock, but
> > > don't allocate any memory AFAICT.
> > > 
> > > Since huge page-table-entry splitting may happen under the i_mmap_lock
> > > from unmap_mapping_range() it might be worth figuring out how new page
> > > directory pages are allocated, though.
> > ofc I'm not an mm expert at all, but I did try to scroll through all
> > i_mmap_lock_write/read callers. Found the following:
> > 
> > - kernel/events/uprobes.c in build_map_info:
> > 
> >              /*
> >               * Needs GFP_NOWAIT to avoid i_mmap_rwsem recursion through
> >               * reclaim. This is optimistic, no harm done if it fails.
> >               */
> > 
> > - I got lost in the hugetlb.c code and couldn't convince myself it's
> > not allocating page directories at various levels with something else
> > than GFP_KERNEL.
> > 
> > So looks like the recursion is clearly there and known, but the
> > hugepage code is too complex and flying over my head.
> > -Daniel
> 
> OK, so I inverted your annotation and ran a memory hog, and got the below
> splat. So clearly your proposed reclaim->i_mmap_lock locking order is an
> already established one.
> 
> So
> 
> Reviewed-by: Thomas Hellström <thomas.hellstrom@intel.com>

No one complaining that this is a terrible idea and two reviews from
people who know stuff, so I went ahead and pushed this to drm-misc-next.

Thanks for taking a look at this.
-Daniel

> 
> 8<---------------------------------------------------------------------------------------------
> 
> [  308.324654] WARNING: possible circular locking dependency detected
> [  308.324655] 5.8.0-rc2+ #16 Not tainted
> [  308.324656] ------------------------------------------------------
> [  308.324657] kswapd0/98 is trying to acquire lock:
> [  308.324658] ffff92a16f758428 (&mapping->i_mmap_rwsem){++++}-{3:3}, at:
> rmap_walk_file+0x1c0/0x2f0
> [  308.324663]
>                but task is already holding lock:
> [  308.324664] ffffffffb0960240 (fs_reclaim){+.+.}-{0:0}, at:
> __fs_reclaim_acquire+0x5/0x30
> [  308.324666]
>                which lock already depends on the new lock.
> 
> [  308.324667]
>                the existing dependency chain (in reverse order) is:
> [  308.324667]
>                -> #1 (fs_reclaim){+.+.}-{0:0}:
> [  308.324670]        fs_reclaim_acquire+0x34/0x40
> [  308.324672]        dma_resv_lockdep+0x186/0x224
> [  308.324675]        do_one_initcall+0x5d/0x2c0
> [  308.324676]        kernel_init_freeable+0x222/0x288
> [  308.324678]        kernel_init+0xa/0x107
> [  308.324679]        ret_from_fork+0x1f/0x30
> [  308.324680]
>                -> #0 (&mapping->i_mmap_rwsem){++++}-{3:3}:
> [  308.324682]        __lock_acquire+0x119f/0x1fc0
> [  308.324683]        lock_acquire+0xa4/0x3b0
> [  308.324685]        down_read+0x2d/0x110
> [  308.324686]        rmap_walk_file+0x1c0/0x2f0
> [  308.324687]        page_referenced+0x133/0x150
> [  308.324689]        shrink_active_list+0x142/0x610
> [  308.324690]        balance_pgdat+0x229/0x620
> [  308.324691]        kswapd+0x200/0x470
> [  308.324693]        kthread+0x11f/0x140
> [  308.324694]        ret_from_fork+0x1f/0x30
> [  308.324694]
>                other info that might help us debug this:
> 
> [  308.324695]  Possible unsafe locking scenario:
> 
> [  308.324695]        CPU0                    CPU1
> [  308.324696]        ----                    ----
> [  308.324696]   lock(fs_reclaim);
> [  308.324697] lock(&mapping->i_mmap_rwsem);
> [  308.324698]                                lock(fs_reclaim);
> [  308.324699]   lock(&mapping->i_mmap_rwsem);
> [  308.324699]
>                 *** DEADLOCK ***
> 
> [  308.324700] 1 lock held by kswapd0/98:
> [  308.324701]  #0: ffffffffb0960240 (fs_reclaim){+.+.}-{0:0}, at:
> __fs_reclaim_acquire+0x5/0x30
> [  308.324702]
>                stack backtrace:
> [  308.324704] CPU: 1 PID: 98 Comm: kswapd0 Not tainted 5.8.0-rc2+ #16
> [  308.324705] Hardware name: VMware, Inc. VMware Virtual Platform/440BX
> Desktop Reference Platform, BIOS 6.00 07/29/2019
> [  308.324706] Call Trace:
> [  308.324710]  dump_stack+0x92/0xc8
> [  308.324711]  check_noncircular+0x12d/0x150
> [  308.324713]  __lock_acquire+0x119f/0x1fc0
> [  308.324715]  lock_acquire+0xa4/0x3b0
> [  308.324716]  ? rmap_walk_file+0x1c0/0x2f0
> [  308.324717]  ? __lock_acquire+0x394/0x1fc0
> [  308.324719]  down_read+0x2d/0x110
> [  308.324720]  ? rmap_walk_file+0x1c0/0x2f0
> [  308.324721]  rmap_walk_file+0x1c0/0x2f0
> [  308.324722]  page_referenced+0x133/0x150
> [  308.324724]  ? __page_set_anon_rmap+0x70/0x70
> [  308.324725]  ? page_get_anon_vma+0x190/0x190
> [  308.324726]  shrink_active_list+0x142/0x610
> [  308.324728]  balance_pgdat+0x229/0x620
> [  308.324730]  kswapd+0x200/0x470
> [  308.324731]  ? lockdep_hardirqs_on_prepare+0xf5/0x170
> [  308.324733]  ? finish_wait+0x80/0x80
> [  308.324734]  ? balance_pgdat+0x620/0x620
> [  308.324736]  kthread+0x11f/0x140
> [  308.324737]  ? kthread_create_worker_on_cpu+0x40/0x40
> [  308.324739]  ret_from_fork+0x1f/0x30
> 
> 
> 
> > > /Thomas
> > > 
> > > 
> > > 
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
