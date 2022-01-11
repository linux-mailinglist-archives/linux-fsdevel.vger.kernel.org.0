Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94C048AE6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 14:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbiAKN3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 08:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiAKN3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:29:34 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97009C06173F;
        Tue, 11 Jan 2022 05:29:34 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id g14so18748529ybs.8;
        Tue, 11 Jan 2022 05:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jL+yPSB/x8F3npn1ApaD1l+3nlGvKvDyURY4vjl6cjk=;
        b=PBuDYGZeIwCcDpXJCYSBxIwHB7BJ5t2zQ0lahrmzemAvzmzimIXgjU/rYz6l0MtTyK
         2HHrE9ppSHjg18RTs+v+AK7+vfNLIuD7hEOCrVsKWr+t5EStZkRC6HN//KJFK8TqGkYC
         FePJKOwbsV4EEPHBZ7pKHeHQC/UBGieXsnJGmgPp4Mq40qqbvQxT3KQ4qJQ5+gfXoo9h
         vXWsx3Izd2LM0vjuBXWJvISZVgMVDL6HUKaavTDE/JgmHp2XQ6TvkD2K1ViE8fz9MIKt
         TizgZo0RMP4NgFKcOSgmSnjwR/SZZierPfS3bVhZcMdjXbPNOQ7iMu4/Z0tEUmXbxKam
         v24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jL+yPSB/x8F3npn1ApaD1l+3nlGvKvDyURY4vjl6cjk=;
        b=Xk4efCegRYo7mytQrVJxr0jVLRJcC7XeDnbgFyMpbly8Bj8kLVBuA66i9tI3H+TF2X
         EWL6nWWjam8CG98TJ+7CNt6+m7mqEUWDmJUEdsYpoDmkTt3BRWVAN5pRSRyWBQbdcDfn
         cArkbJCKRlXv+HzgJELqyyLVzUVrI1NPDg84MytZ5+jVRuCjBifSr9niPg6EWy+bA47w
         /1S6VoiuAJ5sBFk9yn9rd2G4v+RABa5Zm6nCvszg9jyln3Ytptl5Wik/pxiShEIFC+aV
         93Vo7C2QOTKEF/uU+I+6GVG36hnWgGR87NGlFtiN0pBsatCDF0SSbtUjQvmDr5K804PN
         wlWA==
X-Gm-Message-State: AOAM5317RTVNHptfTBwK0fsZSYASe64KD4wysGusNxiVAQi68KwfPK1E
        +O+XcuUVMUIHyNdtpUoAt0vap7arVJdlQhUuCYY=
X-Google-Smtp-Source: ABdhPJyHlIrey4/cjQgBVGtOy7gYF3fLifZxYuLIUX8n9ONzUtNiWpsPRX0o0X/lBfo/3uF7iRbtnhZnJl3KAGLMge4=
X-Received: by 2002:a25:b00b:: with SMTP id q11mr85198ybf.421.1641907773833;
 Tue, 11 Jan 2022 05:29:33 -0800 (PST)
MIME-Version: 1.0
From:   Kaia Yadira <hypericumperforatum4444@gmail.com>
Date:   Tue, 11 Jan 2022 21:29:22 +0800
Message-ID: <CACDmwr-0J1C=8Eba9bX9sCRdxVmF_u370xWoNo5vnTr4giUPCw@mail.gmail.com>
Subject: KCSAN: data-race in step_into / vfs_unlink
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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
console output: KCSAN: data-race in step_into / vfs_unlink
kernel config: https://paste.ubuntu.com/p/QB39MJKWKb/plain/
Syzlang reproducer: https://paste.ubuntu.com/p/qQPrVRrYfb/plain/

If you fix this issue, please add the following tag to the commit:

Reported-by: Hypericum <hypericumperforatum4444@gmail.com>

I think the program data race at the both reading and read/write at
the dentry->d_flags

reproducer log: https://paste.ubuntu.com/p/2xsqF6W3sB/plain/
reproducer report:

==================================================================
BUG: KCSAN: data-race in step_into / vfs_unlink

read-write to 0xffff88810a3899c0 of 4 bytes by task 5771 on cpu 1:
 dont_mount include/linux/dcache.h:358 [inline]
 vfs_unlink+0x28e/0x440 fs/namei.c:4102
 do_unlinkat+0x278/0x540 fs/namei.c:4167
 __do_sys_unlink fs/namei.c:4215 [inline]
 __se_sys_unlink fs/namei.c:4213 [inline]
 __x64_sys_unlink+0x2c/0x30 fs/namei.c:4213
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

read to 0xffff88810a3899c0 of 4 bytes by task 1537 on cpu 5:
 __follow_mount_rcu fs/namei.c:1429 [inline]
 handle_mounts fs/namei.c:1486 [inline]
 step_into+0xf4/0xea0 fs/namei.c:1800
 walk_component+0x1a1/0x360 fs/namei.c:1976
 lookup_last fs/namei.c:2425 [inline]
 path_lookupat+0x12d/0x3c0 fs/namei.c:2449
 filename_lookup+0x130/0x310 fs/namei.c:2478
 user_path_at_empty+0x3e/0x110 fs/namei.c:2801
 do_readlinkat+0x97/0x210 fs/stat.c:443
 __do_sys_readlink fs/stat.c:476 [inline]
 __se_sys_readlink fs/stat.c:473 [inline]
 __x64_sys_readlink+0x43/0x50 fs/stat.c:473
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

value changed: 0x00600008 -> 0x00008008

Reported by Kernel Concurrency Sanitizer on:
CPU: 5 PID: 1537 Comm: systemd-udevd Not tainted 5.16.0-rc8+ #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
==================================================================
