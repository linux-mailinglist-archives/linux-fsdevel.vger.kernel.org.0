Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4667D10F3D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 01:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfLCAOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 19:14:09 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39026 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfLCAOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 19:14:09 -0500
Received: by mail-oi1-f193.google.com with SMTP id a67so1569998oib.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 16:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jU8zQM7dQsl7j+C2HShiZHxrCqA16lgqBbZmIQjuFsE=;
        b=UdtIHWXsgA1cgpVIddyD/Sekot8kmzIvm9AkSrHSOZneyL3PfXwLCGrfd2C7oZrezJ
         e8qaDNGxII/RljQThXGhEK53xQlKGoHxvaU6wwSyag3/jkfaemJH/tfN/uNdLN94XfOL
         aVFVvIau+de3pcuRbNR7xT4Zu8AUADkU1oGkw1GizVGGrbAZB7rMydqYyNTn5c5au9iu
         YF28TyNBvvlTW+2V6dmrnMmGITVDsNi6ylMGS8G0Ym7Rx20w4FJf7W18LzPkd4ix1ubm
         lTY6XBoQjMu5H2nB1yRLjVmVwFFJbQN437b5r37RMCynvnUwjOF/bmGTunHUMdy83uvP
         3eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jU8zQM7dQsl7j+C2HShiZHxrCqA16lgqBbZmIQjuFsE=;
        b=HOWDiB51QSiwiw0IgBSllm0dpPkpqDx575jB9wogZ6YOd8D8R4dYk6+GsWnWCei/y2
         bt5h2MXgWeQXImM9MJd0GSfpd0f4Sgwbw+wJriTOLRB8cFMopMXiC0oRHcY1TTSvAG68
         7Qh5SqTl4qveCpVVrZZSTeBVszVlxOq6lgoTUxzAVZi1QNiUTGUB9usFPD1EBQ4L2BPD
         d1LD7nDFw5WIeS0y+OG8PlfygRnj8KEZcRSCV9v0zF4xeOfftSVa65NFCVTVuEEMKpi4
         9QxtqSnk+vYo1WlbqHiLmgUGeuLioAjWD7Rkx4N+Dj8ulrIRTxnUnUudC53ruRyIJp1f
         RZTQ==
X-Gm-Message-State: APjAAAWRxp0l9lvS6Q6qznCCL7adCoVGlo6eEYSvJQ/5gumf57vh1SMK
        7CKWnw8+z/G6uvblXK+sOBSGgsCgq0xh8BFq4U+sqA==
X-Google-Smtp-Source: APXvYqxHMoMNJtSea2KbnT6kI5KkGt3Sur+DvCkMAz+DyiTipaX++WIG/yH7EvjF/HQkpI5hCJ3YCuHSS9BQklKkN6Y=
X-Received: by 2002:aca:670b:: with SMTP id z11mr1401696oix.79.1575332047908;
 Mon, 02 Dec 2019 16:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20191129214541.3110-1-ptikhomirov@virtuozzo.com> <4e2d959a-0b0e-30aa-59b4-8e37728e9793@virtuozzo.com>
