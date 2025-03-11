Return-Path: <linux-fsdevel+bounces-43689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72414A5BB05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 09:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632B23AADDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6559A226CF8;
	Tue, 11 Mar 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khDC3Qmn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B930622170A;
	Tue, 11 Mar 2025 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741682722; cv=none; b=O4LMA2SNCE1zO86nvAyndKkSas9ED/Ult7EcnaLQoZRxNL3dDdEXqXSzaW7PUk4kkAS/6BmBbtvey7lpoceaGpT2HAY+6vLrC3nJtRRQcZVa961VXZVBASYRiIdHTwHILBE+Eit4Es3ew/q8zQzT+SNo9As9epPh8aUM9ShcKS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741682722; c=relaxed/simple;
	bh=N9ti5RiaRpT1tNwEt+6s4aMLX61sSMleWeCRdLu0vRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gp2CN+k3xFj3fJbdV8LMB/CYW953gCRDQEIWytF85UXrbcsAoDAEEE0vOjFCyjNXfr09f/RZXHbvBu1RDX53iHZwDXebyPhtkeTW+wbFvK3b0fQCOjMMWl+uRtIvcTkoT3CggFZGsa68GRKrrcZOnitZJd/lJg1a9LYAPSK8fr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khDC3Qmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B58C4CEE9;
	Tue, 11 Mar 2025 08:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741682722;
	bh=N9ti5RiaRpT1tNwEt+6s4aMLX61sSMleWeCRdLu0vRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khDC3QmnMIrnmmb1FPIFzpqN2IXIOe5NEH+HOQMDiRHJED8T9m48iO7iURB2C0IZV
	 NttRgvepFzWc9A4WmwzjIsOaNNshl1mn57huVuTDkFFyv+/FF+aq4HwTWJP/GfnGwb
	 gmLnOer9xktPRV/L52o4cFPfIRJi4IVgCJ5b0Yy3wzU2qHZbLrj5BxM/vT89NpQ3KQ
	 4x7AzLUiJhv+MJHnWxdy2gaEZCy3FRc9InwsJGQgsFypG+zsMmU7STyzWc/JziZxBL
	 mwOdokGqFI78p3PEimv19fBivjHY3CTDO/ctjNGgo2pE9GDlx1Za10juRUZ5+TAWIW
	 Zt9Rs2luR2qMg==
Date: Tue, 11 Mar 2025 09:45:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Ryan Lee <ryan.lee@canonical.com>, 
	Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, linux-security-module@vger.kernel.org, 
	apparmor <apparmor@lists.ubuntu.com>, linux-efi@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, "jk@ozlabs.org" <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org
Subject: Re: apparmor NULL pointer dereference on resume [efivarfs]
Message-ID: <20250311-visite-rastplatz-d1fdb223dc10@brauner>
References: <e54e6a2f-1178-4980-b771-4d9bafc2aa47@tnxip.de>
 <CAKCV-6s3_7RzDfo_yGQj9ndf4ZKw_Awf8oNc6pYKXgDTxiDfjw@mail.gmail.com>
 <465d1d23-3b36-490e-b0dd-74889d17fa4c@tnxip.de>
 <CAKCV-6uuKo=RK37GhM+fV90yV9sxBFqj0s07EPSoHwVZdDWa3A@mail.gmail.com>
 <ea97dd9d1cb33e28d6ca830b6bff0c2ece374dbe.camel@HansenPartnership.com>
 <CAMj1kXGLXbki1jezLgzDGE7VX8mNmHKQ3VLQPq=j5uAyrSomvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXGLXbki1jezLgzDGE7VX8mNmHKQ3VLQPq=j5uAyrSomvQ@mail.gmail.com>

