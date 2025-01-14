Return-Path: <linux-fsdevel+bounces-39122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B7FA102B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 10:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571C07A01E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A6B28EC69;
	Tue, 14 Jan 2025 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SV2VtwAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE9230998
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736845639; cv=none; b=kZTKGK9a4aO2blfeMxar3J51/21e40rTHexO0wBJI2z8OcDpCk8Bfsm0nTU+gnuIzcX01wnNFVEpWwdYCGN5zHJkXkCWb9TPvwIkzAgGnDjnGs+OdfbNc3c+EcUox0yYoNCbhTmhpRHbdLJOqsxVJkOmrMmGRp+cZCGQYJTazsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736845639; c=relaxed/simple;
	bh=A4c/WA0nMlP0wDYXCCXe/ToJdrM+IN2oRntlPJbAiL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vF3RSCvwb/iNIp/ZCeUeYIxzKmpoWFROFSbaXhvxqcn+B2SV/xep+VhLbgaBrFtjvHn/M/rG/jXfbXAcCmDvPqR3OxwZ5HLwK3M4qCMbLKJnVmpOcSbRS/TU7HsPxSjp18p0LxnJciGjihBpAeqDw84KMVGLyAKXXNagdzsF8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SV2VtwAJ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30613802a59so28373941fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 01:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736845635; x=1737450435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtqSMgf8m35rnWv7dwro4dU155LWff8NLmtzn7afVH8=;
        b=SV2VtwAJVdmgc/Gj1jUHlKtTb+3RzKwnvSK+DuP2LSMPyXbziAiHCmr4PVBFzCDRAZ
         fn2DzdY3B+sYIVJXRn06zjb9iJ1uGOw993XDhBNW8XGcigUVeTvXf8h1bh7JgOLOaaHL
         csu0ZOHuJ1xCw0w6wgJgQc19HroGgBu8GzSXb5PSUKVrAxjrM5BaOK56zFieI2E9q97H
         i9kq3qs5iUMZrtIfoGIcD+xpXW6k9oY2oomtcU4hHsHPS52GQawhh6cR/ZSR7ZLIJbVc
         o07jqrhLXx/FnM0XmmjnvTKerLcKBi9wm9KAwQQK27CTN4J11Ps6aWOvmi7+cvc2Sl5I
         Busg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736845635; x=1737450435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtqSMgf8m35rnWv7dwro4dU155LWff8NLmtzn7afVH8=;
        b=noyQNbZaIiW+c3q2yZckg4WBjlGtmRYacbs+Ofo7xLhE183pc+Snqul3X9iO4KYOvl
         PWKEdgh1YMZvKGNgFm7EV7Cmkz/PQ0iKe+rw+ejMfC5AmGBs2Y4ij6FwVB62QQyRNSQD
         vI0JdYi3E3aTd1Msbgixm41N19WRTL2tXN7u9diZoyd+2TWvFAtiLwc6VszdDBPPUFz8
         WAvyhqOGhNhtBDtr5h5fayMOtpIx4qYsGEpXeZjeOauZ6i6o43O/fGB4FwmRznUq7BO0
         Jz4auMZoB32l9uR81GTeRTsTDlhep3VmoJ3VkTGnxsvljBGmBw0y1Me2wCqI/RDzfz38
         14Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUMRVv19z5gGKHi+b8qVFoSPakFGeljVtuMyVs+G8xRX6B0+sE16DAx83tJoRB/llVO42sRaSDG9saH04Ii@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6EnBDE/Ljs0sASWD0bg0ODtl5ge8w0laszUQtxHD524yKD9Ff
	iVYNNgff/rZhH2O1P/vjw+fO6xEL3UdnFYUjj4QABgp0d+IZ12g8s53gHteUMsIl71O1LJB3/4c
	Gya9X4yVDU6m8+5ozI5IoyEMxT8VSNti0q9Z5
X-Gm-Gg: ASbGnctGgE0spYwPz8KW4KnENtlE39RqMCtn5kdP7zoURZWFdNYzHmYf2S5ZG14iQwr
	LBAa6w/3FDZcff3/KtFFD5SP73OnpFABexCMn8syBdy2Hc1RKmbbabgxUgUYmcxg73CUYNg==
X-Google-Smtp-Source: AGHT+IEpO+wrq2vCVhxgF/UsobbyNc8ZPzfFSOanTfotbUVliLZfG1YG+uq848tzdk9BuaXBQEcvYP8EoHVE+aB37qc=
X-Received: by 2002:a2e:be09:0:b0:300:3a15:8f19 with SMTP id
 38308e7fff4ca-305f45dc70dmr82814961fa.32.1736845634924; Tue, 14 Jan 2025
 01:07:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa> <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
In-Reply-To: <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 14 Jan 2025 10:07:03 +0100
X-Gm-Features: AbW1kvbd061HI9e3Udt3xzChloMi2Kn4WgYpG7R_WoAKMDfjCTL6YmGptH3NGIQ
Message-ID: <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Kun Hu <huk23@m.fudan.edu.cn>, jlayton@redhat.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, david@fromorbit.com, 
	bfields@redhat.com, viro@zeniv.linux.org.uk, christian.brauner@ubuntu.com, 
	hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, linux-bcachefs@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jan 2025 at 21:00, Kent Overstreet <kent.overstreet@linux.dev> w=
rote:
>
> On Mon, Jan 13, 2025 at 11:28:43AM +0100, Jan Kara wrote:
> > Hello!
> >
> > First I'd note that the list of recipients of this report seems somewha=
t
> > arbitrary. linux-kernel & linux-fsdevel makes sense but I'm not sure ho=
w
> > you have arrived at the list of other persons you have CCed :). I have =
to
> > say syzbot folks have done a pretty good job at implementing mechanisms=
 how
> > to determine recipients of the reports (as well as managing existing
> > reports over the web / email). Maybe you could take some inspiration th=
ere
> > or just contribute your syzkaller modifications to syzbot folks so that
> > your reports can benefit from all the other infrastructure they have?
>
> Is there some political reason that collaboration isn't happening? I've
> found the syzbot people to be great to work with.
>
> I'll give some analysis on this bug, but in general I won't in the
> future until you guys start collaborating (or at least tell us what the
> blocker is) - I don't want to be duplicating work I've already done for
> syzbot.

I suspect the bulk of the reports are coming from academia
researchers. In lots of academia papers based on syzkaller I see "we
also reported X bugs to the upstream kernel". Somehow there seems to
be a preference to keep things secret before publication, so upstream
syzbot integration is problematic. Though it is well possible to
publish papers based on OSS work, these usually tend to be higher
quality and have better evaluation.

I also don't fully understand the value of "we also reported X bugs to
the upstream kernel" for research papers. There is little correlation
with the quality/novelty of research.


> > Anyway, in this particular case, based on locks reported by lockdep, th=
e
> > problem seems to be most likely somewhere in bcachefs. Added relevant C=
Cs.
> >
> >                                                               Honza
> >
> > On Sun 12-01-25 18:00:24, Kun Hu wrote:
> > > When using our customized fuzzer tool to fuzz the latest Linux kernel=
, the following crash (43s)
> > > was triggered.
> > >
> > > HEAD commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
> > > git tree: upstream
> > > Console output: https://github.com/pghk13/Kernel-Bug/blob/main/0110_6=
.13rc6/43-INFO_%20task%20hung%20in%20lock_two_nondirectories/log0
> > > Kernel config: https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.=
13rc6/config.txt
> > > C reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.1=
3rc6/43-INFO_%20task%20hung%20in%20lock_two_nondirectories/12generated_prog=
ram.c
> > > Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/01=
10_6.13rc6/43-INFO_%20task%20hung%20in%20lock_two_nondirectories/12_repro.t=
xt
> > >
> > > We first found the issue without a stable C and Syzlang reproducers, =
but later I tried multiple rounds of replication and got the C and Syzlang =
reproducers.
> > >
> > > I suspect the issue may stem from resource contention or synchronizat=
ion delays, as indicated by functions like lock_two_nondirectories and vfs_=
rename. There could also be potential deadlocks or inconsistencies in file =
system state management (e.g., sb_writers or inode locks) within the bcache=
fs subsystem. Additionally, interactions between lock_rename and concurrent=
 rename operations might be contributing factors.
