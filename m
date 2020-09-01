Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA46258550
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 03:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIABsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 21:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgIABsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:48:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBA5C061757
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 18:48:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b3so6263201qtg.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 18:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XWxLvc+hXg/SkiQ5wfCbFr+LM1rFQokXqPGeJU15aNU=;
        b=AsjISKP9hxNHvQ3onHF3Bsx9uHksfghwk2xn0rbKm2jMzZMsKJ/Mt4Xmfz9ozgo6g3
         OsFv8cbuVK2RHi888naGgogqqFWpMpd4bZKFLgC5SJ7fyquwhPgLL+Dhjwqg2waqZRkf
         eyDyPaara6zDhcK+XRMNDkGk92nYIERqx/qEZIH04/MJuM3ZX9L4mRr+l7hRiMx4wHpa
         S5JXxDVOnT3MYOtgde4KvehSudyx59HDSGAunbFJ4Q/j6hgqUSNJls0QksReRGn4QLZP
         ztsJgNbE2Vv19LssbyS+VE/eyWrGIMXnDF2MaAiDNyUB+SAPt1B5l/JCJjsNVwUlEsfj
         8dSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XWxLvc+hXg/SkiQ5wfCbFr+LM1rFQokXqPGeJU15aNU=;
        b=SQr8bg4QwKyq2ov0ZJ4ZM/gtXoqffI1o+kzmEtNst5yhbOZ5B0Ygtu1BrYWCgR7QkZ
         Xek5jYZYKmJVXe8S/1/fjMQ2ZOx6SqrAWz/Dw13T6pDpPaH9qhJe3Ur40HzFLsjBkd28
         VY7BQ8NwtNEtCCGpfOc0fIw6V1TGWbyWZN75T0SUz6iSZ0Z8yjUXDdEF+CtN89VbOAi7
         fsWYLxrbnr4b4RI+S2EAmIUoBxPVPLpTwNy5TJ5/Qd/iqF/t7bMLJLIqLEIERqgBV9HQ
         h2KTAvaebsRt99bT5hn9pkGTC+WiTvCs57+5wypn9tHMFbNBOajLMMLmIPJ/9uSsxfdW
         0tBg==
X-Gm-Message-State: AOAM533eckE8Ax3OEvEqjMt9st5vXibnhC5BKygFbJSaA7kef4Xp8lqO
        1ECV0UG2uXXbXcUBxIiH8e0lJQ==
X-Google-Smtp-Source: ABdhPJxbCXjhGOzhAbdBCpCXPrlDLuu4zUg3khXBeKC5h0wnUqZZzISVkP6Uq1WroyS8tFPCVs9zdQ==
X-Received: by 2002:ac8:3fcb:: with SMTP id v11mr3873921qtk.80.1598924883603;
        Mon, 31 Aug 2020 18:48:03 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a20sm12580692qtw.45.2020.08.31.18.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 18:48:03 -0700 (PDT)
Date:   Mon, 31 Aug 2020 21:47:57 -0400
From:   Qian Cai <cai@lca.pw>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@canonical.com>, paulmck@kernel.org
Subject: Re: splice: infinite busy loop lockup bug
Message-ID: <20200901014720.GA5202@lca.pw>
References: <00000000000084b59f05abe928ee@google.com>
 <29de15ff-15e9-5c52-cf87-e0ebdfa1a001@I-love.SAKURA.ne.jp>
 <20200807122727.GR1236603@ZenIV.linux.org.uk>
 <d96b0b3f-51f3-be3d-0a94-16471d6bf892@i-love.sakura.ne.jp>
 <20200901005131.GA3300@lca.pw>
 <20200901010928.GC1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901010928.GC1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 01, 2020 at 02:09:28AM +0100, Al Viro wrote:
