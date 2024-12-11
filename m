Return-Path: <linux-fsdevel+bounces-37111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295319EDA7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 23:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1B01888A59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AB81F236E;
	Wed, 11 Dec 2024 22:55:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A9E1DC9AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957727; cv=none; b=m5NOY7GoKXEnU2trdqUAqNkNAmKw9JTJPqmw17JRLAiIR6YkiC0W6wr++Mi7lBT9QmaI5Lw5BwMpC9svUEbVHWyZSiYugm2YNMzw+SNlDWz0HhjWqZlqUWwTj/Wfl1EwPVIlDwE5QKikUv7aX0Qzf3FkqZMDb23oJ15TMuV2SVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957727; c=relaxed/simple;
	bh=jc0W9O2uQ3OGTE/F6KtTKL+X+KlvTdfhU+I1mKDM9Zs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u4HE92xLGbEkf0y/H4B7ZRUTbu1K4cnvktaU/7UvgF9YOQHiLG0KK246k69Ilz/W0wWgX5S5V/VJh3H5a5V70MkufRY5GlYShLONiqwZKH6/nFCjeSdyDE4lxBtUfrMSBb/6GrYwnfhOE7RVMfP3XACTyXPorvEc6ylFonCrKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3abe7375ba6so571675ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 14:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733957724; x=1734562524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+nmTgoayWmHN6bLkUqXiLY2fbJkQQ8QGl6FHgAwAjU=;
        b=ZHo7Jra9wt4UHfyi1vOzN+CpP3CzyYLywoVpbpAxBZ7/WslPcPUXxC+dHR6rpQorn+
         slzsSAlO21uUausDgbjvKfXhwkTE0Nr+FgFJRK/uOLWBqc/2+NXbD/bZN2IKtwjs484o
         lDDgXVuZIcv3LEr3sJTcxC0rBIAsCQeGAfsfUDzx8hZP14vvcMToIobzw6F80ooMjcrc
         HQjo5TmQ8qdFJpvd9BWaS2hF49tPmaNOsxVB8cxE/XGR6xL0GKuLXsEAhnVqrqW7Dy9C
         4bYrnYfGbU0+RGin0iyIfbLuzMjQtJvwxkIsolsZ3tcpaZPkI4tCJyo6Vd9gJds7JCUE
         AT/w==
X-Forwarded-Encrypted: i=1; AJvYcCUSLwtEFovAczLgoic/w/LSmyLIMa9xRLVLACxYMEEt3BPiAxagUSplnfc3fLGqdqnm65LKPhQRooK/zquY@vger.kernel.org
X-Gm-Message-State: AOJu0YzSv7Z5F9FfzQ7z6dQqD1tdFgmWIZxU4+Gskd5fRsYGbZ461I4J
	wnhLlC2yDP6eiBUSGqpKsaEOZsElaviDTJL6mCq/+W+sSnVWoxxdKNXdNZuVlTIGcCFwWzEDjxv
	2Ch07Dv/aVkMJzaSKls/cnsLSDDnjOiIpHgV8U4xN8LxUcFaUbNPVkDQ=
X-Google-Smtp-Source: AGHT+IHT2VzCqWBfjtgCo++VQ7XRfXQRYilrdxGxi8V65j2LWvJMs012XL68Fm7IzuzTDOfvLrh2nbrOsf8Yz2Z7VFHrzwzHjmHa
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1566:b0:3a7:8720:9ea4 with SMTP id
 e9e14a558f8ab-3ac47597cecmr14073855ab.5.1733957723097; Wed, 11 Dec 2024
 14:55:23 -0800 (PST)
