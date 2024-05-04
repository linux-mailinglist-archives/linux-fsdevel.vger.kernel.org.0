Return-Path: <linux-fsdevel+bounces-18719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F118BBA63
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 11:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6E01F222DA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A1D1799B;
	Sat,  4 May 2024 09:55:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DE17550
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 May 2024 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714816524; cv=none; b=Bhr+e67YS/KzV9UXqsaJ0gW0pnxQuL0LHi7+2pK3Mj9ysph/qeQB4iCk/6EATHiV7zo6FrIyST8FR9QddbczCpIBJjCepowc9OUZfGH3tlBXwGwUxYFM8hqhPjYDkvFJk2eMuNWcxsKsOu313VjPZWlWcRo1YmaG/b8vORXmdME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714816524; c=relaxed/simple;
	bh=cW7OACxtfs1qddU/4aLJTGIMsX5ozeF6aKLExD6bMRU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K+zBY7ZTlLNbBYTy2xHT02uRRFaIj/GQO0twD49CBRgiX1U8RXSpYVKppmM3ZtFtv9aPHVdKUfUzIzkg62ZUoe7BQIM/1uQmfgZbX6pytCnjRzGVgWSiZVG1P+N1iioo74Qgi8c3zDT+M0fRjG3L8iwBeHSajzfmlTAV9eU0uyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ddf0219685so56004039f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 02:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714816522; x=1715421322;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJOaWMEoqpk+8ScF+/qMX9N+1BGZMwIv53Xitcmi4MU=;
        b=fyZ+/c8IYcnjUriLtUY/BRoRJEB9cuyfXsP7mIeDDpBfc+PRQSJB2SLOslb8TvFfYk
         bHACSMbk7bIM9A+F69GIyodhvx62pXaUpsH6l7UbzNvmjmMyc6DlaKBSEKkSo3ljChZW
         dCrnAyjNvdJN2l5rP9JOvA9k8bvgsGkAkGSK6j4zAfNKZIteTkhlFDmE8ozJjErRDasF
         7rvReh6ZbK0YCt+h8VARYnf/FklNupqVYvEKIhBQkYt2t38hZjedhapvTVzm4vlamvUx
         bQKMgqlti1P80gtExRlvRcZeLmGfRylxSmqNfr6s9w8pKWTJwWkLkHLRX85qQu10GLaQ
         RHBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhxFRpDAr8TQloDYvcR+kltG7ENN2u2xXJJ+xB3u8orKn+YfCIou3M+G52WZslDp+IqNGY2qx5Qq/ptYqHwP1QmgprN+alAW3AUy6jHg==
X-Gm-Message-State: AOJu0YyO1KQXm5i1oFKbH073/SX2GTUYLQeHSuL58EQth2SOC9BYRA0m
	tEc1JjtwA2PQDA5ckFU8zFc/nvQFp+0EDiBAm13Q9425Jpe9eQtpeRUA/qi/QsSaSRX6Sg7UCa8
	EFFBUQgW7anFjO/ItmB97p5AHUqiY+o1ytVmbsNzynrquBZzlARArNGE=
X-Google-Smtp-Source: AGHT+IEz+D6Qex1NA0StL/fBe1wyM5usF5Gu21Nh5V88IwYc7lO04xoWKDoD3Dfid5taUZgEkUVLmxzNsriMdBl64z0hzly4sCpS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:868d:b0:487:5a5d:b756 with SMTP id
 iv13-20020a056638868d00b004875a5db756mr227670jab.4.1714816522169; Sat, 04 May
 2024 02:55:22 -0700 (PDT)
Date: Sat, 04 May 2024 02:55:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8be8b06179dd553@google.com>
Subject: [syzbot] [bcachefs?] general protection fault in check_init_srcu_struct
From: syzbot <syzbot+747508948da55ff287c2@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d25a941ea50 Merge tag 'block-6.9-20240503' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175e897f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45d8db3acdc1ccc6
dashboard link: https://syzkaller.appspot.com/bug?extid=747508948da55ff287c2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-3d25a941.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49d9f26b0beb/vmlinux-3d25a941.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2c424c14fff/bzImage-3d25a941.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+747508948da55ff287c2@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000031: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000188-0x000000000000018f]
CPU: 1 PID: 110 Comm: kswapd0 Not tainted 6.9.0-rc6-syzkaller-00227-g3d25a941ea50 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:check_init_srcu_struct+0x44/0x170 kernel/rcu/srcutree.c:408
Code: 53 48 89 fb 80 3c 02 00 0f 85 fe 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 38 48 8d bd 88 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ce 00 00 00 48 8b 85 88 01 00 00 a8 03 75 0b 5b
RSP: 0018:ffffc90001ef7568 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888026f84240 RCX: ffffffff83ecf098
RDX: 0000000000000031 RSI: 0000000000000000 RDI: 0000000000000188
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888026f84278
R13: ffff888064c22630 R14: 0000000000000000 R15: ffff888026f80000
FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562dfa8c9e28 CR3: 000000006730a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 srcu_gp_start_if_needed+0x80/0xf00 kernel/rcu/srcutree.c:1221
 bkey_cached_free fs/bcachefs/btree_key_cache.c:90 [inline]
 bch2_btree_key_cache_scan+0xae0/0x1740 fs/bcachefs/btree_key_cache.c:893
 do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
 shrink_slab+0x18a/0x1310 mm/shrinker.c:662
 shrink_one+0x493/0x7c0 mm/vmscan.c:4774
 shrink_many mm/vmscan.c:4835 [inline]
 lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4935
 shrink_node mm/vmscan.c:5894 [inline]
 kswapd_shrink_node mm/vmscan.c:6704 [inline]
 balance_pgdat+0x10d1/0x1a10 mm/vmscan.c:6895
 kswapd+0x5ea/0xbf0 mm/vmscan.c:7164
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:check_init_srcu_struct+0x44/0x170 kernel/rcu/srcutree.c:408
Code: 53 48 89 fb 80 3c 02 00 0f 85 fe 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 38 48 8d bd 88 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ce 00 00 00 48 8b 85 88 01 00 00 a8 03 75 0b 5b
RSP: 0018:ffffc90001ef7568 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888026f84240 RCX: ffffffff83ecf098
RDX: 0000000000000031 RSI: 0000000000000000 RDI: 0000000000000188
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888026f84278
R13: ffff888064c22630 R14: 0000000000000000 R15: ffff888026f80000
FS:  0000000000000000(0000) GS:ffff88802c200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffed628afd8 CR3: 000000000d57a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	53                   	push   %rbx
   1:	48 89 fb             	mov    %rdi,%rbx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 fe 00 00 00    	jne    0x10c
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	48 8b 6b 38          	mov    0x38(%rbx),%rbp
  1c:	48 8d bd 88 01 00 00 	lea    0x188(%rbp),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 ce 00 00 00    	jne    0x102
  34:	48 8b 85 88 01 00 00 	mov    0x188(%rbp),%rax
  3b:	a8 03                	test   $0x3,%al
  3d:	75 0b                	jne    0x4a
  3f:	5b                   	pop    %rbx


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

