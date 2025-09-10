Return-Path: <linux-fsdevel+bounces-60853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C860B5230F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B306A819F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E12F39C4;
	Wed, 10 Sep 2025 20:53:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050B7242D9D
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537608; cv=none; b=QPSOnHfIcDfGlj2eoeCFuZiemBAlnnZty3ATM4hS9JcfPvrDaJvYa6zcXU4kT9ByWdzEQ2dPMrGhYLvS5ZJC3fgUduBFBE6xxK7aIVYki2M72awQ/6yyfYAt8IMCnYkbkPyDFT5BLsl/xe0Vm96vk3CHaQpSUKqZ5n6ZW7eMK9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537608; c=relaxed/simple;
	bh=z+SSr5e4raDynlSrCzw4DbMZwm/elGSHp/acpNaX/IA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=EerWZ9nKVMUN2WHPGCajBtOy9k/gFS+L94N+ujP6KdwemOkySFe51I9OUMjPjtvUjvSS+zknr4AWtudh7mFbOq+JtnqbZhTd63ATib5GhQO+6Y+t/SUh1xX3aVOX/IrCk9oYOIqWD2BxC0SpeNKilyd8WP8LOq7P5K9pot8IOrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88c2fa17143so2417539f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 13:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757537605; x=1758142405;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORHDDrKhvA3/qUkPzDVcq1X/g8kCw2zy04ZymDlu2HE=;
        b=Dhb60zhkQXtzA/anAEQwzk0p3nLZOZ6mVwU1ucER1PUg4owbu89aMCE4AD2bUJeqOd
         hD/lCjyER9nalRds/KwyUs1z7CVq0XhnV3MEwU592vEXXeHy9kaJQijPvAqJ0GSN+3kB
         Ti1B1gAnWY+wFWRQwGUdDrgmN2SmY7O1W8zp0S852UbbXvU0NqsDwasbEXRWJl7Q330s
         V/zZwt56NDvObMyY5udtzLx9Jt9shJSJKH8UZqOq2ls4UqKMWAPQHVxEeo+HOGLtlbyf
         hXNtdU34Lpziv5zHiRrId+4C4DQ1L5s0pv8xC8/sjZ+X7gRAF3wyb+rmI8Gj4w0r57KB
         zuKg==
X-Forwarded-Encrypted: i=1; AJvYcCVIaFxutE1POHhBXzClzQiFWnTVxdh0GBq6fnshqs6JcqpDWEo7nUbk3e+STm89TWIw2Wu6t/wGiLTkso6t@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2zuDYE9NXXU9Hj28EeRYwSSDzqG7WafRNxK+uDc/ob4vPOcwH
	JyEK4WKIUHMMOnOyGjGZEgu0WWtAseca/M7VxdO8QJddPafu71JuAmTLk4nqKF6M8bNJtl/7J7d
	XqjxRYgtcfaVwd1FDCkyQan6kzoU/OmFajD9YiHVHRYxVPWhvB6c+2kxaRAA=
X-Google-Smtp-Source: AGHT+IELNcieJyO3PScSY3ls43ocO856dpwKju7gM2D1Vty+fwi/cTBoqQMfNRZ1V0PBBKdy5zAPf22QzDDN/RUdRFlpuS0plJbP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca46:0:b0:410:cae9:a07c with SMTP id
 e9e14a558f8ab-410cae9a261mr93638345ab.5.1757537605114; Wed, 10 Sep 2025
 13:53:25 -0700 (PDT)
