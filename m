Return-Path: <linux-fsdevel+bounces-69735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D330CC841E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180173AB017
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74B02FD1D5;
	Tue, 25 Nov 2025 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpSsoEx5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A26E242D89;
	Tue, 25 Nov 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061225; cv=none; b=WIexuCQUQUbn7ki1QpjNtpM0iAsatkxMQGxvYUzoQHCWhm/SjbNk6i6vYehvXFaeg5QSRkXqiqMDx4xyqL690H6+2vDUkpkCZO5Lo0eGWHoOhY3Y4JYtDVwUWovhnHEwljj+FwbqepaksVKif02kRsEvivmb+EXhoRi9b62xs4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061225; c=relaxed/simple;
	bh=CT6YCL6/hiTrxq+RuF05k4GptF9kLO+iBGf9vzrqlsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcnVibnXTaQ5GL259FGhJLE44oDJh5Si+YyGAjl7uHA95kEkYdNMfvDpjEi5f/NoJOpt7jj+h6Cczn+GN17J4FYjB19zBm3jdSZlFOfzSXzack76xBLJR6ZvJeT1y8ywyOkxiAQTS9a0k/9IKuldj53B0ZabmhAcr++wcxB02Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpSsoEx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0657AC4CEF1;
	Tue, 25 Nov 2025 09:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764061224;
	bh=CT6YCL6/hiTrxq+RuF05k4GptF9kLO+iBGf9vzrqlsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpSsoEx5/uwjAQ4nnJUnJgB3bjGaJvHtP462lFQXO+GrhnGRyrzB7tx1Wzuuy9VOl
	 caWXhTbXp7ipshDsWwbdo0DgTirMBZ0V0ZOOyOSt0QOUY5Ou6pWLQ7JbCTWRAHvv8j
	 oxeuSW4FMMwiVBZtaarFhPrMhCLU08Y1qjcW8Q6re5cfpZigWwgMAXrFpRaJtmGIoy
	 fRGk2/itQLOcAsrfQfu7egYRC0Cwpx8N4uCs578NJb+7O6gWtHgem49UIuqFXQDcuE
	 UeK0ZzPR3/apvnI+5C0rafNScpPAAXr+SIQo+1M5OKLkJXhavWIzJ0TQhqkebcoviy
	 b0YiVAoxDOqrg==
Date: Tue, 25 Nov 2025 10:00:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, borntraeger@linux.ibm.com, 
	bpf@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] Re: [PATCH v2 22/50] convert efivarfs
Message-ID: <20251125-lammfell-verlosen-b9ca07599254@brauner>
References: <20251028210805.GP2441659@ZenIV>
 <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
 <9f079d0c8cffb150c0decb673a12bfe1b835efc9.camel@HansenPartnership.com>
 <20251029193755.GU2441659@ZenIV>
 <CAMj1kXHnEq97bzt-C=zKJdV3BK3EDJCPz3Pfyk52p2735-4wFA@mail.gmail.com>
 <20251105-aufheben-ausmusterung-4588dab8c585@brauner>
 <423f5cc5352c54fc21e0570daeeddc4a58e74974.camel@HansenPartnership.com>
 <20251105-sohlen-fenster-e7c5af1204c4@brauner>
 <20251105-vorbild-zutreffen-fe00d1dd98db@brauner>
 <aR4zisdeorFTTwOv@debian.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aR4zisdeorFTTwOv@debian.local>

On Wed, Nov 19, 2025 at 09:15:54PM +0000, Chris Bainbridge wrote:
> On Wed, Nov 05, 2025 at 02:43:34PM +0100, Christian Brauner wrote:
> > > > > And suspend/resume works just fine with freeze/thaw. See commit
> > > > > eacfbf74196f ("power: freeze filesystems during suspend/resume")
> > > > > which implements exactly that.
> > > > >=20
> > > > > The reason this didn't work for you is very likely:
> > > > >=20
> > > > > cat /sys/power/freeze_filesystems
> > > > > 0
> > > > >=20
> > > > > which you must set to 1.
> > > >=20
> > > > Actually, no, that's not correct.  The efivarfs freeze/thaw logic m=
ust
> > > > run unconditionally regardless of this setting to fix the systemd b=
ug,
> > > > so all the variable resyncing is done in the thaw call, which isn't
> > > > conditioned on the above (or at least it shouldn't be).
> > >=20
> > > It is conditioned on the above currently but we can certainly fix it
> > > easily to not be.
> >=20
> > Something like the appended patch would do it.
>=20
> > >From 1f9dc293cebb10b18d9ec8e01b60c014664c98ab Mon Sep 17 00:00:00 2001
> > From: Christian Brauner <brauner@kernel.org>
> > Date: Wed, 5 Nov 2025 14:39:45 +0100
> > Subject: [PATCH] power: always freeze efivarfs
> >=20
> > The efivarfs filesystems must always be frozen and thawed to resync
> > variable state. Make it so.
> >=20
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
>=20
> I bisected some intermittent (44% chance of occuring on any given
> suspend) lock warnings on suspend to this commit:
>=20
> a3f8f8662771285511ae26c4c8d3ba1cd22159b9 power: always freeze efivarfs
>=20
> Reproducer: `for x in {1..20}; do systemctl suspend; sleep 5; done`

This is very likely a false-positive triggered by:

  #ifdef CONFIG_LOCKDEP
          /*
           * It's dangerous to freeze with locks held; there be dragons the=
re.
           */
          if (!(state & __TASK_FREEZABLE_UNSAFE))
                  WARN_ON_ONCE(debug_locks && p->lockdep_depth);
  #endif

in __set_task_frozen(). When a filesystem is frozen we'll acquire=20

percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1, true);

