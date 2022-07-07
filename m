Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4959456A884
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 18:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiGGQqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 12:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiGGQqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:46:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393EF30565;
        Thu,  7 Jul 2022 09:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C47FA6242E;
        Thu,  7 Jul 2022 16:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D209C3411E;
        Thu,  7 Jul 2022 16:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657212388;
        bh=N4BCdpwIUOhoC2Cqt1sjpgdPBY0ujdUoPu3si0ynlZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1Cle8tUQMGzckN02mJE6TsEo0A1kcZZtyewj4btbhdA8o1BRn2At8iJLDrBz8ACt
         Psd2mfmsR9galClGKeUULRlkXJvm+JGboygBWZ0j6oBeJVLxGjdI0RM1K6ajj2fgwu
         irD9EasUduF36cic5dOhYeRaq0LbmWws/n0pdPKDub5J/SxjIevUYSAosSDQ1kHqQv
         4ltw+hELx2YUfHng5DiWi2aQC8+WqCqWfflH0qu16d49IVRa/1A6gdRRSLcOrQOosY
         gRto4riaUo/cNe62szDcmlCW+CoQu3foBVd8oEe/Pr0TRdUBi48Lcbu36/AroBq5yF
         lU2Iq1dam1/eg==
Date:   Thu, 7 Jul 2022 19:46:11 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 truncate_inode_partial_folio
Message-ID: <YscN0+ORoOSdNxBd@kernel.org>
References: <000000000000f94c4805e289fc47@google.com>
 <YrvYEdTNWcvhIE7U@sol.localdomain>
 <CAJHvVcgoeKhqFTN5aGfQ53GbRDYJsfkRjeUM-yO5AROC0A8ekQ@mail.gmail.com>
 <20220701073241.1277-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701073241.1277-1-hdanton@sina.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 01, 2022 at 03:32:41PM +0800, Hillf Danton wrote:
> On Thu, 30 Jun 2022 11:47:39 +0300 Mike Rapoport wrote:
> > On Wed, Jun 29, 2022 at 09:30:12AM -0700, Axel Rasmussen wrote:
> > > On Tue, Jun 28, 2022 at 9:41 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> > >From edfcb2f0d31c2132bda483635dd2a8dd295efb04 Mon Sep 17 00:00:00 2001
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > Date: Thu, 30 Jun 2022 11:26:37 +0300
> > Subject: [PATCH] secretmem: fix unhandled fault in truncate
> > 
> > syzkaller reports the following issue:
> > 
> > BUG: unable to handle page fault for address: ffff888021f7e005
> > PGD 11401067 P4D 11401067 PUD 11402067 PMD 21f7d063 PTE 800fffffde081060
> > Oops: 0002 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 3761 Comm: syz-executor281 Not tainted 5.19.0-rc4-syzkaller-00014-g941e3e791269 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:memset_erms+0x9/0x10 arch/x86/lib/memset_64.S:64
> > Code: c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 <f3> aa 4c 89 c8 c3 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01
> > RSP: 0018:ffffc9000329fa90 EFLAGS: 00010202
> > RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000ffb
> > RDX: 0000000000000ffb RSI: 0000000000000000 RDI: ffff888021f7e005
> > RBP: ffffea000087df80 R08: 0000000000000001 R09: ffff888021f7e005
> > R10: ffffed10043efdff R11: 0000000000000000 R12: 0000000000000005
> > R13: 0000000000000000 R14: 0000000000001000 R15: 0000000000000ffb
> > FS:  00007fb29d8b2700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffff888021f7e005 CR3: 0000000026e7b000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  zero_user_segments include/linux/highmem.h:272 [inline]
> >  folio_zero_range include/linux/highmem.h:428 [inline]
> >  truncate_inode_partial_folio+0x76a/0xdf0 mm/truncate.c:237
> >  truncate_inode_pages_range+0x83b/0x1530 mm/truncate.c:381
> >  truncate_inode_pages mm/truncate.c:452 [inline]
> >  truncate_pagecache+0x63/0x90 mm/truncate.c:753
> >  simple_setattr+0xed/0x110 fs/libfs.c:535
> >  secretmem_setattr+0xae/0xf0 mm/secretmem.c:170
> >  notify_change+0xb8c/0x12b0 fs/attr.c:424
> >  do_truncate+0x13c/0x200 fs/open.c:65
> >  do_sys_ftruncate+0x536/0x730 fs/open.c:193
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > RIP: 0033:0x7fb29d900899
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fb29d8b2318 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
> > RAX: ffffffffffffffda RBX: 00007fb29d988408 RCX: 00007fb29d900899
> > RDX: 00007fb29d900899 RSI: 0000000000000005 RDI: 0000000000000003
> > RBP: 00007fb29d988400 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb29d98840c
> > R13: 00007ffca01a23bf R14: 00007fb29d8b2400 R15: 0000000000022000
> >  </TASK>
> > Modules linked in:
> > CR2: ffff888021f7e005
> > ---[ end trace 0000000000000000 ]---
> > 
> > Eric Biggers suggested that this happens when
> > secretmem_setattr()->simple_setattr() races with secretmem_fault() so
> > that a page that is faulted in by secretmem_fault() (and thus removed
> > from the direct map) is zeroed by inode truncation right afterwards.
> > 
> > Use an rw_semaphore to make secretmem_fault() and secretmem_setattr()
> > mutually exclusive.
> 
> Given inode_lock() in do_truncate(), another simpler option is to lock
> inode in the fault path if the suggested race is the root cause.

Yeah, it makes sense. It does not look like a race would happen anywhere
but do_truncate().
 
> Hillf
> 

-- 
Sincerely yours,
Mike.
