Return-Path: <linux-fsdevel+bounces-13607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DCC871CD3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 12:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88468285D44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA89758ADE;
	Tue,  5 Mar 2024 11:03:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7158222
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636611; cv=none; b=bdwASNMU1LHEuSpc5bM33dPvb9BkGAHyOHEhsWs9DtKa7Q7WA38l8fQRxQk0ckbBFjj3kM3jvdoVXx+DqGBmHwuXOIAiGbB/Njn0q+hbEfEZllszAhbXN65m4JPJTALHce2Vrl1/E//5nUcdZqDRTEBSuY6HAtX4tlG0p7Ydvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636611; c=relaxed/simple;
	bh=F6CCUVJjzFeMM02fSLem8/HHQsC/x2Ttc9fdcPJ/3WI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qzc7LJtTLFC+zWPz55eD3/TJIoC8Hg8o2TyU6YuJql2cHlvmmya6zCbTHXxUsfhJYIQSjWxmM0GtJng3few20sW+sJY6dKkcJl9gje33ZdVH2Ad+DuuPdJvGqt7CtlFVAia+heovGyJF+Cs7sGRnzbjmZwnIBxPcrahFgGa966g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c8440b33b6so263168539f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 03:03:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636609; x=1710241409;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61smrnQbOZotuakrMyfB8Rzk7rp+E0dZL4oOdtQON7w=;
        b=Rtnh6t10R5KVGkFjRoY+Jn7UNKGMJHDeNn20GTGF97zbFNBNq4DR1kI+ieqAwalLRb
         8eaW4Hwobkk3XBippanOMKpjOM8R9uy2LxHs6lxv29MDKnZFlEM3gHhiBd80hGMtJlOM
         tl57DH1CGnQheUrNjO8xINVgTIaJFBd9RzNnqQ1iU5x2Ws+EZTSHyhxPtMKJ8VaCbtrC
         uIqksZ5DLfFZnalKaz5WwJ5+K3wxY51nLprAONDMwU7xt8uIvXtFmzp3N+UzvrVX8HL8
         UA7fpVrjdCK8aRQJo0CX+LdTBoYLBzeTY7tg+/ko3IA6wUtZWP3Bjf4jNbqLAhZDn7Vf
         3XBw==
X-Forwarded-Encrypted: i=1; AJvYcCX/BbJSKjbA6LR76830Y9hF6ZPXWQhLs73wfAnkxwyL8eggNaFWJ/S41LCKQxqijNHOAygXwAI3wEqPQLw8OKZ2BKvYF0rWLQQIzxobMA==
X-Gm-Message-State: AOJu0YzVAR4t+JpWeXIr4nXH8thJUZd01FT61v/gppsVY/WljL1rVHaj
	R/EMsQWUwBzftxx+u2j0F27hLsxSbp2Sd/riSKbrcIvW7C2lFDOahW0lZk0VbFjKAqWfEM/CwBX
	uLS3+wzwULeS6jWw2GtTcTh/qp414S+2aGDcqZXDsdjdMKASGAAjcYiI=
X-Google-Smtp-Source: AGHT+IGgh9KUvpUSaCh3JUfC4N2IL69Gm5j634ufd+1IjISlPa1TgEQyqU69uqmEcoVB5GrFpmtzAlZM8qoNczAqZ9Eryh1ULJ6F
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1486:b0:7c8:3577:2a50 with SMTP id
 a6-20020a056602148600b007c835772a50mr402750iow.0.1709636609275; Tue, 05 Mar
 2024 03:03:29 -0800 (PST)
Date: Tue, 05 Mar 2024 03:03:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca86690612e7cacd@google.com>
Subject: [syzbot] [gfs2?] WARNING in gfs2_check_blk_type (2)
From: syzbot <syzbot+26e96d7e92eed8a21405@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    90d35da658da Linux 6.8-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10bb48e4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=119d08814b43915b
dashboard link: https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fcb02e180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1028a27a180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/821deeb51f0a/disk-90d35da6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a7d492f89d7/vmlinux-90d35da6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/78bfac3e2f5d/bzImage-90d35da6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a2629006a328/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130748e4180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=108748e4180000
console output: https://syzkaller.appspot.com/x/log.txt?x=170748e4180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+26e96d7e92eed8a21405@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: first mount done, others may mount
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5058 at fs/gfs2/rgrp.c:2630 gfs2_check_blk_type+0x44e/0x680 fs/gfs2/rgrp.c:2630
Modules linked in:
CPU: 1 PID: 5058 Comm: syz-executor354 Not tainted 6.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:gfs2_check_blk_type+0x44e/0x680 fs/gfs2/rgrp.c:2630
Code: d4 01 00 00 8b 1b 89 df 44 89 f6 e8 4c 49 bd fd 4c 89 74 24 10 44 39 f3 76 23 e8 7d 47 bd fd 45 31 ed eb 70 e8 73 47 bd fd 90 <0f> 0b 90 41 bf f9 ff ff ff 48 8b 5c 24 18 e9 46 01 00 00 e8 5a 47
RSP: 0018:ffffc900040d78c0 EFLAGS: 00010293
RAX: ffffffff83d6242c RBX: ffff88802ee40028 RCX: ffff8880779e0000
RDX: 0000000000000000 RSI: 0000000000000012 RDI: 0000000000000013
RBP: ffffc900040d79d0 R08: ffffffff83d62422 R09: 1ffff1100f3b75dc
R10: dffffc0000000000 R11: ffffed100f3b75dd R12: 1ffff11005dc8006
R13: ffff88802ee40000 R14: 0000000000000012 R15: 0000000000000013
FS:  000055555631c380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 000000002aba0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_inode_lookup+0xb05/0xc60 fs/gfs2/inode.c:178
 gfs2_lookup_by_inum+0x51/0xf0 fs/gfs2/inode.c:251
 gfs2_get_dentry fs/gfs2/export.c:139 [inline]
 gfs2_fh_to_dentry+0x13a/0x1f0 fs/gfs2/export.c:160
 exportfs_decode_fh_raw+0x152/0x5f0 fs/exportfs/expfs.c:444
 exportfs_decode_fh+0x3c/0x80 fs/exportfs/expfs.c:584
 do_handle_to_path fs/fhandle.c:155 [inline]
 handle_to_path fs/fhandle.c:210 [inline]
 do_handle_open+0x494/0x650 fs/fhandle.c:226
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f87a993d839
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff387ac1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 00007fff387ac3c8 RCX: 00007f87a993d839
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000004
RBP: 00007f87a99c3610 R08: 0000000000000000 R09: 00007fff387ac3c8
R10: 00007f87a9978bf3 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff387ac3b8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

