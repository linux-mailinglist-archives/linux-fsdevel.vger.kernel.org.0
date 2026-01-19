Return-Path: <linux-fsdevel+bounces-74554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7341D3BA11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CAE4302DB20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2092FB630;
	Mon, 19 Jan 2026 21:34:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF4270ED2
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768858474; cv=none; b=H/HzPL8kTYH+aioY9g4BP6B1KpIs86NGwE7+rEUG8fcwMMSunszFJu/G4KBI/Pz8q9VoNI1Vx85OcimEtqQmHnTNIMeCs4QJKq7rUWaRh3wy3K1/hULRsj53Z5CfYDW/G+yb5s8HVbdWTMCm97JzbbVYcpYzn5ymMlH6S6ROY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768858474; c=relaxed/simple;
	bh=mt2lAZM/yu19sb8v0KRLEnHyOH5eQqUsDlnw+RZRGaA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RKok7W/1/Keg8jGzbwN+6GDqNNIUZnCJDqO+5lxgcPsgRi7Flm96pSDtftluI2iAo3yhbG4Q/6iIDx5ZBqgtet1KdCWg8OcteTiAtdTOkpbDbx33NqS9hSM4R3gBOlYUy2tEQYw2VziUuMKuajxcQBZc0Kx3qP0FB30uZLw/KRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-45c8d5caf62so4763974b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 13:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768858472; x=1769463272;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Er3hXqbv6+T3+tQYj29F1jwAO08ziVFNqrkr+zDbkIU=;
        b=rNCZGjPx+ZOM/wdgwCKYBHL+noq6SnYTmOWBmX4o6vqbb1J/0hkQhfCIdLGTEFios4
         nWilY2d4jVEItsC0bMmEisCR4Z4PEq3oKtMhWRScEWTICX+g7KbloHcdHv8fyqjjsJGr
         hoc6r/424DakD8jzoFW2ymhs8LSgOxcvKg6PDj4KfXJ5MxIfauKc3h0eo9vB5IxPp+Dd
         UnxQTtzMnDkkUr6z9jVaAKBPRNxiIzOAbn94vCeK/dCgkWEPD0X3FW3TYEUU4RbXaX3x
         8ui3fIkeOU0KcW2rZTlBWrwkepPz0A0/w1wj+uJ6ELuNN/jYee1GSTZpLHOmIbKonEdb
         T1jA==
X-Forwarded-Encrypted: i=1; AJvYcCUbaCFQnpf18VuOVidXb6oLvx3RZuV8Tj5voaOti4q4w+JU9cKHMee0CqSPbf0sB02xM7UhLB1h9/2Q8fzI@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZZI8FvymBOh7t464KKCfz0rYMoYWT+i42to5HnotBLnJdP3Z
	LMWRCBzYRuiLrDPCM5TVJ6QrR4fyMZmFScP2liecVaxYrkW/qWXxWRA8BoWlkSFX15cRJfQbGcC
	8C4MsBxOaX+v7IuLTOPIDAR22Vb8wNac3Rj5+KuV5CmWe1hpWneV5Hd7jyR4=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1985:b0:65b:8574:2e86 with SMTP id
 006d021491bc7-6611796c1d3mr4842232eaf.31.1768858472137; Mon, 19 Jan 2026
 13:34:32 -0800 (PST)
Date: Mon, 19 Jan 2026 13:34:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696ea368.a70a0220.34546f.04b7.GAE@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_strcasecmp (2)
From: syzbot <syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    603c05a1639f Merge tag 'nfs-for-6.19-2' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178b339a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46b5f80a6e7aaa5c
dashboard link: https://syzkaller.appspot.com/bug?extid=d80abb5b890d39261e72
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157be39a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12625a3a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f5064e5f9c76/disk-603c05a1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c466bcf334e3/vmlinux-603c05a1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4e1318b36fb1/bzImage-603c05a1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a0364f040b52/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
=====================================================
BUG: KMSAN: uninit-value in case_fold fs/hfsplus/unicode.c:26 [inline]
BUG: KMSAN: uninit-value in hfsplus_strcasecmp+0x63a/0x980 fs/hfsplus/unicode.c:67
 case_fold fs/hfsplus/unicode.c:26 [inline]
 hfsplus_strcasecmp+0x63a/0x980 fs/hfsplus/unicode.c:67
 hfsplus_cat_case_cmp_key+0xb9/0x190 fs/hfsplus/catalog.c:26
 hfs_find_rec_by_key+0xae/0x240 fs/hfsplus/bfind.c:89
 __hfsplus_brec_find+0x274/0x840 fs/hfsplus/bfind.c:124
 hfsplus_brec_find+0x4ec/0xa10 fs/hfsplus/bfind.c:190
 hfsplus_find_cat+0x3b0/0x4f0 fs/hfsplus/catalog.c:220
 hfsplus_iget+0x815/0xc30 fs/hfsplus/super.c:96
 hfsplus_fill_super+0x1550/0x2580 fs/hfsplus/super.c:548
 get_tree_bdev_flags+0x6e6/0x920 fs/super.c:1691
 get_tree_bdev+0x38/0x50 fs/super.c:1714
 hfsplus_get_tree+0x35/0x40 fs/hfsplus/super.c:680
 vfs_get_tree+0xb3/0x5c0 fs/super.c:1751
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount+0x879/0x1700 fs/namespace.c:3712
 path_mount+0x749/0x1fb0 fs/namespace.c:4022
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount+0x6f7/0x7e0 fs/namespace.c:4201
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4201
 x64_sys_call+0x38cb/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd3/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 hfsplus_cat_build_key_uni fs/hfsplus/catalog.c:77 [inline]
 hfsplus_find_cat+0x356/0x4f0 fs/hfsplus/catalog.c:217
 hfsplus_iget+0x815/0xc30 fs/hfsplus/super.c:96
 hfsplus_fill_super+0x1550/0x2580 fs/hfsplus/super.c:548
 get_tree_bdev_flags+0x6e6/0x920 fs/super.c:1691
 get_tree_bdev+0x38/0x50 fs/super.c:1714
 hfsplus_get_tree+0x35/0x40 fs/hfsplus/super.c:680
 vfs_get_tree+0xb3/0x5c0 fs/super.c:1751
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount+0x879/0x1700 fs/namespace.c:3712
 path_mount+0x749/0x1fb0 fs/namespace.c:4022
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount+0x6f7/0x7e0 fs/namespace.c:4201
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4201
 x64_sys_call+0x38cb/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd3/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable tmp created at:
 hfsplus_find_cat+0x43/0x4f0 fs/hfsplus/catalog.c:197
 hfsplus_iget+0x815/0xc30 fs/hfsplus/super.c:96

CPU: 1 UID: 0 PID: 6037 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

