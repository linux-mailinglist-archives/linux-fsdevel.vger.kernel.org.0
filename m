Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E003948A572
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 03:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346518AbiAKCLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jan 2022 21:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344038AbiAKCLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:11:06 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FA4C06173F;
        Mon, 10 Jan 2022 18:11:06 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id v186so33936303ybg.1;
        Mon, 10 Jan 2022 18:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=A7XN1/9DkdNPIW6uAaFqSqp7tSwx5tIJEtLK6jywVVo=;
        b=QizAn2caBcSOuLPCOHHf3kvuZ2cvSYbe8LkmMYcxo941RbBdWqpzkaZQxFYPlSNMRJ
         0h9BtYZpCKoyxt+E8Z4rCbQ8QeX6PML24pFDDSdu8+Ogis8Ry/t9L7i8C2IUPDayp/tk
         ou7E8+LxUYDy6gpytIoJc0zvHvZTcnyPDOeaNmusXIQRVTNgFLCnL0WLA9BnxItCYGM0
         OzFbuuIx464XDcR8AE2pPWpYbu4A6+kgRgy5tsCJgV/0aBQDurP9f3O3excCUCNU/0Ai
         Hqrc0ObXGDP3cbeL9S/H8G0cEhKa+At3i5HBjZbgQNoO5V7m7ZIIp+XP8A/oOuqnSB46
         eNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A7XN1/9DkdNPIW6uAaFqSqp7tSwx5tIJEtLK6jywVVo=;
        b=FJpUimFPYHoLPmuFKUwphh1h5yCDsezkZHyNkmUYW+2jEt5fO4jvSaPfZ3i1n5wDel
         J2NEZltdAQ9Vc/S7OndessbAo9t1hR9nXIix+oGZifasiyt+x9QFTbZDfL027F5X2xq5
         8bAbnEsmXUwYSoSJwIPBeUkzdkZpVkdMBXDdWe846Gw2ycXyMHtvC4I5Y/Oj22ww6rRP
         gsWSoEQMUbELAyQ1S7IP83Oss7TjYmzpc4KRuuNLITxRqYrrqaQBm1X+8GyO1Mdaoz6Z
         gY9H5CToZ6G+OUQ4wEbVJ5/PLLvtRqdfcNvLUCFykcPLjPpmmWeqvt9S82ZTWb1AXfFJ
         j/lQ==
X-Gm-Message-State: AOAM532NbCxqad+3fPEv0yZsLr/ttDFUB940RN7rCNkmDwmpwk5aD/mk
        FrEqWaUKKTOnRwzs6Bu6UoziqlnMNbz/k5CZOiucGAgBzMxGhaNfQzM=
X-Google-Smtp-Source: ABdhPJyRM4fiafUKN0ESArgShhOGihu/0Nfdqvo1T+Xfkq+LLnVcwFiM9dNbRRI9J6q0VUmsPkHOwpmjrdOygXSrpds=
X-Received: by 2002:a25:348b:: with SMTP id b133mr3642048yba.21.1641867065708;
 Mon, 10 Jan 2022 18:11:05 -0800 (PST)
MIME-Version: 1.0
From:   cruise k <cruise4k@gmail.com>
Date:   Tue, 11 Jan 2022 10:10:55 +0800
Message-ID: <CAKcFiNBC9-kkW1xgQ=5YjxeqpmM5Fh9yks0E6WGniB7JoHGTNw@mail.gmail.com>
Subject: INFO: task hung in lock_rename
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Syzkaller found the following issue:

HEAD commit: 75acfdb Linux 5.16-rc8
git tree: upstream
console output: https://pastebin.com/raw/yWmdPX93
kernel config: https://pastebin.com/raw/XsnKfdRt

And hope the report log can help you.


INFO: task syz-executor.8:28108 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc8+ #10
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.8  state:D stack:28384 pid:28108 ppid:  6926 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2550 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 rwsem_down_write_slowpath+0x664/0x1190 kernel/locking/rwsem.c:1151
 __down_write_common kernel/locking/rwsem.c:1268 [inline]
 __down_write_common kernel/locking/rwsem.c:1265 [inline]
 __down_write kernel/locking/rwsem.c:1277 [inline]
 down_write_nested+0x139/0x150 kernel/locking/rwsem.c:1634
 inode_lock_nested include/linux/fs.h:818 [inline]
 lock_rename+0x225/0x280 fs/namei.c:2915
 do_renameat2+0x486/0xbe0 fs/namei.c:4718
 __do_sys_renameat fs/namei.c:4817 [inline]
 __se_sys_renameat fs/namei.c:4814 [inline]
 __x64_sys_renameat+0xbf/0xf0 fs/namei.c:4814
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f2adfe6689d
RSP: 002b:00007f2ade7b6c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000108
RAX: ffffffffffffffda RBX: 00007f2adff86030 RCX: 00007f2adfe6689d
RDX: 0000000000000003 RSI: 0000000020000140 RDI: 0000000000000005
RBP: 00007f2adfed300d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000a00 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe3cfabf3f R14: 00007f2adff86030 R15: 00007f2ade7b6dc0
 </TASK>