Date: Wed, 10 Sep 2025 13:53:25 -0700
In-Reply-To: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c1e545.050a0220.3c6139.002b.GAE@google.com>
Subject: [syzbot ci] Re: ns: support file handles
From: syzbot ci <syzbot+cic2a3475eff9e1ea7@syzkaller.appspotmail.com>
To: amir73il@gmail.com, axboe@kernel.dk, brauner@kernel.org, 
	cgroups@vger.kernel.org, chuck.lever@oracle.com, cyphar@cyphar.com, 
	daan.j.demeyer@gmail.com, edumazet@google.com, hannes@cmpxchg.org, 
	horms@kernel.org, jack@suse.cz, jlayton@kernel.org, josef@toxicpanda.com, 
	kuba@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-nfs@vger.kernel.org, me@yhndnzj.com, mkoutny@suse.com, 
	mzxreary@0pointer.de, netdev@vger.kernel.org, pabeni@redhat.com, 
	tj@kernel.org, viro@zeniv.linux.org.uk, zbyszek@in.waw.pl
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] ns: support file handles
https://lore.kernel.org/all/20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org
* [PATCH 01/32] pidfs: validate extensible ioctls
* [PATCH 02/32] nsfs: validate extensible ioctls
* [PATCH 03/32] block: use extensible_ioctl_valid()
* [PATCH 04/32] ns: move to_ns_common() to ns_common.h
* [PATCH 05/32] nsfs: add nsfs.h header
* [PATCH 06/32] ns: uniformly initialize ns_common
* [PATCH 07/32] mnt: use ns_common_init()
* [PATCH 08/32] ipc: use ns_common_init()
* [PATCH 09/32] cgroup: use ns_common_init()
* [PATCH 10/32] pid: use ns_common_init()
* [PATCH 11/32] time: use ns_common_init()
* [PATCH 12/32] uts: use ns_common_init()
* [PATCH 13/32] user: use ns_common_init()
* [PATCH 14/32] net: use ns_common_init()
* [PATCH 15/32] ns: remove ns_alloc_inum()
* [PATCH 16/32] nstree: make iterator generic
* [PATCH 17/32] mnt: support iterator
* [PATCH 18/32] cgroup: support iterator
* [PATCH 19/32] ipc: support iterator
* [PATCH 20/32] net: support iterator
* [PATCH 21/32] pid: support iterator
* [PATCH 22/32] time: support iterator
* [PATCH 23/32] userns: support iterator
* [PATCH 24/32] uts: support iterator
* [PATCH 25/32] ns: add to_<type>_ns() to respective headers
* [PATCH 26/32] nsfs: add current_in_namespace()
* [PATCH 27/32] nsfs: support file handles
* [PATCH 28/32] nsfs: support exhaustive file handles
* [PATCH 29/32] nsfs: add missing id retrieval support
* [PATCH 30/32] tools: update nsfs.h uapi header
* [PATCH 31/32] selftests/namespaces: add identifier selftests
* [PATCH 32/32] selftests/namespaces: add file handle selftests

and found the following issue:
WARNING in copy_net_ns

Full report is available here:
https://ci.syzbot.org/series/bc3dfd83-98cc-488c-b046-f849c79a6a41

***

WARNING in copy_net_ns

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      deb105f49879dd50d595f7f55207d6e74dec34e6
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/a560fd28-b788-4442-a7c8-10c6240b4dbf/config
syz repro: https://ci.syzbot.org/findings/18e91b10-567e-4cae-a279-8a5f2f2cde80/syz_repro

------------[ cut here ]------------
ida_free called for id=1326 which is not allocated.
WARNING: CPU: 0 PID: 6146 at lib/idr.c:592 ida_free+0x280/0x310 lib/idr.c:592
Modules linked in:
CPU: 0 UID: 0 PID: 6146 Comm: syz.1.60 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:ida_free+0x280/0x310 lib/idr.c:592
Code: 00 00 00 00 fc ff df 48 8b 5c 24 10 48 8b 7c 24 40 48 89 de e8 d1 8a 0c 00 90 48 c7 c7 80 ee ba 8c 44 89 fe e8 11 87 12 f6 90 <0f> 0b 90 90 eb 34 e8 95 02 4f f6 49 bd 00 00 00 00 00 fc ff df eb
RSP: 0018:ffffc9000302fba0 EFLAGS: 00010246
RAX: c838d58ce4bb0000 RBX: 0000000000000a06 RCX: ffff88801eac0000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffc9000302fca0 R08: ffff88804b024293 R09: 1ffff11009604852
R10: dffffc0000000000 R11: ffffed1009604853 R12: 1ffff92000605f78
R13: dffffc0000000000 R14: ffff888026c1fd00 R15: 000000000000052e
FS:  00007f6d7aab16c0(0000) GS:ffff8880b8613000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000004000 CR3: 000000002726e000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 copy_net_ns+0x37a/0x510 net/core/net_namespace.c:593
 create_new_namespaces+0x3f3/0x720 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x11c/0x170 kernel/nsproxy.c:218
 ksys_unshare+0x4c8/0x8c0 kernel/fork.c:3127
 __do_sys_unshare kernel/fork.c:3198 [inline]
 __se_sys_unshare kernel/fork.c:3196 [inline]
 __x64_sys_unshare+0x38/0x50 kernel/fork.c:3196
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6d79b8eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6d7aab1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f6d79dd5fa0 RCX: 00007f6d79b8eba9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000062040200
RBP: 00007f6d79c11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6d79dd6038 R14: 00007f6d79dd5fa0 R15: 00007ffd5ab830f8
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

