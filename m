Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2242173CE06
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jun 2023 04:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjFYCVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jun 2023 22:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjFYCVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jun 2023 22:21:46 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28521AB
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jun 2023 19:21:44 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-77e23d23eccso91116039f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jun 2023 19:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687659704; x=1690251704;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+EwnMDRCODIH9OqO4aAf82Xo3JQ4joGMJA2Ab/bmTY=;
        b=ldVftp8FYN4Ckb16G35gQm3eZmXscrpCa7ryOj/SIFYwMCdmmAcU7CUa5RRF2j97LW
         1dAg+Te77cIE8NweMsiLjQWsaGCZzQfAaF/Zy8IinQNnY59dfutb2CcF80zVnRMvckWY
         539oB9e7/wDQG7vDQxJa/JfoA2SZP4BznpctZ8ZJgSHa6ks5lH348QK9qgCkwzR9UFJ8
         WatU/wVxKi98u0c8Vz7iXXJ9tysiNnP/Fc7gB0riPPmtIISNGxH8l6srCu670Bv+b5W4
         4rhmAILjJd9sytUaHH49pSluKbIEIV2zMswXA4wgmOYxYfwA5j/WNvUQ8NP95pFzHAo7
         O8vA==
X-Gm-Message-State: AC+VfDzdnqW8eHbsGJ1NZWF8sKARWriHQO7SrBkG4CFjVDgVMGpzFRA5
        uFd8b/2a36Lv8uy32pkLRh1jBYkDN3R9b4bIuSWpQ4vdGgN/
X-Google-Smtp-Source: ACHHUZ5tEHhNcFESJbRkIz286gsVjRiamwYztupd+uu8b6VLN5PWmbK6tE8EQUI8zVSd+hnlR/UoTYnn2rTj2NkWH6aE1q0LcIz2
MIME-Version: 1.0
X-Received: by 2002:a6b:7f02:0:b0:780:da2d:b80d with SMTP id
 l2-20020a6b7f02000000b00780da2db80dmr2071141ioq.1.1687659704091; Sat, 24 Jun
 2023 19:21:44 -0700 (PDT)
Date:   Sat, 24 Jun 2023 19:21:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a0b1305feeae5db@google.com>
Subject: [syzbot] [ext4?] general protection fault in ext4_put_io_end_defer
From:   syzbot <syzbot+94a8c779c6b238870393@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f7efed9f38f8 Add linux-next specific files for 20230616
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=152e89f3280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60b1a32485a77c16
dashboard link: https://syzkaller.appspot.com/bug?extid=94a8c779c6b238870393
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116af1eb280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e22d2f280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95bcbee03439/disk-f7efed9f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fd295caa4de/vmlinux-f7efed9f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69c038a34b5f/bzImage-f7efed9f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94a8c779c6b238870393@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc00000000c5: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000628-0x000000000000062f]
CPU: 1 PID: 5032 Comm: syz-executor136 Not tainted 6.4.0-rc6-next-20230616-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:EXT4_SB fs/ext4/ext4.h:1741 [inline]
RIP: 0010:ext4_add_complete_io fs/ext4/page-io.c:225 [inline]
RIP: 0010:ext4_put_io_end_defer fs/ext4/page-io.c:297 [inline]
RIP: 0010:ext4_put_io_end_defer+0x162/0x460 fs/ext4/page-io.c:289
Code: c1 ea 03 80 3c 02 00 0f 85 b9 02 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 6c 24 28 49 8d bd 28 06 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 c0 02 00 00 f7 d3 31 ff 4d 8b ad 28 06 00 00 83
RSP: 0000:ffffc900001e0cb8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000100
RDX: 00000000000000c5 RSI: ffffffff8234a5d2 RDI: 0000000000000628
RBP: ffff888076af2180 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88807f3ee6b0
R13: 0000000000000000 R14: ffff8880213eb400 R15: ffff8880213eb3d8
FS:  0000555556fc0300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002a18c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 ext4_end_bio+0x282/0x560 fs/ext4/page-io.c:359
 bio_endio+0x589/0x690 block/bio.c:1617
 req_bio_endio block/blk-mq.c:766 [inline]
 blk_update_request+0x56b/0x14f0 block/blk-mq.c:911
 scsi_end_request+0x7a/0xa20 drivers/scsi/scsi_lib.c:541
 scsi_io_completion+0x17b/0x1770 drivers/scsi/scsi_lib.c:978
 scsi_complete+0x126/0x3b0 drivers/scsi/scsi_lib.c:1442
 blk_complete_reqs+0xb3/0xf0 block/blk-mq.c:1110
 __do_softirq+0x1d4/0x905 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:200
