Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 087D8191C3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 22:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgCXVsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 17:48:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38056 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbgCXVsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:48:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGrNd-001z3G-WE; Tue, 24 Mar 2020 21:46:38 +0000
Date:   Tue, 24 Mar 2020 21:46:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Null-ptr-deref due to "sanitized pathwalk machinery (v4)"
Message-ID: <20200324214637.GI23230@ZenIV.linux.org.uk>
References: <4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:06:03PM -0400, Qian Cai wrote:
> Reverted the series on the top of today's linux-next fixed boot crashes.

Umm...  How about a reproducer (or bisect of vfs.git#work.dotdot, assuming
it reproduces there)?

> [   53.027443][ T3519] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [   53.027480][ T3519] Faulting instruction address: 0xc0000000004dbfa4
> [   53.027498][ T3519] Oops: Kernel access of bad area, sig: 11 [#1]
> [   53.027521][ T3519] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256 DEBUG_PAGEALLOC NUMA PowerNV
> [   53.027538][ T3519] Modules linked in: kvm_hv kvm ip_tables x_tables xfs sd_mod bnx2x ahci libahci mdio libata tg3 libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
> [   53.027594][ T3519] CPU: 36 PID: 3519 Comm: polkitd Not tainted 5.6.0-rc7-next-20200324 #1
> [   53.027618][ T3519] NIP:  c0000000004dbfa4 LR: c0000000004dc040 CTR: 0000000000000000
> [   53.027634][ T3519] REGS: c0002013879af810 TRAP: 0300   Not tainted  (5.6.0-rc7-next-20200324)
> [   53.027668][ T3519] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24004422  XER: 20040000
> [   53.027708][ T3519] CFAR: c0000000004dc044 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0 
> [   53.027708][ T3519] GPR00: c0000000004dc040 c0002013879afaa0 c00000000165a500 0000000000000000 
> [   53.027708][ T3519] GPR04: c000000001511408 0000000000000000 c0002013879af834 0000000000000002 
> [   53.027708][ T3519] GPR08: 0000000000000001 0000000000000000 0000000000000000 0000000000000001 
> [   53.027708][ T3519] GPR12: 0000000000004000 c000001ffffe1e00 0000000000000000 0000000000000000 
> [   53.027708][ T3519] GPR16: 0000000000000000 0000000000000001 0000000000000000 0000000000000000 
> [   53.027708][ T3519] GPR20: c000200ea1eacf38 c000201c8102f043 2f2f2f2f2f2f2f2f 0000000000000003 
> [   53.027708][ T3519] GPR24: 0000000000000000 c0002013879afbc8 fffffffffffff000 0000000000200000 
> [   53.027708][ T3519] GPR28: ffffffffffffffff 61c8864680b583eb 0000000000000000 0000000000002e2e 
> [   53.027931][ T3519] NIP [c0000000004dbfa4] link_path_walk+0x284/0x4c0
> __d_entry_type at include/linux/dcache.h:389
> (inlined by) d_can_lookup at include/linux/dcache.h:404
> (inlined by) link_path_walk at fs/namei.c:2178

... and apparently NULL nd->path.dentry there.  After walk_component()
having returned NULL.  Which means either handle_dots() returning NULL
or step_into() doing the same.  The former means either (for "..")
step_into() having returned NULL, or nd->path.dentry left unchanged.

So we either have step_into() returning NULL with nd->path.dentry ending up
NULL, or we'd entered link_path_walk() with nd->path.dentry being NULL (it
must have been that way on the entry, or we would've barfed on the previous
iteration).

1) step_into() returns NULL either after
        if (likely(!d_is_symlink(path.dentry)) ||
           ((flags & WALK_TRAILING) && !(nd->flags & LOOKUP_FOLLOW)) ||
           (flags & WALK_NOFOLLOW)) {
                /* not a symlink or should not follow */
                if (!(nd->flags & LOOKUP_RCU)) {
                        dput(nd->path.dentry);
                        if (nd->path.mnt != path.mnt)
                                mntput(nd->path.mnt);
                }  
                nd->path = path;
                nd->inode = inode;
                nd->seq = seq;
                return NULL;
in which case nd->path.dentry is left equal to path.dentry, which can't be
NULL (we would've oopsed on d_is_symlink() if it had been) or it's
pick_link() returning NULL and leaving NULL nd->path.dentry.

pick_link() either leaves nd->path unchanged (in which case we are back to
the "had NULL nd->path.dentry on entry into link_path_walk()") or does
nd_jump_root() (absolute symlinks) or has ->get_link() call nd_jump_link().
nd_jump_root() cannot survive leaving NULL in ->path.dentry - it hits
either
                d = nd->path.dentry;
                nd->inode = d->d_inode;
or
                nd->inode = nd->path.dentry->d_inode;
and either would've ooped right there.
nd_jump_link() hits
        nd->inode = nd->path.dentry->d_inode;
on the way out, which also should be impossible to survive.

So we appear to have hit link_path_walk() with NULL nd->path.dentry.  And
it's path_lookupat() from vfs_statx(), so we don't have LOOKUP_DOWN there.
Which means either path_init() leaving NULL nd->path.dentry or lookup_last()
returning NULL and leaving NULL nd->path.dentry...  The latter is basically
walk_component(), so we would've had left link_path_walk() without an
error, with symlink picked and with NULL nd->path.dentry.  Which means
having the previous call of link_path_walk() also entered with NULL
nd->path.dentry...

OK, so it looks like path_init() returning a string and leaving that...
And I don't see any way for that to happen...


Right, so...  Could you slap the following
	if (WARN_ON(!nd->path.dentry))
		printk(KERN_ERR "pathname = %s\n", nd->name->name);
1) into beginning of link_path_walk(), right before
        while (*name=='/')
                name++;
        if (!*name)
                return 0;
in there.
2) into pick_link(), right after
all_done: // pure jump

and see what your reproducer catches?