at some point. And while that fs is frozen that rw_sem will remain held.
__set_task_frozen()'s lockdep annotation doesn't yet know what to do
with such tasks and then complains about them when lockdep is enabled.
It should have an exception for the suspend path here specifically.
IIRC, we asked peterz how to handle this a couple of months ago. It
seems we didn't reach a conclusion. It's benign though but we need to
clean this up for sure.

>=20
> Warnings are:
>=20
> [   50.702541] OOM killer enabled.
> [   50.702545] Restarting tasks: Starting
> [   50.703553] Restarting tasks: Done
> [   50.704233] efivarfs: resyncing variable state
> [   50.710323] efivarfs: finished resyncing variable state
> [   50.710349] random: crng reseeded on system resumption
> [   50.724547] PM: suspend exit
> [   50.743157] nvme nvme0: 8/0/0 default/read/poll queues
> [   54.814961] PM: suspend entry (s2idle)
> [   55.064704] Filesystems sync: 0.249 seconds
> [   55.112462] Freezing user space processes
> [   55.112647] ------------[ cut here ]------------
>=20
> [   55.113009] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   55.113010] WARNING: possible circular locking dependency detected
> [   55.113011] 6.18.0-rc6-00040-g8b690556d8fe-dirty #168 Not tainted
> [   55.113012] ------------------------------------------------------
> [   55.113012] systemd-sleep/2563 is trying to acquire lock:
> [   55.113013] ffffffff99e7aa00 (console_owner){....}-{0:0}, at: console_=
lock_spinning_enable+0x3c/0x60
> [   55.113021]=20
>                but task is already holding lock:
> [   55.113022] ffff9c3961c65728 (&p->pi_lock){-.-.}-{2:2}, at: task_call_=
func+0x49/0xf0
> [   55.113025]=20
>                which lock already depends on the new lock.
>=20
> [   55.113025]=20
>                the existing dependency chain (in reverse order) is:
> [   55.113025]=20
>                -> #2 (&p->pi_lock){-.-.}-{2:2}:
> [   55.113027]        _raw_spin_lock_irqsave+0x47/0x60
> [   55.113030]        try_to_wake_up+0x69/0xac0
> [   55.113031]        create_worker+0x17c/0x200
> [   55.113033]        workqueue_init+0x27e/0x2e0
> [   55.113036]        kernel_init_freeable+0x15e/0x310
> [   55.113038]        kernel_init+0x16/0x120
> [   55.113039]        ret_from_fork+0x2a9/0x310
> [   55.113041]        ret_from_fork_asm+0x11/0x20
> [   55.113043]=20
>                -> #1 (&pool->lock){-.-.}-{2:2}:
> [   55.113045]        _raw_spin_lock+0x2f/0x40
> [   55.113046]        __queue_work+0x23d/0x680
> [   55.113048]        queue_work_on+0x56/0xa0
> [   55.113050]        soft_cursor+0x196/0x240
> [   55.113053]        bit_cursor+0x368/0x5e0
> [   55.113055]        hide_cursor+0x21/0xa0
> [   55.113056]        vt_console_print+0x460/0x480
> [   55.113057]        console_flush_all+0x2de/0x4e0
> [   55.113059]        console_unlock+0x78/0x130
> [   55.113060]        vprintk_emit+0x34c/0x400
> [   55.113062]        _printk+0x67/0x80
> [   55.113064]        int_to_scsilun+0xa/0x30 [scsi_common]
> [   55.113068]        do_one_initcall+0x68/0x390
> [   55.113069]        do_init_module+0x60/0x220
> [   55.113070]        init_module_from_file+0x85/0xc0
> [   55.113071]        idempotent_init_module+0x11a/0x310
> [   55.113072]        __x64_sys_finit_module+0x69/0xd0
> [   55.113073]        do_syscall_64+0x95/0x6e0
> [   55.113076]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   55.113077]=20
>                -> #0 (console_owner){....}-{0:0}:
> [   55.113078]        __lock_acquire+0x1444/0x2200
> [   55.113080]        lock_acquire+0xd1/0x2e0
> [   55.113081]        console_lock_spinning_enable+0x58/0x60
> [   55.113083]        console_flush_all+0x2a6/0x4e0
> [   55.113085]        console_unlock+0x78/0x130
> [   55.113086]        vprintk_emit+0x34c/0x400
> [   55.113088]        _printk+0x67/0x80
> [   55.113090]        report_bug.cold+0x13/0x5a
> [   55.113092]        handle_bug+0x18d/0x250
> [   55.113094]        exc_invalid_op+0x13/0x60
> [   55.113096]        asm_exc_invalid_op+0x16/0x20
> [   55.113097]        __set_task_frozen+0x6a/0x90
> [   55.113099]        task_call_func+0x76/0xf0
> [   55.113099]        freeze_task+0x87/0xf0
> [   55.113101]        try_to_freeze_tasks+0xe1/0x2b0
> [   55.113102]        freeze_processes+0x46/0xb0
> [   55.113104]        pm_suspend.cold+0x194/0x29f
> [   55.113106]        state_store+0x68/0xc0
> [   55.113108]        kernfs_fop_write_iter+0x172/0x240
> [   55.113110]        vfs_write+0x249/0x560
> [   55.113112]        ksys_write+0x6d/0xe0
> [   55.113114]        do_syscall_64+0x95/0x6e0
> [   55.113115]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   55.113116]=20
>                other info that might help us debug this:
>=20
> [   55.113117] Chain exists of:
>                  console_owner --> &pool->lock --> &p->pi_lock
>=20
> [   55.113118]  Possible unsafe locking scenario:
>=20
> [   55.113119]        CPU0                    CPU1
> [   55.113119]        ----                    ----
> [   55.113119]   lock(&p->pi_lock);
> [   55.113120]                                lock(&pool->lock);
> [   55.113121]                                lock(&p->pi_lock);
> [   55.113121]   lock(console_owner);
> [   55.113122]=20
>                 *** DEADLOCK ***
>=20
> [   55.113122] 9 locks held by systemd-sleep/2563:
> [   55.113124]  #0: ffff9c39429a2420 (sb_writers#5){.+.+}-{0:0}, at: ksys=
_write+0x6d/0xe0
> [   55.113127]  #1: ffff9c394683f488 (&of->mutex){+.+.}-{4:4}, at: kernfs=
_fop_write_iter+0x117/0x240
> [   55.113130]  #2: ffff9c3941257298 (kn->active#212){.+.+}-{0:0}, at: ke=
rnfs_fop_write_iter+0x12c/0x240
> [   55.113132]  #3: ffffffff99e6f088 (system_transition_mutex){+.+.}-{4:4=
}, at: pm_suspend.cold+0x4c/0x29f
> [   55.113136]  #4: ffffffff99e08098 (tasklist_lock){.+.+}-{3:3}, at: try=
_to_freeze_tasks+0x8a/0x2b0
> [   55.113138]  #5: ffffffff99fa8e98 (freezer_lock){....}-{3:3}, at: free=
ze_task+0x29/0xf0
> [   55.113141]  #6: ffff9c3961c65728 (&p->pi_lock){-.-.}-{2:2}, at: task_=
call_func+0x49/0xf0
> [   55.113143]  #7: ffffffff99eeadc0 (console_lock){+.+.}-{0:0}, at: _pri=
ntk+0x67/0x80
> [   55.113146]  #8: ffffffff99eeae10 (console_srcu){....}-{0:0}, at: cons=
ole_flush_all+0x3d/0x4e0
> [   55.113149]=20
>                stack backtrace:
> [   55.113151] CPU: 8 UID: 0 PID: 2563 Comm: systemd-sleep Not tainted 6.=
18.0-rc6-00040-g8b690556d8fe-dirty #168 PREEMPT(voluntary)=20
> [   55.113153] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, =
BIOS F.17 12/18/2024
> [   55.113154] Call Trace:
> [   55.113155]  <TASK>
> [   55.113156]  dump_stack_lvl+0x6a/0x90
> [   55.113159]  print_circular_bug.cold+0x178/0x1be
> [   55.113162]  check_noncircular+0x142/0x160
> [   55.113166]  __lock_acquire+0x1444/0x2200
> [   55.113169]  lock_acquire+0xd1/0x2e0
> [   55.113170]  ? console_lock_spinning_enable+0x3c/0x60
> [   55.113173]  ? console_lock_spinning_enable+0x35/0x60
> [   55.113175]  ? lock_release+0x17d/0x2c0
> [   55.113177]  console_lock_spinning_enable+0x58/0x60
> [   55.113179]  ? console_lock_spinning_enable+0x3c/0x60
> [   55.113181]  console_flush_all+0x2a6/0x4e0
> [   55.113183]  ? console_flush_all+0x3d/0x4e0
> [   55.113186]  console_unlock+0x78/0x130
> [   55.113188]  vprintk_emit+0x34c/0x400
> [   55.113191]  ? __set_task_frozen+0x6a/0x90
> [   55.113193]  _printk+0x67/0x80
> [   55.113195]  ? lock_is_held_type+0xd5/0x130
> [   55.113199]  report_bug.cold+0x13/0x5a
> [   55.113201]  ? __set_task_frozen+0x6a/0x90
> [   55.113203]  handle_bug+0x18d/0x250
> [   55.113205]  exc_invalid_op+0x13/0x60
> [   55.113207]  asm_exc_invalid_op+0x16/0x20
> [   55.113209] RIP: 0010:__set_task_frozen+0x6a/0x90
> [   55.113211] Code: f7 c5 00 20 00 00 74 06 40 f6 c5 03 74 33 81 e5 00 4=
0 00 00 75 16 8b 15 d8 8c 52 01 85 d2 74 0c 8b 83 f0 0e 00 00 85 c0 74 02 <=
0f> 0b 8b 43 18 c7 43 18 00 80 00 00 89 43 1c b8 00 80 00 00 5b 5d
> [   55.113212] RSP: 0018:ffffbfba462ef8d0 EFLAGS: 00010002
> [   55.113214] RAX: 0000000000000002 RBX: ffff9c3961c64900 RCX: 000000000=
0000000
> [   55.113215] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9c396=
1c64900
> [   55.113216] RBP: 0000000000000000 R08: 00000000000000b6 R09: 000000000=
0000006
> [   55.113217] R10: 00000000000000f0 R11: 0000000000000006 R12: ffffffff9=
8bd9000
> [   55.113217] R13: 0000000000000000 R14: ffff9c3961c65710 R15: ffff9c396=
1c65200
> [   55.113218]  ? freezing_slow_path+0x70/0x70
> [   55.113222]  task_call_func+0x76/0xf0
> [   55.113224]  freeze_task+0x87/0xf0
> [   55.113226]  try_to_freeze_tasks+0xe1/0x2b0
> [   55.113229]  ? lockdep_hardirqs_on+0x78/0x100
> [   55.113231]  freeze_processes+0x46/0xb0
> [   55.113233]  pm_suspend.cold+0x194/0x29f
> [   55.113235]  state_store+0x68/0xc0
> [   55.113238]  kernfs_fop_write_iter+0x172/0x240
> [   55.113239]  vfs_write+0x249/0x560
> [   55.113243]  ksys_write+0x6d/0xe0
> [   55.113246]  do_syscall_64+0x95/0x6e0
> [   55.113249]  ? __lock_acquire+0x469/0x2200
> [   55.113252]  ? __lock_acquire+0x469/0x2200
> [   55.113255]  ? lock_acquire+0xd1/0x2e0
> [   55.113257]  ? find_held_lock+0x2b/0x80
> [   55.113258]  ? __folio_batch_add_and_move+0x185/0x320
> [   55.113260]  ? find_held_lock+0x2b/0x80
> [   55.113261]  ? rcu_read_unlock+0x17/0x60
> [   55.113264]  ? rcu_read_unlock+0x17/0x60
> [   55.113266]  ? lock_release+0x17d/0x2c0
> [   55.113269]  ? __lock_acquire+0x469/0x2200
> [   55.113271]  ? __handle_mm_fault+0xac2/0xf10
> [   55.113273]  ? find_held_lock+0x2b/0x80
> [   55.113275]  ? rcu_read_unlock+0x17/0x60
> [   55.113276]  ? rcu_read_unlock+0x17/0x60
> [   55.113278]  ? lock_release+0x17d/0x2c0
> [   55.113279]  ? rcu_is_watching+0xd/0x40
> [   55.113281]  ? find_held_lock+0x2b/0x80
> [   55.113282]  ? exc_page_fault+0x8f/0x260
> [   55.113284]  ? exc_page_fault+0x8f/0x260
> [   55.113285]  ? lock_release+0x17d/0x2c0
> [   55.113287]  ? exc_page_fault+0x132/0x260
> [   55.113289]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   55.113291] RIP: 0033:0x7fd302d0e0d0
> [   55.113292] Code: 2d 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2=
e 0f 1f 84 00 00 00 00 00 80 3d 99 af 0e 00 00 74 17 b8 01 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> [   55.113293] RSP: 002b:00007fffb5edd3d8 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000001
> [   55.113295] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fd30=
2d0e0d0
> [   55.113295] RDX: 0000000000000004 RSI: 000055aa9fd98750 RDI: 000000000=
0000007
> [   55.113296] RBP: 000055aa9fd98750 R08: 00007fd302df1ac0 R09: 000000000=
0000001
> [   55.113297] R10: 00007fd302df1bb0 R11: 0000000000000202 R12: 000000000=
0000004
> [   55.113297] R13: 000055aa9fd8f2a0 R14: 00007fd302defea0 R15: 00000000f=
ffffff7
> [   55.113301]  </TASK>
> [   55.113362] WARNING: CPU: 8 PID: 2563 at kernel/freezer.c:140 __set_ta=
sk_frozen+0x6a/0x90
> [   55.113366] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_s=
eq_device xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netl=
ink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrt=
ype nft_compat x_tables nf_tables br_netfilter bridge stp llc ccm overlay q=
rtr rfcomm cmac algif_hash algif_skcipher af_alg bnep binfmt_misc nls_ascii=
 nls_cp437 vfat fat iwlmvm snd_hda_codec_generic intel_rapl_msr uvcvideo sn=
