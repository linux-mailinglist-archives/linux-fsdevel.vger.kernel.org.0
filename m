Return-Path: <linux-fsdevel+bounces-64938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160E7BF7210
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25475188D502
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B4E33C503;
	Tue, 21 Oct 2025 14:41:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75C033C516
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057707; cv=none; b=W4M8BREL0fWudZMyEoU37WsKatdovLG6dHI3GBaR6LleFy8ddrbZJie1VC6EtbavSaqZLHhBHJJkGB2rJPtWeDjovcg1PjblGnSaypjb2fDSy3OUvb/kaUZ6VCj6KDMyLgZFumGArw+XtwLUne00gcOlKGJDRQH574TNWgpyFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057707; c=relaxed/simple;
	bh=Xk82p3QMQ218l3t+5+rV+5DkhvLFvg+GAWSI/dQi70o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Xl2MuiNKwfIvG5SWFzjq+g7oQnoLrS55zH8BI3Z5k92w1LGD9wDnUgluQ8+z8pGCOkjAS6wGad9Zc90xtCaHCIzWVATC0sCfzGqpgShacEGw8S8eBLkC7RM8iLCRnbZGvefKgWMQ6aFvSnFYg9mbXqExedrkiz8eClUF9FvKWcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-429278a11f7so61232185ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 07:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761057704; x=1761662504;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nyXkjWC/ci1YXwgRcz9ZasDLILOvM2KJyStZKlc64A=;
        b=iF+C8OZYgmMcmNx01n539SoVnoxTv1vfFyeOV922844zCa22kMy9XITHEuzqS/J5dS
         UqjnB8a6GBrCICarK9/04sE2sKeKXk/kNDEd5w0QdbS6T9ftzQBJ8uy6K1Eg7kpeQYYo
         YTPe+c9eBpQcDOA3lf2f2O4ggqVUrAltjAQ4edbQz1foMOjlEhZYcURPvnNyx+A7Q/n+
         1RaG809dhDoM+GIJTgCheSykTG+BAPhqoE63comP0VexOlAclbnBmxMdv/hI5TIyMcav
         R9olqaKc/HRCWUE38CIqLIQBAjQE53F3IFxu+YnJtly5LdT2hyJ8tLN6CKo8tRL94+4L
         nDAA==
X-Forwarded-Encrypted: i=1; AJvYcCWcDJ7kKNJOV/b9K8opEO1Po0psk3UD/zCK+3yOv1DeJb4XKU/J2PkGyt/NJDEtpJo07NfMpAjQO9L7GyW4@vger.kernel.org
X-Gm-Message-State: AOJu0YyjHF/xGLr9+OkbU/eaKWfLGwdYpV+xMlP2yMRZk4Dy1jslElqc
	MSpvp2bffBRZTtO5VmdiyAaMnY2dMClH7cd1HvV6bRIqjyQ4eBcK/H3+XjySmy5DHbDCBPZFfkb
	z7ei8tplpasuckTafx9oV91awnL1vejo5tNNMnFPkZDZuQlpbclUrJGSWRv0=
X-Google-Smtp-Source: AGHT+IFB7JSh1jrcc84lwp+scGP8tt2pMbdrY49scmV75mR9oHYCvfnRmGuGOLsMGCf2cDZgm31FWVk2KIt/UjEYUCv1sp6O0Atc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd82:0:b0:426:39a:90f1 with SMTP id
 e9e14a558f8ab-430c527dc54mr238746205ab.18.1761057704018; Tue, 21 Oct 2025
 07:41:44 -0700 (PDT)
Date: Tue, 21 Oct 2025 07:41:44 -0700
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f79ba8.050a0220.346f24.001f.GAE@google.com>
Subject: [syzbot ci] Re: nstree: listns()
From: syzbot ci <syzbot+ci929e562404b4811b@syzkaller.appspotmail.com>
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

