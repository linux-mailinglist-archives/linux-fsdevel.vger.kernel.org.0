Return-Path: <linux-fsdevel+bounces-18607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B24768BABBE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406541F22506
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F27152DEE;
	Fri,  3 May 2024 11:38:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895421509B2
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736330; cv=none; b=XY7Pus9nzkB+f5klhitL50y6K2ft5QO0srBltDIvmdTktqFa9HQBPLSBdBgga7rfaUacxjBA4aljD3q2Q9jApJZUkJlLYdQso1ymbRCcuhsKXhep+ocR0Vo2G4Y5xGOoBlP6RmunsMc1k4If0TpWUqgsKCsFmejZA3yfWbhC10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736330; c=relaxed/simple;
	bh=2YhKxh3OG6MTAwjZAphP2OhTLjKcyUM9UyqB4UpZq0g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oRfPbupbaIBmQJQpCp173Y5immBB46GuRSNQaHqoJhEQpWVpZ/z1mZq9f0BQoAeg/2jhzOyeEEpR/J+JmqyCGAkI8elMswmv2i7PGyHYqIv9Zv/JeT4ySOgqbA4cr61mKE4Qq+5S20h+cb0E52XKdekelRmDLbdteh5yZyusv68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dabc125bddso951450439f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 04:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714736328; x=1715341128;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSGzZ2Q94nDINSiwaf3tEOU+6Qd4BCLcgtdCZBuXrNM=;
        b=d6rkkDFFe7gG4zD1enP5oth1banwITq6GsvxP1iXAy9u3NsnCtWH0FfTcULayaZsIz
         8BgJxyLdxVEIXHgAuL08TnhnPLRyS8F88Ofma/iSS+Qda4EX6+eU0K8LDVOwsbiwE+/x
         qEMURgwel0hpZx6LzJLonjFXqmP3Fy4rbxibBr8/vmuHTbOIqcGuKnBFMq5i0yAjuOfS
         2gd+BZ72daOB06Ov+dQe3oXOkSKU5Dhe61b0whfubt2/sNWxQ296Z3Bubs50MK8D1psV
         yhtMRzuePXgemfWYCEnHosfyhP9rHAyK8FutolchcFPnGGuUU7Cp213+sVSrvbEw/GVn
         QplA==
X-Forwarded-Encrypted: i=1; AJvYcCX1fn2HdurvhVX2IG+uyDSTgJL4KIijcwQ731yuXEcJI8KSDvJJQuKvEUDVduTtTDn8JZ0AluGNRexRS/FPbfLfXea80/YpARLkrhUGpw==
X-Gm-Message-State: AOJu0Yx1m/xCNFEOKIW9GejFjWKAhy/tOmC4zs6AzYcdMZR5652dfwfp
	f9YhLayJvmJlG22+yAc0JY16S7maFdlOOSQ1t77B3as6KBiGiaX4QiOsCQ604H4puwf/pCW5OIx
	aN5Ucmnj/C1jUHMXXgFsiJWiKCLh1OH8/pD4NoG0I5jMj/0fFWkvh3iI=
X-Google-Smtp-Source: AGHT+IFn8BLlMYW+AzmzCdtrBn7J+L8l5HkYITOHl4gPrV5fo0xn/f716HUtvoXo4eV4wGHrdylnftuPa+AySPD3BypatPlxUu9T
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:31c5:b0:487:100b:9212 with SMTP id
 n5-20020a05663831c500b00487100b9212mr94631jav.3.1714736326346; Fri, 03 May
 2024 04:38:46 -0700 (PDT)
Date: Fri, 03 May 2024 04:38:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d99ed06178b29b5@google.com>
Subject: [syzbot] [bcachefs?] BUG: unable to handle kernel paging request in bch2_fs_btree_key_cache_exit
From: syzbot <syzbot+a35cdb62ec34d44fb062@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a71d2909427 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11889a4c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fca646cf17cc616b
dashboard link: https://syzkaller.appspot.com/bug?extid=a35cdb62ec34d44fb062
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c77d21fa1405/disk-6a71d290.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/429fcd369816/vmlinux-6a71d290.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3d8a4b85112/Image-6a71d290.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a35cdb62ec34d44fb062@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address ffff7000249ff210
KASAN: probably wild-memory-access in range [0xffff800124ff9080-0xffff800124ff9087]
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001ad5bd000
[ffff7000249ff210] pgd=0000000000000000, p4d=000000023e882003, pud=000000023e880003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 7242 Comm: syz-executor.4 Not tainted 6.9.0-rc4-syzkaller-g6a71d2909427 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 80401005 (Nzcv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : bch2_fs_btree_key_cache_exit+0x7ec/0xfcc fs/bcachefs/btree_key_cache.c:974
lr : bch2_fs_btree_key_cache_exit+0x78c/0xfcc fs/bcachefs/btree_key_cache.c:970
sp : ffff8000aa1d6e80
x29: ffff8000aa1d6f50 x28: 1fffe0001c790010 x27: ffff0000e3c844b0
x26: 1ffff0001543ade0 x25: dfff800000000000 x24: 1ffff0001168e5d4
x23: 0000000000000000 x22: ffff800124ff9080 x21: ffff8000aa1d6f00
x20: ffff80008ee81218 x19: dfff800000000000 x18: 1fffe000367b9596
x17: ffff80008ee7d000 x16: ffff8000802896e4 x15: 0000000000000001
x14: 1fffe0001c790898 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000040000 x10: 0000000000ff0100 x9 : 0000000000000003
x8 : 1ffff000249ff210 x7 : ffff80008275d4e8 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008275d4f8
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000008
Call trace:
 bch2_fs_btree_key_cache_exit+0x7ec/0xfcc fs/bcachefs/btree_key_cache.c:974
 __bch2_fs_free fs/bcachefs/super.c:562 [inline]
 bch2_fs_release+0x1e0/0x564 fs/bcachefs/super.c:609
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x2a8/0x41c lib/kobject.c:737
 bch2_fs_free+0x288/0x2f0 fs/bcachefs/super.c:674
 bch2_fs_alloc+0xe4c/0x1c60 fs/bcachefs/super.c:965
 bch2_fs_open+0x740/0xb64 fs/bcachefs/super.c:2080
 bch2_mount+0x558/0xe10 fs/bcachefs/fs.c:1900
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:662
 vfs_get_tree+0x90/0x288 fs/super.c:1779
 do_new_mount+0x278/0x900 fs/namespace.c:3352
 path_mount+0x590/0xe04 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3875
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: f90027e8 d343fec8 11000d29 f9002be8 (38f36908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f90027e8 	str	x8, [sp, #72]
   4:	d343fec8 	lsr	x8, x22, #3
   8:	11000d29 	add	w9, w9, #0x3
   c:	f9002be8 	str	x8, [sp, #80]
* 10:	38f36908 	ldrsb	w8, [x8, x19] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

