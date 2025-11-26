Return-Path: <linux-fsdevel+bounces-69887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55327C89C4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 13:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC4A64EA8F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545A2328265;
	Wed, 26 Nov 2025 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V72kk2ZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F836327BE6
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160214; cv=none; b=Dc9JV6zu+R/45mrU8hQKSX41bD7v9RC/oHJS/n+cHcGQSiRPHhD2USeR5aGWMpBFhPEnzEgouJPkrCWofTB3hMEsxnX91g9VXSOg+ki6E/pWcbAOn1w9rPnzkw5H0yeXm8f8IwAGrswoI5p3HNBey360yCi7n5zEIbP1wThN+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160214; c=relaxed/simple;
	bh=7LaKh4SKkJZP9igZfKyzHF/xQa5BBL8oladEBtlkksc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mk9dnpN0QN0Uvzw+WddjkzaD/BRsdTmClHOuwlIaPdrWf1TDgzxPHVTx/X3+qHoGSxwXwxdsx4hLTJ3U5h33IGvjAv1dgPyD/mLq9dyEmwvFQEwp5WcGLhq2n8Uh3jgQmrlWNvNTSv1Gel6IZRlgLo1WzNhMrucc5AgsvXOOnsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V72kk2ZO; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so8797111a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 04:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764160209; x=1764765009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbofuyaCjblUfm2kB3vXRi6dRXYTWCLMfwZ2YrRLIBM=;
        b=V72kk2ZOB3/4RV/MkJaZPiHrgxGHFY4PIHPdCuJTpeMeX0vVRtWtvk5DxCTbVHZTia
         nH43d8vVOWJL+IWYcSOIU+mkFNuWLFXT75yFN8f8Fcrypd6q8aLnCmqObK8Z3EoRR8+D
         1MPs1ZHVUN18tO/hG9tARIcRfh/OTwxOVVsF4L6lW88aD+bijNc1mIgKpa+C89Ff78/L
         nasmyhzAq1JPgQPy127GUJuy6rnvMZQntebjtqYSG700wnKExeJfi+KXADee+v4CZOPs
         0+Ozxxs1miPhWiystQkLquRMiAiuW24fiz7Qg/iGQilI1Lyv5d/1hPr2TiiTq4YW1miH
         0ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764160209; x=1764765009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MbofuyaCjblUfm2kB3vXRi6dRXYTWCLMfwZ2YrRLIBM=;
        b=joiYRFCMh29dzXYHl58nhliNtFflValVxY4znX7uOq/x752jcMi3HGKtp/zXSQ7Se/
         QkpNpv2ZH6i+QhhTduwTbFSNn8b3rFWjSD1i17jE99fcV/b/4PGDlt67KrlPfvXaSNxq
         EW4iQTsDEixAsuCpwfh5qkhVbIVxghm5RsIPGA9eroZDaq2nGMcmv4bHmNswjhDwcb17
         2ZpytMYV9nxYhgT9gK1hX17R1EJGsCkHe+juqPcOY/I0ufI1x+frqhznVK6jSVj9Evir
         A6J4gbWXQTLzZWLerMbnTu5droTLGMlj+0hrrwxiYj51Y2pCjE+FPDxQKS3SJH1hIMaK
         GK+w==
X-Forwarded-Encrypted: i=1; AJvYcCXLb5NaTULR7n6s5qOOVyXq+8fKj2GSed87fDFufC/Wu2JHfZf89JJrHrBJZNZx5YvmS+7laoo15i0ozq8e@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/IGjZn5BYuuDukqGMWI15k2vq6yyqso02gmntTCX+CKSNuJO
	BvEL3Z9Isw1wVcJ9d6ILUzaFC6RRDTQ1UGtXwl2p3E30J9UHtoWap6iZkj7uC4rGHS+c/bvTV9r
	flR3xZwniwlH528Ii7n21WgPrb8v/9caMllA49l8=