> On Mon, Aug 31, 2020 at 08:51:32PM -0400, Qian Cai wrote:
> > On Fri, Aug 07, 2020 at 09:34:08PM +0900, Tetsuo Handa wrote:
> > > On 2020/08/07 21:27, Al Viro wrote:
> > > > On Fri, Aug 07, 2020 at 07:35:08PM +0900, Tetsuo Handa wrote:
> > > >> syzbot is reporting hung task at pipe_release() [1], for for_each_bvec() from
> > > >> iterate_bvec() from iterate_all_kinds() from iov_iter_alignment() from
> > > >> ext4_unaligned_io() from ext4_dio_write_iter() from ext4_file_write_iter() from
> > > >> call_write_iter() from do_iter_readv_writev() from do_iter_write() from
> > > >> vfs_iter_write() from iter_file_splice_write() falls into infinite busy loop
> > > >> with pipe->mutex held.
> > > >>
> > > >> The reason of falling into infinite busy loop is that iter_file_splice_write()
> > > >> for some reason generates "struct bio_vec" entry with .bv_len=0 and .bv_offset=0
> > > >> while for_each_bvec() cannot handle .bv_len == 0.
> > > > 
> > > > broken in 1bdc76aea115 "iov_iter: use bvec iterator to implement iterate_bvec()",
> > > > unless I'm misreading it...
> > 
> > I have been chasing something similar for a while as in,
> > 
> > https://lore.kernel.org/linux-fsdevel/89F418A9-EB20-48CB-9AE0-52C700E6BB74@lca.pw/
> > 
> > In my case, it seems the endless loop happens in iterate_iovec() instead where
> > I put a debug patch here,
> > 
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -33,6 +33,7 @@
> >                 if (unlikely(!__v.iov_len))             \
> >                         continue;                       \
> >                 __v.iov_base = __p->iov_base;           \
> > +               printk_ratelimited("ITER_IOVEC left = %zu, n = %zu\n", left, n); \
> >                 left = (STEP);                          \
> >                 __v.iov_len -= left;                    \
> >                 skip = __v.iov_len;                     \
> > 
> > and end up seeing overflows ("n" supposes to be less than PAGE_SIZE) before the
> > soft-lockups and a dead system,
> > 
> > [ 4300.249180][T470195] ITER_IOVEC left = 0, n = 48566423
> > 
> > Thoughts?
> 
> Er...  Where does that size come from?  If that's generic_perform_write(),
> I'd like to see pos, offset and bytes at the time of call...  ->iov_offset would
> also be interesting to see (along with the entire iovec array, really).

Yes, generic_perform_write(). I'll see if I can capture more information.

