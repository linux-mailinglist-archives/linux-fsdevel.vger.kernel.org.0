Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD8A31933E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 20:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhBKTkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 14:40:06 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:31177 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231235AbhBKTkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:40:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613072380; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=7ZShCPlqDj9fscjkgLTRVv6M92I9n+gZhGfFsm84qH4=;
 b=Sf6KUk9r13x/K/87AvTpzwVFoKZf39NIZOTjtFno3OQVnPXUGdFs8lZep3Jmbgb40V+20wEr
 glfygx4SJjvwLqVeKAilpUx/wBnmq2MMKokByuTG6z2setCcEFXFBetKP/rDOfwfjLkqKr/c
 uSxYNzphzwl+zHNknDu3ThKmI9k=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 602587dbf112b7872cc26a7b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 19:39:07
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A864EC43461; Thu, 11 Feb 2021 19:39:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 984C3C433CA;
        Thu, 11 Feb 2021 19:39:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 11 Feb 2021 11:39:05 -0800
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2] [RFC] mm: fs: Invalidate BH LRU during page migration
In-Reply-To: <20210211140950.GJ308988@casper.infradead.org>
References: <cover.1613020616.git.cgoldswo@codeaurora.org>
 <c083b0ab6e410e33ca880d639f90ef4f6f3b33ff.1613020616.git.cgoldswo@codeaurora.org>
 <20210211140950.GJ308988@casper.infradead.org>
Message-ID: <60485ac195c0b1eecac2c99d8bca7fcb@codeaurora.org>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-02-11 06:09, Matthew Wilcox wrote:
> On Wed, Feb 10, 2021 at 09:35:40PM -0800, Chris Goldsworthy wrote:
>> +/* These are used to control the BH LRU invalidation during page 
>> migration */
>> +static struct cpumask lru_needs_invalidation;
>> +static bool bh_lru_disabled = false;
> 
> As I asked before, what protects this on an SMP system?
> 

Sorry Matthew, I misconstrued your earlier question in V1, and thought 
you had been referring to compile-time protection (so as to prevent 
build breakages).  It is not protected, so I'll need to change this into 
an atomic counter that is incremented and decremented by bh_lru_enable() 
and bh_lru_disable() respectively (such that if the counter is greater 
than zero, we bail).

>> @@ -1292,7 +1296,9 @@ static inline void check_irqs_on(void)
>>  /*
>>   * Install a buffer_head into this cpu's LRU.  If not already in the 
>> LRU, it is
>>   * inserted at the front, and the buffer_head at the back if any is 
>> evicted.
>> - * Or, if already in the LRU it is moved to the front.
>> + * Or, if already in the LRU it is moved to the front. Note that if 
>> LRU is
>> + * disabled because of an ongoing page migration, we won't insert bh 
>> into the
>> + * LRU.
> 
> And also, why do we need to do this?  The page LRU has no equivalent
> mechanism to prevent new pages being added to the per-CPU LRU lists.
> If a BH has just been used, isn't that a strong hint that this page is
> a bad candidate for migration?

I had assumed that up until now, that pages in the page cache aren't an 
issue, such that they're dropped during migration as needed. Looking at 
try_to_free_buffers[1], I don't see any handling for the page cache.  I 
will need to do due diligence and follow up on this.

As for the question on necessity, if there is a case in which preventing 
buffer_heads from being added to the BH LRU ensures that the containing 
page can be migrated, then I would say that the change is justified, 
since adds another scenario in which migration is guaranteed (I will 
follow up on this as well).

Regards,

Chris.

[1] https://elixir.bootlin.com/linux/latest/source/fs/buffer.c#L3225

-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