X-Gm-Gg: ASbGncsZp0tMIXvE0+EjfHIrm7dbjxF12+YfK5ChiS7HrgFi9nVYHyrEnyLgXg/MO3H
	wdtVI/CEzNuhtV03EZPq5NERADzhhSNRDFiwxwIYEa1RhiR+nQ98XmXM1o3r4c1271a4+fEEvBH
	e6Eb3lZjOeAR66BF2xiJYjLJVbgafnD17GgFwmijy2v9IWN+XACBaYrgicJxASQ3taM1sXTD03r
	oBmTUDFnMYhy8EiG2Qi2Vj/utE/WEJeryFv1xajZaw5hh5poEbfrmo23ni2CAW2D/88ThHFe0yj
	mreV53A0DhDvQ1oZAOsMSFbEU+Y=
X-Google-Smtp-Source: AGHT+IHaPOWbj4IKk3WIETHSMuwnIVbDhNKab5FuLki4GfOsVz/VNX97e+bH3umTbClvXEs98FN3ZAjMRZboc4uMevE=
X-Received: by 2002:a05:6402:4146:b0:645:cdc7:ed91 with SMTP id
 4fb4d7f45d1cf-645cdc7f149mr9290398a12.32.1764160209111; Wed, 26 Nov 2025
 04:30:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202511252132.2c621407-lkp@intel.com> <20251126-beerdigen-spanplatten-d86d4e9eaaa7@brauner>
In-Reply-To: <20251126-beerdigen-spanplatten-d86d4e9eaaa7@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 26 Nov 2025 13:29:57 +0100
X-Gm-Features: AWmQ_bkvhTI4kRU-eyKznRsjhfGkU3m129lEzY1Ff6OHXmBAZmCBZc3kKSyZVLY
Message-ID: <CAOQ4uxgHqKyaRfXAugnCP4sozgwiOGTGDYvx2A-XJdxfswo-Ug@mail.gmail.com>
Subject: Re: [linux-next:master] [VFS/nfsd/cachefiles/ovl] 7ab96df840: WARNING:at_fs/dcache.c:#umount_check
To: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, 
	Jeff Layton <jlayton@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:42=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Tue, Nov 25, 2025 at 09:48:18PM +0800, kernel test robot wrote:
> >
> > Hello,
> >
> > kernel test robot noticed "WARNING:at_fs/dcache.c:#umount_check" on:
> >
> > commit: 7ab96df840e60eb933abfe65fc5fe44e72f16dc0 ("VFS/nfsd/cachefiles/=
ovl: add start_creating() and end_creating()")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > [test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d6=
4f5]
>
> Neil, can you please take a look at this soon?
> I plan on sending the batch of PRs for this cycle on Friday.
>
> >
> > in testcase: filebench
> > version: filebench-x86_64-22620e6-1_20251009
> > with following parameters:
> >
> >       disk: 1SSD
> >       fs: ext4
> >       fs2: nfsv4
> >       test: ratelimcopyfiles.f
> >       cpufreq_governor: performance
> >

Test is copying to nfsv4 so that's the immediate suspect.
WARN_ON is in unmount of ext4, but I suspect that nfs
was loop mounted for the test.

FWIW, nfsd_proc_create() looks very suspicious.

nfsd_create_locked() does end_creating() internally (internal API change)
but nfsd_create_locked() still does end_creating() regardless.

Oliver,

Can you test this handwritten change or need a patch/branch for testing:

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 28f03a6a3cc38..35618122705db 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -407,6 +407,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
                /* File doesn't exist. Create it and set attrs */
                resp->status =3D nfsd_create_locked(rqstp, dirfhp, &attrs, =
type,
                                                  rdev, newfhp);