> > >
> > > Could you kindly help review these areas to narrow down the root caus=
e? Your expertise would be greatly appreciated.
>
> We need to know what the other threads are doing. Since lockdep didn't
> detect an actual deadlock, it seems most likely that the blocked thread
> is blocked because the thread holding the inode lock is spinning and
> livelocked.
>
> That's not in the dump, so to debug this we'd need to reproduce this in
> a local VM and poke around with e.g. top/perf and see what's going on.
>
> I've a tool to reproduce syzbot bugs locally in a single command [1], so
> that would be my starting point - except it doesn't work with your
> forked version. Doh.
>
> Another thing we could do is write some additional code for the hung
> task detector that, when lockdep is enabled, uses it to figure out which
> task it's blocked on and additionally print a backtrace for that.
>
> [1]: https://evilpiepirate.org/git/ktest.git/tree/tests/syzbot-repro.ktes=
t
>
> > >
> > > If you fix this issue, please add the following tag to the commit:
> > > Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fuda=
n.edu.cn>
> > >
> > > INFO: task syz.0.12:1823 blocked for more than 143 seconds.
> > >       Tainted: G        W          6.13.0-rc6 #1
> > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this mess=
age.
> > > task:syz.0.12        state:D stack:25728 pid:1823  tgid:1714  ppid:44=
2    flags:0x00000004
> > > Call Trace:
> > >  <TASK>
> > >  context_switch kernel/sched/core.c:5369 [inline]
> > >  __schedule+0xe60/0x4120 kernel/sched/core.c:6756
> > >  __schedule_loop kernel/sched/core.c:6833 [inline]
> > >  schedule+0xd4/0x210 kernel/sched/core.c:6848
> > >  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
> > >  rwsem_down_write_slowpath+0x551/0x1660 kernel/locking/rwsem.c:1176
> > >  __down_write_common kernel/locking/rwsem.c:1304 [inline]
> > >  __down_write kernel/locking/rwsem.c:1313 [inline]
> > >  down_write_nested+0x1db/0x210 kernel/locking/rwsem.c:1694
> > >  inode_lock_nested include/linux/fs.h:853 [inline]
> > >  lock_two_nondirectories+0x107/0x210 fs/inode.c:1283
> > >  vfs_rename+0x14c7/0x2a20 fs/namei.c:5038
> > >  do_renameat2+0xb81/0xc90 fs/namei.c:5224
> > >  __do_sys_renameat2 fs/namei.c:5258 [inline]
> > >  __se_sys_renameat2 fs/namei.c:5255 [inline]
> > >  __x64_sys_renameat2+0xe4/0x120 fs/namei.c:5255
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7fca967c071d
> > > RSP: 002b:00007fca953f2ba8 EFLAGS: 00000246 ORIG_RAX: 000000000000013=
c
> > > RAX: ffffffffffffffda RBX: 00007fca96983058 RCX: 00007fca967c071d
> > > RDX: ffffffffffffff9c RSI: 0000000020000580 RDI: ffffffffffffff9c
> > > RBP: 00007fca96835425 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 00000000200005c0 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 00007fca96983064 R14: 00007fca969830f0 R15: 00007fca953f2d40
> > >  </TASK>
> > >
> > > Showing all locks held in the system:
> > > 1 lock held by khungtaskd/45:
> > >  #0: ffffffff9fb1aea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acqui=
re include/linux/rcupdate.h:337 [inline]
> > >  #0: ffffffff9fb1aea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock =
include/linux/rcupdate.h:849 [inline]
> > >  #0: ffffffff9fb1aea0 (rcu_read_lock){....}-{1:3}, at: debug_show_all=
_locks+0x75/0x340 kernel/locking/lockdep.c:6744
> > > 1 lock held by in:imklog/329:
> > > 5 locks held by syz.0.12/1715:
> > >  #0: ff1100003ff8c420 (sb_writers#20){.+.+}-{0:0}, at: do_open fs/nam=
ei.c:3821 [inline]
> > >  #0: ff1100003ff8c420 (sb_writers#20){.+.+}-{0:0}, at: path_openat+0x=
1577/0x2970 fs/namei.c:3987
> > >  #1: ff110000415c1780 (&sb->s_type->i_mutex_key#21){++++}-{4:4}, at: =
inode_lock include/linux/fs.h:818 [inline]
> > >  #1: ff110000415c1780 (&sb->s_type->i_mutex_key#21){++++}-{4:4}, at: =
do_truncate+0x131/0x200 fs/open.c:63
> > >  #2: ff11000047780a38 (&c->snapshot_create_lock){.+.+}-{4:4}, at: bch=
2_truncate+0x145/0x260 fs/bcachefs/io_misc.c:292
> > >  #3: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu=
_lock_acquire include/linux/srcu.h:158 [inline]
> > >  #3: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu=
_read_lock include/linux/srcu.h:249 [inline]
> > >  #3: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bc=
h2_trans_get+0x625/0xf60 fs/bcachefs/btree_iter.c:3228
> > >  #4: ff110000477a66d0 (&c->gc_lock){.+.+}-{4:4}, at: bch2_btree_updat=
e_start+0xb18/0x2010 fs/bcachefs/btree_update_interior.c:1197
> > > 3 locks held by syz.0.12/1823:
> > >  #0: ff1100003ff8c420 (sb_writers#20){.+.+}-{0:0}, at: do_renameat2+0=
x3ea/0xc90 fs/namei.c:5154
> > >  #1: ff110000415c0148 (&sb->s_type->i_mutex_key#21/1){+.+.}-{4:4}, at=
: inode_lock_nested include/linux/fs.h:853 [inline]
> > >  #1: ff110000415c0148 (&sb->s_type->i_mutex_key#21/1){+.+.}-{4:4}, at=
: lock_rename fs/namei.c:3215 [inline]
> > >  #1: ff110000415c0148 (&sb->s_type->i_mutex_key#21/1){+.+.}-{4:4}, at=
: lock_rename+0xa5/0xc0 fs/namei.c:3212
> > >  #2: ff110000415c1780 (&sb->s_type->i_mutex_key#21/4){+.+.}-{4:4}, at=
: inode_lock_nested include/linux/fs.h:853 [inline]
> > >  #2: ff110000415c1780 (&sb->s_type->i_mutex_key#21/4){+.+.}-{4:4}, at=
: lock_two_nondirectories+0x107/0x210 fs/inode.c:1283
> > > 4 locks held by bch-reclaim/loo/1811:
> > >  #0: ff110000477cb0a8 (&j->reclaim_lock){+.+.}-{4:4}, at: bch2_journa=
l_reclaim_thread+0x101/0x560 fs/bcachefs/journal_reclaim.c:739
> > >  #1: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu=
_lock_acquire include/linux/srcu.h:158 [inline]
> > >  #1: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu=
_read_lock include/linux/srcu.h:249 [inline]
> > >  #1: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bc=
h2_trans_get+0x625/0xf60 fs/bcachefs/btree_iter.c:3228
> > >  #2: ff11000047784740 (&wb->flushing.lock){+.+.}-{4:4}, at: btree_wri=
te_buffer_flush_seq+0x69f/0xa40 fs/bcachefs/btree_write_buffer.c:516
> > >  #3: ff110000477a66d0 (&c->gc_lock){.+.+}-{4:4}, at: bch2_btree_updat=
e_start+0xb18/0x2010 fs/bcachefs/btree_update_interior.c:1197
> > > 1 lock held by syz-executor/5484:
> > > 2 locks held by syz.1.1333/8755:
> > > 1 lock held by syz.7.1104/8876:
> > >  #0: ffffffff9fb27ef8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funn=
el_lock+0x29f/0x3d0 kernel/rcu/tree_exp.h:297
> > > 2 locks held by syz.8.1367/8889:
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > ---------------
> > > thanks,
> > > Kun Hu
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR

