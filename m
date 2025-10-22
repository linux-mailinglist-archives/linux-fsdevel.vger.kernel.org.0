Return-Path: <linux-fsdevel+bounces-65203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DB6BFDFD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 21:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F9094F1FD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 19:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85EA2F1FEC;
	Wed, 22 Oct 2025 19:16:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0BD221F0A
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160573; cv=none; b=X0a4jGBTFUcoK4lBVeLcPzJXwJEif+UgfUapow2MPXgGIYfkJqAxvEOkHQG0W19rj2Qf2boTN8g2vJ8lAQgf2k45+t6eI7evq3Pw4yQoLNJZI021DgaOaXPP9HjwmV6CdbecZxawU5quQVYZJ8om1HtTwrxWFlkNYdP8fSqgV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160573; c=relaxed/simple;
	bh=jTqzqpq0wKiEGFhz2E0f2SrvJaKKx2gYXx+fetZYG/I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=r/5SXnYtEgrnNQV88gGIIEg5z+ppowTN/RbhXZ/qgYYnnHKnHws3aZo1/EGez9Rnywm4figoDG2xfOqGOR2+miljCw5k9qD8Mgg7kIEf2fIpwqjO938CUqzv6icTL3eWodrxtv7sGLFxBgWO88gOA9KCqTxkH9G0EY9LZ+VBfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e7ece2ff4so1710279339f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 12:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761160570; x=1761765370;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVAwk4TZwAsOUy7yFniWKauZ87Pvr8R3p3UyVOapIqY=;
        b=QhX/mrXQbSiqEe4MZwzChgKBDkxjyqqmipM3BHyAwsYNOZeKW+gBi56ikhhkQBh6Y+
         /7s7T3fe0i2Q7W3Q/ga63CYnpq/socXBGCxueV3wVb8zaREv1p79/ySqwm1jev7YV58p
         d/8N1LM83eIh2/7/eN4ehNXDkLkMtxdoBAloCBv5Zw0PcLbYQI82r6Lc8EKNAtNqaMG+
         xrAAXKiJCNer+Gg6jaf9+632OgIfh0M66hSegdiu4tAJ+qFsh0nVN2yRuaNiTToqmrRW
         3G1ud/ZOnav9xh0U8aYb1BjZgksu4i2B2HSo0gox4YHSYqZ843tGKW/3EzCidUru6jLP
         uEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqzuawed461oRvLo1I29R83Cu0i2u1c7cnN+AoRRve6btlsdEMeXf/NT6QCrlDmNAzKbuJmSdEW2ATwWOW@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYMhF0M/96TXUOL51R4LgTV1XGT29uKtrF6N7HqGJHfid8WTA
	K0Ffw2Ps6DJzuPZKYvh/1i6OkfbKt2p+kMFdqrcqRGfE2gpprINUlVpr3uSviu1H1hchF5kdkqR
	IkCPGZXcR9Bam0zZkiwmpIO78N0Vwr/ZGvaElf2lPKSqSCF37N7RsDVGvGW4=
