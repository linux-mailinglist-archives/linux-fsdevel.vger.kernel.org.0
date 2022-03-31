Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104BC4ED3CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 08:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiCaGSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 02:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiCaGSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:18:41 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A085938B
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 23:16:54 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id t11so40621606ybi.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 23:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ssMyZLw7ncLemsmqGaMfG0ae57UUUk7vXWBlKG+NN1A=;
        b=2d+K+RWlJqT+nE6mE8PAkmz9MrEs71tfObMPJmDRdCGm3JD1v+UPAtzj8Jbu8Wm4xp
         DGUIuhDaPABNKSrd7TpB8GX1KjFQCYSjzzSNRUXVqV+dsjagX3PxE6qIxebCX3dgFy7E
         +DiMGmDJvumnOVNI8EiUPVNdi0JKxbAWKQECPLUf2nlCeQAHkVGhrJ4mrwl+qSlFnImM
         nkUjv34LYTL+G5hV+b3387hdlExLvTb6w5VbzTFzA6v7Q5/Boa9dexCVNSmmsJBjV9M6
         jLWg5eF3fD1zvdDACie3F3Ev7M26DboU34xmln2X9vRqEogOfnZQSYxGxRNscJxxyCFZ
         ednw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ssMyZLw7ncLemsmqGaMfG0ae57UUUk7vXWBlKG+NN1A=;
        b=SFl6p1JAZXUREFjtTMoeQlZd1HhrCitcGdE48P5qfVwO62PEipzZhMEf5PSf6raDSY
         WpNRTcCFN7KN+Iv+BYjKSYo+B27FW0FXFDc7bb4IvmG8DheNse3QISMIyB19Xe6LuePH
         4A0UYwOXgOnzlVXqNJyenvLZx8YcfvR0xeYTcPCe5Ku6qUatZAah2u4tVbNxBUPUMbcG
         S8zm0bELYHTgSMXzOruAtEvK0+jBMZSARaB4JofIDGDjcmTmu6V2Pr6hOQDjzQzcNkbd
         sT+jJuLkziL8RofuQfUT1jKWqpklZYxCDEJ0IeYE0VEya3nnwd4yPvGW4i/ILOZySEvZ
         sFOA==
X-Gm-Message-State: AOAM530sU0GZn6MEH+90HOG7DjEyNY4Fih7FGmJDnv/HQPrhhspOW/Fe
        rkj6ZaBleAOepzUm+6bCY94QyUZj/3hXmx+o2IxeVQ==
X-Google-Smtp-Source: ABdhPJzPL/5GzcZ7y9X+UBkl5p/lmzz0czNU9Xq1SriFM841PFmkRBojaT7/2rmd3IyxJl4N94K7MBAyzyqp28Kt9KE=
X-Received: by 2002:a05:6902:70c:b0:634:73ef:e663 with SMTP id
 k12-20020a056902070c00b0063473efe663mr3181281ybt.246.1648707413283; Wed, 30
 Mar 2022 23:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220228122126.37293-1-songmuchun@bytedance.com>
 <20220228122126.37293-13-songmuchun@bytedance.com> <164869718565.25542.15818719940772238394@noble.neil.brown.name>
 <CAMZfGtUSA9f3k9jF5U-y+NVt8cpmB9_mk1F9-vmm4JOuWFF_Bw@mail.gmail.com> <164870069595.25542.17292003658915487357@noble.neil.brown.name>
In-Reply-To: <164870069595.25542.17292003658915487357@noble.neil.brown.name>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 31 Mar 2022 14:16:17 +0800
Message-ID: <CAMZfGtX9pkWYf40RwDALZLKGDc+Dt2UJA7wZFjTagf0AyWyCiw@mail.gmail.com>
Subject: Re: [PATCH v6 12/16] mm: list_lru: replace linear array with xarray
To:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:25 PM NeilBrown <neilb@suse.de> wrote:
>
> On Thu, 31 Mar 2022, Muchun Song wrote:
> >
> > If the above fix cannot fix your issue, would you mind providing
> > the .config and stack trace?
>
> The kernel I'm using is
>   74164d284b2909de0ba13518cc063e9ea9334749
> plus one patch in fs/namei.c
> So it does include the commit you mentioned.
>
> Config is below
>
> I run
>     ./check -nfs generic/037
> in xfstests, and crash is quick.
>
> Stack trace is
>
> [  121.557601] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [  121.558003] #PF: supervisor read access in kernel mode
> [  121.558299] #PF: error_code(0x0000) - not-present page
> [  121.558598] PGD 0 P4D 0
> [  121.558750] Oops: 0000 [#1] PREEMPT SMP
> [  121.558978] CPU: 2 PID: 1116 Comm: setfattr Not tainted 5.17.0-dev #455
> [  121.559360] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
> [  121.560009] RIP: 0010:list_lru_add+0x58/0xae
> [  121.560267] Code: 00 48 8d 58 48 74 23 48 89 ef e8 93 08 03 00 49 89 c5 48 85 c0 74 13 8b 90 40 0e 00 00 31 f6 4c 89 e7 e8 66 fb ff ff 48 3
> [  121.561353] RSP: 0018:ffffc900016dfbd0 EFLAGS: 00010246
> [  121.561668] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000094fd1aeb
> [  121.562076] RDX: ffff888007768be8 RSI: ffffffff826b4914 RDI: ffffffff82745064
> [  121.562484] RBP: ffff8880097b3888 R08: ffffffffffffffff R09: ffff888007768b40
> [  121.562890] R10: ffffc900016dfa98 R11: 0000000000008f0c R12: ffffffff8482e7a0
> [  121.563296] R13: ffff888007766000 R14: ffff888005e72300 R15: 0000000000000000
> [  121.563702] FS:  00007f558ef08580(0000) GS:ffff88801f200000(0000) knlGS:0000000000000000
> [  121.564166] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  121.564499] CR2: 0000000000000008 CR3: 00000000084c4000 CR4: 00000000000006e0
> [  121.564905] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  121.565314] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  121.565719] Call Trace:
> [  121.565860]  <TASK>
> [  121.565985]  nfs4_xattr_get_cache+0x131/0x169
> [  121.566239]  nfs4_xattr_cache_add+0x47/0x15a
> [  121.566485]  nfs4_xattr_set_nfs4_user+0xcb/0xef
> [  121.566748]  __vfs_setxattr+0x66/0x72
> [  121.566961]  __vfs_setxattr_noperm+0x6e/0xf5
> [  121.567211]  vfs_setxattr+0xa7/0x12a
> [  121.567419]  setxattr+0x115/0x14d
> [  121.567612]  ? check_chain_key+0xde/0x11f
> [  121.567846]  path_setxattr+0x78/0xcf
> [  121.568053]  __x64_sys_setxattr+0x22/0x25
> [  121.568287]  do_syscall_64+0x6d/0x80
> [  121.568497]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>

Thanks for your report.  I knew the reason. It is because the following
patch in this series was missed upstream.  Could you help me test if it
works properly?

[v6,06/16] nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry

Hi Andrew,

Would you mind picking it up?

Thanks.
