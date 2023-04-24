Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56B46EC7E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 10:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjDXI2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 04:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDXI2C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:28:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55412B0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 01:28:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4efea87c578so2294e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682324879; x=1684916879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UQV8qz7rXi58bwtsOBC95I/F9EqRXuGTyW82YTYj27I=;
        b=DHXlAhx/AweCzyZoNYEnALE4ZrZKyco4KzL+ra+v+IClbMb3kUDbb+hXXWseDqibNl
         Bifgl628evb1ihVDEDdkfH+/blhaj/8k5Ff+ltHdZko1x7DPU/2Qi7andMjfOSGPwIS+
         +XNKETLAHMSx/dMB4gMtzXQ8XwelI1nZz9Jw7Ty8Cy8iRrlFMvZkJuWwmEylxdw+4PzK
         PYrkSj8J/bRPpQvM1mGqzBcNflRnY55k+g0GGlZAYhODXDjoP1x5QCQ1o/vfU5nbW+AT
         24D3LXizMIN21WA2U4TLEV9Is+gsVDIRS9azP6vf5dpcDn53W4otFlg2J1wpq7iN59I8
         rfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682324879; x=1684916879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQV8qz7rXi58bwtsOBC95I/F9EqRXuGTyW82YTYj27I=;
        b=S970cLBJh+QM/wCcFIuk1Wxygjw7evw6COHsCRtYB5gJInv4xcKJyY5OBG+HL/m94s
         uusJ03XODcwutjawxh0Z7oXAdKHVaZtX/ak/8yk7sykbsc9Pmi7g2dTUsGC8xFsYqKRw
         HOo0RdKQ5KnHQSzWaBICCjbtli3BhwFUsd/0UtvLeXW7PjLcBtcL1St6RAbYAAxTEEZo
         7B5tk3F7CFqCsu7SJr27Y0s59b7KyudiqjScmC7/9W9akR/M9a9P/LBQSLq/L2tAbmYE
         hLWKfqqRcan4s+3NEBVKRewH4xjEQyPDv98DDl6q3VcYGtk6Udvs5NAqFB9bxAbWWAX2
         3emA==
X-Gm-Message-State: AAQBX9db47gyWJ/tLB5nKcm5J3onadxB3VKis7/UlxhTgmCgOUn40c3I
        are5XX97XzYWbkncGhplSMZON2WvxwByQAdgDBirow==
X-Google-Smtp-Source: AKy350ZMfTZ3x+FDN0JgQJxvxJuM8ruY2/N8Lp71PLM7q8GD3WxeGGzLvw/lBuwidlpDKloGnJvyYU8AXxxw/w/eTgc=
X-Received: by 2002:a05:6512:e94:b0:4da:cd0a:3724 with SMTP id
 bi20-20020a0565120e9400b004dacd0a3724mr175644lfb.4.1682324879244; Mon, 24 Apr
 2023 01:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c2e89505fa108749@google.com>
In-Reply-To: <000000000000c2e89505fa108749@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Apr 2023 10:27:46 +0200
Message-ID: <CACT4Y+arm0wqa=GbrTpH4UJrc-OCq3dwvTKa9k-yxoPLtwnbHQ@mail.gmail.com>
Subject: Re: [syzbot] [fs?] KCSAN: data-race in inotify_handle_inode_event / inotify_remove_from_idr
To:     syzbot <syzbot+4a06d4373fd52f0b2f9c@syzkaller.appspotmail.com>
Cc:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Apr 2023 at 10:09, syzbot
<syzbot+4a06d4373fd52f0b2f9c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    622322f53c6d Merge tag 'mips-fixes_6.3_2' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1482ffafc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4baf7c6b35b5d5
> dashboard link: https://syzkaller.appspot.com/bug?extid=4a06d4373fd52f0b2f9c
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8b5f31d96315/disk-622322f5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/adca7dc8daae/vmlinux-622322f5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ed78ddc31ccb/bzImage-622322f5.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4a06d4373fd52f0b2f9c@syzkaller.appspotmail.com

If I am reading this correctly, userspace can get wd=-1 as the result
of this race. Docs say wd must refer to a previously allocated
descriptor, which is positive. I don't see any mentions of semantics
of wd=-1.

> ==================================================================
> BUG: KCSAN: data-race in inotify_handle_inode_event / inotify_remove_from_idr
>
> write to 0xffff888104e31368 of 4 bytes by task 3229 on cpu 1:
>  inotify_remove_from_idr+0x106/0x310 fs/notify/inotify/inotify_user.c:511
>  inotify_ignored_and_remove_idr+0x34/0x60 fs/notify/inotify/inotify_user.c:532
>  inotify_freeing_mark+0x1d/0x30 fs/notify/inotify/inotify_fsnotify.c:133
>  fsnotify_free_mark fs/notify/mark.c:490 [inline]
>  fsnotify_destroy_mark+0x17a/0x190 fs/notify/mark.c:499
>  __do_sys_inotify_rm_watch fs/notify/inotify/inotify_user.c:817 [inline]
>  __se_sys_inotify_rm_watch+0xf7/0x170 fs/notify/inotify/inotify_user.c:794
>  __x64_sys_inotify_rm_watch+0x31/0x40 fs/notify/inotify/inotify_user.c:794
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff888104e31368 of 4 bytes by task 3638 on cpu 0:
>  inotify_handle_inode_event+0x17e/0x2c0 fs/notify/inotify/inotify_fsnotify.c:113
>  fsnotify_handle_inode_event+0x19b/0x1f0 fs/notify/fsnotify.c:264
>  fsnotify_handle_event fs/notify/fsnotify.c:316 [inline]
>  send_to_group fs/notify/fsnotify.c:364 [inline]
>  fsnotify+0x101c/0x1150 fs/notify/fsnotify.c:570
>  __fsnotify_parent+0x307/0x480 fs/notify/fsnotify.c:230
>  fsnotify_parent include/linux/fsnotify.h:77 [inline]
>  fsnotify_file include/linux/fsnotify.h:99 [inline]
>  fsnotify_close include/linux/fsnotify.h:341 [inline]
>  __fput+0x4b0/0x570 fs/file_table.c:307
>  ____fput+0x15/0x20 fs/file_table.c:349
>  task_work_run+0x123/0x160 kernel/task_work.c:179
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop+0xd1/0xe0 kernel/entry/common.c:171
>  exit_to_user_mode_prepare+0x6c/0xb0 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
>  syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:297
>  do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> value changed: 0x00000060 -> 0xffffffff
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 3638 Comm: syz-executor.0 Not tainted 6.3.0-rc7-syzkaller-00191-g622322f53c6d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000c2e89505fa108749%40google.com.
