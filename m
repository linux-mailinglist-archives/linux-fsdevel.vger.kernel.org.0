Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6769C5A590E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 03:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiH3B67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 21:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiH3B65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:58:57 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDA97AC35
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 18:58:53 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id by6so9814624ljb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Aug 2022 18:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=g/W6JgGQNd0R0s8XaS5i9agOs85nQjdANneFur2Kh6A=;
        b=ODd1wpIXN4RT1h3uVQR/p/1t9/2jLI13ySCdi6DmiDY7lSpTzuc5x2wyCUyYh39Icy
         rifDeQs5sL7cyjxr/i85+o4aphBvmNkKQ9v9CDndvVFjuK+cT1zlmpoYxqCz7MRLkaF4
         IQrsHqj/LAa8l6vavqVCtJmWS6Lzcavld5ap6Qsv3sb9AT0nligIae9KX5DqQ5RbzndJ
         T3ZD122sb2QZccbO/H4UfGT6/8H6USr+v732PiglrNOvAlQgbMF7uZsyoCZywcNBz0f9
         WP9sorqqo/Tj5tsOPFrxf+lw6FKn7J4hT1E1LSceBXtHL6yU3xFE+WugNIQFswOUcnwr
         qhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=g/W6JgGQNd0R0s8XaS5i9agOs85nQjdANneFur2Kh6A=;
        b=sTxVyp2cS0p2wlFvnXPhfTQY6zf/DmpYqUHCpEw+lYDf6UVX+4Yd0QqL9BhtkKCG3E
         pNmDwACMrjrMgdmrDgosKWpPhTt3cuT7GALTTJIyB8nMFU9U3NmxU3CdaNP+h+1EM1wn
         EFhmZz69OG6bJKfzeylj9pG8CwKqQGPQ6Kj3D+pihwmazcVvyI1lBaIwB/pIQR2HB390
         dowbKOq2XIhjjRxVHF20FTA8E2+JWvEqz6qpks2jfkUtl4FNwntfZTF7vlYRdLMeTo48
         AyRhTtvTHw7j+GS1NCYXsU4dIe64KSGPN46O5zWNrtu6dyxp3jLnzQIthykuEnlPAcGm
         zNug==
X-Gm-Message-State: ACgBeo3LKw8fJ5XkgGfsK1ckMjeGgPHG7DTTKVmzrpi4PAQliboANz7J
        w60nCTcVvDxbBwEkYnrlI4JSfSUW6pBxIGZADNuADYTQ76k=
X-Google-Smtp-Source: AA6agR7TYej8b/AzM+ewWrjc7UipLnwIX4STijnoUasN/MWRE/IgqRdHrkyZN1SWjDfEm6Y/pI3DempkRqMYLsl0N0A=
X-Received: by 2002:a05:651c:1591:b0:261:c388:aa58 with SMTP id
 h17-20020a05651c159100b00261c388aa58mr6491303ljq.277.1661824731713; Mon, 29
 Aug 2022 18:58:51 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?67CV7JiB7KSA?= <her0gyugyu@gmail.com>
Date:   Tue, 30 Aug 2022 10:58:15 +0900
Message-ID: <CAJ16EqgEd-BP3XStsR_Cm88Qw2=CTppZo7Ewqv9se+YyzrbzCQ@mail.gmail.com>
Subject: question about fuse livelock situation
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I found fuse livelock situation and report it for possibility of problem.

[Environment]
22.04 5.15.0-43-generic ubuntu kernel.
ntfs-3g version ntfs-3g 2021.8.22 integrated FUSE 28 - Third
Generation NTFS Driver

[Problem]
I bumped on livelock and analyze it. and concluded that it is needed
to be fixed.
it happends when 3 operation concurrently progressing.

1) usb detach by user. and kernel detect it.
2) mount.ntfs umount request & device release operation
3) pool-udisksd umount operation.

[Conclusion]
1. mounted target device file must be released after /dev/fuse
release. it makes deadlocky scenario.
2. fuse file system "fuse_simple_request" should not be waiting
forever. it is hard to solve this situation by interrupting
application. huntask panic configuration make user kernel panic. user
don't know why.

[Analysis]
I got a kernel crash dump file. and analyze it.

