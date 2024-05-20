Return-Path: <linux-fsdevel+bounces-19730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45DD8C97B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 03:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D222C1C21235
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 01:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6819F8F6E;
	Mon, 20 May 2024 01:52:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33E4A28
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716169948; cv=none; b=EMDFaq4S9He9ZeKOrYsxSefdKjAmaSmA6bQcP6PIaMhfbzAQXbPk+fQ8Es0N8PlWgYuBsiF1CedcOxnlzCDRf4Jryc0Un4lHi7gy6iQiLh7KXVlqOpLVRlBajdjKiYtGgai1Gt1FdgYooMTOtbMTSzWY1zcuzkaXF3tloWl17SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716169948; c=relaxed/simple;
	bh=HsQV4Ltggy6Aey7CF0suvofOohFBFlsZ5EqjOonqp6c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ces+zmMwmPJ6mYsKN1VCLxxQ4l5m+wAGipNxRW57WVF1fy6Gns4vQVzbhgiQR3mqI2guiAFY2ZhPzDtrxoGqrUnWEVDZnW/dR61MlD349eE2PAIsDv4a4uRBgvXdKyn7oHSAyf3AFJXrP8abyMkjwU3nNXBIQ7i5k1ed32Dqp5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7da52a99cbdso1243919939f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2024 18:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716169946; x=1716774746;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k++fI0WKokHitI27fX8ZAGJFInOOijXTOw3x+5jhqLg=;
        b=LUaSZS/maSHxorK4c33GSuOT97XIXWAJo9ZOqtlRs421VC6kWdjpvyjcsj3rUXUG/b
         dFCdsreMayNsKeAH5/FrnGXzG6gWDv74tXeMWghk+32FzEDyssvQrDbCVm73tkANrQRl
         4kyXqmdl/rovNLvjBvh6spJSaZXGC7BsU2KnDLdRc2NE256KpBJhMZ86sN9OkgXZGxOP
         m2UsANNMVfgHVCr7U667KLf4+ohrcmk+UKQMyGTUGNTAWJ+ooUn1Y78yF3NlN2rAMZqR
         LPW6iKEXPtKE/vaCRZ8uUE3AxMTPXpgSUY62N68LpG7S4rjBlqui2Z9SQKX70KgvH7Wf
         VDpg==
X-Forwarded-Encrypted: i=1; AJvYcCUWEMVeNVveo9ZSKLITo/skEvNy4LuYZ+YHp/HDqHM519B1zeZxVr6QfJ+ar8hpouohv5aoRKTkDRYU5fMt37ZaPy48OVjujthD92EPkQ==
X-Gm-Message-State: AOJu0YwU1NfNG6K6ulV1aDYSHAdFn/cD+dKQ5YdOM33VFR42rFvuqYhS
	zBBSDchSPJMSMYGc7gi7V6QBQ8CcmyyC12Oe1IHAF+ETx7AKraP1nEzh0NilfjaMioy7fDrAdPn
	d2xL2qwbrnKow6yN8IWcUv2cuMCbTMgvYk/3FVgRK4R1XryogNzPLhuM=
X-Google-Smtp-Source: AGHT+IHfDk7mUTbbI/3N8CUKQkG0KRS2hg0WW5QlxyVMk7+oinsyJd/sju8KYYQgN0slGoVobo/Iaff4pwYsacf+PjdZ+Kp67gC/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8725:b0:488:5e26:ffb5 with SMTP id
 8926c6da1cb9f-48958694bafmr1963185173.2.1716169945846; Sun, 19 May 2024
 18:52:25 -0700 (PDT)
Date: Sun, 19 May 2024 18:52:25 -0700
In-Reply-To: <000000000000f19a1406109eb5c5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff23a10618d8f3b5@google.com>
Subject: Re: [syzbot] [ext4?] general protection fault in __block_commit_write
From: syzbot <syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fda5695d692c Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1624be58980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95dc1de8407c7270
dashboard link: https://syzkaller.appspot.com/bug?extid=18df508cf00a0598d9a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bef634980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b68242980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/07f3214ff0d9/disk-fda5695d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70e2e2c864e8/vmlinux-fda5695d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b259942a16dc/Image-fda5695d.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/5853ffd99deb/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/8d78b07027fb/mount_5.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff800000000004
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000004] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 20274 Comm: syz-executor185 Not tainted 6.9.0-rc7-syzkaller-gfda5695d692c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __block_commit_write+0x64/0x2b0 fs/buffer.c:2167
lr : __block_commit_write+0x3c/0x2b0 fs/buffer.c:2160
sp : ffff8000a1957600
x29: ffff8000a1957610 x28: dfff800000000000 x27: ffff0000e30e34b0
x26: 0000000000000000 x25: dfff800000000000 x24: dfff800000000000
x23: fffffdffc397c9e0 x22: 0000000000000020 x21: 0000000000000020
x20: 0000000000000040 x19: fffffdffc397c9c0 x18: 1fffe000367bd196
x17: ffff80008eead000 x16: ffff80008ae89e3c x15: 00000000200000c0
x14: 1fffe0001cbe4e04 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000004 x7 : 0000000000000000 x6 : 0000000000000000
x5 : fffffdffc397c9c0 x4 : 0000000000000020 x3 : 0000000000000020
x2 : 0000000000000040 x1 : 0000000000000020 x0 : fffffdffc397c9c0
Call trace:
 __block_commit_write+0x64/0x2b0 fs/buffer.c:2167
 block_write_end+0xb4/0x104 fs/buffer.c:2253
 ext4_da_do_write_end fs/ext4/inode.c:2955 [inline]
 ext4_da_write_end+0x2c4/0xa40 fs/ext4/inode.c:3028
 generic_perform_write+0x394/0x588 mm/filemap.c:3985
 ext4_buffered_write_iter+0x2c0/0x4ec fs/ext4/file.c:299
 ext4_file_write_iter+0x188/0x1780
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x968/0xc3c fs/read_write.c:590
 ksys_write+0x15c/0x26c fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: 97f85911 f94002da 91008356 d343fec8 (38796908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97f85911 	bl	0xffffffffffe16444
   4:	f94002da 	ldr	x26, [x22]
   8:	91008356 	add	x22, x26, #0x20
   c:	d343fec8 	lsr	x8, x22, #3
* 10:	38796908 	ldrb	w8, [x8, x25] <-- trapping instruction


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