Code: f6 da 90 02 66 0f 1f 44 00 00 f3 0f 1e fa 48 8b be b0 01 00 00 e8 b0 ff ff ff 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 <f3> 0f 1e fa 65 8b 05 1d 58 7f 7e 89 c1 48 8b 34 24 81 e1 00 01 00
RSP: 0000:ffffc900039df500 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff8880265c1dc0 RSI: ffffffff81687255 RDI: 0000000000000007
RBP: ffffffff8d4ba518 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000200 R11: 00000000000000d4 R12: 0000000000000000
R13: ffffffff8d4ba4c0 R14: dffffc0000000000 R15: 0000000000000001
 console_emit_next_record arch/x86/include/asm/irqflags.h:42 [inline]
 console_flush_all+0x61b/0xcc0 kernel/printk/printk.c:2933
 console_unlock+0xb8/0x1f0 kernel/printk/printk.c:3007
 vprintk_emit+0x1bd/0x600 kernel/printk/printk.c:2307
 vprintk+0x84/0xa0 kernel/printk/printk_safe.c:50
 _printk+0xbf/0xf0 kernel/printk/printk.c:2328
 __list_add_valid+0xb9/0x100 lib/list_debug.c:30
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 list_lru_add+0x298/0x520 mm/list_lru.c:129
 d_lru_add fs/dcache.c:431 [inline]
 retain_dentry fs/dcache.c:685 [inline]
 dput+0x806/0xe10 fs/dcache.c:908
 do_unlinkat+0x3f3/0x680 fs/namei.c:4398
 do_coredump+0x1836/0x4040 fs/coredump.c:675
 get_signal+0x1c16/0x25f0 kernel/signal.c:2863
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 exc_page_fault+0xc0/0x170 arch/x86/mm/fault.c:1593
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f7d17d7ce13
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5032 at arch/x86/mm/tlb.c:1295 nmi_uaccess_okay+0x99/0xb0 arch/x86/mm/tlb.c:1295
Modules linked in:
CPU: 1 PID: 5032 Comm: syz-executor136 Not tainted 6.4.0-rc6-next-20230616-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:nmi_uaccess_okay+0x99/0xb0 arch/x86/mm/tlb.c:1295
Code: d8 48 ba 00 f0 ff ff ff ff 0f 00 41 b8 01 00 00 00 48 21 d0 48 ba 00 00 00 00 80 88 ff ff 48 01 d0 48 39 85 80 00 00 00 74 b0 <0f> 0b eb ac 0f 0b eb a0 e8 ba d5 9d 00 eb 8d e8 b3 d5 9d 00 eb be
RSP: 0000:ffffc900001e0938 EFLAGS: 00010007
RAX: ffff88802a18c000 RBX: ffff88807f50b600 RCX: 0000000000000100
RDX: ffff888000000000 RSI: ffffffff8a11653d RDI: ffff88807f50b680
RBP: ffff88807f50b600 R08: 0000000000000001 R09: 00007f7d17d7cde9
R10: 00007f7d17d7ce29 R11: 0000000000096001 R12: 00007f7d17d7cde9
R13: 00007f7d17d7ce29 R14: 0000000000000000 R15: ffffc900001e0aa8
FS:  0000555556fc0300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002a18c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 copy_from_user_nmi+0x62/0x150 arch/x86/lib/usercopy.c:39
 copy_code arch/x86/kernel/dumpstack.c:91 [inline]
 show_opcodes+0x5d/0xd0 arch/x86/kernel/dumpstack.c:121
 show_ip arch/x86/kernel/dumpstack.c:144 [inline]
 show_iret_regs+0x30/0x60 arch/x86/kernel/dumpstack.c:149
 __show_regs+0x22/0x680 arch/x86/kernel/process_64.c:75
 show_trace_log_lvl+0x255/0x390 arch/x86/kernel/dumpstack.c:301
 __die_body arch/x86/kernel/dumpstack.c:420 [inline]
 die_addr+0x3c/0xa0 arch/x86/kernel/dumpstack.c:460
 __exc_general_protection arch/x86/kernel/traps.c:783 [inline]
 exc_general_protection+0x129/0x230 arch/x86/kernel/traps.c:728
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
RIP: 0010:EXT4_SB fs/ext4/ext4.h:1741 [inline]
RIP: 0010:ext4_add_complete_io fs/ext4/page-io.c:225 [inline]
RIP: 0010:ext4_put_io_end_defer fs/ext4/page-io.c:297 [inline]
RIP: 0010:ext4_put_io_end_defer+0x162/0x460 fs/ext4/page-io.c:289
Code: c1 ea 03 80 3c 02 00 0f 85 b9 02 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b 6c 24 28 49 8d bd 28 06 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 c0 02 00 00 f7 d3 31 ff 4d 8b ad 28 06 00 00 83
RSP: 0000:ffffc900001e0cb8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000100
RDX: 00000000000000c5 RSI: ffffffff8234a5d2 RDI: 0000000000000628
RBP: ffff888076af2180 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88807f3ee6b0
R13: 0000000000000000 R14: ffff8880213eb400 R15: ffff8880213eb3d8
 ext4_end_bio+0x282/0x560 fs/ext4/page-io.c:359
 bio_endio+0x589/0x690 block/bio.c:1617
 req_bio_endio block/blk-mq.c:766 [inline]
 blk_update_request+0x56b/0x14f0 block/blk-mq.c:911
 scsi_end_request+0x7a/0xa20 drivers/scsi/scsi_lib.c:541
 scsi_io_completion+0x17b/0x1770 drivers/scsi/scsi_lib.c:978
 scsi_complete+0x126/0x3b0 drivers/scsi/scsi_lib.c:1442
 blk_complete_reqs+0xb3/0xf0 block/blk-mq.c:1110
 __do_softirq+0x1d4/0x905 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:200
