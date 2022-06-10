Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B78E545988
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 03:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiFJBY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 21:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiFJBY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:24:27 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96A72DA81
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 18:24:25 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id x5-20020a923005000000b002d1a91c4d13so18751998ile.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 18:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=n0Ch7+DU9ChBm9opkEwvPaHDcGkdnzEb2XEWkE5Tbz0=;
        b=nopkFsa9kTwfqLGWKgCd+UU3tGSpN5Cwed+aJ9GDASghKZivIXWr0nDRVT4TPT9uuP
         4GiNdyiJmv24lfRgWb1tiXBnJ9FVuLdzxR74nD4HA7yrYOH359iOS/DvzcaOxJHX6P9u
         p++RrKjbnfAjz0RMSnYgHMx54BeE27qhwtilJ+D/pJbig0w0UOf6PIomFmN394yeIDl9
         ZU4GPv1tXC1idzpxnzHq+qyLSrunynUwgezLEZpBEsdkM45vpRS6UzCjaKnB3p+m99Xl
         0TBpAsZTNot/O3I9+ZMAQTEOlsCqv4UJR8uBSiFAF3viX98SMTk9b+R9/7T1LW0AXoeB
         uG6w==
X-Gm-Message-State: AOAM530iCXL6i/IZCe17kZQZdV+MLM+5PQ86cgB2vOfHlbIgtvzw0lfe
        /TCAU/nhP8SAMvQgl3T3NhOEZOnlulsJAbnyTMovB5h66kpZ
X-Google-Smtp-Source: ABdhPJzjg59yvuNzBbkLIKpk4zMOxAOYYp7M22Dj8lcRIyMUNweOFwHFy1SP9AuENBe/T7CDUhVXJxniffYE8syJyYpyU1X5G7Bh
MIME-Version: 1.0
X-Received: by 2002:a92:c242:0:b0:2d1:e04f:43c0 with SMTP id
 k2-20020a92c242000000b002d1e04f43c0mr23944404ilo.111.1654824265255; Thu, 09
 Jun 2022 18:24:25 -0700 (PDT)
Date:   Thu, 09 Jun 2022 18:24:25 -0700
In-Reply-To: <0000000000003ce9d105e0db53c8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f13ca05e10dccc0@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in copy_page_from_iter_atomic (2)
From:   syzbot <syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ff539ac73ea5 Add linux-next specific files for 20220609
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1627d920080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5002042f00a8bce
dashboard link: https://syzkaller.appspot.com/bug?extid=d2dd123304b4ae59f1bd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d6d7cff00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1113b2bff00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com

BTRFS error (device loop0): bad tree block start, want 30490624 have 0
==================================================================
BUG: KASAN: use-after-free in copy_page_from_iter_atomic+0xef6/0x1b30 lib/iov_iter.c:969
Read of size 4096 at addr ffff888170801000 by task kworker/u4:0/8

CPU: 0 PID: 8 Comm: kworker/u4:0 Not tainted 5.19.0-rc1-next-20220609-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: loop0 loop_rootcg_workfn
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 memcpy+0x20/0x60 mm/kasan/shadow.c:65
 copy_page_from_iter_atomic+0xef6/0x1b30 lib/iov_iter.c:969
 generic_perform_write+0x2b8/0x560 mm/filemap.c:3735
 __generic_file_write_iter+0x2aa/0x4d0 mm/filemap.c:3855
 generic_file_write_iter+0xd7/0x220 mm/filemap.c:3887
 call_write_iter include/linux/fs.h:2057 [inline]
 do_iter_readv_writev+0x3d1/0x640 fs/read_write.c:742
 do_iter_write+0x182/0x700 fs/read_write.c:868
 vfs_iter_write+0x70/0xa0 fs/read_write.c:909
 lo_write_bvec drivers/block/loop.c:249 [inline]
 lo_write_simple drivers/block/loop.c:271 [inline]
 do_req_filebacked drivers/block/loop.c:495 [inline]
 loop_handle_cmd drivers/block/loop.c:1859 [inline]
 loop_process_work+0xd83/0x2050 drivers/block/loop.c:1894
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0005c20040 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x170801
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000000000 ffffea0005c20048 ffffea0005c20048 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff888170800f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888170800f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888170801000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff888170801080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888170801100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