d_hda_codec_hdmi amd_atl mac80211 btusb videobuf2_vmalloc intel_rapl_common=
 btrtl videobuf2_memops snd_hda_intel snd_acp3x_pdm_dma snd_soc_dmic snd_ac=
p3x_rn uvc btintel kvm_amd snd_hda_codec videobuf2_v4l2 snd_soc_core btbcm =
libarc4 videodev snd_compress btmtk snd_intel_dspcfg ucsi_acpi kvm snd_hwde=
p videobuf2_common snd_pci_acp6x typec_ucsi bluetooth snd_hda_core snd_pci_=
acp5x mc ee1004 sg iwlwifi irqbypass roles snd_pcm ecdh_generic snd_rn_pci_=
acp3x typec wmi_bmof ecc rapl snd_timer snd_acp_config cfg80211 snd snd_soc=
_acpi sp5100_tco pcspkr k10temp thunderbolt watchdog ccp
> [   55.113424]  snd_pci_acp3x soundcore rfkill ac battery joydev acpi_tad=
 amd_pmc evdev serio_raw msr dm_mod parport_pc ppdev lp parport nvme_fabric=
s fuse efi_pstore configfs nfnetlink efivarfs autofs4 crc32c_cryptoapi sd_m=
od uas usb_storage scsi_mod scsi_common btrfs blake2b_generic xor raid6_pq =
amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm_exec drm_suballoc=
_helper drm_buddy drm_panel_backlight_quirks gpu_sched amdxcp drm_display_h=
elper xhci_pci hid_multitouch drm_kms_helper hid_generic xhci_hcd cec i2c_h=
id_acpi amd_sfh i2c_hid rc_core nvme usbcore i2c_piix4 video ghash_clmulni_=
intel hid crc16 usb_common nvme_core i2c_smbus fan button wmi drm aesni_int=
el
> [   55.113467] CPU: 8 UID: 0 PID: 2563 Comm: systemd-sleep Not tainted 6.=
18.0-rc6-00040-g8b690556d8fe-dirty #168 PREEMPT(voluntary)=20
> [   55.113470] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, =
BIOS F.17 12/18/2024
> [   55.113471] RIP: 0010:__set_task_frozen+0x6a/0x90
> [   55.113473] Code: f7 c5 00 20 00 00 74 06 40 f6 c5 03 74 33 81 e5 00 4=
0 00 00 75 16 8b 15 d8 8c 52 01 85 d2 74 0c 8b 83 f0 0e 00 00 85 c0 74 02 <=
0f> 0b 8b 43 18 c7 43 18 00 80 00 00 89 43 1c b8 00 80 00 00 5b 5d
> [   55.113474] RSP: 0018:ffffbfba462ef8d0 EFLAGS: 00010002
> [   55.113476] RAX: 0000000000000002 RBX: ffff9c3961c64900 RCX: 000000000=
0000000
> [   55.113477] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9c396=
1c64900
> [   55.113479] RBP: 0000000000000000 R08: 00000000000000b6 R09: 000000000=
0000006
> [   55.113480] R10: 00000000000000f0 R11: 0000000000000006 R12: ffffffff9=
8bd9000
> [   55.113481] R13: 0000000000000000 R14: ffff9c3961c65710 R15: ffff9c396=
1c65200
> [   55.113482] FS:  00007fd303258980(0000) GS:ffff9c3cb2d98000(0000) knlG=
S:0000000000000000
> [   55.113484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   55.113485] CR2: 0000561c6a183168 CR3: 0000000122bcb000 CR4: 000000000=
0750ef0
> [   55.113487] PKRU: 55555554
> [   55.113488] Call Trace:
> [   55.113489]  <TASK>
> [   55.113491]  task_call_func+0x76/0xf0
> [   55.113493]  freeze_task+0x87/0xf0
> [   55.113496]  try_to_freeze_tasks+0xe1/0x2b0
> [   55.113499]  ? lockdep_hardirqs_on+0x78/0x100
> [   55.113502]  freeze_processes+0x46/0xb0
> [   55.113505]  pm_suspend.cold+0x194/0x29f
> [   55.113507]  state_store+0x68/0xc0
> [   55.113510]  kernfs_fop_write_iter+0x172/0x240
> [   55.113513]  vfs_write+0x249/0x560
> [   55.113518]  ksys_write+0x6d/0xe0
> [   55.113521]  do_syscall_64+0x95/0x6e0
> [   55.113524]  ? __lock_acquire+0x469/0x2200
> [   55.113528]  ? __lock_acquire+0x469/0x2200
> [   55.113532]  ? lock_acquire+0xd1/0x2e0
> [   55.113534]  ? find_held_lock+0x2b/0x80
> [   55.113536]  ? __folio_batch_add_and_move+0x185/0x320
> [   55.113538]  ? find_held_lock+0x2b/0x80
> [   55.113540]  ? rcu_read_unlock+0x17/0x60
> [   55.113543]  ? rcu_read_unlock+0x17/0x60
> [   55.113545]  ? lock_release+0x17d/0x2c0
> [   55.113549]  ? __lock_acquire+0x469/0x2200
> [   55.113551]  ? __handle_mm_fault+0xac2/0xf10
> [   55.113554]  ? find_held_lock+0x2b/0x80
> [   55.113556]  ? rcu_read_unlock+0x17/0x60
> [   55.113558]  ? rcu_read_unlock+0x17/0x60
> [   55.113561]  ? lock_release+0x17d/0x2c0
> [   55.113563]  ? rcu_is_watching+0xd/0x40
> [   55.113565]  ? find_held_lock+0x2b/0x80
> [   55.113566]  ? exc_page_fault+0x8f/0x260
> [   55.113568]  ? exc_page_fault+0x8f/0x260
> [   55.113570]  ? lock_release+0x17d/0x2c0
> [   55.113573]  ? exc_page_fault+0x132/0x260
> [   55.113576]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   55.113578] RIP: 0033:0x7fd302d0e0d0
> [   55.113579] Code: 2d 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2=
e 0f 1f 84 00 00 00 00 00 80 3d 99 af 0e 00 00 74 17 b8 01 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> [   55.113581] RSP: 002b:00007fffb5edd3d8 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000001
> [   55.113583] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fd30=
2d0e0d0
> [   55.113584] RDX: 0000000000000004 RSI: 000055aa9fd98750 RDI: 000000000=
0000007
> [   55.113585] RBP: 000055aa9fd98750 R08: 00007fd302df1ac0 R09: 000000000=
0000001
> [   55.113586] R10: 00007fd302df1bb0 R11: 0000000000000202 R12: 000000000=
0000004
> [   55.113587] R13: 000055aa9fd8f2a0 R14: 00007fd302defea0 R15: 00000000f=
ffffff7
> [   55.113591]  </TASK>
> [   55.113592] irq event stamp: 22480
> [   55.113594] hardirqs last  enabled at (22479): [<ffffffff997159b8>] _r=
aw_spin_unlock_irqrestore+0x48/0x60
> [   55.113596] hardirqs last disabled at (22480): [<ffffffff9971575b>] _r=
aw_spin_lock_irqsave+0x5b/0x60
> [   55.113598] softirqs last  enabled at (21756): [<ffffffff98a91401>] ke=
rnel_fpu_end+0x31/0x40
> [   55.113600] softirqs last disabled at (21754): [<ffffffff98a91a66>] ke=
rnel_fpu_begin_mask+0xd6/0x150
> [   55.113602] ---[ end trace 0000000000000000 ]---
> [   55.115030] Freezing user space processes completed (elapsed 0.002 sec=
onds)
> [   55.115035] OOM killer disabled.
> [   55.115037] Freezing remaining freezable tasks
> [   55.116230] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
> [   55.116233] printk: Suspending console(s) (use no_console_suspend to d=
ebug)
>=20
> And another:
>=20
> [   90.334155] OOM killer enabled.
> [   90.334159] Restarting tasks: Starting
> [   90.335256] Restarting tasks: Done
> [   90.336242] efivarfs: resyncing variable state
> [   90.347855] efivarfs: finished resyncing variable state
> [   90.351615] random: crng reseeded on system resumption
> [   90.402289] Bluetooth: MGMT ver 1.23
> [   90.418337] PM: suspend exit
> [   90.418508] PM: suspend entry (s2idle)
> [   90.442310] Filesystems sync: 0.023 seconds
> [   90.464970] Freezing user space processes
> [   90.465209] ------------[ cut here ]------------
> [   90.465655] WARNING: CPU: 12 PID: 3770 at kernel/freezer.c:140 __set_t=
ask_frozen+0x6a/0x90
> [   90.465662] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_s=
eq_device xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netl=
ink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrt=
ype nft_compat x_tables nf_tables br_netfilter bridge stp llc ccm overlay q=
rtr rfcomm cmac algif_hash algif_skcipher af_alg bnep binfmt_misc ext4 mbca=
che jbd2 nls_ascii nls_cp437 vfat fat iwlmvm intel_rapl_msr amd_atl intel_r=
apl_common snd_hda_codec_generic snd_hda_codec_hdmi btusb uvcvideo mac80211=
 btrtl videobuf2_vmalloc btintel kvm_amd videobuf2_memops snd_hda_intel btb=
