Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5385FF669
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 00:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJNWjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 18:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJNWjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:39:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342B310B3;
        Fri, 14 Oct 2022 15:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E48E461CE1;
        Fri, 14 Oct 2022 22:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA51C433C1;
        Fri, 14 Oct 2022 22:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665787178;
        bh=ScZ7ZpzpYCbhHr2dgKusZtqNyUk5mj5ETrqZNK3W/aA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKRoMTk3ERHolXcN0xKekhjMg0NBp1WEHv9rsuu/0IMCA/UCaDojvajV92EMiC0AN
         r8wYZnYHeumVpj9Pn3k6EMognTrdbWYoNWnWMvDFGFqb6V7l1HBasqdVLFO1jKMcdH
         ETaLl8dwX9r6p19hSRp5v5AY10gVky2YNb1PoOLQ/MvyhPss2AUMolEf+WnnF5UpRW
         sOaP/8kq+N5/kWnWZ6oVXBaRyzWfVJLfMKwNu3YYzKaPI6iRf/iA07mGeVt6kIKZo2
         1HD5L7SNdD8WZoR+Yfelw11OpnVI7c58aRt/dVswBYfAnGDmhaYqV1KyIfKBayR6zT
         SYdTsyQ6aS8uQ==
Date:   Fri, 14 Oct 2022 15:39:35 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tom Rix <trix@redhat.com>, Xiaoming Ni <nixiaoming@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Christoph Hellwig <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] fs/select: mark do_select noinline_for_stack
Message-ID: <Y0nlJ6whtJuZddjr@dev-arch.thelio-3990X>
References: <c8f87abd-9d66-40cf-bcea-e2b1388d3030@app.fastmail.com>
 <20221011205547.14553-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011205547.14553-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 01:55:47PM -0700, Nick Desaulniers wrote:
> Effectively a revert of
> commit ad312f95d41c ("fs/select: avoid clang stack usage warning")
> 
> Various configs can still push the stack useage of core_sys_select()
> over the CONFIG_FRAME_WARN threshold (1024B on 32b targets).
> 
>   fs/select.c:619:5: error: stack frame size of 1048 bytes in function
>   'core_sys_select' [-Werror,-Wframe-larger-than=]
> 
> core_sys_select() has a large stack allocation for `stack_fds` where it
> tries to do something equivalent to "small string optimization" to
> potentially avoid a kmalloc.
> 
> core_sys_select() calls do_select() which has another potentially large
> stack allocation, `table`. Both of these values depend on
> FRONTEND_STACK_ALLOC.
> 
> Mix those two large allocation with register spills which are
> exacerbated by various configs and compiler versions and we can just
> barely exceed the 1024B limit.
> 
> Rather than keep trying to find the right value of MAX_STACK_ALLOC or
> FRONTEND_STACK_ALLOC, mark do_select() as noinline_for_stack.
> 
> The intent of FRONTEND_STACK_ALLOC is to help potentially avoid a
> dynamic memory allocation. In that spirit, restore the previous
> threshold but separate the stack frames.
> 
> Many tests of various configs for different architectures and various
> versions of GCC were performed; do_select() was never inlined into
> core_sys_select() or compat_core_sys_select(). The kernel is built with
> the GCC specific flag `-fconserve-stack` which can limit inlining
> depending on per-target thresholds of callee stack size, which helps
> avoid the issue when using GCC. Clang is being more aggressive and not
> considering the stack size when decided whether to inline or not. We may
> consider using the clang-16+ flag `-finline-max-stacksize=` in the
> future.
> 
> Link: https://lore.kernel.org/lkml/20221006222124.aabaemy7ofop7ccz@google.com/
> Fixes: ad312f95d41c ("fs/select: avoid clang stack usage warning")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Changes v1 -> v2:
> * Drop the 32b specific guard, since I could reproduce the no-inlining
>   w/ aarch64-linux-gnu-gcc-10 ARCH=arm64 defconfig, and per Arnd.
> * Drop references to 32b in commit message.
> * Add new paragraph in commit message at the end about -fconserve-stack
>   and -finline-max-stacksize=.
> * s/malloc/kmalloc/ in commit message.
> 
>  fs/select.c          | 1 +
>  include/linux/poll.h | 4 ----
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 0ee55af1a55c..794e2a91b1fa 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -476,6 +476,7 @@ static inline void wait_key_set(poll_table *wait, unsigned long in,
>  		wait->_key |= POLLOUT_SET;
>  }
>  
> +noinline_for_stack
>  static int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
>  {
>  	ktime_t expire, *to = NULL;
> diff --git a/include/linux/poll.h b/include/linux/poll.h
> index a9e0e1c2d1f2..d1ea4f3714a8 100644
> --- a/include/linux/poll.h
> +++ b/include/linux/poll.h
> @@ -14,11 +14,7 @@
>  
>  /* ~832 bytes of stack space used max in sys_select/sys_poll before allocating
>     additional memory. */
> -#ifdef __clang__
> -#define MAX_STACK_ALLOC 768
> -#else
>  #define MAX_STACK_ALLOC 832
> -#endif
>  #define FRONTEND_STACK_ALLOC	256
>  #define SELECT_STACK_ALLOC	FRONTEND_STACK_ALLOC
>  #define POLL_STACK_ALLOC	FRONTEND_STACK_ALLOC
> -- 
> 2.38.0.rc2.412.g84df46c1b4-goog
> 
> 
