Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FF07101F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 02:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjEYAV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 20:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjEYAV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 20:21:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA6199;
        Wed, 24 May 2023 17:21:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 755CE639A3;
        Thu, 25 May 2023 00:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA5CC433D2;
        Thu, 25 May 2023 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684974113;
        bh=yXi9V0/F6k9EKbphV/OOXmADbsUSWa4D9vfJH+/4NEE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b85qzx/Y6QIzJImaX2xXMmXsF7Z+KFvCmv+XBtosojGt7urQ95dBTES9SOK4dIDNK
         aTYp9WEI03JdixtUndCywEEimskEtuq5LFZODVU+q/DqsZBO3SobLqi5vIQ/v6ZdLA
         SNUmmuVAxcMSc/+6VvwzOH1iIvVuw4FJbh4OWvw+cd6ReQbTAdSXeBpIc4wHAb5moF
         2Zl/1TEMtMKuE7hXsf3AvQAvlKS71+KeXt1yjsNhKt8inRFReMpFsXE2pDdPSY0E0z
         aRiVkJb/DTLhLt+QuzgSx0OfT3cR1eKGN49DbpzNEiD9YVmMJaFD93ohgCnjLNj8No
         GtJoYQAEf2opw==
Date:   Thu, 25 May 2023 08:21:48 +0800
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, lkft-triage@lists.linaro.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: LTP: tracing: RIP: 0010:security_inode_permission+0x5/0x70
Message-Id: <20230525082148.af95df069c337fa570f24331@kernel.org>
In-Reply-To: <20230524-windhund-karikatur-354025f2ef1c@brauner>
References: <CA+G9fYuGT0esjqBT9=xCTtWKV1DxYspXTtM5gqprbDKiTrb7qQ@mail.gmail.com>
        <20230524-windhund-karikatur-354025f2ef1c@brauner>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 24 May 2023 12:39:40 +0200
Christian Brauner <brauner@kernel.org> wrote:

> On Wed, May 24, 2023 at 02:32:25PM +0530, Naresh Kamboju wrote:
> > While running LTP tracing tests on qemu-x86_64 following kernel crash noticed
> > with stable-rc 6.3.4-rc2.
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > FAILED COMMAND File:
> > /lava-1/0/tests/0_ltp-tracing/automated/linux/ltp/output/LTP_tracing.failed
> > TCONF COMMAND File: /opt/ltp/output/LTP_RUN_ON-LTP_tracing.log.tconf
> > Running tests.......
> 
> No idea and seems very odd. Only thing I see is that there's ftrace
> regression testing running while the crash happens.

It sounds like there is a timing issue on int3 self-modifying code @ alternative.c
ftrace@x86 uses it for arming/disarming mcount(fentry) call.
I would like to know what is the actual command to run it. The above files are
local file, and no actual commands recorded in the full log.

Thank you,