cm uvc libarc4 snd_hda_codec btmtk videobuf2_v4l2 kvm snd_intel_dspcfg snd_=
hda_scodec_cs35l41_i2c snd_hwdep bluetooth videodev snd_hda_scodec_cs35l41 =
snd_hda_core irqbypass iwlwifi ideapad_laptop snd_soc_cs_amp_lib videobuf2_=
common ecdh_generic sparse_keymap snd_pcm cs_dsp rapl ecc mc wmi_bmof ee100=
4 platform_profile pcspkr cfg80211 snd_soc_cs35l41_lib snd_timer k10temp cc=
p sg rfkill battery snd soundcore cm32181
> [   90.466192]  serial_multi_instantiate industrialio joydev ac evdev msr=
 parport_pc ppdev lp parport nvme_fabrics fuse efi_pstore configfs nfnetlin=
k efivarfs autofs4 crc32c_cryptoapi btrfs blake2b_generic xor raid6_pq dm_c=
rypt sd_mod uas usbhid usb_storage amdgpu drm_client_lib i2c_algo_bit drm_t=
tm_helper ttm drm_exec drm_suballoc_helper drm_buddy drm_panel_backlight_qu=
irks dm_mod gpu_sched ahci amdxcp r8169 libahci drm_display_helper ucsi_acp=
i realtek libata drm_kms_helper typec_ucsi hid_multitouch xhci_pci mdio_dev=
res roles cec sp5100_tco hid_generic xhci_hcd libphy scsi_mod nvme video ty=
pec rc_core wdat_wdt i2c_piix4 ghash_clmulni_intel nvme_core mdio_bus serio=
_raw watchdog scsi_common usbcore thunderbolt crc16 i2c_hid_acpi i2c_smbus =
usb_common i2c_hid wmi hid drm button aesni_intel
> [   90.466268] CPU: 12 UID: 0 PID: 3770 Comm: systemd-sleep Not tainted 6=
=2E18.0-rc6-00040-g8b690556d8fe-dirty #168 PREEMPT(voluntary)=20
> [   90.466272] Hardware name: LENOVO 82N6/LNVNB161216, BIOS GKCN65WW 01/1=
6/2024
> [   90.466274] RIP: 0010:__set_task_frozen+0x6a/0x90
> [   90.466277] Code: f7 c5 00 20 00 00 74 06 40 f6 c5 03 74 33 81 e5 00 4=
0 00 00 75 16 8b 15 d8 8c 52 01 85 d2 74 0c 8b 83 f0 0e 00 00 85 c0 74 02 <=
0f> 0b 8b 43 18 c7 43 18 00 80 00 00 89 43 1c b8 00 80 00 00 5b 5d
> [   90.466279] RSP: 0018:ffffaa8f8bf5bab0 EFLAGS: 00010002
> [   90.466282] RAX: 0000000000000002 RBX: ffff8bd9e5d12480 RCX: 000000000=
0000000
> [   90.466284] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8bd9e=
5d12480
> [   90.466285] RBP: 0000000000000000 R08: 00000000000000b4 R09: 000000000=
0000006
> [   90.466287] R10: 00000000000000f0 R11: 0000000000000006 R12: ffffffff8=
3dd9000
> [   90.466288] R13: 0000000000000000 R14: ffff8bd9e5d13290 R15: ffff8bd9e=
5d12d80
> [   90.466290] FS:  00007f5e1fc45980(0000) GS:ffff8bdfc4698000(0000) knlG=
S:0000000000000000
> [   90.466292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   90.466293] CR2: 00007f5e2043b488 CR3: 000000016063e000 CR4: 000000000=
0750ef0
> [   90.466295] PKRU: 55555554
> [   90.466296] Call Trace:
> [   90.466298]  <TASK>
> [   90.466301]  task_call_func+0x76/0xf0
> [   90.466307]  freeze_task+0x87/0xf0
> [   90.466312]  try_to_freeze_tasks+0xe1/0x2b0
> [   90.466317]  ? lockdep_hardirqs_on+0x78/0x100
> [   90.466322]  freeze_processes+0x46/0xb0
> [   90.466326]  pm_suspend.cold+0x194/0x29f
> [   90.466330]  state_store+0x68/0xc0
> [   90.466335]  kernfs_fop_write_iter+0x172/0x240
> [   90.466340]  vfs_write+0x249/0x560
> [   90.466350]  ksys_write+0x6d/0xe0
> [   90.466355]  do_syscall_64+0x95/0x6e0
> [   90.466363]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   90.466366]  ? lockdep_hardirqs_on+0x78/0x100
> [   90.466369]  ? do_syscall_64+0x1ad/0x6e0
> [   90.466372]  ? find_held_lock+0x2b/0x80
> [   90.466376]  ? do_sys_openat2+0xa4/0xe0
> [   90.466379]  ? kmem_cache_free+0x13e/0x640
> [   90.466385]  ? do_sys_openat2+0xa4/0xe0
> [   90.466387]  ? do_sys_openat2+0xa4/0xe0
> [   90.466390]  ? find_held_lock+0x2b/0x80
> [   90.466395]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   90.466397]  ? lockdep_hardirqs_on+0x78/0x100
> [   90.466400]  ? do_syscall_64+0x1ad/0x6e0
> [   90.466402]  ? exc_page_fault+0x132/0x260
> [   90.466409]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   90.466410] RIP: 0033:0x7f5e1fe99687
> [   90.466414] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 5=
9 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <=
5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> [   90.466415] RSP: 002b:00007fff3d312840 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000001
> [   90.466418] RAX: ffffffffffffffda RBX: 00007f5e1fc45980 RCX: 00007f5e1=
fe99687
> [   90.466419] RDX: 0000000000000007 RSI: 000055c3cbfbce50 RDI: 000000000=
0000007
> [   90.466421] RBP: 000055c3cbfbce50 R08: 0000000000000000 R09: 000000000=
0000000
> [   90.466422] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000=
0000007
> [   90.466423] R13: 000055c3cbfb22a0 R14: 00007f5e1ffefe80 R15: 00000000f=
ffffff7
> [   90.466435]  </TASK>
> [   90.466437] irq event stamp: 118990
> [   90.466438] hardirqs last  enabled at (118989): [<ffffffff849159b8>] _=
raw_spin_unlock_irqrestore+0x48/0x60
> [   90.466441] hardirqs last disabled at (118990): [<ffffffff8491575b>] _=
raw_spin_lock_irqsave+0x5b/0x60
> [   90.466443] softirqs last  enabled at (118630): [<ffffffff83cf99ed>] _=
_irq_exit_rcu+0xcd/0x140
> [   90.466446] softirqs last disabled at (118623): [<ffffffff83cf99ed>] _=
_irq_exit_rcu+0xcd/0x140
> [   90.466448] ---[ end trace 0000000000000000 ]---
> [   90.466528] ------------[ cut here ]------------
> [   90.466530] WARNING: CPU: 12 PID: 3770 at kernel/freezer.c:140 __set_t=
ask_frozen+0x6a/0x90
> [   90.466535] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_s=
eq_device xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netl=
ink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrt=
ype nft_compat x_tables nf_tables br_netfilter bridge stp llc ccm overlay q=
rtr rfcomm cmac algif_hash algif_skcipher af_alg bnep binfmt_misc ext4 mbca=
che jbd2 nls_ascii nls_cp437 vfat fat iwlmvm intel_rapl_msr amd_atl intel_r=
apl_common snd_hda_codec_generic snd_hda_codec_hdmi btusb uvcvideo mac80211=
 btrtl videobuf2_vmalloc btintel kvm_amd videobuf2_memops snd_hda_intel btb=
