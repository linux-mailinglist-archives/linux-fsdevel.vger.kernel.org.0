Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616E34A345
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 16:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfFRODZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 10:03:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46868 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFRODZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:03:25 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hdEh6-00037d-Bm; Tue, 18 Jun 2019 14:02:40 +0000
Date:   Tue, 18 Jun 2019 15:02:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+6004acbaa1893ad013f0@syzkaller.appspotmail.com>
Cc:     arnd@arndb.de, axboe@kernel.dk, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dhowells@redhat.com,
        geert@linux-m68k.org, hare@suse.com, heiko.carstens@de.ibm.com,
        hpa@zytor.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: general protection fault in do_move_mount (2)
Message-ID: <20190618140239.GA17978@ZenIV.linux.org.uk>
References: <000000000000bb362d058b96d54d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000bb362d058b96d54d@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 18, 2019 at 03:47:10AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9e0babf2 Linux 5.2-rc5
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=138b310aa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d16883d6c7f0d717
> dashboard link: https://syzkaller.appspot.com/bug?extid=6004acbaa1893ad013f0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154e8c2aa00000

IDGI...

mkdir(&(0x7f0000632000)='./file0\x00', 0x0)
mount(0x0, 0x0, 0x0, 0x0, 0x0)
syz_open_procfs(0x0, 0x0)
r0 = open(&(0x7f0000032ff8)='./file0\x00', 0x0, 0x0)
r1 = memfd_create(&(0x7f00000001c0)='\xb3', 0x0)
write$FUSE_DIRENT(r1, &(0x7f0000000080)=ANY=[], 0x29)
move_mount(r0, &(0x7f0000000040)='./file0\x00', 0xffffffffffffff9c, &(0x7f0000000100)='./file0\x00', 0x66)

reads as if we'd done mkdir ./file0, opened it and then tried
to feed move_mount(2) "./file0" relative to that descriptor.
How the hell has that avoided an instant -ENOENT?  On the first
pair, that is - the second one (AT_FDCWD, "./file0") is fine...

Confused...  Incidentally, what the hell is
	mount(0x0, 0x0, 0x0, 0x0, 0x0)
about?  *IF* that really refers to mount(2) with
such arguments, all you'll get is -EFAULT.  Way before
it gets to actually doing anything - it won't get past
        /* ... and get the mountpoint */
        retval = user_path(dir_name, &path);
        if (retval)
                return retval;
in do_mount(2)...
