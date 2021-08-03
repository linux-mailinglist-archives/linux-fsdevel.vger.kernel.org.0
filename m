Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E1E3DE656
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 07:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhHCFtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 01:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhHCFtv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:49:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E005C06175F;
        Mon,  2 Aug 2021 22:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=/VI0OX6tPjo83WWVqMyso0s285F63zqU4KmdLeopRwU=; b=COGaYEF72MXSP2D0X1YkdMlcuk
        ve9jynmiZNNLkNGM+XGnPwmwomSkKQiiIHVr7Y/Hhb4IBpVsMOpyuRBP7ks8JCcNDAaKkSnSX9Uls
        Pg8Z0N0Qalz2aZrwljhk5wFYq9tzXn+CWds6bA0JkyF7c6UnSSH1xaqejehTPUEQRBKTiXqgdhnfM
        roOHaWEIfkYZeN1P32kdHdmtWbUb/uCbCTZUVsEcTGodNKkCyzMs+g3IObtS3tVyAer0d0D6cyQzY
        9KgwJYo4p8cQZlnZMAqM+BbAyow6fqrHAFwTO6eOXOidJlAxP7JK0NFs4ZRO2d0F1vnJ1DiVSdvvf
        UoGWqfoA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAnJ3-005L8h-0N; Tue, 03 Aug 2021 05:49:37 +0000
Subject: Re: mmotm 2021-08-02-18-51 uploaded (struct user_struct when
 CONFIG_EPOLL is not set)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Nicholas Piggin <npiggin@gmail.com>
References: <20210803015202.vA3c5O7uP%akpm@linux-foundation.org>
 <ff69bf0c-39b2-1eb0-67cb-5a596c2049d8@infradead.org>
Message-ID: <a1a499b0-a5f6-4c20-dbb1-d5f0a20df818@infradead.org>
Date:   Mon, 2 Aug 2021 22:49:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ff69bf0c-39b2-1eb0-67cb-5a596c2049d8@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/2/21 10:41 PM, Randy Dunlap wrote:
> On 8/2/21 6:52 PM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2021-08-02-18-51 has been uploaded to
>>
>>     https://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> https://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release 
>> (5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is 
>> duplicated in
>> https://ozlabs.org/~akpm/mmotm/series
>>
>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>> followed by the base kernel version against which this patch series is to
>> be applied.
>>
> 
> I am seeing build errors on i386 or x86_64 when CONFIG_EPOLL is not set:
> 
> ../kernel/user.c: In function ‘free_user’:
> ../kernel/user.c:141:30: error: ‘struct user_struct’ has no member named 
> ‘epoll_watches’; did you mean ‘nr_watches’?
>    percpu_counter_destroy(&up->epoll_watches);
>                                ^~~~~~~~~~~~~
>                                nr_watches
> In file included from ../include/linux/sched/user.h:7:0,
>                   from ../kernel/user.c:17:
> ../kernel/user.c: In function ‘alloc_uid’:
> ../kernel/user.c:189:33: error: ‘struct user_struct’ has no member named 
> ‘epoll_watches’; did you mean ‘nr_watches’?
>     if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
>                                   ^
> ../include/linux/percpu_counter.h:38:25: note: in definition of macro 
> ‘percpu_counter_init’
>     __percpu_counter_init(fbc, value, gfp, &__key);  \
>                           ^~~
> ../kernel/user.c:203:33: error: ‘struct user_struct’ has no member named 
> ‘epoll_watches’; did you mean ‘nr_watches’?
>      percpu_counter_destroy(&new->epoll_watches);
>                                   ^~~~~~~~~~~~~
>                                   nr_watches
> In file included from ../include/linux/sched/user.h:7:0,
>                   from ../kernel/user.c:17:
> ../kernel/user.c: In function ‘uid_cache_init’:
> ../kernel/user.c:225:37: error: ‘struct user_struct’ has no member named 
> ‘epoll_watches’; did you mean ‘nr_watches’?
>    if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
>                                       ^
> ../include/linux/percpu_counter.h:38:25: note: in definition of macro 
> ‘percpu_counter_init’
>     __percpu_counter_init(fbc, value, gfp, &__key);  \
>                           ^~~
> 
> 

Also do this change in kernel/user.c please:

         if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
-               panic("percpu cpunter alloc failed");
+               panic("percpu counter alloc failed");


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
https://people.kernel.org/tglx/notes-about-netiquette