X-Google-Smtp-Source: AGHT+IE9YMgRXbsiBihlZmXvuOwlYJ4oAY1aAdGjqEgMOZ45S4fxNHwYERqLkPKagaAfa1OpMchm7B1RZCBA6JqTCf4avvHGfRRz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c05:b0:940:f0a7:30d7 with SMTP id
 ca18e2360f4ac-940f0a7354emr996339639f.15.1761160570591; Wed, 22 Oct 2025
 12:16:10 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:16:10 -0700
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f92d7a.a70a0220.3bf6c6.0023.GAE@google.com>
Subject: [syzbot ci] Re: nstree: listns()
From: syzbot ci <syzbot+cia016abba7fbbfb27@syzkaller.appspotmail.com>
To: amir73il@gmail.com, arnd@arndb.de, bpf@vger.kernel.org, brauner@kernel.org, 
	cgroups@vger.kernel.org, cyphar@cyphar.com, daan.j.demeyer@gmail.com, 
	edumazet@google.com, hannes@cmpxchg.org, jack@suse.cz, jannh@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, me@yhndnzj.com, 
	mzxreary@0pointer.de, netdev@vger.kernel.org, tglx@linutronix.de, 
	tj@kernel.org, viro@zeniv.linux.org.uk, zbyszek@in.waw.pl
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] nstree: listns()
https://lore.kernel.org/all/20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org
* [PATCH v2 01/63] libfs: allow to specify s_d_flags
* [PATCH v2 02/63] nsfs: use inode_just_drop()
* [PATCH v2 03/63] nsfs: raise DCACHE_DONTCACHE explicitly
* [PATCH v2 04/63] pidfs: raise DCACHE_DONTCACHE explicitly
* [PATCH v2 05/63] nsfs: raise SB_I_NODEV and SB_I_NOEXEC
* [PATCH v2 06/63] cgroup: add cgroup namespace to tree after owner is set
* [PATCH v2 07/63] nstree: simplify return
* [PATCH v2 08/63] ns: initialize ns_list_node for initial namespaces
* [PATCH v2 09/63] ns: add __ns_ref_read()
* [PATCH v2 10/63] ns: add active reference count
* [PATCH v2 11/63] ns: use anonymous struct to group list member
* [PATCH v2 12/63] nstree: introduce a unified tree
* [PATCH v2 13/63] nstree: allow lookup solely based on inode
* [PATCH v2 14/63] nstree: assign fixed ids to the initial namespaces
* [PATCH v2 15/63] ns: maintain list of owned namespaces
* [PATCH v2 16/63] nstree: add listns()
* [PATCH v2 17/63] arch: hookup listns() system call
* [PATCH v2 18/63] nsfs: update tools header
* [PATCH v2 19/63] selftests/filesystems: remove CLONE_NEWPIDNS from setup_userns() helper
* [PATCH v2 20/63] selftests/namespaces: first active reference count tests
* [PATCH v2 21/63] selftests/namespaces: second active reference count tests
* [PATCH v2 22/63] selftests/namespaces: third active reference count tests
* [PATCH v2 23/63] selftests/namespaces: fourth active reference count tests
* [PATCH v2 24/63] selftests/namespaces: fifth active reference count tests
* [PATCH v2 25/63] selftests/namespaces: sixth active reference count tests
* [PATCH v2 26/63] selftests/namespaces: seventh active reference count tests
* [PATCH v2 27/63] selftests/namespaces: eigth active reference count tests
* [PATCH v2 28/63] selftests/namespaces: ninth active reference count tests
* [PATCH v2 29/63] selftests/namespaces: tenth active reference count tests
* [PATCH v2 30/63] selftests/namespaces: eleventh active reference count tests
* [PATCH v2 31/63] selftests/namespaces: twelth active reference count tests
* [PATCH v2 32/63] selftests/namespaces: thirteenth active reference count tests
* [PATCH v2 33/63] selftests/namespaces: fourteenth active reference count tests
* [PATCH v2 34/63] selftests/namespaces: fifteenth active reference count tests
* [PATCH v2 35/63] selftests/namespaces: add listns() wrapper
* [PATCH v2 36/63] selftests/namespaces: first listns() test
* [PATCH v2 37/63] selftests/namespaces: second listns() test
* [PATCH v2 38/63] selftests/namespaces: third listns() test
* [PATCH v2 39/63] selftests/namespaces: fourth listns() test
* [PATCH v2 40/63] selftests/namespaces: fifth listns() test
* [PATCH v2 41/63] selftests/namespaces: sixth listns() test
* [PATCH v2 42/63] selftests/namespaces: seventh listns() test
* [PATCH v2 43/63] selftests/namespaces: ninth listns() test
* [PATCH v2 44/63] selftests/namespaces: ninth listns() test
* [PATCH v2 45/63] selftests/namespaces: first listns() permission test
* [PATCH v2 46/63] selftests/namespaces: second listns() permission test
* [PATCH v2 47/63] selftests/namespaces: third listns() permission test
* [PATCH v2 48/63] selftests/namespaces: fourth listns() permission test
* [PATCH v2 49/63] selftests/namespaces: fifth listns() permission test
* [PATCH v2 50/63] selftests/namespaces: sixth listns() permission test
* [PATCH v2 51/63] selftests/namespaces: seventh listns() permission test
* [PATCH v2 52/63] selftests/namespaces: first inactive namespace resurrection test
* [PATCH v2 53/63] selftests/namespaces: second inactive namespace resurrection test
* [PATCH v2 54/63] selftests/namespaces: third inactive namespace resurrection test
* [PATCH v2 55/63] selftests/namespaces: fourth inactive namespace resurrection test
* [PATCH v2 56/63] selftests/namespaces: fifth inactive namespace resurrection test
* [PATCH v2 57/63] selftests/namespaces: sixth inactive namespace resurrection test
* [PATCH v2 58/63] selftests/namespaces: seventh inactive namespace resurrection test
* [PATCH v2 59/63] selftests/namespaces: eigth inactive namespace resurrection test
* [PATCH v2 60/63] selftests/namespaces: ninth inactive namespace resurrection test
* [PATCH v2 61/63] selftests/namespaces: tenth inactive namespace resurrection test
* [PATCH v2 62/63] selftests/namespaces: eleventh inactive namespace resurrection test
* [PATCH v2 63/63] selftests/namespaces: twelth inactive namespace resurrection test

