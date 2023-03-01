Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846F26A7676
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 22:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCAVzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 16:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCAVzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:55:31 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D983B875
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 13:55:15 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso746256pju.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Mar 2023 13:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AE61FwVgXloNhSM5ZenfX5y6Vo/6+yh3Dr6aPcvzdng=;
        b=z6PaE6nerM9FUo86l1KBLYZPqhEYrwMnGztbwCVf5DcnhX5ZZfcdO12L5+kIEyAIjg
         GnGdIQhnuLCCTT72IjV2d98YrTtxZq6HXayw9WsLBOXEMWrgxeSKD/KJmglliI0Pa42a
         iJvoiFTDdCYUjV9FgU2fCnGexyqzpkveefAcRL42rfRifdbRLpAX7dQflk6xzoWWEii1
         2LF9U8ao+edu7MyG7sWfTDY8zVVeWji++EaPBZX6IOrxEON6Z++PBqGVdfuggFOqR5rN
         gb5d1PUrXVLtKsOO8CtRmX86WJiFvKftJfEEkF4r1HenSDabg89RfINkHGFqvdSY+8Mb
         GIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE61FwVgXloNhSM5ZenfX5y6Vo/6+yh3Dr6aPcvzdng=;
        b=BXKzc2SChzPDC2cer0uV1dap1t9h6gDvfVrB0/+n+vnF2HN/GqWFOIh3DjKP9s5aLJ
         lB6xRjs0ktdkd1QHHe9TK82T3kjyZrW9k15OxZa4LknMOOITY8hoSpcRKOiDbHNEk3VE
         u+6+n9829nFF81IheU4QjnVzdLwkNRfuRADpWRHUJGckvm0BrjskP//wlCfjmr0RcYSJ
         ABdEojpkpztcJTvYSSRxpvTZmm1LTPD3RrjeV9TiGlSRqBFbXbKg3krm6Y+Xka6llapS
         27YbLtH829ODltCuG8EryeH5pf4Ms7nRVuVE1efGwsxWByiQMCQI5P1Fwnx48qo3uQdY
         dLSg==
X-Gm-Message-State: AO0yUKVJfGE/EBUoOCzlpktoJ7dzAb4wUJM6whQDa4ICyov3axRgLtjo
        2IM0SVGG3XQprXi2JTd4w54CobamqhdJMBRv
X-Google-Smtp-Source: AK7set9DeyfsrZffzNp8g6/B9oLZMWp1hH0JhV6Y5X/KLVSOSkkHmWx3FGOYQhSNzmwg/KcjheFeVg==
X-Received: by 2002:a05:6a20:9150:b0:cd:ed5c:4be with SMTP id x16-20020a056a20915000b000cded5c04bemr7310602pzc.25.1677707714480;
        Wed, 01 Mar 2023 13:55:14 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id a6-20020a631a46000000b004fc1d91e695sm7821235pgm.79.2023.03.01.13.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 13:55:13 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pXUPn-003gHe-23; Thu, 02 Mar 2023 08:55:11 +1100
Date:   Thu, 2 Mar 2023 08:55:10 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     syzbot <syzbot+dd426ae4af71f1e74729@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] possible deadlock in evict (3)
Message-ID: <20230301215510.GM2825702@dread.disaster.area>
References: <20230301000142.GK2825702@dread.disaster.area>
 <87v8jka12p.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8jka12p.fsf@doe.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 09:57:58PM +0530, Ritesh Harjani wrote:
