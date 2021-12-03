Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7C84676EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 12:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380642AbhLCMDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 07:03:20 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45948 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbhLCMDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:03:19 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4D1891FD3F;
        Fri,  3 Dec 2021 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638532794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KdazV+5dpFcxcu5IXEP+kgN/NpeXmvpoVUL6S+BnkZ4=;
        b=zeFPFPekdXm0eeHHD9fukFGRrduVhvLP09oVZXTR84us+XgctbD0Cr0CA8V9TvWmb9hO5C
        jeZaKurvasjR+ZAMMAKEuSio4ikrCFqOVcy/7L/GdCC1JP/ZAkuSzCMmAHUKQTTXI3P+gq
        7lsQ0eCfBk16Cq3yVNsYLupTenWnQ54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638532794;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KdazV+5dpFcxcu5IXEP+kgN/NpeXmvpoVUL6S+BnkZ4=;
        b=97fRlWE3/DYli8de6+Duv/6JqJT8Bj06QCOf0ZrA2uZx1ntBxj+iw5JlIijTxVyZKt8tZw
        g8Y8A3+ScReqkQDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0ADDD13DF5;
        Fri,  3 Dec 2021 11:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1i6gAboGqmHoOAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 03 Dec 2021 11:59:54 +0000
Message-ID: <cca17e9f-0d4f-f23a-2bc4-b36e834f7ef8@suse.cz>
Date:   Fri, 3 Dec 2021 12:59:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working
 set
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        ValdikSS <iam@valdikss.org.ru>
Cc:     Alexey Avramov <hakavlad@inbox.lv>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        oleksandr@natalenko.name, kernel@xanmod.org, aros@gmx.com,
        hakavlad@gmail.com, Yu Zhao <yuzhao@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20211130201652.2218636d@mail.inbox.lv>
 <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
 <20211202135824.33d2421bf5116801cfa2040d@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211202135824.33d2421bf5116801cfa2040d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/2/21 22:58, Andrew Morton wrote:
> On Thu, 2 Dec 2021 21:05:01 +0300 ValdikSS <iam@valdikss.org.ru> wrote:
> 
>> This patchset is surprisingly effective and very useful for low-end PC 
>> with slow HDD, single-board ARM boards with slow storage, cheap Android 
>> smartphones with limited amount of memory. It almost completely prevents 
>> thrashing condition and aids in fast OOM killer invocation.
>> 
>> The similar file-locking patch is used in ChromeOS for nearly 10 years 
>> but not on stock Linux or Android. It would be very beneficial for 
>> lower-performance Android phones, SBCs, old PCs and other devices.
>> 
>> With this patch, combined with zram, I'm able to run the following 
>> software on an old office PC from 2007 with __only 2GB of RAM__ 
>> simultaneously:
>> 
>>   * Firefox with 37 active tabs (all data in RAM, no tab unloading)
>>   * Discord
>>   * Skype
>>   * LibreOffice with the document opened
>>   * Two PDF files (14 and 47 megabytes in size)
>> 
>> And the PC doesn't crawl like a snail, even with 2+ GB in zram!
>> Without the patch, this PC is barely usable.
>> Please watch the video:
>> https://notes.valdikss.org.ru/linux-for-old-pc-from-2007/en/
>> 
> 
> This is quite a condemnation of the current VM.  It shouldn't crawl
> like a snail.
> 
> The patch simply sets hard limits on page reclaim's malfunctioning. 
> I'd prefer that reclaim not malfunction :(

+CC Johannes

I'd also like to know where that malfunction happens in this case. The
relatively well known scenario is that memory overloaded systems thrash
instead of going OOM quickly - something PSI should be able to help with.

But in your case, if there is no OOM due to the added protections, it would
mean that the system is in fact not overloaded, just that the normal reclaim
decisions lead to reclaming something that should be left in memory, while
there is other memory that can be reclaimed without causing thrashing?
That's perhaps worse and worth investigating.

> That being said, I can see that a blunt instrument like this would be
> useful.
> 
> I don't think that the limits should be "N bytes on the current node". 
> Nodes can have different amounts of memory so I expect it should scale
> the hard limits on a per-node basis.  And of course, the various zones
> have different size as well.
> 
> We do already have a lot of sysctls for controlling these sort of
> things.  Was much work put into attempting to utilize the existing
> sysctls to overcome these issues?
> 
> 

