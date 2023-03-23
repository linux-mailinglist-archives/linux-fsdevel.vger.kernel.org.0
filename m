Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A4E6C7277
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 22:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCWVk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 17:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCWVk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:40:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1625FD6;
        Thu, 23 Mar 2023 14:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F5CF628D7;
        Thu, 23 Mar 2023 21:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D503C433EF;
        Thu, 23 Mar 2023 21:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679607654;
        bh=WsYCeM7s6lyRPKbV9vmbt4mh8ZQCMbecPZuKeMMG3HE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HoiYXx2mpjTpQMUGFzwOnnMCyhZtWaKvQ55jxMRfvvFZUtsTOaKrRm08s7KclD4Wl
         S63XG/n55U2xIwLrg+14sTUN+tHzxtWbaPsEyYi5OSiwRbqvM1gBQjLcVID9EIUz3t
         6ySf1k2jZrRYuPc0XlHiZB8d5WjDh6trrdPVnaSU=
Date:   Thu, 23 Mar 2023 14:40:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     <willy@infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: Return early in truncate_pagecache if newsize
 overflows
Message-Id: <20230323144053.68add73fe29ee56fa5c628c6@linux-foundation.org>
In-Reply-To: <20230306113317.2295343-1-mawupeng1@huawei.com>
References: <20230306113317.2295343-1-mawupeng1@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Mar 2023 19:33:17 +0800 Wupeng Ma <mawupeng1@huawei.com> wrote:

> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> Our own test reports a UBSAN in truncate_pagecache:
> 
> UBSAN: Undefined behaviour in mm/truncate.c:788:9
> signed integer overflow:
> 9223372036854775807 + 1 cannot be represented in type 'long long int'
> 
> Call Trace:
>   truncate_pagecache+0xd4/0xe0
>   truncate_setsize+0x70/0x88
>   simple_setattr+0xdc/0x100
>   notify_change+0x654/0xb00
>   do_truncate+0x108/0x1a8
>   do_sys_ftruncate+0x2ec/0x4a0
>   __arm64_sys_ftruncate+0x5c/0x80
> 
> For huge file which pass LONG_MAX to ftruncate, truncate_pagecache() will
> be called to truncate with newsize be LONG_MAX which will lead to
> overflow for holebegin:
> 
>   loff_t holebegin = round_up(newsize, PAGE_SIZE);
> 
> Since there is no meaning to truncate a file to LONG_MAX, return here
> to avoid burn a bunch of cpu cycles.
> 
> ...
>
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -730,6 +730,9 @@ void truncate_pagecache(struct inode *inode, loff_t newsize)
>  	struct address_space *mapping = inode->i_mapping;
>  	loff_t holebegin = round_up(newsize, PAGE_SIZE);
>  
> +	if (holebegin < 0)
> +		return;
> +

It's awkward to perform an operation which might experience overflow
and to then test the possibly-overflowed result!  In fact it might
still generate the UBSAN warning, depending on what the compiler
decides to do with it all.

So wouldn't it be better to check the input argument *before*
performing these operations on it?  Preferably with a code comment
which explains the reason for the check, please.


