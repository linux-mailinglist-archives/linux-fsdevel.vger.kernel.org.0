Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF43863927E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 01:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiKZAHx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 19:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKZAHw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:07:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DD0DF7E;
        Fri, 25 Nov 2022 16:07:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48CD36101A;
        Sat, 26 Nov 2022 00:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B10C433C1;
        Sat, 26 Nov 2022 00:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669421269;
        bh=Wa9+Z2zcoHWiPUV8B1ZEnHvwozxO2GsYV8j1FeMJNXw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UYHla2n6vf5fk6sCQ2zx35upgrF/tvwu7XhC4TjSFG0Icb7PsJ+0bqeDN+3P78XEX
         G1aemuMU+gxs9FO+ijq2jGDLxAWyufgdSWO1Pu2D8VC8XBC4GNxVZQlPl/cw6GdQtm
         hfUKBnXg+4DUiX5OXShGcq1PbAvV7+4En68rjdqc=
Date:   Fri, 25 Nov 2022 16:07:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+8c7a4ca1cc31b7ce7070@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org, Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [syzbot] WARNING in iov_iter_revert (3)
Message-Id: <20221125160748.b620ba69dad1bc0fc5f6dea7@linux-foundation.org>
In-Reply-To: <000000000000519d0205ee4ba094@google.com>
References: <000000000000519d0205ee4ba094@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 25 Nov 2022 05:37:43 -0800 syzbot <syzbot+8c7a4ca1cc31b7ce7070@syzkaller.appspotmail.com> wrote:

> Hello,

Thanks.  cc's added.

> syzbot found the following issue on:
> 
> HEAD commit:    eb7081409f94 Linux 6.1-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=105ff881880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdf448d3b35234
> dashboard link: https://syzkaller.appspot.com/bug?extid=8c7a4ca1cc31b7ce7070
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4a019f55c517/disk-eb708140.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/eb36e890aa8b/vmlinux-eb708140.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/feee2c23ec64/bzImage-eb708140.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8c7a4ca1cc31b7ce7070@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 7897 at lib/iov_iter.c:918 iov_iter_revert+0x394/0x850
> Modules linked in:
> CPU: 0 PID: 7897 Comm: syz-executor.2 Not tainted 6.1.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> RIP: 0010:iov_iter_revert+0x394/0x850 lib/iov_iter.c:918
> Code: 80 3c 01 00 48 8b 5c 24 20 74 08 48 89 df e8 e3 c9 a3 fd 4c 89 2b 48 83 c4 68 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 5c b1 4f fd <0f> 0b eb e8 48 8d 6b 18 48 89 e8 48 c1 e8 03 42 80 3c 28 00 74 08
> RSP: 0018:ffffc90015fe7ac8 EFLAGS: 00010287
> RAX: ffffffff843ae714 RBX: ffffc90015fe7e40 RCX: 0000000000040000
> RDX: ffffc9000c1cc000 RSI: 000000000003ef70 RDI: 000000000003ef71
> RBP: fffffffffff80e18 R08: ffffffff843ae3bc R09: fffffbfff1d2f2de
> R10: fffffbfff1d2f2de R11: 1ffffffff1d2f2dd R12: fffffffffff80e18
> R13: ffffc90015fe7e40 R14: ffffc90015fe7e50 R15: 000000007fefef0c
> FS:  00007f212fd7e700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c00c59ffb8 CR3: 000000007dc32000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  generic_file_read_iter+0x3d4/0x540 mm/filemap.c:2804
>  do_iter_read+0x6e3/0xc10 fs/read_write.c:796
>  vfs_readv fs/read_write.c:916 [inline]
>  do_preadv+0x1f4/0x330 fs/read_write.c:1008
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f212f08b639
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f212fd7e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000147
> RAX: ffffffffffffffda RBX: 00007f212f1ac1f0 RCX: 00007f212f08b639
> RDX: 0000000000000001 RSI: 0000000020000100 RDI: 0000000000000003
> RBP: 00007f212f0e6ae9 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffdc886837f R14: 00007f212fd7e300 R15: 0000000000022000
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