+               goto out_write;
        } else if (type =3D=3D S_IFREG) {
                dprintk("nfsd:   existing %s, valid=3D%x, size=3D%ld\n",
                        argp->name, attr->ia_valid, (long) attr->ia_size);


Thanks,
Amir.

> >
> >
> > config: x86_64-rhel-9.4
> > compiler: gcc-14
> > test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU =
@ 2.30GHz (Cascade Lake) with 176G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202511252132.2c621407-lkp@inte=
l.com
> >
> >
> > Unmount[  252.448780][T17295] ------------[ cut here ]------------
> > [  252.455068][T17295] WARNING: CPU: 114 PID: 17295 at fs/dcache.c:1590=
 umount_check (fs/dcache.c:1590 (discriminator 1) fs/dcache.c:1580 (discrim=
inator 1))
> > m - /opt/rootfs.[  252.540436][T17295] CPU: 114 UID: 0 PID: 17295 Comm:=
 umount Tainted: G S                  6.18.0-rc1-00004-g7ab96df840e6 #1 VOL=
UNTARY
> > [  252.553273][T17295] Tainted: [S]=3DCPU_OUT_OF_SPEC
> > [  252.558205][T17295] Hardware name: Intel Corporation ............/S9=
200WKBRD2, BIOS SE5C620.86B.0D.01.0552.060220191912 06/02/2019
> > [  252.558206][T17295] RIP: 0010:umount_check (fs/dcache.c:1590 (discri=
minator 1) fs/dcache.c:1580 (discriminator 1))
> > [  252.575407][T17295] Code: 8d 88 a0 03 00 00 48 8b 40 28 4c 8b 08 48 =
8b 46 30 48 85 c0 74 04 48 8b 50 40 51 48 c7 c7 88 3b ad 82 48 89 f1 e8 27 =
07 c0 ff <0f> 0b 58 31 c0 c3 cc cc cc cc 41 83 f8 01 75 bf eb aa 0f 1f 44 0=
0
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 8d 88 a0 03 00 00       lea    0x3a0(%rax),%ecx
> >    6: 48 8b 40 28             mov    0x28(%rax),%rax
> >    a: 4c 8b 08                mov    (%rax),%r9
> >    d: 48 8b 46 30             mov    0x30(%rsi),%rax
> >   11: 48 85 c0                test   %rax,%rax
> >   14: 74 04                   je     0x1a
> >   16: 48 8b 50 40             mov    0x40(%rax),%rdx
> >   1a: 51                      push   %rcx
> >   1b: 48 c7 c7 88 3b ad 82    mov    $0xffffffff82ad3b88,%rdi
> >   22: 48 89 f1                mov    %rsi,%rcx
> >   25: e8 27 07 c0 ff          call   0xffffffffffc00751
> >   2a:*        0f 0b                   ud2             <-- trapping inst=
ruction
> >   2c: 58                      pop    %rax
> >   2d: 31 c0                   xor    %eax,%eax
> >   2f: c3                      ret
> >   30: cc                      int3
> >   31: cc                      int3
> >   32: cc                      int3
> >   33: cc                      int3
> >   34: 41 83 f8 01             cmp    $0x1,%r8d
> >   38: 75 bf                   jne    0xfffffffffffffff9
> >   3a: eb aa                   jmp    0xffffffffffffffe6
> >   3c: 0f                      .byte 0xf
> >   3d: 1f                      (bad)
> >   3e: 44                      rex.R
> >       ...
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 0f 0b                   ud2
> >    2: 58                      pop    %rax
> >    3: 31 c0                   xor    %eax,%eax
> >    5: c3                      ret
> >    6: cc                      int3
> >    7: cc                      int3
> >    8: cc                      int3
> >    9: cc                      int3
> >    a: 41 83 f8 01             cmp    $0x1,%r8d
> >    e: 75 bf                   jne    0xffffffffffffffcf
> >   10: eb aa                   jmp    0xffffffffffffffbc
> >   12: 0f                      .byte 0xf
> >   13: 1f                      (bad)
> >   14: 44                      rex.R
> >       ...
> > [  252.575410][T17295] RSP: 0018:ffffc9003672bb88 EFLAGS: 00010282
> > [  252.601300][T17295] RAX: 0000000000000000 RBX: ffff88ac4c0c55c0 RCX:=
 0000000000000027
> > [  252.601301][T17295] RDX: ffff888c5009c1c8 RSI: 0000000000000001 RDI:=
 ffff888c5009c1c0
> > [  252.601303][T17295] RBP: ffff8881e925da40 R08: 0000000000000000 R09:=
 ffffc9003672b958
> > [  252.625337][T17295] R10: ffff88ac7fc33fa8 R11: 0000000000000003 R12:=
 ffffffff81748d50
> > [  252.625338][T17295] R13: ffff8881e925da40 R14: ffff88ac4c0c9200 R15:=
 ffff88ac4c0c9280
> > [  252.625339][T17295] FS:  00007ffff7bfb840(0000) GS:ffff888ccc272000(=
0000) knlGS:0000000000000000
> > [  252.625340][T17295] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [  252.625341][T17295] CR2: 00007ffff7ec97a0 CR3: 00000001ce11e005 CR4:=
 00000000007726f0
> > [  252.625342][T17295] PKRU: 55555554
> > [  252.625343][T17295] Call Trace:
> > [  252.625345][T17295]  <TASK>
> > [  252.625348][T17295]  d_walk (fs/dcache.c:1322)
> > [  252.625353][T17295]  shrink_dcache_for_umount (include/linux/spinloc=
k.h:351 fs/dcache.c:601 fs/dcache.c:1606 fs/dcache.c:1621)
> > [  252.625357][T17295]  generic_shutdown_super (fs/super.c:621)
> > [  252.689813][T17295]  kill_block_super (fs/super.c:1723)
> > [  252.689817][T17295] ext4_kill_sb (fs/ext4/super.c:7405) ext4
> > [  252.699584][T17295]  deactivate_locked_super (fs/super.c:434 fs/supe=
r.c:475)
> > Unmount[  252.704921][T17295]  cleanup_mnt (fs/namespace.c:242 fs/names=
pace.c:1328)
> > [  252.704926][T17295]  task_work_run (include/linux/sched.h:2092 kerne=
l/task_work.c:229)
> > - Legacy Locks D[  252.727385][T17295]  ? __cond_resched (kernel/sched/=
core.c:7477)
> > irectory /run/lo[  252.733357][T17295]  ? generic_fillattr (fs/stat.c:9=
9)
> > [  252.739669][T17295]  ? _copy_to_user (arch/x86/include/asm/uaccess_6=
4.h:126 arch/x86/include/asm/uaccess_64.h:147 include/linux/uaccess.h:197 l=
ib/usercopy.c:26)
> > [  252.744854][T17295]  ? cp_new_stat (fs/stat.c:506 (discriminator 1))
> > [  252.744857][T17295]  ? __do_sys_newfstatat (fs/stat.c:546 (discrimin=
ator 1))
> > [  252.744861][T17295]  ? do_syscall_64 (arch/x86/include/asm/jump_labe=
l.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tra=
cking.h:41 include/linux/irq-entry-common.h:261 include/linux/entry-common.=
h:212 arch/x86/entry/syscall_64.c:100)
> > [  252.759380][T17295]  ? clear_bhb_loop (arch/x86/entry/entry_64.S:154=
8)
> > [  252.764099][T17295]  ? clear_bhb_loop (arch/x86/entry/entry_64.S:154=
8)
> > [  252.764101][T17295]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/=
entry_64.S:130)
> > [  252.774744][T17295] RIP: 0033:0x7ffff7e54217
> > [  252.779199][T17295] Code: 0d 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 =
0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 =
00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 b1 5b 0d 00 f7 d8 64 89 02 b=
8
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 0d 00 f7 d8 64          or     $0x64d8f700,%eax
> >    5: 89 02                   mov    %eax,(%rdx)
> >    7: b8 ff ff ff ff          mov    $0xffffffff,%eax
> >    c: c3                      ret
> >    d: 66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
> >   13: 31 f6                   xor    %esi,%esi
> >   15: e9 09 00 00 00          jmp    0x23
> >   1a: 66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
> >   21: 00 00
> >   23: b8 a6 00 00 00          mov    $0xa6,%eax
> >   28: 0f 05                   syscall
> >   2a:*        48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax  =
       <-- trapping instruction
> >   30: 77 01                   ja     0x33
> >   32: c3                      ret
> >   33: 48 8b 15 b1 5b 0d 00    mov    0xd5bb1(%rip),%rdx        # 0xd5be=
b
> >   3a: f7 d8                   neg    %eax
> >   3c: 64 89 02                mov    %eax,%fs:(%rdx)
> >   3f: b8                      .byte 0xb8
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
> >    6: 77 01                   ja     0x9
> >    8: c3                      ret
> >    9: 48 8b 15 b1 5b 0d 00    mov    0xd5bb1(%rip),%rdx        # 0xd5bc=
1
> >   10: f7 d8                   neg    %eax
> >   12: 64 89 02                mov    %eax,%fs:(%rdx)
> >   15: b8                      .byte 0xb8
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20251125/202511252132.2c621407-=
lkp@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >

