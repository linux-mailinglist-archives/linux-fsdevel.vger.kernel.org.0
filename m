Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF541C707F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 14:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEFMlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 08:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgEFMlu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 08:41:50 -0400
Received: from [192.168.0.106] (unknown [202.53.39.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3468320575;
        Wed,  6 May 2020 12:41:45 +0000 (UTC)
Subject: Re: exec: Promised cleanups after introducing exec_update_mutex
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <5140633d-cbb6-58cb-4f05-31c5e6c75643@linux-m68k.org>
Date:   Wed, 6 May 2020 22:41:43 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87h7wujhmz.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric,

On 6/5/20 5:39 am, Eric W. Biederman wrote:
> In the patchset that introduced exec_update_mutex there were a few last
> minute discoveries and fixes that left the code in a state that can
> be very easily be improved.
> 
> During the merge window we discussed the first three of these patches
> and I promised I would resend them.
> 
> What the first patch does is it makes the the calls in the binfmts:
> 	flush_old_exec();
>          /* set the personality */
>          setup_new_exec();
>          install_exec_creds();
> 
> With no sleeps or anything in between.
> 
> At the conclusion of this set of changes the the calls in the binfmts
> are:
> 	begin_new_exec();
>          /* set the personality */
>          setup_new_exec();
> 
> The intent is to make the code easier to follow and easier to change.
> 
> Eric W. Biederman (7):
>        binfmt: Move install_exec_creds after setup_new_exec to match binfmt_elf
>        exec: Make unlocking exec_update_mutex explict
>        exec: Rename the flag called_exec_mmap point_of_no_return
>        exec: Merge install_exec_creds into setup_new_exec
>        exec: In setup_new_exec cache current in the local variable me
>        exec: Move most of setup_new_exec into flush_old_exec
>        exec: Rename flush_old_exec begin_new_exec
> 
>   Documentation/trace/ftrace.rst |   2 +-
>   arch/x86/ia32/ia32_aout.c      |   4 +-
>   fs/binfmt_aout.c               |   3 +-
>   fs/binfmt_elf.c                |   3 +-
>   fs/binfmt_elf_fdpic.c          |   3 +-
>   fs/binfmt_flat.c               |   4 +-
>   fs/exec.c                      | 162 ++++++++++++++++++++---------------------
>   include/linux/binfmts.h        |  10 +--
>   kernel/events/core.c           |   2 +-
>   9 files changed, 92 insertions(+), 101 deletions(-)

I tested the the whole series on non-MMU m68k and non-MMU arm
(exercising binfmt_flat) and it all tested out with no problems,
so for the binfmt_flat changes:

Tested-by: Greg Ungerer <gerg@linux-m68k.org>

I reviewed the whole series too, and looks good to me:

Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


> ---
> 
> These changes are against v5.7-rc3.
> 
> My intention once everything passes code reveiw is to place these
> changes in a topic branch in my tree and then into linux-next, and
> eventually to send Linus a pull when the next merge window opens.
> Unless someone has a better idea.
> 
> I am a little concerned that I might conflict with the ongoing coredump
> cleanups.
> 
> I have several follow up sets of changes with additional cleanups as
> well but I am trying to keep everything small enough that the code can
> be reviewed.
> 
> After enough cleanups I hope to reopen the conversation of dealing with
> the livelock situation with cred_guard_mutex.  As I think figuring out
> what to do becomes much easier once several of my planned
> cleanups/improvements have been made.
> 
> But ultimately I just want to get exec to the point where when
> we have disucssions on how to make exec better the code is in good
> enough shape we can actually address the issues we see.
> 
> Eric
> 
