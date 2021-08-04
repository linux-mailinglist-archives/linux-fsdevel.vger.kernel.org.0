Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1D73E087B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 21:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbhHDTHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 15:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbhHDTHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:07:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EFAC0613D5;
        Wed,  4 Aug 2021 12:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=DhwLtsNskNFFTWvabwpi9A2MO0bfG7bv9FAj/gK66CI=; b=k7LQJkIyN1PHacBvHfvyVjjYe0
        KnucxBVgwnNfc+ceQCrLVF/i97zN4mrfPsrSQRhLGNpZl0UcsL6fozcvNzT90C42IrZPVRo1yYMcv
        4TRG8d7NbLVd6J98XOVIOCRu7fw73geUIN4j9+MGIXorUaH0Fn0XgYmgFCEYklbIp0mT8P1r8YiWM
        Zt5SP0MBno+dmPs50yr3z8v3F/PyRyQnMBng35YnU4yBEswdAUWy76GcMKihBI2DSa6EUKVVO4fVV
        gACsPUT1Vh3RGPYPs61DtM5Fm+XUXScHv9Yvqm+TS6qEX9Nz86FwqGqoFRUDXbamhbGl/VfiG7Spw
        9uisiOjQ==;
Received: from [2601:1c0:6280:3f0:e65e:37ff:febd:ee53]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBMEJ-005oBL-M4; Wed, 04 Aug 2021 19:07:04 +0000
Subject: Re: [PATCH v1] fs/epoll: use a per-cpu counter for user's watches
 count
To:     Guenter Roeck <linux@roeck-us.net>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anton Blanchard <anton@ozlabs.org>
References: <20210802032013.2751916-1-npiggin@gmail.com>
 <20210804152222.GA3717568@roeck-us.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f641fd9b-56c7-ddef-45d8-36ba340b9ab9@infradead.org>
Date:   Wed, 4 Aug 2021 12:06:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804152222.GA3717568@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/4/21 8:22 AM, Guenter Roeck wrote:
> On Mon, Aug 02, 2021 at 01:20:13PM +1000, Nicholas Piggin wrote:
>> This counter tracks the number of watches a user has, to compare against
>> the 'max_user_watches' limit. This causes a scalability bottleneck on
>> SPECjbb2015 on large systems as there is only one user. Changing to a
>> per-cpu counter increases throughput of the benchmark by about 30% on a
>> 16-socket, > 1000 thread system.
>>
>> Reported-by: Anton Blanchard <anton@ozlabs.org>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> With all tinyconfig builds (and all other builds with CONFIG_EPOLL=n),
> this patch results in:
> 
> kernel/user.c: In function 'free_user':
> kernel/user.c:141:35: error: 'struct user_struct' has no member named 'epoll_watches'
>    141 |         percpu_counter_destroy(&up->epoll_watches);
>        |                                   ^~
> kernel/user.c: In function 'alloc_uid':
> kernel/user.c:189:45: error: 'struct user_struct' has no member named 'epoll_watches'
>    189 |                 if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
>        |                                             ^~
> kernel/user.c:203:52: error: 'struct user_struct' has no member named 'epoll_watches'
>    203 |                         percpu_counter_destroy(&new->epoll_watches);
>        |                                                    ^~
> kernel/user.c: In function 'uid_cache_init':
> kernel/user.c:225:43: error: 'struct user_struct' has no member named 'epoll_watches'
>    225 |         if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
>        |                                           ^
> 
> Guenter
> 

Hi,
Nick and I have also posted patches for this.

https://lore.kernel.org/lkml/1628051945.fens3r99ox.astroid@bobo.none/

thanks.--
~Randy

