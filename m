Return-Path: <linux-fsdevel+bounces-39151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A9DA10A5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 16:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E475B18834A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 15:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D161157466;
	Tue, 14 Jan 2025 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="htZlzZjU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B75D156644
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867372; cv=none; b=mHcpSN7d4fqsHWjFJmC7TwCJ1OSKOf3lluqFmf+0yAtoBMG66WlRl7yw1r3Vzm68lgprjDWtX8osF2ex3Htjpe6q/2Us1R3nzY58jJlQhMHWT98vt27P3Q1eZoLqpMWW3GLJfSgefDUP01OUC3OXfDAm/r1y9l71KL5GJt7/jBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867372; c=relaxed/simple;
	bh=BZJ+rsWTpr0jF0jxXeu66vC3ZRKeM1fh4sGq/1j+H5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSLxnDEpcyz7euU4W+Etrb9DDsuZKA3C+/mjrrlWTJmlBbW4FmswnD7T2BGf3fe5YW/gjfk+rvpPZ/WV7PEM/iTJa1TwPrBgStoRThMJklMJFsWe++jqTjckgi7kPhojUhQ0CJfP/J76psPkOZNDYsu4F+lHA13QTU7UHLV0uqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=htZlzZjU; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Jan 2025 10:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736867362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v4hl+TVqoW3lMm9JhL669Z/DP2Wwjh+iHUz2DeH1Qac=;
	b=htZlzZjUzHIDjpXt6VfmViH9A7MF3hxfVi2GOTJkR0o5cIiHM93+CBcikbLyW8rmMoNA3a
	Zi5B6PNyLByfp58ye/H0i/rPz2le2PrW/JkCaga8q3jbh5Rb1orwTv4gaDA+zffRJ0yTsY
	OgbVYKowwMPXczCvS79lSDUzZsbLsdk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	syzkaller@googlegroups.com
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <xxpizgm5l66ru5n23ejgiyw5xbq4mf4sxwfgj63b4xgr5ot2sh@iqzwriqmwjg3>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
 <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
 <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
 <D067012D-7E8D-4AD9-A0CA-66B397110989@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D067012D-7E8D-4AD9-A0CA-66B397110989@m.fudan.edu.cn>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 14, 2025 at 05:14:39PM +0800, Kun Hu wrote:
