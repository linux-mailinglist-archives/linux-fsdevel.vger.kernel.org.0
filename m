Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCED542220
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiFHC6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 22:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389307AbiFHCvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:51:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E9519DE66;
        Tue,  7 Jun 2022 17:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DWz3ui5LEc+ma9xRBMOzP5TNgLacSn29NUs51MHH6ts=; b=SLGVsJreRbNRapKv7nn3fCnPys
        WY1SXMwHi9Ol2YNzcPnIxzzZzmIgJqnEXtRNK8boz+cJiSeNfUNBl1oB6kWi0cRIYJU8pG00eVByM
        PbxYR//4JrTD5EipxGyZfFA1+tO2+qUig056zxwEtxrWy0Lm50xF55swy0x4ZoNuiRetFpFVqzVux
        v/5jNa6sU0ntS4uQgm2lGszboCh15NwY84ymFu4ZkLg8YG2+GHndFkfHLxLO4H5UkDewANxGPd8QI
        X+PcshUvqyhWG/UqknDGQk7ypT7s6n/Mjq0hiEiyzgdyTsANm9wda+nB/7ITdQuVvknyfv/P0Z4SI
        4boh4R+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyjU4-00C9jC-Ix; Wed, 08 Jun 2022 00:23:40 +0000
Date:   Wed, 8 Jun 2022 01:23:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+2c93b863a7698df84bad@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Subject: Re: [syzbot] WARNING: locking bug in truncate_inode_pages_final
Message-ID: <Yp/sDLP+eHXDzumt@casper.infradead.org>
References: <0000000000000cf8be05e0d65e09@google.com>
 <20220607160020.c088f4d29929310f2a3c1c32@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607160020.c088f4d29929310f2a3c1c32@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:00:20PM -0700, Andrew Morton wrote:
> Lots of cc's added.

That's a shame.  See my other reply for why this report tells us
almost nothing.  It might be ntfs related, but even that isn't certain.

> On Tue, 07 Jun 2022 00:16:29 -0700 syzbot <syzbot+2c93b863a7698df84bad@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> 
> Thanks.
> 
> > syzbot found the following issue on:
> 
> Oh dear.
> 
> > HEAD commit:    d1dc87763f40 assoc_array: Fix BUG_ON during garbage collect
> 
> I think this bisection is wrong.
> 
> I sure hope it's wrong - that patch went straight from the mailing list
> into mainline and two days later was added to what appears to be every
> -stable kernel we own.  It spent no time in -next except for a week or
> so when I was sitting on an earlier version.
> 
> But I think the bisection is wrong.  I don't see how d1dc87763f40 can
> affect ntfs3 and pagecache truncate.
> 
> Does that testcase even use the security keyrings code?  I'd be
> suspicious of ntfs3 here.
> 
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14979947f00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c51cd24814bb5665
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2c93b863a7698df84bad
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> 
> Confused.  How is it possible to do a git-bisect without a reproducer?
> 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+2c93b863a7698df84bad@syzkaller.appspotmail.com
> > 
> > ntfs3: loop3: Different NTFS' sector size (2048) and media sector size (512)
> > ntfs3: loop3: Different NTFS' sector size (2048) and media sector size (512)
> > ------------[ cut here ]------------
> > releasing a pinned lock
> > WARNING: CPU: 2 PID: 21856 at kernel/locking/lockdep.c:5349 __lock_release kernel/locking/lockdep.c:5349 [inline]
> > WARNING: CPU: 2 PID: 21856 at kernel/locking/lockdep.c:5349 lock_release+0x6a9/0x780 kernel/locking/lockdep.c:5685
> > Modules linked in:
> > CPU: 2 PID: 21856 Comm: syz-executor.3 Not tainted 5.18.0-syzkaller-11972-gd1dc87763f40 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> > RIP: 0010:__lock_release kernel/locking/lockdep.c:5349 [inline]
> > RIP: 0010:lock_release+0x6a9/0x780 kernel/locking/lockdep.c:5685
> > Code: 68 00 e9 5a fa ff ff 4c 89 f7 e8 f2 3d 68 00 e9 36 fc ff ff e8 78 3d 68 00 e9 f5 fb ff ff 48 c7 c7 e0 9a cc 89 e8 d1 84 d3 07 <0f> 0b e9 87 fb ff ff e8 3b b3 18 08 48 c7 c7 4c 44 bb 8d e8 4f 3d
> > RSP: 0018:ffffc90003497a00 EFLAGS: 00010082
> > RAX: 0000000000000000 RBX: ffff88801e742c48 RCX: 0000000000000000
> > RDX: 0000000000040000 RSI: ffffffff81601908 RDI: fffff52000692f32
> > RBP: 1ffff92000692f42 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000080000001 R11: 0000000000000001 R12: ffff88804fb22498
> > R13: 0000000000000002 R14: ffff88801e742c18 R15: ffff88801e7421c0
> > FS:  00007f64be4cb700(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f64be4cc000 CR3: 00000000669a7000 CR4: 0000000000150ee0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 000000000000003b DR6: 00000000ffff0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:157 [inline]
> >  _raw_spin_unlock_irq+0x12/0x40 kernel/locking/spinlock.c:202
> >  spin_unlock_irq include/linux/spinlock.h:399 [inline]
> >  truncate_inode_pages_final+0x5f/0x80 mm/truncate.c:484
> >  ntfs_evict_inode+0x16/0xa0 fs/ntfs3/inode.c:1750
> >  evict+0x2ed/0x6b0 fs/inode.c:664
> >  iput_final fs/inode.c:1744 [inline]
> >  iput.part.0+0x562/0x820 fs/inode.c:1770
> >  iput+0x58/0x70 fs/inode.c:1760
> >  ntfs_fill_super+0x2d66/0x3730 fs/ntfs3/super.c:1180
> >  get_tree_bdev+0x440/0x760 fs/super.c:1292
> >  vfs_get_tree+0x89/0x2f0 fs/super.c:1497
> >  do_new_mount fs/namespace.c:3040 [inline]
> >  path_mount+0x1320/0x1fa0 fs/namespace.c:3370
> >  do_mount fs/namespace.c:3383 [inline]
> >  __do_sys_mount fs/namespace.c:3591 [inline]
> >  __se_sys_mount fs/namespace.c:3568 [inline]
> >  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7f64bd28a63a
> > Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f64be4caf88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> > RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f64bd28a63a
> > RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f64be4cafe0
> > RBP: 00007f64be4cb020 R08: 00007f64be4cb020 R09: 0000000020000000
> > R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000
> > R13: 0000000020000100 R14: 00007f64be4cafe0 R15: 000000002007a980
> >  </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
