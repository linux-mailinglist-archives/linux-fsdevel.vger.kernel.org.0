Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A1B1C7083
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 14:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgEFMmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 08:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgEFMmt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 08:42:49 -0400
Received: from [192.168.0.106] (unknown [202.53.39.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC1B206D5;
        Wed,  6 May 2020 12:42:45 +0000 (UTC)
Subject: Re: [PATCH 1/7] binfmt: Move install_exec_creds after setup_new_exec
 to match binfmt_elf
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
 <87bln2jhki.fsf@x220.int.ebiederm.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <ce5f0c22-675b-cdc8-cd95-976c0e0babee@linux-m68k.org>
Date:   Wed, 6 May 2020 22:42:42 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87bln2jhki.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One small nit:

On 6/5/20 5:41 am, Eric W. Biederman wrote:
> In 2016 Linus moved install_exec_creds immediately after
> setup_new_exec, in binfmt_elf as a cleanup and as part of closing a
> potential information leak.
> 
> Perform the same cleanup for the other binary formats.
> 
> Different binary formats doing the same things the same way makes exec
> easier to reason about and easier to maintain.
> 
> The binfmt_flagt bits were tested by Greg Ungerer <gerg@linux-m68k.org>
              ^^^^^
              flat

Regards
Greg


> Ref: 9f834ec18def ("binfmt_elf: switch to new creds when switching to new mm")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>   arch/x86/ia32/ia32_aout.c | 3 +--
>   fs/binfmt_aout.c          | 2 +-
>   fs/binfmt_elf_fdpic.c     | 2 +-
>   fs/binfmt_flat.c          | 3 +--
>   4 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
> index 9bb71abd66bd..37b36a8ce5fa 100644
> --- a/arch/x86/ia32/ia32_aout.c
> +++ b/arch/x86/ia32/ia32_aout.c
> @@ -140,6 +140,7 @@ static int load_aout_binary(struct linux_binprm *bprm)
>   	set_personality_ia32(false);
>   
>   	setup_new_exec(bprm);
> +	install_exec_creds(bprm);
>   
>   	regs->cs = __USER32_CS;
>   	regs->r8 = regs->r9 = regs->r10 = regs->r11 = regs->r12 =
> @@ -156,8 +157,6 @@ static int load_aout_binary(struct linux_binprm *bprm)
>   	if (retval < 0)
>   		return retval;
>   
> -	install_exec_creds(bprm);
> -
>   	if (N_MAGIC(ex) == OMAGIC) {
>   		unsigned long text_addr, map_size;
>   
> diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
> index 8e8346a81723..ace587b66904 100644
> --- a/fs/binfmt_aout.c
> +++ b/fs/binfmt_aout.c
> @@ -162,6 +162,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
>   	set_personality(PER_LINUX);
>   #endif
>   	setup_new_exec(bprm);
> +	install_exec_creds(bprm);
>   
>   	current->mm->end_code = ex.a_text +
>   		(current->mm->start_code = N_TXTADDR(ex));
> @@ -174,7 +175,6 @@ static int load_aout_binary(struct linux_binprm * bprm)
>   	if (retval < 0)
>   		return retval;
>   
> -	install_exec_creds(bprm);
>   
>   	if (N_MAGIC(ex) == OMAGIC) {
>   		unsigned long text_addr, map_size;
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 240f66663543..6c94c6d53d97 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -353,6 +353,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>   		current->personality |= READ_IMPLIES_EXEC;
>   
>   	setup_new_exec(bprm);
> +	install_exec_creds(bprm);
>   
>   	set_binfmt(&elf_fdpic_format);
>   
> @@ -434,7 +435,6 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>   	current->mm->start_stack = current->mm->start_brk + stack_size;
>   #endif
>   
> -	install_exec_creds(bprm);
>   	if (create_elf_fdpic_tables(bprm, current->mm,
>   				    &exec_params, &interp_params) < 0)
>   		goto error;
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index 831a2b25ba79..1a1d1fcb893f 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -541,6 +541,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>   		/* OK, This is the point of no return */
>   		set_personality(PER_LINUX_32BIT);
>   		setup_new_exec(bprm);
> +		install_exec_creds(bprm);
>   	}
>   
>   	/*
> @@ -963,8 +964,6 @@ static int load_flat_binary(struct linux_binprm *bprm)
>   		}
>   	}
>   
> -	install_exec_creds(bprm);
> -
>   	set_binfmt(&flat_format);
>   
>   #ifdef CONFIG_MMU
> 