> Dave Chinner <david@fromorbit.com> writes:
> 
> > [obvious one for the ext4 people]
> >
> > On Tue, Feb 28, 2023 at 09:25:55AM -0800, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    ae3419fbac84 vc_screen: don't clobber return value in vcs_..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1136fe18c80000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff98a3b3c1aed3ab
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
> >> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >>
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+dd426ae4af71f1e74729@syzkaller.appspotmail.com
> >>
> >> ======================================================
> >> WARNING: possible circular locking dependency detected
> >> 6.2.0-syzkaller-12913-gae3419fbac84 #0 Not tainted
> >> ------------------------------------------------------
> >> kswapd0/100 is trying to acquire lock:
> >> ffff888047aea650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x6b0 fs/inode.c:665
> >>
> >> but task is already holding lock:
> >> ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: set_task_reclaim_state mm/vmscan.c:200 [inline]
> >> ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x170/0x1ac0 mm/vmscan.c:7338
> >>
> >> which lock already depends on the new lock.
> >>
> >>
> >> the existing dependency chain (in reverse order) is:
> >>
> >> -> #3 (fs_reclaim){+.+.}-{0:0}:
> >>        __fs_reclaim_acquire mm/page_alloc.c:4716 [inline]
> >>        fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4730
> >>        might_alloc include/linux/sched/mm.h:271 [inline]
> >>        prepare_alloc_pages+0x159/0x570 mm/page_alloc.c:5362
> >>        __alloc_pages+0x149/0x5c0 mm/page_alloc.c:5580
> >>        alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
> >>        __get_free_pages+0xc/0x40 mm/page_alloc.c:5641
> >>        kasan_populate_vmalloc_pte mm/kasan/shadow.c:309 [inline]
> >>        kasan_populate_vmalloc_pte+0x27/0x150 mm/kasan/shadow.c:300
> >>        apply_to_pte_range mm/memory.c:2578 [inline]
> >>        apply_to_pmd_range mm/memory.c:2622 [inline]
> >>        apply_to_pud_range mm/memory.c:2658 [inline]
> >>        apply_to_p4d_range mm/memory.c:2694 [inline]
> >>        __apply_to_page_range+0x68c/0x1030 mm/memory.c:2728
> >>        alloc_vmap_area+0x536/0x1f20 mm/vmalloc.c:1638
> >>        __get_vm_area_node+0x145/0x3f0 mm/vmalloc.c:2495
> >>        __vmalloc_node_range+0x250/0x1300 mm/vmalloc.c:3141
> >>        kvmalloc_node+0x156/0x1a0 mm/util.c:628
> >>        kvmalloc include/linux/slab.h:737 [inline]
> >>        ext4_xattr_move_to_block fs/ext4/xattr.c:2570 [inline]
> >
> > 	buffer = kvmalloc(value_size, GFP_NOFS);
> >
> > Yeah, this doesn't work like the code says it should. The gfp mask
> > is not passed down to the page table population code and it hard
> > codes GFP_KERNEL allocations so you have to do:
> >
> > 	memalloc_nofs_save();
> > 	buffer = kvmalloc(value_size, GFP_KERNEL);
> > 	memalloc_nofs_restore();
> >
> > to apply GFP_NOFS to allocations in the pte population code to avoid
> > memory reclaim recursion in kvmalloc.
> 
> What about this patch mentioned below? Is it the kasan allocations
> (kasan_populate_vmalloc()), which hasn't been taken care of in this
> patch. Does this means we need kvmalloc fixed instead for kasan allocations?
> 
> Though I agree we can have the fix like you mentioned above
> (as many of the API users are already doing above). Just wanted to have the
> full context of what is going on here.
> 
> 451769ebb7e792c3404db53b3c2a422990de654e
> Author:     Michal Hocko <mhocko@suse.com>
> 
> mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc

Oh, you're right, I didn't realise that had been smacked into the
guts of the vmalloc implementation instead of just being wrapped
around the whole lot of it. That's an exact example of *how not to
use scoped allocation contexts* because it leads to stupid
whack-a-mole bugs like this one.  I made this exact point in the
discussion you pointed to when I noticed an anti-pattern of scoped
contexts were being used to wrap single kmalloc(GFP_KERNEL) calls.

KASAN essentialy requires explicit use of allocation scopes to avoid
spurious lockdep GFP_NOFS/GFP_NOIO allocation context warnings
because most of it's low level tracking allocations are GFP_KERNEL.
If we wrap the whole of kvmalloc() with the correct context,
everything is fine. But using contexts for fined-grained internal
"fix only the specific call-chain" patches like the above commit,
then it just doesn't work.

So in this case, I agree with you that this is a kvmalloc() bug in
that kvmalloc is failing to apply the GFP_NOFS scoped context across
the entire vmalloc operation. As it currently stands, any low level
allocation in the vmalloc path that isn't passed the correct gfp
mask will trigger this sort of warning.

This is one of the reasons we use the scopes extensively in XFS -
whenever we enter a NOFS context, we call memalloc_nofs_save() and
so we always get disconnected low level allocations (like KASAN
does) doing the right thing. Hence we simply haven't noticed how
badly vmalloc() screwed up setting allocation contexts....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