cm uvc libarc4 snd_hda_codec btmtk videobuf2_v4l2 kvm snd_intel_dspcfg snd_=
hda_scodec_cs35l41_i2c snd_hwdep bluetooth videodev snd_hda_scodec_cs35l41 =
snd_hda_core irqbypass iwlwifi ideapad_laptop snd_soc_cs_amp_lib videobuf2_=
common ecdh_generic sparse_keymap snd_pcm cs_dsp rapl ecc mc wmi_bmof ee100=
4 platform_profile pcspkr cfg80211 snd_soc_cs35l41_lib snd_timer k10temp cc=
p sg rfkill battery snd soundcore cm32181
> [   90.466665]  serial_multi_instantiate industrialio joydev ac evdev msr=
 parport_pc ppdev lp parport nvme_fabrics fuse efi_pstore configfs nfnetlin=
k efivarfs autofs4 crc32c_cryptoapi btrfs blake2b_generic xor raid6_pq dm_c=
rypt sd_mod uas usbhid usb_storage amdgpu drm_client_lib i2c_algo_bit drm_t=
tm_helper ttm drm_exec drm_suballoc_helper drm_buddy drm_panel_backlight_qu=
irks dm_mod gpu_sched ahci amdxcp r8169 libahci drm_display_helper ucsi_acp=
i realtek libata drm_kms_helper typec_ucsi hid_multitouch xhci_pci mdio_dev=
res roles cec sp5100_tco hid_generic xhci_hcd libphy scsi_mod nvme video ty=
pec rc_core wdat_wdt i2c_piix4 ghash_clmulni_intel nvme_core mdio_bus serio=
_raw watchdog scsi_common usbcore thunderbolt crc16 i2c_hid_acpi i2c_smbus =
usb_common i2c_hid wmi hid drm button aesni_intel
> [   90.466759] CPU: 12 UID: 0 PID: 3770 Comm: systemd-sleep Tainted: G   =
     W           6.18.0-rc6-00040-g8b690556d8fe-dirty #168 PREEMPT(voluntar=
