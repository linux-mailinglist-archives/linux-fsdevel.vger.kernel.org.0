Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46A7590E13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 11:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbiHLJaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 05:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbiHLJaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:30:00 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA47A99D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 02:29:58 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l21so411072ljj.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 02:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=92ou/u14nlAhRLAjyH+K5VTnxlst6DGZsroJdwVOovQ=;
        b=BYUOxr06BCh8L+j+0kdrblTLsfOAc/S1qPRVrIOUjSIteDptTVgc3VdOuPlNx8LkCE
         7HL2VOP0xS7+FoFkFpGkV/2J62IDmuPMsY3+3zCsuSBJ/or6VNQAAOTVXj3RMINn3H7L
         VL2qIe3Z2mCX6vXter3C+GKO0XkjbhdppPRoRdPMKvVHG0EFp1ff508s8QqKCEQ8960l
         FGCxlwJNlnJRYyrpBQZdIr55z5UyDM3M/yL4Rfxr8HH5vIuvKOUaNXEcZ7cFA9GvA4wj
         egjarR98yKRN6RZPLnyEmnljddhDPuWpMH5ffg9hGkG034uwDBRtap6niExmB3h+RrUj
         VAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=92ou/u14nlAhRLAjyH+K5VTnxlst6DGZsroJdwVOovQ=;
        b=Q7SrIZsDiuTJubos2Y1P85dxw3qTlP3LbUzPWSfmpAUkxR2YsSUs1T0oG7yVGw50cB
         SVW2bCPKzNBxV3lbWlPAFjOjaqw4rSHVD0m0w8IgZn6XF+skrk2Vwi+nCv3tWwYq7oMk
         BS33fC43EMV8Q3uqkfl8Y2yYH3IHOQMzJB3NoDsYCzAtJAOj6KmkS6sZ6BnlKuSxk3ta
         1a4Bmb+7eyBiQgyM294/xu+jriYwfvFOCMQUwj0R1G/jBOztrgohaH8qjctgK30ViMj3
         aQ0COwLAclYljpsQh6l9rDXvE36270BBx2kjDJQ6t5oIzXtRsuoeurVdgkr5maAp11mu
         Kq8w==
X-Gm-Message-State: ACgBeo0vAa9V8bIKg5hWzhOXFUKUdzccgSqVA4TQ4j7476K6/mseZ3Ff
        xjoybAr235WVYR1GcnPbJ8JMmvv6y98iDNHc9av2Cg==
X-Google-Smtp-Source: AA6agR6tYzV/IQQ/OxLEjd+jk1f2ZSvYtf5ruKBh0ui0nUtixe61EgEuG7yugxxBKG9qC5S4CehK8y+rA0CaaMZcuSc=
X-Received: by 2002:a2e:a5ca:0:b0:25e:1c49:70f4 with SMTP id
 n10-20020a2ea5ca000000b0025e1c4970f4mr988263ljp.4.1660296596373; Fri, 12 Aug
 2022 02:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008c0ba505e5f22066@google.com> <202208110830.8F528D6737@keescook>
 <YvU+0UHrn9Ab4rR8@iweiny-desk3> <YvVPtuel8NMmiTKk@iweiny-desk3>
 <202208111356.97951D32@keescook> <YvWaqhLGsBp9ynIq@iweiny-desk3>
In-Reply-To: <YvWaqhLGsBp9ynIq@iweiny-desk3>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Aug 2022 11:29:44 +0200
Message-ID: <CACT4Y+bBNJsFobK28impL5bPGE9meQt-RE6xyDF=yxsmcR8ySw@mail.gmail.com>
Subject: Re: [syzbot] linux-next boot error: BUG: unable to handle kernel
 paging request in kernel_execve
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        syzbot <syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com>
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

