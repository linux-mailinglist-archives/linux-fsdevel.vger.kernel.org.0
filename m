Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88F6F3671
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 21:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjEATAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 15:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjEATAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 15:00:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A95D10F8
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 12:00:11 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 341IxtXc026576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 May 2023 14:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682967597; bh=Qo1w3pZJsItaqOh4abhpZbgVenLKe+TznxSlIKci72w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MjU/iB5BCvG0bZVdczqTUi+6z18x/dqs11LeciX9RcMxYalVP6Yb8+06dgSKpmueh
         7t/AhvULVfL4H4bCX4Lz9YJOYNY7j5rCgoEnu8ETAAOSWoH2V4Xqqc3OzQU2UqrHrw
         8Mr0TmFKLtI30mW4kHk5k31pa8eZFiBwG21YJRys0dqUeh0VvAloB2KnyUiBA+OqaR
         iLMjUEx7ITh8vKMcKiyb+YMgwsN+O6ucseodTrKpKYVUKufUCDVx6vntsglb4SahM8
         O8XIH9cQDi3Sptw6MydcEt9QIF0zri9LbXGqoAdEXJYk5RgcHtHCMA0fzYISGVgtca
         TwWn61sDc99Pg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0BEA715C02E2; Mon,  1 May 2023 14:59:55 -0400 (EDT)
Date:   Mon, 1 May 2023 14:59:55 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+18b2ab4c697021ee8369@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        Christian Brauner <brauner@kernel.org>
Subject: Re: INFO: task hung in do_truncate (2)
Message-ID: <20230501185955.GA604757@mit.edu>
References: <000000000000209d7205a7c7ab09@google.com>
 <0000000000003fa24b05b84a0886@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003fa24b05b84a0886@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 06, 2021 at 11:03:09PM -0800, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit dfefd226b0bf7c435a58d75a0ce2f9273b9825f6
> Author: Alexey Dobriyan <adobriyan@gmail.com>
> Date:   Tue Dec 15 03:15:03 2020 +0000
> 
>     mm: cleanup kstrto*() usage

This is a nonsense bisect result; I've filed a bug against syzbot[1].

[1] https://github.com/google/syzkaller/issues/3855

Looking more closely at this reproducer, it looks like it is setting
up a and configuring userfaultd on a large number of threads:

    clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x11ad690)

    res = syscall(__NR_userfaultfd, 0ul);

    syscall(__NR_ioctl, r[0], UFFDIO_API, {api=0xaa, features=0, ... });

    syscall(__NR_ioctl, -1, PPPIOCGMRU, 0ul)    returns -EBADF
        (don't know why the syzbot minimizer didn't get rid of this...)

    syscall(__NR_ioctl, r[0], UFFDIO_REGISTER,  {range={start=0x20909000, len=0x4000}, mode=UFFDIO_REGISTER_MODE_MISSING ...)

    ...

It does this in a tight loop, spawning many threads each time, and
while it doesen't always end up reporting an rcu preempt stall, and
locking up the kernel, I have manage to trigger a similar crash when
the underlying file system is btrfs, with the stack traces being
similar.  So I don't believe it is an ext4-specific bug.

#syz set subsystems: fs

I'm not an expert on userfaultd, but I'm not at all convinced what
this reproducer is doing is valid and it may be a "root an screw
itself" kind of issue.  Maybe someone who knows more about userfaultfd
can comment?

There is a C reproducer[2], but it suffers from the standard
obfuscation via ultra-non-portable-C-so-much-it-might-as- well-be-asm
problem.  The syzbot dashboard page for this can be found here[3].

[2] https://syzkaller.appspot.com/text?tag=ReproC&x=153a741e100000
[3] https://syzkaller.appspot.com/bug?id=d38f8eae55e27aaef60b4748bc77ecb712dba4b9

Thanks,

						- Ted
