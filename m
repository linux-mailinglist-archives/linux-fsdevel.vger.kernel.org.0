Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B114022078C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 10:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgGOIjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 04:39:18 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:55701 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbgGOIjS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:39:18 -0400
Received: by mail-il1-f199.google.com with SMTP id b2so890003ilh.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 01:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=X50zSFlWOsBbnGGaGGIgEhrXhN4UntpAF5C1oBx9MYs=;
        b=ncdNFzID3ETyAFCidF51JVxY3L+2mOjQOPq2s4q8q5uen9eDA+N1haxPQkb1sW3RzI
         vMlWy0U0XnSXTS01c89TQNdYzS2gCWek/yhJtkuzFl6stIr7sak0zw0RCid/4wEJhwh2
         TPNLw4oZy++CT+A+NsNXAScWGUXKAyqPsL90YIlh9+F7sazGd6d0mBA7Fbb48MLecsRZ
         3IpzGHSea2IuOEa/ppwuQYXWI6DzY5k/m8cNW4gQFwhNZdKE5Zd8+WZhmg5FXxwwVnqR
         9n7Ph+uY3qs+jhNpR0hKcKv/0QaYK2Q7KfZfC6fHXn+nr+ZnuNKsIplt9bLLIf41t0Uk
         f+3w==
X-Gm-Message-State: AOAM531f2atkixlEZsKeZcEDYjFm6UtteX4sp80WCPxGKsDmF1MeiCwB
        nbYQK5TQs1zg6q1PAvlspRq9qB8auILCxE6d05H66oAFZp7H
X-Google-Smtp-Source: ABdhPJyFSqYEGOij/2d2gRAgBYTTNAvoJfPacGxhsMgIpHLdOUDDPeG4AeOMpxQVXQBcvyYcDGWpH3dXO8ZI3tqHxnFQj6EqYi7Y
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:682:: with SMTP id o2mr8155784ils.188.1594802357332;
 Wed, 15 Jul 2020 01:39:17 -0700 (PDT)
Date:   Wed, 15 Jul 2020 01:39:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fef5a905aa76dbf9@google.com>
Subject: memory leak in create_pipe_files
From:   syzbot <syzbot+6a137efd811917e8b53c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a581387e Merge tag 'io_uring-5.8-2020-07-10' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ba1967100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13a9cfc3f50ff96
dashboard link: https://syzkaller.appspot.com/bug?extid=6a137efd811917e8b53c
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d2004f100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a137efd811917e8b53c@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88812a6c8800 (size 256):
  comm "syz-execprog", pid 6479, jiffies 4295096411 (age 83.520s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    20 2d 85 2a 81 88 ff ff 80 57 d2 15 81 88 ff ff   -.*.....W......
  backtrace:
    [<00000000057eb446>] kmem_cache_zalloc include/linux/slab.h:659 [inline]
    [<00000000057eb446>] __alloc_file+0x23/0x120 fs/file_table.c:101
    [<0000000046b459a4>] alloc_empty_file+0x4f/0xe0 fs/file_table.c:151
    [<00000000fced1caf>] alloc_file+0x31/0x160 fs/file_table.c:193
    [<0000000079549d8a>] alloc_file_pseudo+0xae/0x120 fs/file_table.c:233
    [<0000000058a70f71>] create_pipe_files+0x127/0x270 fs/pipe.c:931
    [<00000000ad5d09be>] __do_pipe_flags fs/pipe.c:964 [inline]
    [<00000000ad5d09be>] do_pipe2+0x43/0x110 fs/pipe.c:1012
    [<0000000038960906>] __do_sys_pipe2 fs/pipe.c:1030 [inline]
    [<0000000038960906>] __se_sys_pipe2 fs/pipe.c:1028 [inline]
    [<0000000038960906>] __x64_sys_pipe2+0x16/0x20 fs/pipe.c:1028
    [<00000000b1b64f40>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:384
    [<00000000e3fac4b7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88812a7abb80 (size 16):
  comm "syz-execprog", pid 6479, jiffies 4295096411 (age 83.520s)
  hex dump (first 16 bytes):
    01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000029e2bcd5>] kmem_cache_zalloc include/linux/slab.h:659 [inline]
    [<0000000029e2bcd5>] lsm_file_alloc security/security.c:567 [inline]
    [<0000000029e2bcd5>] security_file_alloc+0x2e/0xc0 security/security.c:1455
    [<00000000884a9f66>] __alloc_file+0x61/0x120 fs/file_table.c:106
    [<0000000046b459a4>] alloc_empty_file+0x4f/0xe0 fs/file_table.c:151
    [<00000000fced1caf>] alloc_file+0x31/0x160 fs/file_table.c:193
    [<0000000079549d8a>] alloc_file_pseudo+0xae/0x120 fs/file_table.c:233
    [<0000000058a70f71>] create_pipe_files+0x127/0x270 fs/pipe.c:931
    [<00000000ad5d09be>] __do_pipe_flags fs/pipe.c:964 [inline]
    [<00000000ad5d09be>] do_pipe2+0x43/0x110 fs/pipe.c:1012
    [<0000000038960906>] __do_sys_pipe2 fs/pipe.c:1030 [inline]
    [<0000000038960906>] __se_sys_pipe2 fs/pipe.c:1028 [inline]
    [<0000000038960906>] __x64_sys_pipe2+0x16/0x20 fs/pipe.c:1028
    [<00000000b1b64f40>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:384
    [<00000000e3fac4b7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
