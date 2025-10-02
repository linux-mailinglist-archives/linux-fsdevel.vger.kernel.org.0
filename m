Return-Path: <linux-fsdevel+bounces-63323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045FEBB507A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 21:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8AD165E15
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 19:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23D2882D0;
	Thu,  2 Oct 2025 19:42:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9996128726E
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759434150; cv=none; b=OsvKSbLRnRXc5v/CDhKug51SDjzDeUfvibTrOkQ/usZxHJfowQpgnVUbROPisbWrceuCVQKJ5wHBI7KwqsFWknNzmbppK+vUVy+OAtwNIkJmswQrpWMCJSTuuLKxQWoFg1M3NKpNKN7AEfF0lMrayMOGBqs2Gp8uHV1hGxCBDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759434150; c=relaxed/simple;
	bh=3Dp6vEI+NZmOP+OmAZzPl19dhORww3b+5ZehyD+d1y0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eTscShU5oeuGicfTa047F1c43/LRDZEYq+/GA2kmYKnq8/o/jkl3G8mjZbkCoWf7NplmeQ7iuEZ/zpgv7vg+ZP3nGFjoeF2bWi6xvJnhv0uU56EtIP5iaIHj+jAsc1F41fsiO/VMiQ4Pk6vJb2JKxMANKJajek5hjWMvex893Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-42d8a33a27aso35356365ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 12:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759434147; x=1760038947;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHWoufPOT2ZPXNRc5DoYz+FwJd3fX1cS0hwyHgiBJhE=;
        b=MpN5ecKdgsR7OjyOPxJLAHfYxlisYJu4XEo7M1AJu49+xFKXBrQjC+kyT3XomGbTr7
         ptNTXlvxGoIsALzByaDDd+oTxtudmZTynedI7/zMhVhlFiTG53FYtF5c3YIoOVPch/he
         f1cYn2eMqLXSjNvkkP6tWchE3VfmDCN03XBt6p1owf7dtQMwtjueCHeHhHIP7nm7EcNq
         FJ3tTPDHNgULlTwjN6jQ9VA95kBMztgp6XEoCz25NkpdRgMC1MmwWio5u0NKcK82pKtn
         1L0GC87YBLLjFnboJzFKUprSdEoBtA5W84barQsfn8fJuQDNvlXYXPVfPO+orwLIIgg+
         Fd+g==
X-Forwarded-Encrypted: i=1; AJvYcCWnqBjJCjLRL7lMvJDel2j7Gyo6FSxDPgWAOIw/rR7bY+mYvpgwwTsSjYKh12rP/lc1PsBu3Ba+o6S8f9jI@vger.kernel.org
X-Gm-Message-State: AOJu0YwXufHN9emiDZxis6nhAXp0znNj8C7mCzBzVdt42zFC0rHXeMfb
	tfTBkrfaUMTumxRXIY5KxpaDIo4v/Zt4vxQZPfbEYs3pGVHZE7Xqv+Yic1I9fc3l0LsG6c6Fpy0
	nF5KN5HUsW76h2ukdo7UzBjslyRnSYk8NBQTEmVFxcPbQ56X9XXvTyZNKh7E=
X-Google-Smtp-Source: AGHT+IEU/OOOMA49KmfXt1XRj8L46i3dX/8quLElMh47ODydo8OUZNrWsPpf6M7lZE1c/RoGQ7sTiG8ceohhIa5t+PXrLgW2CxEE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b41:b0:42d:7dea:1e09 with SMTP id
 e9e14a558f8ab-42e7ad6ea2fmr6404525ab.21.1759434147612; Thu, 02 Oct 2025
 12:42:27 -0700 (PDT)
Date: Thu, 02 Oct 2025 12:42:27 -0700
In-Reply-To: <68c6c3b1.050a0220.2ff435.0382.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ded5a3.050a0220.1696c6.0036.GAE@google.com>
Subject: Re: [syzbot] [fs?] kernel BUG in qlist_free_all (2)
From: syzbot <syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com>
To: bp@alien8.de, brauner@kernel.org, dave.hansen@linux.intel.com, 
	hpa@zytor.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7f7072574127 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1234b092580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b78ebc06b51acd7e
dashboard link: https://syzkaller.appspot.com/bug?extid=8715dd783e9b0bef43b1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bc1092580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176bfd04580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/70468cf24114/disk-7f707257.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8126ac85fc8f/vmlinux-7f707257.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b72e383dd9d/bzImage-7f707257.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 5927 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__phys_addr+0x173/0x180 arch/x86/mm/physaddr.c:28
Code: e8 72 22 49 00 48 c7 c7 90 ce 21 8d 48 89 de 4c 89 f2 e8 b0 03 39 03 e9 4d ff ff ff e8 56 22 49 00 90 0f 0b e8 4e 22 49 00 90 <0f> 0b e8 46 22 49 00 90 0f 0b 0f 1f 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003fbfcd8 EFLAGS: 00010293
RAX: ffffffff81740d22 RBX: 0000607fffd49468 RCX: ffff8880256c1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffe8ffffd49468 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1d6b7e7 R12: ffffea0000000000
R13: 0000000000000000 R14: 000000000000002e R15: 0000000000000001
FS:  000055558ba17500(0000) GS:ffff888127122000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc7f61af40 CR3: 00000000350ca000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 virt_to_folio include/linux/mm.h:1180 [inline]
 virt_to_slab mm/slab.h:187 [inline]
 qlink_to_cache mm/kasan/quarantine.c:131 [inline]
 qlist_free_all+0x39/0x140 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_noprof+0x114/0x2d0 mm/slub.c:4247
 getname_flags+0xb8/0x540 fs/namei.c:146
 user_path_at+0x24/0x60 fs/namei.c:3214
 ksys_umount fs/namespace.c:2055 [inline]
 __do_sys_umount fs/namespace.c:2063 [inline]
 __se_sys_umount fs/namespace.c:2061 [inline]
 __x64_sys_umount+0xee/0x160 fs/namespace.c:2061
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f62cb4c01f7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffc7f61a098 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 00007f62cb541d7d RCX: 00007f62cb4c01f7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffc7f61b1e0
RBP: 00007ffc7f61b1cc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc7f61b1e0
R13: 00007f62cb541d7d R14: 0000000000022677 R15: 00007ffc7f61b220
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0x173/0x180 arch/x86/mm/physaddr.c:28
Code: e8 72 22 49 00 48 c7 c7 90 ce 21 8d 48 89 de 4c 89 f2 e8 b0 03 39 03 e9 4d ff ff ff e8 56 22 49 00 90 0f 0b e8 4e 22 49 00 90 <0f> 0b e8 46 22 49 00 90 0f 0b 0f 1f 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003fbfcd8 EFLAGS: 00010293
RAX: ffffffff81740d22 RBX: 0000607fffd49468 RCX: ffff8880256c1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffe8ffffd49468 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1d6b7e7 R12: ffffea0000000000
R13: 0000000000000000 R14: 000000000000002e R15: 0000000000000001
FS:  000055558ba17500(0000) GS:ffff888127122000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc7f61af40 CR3: 00000000350ca000 CR4: 00000000003526f0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

