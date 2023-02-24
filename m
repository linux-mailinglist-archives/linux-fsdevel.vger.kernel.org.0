Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EEE6A17FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 09:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBXIcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 03:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjBXIcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:32:52 -0500
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8F41736
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 00:32:51 -0800 (PST)
Received: by mail-io1-f78.google.com with SMTP id r12-20020a5edb4c000000b007297c4996c7so8038823iop.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 00:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGz0xI/eOTrHpwY7e1zbCubux+0rGm5ClbH4DOLUgSc=;
        b=bM6QyTMDGR+fXC38nFsrUti/VPkLaBPatFrZaMWqUtSPTq1m2I/AcZrbrwed4GDRJ/
         7W4C5wQAxd6moTTcTNPhB3WQ0KjJVzv/bN32lw+AqIsSnF+auGrvYdRfWz867/qUFUNk
         LIveMu97ptx/k8In5bC+b3RY7kDetdb56KcVYpfSQU2mPOarmq9G++vCIlUhvLKaJ1hN
         xoh87ePvsk4y1Ktvv5EVzhA4qDXtHDnRXz4mjZqeTGzJiH3r+OfFVQVbIoyBGoLmlfkd
         Yn1WZR5Q2ELR3gTDLw/g86xPlF/k1apt7pKwa3lUyQU57/Z8hIrDetso5F+X2D3DbJlJ
         qRng==
X-Gm-Message-State: AO0yUKVWXfAo2u3G/i8wMOy1rDORH5VkcZr4R4cRJYJsLEO0upGnKO4K
        kIpo+f+rhnb0h5gPoW0zqX8qQEnwz3TpqxAIsp3JIvojA0GV
X-Google-Smtp-Source: AK7set+iRDLZndKt+NiHRFKoauDMyx0XwSkRPRZmpyLZhRpNE7W6pcCPFmpYpBL07M+ziznBxUqQcz41AULLCr7KjuYbxaRfNq1b
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3499:b0:315:9774:deec with SMTP id
 bp25-20020a056e02349900b003159774deecmr5129526ilb.0.1677227570720; Fri, 24
 Feb 2023 00:32:50 -0800 (PST)
Date:   Fri, 24 Feb 2023 00:32:50 -0800
In-Reply-To: <0000000000007dcc0b05e91943c2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f74e905f56df987@google.com>
Subject: Re: [syzbot] [fs?] [mm?] KMSAN: uninit-value in ondemand_readahead
From:   syzbot <syzbot+8ce7f8308d91e6b8bbe2@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, glider@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    97e36f4aa06f Revert "sched/core: kmsan: do not instrument ..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10e46944c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46c642641b9ef616
dashboard link: https://syzkaller.appspot.com/bug?extid=8ce7f8308d91e6b8bbe2
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143b8650c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a22f2cc80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9931a9627dc6/disk-97e36f4a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1aafdb2fd6dc/vmlinux-97e36f4a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/90df5872c7ff/bzImage-97e36f4a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ea75a01297dd/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ce7f8308d91e6b8bbe2@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 16
=====================================================
BUG: KMSAN: uninit-value in ondemand_readahead+0xddf/0x1720 mm/readahead.c:596
 ondemand_readahead+0xddf/0x1720 mm/readahead.c:596
 page_cache_sync_ra+0x72b/0x760 mm/readahead.c:709
 page_cache_sync_readahead include/linux/pagemap.h:1210 [inline]
 cramfs_blkdev_read fs/cramfs/inode.c:217 [inline]
 cramfs_read+0x611/0x1280 fs/cramfs/inode.c:278
 cramfs_lookup+0x1b8/0x870 fs/cramfs/inode.c:767
 __lookup_slow+0x528/0x730 fs/namei.c:1685
 lookup_slow+0x6a/0xc0 fs/namei.c:1702
 walk_component fs/namei.c:1993 [inline]
 link_path_walk+0xe9a/0x1620 fs/namei.c:2320
 path_openat+0x333/0x5750 fs/namei.c:3710
 do_filp_open+0x24d/0x660 fs/namei.c:3741
 do_sys_openat2+0x1f0/0x910 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_compat_sys_openat fs/open.c:1386 [inline]
 __se_compat_sys_openat fs/open.c:1384 [inline]
 __ia32_compat_sys_openat+0x2ab/0x330 fs/open.c:1384
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Local variable ra.i created at:
 cramfs_blkdev_read fs/cramfs/inode.c:186 [inline]
 cramfs_read+0xc0/0x1280 fs/cramfs/inode.c:278
 cramfs_lookup+0x1b8/0x870 fs/cramfs/inode.c:767

CPU: 1 PID: 5017 Comm: syz-executor948 Not tainted 6.2.0-syzkaller-81152-g97e36f4aa06f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
=====================================================