In-Reply-To: <4e2d959a-0b0e-30aa-59b4-8e37728e9793@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 2 Dec 2019 16:13:56 -0800
Message-ID: <CALvZod7rhaOBUNR=Pt5a1vAEPimrwN=41dmDD9dekCGztAe=NQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix hanging shrinker management on long do_shrink_slab
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 2, 2019 at 8:37 AM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
> On 11/30/19 12:45 AM, Pavel Tikhomirov wrote:
> > We have a problem that shrinker_rwsem can be held for a long time for
> > read in shrink_slab, at the same time any process which is trying to
> > manage shrinkers hangs.
> >
> > The shrinker_rwsem is taken in shrink_slab while traversing shrinker_list.
> > It tries to shrink something on nfs (hard) but nfs server is dead at
> > these moment already and rpc will never succeed. Generally any shrinker
> > can take significant time to do_shrink_slab, so it's a bad idea to hold
> > the list lock here.
> >
> > We have a similar problem in shrink_slab_memcg, except that we are
> > traversing shrinker_map+shrinker_idr there.
> >
> > The idea of the patch is to inc a refcount to the chosen shrinker so it
> > won't disappear and release shrinker_rwsem while we are in
> > do_shrink_slab, after that we will reacquire shrinker_rwsem, dec
> > the refcount and continue the traversal.
> >
> > We also need a wait_queue so that unregister_shrinker can wait for the
> > refcnt to become zero. Only after these we can safely remove the
> > shrinker from list and idr, and free the shrinker.
> >
> > I've reproduced the nfs hang in do_shrink_slab with the patch applied on
> > ms kernel, all other mount/unmount pass fine without any hang.
> >
> > Here is a reproduction on kernel without patch:
> >
> > 1) Setup nfs on server node with some files in it (e.g. 200)
> >
> > [server]# cat /etc/exports
> > /vz/nfs2 *(ro,no_root_squash,no_subtree_check,async)
> >
> > 2) Hard mount it on client node
> >
> > [client]# mount -ohard 10.94.3.40:/vz/nfs2 /mnt
> >
> > 3) Open some (e.g. 200) files on the mount
> >
> > [client]# for i in $(find /mnt/ -type f | head -n 200); \
> >   do setsid sleep 1000 &>/dev/null <$i & done
> >
> > 4) Kill all openers
> >
> > [client]# killall sleep -9
> >
> > 5) Put your network cable out on client node
> >
> > 6) Drop caches on the client, it will hang on nfs while holding
> >   shrinker_rwsem lock for read
> >
> > [client]# echo 3 > /proc/sys/vm/drop_caches
> >
> >   crash> bt ...
> >   PID: 18739  TASK: ...  CPU: 3   COMMAND: "bash"
> >    #0 [...] __schedule at ...
> >    #1 [...] schedule at ...
> >    #2 [...] rpc_wait_bit_killable at ... [sunrpc]
> >    #3 [...] __wait_on_bit at ...
> >    #4 [...] out_of_line_wait_on_bit at ...
> >    #5 [...] _nfs4_proc_delegreturn at ... [nfsv4]
> >    #6 [...] nfs4_proc_delegreturn at ... [nfsv4]
> >    #7 [...] nfs_do_return_delegation at ... [nfsv4]
> >    #8 [...] nfs4_evict_inode at ... [nfsv4]
> >    #9 [...] evict at ...
> >   #10 [...] dispose_list at ...
> >   #11 [...] prune_icache_sb at ...
> >   #12 [...] super_cache_scan at ...
> >   #13 [...] do_shrink_slab at ...
> >   #14 [...] shrink_slab at ...
> >   #15 [...] drop_slab_node at ...
> >   #16 [...] drop_slab at ...
> >   #17 [...] drop_caches_sysctl_handler at ...
> >   #18 [...] proc_sys_call_handler at ...
> >   #19 [...] vfs_write at ...
> >   #20 [...] ksys_write at ...
> >   #21 [...] do_syscall_64 at ...
> >   #22 [...] entry_SYSCALL_64_after_hwframe at ...
> >
> > 7) All other mount/umount activity now hangs with no luck to take
> >   shrinker_rwsem for write.
> >
> > [client]# mount -t tmpfs tmpfs /tmp
> >
> >   crash> bt ...
> >   PID: 5464   TASK: ...  CPU: 3   COMMAND: "mount"
> >    #0 [...] __schedule at ...
> >    #1 [...] schedule at ...
> >    #2 [...] rwsem_down_write_slowpath at ...
> >    #3 [...] prealloc_shrinker at ...
> >    #4 [...] alloc_super at ...
> >    #5 [...] sget at ...
> >    #6 [...] mount_nodev at ...
> >    #7 [...] legacy_get_tree at ...
> >    #8 [...] vfs_get_tree at ...
> >    #9 [...] do_mount at ...
> >   #10 [...] ksys_mount at ...
> >   #11 [...] __x64_sys_mount at ...
> >   #12 [...] do_syscall_64 at ...
> >   #13 [...] entry_SYSCALL_64_after_hwframe at ...
> >
>
>
> I don't think this patch solves the problem, it only fixes one minor symptom of it.
> The actual problem here the reclaim hang in the nfs.
> It means that any process, including kswapd, may go into nfs inode reclaim and stuck there.
>
> Even mount() itself has GFP_KERNEL allocations in its path, so it still might stuck there even with your patch.
>
> I think this should be handled on nfs/vfs level by making  inode eviction during reclaim more asynchronous.

Though I agree that we should be fixing shrinkers to not get stuck
(and be more async), I still think the problem this patch is solving
is worth fixing. On machines running multiple workloads, one job stuck
in slab shrinker and blocking all other unrelated jobs wanting
shrinker_rwsem, breaks the isolation and causes DoS.

Shakeel
