Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A181B1ADB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 02:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgDUAoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 20:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726405AbgDUAoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 20:44:01 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED52C061A0F
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 17:44:00 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j14so9645563lfg.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 17:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZRwrK1UjiJpxDYSszjRPtqs1cjLjLji6Aam7rS81wo=;
        b=FQPGxAaF17vSSjjng+SYnVVTyYVA5s2NG2nnA/4N5kDp/WGCIrb9f25On61fC0A+Mz
         ArASZ/MOC2sFxS+nTQb0i3heZ8Ll8zNSL8IdvP2+Mna+8oUk343fzXUGUxuQLgoMW1Z4
         O1jPs/t5whKhm7gTkJBQZestxtL3Dmcfy7EBMApLi0iSO0KWfQQuLCxKrEFiTYNN/OWU
         h0Ilp90Q6OjyQ3npdWPqddwv5b8E9qdaHGsEOkd8UvwVHnCIO9+AnxuUgJmr+wM8tDXz
         7krNt+EMRR4FeeU9CTQQ/Ufy7Dc5u+ind2EDMZ2YSGF7sRuDCng69DxqD8wNP25ug6Nz
         Ql8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZRwrK1UjiJpxDYSszjRPtqs1cjLjLji6Aam7rS81wo=;
        b=cptiRL9fSdBm6aEOyM7nDtCG10zyIKAc1g1P0Z/QbgwFxA7QgYRFRhnmOqXQ2HWR6U
         RCteHKufgxd/5QT7af4a/4uCvedQ+47ocZh3Lf0cXnaeVu9dE/8yC+7007NHQ02LTxnP
         5B4ewf2DBS08ICE+lPBtmvznzJRXsPosy01GPJOanImFqLhtTzHcyGZavxzm07OmCHYj
         55Foo4WfIpbF0nLyLHm/4wDsr7a3FmoG+lf7ejMEqwUsyWbtJr2INHXIfW52t1AvEwqR
         oDd3rFkj07w1RqhQtASdmZFUYsal0SakQnaf3vsDogiSNt6IP5VP8k/Dz6L7wayGfuY8
         Q22w==
X-Gm-Message-State: AGi0PuZ0EjUh9uwxLFf0rFJ9Rwq7mlXEOUuTsljVG8h2/FaLRn0c0Clg
        ci+UCclVgFOe6iW/rREluYImeMivg2eqyZNQzi/rZg==
X-Google-Smtp-Source: APiQypJA0kncl3JUukHJh3Fz03w09zxZUG/GX3THwphT5IE6WJ7yzeQ6IMtZBOX7BEGJ02BB50U5guI79IbFaZqJp2g=
X-Received: by 2002:a05:6512:318a:: with SMTP id i10mr12195933lfe.96.1587429838243;
 Mon, 20 Apr 2020 17:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200420223936.6773-1-schatzberg.dan@gmail.com> <20200420223936.6773-3-schatzberg.dan@gmail.com>
In-Reply-To: <20200420223936.6773-3-schatzberg.dan@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 20 Apr 2020 17:43:47 -0700
Message-ID: <CALvZod4GizLVogLoGObxqXveeFX+vBm2SEpHNYA+Yz+Op7o0Qg@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: support nesting memalloc_use_memcg()
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 3:41 PM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> The memalloc_use_memcg() function to override the default memcg
> accounting context currently doesn't nest. But the patches to make the
> loop driver cgroup-aware will end up nesting:
>
> [   98.137605]  alloc_page_buffers+0x210/0x288
> [   98.141799]  __getblk_gfp+0x1d4/0x400
> [   98.145475]  ext4_read_block_bitmap_nowait+0x148/0xbc8
> [   98.150628]  ext4_mb_init_cache+0x25c/0x9b0
> [   98.154821]  ext4_mb_init_group+0x270/0x390
> [   98.159014]  ext4_mb_good_group+0x264/0x270
> [   98.163208]  ext4_mb_regular_allocator+0x480/0x798
> [   98.168011]  ext4_mb_new_blocks+0x958/0x10f8
> [   98.172294]  ext4_ext_map_blocks+0xec8/0x1618
> [   98.176660]  ext4_map_blocks+0x1b8/0x8a0
> [   98.180592]  ext4_writepages+0x830/0xf10
> [   98.184523]  do_writepages+0xb4/0x198
> [   98.188195]  __filemap_fdatawrite_range+0x170/0x1c8
> [   98.193086]  filemap_write_and_wait_range+0x40/0xb0
> [   98.197974]  ext4_punch_hole+0x4a4/0x660
> [   98.201907]  ext4_fallocate+0x294/0x1190
> [   98.205839]  loop_process_work+0x690/0x1100
> [   98.210032]  loop_workfn+0x2c/0x110
> [   98.213529]  process_one_work+0x3e0/0x648
> [   98.217546]  worker_thread+0x70/0x670
> [   98.221217]  kthread+0x1b8/0x1c0
> [   98.224452]  ret_from_fork+0x10/0x18
>
> where loop_process_work() sets the memcg override to the memcg that
> submitted the IO request, and alloc_page_buffers() sets the override
> to the memcg that instantiated the cache page, which may differ.
>
> Make memalloc_use_memcg() return the old memcg and convert existing
> users to a stacking model. Delete the unused memalloc_unuse_memcg().
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

This patch was from Johannes, so I would suggest to keep his
authorship and signoff along with your signoff.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
