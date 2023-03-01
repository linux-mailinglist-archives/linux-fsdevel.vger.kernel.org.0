Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342F06A63F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 01:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCAABv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 19:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCAABu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:01:50 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219DE3646D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 16:01:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so11286153pjz.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 16:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dase/rKwb8olXZw4+LDNprv2RVCPainY9pi10HK+tM4=;
        b=EoN6tMUySbv/wFvH2G/QeYhTnLIx3gjJeTQtsMNGzRTnISlnTeG8+r+tvwK6CmYT41
         OeouGTxgJLPsn272MRkAGA4Olp0GdYTo6rrImv8mCMuQ/Wp44Ka7nK2wTZ0z0lgh/Qx+
         dZJ9uNPfEhxRodhq6vnIxcWla5T03eiWYMPAFlMAt+7sFP9HaC7pVlTp+A52Wy/bSG5M
         yDzO5Ph6nQh2T+pjRfVh0cVTEjft9Nbp2dpYrAeGm06yuGmsQ+JaGppvhOUkNS0W+raw
         5tW+xZ9ho/DJ3URoql/D5S1tetpNq4lNmlxjBpF3L5XvUGZojRlGcBfn2gAnhMDOVRnC
         lxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dase/rKwb8olXZw4+LDNprv2RVCPainY9pi10HK+tM4=;
        b=QO2u1Td5vAInC5BWlRafqhZ2d301ks/QZ+eNcTIt5tE/dCw3M+Ab65Z/NuDBdul0Z1
         0JWY/eM0wf26geK60eKWBrvul5g/Byg34EpyJOZQ1Wo+PQiDFr+/nr0RwSUqKFxYdcGh
         /4+n8cyingj0wu2EQ6nZJICqXTsufgtKLLon4p/b7LpXbj0j9wtL1Kx8HTPygfKtf9Hi
         LJTjxR3xu2JXA39zmLWida1RdNk8PEmPBW4xlfYiBHofVi76Yn5FIMrb95ZE6DspQ86T
         lDtKPGFma5EMbpxzLBvEhkovVIHbJrQ1XD4Jz9tIk2ayvQAmJH39hmHvq2wzdWGG6DXF
         8IzA==
X-Gm-Message-State: AO0yUKWLfmVRerLFIE9rr4YnyQEm8FoAuAPNmK8EjwarHIgx1ogIrZ6S
        VtwylrAdT/hnaUn2+V82SmSpuw==
X-Google-Smtp-Source: AK7set/KzrMuIbnrMYbSMOuNfdjL2hXTWzj1HCDFNgudNuM3MC2YID6lT6+Gg5o1CKvOP0NhVRyMqQ==
X-Received: by 2002:a17:902:e543:b0:19d:62b:f040 with SMTP id n3-20020a170902e54300b0019d062bf040mr5423860plf.37.1677628906585;
        Tue, 28 Feb 2023 16:01:46 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id u8-20020a656708000000b005004919b31dsm6278906pgf.72.2023.02.28.16.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:01:45 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pX9ug-003JtX-7K; Wed, 01 Mar 2023 11:01:42 +1100
Date:   Wed, 1 Mar 2023 11:01:42 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+dd426ae4af71f1e74729@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] possible deadlock in evict (3)
Message-ID: <20230301000142.GK2825702@dread.disaster.area>
References: <00000000000065970505f5c5e3fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000065970505f5c5e3fb@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[obvious one for the ext4 people]

On Tue, Feb 28, 2023 at 09:25:55AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ae3419fbac84 vc_screen: don't clobber return value in vcs_..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1136fe18c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ff98a3b3c1aed3ab
> dashboard link: https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dd426ae4af71f1e74729@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.2.0-syzkaller-12913-gae3419fbac84 #0 Not tainted
> ------------------------------------------------------
> kswapd0/100 is trying to acquire lock:
> ffff888047aea650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x6b0 fs/inode.c:665
> 
> but task is already holding lock:
> ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: set_task_reclaim_state mm/vmscan.c:200 [inline]
> ffffffff8c8e29e0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x170/0x1ac0 mm/vmscan.c:7338
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 (fs_reclaim){+.+.}-{0:0}:
>        __fs_reclaim_acquire mm/page_alloc.c:4716 [inline]
>        fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4730
>        might_alloc include/linux/sched/mm.h:271 [inline]
>        prepare_alloc_pages+0x159/0x570 mm/page_alloc.c:5362
>        __alloc_pages+0x149/0x5c0 mm/page_alloc.c:5580
>        alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
>        __get_free_pages+0xc/0x40 mm/page_alloc.c:5641
>        kasan_populate_vmalloc_pte mm/kasan/shadow.c:309 [inline]
>        kasan_populate_vmalloc_pte+0x27/0x150 mm/kasan/shadow.c:300
>        apply_to_pte_range mm/memory.c:2578 [inline]
>        apply_to_pmd_range mm/memory.c:2622 [inline]
>        apply_to_pud_range mm/memory.c:2658 [inline]
>        apply_to_p4d_range mm/memory.c:2694 [inline]
>        __apply_to_page_range+0x68c/0x1030 mm/memory.c:2728
>        alloc_vmap_area+0x536/0x1f20 mm/vmalloc.c:1638
>        __get_vm_area_node+0x145/0x3f0 mm/vmalloc.c:2495
>        __vmalloc_node_range+0x250/0x1300 mm/vmalloc.c:3141
>        kvmalloc_node+0x156/0x1a0 mm/util.c:628
>        kvmalloc include/linux/slab.h:737 [inline]
>        ext4_xattr_move_to_block fs/ext4/xattr.c:2570 [inline]

	buffer = kvmalloc(value_size, GFP_NOFS);

Yeah, this doesn't work like the code says it should. The gfp mask
is not passed down to the page table population code and it hard
codes GFP_KERNEL allocations so you have to do:

	memalloc_nofs_save();
	buffer = kvmalloc(value_size, GFP_KERNEL);
	memalloc_nofs_restore();

to apply GFP_NOFS to allocations in the pte population code to avoid
memory reclaim recursion in kvmalloc.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