y)=20
> [   90.466763] Tainted: [W]=3DWARN
> [   90.466765] Hardware name: LENOVO 82N6/LNVNB161216, BIOS GKCN65WW 01/1=
6/2024
> [   90.466767] RIP: 0010:__set_task_frozen+0x6a/0x90
> [   90.466770] Code: f7 c5 00 20 00 00 74 06 40 f6 c5 03 74 33 81 e5 00 4=
0 00 00 75 16 8b 15 d8 8c 52 01 85 d2 74 0c 8b 83 f0 0e 00 00 85 c0 74 02 <=
0f> 0b 8b 43 18 c7 43 18 00 80 00 00 89 43 1c b8 00 80 00 00 5b 5d
> [   90.466772] RSP: 0018:ffffaa8f8bf5bab0 EFLAGS: 00010002
> [   90.466775] RAX: 0000000000000002 RBX: ffff8bda00862480 RCX: 000000000=
0000000
> [   90.466777] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8bda0=
0862480
> [   90.466779] RBP: 0000000000000000 R08: 00000000000000b4 R09: 000000000=
0000006
> [   90.466781] R10: 00000000000000f0 R11: 0000000000000006 R12: ffffffff8=
3dd9000
> [   90.466783] R13: 0000000000000000 R14: ffff8bda00863290 R15: ffff8bd9e=
5d45200
> [   90.466785] FS:  00007f5e1fc45980(0000) GS:ffff8bdfc4698000(0000) knlG=
S:0000000000000000
> [   90.466787] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   90.466789] CR2: 00007f5e2043b488 CR3: 000000016063e000 CR4: 000000000=
0750ef0
> [   90.466791] PKRU: 55555554
> [   90.466793] Call Trace:
> [   90.466794]  <TASK>
> [   90.466797]  task_call_func+0x76/0xf0
> [   90.466805]  freeze_task+0x87/0xf0
> [   90.466812]  try_to_freeze_tasks+0xe1/0x2b0
> [   90.466817]  ? lockdep_hardirqs_on+0x78/0x100
> [   90.466824]  freeze_processes+0x46/0xb0
> [   90.466828]  pm_suspend.cold+0x194/0x29f
> [   90.466833]  state_store+0x68/0xc0
> [   90.466840]  kernfs_fop_write_iter+0x172/0x240
> [   90.466846]  vfs_write+0x249/0x560
> [   90.466859]  ksys_write+0x6d/0xe0
> [   90.466866]  do_syscall_64+0x95/0x6e0
> [   90.466877]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   90.466880]  ? lockdep_hardirqs_on+0x78/0x100
> [   90.466883]  ? do_syscall_64+0x1ad/0x6e0
> [   90.466888]  ? find_held_lock+0x2b/0x80
> [   90.466894]  ? do_sys_openat2+0xa4/0xe0
> [   90.466896]  ? kmem_cache_free+0x13e/0x640
> [   90.466905]  ? do_sys_openat2+0xa4/0xe0
> [   90.466908]  ? do_sys_openat2+0xa4/0xe0
> [   90.466911]  ? find_held_lock+0x2b/0x80
> [   90.466918]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   90.466921]  ? lockdep_hardirqs_on+0x78/0x100
> [   90.466925]  ? do_syscall_64+0x1ad/0x6e0
> [   90.466929]  ? exc_page_fault+0x132/0x260
> [   90.466938]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   90.466940] RIP: 0033:0x7f5e1fe99687
> [   90.466943] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 5=
9 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <=
5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> [   90.466945] RSP: 002b:00007fff3d312840 EFLAGS: 00000202 ORIG_RAX: 0000=
000000000001
> [   90.466949] RAX: ffffffffffffffda RBX: 00007f5e1fc45980 RCX: 00007f5e1=
fe99687
> [   90.466950] RDX: 0000000000000007 RSI: 000055c3cbfbce50 RDI: 000000000=
0000007
> [   90.466952] RBP: 000055c3cbfbce50 R08: 0000000000000000 R09: 000000000=
0000000
> [   90.466954] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000=
0000007
> [   90.466956] R13: 000055c3cbfb22a0 R14: 00007f5e1ffefe80 R15: 00000000f=
ffffff7
> [   90.466971]  </TASK>
> [   90.466973] irq event stamp: 119140
> [   90.466975] hardirqs last  enabled at (119139): [<ffffffff849159b8>] _=
raw_spin_unlock_irqrestore+0x48/0x60
> [   90.466977] hardirqs last disabled at (119140): [<ffffffff8491575b>] _=
raw_spin_lock_irqsave+0x5b/0x60
> [   90.466980] softirqs last  enabled at (118630): [<ffffffff83cf99ed>] _=
_irq_exit_rcu+0xcd/0x140
> [   90.466983] softirqs last disabled at (118623): [<ffffffff83cf99ed>] _=
_irq_exit_rcu+0xcd/0x140
> [   90.466987] ---[ end trace 0000000000000000 ]---
> [   90.468818] Freezing user space processes completed (elapsed 0.003 sec=
onds)
> [   90.468822] OOM killer disabled.
> [   90.468824] Freezing remaining freezable tasks
> [   90.470358] Freezing remaining freezable tasks completed (elapsed 0.00=
1 seconds)
> [   90.470361] printk: Suspending console(s) (use no_console_suspend to d=
ebug)
>=20
> #regzbot title: Intermittent suspend __set_task_frozen lock warnings
> #regzbot introduced: a3f8f8662771285511ae26c4c8d3ba1cd22159b9

