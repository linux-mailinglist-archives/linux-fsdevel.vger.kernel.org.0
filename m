Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B19B2CA6AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 16:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391764AbgLAPIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 10:08:24 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:34079 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390103AbgLAPIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:08:24 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kk7Ff-0021Gh-6r; Tue, 01 Dec 2020 16:07:35 +0100
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kk7Fe-0015L5-My; Tue, 01 Dec 2020 16:07:34 +0100
Subject: Re: [PATCH v2 00/13] arch, mm: deprecate DISCONTIGMEM
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>
References: <20201101170454.9567-1-rppt@kernel.org>
 <43c53597-6267-bdc2-a975-0aab5daa0d37@physik.fu-berlin.de>
 <20201117062316.GB370813@kernel.org>
 <a7d01146-77f9-d363-af99-af3aee3789b4@physik.fu-berlin.de>
 <20201201102901.GF557259@kernel.org>
 <e3d5d791-8e4f-afcc-944c-24f66f329bd7@physik.fu-berlin.de>
 <20201201121033.GG557259@kernel.org>
 <49a2022c-f106-55ec-9390-41307a056517@physik.fu-berlin.de>
 <20201201135623.GA751215@kernel.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <4c752ff0-27a6-b9d7-ab81-8aac1a3b7b65@physik.fu-berlin.de>
Date:   Tue, 1 Dec 2020 16:07:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201135623.GA751215@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 160.45.32.140
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/1/20 2:56 PM, Mike Rapoport wrote:
> (added Jens)
> 
> On Tue, Dec 01, 2020 at 01:16:05PM +0100, John Paul Adrian Glaubitz wrote:
>> Hi Mike!
>>
>> On 12/1/20 1:10 PM, Mike Rapoport wrote:
>>> On Tue, Dec 01, 2020 at 12:35:09PM +0100, John Paul Adrian Glaubitz wrote:
>>>> Hi Mike!
>>>>
>>>> On 12/1/20 11:29 AM, Mike Rapoport wrote: 
>>>>> These changes are in linux-mm tree (https://www.ozlabs.org/~akpm/mmotm/
>>>>> with a mirror at https://github.com/hnaz/linux-mm)
>>>>>
>>>>> I beleive they will be coming in 5.11.
>>>>
>>>> Just pulled from that tree and gave it a try, it actually fails to build:
>>>>
>>>>   LDS     arch/ia64/kernel/vmlinux.lds
>>>>   AS      arch/ia64/kernel/entry.o
>>>> arch/ia64/kernel/entry.S: Assembler messages:
>>>> arch/ia64/kernel/entry.S:710: Error: Operand 2 of `and' should be a general register
>>>> arch/ia64/kernel/entry.S:710: Error: qualifying predicate not followed by instruction
>>>> arch/ia64/kernel/entry.S:848: Error: Operand 2 of `and' should be a general register
>>>> arch/ia64/kernel/entry.S:848: Error: qualifying predicate not followed by instruction
>>>>   GEN     usr/initramfs_data.cpio
>>>> make[1]: *** [scripts/Makefile.build:364: arch/ia64/kernel/entry.o] Error 1
>>>> make: *** [Makefile:1797: arch/ia64/kernel] Error 2
>>>> make: *** Waiting for unfinished jobs....
>>>>   CC      init/do_mounts_initrd.o
>>>>   SHIPPED usr/initramfs_inc_data
>>>>   AS      usr/initramfs_data.o
>>>
>>> Hmm, it was buidling fine with v5.10-rc2-mmotm-2020-11-07-21-40.
>>> I'll try to see what could cause this.
>>>
>>> Do you build with defconfig or do you use a custom config?
>>
>> That's with "localmodconfig", see attached configuration file.
> 
> Thanks.
> It seems that the recent addition of TIF_NOTIFY_SIGNAL to ia64 in
> linux-next caused the issue. Can you please try the below patch?
> 
> From c4d06cf1c2938e6b2302e7ed0be95c3401181ebb Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Tue, 1 Dec 2020 15:40:28 +0200
> Subject: [PATCH] ia64: fix TIF_NOTIFY_SIGNAL implementation
> 
> * Replace wrong spelling of TIF_SIGNAL_NOTIFY with the correct
>   TIF_NOTIFY_SIGNAL
> * Remove mistyped plural in test_thread_flag() call in
>   process::do_notify_resume_user()
> * Use number 5 for TIF_NOTIFY_SIGNAL as 7 is too big and assembler is not
>   happy:
> 
>   AS      arch/ia64/kernel/entry.o
> arch/ia64/kernel/entry.S: Assembler messages:
> arch/ia64/kernel/entry.S:710: Error: Operand 2 of `and' should be an 8-bit integer (-128-127)
> arch/ia64/kernel/entry.S:710: Error: qualifying predicate not followed by instruction
> 
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Fixes: bbb026da151c ("ia64: add support for TIF_NOTIFY_SIGNAL")
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> 
> The Fixes tag is based on the commit in next-20201201, I'm not 100% sure
> it is stable
> 
>  arch/ia64/include/asm/thread_info.h | 4 ++--
>  arch/ia64/kernel/process.c          | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/thread_info.h b/arch/ia64/include/asm/thread_info.h
> index 759d7d68a5f2..51d20cb37706 100644
> --- a/arch/ia64/include/asm/thread_info.h
> +++ b/arch/ia64/include/asm/thread_info.h
> @@ -103,8 +103,8 @@ struct thread_info {
>  #define TIF_SYSCALL_TRACE	2	/* syscall trace active */
>  #define TIF_SYSCALL_AUDIT	3	/* syscall auditing active */
>  #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
> +#define TIF_NOTIFY_SIGNAL	5	/* signal notification exist */
>  #define TIF_NOTIFY_RESUME	6	/* resumption notification requested */
> -#define TIF_NOTIFY_SIGNAL	7	/* signal notification exist */
>  #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
>  #define TIF_MCA_INIT		18	/* this task is processing MCA or INIT */
>  #define TIF_DB_DISABLED		19	/* debug trap disabled for fsyscall */
> @@ -116,7 +116,7 @@ struct thread_info {
>  #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
>  #define _TIF_SYSCALL_TRACEAUDIT	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP)
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
> -#define _TIF_SIGNAL_NOTIFY	(1 << TIF_SIGNAL_NOTIFY)
> +#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>  #define _TIF_MCA_INIT		(1 << TIF_MCA_INIT)
> diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
> index 468525fc64e0..ee394abcc03e 100644
> --- a/arch/ia64/kernel/process.c
> +++ b/arch/ia64/kernel/process.c
> @@ -172,7 +172,7 @@ do_notify_resume_user(sigset_t *unused, struct sigscratch *scr, long in_syscall)
>  
>  	/* deal with pending signal delivery */
>  	if (test_thread_flag(TIF_SIGPENDING) ||
> -	    test_thread_flags(TIF_NOTIFY_SIGNAL)) {
> +	    test_thread_flag(TIF_NOTIFY_SIGNAL)) {
>  		local_irq_enable();	/* force interrupt enable */
>  		ia64_do_signal(scr, in_syscall);
>  	}
> 

This fixes the issue for me.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

