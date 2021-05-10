Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5F5378F21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbhEJNdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 09:33:46 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:33696 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344806AbhEJMUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 08:20:23 -0400
Received: by mail-il1-f198.google.com with SMTP id l6-20020a056e021c06b02901b9680ed93eso3584987ilh.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 05:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eYJwuDZ+XsqRKCRKIvwFZzV5wcwkB59FcbGmaKLVifw=;
        b=o7Zhc5gblRiaDPt+K76QMehZ6HuGHSIueLT0v0oFJKoqbmO8bn1YkPCp9tK/ASfSJ8
         /pqlYXWRYHUexfU+tv4deYzsGgycClvRJPOXPv7AuxIW+RGRuL+YOAjPaH5fJWF3eWpL
         SeTSMRvAgH46Oyj9eeCDc97bJKLO08p7vlM9qcHTZXdOBQJySw64yLcahNFRidZUK61r
         0+jPbx7OrpXJAGftJCaOfENgJNdm8158h6Z3Nj/Q9ESCeR2oWV7TD3HOTDRHvqPuo84O
         4pPvdu+uqlIGts/9Ub+pvqoNu+Mh0a8vgtyG/mcjZqjiRc6YIWB3GA6kg+mAQs1N0pYG
         mePg==
X-Gm-Message-State: AOAM532+z+t633VemjnsXlrnNwkbULT4iqmmn3fDFtpHCaiHs/pmclMw
        zijWdtg2o2puGDcVJwpfDUMli0/0gbbtaKcRjvoq6om+Dckk
X-Google-Smtp-Source: ABdhPJyFK7D1jwvXUWQ6WVwkji1paIyU97HyrhX4bG6k0z3W/BkrqxebK0x1iuSYmhw44Dkty51TcsDtORPoQdIK2afFatUJ5DMg
MIME-Version: 1.0
X-Received: by 2002:a92:cd85:: with SMTP id r5mr21276631ilb.169.1620649158349;
 Mon, 10 May 2021 05:19:18 -0700 (PDT)
Date:   Mon, 10 May 2021 05:19:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063a4b605c1f8c94b@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in do_mpage_readpage
From:   syzbot <syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes.berg@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11dfac0dd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d360b81e47df40ea
dashboard link: https://syzkaller.appspot.com/bug?extid=cf89d662483d6a1a0790
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17051fc3d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163ab395d00000

The issue was bisected to:

commit dcd479e10a0510522a5d88b29b8f79ea3467d501
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Fri Oct 9 12:17:11 2020 +0000

    mac80211: always wind down STA state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10795f2dd00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12795f2dd00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14795f2dd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
Fixes: dcd479e10a05 ("mac80211: always wind down STA state")

================================================================================
UBSAN: shift-out-of-bounds in fs/mpage.c:189:40
shift exponent 4294967279 is too large for 64-bit type 'long long unsigned int'
CPU: 1 PID: 8457 Comm: systemd-udevd Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
 do_mpage_readpage.cold+0x226/0x2bb fs/mpage.c:189
 mpage_readahead+0x3a3/0x880 fs/mpage.c:389
 read_pages+0x1df/0x8d0 mm/readahead.c:130
 page_cache_ra_unbounded+0x61f/0x920 mm/readahead.c:238
 do_page_cache_ra mm/readahead.c:267 [inline]
 force_page_cache_ra+0x3ba/0x5b0 mm/readahead.c:299
 page_cache_sync_ra+0x107/0x200 mm/readahead.c:573
 page_cache_sync_readahead include/linux/pagemap.h:864 [inline]
 filemap_get_pages+0x29f/0x1920 mm/filemap.c:2442
 filemap_read+0x2ca/0xe40 mm/filemap.c:2525
 generic_file_read_iter+0x397/0x4f0 mm/filemap.c:2676
 blkdev_read_iter+0x11b/0x180 fs/block_dev.c:1720
 call_read_iter include/linux/fs.h:2110 [inline]
 new_sync_read+0x41e/0x6e0 fs/read_write.c:415
 vfs_read+0x35c/0x570 fs/read_write.c:496
 ksys_read+0x12d/0x250 fs/read_write.c:634
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fdc7280d210
Code: 73 01 c3 48 8b 0d 98 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d b9 c1 20 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 4e fc ff ff 48 89 04 24
RSP: 002


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
