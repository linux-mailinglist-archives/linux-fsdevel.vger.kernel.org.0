Return-Path: <linux-fsdevel+bounces-77247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDIlKxd+kWkhjQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 09:04:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0947113E443
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 09:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D3DD3014138
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 08:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B5429E10C;
	Sun, 15 Feb 2026 08:04:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC322798E5
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771142672; cv=none; b=HCkwsXCHpqSA4bmSAhQ4RahAy+bio1kAf+ayrq2k/5PAu3wh7kWztM4QKbfTq6w5xYakSJfzhiZzIbr0Q+M9OdVilythtwqI3ZR5CQ7vvO1/YP+V1A7pcU0Dgwyl2XMQU+/AKNkn7VT2IO5W+KgX4CDQLMiGory9Z+PYQiMZ5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771142672; c=relaxed/simple;
	bh=Ipp85/hEloAu7h2ZRTWs7mim9brtp9CVIB07o8ccNMc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DIFq5gCJd+6b0GGtTd8c/dQL6LKdnqFlIfCeEOdxo57kDejB+S4/t8Wj2qt16X1hO8i9+u4Blwdygn4Dd9YvHwLCu1PASCE/wapNstq0B7miIvxkXJb/auSlyKZEfTBCEZ7+EkzMDIpRIywXZmOacDEgdquj6uRNi7H3T/zwewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6795b03ffdbso9181741eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 00:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771142670; x=1771747470;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fkt9PcjpWRNdmhtv/6vfZwPC/hjy3+sCKcFS5m6nEYU=;
        b=rI0pLn0oavQgw6sTxTynsPqGKlNHPyCBBp7H1TSoy/sox8wUCb2QnnUJvJ6mL6FeVc
         fh4Gf3OiFR/gNBPEFGj3V16bw2W9HTJihKyUN1+eYmsNS4y6rNgQUZI2xvVV16P8KxZo
         GE2mybf/Ug2jngfxkQNG8mlcoj5/4oH6I/EvLoE102dBtE43SZhUn9gPt4vlixsKL5FO
         rmKih9DahCcqOZVgBfcguhzxVz0d1VPz73c2NtVAtjGz7DnVLBrV6/ygblVh0aTtQDfV
         BZiPT2ijJuZD+ECO+nNvLW/79MhCjtI79wYl0309Yx6tW6ENcO/V9mFnA3QpaTYsiXVf
         RKdA==
X-Gm-Message-State: AOJu0Yw0g9fYaXLFEDGA1hEMLWusesUzYdi1KAQMa2A5LzLxgEM3WEyQ
	dCsYrLHmAUvP/JFW2PQU/V7cAXkVwXOpReKZsqZUbLDHGh5jexyMCI7uq8bbNypiHJ7c3T4FVd3
	kGXKvvgSmkAmi82wQr23yAqpXn2Vf9ogU2GWJSCH0q+An/rMKHNXPAZmxZcQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6ac8:b0:676:da74:842b with SMTP id
 006d021491bc7-67767484bdemr3291014eaf.28.1771142669774; Sun, 15 Feb 2026
 00:04:29 -0800 (PST)
Date: Sun, 15 Feb 2026 00:04:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69917e0d.050a0220.340abe.02e2.GAE@google.com>
Subject: [syzbot] [fuse?] KMSAN: uninit-value in fuse_dentry_revalidate (2)
From: syzbot <syzbot+fdebb2dc960aa56c600a@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=50148b563a4d5941];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77247-lists,linux-fsdevel=lfdr.de,fdebb2dc960aa56c600a];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,syzkaller.appspot.com:url,goo.gl:url,appspotmail.com:email,storage.googleapis.com:url]
X-Rspamd-Queue-Id: 0947113E443
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    770aaedb461a Merge tag 'bootconfig-v7.0' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158f7e5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50148b563a4d5941
dashboard link: https://syzkaller.appspot.com/bug?extid=fdebb2dc960aa56c600a
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138f7e5a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a5c15a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24ba89b61208/disk-770aaedb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b38352aa3489/vmlinux-770aaedb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c388a7a46371/bzImage-770aaedb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fdebb2dc960aa56c600a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in fuse_dentry_revalidate+0x150/0x13d0 fs/fuse/dir.c:394
 fuse_dentry_revalidate+0x150/0x13d0 fs/fuse/dir.c:394
 d_revalidate fs/namei.c:1030 [inline]
 lookup_open fs/namei.c:4405 [inline]
 open_last_lookups fs/namei.c:4583 [inline]
 path_openat+0x1614/0x64c0 fs/namei.c:4827
 do_file_open+0x2aa/0x680 fs/namei.c:4859
 do_sys_openat2+0x163/0x380 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x240/0x300 fs/open.c:1383
 x64_sys_call+0x2445/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4466 [inline]
 slab_alloc_node mm/slub.c:4788 [inline]
 kmem_cache_alloc_lru_noprof+0x382/0x1280 mm/slub.c:4807
 __d_alloc+0x55/0xa00 fs/dcache.c:1740
 d_alloc_parallel+0x99/0x2740 fs/dcache.c:2604
 lookup_open fs/namei.c:4398 [inline]
 open_last_lookups fs/namei.c:4583 [inline]
 path_openat+0x135f/0x64c0 fs/namei.c:4827
 do_file_open+0x2aa/0x680 fs/namei.c:4859
 do_sys_openat2+0x163/0x380 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x240/0x300 fs/open.c:1383
 x64_sys_call+0x2445/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6074 Comm: syz.0.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
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

