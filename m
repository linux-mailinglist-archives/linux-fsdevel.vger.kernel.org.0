Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2A95FC9DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 19:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJLRYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 13:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJLRYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:24:13 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEBC33A08;
        Wed, 12 Oct 2022 10:24:11 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7DD2921E2;
        Wed, 12 Oct 2022 17:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1665595303;
        bh=roF9FW6LNEApC7ACmNHo6rFK9zKBitkWaBsRohlaeIE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qo4FEAMa2exiSJOm+QXIcfMzT11/AEPhx1leZI4iwurQaJHJQQkWHDtfujqsLdsbC
         sAzTl1BBectd21IOOMSvTyP2wagaOS95eJl/ryTmvjLpC7XO7sbdbM35d14O4HC8S7
         P2wm8z0BPvcH/ub+SqyviTLPdsX4iZ2Gwtdrze1E=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 12 Oct 2022 20:24:08 +0300
Message-ID: <b1f87233-58ae-0a41-8b0e-2e61cb9b70e1@paragon-software.com>
Date:   Wed, 12 Oct 2022 20:24:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [syzbot] BUG: scheduling while atomic in exit_to_user_mode_loop
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+cceb1394467dba9c62d9@syzkaller.appspotmail.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>,
        <ntfs3@lists.linux.dev>
References: <00000000000006aa2405ea93b166@google.com>
 <Y0OWBChTBr86DdNv@casper.infradead.org>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <Y0OWBChTBr86DdNv@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/10/22 06:48, Matthew Wilcox wrote:
> 
> Yet another ntfs bug.  It's getting really noisy.  Maybe stop testing
> ntfs until some more bugs get fixed?
> 

Hello
I think, that we can stop testing ntfs3 because there are several fixes in
development. Until they are pulled in kernel I think it is not necessary
to run these tests.

> On Sat, Oct 08, 2022 at 10:55:34PM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    0326074ff465 Merge tag 'net-next-6.1' of git://git.kernel...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15b1382a880000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d323d85b1f8a4ed7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=cceb1394467dba9c62d9
>> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1755e8b2880000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/c40d70ae7512/disk-0326074f.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/3603ce065271/vmlinux-0326074f.xz
>> mounted in repro: https://storage.googleapis.com/syzbot-assets/738016e3c6ba/mount_1.gz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+cceb1394467dba9c62d9@syzkaller.appspotmail.com
>>
>> ntfs3: loop2: Different NTFS' sector size (1024) and media sector size (512)
>> BUG: scheduling while atomic: syz-executor.2/9901/0x00000002
>> 2 locks held by syz-executor.2/9901:
>>   #0: ffff888075f880e0 (&type->s_umount_key#47/1){+.+.}-{3:3}, at: alloc_super+0x212/0x920 fs/super.c:228
>>   #1: ffff8880678e78f0 (&sb->s_type->i_lock_key#33){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
>>   #1: ffff8880678e78f0 (&sb->s_type->i_lock_key#33){+.+.}-{2:2}, at: _atomic_dec_and_lock+0x9d/0x110 lib/dec_and_lock.c:28
>> Modules linked in:
>> Preemption disabled at:
>> [<0000000000000000>] 0x0
>> Kernel panic - not syncing: scheduling while atomic
>> CPU: 1 PID: 9901 Comm: syz-executor.2 Not tainted 6.0.0-syzkaller-02734-g0326074ff465 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
>> Call Trace:
>>   <TASK>
>>   __dump_stack lib/dump_stack.c:88 [inline]
>>   dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
>>   panic+0x2d6/0x715 kernel/panic.c:274
>>   __schedule_bug+0x1ff/0x250 kernel/sched/core.c:5725
>>   schedule_debug+0x1d3/0x3c0 kernel/sched/core.c:5754
>>   __schedule+0xfb/0xdf0 kernel/sched/core.c:6389
>>   schedule+0xcb/0x190 kernel/sched/core.c:6571
>>   exit_to_user_mode_loop+0xe5/0x150 kernel/entry/common.c:157
>>   exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:201
>>   irqentry_exit_to_user_mode+0x5/0x30 kernel/entry/common.c:307
>>   asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
>> RIP: 000f:lock_acquire+0x1e1/0x3c0
>> RSP: 0018:ffffc9000563f900 EFLAGS: 00000206
>> RAX: 1ffff92000ac7f28 RBX: 0000000000000001 RCX: ffff8880753be2f0
>> RDX: dffffc0000000000 RSI: ffffffff8a8d9060 RDI: ffffffff8aecb5e0
>> RBP: ffffc9000563fa28 R08: dffffc0000000000 R09: fffffbfff1fc4229
>> R10: fffffbfff1fc4229 R11: 1ffffffff1fc4228 R12: dffffc0000000000
>> R13: 1ffff92000ac7f24 R14: ffffc9000563f940 R15: 0000000000000246
>>   </TASK>
>> Kernel Offset: disabled
>> Rebooting in 86400 seconds..
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> syzbot can test patches for this issue, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
