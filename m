Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB875BE327
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 12:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiITK1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 06:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiITK0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:26:45 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C0C70E6B
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 03:26:40 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id i14-20020a5d934e000000b006892db5bcd4so1168454ioo.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 03:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=+7GYa/bfu8He9Neu0dv/rAd1cD9cFE948uqmZB8ev0E=;
        b=M7K83/hCrxWxTt8A1lmRNxteKsGxIGEeCmPSmbNSWBI/K8Gi1jwnPL9DSqrFS1a7qW
         Qa1v/fN2hRDaT0XuE818YQW4XH/xvJ2cN+a7u6c2MJ1FnDiORn9bG1WFtn1Y7JwYJ43n
         DiBCwTdwUf8DeXdn+Ct/plcTvVocaAKr8kjgPw7TBooiyFa+Mp2uise/P7xD5TQ+I6Se
         K4AG4vUiS9kHHBDGtl/R/Wkbb/DafLKjtafIoMX2P3PLcisRrx1CEMOOGWMu87c2UJTq
         O1H3MerRUK9qYILQhHSJlZFDnCe7FkAVCINVsu3gc/Czx1R6ZPDtNAI+ZjW+RcWLP9MT
         U5Jg==
X-Gm-Message-State: ACrzQf1//UpkepYGCvmOLOa25xUFEr/0SpPYVR+YCKUoMebrltrPY54d
        FoqdkyZwz0vRkvME1QQQ8zJBzT/FaOdU+i0f6Hf3XWMB8qwY
X-Google-Smtp-Source: AMsMyM46YkZcgiL35+Q16+pirzky0DfEkO6SBesqD1GfcPUVhZXdytVW/g5sqG8tN7OXwbf3PwG474P1DQmPozw24yQrh1XBjRLe
MIME-Version: 1.0
X-Received: by 2002:a92:c543:0:b0:2f5:ae52:a023 with SMTP id
 a3-20020a92c543000000b002f5ae52a023mr4289358ilj.118.1663669599322; Tue, 20
 Sep 2022 03:26:39 -0700 (PDT)
Date:   Tue, 20 Sep 2022 03:26:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007dcc0b05e91943c2@google.com>
Subject: [syzbot] KMSAN: uninit-value in ondemand_readahead
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

Hello,

syzbot found the following issue on:

HEAD commit:    8f4ae27df775 Revert "Revert "crypto: kmsan: disable accele..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10b5e0f8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=121c7ef28ec597bd
dashboard link: https://syzkaller.appspot.com/bug?extid=8ce7f8308d91e6b8bbe2
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/4cf4e5a58eb8/disk-8f4ae27d.raw.xz
vmlinux: https://storage.googleapis.com/82e5fbbe1600/vmlinux-8f4ae27d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ce7f8308d91e6b8bbe2@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ondemand_readahead+0x9de/0x1930 mm/readahead.c:586
 ondemand_readahead+0x9de/0x1930 mm/readahead.c:586
 page_cache_sync_ra+0x733/0x770 mm/readahead.c:699
 page_cache_sync_readahead include/linux/pagemap.h:1215 [inline]
 cramfs_blkdev_read+0x5fb/0x12b0 fs/cramfs/inode.c:217
 cramfs_read fs/cramfs/inode.c:278 [inline]
 cramfs_read_folio+0x21e/0x11e0 fs/cramfs/inode.c:827
 read_pages+0x1217/0x16b0 mm/readahead.c:178
 page_cache_ra_unbounded+0x7bf/0x880 mm/readahead.c:263
 do_page_cache_ra mm/readahead.c:293 [inline]
 page_cache_ra_order+0xf50/0x1000 mm/readahead.c:550
 ondemand_readahead+0x10f3/0x1930 mm/readahead.c:672
 page_cache_sync_ra+0x733/0x770 mm/readahead.c:699
 page_cache_sync_readahead include/linux/pagemap.h:1215 [inline]
 filemap_get_pages mm/filemap.c:2566 [inline]
 filemap_read+0xa07/0x3f80 mm/filemap.c:2660
 generic_file_read_iter+0x128/0xaa0 mm/filemap.c:2806
 __kernel_read+0x3c1/0xaa0 fs/read_write.c:428
 integrity_kernel_read+0x80/0xb0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x18b6/0x3e30 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x42f/0xb50 security/integrity/ima/ima_api.c:292
 process_measurement+0x208a/0x3680 security/integrity/ima/ima_main.c:337
 ima_file_check+0xbc/0x120 security/integrity/ima/ima_main.c:517
 do_open fs/namei.c:3559 [inline]
 path_openat+0x497c/0x5600 fs/namei.c:3691
 do_filp_open+0x249/0x660 fs/namei.c:3718
 do_sys_openat2+0x1f0/0x910 fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_compat_sys_openat fs/open.c:1387 [inline]
 __se_compat_sys_openat fs/open.c:1385 [inline]
 __ia32_compat_sys_openat+0x2a7/0x330 fs/open.c:1385
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Local variable ra created at:
 cramfs_blkdev_read+0xbe/0x12b0 fs/cramfs/inode.c:186
 cramfs_read fs/cramfs/inode.c:278 [inline]
 cramfs_read_folio+0x21e/0x11e0 fs/cramfs/inode.c:827

CPU: 0 PID: 4115 Comm: syz-executor.2 Not tainted 6.0.0-rc5-syzkaller-48538-g8f4ae27df775 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