Date: Wed, 11 Dec 2024 14:55:23 -0800
In-Reply-To: <674f4e43.050a0220.17bd51.004e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675a185b.050a0220.17f54a.0049.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_get_dentry_cached
From: syzbot <syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f92f4749861b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144e7544580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df9504e360281ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=8f8fe64a30c50b289a18
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bfbb30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124e7544580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ca4977648e90/disk-f92f4749.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f743aedaf863/vmlinux-f92f4749.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d7aea41c35c/bzImage-f92f4749.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4e5e94b5fe8e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com

syz-executor248: attempt to access beyond end of device
loop0: rw=524288, sector=165, nr_sectors = 1 limit=64
syz-executor248: attempt to access beyond end of device
loop0: rw=524288, sector=166, nr_sectors = 1 limit=64
syz-executor248: attempt to access beyond end of device
loop0: rw=524288, sector=167, nr_sectors = 1 limit=64
syz-executor248: attempt to access beyond end of device
loop0: rw=0, sector=161, nr_sectors = 1 limit=64
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 UID: 0 PID: 5825 Comm: syz-executor248 Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:exfat_get_dentry_cached+0x11a/0x1b0 fs/exfat/dir.c:727
Code: df 48 89 da 48 c1 ea 03 80 3c 02 00 0f 85 9d 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 1b 48 8d 7b 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 61 49 8d 7d 18 48 8b 43 28 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc900032df378 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000009
RDX: 0000000000000005 RSI: ffffffff82705916 RDI: 0000000000000028
RBP: 0000000000000200 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000009 R11: 0000000000000003 R12: ffffc900032df4a0
R13: ffff8880350f6000 R14: 0000000000000009 R15: 0000000000000010
FS:  00007f9512b986c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ea395f6818 CR3: 000000007542e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 exfat_init_ext_entry+0x1b6/0x3b0 fs/exfat/dir.c:498
 exfat_add_entry+0x321/0x7a0 fs/exfat/namei.c:517
 exfat_create+0x1cf/0x5c0 fs/exfat/namei.c:565
 lookup_open.isra.0+0x1177/0x14c0 fs/namei.c:3649
 open_last_lookups fs/namei.c:3748 [inline]
 path_openat+0x904/0x2d60 fs/namei.c:3984
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_creat fs/open.c:1495 [inline]
 __se_sys_creat fs/open.c:1489 [inline]
 __x64_sys_creat+0xcd/0x120 fs/open.c:1489
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9512c02be9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9512b98168 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f9512c8c6d8 RCX: 00007f9512c02be9
RDX: 00007f9512bdc606 RSI: 0000000000000000 RDI: 0000000020000e00
RBP: 00007f9512c8c6d0 R08: 00007ffe09e1cab7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9512c8c6dc
R13: 000000000000006e R14: 00007ffe09e1c9d0 R15: 00007ffe09e1cab8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:exfat_get_dentry_cached+0x11a/0x1b0 fs/exfat/dir.c:727
Code: df 48 89 da 48 c1 ea 03 80 3c 02 00 0f 85 9d 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 1b 48 8d 7b 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 61 49 8d 7d 18 48 8b 43 28 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc900032df378 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000009
RDX: 0000000000000005 RSI: ffffffff82705916 RDI: 0000000000000028
RBP: 0000000000000200 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000009 R11: 0000000000000003 R12: ffffc900032df4a0
R13: ffff8880350f6000 R14: 0000000000000009 R15: 0000000000000010
FS:  00007f9512b986c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ea395f6818 CR3: 000000007542e000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	48 89 da             	mov    %rbx,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 9d 00 00 00    	jne    0xae
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df
  1b:	48 8b 1b             	mov    (%rbx),%rbx
  1e:	48 8d 7b 28          	lea    0x28(%rbx),%rdi
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	75 61                	jne    0x90
  2f:	49 8d 7d 18          	lea    0x18(%r13),%rdi
  33:	48 8b 43 28          	mov    0x28(%rbx),%rax
  37:	48                   	rex.W
  38:	ba 00 00 00 00       	mov    $0x0,%edx
  3d:	00 fc                	add    %bh,%ah


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

