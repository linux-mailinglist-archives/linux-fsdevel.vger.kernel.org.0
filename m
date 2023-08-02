Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57A876C4E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 07:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjHBFfi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 01:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjHBFfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:35:36 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBC6ED
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 22:35:32 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b9ef9b1920so9435794a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 22:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690954531; x=1691559331;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puHHKTR7+kIYGy3TDtVRQB3V5vTcG4bvmKPpiu7MjD0=;
        b=jeehPkVnKw+jeQY3Zvi/Ubm29pjoiwxcW1Bu0IRH8RVGxjcZhIBLvpYxua7rZPpgoI
         LsR9xlgGQdxIxqpKD/HLGbHALS4+obvSK9RyMSHiA32064YiSbcbWwhoOqlNCcEG8Zuq
         BISx/viDY0Z2rLgmWQqk2R4DNjrC0ya0FIn7DlsHE6lICLFTYVYFnOEj6rSQneVAa3GX
         xQHWm4ZMPCJj/y9Gqel1CjG5DmijgtwZvaDoB3x1fqYNTFqw7qjflVp7qmjcV1yZQYpj
         2id6QMun2F7CMUJq0luuFmzIVGEy1LQFnNDUUlkvDXh4Jdj+69fSmHzgHVCZnWSBVljV
         1HPw==
X-Gm-Message-State: ABy/qLaunUZfTboSBlUxC4Yke60+KWyp9nTvpXAVIVLxTBsSQfP7AqpN
        K+IjWW/xsnhdDeMfo6vcYXoZ5eiAqQMjFJdgTQZHzsyeaqeo
X-Google-Smtp-Source: APBJJlHY7si2ILDgr7QXRY5rvu2C891Bj4w8mHIftnPeituUSrLziiDOwr7rAfck0qHG1wdjHcj99Z/V86mjPTtoUgjjuSMrEMEa
MIME-Version: 1.0
X-Received: by 2002:a05:6830:2087:b0:6b9:b1b8:bf0b with SMTP id
 y7-20020a056830208700b006b9b1b8bf0bmr15835099otq.0.1690954531329; Tue, 01 Aug
 2023 22:35:31 -0700 (PDT)
Date:   Tue, 01 Aug 2023 22:35:31 -0700
In-Reply-To: <8d17478c-f1d7-d1fa-3012-06b0ba8d534c@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bdb540601ea088c@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
From:   syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nogikh@google.com,
        quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in prepare_to_merge

------------[ cut here ]------------
BTRFS: Transaction aborted (error -117)
WARNING: CPU: 2 PID: 8050 at fs/btrfs/relocation.c:1946 prepare_to_merge+0x10e0/0x1460 fs/btrfs/relocation.c:1946
Modules linked in:
CPU: 2 PID: 8050 Comm: syz-executor.0 Not tainted 6.5.0-rc3-syzkaller-g8b6f9b585045 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:prepare_to_merge+0x10e0/0x1460 fs/btrfs/relocation.c:1946
Code: 8b 7e 50 44 89 e2 48 c7 c6 20 d8 b6 8a e8 28 1d 10 00 eb c1 e8 d1 83 00 fe be 8b ff ff ff 48 c7 c7 80 d7 b6 8a e8 f0 4b c7 fd <0f> 0b e9 bf fe ff ff 48 8b 7c 24 28 e8 af 93 53 fe e9 3e f5 ff ff
RSP: 0018:ffffc90022d4f6b0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88804485e440 RCX: 0000000000000000
RDX: ffff888031a78480 RSI: ffffffff814c5346 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000002d2d2d2d R12: 0000000000000000
R13: 0000000000000084 R14: ffff88804485e3f0 R15: ffff88801d0eb000
FS:  00007f6a3df146c0(0000) GS:ffff88806b800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0a76ac56be CR3: 00000000300a1000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 relocate_block_group+0x8d1/0xe70 fs/btrfs/relocation.c:3779
 btrfs_relocate_block_group+0x714/0xd90 fs/btrfs/relocation.c:4117
 btrfs_relocate_chunk+0x143/0x440 fs/btrfs/volumes.c:3277
 __btrfs_balance fs/btrfs/volumes.c:4012 [inline]
 btrfs_balance+0x20fc/0x3ef0 fs/btrfs/volumes.c:4389
 btrfs_ioctl_balance fs/btrfs/ioctl.c:3604 [inline]
 btrfs_ioctl+0x1362/0x5cf0 fs/btrfs/ioctl.c:4637
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6a3d27cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6a3df140c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6a3d39bf80 RCX: 00007f6a3d27cae9
RDX: 00000000200003c0 RSI: 00000000c4009420 RDI: 0000000000000005
RBP: 00007f6a3d2c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f6a3d39bf80 R15: 00007ffd18ee1568
 </TASK>


Tested on:

commit:         8b6f9b58 btrfs: reject invalid reloc tree root keys
git tree:       https://github.com/adam900710/linux graceful_reloc_mismatch
console output: https://syzkaller.appspot.com/x/log.txt?x=115ab96ea80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23c579cf0ae1addd
dashboard link: https://syzkaller.appspot.com/bug?extid=ae97a827ae1c3336bbb4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
