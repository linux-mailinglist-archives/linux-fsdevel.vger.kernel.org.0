Return-Path: <linux-fsdevel+bounces-70620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 245F0CA2175
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 02:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 122B030213FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 01:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77BB1FAC34;
	Thu,  4 Dec 2025 01:21:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66EB18027
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764811268; cv=none; b=OXzceP8v+N1x1aRpg6p4vXVb6eet8cSp7O43EZ2qt6OrxFZAQvVfc7KWKNue5inUddBGe4tYn13GRZBFWj7hZVaYM7oqIYgLlnAJtyYOlgG55Lod0qYahyOoV3CsUOfVlaysRJurzR08lqAb04zAuc7yP3eszPon4KJE3vQ1Id8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764811268; c=relaxed/simple;
	bh=/5scZ/eC107Phge51Zoi2mfL0kncJfhraiodin6jWsY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jBW0IzNO1zLtqUqlutiAR0f/XZWrm6OHPrrBfMabDs6NxPiQOkNDe7PWxn9loJaiDcfomTd/KDOTk8ozJS+QzfkSs9a9hUKKW8u5UuwKeZ8MZyaRv46kaUo23S8yqT24urYHwyxvGwyGLc6+oF0AsXzl5QLQlzk2wthsjLRZWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7c6d3685fadso406341a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 17:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764811265; x=1765416065;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiyA4BsvKpdDe/wb+UstNj8L9RhhCP0Ealq39FLJ2X4=;
        b=jtwRnis+KyUVkasJwdmibnEG3D4eCtSeLFr8uu3ENNyCqSDHkQWnBns4tCesDIFA5t
         ifMwMX7Pb/UpSmt3k22a+YmvH8jBhUnwuE+Ahi+tABQWygTbQqEgZHL+02ehcDR4j4+J
         v1ry6c0MaoYgsjSfjRzspHPiD2lnR6tEE6KI0hKirkkYe0ZWksdxC4fSjEt30gP+x9Go
         NiYwlf08AbxahppfPyoi+r3HL2Is6IAgIsYw7LoxDbCsNuKCeDFNfKsY6vNr7G4hoy4e
         LSa8/U3QhmOeiRVo1+imyKRf85sQe+ljpDu/zKMMrsNKL+yVkVGCzcFjX0OiCUBcJcyw
         b3wg==
X-Forwarded-Encrypted: i=1; AJvYcCW6xys4jIDjhMJu2/jDkON05YYDeNjmVbp4+NSgJWAQyO26qGggVCgItLW3P6t4kn13VuKoopjwVpsOumck@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+Qu0KgrkIfrJEZfrzQwroYxoaYB30PSisjxyWd9O8QUcVvLp
	L5WgDmC8jFbmsgfeZQZGdxaGNfT0RRs30Kbl8rk2LH+HSwHmAJKDI0U+oEWCgd7YVP0jqYNJqHr
	V8ZZHCM0nosk3o46M01TW7xb/mmBIlRWz5S15gp5zCc/nKgNN10McUE9KW/k=
X-Google-Smtp-Source: AGHT+IGR6yzN8/gTaXDLHIZCWPMzJY+8/LoYxKW5pQ87fDfFBQvXhn8k6gO3O1NINCmYw1AcqzMIc2QLuA5jADlGeMLkm4t6Jhtj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b07:b0:453:50af:c463 with SMTP id
 5614622812f47-4536e51a345mr2347095b6e.41.1764811264789; Wed, 03 Dec 2025
 17:21:04 -0800 (PST)
Date: Wed, 03 Dec 2025 17:21:04 -0800
In-Reply-To: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6930e200.a70a0220.d98e3.01bd.GAE@google.com>
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

(syz.0.73,6964,1):ocfs2_find_entry_id:420 ERROR: status = -30
------------[ cut here ]------------
kernel BUG at fs/namei.c:2532!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6964 Comm: syz.0.73 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:link_path_walk+0x1a57/0x1a90 fs/namei.c:2532
Code: 89 e9 80 e1 07 fe c1 38 c1 0f 8c be fd ff ff 4c 89 ef e8 2c e5 e9 ff e9 b1 fd ff ff e8 62 90 83 ff 90 0f 0b e8 5a 90 83 ff 90 <0f> 0b e8 52 90 83 ff 90 0f 0b e8 4a 90 83 ff 4c 89 ff 48 c7 c6 40
RSP: 0018:ffffc9000491f8a0 EFLAGS: 00010293
RAX: ffffffff823e22d6 RBX: dffffc0000000000 RCX: ffff8880250f3d00
RDX: 0000000000000000 RSI: 0000000000008000 RDI: 0000000000004000
RBP: ffff888079181120 R08: ffff8880299ef520 R09: ffff88807acd2000
R10: ffff8880299ef520 R11: ffff88807acd2000 R12: ffffc9000491fc58
R13: ffffc9000491fc28 R14: 0000000000008000 R15: 0000000000100000
FS:  00007ff92e2e36c0(0000) GS:ffff888125f49000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555575344808 CR3: 0000000025c92000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 path_openat+0x2b3/0x3dd0 fs/namei.c:4787
 do_filp_open+0x1fa/0x410 fs/namei.c:4818
 do_sys_openat2+0x121/0x200 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_open fs/open.c:1444 [inline]
 __se_sys_open fs/open.c:1440 [inline]
 __x64_sys_open+0x11e/0x150 fs/open.c:1440
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff92d38f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff92e2e3038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ff92d5e5fa0 RCX: 00007ff92d38f749
RDX: 0000000000000000 RSI: 0000000000145142 RDI: 0000200000000240
RBP: 00007ff92d413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff92d5e6038 R14: 00007ff92d5e5fa0 R15: 00007ffda4bd0278
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:link_path_walk+0x1a57/0x1a90 fs/namei.c:2532
Code: 89 e9 80 e1 07 fe c1 38 c1 0f 8c be fd ff ff 4c 89 ef e8 2c e5 e9 ff e9 b1 fd ff ff e8 62 90 83 ff 90 0f 0b e8 5a 90 83 ff 90 <0f> 0b e8 52 90 83 ff 90 0f 0b e8 4a 90 83 ff 4c 89 ff 48 c7 c6 40
RSP: 0018:ffffc9000491f8a0 EFLAGS: 00010293
RAX: ffffffff823e22d6 RBX: dffffc0000000000 RCX: ffff8880250f3d00
RDX: 0000000000000000 RSI: 0000000000008000 RDI: 0000000000004000
RBP: ffff888079181120 R08: ffff8880299ef520 R09: ffff88807acd2000
R10: ffff8880299ef520 R11: ffff88807acd2000 R12: ffffc9000491fc58
R13: ffffc9000491fc28 R14: 0000000000008000 R15: 0000000000100000
FS:  00007ff92e2e36c0(0000) GS:ffff888125e49000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1310116e9c CR3: 0000000025c92000 CR4: 00000000003526f0


Tested on:

commit:         b2c27842 Add linux-next specific files for 20251203
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15d7801a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caadf525b0ab8d17
dashboard link: https://syzkaller.appspot.com/bug?extid=d222f4b7129379c3d5bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1281d4c2580000