[v1] nstree: listns()
https://lore.kernel.org/all/20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org
* [PATCH RFC DRAFT 01/50] libfs: allow to specify s_d_flags
* [PATCH RFC DRAFT 02/50] nsfs: use inode_just_drop()
* [PATCH RFC DRAFT 03/50] nsfs: raise DCACHE_DONTCACHE explicitly
* [PATCH RFC DRAFT 04/50] pidfs: raise DCACHE_DONTCACHE explicitly
* [PATCH RFC DRAFT 05/50] nsfs: raise SB_I_NODEV and SB_I_NOEXEC
* [PATCH RFC DRAFT 06/50] nstree: simplify return
* [PATCH RFC DRAFT 07/50] ns: initialize ns_list_node for initial namespaces
* [PATCH RFC DRAFT 08/50] ns: add __ns_ref_read()
* [PATCH RFC DRAFT 09/50] ns: add active reference count
* [PATCH RFC DRAFT 10/50] ns: use anonymous struct to group list member
* [PATCH RFC DRAFT 11/50] nstree: introduce a unified tree
* [PATCH RFC DRAFT 12/50] nstree: allow lookup solely based on inode
* [PATCH RFC DRAFT 13/50] nstree: assign fixed ids to the initial namespaces
* [PATCH RFC DRAFT 14/50] ns: maintain list of owned namespaces
* [PATCH RFC DRAFT 15/50] nstree: add listns()
* [PATCH RFC DRAFT 16/50] arch: hookup listns() system call
* [PATCH RFC DRAFT 17/50] nsfs: update tools header
* [PATCH RFC DRAFT 18/50] selftests/filesystems: remove CLONE_NEWPIDNS from setup_userns() helper
* [PATCH RFC DRAFT 19/50] selftests/namespaces: first active reference count tests
* [PATCH RFC DRAFT 20/50] selftests/namespaces: second active reference count tests
* [PATCH RFC DRAFT 21/50] selftests/namespaces: third active reference count tests
* [PATCH RFC DRAFT 22/50] selftests/namespaces: fourth active reference count tests
* [PATCH RFC DRAFT 23/50] selftests/namespaces: fifth active reference count tests
* [PATCH RFC DRAFT 24/50] selftests/namespaces: sixth active reference count tests
* [PATCH RFC DRAFT 25/50] selftests/namespaces: seventh active reference count tests
* [PATCH RFC DRAFT 26/50] selftests/namespaces: eigth active reference count tests
* [PATCH RFC DRAFT 27/50] selftests/namespaces: ninth active reference count tests
* [PATCH RFC DRAFT 28/50] selftests/namespaces: tenth active reference count tests
* [PATCH RFC DRAFT 29/50] selftests/namespaces: eleventh active reference count tests
* [PATCH RFC DRAFT 30/50] selftests/namespaces: twelth active reference count tests
* [PATCH RFC DRAFT 31/50] selftests/namespaces: thirteenth active reference count tests
* [PATCH RFC DRAFT 32/50] selftests/namespaces: fourteenth active reference count tests
* [PATCH RFC DRAFT 33/50] selftests/namespaces: fifteenth active reference count tests
* [PATCH RFC DRAFT 34/50] selftests/namespaces: add listns() wrapper
* [PATCH RFC DRAFT 35/50] selftests/namespaces: first listns() test
* [PATCH RFC DRAFT 36/50] selftests/namespaces: second listns() test
* [PATCH RFC DRAFT 37/50] selftests/namespaces: third listns() test
* [PATCH RFC DRAFT 38/50] selftests/namespaces: fourth listns() test
* [PATCH RFC DRAFT 39/50] selftests/namespaces: fifth listns() test
* [PATCH RFC DRAFT 40/50] selftests/namespaces: sixth listns() test
* [PATCH RFC DRAFT 41/50] selftests/namespaces: seventh listns() test
* [PATCH RFC DRAFT 42/50] selftests/namespaces: ninth listns() test
* [PATCH RFC DRAFT 43/50] selftests/namespaces: ninth listns() test
* [PATCH RFC DRAFT 44/50] selftests/namespaces: first listns() permission test
* [PATCH RFC DRAFT 45/50] selftests/namespaces: second listns() permission test
* [PATCH RFC DRAFT 46/50] selftests/namespaces: third listns() permission test
* [PATCH RFC DRAFT 47/50] selftests/namespaces: fourth listns() permission test
* [PATCH RFC DRAFT 48/50] selftests/namespaces: fifth listns() permission test
* [PATCH RFC DRAFT 49/50] selftests/namespaces: sixth listns() permission test
* [PATCH RFC DRAFT 50/50] selftests/namespaces: seventh listns() permission test

and found the following issue:
WARNING in __ns_tree_add_raw

Full report is available here:
https://ci.syzbot.org/series/03ca38c3-876c-4231-aa06-ddb0bc8a30ad

***

WARNING in __ns_tree_add_raw

tree:      bpf
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf.git
base:      5fb750e8a9ae123b2034771b864b8a21dbef65cd
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/156cf21b-68f9-423c-807a-3dd094e6aed8/config

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5816 at kernel/nstree.c:189 __ns_tree_add_raw+0xa92/0xb30
Modules linked in:
CPU: 1 UID: 0 PID: 5816 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__ns_tree_add_raw+0xa92/0xb30
Code: 32 00 90 0f 0b 90 42 80 3c 23 00 0f 85 1e fc ff ff e9 21 fc ff ff e8 ed 78 32 00 90 0f 0b 90 e9 66 fc ff ff e8 df 78 32 00 90 <0f> 0b 90 e9 53 ff ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c ef
RSP: 0018:ffffc90003f27c30 EFLAGS: 00010293
RAX: ffffffff818e0051 RBX: 1ffffffff16db871 RCX: ffff88810ffe0000
RDX: 0000000000000000 RSI: ffff8881bbf5e9a8 RDI: ffff88816d0e6e00
RBP: ffff88816d0e6e00 R08: ffff88816d0e6e3f R09: 0000000000000000
R10: ffff88816d0e6e30 R11: ffffffff81b988c0 R12: dffffc0000000000
R13: ffff88816d0e6e40 R14: ffffffff8b6dc388 R15: ffff8881bbf5e9a8
FS:  000055558630f500(0000) GS:ffff8882a9d04000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5c3f03529c CR3: 000000010b5bc000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 copy_cgroup_ns+0x373/0x5f0
 create_new_namespaces+0x358/0x720
 unshare_nsproxy_namespaces+0x11c/0x170
 ksys_unshare+0x4c8/0x8c0
 __x64_sys_unshare+0x38/0x50
 do_syscall_64+0xfa/0xfa0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5c3ef907c7
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc62c39c88 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007ffc62c39c90 RCX: 00007f5c3ef907c7
RDX: 0000000000000000 RSI: 00007f5c3f03529c RDI: 0000000002000000
RBP: 00007ffc62c39d20 R08: 0000000000000000 R09: 00007f5c3fd1d6c0
R10: 0000000000044000 R11: 0000000000000246 R12: 00007ffc62c39d20
R13: 00007ffc62c39d28 R14: 0000000000000009 R15: 0000000000000000
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

