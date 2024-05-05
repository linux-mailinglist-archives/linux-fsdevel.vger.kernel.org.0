Return-Path: <linux-fsdevel+bounces-18761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9598BC266
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 18:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A3E280ABD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 16:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBB73B2A1;
	Sun,  5 May 2024 16:14:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D742E83F
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714925682; cv=none; b=R0UUZWGpjNf0RLp4mP8M+2eJ8pPjE2O1zXHpBBt0JbKz8iIOJMjmll15MpVH1kv0jMSrBt7NDtBWHn2RYj0gy3sk2q1CNuCtlUFn4uqqGZNwsNn2AlhanlGpxjo1ohbYVga+B2b+Dr+nsJlX0c4oHcSSfmEoPKYPDQAygCK0p4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714925682; c=relaxed/simple;
	bh=QIz43+speCYoyC4F7oRZF3N8UpU9Lm96tmkLZxNpOhs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TacFwlq/PVkcghh+nzKuy9mJsj9uRH3Ws/j8PworStwN23/UJPvHLKAJT27gKjB4tJJQmDdayWPSWWZhDAJU2MD5QHqMNl9V0IVzv9K/2ZLXLSacpADctB/MWqbVORBCsUQtq10Uyd7PkWsTW08VZ9z0LFYrm3RuVbTkTdPXDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-36c89052654so12760535ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 09:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714925680; x=1715530480;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Y7O1nOaScM4M/3DUeCIB71VrhmW7zyenpvPyEqNVEc=;
        b=XEmYk5MtwiYPStH50f+ppz8amIzLMIgS1y1OLp2CMG1MTpo220mzF57TTTGgHnQj5K
         kPhlx+F572maBGQ6ScFIw/L1R+DUWTWyFHXlGGypkH7/auPLw8qwdAH5asVcZxKfA94b
         IogZoFCyxZqm/wICvrnnp6xh0ad9sO3yCYIvUg9SkSytCuX6MPLq6r1JSK2fhtzGpg+G
         vdG0mTr/g8TvV1Lq9K9Jp/LGovZyrjd+C/d8WlhRsDnIhTcW0M2AFWpmsd6bE0FR7fbo
         dVNMoINkn+O9FhWdIzQa7iLVhw3vJg/386VsFeW7hkc3SUKg8ko+kcWeqs9uBkmItJFf
         kyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqp2VfvNf4bbyr6dtbnnw3/VsoPCu3l8RrocclklqVuT3z35FwVVYtkrqnwHrY4wyYPrbCA7h7cAmapYkZ+Ej4HQpIlaN1U/m+goNaMA==
X-Gm-Message-State: AOJu0YxZr1tXReCYCL8o6M2iXpXYUyXFopriSgJK1edjNuVGR3uo+OWc
	oqALQKyUed19uLBB2xCG//MgdZWp5y2ble/nkyrCYAESHFHaJBEZfatYSESj//yJfBGQkkOlW2A
	SmOwnMX1JCU7ZJqS6mopDmHCuez9sIT1G7yoOW+HpFn7p1Y+UrtNFWoY=
X-Google-Smtp-Source: AGHT+IGiSS9UF64KGVYYTZho6dcuKXx7CzilFmdBCiB1PHNxcYMJ11mnCSTyOCNpViBA93+eYtCw19IB4OzzKhTSfsw+4cM7PnKE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:36a:190f:1c93 with SMTP id
 i2-20020a056e02152200b0036a190f1c93mr342001ilu.5.1714925680752; Sun, 05 May
 2024 09:14:40 -0700 (PDT)
Date: Sun, 05 May 2024 09:14:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000498630617b740d3@google.com>
Subject: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in rewrite_old_nodes_pred
From: syzbot <syzbot+594427aebfefeebe91c6@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=133dd354980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=594427aebfefeebe91c6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d1b2a0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135c2ca8980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03bd77f8af70/disk-7367539a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb03a61f9582/vmlinux-7367539a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4c5c654b571/bzImage-7367539a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7aefb3ba7f27/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+594427aebfefeebe91c6@syzkaller.appspotmail.com

bcachefs (loop0): journal_replay... done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): scanning for old btree nodes: min_version 0.24: unwritten_extents
bcachefs (loop0): going read-write
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/bcachefs/move.c:986:31
shift exponent 64 is too large for 64-bit type 'unsigned long long'
CPU: 0 PID: 5081 Comm: syz-executor477 Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 bformat_needs_redo fs/bcachefs/move.c:986 [inline]
 rewrite_old_nodes_pred+0x45e/0x620 fs/bcachefs/move.c:1002
 bch2_move_btree+0x792/0xde0 fs/bcachefs/move.c:886
 bch2_scan_old_btree_nodes+0x14b/0x3c0 fs/bcachefs/move.c:1016
 bch2_fs_recovery+0x534e/0x6390 fs/bcachefs/recovery.c:887
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1043
 bch2_fs_open+0xa8d/0xdf0 fs/bcachefs/super.c:2102
 bch2_mount+0x71d/0x1320 fs/bcachefs/fs.c:1903
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc4970e98fa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff723ad538 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff723ad540 RCX: 00007fc4970e98fa
RDX: 0000000020011a00 RSI: 0000000020000100 RDI: 00007fff723ad540
RBP: 0000000000000004 R08: 00007fff723ad580 R09: 005f617461646174
R10: 0000000003004081 R11: 0000000000000282 R12: 00007fff723ad580
R13: 0000000000000003 R14: 0000000001000000 R15: 0000000000000001
 </TASK>
---[ end trace ]---


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

