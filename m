Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CBB7247B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 17:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbjFFP2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 11:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjFFP2U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:28:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A690E42
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GnU8oWEO231c+lKHMe7QwAkGTFn3nzNqn1xTmlwmJIo=; b=DKSTXqJvn6bIxUJvnvQ2uc0Ptc
        tBGO5uTvqndocNFY1rdWoaSyQeauwZX2UHqtbJBm8V5dqB7G68b8OVHRUDvhDExza4uPOsImzr2QY
        DI4/mA4C1pR2XV/5YmzejjZjWAlOkDoNELHir0ET03QkwJhY0dm/inv8LxXfsC+R7bFBrdPc2mdcv
        N1ip9rVVSQ6IDVE5ZGmsdpoqguJd+o+Zlpz6vmqR4/OnvC3cqjaqR86smK7ZxNqlvTX4WBlVMxESb
        YJGHnkg3l2Aetq46Sj3EaVdJsygGo7g9j5maeBQ/H0kL/Lh1wAfUda46Ci59DHnkGPE0rvGcpvnrK
        IHWrjMYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6YbX-00DH2E-F2; Tue, 06 Jun 2023 15:28:15 +0000
Date:   Tue, 6 Jun 2023 16:28:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Is coredump_wait broken in 6.4-rc5?
Message-ID: <ZH9Qj5oCIfFBeoBo@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Have you seen anything like this?  It could be one of my patches that
broke it:

00135 fio[39217]: segfault at 560494fe654c ip 00007fe9fb6b3e67 sp 00007ffc8f08b6d0 error 4 in libc.so.6[7fe9fb645000+155000] likely on CPU 0 (core 0, socket 0)
00135 Code: 1f 40 00 48 83 ec 08 48 8b 4f 08 48 89 c8 48 83 e0 f8 48 3b 04 07 0f 85 a9 00 00 00 f3 0f 6f 47 10 48 8b 57 18 66 48 0f 7e c0 <48> 3b 78 18 75 7b 48 3b 7a 10 75 75 48 8b 77 10 48 89 50 18 66 0f
00363 INFO: task fsstress:39216 blocked for more than 120 seconds.
00363       Not tainted 6.4.0-rc5-00028-gf824d48d50fc #391
00363 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
00363 task:fsstress        state:D stack:11496 pid:39216 ppid:39214  flags:0x00000002
00363 Call Trace:
[snip]
00363  wait_for_completion_state+0x11c/0x1e0
00363  do_coredump+0x265/0x15b0
00363  get_signal+0x904/0x9c0
00363  arch_do_signal_or_restart+0x1b/0x250
00363  exit_to_user_mode_prepare+0x99/0x100
00363  syscall_exit_to_user_mode+0x21/0x40

# cat /proc/39216/stack
[<0>] do_coredump+0x265/0x15b0
[<0>] get_signal+0x904/0x9c0
[<0>] arch_do_signal_or_restart+0x1b/0x250
[<0>] exit_to_user_mode_prepare+0x99/0x100
[<0>] syscall_exit_to_user_mode+0x21/0x40
[<0>] do_syscall_64+0x40/0x80
[<0>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

# cat /proc/39214/stack
[<0>] do_wait+0x161/0x2f0
[<0>] kernel_wait4+0x8a/0x110
[<0>] __do_sys_wait4+0x67/0x80
[<0>] __x64_sys_wait4+0x17/0x20
[<0>] do_syscall_64+0x34/0x80
[<0>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Those are the only two pids running fsstress.

# ps -aux | grep fsstress
root       39214  0.0  0.0   2580  1664 ?        S    15:11   0:00 ./ltp/fsstress -p 1 -n999999999 -f setattr 0 -ffsync 0 -fsync 0 -ffdatasync 0 -f setattr 1 -d /mnt/scratch/fsstress.39009
root       39216  0.3  0.3   8024  6792 ?        D    15:11   0:02 ./ltp/fsstress -p 1 -n999999999 -f setattr 0 -ffsync 0 -fsync 0 -ffdatasync 0 -f setattr 1 -d /mnt/scratch/fsstress.39009

Obviously fio shouldn't've segfaulted in the first place, but sometimes
when it does, fsstress hangs during coredump, and that also seems like
it shouldn't happen.
