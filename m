Return-Path: <linux-fsdevel+bounces-76521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cz79LQBihWkZBAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 04:37:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AE0F9C96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 04:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB245300A31A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 03:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4AA3321B3;
	Fri,  6 Feb 2026 03:37:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59382701C4
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770349051; cv=none; b=XcpoTwpXu0po1dXNaU0+zm4cjffcsNCZksqsu7Jn+knMsiO2+IfNuepAn1gJ9VoAZjQyVkbACnbF9oam6yCigHw8cuu//thME13VKWK1jsPFVyNkZSYsom0cT6cDt3hKH9Onb9aSG2EBVC6MmhfqP1vD+rZnq84BzW4T3m5wI7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770349051; c=relaxed/simple;
	bh=lP7AHwLQGEuPvN8uqzqzr5g1HPkzOVrZpSim3Z63GqA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hHWmbC/JvCVu9TB556X3prWHcmWcVxvl9iM1nWO5xMId08S9iNKVhgxTq0WekwGVbXhejko4rS/Fymhb1GAp8VtxvzWvAPO5vtVFFSiI0aofvKdx2BsgvrSTRBLpRx/MM0R/gsAWlamGCdzH2xIDXNqSSirkb+gcS5WOy46hsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7d195fe3eb4so6913242a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 19:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770349050; x=1770953850;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95xTLcshfo8zJpBkBOaICZBlbfeD59W6ADSPHs4aGk8=;
        b=Xs4Em3TM43qtdGwV62rma4nN70OZGLxyPfJp8i8utA97f56unViHctih7/VEc+A+Pa
         p5JiYV2SO7/lQ38gXv093P2sDP9ucEYHROLXH3+oMsgKelUU9w/hwkEfqJlx5KzZwGVQ
         OZgqb3GUf3bcF5ftscz1SJEl8oY3YnFHT35droy8FncsmGmMssq85OLQlYVtRr3UcPTo
         hpxO7GqRL9q4EtcnkD3WOL4GNb+vZwpL548SRRaf5zV9JnVjbeQsjrm9i2vB3m2KeGx1
         jL36AoXbXAwtzUzEtZR1+UUNISLuUR+g5eiohxdmgTxadZSFfjy1eKkw5kG972XXZ/uz
         7KnA==
X-Gm-Message-State: AOJu0YxcxIVZ3AJaGsv+QI9E1DhM9r1akRAYAEhVt1i6Q+B/sXv+ZGqN
	zU9giDPGcfXIBaSYmMWKJlbo23OCqIe8G7w/4PXkPJMob657HuBQUmL+uoU8tNn6gLv6uwkXJf3
	OoRRkVeSEcm3LsKjIRvWrY2+dLcGTtrjg9HE2f4BoqbOXQwuPkz/TajomSvdn3Q==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee10:0:b0:664:8baa:fcda with SMTP id
 006d021491bc7-66d0d2fb048mr691886eaf.81.1770349049785; Thu, 05 Feb 2026
 19:37:29 -0800 (PST)
Date: Thu, 05 Feb 2026 19:37:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698561f9.a00a0220.34fa92.0022.GAE@google.com>
Subject: [syzbot] [fuse?] KMSAN: uninit-value in fuse_fileattr_get
From: syzbot <syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9682a42d8ec8b05c];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76521-lists,linux-fsdevel=lfdr.de,7c31755f2cea07838b0c];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email,storage.googleapis.com:url,goo.gl:url]
X-Rspamd-Queue-Id: 46AE0F9C96
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    18f7fcd5e69a Linux 6.19-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bafc5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9682a42d8ec8b05c
dashboard link: https://syzkaller.appspot.com/bug?extid=7c31755f2cea07838b0c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1329b322580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178a425a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c8e19a1c3a97/disk-18f7fcd5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ffdc9733836e/vmlinux-18f7fcd5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8cdf30f0d2d2/bzImage-18f7fcd5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in fuse_fileattr_get+0xeb4/0x1450 fs/fuse/ioctl.c:517
 fuse_fileattr_get+0xeb4/0x1450 fs/fuse/ioctl.c:517
 vfs_fileattr_get fs/file_attr.c:94 [inline]
 __do_sys_file_getattr fs/file_attr.c:416 [inline]
 __se_sys_file_getattr+0x6cb/0xbd0 fs/file_attr.c:372
 __x64_sys_file_getattr+0xe4/0x150 fs/file_attr.c:372
 x64_sys_call+0x17cd/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:469
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable fa.i created at:
 __do_sys_file_getattr fs/file_attr.c:380 [inline]
 __se_sys_file_getattr+0x8c/0xbd0 fs/file_attr.c:372
 __x64_sys_file_getattr+0xe4/0x150 fs/file_attr.c:372

CPU: 1 UID: 0 PID: 6065 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
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