Code: f6 da 90 02 66 0f 1f 44 00 00 f3 0f 1e fa 48 8b be b0 01 00 00 e8 b0 ff ff ff 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 <f3> 0f 1e fa 65 8b 05 1d 58 7f 7e 89 c1 48 8b 34 24 81 e1 00 01 00
RSP: 0000:ffffc900039df500 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff8880265c1dc0 RSI: ffffffff81687255 RDI: 0000000000000007
RBP: ffffffff8d4ba518 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000200 R11: 00000000000000d4 R12: 0000000000000000
R13: ffffffff8d4ba4c0 R14: dffffc0000000000 R15: 0000000000000001
 console_emit_next_record arch/x86/include/asm/irqflags.h:42 [inline]
 console_flush_all+0x61b/0xcc0 kernel/printk/printk.c:2933
 console_unlock+0xb8/0x1f0 kernel/printk/printk.c:3007
 vprintk_emit+0x1bd/0x600 kernel/printk/printk.c:2307
 vprintk+0x84/0xa0 kernel/printk/printk_safe.c:50
 _printk+0xbf/0xf0 kernel/printk/printk.c:2328
 __list_add_valid+0xb9/0x100 lib/list_debug.c:30
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 list_lru_add+0x298/0x520 mm/list_lru.c:129
 d_lru_add fs/dcache.c:431 [inline]
 retain_dentry fs/dcache.c:685 [inline]
 dput+0x806/0xe10 fs/dcache.c:908
 do_unlinkat+0x3f3/0x680 fs/namei.c:4398
 do_coredump+0x1836/0x4040 fs/coredump.c:675
 get_signal+0x1c16/0x25f0 kernel/signal.c:2863
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 exc_page_fault+0xc0/0x170 arch/x86/mm/fault.c:1593
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f7d17d7ce13
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 002b:00007ffecfb11b00 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000014024 RCX: 00007f7d17d95071
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000001b1 R08: 0000000000000000 R09: 00007ffecfbcc080
R10: 0000000000000000 R11: 0000000000000000 R12: 00007ffecfb11b64
R13: 00007ffecfb11bc0 R14: 00000000000000d7 R15: 431bde82d7b634db
 </TASK>
----------------
Code disassembly (best guess):
   0:	c1 ea 03             	shr    $0x3,%edx
   3:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   7:	0f 85 b9 02 00 00    	jne    0x2c6
   d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  14:	fc ff df
  17:	4d 8b 6c 24 28       	mov    0x28(%r12),%r13
  1c:	49 8d bd 28 06 00 00 	lea    0x628(%r13),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 c0 02 00 00    	jne    0x2f4
  34:	f7 d3                	not    %ebx
  36:	31 ff                	xor    %edi,%edi
  38:	4d 8b ad 28 06 00 00 	mov    0x628(%r13),%r13
  3f:	83                   	.byte 0x83


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
