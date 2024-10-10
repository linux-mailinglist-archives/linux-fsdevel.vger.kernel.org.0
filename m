Return-Path: <linux-fsdevel+bounces-31593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 051D4998959
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 16:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351E61C24032
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD32F1CEEBD;
	Thu, 10 Oct 2024 14:16:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E5C1CB524
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569766; cv=none; b=EJWpjYg/CxijheUuFjzrIjKC6h5FbW3b6BrwenSDkC4t2lB3Bj0XUezIwzJuhy6nGWpfM+1M64xtCkGWUntNJ2lSD5dThJFZUJKU2TQhkcOmOH/EujGUoKWkvuownWY9JeHRz2FE4nKkMPeL5wGCkOKFMzD/hS+jLhsnvtM/W70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569766; c=relaxed/simple;
	bh=wo1aqpD0fJx2ciqxxDy8ZSZ5yYdeEAeEXEqccPnZFUk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NIFZ0S7J54bJf0Bw/WKBN+9LbF803pybjI1ePIOHzLuFYmJJCjpVhGjE9KsfKrTmpMeTygA6an3jYv+rJll7w+dHuANrjna2PTXk6/f0uLf535mGof6emh6sHhT4AJ6SRLtYjmBKYU8PpArPYwwP8EQHh6jfrPj0ihS/2AGi/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3972c435dso10149515ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 07:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728569764; x=1729174564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xgq60H82SiwsEEYyfETa4MwhBeXGmeG/1/Rkqw+PB7Y=;
        b=KZ77T7j0RjyEXP0fdZ7vuPcuwr16YnGVM3uoKwC+68axfezMrTCe7QCRk8hhPNSiPJ
         NkUWbnikSUcfim/ILVPXW5s5NWFdvk2WmKaDyeSvYCzKWhsEPxu4YLfoWsqBQMyW9WTk
         dOASpUFrr7qjT2adqYn+ZyDKVzziRzzHZppjtq2P4rbFfuqqNonF+1KmJ8zKIeIbnXJV
         ChBtteH/c/gRV39Hbmd4XIOE/qeY0SjRisAE25/B4z1JW+x7p0nx5LdszlYHAaoRHXq/
         NT/7IxC1rAqe/J0LTWRHkh2qyaXQWtN81kaUU8K13YNT4zjEXq+UCT7zXKOyF3HlIg8m
         P1Og==
X-Gm-Message-State: AOJu0YxWi+pavY/41gpWTA6V96MQYG9GSm3b1TDZuYvB8gqBU0XEgjwt
	bNbJxngYj7rDygf5n4/RRvQ3yDEB/rsJwqWlj5tweeJ/9SV049CRYwgIW0deIwkfeNXXuD0WNkk
	fN5x8HXvu5Xh4GBZ+XDkax3Pk18qPIwBosm4fZe+H32CsR7WcVYPTZ6Q=
X-Google-Smtp-Source: AGHT+IGyR/sLbWQK4QmtOec/SQH+sZL6vZpBJgNUN4MWA4vVduu4+9Z9or8U54sP7rLb2td24R/a8Yihjkcp40W99jiCXYw1Zaiy
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0a:0:b0:3a1:a163:ba58 with SMTP id
 e9e14a558f8ab-3a397d1d064mr70988585ab.26.1728569764030; Thu, 10 Oct 2024
 07:16:04 -0700 (PDT)
Date: Thu, 10 Oct 2024 07:16:03 -0700
In-Reply-To: <ZwfZkr_27ycafr7F@iZbp1asjb3cy8ks0srf007Z>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707e1a3.050a0220.8109b.0010.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	qianqiang.liu@163.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in __hfs_ext_cache_extent

loop0: detected capacity change from 0 to 64
=====================================================
BUG: KMSAN: uninit-value in __hfs_ext_read_extent fs/hfs/extent.c:163 [inline]
BUG: KMSAN: uninit-value in __hfs_ext_cache_extent+0x779/0x7e0 fs/hfs/extent.c:179
 __hfs_ext_read_extent fs/hfs/extent.c:163 [inline]
 __hfs_ext_cache_extent+0x779/0x7e0 fs/hfs/extent.c:179
 hfs_ext_read_extent fs/hfs/extent.c:202 [inline]
 hfs_get_block+0x733/0xf50 fs/hfs/extent.c:366
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121
 block_write_begin fs/buffer.c:2231 [inline]
 cont_write_begin+0xf82/0x1940 fs/buffer.c:2582
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 cont_expand_zero fs/buffer.c:2509 [inline]
 cont_write_begin+0x32f/0x1940 fs/buffer.c:2572
 hfs_write_begin+0x85/0x120 fs/hfs/inode.c:52
 hfs_file_truncate+0x1a5/0xd30 fs/hfs/extent.c:494
 hfs_inode_setattr+0x998/0xab0 fs/hfs/inode.c:654
 notify_change+0x1a8e/0x1b80 fs/attr.c:503
 do_truncate+0x22a/0x2b0 fs/open.c:65
 vfs_truncate+0x5d4/0x680 fs/open.c:111
 do_sys_truncate+0x104/0x240 fs/open.c:134
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __x64_sys_truncate+0x6c/0xa0 fs/open.c:144
 x64_sys_call+0x2ce3/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:77
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable fd.i created at:
 hfs_ext_read_extent fs/hfs/extent.c:193 [inline]
 hfs_get_block+0x295/0xf50 fs/hfs/extent.c:366
 __block_write_begin_int+0xa6b/0x2f80 fs/buffer.c:2121

CPU: 1 UID: 0 PID: 5954 Comm: syz.0.15 Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


Tested on:

commit:         d3d15566 Merge tag 'mm-hotfixes-stable-2024-10-09-15-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17aecb27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1777005f980000


