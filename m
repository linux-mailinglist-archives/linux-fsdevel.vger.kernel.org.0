Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0902DB9AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 04:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgLPDc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 22:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPDc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:32:56 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A83C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 19:32:16 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 131so15731074pfb.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 19:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=veVIVNk8PAyV7iFAehCsxwGquHtPF8HwrxYnNlbnzbE=;
        b=IjhBM44BVrVbSUPbn4roZtsCN9KLZ2gsFzzBxTZHrPDEXt+bAEZUexAopItMZzgH7k
         4RJOl38q3UQQ/RE+hHdIqdXgEGBX/EmQy6HMB7xjAsNoyVzqdG4pq+wlfHNIPWvfSnAH
         3h04j8vRniV5dQsCGgB/aiiccaDvvHiBczEeLNCv5m4wSSq6Tj3S8YvxGKfwcTIpRh77
         be5mnJvpSLpQKiD4mIAwsxJ1pB3eaJqY2eqUx8WJRsduG7VDR+rEseKWBK1QVsgfZhsg
         dvCZnQGdOD1y7Q7b24FB5YunHgmbws11y4IOZEixxlHW/peytbmcoQByWcjUSBW+1sVA
         0vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=veVIVNk8PAyV7iFAehCsxwGquHtPF8HwrxYnNlbnzbE=;
        b=PSpnuiZ1wOVuF+wcTdX0Z2AALXop3J68gZqUByd3lrnaIbz669YW9G50SlpvjLWep2
         5Q8SIrkhbFwdHgMhY7Q4Latk5jWuEXfgCmqsLtg+fnzWOv2PH4SdjCIDWHmMQ/CTKZEl
         /81TrXDsacMcvQeoylTKvaWlrMaXeRvRfodZh5dl3cG9zj5B6GxLVlEhrXF6m7CYAWOx
         3PTvHDXinb34hgXgLw6J1MYjQtRvY08FFg+R8HthnRQ5FVTL7wUASTezXPwM0K2MTdcI
         4CI6nZSAPz13Eicgke4s3mI1SCKLVFZA0v++d+DNohKAa0NZw5xhRr5HjM2NiJ7LHxL5
         w2Yw==
X-Gm-Message-State: AOAM530ulsrHYKt2jwuEfRybBFQDbveoiO17s9wFjMpKWrzJdeBtFOSH
        a0fTIiwGu+6jvny7TJR431vOnt9iw5dyIA==
X-Google-Smtp-Source: ABdhPJy7qQ5Y0Te64D7iValNux9aU0UPsCb74DNWrM5bD1QoIc7dUAI3R1Mv89VzCbQxpEQ0Vp8JOw==
X-Received: by 2002:a63:1a02:: with SMTP id a2mr30983184pga.359.1608089536315;
        Tue, 15 Dec 2020 19:32:16 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id n28sm463895pfq.61.2020.12.15.19.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 19:32:15 -0800 (PST)
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-3-axboe@kernel.dk>
 <20201216024315.GJ3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d20ac786-9bdc-524b-41c1-e14d9d2cd42d@kernel.dk>
Date:   Tue, 15 Dec 2020 20:32:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201216024315.GJ3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/20 7:43 PM, Al Viro wrote:
> On Mon, Dec 14, 2020 at 12:13:22PM -0700, Jens Axboe wrote:
>> @@ -3140,6 +3149,12 @@ static const char *open_last_lookups(struct nameidata *nd,
>>  			return ERR_CAST(dentry);
>>  		if (likely(dentry))
>>  			goto finish_lookup;
>> +		/*
>> +		 * We can't guarantee nonblocking semantics beyond this, if
>> +		 * the fast lookup fails.
>> +		 */
>> +		if (nd->flags & LOOKUP_NONBLOCK)
>> +			return ERR_PTR(-EAGAIN);
>>  
>>  		BUG_ON(nd->flags & LOOKUP_RCU);
> 
> That can't be right - we already must have removed LOOKUP_RCU here
> (see BUG_ON() right after that point).  What is that test supposed
> to catch?
> 
> What am I missing here?

Nothing I think, doesn't look like it's needed. If we don't return
a valid dentry under LOOKUP_RCU, we will indeed have unlazied at
this point. So this hunk can go.

-- 
Jens Axboe

