Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6667970CDF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 00:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjEVWaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 18:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEVWae (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 18:30:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DD7109;
        Mon, 22 May 2023 15:30:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F1A91FEE9;
        Mon, 22 May 2023 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684794629;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IeRR5m7pzmYl0Ar1i40Qz7t46CN66yxFsAZx3v44EHU=;
        b=Jap4uBpt/3Lv0r4uwtIXQs5YMDLXLHNqVr8awKTjJfu7Jm4SXSbejyUPeoGE0HErl7gTTB
        8zouQEyamI58E3NEpwP50QCFUAucK3g67chaMgaSAgIgE/hSnW1sO5T8u0GFEgBjOWM1WU
        GR3/fYV3CM5uiFvauunL7Xboso65hcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684794629;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IeRR5m7pzmYl0Ar1i40Qz7t46CN66yxFsAZx3v44EHU=;
        b=U7jiNNzH8JgsrPETLfiG5MvKnieVlLXd8gjx4wwkJBaEMXzTT35rdx7/8duEbUmElG6hTl
        VkiJBrxnQml0aDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2BB713776;
        Mon, 22 May 2023 22:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M6coOgTta2RQfQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 May 2023 22:30:28 +0000
Date:   Tue, 23 May 2023 00:24:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     syzbot <syzbot+5e466383663438b99b44@syzkaller.appspotmail.com>
Cc:     chris@chrisdown.name, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiaoshoukui@gmail.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_exclop_balance (2)
Message-ID: <20230522222422.GV32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000725cab05f55f1bb0@google.com>
 <000000000000e7582c05fafc8901@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e7582c05fafc8901@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 06:43:55PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    7163a2111f6c Merge tag 'acpi-6.4-rc1-3' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=175bb84c280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
> dashboard link: https://syzkaller.appspot.com/bug?extid=5e466383663438b99b44
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12048338280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ff7314280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/01051811f2fe/disk-7163a211.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a26c68e4c8a6/vmlinux-7163a211.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/17380fb8dad4/bzImage-7163a211.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/b30a249e8609/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5e466383663438b99b44@syzkaller.appspotmail.com
> 
> assertion failed: fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED, in fs/btrfs/ioctl.c:463

Looks like syzbot was able to hit another problem, the above assertion
is from a recent fix ac868bc9d136 ("btrfs: fix assertion of exclop
condition when starting balance").

> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/messages.c:259!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 8630 Comm: syz-executor102 Not tainted 6.3.0-syzkaller-13225-g7163a2111f6c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
> RIP: 0010:btrfs_assertfail+0x18/0x20 fs/btrfs/messages.c:259
> Code: df e8 2c 05 36 f7 e9 50 fb ff ff e8 b2 90 01 00 66 90 66 0f 1f 00 89 d1 48 89 f2 48 89 fe 48 c7 c7 80 32 2c 8b e8 c8 60 ff ff <0f> 0b 66 0f 1f 44 00 00 66 0f 1f 00 53 48 89 fb e8 73 31 de f6 48
> RSP: 0018:ffffc9000ae27e48 EFLAGS: 00010246
> RAX: 0000000000000066 RBX: 1ffff1100fa13c18 RCX: e812ce05a9b3c300
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000000000000002 R08: ffffffff816f0fec R09: fffff520015c4f7d
> R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88807d09e0c0
> R13: ffff88807d09c000 R14: ffff88807d09c678 R15: dffffc0000000000
> FS:  00007f2bb10a8700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2bb0c90000 CR3: 0000000028447000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  btrfs_exclop_balance+0x153/0x1f0 fs/btrfs/ioctl.c:463
>  btrfs_ioctl_balance+0x482/0x7c0 fs/btrfs/ioctl.c:3562
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f2bb853ec69
> RSP: 002b:00007f2bb10a82f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f2bb85c87c0 RCX: 00007f2bb853ec69

If this could be relevant as some error code, RAX 0xda is -38 which is
ENOSYS, so there might be some combination of balance parameters that is
unexpected.

> RDX: 0000000020000540 RSI: 00000000c4009420 RDI: 0000000000000004
> RBP: 00007f2bb85951d0 R08: 00007f2bb10a8700 R09: 0000000000000000
> R10: 00007f2bb10a8700 R11: 0000000000000246 R12: 7fffffffffffffff
> R13: 0000000100000001 R14: 8000000000000001 R15: 00007f2bb85c87c8
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:btrfs_assertfail+0x18/0x20 fs/btrfs/messages.c:259
> RSP: 0018:ffffc9000ae27e48 EFLAGS: 00010246
> RAX: 0000000000000066 RBX: 1ffff1100fa13c18 RCX: e812ce05a9b3c300
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000000000000002 R08: ffffffff816f0fec R09: fffff520015c4f7d
> R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88807d09e0c0
> R13: ffff88807d09c000 R14: ffff88807d09c678 R15: dffffc0000000000
> FS:  00007f2bb10a8700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2bb0c90000 CR3: 0000000028447000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
