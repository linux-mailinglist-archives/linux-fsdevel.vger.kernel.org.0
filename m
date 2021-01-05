Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A0D2EADC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 16:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbhAEO6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 09:58:14 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:30481 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAEO6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:58:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609858676; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=fwDk5dE76SAgv9tzvvnt+zIDxcUrSDTT6CNPHI4UAzY=;
 b=Qxsbn0Jt6YsG4gNDH58M5/tJaNRs/PtubfJyJuIWycOwY2hlEa5Ieeq11a1AcSCrLD4ygoAS
 uIKHVXy1lhM21JxNnOVFgljnowu/tW6Xh/WsWgw+D2WblUGXUHJfvkQfsOHekYRrvOwIayeY
 ZHvlKT6S9Xktv5UP/S6/0Yx0ijE=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ff47e583d84969114678fd1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Jan 2021 14:57:28
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B7D03C43463; Tue,  5 Jan 2021 14:57:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 10819C433C6;
        Tue,  5 Jan 2021 14:57:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Jan 2021 06:57:26 -0800
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [PATCH] fs/buffer.c: Revoke LRU when trying to drop buffers
In-Reply-To: <20201124153912.GC4327@casper.infradead.org>
References: <cover.1606194703.git.cgoldswo@codeaurora.org>
 <1fe5d53722407a2651eeeada3a422c117041bf1d.1606194703.git.cgoldswo@codeaurora.org>
 <20201124153912.GC4327@casper.infradead.org>
Message-ID: <fe8c287dcd131a573ae4b7a46a36825e@codeaurora.org>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-11-24 07:39, Matthew Wilcox wrote:
> On Mon, Nov 23, 2020 at 10:49:38PM -0800, Chris Goldsworthy wrote:
>> +static void __evict_bh_lru(void *arg)
>> +{
>> +	struct bh_lru *b = &get_cpu_var(bh_lrus);
>> +	struct buffer_head *bh = arg;
>> +	int i;
>> +
>> +	for (i = 0; i < BH_LRU_SIZE; i++) {
>> +		if (b->bhs[i] == bh) {
>> +			brelse(b->bhs[i]);
>> +			b->bhs[i] = NULL;
>> +			goto out;
> 
> That's an odd way to spell 'break' ...
> 
>> +		}
>> +	}
>> +out:
>> +	put_cpu_var(bh_lrus);
>> +}
> 
> ...
> 
>> @@ -3245,8 +3281,15 @@ drop_buffers(struct page *page, struct 
>> buffer_head **buffers_to_free)
>> 
>>  	bh = head;
>>  	do {
>> -		if (buffer_busy(bh))
>> -			goto failed;
>> +		if (buffer_busy(bh)) {
>> +			/*
>> +			 * Check if the busy failure was due to an
>> +			 * outstanding LRU reference
>> +			 */
>> +			evict_bh_lrus(bh);
>> +			if (buffer_busy(bh))
>> +				goto failed;

Hi Matthew,

Apologies for the delayed response.

> We might be better off just calling invalidate_bh_lrus() -- we'd flush
> the entire LRU, but we'd only need to do it once, not once per buffer 
> head.

I'm concerned about emptying the cache, such that those who might 
benefit
from it would be left affected.

> We could have a more complex 'evict' that iterates each busy buffer on 
> a
> page so transforming:
> 
> for_each_buffer
> 	for_each_cpu
> 		for_each_lru_entry
> 
> to:
> 
> for_each_cpu
> 	for_each_buffer
> 		for_each_lru_entry
> 
> (and i suggest that way because it's more expensive to iterate the 
> buffers
> than it is to iterate the lru entries)

I've gone ahead and done this in a follow-up patch:

https://lore.kernel.org/lkml/cover.1609829465.git.cgoldswo@codeaurora.org/

There might be room for improvement in the data structure being used to
track the used entries - using an xarray gives the cleanest code, but
pre-allocating an array to hold up to page_size(page) / bh->b_size 
entres
might be faster, although it would be a bit uglier to do in a way that
doesn't reduce the performance of the case when evict_bh_lru() doesn't
need to be called.

Regards,

Chris.

-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
