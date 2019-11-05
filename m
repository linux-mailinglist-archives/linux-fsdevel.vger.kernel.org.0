Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06EAEF665
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 08:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbfKEH1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 02:27:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39129 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387482AbfKEH1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:27:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id t26so14769099wmi.4;
        Mon, 04 Nov 2019 23:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=u3oNbA4I10/mjIuskX/q0SYWtQUKKiw+bIAOAK1v+YI=;
        b=E09qkUcoc5nFUiOs4ZMnUI5kLeWXUYZANcKpLy8a5kpLoy1tcjJ2E0UcTzG0tx71e6
         MJujARVkXcrHfkkP9T067RIGoZAcuuuWQVj+u8C+x+TQEpKDiWq6+uzDktUXHqvMDR67
         OR5NGG7PqcVZM5hrSBJytOySdIzUwEXx2aKpc4WQGtC5+KmLEQU10BKKMSI9J16o+zs0
         Ye3nN+1xR7yqeHN2V6rEp/lHzlggjPa0coOQLw3FCbsgTDK91JTCgYv0B5eoxON5JK5M
         9n+Ck0V4MUgffQmM9GGf34JoM0SSBwX510SqOimWO1QgqcOjo0vDRo9MDbtNqmNw313r
         xNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=u3oNbA4I10/mjIuskX/q0SYWtQUKKiw+bIAOAK1v+YI=;
        b=i/bukS2dslYtKBsSodPh/WW17RTTt3gnNqzN+859LPlA4DLoGKDu1Zm1nkO0gyEWx6
         NeFQbfxBj3IJsUUldslmrCn/JGw69Bfbj3MkEZVGE3SoGElzNfygnwm5Oi0MlBGVnbaE
         HroItaExdXzxemmqkWgFqWmx3gZh9owIpgfNXYQCw6k/aGKxCo/Ujnxzv5pl0qfCTLMX
         +wlysy2APfO87BJbH6ZBaowWQ9/Ag0mgEr9PJ4IliCPIUI+uITveZMdhN0e8b3PBLYwM
         /ycf+7+I4xiKWul7mh6GrP/7WHlXpi5byTYmDONehq9sE8dHGOo/w59cgLXeWII5xKXR
         auag==
X-Gm-Message-State: APjAAAVeVpOU1N04ZWTL1XlM6OLxzDyevLTqp9xBcCQdzhheFtVEZVm+
        1oLLGBPH66QFloYAdeMvnf52+3PWcx7otDkdFb298+HP
X-Google-Smtp-Source: APXvYqwgS/xVJLOvqdRmTRu6ArMf9NiA/mxQfZbWsZkm1qbyTMNc3VCxdK2jhLA8uWTGXS0f7zjQheAF3GqnJvge+jE=
X-Received: by 2002:a1c:e308:: with SMTP id a8mr2762645wmh.55.1572938861603;
 Mon, 04 Nov 2019 23:27:41 -0800 (PST)