> 
> 
> > 2025年1月14日 17:07，Dmitry Vyukov <dvyukov@google.com> 写道：
> > 
> > On Mon, 13 Jan 2025 at 21:00, Kent Overstreet <kent.overstreet@linux.dev <mailto:kent.overstreet@linux.dev>> wrote:
> >> 
> >> On Mon, Jan 13, 2025 at 11:28:43AM +0100, Jan Kara wrote:
> >>> Hello!
> >>> 
> >>> First I'd note that the list of recipients of this report seems somewhat
> >>> arbitrary. linux-kernel & linux-fsdevel makes sense but I'm not sure how
> >>> you have arrived at the list of other persons you have CCed :). I have to
> >>> say syzbot folks have done a pretty good job at implementing mechanisms how
> >>> to determine recipients of the reports (as well as managing existing
> >>> reports over the web / email). Maybe you could take some inspiration there
> >>> or just contribute your syzkaller modifications to syzbot folks so that
> >>> your reports can benefit from all the other infrastructure they have?
> >> 
> >> Is there some political reason that collaboration isn't happening? I've
> >> found the syzbot people to be great to work with.
> >> 
> >> I'll give some analysis on this bug, but in general I won't in the
> >> future until you guys start collaborating (or at least tell us what the
> >> blocker is) - I don't want to be duplicating work I've already done for
> >> syzbot.
> > 
> > I suspect the bulk of the reports are coming from academia
> > researchers. In lots of academia papers based on syzkaller I see "we
> > also reported X bugs to the upstream kernel". Somehow there seems to
> > be a preference to keep things secret before publication, so upstream
> > syzbot integration is problematic. Though it is well possible to
> > publish papers based on OSS work, these usually tend to be higher
> > quality and have better evaluation.
> > 
> > I also don't fully understand the value of "we also reported X bugs to
> > the upstream kernel" for research papers. There is little correlation
> > with the quality/novelty of research.
> > 
> > 
> >>> Anyway, in this particular case, based on locks reported by lockdep, the
> >>> problem seems to be most likely somewhere in bcachefs. Added relevant CCs.
> >>> 
> >>>                                                              Honza
> >>> 
> >>> On Sun 12-01-25 18:00:24, Kun Hu wrote:
> >>>> When using our customized fuzzer tool to fuzz the latest Linux kernel, the following crash (43s)
> >>>> was triggered.
> >>>> 
> >>>> HEAD commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
> >>>> git tree: upstream
> >>>> Console output: https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/43-INFO_%20task%20hung%20in%20lock_two_nondirectories/log0
> >>>> Kernel config: https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/config.txt
> >>>> C reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/43-INFO_%20task%20hung%20in%20lock_two_nondirectories/12generated_program.c
> >>>> Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0110_6.13rc6/43-INFO_%20task%20hung%20in%20lock_two_nondirectories/12_repro.txt
> >>>> 
> >>>> We first found the issue without a stable C and Syzlang reproducers, but later I tried multiple rounds of replication and got the C and Syzlang reproducers.
> >>>> 
> >>>> I suspect the issue may stem from resource contention or synchronization delays, as indicated by functions like lock_two_nondirectories and vfs_rename. There could also be potential deadlocks or inconsistencies in file system state management (e.g., sb_writers or inode locks) within the bcachefs subsystem. Additionally, interactions between lock_rename and concurrent rename operations might be contributing factors.
> >>>> 
> >>>> Could you kindly help review these areas to narrow down the root cause? Your expertise would be greatly appreciated.
> >> 
> >> We need to know what the other threads are doing. Since lockdep didn't
> >> detect an actual deadlock, it seems most likely that the blocked thread
> >> is blocked because the thread holding the inode lock is spinning and
> >> livelocked.
> >> 
> >> That's not in the dump, so to debug this we'd need to reproduce this in
> >> a local VM and poke around with e.g. top/perf and see what's going on.
> >> 
> >> I've a tool to reproduce syzbot bugs locally in a single command [1], so
> >> that would be my starting point - except it doesn't work with your
> >> forked version. Doh.
> >> 
> >> Another thing we could do is write some additional code for the hung
> >> task detector that, when lockdep is enabled, uses it to figure out which
> >> task it's blocked on and additionally print a backtrace for that.
> >> 
> >> [1]: https://evilpiepirate.org/git/ktest.git/tree/tests/syzbot-repro.ktest
> >> 
> >>>> 
> >>>> If you fix this issue, please add the following tag to the commit:
> >>>> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
> >>>> 
> >>>> INFO: task syz.0.12:1823 blocked for more than 143 seconds.
> >>>>      Tainted: G        W          6.13.0-rc6 #1
> >>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>>> task:syz.0.12        state:D stack:25728 pid:1823  tgid:1714  ppid:442    flags:0x00000004
> >>>> Call Trace:
> >>>> <TASK>
> >>>> context_switch kernel/sched/core.c:5369 [inline]
> >>>> __schedule+0xe60/0x4120 kernel/sched/core.c:6756
> >>>> __schedule_loop kernel/sched/core.c:6833 [inline]
> >>>> schedule+0xd4/0x210 kernel/sched/core.c:6848
> >>>> schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
> >>>> rwsem_down_write_slowpath+0x551/0x1660 kernel/locking/rwsem.c:1176
> >>>> __down_write_common kernel/locking/rwsem.c:1304 [inline]
> >>>> __down_write kernel/locking/rwsem.c:1313 [inline]
> >>>> down_write_nested+0x1db/0x210 kernel/locking/rwsem.c:1694
> >>>> inode_lock_nested include/linux/fs.h:853 [inline]
> >>>> lock_two_nondirectories+0x107/0x210 fs/inode.c:1283
> >>>> vfs_rename+0x14c7/0x2a20 fs/namei.c:5038
> >>>> do_renameat2+0xb81/0xc90 fs/namei.c:5224
> >>>> __do_sys_renameat2 fs/namei.c:5258 [inline]
> >>>> __se_sys_renameat2 fs/namei.c:5255 [inline]
> >>>> __x64_sys_renameat2+0xe4/0x120 fs/namei.c:5255
> >>>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >>>> do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
> >>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >>>> RIP: 0033:0x7fca967c071d
> >>>> RSP: 002b:00007fca953f2ba8 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
> >>>> RAX: ffffffffffffffda RBX: 00007fca96983058 RCX: 00007fca967c071d
> >>>> RDX: ffffffffffffff9c RSI: 0000000020000580 RDI: ffffffffffffff9c
> >>>> RBP: 00007fca96835425 R08: 0000000000000000 R09: 0000000000000000
> >>>> R10: 00000000200005c0 R11: 0000000000000246 R12: 0000000000000000
> >>>> R13: 00007fca96983064 R14: 00007fca969830f0 R15: 00007fca953f2d40
> >>>> </TASK>
> >>>> 
> >>>> Showing all locks held in the system:
> >>>> 1 lock held by khungtaskd/45:
> >>>> #0: ffffffff9fb1aea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
> >>>> #0: ffffffff9fb1aea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
> >>>> #0: ffffffff9fb1aea0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6744
> >>>> 1 lock held by in:imklog/329:
> >>>> 5 locks held by syz.0.12/1715:
> >>>> #0: ff1100003ff8c420 (sb_writers#20){.+.+}-{0:0}, at: do_open fs/namei.c:3821 [inline]
> >>>> #0: ff1100003ff8c420 (sb_writers#20){.+.+}-{0:0}, at: path_openat+0x1577/0x2970 fs/namei.c:3987
> >>>> #1: ff110000415c1780 (&sb->s_type->i_mutex_key#21){++++}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
> >>>> #1: ff110000415c1780 (&sb->s_type->i_mutex_key#21){++++}-{4:4}, at: do_truncate+0x131/0x200 fs/open.c:63
> >>>> #2: ff11000047780a38 (&c->snapshot_create_lock){.+.+}-{4:4}, at: bch2_truncate+0x145/0x260 fs/bcachefs/io_misc.c:292
> >>>> #3: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:158 [inline]
> >>>> #3: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:249 [inline]
> >>>> #3: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bch2_trans_get+0x625/0xf60 fs/bcachefs/btree_iter.c:3228
> >>>> #4: ff110000477a66d0 (&c->gc_lock){.+.+}-{4:4}, at: bch2_btree_update_start+0xb18/0x2010 fs/bcachefs/btree_update_interior.c:1197
> >>>> 3 locks held by syz.0.12/1823:
> >>>> #0: ff1100003ff8c420 (sb_writers#20){.+.+}-{0:0}, at: do_renameat2+0x3ea/0xc90 fs/namei.c:5154
> >>>> #1: ff110000415c0148 (&sb->s_type->i_mutex_key#21/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:853 [inline]
> >>>> #1: ff110000415c0148 (&sb->s_type->i_mutex_key#21/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3215 [inline]
> >>>> #1: ff110000415c0148 (&sb->s_type->i_mutex_key#21/1){+.+.}-{4:4}, at: lock_rename+0xa5/0xc0 fs/namei.c:3212
> >>>> #2: ff110000415c1780 (&sb->s_type->i_mutex_key#21/4){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:853 [inline]
> >>>> #2: ff110000415c1780 (&sb->s_type->i_mutex_key#21/4){+.+.}-{4:4}, at: lock_two_nondirectories+0x107/0x210 fs/inode.c:1283
> >>>> 4 locks held by bch-reclaim/loo/1811:
> >>>> #0: ff110000477cb0a8 (&j->reclaim_lock){+.+.}-{4:4}, at: bch2_journal_reclaim_thread+0x101/0x560 fs/bcachefs/journal_reclaim.c:739
> >>>> #1: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:158 [inline]
> >>>> #1: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:249 [inline]
> >>>> #1: ff11000047784398 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bch2_trans_get+0x625/0xf60 fs/bcachefs/btree_iter.c:3228
> >>>> #2: ff11000047784740 (&wb->flushing.lock){+.+.}-{4:4}, at: btree_write_buffer_flush_seq+0x69f/0xa40 fs/bcachefs/btree_write_buffer.c:516
> >>>> #3: ff110000477a66d0 (&c->gc_lock){.+.+}-{4:4}, at: bch2_btree_update_start+0xb18/0x2010 fs/bcachefs/btree_update_interior.c:1197
> >>>> 1 lock held by syz-executor/5484:
> >>>> 2 locks held by syz.1.1333/8755:
> >>>> 1 lock held by syz.7.1104/8876:
> >>>> #0: ffffffff9fb27ef8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock+0x29f/0x3d0 kernel/rcu/tree_exp.h:297
> >>>> 2 locks held by syz.8.1367/8889:
> >>>> 
> >>>> =============================================
> >>>> 
> >>>> ---------------
> >>>> thanks,
> >>>> Kun Hu
> >>> --
> >>> Jan Kara <jack@suse.com>
> >>> SUSE Labs, CR
> 
> 
> Hello D and Kent,
> 
> Thanks for the advice guys. What you guys say may be true, but I also
> want to make it clear that not working with Syzbot has not come from
> political reasons, nor for the sake of secrecy of the paper, but
> simply just dabbling in the field.

Makes sense. Sorry if I came off a bit strong, there's been a couple
syzbot copycats and I find I keep repeating myself :)

So, it sounds like you're getting nudged to work upstream, i.e. people
funding you want you to be a bit better engineers so the work you're
doing is taken up (academics tend to be lousy engineers, and vice
versa, heh).

But if you're working on fuzzing, upstream is syzbot, not the kernel -
if there's a community you should be working with, that's the one.

An individual bug report like this is pretty low value to me. I see a
ton of dups, and dups coming from yet another system is downright
painful.

The real value is all the infrastructure /around/ running tests and
finding bugs: ingesting all that data into dashboards so I can look for
patterns, and additional tooling (like the ktest/syzbot integration, as
well as other things) for getting the most out of every bug report
possible.

If you're working on fuzzing, you don't want to be taking all that on
solo. That's the power of working with a community :) And more than
that, we do _very_ much need more community minded people getting
involved with testing in general, not just fuzzing.

