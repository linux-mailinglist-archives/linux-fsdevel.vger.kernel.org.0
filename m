Return-Path: <linux-fsdevel+bounces-43687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF5A5B99D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 08:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6A31714AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 07:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C30221D98;
	Tue, 11 Mar 2025 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL0nHscF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C759721421F;
	Tue, 11 Mar 2025 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741677407; cv=none; b=a8410SaqP7OcZ9EuNVYqZhRj6gTOYUQWndP09NH2I0aMzx6/vqqx1zkcnYlmF5BqNCduFMviN5YwJ72R5Q2Ee78WO4NLJukYOTU4oG4cDdgl/r58m95OGB+bb1GzyNPCa/rW+sjPF7+L0KYBj9aIAkvU6bxMyQUGTefY5B+pknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741677407; c=relaxed/simple;
	bh=oOc9X7xxWMwAGW31ghzLzBS0inrXqRWFanIWsOVm9V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txWR9sfGtYCkXcRDDBvK6VAx429lPUqTykGcw9rNJjBHlOxYiHcR3fxYCtvGBFORu/CyUs2ZVtFpraldDW4eeMfGIyVUb+0A0ngNTIOQm8G69C/EQps8G0l46gdImxVFZEmNray7ZDo85infOdEk/n6F8o6pydrv/Jq0ujz014A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL0nHscF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F45C4CEEA;
	Tue, 11 Mar 2025 07:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741677407;
	bh=oOc9X7xxWMwAGW31ghzLzBS0inrXqRWFanIWsOVm9V4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KL0nHscFis92rq5eVh8zdhU1AOgY6zcpzFZEvlNnq1ro8jwMkaX/xA3qAalsxxTh8
	 Y/e1aSDj3oeN7BtVmnqMdfo0owzy8310sF6gstWMb6fgzA0Je/OYsC1XrnqBsbUo3+
	 0K6ICkrM1MXXy+hkT5TavVBWFMBPYonA+Q2knAjMKM0OfTrWgmUDulo2oikG5R6nqa
	 XqRtS3BCpAeYSudg+G0XwFWmGrMJmuMiBIkJGN9rcnzHVMO3uU1wPG8cWdqP/UCgVH
	 0WEngJX1RVBiOW5jAQZ+/etSWY1pTEyNhv1ipisgXnejruz6mqpHy3joMgLEzKfp+b
	 5pARw6N4Id8FQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54954fa61c9so5873090e87.1;
        Tue, 11 Mar 2025 00:16:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbKHbsQpUKtYb3KTH4MpgaPV0u3XSPDIlAYHT0pNA8AT6hjwwew6OxShYTLOeKGOfJWoDYIQ3uNOI=@vger.kernel.org, AJvYcCUj0y0Ba222G6CjWLUGOLCG+M9VhQAPJKqWtP3fRnPPfI1Cy41pZlB7eUyAdu++sGSmRm8uBZods6oQVWHgkw==@vger.kernel.org, AJvYcCVaRbLp6XbAsFqPPMzHRCwR2g2cus9E3+vSZCjpXmKZ1b0EewNH+RoX4eTE7nsImzDHzDj2pWjeaKljk4WZXr4Nq93Il6Qf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywip93dS2Q7x5/CTfm1yp0hIJdbvwaOFu2PGnOAQNXU8OEXuwGm
	5aVG7aj+90YWgDTqTOUEovbt+J0W5LP5xwmM6OylyNoMWbzKlknMMmFmJvxJKn2i9zOXx4cY1jf
	okK5Y40iNQ3CMtqLhgE12/VsyAFQ=
X-Google-Smtp-Source: AGHT+IGwhC7iFZWUl9hxbKT5R+fYo4kG1aEBkBG3DgvmjEIjpQksGP3eKc3lFhqGIbFq15E2OBbJL+DSOUI7XR9CzpM=
X-Received: by 2002:a05:6512:3291:b0:549:7590:ff2e with SMTP id
 2adb3069b0e04-54990ec1882mr4810628e87.32.1741677405405; Tue, 11 Mar 2025
 00:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e54e6a2f-1178-4980-b771-4d9bafc2aa47@tnxip.de>
 <CAKCV-6s3_7RzDfo_yGQj9ndf4ZKw_Awf8oNc6pYKXgDTxiDfjw@mail.gmail.com>
 <465d1d23-3b36-490e-b0dd-74889d17fa4c@tnxip.de> <CAKCV-6uuKo=RK37GhM+fV90yV9sxBFqj0s07EPSoHwVZdDWa3A@mail.gmail.com>
 <ea97dd9d1cb33e28d6ca830b6bff0c2ece374dbe.camel@HansenPartnership.com>
