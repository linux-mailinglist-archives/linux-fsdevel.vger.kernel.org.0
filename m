Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180BA1E86A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 20:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgE2S32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 14:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2S31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 14:29:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D210CC03E969;
        Fri, 29 May 2020 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=B5WVANQZx4YCGx97jJ5OLiz8s2lEqqhT42bbB5YnkyM=; b=OktvBRzz6+OuWH5zwNRdS/Angw
        zaWqzcSHUi7LJ+pozmbCvkcKL+K6eyAYP2YkbChE4QjKJJoauaZqqKzVr23x/72OP04qi/Px9dm6s
        Ad5YUeDqgMiefrDYSr1sJIne+NX7MNVsNgW6SfFbSopUtDp8HFaGwOX0+lpmvgW8YU8X3dbGNJkYk
        EddZkfa2GsHiOna7DkMtbEyy/pmRGktK6k3Uwh6qKbIYjAqw9CE57DALW+f4SQE/3pMrZVKQR73V9
        9ReybVEUI/yS3lRLHckpUw9OaYwfPgffzUCQ179BUWISlzXaZ7fVVOIe03B4JGSebLOWAkUuIPNjU
        ZEaOh3/w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jejkq-0006aG-Fy; Fri, 29 May 2020 18:29:16 +0000
Subject: Re: [PATCH] x86/uaccess: Remove redundant likely/unlikely annotations
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org>
 <20200528172005.GP2483@worktop.programming.kicks-ass.net>
 <20200529135750.GA1580@lst.de>
 <20200529143556.GE706478@hirez.programming.kicks-ass.net>
 <20200529145325.GB706518@hirez.programming.kicks-ass.net>
 <20200529153336.GC706518@hirez.programming.kicks-ass.net>
 <20200529160514.cyaytn33thphb3tz@treble>
 <20200529161253.GD706460@hirez.programming.kicks-ass.net>
 <20200529165011.o7vvhn4wcj6zjxux@treble>
 <20200529165419.GF706460@hirez.programming.kicks-ass.net>
 <20200529172505.fdjppgquujab7ayv@treble>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <77d5741f-4b84-4cb8-1b01-3e411d3b8a70@infradead.org>
Date:   Fri, 29 May 2020 11:29:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529172505.fdjppgquujab7ayv@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/29/20 10:25 AM, Josh Poimboeuf wrote:
> On Fri, May 29, 2020 at 06:54:19PM +0200, Peter Zijlstra wrote:
>> On Fri, May 29, 2020 at 11:50:11AM -0500, Josh Poimboeuf wrote:
>>> The nested likelys seem like overkill anyway -- user_access_begin() is
>>> __always_inline and it already has unlikely(), which should be
>>> propagated.
>>>
>>> So just remove the outer likelys?
>>
>> That fixes it. Ack!
> 
> If there are no objections to the patch, I can add it to my objtool-core
> branch unless anybody else wants to take it.  It only affects
> linux-next.
> 
> ---8<---
> 
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] x86/uaccess: Remove redundant likely/unlikely annotations
> 
> Since user_access_begin() already has an unlikely() annotation for its
> access_ok() check, "if (likely(user_access_begin))" results in nested
> likely annotations.  When combined with CONFIG_TRACE_BRANCH_PROFILING,
> GCC converges the error/success paths of the nested ifs, using a
> register value to distinguish between them.
> 
> While the code is technically uaccess safe, it complicates the
> branch-profiling generated code.  It also confuses objtool, because it
> doesn't do register value tracking, resulting in the following warnings:
> 
>   arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_from_user()+0x2a4: call to memset() with UACCESS enabled
>   arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_to_user()+0x243: return with UACCESS enabled
> 
> The outer likely annotations aren't actually needed anyway, since the
> compiler propagates the error path coldness when it inlines
> user_access_begin().
> 
> Fixes: 18372ef87665 ("x86_64: csum_..._copy_..._user(): switch to unsafe_..._user()")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/x86/lib/csum-wrappers_64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
> index a12b8629206d..ee63d7576fd2 100644
> --- a/arch/x86/lib/csum-wrappers_64.c
> +++ b/arch/x86/lib/csum-wrappers_64.c
> @@ -27,7 +27,7 @@ csum_and_copy_from_user(const void __user *src, void *dst,
>  	might_sleep();
>  	*errp = 0;
>  
> -	if (!likely(user_access_begin(src, len)))
> +	if (!user_access_begin(src, len))
>  		goto out_err;
>  
>  	/*
> @@ -89,7 +89,7 @@ csum_and_copy_to_user(const void *src, void __user *dst,
>  
>  	might_sleep();
>  
> -	if (unlikely(!user_access_begin(dst, len))) {
> +	if (!user_access_begin(dst, len)) {
>  		*errp = -EFAULT;
>  		return 0;
>  	}
> 


-- 
~Randy
