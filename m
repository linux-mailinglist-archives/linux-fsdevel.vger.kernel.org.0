Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC5F3DE648
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 07:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhHCFlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 01:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhHCFli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:41:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29A2C06175F;
        Mon,  2 Aug 2021 22:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=uwAkekVM3YUihzDR1kquqE04ZiF9bUkpWcr7bm0ku1c=; b=an7jhKrep5fjlnXrbAgvOtNqTo
        Pa+gpw2pMXTpDnI1mi1Poh3vO3mzOdDihRcH7SrRaMppCQs8ZH/ZbXob2LrWKpL3x1NGVFYsLvFc8
        WOmWfig5EdLAX0zloaTkZvDaIJhpjyCRII7VNSEWCHjUcn7wIrKS1dHNpf09SThogXYsJwpvfzjKN
        clvgA4cGLF3xdrA8rlWOjBHPopUjlBpzY3VFy71mP9vuFna+Dj8Z8cGpflgOwdw1xMa75Fn8kBnYd
        BilXhRw3bgMlQ+4Ia6TNxj2UFsPhySoUcIVCgtF015bi5ajJM/SveTU8GhMX2TYTskyoHafjqW1wY
        Etbawong==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAnB1-005Kyq-Ew; Tue, 03 Aug 2021 05:41:20 +0000
Subject: Re: mmotm 2021-08-02-18-51 uploaded (struct user_struct when
 CONFIG_EPOLL is not set)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Nicholas Piggin <npiggin@gmail.com>
References: <20210803015202.vA3c5O7uP%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ff69bf0c-39b2-1eb0-67cb-5a596c2049d8@infradead.org>
Date:   Mon, 2 Aug 2021 22:41:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803015202.vA3c5O7uP%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/2/21 6:52 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2021-08-02-18-51 has been uploaded to
> 
>     https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> https://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
> 

I am seeing build errors on i386 or x86_64 when CONFIG_EPOLL is not set:

../kernel/user.c: In function ‘free_user’:
../kernel/user.c:141:30: error: ‘struct user_struct’ has no member named 
‘epoll_watches’; did you mean ‘nr_watches’?
   percpu_counter_destroy(&up->epoll_watches);
                               ^~~~~~~~~~~~~
                               nr_watches
In file included from ../include/linux/sched/user.h:7:0,
                  from ../kernel/user.c:17:
../kernel/user.c: In function ‘alloc_uid’:
../kernel/user.c:189:33: error: ‘struct user_struct’ has no member named 
‘epoll_watches’; did you mean ‘nr_watches’?
    if (percpu_counter_init(&new->epoll_watches, 0, GFP_KERNEL)) {
                                  ^
../include/linux/percpu_counter.h:38:25: note: in definition of macro 
‘percpu_counter_init’
    __percpu_counter_init(fbc, value, gfp, &__key);  \
                          ^~~
../kernel/user.c:203:33: error: ‘struct user_struct’ has no member named 
‘epoll_watches’; did you mean ‘nr_watches’?
     percpu_counter_destroy(&new->epoll_watches);
                                  ^~~~~~~~~~~~~
                                  nr_watches
In file included from ../include/linux/sched/user.h:7:0,
                  from ../kernel/user.c:17:
../kernel/user.c: In function ‘uid_cache_init’:
../kernel/user.c:225:37: error: ‘struct user_struct’ has no member named 
‘epoll_watches’; did you mean ‘nr_watches’?
   if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
                                      ^
../include/linux/percpu_counter.h:38:25: note: in definition of macro 
‘percpu_counter_init’
    __percpu_counter_init(fbc, value, gfp, &__key);  \
                          ^~~


-- 
~Randy

