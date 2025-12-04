Return-Path: <linux-fsdevel+bounces-70657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C2CA381C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 12:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED3E0304995D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 11:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AE533CE87;
	Thu,  4 Dec 2025 11:56:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8533ADB3
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764849366; cv=none; b=DuD7M2+tRaOp/Q7VkPunsYTKf02B7px2v5htOPZeGaKIQvzEWwv0xsr8bIAOCth2J878YhFmUsv2RQC9/FLkqyQI/2Y40B2NfUWcFdD6+Ypgm3QexzQwF+BAK/TxBBj3zI1hZA4oP6/QEYBKrLqvEEUpGJztRw8QBFeHif4Okto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764849366; c=relaxed/simple;
	bh=HuRV66mhwIK+ujuZkfALcvDiKj8dTdPI6TepPMED/WQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fmcTHLLWiQOZO7UBsVGtxH9V+sqDjuSz8tUssIo9xEZMhisVn4gS1eL8D53etdDfmx2gk1khodqOSZeRdaOalV6kGs0cyavy62zdfEtc6QYhW3IpR5MbcZgHyWqDHcLqX3NQZ2c0IRyBu+1enZfLyy58bqHPs2cDT0TAWY7L/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-450fd003480so1055200b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 03:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764849362; x=1765454162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0C/CCiyV8nJfaxNZGgm0t8nS5tX7x5fb2iYGpwFC0ok=;
        b=EHZ2q+Pf9JlXq8YOTz8PJKhHMwkTxzMD6oGdpXaMhHvxe6AUHMxLLF7QjaQKuuVxU8
         QyNahWJqXY+gXpDXcqhd7rAJeMRJ+pDGLjIGqr3oc1ybAkByQZeGxvY4voND5v7OP7WJ
         yReH9ywvYIl5Y/ybw4BgrBTucLyEaaoBA9BCVrHJ8RFxN8OX66uvGJkOB/l9uPpSOrn2
         ACKkDy14oxZRfHeJXFinp2fOsHIoD257hqPOzyjwUREnVby1TvpWIuqpX1Bif+7JRsgu
         op1hgCwqCPy0N/cjCtvBTLu8jrIsiYNwfk/vZpGUJZ4MfCTyVb8zNIVRyXn9YWUNEQun
         WWnA==
X-Forwarded-Encrypted: i=1; AJvYcCUAn/CaevLx1r66U6UhgR/WcrpW8zaGrlHJbjVD+Ms51v5+VHe308gpbNU9296dlRS8F100yw5fZ+yrZ+x7@vger.kernel.org
X-Gm-Message-State: AOJu0YwimuDAUFIxPQ7k4ceUzeY8SvkPAukAiR72PZiOJcJjLvhFXJjK
	VDVHSD5We4dnIcjjeFbZHzi8Bp7iuRcoKcyvQiwpsqj7EN/WN8tntRw4gL44qhaPYWMQX2otQuA
	bBqPftytXNs2aihHH6ingEogTjAD3OAHO3xwxalqIzV8wqSw5YfUo440hIO4=
X-Google-Smtp-Source: AGHT+IHNrzg0lUqRiTNM4AjSuYJZKlDaPkqo1TSL3pb5Fp9eZaSHERWKJcevEKtpN7MtVQ1/ESm3dKU8dQKpIyQ2UDqp0p3jYubj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2225:b0:441:8f74:fbf with SMTP id
 5614622812f47-45379eb6e74mr1479684b6e.60.1764849362313; Thu, 04 Dec 2025
 03:56:02 -0800 (PST)
Date: Thu, 04 Dec 2025 03:56:02 -0800
In-Reply-To: <y3ucyzxisq6hcrhynzyhmb7h4vpzkyuueqesw547cx5zmzrvl4@offzqo327t4w>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693176d2.a70a0220.d98e3.01ce.GAE@google.com>
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
From: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	mjguzik@gmail.com, ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in link_path_walk

VFS_BUG_ON_INODE(d_can_lookup(_dentry) && !S_ISDIR(_dentry->d_inode->i_mode)) encountered for inode ffff888074eca4f8
fs ocfs2 mode 100000 opflags 0x2 flags 0x20 state 0x0 count 2
------------[ cut here ]------------
kernel BUG at fs/namei.c:2542!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 7668 Comm: syz.0.211 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:link_path_walk+0x1d7f/0x1d90 fs/namei.c:2542
Code: e8 a6 16 ea fe 90 0f 0b e8 de 8c 83 ff 41 89 ef e9 d2 fc ff ff e8 d1 8c 83 ff 4c 89 ff 48 c7 c6 40 d6 79 8b e8 82 16 ea fe 90 <0f> 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc9000c5a78a0 EFLAGS: 00010282
RAX: 00000000000000b2 RBX: ffffc9000c5a7c20 RCX: 68650f632580b300
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888011640020 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bbae20 R12: 0000000000008000
R13: ffffc9000c5a7c28 R14: ffff888074f0a0b8 R15: ffff888074eca4f8
FS:  00007f56a8b4f6c0(0000) GS:ffff888125f3a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f56a73fdf98 CR3: 00000000742f6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 path_openat+0x2b3/0x3dd0 fs/namei.c:4799
 do_filp_open+0x1fa/0x410 fs/namei.c:4830
 do_sys_openat2+0x121/0x200 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_open fs/open.c:1444 [inline]
 __se_sys_open fs/open.c:1440 [inline]
 __x64_sys_open+0x11e/0x150 fs/open.c:1440
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f56a7d8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f56a8b4f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f56a7fe5fa0 RCX: 00007f56a7d8f749
RDX: 0000000000000000 RSI: 0000000000145142 RDI: 0000200000000240
RBP: 00007f56a7e13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f56a7fe6038 R14: 00007f56a7fe5fa0 R15: 00007ffd61dc1878
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:link_path_walk+0x1d7f/0x1d90 fs/namei.c:2542
Code: e8 a6 16 ea fe 90 0f 0b e8 de 8c 83 ff 41 89 ef e9 d2 fc ff ff e8 d1 8c 83 ff 4c 89 ff 48 c7 c6 40 d6 79 8b e8 82 16 ea fe 90 <0f> 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc9000c5a78a0 EFLAGS: 00010282
RAX: 00000000000000b2 RBX: ffffc9000c5a7c20 RCX: 68650f632580b300
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888011640020 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bbae20 R12: 0000000000008000
R13: ffffc9000c5a7c28 R14: ffff888074f0a0b8 R15: ffff888074eca4f8
FS:  00007f56a8b4f6c0(0000) GS:ffff888125f3a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f56a73fdf98 CR3: 00000000742f6000 CR4: 00000000003526f0


Tested on:

commit:         bc04acf4 Add linux-next specific files for 20251204
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=107bd01a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=d222f4b7129379c3d5bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1377401a580000


