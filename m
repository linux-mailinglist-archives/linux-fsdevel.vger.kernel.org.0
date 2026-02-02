Return-Path: <linux-fsdevel+bounces-76078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBMDB2DogGleCAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 19:09:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 885B6CFEFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 19:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B0823043032
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B4738BF74;
	Mon,  2 Feb 2026 18:05:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E238BF64
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055531; cv=none; b=N2gDf0BZBSk0GEzKcMcVwB6NdfZEZndDyQ314+FCF7YfguhMOP8k81QwvG8PqHCo4kxUCN0lkAzb6/ygzdgDL1390KZwIlZ95YJ43w38oVaQZgYPnSQhBy5+eqPDPnYlZflSvGT2vfqquctShGoZVBoUKzp0N6fjceTOZRevad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055531; c=relaxed/simple;
	bh=pGX447dP/kFz8kz84koXOJ2/fnkIBeoenbCZ3+X4X9o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s0c0UxXZBmM0z+qs/Ysq2Sgo+ZwFb+l8fdajd1tlfXhrOyL4L1lyfdLZ2EHQJ0GWffP11zSpWPPs0FuAou6nl2j0Q05ltF2Po/b/zfOXSF6tF9ZKp2BQzj/jyltLyYzUgdgLjMnOr3qnJbQHyvTshCbIQT4+warWqRLupncIsrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-45c8d5caf62so9183739b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 10:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055528; x=1770660328;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTr9+EynYv4FeyVlmNp2C92imZ52otdcDv9Jige4oVQ=;
        b=OQqyONZfouIPrZ9zl+7CK7XLeoVI4TcoTo3GfM3gitnf8bIaAxQD7im6SzP8WC147y
         W5B9hmVRd8fGoEOsl+ee5Vt4TEbEKNUGs9uvhYULmIjsIA/RZmyvEIgf7o59Y357jAx3
         I6JRGUmzaYUgo99WtNgEcaXaj5jLjVChPSIn+i4ShCO39g9Ith/7yu7zTQlX2yctygQy
         dQkC9stsobcFoGfkJLdGjnE/Voe1538i+Dw+aIpyLBi1StOWIbWNGSsLTG3XV7HJGnKq
         x/N4GXFsWjBBlEqjh7asbgNdH3n6nus8hbirXzBfxI4BLtF/dYKT9YRBia2a81z1Y2Va
         Jdzg==
X-Forwarded-Encrypted: i=1; AJvYcCXmUXpJWPMqi4sXYwRhZflRHCud0Xrw+T02BGo0RNGPNaj462rxOPfWehf0i+iX7FBCMwh8Wsqw9q9kD4gu@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc5041pLb/mv/HR/nJ7w41BgBtsfT+728qL9cGTPgvNNa56qk8
	zefi+lf46ocd2xH//XpAoK31/aogLUvs9q3/nOGeLsJ8zdYKgUY5eqOwVzzLEfYNPVnEz1iNQeS
	YkRG0GCZfBbjwrlPOsY3WnljKKTEd1ZXehVshsvViBPd0wGfYq/cMwQg973c=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4dfb:b0:662:f244:3530 with SMTP id
 006d021491bc7-6630f004232mr5547317eaf.17.1770055528543; Mon, 02 Feb 2026
 10:05:28 -0800 (PST)
Date: Mon, 02 Feb 2026 10:05:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6980e768.050a0220.16b13.00a8.GAE@google.com>
Subject: [syzbot] [hfs?] INFO: task hung in worker_thread (6)
From: syzbot <syzbot+fa1cc3e4b001b79309ec@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=1b94612779ae7173];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76078-lists,linux-fsdevel=lfdr.de,fa1cc3e4b001b79309ec];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,goo.gl:url]
X-Rspamd-Queue-Id: 885B6CFEFF
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    33a647c659ff Add linux-next specific files for 20260129
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15aa1644580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b94612779ae7173
dashboard link: https://syzkaller.appspot.com/bug?extid=fa1cc3e4b001b79309ec
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cc1c52580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17849588580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d0ce0a8fecd/disk-33a647c6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4369620c4390/vmlinux-33a647c6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18ae695e8dfc/bzImage-33a647c6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/20bb3c39107f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa1cc3e4b001b79309ec@syzkaller.appspotmail.com

INFO: task kworker/u8:5:78 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:5    state:D stack:23136 pid:78    tgid:78    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x1539/0x5080 kernel/sched/core.c:6907
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0xb46/0x1140 kernel/workqueue.c:3443
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
1 lock held by khungtaskd/30:
 #0: 
ffffffff8e7601a0
 (
){....}-{1:3}
ffff8880206a0148
 (
(wq_completion)writeback
){+.+.}-{0:0}
, at: process_one_work+0x855/0x15a0 kernel/workqueue.c:3254
, at: super_trylock_shared+0x20/0xf0 fs/super.c:565
, at: hfsplus_find_init+0x168/0x2d0 fs/hfsplus/bfind.c:28
4 locks held by kworker/u8:3/49:
 #0: 
ffff8880206a0148
 (
(wq_completion)writeback
){+.+.}-{0:0}
, at: process_one_work+0x855/0x15a0 kernel/workqueue.c:3254
 #1: 
ffffc90000ba7c40
 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x87c/0x15a0 kernel/workqueue.c:3255
 #2: ffff88802b4f00e0 (&type->s_umount_key#55){.+.+}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:565
 #3: ffff88802b4f20b0 (&tree->tree_lock){+.+.}-{4:4}, at: hfsplus_find_init+0x168/0x2d0 fs/hfsplus/bfind.c:28
4 locks held by kworker/u8:5/78:
 #0: ffff8880206a0148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x855/0x15a0 kernel/workqueue.c:3254
 #1: ffffc900025cfc40 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x87c/0x15a0 kernel/workqueue.c:3255
 #2: ffff8880348a80e0 (&type->s_umount_key#55){.+.+}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:565
 #3: ffff8880361ee0b0 (&tree->tree_lock){+.+.}-{4:4}, at: hfsplus_find_init+0x168/0x2d0 fs/hfsplus/bfind.c:28
4 locks held by kworker/u8:6/1143:
 #0: ffff8880206a0148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x855/0x15a0 kernel/workqueue.c:3254


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

