Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF536419BC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 19:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhI0RV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 13:21:57 -0400
Received: from foss.arm.com ([217.140.110.172]:39054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236822AbhI0RTz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:19:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8B3E6D;
        Mon, 27 Sep 2021 10:18:16 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CA943F718;
        Mon, 27 Sep 2021 10:18:14 -0700 (PDT)
Date:   Mon, 27 Sep 2021 18:18:12 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+488ddf8087564d6de6e2@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
Subject: Re: [syzbot] upstream test error: KASAN: invalid-access Read in
 __entry_tramp_text_end
Message-ID: <20210927171812.GB9201@C02TD0UTHF1T.local>
References: <000000000000a3cf8605cb2a1ec0@google.com>
 <CACT4Y+aS6w1gFuMVY1fnAG0Yp0XckQTM+=tUHkOuxHUy2mkxrg@mail.gmail.com>
 <20210921165134.GE35846@C02TD0UTHF1T.local>
 <CACT4Y+ZjRgb57EV6mvC-bVK0uT0aPXUjtZJabuWasYcshKNcgw@mail.gmail.com>
 <20210927170122.GA9201@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927170122.GA9201@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 06:01:22PM +0100, Mark Rutland wrote:
> On Mon, Sep 27, 2021 at 04:27:30PM +0200, Dmitry Vyukov wrote:
> > On Tue, 21 Sept 2021 at 18:51, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > The good news is that the bad unwind is a known issue, the bad news is
> > > that we don't currently have a way to fix it (and I'm planning to talk
> > > about this at the LPC "objtool on arm64" talk this Friday).
> > >
> > > More info below: the gist is we can produce spurious entries at an
> > > exception boundary, but shouldn't miss a legitimate value, and there's a
> > > plan to make it easier to spot when entries are not legitimate.
> > >
> > > On Fri, Sep 17, 2021 at 05:03:48PM +0200, Dmitry Vyukov wrote:
> > > > > Call trace:
> > > > >  dump_backtrace+0x0/0x1ac arch/arm64/kernel/stacktrace.c:76
> > > > >  show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:215
> > > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > > >  dump_stack_lvl+0x68/0x84 lib/dump_stack.c:105
> > > > >  print_address_description+0x7c/0x2b4 mm/kasan/report.c:256
> > > > >  __kasan_report mm/kasan/report.c:442 [inline]
> > > > >  kasan_report+0x134/0x380 mm/kasan/report.c:459
> > > > >  __do_kernel_fault+0x128/0x1bc arch/arm64/mm/fault.c:317
> > > > >  do_bad_area arch/arm64/mm/fault.c:466 [inline]
> > > > >  do_tag_check_fault+0x74/0x90 arch/arm64/mm/fault.c:737
> > > > >  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
> > > > >  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
> > > > >  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
> > > > >  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
> > > > >  __entry_tramp_text_end+0xdfc/0x3000
> > > >
> > > > /\/\/\/\/\/\/\
> > > >
> > > > This is broken unwind on arm64. d_lookup statically calls __d_lookup,
> > > > not __entry_tramp_text_end (which is not even a function).
> > > > See the following thread for some debugging details:
> > > > https://lore.kernel.org/lkml/CACT4Y+ZByJ71QfYHTByWaeCqZFxYfp8W8oyrK0baNaSJMDzoUw@mail.gmail.com/
> 
> Looking at this again (and as you point out below), my initial analysis
> was wrong, and this isn't to do with the LR -- this value should be the
> PC at the time the exception boundary.

Whoops, I accidentally nuked the more complete/accurate analysis I just
wrote and sent the earlier version. Today is not a good day for me and
computers. :(

What's happened here is that __d_lookup() (via a few layers of inlining) called
load_unaligned_zeropad(). The `LDR` at the start of the asm faulted (I suspect
due to a tag check fault), and so the exception handler replaced the PC with
the (anonymous) fixup function. This is akin to a tail or sibling call, and so
the fixup function entirely replaces __d_lookup() in the trace.

The fixup function itself has an `LDR` which faulted (because it's
designed to fixup page alignment problems, not tag check faults), and
that is what's reported here.

As the fixup function is anonymous, and the nearest prior symbol in .text is
__entry_tramp_text_end, it gets symbolized as an offset from that.

We can make the unwinds a bit nicer by adding some markers (e.g. patch
below), but actually fixing this case will require some more thought.

Thanks,
Mark.

---->8----
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 709d2c433c5e..127096a0faea 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -111,6 +111,11 @@ jiffies = jiffies_64;
 #define TRAMP_TEXT
 #endif
 
+#define FIXUP_TEXT                                     \
+       __fixup_text_start = .;                         \
+       *(.fixup);                                      \
+       __fixup_text_end = .;
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from _stext to _edata, must be a round multiple of the PE/COFF
@@ -161,7 +166,7 @@ SECTIONS
                        IDMAP_TEXT
                        HIBERNATE_TEXT
                        TRAMP_TEXT
-                       *(.fixup)
+                       FIXUP_TEXT
                        *(.gnu.warning)
                . = ALIGN(16);
                *(.got)                 /* Global offset table          */