On Fri, 12 Aug 2022 at 02:11, Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Thu, Aug 11, 2022 at 02:00:59PM -0700, Kees Cook wrote:
> > On Thu, Aug 11, 2022 at 11:51:34AM -0700, Ira Weiny wrote:
> > > On Thu, Aug 11, 2022 at 10:39:29AM -0700, Ira wrote:
> > > > On Thu, Aug 11, 2022 at 08:33:16AM -0700, Kees Cook wrote:
> > > > > Hi Fabio,
> > > > >
> > > > > It seems likely that the kmap change[1] might be causing this crash. Is
> > > > > there a boot-time setup race between kmap being available and early umh
> > > > > usage?
> > > >
> > > > I don't see how this is a setup problem with the config reported here.
> > > >
> > > > CONFIG_64BIT=y
> > > >
> > > > ...and HIGHMEM is not set.
> > > > ...and PREEMPT_RT is not set.
> > > >
> > > > So the kmap_local_page() call in that stack should be a page_address() only.
> > > >
> > > > I think the issue must be some sort of race which was being prevented because
> > > > of the preemption and/or pagefault disable built into kmap_atomic().
> > > >
> > > > Is this reproducable?
> > > >
> > > > The hunk below will surely fix it but I think the pagefault_disable() is
> > > > the only thing that is required.  It would be nice to test it.
> > >
> > > Fabio and I discussed this.  And he also mentioned that pagefault_disable() is
> > > all that is required.
> >
> > Okay, sounds good.
> >
> > > Do we have a way to test this?
> >
> > It doesn't look like syzbot has a reproducer yet, so its patch testing
> > system[1] will not work. But if you can send me a patch, I could land it
> > in -next and we could see if the reproduction frequency drops to zero.
> > (Looking at the dashboard, it's seen 2 crashes, most recently 8 hours
> > ago.)
>
> Patch sent.
>
> https://lore.kernel.org/lkml/20220812000919.408614-1-ira.weiny@intel.com/
>
> But I'm more confused after looking at this again.

There is splat of random crashes in linux-next happened at the same time:

https://groups.google.com/g/syzkaller-bugs/search?q=%22linux-next%20boot%20error%3A%22

There are 10 different crashes in completely random places.
I would assume they have the same root cause, some silent memory
corruption or something similar.




> > [1] https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
> >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    bc6c6584ffb2 Add linux-next specific files for 20220810
> > > > > > git tree:       linux-next
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=115034c3080000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5784be4315a4403b
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3250d9c8925ef29e975f
> > > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com
> > > > > >
> > > > > > BUG: unable to handle page fault for address: ffffdc0000000000
> > > > > > #PF: supervisor read access in kernel mode
> > > > > > #PF: error_code(0x0000) - not-present page
> > > > > > PGD 11826067 P4D 11826067 PUD 0
> > > > > > Oops: 0000 [#1] PREEMPT SMP KASAN
> > > > > > CPU: 0 PID: 1100 Comm: kworker/u4:5 Not tainted 5.19.0-next-20220810-syzkaller #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> > > > > > RIP: 0010:strnlen+0x3b/0x70 lib/string.c:504
> > > > > > Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
> > > > > > RSP: 0000:ffffc90005c5fe10 EFLAGS: 00010246
> > > > > > RAX: ffff000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> > > > > > RDX: 1fffe00000000000 RSI: 0000000000020000 RDI: ffff000000000000
> > > > > > RBP: ffff000000020000 R08: 0000000000000005 R09: 0000000000000000
> > > > > > R10: 0000000000000006 R11: 0000000000000000 R12: ffff000000000000
> > > > > > R13: ffff88814764cc00 R14: ffff000000000000 R15: ffff88814764cc00
> > > > > > FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: ffffdc0000000000 CR3: 000000000bc8e000 CR4: 00000000003506f0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  strnlen include/linux/fortify-string.h:119 [inline]
> > > > > >  copy_string_kernel+0x26/0x250 fs/exec.c:616
> > > > > >  copy_strings_kernel+0xb3/0x190 fs/exec.c:655
> > > > > >  kernel_execve+0x377/0x500 fs/exec.c:1998
> > > > > >  call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
> > > > > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> > > > > >  </TASK>
> > > [...]
> > > > > > ---
> > > > > > This report is generated by a bot. It may contain errors.
> > > > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > > > >
> > > > > > syzbot will keep track of this issue. See:
> > > > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > --
> > Kees Cook
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/YvWaqhLGsBp9ynIq%40iweiny-desk3.
