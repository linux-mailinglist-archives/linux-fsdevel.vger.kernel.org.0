Return-Path: <linux-fsdevel+bounces-77396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKNwNBTGlGnCHgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 20:48:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADC614FBA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 20:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DAE73023DAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6D1376BCC;
	Tue, 17 Feb 2026 19:48:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91D285CAD
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357713; cv=none; b=q51e/LlOpFvAgbxyxCetPelOOGNSTKwzpBTGIaCluMubzkEk3zxoDSR2fliTtW5e0NGQJ8eXNukcNno47T44ZoYpZ0RwqJ5sc1H/cr11u6V8n47BCwJECS506OJV3Q3DBRqs8FM+ZO5FnxJ3anuA9BVKb5CQPVU6N06ca9Y8F9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357713; c=relaxed/simple;
	bh=tIvuwwW/1mrfxLptV9/j1f45nxLmnN4c6mEo9abhh50=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Jt7xVbHk6Ah7/vD5yDwwQCwRV+IcvYB1cuw/8JE+1SHpe8dZcs8p5xECUSRw22yjHd+JNazRPAdIDft98sDoqI0M5MHYLHAssj0BwGVuFD5IqICsGK/nQDKde09yD8hgKdoFmn1ETsyM1Pv5agHs1/yi0seF2NfZtlIn5VQhBB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4639eb7bd4cso14126675b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 11:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771357711; x=1771962511;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqBynDemvxGGJGDs/yW5uaIraXzuuwQbmc0L/+wETCo=;
        b=LrKOERZUY6OxnqQzKHaeSw/AgY7mNZKiJKABaI+DhogZ1Rcrfq1NDH6CDbrSqMnab2
         mwdQJCpY8HqMIDRn+qD4AFKL4q/+4Nvq+LMynb2v4pEVpdacA8eXJ3IiUpPWuYqSFIGC
         u7iypP7RoBplBiGHo/+5oS3Zm89Hz3wVFzXb4nBlxomQ/7YWBTEAg0Ou86bCt6tLyBWh
         /HyoV+s712ZH2gtpIkFp3MYavj4i2zsd/d4W+95ozyB0fCcgYCR7NLXEbEVJmI1WZknr
         lrwLTbYEZyvQ3gQbDwEaKxyq90iHZf8VRGgK4DI3YywC/sWOqm4FgNgm4FYo/U6xoiJZ
         ZXjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaGL8LqM6XmeeWNdC+gNG5I50oxt01XR7kVtuLWaBUVKz5AL/a3xLMTvoLK06WgT+Lg7zwRiSzCSUEFZ7m@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi1OGrwMdm8KPP3OOct+jkImgWs3PUy8oiCwHcAP2rjFRFtlx3
	JRCLCSbY+Bo4kKh/G/mwA6Eu6KcM2EJKOcznxFhElo1C/M8KhiLohYXbKq00sZQnnp9ctokJFde
	qdD4UnOs+KDBuDB7KdrPMZ4eRxHeEIVpZGykmijiQyhjSJcWUQTJRorNoYQg=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f93:b0:45e:8495:21f3 with SMTP id
 5614622812f47-4639f1be199mr6675806b6e.40.1771357711109; Tue, 17 Feb 2026
 11:48:31 -0800 (PST)
Date: Tue, 17 Feb 2026 11:48:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6994c60f.a70a0220.2c38d7.0107.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in vfs_open_tree
From: syzbot <syzbot+d09c0eed6e4176ba5c86@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3696efcd0f17d527];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77396-lists,linux-fsdevel=lfdr.de,d09c0eed6e4176ba5c86];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,googlegroups.com:email,goo.gl:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,storage.googleapis.com:url]
X-Rspamd-Queue-Id: 4ADC614FBA2
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    fe9e3edb6a21 Add linux-next specific files for 20260217
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=153fb652580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3696efcd0f17d527
dashboard link: https://syzkaller.appspot.com/bug?extid=d09c0eed6e4176ba5c86
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1267095a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17036ffa580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3a3b845d3361/disk-fe9e3edb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/efa525980a65/vmlinux-fe9e3edb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5bf9ea774626/bzImage-fe9e3edb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d09c0eed6e4176ba5c86@syzkaller.appspotmail.com

------------[ cut here ]------------
old_ns_root->mnt_id_unique != 1
WARNING: fs/namespace.c:3112 at create_new_namespace fs/namespace.c:3112 [inline], CPU#0: syz.0.17/6017
WARNING: fs/namespace.c:3112 at open_new_namespace fs/namespace.c:3172 [inline], CPU#0: syz.0.17/6017
WARNING: fs/namespace.c:3112 at vfs_open_tree+0xf35/0xfb0 fs/namespace.c:3221, CPU#0: syz.0.17/6017
Modules linked in:
CPU: 0 UID: 0 PID: 6017 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:create_new_namespace fs/namespace.c:3112 [inline]
RIP: 0010:open_new_namespace fs/namespace.c:3172 [inline]
RIP: 0010:vfs_open_tree+0xf35/0xfb0 fs/namespace.c:3221
Code: 39 78 ff 49 bf 00 00 00 00 00 fc ff df e9 1e fb ff ff e8 9e 39 78 ff 4d 63 ee 4c 8b 64 24 08 e9 64 ff ff ff e8 8c 39 78 ff 90 <0f> 0b 90 e9 d1 f5 ff ff e8 7e 39 78 ff 90 0f 0b 90 e9 18 f6 ff ff
RSP: 0018:ffffc90004237d80 EFLAGS: 00010293
RAX: ffffffff824db904 RBX: 00000000800002b1 RCX: ffff888031f41e40
RDX: 0000000000000000 RSI: 00000000800002b1 RDI: 0000000000000001
RBP: ffffc90004237eb0 R08: ffffffff8e7fa2eb R09: 1ffffffff1cff45d
R10: dffffc0000000000 R11: fffffbfff1cff45e R12: ffff88807cae1340
R13: 0000000000009902 R14: ffff888033097100 R15: dffffc0000000000
FS:  000055559209d500(0000) GS:ffff888124fff000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7055417dac CR3: 000000002e056000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __do_sys_open_tree fs/namespace.c:3231 [inline]
 __se_sys_open_tree fs/namespace.c:3229 [inline]
 __x64_sys_open_tree+0x96/0x110 fs/namespace.c:3229
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f705519c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9b19c798 EFLAGS: 00000246 ORIG_RAX: 00000000000001ac
RAX: ffffffffffffffda RBX: 00007f7055415fa0 RCX: 00007f705519c629
RDX: 0000000000009902 RSI: 0000200000000640 RDI: ffffffffffffff9c
RBP: 00007f7055232b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7055415fac R14: 00007f7055415fa0 R15: 00007f7055415fa0
 </TASK>


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