In-Reply-To: <ea97dd9d1cb33e28d6ca830b6bff0c2ece374dbe.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 11 Mar 2025 08:16:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGLXbki1jezLgzDGE7VX8mNmHKQ3VLQPq=j5uAyrSomvQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpSuv2GVZBu2x49CbMX7Dwohp26mb9vGoGNYJtJZ8JNMlUZqDGaCOeLu38
Message-ID: <CAMj1kXGLXbki1jezLgzDGE7VX8mNmHKQ3VLQPq=j5uAyrSomvQ@mail.gmail.com>
Subject: Re: apparmor NULL pointer dereference on resume [efivarfs]
To: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Ryan Lee <ryan.lee@canonical.com>, =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>, 
	linux-security-module@vger.kernel.org, apparmor <apparmor@lists.ubuntu.com>, 
	linux-efi@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	"jk@ozlabs.org" <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(cc Al Viro)

On Mon, 10 Mar 2025 at 22:49, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2025-03-10 at 12:57 -0700, Ryan Lee wrote:
> > On Wed, Mar 5, 2025 at 1:47=E2=80=AFPM Malte Schr=C3=B6der
> > <malte.schroeder@tnxip.de> wrote:
> > >
> > > On 05/03/2025 20:22, Ryan Lee wrote:
> > > > On Wed, Mar 5, 2025 at 11:11=E2=80=AFAM Malte Schr=C3=B6der
> > > > <malte.schroeder@tnxip.de> wrote:
> > > > > Hi,
> > > > >
> > > > > I hope this is the right place to report this. Since 6.14-rc1
> > > > > ff. resume
> > > > > from hibernate does not work anymore. Now I finally managed to
> > > > > get dmesg
> > > > > from when this happens (Console is frozen, but managed to login
> > > > > via
> > > > > network). If I read that trace correctly there seems to be some
> > > > > interaction with apparmor. I retried with apparmor disabled and
> > > > > the
> > > > > issue didn't trigger.
> > > > Also CC'ing the AppArmor-specific mailing list in this reply.
> > > >
> > > > > I am happy to provide more data if required.
> > > > Could you try to reproduce this NULL pointer dereference with a
> > > > clean
> > > > kernel with debug info (that I'd be able to access the source
> > > > code of)
> > > > and send a symbolized stacktrace processed with
> > > > scripts/decode_stacktrace.sh?
> > >
> > > Sure. Result using plain v6.14-rc5:
> > >
> > > [  142.014428] BUG: kernel NULL pointer dereference, address:
> > > 0000000000000018
> > > [  142.014429] #PF: supervisor read access in kernel mode
> > > [  142.014431] #PF: error_code(0x0000) - not-present page
> > > [  142.014432] PGD 0 P4D 0
> > > [  142.014433] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > [  142.014436] CPU: 4 UID: 0 PID: 6833 Comm: systemd-sleep Not
> > > tainted
> > > 6.14.0-rc5 #1
> > > [  142.014437] Hardware name: To Be Filled By O.E.M. X570
> > > Extreme4/X570
> > > Extreme4, BIOS P5.60 01/18/2024
> > > [  142.014439] RIP: 0010:apparmor_file_open
> > > (./include/linux/mount.h:78
> > > (discriminator 2) ./include/linux/fs.h:2781 (discriminator 2)
> > > security/apparmor/lsm.c:483 (discriminator 2))
> > > [ 142.014442] Code: c5 00 08 00 00 0f 85 4b 01 00 00 4c 89 e9 31 c0
> > > f6
> > > c1 02 0f 85 fd 00 00 00 48 8b 87 88 00 00 00 4c 8d b7 88 00 00 00
> > > 48 89
> > > fd <48> 8b 40 18 48 8b 4f 70 0f b7 11 48 89 c7 66 89 54 24 04 48 8b
> > > 51
> > > All code
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > >    0:    c5 00 08                 (bad)
> > >    3:    00 00                    add    %al,(%rax)
> > >    5:    0f 85 4b 01 00 00        jne    0x156
> > >    b:    4c 89 e9                 mov    %r13,%rcx
> > >    e:    31 c0                    xor    %eax,%eax
> > >   10:    f6 c1 02                 test   $0x2,%cl
> > >   13:    0f 85 fd 00 00 00        jne    0x116
> > >   19:    48 8b 87 88 00 00 00     mov    0x88(%rdi),%rax
> > >   20:    4c 8d b7 88 00 00 00     lea    0x88(%rdi),%r14
> > >   27:    48 89 fd                 mov    %rdi,%rbp
> > >   2a:*    48 8b 40 18              mov    0x18(%rax),%rax        <-
> > > -
> > > trapping instruction
> > >   2e:    48 8b 4f 70              mov    0x70(%rdi),%rcx
> > >   32:    0f b7 11                 movzwl (%rcx),%edx
> > >   35:    48 89 c7                 mov    %rax,%rdi
> > >   38:    66 89 54 24 04           mov    %dx,0x4(%rsp)
> > >   3d:    48                       rex.W
> > >   3e:    8b                       .byte 0x8b
> > >   3f:    51                       push   %rcx
> > >
> > > Code starting with the faulting instruction
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >    0:    48 8b 40 18              mov    0x18(%rax),%rax
> > >    4:    48 8b 4f 70              mov    0x70(%rdi),%rcx
> > >    8:    0f b7 11                 movzwl (%rcx),%edx
> > >    b:    48 89 c7                 mov    %rax,%rdi
> > >    e:    66 89 54 24 04           mov    %dx,0x4(%rsp)
> > >   13:    48                       rex.W
> > >   14:    8b                       .byte 0x8b
> > >   15:    51                       push   %rcx
> > > [  142.014443] RSP: 0018:ffffb9ef7189bc50 EFLAGS: 00010246
> > > [  142.014445] RAX: 0000000000000000 RBX: ffff95eb5e555b00 RCX:
> > > 0000000000000300
> > > [  142.014446] RDX: ffff95f838227538 RSI: 00000000002ba677 RDI:
> > > ffff95e992be2a00
> > > [  142.014447] RBP: ffff95e992be2a00 R08: ffff95f838227520 R09:
> > > 0000000000000002
> > > [  142.014447] R10: ffff95ea72241d00 R11: 0000000000000001 R12:
> > > 0000000000000010
> > > [  142.014448] R13: 0000000000000300 R14: ffff95e992be2a88 R15:
> > > ffff95e95a6034e0
> > > [  142.014449] FS:  00007f74ab6cf880(0000)
> > > GS:ffff95f838200000(0000)
> > > knlGS:0000000000000000
> > > [  142.014450] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  142.014451] CR2: 0000000000000018 CR3: 00000002473b6000 CR4:
> > > 0000000000f50ef0
> > > [  142.014452] PKRU: 55555554
> > > [  142.014453] Call Trace:
> > > [  142.014454]  <TASK>
> > > [  142.014456] ? __die_body (arch/x86/kernel/dumpstack.c:421)
> > > [  142.014459] ? page_fault_oops (arch/x86/mm/fault.c:710)
> > > [  142.014460] ? __lock_acquire (kernel/locking/lockdep.c:?
> > > kernel/locking/lockdep.c:5174)
> > > [  142.014462] ? local_lock_acquire
> > > (./include/linux/local_lock_internal.h:29 (discriminator 1))
> > > [  142.014465] ? do_user_addr_fault (arch/x86/mm/fault.c:?)
> > > [  142.014467] ? exc_page_fault
> > > (./arch/x86/include/asm/irqflags.h:37
> > > ./arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1488
> > > arch/x86/mm/fault.c:1538)
> > > [  142.014468] ? asm_exc_page_fault
> > > (./arch/x86/include/asm/idtentry.h:623)
> > > [  142.014471] ? apparmor_file_open (./include/linux/mount.h:78
> > > (discriminator 2) ./include/linux/fs.h:2781 (discriminator 2)
> > > security/apparmor/lsm.c:483 (discriminator 2))
> > > [  142.014472] security_file_open (security/security.c:?)
> > > [  142.014474] do_dentry_open (fs/open.c:934)
> > > [  142.014476] kernel_file_open (fs/open.c:1201)
> > > [  142.014477] efivarfs_pm_notify (fs/efivarfs/super.c:505)
> >
> > I traced the NULL dereference down to efivarfs_pm_notify creating a
> > struct path with a NULL .mnt pointer which is then passed into
> > kernel_file_open, which then invokes the LSM file_open security hook,
> > where AppArmor is not expecting a path that has a NULL .mnt pointer.
> > The code in question was introduced in b5d1e6ee761a (efivarfs: add
> > variable resync after hibernation).
> >
> > I have sent in a patch to the AppArmor mailing list at
> > https://lists.ubuntu.com/archives/apparmor/2025-March/013545.html
> > which should give improved diagnostics for this case happening again.
> > My understanding is that path .mnt pointers generally should not be
> > NULL, but I do not know what an appropriate (non-NULL) value for that
> > pointer should be, as I am not familiar with the efivarfs subsystem.
>
> The problem comes down to the superblock functions not being able to
> get the struct vfsmount for the superblock (because it isn't even
> allocated until after they've all been called).  The assumption I was
> operating under was that provided I added O_NOATIME to prevent the
> parent directory being updated, passing in a NULL mnt for the purposes
> of iterating the directory dentry was safe.  What apparmour is trying
> to do is look up the idmap for the mount point to do one of its checks.
>
> There are two ways of fixing this that I can think of.  One would be
> exporting a function that lets me dig the vfsmount out of s_mounts and
> use that (it's well hidden in the internals of fs/mount.h, so I suspect
> this might not be very acceptable) or to get mnt_idmap to return
> &nop_mnt_idmap if the passed in mnt is NULL.  I'd lean towards the
> latter, but I'm cc'ing fsdevel to see what others think.
>


Al spotted the same issue based on a syzbot report [0]

[0] https://lore.kernel.org/all/20250310235831.GL2023217@ZenIV/

