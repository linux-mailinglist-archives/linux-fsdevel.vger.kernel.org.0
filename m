Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA443591D22
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Aug 2022 01:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiHMXXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Aug 2022 19:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiHMXXa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Aug 2022 19:23:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416FF883E4;
        Sat, 13 Aug 2022 16:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCFC4B800E2;
        Sat, 13 Aug 2022 23:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C87C433D6;
        Sat, 13 Aug 2022 23:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660433006;
        bh=ysFtNkgWmL61tA/vu1l6V4vTgJfiMC+3pvDXK+Y2NCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=faAZbMVOwLQHfw3hBgJv5a3v56W681DVzOI55UQpHQq+Pac+jtYmOphgd2KVIffEQ
         G9j0bOGPW2JVcN6E0bQBkOUFnVsTsmkvPpRH/V1OPtr+0pWl+h8Hvlpb62Md6mSFHw
         1aCs8GRY+7pq7mRyznOvXgRLg67x7O1Z4B+xeLHY=
Date:   Sat, 13 Aug 2022 16:23:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     cgel.zte@gmail.com
Cc:     bsingharora@gmail.com, iamjoonsoo.kim@lge.com, mingo@redhat.com,
        bristot@redhat.com, vschneid@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>
Subject: Re: [PATCH 1/2] delayacct: support re-entrance detection of
 thrashing accounting
Message-Id: <20220813162325.57bb5d703d0063d717dc47e9@linux-foundation.org>
In-Reply-To: <20220813074108.58196-1-yang.yang29@zte.com.cn>
References: <20220813074108.58196-1-yang.yang29@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 13 Aug 2022 07:41:09 +0000 cgel.zte@gmail.com wrote:

> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Once upon a time, we only support accounting thrashing of page cache.
> Then Joonsoo introduced workingset detection for anonymous pages and
> we gained the ability to account thrashing of them[1].
> 
> For page cache thrashing accounting, there is no suitable place to do
> it in fs level likes swap_readpage(). So we have to do it in
> folio_wait_bit_common().
> 
> Then for anonymous pages thrashing accounting, we have to do it in
> both swap_readpage() and folio_wait_bit_common(). This likes PSI,
> so we should let thrashing accounting supports re-entrance detection.
> 
> This patch is to prepare complete thrashing accounting, and is based
> on patch "filemap: make the accounting of thrashing more consistent".
> 
> -static inline void delayacct_thrashing_start(void)
> +static inline void delayacct_thrashing_start(unsigned long *flags)

I don't think that `flags' is a very descriptive name.  It might be
anything.  

> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -943,6 +943,10 @@ struct task_struct {
>  #ifdef	CONFIG_CPU_SUP_INTEL
>  	unsigned			reported_split_lock:1;
>  #endif
> +#ifdef CONFIG_TASK_DELAY_ACCT
> +	/* delay due to memory thrashing */
> +	unsigned                        in_thrashing:1;
> +#endif

OK, saving space in the task_struct is good.

>  	unsigned long			atomic_flags; /* Flags requiring atomic access. */
>  
> diff --git a/kernel/delayacct.c b/kernel/delayacct.c
> index 164ed9ef77a3..a5916196022f 100644
> --- a/kernel/delayacct.c
> +++ b/kernel/delayacct.c
> @@ -214,13 +214,22 @@ void __delayacct_freepages_end(void)
>  		      &current->delays->freepages_count);
>  }
>  
> -void __delayacct_thrashing_start(void)
> +void __delayacct_thrashing_start(unsigned long *flags)
>  {
> +	*flags = current->in_thrashing;
> +	if (*flags)
> +		return;

Can't we rename `flags' to `in_thrashing' throughout?

And may as well give it type `bool'.  And convert that bool to/from the
bitfield when moving it in and out of the task_struct with

	*in_thrashing = !!current->in_thrashing;

	current->in_thrashing = (in_thrashing != 0);


