Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F02F5F97B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 07:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiJJFSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 01:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJJFST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:18:19 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429404D4C4;
        Sun,  9 Oct 2022 22:18:18 -0700 (PDT)
Message-ID: <8da9812d-eb84-2a84-321e-ea2826ef8981@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665379096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPNRy9onik+CC8H+dbLBGG/JFwC/8JgqUDFh6TQvjgI=;
        b=dVajeWBCcCO1PzScOej77248yySjwbUmP9SvX6xR/puhU5jnZMHgj6LOku/wZMaMMQ98Ki
        yfo+nMCN0uF3CE04ZlxkeKXtYTYNGRGuE1oxwx74rgy0CIYe1/njfj6gTTjQAl8S86mL5O
        rJsCdqqalBAjnegbuN5Fmk7Xe1Lqvpk=
Date:   Sun, 9 Oct 2022 22:18:11 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/4] arc: Use generic dump_stack_print_cmdline()
 implementation
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, linux-s390@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>, x86@kernel.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20220808130917.30760-1-deller@gmx.de>
 <20220808130917.30760-5-deller@gmx.de>
Cc:     Alexey Brodkin <abrodkin@synopsys.com>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vineet Gupta <vineet.gupta@linux.dev>
In-Reply-To: <20220808130917.30760-5-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/22 06:09, Helge Deller wrote:
> The process program name and command line is now shown in generic code
> in dump_stack_print_info(), so drop the arc-specific implementation.
>
> Signed-off-by: Helge Deller <deller@gmx.de>

But that info printing was added back in 2018 by e36df28f532f882.
I don't think arc is using show_regs_print_info -> dump_stack_print_info 
yet.
Or is there a different code path now which calls here ?

> ---
>   arch/arc/kernel/troubleshoot.c | 24 ------------------------
>   1 file changed, 24 deletions(-)
>
> diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
> index 7654c2e42dc0..9807e590ee55 100644
> --- a/arch/arc/kernel/troubleshoot.c
> +++ b/arch/arc/kernel/troubleshoot.c
> @@ -51,29 +51,6 @@ static void print_regs_callee(struct callee_regs *regs)
>   		regs->r24, regs->r25);
>   }
>
> -static void print_task_path_n_nm(struct task_struct *tsk)
> -{
> -	char *path_nm = NULL;
> -	struct mm_struct *mm;
> -	struct file *exe_file;
> -	char buf[ARC_PATH_MAX];
> -
> -	mm = get_task_mm(tsk);
> -	if (!mm)
> -		goto done;
> -
> -	exe_file = get_mm_exe_file(mm);
> -	mmput(mm);
> -
> -	if (exe_file) {
> -		path_nm = file_path(exe_file, buf, ARC_PATH_MAX-1);
> -		fput(exe_file);
> -	}
> -
> -done:
> -	pr_info("Path: %s\n", !IS_ERR(path_nm) ? path_nm : "?");
> -}
> -
>   static void show_faulting_vma(unsigned long address)
>   {
>   	struct vm_area_struct *vma;
> @@ -176,7 +153,6 @@ void show_regs(struct pt_regs *regs)
>   	 */
>   	preempt_enable();

Maybe we remove preempt* as well now (perhaps as a follow up patch) 
since that was added by f731a8e89f8c78 "ARC: show_regs: lockdep: 
re-enable preemption" where show_regs -> print_task_path_n_nm -> mmput 
was triggering lockdep splat which is supposedly removed.

>
> -	print_task_path_n_nm(tsk);
>   	show_regs_print_info(KERN_INFO);
>
>   	show_ecr_verbose(regs);
> --
> 2.37.1
>
>
> _______________________________________________
> linux-snps-arc mailing list
> linux-snps-arc@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-snps-arc

