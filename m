Return-Path: <linux-fsdevel+bounces-72635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3A2CFE9C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 16:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6AFB30F6540
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C038329373;
	Wed,  7 Jan 2026 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EizxpWL9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB03370EF
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799269; cv=none; b=uEyOHWW4SwGocd68tjai0u4/dGBY9ybsNRzDd1NuNy3VRrHpiAgf6PemnUa2i3WdZtK1t8MhAVJPaqz6HeZ5qteBttt7slr2CEgXAA+ztSi4eme0uoLQNxIA+5URFLL5RZh5ZNi5I2NIJvpeHCgXt08t5r3Q3pCWdsczA4rzr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799269; c=relaxed/simple;
	bh=PGbpWQOkegy/YLZosbUfA64tVIRpHUSeUUB8YHgi9Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJt5LTZEQ/ek1sVPps7iqrxg67psfwrZZjxpeJePqX4OMl6sXG4i1MCnVMP7sRp04Pu7hC0X38z+EejJtYf78dixr0ClgH/GSbP4ksAndUDCJ0VztbYPUZ6wk5kcWJ/YAWKg38pN2/w7vY+8dU2m2xZgfTfK/DC7zWtEqF8B9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EizxpWL9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso318278866b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767799263; x=1768404063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxmB5K/bVq87IrxAiozuXuhROUhRp4bbDUfbrllt814=;
        b=EizxpWL9TYPYiWzxdqVdjdwkQIKiwU8wbeebibVYEuNxCRYQ5xjH1fwMMC223URRQJ
         CPsXyuM+vwRZKRUVUOAZkvupWWQjQ54EWBZ5TPHmyq7DCLKqsx4fSlwCD3jTVmIj+42f
         u7R5jl82LiL5pLXiMf3KFPi1Q49Siy/C2NeGUswuas0/nVqwhisAK0UGSQlhtHhDeO9s
         EsSsjXM+fvV94eGNROlT5OqrxaEV5uODjhZ+wpLW3HGJdGTj6PpAsws7iH7Y23eUOhFo
         H/bXWUzRcpt7uj6mnFCzKGc1ETjPWvFwKVbdJY+1f3O7PpLVxFZJpw+WJqT436rBvQ/D
         MOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767799263; x=1768404063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BxmB5K/bVq87IrxAiozuXuhROUhRp4bbDUfbrllt814=;
        b=R+r4s/9S4QeGe/E9RI7dd/KCSeMDZ/pYKeMjfLjJt8mVjO7MxXR1J0HO3+xNoxz4KW
         eQt2o2WRw/ofATxmr8lWj4uXQtyK/du9s1oMOHymZ9vCp/Uf4lGcnmA79MalWqjTLu3Y
         f2C0xgXht4kszR318mYPwswhnXRPVB0F3v0CTiYAFnw0tRf5fK7g8FjDOlRhIv/m3440
         MfBqnjLrF4MuNbc+QStn5zEaH9kdSq29A4lSaR7g4x02qxghG0rMsbqB2t8gNZ+eEXcF
         98NZ4mrqEokDIwLn5TMSRFzZprOK/l1dKVKtsbNmB2aUT84gLX6Fkz8h4R2COMicXcsJ
         0urg==
X-Forwarded-Encrypted: i=1; AJvYcCXulsNX7EQZw1jVeukCHaiE4uytrtnDE5dZ+fC21Xlwz6r36dJ25piorFkN0ja0TeJ5ZZoB9USysvdZcnjk@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+/3DMryqeYX13SB8doVp1JjnubDJpb4jp2AC5y0YfFpgcW/n
	zmq5+vZRE/LwI0W/cVuAQhHJ/AcGXTZV1CWEaDM8oMHv8jBhUMsYA8aWq9u7QDvr7mAfemy2t5g
	YdfkDHNaq9RBOcd2W0abx/EaY3WopZn0=
X-Gm-Gg: AY/fxX6eNrlaIOv+QvpmdfAiB2q/mGFNFzaA50sxHj/1U29QZus+MwujkMer0+9Czzr
	pnzr40af62AS+fBFTpyEbiTPyZ1XWhoi1ZHU6ZtVx5+jt6bYOvZT4swu04LDpUQPE+gSU/6u3Rs
	07unbjoL3HTk6JqdyMJ60jgLN735UVGTlIfLGFt6GaTlLKADAQeWSJsjrw65GCbdOL3EJ1S81bY
	/pj1j66lTizaKMhH8mZ0E6TaxiQmkMV1tCL6n+e+OVGdLCtsgkpe5PYolsVXdMhG5AU1+w9w0eM
	zgyBU3/mnM7g2Z5Fs2fMOQ6sgemrY1qdePQ=