MIME-Version: 1.0
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Tue, 5 Nov 2019 07:27:16 +0000
Message-ID: <CALjAwxiuTYAVvGGUXLx6Bo-zNuW5+WXL=A8DqR5oD6D5tsKwng@mail.gmail.com>
Subject: Tasks blocking forever with XFS stack traces
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We have a system that has been seeing tasks with XFS calls in their
stacks. Once these tasks start hanging with uninterruptible sleep any
write I/O to the directory they were doing I/O to will also hang
forever. The I/O they doing is being done to a bind mounted directory
atop an XFS filesystem on top an MD device (the MD device seems to be
still functional and isn't offline). The kernel is fairly old but I
thought I'd post a stack in case anyone can describe this or has seen
it before:

kernel: [425684.110424] INFO: task kworker/u162:0:58843 blocked for
more than 120 seconds.
kernel: [425684.110800]       Tainted: G           OE
4.15.0-64-generic #73-Ubuntu
kernel: [425684.111164] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
kernel: [425684.111568] kworker/u162:0  D    0 58843      2 0x80000080
kernel: [425684.111581] Workqueue: writeback wb_workfn (flush-9:126)
kernel: [425684.111585] Call Trace:
kernel: [425684.111595]  __schedule+0x24e/0x880
kernel: [425684.111664]  ? xfs_map_blocks+0x82/0x250 [xfs]
kernel: [425684.111668]  schedule+0x2c/0x80
kernel: [425684.111671]  rwsem_down_read_failed+0xf0/0x160
kernel: [425684.111675]  ? bitmap_startwrite+0x9f/0x1f0
kernel: [425684.111679]  call_rwsem_down_read_failed+0x18/0x30
kernel: [425684.111682]  ? call_rwsem_down_read_failed+0x18/0x30
kernel: [425684.111685]  down_read+0x20/0x40
kernel: [425684.111736]  xfs_ilock+0xd5/0x100 [xfs]
kernel: [425684.111782]  xfs_map_blocks+0x82/0x250 [xfs]
kernel: [425684.111823]  xfs_do_writepage+0x167/0x6a0 [xfs]
kernel: [425684.111830]  ? clear_page_dirty_for_io+0x19f/0x1f0
kernel: [425684.111834]  write_cache_pages+0x207/0x4e0
kernel: [425684.111869]  ? xfs_vm_writepages+0xf0/0xf0 [xfs]
kernel: [425684.111875]  ? submit_bio+0x73/0x140
kernel: [425684.111878]  ? submit_bio+0x73/0x140
kernel: [425684.111911]  ? xfs_setfilesize_trans_alloc.isra.13+0x3e/0x90 [xfs]
kernel: [425684.111944]  xfs_vm_writepages+0xbe/0xf0 [xfs]
kernel: [425684.111949]  do_writepages+0x4b/0xe0
kernel: [425684.111954]  ? fprop_fraction_percpu+0x2f/0x80
kernel: [425684.111958]  ? __wb_calc_thresh+0x3e/0x130
kernel: [425684.111963]  __writeback_single_inode+0x45/0x350
kernel: [425684.111966]  ? __writeback_single_inode+0x45/0x350
kernel: [425684.111970]  writeback_sb_inodes+0x1e1/0x510
kernel: [425684.111975]  __writeback_inodes_wb+0x67/0xb0
kernel: [425684.111979]  wb_writeback+0x271/0x300
kernel: [425684.111983]  wb_workfn+0x1bb/0x400
kernel: [425684.111986]  ? wb_workfn+0x1bb/0x400
kernel: [425684.111992]  process_one_work+0x1de/0x420
kernel: [425684.111996]  worker_thread+0x32/0x410
kernel: [425684.111999]  kthread+0x121/0x140
kernel: [425684.112003]  ? process_one_work+0x420/0x420
kernel: [425684.112005]  ? kthread_create_worker_on_cpu+0x70/0x70
kernel: [425684.112009]  ret_from_fork+0x35/0x40
kernel: [425684.112024] INFO: task kworker/74:0:9623 blocked for more
than 120 seconds.
kernel: [425684.112461]       Tainted: G           OE
4.15.0-64-generic #73-Ubuntu
kernel: [425684.112925] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
kernel: [425684.113438] kworker/74:0    D    0  9623      2 0x80000080
kernel: [425684.113500] Workqueue: xfs-cil/md126 xlog_cil_push_work [xfs]
kernel: [425684.113502] Call Trace:
kernel: [425684.113508]  __schedule+0x24e/0x880
kernel: [425684.113559]  ? xlog_bdstrat+0x2b/0x60 [xfs]
kernel: [425684.113564]  schedule+0x2c/0x80
kernel: [425684.113609]  xlog_state_get_iclog_space+0x105/0x2d0 [xfs]
kernel: [425684.113614]  ? wake_up_q+0x80/0x80
kernel: [425684.113656]  xlog_write+0x163/0x6e0 [xfs]
kernel: [425684.113699]  xlog_cil_push+0x2a7/0x410 [xfs]
kernel: [425684.113740]  xlog_cil_push_work+0x15/0x20 [xfs]
kernel: [425684.113743]  process_one_work+0x1de/0x420
kernel: [425684.113747]  worker_thread+0x32/0x410
kernel: [425684.113750]  kthread+0x121/0x140
kernel: [425684.113753]  ? process_one_work+0x420/0x420
kernel: [425684.113756]  ? kthread_create_worker_on_cpu+0x70/0x70
kernel: [425684.113759]  ret_from_fork+0x35/0x40

Other directories on the same filesystem seem fine as do other XFS
filesystems on the same system.

-- 
Sitsofe | http://sucs.org/~sits/
