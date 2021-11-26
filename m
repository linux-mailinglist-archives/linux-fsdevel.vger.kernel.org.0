Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504C045EA3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 10:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376257AbhKZJZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 04:25:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56344 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbhKZJXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:23:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C65E72191E;
        Fri, 26 Nov 2021 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637918408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5k5vK/+q1leHRnJPrDKCH9MzNU/pVi4fFNrdxV9OtJE=;
        b=E1+Ar2/rg1DO/JJirjFLfkspiVPBYIUap6wd9hewzcwfL/mUoXVt/h3nMSeYlqAlLKRim6
        xrBdpwgQ5InRb1zkXc6tRTfr8w0qXmd/yDAIjUOGKnQ9t5uF9gquSDdyShtlOYSf+CzgUw
        RU3qCkbAuTDkCz4XNwhSkiiusrpvQic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637918408;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5k5vK/+q1leHRnJPrDKCH9MzNU/pVi4fFNrdxV9OtJE=;
        b=pTwZ5pjj5jOIihAZspAnH0nFC12gFdg80V50sli/gaOCs0cA1VKCnbRy/mWeJaI217UppS
        yBl0+iIXID5lr/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98EAC13BAE;
        Fri, 26 Nov 2021 09:20:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ocetJMimoGEQPAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 26 Nov 2021 09:20:08 +0000
Message-ID: <bc4422ea-89fe-1263-7007-7d6a088f9bfc@suse.cz>
Date:   Fri, 26 Nov 2021 10:20:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 0/4] extend vmalloc support for constrained allocations
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Neil Brown <neilb@suse.de>, Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211124225526.GM418105@dread.disaster.area>
 <YZ9QNeHYt99mdfbZ@dhcp22.suse.cz> <YZ9XtLY4AEjVuiEI@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YZ9XtLY4AEjVuiEI@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/25/21 10:30, Michal Hocko wrote:
> [Cc Sebastian and Vlastimil]
> 
> On Thu 25-11-21 09:58:31, Michal Hocko wrote:
>> On Thu 25-11-21 09:55:26, Dave Chinner wrote:
>> [...]
>> > Correct __GFP_NOLOCKDEP support is also needed. See:
>> > 
>> > https://lore.kernel.org/linux-mm/20211119225435.GZ449541@dread.disaster.area/
>> 
>> I will have a closer look. This will require changes on both vmalloc and
>> sl?b sides.
> 
> This should hopefully make the trick
> --- 
> From 0082d29c771d831e5d1b9bb4c0a61d39bac017f0 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Thu, 25 Nov 2021 10:20:16 +0100
> Subject: [PATCH] mm: make slab and vmalloc allocators __GFP_NOLOCKDEP aware
> 
> sl?b and vmalloc allocators reduce the given gfp mask for their internal
> needs. For that they use GFP_RECLAIM_MASK to preserve the reclaim
> behavior and constrains.
> 
> __GFP_NOLOCKDEP is not a part of that mask because it doesn't really
> control the reclaim behavior strictly speaking. On the other hand
> it tells the underlying page allocator to disable reclaim recursion
> detection so arguably it should be part of the mask.
> 
> Having __GFP_NOLOCKDEP in the mask will not alter the behavior in any
> form so this change is safe pretty much by definition. It also adds
> a support for this flag to SL?B and vmalloc allocators which will in
> turn allow its use to kvmalloc as well. A lack of the support has been
> noticed recently in http://lkml.kernel.org/r/20211119225435.GZ449541@dread.disaster.area
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 3b79a5c9427a..2ceea20b5b2a 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -21,7 +21,7 @@
>  #define GFP_RECLAIM_MASK (__GFP_RECLAIM|__GFP_HIGH|__GFP_IO|__GFP_FS|\
>  			__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NOFAIL|\
>  			__GFP_NORETRY|__GFP_MEMALLOC|__GFP_NOMEMALLOC|\
> -			__GFP_ATOMIC)
> +			__GFP_ATOMIC|__GFP_NOLOCKDEP)
>  
>  /* The GFP flags allowed during early boot */
>  #define GFP_BOOT_MASK (__GFP_BITS_MASK & ~(__GFP_RECLAIM|__GFP_IO|__GFP_FS))
> 

