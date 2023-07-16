Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAAD754CEA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 02:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGPAjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 20:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGPAjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 20:39:53 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C502B271E
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jul 2023 17:39:51 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6b7cb432dd0so4385739a34.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jul 2023 17:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689467991; x=1692059991;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HRENWUX6473hWOYfvczN63G7wz7qzxxc9sTMX76Qkk=;
        b=UHker+x2g62D0YvPJH5PzRNSF0CYhwvQd3aGZ7GpZbx9MgkzUCXs6XPor0zehEP4ar
         PIRULv75l1rCmXCv6vXh01YGBzUPXhVSxQH7SK1L18B09xQCXIC+18hfYiM7WgsxrM6e
         oieYqHnfnwmzVfYqV3jD6EpK4GkO+hgHPW9iW8Iqta5RMsUZUHoBisr4SWBZGo+IXjlS
         SOHSkAqviePyVB8//hhbQii3f+KqV8AWo2QeraNjmMNtRhx4mT0ucDiMXfJL2FpyQKF2
         s3FSfEZOQIPeUjPWYLyMCOUXvUeEjDMm5tmeC7/iqNXsEovhA/uzm+lAE2koJytAkrs5
         IGDg==
X-Gm-Message-State: ABy/qLb4b3lPVBqtif19PS6UJTw/u5z5HJ7hk8b8XhwfhUb12RVMJNia
        KMiX2qVCJDd+byV50W0jhaKG6iFuqOYgqTe3BJZVL/2n+DRC
X-Google-Smtp-Source: APBJJlFWfKTYuvIOAsszfL9DrcUI56VvQS5qJlyU+vqlkFsCpMxoySifryMf7F2v6fiIrN/bJNLnflZmnz8yXbS0iEJmDIWQ/Avd
MIME-Version: 1.0
X-Received: by 2002:a05:6871:6a97:b0:1ba:5296:a97f with SMTP id
 zf23-20020a0568716a9700b001ba5296a97fmr3041132oab.9.1689467991100; Sat, 15
 Jul 2023 17:39:51 -0700 (PDT)
Date:   Sat, 15 Jul 2023 17:39:51 -0700
In-Reply-To: <000000000000459c6205ea318e35@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078172f06008febc9@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in xtSearch
From:   syzbot <syzbot+76a072c2f8a60280bd70@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    b6e6cc1f78c7 Merge tag 'x86_urgent_for_6.5_rc2' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f40fa2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a9506b1ca57ae9f
dashboard link: https://syzkaller.appspot.com/bug?extid=76a072c2f8a60280bd70
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172c5646a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13360a92a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3dfa34d80a41/disk-b6e6cc1f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/778e016c7229/vmlinux-b6e6cc1f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c8001018a584/bzImage-b6e6cc1f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/36bab007b655/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76a072c2f8a60280bd70@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_xtree.c:360:4
index 18 is out of range for type 'xad_t [18]'
CPU: 0 PID: 5017 Comm: syz-executor116 Not tainted 6.5.0-rc1-syzkaller-00248-gb6e6cc1f78c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:348
 xtSearch+0x12e2/0x1650 fs/jfs/jfs_xtree.c:360
 xtLookup+0x273/0x840 fs/jfs/jfs_xtree.c:152
 jfs_get_block+0x325/0xb20 fs/jfs/inode.c:218
 do_mpage_readpage+0x6f8/0x1ab0 fs/mpage.c:234
 mpage_readahead+0x344/0x580 fs/mpage.c:382
 read_pages+0x1d1/0xda0 mm/readahead.c:160
 page_cache_ra_unbounded+0x457/0x5e0 mm/readahead.c:269
 do_page_cache_ra mm/readahead.c:299 [inline]
 page_cache_ra_order+0x72b/0xa80 mm/readahead.c:559
 ondemand_readahead+0x540/0x1150 mm/readahead.c:681
 page_cache_sync_ra+0x174/0x1d0 mm/readahead.c:708
 page_cache_sync_readahead include/linux/pagemap.h:1213 [inline]
 filemap_get_pages+0xc05/0x1820 mm/filemap.c:2563
 filemap_splice_read+0x3d0/0x9f0 mm/filemap.c:2925
 vfs_splice_read fs/splice.c:994 [inline]
 vfs_splice_read+0x2c8/0x3b0 fs/splice.c:963
 splice_direct_to_actor+0x2a5/0xa30 fs/splice.c:1070
 do_splice_direct+0x1af/0x280 fs/splice.c:1195
 do_sendfile+0xb88/0x1390 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1d6/0x220 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9707d0abc9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f97008a5168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f9707d97718 RCX: 00007f9707d0abc9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007f9707d97710 R08: 00007f97008a56c0 R09: 0000000000000000
R10: 0001000000201004 R11: 0000000000000246 R12: 00007f9707d9771c
R13: 000000000000006e R14: 00007ffe2c345d70 R15: 00007ffe2c345e58
 </TASK>
================================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
