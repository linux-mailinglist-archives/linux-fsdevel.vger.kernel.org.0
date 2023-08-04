Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAA4770BB4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 00:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjHDWEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 18:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjHDWEK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:04:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FED10D2;
        Fri,  4 Aug 2023 15:04:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B04562113;
        Fri,  4 Aug 2023 22:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23805C433C8;
        Fri,  4 Aug 2023 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691186642;
        bh=QQtuqYG6YirPTr9VJ2u4k1MKT/dkwSKduavE+BZI9ZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nf+/klpiE9Fj+mcS29Buo0CQd4zhmPcucswSJSjvzD72yCaCfNtq70VgsUH+QdglD
         XZkVS+abxJBddXtFN3yF4qE2LrHTd9/xfQsxKM3Tqau6rVG9hrxAEewvhngjKeRK/E
         lP0HrjUilCT5RenUIVGKSHD3rc5ep8NL32NSRoI2P+2xvGS8kLJP8cHe989bOfqXB9
         5pNDjGGtcYpCdxYwbXWVpZxnnjBQC8oav57byYzP7JFehRBKpUNU7h8R+0RkR8O+Q7
         x7iyNxIWKoqOCXux19A/B0IfR8uJyHWwNWTBOrJ9oPpZUD0EIqzNa+fIpF/xKlP18d
         +vZmXIL+oyNMQ==
Date:   Sat, 5 Aug 2023 00:03:59 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Dave Chinner <david@fromorbit.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH] fs/buffer.c: disable per-CPU buffer_head cache for
 isolated CPUs
Message-ID: <ZM11z1Jxqrwk47e9@lothringen>
References: <ZJtBrybavtb1x45V@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJtBrybavtb1x45V@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 05:08:15PM -0300, Marcelo Tosatti wrote:
> 
> For certain types of applications (for example PLC software or
> RAN processing), upon occurrence of an event, it is necessary to
> complete a certain task in a maximum amount of time (deadline).
> 
> One way to express this requirement is with a pair of numbers,
> deadline time and execution time, where:
> 
>         * deadline time: length of time between event and deadline.
>         * execution time: length of time it takes for processing of event
>                           to occur on a particular hardware platform
>                           (uninterrupted).
> 
> The particular values depend on use-case. For the case
> where the realtime application executes in a virtualized
> guest, an IPI which must be serviced in the host will cause
> the following sequence of events:
> 
>         1) VM-exit
>         2) execution of IPI (and function call)
>         3) VM-entry
> 
> Which causes an excess of 50us latency as observed by cyclictest
> (this violates the latency requirement of vRAN application with 1ms TTI,
> for example).
> 
> invalidate_bh_lrus calls an IPI on each CPU that has non empty
> per-CPU cache:
> 
>         on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
> 
> The performance when using the per-CPU LRU cache is as follows:
> 
>  42 ns per __find_get_block
>  68 ns per __find_get_block_slow
> 
> Given that the main use cases for latency sensitive applications
> do not involve block I/O (data necessary for program operation is 
> locked in RAM), disable per-CPU buffer_head caches for isolated CPUs.

So what happens if they ever do I/O then? Like if they need to do
some prep work before entering an isolated critical section?

Thanks.

> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index a7fc561758b1..49e9160ce100 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -49,6 +49,7 @@
>  #include <trace/events/block.h>
>  #include <linux/fscrypt.h>
>  #include <linux/fsverity.h>
> +#include <linux/sched/isolation.h>
>  
>  #include "internal.h"
>  
> @@ -1289,7 +1290,7 @@ static void bh_lru_install(struct buffer_head *bh)
>  	 * failing page migration.
>  	 * Skip putting upcoming bh into bh_lru until migration is done.
>  	 */
> -	if (lru_cache_disabled()) {
> +	if (lru_cache_disabled() || cpu_is_isolated(smp_processor_id())) {
>  		bh_lru_unlock();
>  		return;
>  	}
> @@ -1319,6 +1320,10 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
>  
>  	check_irqs_on();
>  	bh_lru_lock();
> +	if (cpu_is_isolated(smp_processor_id())) {
> +		bh_lru_unlock();
> +		return NULL;
> +	}
>  	for (i = 0; i < BH_LRU_SIZE; i++) {
>  		struct buffer_head *bh = __this_cpu_read(bh_lrus.bhs[i]);
>  
> 