[ 2867.463013][T217919] ITER_IOVEC left = 0, n = 2209 
[ 2867.466154][T217971] ITER_IOVEC left = 0, n = 2093279 
[ 2867.903689][T217971] ITER_IOVEC left = 0, n = 2093259 
[ 2867.928514][T217971] ITER_IOVEC left = 0, n = 2093239 
[ 2867.952450][T217971] ITER_IOVEC left = 0, n = 2090980 
[ 2867.976585][T217971] ITER_IOVEC left = 0, n = 2090960 
[ 2869.219459][T217774] futex_wake_op: trinity-c61 tries to shift op by -1; fix this program 
[ 2870.005178][T218110] futex_wake_op: trinity-c9 tries to shift op by -1; fix this program 
[ 2870.297607][T218213] futex_wake_op: trinity-c4 tries to shift op by -836; fix this program 
[ 2870.338118][T218213] futex_wake_op: trinity-c4 tries to shift op by -836; fix this program 
[-- MARK -- Mon Aug 31 18:50:00 2020] 
[ 2893.870387][   C62] watchdog: BUG: soft lockup - CPU#62 stuck for 23s! [trinity-c5:218155] 
[ 2893.912341][   C62] Modules linked in: nls_ascii nls_cp437 vfat fat kvm_intel kvm irqbypass efivars ip_tables x_tables sd_mod ahci bnx2x libahci mdio libata firmware_class dm_mirror dm_region_hash dm_log dm_mod efivarfs 
[ 2894.003787][   C62] irq event stamp: 55378 
[ 2894.022398][   C62] hardirqs last  enabled at (55377): [<ffffffff95a00c42>] asm_sysvec_apic_timer_interrupt+0x12/0x20 
[ 2894.070770][   C62] hardirqs last disabled at (55378): [<ffffffff959b111d>] irqentry_enter+0x1d/0x50 
[ 2894.112794][   C62] softirqs last  enabled at (50602): [<ffffffff95c0070f>] __do_softirq+0x70f/0xa9f 
[ 2894.154580][   C62] softirqs last disabled at (49393): [<ffffffff95a00ec2>] asm_call_on_stack+0x12/0x20 
[ 2894.197654][   C62] CPU: 62 PID: 218155 Comm: trinity-c5 Not tainted 5.9.0-rc2-next-20200828+ #4 
[ 2894.239807][   C62] Hardware name: HP Synergy 480 Gen9/Synergy 480 Gen9 Compute Module, BIOS I37 10/21/2019 
[ 2894.284894][   C62] RIP: 0010:iov_iter_copy_from_user_atomic+0x598/0xab0 
[ 2894.316037][   C62] Code: 42 0f b6 14 08 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 7c 03 00 00 48 8d 7e 08 8b 46 0c 48 89 fa 48 c1 ea 03 01 e8 <42> 0f b6 14 0a 84 d2 74 09 80 fa 03 0f 8e 0e 03 00 00 44 8b 6e 08 
[ 2894.408763][   C62] RSP: 0018:ffffc9000fb7f848 EFLAGS: 00000246 
[ 2894.440034][   C62] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888fce295100 
[ 2894.480312][   C62] RDX: 1ffff111f9c52a21 RSI: ffff888fce295100 RDI: ffff888fce295108 
[ 2894.517551][   C62] RBP: 0000000000000000 R08: fffff52001f6ffa1 R09: dffffc0000000000 
[ 2894.556460][   C62] R10: ffff889055c1f000 R11: 0000000000000400 R12: ffffc9000fb7fcf0 
[ 2894.593928][   C62] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000400 
[ 2894.630979][   C62] FS:  00007ff89140a740(0000) GS:ffff88905fd80000(0000) knlGS:0000000000000000 
[ 2894.673104][   C62] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[ 2894.702914][   C62] CR2: 00007ff8906242fc CR3: 000000101bb76004 CR4: 00000000003706e0 
[ 2894.740628][   C62] DR0: 00007ff891250000 DR1: 0000000000000000 DR2: 0000000000000000 
[ 2894.778016][   C62] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600 
[ 2894.815393][   C62] Call Trace: 
[ 2894.830531][   C62]  ? shmem_write_begin+0xc4/0x1b0 
[ 2894.853643][   C62]  generic_perform_write+0x2ac/0x410 
[ 2894.878266][   C62]  ? filemap_check_errors+0xe0/0xe0 
[ 2894.901557][   C62]  ? file_update_time+0x215/0x380 
[ 2894.925234][   C62]  ? update_time+0xa0/0xa0 
[ 2894.947683][   C62]  ? down_write+0xdb/0x150 
[ 2894.969843][   C62]  __generic_file_write_iter+0x2fe/0x4f0 
[ 2894.995527][   C62]  ? rcu_read_unlock+0x50/0x50 
[ 2895.017683][   C62]  generic_file_write_iter+0x2ee/0x520 
[ 2895.042981][   C62]  ? __generic_file_write_iter+0x4f0/0x4f0 
[ 2895.069612][   C62]  ? __mutex_lock+0x4af/0x1390 
[ 2895.092240][   C62]  do_iter_readv_writev+0x388/0x6f0 
[ 2895.115794][   C62]  ? lockdep_hardirqs_on_prepare+0x33e/0x4e0 
[ 2895.143303][   C62]  ? default_llseek+0x240/0x240 
[ 2895.165522][   C62]  ? rcu_read_lock_bh_held+0xc0/0xc0 
[ 2895.190122][   C62]  do_iter_write+0x130/0x5f0 
[ 2895.211226][   C62]  iter_file_splice_write+0x54c/0xa40 
[ 2895.235917][   C62]  ? page_cache_pipe_buf_try_steal+0x1e0/0x1e0 
[ 2895.264415][   C62]  ? rcu_read_lock_any_held+0xdb/0x100 
[ 2895.290249][   C62]  do_splice+0x86c/0x1440 
[ 2895.310155][   C62]  ? syscall_enter_from_user_mode+0x1b/0x230 
[ 2895.337531][   C62]  ? direct_splice_actor+0x100/0x100 
[ 2895.362348][   C62]  __x64_sys_splice+0x151/0x200 
[ 2895.384677][   C62]  do_syscall_64+0x33/0x40 
[ 2895.405223][   C62]  entry_SYSCALL_64_after_hwframe+0x44/0xa9 
[ 2895.433800][   C62] RIP: 0033:0x7ff890d246ed 
[ 2895.456812][   C62] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b 57 2c 00 f7 d8 64 89 01 48 
[ 2895.553070][   C62] RSP: 002b:00007fff8a6acfb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113 
[ 2895.592859][   C62] RAX: ffffffffffffffda RBX: 0000000000000113 RCX: 00007ff890d246ed 
[ 2895.630744][   C62] RDX: 000000000000015b RSI: 0000000000000000 RDI: 000000000000016b 
[ 2895.668870][   C62] RBP: 0000000000000113 R08: 0000000000000400 R09: 0000000000000000 
[ 2895.707052][   C62] R10: 00007ff88f30a000 R11: 0000000000000246 R12: 0000000000000002 
[ 2895.744716][   C62] R13: 00007ff8913ee058 R14: 00007ff89140a6c0 R15: 00007ff8913ee000
