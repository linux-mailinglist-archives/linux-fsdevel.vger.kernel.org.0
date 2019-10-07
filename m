Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD98CEC72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 21:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfJGTHw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 15:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGTHw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:07:52 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC8B2206C2;
        Mon,  7 Oct 2019 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570475271;
        bh=1d9hqI3IklouHPR1dXFdr/dQUb8bSDddpHAyOJnKXzY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sSCk8niSRCGVtk0J795EZwnjtInzPeorf3roXvwowDk49e70dHkEU9skeZ7Yz5iAg
         yW9/DmjD3b8ZObW0rqhTDh/D8xlNxBdTzQ5kAftLt9m5JWfAdHxj6iRta80gLmNBr6
         sEgOnQnTJQmnLPCfjM1pITtr3tJpe0x04ePqJg5s=
Date:   Mon, 7 Oct 2019 12:07:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING in filldir64
Message-ID: <20191007190747.GA16653@gmail.com>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006b7bfb059452e314@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+Linus]

On Mon, Oct 07, 2019 at 07:30:07AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    43b815c6 Merge tag 'armsoc-fixes' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10721dfb600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fb0b431ccdf08c1c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3031f712c7ad5dd4d926
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 10405 at fs/readdir.c:150 verify_dirent_name
> fs/readdir.c:150 [inline]
> WARNING: CPU: 1 PID: 10405 at fs/readdir.c:150 filldir64+0x524/0x620
> fs/readdir.c:356
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 10405 Comm: syz-executor.2 Not tainted 5.4.0-rc1+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
>  panic+0x25c/0x799 kernel/panic.c:220
>  __warn+0x20e/0x210 kernel/panic.c:581
>  report_bug+0x1b6/0x2f0 lib/bug.c:195
>  fixup_bug arch/x86/kernel/traps.c:179 [inline]
>  do_error_trap+0xd7/0x440 arch/x86/kernel/traps.c:272
>  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291
>  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
> RIP: 0010:verify_dirent_name fs/readdir.c:150 [inline]
> RIP: 0010:filldir64+0x524/0x620 fs/readdir.c:356
> Code: 00 00 c7 03 f2 ff ff ff b8 f2 ff ff ff 48 83 c4 60 5b 41 5c 41 5d 41
> 5e 41 5f 5d c3 e8 55 2c b9 ff 0f 0b eb 07 e8 4c 2c b9 ff <0f> 0b 49 83 c6 24
> 4c 89 f0 48 c1 e8 03 42 8a 04 20 84 c0 0f 85 b6
> RSP: 0018:ffff8880a3dc7b88 EFLAGS: 00010283
> RAX: ffffffff81ba0624 RBX: 000000000000000c RCX: 0000000000040000
> RDX: ffffc9000a588000 RSI: 00000000000021f1 RDI: 00000000000021f2
> RBP: ffff8880a3dc7c10 R08: ffffffff81ba0134 R09: 0000000000000004
> R10: fffffbfff1120afb R11: 0000000000000000 R12: dffffc0000000000
> R13: ffff8880a3dc7d30 R14: ffff8880a3dc7e88 R15: 000000000000000c
>  dir_emit include/linux/fs.h:3542 [inline]
>  __fat_readdir+0x1320/0x1a50 fs/fat/dir.c:677
>  fat_readdir+0x46/0x50 fs/fat/dir.c:704
>  iterate_dir+0x2a4/0x520 fs/readdir.c:107
>  ksys_getdents64+0x1ea/0x3f0 fs/readdir.c:412
>  __do_sys_getdents64 fs/readdir.c:431 [inline]
>  __se_sys_getdents64 fs/readdir.c:428 [inline]
>  __x64_sys_getdents64+0x7a/0x90 fs/readdir.c:428
>  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459a59
> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f943ff4bc78 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a59
> RDX: 0000000000001000 RSI: 00000000200005c0 RDI: 0000000000000005
> RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f943ff4c6d4
> R13: 00000000004c0533 R14: 00000000004d2c58 R15: 00000000ffffffff
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 

This WARN_ON was added by:

	commit 8a23eb804ca4f2be909e372cf5a9e7b30ae476cd
	Author: Linus Torvalds <torvalds@linux-foundation.org>
	Date:   Sat Oct 5 11:32:52 2019 -0700

	    Make filldir[64]() verify the directory entry filename is valid

Seems this indicates a corrupt filesystem rather than a kernel bug, so using
WARN_ON is not appropriate.  It should either use pr_warn_once(), or be silent.

- Eric