On Tue, Mar 11, 2025 at 08:16:34AM +0100, Ard Biesheuvel wrote:
> (cc Al Viro)
> 
> On Mon, 10 Mar 2025 at 22:49, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > On Mon, 2025-03-10 at 12:57 -0700, Ryan Lee wrote:
> > > On Wed, Mar 5, 2025 at 1:47 PM Malte Schröder
> > > <malte.schroeder@tnxip.de> wrote:
> > > >
> > > > On 05/03/2025 20:22, Ryan Lee wrote:
> > > > > On Wed, Mar 5, 2025 at 11:11 AM Malte Schröder
> > > > > <malte.schroeder@tnxip.de> wrote:
> > > > > > Hi,
> > > > > >
> > > > > > I hope this is the right place to report this. Since 6.14-rc1
> > > > > > ff. resume
> > > > > > from hibernate does not work anymore. Now I finally managed to
> > > > > > get dmesg
> > > > > > from when this happens (Console is frozen, but managed to login
> > > > > > via
> > > > > > network). If I read that trace correctly there seems to be some
> > > > > > interaction with apparmor. I retried with apparmor disabled and
> > > > > > the
> > > > > > issue didn't trigger.
> > > > > Also CC'ing the AppArmor-specific mailing list in this reply.
> > > > >
> > > > > > I am happy to provide more data if required.
> > > > > Could you try to reproduce this NULL pointer dereference with a
> > > > > clean
> > > > > kernel with debug info (that I'd be able to access the source
> > > > > code of)
> > > > > and send a symbolized stacktrace processed with
> > > > > scripts/decode_stacktrace.sh?
> > > >
> > > > Sure. Result using plain v6.14-rc5:
> > > >
> > > > [  142.014428] BUG: kernel NULL pointer dereference, address:
> > > > 0000000000000018
> > > > [  142.014429] #PF: supervisor read access in kernel mode
> > > > [  142.014431] #PF: error_code(0x0000) - not-present page
> > > > [  142.014432] PGD 0 P4D 0
> > > > [  142.014433] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > > [  142.014436] CPU: 4 UID: 0 PID: 6833 Comm: systemd-sleep Not
> > > > tainted
> > > > 6.14.0-rc5 #1
> > > > [  142.014437] Hardware name: To Be Filled By O.E.M. X570
> > > > Extreme4/X570
> > > > Extreme4, BIOS P5.60 01/18/2024
> > > > [  142.014439] RIP: 0010:apparmor_file_open
> > > > (./include/linux/mount.h:78
> > > > (discriminator 2) ./include/linux/fs.h:2781 (discriminator 2)
> > > > security/apparmor/lsm.c:483 (discriminator 2))
> > > > [ 142.014442] Code: c5 00 08 00 00 0f 85 4b 01 00 00 4c 89 e9 31 c0
> > > > f6
> > > > c1 02 0f 85 fd 00 00 00 48 8b 87 88 00 00 00 4c 8d b7 88 00 00 00
> > > > 48 89
> > > > fd <48> 8b 40 18 48 8b 4f 70 0f b7 11 48 89 c7 66 89 54 24 04 48 8b
> > > > 51
> > > > All code
> > > > ========
> > > >    0:    c5 00 08                 (bad)
> > > >    3:    00 00                    add    %al,(%rax)
> > > >    5:    0f 85 4b 01 00 00        jne    0x156
> > > >    b:    4c 89 e9                 mov    %r13,%rcx
> > > >    e:    31 c0                    xor    %eax,%eax
> > > >   10:    f6 c1 02                 test   $0x2,%cl
> > > >   13:    0f 85 fd 00 00 00        jne    0x116
> > > >   19:    48 8b 87 88 00 00 00     mov    0x88(%rdi),%rax
> > > >   20:    4c 8d b7 88 00 00 00     lea    0x88(%rdi),%r14
> > > >   27:    48 89 fd                 mov    %rdi,%rbp
> > > >   2a:*    48 8b 40 18              mov    0x18(%rax),%rax        <-
> > > > -
> > > > trapping instruction
> > > >   2e:    48 8b 4f 70              mov    0x70(%rdi),%rcx
> > > >   32:    0f b7 11                 movzwl (%rcx),%edx
> > > >   35:    48 89 c7                 mov    %rax,%rdi
> > > >   38:    66 89 54 24 04           mov    %dx,0x4(%rsp)
> > > >   3d:    48                       rex.W
> > > >   3e:    8b                       .byte 0x8b
> > > >   3f:    51                       push   %rcx
> > > >
> > > > Code starting with the faulting instruction
> > > > ===========================================
> > > >    0:    48 8b 40 18              mov    0x18(%rax),%rax
> > > >    4:    48 8b 4f 70              mov    0x70(%rdi),%rcx
> > > >    8:    0f b7 11                 movzwl (%rcx),%edx
> > > >    b:    48 89 c7                 mov    %rax,%rdi
> > > >    e:    66 89 54 24 04           mov    %dx,0x4(%rsp)
> > > >   13:    48                       rex.W
> > > >   14:    8b                       .byte 0x8b
> > > >   15:    51                       push   %rcx
> > > > [  142.014443] RSP: 0018:ffffb9ef7189bc50 EFLAGS: 00010246
> > > > [  142.014445] RAX: 0000000000000000 RBX: ffff95eb5e555b00 RCX:
> > > > 0000000000000300
> > > > [  142.014446] RDX: ffff95f838227538 RSI: 00000000002ba677 RDI:
> > > > ffff95e992be2a00
> > > > [  142.014447] RBP: ffff95e992be2a00 R08: ffff95f838227520 R09:
> > > > 0000000000000002
> > > > [  142.014447] R10: ffff95ea72241d00 R11: 0000000000000001 R12:
> > > > 0000000000000010
> > > > [  142.014448] R13: 0000000000000300 R14: ffff95e992be2a88 R15:
> > > > ffff95e95a6034e0
> > > > [  142.014449] FS:  00007f74ab6cf880(0000)
> > > > GS:ffff95f838200000(0000)
> > > > knlGS:0000000000000000
> > > > [  142.014450] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [  142.014451] CR2: 0000000000000018 CR3: 00000002473b6000 CR4:
> > > > 0000000000f50ef0
> > > > [  142.014452] PKRU: 55555554
> > > > [  142.014453] Call Trace:
> > > > [  142.014454]  <TASK>
> > > > [  142.014456] ? __die_body (arch/x86/kernel/dumpstack.c:421)
> > > > [  142.014459] ? page_fault_oops (arch/x86/mm/fault.c:710)
> > > > [  142.014460] ? __lock_acquire (kernel/locking/lockdep.c:?
> > > > kernel/locking/lockdep.c:5174)
> > > > [  142.014462] ? local_lock_acquire
> > > > (./include/linux/local_lock_internal.h:29 (discriminator 1))
> > > > [  142.014465] ? do_user_addr_fault (arch/x86/mm/fault.c:?)
> > > > [  142.014467] ? exc_page_fault
> > > > (./arch/x86/include/asm/irqflags.h:37
> > > > ./arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1488
> > > > arch/x86/mm/fault.c:1538)
> > > > [  142.014468] ? asm_exc_page_fault
> > > > (./arch/x86/include/asm/idtentry.h:623)
> > > > [  142.014471] ? apparmor_file_open (./include/linux/mount.h:78
> > > > (discriminator 2) ./include/linux/fs.h:2781 (discriminator 2)
> > > > security/apparmor/lsm.c:483 (discriminator 2))
> > > > [  142.014472] security_file_open (security/security.c:?)
> > > > [  142.014474] do_dentry_open (fs/open.c:934)
> > > > [  142.014476] kernel_file_open (fs/open.c:1201)
> > > > [  142.014477] efivarfs_pm_notify (fs/efivarfs/super.c:505)
> > >
> > > I traced the NULL dereference down to efivarfs_pm_notify creating a
> > > struct path with a NULL .mnt pointer which is then passed into
> > > kernel_file_open, which then invokes the LSM file_open security hook,
> > > where AppArmor is not expecting a path that has a NULL .mnt pointer.
> > > The code in question was introduced in b5d1e6ee761a (efivarfs: add
> > > variable resync after hibernation).
> > >
> > > I have sent in a patch to the AppArmor mailing list at
> > > https://lists.ubuntu.com/archives/apparmor/2025-March/013545.html
> > > which should give improved diagnostics for this case happening again.
> > > My understanding is that path .mnt pointers generally should not be
> > > NULL, but I do not know what an appropriate (non-NULL) value for that
> > > pointer should be, as I am not familiar with the efivarfs subsystem.
> >
> > The problem comes down to the superblock functions not being able to
> > get the struct vfsmount for the superblock (because it isn't even
> > allocated until after they've all been called).  The assumption I was
> > operating under was that provided I added O_NOATIME to prevent the
> > parent directory being updated, passing in a NULL mnt for the purposes
> > of iterating the directory dentry was safe.  What apparmour is trying
> > to do is look up the idmap for the mount point to do one of its checks.
> >
> > There are two ways of fixing this that I can think of.  One would be
> > exporting a function that lets me dig the vfsmount out of s_mounts and
> > use that (it's well hidden in the internals of fs/mount.h, so I suspect
> > this might not be very acceptable) or to get mnt_idmap to return

Nope, please don't.

> > &nop_mnt_idmap if the passed in mnt is NULL.  I'd lean towards the
> > latter, but I'm cc'ing fsdevel to see what others think.

A struct path with mount NULL and dentry != NULL is guaranteed to bit us
in the ass in other places. That's the bug.

> >
> 
> 
> Al spotted the same issue based on a syzbot report [0]
> 
> [0] https://lore.kernel.org/all/20250310235831.GL2023217@ZenIV/

efivars as written only has a single global superblock and it doesn't
support idmapped mounts and I don't see why it ever would.

But since efivars does only ever have a single global superblock, one
possibility is to an internal superblock that always exits and is
resurfaced whenever userspace mounts efivarfs. That's essentially the
devtmpfs model.

Then you can stash:

static struct vfsmount *efivarfs_mnt;

globally and use that in efivarfs_pm_notify() to fill in struct path.

