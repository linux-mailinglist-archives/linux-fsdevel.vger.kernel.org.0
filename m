Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E144137D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 18:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhIUQxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 12:53:11 -0400
Received: from foss.arm.com ([217.140.110.172]:36440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhIUQxG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:53:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFD57113E;
        Tue, 21 Sep 2021 09:51:37 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BD7C3F718;
        Tue, 21 Sep 2021 09:51:36 -0700 (PDT)
Date:   Tue, 21 Sep 2021 17:51:34 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] upstream test error: KASAN: invalid-access Read in
 __entry_tramp_text_end
Message-ID: <20210921165134.GE35846@C02TD0UTHF1T.local>
References: <000000000000a3cf8605cb2a1ec0@google.com>
 <CACT4Y+aS6w1gFuMVY1fnAG0Yp0XckQTM+=tUHkOuxHUy2mkxrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aS6w1gFuMVY1fnAG0Yp0XckQTM+=tUHkOuxHUy2mkxrg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dmitry,

The good news is that the bad unwind is a known issue, the bad news is
that we don't currently have a way to fix it (and I'm planning to talk
about this at the LPC "objtool on arm64" talk this Friday).

More info below: the gist is we can produce spurious entries at an
exception boundary, but shouldn't miss a legitimate value, and there's a
plan to make it easier to spot when entries are not legitimate.

On Fri, Sep 17, 2021 at 05:03:48PM +0200, Dmitry Vyukov wrote:
> > Call trace:
> >  dump_backtrace+0x0/0x1ac arch/arm64/kernel/stacktrace.c:76
> >  show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:215
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x68/0x84 lib/dump_stack.c:105
> >  print_address_description+0x7c/0x2b4 mm/kasan/report.c:256
> >  __kasan_report mm/kasan/report.c:442 [inline]
> >  kasan_report+0x134/0x380 mm/kasan/report.c:459
> >  __do_kernel_fault+0x128/0x1bc arch/arm64/mm/fault.c:317
> >  do_bad_area arch/arm64/mm/fault.c:466 [inline]
> >  do_tag_check_fault+0x74/0x90 arch/arm64/mm/fault.c:737
> >  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
> >  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
> >  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
> >  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
> >  __entry_tramp_text_end+0xdfc/0x3000
> 
> /\/\/\/\/\/\/\
> 
> This is broken unwind on arm64. d_lookup statically calls __d_lookup,
> not __entry_tramp_text_end (which is not even a function).
> See the following thread for some debugging details:
> https://lore.kernel.org/lkml/CACT4Y+ZByJ71QfYHTByWaeCqZFxYfp8W8oyrK0baNaSJMDzoUw@mail.gmail.com/

The problem here is that our calling convention (AAPCS64) only allows us
to reliably unwind at function call boundaries, where the state of both
the Link Register (LR/x30) and Frame Pointer (FP/x29) are well-defined.
Within a function, we don't know whether to start unwinding from the LR
or FP, and we currently start from the LR, which can produce spurious
entries (but ensures we don't miss anything legitimte).

In the short term, I have a plan to make the unwinder indicate when an
entry might not be legitimate, with the usual stackdump code printing an
indicator like '?' on x86.

In the longer term, we might be doing things with objtool or asking for
some toolchain help such that we can do better in these cases.

Thanks,
Mark.
