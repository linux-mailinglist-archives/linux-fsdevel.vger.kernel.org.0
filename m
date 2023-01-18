Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CDE6724A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 18:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjARRRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 12:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjARRQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:16:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6324E529;
        Wed, 18 Jan 2023 09:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UiaXdyQfqOt+6WwaLnuzqkN2uc7Go0jhzWYcMdFqIEU=; b=HqOF5yLycZqDpix07Wa88U3B5z
        PV+/OuawmGvHXon+V/NTHJO4/hAbMGN4g/ngBlG1PxYXFmW3biP2WJviIM5ke7Ipp6ssbdY7YRUki
        sTvKtZLK5hHgUk9IahRiPHErAzQhRSnAErMtzdP17+tHybH3AeIdYLBo/DcnAzBSO6pkkfID7e9Ke
        Is6/xXp8olzFV5cJU7Buzu91LCDft1CQx1FD6SXygcfJqiHQj05Ovli4iFSsDM3j1eqyFix6iFNhr
        SJt3QCrObUHCcDwUwwJmBO6hLfVVE9OVRCjEk2OlSCXHBb5OANTpBps1L8ypjUEVZZzbCbDnOV7T4
        IW0JVL2Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pIC2Y-0003H1-1h;
        Wed, 18 Jan 2023 17:15:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22EE8300094;
        Wed, 18 Jan 2023 18:16:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7DC920B2B4E5; Wed, 18 Jan 2023 18:16:23 +0100 (CET)
Date:   Wed, 18 Jan 2023 18:16:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org,
        adobriyan@gmail.com, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 1/3] ptrace,syscall_user_dispatch: Implement Syscall User
 Dispatch Suspension
Message-ID: <Y8gpZ+T/re7mEDjB@hirez.programming.kicks-ass.net>
References: <20230109153348.5625-1-gregory.price@memverge.com>
 <20230109153348.5625-2-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109153348.5625-2-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 10:33:46AM -0500, Gregory Price wrote:
> @@ -36,6 +37,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
>  	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
>  	char state;
>  
> +	if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
> +			unlikely(current->ptrace & PT_SUSPEND_SYSCALL_USER_DISPATCH))
> +		return false;
> +
>  	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
>  		return false;
>  

So by making syscall_user_dispatch() return false, we'll make
syscall_trace_enter() continue to handle things, and supposedly you want
to land in ptrace_report_syscall_entry(), right?

> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 54482193e1ed..a6ad815bd4be 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -370,6 +370,11 @@ static int check_ptrace_options(unsigned long data)
>  	if (data & ~(unsigned long)PTRACE_O_MASK)
>  		return -EINVAL;
>  
> +	if (unlikely(data & PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)) {
> +		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTART))
> +			return -EINVAL;
> +	}

Should setting this then not also depend on having
SYSCALL_WORK_SYSCALL_TRACE set? Because without that, you get 'funny'
things.