X-Google-Smtp-Source: AGHT+IESqIPJmdS/8JZLYS91oZpcbQZODLgn7AxqWpcC7VOgB9KzzqMokSZM6jFzw/x88vTNvB+figr9bsxmIuznUZM=
X-Received: by 2002:a17:907:3d02:b0:b83:d1bc:244b with SMTP id
 a640c23a62f3a-b84451c32aemr266143266b.23.1767799262553; Wed, 07 Jan 2026
 07:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-likely_device-v1-1-0c55f83a7e47@debian.org>
 <CAGudoHESsM03W+Qo3sHP5FEXZOxF_bHBYFErYx81wZwWdq5ANg@mail.gmail.com> <thjezcdhtxod63uu3zh35a6a3d4vimvdx5cieehaqynzqixwhl@qod7sgkrmkl4>
In-Reply-To: <thjezcdhtxod63uu3zh35a6a3d4vimvdx5cieehaqynzqixwhl@qod7sgkrmkl4>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 7 Jan 2026 16:20:50 +0100
X-Gm-Features: AQt7F2rvHJnU0Uc_4bovluGSWW_BYMDNpYabNkBIcvOumVIU3MIqlS_A2I-LL-U
Message-ID: <CAGudoHHdFXeN4kRXxdBxV_fumQqxeTxjfFb2oSrvTxu-pC5u7g@mail.gmail.com>
Subject: Re: [PATCH] device_cgroup: remove branch hint after code refactor
To: Breno Leitao <leitao@debian.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, rostedt@goodmis.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 4:17=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> Hello Mateusz,
>
> On Wed, Jan 07, 2026 at 03:17:40PM +0100, Mateusz Guzik wrote:
> > On Wed, Jan 7, 2026 at 3:06=E2=80=AFPM Breno Leitao <leitao@debian.org>=
 wrote:
> > > diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgr=
oup.h
> > > index 0864773a57e8..822085bc2d20 100644
> > > --- a/include/linux/device_cgroup.h
> > > +++ b/include/linux/device_cgroup.h
> > > @@ -21,7 +21,7 @@ static inline int devcgroup_inode_permission(struct=
 inode *inode, int mask)
> > >         if (likely(!S_ISBLK(inode->i_mode) && !S_ISCHR(inode->i_mode)=
))
> > >                 return 0;
> > >
> > > -       if (likely(!inode->i_rdev))
> > > +       if (!inode->i_rdev)
> > >                 return 0;
> > >
> >
> > The branch was left there because I could not be bothered to analyze
> > whether it can be straight up eleminated with the new checks in place.
> >
> > A quick look at init_special_inode suggests it is an invariant rdev is
> > there in this case.
> >
> > So for the time being I would replace likely with WARN_ON_ONCE . Might
> > be even a good candidate for the pending release.
>
> Oh, in fact that was my first try, but, when I tested it, I found that
> it warns in some cases.
>

heh, bummer

in that case:
Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>

thanks

>         [  126.951410] WARNING: ./include/linux/device_cgroup.h:24 at ino=
de_permission+0x181/0x190, CPU#4: networkd)/1212
>         [  126.971659] Modules linked in: intel_uncore_frequency(E) intel=
_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdim=
m(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) k=
vm(E) iTCO_wdt(E) iTCO_vendor_support(E) irqbypass(E) acpi_cpufreq(E) i2c_i=
801(E) i2c_smbus(E) wmi(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) ev=
dev(E) button(E) bpf_preload(E) sch_fq_codel(E) xhci_pci(E) xhci_hcd(E) vho=
st_net(E) tap(E) tun(E) vhost(E) vhost_iotlb(E) mpls_gso(E) mpls_iptunnel(E=
) mpls_router(E) fou(E) loop(E) efivarfs(E) autofs4(E)
>         [  127.097485] Tainted: [S]=3DCPU_OUT_OF_SPEC, [E]=3DUNSIGNED_MOD=
ULE
>         [  127.109038] Hardware name: Quanta Delta Lake MP 29F0EMA01D0/De=
lta Lake-Class1, BIOS F0E_3A21 06/27/2024
>         [  127.127889] RIP: 0010:inode_permission (./include/linux/device=
_cgroup.h:24 fs/namei.c:600)
>         [  127.137542] Code: 14 81 e2 ff ff 0f 00 31 ff 3d 00 60 00 00 41=
 8d 0c 48 40 0f 95 c7 ff c7 e8 5c 68 35 00 85 c0 0f 85 6d ff ff ff e9 29 ff=
 ff ff <0f> 0b e9 22 ff ff ff 0f 1f 84 00 00 00 00 00 41 56 53 49 89 f6 48
