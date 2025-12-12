Return-Path: <linux-fsdevel+bounces-71170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC23CB7732
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 01:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69B3E300253B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 00:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F5621CC60;
	Fri, 12 Dec 2025 00:25:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EB421773F
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765499127; cv=none; b=twSYksNPCQKAcALKrkylAd1UN7kPH4rB7LPSu1ksqV2fZBZBHuRF+0OzcUbBSvO8ghp4YbgyQyzPB6V59FKOfXRFe3TTu6WW47OHiWe8SUeME+a+dY/OXt2ZmZLjktlskFiGyYa8GaQdsWJaofJvfqtOe3quVzyBlaAPatU2E4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765499127; c=relaxed/simple;
	bh=8jUrUuw5gKi2s0Zl/IdHKAHAtaEFNHSf3/1sKyDndXU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dAGl235pYu7p/8f7YyBfW+AAT7xAVzW9vA5J6jmFHNCv94TToA+8fqqafbVlOwKsMtqBqs6D1Uz41blFcAt8lagsu9BE1kBmlI/oVZr8RQxWJhP1PP7aspRNWdzVvtjF41FrEb7JsSng41Dt1sBTYqgxgPraCinVgcNkyus0jFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-65b3208d4deso1116633eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 16:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765499125; x=1766103925;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/NrCdqDUZtACZsrvy+EiQLkTmBHiqI3EaCw4Sv1I0g=;
        b=XiYIxN+JETnif4eMbYSvW0HIIzb+mOF/Uoi3bemGN9IH9tC/JPUODoiqdBntW1+a8f
         vzq2/FbePqtZzNaKq0WQqF5PWdEH1JN2Xk9e5zz0Zq8BfhY1cp576QykplVHp/uJ86U5
         obqgGU8UfVHSC39vI32IFWSo+svmcOvmZAqXPjDlK2U/9yedGsy0pbFuq2a3tPZowWlW
         AzysLq7D2Q6EzsoXvHGk3IcPTHJJkF5THWxAkUaDZHtPStZSfOJ73BjsEuE9E4MpAQPJ
         Lrx3jf7z/L0dyQyUmPkyIE5LcvgecpDKlCujHDjBEbvHSYrZ5Ti7aIHxpzt9j2OMRRcX
         TZlw==
X-Forwarded-Encrypted: i=1; AJvYcCV9iwy7isQoAdw2GS1ZuZqpMcSlnxE9kZb/ASikPzHANT4ru+yDwweyV0SrAHh1Vxp9+RD9obGDW5OxTgJD@vger.kernel.org
X-Gm-Message-State: AOJu0YwTgZEcdevkOb1xB3Il1nD6G3x8R1VMn4yYI1273pVzVNjVw4ZO
	o/Uur4wS/JlQ2eSnStLQAvbF7wWKT3cRWEfpZdOvP25gPyoCwPl2UbXaL24C9CsnowZ4DKEmiFn
	CSQ1/MfdhPMiMOdUvpGzFDReNMKnPGgMQ+yILXsTHcSJIf7GDQb1rGittoro=
X-Google-Smtp-Source: AGHT+IE96IZQqt2rK1+9HkR+Ou2xxjyLstdmoZGNVd8+7uYY2fEtqwNOquuUPK1gB4Vk2Mh2EXmKXYoB8Y4oWDL4EL06ZGd+32wA
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2905:b0:659:9a49:8f74 with SMTP id
 006d021491bc7-65b45736683mr126458eaf.57.1765499125456; Thu, 11 Dec 2025
 16:25:25 -0800 (PST)
Date: Thu, 11 Dec 2025 16:25:25 -0800
In-Reply-To: <692fc776.a70a0220.2ea503.00cb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693b60f5.050a0220.4004e.04c5.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] WARNING in sched_mm_cid_fork
From: syzbot <syzbot+9ca2c6e6b098bf5ae60a@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d358e5254674 Merge tag 'for-6.19/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c0d1c2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de48dccdf203ea90
dashboard link: https://syzkaller.appspot.com/bug?extid=9ca2c6e6b098bf5ae60a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144621b4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124621b4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d358e525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3fa1d04c1a85/vmlinux-d358e525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a9b253146e36/bzImage-d358e525.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4a5df3575982/mount_1.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=11119592580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9ca2c6e6b098bf5ae60a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: kernel/sched/core.c:10569 at sched_mm_cid_fork+0x66/0xc30 kernel/sched/core.c:10569, CPU#0: kworker/u4:4/5674
Modules linked in:
CPU: 0 UID: 0 PID: 5674 Comm: kworker/u4:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:sched_mm_cid_fork+0x66/0xc30 kernel/sched/core.c:10569
Code: 4c 8b 3b 4d 85 ff 74 21 49 8d 9d d4 15 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 30 84 c0 0f 85 13 0a 00 00 31 c0 3b 03 70 04 90 <0f> 0b 90 49 8d 9f 00 01 00 00 49 8d bf c0 01 00 00 48 89 7c 24 20
RSP: 0000:ffffc900036cfbd8 EFLAGS: 00010246
RAX: 1ffff110067b79e3 RBX: ffff888033dbcf18 RCX: ffff888033dbc980
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888033dbc980
RBP: ffffc900036cfd68 R08: ffffffff8e295e83 R09: 1ffffffff1c52bd0
R10: dffffc0000000000 R11: fffffbfff1c52bd1 R12: ffff888033dbc980
R13: ffff888033dbc980 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88808d22f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6ad913e000 CR3: 0000000041a50000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 bprm_execve+0xd88/0x1400 fs/exec.c:1776
 kernel_execve+0x8f0/0x9f0 fs/exec.c:1919
 call_usermodehelper_exec_async+0x210/0x360 kernel/umh.c:109
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

