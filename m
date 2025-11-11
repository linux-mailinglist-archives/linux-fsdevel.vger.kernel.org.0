Return-Path: <linux-fsdevel+bounces-67923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84503C4E05F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07F71885609
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7E4324702;
	Tue, 11 Nov 2025 13:03:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D343246F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866185; cv=none; b=ty5bF2uF6DsQzmunYaafot/TBmOyC79DbOOPYGVJRufoEwzR4gLqsV8bDBZoSSfkEodIOamJCIrzJm1/9PcdrFopL+DAxOHmSBJmK/ydtmUYJ43SqJvnGfkNpYl9mj1kMlh/fu3F/+Im2htbrzDS4ilYNQQ8OlgFIqWJIikYyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866185; c=relaxed/simple;
	bh=Vt1k5EQoPqh3Nrp0Bhb6ewVSEmyuqnxy7cXy4xH/yLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DAfOAwtvXe15f5YBJdAft5DPw+sG7erU2AxiE6OFMNwn9CRN3ZT8dg0j9dnGxeXGShl1Iypg6Olw06F1O7VnN7xi1dqCKaCvLH41CKujJm5PxCo5htnzPx1fKjfMAg3Ok/SJAqEo3cFvbDYCT6I1YIoTwbcapCmq2NekH12zSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43470d72247so1808935ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 05:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762866183; x=1763470983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGB/TAKZOcKtrhPxjpEL/9Rt1n53HiPGQxYzu5TTEyA=;
        b=knev6aein9wyfLYVCKsxEKKmFKojpLmBlgqVCNuio4Z6bVqH2YT26VgQda4fMfkjxU
         +jNi4BbQYQeb7jMbyK66rTa4cFISbZzEsRijSfG0vfI4wx4/5BzQX31BGeeZDQ3FSPQv
         Ls8A8skl0dlsPAij+y/OXU88t4ZbnfQ68qltUItQQhy7R4d3QKUGBrrNPuSTkzy8uYqr
         OUTz+YtSU5RkRMNwaJ5wmvy4wMn+IFbmDFFTYTMswU0lRh2ShnlP3c5KrtxJ+cAt9vKG
         FqGVWWotc5nbC1uMCxKkZ39SL3mUV9PlRsdxK/1dp1K1ofkEOVDQ0B7uYw/kIwCZc5GE
         hQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjTmv4H+v038LDd4biS/AMcRAAeetQekeTR1BuD674SDLsm8POBQbfJn6GNdz2AvEBRGo4ZM4O9cme3+aD@vger.kernel.org
X-Gm-Message-State: AOJu0YyHRoRAs+cJIIXOv5ossahA8t8R54DpxJO/BbfCu9WpPNUOCr1r
	4uf86MegkVWqVN0Jl+ZDc0ZLBPAgctbJOk3pENWt7H+aQvhkhLSwrFZETAH/MqOetGsB/Xi9+L0
	3lJTw3A+FjiYnolAZf8xcFJwW1Uyi6Z950NqFEzbmFz2T4xh0q6fHSapl9QI=
X-Google-Smtp-Source: AGHT+IEpTzA/3NqtQbsss3Bt9ogTGA39GU8M8pGLRnvPzS3lXufcYtJkf55mtmGcYxBah4LCmhDhp2qV1vWIUjAYrBjwalX4qAqr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2408:b0:433:29c3:c512 with SMTP id
 e9e14a558f8ab-43367e2d24emr143895815ab.21.1762866183264; Tue, 11 Nov 2025
 05:03:03 -0800 (PST)
Date: Tue, 11 Nov 2025 05:03:03 -0800
In-Reply-To: <20251111-covern-deklamieren-ee89b7b4e502@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69133407.a70a0220.22f260.0138.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bpf@vger.kernel.org, brauner@kernel.org, 
	bsegall@google.com, david@redhat.com, dietmar.eggemann@arm.com, jack@suse.cz, 
	jsavitz@redhat.com, juri.lelli@redhat.com, kartikey406@gmail.com, 
	kees@kernel.org, liam.howlett@oracle.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, mjguzik@gmail.com, 
	oleg@redhat.com, paul@paul-moore.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, vincent.guittot@linaro.org, 
	viro@zeniv.linux.org.uk, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __ns_ref_active_put

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6581 at kernel/nscommon.c:171 __ns_ref_active_put+0x3d7/0x450 kernel/nscommon.c:171
Modules linked in:
CPU: 0 UID: 0 PID: 6581 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:__ns_ref_active_put+0x3d7/0x450 kernel/nscommon.c:171
Code: 4d 8b 3e e9 1b fd ff ff e8 76 62 32 00 90 0f 0b 90 e9 29 fd ff ff e8 68 62 32 00 90 0f 0b 90 e9 59 fd ff ff e8 5a 62 32 00 90 <0f> 0b 90 e9 72 ff ff ff e8 4c 62 32 00 90 0f 0b 90 e9 64 ff ff ff
RSP: 0018:ffffc9000238fd68 EFLAGS: 00010293
RAX: ffffffff818e5946 RBX: 00000000ffffffff RCX: ffff8880302ebc80
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc9000238fe00 R08: ffff888078968c2b R09: 1ffff1100f12d185
R10: dffffc0000000000 R11: ffffed100f12d186 R12: dffffc0000000000
R13: 1ffff1100f12d184 R14: ffff888078968c20 R15: ffff888078968c28
FS:  00007efc0fd536c0(0000) GS:ffff888125cf3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33263fff CR3: 0000000030876000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nsproxy_ns_active_put+0x4a/0x200 fs/nsfs.c:701
 free_nsproxy kernel/nsproxy.c:80 [inline]
 put_nsset kernel/nsproxy.c:316 [inline]
 __do_sys_setns kernel/nsproxy.c:-1 [inline]
 __se_sys_setns+0x1349/0x1b60 kernel/nsproxy.c:534
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efc0ef90ef7
Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 34 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efc0fd52fd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000134
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007efc0ef90ef7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000c9
RBP: 00007efc0f011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efc0f1e6038 R14: 00007efc0f1e5fa0 R15: 00007fff5692b648
 </TASK>


Tested on:

commit:         cc719c88 nsproxy: fix free_nsproxy() and simplify crea..
git tree:       https://github.com/brauner/linux.git namespace-6.19
console output: https://syzkaller.appspot.com/x/log.txt?x=1613f17c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59952e73920025e4
dashboard link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

