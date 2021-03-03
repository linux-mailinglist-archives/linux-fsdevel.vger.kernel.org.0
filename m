Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ABC32B4E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450155AbhCCFas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:30:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232956AbhCCAmM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:42:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7498964F8C;
        Wed,  3 Mar 2021 00:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614732080;
        bh=NJFM8ypXGB8CAwTG3IODGhNTCzeklS9Cmkn4gelagqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eHhP3Y6TUhObWtFqyaunxUjAwcLsc1/IkbJla6YZsScy1tLRwTz5vuZohf6UqFLHF
         QCB7g+3ktloWMkTBSFMaeU8SLzBCjbi6NhfndlRJhUdjfV3ANxksAVi4/7cezD5xIQ
         nfdklbk1ZPDuiMmmt52swFT2mmflnkNwqVNM11Nc=
Date:   Tue, 2 Mar 2021 16:41:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lior Ribak <liorribak@gmail.com>
Cc:     deller@gmx.de, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] binfmt_misc: Fix possible deadlock in
 bm_register_write
Message-Id: <20210302164119.406098356cdea37b999b0b0a@linux-foundation.org>
In-Reply-To: <20210228224414.95962-1-liorribak@gmail.com>
References: <20201224111533.24719-1-liorribak@gmail.com>
        <20210228224414.95962-1-liorribak@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 28 Feb 2021 14:44:14 -0800 Lior Ribak <liorribak@gmail.com> wrote:

> There is a deadlock in bm_register_write:
> First, in the beggining of the function, a lock is taken on the
> binfmt_misc root inode with inode_lock(d_inode(root))
> Then, if the user used the MISC_FMT_OPEN_FILE flag, the function will
> call open_exec on the user-provided interpreter.
> open_exec will call a path lookup, and if the path lookup process
> includes the root of binfmt_misc, it will try to take a shared lock
> on its inode again, but it is already locked, and the code will
> get stuck in a deadlock
> 
> To reproduce the bug:
> $ echo ":iiiii:E::ii::/proc/sys/fs/binfmt_misc/bla:F" > /proc/sys/fs/binfmt_misc/register
> 
> backtrace of where the lock occurs (#5):
> 0  schedule () at ./arch/x86/include/asm/current.h:15
> 1  0xffffffff81b51237 in rwsem_down_read_slowpath (sem=0xffff888003b202e0, count=<optimized out>, state=state@entry=2) at kernel/locking/rwsem.c:992
> 2  0xffffffff81b5150a in __down_read_common (state=2, sem=<optimized out>) at kernel/locking/rwsem.c:1213
> 3  __down_read (sem=<optimized out>) at kernel/locking/rwsem.c:1222
> 4  down_read (sem=<optimized out>) at kernel/locking/rwsem.c:1355
> 5  0xffffffff811ee22a in inode_lock_shared (inode=<optimized out>) at ./include/linux/fs.h:783
> 6  open_last_lookups (op=0xffffc9000022fe34, file=0xffff888004098600, nd=0xffffc9000022fd10) at fs/namei.c:3177
> 7  path_openat (nd=nd@entry=0xffffc9000022fd10, op=op@entry=0xffffc9000022fe34, flags=flags@entry=65) at fs/namei.c:3366
> 8  0xffffffff811efe1c in do_filp_open (dfd=<optimized out>, pathname=pathname@entry=0xffff8880031b9000, op=op@entry=0xffffc9000022fe34) at fs/namei.c:3396
> 9  0xffffffff811e493f in do_open_execat (fd=fd@entry=-100, name=name@entry=0xffff8880031b9000, flags=<optimized out>, flags@entry=0) at fs/exec.c:913
> 10 0xffffffff811e4a92 in open_exec (name=<optimized out>) at fs/exec.c:948
> 11 0xffffffff8124aa84 in bm_register_write (file=<optimized out>, buffer=<optimized out>, count=19, ppos=<optimized out>) at fs/binfmt_misc.c:682
> 12 0xffffffff811decd2 in vfs_write (file=file@entry=0xffff888004098500, buf=buf@entry=0xa758d0 ":iiiii:E::ii::i:CF\n", count=count@entry=19, pos=pos@entry=0xffffc9000022ff10) at fs/read_write.c:603
> 13 0xffffffff811defda in ksys_write (fd=<optimized out>, buf=0xa758d0 ":iiiii:E::ii::i:CF\n", count=19) at fs/read_write.c:658
> 14 0xffffffff81b49813 in do_syscall_64 (nr=<optimized out>, regs=0xffffc9000022ff58) at arch/x86/entry/common.c:46
> 15 0xffffffff81c0007c in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:120
> 
> To solve the issue, the open_exec call is moved to before the write
> lock is taken by bm_register_write
> 

Looks good to me.

I assume this is an ancient bug and that a backport to -stable trees
(with a cc:stable) is warranted?