and found the following issue:
general protection fault in copy_creds

Full report is available here:
https://ci.syzbot.org/series/edb88bd4-fe2f-4399-a44b-69d30faa57fb

***

general protection fault in copy_creds

tree:      bpf
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf.git
base:      5fb750e8a9ae123b2034771b864b8a21dbef65cd
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/b6fa4981-93e1-4b9c-a4b4-a1be1c33d835/config

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
CPU: 1 UID: 0 PID: 5952 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:copy_creds+0x473/0xd10
Code: 6a 8b e8 a0 76 0f 00 48 c7 c7 e0 cd 13 8e 48 89 de e8 81 5c 0f 00 e8 6c 01 19 00 ba 01 00 00 00 4c 89 f7 31 f6 e8 6d 99 00 00 <41> 80 7c 24 12 00 74 0a bf 90 00 00 00 e8 eb bc 97 00 4c 8b 34 25
RSP: 0018:ffffc900045d7938 EFLAGS: 00010286
RAX: 0000000000000131 RBX: ffffffff818e8499 RCX: ffff88810d1ad700
RDX: 0000000000000000 RSI: 7fffffffffffffff RDI: 0000000000000131
RBP: 0000000000000001 R08: ffffffff8dfef75f R09: 1ffffffff1bfdeeb
R10: dffffc0000000000 R11: fffffbfff1bfdeec R12: dffffc0000000000
R13: 0000000000010000 R14: ffffffff8dfef6c0 R15: 1ffff110216064bd
FS:  000055558d65c500(0000) GS:ffff8882a9d02000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd1e15c36f0 CR3: 000000011b786000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 copy_process+0x964/0x3c00
 kernel_clone+0x21e/0x840
 __se_sys_clone3+0x256/0x2d0
 do_syscall_64+0xfa/0xfa0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd1e15c3709
Code: d6 08 00 48 8d 3d bc d6 08 00 e8 02 29 f6 ff 66 90 b8 ea ff ff ff 48 85 ff 74 2c 48 85 d2 74 27 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85 c0 7c 18 74 01 c3 31 ed 48 83 e4 f0 4c 89 c7 ff d2 48 89 c7
RSP: 002b:00007fff0ae99118 EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007fd1e1545b10 RCX: 00007fd1e15c3709
RDX: 00007fd1e1545b10 RSI: 0000000000000058 RDI: 00007fff0ae99160
RBP: 00007fd1e13ff6c0 R08: 00007fd1e13ff6c0 R09: 00007fff0ae99247
R10: 0000000000000008 R11: 0000000000000202 R12: ffffffffffffffa8
R13: 0000000000000009 R14: 00007fff0ae99160 R15: 00007fff0ae99248
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:copy_creds+0x473/0xd10
Code: 6a 8b e8 a0 76 0f 00 48 c7 c7 e0 cd 13 8e 48 89 de e8 81 5c 0f 00 e8 6c 01 19 00 ba 01 00 00 00 4c 89 f7 31 f6 e8 6d 99 00 00 <41> 80 7c 24 12 00 74 0a bf 90 00 00 00 e8 eb bc 97 00 4c 8b 34 25
RSP: 0018:ffffc900045d7938 EFLAGS: 00010286
RAX: 0000000000000131 RBX: ffffffff818e8499 RCX: ffff88810d1ad700
RDX: 0000000000000000 RSI: 7fffffffffffffff RDI: 0000000000000131
RBP: 0000000000000001 R08: ffffffff8dfef75f R09: 1ffffffff1bfdeeb
R10: dffffc0000000000 R11: fffffbfff1bfdeec R12: dffffc0000000000
R13: 0000000000010000 R14: ffffffff8dfef6c0 R15: 1ffff110216064bd
FS:  000055558d65c500(0000) GS:ffff8882a9d02000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fed5f717d60 CR3: 000000011b786000 CR4: 00000000000006f0


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

