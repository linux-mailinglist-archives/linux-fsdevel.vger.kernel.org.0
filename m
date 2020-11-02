Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752982A2AA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 13:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgKBM0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 07:26:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:56060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728359AbgKBM0k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:26:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F070AFE1;
        Mon,  2 Nov 2020 12:26:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3A9C21E12FB; Mon,  2 Nov 2020 13:26:38 +0100 (CET)
Date:   Mon, 2 Nov 2020 13:26:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201102122638.GB23988@quack2.suse.cz>
References: <20201101212738.GA16924@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201101212738.GA16924@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 01-11-20 22:27:38, Paweł Jasiak wrote:
> I am trying to run examples from man fanotify.7 but fanotify_mark always
> fail with errno = EFAULT.
> 
> fanotify_mark declaration is
> 
> SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
> 			      __u64, mask, int, dfd,
> 			      const char  __user *, pathname)
> 
> When 
> 
> fanotify_mark(4, FAN_MARK_ADD | FAN_MARK_ONLYDIR,
>               FAN_CREATE | FAN_ONDIR, AT_FDCWD, 0xdeadc0de)
> 
> is called on kernel side I can see in do_syscall_32_irqs_on that CPU
> context is
>     bx = 0x4        = 4
>     cx = 0x9        = FAN_MARK_ADD | FAN_MARK_ONLYDIR,
>     dx = 0x40000100 = FAN_CREATE | FAN_ONDIR
>     si = 0x0
>     di = 0xffffff9c = AT_FDCWD
>     bp = 0xdeadc0de
>     ax = 0xffffffda
>     orix_ax = 0x153
> 
> I am not sure if it is ok because third argument is uint64_t so if I
> understand correctly mask should be divided into two registers (dx and
> si).
> 
> But in fanotify_mark we get
>     fanotify_fd = 4          = bx
>     flags       = 0x9        = cx
>     mask        = 0x40000100 = dx
>     dfd         = 0          = si
>     pathname    = 0xffffff9c = di
> 
> I believe that correct order is
>     fanotify_fd = 4          = bx
>     flags       = 0x9        = cx
>     mask        = 0x40000100 = (si << 32) | dx
>     dfd         = 0xffffff9c = di
>     pathname    = 0xdeadc0de = bp
> 
> I think that we should call COMPAT version of fanotify_mark here
> 
> COMPAT_SYSCALL_DEFINE6(fanotify_mark,
> 				int, fanotify_fd, unsigned int, flags,
> 				__u32, mask0, __u32, mask1, int, dfd,
> 				const char  __user *, pathname)
> 
> or something wrong is with 64-bits arguments.
> 
> I am running Linux 5.9.2 i686 on Pentium III (Coppermine).
> For tests I am using Debian sid on qemu with 5.9.2 and default kernel
> from repositories.
> 
> Everything works fine on 5.5 and 5.4.

Strange. Thanks for report. Looks like some issue got created / exposed
somewhere between 5.5 and 5.9 (actually probably between 5.5 and 5.7
because the Linaro report you mentioned [1] is from 5.7-rc6). There were
no changes in this area in fanotify, I think it must have been some x86
change that triggered this. Hum, looking into x86 changelog in that time
range there was a series rewriting 32-bit ABI [2] that got merged into
5.7-rc1. Can you perhaps check whether 5.6 is good and 5.7-rc1 is bad?

Brian, any idea whether your series could regress fanotify_mark(2) syscall?
Do we have somewhere documented which syscalls need compat wrappers and how
they should look like?

								Honza

[1] https://lists.linux.it/pipermail/ltp/2020-June/017436.html
[2] https://lore.kernel.org/lkml/20200313195144.164260-1-brgerst@gmail.com/

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