> 
> > 
> > <4>[   57.932577] int3: 0000 [#1] PREEMPT SMP PTI
> > <4>[   57.933090] CPU: 0 PID: 138 Comm: systemd-udevd Not tainted 6.3.4-rc2 #1
> > <4>[   57.933243] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.14.0-2 04/01/2014
> > <4>[   57.933447] RIP: 0010:security_inode_permission+0x5/0x70
> > <4>[   57.934163] Code: c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00
> > 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66
> > 0f 1f 00 e8 <e7> 8d 64 18 f6 47 0d 02 75 50 55 48 89 e5 41 55 41 89 f5
> > 41 54 49
> > <4>[   57.934257] RSP: 0018:ffffa300c050bca0 EFLAGS: 00000246
> > <4>[   57.934363] RAX: 00000000000041ed RBX: ffff9bda012805c0 RCX:
> > 0000000000000000
> > <4>[   57.934390] RDX: ffff9bda01f6df00 RSI: 0000000000000081 RDI:
> > ffff9bda012805c0
> > <4>[   57.934415] RBP: ffffa300c050bcd0 R08: ffffa300c050bd80 R09:
> > 00000000ffffff9c
> > <4>[   57.934440] R10: 0000000000000fe0 R11: ffc9d09b99d09993 R12:
> > 0000000000000081
> > <4>[   57.934465] R13: 0000000000000000 R14: ffffffffa958f970 R15:
> > 2f2f2f2f2f2f2f2f
> > <4>[   57.934544] FS:  00007fb89665f800(0000)
> > GS:ffff9bda7bc00000(0000) knlGS:0000000000000000
> > <4>[   57.934578] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4>[   57.934604] CR2: 00007f60c9b0e000 CR3: 0000000104402000 CR4:
> > 00000000000006f0
> > <4>[   57.934793] Call Trace:
> > <4>[   57.934958]  <TASK>
> > <4>[   57.935082]  ? inode_permission+0x70/0x1a0
> > <4>[   57.935235]  link_path_walk.part.0.constprop.0+0xdd/0x3b0
> > <4>[   57.935360]  path_lookupat+0x3e/0x190
> > <4>[   57.935426]  filename_lookup+0xe8/0x1f0
> > <4>[   57.935638]  user_path_at_empty+0x42/0x60
> > <4>[   57.935692]  do_fchmodat+0x5f/0xc0
> > <4>[   57.935809]  __x64_sys_chmod+0x1f/0x30
> > <4>[   57.935845]  do_syscall_64+0x3e/0x90
> > <4>[   57.935886]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > <4>[   57.935996] RIP: 0033:0x7fb8964fbd6b
> > <4>[   57.936393] Code: ff ff ff ff eb e6 66 0f 1f 84 00 00 00 00 00
> > f3 0f 1e fa b8 5f 00 00 00 0f 05 c3 0f 1f 40 00 f3 0f 1e fa b8 5a 00
> > 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 85 40 0f 00 f7 d8 64
> > 89 01 48
> > <4>[   57.936422] RSP: 002b:00007ffcf4c2aa38 EFLAGS: 00000202
> > ORIG_RAX: 000000000000005a
> > <4>[   57.936471] RAX: ffffffffffffffda RBX: 0000000000000190 RCX:
> > 00007fb8964fbd6b
> > <4>[   57.936490] RDX: 00007ffcf4c2aa4f RSI: 0000000000000190 RDI:
> > 00007ffcf4c2aa40
> > <4>[   57.936504] RBP: 0000000000000190 R08: 0000000000000000 R09:
> > 00007ffcf4c2a8e0
> > <4>[   57.936528] R10: 0000000000000000 R11: 0000000000000202 R12:
> > 00007ffcf4c2aa40
> > <4>[   57.936542] R13: 0000000000000005 R14: 0000000000000000 R15:
> > 0000000000000001
> > <4>[   57.936754]  </TASK>
> > <4>[   57.936853] Modules linked in:
> > <4>[   57.962890] ---[ end trace 0000000000000000 ]---
> > <4>[   57.963006] RIP: 0010:security_inode_permission+0x5/0x70
> > <4>[   57.963080] Code: c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00
> > 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66
> > 0f 1f 00 e8 <e7> 8d 64 18 f6 47 0d 02 75 50 55 48 89 e5 41 55 41 89 f5
> > 41 54 49
> > <4>[   57.963105] RSP: 0018:ffffa300c050bca0 EFLAGS: 00000246
> > <4>[   57.963145] RAX: 00000000000041ed RBX: ffff9bda012805c0 RCX:
> > 0000000000000000
> > <4>[   57.963163] RDX: ffff9bda01f6df00 RSI: 0000000000000081 RDI:
> > ffff9bda012805c0
> > <4>[   57.963180] RBP: ffffa300c050bcd0 R08: ffffa300c050bd80 R09:
> > 00000000ffffff9c
> > <4>[   57.963195] R10: 0000000000000fe0 R11: ffc9d09b99d09993 R12:
> > 0000000000000081
> > <4>[   57.963209] R13: 0000000000000000 R14: ffffffffa958f970 R15:
> > 2f2f2f2f2f2f2f2f
> > <4>[   57.963226] FS:  00007fb89665f800(0000)
> > GS:ffff9bda7bc00000(0000) knlGS:0000000000000000
> > <4>[   57.963246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4>[   57.963261] CR2: 00007f60c9b0e000 CR3: 0000000104402000 CR4:
> > 00000000000006f0
> > <0>[   57.963444] Kernel panic - not syncing: Fatal exception in interrupt
> > <0>[   57.964629] Kernel Offset: 0x26600000 from 0xffffffff81000000
> > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > 
> > 
> > links,
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.3-364-ga37c304c022d/testrun/17168198/suite/log-parser-test/tests/
> >  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.3-364-ga37c304c022d/testrun/17168198/suite/log-parser-test/test/check-kernel-panic/log
> >  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2QCeudZ18KF3RXw3A5qfr5lPC2N/
> >  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2QCeudZ18KF3RXw3A5qfr5lPC2N/config
> > 
> > --
> > Linaro LKFT
> > https://lkft.linaro.org


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