>         All code
>         =3D=3D=3D=3D=3D=3D=3D=3D
>         0:    14 81                    adc    $0x81,%al
>         2:    e2 ff                    loop   0x3
>         4:    ff 0f                    decl   (%rdi)
>         6:    00 31                    add    %dh,(%rcx)
>         8:    ff                       (bad)
>         9:    3d 00 60 00 00           cmp    $0x6000,%eax
>         e:    41 8d 0c 48              lea    (%r8,%rcx,2),%ecx
>         12:    40 0f 95 c7              setne  %dil
>         16:    ff c7                    inc    %edi
>         18:    e8 5c 68 35 00           call   0x356879
>         1d:    85 c0                    test   %eax,%eax
>         1f:    0f 85 6d ff ff ff        jne    0xffffffffffffff92
>         25:    e9 29 ff ff ff           jmp    0xffffffffffffff53
>         2a:*    0f 0b                    ud2            <-- trapping inst=
ruction
>         2c:    e9 22 ff ff ff           jmp    0xffffffffffffff53
>         31:    0f 1f 84 00 00 00 00     nopl   0x0(%rax,%rax,1)
>         38:    00
>         39:    41 56                    push   %r14
>         3b:    53                       push   %rbx
>         3c:    49 89 f6                 mov    %rsi,%r14
>         3f:    48                       rex.W
>
>         Code starting with the faulting instruction
>         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         0:    0f 0b                    ud2
>         2:    e9 22 ff ff ff           jmp    0xffffffffffffff29
>         7:    0f 1f 84 00 00 00 00     nopl   0x0(%rax,%rax,1)
>         e:    00
>         f:    41 56                    push   %r14
>         11:    53                       push   %rbx
>         12:    49 89 f6                 mov    %rsi,%r14
>         15:    48                       rex.W
>         [  127.175161] RSP: 0018:ffffc9000438fe60 EFLAGS: 00010246
>         [  127.185667] RAX: 0000000000002000 RBX: 0000000000000010 RCX: 0=
000000000006000
>         [  127.199992] RDX: 0000000000000000 RSI: ffff88842a9b5418 RDI: f=
fffffff83e31178
>         [  127.214320] RBP: 0000000000000001 R08: 0000000000000001 R09: 0=
000000000000000
>         [  127.228667] R10: 0000000000000000 R11: ffff88842a9b54b0 R12: f=
fffffff83e31178
>         [  127.243017] R13: ffff88842a9b5418 R14: ffff88842a9b5418 R15: f=
fff88842a9b5498
>         [  127.257360] FS:  00007f86e4bc3900(0000) GS:ffff8890b23fa000(00=
00) knlGS:0000000000000000
>         [  127.273624] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>         [  127.285172] CR2: 000055990443e068 CR3: 00000004183b2001 CR4: 0=
0000000007726f0
>         [  127.299500] PKRU: 55555554
>         [  127.304961] Call Trace:
>         [  127.309885]  <TASK>
>         [  127.314121]  do_faccessat (fs/open.c:508)
>         [  127.321488]  ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/=
entry_64.S:131)
>         [  127.331973]  __x64_sys_access (fs/open.c:549 fs/open.c:547 fs/=
open.c:547)
>         [  127.339677]  do_syscall_64 (arch/x86/entry/syscall_64.c:?)
>         [  127.347038]  ? rcu_is_watching (./include/linux/context_tracki=
ng.h:128 kernel/rcu/tree.c:751)
>         [  127.354775]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/en=
try_64.S:131)
>         [  127.364914] RIP: 0033:0x7f86e42ff21b
>
>
> Lines against commit f0b9d8eb98df  ("Merge tag 'nfsd-6.19-3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux"), plus something=
 like:
>
>
> diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.=
h
> index 822085bc2d20..c2b933a318f8 100644
> --- a/include/linux/device_cgroup.h
> +++ b/include/linux/device_cgroup.h
> @@ -21,7 +21,7 @@ static inline int devcgroup_inode_permission(struct ino=
de *inode, int mask)
>         if (likely(!S_ISBLK(inode->i_mode) && !S_ISCHR(inode->i_mode)))
>                 return 0;
>
> -       if (likely(!inode->i_rdev))
> +       if (WARN_ON_ONCE(!inode->i_rdev))
>                 return 0;
>
>         if (S_ISBLK(inode->i_mode))
>
>

