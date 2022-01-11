Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C856C48AEFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 14:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiAKN5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 08:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiAKN5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:57:11 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CC6C06173F;
        Tue, 11 Jan 2022 05:57:11 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id p187so5002162ybc.0;
        Tue, 11 Jan 2022 05:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jp3Bszp6UFf7UyCmveFRsPqGiMkiDRerOmO8TUL8zpU=;
        b=TGX5L5jiacqzJLHAJWZP/ZyTjIe9qVrC+82IDcD8VZzmqWKM2OI6wub4UTjnwhbjSD
         ahbcpLwNK8KqeZcFQ5G8EeEW+DUUSlPjYI+N+YFCffRs6/veThnz2bHl0QVCo/FOTId/
         LwfS5fINbpcmjrM/T6jhXEcD051UOQKNSp2vWAkjqPhr9l2CFqYUI0YE/3+lgnbzrf/g
         /L+7YPzzO/RvUnaNDYtpUgFkXu7c4ghb5FFMOzCqxl9EyjvzVmGDKe8RLVj4Q9CxRyHb
         mBfQU6gyTwwQjOlHByFgTXjUgOg2AgUsuD4aHJQA2HsH99en5DVdmgKunsn81qhedncq
         0flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jp3Bszp6UFf7UyCmveFRsPqGiMkiDRerOmO8TUL8zpU=;
        b=GCyToszbUlOwPujtkLDPzK0GQYLwg0bNpV1wAuSrzNJi6cKrt4iU5VgtvEh2MP5iV8
         826AXGNNwK7FBqyeMNKNt1IJKSkl4VlxIqlW0YTiOtSvIjQtBfJoHADSe75Bkhp8bjXS
         M4b8DB4Z6V1JsXehCwBoVdCcx3uDYrEBQOoQxZF8xb92gUiUN3V44R0TjUlDyt7GFtEA
         NXV0gWOUMfxh0OL0KI5bAfo4lFrtHnCqjz2UCBPTbRFyRiBBXYNEawAd4QTFklsQpJLO
         WiCpt1H24yws9vbJL3X8FeFtook3M3HeBM83WKGKcNr2RVgZ2ozvHhgUUCsnMQznSATL
         DGSA==
X-Gm-Message-State: AOAM530ByNt6KHqcGD6QGNbRjIp12tXRM8iMhEs9/gR5fyvWlPh5Q8sg
        ZlIZKcy/lYAt709Mu4Rh5EysrrDwZ+K3RvpKBAQ=
X-Google-Smtp-Source: ABdhPJwSvd21XhbfItq1iKt5zF7MkbKdvkcIPO4OgyXSRn9i/WfeSh/ykuFw6lGD0zTEr5tFKQvNbNkGjdlboA7u+sY=
X-Received: by 2002:a25:7751:: with SMTP id s78mr6327368ybc.434.1641909430550;
 Tue, 11 Jan 2022 05:57:10 -0800 (PST)
MIME-Version: 1.0
From:   Kaia Yadira <hypericumperforatum4444@gmail.com>
Date:   Tue, 11 Jan 2022 21:56:59 +0800
Message-ID: <CACDmwr_J0ZoS+TJcKTMXR+H9K0A0y=X22EGxiqdq6sHFDaGD0A@mail.gmail.com>
Subject: KCSAN: data-race in task_mem / unmap_region
To:     jgg@ziepe.ca, rcampbell@nvidia.com, aarcange@redhat.com,
        david@redhat.com, apopple@nvidia.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Cc:     sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

When using Syzkaller to fuzz the latest Linux kernel, the following
crash was triggered.

HEAD commit: a7904a538933 Linux 5.16-rc6
git tree: upstream
console output: KCSAN: data-race in task_mem / unmap_region
kernel config: https://paste.ubuntu.com/p/QB39MJKWKb/plain/
Syzlang reproducer: https://paste.ubuntu.com/p/q2DVwVh6hr/plain/

If you fix this issue, please add the following tag to the commit:

Reported-by: Hypericum <hypericumperforatum4444@gmail.com>

I think fs/proc/task_mmu.c visits the variable mm without locking and
another mmap visits mm->hiwater_vm resulting in a data race.

reproducer log: https://paste.ubuntu.com/p/Sp6RDWKDfy/plain/
reproducer report:
==================================================================
BUG: KCSAN: data-race in task_mem / unmap_region

write to 0xffff8881095008b0 of 8 bytes by task 3712 on cpu 4:
 update_hiwater_rss include/linux/mm.h:2102 [inline]
 unmap_region+0x12b/0x1e0 mm/mmap.c:2648
 __do_munmap+0xe6e/0x12b0 mm/mmap.c:2883
 __vm_munmap mm/mmap.c:2906 [inline]
 __do_sys_munmap+0x9f/0x160 mm/mmap.c:2932
 __se_sys_munmap mm/mmap.c:2928 [inline]
 __x64_sys_munmap+0x2d/0x40 mm/mmap.c:2928
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

read to 0xffff8881095008b0 of 8 bytes by task 1512 on cpu 7:
 task_mem+0xfb/0x3d0 fs/proc/task_mmu.c:50
 proc_pid_status+0x890/0x14d0 fs/proc/array.c:438
 proc_single_show+0x84/0x100 fs/proc/base.c:778
 seq_read_iter+0x2e3/0x930 fs/seq_file.c:230
 seq_read+0x234/0x280 fs/seq_file.c:162
 vfs_read+0x1e6/0x730 fs/read_write.c:479
 ksys_read+0xd9/0x190 fs/read_write.c:619
 __do_sys_read fs/read_write.c:629 [inline]
 __se_sys_read fs/read_write.c:627 [inline]
 __x64_sys_read+0x3e/0x50 fs/read_write.c:627
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

value changed: 0x000000000000065b -> 0x0000000000000662

Reported by Kernel Concurrency Sanitizer on:
CPU: 7 PID: 1512 Comm: systemd-journal Not tainted 5.16.0-rc8+ #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
==================================================================