here is the scenario description.
![1](https://user-images.githubusercontent.com/66734313/187164968-70880294-97bb-4ed9-807c-21d76b6f8f01.png)

1. kworker detect usb is detached from computer.
it is blocked by umount operation (pool-udiskd)
PID: 8      TASK: ffff88810029e400  CPU: 0   COMMAND: "kworker/0:1"
 #0 [ffffc9000006f6f0] __schedule at ffffffff81d57c0d
 #1 [ffffc9000006f778] schedule at ffffffff81d57fae
 #2 [ffffc9000006f798] rwsem_down_read_slowpath at ffffffff81d5a2de
 #3 [ffffc9000006f830] down_read at ffffffff81d5a373 // wait s_umount
 #4 [ffffc9000006f848] get_super at ffffffff813799ca
 #5 [ffffc9000006f878] fsync_bdev at ffffffff815c6f46
 #6 [ffffc9000006f8a0] delete_partition at ffffffff815e9328
 #7 [ffffc9000006f8c0] blk_drop_partitions at ffffffff815e9b3e
 #8 [ffffc9000006f8e8] del_gendisk at ffffffff815e75f1 // lock mutex
 #9 [ffffc9000006f930] sd_remove at ffffffff818cd325
#10 [ffffc9000006f958] __device_release_driver at ffffffff8184006f
#11 [ffffc9000006f990] device_release_driver at ffffffff818400a9
#12 [ffffc9000006f9b0] bus_remove_device at ffffffff8183f28e
#13 [ffffc9000006f9d8] device_del at ffffffff818399ac
#14 [ffffc9000006fa28] __scsi_remove_device at ffffffff818c2628
#15 [ffffc9000006fa50] scsi_forget_host at ffffffff818c029f
#16 [ffffc9000006fa70] scsi_remove_host at ffffffff818b3727
#17 [ffffc9000006fa98] usb_stor_disconnect at ffffffffc0659b20 [usb_storage]
#18 [ffffc9000006fac0] usb_unbind_interface at ffffffff8194ef30
#19 [ffffc9000006fb18] __device_release_driver at ffffffff8184006f
#20 [ffffc9000006fb50] device_release_driver at ffffffff818400a9
#21 [ffffc9000006fb70] bus_remove_device at ffffffff8183f28e
#22 [ffffc9000006fb98] device_del at ffffffff818399ac
#23 [ffffc9000006fbe8] usb_disable_device at ffffffff8194cdce
#24 [ffffc9000006fc30] usb_disconnect.cold at ffffffff81d19e09
#25 [ffffc9000006fc80] hub_port_connect at ffffffff81944bb8
#26 [ffffc9000006fd00] hub_port_connect_change at ffffffff819454b1
#27 [ffffc9000006fd70] port_event at ffffffff81945d77
#28 [ffffc9000006fe08] hub_event at ffffffff819460a7
#29 [ffffc9000006fe78] process_one_work at ffffffff810d9e7b
#30 [ffffc9000006fec8] worker_thread at ffffffff810da073
#31 [ffffc9000006ff10] kthread at ffffffff810e1cba
#32 [ffffc9000006ff50] ret_from_fork at ffffffff81004bc2


 #3 [ffffc9000006f830] down_read at ffffffff81d5a373
    ffffc9000006f838: [ffff888154d36800:kmalloc-2k] ffffc9000006f870
    ffffc9000006f848: get_super+154

2. it request umount. and release /dev/sdc file before release
/dev/fuse. but. it is blocked by usb detach.
PID: 18681  TASK: ffff88810e5b8000  CPU: 1   COMMAND: "mount.ntfs"
 #0 [ffffc90000ea7c50] __schedule at ffffffff81d57c0d
 #1 [ffffc90000ea7cd8] schedule at ffffffff81d57fae
 #2 [ffffc90000ea7cf8] schedule_preempt_disabled at ffffffff81d5839e
 #3 [ffffc90000ea7d08] __mutex_lock.constprop.0 at ffffffff81d59053
 #4 [ffffc90000ea7d80] __mutex_lock_slowpath at ffffffff81d59353
 #5 [ffffc90000ea7d90] mutex_lock at ffffffff81d59394 // wait open mutex
 #6 [ffffc90000ea7da8] blkdev_put at ffffffff815c765a
 #7 [ffffc90000ea7de0] blkdev_close at ffffffff815c86e7
 #8 [ffffc90000ea7df8] __fput at ffffffff8137704f
 #9 [ffffc90000ea7e30] ____fput at ffffffff8137724e
#10 [ffffc90000ea7e40] task_work_run at ffffffff810deb6d
#11 [ffffc90000ea7e68] exit_to_user_mode_loop at ffffffff81160fc0
#12 [ffffc90000ea7e90] exit_to_user_mode_prepare at ffffffff8116106c
#13 [ffffc90000ea7ea8] syscall_exit_to_user_mode at ffffffff81d4f327
#14 [ffffc90000ea7ec0] do_syscall_64 at ffffffff81d4b1b9
#15 [ffffc90000ea7ef8] exit_to_user_mode_prepare at ffffffff81161007
#16 [ffffc90000ea7f10] syscall_exit_to_user_mode at ffffffff81d4f327
#17 [ffffc90000ea7f28] do_syscall_64 at ffffffff81d4b1b9
    RIP: 00007f3e315fb117  RSP: 00007fff16bcb628  RFLAGS: 00000246
    RAX: 0000000000000000  RBX: 000055cc1b45c710  RCX: 00007f3e315fb117
    RDX: 0000000000000000  RSI: 0000000000000006  RDI: 0000000000000003
    RBP: 000055cc1b45c970   R8: 000055cc1b476940   R9: 0000000000000000
    R10: 0000000000000005  R11: 0000000000000246  R12: 00007f3e314e36c0
    R13: 000055cc1b45c710  R14: 000055cc1b467030  R15: 00000000ffffffff
    ORIG_RAX: 0000000000000003  CS: 0033  SS: 002b


 #3 [ffffc90000ea7d08] __mutex_lock.constprop.0 at ffffffff81d59053
    ffffc90000ea7d10: [ffff8881caad1880:kmalloc-512] 00000002547b2ff8
    ffffc90000ea7d20: [ffff8881caad1880:kmalloc-512]
[ffff8881caad1880:kmalloc-512]
    ffffc90000ea7d30: [ffff88810e5b8000:task_struct] 0000000008000008
    ffffc90000ea7d40: ffffc90000ea7de0 fcee7cb500545100
    ffffc90000ea7d50: [ffff888110f99f40:bdev_cache]
[ffff8881caad1870:kmalloc-512]
    ffffc90000ea7d60: [ffff8881caad1800:kmalloc-512]
[ffff8881caad1870:kmalloc-512]
    ffffc90000ea7d70: [ffff8881bcd4ccc0:dentry] ffffc90000ea7d88
    ffffc90000ea7d80: __mutex_lock_slowpath+19
 #4 [ffffc90000ea7d80] __mutex_lock_slowpath at ffffff

3. we can know that it is releasing /dev/sdc file and not release /dev/fuse.
crash> files 18681
PID: 18681  TASK: ffff88810e5b8000  CPU: 1   COMMAND: "mount.ntfs"
ROOT: /    CWD: /
 FD       FILE            DENTRY           INODE       TYPE PATH
  0 ffff888102f75200 ffff8881020510c0 ffff888100f84668 CHR  /dev/null
  1 ffff888102f75200 ffff8881020510c0 ffff888100f84668 CHR  /dev/null
  2 ffff888102f75200 ffff8881020510c0 ffff888100f84668 CHR  /dev/null
  4 ffff888154001f00 ffff8881020cce40 ffff888100f90f50 CHR  /dev/fuse
  5 ffff888102f74200 ffff8881c2c5dd80 ffff88815db73e40 SOCK UNIX
  8 ffff888106412800 ffff888104785540 ffff888104a9e470 REG  /proc/804/mountinfo
  9 ffff888106412100 ffff888100443840 ffff8881022a9688 REG  /proc/swaps
 14 ffff88810a720700 ffff888104785540 ffff888104a9e470 REG  /proc/804/mountinfo

4. pool udisksd is progressing umount process (cuz uhelper=udisksd2)
but it is waiting forever cuz mount.ntfs does not progress. (if it is
to be released, /dev/fuse
must be released. but mount.ntfs blocked by kworker)

PI3: 18741  TASK: ffff8881a702b200  CPU: 1   COMMAND: "pool-udisksd"
 #0 [ffffc900022a3be8] __schedule at ffffffff81d57c0d
 #1 [ffffc900022a3c70] schedule at ffffffff81d57fae
 #2 [ffffc900022a3c90] request_wait_answer at ffffffff814ea190
 #3 [ffffc900022a3cf0] fuse_simple_request at ffffffff814ec9c1
 #4 [ffffc900022a3d30] fuse_send_destroy at ffffffff814f743f
 #5 [ffffc900022a3db8] fuse_conn_destroy at ffffffff814f7622
 #6 [ffffc900022a3dd0] fuse_kill_sb_blk at ffffffff814f7d82
 #7 [ffffc900022a3e00] deactivate_locked_super at ffffffff8137863b
 #8 [ffffc900022a3e20] deactivate_super at ffffffff813786f0 // lock s_umount
 #9 [ffffc900022a3e38] cleanup_mnt at ffffffff8139f350
#10 [ffffc900022a3e78] __cleanup_mnt at ffffffff8139f422
#11 [ffffc900022a3e88] task_work_run at ffffffff810deb6d
#12 [ffffc900022a3eb0] exit_to_user_mode_loop at ffffffff81160fc0
#13 [ffffc900022a3ed8] exit_to_user_mode_prepare at ffffffff8116106c
#14 [ffffc900022a3ef0] syscall_exit_to_user_mode at ffffffff81d4f327
#15 [ffffc900022a3f08] do_syscall_64 at ffffffff81d4b1b9
#16 [ffffc900022a3f50] entry_SYSCALL_64_after_hwframe at ffffffff81e0007c
    RIP: 00007f110d17bbeb  RSP: 00007f110beb63b8  RFLAGS: 00000246
    RAX: 0000000000000000  RBX: 00007f10fc0257e0  RCX: 00007f110d17bbeb
    RDX: 0000000000000000  RSI: 0000000000000000  RDI: 00007f10fc012bb0
    RBP: 00007f10fc09f480   R8: 0000000000000000   R9: 00007f10fc05edf0
    R10: 00007f10fc05ee30  R11: 0000000000000246  R12: 0000000000000000
    R13: 00007f10fc012bb0  R14: 00007f10fc09f590  R15: 0000000000000000
    ORIG_RAX: 00000000000000a6  CS: 0033  SS: 002b
